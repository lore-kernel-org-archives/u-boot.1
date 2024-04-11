Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4DCC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539F1881FA;
	Fri, 12 Apr 2024 00:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="mgyAcJFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C248758B; Fri, 12 Apr 2024 00:37:46 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEC3881FD
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dd161eb03afso327478276.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875061; x=1713479861;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRNyd6a7VWNtm86TXN1lqxb3cvB2GYtldmsHq2lj/VI=;
 b=mgyAcJFScLsBHGeNHxKXOU67tPVCgQfR6pIaxcBe7/vDGaScinDdc9R3LqPxt3nB06
 J8THx6ush4YDA8NGOV5N2qL6rreCCryAGnUuY8ApLkCio++hAtA+68JSBWfeAHB5OXQz
 +q6ZUgYVJO5OXxivuCprJ1MtSuTImMhv9VFHeQcPAsYY9Oc8nqJtcqmWQhkg5L/Ua6jw
 DHJul3YbBibtOV85EFe1LqTJQK5QeHnW7wufrMfkx3aPkZgFPb0u150pIE0bEkqYZrRg
 wcrFOyhj+nfW52zyIBXB1Jn/Z4QeTEowNq9YkwPmspEmmLMaDpD1OW6/xmp7pbrQFQAv
 b0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875061; x=1713479861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRNyd6a7VWNtm86TXN1lqxb3cvB2GYtldmsHq2lj/VI=;
 b=J3gGfdrPv1T06oyiGMyRPB3GjamrUw1zaEn2pFTrCjmAVjrrrItUCzT2j6WdKGC+P8
 dMkmDbxUtpSH0aYEgvmdQy2bBgugemRbzwA9P6cMFM1lpZIZk4tS57iCAWurdKMvlJ10
 ZwewU+PJyxojyXSknTxUWqh1p0zzZGG6nUoD8oqLjxBIsUzAELt9fzxYl/3/ETcWtU46
 TWRBZS3Y8DNJswXoXz0QWVTjILXYvqOELXtG+3KmILF/C44Q2lQkAFHqfeB6Q+nn+l4S
 +2Tj2rtLp7t7ogp4iCCbu3lxaiHSRAr+elXbgvAq7yGTj6lrtX5ANGjezxVosJuuM1fX
 QAcw==
X-Gm-Message-State: AOJu0YzfJ81NwiSYGy6qCVUHwphF1e6wk26cKWLhYnGLRtb9dgb3jozK
 bloOxhkBT4Smdg95fm/qyPWV7TeKsmNJ1Bg8PKvWDNvBH+U9BD8wBLiz1U092VK+KToN0De1hvo
 5Qw==
X-Google-Smtp-Source: AGHT+IGrPNyOFzYCDSBEleYqeFglTgZcw5ykZCOeRTXa36MgBErOXpbMj8CS2cpy8t8xVV3545GyWw==
X-Received: by 2002:a05:6902:1b82:b0:dc7:465d:c06d with SMTP id
 ei2-20020a0569021b8200b00dc7465dc06dmr1019280ybb.28.1712875061486; 
 Thu, 11 Apr 2024 15:37:41 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:41 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Apurva Nandan <a-nandan@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 03/11] spi: cadence-quadspi: Enable DDR bit for DTR commands
Date: Thu, 11 Apr 2024 18:36:47 -0400
Message-ID: <20240411223709.573-4-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411223709.573-1-greg.malysa@timesys.com>
References: <20240411223709.573-1-greg.malysa@timesys.com>
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

The Cadence octal SPI IP read instruction register requires a bit to be
set to indicate if the read opcode is a compliant DDR read command.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 drivers/spi/cadence_qspi.h     | 1 +
 drivers/spi/cadence_qspi_apb.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 693474a287..72e92cc997 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -61,6 +61,7 @@
 #define CQSPI_REG_RD_INSTR                      0x04
 #define CQSPI_REG_RD_INSTR_OPCODE_LSB           0
 #define CQSPI_REG_RD_INSTR_TYPE_INSTR_LSB       8
+#define CQSPI_REG_RD_INSTR_DDR_EN_MASK          BIT(10)
 #define CQSPI_REG_RD_INSTR_TYPE_ADDR_LSB        12
 #define CQSPI_REG_RD_INSTR_TYPE_DATA_LSB        16
 #define CQSPI_REG_RD_INSTR_MODE_EN_LSB          20
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index fb90532217..34cacf1880 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -446,6 +446,7 @@ int cadence_qspi_apb_command_read_setup(struct cadence_spi_priv *priv,
 		return ret;
 
 	reg = cadence_qspi_calc_rdreg(priv);
+	reg |= op->cmd.dtr ? CQSPI_REG_RD_INSTR_DDR_EN_MASK : 0;
 	writel(reg, priv->regbase + CQSPI_REG_RD_INSTR);
 
 	return 0;
@@ -537,6 +538,7 @@ int cadence_qspi_apb_command_write_setup(struct cadence_spi_priv *priv,
 		return ret;
 
 	reg = cadence_qspi_calc_rdreg(priv);
+	reg |= op->cmd.dtr ? CQSPI_REG_RD_INSTR_DDR_EN_MASK : 0;
 	writel(reg, priv->regbase + CQSPI_REG_RD_INSTR);
 
 	return 0;
@@ -638,6 +640,7 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 		opcode = op->cmd.opcode;
 
 	rd_reg = opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
+	rd_reg |= op->cmd.dtr ? CQSPI_REG_RD_INSTR_DDR_EN_MASK : 0;
 	rd_reg |= cadence_qspi_calc_rdreg(priv);
 
 	writel(op->addr.val, priv->regbase + CQSPI_REG_INDIRECTRDSTARTADDR);
@@ -812,6 +815,7 @@ int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 	writel(reg, priv->regbase + CQSPI_REG_WR_INSTR);
 
 	reg = cadence_qspi_calc_rdreg(priv);
+	reg |= op->cmd.dtr ? CQSPI_REG_RD_INSTR_DDR_EN_MASK : 0;
 	writel(reg, priv->regbase + CQSPI_REG_RD_INSTR);
 
 	writel(op->addr.val, priv->regbase + CQSPI_REG_INDIRECTWRSTARTADDR);
-- 
2.43.2

