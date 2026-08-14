Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F60C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28B5360A86;
	Fri, 14 Aug 2026 18:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNDiBM62OxI6; Fri, 14 Aug 2026 18:30:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1D3C60AC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732247;
	bh=PE06Ndo5RvaHTH6d3FYkXh5tR6KWOrNYU5xy3W9UbwE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y5MdZG9EoHdGF10H5XTl3v030QSscVwPPkzc0B/D07hPXQKNUUfW4Dr1DyANVVC+e
	 V0ahA6GWq6jH3C9GpFJoQnYHo1jwTYMUa2+1O+8J8lTpBQ0+hOIMXqcJEb9Yxo4zTm
	 65XgVreDg+wKxGTj9XOmDsBISirIbnKP6pPLDMC0LKZ7M5JdmE7lkol6Q333R/TVd+
	 q1gqaZhjsW5aanf22c2Jk2HAm2tVbqSQ50BijSrcB60MUULMQgQdP9pymFd7vUKemV
	 iqPE/E+tFevfKM6vy5RjXA8Z2pPBn0a4phc5tIZxtz64ngggyOyaGsh1stCaqpUhsG
	 Clq+GFQq806Wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1D3C60AC0;
	Fri, 14 Aug 2026 18:30:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFFB83A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5B8F40D22
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ODPQP8_FTsd for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:30:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A73C140C9C
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A73C140C9C
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tWbB36YG
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A73C140C9C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:44 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-51c0cea8883so11088681cf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732243; x=1787337043;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PE06Ndo5RvaHTH6d3FYkXh5tR6KWOrNYU5xy3W9UbwE=;
 b=tWbB36YGGus7B1Xf1SrcHpMbpfARduFDBPeYUbIiEP5RwK7CcJlru6xKvQsrXurmoE
 Rz1/E1P0nB0/wVdKGZKfHVED+lNR06wFgS2TRbvGHCF6uE0sD9DqBfCMET4PchZT34Du
 TOaDQpNXxUt9XyiO/Rg7HqfKfkZzp2iuNZRUrxE6MNDa/SIoYMk7GS2XvX8tLVepRCgy
 yAS1Yj60MDeIaJceB1XwAeAGShAaztm7J4sbm9lWAU/XJ3uKTNUD5Z1IfZ6Cjp3ozB/u
 kfOB6wlDwZo87DwM4TaQ0wrOSJYAiYPD9+EtXFcfEOmXQVvJi6V3zFDHpRIdmqGiSEWb
 kX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732243; x=1787337043;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PE06Ndo5RvaHTH6d3FYkXh5tR6KWOrNYU5xy3W9UbwE=;
 b=mqoEA5DmZ2PyspFPqL9kmEEm9TRw1jBG7hmWX5xm3RILRuuP5VQuwueuBKV5IbBRw3
 +uAPjbA3jggANJv6UsP3AJWVCCs3eEmlEl5LChBfXhpxiNrFqlGdky0E/y9O3FDYghx5
 +/O+/sefkCc2DRmEuQ0tLzxx3R2ec3N0C/BOxDtCW8OpQ8qPFVB3oy2bCPEVlCScmpol
 H64XrTtHQlEEsudqpR7IG1R3qhUfRE5FJQ/UAmO/PMg/LeZUTzxCdbNu1cHEuv61i9po
 VBcPXod50trs2/nLggsTmvmVA5RtJWLTgAT5y7diYnAq1G6gWj5tvm4EkbGn94J6urts
 MuIQ==
X-Gm-Message-State: AOJu0Ywz1NBeOPrQQweEMz1avLztZ31dXWZKWk9MwNUzry0miNa65jSP
 +zyvMUbIqdfy2DnMzqXXuH9vAOSBv3W0DDBIyBy0itTduWqtP4J4mUzpyoroyyNbfQAJkRDqZ9p
 eln657yk=
X-Gm-Gg: AR+sD10Tw6vB+Nr8DaKvs5+WiuNT9QrhMftr+ZoDLWW4DEkShCyAudhWfeQ1VdZ41RB
 4a6akrRLF/txHb4zi8OY0Y8tu8e8jJ0Qd+ftjaSGbe92uILjSdaZF8IrY99HdxkDnp3VMGZwfVX
 BxBMOXSsh8fE5j5NhMI+/DeUE9HK+Ft6Pt7/NoPADjLQQ9TbKgOHD7Z/R0yphrgQDSY9/yY2aS7
 61yYvjdNjqQH/PsGY5iakl8Rfrx1RSbiV2h+Kz+t6v14MAjX+sszs+X5FsS6plzD2L8ToB6mb1v
 CFq+lrjS28GW9ePK0K41MYa2XTEkZqjQYFvcD/uZkSpwbABazjdJ2GjumrvYykvaIVUxOgkRFyz
 bdSPK2guTbQ9GfVGV1zyIaGlbk5yQ18jfu2YAvhwqePwwiqHnXbPjpY3hQ7tnJl1KyZywZx1ypC
 e2fi4eipmPuWmoZaiEaUWR7QhqLO5P2eCL719gloygZ1unTirWB6vSwbsi97HsZQbWR+vpPOHSP
 CX3CcWByB4MeNzySLMJI1v8gdMTngKSCfoH9SOgGrcYT9xXCGmlQY2k
