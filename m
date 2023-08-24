Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B371C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3BF86433;
	Thu, 24 Aug 2023 15:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="asfRu178";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 664B886519; Thu, 24 Aug 2023 15:28:48 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D777A86430
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52889bc61b6so8945325a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692883725; x=1693488525;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hHC6toSgG3MDkKltZ6DDJWBnY7M4gWrz4pgIcXVVVmg=;
 b=asfRu1788dL8KGmqSiPXMFHMUbdPKptsfxNrxbNkyAY2Xq2jNS2YN9E3n1GcWQAwDh
 NuJHtqWRgsIHEMWfo7TAs8yMfGs7Rgk6LE+JN9I3lLlWBikWE8GbvmIRxWoN19A/A8RW
 YmQj7gDYQ9R4iFln9BIPZNqTJl2Jg9Pu9+pMnSWTj4bEc49oIkTFpyewcpRCfSICbsrH
 4MpTaPQ7+3ebtP2G+QEjwcuJSq9ahBgEi/51wCSI8U9gurnRFKGUhl1Wvh/C9JCQG8HG
 ZDbzcZK5cwvzDBdX869XAJvYR8y2Q4FF8amd6eqVL0leA5d7SSFV0pibvJpV+zvyWqXX
 59uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692883725; x=1693488525;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hHC6toSgG3MDkKltZ6DDJWBnY7M4gWrz4pgIcXVVVmg=;
 b=Xqh4RwL4Yggm2HIZPZ29mSnw6grUEo/Fj6r4vMc82KU0kLlrNQmWU231I4QM159SHq
 /OaS+HfVevlPnAjG4ABqzG8h3NC8alhrfaMrLJy3VdCFZtPNzMhI8/jznPil83MMesEv
 eMdb8YHzayN2rCT53LrvSwB6ur1tljUMLnsGVYn9NkflJed4OfkrG8SaSg1k3zOoZCsS
 agYX9AyGEKT1UyDP1iPp1yXV75CTKc5Cimlk/dgCPBu3fARbgwI6z8TCTATQtF1PRONi
 +FsgXPeVB82Sr2k34Fjq/s6f6j2TEzB8vsIK45+U02tGu/Tdc00eDCxAAUe6R3gTbOv4
 Waug==
X-Gm-Message-State: AOJu0YxxaN89YuPaW41YhfbopgcHP4KibipNnDWUNG7oU0owpWfA2wO1
 ZwA41fqFcDgMrg2O3rc81vY=
X-Google-Smtp-Source: AGHT+IHuVTkPNL1wHNgO9kho4T6v3vkKEdRAU0KwQPwZcX2NtN3AImi0cnM2261SQ4mGSLGSCsm2qw==
X-Received: by 2002:a50:ef0d:0:b0:52a:250e:a04a with SMTP id
 m13-20020a50ef0d000000b0052a250ea04amr4869979eds.7.1692883725130; 
 Thu, 24 Aug 2023 06:28:45 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 z8-20020aa7c648000000b0052544bca116sm10437024edr.13.2023.08.24.06.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 06:28:44 -0700 (PDT)
Message-ID: <58111810-f29d-ee4b-dbc3-3b30864f2a95@gmail.com>
Date: Thu, 24 Aug 2023 15:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/3] mtd: nand: raw: rockchip_nfc: add NAND_SKIP_BBTSCAN
 option
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de
References: <cbbaecb0-19fc-018d-df63-c5f265156024@gmail.com>
Content-Language: en-US
In-Reply-To: <cbbaecb0-19fc-018d-df63-c5f265156024@gmail.com>
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
2.30.2

