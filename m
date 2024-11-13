Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F20AD462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB70895B4;
	Wed, 13 Nov 2024 16:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CFPLTF+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A21895B4; Wed, 13 Nov 2024 16:10:06 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6C289417
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a71938df57so2091015ab.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731510603; x=1732115403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNI8lB63U89LZH6xOeL54DM3rDn+YQ+TLcEmCUhm+Oo=;
 b=CFPLTF+7YvNxMZCSwS9J7+tVpYELWnkP48LT1jC/IC5UuZ00Uo76cdPjE/0hItw0Nq
 rlFnfN0toVqq66SwYjxiuUx8rZF3HWr2g06a1yIejuyLygWzb97z4YLeFs2+n3m2hTwR
 cqZJQgWXWpLsUuqPbQ9i36432UxDJIogL6sz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510603; x=1732115403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GNI8lB63U89LZH6xOeL54DM3rDn+YQ+TLcEmCUhm+Oo=;
 b=s4917K7c7mLpZ+oJQRAXUeVqGMsWWGd+hn7ZwkL880eJt1WiBpTKCGCwfN48Ds27CY
 WQcDSOhmqSbLHTV4K75RfthO6ggDP5CxoJ5oM3t80zYOFVl7nTt+HHVAkpDQm689NcS8
 I/wkkqI+rZNbSJ0Ngo+tEiVihOxi3gHBMSmMSTxrxQfuAf92Tlp2zbVIUd5cLPAjOSGF
 fCrzADC8qFoi/is9aSGcTh5LuaabuFwZnqmS80+xrTBDUYYx+M84ch72oDXERpVtWwLU
 6OybJ97NSYNB9yPEDaseBcseaEVQpdQ7OplTa303iihjQ5FC3nn0PDD7WNX5/6P44Kb0
 B+Lw==
X-Gm-Message-State: AOJu0YwJTbA1htH2m5wVLFVZI+Jq8dawlO0vn7qHUK/mPpvZjdpNG/1u
 0hNKTJwShlEfwyEuZJPiO8vR9iEGJka5Gn0k4JA2Ow0+sTmYh2AP79XjUDj/y7zVFEagdQrJIV0
 =
X-Google-Smtp-Source: AGHT+IEopUZU/e669oxNQBgLKJozf0Ob/2eaNP0AJqetEJdnWP0HvFPyihV0lC7vW1QE6VaDLUsWWQ==
X-Received: by 2002:a92:c242:0:b0:3a7:1aad:e34f with SMTP id
 e9e14a558f8ab-3a71aade413mr15615645ab.11.1731510602752; 
 Wed, 13 Nov 2024 07:10:02 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a719d6b62fsm2710105ab.18.2024.11.13.07.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:10:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 5/8] sunxi: Move to bootstd
Date: Wed, 13 Nov 2024 08:09:35 -0700
Message-Id: <20241113150938.1534931-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113150938.1534931-1-sjg@chromium.org>
References: <20241113150938.1534931-1-sjg@chromium.org>
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

Drop support for distroboot and move to using bootstd instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Convert the other DISTRO_DEFAULTS in the Kconfig too

 arch/arm/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7282c4123b0..b08d8d4ff27 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1155,7 +1155,7 @@ config ARCH_SUNXI
 	select BINMAN
 	select CMD_GPIO
 	select CMD_MMC if MMC
-	select CMD_USB if DISTRO_DEFAULTS && USB_HOST
+	select CMD_USB if BOOTSTD_DEFAULTS && USB_HOST
 	select CLK
 	select DM
 	select DM_GPIO
@@ -1177,9 +1177,9 @@ config ARCH_SUNXI
 	select SUNXI_GPIO
 	select SYS_NS16550
 	select SYS_THUMB_BUILD if !ARM64
-	select USB if DISTRO_DEFAULTS
-	select USB_KEYBOARD if DISTRO_DEFAULTS && USB_HOST
-	select USB_STORAGE if DISTRO_DEFAULTS && USB_HOST
+	select USB if BOOTSTD_DEFAULTS
+	select USB_KEYBOARD if BOOTSTD_DEFAULTS && USB_HOST
+	select USB_STORAGE if BOOTSTD_DEFAULTS && USB_HOST
 	select SPL_USE_TINY_PRINTF if SPL
 	select USE_PREBOOT
 	select SYS_RELOC_GD_ENV_ADDR
@@ -1187,7 +1187,7 @@ config ARCH_SUNXI
 	imply CMD_DM
 	imply CMD_GPT
 	imply CMD_UBI if MTD_RAW_NAND
-	imply DISTRO_DEFAULTS
+	imply BOOTSTD_DEFAULTS
 	imply DM_REGULATOR
 	imply DM_REGULATOR_FIXED
 	imply FAT_WRITE
-- 
2.34.1

