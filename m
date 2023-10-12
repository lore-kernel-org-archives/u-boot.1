Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DE0CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 20:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE7E86E08;
	Thu, 12 Oct 2023 22:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SosSrOv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B76786E08; Thu, 12 Oct 2023 22:52:03 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 556CC86D2E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 22:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so2494266a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697143856; x=1697748656; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qTUbnPiF/Ep1N8+qimp+9xfavR04lYwCdoD7i4NBlGY=;
 b=SosSrOv+FrgRkASrDSLWXZEV3EKle/4JQo91zQJ8+aOOYv90BsOl5+L6y5+OHh61u+
 fD8S6FRcfCT1LmHHJszoEBaIwRI3FOTZMEuJEnwOoN5kCA4vvGWmBTEjvJD48mhCp25/
 FtbUH5Pl+s494nkkYILsORTqAHX8d52SyGa6cQFyxJpqmKz3ksY7wIWgEldG2gW0u12z
 3GIW6lYhFbEAdCoejxvKkpEA/HC4C03VPPgjO4FsOJ+SJrj574/pTHc1FKYRL3wltQ87
 vtL0cSuTfvbiC8h6scn/jI+jbtGmHXod8s4qBdKHBHXFtHGasZnsbZvMhG4fpM4ZTlEO
 Co8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697143856; x=1697748656;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTUbnPiF/Ep1N8+qimp+9xfavR04lYwCdoD7i4NBlGY=;
 b=s3LLTNprghNDj7HNiqCE4RAV00zDgAjGSttsPNkKWInFfWW3p+UCSL+2qFKpT/8FDL
 alnQbg9wCSPvnEY1ekxfV99RD5W1J+qZTjHSUB3FBEK0XaS3COT+Zf6PaDURZ+nZGeMi
 RGM7i76qp2/INtyUPnkSjwJW/Zfg/QMjg+Hm48T0q+SA07Hj6kTh7cVFuLyotu6UmfBI
 lXwKKFMh0klQrSlZ13fGQVjnTKdP3ee81heALuX/yuwHUqgtlWjDlsW3cCm9rmM4r9iG
 2CqApP0/VZG0t/nA21xrWz44Mk4GECV7C2hmd3T/i/ENJiD/xQyXefJEcndN54jJa/my
 GjMA==
X-Gm-Message-State: AOJu0YyK4TZtgXv56ADiY+s7uALSdW6GtX8fq+b9S3IjzJVgGURH5mfi
 /GYaI3mgy8i7yrUqeDV8XivHrQBoWMKw8Q==
X-Google-Smtp-Source: AGHT+IGXqaAg3NQcopGUsD9a3ccFLYf+6rJKSFIj2kAC/xT79vo+lMY7Ziup/SA7GbV+MAP1QRXFkw==
X-Received: by 2002:a17:906:109e:b0:9b2:a7f2:f819 with SMTP id
 u30-20020a170906109e00b009b2a7f2f819mr21317796eju.31.1697143856351; 
 Thu, 12 Oct 2023 13:50:56 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a17090628d000b0099bd5d28dc4sm11543349ejd.195.2023.10.12.13.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 13:50:56 -0700 (PDT)
Message-ID: <2824a577-02f9-5904-d7af-cb4b23223b45@gmail.com>
Date: Thu, 12 Oct 2023 22:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 1/7] mtd: nand: raw: rockchip_nfc: add NAND_SKIP_BBTSCAN
 option
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <>
Content-Language: en-US
In-Reply-To: <>
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

