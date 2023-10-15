Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98ECCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 22:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B1786B2C;
	Mon, 16 Oct 2023 00:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CWCIoii6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB4498692B; Mon, 16 Oct 2023 00:32:41 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16FA286AE9
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 00:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso5644484a12.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697409150; x=1698013950; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qTUbnPiF/Ep1N8+qimp+9xfavR04lYwCdoD7i4NBlGY=;
 b=CWCIoii6/UVvKT4xuwxRFJa1a90YKvD1x2nd1FlxijVRsVBTqpljzFhYuhEdTbib9g
 3XAGG5qx8Yt7YDGSAYP3FMDPWk6pSWcO95dE1vhKnDKXA1k1RP864/u4UGW9taDkkexZ
 nI0z9NhlXZXDBYdMDY2RMK48KlzQ2bDG7Y5WIP1Oh52n887fFb+WkLAvsP9vVDiCe+q4
 oWmSQ+/z1y3B7igCWIYeBiOWo28Fw9aFJQcUXNaYsBOMaTUciJMjVp/aefJtuiAirLfa
 h/27vAtzyDBhemeLAIkraoGGNgfzK5ifip94hHgJeP4Cq4zOA0DiXG5jqZxHHD3F54vt
 bpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697409150; x=1698013950;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTUbnPiF/Ep1N8+qimp+9xfavR04lYwCdoD7i4NBlGY=;
 b=ihtaa0ag7HnfEp7f3vuJ84h5fgzeDPJKTzoV2jsso++ztGM4D0n0LS0A9kG1uQVoCn
 DOQVXvvmCMJpuEA70H5cQPnDWzc/Cx2Y5kJaNpIyWhvWUSo3i14uQMLVmdZAzaOl4pTb
 8nLXwDYQKGiZCDz+jwICg1agLi4t7mxL+k7unm6nrHNVNid7aVbaIlV/lq0AlpAJSzyC
 MIdlnQVN5lnhvwYAyYhaPvFg4pTsHuZN2iwtfAvBtwN3IIvUhlfRauH7JOKrwgaAdS0N
 zcYlC5N4KZ3P5BeaOUhTsQCaCkIovKE5P1bbEs+VLo7rcoQ3gXrU4P/EyxxDIQrIRbJi
 PCDw==
X-Gm-Message-State: AOJu0Ywgdlg+CMXwCclYivwrqTlnCUtcAcmqkmeBxsLnlUFj2G7KcOXd
 XqVgBs6X+f39bbHKUDMCgsw=
X-Google-Smtp-Source: AGHT+IFU7gXpn3lW99WdxDvzq0Bqc1al8e2eY0hU0+HNQ5pDWhCsAN0/VKt0329R1GbpG6rfi7+BHw==
X-Received: by 2002:a17:907:7b93:b0:9be:315d:e607 with SMTP id
 ne19-20020a1709077b9300b009be315de607mr5200633ejc.28.1697409150115; 
 Sun, 15 Oct 2023 15:32:30 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 bo8-20020a170906d04800b0097404f4a124sm2819884ejb.2.2023.10.15.15.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:32:29 -0700 (PDT)
Message-ID: <540e564d-030b-fee2-b95a-fae322300b20@gmail.com>
Date: Mon, 16 Oct 2023 00:32:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 1/8] mtd: nand: raw: rockchip_nfc: add NAND_SKIP_BBTSCAN
 option
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Language: en-US
In-Reply-To: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On Rockchip SoCs the first boot stages are written on NAND
with help of manufacturer software that uses a different format
then the MTD framework. Skip the automatic BBT scan with the
NAND_SKIP_BBTSCAN option to be able to pass the driver probe
function and to let the original data unchanged.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 drivers/mtd/nand/raw/Kconfig        | 9 +++++++++
 drivers/mtd/nand/raw/rockchip_nfc.c | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index d624589a892b..72547f00fbec 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -611,6 +611,15 @@ config ROCKCHIP_NAND
 	    NFC v800: RK3308, RV1108
 	    NFC v900: PX30, RK3326

+config ROCKCHIP_NAND_SKIP_BBTSCAN
+	bool "Skip the automatic BBT scan with Rockchip NAND controllers"
+	depends on ROCKCHIP_NAND
+	default n
+	help
+	  Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN
+	  option when data content is not in MTD format or
+	  must remain unchanged.
+
 config TEGRA_NAND
 	bool "Support for NAND controller on Tegra SoCs"
 	depends on ARCH_TEGRA
diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index 6ad51df4acff..df6742c2f9bb 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -981,6 +981,9 @@ static int rk_nfc_nand_chip_init(ofnode node, struct rk_nfc *nfc, int devnum)
 	chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
 	chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER;

+	if (IS_ENABLED(CONFIG_ROCKCHIP_NAND_SKIP_BBTSCAN))
+		chip->options |= NAND_SKIP_BBTSCAN;
+
 	rk_nfc_hw_init(nfc);
 	ret = nand_scan_ident(mtd, nsels, NULL);
 	if (ret)
--
2.39.2

