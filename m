Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0500C83F07
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 22:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D52458307F;
	Mon,  7 Jul 2025 00:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E50282F14; Sun,  6 Jul 2025 13:29:28 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06EF18277D
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 13:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7d41b04bf6fso238054385a.0
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 04:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751801365; x=1752406165;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/vFZcs4nbLKxyZyzoebFwTjho2YAyB/KOL41NeyYrw0=;
 b=mL0pZzK44FKBdpy1x0o6q2iFQ28NtFKqMoARTt1vtCbq4qGc2VXz2J9zgGzdpY7QnD
 Qlva4egaWXKsoQarNeHHRIvO3QsjfnUosEr4xwKHARmeZGw9CiI2SGAp8aXUNkIpiUBc
 c3clvQSbWxr8Sp4fj7xS6ztLf9nGJzpKoVoSBq82vcClM8xjM2vjoJH1T6wJ26Hl1N1O
 I5n26u+eyAmqc4g7tRyG8QM5jk7poHsKGOWgA8876+WOB0ecxcwucrgQzIljS6SIN5/A
 BIo0Q0+FKA0jlIMJyI36mpRhYDQ1DAMp3eGWGENwOPnBX9887Y2n2OMon96VcFUjIX+y
 rHQw==
X-Gm-Message-State: AOJu0YwgNk4vKtiYNPTbBEClCfwXdfQFs1QU0D6gthnV1Oy/++O6nk59
 RtEFOSun2eI5bpKk53FwCchizGbF/AG10WP3XTbZRfDmoLVVSfZNvEESypsneHrI
X-Gm-Gg: ASbGncsdk6ovJbyCvQJwJZ9lIAh2C1TB8b5FFGXVhZBAdewBLTxdihwBDDh2Ed96L3C
 XkYsPMjnYP4M0B6F1VLX/KDxEUo3Ch7OJXuFARkV8dihM3OKHLRG/GWE8SSVUxHVWtcuh734p9d
 a4ZcKO09ex2mpGYuV83fdg/PxkIX50K+hz8NbjsfLTau7UP82VwigYlqd1BpQWE/vAyJUTQpbCQ
 va6oj9wcX+B28bFkba9AYcnjmSVWkusqodJX0PDjHxzdLo/s3hJILyvKJmZL3LIhZTfr1K8RUrl
 xXLC3hgoDL990A2U9wIm7XYfq9XXpRsou8LRzNeAbZAgXJLGquFB/OxaTs9EukgfrwXF+eipjcc
 HhCHAc+c=
X-Google-Smtp-Source: AGHT+IFyKSQncbU/6JHlwD52YGVaPbGHIRFSQSRvWwsdVzJMsUx9JtJ7Ljay1uS2nQVi2gjZC5j6kg==
X-Received: by 2002:a05:620a:468c:b0:7cd:4b5b:a1fc with SMTP id
 af79cd13be357-7d5df0ccfe3mr1181659985a.7.1751801364629; 
 Sun, 06 Jul 2025 04:29:24 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4cd4049sm42455666d6.51.2025.07.06.04.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 04:29:24 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>, Chris.Brandt@renesas.com,
 marek.vasut+renesas@mailbox.org, geert+renesas@glider.be
Date: Sun, 06 Jul 2025 13:29:22 +0200
Message-Id: <175180136211.86839.18252924614607632271.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v3 6/9] spi: renesas_rpc_spi: Add RZ/A2 SPI Multi I/O support
X-Mailman-Approved-At: Mon, 07 Jul 2025 00:18:49 +0200
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

From: Magnus Damm <damm@opensource.se>

Add SPI Multi I/O Bus (also known as RPC SPI) support for RZ/A2 r7s9210.

Tested on RZ/A1H Genmai with U6 S25FL512S-16 by Spansion.
Tested on RZ/A2M RZA2MBTC with U2 MX25L51245GXDI-08G by Macronix.
In the latter case the SPI flash is also used as boot media.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since v2:
 - new patch

 drivers/spi/Kconfig           |    8 ++++----
 drivers/spi/renesas_rpc_spi.c |    3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

--- 0001/drivers/spi/Kconfig
+++ work/drivers/spi/Kconfig	2025-07-05 03:07:38.660458220 +0900
@@ -432,12 +432,12 @@ config SPI_QUP
 
 config RENESAS_RPC_SPI
 	bool "Renesas RPC SPI driver"
-	depends on RCAR_64 || RZA1
+	depends on RCAR_64 || RZA1 || RZA2
 	imply SPI_FLASH_SFDP_SUPPORT
 	help
-	  Enable the Renesas RPC SPI driver, used to access SPI NOR flash
-	  on Renesas R-Car Gen3 SoCs. This uses driver model and requires a
-	  device tree binding to operate.
+	 Enable the Renesas RPC SPI driver, used to access SPI NOR flash
+	 on Renesas R-Car Gen3 and RZ/A series of SoCs. This uses driver model
+	 and requires a device tree binding to operate.
 
 config ROCKCHIP_SFC
 	bool "Rockchip SFC Driver"
--- 0001/drivers/spi/renesas_rpc_spi.c
+++ work/drivers/spi/renesas_rpc_spi.c	2025-07-05 01:44:41.907314240 +0900
@@ -207,7 +207,7 @@ static void rpc_spi_flush_read_cache(str
 
 static u32 rpc_spi_get_strobe_delay(void)
 {
-#ifndef CONFIG_RZA1
+#if !defined(CONFIG_RZA1) && !defined(CONFIG_RZA2)
 	u32 cpu_type = renesas_get_cpu_type();
 
 	/*
@@ -464,6 +464,7 @@ static const struct dm_spi_ops rpc_spi_o
 
 static const struct udevice_id rpc_spi_ids[] = {
 	{ .compatible = "renesas,r7s72100-rpc-if" },
+	{ .compatible = "renesas,r7s9210-rpc-if" },
 	{ .compatible = "renesas,rcar-gen3-rpc-if" },
 	{ .compatible = "renesas,rcar-gen4-rpc-if" },
 	{ }
