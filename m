Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20859C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 10:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF9AC60757;
	Thu, 20 Aug 2026 10:25:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vRkxvRfohdib; Thu, 20 Aug 2026 10:25:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787221529;
	bh=dpcwzvPwZk4oskkTKuWc2D3QRQ8FAKHiIZ9NhJdkg9Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Eo8qxLrQ9qUAmIrLaw3y8OlpynjwVxVUidHHM4oeKTRKFpPvvKfvpAqNHy6CydsvW
	 M3mXTljUXGImBCiiZxw04dPWFsDiCKClsuTgutc8eC+CuXcflgTYCHZTDxJCRTHwgJ
	 MyiGeXc8ux1leg6vhPQTQSvASyNXQzCR8Frm4nFhQklrLwZ4/6hki0Oefnj66mvRlX
	 m+HkRMiGkiqaBAN+DeO22S7/TFV4/cPBIrS0M2I5sxlm+Q81tGL613HNbhLLRr7946
	 u7Pm8LRKzOCaet0UowLOng6TCmCZlG6SFFShkNSJZXMfCa8AMfRojU82hLP6zz+SB/
	 ZihTATEEvpPLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2F3B606E1;
	Thu, 20 Aug 2026 10:25:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 766A629D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67AFB80C66
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:25:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F6nGv1SUNCTW for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 10:25:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MAaeOXo+
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40B3080989
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:25:26 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso21483175e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787221525; x=1787826325;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dpcwzvPwZk4oskkTKuWc2D3QRQ8FAKHiIZ9NhJdkg9Q=;
 b=MAaeOXo+2OlXf24XClGoWMtEtKE9sp5tcwR+Tbfy/zCVQMV/BC66mESB9XaDbJsimL
 Uo8nwNhGsfiSc9mrofFb6kcxCYxG7Ju9kR2FQfiYr1CXoeNfuUgpparwdodL8NJwJySp
 wo6ldOQHUmHIut0cxJWZM/CDwxcBthSbS7Gc1uma5vhU31zIU4AuXW69oWjbsVNVjF7X
 J+qV2c2+GBckpt09ZS90E/bPXJbj6ErRfRmexu0SaTycMkC3958O94+FjhpLMhPBu0Hg
 sytfTNnG1SAugo0yFdA7yjY92w5tJPGnzBpdh0jPX/39mJI9PoN8r/BhfsGQ9/ixlAdv
 FOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787221525; x=1787826325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dpcwzvPwZk4oskkTKuWc2D3QRQ8FAKHiIZ9NhJdkg9Q=;
 b=VB4U3q1OkuMiijoF9zVr24zfnc2E8XCZnJlfmnHqv2NmhdnLtHLIh2buG78XocKZ0Y
 Z6P6M1X0ZNsEKp0tEjqAdQvB5y1eYUR2T4rvqJ15Fh9rtORWkhnEzSd5Wma0bvN6clrc
 +CTxy4KqmO+5i581/xL8BTiCcIVL64d6g1QLQJ2puZ6N2LIKyxIZ8Uz/r6+vMyX4vDw3
 DYZsFCaX6DCt3caTfbm74h2+Dhb9sjb6uT5/1cDrthGbLvicRW01xFPqBlupTRe8libr
 gH+NvrMla2S7zvsxORqMWgKOVFKBfISHRgOUdTirakhF+2RcYRwSziY+nNuObOEA184x
 B9sQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUwoBEUKR0rS7EnjkaQ70zZS+QsYkFvTkSLlHzxjsDpTIvzTSF7FYoPBsCe3t8DGCXLCe5i1s=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzJLfrteor0mkaFsaNECPdUyAaojJHeYyptZpz+AXpE/1X1nyqd
 MnFmxGfJqySgJYQpBZiB5rUgfZln1lUWFE/c8X6KYy3oipfwQ/9OyqSO
