Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0D6C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63CC88227;
	Fri, 12 Apr 2024 00:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="DMtWHaiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B88B88227; Fri, 12 Apr 2024 00:37:50 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7073A88211
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dcd9e34430cso343224276.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875064; x=1713479864;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DM9XHh/qPuTHB5P1dE9Mw9suPfUvDU6T3YKOEUDAS/4=;
 b=DMtWHaiDorgD81UJbBHa4qAA2FdNXvMR1FelVgMHs9T5HBFF6nkOlTbFPYfOvYcQXI
 sNudH7NF0wyZjatsaXdY8KklC9PYfg0orGUvlzNu98HkcTxaP2S8182KIOgoP5Ea5Gku
 ucjjmpsaNVAc3QYAVdPnuQVoICQJS50mu3/IKF42beWe59EfSSeKFtHYpmIJmo3Kk7Iv
 CEqCeql7t+mDsCMsxbWeJcTdpej/n1DFZLhSVgprNToJwH/+fY0HYeaA8wnF46+wzs1C
 tRMh6ihlq54FEfXRrtm83yd9bPU+MmZfGc7t6sdJ1zyYwI+6Xguix3M2z7w/AzK7yNps
 bf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875064; x=1713479864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DM9XHh/qPuTHB5P1dE9Mw9suPfUvDU6T3YKOEUDAS/4=;
 b=PlfHAwxiB5gUH+ctMkAfLVWu9p0124T9BnNM4EAhtWkw6k+O/UhhHzx8J5t8Ww51G9
 aKvKWlzh02su2Xutt64B1bBNDBpJex1dfSVkc3aTaCZKZgRaK8pHhIqDJXofZ3p6LrXz
 LdEJLdQ4MMHspHAPJK1Ej3rXrwJ5iegod7XVOldwrNuF0wwFx+Q5aq9+dfWVOrO3ZrQP
 FurWlNTbt36iIMatOI7uwMEYa6kBJQp+Zou4zfwax6gnL5gOXtjN8GG+g9AazErzCZwV
 0Ux1DgsZvJ5k8qycrRYHllc5ZLeTyN1Hr5zCKEmEiw0a3pOs8lrsdWCSBL3LJ7cUk81r
 K9Ew==
X-Gm-Message-State: AOJu0YyvFZk+byU+XunqcVht0oVYLVqIDgvrObqL0tOkllmYW/NgtmV3
 6WmmoVaCsQQkXtrmQyk6mtyZwu5N6JJvgIG2A5f0EBd+sJ/qV3O9Fc5/VsGd92PDtu1tm5RE9ob
 MrA==
X-Google-Smtp-Source: AGHT+IHBvwGDkF1DLI9OmlqqBG1A+qPysmf+pMkLcYX2QjkmZaSOD1UMSM8Y/kXccHS8d1wwt1iX8Q==
X-Received: by 2002:a25:df91:0:b0:dcc:dbb8:ba73 with SMTP id
 w139-20020a25df91000000b00dccdbb8ba73mr836934ybg.9.1712875064133; 
 Thu, 11 Apr 2024 15:37:44 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:43 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Apurva Nandan <a-nandan@ti.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Johan Jonker <jbx6244@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 07/11] spi: cadence-quadspi: Remove redundant DTR state
Date: Thu, 11 Apr 2024 18:36:51 -0400
Message-ID: <20240411223709.573-8-greg.malysa@timesys.com>
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

