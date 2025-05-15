Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5372C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2FC882C57;
	Thu, 15 May 2025 16:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oV/12J10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9247782C0C; Thu, 15 May 2025 16:56:01 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3E782AFC
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso10005925e9.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747320955; x=1747925755;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9U0blKGXVXwmaC6hRcFej55AndVbW83uaN+gqIslc0=;
 b=oV/12J10qPn1rhkpW5uZF/sL3KmGKFFl/1mGAbQEXHH/T5Oy3Tnoo5uHRuFWHCWe51
 eAsCk5fA+nZgilvGSUbDhbhi2olBlmF2J529O6zi0BzMvYBfK8+B2dFdk9pNkxMSYaYY
 Hu7Tl7Y8NAhidhcONyWZzTeCzCFTxnuaDZXPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747320955; x=1747925755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9U0blKGXVXwmaC6hRcFej55AndVbW83uaN+gqIslc0=;
 b=NHbp4ODFWags8Fzvc/NiZg/Wiq2/DT+EOqEFipCW/RcPpEehpXygEyt4PlzOePwzrH
 pqYvnoXl3L5NwWI71LPRE/g/4lZBdyDT1KsJ35WCyFT8ymyftCgcTMUj41GfZQjZzo66
 byKBhkttWDZPfy6TSdBgw8aSME6BzZxPqmmll0iTJx+33wkfEGBgs9gMee36S/hegTqA
 Bx/VxkEr56K9pS6RkUrnrQ4jaY93x2T5CVSC675JG2ScPJbN4Yovk1KGevhiXnrFsiBr
 zWNu3dWHLJeL7rblfjzkklKABuarj6c9nluLOxIZuuqNHQIRdnVE76GTnZJWvvgGrc/v
 UQCQ==
X-Gm-Message-State: AOJu0YxTU+evnpVyBJA0KZ8wM7vFPJGsZBXn8MhiJal2vXj3uTC8vie5
 1d4bnDUoy+/Gwr5QOazERoNh8Rmuf/mg3ZFp57DzM8yB2mxEF4RqYZzb7kPe5aksOThH8QGcxay
 mQEc=
X-Gm-Gg: ASbGncu1g8kzFI26MvRpikeRaqCTmYRNZVYyqpFKlJKNY3uYXQfVFhXqarNqFaiL99p
 PGGJBjaeuhqTRcuVavea/igO1/f4gHDxTqIyaVx9rwHRCEmM0zGHILfi8+Bm3JpGtxiNOPIbYdf
 Mgynsr0jtjIdHCwol1UlBFh07NSsFaPi4L8haEL7Sk6vaOdGEBfi87KPv0vVdUnPKWZ/gfDGbrQ
 /drQaloQEHFCGJtGQ+T7fjvite3NlofMIEJFjUxHtkydaGWwdr03H3cPnBLNAILrUWFTnDzaGOV
 JwvY0hbGo3alYWTgLNJJfsLVZQIsVZrDl+PZVC5FRROrD1RR9q/e5iaA94Y+SD5cL1pvIkgr8Lu
 yPbntGGokWEn0IP8oJFwBF9/pQjgB4WEh4W/xTqAAosA=
X-Google-Smtp-Source: AGHT+IEPdTjxF2BMF/8prjolCHh/UFoOLCNaKeizY0xL4qnoK02dEJYOp9O/fWduXNQnlCPMjEFawQ==
X-Received: by 2002:a05:600c:c87:b0:43c:e7ae:4bc9 with SMTP id
 5b1f17b1804b1-442f96e48d6mr21895235e9.1.1747320955587; 
 Thu, 15 May 2025 07:55:55 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3369138sm77030235e9.8.2025.05.15.07.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 07:55:54 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v2 2/4] imx: spl_imx_romapi: support raw NAND sector
Date: Thu, 15 May 2025 16:55:35 +0200
Message-ID: <20250515145541.886857-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515145541.886857-1-dario.binacchi@amarulasolutions.com>
References: <20250515145541.886857-1-dario.binacchi@amarulasolutions.com>
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

Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options") breaks
the boot of the BSH SMM S2 board. As stated in the dropped comment, "Some
boards use this value even though MMC is not enabled in SPL, for example
imx8mn_bsh_smm_s2".

Support load of the U-Boot image from raw NAND sector.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/mach-imx/spl_imx_romapi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index 3982f4cca184..b7008df8e35a 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -35,12 +35,10 @@ ulong __weak spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev)
 {
 	u32 sector = 0;
 
-	/*
-	 * Some boards use this value even though MMC is not enabled in SPL, for
-	 * example imx8mn_bsh_smm_s2
-	 */
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR)
 	sector = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR;
+#elif IS_ENABLED(CONFIG_SPL_NAND_RAW_U_BOOT_USE_SECTOR)
+	sector = CONFIG_SPL_NAND_RAW_U_BOOT_SECTOR;
 #endif
 
 	return image_offset + sector * 512 - 0x8000;
-- 
2.43.0

