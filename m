Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C61CCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 05:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB6482E34;
	Fri, 24 Oct 2025 07:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdmsmUj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F5D8334F; Fri, 24 Oct 2025 07:40:59 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D078581E13
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 07:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so9168715e9.2
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 22:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761284457; x=1761889257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5v5/HwBBN86j6X+rmzg22pAEW7yaNFilqUu3/GpUfrI=;
 b=BdmsmUj3TBi9h7zoPxHE8DD/BF5Xusn4CsnHeE9HJ+9TR62eFkDoorltWKu6k43F2g
 oMWJFT0BKXSxOqmCD0EjNb4SQXfWdU7pG+Cb/XuLpi6JnRzt0pGgXvEvm2f5rjdXwRkz
 qBPckNhGM955s6rLHFX2OEcaZ86/WBp6BWV4Upq9yK0OlTnMbN/Jb/5270s05t9EmYYC
 girvOXtx3rWvePR8VjKby6/ubW3LzRFer+/0Hq3ajsICX6f9yBGI+nc3NRfVigICP5tq
 WM6g6Yiww6Zt9FVUT2ZWZtB7UxD5NAjnw9Sgq1u1AjkD0zxEyzurT4PBX+zfU3LpmZCi
 BdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761284457; x=1761889257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5v5/HwBBN86j6X+rmzg22pAEW7yaNFilqUu3/GpUfrI=;
 b=IJYKXKhfmm3aiYGzqViDjZm10zvOY+Qps6rI34cDRTR+SOcHx+MCc7vmhXLcHxPgxO
 MvE6d1WZP8poHBPZ7zB0t0wprqJf8b1cEp2mLGkoZnc+S+ewOethzWUJO3r7md5tz+c4
 C3mmBCNK0iwyBoQh8gmWQbXBxgrD0KXklRHFaiCogaFBdg7oCl7gtGgcLsYnDZ2gWP/S
 L2mrCaoUmmXp7Q27FnePYQA7wiDGuxW0KLLUrU/ida2DYYOIjgp/L0HIdHeEEOHvJxVz
 LobJrL6ZJ6wyyrvOA/IiQ2NmdwcG1Lw1iEsnv1NRnI8w9fbr4PhWgVsve62WG45jbZS4
 lvnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu2Mdt23DESEtv7UHm6cHQFxGNmwBKXpnQFhGCrAmzdXvqy0Uo0NU+/4BGcOvw41Nr8MuFnyg=@lists.denx.de
X-Gm-Message-State: AOJu0YxDfrw3LubhFeFXNeoAhWdL96xCoM7mX0uGwpN6InR2fxMc2BNO
 mzU8dsC4Pu0axlviEOXRxpyo+dPqzkWZ3S4VuOpUHj2me+CLSi95M5/N
X-Gm-Gg: ASbGncsgNuo6o9AwnVIU5Vo1XAU7us9Bq6k51tVUin/FpjNaGaPkEGVJ6Bdwt4wlO4Y
 P45bsWV3e2u79RtiythutFBHvGKc1NIeEwSsGCaK5WHG0FS5d68iFUXDAWXSBQp229J0Vajh2z/
 xQ38Ft759umr+YK8ynMxaLAQT1GfuBE0oJqvSX6S4a0JE0AfK/oUchgjNbdeBRd2jOex5Lj8nuY
 55uxYQVvGdyPOiWzr/jfIAJ42gejSZqvTQ/fV73W/c8rpnfYY8yA6M7JAXWXaSJxACCgp/LOyol
 TbdUTmJEY85sBHYOozzZw6tDz1Y/UF3MC2E4rtoinWF1DjxCpMLtRjML/FktP58bQSE1dIcGDXg
 IFe3d+yVI7/JET/RUGkaeKaraq5MPwipO74A6SHAK+ODwhDgJa3tqy3GFEBgYl/z0d0KCkkQTdL
 24qgS/GuwwGY9kFCfNSs4ZkfeNTNCpbzWnIamuSS1g
X-Google-Smtp-Source: AGHT+IFSEsaqlTnlgzGVt/ueuMt+cr6nZPNtzbAr0v6FYhv/KpGuR+tSYCDYV7sOmJs1b1AvYP5BPA==
X-Received: by 2002:a05:600c:a14:b0:471:15bb:ad7b with SMTP id
 5b1f17b1804b1-4711786d60fmr210992465e9.6.1761284457065; 
 Thu, 23 Oct 2025 22:40:57 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:a7ba:ce3f:562d:ebed])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342373sm155900585e9.12.2025.10.23.22.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 22:40:56 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v1] arm: imx8: select ARCH_MISC_INIT if FSL_CAAM is enabled
Date: Fri, 24 Oct 2025 07:40:32 +0200
Message-ID: <20251024054036.676912-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Commit 2a7acc865b9d ("configs: colibri-imx8x: enable RNG support for KASLR")
enables FSL_CAAM which requires initialization in arch_misc_init().
The ARCH_MISC_INIT configuration was added to the relevant defconfig.

Commit d0ed9636902b ("global: Make ARCH_MISC_INIT a selected symbol")
changed ARCH_MISC_INIT to require explicit selection by the developer.
With this change the colibri-imx8x defconfig is no longer sufficient to
enable ARCH_MISC_INIT when FSL_CAAM is selected.

Add the necessary selection to automatically enable ARCH_MISC_INIT when
FSL_CAAM is enabled on i.MX8 platforms.

Fixes: d0ed9636902b ("global: Make ARCH_MISC_INIT a selected symbol")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ef834542bd4a..1028764b742c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -898,6 +898,7 @@ config ARCH_LPC32XX
 
 config ARCH_IMX8
 	bool "NXP i.MX8 platform"
+	select ARCH_MISC_INIT if FSL_CAAM
 	select ARM64
 	select SYS_FSL_HAS_SEC
 	select SYS_FSL_SEC_COMPAT_4
-- 
2.43.0

