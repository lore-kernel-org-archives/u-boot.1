Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F41F10A1E7D
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BCBC83FC6;
	Thu, 26 Mar 2026 12:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="V19WgCNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8907583FD3; Thu, 26 Mar 2026 12:29:06 +0100 (CET)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA3E81E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-12713e56abdso312708c88.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524542; x=1775129342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtnUIfLY6ulsQCOzYGUSOoShhsY8192WWrk6X8C5vaI=;
 b=V19WgCNYLwT6fH+iK+FmM4C8awT0b98yQO2xUAPvfnGeuj4bB3ixCAihfduFA2qdFJ
 oiwGPydkjCm51+asZ0fb7smRKvJ/GQMDBQMquODPDIy7IiDnrQP8FGndcrgBVcu0fomy
 BP6dOghMs4qAuWY7/OZx5XfODR6BFw3kTR6t3QcD1zaz5jWfCzqLmGl78ogo1pX3kSEl
 BEMr449uu5oUzZu0KBci2n7TDQ3kOE+6yOriVMDb8bg0x8AwUIhSCLAGQtcr2V/nFTA2
 A78GvS/fYbzZCER93mk/DjVcAYgqP2XezE5g19DyslvycP+sFxVzMea2eE5+wBgLV50S
 BdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524542; x=1775129342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LtnUIfLY6ulsQCOzYGUSOoShhsY8192WWrk6X8C5vaI=;
 b=A99Z+nrPYlpyZ1FaRxC6b7FWlko340PaHJyQWU+QNMDx7Z6oXITErkgy7fKkT2L/G9
 iaVB8Ap9mARRafC0/J6WU3EnW8xlkDSA4GBYXqLXcOT72wjW1W1ijk1xDDLWcdsrfGlX
 6eQGTopeiKRG5WXVVLiCmgJe0Q1Er9+u137oMuBTXQdZiF4wiwfLbDhsol1yIKcCrZ9x
 3LBaPwRkJhDRZ/mC6nRuVbFSVT3vFBx++gkXtPDd1WVEr5/5WTQo8vyRDnn3xn7L3vQB
 Eex573vSUoenqgKPFmEAn1MjGL1SQE90NZRbWCHS7V0OcKEr3dpd8eQnvWJob4SJCr4B
 ciRA==
X-Gm-Message-State: AOJu0YzJNNj3C613Q9Nl/FCTFxbhBZKlHdYPb66PjuiY2bBXKqO+xk5Y
 xBisMkKNYHweSZVwehOlzjl6ZqpfwpHiJPmPZXVRrn06aDStGw0itdqea5b+zXSOEu1n6OnrzxN
 R58Lk4XDMJeswioydWnG7yP1O1+5RN7cOUHRULC8OJKs/L15RpVBaJFHdTyq8HANzMjVSbiPmsx
 abdaStPZYUKauQ/4Pn5+S9Iye3N9ge/0Btf8DMvX0poBQ=
X-Gm-Gg: ATEYQzwjhvpvpMGHRUe16/Ivcr8lgMVkz5z0OacqMkrCjM4Nx7ZCbe1RDqP/shvkgce
 0kRP6c+OjsmRkA9W1QiCGEcuk3D9ZkuAtAYeP43k7KnmqCeJVzfrUWtXuZCgt3rUh4S0ym6ST/4
 UoLWiwrfsXsLDk+XD7zEZyFj85Sfa89vjXVQ1v30a+XdRtzPl+PUcW0iVNvevZTPdx8BaNRBVTR
 bNJCqmDZKvY5+/k7h6Pva5sDdiv/ICvaUFJQ8cU0sjg16PGOkGMvvLv8fsilpx0Pe757Xgn6bah
 GObEWB6BatMOvgGxEx0DjTIha1ZZ/L5eSbHEVlgRuSx8JDkp0pATI4dYERaMG3MEh9THjN60VY1
 Mb4+wkWQdmGGDGNTJiZUMtrwTi7ajuQmwOPyar1+w6NgRfETD38k50XmBeH/CWCwivTgbbTCO+J
 Eru6YPp/UaGcy0JPT19KAgNPE4iBPK30EnOrjJ/EyWXRKeoTThDUUmZRRIZKTTSe0VxdGWFseLi
 NXiCnHvij8TaqMw+92EbnImfMMi/7ZpVbNDqZHnNSp/4Pp+KzU=
X-Received: by 2002:a05:7022:2586:b0:128:d2b2:143b with SMTP id
 a92af1059eb24-12aabb740fbmr469102c88.9.1774524541479; 
 Thu, 26 Mar 2026 04:29:01 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:29:01 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 05/14] mmc: atmel-sdhci: set GCK rate based on compatible
Date: Thu, 26 Mar 2026 12:26:46 +0100
Message-ID: <20260326112830.313874-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
References: <20260326112830.313874-1-robert.marko@sartura.hr>
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

In order to add support for LAN969x we need to set the GCK rate based on
compatible instead of defaulting to 240000000 Hz as LAN969x uses only
100000000 Hz.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mmc/atmel_sdhci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/atmel_sdhci.c b/drivers/mmc/atmel_sdhci.c
index 0b265196f02..f3a030ffde5 100644
--- a/drivers/mmc/atmel_sdhci.c
+++ b/drivers/mmc/atmel_sdhci.c
@@ -96,6 +96,7 @@ static int atmel_sdhci_probe(struct udevice *dev)
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct atmel_sdhci_plat *plat = dev_get_plat(dev);
 	struct sdhci_host *host = dev_get_priv(dev);
+	u32 gck_rate = dev_get_driver_data(dev);
 	u32 max_clk;
 	struct clk clk;
 	int ret;
@@ -119,7 +120,7 @@ static int atmel_sdhci_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	clk_set_rate(&clk, ATMEL_SDHC_GCK_RATE);
+	clk_set_rate(&clk, gck_rate);
 
 	max_clk = clk_get_rate(&clk);
 	if (!max_clk)
@@ -163,9 +164,9 @@ static int atmel_sdhci_bind(struct udevice *dev)
 }
 
 static const struct udevice_id atmel_sdhci_ids[] = {
-	{ .compatible = "atmel,sama5d2-sdhci" },
-	{ .compatible = "microchip,sam9x60-sdhci" },
-	{ .compatible = "microchip,sama7g5-sdhci" },
+	{ .compatible = "atmel,sama5d2-sdhci", .data = ATMEL_SDHC_GCK_RATE },
+	{ .compatible = "microchip,sam9x60-sdhci", .data = ATMEL_SDHC_GCK_RATE },
+	{ .compatible = "microchip,sama7g5-sdhci", .data = ATMEL_SDHC_GCK_RATE },
 	{ }
 };
 
-- 
2.53.0

