Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4EAC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E258821D;
	Fri, 12 Apr 2024 00:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="MMpFPVeL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A82B8821D; Fri, 12 Apr 2024 00:37:46 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 302AE88203
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dc23bf7e5aaso351789276.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875063; x=1713479863;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNxj6UVPinaepYnUbjkM2PEvKLXZlIWzfOwKwE/yf38=;
 b=MMpFPVeLU7I7/hMB1eUQzLpIJCtBDqugDxFE2OU/tiwdCdR0dYJuBvm+peVyXQKZg8
 F0r6pTHGkr9CITLjI1t+b14KEbOf6NyfboF8Jsk7Blvxjc427iLQjAhvzQYQVIZ1BbjG
 LCH1G5AibPv+GyfvrNt5OWt/c5ocQiXDeWvFZ6jZmGqtmzt6OGeu2FVxBQ80JIQcB5dl
 I0o7t3e0MkL0gv1EMiVLQar3DMhIpaeysxAqYPKh7S/GknL2NcORu9AhDpVbZxyQQFF8
 sUZk6t9Mkl+yq6Xz/toUeXV3ixJRZf2Lt/KkPlo2RW8GvHJ4ISBAzWJg2xZD6D7Uk7sT
 wEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875063; x=1713479863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNxj6UVPinaepYnUbjkM2PEvKLXZlIWzfOwKwE/yf38=;
 b=nELv6Bbp0G+npmewLpJiqQSVjN0koRQKi6buL9RxPD7L2dslFHkfQMPJ5kvMcx+X80
 E3AnAu51p10hA3pVt6jhn2bYE3jCSnl9+C447qRYzQ/+sWbZ+kB/kL0w9SncQEMLWal/
 aTRSQTCF5Yt7EA/WAJZ98iCOjRATq0bgVjbRPMFwiuFPnpprGETDjqJ+7iwSx/ADtrbT
 NZ7NM7AwSTRwiiyKnncNGDH4mpwcgvx7/75ePDi2NI3ihEWNf9ddIgpMScO4BssAlhzW
 gpk6A7xhecCdAXuQXmcdNj+pWFOCWtGi4PGK/QLUbynD/BZb37HTXVB8pk8VsADIbZ2U
 ENww==
X-Gm-Message-State: AOJu0Yxs58pQYHCgf1oUoW2KKPrNKW9yFSiveqXH+SFkGWmY6ufpSxAP
 ChSUmOWlPtJikYru43wvZCoyV8YkEpdhN0vltI3ZT8aCszwAfAOvTkEOiDkid2P18C8ZMFwE99Z
 O2g==
X-Google-Smtp-Source: AGHT+IFTVzsw+3G+J1IhpVmx+xJH0M3eKGZUP3W2XVdEMcHYBa3KBCcUbS9Ve4xLtNlkWpbbncNrfA==
X-Received: by 2002:a25:b204:0:b0:dcc:5a73:1cad with SMTP id
 i4-20020a25b204000000b00dcc5a731cadmr873283ybj.42.1712875062959; 
 Thu, 11 Apr 2024 15:37:42 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:42 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Apurva Nandan <a-nandan@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 05/11] spi: cadence-quadspi: disable automatic write enable
Date: Thu, 11 Apr 2024 18:36:49 -0400
Message-ID: <20240411223709.573-6-greg.malysa@timesys.com>
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

The spi-nor subsystem issues the write enable command manually. So
this automatic feature sends duplicate commands and also introduces
the possibility of erroneous writes.

Disable the automatic write enable feature by default.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 drivers/spi/cadence_qspi.h     | 1 +
 drivers/spi/cadence_qspi_apb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 72e92cc997..355919cb23 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -73,6 +73,7 @@
 
 #define CQSPI_REG_WR_INSTR                      0x08
 #define CQSPI_REG_WR_INSTR_OPCODE_LSB           0
+#define CQSPI_REG_WR_INSTR_WELDIS_MASK		BIT(8)
 #define CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
 #define CQSPI_REG_WR_INSTR_TYPE_DATA_LSB	16
 
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index eb9f4ed63d..176cff5338 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -842,6 +842,7 @@ int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 	}
 
 	reg = opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
+	reg |= CQSPI_REG_WR_INSTR_WELDIS_MASK;
 	reg |= priv->data_width << CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
 	reg |= priv->addr_width << CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
 	writel(reg, priv->regbase + CQSPI_REG_WR_INSTR);
-- 
2.43.2

