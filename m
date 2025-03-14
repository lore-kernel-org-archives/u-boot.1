Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C748C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A88E5810F4;
	Fri, 14 Mar 2025 06:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xgu0AmwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64A9D81B52; Fri, 14 Mar 2025 06:54:53 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F2C38198F
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 06:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2239aa5da08so34717095ad.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 22:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741931690; x=1742536490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6SdfGhurtLqpqR1f1sI53XKZhZO+KV7CuTxCDtgOTk=;
 b=Xgu0AmwMeriVPcsQntZS1wKsE41O7sqi1sBREIO6cfhalE4wR+KiP9sLapj05qSYAH
 RObFoyBzcj1hXYNq0lImFu5EFmhqsBO90HKnwLuLVmtPGXum4uJMIadcxM0SXntK47Ey
 tCupEk27CDN1JyxsBiSBjMAM8uaO9j42SA8YVdmkAwYGPYaHvAefqd+RvIfBcxVoDTy+
 LJa+4+Aw5GytARP5uBVLS9Q5eeCzLA3B6uy8jd5wN5W+CzjLyCbW0t+gjmhFir1fkCBD
 sklwJU4sBZlxG7RJv/RWP9+VZEvn36P/8g/1lLf8QVsJj3tQPNB2YPtkapovYSNFBcUv
 RBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741931690; x=1742536490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6SdfGhurtLqpqR1f1sI53XKZhZO+KV7CuTxCDtgOTk=;
 b=J2kHLQTjIQesdVsKOkgyOdma8I5M+uxVdcmeuwD/Tfqvrqe9uANSFasSA5cTwxCoH9
 V1k3AOoBY+z6xbT0r3fz7K1coAtUIxjaAqk9IoU2scjsItfz2z8PUSZBwkkhvoy8gPrT
 uVtt7KFP1KtsF0+YMVKUY/Ko105szYaqu2c0Zo1hn7FdfdwSsDc58BtWLb9cE0dolD04
 n2oAtiIWBmYA3/SVfHSW7qzxvnxnhnQbJO8dcFQNQvnRwPUzw3zyiu/tuHykGlAy+8wD
 k8AuDLT3NSruT5oLeAyGETpdod92Qcsfe4f5PAOjqqS5ZkaYUNvH4loO0jqqWsDi7mO1
 lDYw==
X-Gm-Message-State: AOJu0YyH76BL3GvxzaCHXmkbszZb7tGxuPb0THOTpYmygr5p66Kp01Oq
 qtDXEQEIHKFBk3h6zvxqvVcZYvE0oDE9g6/T18nDokeNSUgcV2z5fe2x8s0z
X-Gm-Gg: ASbGnctunaRMq2d4RECS5n0ZmrFec7+Y+/KZNhnPYbgiZLEf6rwT/3PUjXxUSVCIMYD
 cJsUknT/ODnh68sAg8e5QbstJGH/JI0FMTS4vwObiLDBdPCJC93ixNERo/AiDKnkTON5Cw223My
 hNnIOb1Vcc0nWhJowibuoSC82ETR2iOHtuCHAusAkxTmdJSzL+2xbLNluW3PQymSi9aVhNxTfTl
 O2baPmLkAIEHEiNIUO+x8EJQMDAziQ/K6idgerWaOdHJ5ObOB6Njuya33pu8jrbK3Lsw3L2h68F
 ytr1Sn5bL0QX0QiQBg0rN9JlyMAcNZitb89fqewjA2eLVBtgOkXL03pkOQ/BhzHY8R0yeteBHL2
 cBRBZ0azr4Xhw7/eVFpR8UuINnlLp4T13NaY=
X-Google-Smtp-Source: AGHT+IEV/SMlv0keTpPDNomlhFS0WhiCuFK79On0Ykl2ZYfDHeSaiooAWAcXWdqTIi9sigIfrC5srA==
X-Received: by 2002:a17:903:228d:b0:21f:61a9:be7d with SMTP id
 d9443c01a7336-225e0b195fbmr19650505ad.49.1741931689669; 
 Thu, 13 Mar 2025 22:54:49 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-234-101.mse.spmode.ne.jp.
 [49.98.234.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a8574sm22846505ad.86.2025.03.13.22.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 22:54:49 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, ashok.reddy.soma@amd.com,
 venkatesh.abbarapu@amd.com, Hiroyuki.Saito2@infineon.com,
 Shinsuke.Okada@infineon.com, Daisuke.Nakata@infineon.com,
 tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 1/2] spi: zynqmp_gqspi: Make WR_ANY_REG opcode not use striped
 access
Date: Fri, 14 Mar 2025 14:53:36 +0900
Message-Id: <7c0cb88d00bc27550887607ad3d8ce0779a4683c.1741930961.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741930961.git.Takahiro.Kuwano@infineon.com>
References: <cover.1741930961.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

SPINOR_OP_WR_ANY_REG (0x71) opcode must not be performed in striped
access mode to write the same register value to two Flash devices in
parallel memory configuration. The opcde 0x71 is also used as Read
Configuration Register-2 (SPINOR_OP_RD_CR2). To distiguish it, data
direction needs to be checked.

The following commit is related to this patch.
217b0a28b6d ("spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver")

Tested-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com> 
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/spi/zynqmp_gqspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index 2a095d0c58e..f47c3058942 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -841,6 +841,8 @@ static bool zynqmp_qspi_update_stripe(const struct spi_mem_op *op)
 		return false;
 	case SPINOR_OP_WRSR2:
 		return op->addr.nbytes != 0;
+	case SPINOR_OP_WR_ANY_REG:
+		return op->data.dir != SPI_MEM_DATA_OUT;
 	default:
 		return true;
 	}
-- 
2.34.1

