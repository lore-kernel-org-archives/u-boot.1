Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE36C83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 16:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E13801BE;
	Wed, 30 Jul 2025 18:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FD/74SMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6281080C83; Wed, 30 Jul 2025 18:53:01 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA8B80194
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 18:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4589968e001so283505e9.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753894378; x=1754499178; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KzUeQiyZ9CZWDXMbIdmcSWhei9kwHSJGXTzT0IDvAtY=;
 b=FD/74SMVL4cUxKuB+OdLcSoMrH2Omn1cxSq/QSnmjmlegB/L3EPSMTLHBGtr86JW8t
 4BTgrMb31/4PpLLr5kIGo9C4ENRcU+fSz8TqBFc2TFRfIHA1BvGPClUMYOuzr5z8qxFM
 jx0LAPiowAbQ2I2xIba00bhxkOU/EIxpCveBj8IXmWQifBGarfUby329NCmGhu2QMpeo
 CGr/nBOLngRplLR1pIFIvlFM8ItnxUcg+TsC3/CM1rMCLMmGNaUpQ/7Yp9PU1CXuWrXv
 PH9GEwfvl9/DiCwWMCU1mYUuTc2P2ooVUomyXlQwwZfV4SCuGSA1quJpdp9WOvPIPC03
 S60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753894378; x=1754499178;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KzUeQiyZ9CZWDXMbIdmcSWhei9kwHSJGXTzT0IDvAtY=;
 b=U7eZ0WP4135/sAQMFstPFmoMrFIjGXr1y3hw2xHbBzf09ixzz4OpXzptxDWcuN6dOp
 CloooolNpzLnq4bgVFMu2ZzPzzhNx/kXNV9I+xqDnz/D6ok5NGnHS18NuxvAfyq4Gzhl
 nJt2MD3cdK80ikexhDFnp7IDJJCnQJbZRxgfjDjrp/Vu/ktroPjiBUaPqnJ56BBIr8Ff
 hitNbzhfVUJYBwQ7xXvBb4bH66B5Oc/VhzUb5HESvQHeKzC236v9HBB0hgGD0URky6Nd
 1MardRf8BwMzzJ3PJ2cG/6HGx1LdunbClNs0k790N9rCkDpW3b3V42Jg5FrYGVy80Feq
 FyoA==
X-Gm-Message-State: AOJu0Yx7H4P9GGcMaPHS4P0UQmaUgGsBYn+3AMEgEcrEOIl+ld9qmtG2
 jpDdm9QSZTQuSJGhkfKLoDv+DkFAAaq/zLeMDF4uL+2rBmvXfXJP/osYeYcGGHzE1Rk=
X-Gm-Gg: ASbGncubX8sdKGcrDci2vJUv/TPXQN2whxNVCieog7vX32DbzmYDcdPdBUgLJ4EzxFd
 uwI0sLQ2D2YWylh9rnmzXXhMIs6TjTIADIzcG7s+qsRanG+oVytZOg2T33tWb71QumeIS3aXjd4
 thptIBsgknENrDKK12F3qZQRrriG44+r1XscQCEnp96ssro8YJzs0NULxvnkp//FCKyCimgCOfx
 HdFI+v0WHOoVUmvSeIWnX97Ldwv05VNSFn2CAJb5A1QhZ4HWs1KJW6ooTusjANOeQ9/nGKixYoh
 n67F5Hvlbzijw29yXSYXZY9j0q3loBCTYFCp3HdnNMX2rzPDxexikI2i3RRvUQcrSLhMR1tb6R/
 WZzYY4lC46tKExi7ddqfnr8KBgMsQJvLzQpFu/lB7cEeX72m/erA=
X-Google-Smtp-Source: AGHT+IEV2P1xG7iK6yHtFbWnjgsc+hcWXB/RXTKMuHZBilh8v+UfA/7YWcW2nKEXEHGwKr9FjHojxw==
X-Received: by 2002:a05:600c:a009:b0:456:2ac6:ccc3 with SMTP id
 5b1f17b1804b1-4589c505c6cmr16784545e9.25.1753894377690; 
 Wed, 30 Jul 2025 09:52:57 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e0e1:49aa:5ad4:62b1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78084f79csm14936662f8f.71.2025.07.30.09.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 09:52:57 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 30 Jul 2025 17:52:56 +0100
Subject: [PATCH] mmc: iproc_sdhci: Cannot test unsigned variable for negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-iproc_sdhci-v1-1-310015b22944@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOdNimgC/x2NQQqDQAwAvyI5dyFVl0q/UkqJ2djNoaskUgTx7
 117HIZhdnAxFYd7s4PJV13nUuF6aYAzlbcETZWhxTbircOgi8388pRZw4QUU49Dz0OEWozkEka
 jwvlsPuSr2CkWk0m3/+bxPI4f3scH53YAAAA=
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In sdhci_iproc_execute_tuning the variable tuning_loop_counter is
unsigned and therefore will always fail the test for it being less than
0. Fix this by changing the variable type to be s8.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/iproc_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/iproc_sdhci.c b/drivers/mmc/iproc_sdhci.c
index 7ab74ff117a..654672a546f 100644
--- a/drivers/mmc/iproc_sdhci.c
+++ b/drivers/mmc/iproc_sdhci.c
@@ -182,7 +182,7 @@ static int sdhci_iproc_execute_tuning(struct mmc *mmc, u8 opcode)
 	u32 ctrl;
 	u32 blocksize = SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, 64);
 	struct sdhci_host *host = dev_get_priv(mmc->dev);
-	char tuning_loop_counter = MAX_TUNING_LOOP;
+	s8 tuning_loop_counter = MAX_TUNING_LOOP;
 	int ret = 0;
 
 	sdhci_start_tuning(host);

---
base-commit: a8f20bb6650df56d2600cda2c66f9349df9e49c8
change-id: 20250730-iproc_sdhci-f0a5d4084c85

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

