Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F17C2BA18
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 01:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EA7D882AD;
	Fri, 21 Jun 2024 03:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GBqfg/ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37DE883F2; Fri, 21 Jun 2024 03:54:05 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B2888013
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 03:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57d0f929f79so1314919a12.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 18:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718934843; x=1719539643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mG/VkNSKWlWqbcP9I+0WoDws0pP73p8OtMj2sCPffIs=;
 b=GBqfg/tsiE26ud/DylsFW1rd33OKxQwAEEW8ZgAxTLP5qmgerY3GnWP/5NIaM8z2wT
 okRowwM1JnHVg5ph4sdJKKTJM6IIgAbuU9CrFp4zmqGpEbRIU+2/vKucpAK07Fz5zmno
 c88M36wUuFU6xEsPFx3kmZfiVX/VLQXazSoHTySfxp4biyjgAiFMaJfGxdPcjB88cWbs
 6V1nY1c6bMk11YOwR0F5zD9tyrptcRdnukZeYP/qg4Sy2mcwcdkE1i+E3uzQWxyUEuSV
 YfF8NR+gFa+ZPt7B0pc+hZnj1nHx+RNh+CsC6EzoYtYJ9CK/A74TCl/zG9gnW78hy2RH
 1LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718934843; x=1719539643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mG/VkNSKWlWqbcP9I+0WoDws0pP73p8OtMj2sCPffIs=;
 b=oKKNFLgs4eAoSZzI1daFrhxuXOHbKI7LZeQpoQSoAKz6Rw46/Zn4MHx5CceF8BX/EN
 m3wDA89j85vfw0Y2NUSUeXchhiP3RWg9SG1y0WONKM4Cy7fz8hsc6NToySLwte/cZ1qa
 Uak2S1MkrDm/sj4OntAFDAqJpu9fuJXo1NMEgQIJnDMGmrEhfd2ZmMJhvsGCtrOZFBYy
 zIXowDhQIDhb+fLx77oOk882c7k7a06ZEzL762CNu2uA1bbhX30LhTnZXtFdKAUd+Fk6
 l0RS9LhEOwOa0X2qn5lG+4kZOcwN8SBG5MrCeoM3hSHvm5YXoKATZ63qL8UAmLfF0sn0
 ScJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6zslS6lLo9M1q6say157uC5dmca/F8iXYEFaNrW5tPPye5Bl+d9shjHll44200pMLeplNhGb1mMMd6DLnNA4KFJkw+A==
X-Gm-Message-State: AOJu0YwAzIlOH8NIXr4EMV3HNP7drQwCgEmTBpZgcH+AH1M0L6YPnC18
 iYD1TFXZeLH40b/qmKf1icC5RyL09KjEZpFSGokapiqYA4qG044kFGI/Q618F/g=
X-Google-Smtp-Source: AGHT+IEamWTz98qo58G4EQjZqccGmp10dsqxTFWTLibCf+5Gm/FA7aiNZaFMs8dUzb4Rk+o5g8CvZA==
X-Received: by 2002:a50:d619:0:b0:57d:73c:9299 with SMTP id
 4fb4d7f45d1cf-57d07e752fbmr4153205a12.23.1718934843069; 
 Thu, 20 Jun 2024 18:54:03 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::ebdd])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3041208esm257919a12.30.2024.06.20.18.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 18:54:02 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH] mmc: msm_sdhci: program core_vendor_spec
Date: Fri, 21 Jun 2024 03:53:09 +0200
Message-ID: <20240621015351.1573934-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

After resetting the host controller, program in the POR val for this
register just like the Linux driver does.

This seems to help with initialization when running U-Boot as the primary
bootloader on some boards.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 4ce0de6c47d8..8b3188fa20d4 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -31,8 +31,10 @@
 #define SDCC_MCI_STATUS2 0x6C
 #define SDCC_MCI_STATUS2_MCI_ACT 0x1
 #define SDCC_MCI_HC_MODE 0x78
 
+#define CORE_VENDOR_SPEC_POR_VAL 0xa9c
+
 struct msm_sdhc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 };
@@ -45,21 +47,25 @@ struct msm_sdhc {
 
 struct msm_sdhc_variant_info {
 	bool mci_removed;
 
+	u32 core_vendor_spec;
 	u32 core_vendor_spec_capabilities0;
 };
 
 DECLARE_GLOBAL_DATA_PTR;
 
 static int msm_sdc_clk_init(struct udevice *dev)
 {
 	struct msm_sdhc *prv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info;
 	ofnode node = dev_ofnode(dev);
 	ulong clk_rate;
 	int ret, i = 0, n_clks;
 	const char *clk_name;
 
+	var_info = (void *)dev_get_driver_data(dev);
+
 	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
 	if (ret)
 		clk_rate = 201500000;
 
@@ -104,8 +110,11 @@ static int msm_sdc_clk_init(struct udevice *dev)
 		log_warning("Couldn't set MMC core clock rate: %dE\n", clk_rate ? (int)PTR_ERR((void *)clk_rate) : 0);
 		return -EINVAL;
 	}
 
+	writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
+		prv->host.ioaddr + var_info->core_vendor_spec);
+
 	return 0;
 }
 
 static int msm_sdc_mci_init(struct msm_sdhc *prv)
@@ -254,14 +263,16 @@ static int msm_sdc_bind(struct udevice *dev)
 
 static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 	.mci_removed = false,
 
+	.core_vendor_spec = 0x10c,
 	.core_vendor_spec_capabilities0 = 0x11c,
 };
 
 static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
 	.mci_removed = true,
 
+	.core_vendor_spec = 0x20c,
 	.core_vendor_spec_capabilities0 = 0x21c,
 };
 
 static const struct udevice_id msm_mmc_ids[] = {
-- 
2.45.0

