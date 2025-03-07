Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A62FC282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 13:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC8AB8141D;
	Fri,  7 Mar 2025 14:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="idSRvs22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCBE810F5; Fri,  7 Mar 2025 11:35:12 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6CA380F4C
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 11:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2400d1c01so264275866b.1
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 02:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741343709; x=1741948509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mG+ZY2y7JfQgS8a+bABUyure8g3TiW7MOAT/PSu4n8o=;
 b=idSRvs22PVqGoV49oZfiY07iyNStf1/0kGZEE/cYInr8kPaco3gQxrMF/wAh9PP6Fi
 ixisfCCL2onOe+B92D2NIqtVWFi1Wwyhk3WUO46szxP0/HjjCmr1pth3ZcIWyecRxLWe
 mI720ql1eX6MEeXFOg6sHSy4Gd/0NCE+XCDqdIMl/e0AbmAKwUXRLEM+VCQKw16AAyHQ
 Aw/KJPHdyEKJ2vJP5hQecvPcUPU+QClc0aJ46U9pwmbGavqEAw+/azPdf6dP+YnGRGoq
 IkhmjGHLaxZ/pBm7ccSj7zror+qVnDxDMYsAJ2/daVWkVFnPW4XoFxkPck1/btD6qyHD
 /BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741343709; x=1741948509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mG+ZY2y7JfQgS8a+bABUyure8g3TiW7MOAT/PSu4n8o=;
 b=I6o7LIHaYrF7TSE+rLLgEdWaeHBhkggwP1PHeUMP7EG7qhdjaKRTutpmiVZO2/EF4/
 d1KVfIck/GIeVsvy+tcI2Nhu0WdQUTfpqiKhHr7BDZQFu0GC53OPbPCllzdAbeVeHFEB
 ERLNO9dcN/2L4aejYr8A4OVMVMBS7vXkNH33y2oVW2FGCOOTpaB9W+epilqAyvuxmUHt
 EB9FiPTAHTafuxFtGRkYVbyty7wM2wpnUl2WqMewaZWoph8VBnznrCd8pYeefyaJ7zjr
 MhSSs869dUL3qIg655gwc1oKKSlGQxux50V9JoBz9P2cVYAhQBoPecIOqVObHj12EsLC
 TWbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPCx1cVCe3oAWe2Z7E3oFLGEyXKvikr3Kp+sHZAaH1d3V9pJx0x2wk03QNHz+npytB1fBz4V8=@lists.denx.de
X-Gm-Message-State: AOJu0YwtniJSouGuvURMwcqtzy8KWgDBhOLkB9FJg7QG9KSX58mH8Ncf
 HnmhKc/YEWV76q/UO7lFFHU2ku6T2G3p8z0yXTTkAyRSsrrKTyb/eOZHmHCD
X-Gm-Gg: ASbGncvocS1au79LLR+9/SxiBkjAcVr9GyYOKKI8aR+SwUGC7bTW1A321C8qU/ZcYBB
 A8UgOY0o7lj1XKBmbm/Y6ItW/O1VFTOit7Gkav5ChgcC9JJE5feKOeThGikznyGXokOWh2ndvjx
 7qSgSoQMoJ1uUhT1jQvnu0p6IWEVIu/5EyTWf94qqyO/jOjsw5OEFYBOA/e458LeBkLNVh79Znc
 OiKDjszr4aRzN0H0b/7aQGxCfF2mlDTsvpeZnvTcY0gvLZtPAV7xaJomzzxhvP6NaQRvmL71+7M
 O+9s2rroWCrG92XLuoWWpOi8PInbEqyCXqJ14tZIU9dPgoEF/d9sVQRxdCG81+rX+NbimEMCq12
 ug5fqMqL5kEbvEdvI4ABfSNw=
X-Google-Smtp-Source: AGHT+IE3yWw9ILaTxHX2GQGsZC0RRxeAtHehZnKwFDe/gWQ01rx2v4BIhBJhpYt0nuRWWgrJ4WItRQ==
X-Received: by 2002:a17:907:72d1:b0:abf:4a3b:454d with SMTP id
 a640c23a62f3a-ac24e92b166mr343652166b.7.1741343709015; 
 Fri, 07 Mar 2025 02:35:09 -0800 (PST)
Received: from ernest.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23988b403sm254867166b.129.2025.03.07.02.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 02:35:08 -0800 (PST)
From: ernestvanhoecke@gmail.com
X-Google-Original-From: ernest.vanhoecke@toradex.com
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/2] toradex: apalis/colibri imx6: Select correct DTB for
 SoM v1.2+
Date: Fri,  7 Mar 2025 11:34:14 +0100
Message-ID: <20250307103454.32661-3-ernest.vanhoecke@toradex.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307103454.32661-1-ernest.vanhoecke@toradex.com>
References: <20250307103454.32661-1-ernest.vanhoecke@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Mar 2025 14:08:51 +0100
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

When "fdtfile" is not set, use the "variant" environment variable to
select the correct DTB.

Apalis/Colibri iMX6 V1.2 replaced the STMPE811 ADC/Touch controller
which is EOL with the TLA2024 ADC and AD7879 touch controller. They thus
require a different DTB, which we can easily select with the variant env
variable.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: Fixed the "From" field
v1: https://lore.kernel.org/u-boot/20250228095317.621037-3-ernest.vanhoecke@toradex.com/
---
 configs/apalis_imx6_defconfig  | 2 +-
 configs/colibri_imx6_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index a3f65c5c0269..f51386d10a88 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -31,7 +31,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run distro_bootcmd; usb start; setenv stdout serial,vidconsole; setenv stdin serial,usbkbd"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6q-apalis-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1055
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 4c6ba80789b6..9fc844b32690 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -30,7 +30,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run distro_bootcmd; usb start; setenv stdout serial,vidconsole; setenv stdin serial,usbkbd"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6dl-colibri-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6dl-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1056
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
-- 
2.43.0

