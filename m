Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D79E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 02:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1B680219;
	Wed, 11 Dec 2024 03:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uhySUnsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9A280207; Wed, 11 Dec 2024 03:17:09 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FAAE801FE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 03:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71e1158fe3eso438429a34.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733883424; x=1734488224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oMTPy93NewWGtFcNDmISPBf+EnXAcOkMSCODJmeMmA8=;
 b=uhySUnscNjbot8bwo5nhXmM9/V9A0ZynA7JL2itd0UEDKTZLGhXnKwFDhIz0Mkae94
 vgMJPiMWNodNFbh52WSPkQGDSGYL5JpZtuCpU72WaQMaimTylhs/eqROU7ZMw6tmiWXA
 5IGl15SMP8vNIfYjc1DWOihhk5KHpE74YkTHiqBwqffih5mhIm1DtfzgoymPxByBxeoW
 uKSfN3fuYV1OFr5u6ekWJzFGbCyGLicBa+R9LeQ8i3GelbjjavJJZVmpSAFM6JMksE2b
 pt2WfV7jH6ZjlniZW61Wg+jwy2LoeL89vpbPIk5tUtLy+i1dPGqCGertSQyU5NvPqnYz
 xmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733883424; x=1734488224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oMTPy93NewWGtFcNDmISPBf+EnXAcOkMSCODJmeMmA8=;
 b=u4Osj8pOBRReVDips7nRCC+DjdvDEph4x82cS9D/PAHF1MeqHYY7Aovd5BYghzDyVq
 D6yL0GekOFr078gzqLTqfSAVf/3knMzZJ7U3vyfm/8F/BbiHuibC63+a8N459ySlpl8j
 C2LORLVKerT8k3zQu0uvoWm0qspODeUGi/Hf1vYKUAKpmBD1Rsh9Q1MVGHvcsTHiCdD8
 DinwrAJ9Mfk92AEH+g53D6oI7MGd6ymC21k4LJJaQG0dOhsoK3HJj9ntjZ4ZviJ/IPcp
 PcZxWQTRxFH0pZInVBKGcUakt8ZNcqvQEhMfkmv8Lj4UBOtc3NVqkFds/aYWHl8wf7A7
 h7vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvb+SmzKP4zZxX6b69fexpVwMou5tQCutKfvRSd0cDAGsR6nAfWkWhrfLQkcbtuRSwHNpN178=@lists.denx.de
X-Gm-Message-State: AOJu0YxdOpTCzEiKyN6hiNCNSYuSUQnin2X/7MJ2ztJrxnlWxhbwSjfv
 97qmTra1mTZOLhUSlrUzPNihSMfd+jLNH3rFO6kgIbZdJceO5pYYoZCUM+cDTOVBAR/hmWKPpsN
 k2t8=
X-Gm-Gg: ASbGncu/TQqCBHbM2StnUX8MKhi3tq2avFVwXDNn1HltT6qk7IPp0ee6w+YhJOJNGSE
 dyTK26xCQ4mI9D1RPJ6aUmRytlIhrYnKT4dXpQunQ2G45QOl94z7/gdJHtziOGx3heq8jaYEuIn
 ePRGKXPQSmjOxVl2jyRt3fnkY3fHjvJc6ObGTdgSvlCcUQCTjfc/IpZx98Xxb4QmP5Aj3iEjRiI
 ovO7rnPFmWQ9JUmlgjQujGWf0CTs/lMaB0mBoBJG6FJy3ecJugALACVrgs=
X-Google-Smtp-Source: AGHT+IHmiheXuwOVIAEmOYTqBm/YiB3wrXzLa041FXqQ2EbNn0RrWXLoOPqRoH/9v0ve7lvIQv41mg==
X-Received: by 2002:a05:6830:2650:b0:717:f666:9559 with SMTP id
 46e09a7af769-71e197b7e1bmr652107a34.9.1733883423876; 
 Tue, 10 Dec 2024 18:17:03 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e1d74575bsm23958a34.7.2024.12.10.18.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 18:17:03 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/2] lmb: Fix reserving the same region multiple times
Date: Tue, 10 Dec 2024 20:17:00 -0600
Message-Id: <20241211021703.2333-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

This series is intended to be picked up for the v2025.01 release.

Since commit 1d9aa4a283da ("lmb: Fix the allocation of overlapping
memory areas with !LMB_NONE") the lmb_add_region_flags() returns -1 when
the caller tries to add the already existing region with !LMB_NONE
flags (it was returning 0 before that patch). That causes
boot_fdt_reserve_region() function to print erroneous error messages
when it's called consequently more than one time.

Make lmb_add_region_flags() return -EEXIST when the already added region
with !LMB_NONE flags is being added, and then check that error code in
boot_fdt_reserve_region() to avoid printing the misleading error
messages.

This series fixes all 3 found cases (discussed at [1]) for the false
positive error messages. All unit tests pass in sandbox U-Boot.

Changes in v2:
  - Split the original series by two separate series (cleanups will be
    sent out as a different one)
  - Collected all R-b and A-b tags from review
  - Patch #1: Removed the check for exactly the same region, and return
    -EEXIST in the branch handling overlapping regions instead
  - Reworded the commit messages slightly

[1] https://lists.denx.de/pipermail/u-boot/2024-December/574123.html

Sam Protsenko (2):
  lmb: Return -EEXIST in lmb_add_region_flags() if region already added
  boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()

 boot/image-fdt.c |  2 +-
 lib/lmb.c        | 26 +++++++++++++-------------
 test/lib/lmb.c   |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.39.5

