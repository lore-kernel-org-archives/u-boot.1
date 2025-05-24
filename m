Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C8DC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE3383082;
	Sat, 24 May 2025 16:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cvwdH1Hh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 575FF83327; Sat, 24 May 2025 16:23:06 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0919D82AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-55220699ba8so258853e87.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748096583; x=1748701383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Eps2jZcGm9ww9ooq/LV1v3+lsX6OTLAMs3+a1kW4F9c=;
 b=cvwdH1HhsaZZ9g/PkPq31nfM/TD2lfXk4NezWxuXiW5lCM6qkRMwjAY4yGB0cXMBZi
 cHRCd2KlrBlhKFIt9VxBCAsxeuEl5GVaqa/FGit0TtSxujS7zCMiYhZPkYCXFXAzs5/K
 cEqPrHpJpR5Nmd1M7zldOkT/N+0eVVy4T1UuP5HRifW8oEYuQpwVEq6Fz/CYJqbQUFEA
 a15Gzz+szjrzDgx4Lw+EypFejB406xX2YD+WMuqpOEYDqlg0zCKshsp/d8gisT+6/WYh
 x32qb590DcsgXreD21KOOWctHOb6TQPm3w4+ZAcJSM6z/UGY2dwkA0aZXmNyX9/ON7E3
 YNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096583; x=1748701383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eps2jZcGm9ww9ooq/LV1v3+lsX6OTLAMs3+a1kW4F9c=;
 b=W+nxpqSEv5KFK/+Cgb49SC8TUZY96IZz2tjrlhurTpO3230VLi1swl5MLv9AponXqa
 v5Sj7DD2pPsY+a8+KLFS9gwu56cZgmYGtRJF0DMcmcsYmuFTBuJ0E1apb82tMHSOrhcx
 22iqcrCclPvbG9GLa90UmEr+cSVeh2k1a+ejSVMU4LJd+ANZrIIzrM0mZkI6cQTjOqMf
 XNGdDvGFZ4ejTcYQEOdK6tqKqmuGEa+PreEKr7SLvFiDLcSO86GGjRqFmvMNu+l4V/Ov
 aOW/SAn/IH/0ormbgSnrfoyzo/x9v+I6gwn3nbPeEM+IVzAJWZDUG+9PQRPJLxBwrUo6
 uH0g==
X-Gm-Message-State: AOJu0YwI92m250/sKepD33BLRH5RxwWo/MpmDvIygRV16OR7EMeqPp9q
 k+NWxnPuIqrPX9Sg0oWfiPC1Tc5xca8uffe7/rpc6wFK8XaPjBBcmojNTMJTELO5t8U=
X-Gm-Gg: ASbGncsxr0MKIQ4jYDCDiyRz5x1ldIejx9d8MaPk6ADUERK7Z2NP8x6pq69Whw2Z73S
 GQCfy7/DGbAc+hH7439fiBF5CAjn5DF5FCLypBSzQTsli/mzexmqHaqiIs1UP/AQ2yMzrjkAI63
 UgqyFgKKye7tFFdobsTRTRVSrgcJ6GztyvGyjgynFToVf+KzOH0k2pHq+QCmNvjUAehQ3w4qP+R
 q/R/pvR6HrN7rAPGs9Nnu9HOkU2rKPdDAyw1hulDCZdTQOnaBysUaVpIy8Eop/zz7Qv+4c6qGAs
 JvFPoQDAeRu0LkhLBAfIm2jM6rCY6cXtPRMXrcIY7GaE1O73VGqX6PbvC+5z7Oto4awsyQ==
X-Google-Smtp-Source: AGHT+IE25jKSky7syOT1bMQSL/QfaRyH7+3qpPeZKxepA0NQu1gtJNiT6bde5piS2pUnQnVo2OiyfQ==
X-Received: by 2002:a05:6512:3d20:b0:550:e17a:9d72 with SMTP id
 2adb3069b0e04-5521c7bd930mr794833e87.42.1748096582612; 
 Sat, 24 May 2025 07:23:02 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5521bfdf9basm456896e87.245.2025.05.24.07.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:23:02 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] rockchip: rk3328: Fix Synchronous Abort on usb start
Date: Sat, 24 May 2025 17:20:27 +0300
Message-ID: <20250524142258.297397-1-alexthreed@gmail.com>
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

Remove incorrect assigned-clock-parents in rk3328-u-boot.dtsi.
This incorrect parent has become a problem since recent commit with parent
clock enablement.

Currently assigned-clock-parents is not a CLK node, but rk3328-usb2phy.
It looks like a mistake in dts made a long time ago (~8 years ago).

  => usb start
  starting USB...
  Bus usb@ff580000: "Synchronous Abort" handler, esr 0x96000210, far 0x4

Linux dts source reference:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c60c0373a5e85d8bd0bb026cd5440576249d2299

Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
---

 arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index b0e50a973a..39dcc2313b 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -150,6 +150,10 @@
 	bootph-all;
 };
 
+&u2phy {
+	/delete-property/ assigned-clock-parents;
+};
+
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
 &binman {
 	simple-bin-spi {
-- 
2.43.0

base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
branch: fix-rk3328-usb2phy-clock