X-Received: by 2002:a05:622a:1901:b0:51c:b98c:f772 with SMTP id
 d75a77b69052e-52d85051dbemr76459461cf.15.1786732243044; 
 Fri, 14 Aug 2026 11:30:43 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83ef8879sm26384321cf.10.2026.08.14.11.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:30:42 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:30:39 -0400
Subject: [PATCH v2] mmc: zynq_sdhci: support Renesas RZ/N1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-mmc-v2-1-51e4d8a717b8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM9ef2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ND3aKqPENdEE/X0EA3NzdZ19IwOcXE3MzcwNzMWAmoraAoNS2zAmx
 kdCyEX1yalJWaXAIyR6m2FgBv+H9LdAAAAA==
X-Change-ID: 20260811-rzn1-2026-10-mmc-91cd47670763
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732242; l=4098;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=a20TYHOGHeDgQk3xRV7YhmYcH3H/+MM5N6GwcnXL9Wk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ5XE4eMwQWLpV61ot1vLR8dpQsnZ+68brg7jj9Er2n4ltruzYtV9HXQfkUfoLJQxpd2B79/caO
 pWDWH2ggBzwU=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Renesas RZ/N1 SoC contains a MMC controller using the Arasan IP.
It is supported by the existing driver, with the following changes:

1) Multiple clocks need to be enabled. This is handled using
   clk_get_bulk() and clock_enable_bulk().

2) It is necessary to defer the sdhci_probe(), similar to what is
   done in drivers/mmc/am654_sdhci.c

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- split from the series "Renesas RZ/N1 additional drivers"
  https://lore.kernel.org/u-boot/20260731-rzn1-2026-07-v1-8-af2ce80db9d8@linaro.org/
- fix typo in commit message
---
 drivers/mmc/Kconfig      |  2 +-
 drivers/mmc/zynq_sdhci.c | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f9f7aa5cf97..7649fc8f53f 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -778,7 +778,7 @@ config TEGRA124_MMC_DISABLE_EXT_LOOPBACK
 config MMC_SDHCI_ZYNQ
 	bool "Arasan SDHCI controller support"
 	depends on OF_CONTROL
-	depends on ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2 || ARCH_ZYNQ || ARCH_ZYNQMP
+	depends on ARCH_RENESAS || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2 || ARCH_ZYNQ || ARCH_ZYNQMP
 	depends on MMC_SDHCI
 	help
 	  Support for Arasan SDHCI host controller on Zynq/ZynqMP ARM SoCs platform
diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index eda95b72f49..351e7d56569 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -1012,6 +1012,31 @@ static const struct sdhci_ops arasan_ops = {
 	.config_dll = &arasan_sdhci_config_dll,
 #endif
 };
+
+#elif defined(CONFIG_ARCH_RENESAS)
+/*
+ * It is unknown whether the IP in RZ/N1 supports these clock phase
+ * adjustments. The devicetree does not include these properties.
+ * So this is a no-op for now.
+ */
+static void arasan_dt_parse_clk_phases(struct udevice *dev)
+{
+}
+
+/*
+ * Renesas RZ/N1 needs deferred sdhci_probe(), otherwise the
+ * first CMD_00 fails with "Timeout for status update"
+ */
+static int arasan_sdhci_deferred_probe(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+
+	return sdhci_probe(dev);
+}
+
+static const struct sdhci_ops arasan_ops = {
+	.deferred_probe = arasan_sdhci_deferred_probe,
+};
 #endif
 
 #if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_ZYNQMP_FIRMWARE)
@@ -1110,7 +1135,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct arasan_sdhci_priv *priv = dev_get_priv(dev);
 	struct sdhci_host *host;
-	struct clk clk;
+	struct clk_bulk clks;
 	unsigned long clock;
 	int ret;
 
@@ -1152,13 +1177,13 @@ static int arasan_sdhci_probe(struct udevice *dev)
 		}
 	}
 
-	ret = clk_get_by_index(dev, 0, &clk);
+	ret = clk_get_bulk(dev, &clks);
 	if (ret < 0) {
-		dev_err(dev, "failed to get clock\n");
+		dev_err(dev, "failed to get clock(s)\n");
 		return ret;
 	}
 
-	clock = clk_get_rate(&clk);
+	clock = clk_get_rate(&clks.clks[0]);
 	if (IS_ERR_VALUE(clock)) {
 		dev_err(dev, "failed to get rate\n");
 		return clock;
@@ -1166,9 +1191,9 @@ static int arasan_sdhci_probe(struct udevice *dev)
 
 	dev_dbg(dev, "%s: CLK %ld\n", __func__, clock);
 
-	ret = clk_enable(&clk);
+	ret = clk_enable_bulk(&clks);
 	if (ret) {
-		dev_err(dev, "failed to enable clock\n");
+		dev_err(dev, "failed to enable clock(s)\n");
 		return ret;
 	}
 
@@ -1239,7 +1264,7 @@ static int arasan_sdhci_of_to_plat(struct udevice *dev)
 	priv->host->name = dev->name;
 
 #if defined(CONFIG_ARCH_ZYNQMP) || defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL_NET) || \
-    defined(CONFIG_ARCH_VERSAL2)
+    defined(CONFIG_ARCH_VERSAL2) || defined(CONFIG_ARCH_RENESAS)
 	priv->host->ops = &arasan_ops;
 	arasan_dt_parse_clk_phases(dev);
 #endif

---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-rzn1-2026-10-mmc-91cd47670763

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

