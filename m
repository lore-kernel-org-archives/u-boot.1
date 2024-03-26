Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C2FC54E64
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 02:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1968D87F5E;
	Tue, 26 Mar 2024 03:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="Es5flpxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A0787F5E; Tue, 26 Mar 2024 03:20:43 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBBC187EA8
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 03:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-609fb19ae76so58565417b3.2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1711419639; x=1712024439;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XMkSLiKdH5nVydAyii7wmpX0v+YMbInwQ06O7LNdcs8=;
 b=Es5flpxIVT8HDxoEUT5gwQdfu6XYdwHPdr20crbf9hFrEGT7CHMk2CgtI4+LVyLlLM
 tpYIa7/fXY6dVisATaxY9wvq6hommTPje1cJ0mBfy7zSY3tJDzPKeqXWiryQD1I7mm6f
 pJ9cUVdT98AytRonEG5gfGGxYJei2mnORtNGHBCboGf2tff9gSqVHrMT4sJNia8PkU01
 vazaEr1OLRL2tyCCbHJsmrQn5Tcu6Xg/pf+dPKIxuFneHjtrAx2GgxvHYYIzJjzFXVsx
 O4RulkOjFj5TncK9ln68mJMJoQcWLwF4h9zlmpL8AJ9ocod4iF+g8zJVvyahUs32Mj/S
 EO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711419639; x=1712024439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XMkSLiKdH5nVydAyii7wmpX0v+YMbInwQ06O7LNdcs8=;
 b=cqoyMu+c+vlfG8f7/LtvejNs3WQ6BUTyZP++RXnJRrQB/VHzfK6EfokYJMSV2YiWXc
 ttJz49p9AKgT+lFUSL50S67NMCe9wfga2HAg6olwMSo+nmZXgMNBTl70w+hQ/0WmCoXy
 2QjcQCJBYAnQpEFFFgjapymbdEPPE/MFF1X2haTzVUKM9ROBAXwykeTi8CpwqUT6g/6l
 FCrXSULBFUlK06a9VtMAppDVXPkoYyhpRFtUN/y00DRKezYVEAnhyNikyXPyc2Idbgfo
 qmjpB5KYrME3LkpCaiNKf+y+9GOa0z9D5xlJO51h2NCVxxZddOTVn/z8EtzMOtO9QB7v
 lnUg==
X-Gm-Message-State: AOJu0Yxmr7H1efeW7CaXSdiWyqef7gF9SQMpFI19zgVCeLQZuaeTSSZt
 IMwZt4Kb/5fjHAl6Crir+DvzitAVWYTpOrNjHbfFB+RxqKZ18WwGEypN5dpZLoV5xJX49wPM8hn
 mVw==
X-Google-Smtp-Source: AGHT+IENjRLDTYxn6PIitXKSLcaYILFqUulFF1Zz4ZxOW7NTfg1Ff0oo8iccv4RykW/4CgsV7qgjRQ==
X-Received: by 2002:a5b:3d0:0:b0:dcd:19ba:10df with SMTP id
 t16-20020a5b03d0000000b00dcd19ba10dfmr6302358ybp.56.1711419639347; 
 Mon, 25 Mar 2024 19:20:39 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a25f403000000b00dc6e1cc7f9bsm1265193ybd.53.2024.03.25.19.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 19:20:38 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Geis <pgwipeout@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: sdhci: introduce adma_write_desc() hook to struct
 sdhci_ops
Date: Mon, 25 Mar 2024 22:18:14 -0400
Message-ID: <20240326021819.770-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
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

From: Ian Roberts <ian.roberts@timesys.com>

Add this hook so that it can be overridden with driver specific
implementations. We also let the original sdhci_adma_write_desc()
accept &desc so that the function can set its new value. Then export
the function so that it could be reused by driver's specific
implementations.

The above is a port of Linux kernel commit 54552e4948cbf

In addition, allow drivers to allocate their own ADMA descriptor
tables if additional space is required.

Finally, fix the assignment of adma_addr to fix compiler warning
on 64-bit platforms that still use 32-bit DMA addressing.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>

---


---
 drivers/mmc/fsl_esdhc.c  |  2 +-
 drivers/mmc/sdhci-adma.c | 41 +++++++++++++++++++++++++++-------------
 drivers/mmc/sdhci.c      |  8 +++++---
 include/sdhci.h          | 12 ++++++++++--
 4 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
