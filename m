Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870CDC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08AC878A1;
	Wed, 27 Dec 2023 09:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nE7pJYBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B27F878A1; Wed, 27 Dec 2023 09:24:16 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F4D86590
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d4f5d902dso36022395e9.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665454; x=1704270254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6x98ZGZ6dU9MPXNyg1kolbeOTsyTd9qdDK6S/FoQ8bA=;
 b=nE7pJYBtC54HTKT2zceNXuqOit75aQTF88PBIFlAeGJfStYzr2gWB3KxOSwts7PjTB
 /fQk+6XUpcpueUlgV4o9rfbsTjHWwwmQBjzm2GoWmXXN1iOhWQp6knajhEEbcaZOGXFf
 jf+SFJFBRbylUsDVXhYqI39Oq00kW3JeYbrvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665454; x=1704270254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6x98ZGZ6dU9MPXNyg1kolbeOTsyTd9qdDK6S/FoQ8bA=;
 b=crVSo+4Q645Gu5xcD5+C1V5GjGnJMYWe/mF3/rNh2luyn8uAefVy6+Hfi0Uw2Jq4E3
 yWHYc/cuUrT/pMxqJTd4kceYkFvRXv57Jiy1l+WMCpPLVCchoxrlk1yKo4ylpQqOorr3
 VbdsXFaToHDioO0YH0KthevraiJxkdCrNJxaEGwuFE12RZ5/jXrewFQkYjwdY7sDQzUw
 I9X66PJLMhlef+H3cJV97pzSAy8tKKF/AJOr8PraYDWfVyz6NJ3gfKCq6hHRQikf5gAy
 3KMV79V0wxvz+eJoJ4hEfFu4bnBxRwyBupAvU0IMN6wI8NhZeTHyP/KNB+jWFqqCLW3v
 Sdww==
X-Gm-Message-State: AOJu0YwM0orLn/gn1HqGmTsEeakmJVoznNdV0VE5seTGG6DY+xyY8f7+
 uRnVld/2MLThceYjYBZaCRDChkcV+ov2BgG3eysdRKvMANc+
X-Google-Smtp-Source: AGHT+IHF2duUmkTeTZwf9oDUIveHCWB+DD+DRPxaa4AbL8CAksZHwmrCREViv1EZL2WhokVd6wR1wA==
X-Received: by 2002:a05:600c:a004:b0:40c:2992:716e with SMTP id
 jg4-20020a05600ca00400b0040c2992716emr4344151wmb.129.1703665453739; 
 Wed, 27 Dec 2023 00:24:13 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas@biessmann.org>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Minkyu Kang <mk7.kang@samsung.com>, Scott McNutt <smcnutt@psyent.com>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH 0/9] dts: Move to SoC-specific build rules
Date: Wed, 27 Dec 2023 08:23:56 +0000
Message-Id: <20231227082405.2202246-1-sjg@chromium.org>
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

U-Boot builds devicetree binaries from its source tree. As part of the
Kconfig conversion, the Makefiles were updated to align with how this
is done in Linux: a single target for each SoC is used to build all the
.dtb files for that SoC.

Since then, the Makefiles have devolved in some cases, resulting in
lots of target-specific build rules. Also Linux has moved to using
subdirectories for each vendor.

Recent work aims to allow U-Boot to directly use devicetree files from
Linux. This would be easier if the directory structure were the same.
Another recent discussion involved dropping the build rules altogether.

This series makes a start at cleaning up some of the build rules, to
reduce the amount of code and make it easier to add new boards for the
same SoC.

One issue is that the ARCH_xxx Kconfig options between U-Boot and Linux
are not always the same. Given the large number of SoCs and boards
supported by U-Boot, it would be useful to align these where possible.


Simon Glass (9):
  microblaze: dts: Use the normal build rule
  nios2: dts: Use the normal build rule
  arm: at91: dts: Start an SoC-specific build rule
  arm: at91: dts: Complete conversion of dts build rules
  arm: at91: dts: Sort at91 rules
  arm: samsung: dts: Convert to SoC-specific build rules
  arm: ti: dts: Convert OMAP to SoC-specific build rules
  arm: qualcomm: dts: Convert to SoC-specific build rules
  arm: vexpress: dts: Convert to SoC-specific build rules

 arch/arm/dts/Makefile        | 174 ++++++++++++++---------------------
 arch/microblaze/dts/Makefile |   2 +-
 arch/nios2/dts/Makefile      |   2 +-
 3 files changed, 73 insertions(+), 105 deletions(-)

-- 
2.34.1