cadence_spi_mem_supports_op() already checks that every memory operation
either has all DTR booleans set or cleared. Thus, there is no need to
store a cached dtr value. The command DTR state can be used since it is
not optional like the other fields.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 drivers/spi/cadence_qspi.c     |  6 ++++++
 drivers/spi/cadence_qspi.h     |  1 -
 drivers/spi/cadence_qspi_apb.c | 27 ++++++++-------------------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index f4593c47b8..a2644d9e11 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -362,6 +362,12 @@ static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
 	bool all_true, all_false;
 
 	/*
+	 * For an op to be DTR, cmd phase along with every other non-empty
+	 * phase should have dtr field set to 1. If an op phase has zero
+	 * nbytes, ignore its dtr field; otherwise, check its dtr field.
+	 * Also, dummy checks not performed here Since supports_op()
+	 * already checks that all or none of the fields are DTR.
+	 *
 	 * op->dummy.dtr is required for converting nbytes into ncycles.
 	 * Also, don't check the dtr field of the op phase having zero nbytes.
 	 */
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 355919cb23..5704f5a3f6 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -265,7 +265,6 @@ struct cadence_spi_priv {
 	u8		inst_width;
 	u8		addr_width;
 	u8		data_width;
-	bool		dtr;
 };
 
 /* Functions call declaration */
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index d347cb8d47..2600370f85 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -120,17 +120,6 @@ static int cadence_qspi_set_protocol(struct cadence_spi_priv *priv,
 {
 	int ret;
 
-	/*
-	 * For an op to be DTR, cmd phase along with every other non-empty
-	 * phase should have dtr field set to 1. If an op phase has zero
-	 * nbytes, ignore its dtr field; otherwise, check its dtr field.
-	 * Also, dummy checks not performed here Since supports_op()
-	 * already checks that all or none of the fields are DTR.
-	 */
-	priv->dtr = op->cmd.dtr &&
-		    (!op->addr.nbytes || op->addr.dtr) &&
-		    (!op->data.nbytes || op->data.dtr);
-
 	ret = cadence_qspi_buswidth_to_inst_type(op->cmd.buswidth);
 	if (ret < 0)
 		return ret;
@@ -449,7 +438,7 @@ int cadence_qspi_apb_command_read_setup(struct cadence_spi_priv *priv,
 		return ret;
 
 	ret = cadence_qspi_enable_dtr(priv, op, CQSPI_REG_OP_EXT_STIG_LSB,
-				      priv->dtr);
+				      op->cmd.dtr);
 	if (ret)
 		return ret;
 
@@ -484,13 +473,13 @@ int cadence_qspi_apb_command_read(struct cadence_spi_priv *priv,
 		return log_msg_ret("QSPI: Invalid command length", -EINVAL);
 	}
 
-	if (opcode == CMD_4BYTE_OCTAL_READ && !priv->dtr)
+	if (opcode == CMD_4BYTE_OCTAL_READ && !op->cmd.dtr)
 		opcode = CMD_4BYTE_FAST_READ;
 
 	reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 
 	/* Set up dummy cycles. */
-	dummy_clk = cadence_qspi_calc_dummy(op, priv->dtr);
+	dummy_clk = cadence_qspi_calc_dummy(op, op->cmd.dtr);
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -ENOTSUPP;
 
@@ -547,7 +536,7 @@ int cadence_qspi_apb_command_write_setup(struct cadence_spi_priv *priv,
 		return ret;
 
 	ret = cadence_qspi_enable_dtr(priv, op, CQSPI_REG_OP_EXT_STIG_LSB,
-				      priv->dtr);
+				      op->cmd.dtr);
 	if (ret)
 		return ret;
 
@@ -597,7 +586,7 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 	}
 
 	/* Set up dummy cycles. */
-	dummy_clk = cadence_qspi_calc_dummy(op, priv->dtr);
+	dummy_clk = cadence_qspi_calc_dummy(op, op->cmd.dtr);
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
@@ -645,7 +634,7 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 		return ret;
 
 	ret = cadence_qspi_enable_dtr(priv, op, CQSPI_REG_OP_EXT_READ_LSB,
-				      priv->dtr);
+				      op->cmd.dtr);
 	if (ret)
 		return ret;
 
@@ -673,7 +662,7 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 
 	if (dummy_bytes) {
 		/* Convert to clock cycles. */
-		dummy_clk = cadence_qspi_calc_dummy(op, priv->dtr);
+		dummy_clk = cadence_qspi_calc_dummy(op, op->cmd.dtr);
 
 		if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 			return -ENOTSUPP;
@@ -821,7 +810,7 @@ int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 		return ret;
 
 	ret = cadence_qspi_enable_dtr(priv, op, CQSPI_REG_OP_EXT_WRITE_LSB,
-				      priv->dtr);
+				      op->cmd.dtr);
 	if (ret)
 		return ret;
 
-- 
2.43.2

