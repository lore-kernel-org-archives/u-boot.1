Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B266C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3713088235;
	Fri, 12 Apr 2024 00:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="IXMUZQ2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8357D881FD; Fri, 12 Apr 2024 00:37:46 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C1688202
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6181d032bf9so2868087b3.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875062; x=1713479862;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZGOt78qiZteGmXNos080gB0AWFgnQINCSKqCGF7BkA=;
 b=IXMUZQ2Pv8+BDNpqQUGjnA7qNZfUulZWyXuSINfpDxauMGKDCzUEy5PAy5psEx5/GL
 VFa5GRSCxVEy/DOtSEN8wxFG5YAIsszybGWRFxGqdaOfKLl5JPq999Ld0ZDQ7KyxXnmG
 gxpidNydb/snn38xTiYr0HrGnEwZz5iFGrxt67vo+qCIzwlGWcJk8VV17lj7z7MSNwW+
 m1CfCJnmnIgIjFmsYgObwqJDvRrf+KDJV82n5EDIOJAc/EiCGV5JHzkIWEWOGH8XmDO+
 IWpEEuicGdLPPQoWrtAFVzW60P1Gr6FplnBmIKCw1ADEr1UqePeQlD7Zr0jioBSLGInL
 1g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875062; x=1713479862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZGOt78qiZteGmXNos080gB0AWFgnQINCSKqCGF7BkA=;
 b=o3dRzpWc/B7cpx1f+mqB+Bu1N97WWK/DCRRhDMxHiCkWdJ6TjxNW4Eh0eF/VcewEpl
 ge5zgFTxD6V1d2xkxnsW4yGNhVHbR4Ml+rW60mTDg5bQYDasyX8JXSRnNZrcl9xP8MMX
 kRdFoYeMDZko992672StfKSJMmsPU8KTYn/RbH/5QLJDuSj/ZAAUga70qm5kNyQ5VQzQ
 zKgktaTYYiIHAQsfHrK1XWFg/qxMBbLX20OzpMeYREh+/JCwvdyhamWxyONxiBveiX3V
 cOg81ryUlWQjogEQSBEBpwcrXWw/w7iYVmo3XWi735T2CCtCbC6fkSJrcaC6qr6DHGmq
 vzdQ==
X-Gm-Message-State: AOJu0Yyj3GhYRaP/EbT51l042l1Ym9PlYhMCmbq6YvWp5cJtN4pSjta4
 /a0g4rgVMO7YndzYaHbadB8reWpEAdxNnnbaVXpijePFN8VnxHfBL5CG/k/rFs0lJoKPfun4VV3
 zzA==
X-Google-Smtp-Source: AGHT+IHRMu8bDYH5mSUp+uY/hIlXrMDxH7r+k+0NP4sdjdURiYxCBufwUNdpZGSzelSr0qhKAds0eg==
X-Received: by 2002:a25:8106:0:b0:dc6:de64:f74 with SMTP id
 o6-20020a258106000000b00dc6de640f74mr875406ybk.9.1712875062308; 
 Thu, 11 Apr 2024 15:37:42 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.41
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
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/11] spi: cadence-quadspi: enable opcode extension based on
 command length
Date: Thu, 11 Apr 2024 18:36:48 -0400
Message-ID: <20240411223709.573-5-greg.malysa@timesys.com>
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

Some flash chips use dual opcodes in other modes. For example, the
Macronix MX66 requires dual opcodes for STR octal operation. Thus,
enable opcode extension based on the length of the command instead
of the DTR mode of the controller.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 drivers/spi/cadence_qspi_apb.c | 66 +++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 34cacf1880..eb9f4ed63d 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -412,19 +412,27 @@ static int cadence_qspi_enable_dtr(struct cadence_spi_priv *priv,
 
 	reg = readl(priv->regbase + CQSPI_REG_CONFIG);
 
-	if (enable) {
-		reg |= CQSPI_REG_CONFIG_DTR_PROTO;
+	switch (op->cmd.nbytes) {
+	case 1:
+		reg &= ~CQSPI_REG_CONFIG_DUAL_OPCODE;
+		break;
+	case 2:
 		reg |= CQSPI_REG_CONFIG_DUAL_OPCODE;
 
 		/* Set up command opcode extension. */
 		ret = cadence_qspi_setup_opcode_ext(priv, op, shift);
 		if (ret)
 			return ret;
-	} else {
-		reg &= ~CQSPI_REG_CONFIG_DTR_PROTO;
-		reg &= ~CQSPI_REG_CONFIG_DUAL_OPCODE;
+		break;
+	default:
+		return log_msg_ret("QSPI: Invalid command length", -EINVAL);
 	}
 
+	if (enable)
+		reg |= CQSPI_REG_CONFIG_DTR_PROTO;
+	else
+		reg &= ~CQSPI_REG_CONFIG_DTR_PROTO;
+
 	writel(reg, priv->regbase + CQSPI_REG_CONFIG);
 
 	return 0;
@@ -465,10 +473,16 @@ int cadence_qspi_apb_command_read(struct cadence_spi_priv *priv,
 	unsigned int dummy_clk;
 	u8 opcode;
 
-	if (priv->dtr)
-		opcode = op->cmd.opcode >> 8;
-	else
+	switch (op->cmd.nbytes) {
+	case 1:
 		opcode = op->cmd.opcode;
+		break;
+	case 2:
+		opcode = op->cmd.opcode >> 8;
+		break;
+	default:
+		return log_msg_ret("QSPI: Invalid command length", -EINVAL);
+	}
 
 	if (opcode == CMD_4BYTE_OCTAL_READ && !priv->dtr)
 		opcode = CMD_4BYTE_FAST_READ;
@@ -557,10 +571,16 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 	void *reg_base = priv->regbase;
 	u8 opcode;
 
-	if (priv->dtr)
-		opcode = op->cmd.opcode >> 8;
-	else
+	switch (op->cmd.nbytes) {
+	case 1:
 		opcode = op->cmd.opcode;
+		break;
+	case 2:
+		opcode = op->cmd.opcode >> 8;
+		break;
+	default:
+		return log_msg_ret("QSPI: Invalid command length", -EINVAL);
+	}
 
 	reg |= opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 
@@ -634,10 +654,16 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 	       priv->regbase + CQSPI_REG_INDIRECTTRIGGER);
 
 	/* Configure the opcode */
-	if (priv->dtr)
-		opcode = op->cmd.opcode >> 8;
-	else
+	switch (op->cmd.nbytes) {
+	case 1:
 		opcode = op->cmd.opcode;
+		break;
+	case 2:
+		opcode = op->cmd.opcode >> 8;
+		break;
+	default:
+		return log_msg_ret("QSPI: Invalid command length", -EINVAL);
+	}
 
 	rd_reg = opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
 	rd_reg |= op->cmd.dtr ? CQSPI_REG_RD_INSTR_DDR_EN_MASK : 0;
@@ -804,10 +830,16 @@ int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 	       priv->regbase + CQSPI_REG_INDIRECTTRIGGER);
 
 	/* Configure the opcode */
-	if (priv->dtr)
-		opcode = op->cmd.opcode >> 8;
-	else
+	switch (op->cmd.nbytes) {
+	case 1:
 		opcode = op->cmd.opcode;
+		break;
+	case 2:
+		opcode = op->cmd.opcode >> 8;
+		break;
+	default:
+		return log_msg_ret("QSPI: Invalid command length", -EINVAL);
+	}
 
 	reg = opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
 	reg |= priv->data_width << CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
-- 
2.43.2

