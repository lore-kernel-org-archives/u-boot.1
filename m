Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB75C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 07:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 396B2871C0;
	Tue, 13 Feb 2024 08:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="G0BKCvCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CBEA87801; Tue, 13 Feb 2024 08:33:17 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E55386DBD
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 08:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d10ad265d5so2681481fa.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 23:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707809590; x=1708414390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wr5niysp9Y8ARlPsMS8qvWMOLUThZvTaOTP5MDxEhCw=;
 b=G0BKCvCUA3R4r2dPy75QcpQlDf/mfeFdOdL2mRenxpcTVdnMb1pAJ/YhttvgaQNKkr
 pBws/VebblsZNdKKwx9yazep87oh8ICDCVlnWaHRyFiVWh6GCKWEIaShz1qabt3A5A0G
 br00o4Xr8mGqwd/gi5CA0/wQ0IH/zfJiGacFSftKOZkWtDCSFUkZoKDzNbTCMaMs0znS
 RYPa06UrmGHn69biwpEQAvhNTUMi45S01Jw8WzpdyGTYGsnwZQ3R6I383duzi3uCkh3/
 lpa2PmIkHr9wdGMX9Co9wKCmAtAis74bfpd90jx8gmu01Ewaf9efas9Kf/iGk9s5f2eg
 XfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707809590; x=1708414390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wr5niysp9Y8ARlPsMS8qvWMOLUThZvTaOTP5MDxEhCw=;
 b=X8FioxAqB5O+Rr3PnATDaDH6s3br05qgDVto9TdmnEKIdI6PeD1GQFZeetsYyKLPGQ
 R+EUF6P51ho4RUfbqIJbS52hQyuQLrJz5WOU07+j8RWCtVkyHaoxEZqVZXsKDWSie6eo
 VSeNNJGehX3fXplFB+K/Ihydev/kiSe7gTYx6Nsv4GHqmRo232JQ1NFaQg0fzcuh3DUQ
 L+yu2PiBXrY22MMErbeU7H/TL9DXV4ciir077NOUi4N68ryNS8elNrAIIKLtqDhmBidY
 It+vfpfPawqNNwCRg49WPsSVfJNOs0U8Cu+WEArM22LKZEpupGrjLVapR8pUX1Edo0Yx
 +iLg==
X-Gm-Message-State: AOJu0YxwRfjDSw5j36ffBHM22wFR9oTiOx+vfE+n5cGYTX/GxYPFPgx0
 io1u7EvXHSpUqt0uD8BzNQfUyZuduf07YpjA6A+YFiBnqFeuYgLdrRkJJaMJZD49fEV9HYhPQNX
 FHv8=
X-Google-Smtp-Source: AGHT+IFjczUi2f+xP2gi1hCCrNQrLu58bw73RsctsJvFdl5ezDcDLEhOqFBMH61uPNv8bmezvvxLLQ==
X-Received: by 2002:a2e:8017:0:b0:2d0:d300:e482 with SMTP id
 j23-20020a2e8017000000b002d0d300e482mr5934056ljg.20.1707809589697; 
 Mon, 12 Feb 2024 23:33:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVN7dSTbkfngkXNophy5GuO62lcFX7Y6Fg4FeqFKyPfWoE24lQkSobKEwYw492E+jM/7Yvmr1IrTQyIcSAF6ZGHjWuxkauZp/CvImo6NGBn8dn24BMR4X5fx2jSJbn5LJXc7x4hnYmxMRbfS2SzykcY1Wjd4Mnc3GleIr5E4gDFS9FGx/K7ywQxtBw8/KmBtADfSzdXHnGLNKIXMzBsrqGxkdN1WyCiA7gCyLJ08Pj5IdENZK+hhnTgBd0nLBgeA8i2S4g4vM4zhWGaMBb47rnOWnqhNGSG2KZH90zwuQ80/VNn9guWvO/UqLxFJgvPJ+LR9fbxWgdAj2psd6lKMqG618Yth0myaTjS
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 c23-20020a2e9d97000000b002d0f8b3e259sm380140ljj.65.2024.02.12.23.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 23:33:08 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] MAINTAINERS: add custodian tree info for AV/AVB
Date: Tue, 13 Feb 2024 08:32:56 +0100
Message-Id: <20240213073256.1124630-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Add information about a custodian tree [1] for AVB/AB, which is
maintained by Mattijs Korpershoek.

[1] https://source.denx.de/u-boot/custodians/u-boot-dfu
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46ba17647f3..32f3ee30710 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -62,6 +62,7 @@ M:	Igor Opaniuk <igor.opaniuk@gmail.com>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
 R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	boot/android_ab.c
 F:	cmd/ab_select.c
 F:	doc/android/ab.rst
@@ -72,6 +73,7 @@ ANDROID AVB
 M:	Igor Opaniuk <igor.opaniuk@gmail.com>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
 S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	cmd/avb.c
 F:	common/avb_verify.c
 F:	doc/android/avb2.rst
-- 
2.34.1

