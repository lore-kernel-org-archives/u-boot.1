Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3580DC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD3FE83092;
	Mon, 14 Jul 2025 15:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wL1yneq7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9BF82E52; Mon, 14 Jul 2025 15:13:24 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E339983082
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so3510663f8f.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752498801; x=1753103601; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h1gpah1WBoRjHTJuwXieDvOROb6VZbzTjhgaXGuVgDg=;
 b=wL1yneq7FNU2p5AgqCEk7utneW+AnaZdBepTxGnglAcm94Mhb2M97fXSWUSILz16OP
 hvDidwHynU0tnaiASo/LaHUMSW7mJiH7EdGvBrujJ8NfLPotpumnJFVyePYlV/ZN9Vuv
 6wL1ySKNWe+0Bx0QSjsrWE4KwsQLP9nNLrO/Qrn/bm/r45twNiS4vrlzlXuLB6cRhctT
 6/Ub+yyH3nBYNPT66rlaVy4QaFimy+ykjoD7RcfytWyC77b9xxQEIMw7wcARYCXIbyjG
 +gYaAmFtde6q2xalvjlsdloqMd/DKz3afnWj3ba475m6Bd/81y1y0rG4XaEPGDf0VFcy
 lfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498801; x=1753103601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1gpah1WBoRjHTJuwXieDvOROb6VZbzTjhgaXGuVgDg=;
 b=Bs99HUlzojW4YPXUN3jT4jEJH8WTvGoDuwwimP6yXejlr3gFwGmuMqf6wBxLF+slgM
 FT9m2mzWJtRnS3YgJpvNwYX7/vr6h6J5XQJHWku8Mpa5xpREvFBOc/aP2/QjRd3Dq7f7
 80vCJ0YFqurNwGxyQryPaO5hmTZ+DBz9Lndh4Zq88lsoY3NQtmCbGAaUX4MaiDe4m9ju
 AJgnXpepFKXjxyXl4KdVui1zlumVKwkeRze27cJqrcwDCrhA1WNnK9qGlAISwE6D8NRu
 zcADaaa1qnogmkLrWDa8sK8LsP49g7mGTKRUiuHHn93qyLz+uKj8zU6L3JN+LEQzrx4A
 lMHw==
X-Gm-Message-State: AOJu0YwStXdi0kZbLmlJcesTTEROxzBISILwJFw5o8fT/kXXortBMfdN
 YQp3sxh+MebEtNDDNq8UyBeU/7iJyU+OZxpsmXd1/aqz9LRyVvP9MBVTleG8s0gyD0A=
X-Gm-Gg: ASbGncuGmmZRblpT1k/Udd8mZZY/MS/njn/+CMahGaoohPczoA2s6esQhdMYqMqfhxB
 wCa2Xs2hu7qypz7DWNtHmxWuVSCkb2JNz28+oXBBdZVb8bovcX9+VgMM8Ng6MVOaKLIiyI7XRVD
 CWpbj/hgVUmUfrFiiDrN6JDjCrO/TaFwscBFck++QVXmMbg4+vZw5KWGXZVvz6QWOOvW2EQ+PhI
 XAfVylp1H95/R6kqZTa/ByQhe3Z+pbwIkbaGed/Y1hc8ktu82mfy8I24t1+CrILsfTdEeDNRPml
 DN3F6/QmySgurlH2kVf18cbe6Txp1GNMWiihzc4P76tm+N+RDg9q+5vlMFbeQ7Qb38GdJqstEcR
 Kt9Y6pnPVlrTKxxsoNiinp0IxM6Pu+RgYncQJi8D4TE/9GJJeZZLW9oyR+2zlIVN0OadoTxlujc
 dcpVMj
X-Google-Smtp-Source: AGHT+IF5HA4o4KIbBfNaPwa8oGJOz6E17KAwDEzYBkloYg96K4mD843ncrN0DAIGxhG5kTfR8xBqDg==
X-Received: by 2002:a05:6000:2004:b0:3b4:9dbd:eee9 with SMTP id
 ffacd0b85a97d-3b5f18d999emr10436690f8f.36.1752498801334; 
 Mon, 14 Jul 2025 06:13:21 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm12361010f8f.44.2025.07.14.06.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:13:20 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 14 Jul 2025 15:13:15 +0200
Subject: [PATCH v5 4/8] i2c: geni: load firmware if required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-geni-load-fw-v5-4-5abbc0d29838@linaro.org>
References: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
In-Reply-To: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=nu2caNisw7aXAbiYD/Imhyx9ZRu+DMvOZ6nH+XvuaKU=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBodQJqvz8uHNAOnbq8S/35PWyL8rak1c0T3KRo3
 ycyEdpEB4qJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaHUCagAKCRAFgzErGV9k
 tmnzD/47H2BzyzlLTjTEO+h4ryNTZdj7areU2WSnfHh6ldoWwX9f+aVekTAQeHwrS++m8PBiQai
 45o1RGxFY/jLW4DCZMfP4+y1WqeJAY+frqFtLAH/i9YAVqvFm6vuu9sba/i89CWHj304pL9nDXd
 8swHBYi7Inp97EFw15BLzxlTd+05tpG0zDEq4sVltJegsDi+VNfB3TgwbGg1XDfpbnKnniuW2KG
 a7WPi+ueHDEFd0aHS83OwZMDgpAZEof5PjsslNgRQGoKWNYATY+L38yu2Epsh97tlevBUZh/Pdk
 PrRBNcVVPdUSY6MXkZNk7qmK26aK0YDQkVf57WRA5QT7J+6eZXbDbC/smsB7/L0nGrp5EFU39Zn
 9pew23Dbz1jxyd8WTAz8qUTiCP3C+GzmLDK0Y+wYTSUf0CWKtha3mcwLE6xDcCX5kfwwG1eUvIo
 6A3TrFiqaP8NKxFW25oWsqOYLSkgUuo2SM62PQPBIOVtaWHXtbLa/PNySbcV4Iu2DTzPnY+BDIf
 +A77UdPq+74jb/ec4EJ1zuSiDnr6/IQnmsNNQHu3Y4o0rmnWDliUKak3xFW/tk2Q0Wb2o/uXcD0
 zUkrZvtZKTCoD76r9nJ+t1C13mWxvjBo29CNwN98clbsms/5hQKmLtklH8HD35UBr0Fcjmyon+7
 o4xWCg5ISAuDyMw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Load firmware for the peripheral if necessary.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/i2c/geni_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index 4eb41ba852f7790ca646c8ba38f29fdb727fa804..d29e00fdf41df1d7a95d8d9b3b98f784f5b2a3e1 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -21,8 +21,9 @@
 #include <clk.h>
 #include <reset.h>
 #include <time.h>
 #include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
 
 #define SE_I2C_TX_TRANS_LEN		0x26c
 #define SE_I2C_RX_TRANS_LEN		0x270
 #define SE_I2C_SCL_COUNTERS		0x278
@@ -498,8 +499,15 @@ static int geni_i2c_probe(struct udevice *dev)
 	proto = readl(geni->base + GENI_FW_REVISION_RO);
 	proto &= FW_REV_PROTOCOL_MSK;
 	proto >>= FW_REV_PROTOCOL_SHFT;
 
+	if (proto == GENI_SE_INVALID_PROTO) {
+		qcom_geni_load_firmware(geni->base, dev);
+		proto = readl(geni->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+	}
+
 	if (proto != GENI_SE_I2C) {
 		dev_err(dev, "Invalid proto %d\n", proto);
 		geni_i2c_disable_clocks(dev, geni);
 		return -ENXIO;

-- 
2.50.0

