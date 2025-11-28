Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA28D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC3D483DDF;
	Fri, 28 Nov 2025 23:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xwBqrpeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5848983B8B; Fri, 28 Nov 2025 21:47:45 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CDBC83B85
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so19886695e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764362863; x=1764967663;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KuQiTUgIcIfw5ITo04ojlvfPm6g44aZdgCapT5gQBEY=;
 b=xwBqrpeUfdK/5OBQ9QPRjEd8PMIAHc2yBPEEQVtlzKc2qaEMyCnjz/FTo5WeDZxfvK
 6Yk8bF6gC5gHN273uB6zTjn7E8bZf0G1G6Xo+NmRPpr5jg8xAiwaTQ/9EBHTdlB5H4jG
 15crU2hqV8NJAgOGcX5XcJUC6Ze7se8r80CYScUJMDFIEfnHxA061uWbkp62Rh8VLdBq
 pHPiB43q4y1AN+dOXoYD/s827i181YMI3PAcUc9pRZUhm5X3QkwmFDX7iI67mDDCVl5a
 uOjALJMnVFOOIzE52Sk1o1ufblxo1Yzx9KmUwCadStyCTYbANclmHDCc476MeKb7Tui+
 Vb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764362863; x=1764967663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KuQiTUgIcIfw5ITo04ojlvfPm6g44aZdgCapT5gQBEY=;
 b=wgMLaKjjYrcFJdaZtdqxvldMUYvhj/3urLSzBkKXOFPwMxpQndvlUGK2CimuRp8bP1
 FpnNO6VCpwlVfmv1cVgWrT7c5j840kW7VVWKnELlDYV17B7AJ1uIzG8J1e12VuHnogNN
 dVT1yhgI1nC1pdL08Y4BPMOacxa/NJY59KpPg07CodQA/3UpeKLRgDz4bkYgtzr2lonB
 o/6Gt0Hwass16DHgol9vsn57V5JWZN/RCj64TW7pT9M2RNCeDiUiFH8vTyrM1X665wOz
 rX3ryTO/anGAcTNFkqKeGJ/WWIE5k1aPtBhFNyliiQbphOMpEwrHeHdpH1IE9IjQMSDJ
 6uag==
X-Gm-Message-State: AOJu0YyyjTKYd0CCQhljFPudO12Dgo/rPD8VYPTuOQexMqpqOhdTbB43
 Jag4u+n5VseBlUQtk3+iz+U9LF3C1N44o+NyFZOCRA5WvyRNk2MFl/DUoUD1qMxRAzQ=
X-Gm-Gg: ASbGncuEW4fvF2NoiTYknFlF/sF7hZ2jkev3qqsDg8CeZSQYJcQc7f/t2n0hE6FtWrc
 cLEwrWLlSHkEEMFCXTavOO28k7Oc8EgkLCoPNCoV2+S7Qy/QOiT7O0lynld2AkfPJLgLV+V1NG0
 xoQfeKMSQMCXGgA5jVf68RcaDpPTRsw4zS9v7kAnPoIpTF08Lx3nFwZ5BGhHNpZgkgo4gH/hGnR
 CQbqokc9IboYFG7D5JLVFW8kz5QkHz7bI0Bao7mzMM1OiUuNzbNmcFnfoon8iEdKmlxxaVqnx6I
 uGQ3kWuOF2cFaazC+AVN0BBlrGB6QYLXb3zmkTnBtdjwDs3NY230BIMu3DoYMESAcmlJSxaQzqU
 d33IaoutQI5PyFlg+PtH+NrdRCpk+NUG+S+S8e6WacMlK62ePG7xnO/lUzb3826gMRTqyWrpCis
 vQVGxh1Ak=
X-Google-Smtp-Source: AGHT+IGW8oXYke7HJG9MJObH/Q4JqrrUt/ZxLdAtGaOK9oR9Abyap6CVp9VMgZo5Tz/V2OKMvG482w==
X-Received: by 2002:a05:600c:1c0d:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-47904a6867fmr194793295e9.0.1764362862829; 
 Fri, 28 Nov 2025 12:47:42 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-479052daee3sm95621355e9.12.2025.11.28.12.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:47:42 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 21:46:37 +0100
Subject: [PATCH v2 7/7] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-evm-oftree-v2026-01-v2-7-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033; i=msp@baylibre.com;
 h=from:subject:message-id; bh=KY+FQNTMWDx6jYw6mrniov3mLgedRECAW6Fzn+bRzi0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtrricL7ozjh8Wv/vARsHzvuQ9p4+Ne1NTsqIXljUs3
 vNr/tXZHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCR51sZ/meaHvTyl2fiVT6Y
 dujrHGPtkLX7eT69mbdMquVIc1VGlAjDPzOFDG/5iR/KZwU7setkvzVa/DdvWvnEE7z/zr0Q3xy
 YwAgA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
power domain driver is requierd as well now.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index bd188c252780fb541afbbe61a243bddaab79be93..5826562988c674cc05f45e3d8ee8e131adcba069 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -3,7 +3,10 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am335x-evm"
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_AM33XX=y
 CONFIG_CLOCK_SYNTHESIZER=y
 CONFIG_AM335X_USB0=y
@@ -50,7 +53,8 @@ CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-sancloud-bbe ti/omap/am335x-sancloud-bbe-lite ti/omap/am335x-sancloud-bbe-extended-wifi ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y

-- 
2.51.0

