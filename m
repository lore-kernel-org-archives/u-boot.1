Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B420FE7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 07:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D6A80295;
	Fri,  3 Jan 2025 08:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gQYEZhRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB61C802EF; Fri,  3 Jan 2025 08:46:47 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B51680196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 08:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21644aca3a0so87359605ad.3
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 23:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735890403; x=1736495203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VgKLvqANLRW3vWJEv5MWplzuJfj9kqOijQvfpPxX1C8=;
 b=gQYEZhROhQ9fRzVrpMm/RmHtlNX6XHJ6PSPBi1tQ06Wk6rdn+qw0v2s4c0z5dUo1IQ
 PnSH7YefFh7zmw3MgZ66oJEKf1oHuxCRp0AXs86+KrXml6tV06LymlSRha49WaZB4ugL
 SfusrLO+8KvwLhytpTMpPPXyIU9O3m54eVG9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735890403; x=1736495203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VgKLvqANLRW3vWJEv5MWplzuJfj9kqOijQvfpPxX1C8=;
 b=roa92wQUJsROVLk+MIJmaTjl/eY1x2w/SotgHoHwIRL4tBNRFtMG8JbqvYCSSTtwX9
 GMhbmB0/Y84/ymz8oiLeiBHRYxUtVqQ80ezYaeuuDDUt7HH7buV+3CedDSocg1F6lAFC
 SE5UNKr++V39j2yEEn2qwO2jHX2tTX5ZBBX2+jLRRwhOtgltALGCTJt3xq3x+g+X4M2c
 WxMqF5a2tOghlQhYdkhoScHuwg8KxqVDLsxnpf/uOyyD8Z8kfz8H1s0mR9J6B+2K/gsj
 nFYvk1RbZHSajVg5CvoR2Sj52jbeIIpVFeMwjtGmY0s2KHj6dOm74gvuqEp0gLAWIkRx
 W+Kg==
X-Gm-Message-State: AOJu0YzJPc3Lwnh4PKBn7twR1qxrku6MnsnMSjPFogjyTThJ89J2NYyX
 hNH7U65IqMpcs6ez5XbFoV291IFLOK1m86aWp1hKW4DuML770d2rv2qqli3htzMix5QrKki19sw
 =
X-Gm-Gg: ASbGncusDxrAUzELXapp73QTv1BLmgu7yfIDPhmbrZjzrf5da6YugQgfF1+cxqXuq2v
 uKd50ozDgggaUdg1UsbxSYalHSdYNnJbmkON4XYT9OH1/HRDubL4lZAlJ6Ik/0zskk0gcm94KaM
 dPhpIUWr24kixrKX7AEjG7ymW8P6sMfjWEJRIw7Hz9JQxuYoQqa5LB2cYqEfwaZJlzikvzvRqas
 zgYMb8OTuBigWfGVfz3izBE8yYhRX1xkIfOR5tbVcVjXfmj0BsbL/Z3K0iQpVZlyhea3ktLJrdJ
 ocrOndk=
X-Google-Smtp-Source: AGHT+IE0GTHLkvBkWrGX/6B9B+xBhFyDagsKICmw7DgpVf3yKd37MX4lcRTilDFPoQ98Yfvmr+zIjA==
X-Received: by 2002:a05:6a20:7347:b0:1e3:da8c:1e07 with SMTP id
 adf61e73a8af0-1e5e0458ea2mr79622925637.7.1735890403260; 
 Thu, 02 Jan 2025 23:46:43 -0800 (PST)
Received: from chromium.org (219-89-85-241.adsl.xtra.co.nz. [219.89.85.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842e36c9e3fsm19869376a12.73.2025.01.02.23.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 23:46:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] upl: A few fixes to get EDK2 booting
Date: Fri,  3 Jan 2025 20:46:06 +1300
Message-ID: <20250103074638.2348387-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The previous UPL series almost got things working, but it turns out that
we need to build EDK2 with various options.

This series provides documentation for how to do this and adds a few
fixes and a workaround.

With these it is possible to boot EDK2 from U-Boot on qemu-x86


Simon Glass (4):
  upl: Add a work-around for Tianocore images
  upl: Correct handling of ISA serial
  x86: emulation: Enable bloblist
  upl: Update documentation

 boot/upl_write.c              |   17 +-
 configs/qemu-x86_64_defconfig |    2 +
 configs/qemu-x86_defconfig    |    2 +
 doc/usage/upl.rst             | 1316 ++++++++++++++++++++++++++++++++-
 4 files changed, 1328 insertions(+), 9 deletions(-)

-- 
2.43.0