X-Gm-Gg: AR+sD10XblIeCMBDIG8JGqZd5DT2I4TnMTYrNjCphmeLXjeIKkqjf7AZ82boh1mWdK6
 bI8kLPxr9oObBETmcTFfeo8vHHz6drZ149TYgFwq1E07BUfVwu3hre8RJ+OXWVqebxBB6bsboTp
 SpNLJfBlCYTVbTr453zxqOv0iDw02K4DuUl39pk99bSfbYpCHlJxcO02I0XgCir7kNe7K5q6BL0
 uWo95J/f8LFx6/BezYsrig2haL1SIl+A/XH122Qng5i9PrIPqukQ9gj1zV43V7DIAlwG+0+rp4j
 IQ2945v57xcN2IuDgeeyWNRhXgAtIRGckZRfubIZhWzD+4XMA4UY7ffEgWl6ettD0njwkxRYuMJ
 hVZeiXLOom5fOeTcu63TJZNBM58v5PQJYZ48Qoz+1P3SlzBfhHwcCUF2w1Bu/L09mSq3DUqY2Xh
 Cx85aDrH1+4mTBo7z9a66s2WuWkuWtDTVEkvgpa8jwJP/8CfSBcKYxyPN0cmUpADOw+w==
X-Received: by 2002:a05:600c:4e94:b0:499:78b3:7b36 with SMTP id
 5b1f17b1804b1-499aa1b549cmr195271135e9.11.1787221524759; 
 Thu, 20 Aug 2026 03:25:24 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e8b700sm134803915e9.6.2026.08.20.03.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:25:23 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v3 0/2] vf610: make the USB host port usable
Date: Thu, 20 Aug 2026 12:25:21 +0200
Message-ID: <20260820102523.1076815-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

A device plugged into the host port of a Colibri VF50 or VF61 carrier is
never found, for two reasons.

The pin that switches VBUS never becomes an output: device_probe() reads
the device tree into plat data before it applies the pinctrl state, so
the fixed regulator asks for its GPIO first and the pinctrl state of the
same device then rewrites the pad. Harmless on most SoCs, where the
direction lives in the GPIO block, but on Vybrid the output buffer
enable is a bit of that pad. Patch 1 moves the call back below the
pinctrl step, where it was until 2019. Unchanged since v1.

Patch 2 makes the driver enable the vbus-supply of its port.

v3: Marek asked what happens if the lookup fails with something like
-ENOMEM. v2 ignored every error, so a supply that is described but
cannot be brought up left the port silently unpowered. It now separates
the two cases the way stm32_dsi.c and tdo-tl070wsh30.c do: -ENOENT means
the port has no vbus-supply and -ENOSYS means the build has no
DM_REGULATOR, both of which are normal here, since of the five boards
that select ARCH_VF610 only the Colibri enables DM_REGULATOR at all.
Anything else fails the probe.

v2: dropped the CONFIG_IS_ENABLED(DM_REGULATOR) guards and the NULL
check, the regulator calls handle both themselves.

Patch 2 applies on top of

  https://lore.kernel.org/u-boot/20260820071511.1036506-1-mehmet.fide@gmail.com/

Testing. test/py on sandbox, before and after patch 1: 11 failed, 414
passed, 210 skipped, 1 xfailed, 20 errors, the same failures both times.
Built for vf610twr as well, which has no DM_REGULATOR, to cover the
stubbed path.

On a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from NAND:
"usb start" finds a USB stick, the pad of the VBUS pin reads 0x22ef
instead of 0x22ed, and Linux still boots with Ethernet, SD card and USB
working.

v1: https://lore.kernel.org/u-boot/20260819143543.427396-1-mehmet.fide@gmail.com/
v2: https://lore.kernel.org/u-boot/20260820071536.1036898-1-mehmet.fide@gmail.com/

Mehmet Fide (2):
  dm: core: read the device tree into plat data after pinctrl
  usb: ehci-vf: enable the vbus supply of the port

 drivers/core/device.c      |  8 ++++----
 drivers/usb/host/ehci-vf.c | 29 ++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.54.0

