Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381A6D711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7344892DE;
	Wed, 20 Nov 2024 16:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FK9J23bM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F47187042; Wed, 20 Nov 2024 16:36:54 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABBB0892DE
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-83a9be2c0e6so170101139f.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732117009; x=1732721809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GIb1CPIzu2m6BoWt66RCGiMZy7p8OvjLs4KfhmxLP7c=;
 b=FK9J23bM8pMftKNi4ZxP4uik4JrQkZYprmoOLBmDTDWuFArKck2Z7MSIJTxa9O3w1q
 +HvIMapAmmXtEXvSpEsZJ0FFW544wvQkLrbpBl4kEfCbR4805ihD/yitePlCHE7kUJie
 y6oHpuOi70F/m7cIcH9+coS2GS9tEPBsPpHms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117009; x=1732721809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GIb1CPIzu2m6BoWt66RCGiMZy7p8OvjLs4KfhmxLP7c=;
 b=qAQhDuFB8pd7M54BBiFTsikGCFeO48z9uhCQRpeVYY6eXC4U15WRHXmIh2zndnMW/d
 kOBiwxCwRBnbHDAXamTTNmg20FXtNaFhWflqCK1BmBXuVEPst0q0EGts8u6aek9tTvig
 h2SaqNZpEls4OJ5xVMjIV6fljAHdip2ktPqvaQ9MzFpYX73HUxGpiUlkEtDaq/Q2EWZ2
 X7EGf+Iktf1LGrubf6PzgCVtzXqnNB7a1jx3EzI4ymb8wjjW/i1EMaagXrI9wkcqVHWN
 VQNRPlAdxc8MzmnL2S8OpAfJxI2zDhOPbo1k+BDEG+WZN2pRRHVaq0zTPt33FzJLAcMT
 Fgcg==
X-Gm-Message-State: AOJu0YyDmQXyRvY3AiF4H90cZ4LGsZoeltiOfHha+PTY4qj9NVe/3VOi
 Rr8S/rZlFRVu/yXp/qJgb7uF6oTXfE6bCZvYCI2Jp5XvMjcOUaN/igEFyWn1lqLTbfNeVm//70g
 =
X-Google-Smtp-Source: AGHT+IHr4tuUlEl8qkJgaa6RK3OAbupGYR3L4LJBvD6f8P9sZKjynD6gckUdD6umFfeb3hXJsLVTwg==
X-Received: by 2002:a05:6602:483:b0:83b:56df:a173 with SMTP id
 ca18e2360f4ac-83eb5fa17a0mr361242539f.2.1732117009262; 
 Wed, 20 Nov 2024 07:36:49 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df8cccfsm288747139f.6.2024.11.20.07.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:36:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Svyatoslav <clamor95@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/3] Adjust how autoprobe is implemented
Date: Wed, 20 Nov 2024 08:36:38 -0700
Message-Id: <20241120153642.861633-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This little series makes a minor change to how autoprobe is
implemeneted, as discussed on the list:

   https://patchwork.ozlabs.org/project/uboot/patch/
      20240626235717.272219-1-marex@denx.de/


Changes in v3:
- Add a link to the previous discussion
- Add a summary of the design challenge in the DM docs
- Use a simple return in initr_dm()
- Add a comment to dm_probe_devices()
- Expand comment to dm_autoprobe()

Changes in v2:
- Add autoprobe to SPL also
- Leave the function name the same
- Fix 'Prove' typo
- Update cover letter since SPL is now covered also
- Update the documentation too, with a discussion link

Simon Glass (3):
  common: Drop check for DM in initf_dm()
  dm: core: Simplify dm_probe_devices()
  common: Move autoprobe out to board init

 common/board_f.c                    |  9 ++++++--
 common/board_r.c                    |  2 +-
 common/spl/spl.c                    |  4 ++++
 doc/develop/driver-model/design.rst | 17 ++++++++++++++
 drivers/core/root.c                 | 36 ++++++++++++++++++++---------
 include/dm/root.h                   | 15 ++++++++++++
 6 files changed, 69 insertions(+), 14 deletions(-)

-- 
2.34.1