index d506666669..bd0671cc52 100644
--- a/drivers/mmc/fsl_esdhc.c
+++ b/drivers/mmc/fsl_esdhc.c
@@ -252,7 +252,7 @@ static void esdhc_setup_dma(struct fsl_esdhc_priv *priv, struct mmc_data *data)
 	    priv->adma_desc_table) {
 		debug("Using ADMA2\n");
 		/* prefer ADMA2 if it is available */
-		sdhci_prepare_adma_table(priv->adma_desc_table, data,
+		sdhci_prepare_adma_table(NULL, priv->adma_desc_table, data,
 					 priv->dma_addr);
 
 		adma_addr = virt_to_phys(priv->adma_desc_table);
diff --git a/drivers/mmc/sdhci-adma.c b/drivers/mmc/sdhci-adma.c
index 8213223d3f..8c38448b6a 100644
--- a/drivers/mmc/sdhci-adma.c
+++ b/drivers/mmc/sdhci-adma.c
@@ -9,9 +9,10 @@
 #include <malloc.h>
 #include <asm/cache.h>
 
-static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
-			    dma_addr_t addr, u16 len, bool end)
+void sdhci_adma_write_desc(struct sdhci_host *host, void **next_desc,
+			   dma_addr_t addr, int len, bool end)
 {
+	struct sdhci_adma_desc *desc = *next_desc;
 	u8 attr;
 
 	attr = ADMA_DESC_ATTR_VALID | ADMA_DESC_TRANSFER_DATA;
@@ -19,17 +20,30 @@ static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
 		attr |= ADMA_DESC_ATTR_END;
 
 	desc->attr = attr;
-	desc->len = len;
+	desc->len = len & 0xffff;
 	desc->reserved = 0;
 	desc->addr_lo = lower_32_bits(addr);
 #ifdef CONFIG_DMA_ADDR_T_64BIT
 	desc->addr_hi = upper_32_bits(addr);
 #endif
+
+	*next_desc += ADMA_DESC_LEN;
+}
+
+static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
+					   void **desc, dma_addr_t addr,
+					   int len, bool end)
+{
+	if (host && host->ops && host->ops->adma_write_desc)
+		host->ops->adma_write_desc(host, desc, addr, len, end);
+	else
+		sdhci_adma_write_desc(host, desc, addr, len, end);
 }
 
 /**
  * sdhci_prepare_adma_table() - Populate the ADMA table
  *
+ * @host:	Pointer to the sdhci_host
  * @table:	Pointer to the ADMA table
  * @data:	Pointer to MMC data
  * @addr:	DMA address to write to or read from
@@ -39,25 +53,26 @@ static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
  * Please note, that the table size depends on CONFIG_SYS_MMC_MAX_BLK_COUNT and
  * we don't have to check for overflow.
  */
-void sdhci_prepare_adma_table(struct sdhci_adma_desc *table,
-			      struct mmc_data *data, dma_addr_t addr)
+void sdhci_prepare_adma_table(struct sdhci_host *host,
+			      struct sdhci_adma_desc *table,
+			      struct mmc_data *data, dma_addr_t start_addr)
 {
+	dma_addr_t addr = start_addr;
 	uint trans_bytes = data->blocksize * data->blocks;
-	uint desc_count = DIV_ROUND_UP(trans_bytes, ADMA_MAX_LEN);
-	struct sdhci_adma_desc *desc = table;
-	int i = desc_count;
+	void *next_desc = table;
+	int i = DIV_ROUND_UP(trans_bytes, ADMA_MAX_LEN);
 
 	while (--i) {
-		sdhci_adma_desc(desc, addr, ADMA_MAX_LEN, false);
+		__sdhci_adma_write_desc(host, &next_desc, addr,
+					ADMA_MAX_LEN, false);
 		addr += ADMA_MAX_LEN;
 		trans_bytes -= ADMA_MAX_LEN;
-		desc++;
 	}
 
-	sdhci_adma_desc(desc, addr, trans_bytes, true);
+	__sdhci_adma_write_desc(host, &next_desc, addr, trans_bytes, true);
 
-	flush_cache((dma_addr_t)table,
-		    ROUND(desc_count * sizeof(struct sdhci_adma_desc),
+	flush_cache((phys_addr_t)table,
+		    ROUND(next_desc - (void *)table,
 			  ARCH_DMA_MINALIGN));
 }
 
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 0178ed8a11..65090348ae 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -111,7 +111,7 @@ static void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data,
 	}
 #if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
 	else if (host->flags & (USE_ADMA | USE_ADMA64)) {
-		sdhci_prepare_adma_table(host->adma_desc_table, data,
+		sdhci_prepare_adma_table(host, host->adma_desc_table, data,
 					 host->start_addr);
 
 		sdhci_writel(host, lower_32_bits(host->adma_addr),
@@ -897,8 +897,10 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
 		       __func__);
 		return -EINVAL;
 	}
-	host->adma_desc_table = sdhci_adma_init();
-	host->adma_addr = (dma_addr_t)host->adma_desc_table;
+	if (!host->adma_desc_table) {
+		host->adma_desc_table = sdhci_adma_init();
+		host->adma_addr = virt_to_phys(host->adma_desc_table);
+	}
 
 #ifdef CONFIG_DMA_ADDR_T_64BIT
 	host->flags |= USE_ADMA64;
diff --git a/include/sdhci.h b/include/sdhci.h
index a1b74e3bd7..4bde7db5c7 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -291,6 +291,11 @@ struct sdhci_ops {
 	 * Return: 0 if successful, -ve on error
 	 */
 	int	(*set_enhanced_strobe)(struct sdhci_host *host);
+
+#if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
+	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
+				   dma_addr_t addr, int len, bool end);
+#endif
 };
 
 #define ADMA_MAX_LEN	65532
@@ -526,8 +531,11 @@ extern const struct dm_mmc_ops sdhci_ops;
 #else
 #endif
 
+void sdhci_adma_write_desc(struct sdhci_host *host, void **next_desc,
+			   dma_addr_t addr, int len, bool end);
 struct sdhci_adma_desc *sdhci_adma_init(void);
-void sdhci_prepare_adma_table(struct sdhci_adma_desc *table,
-			      struct mmc_data *data, dma_addr_t addr);
+void sdhci_prepare_adma_table(struct sdhci_host *host,
+			      struct sdhci_adma_desc *table,
+			      struct mmc_data *data, dma_addr_t start_addr);
 
 #endif /* __SDHCI_HW_H */
-- 
2.43.2

