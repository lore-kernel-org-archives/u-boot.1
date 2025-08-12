Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F52C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 11:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40DC783322;
	Tue, 12 Aug 2025 13:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eCM9dPWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BE398327A; Tue, 12 Aug 2025 13:34:42 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528A283287
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 13:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459d44d286eso27410135e9.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754998480; x=1755603280; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SHPK8C1Dne6eLi8JndPd6Oma0hxw8GsrBN7lcFLux/I=;
 b=eCM9dPWFIEr0Zo0t1zf3Pdhbpnwm4o+L1dCois1SLHcHQtxeaUkTR32J5G4vTN01gf
 QP9sckvktjaZOuw453G+ZCRWNmxe/Y2CoNXN6+qCiTGdnUBuREY6UygdrvZIyDZYAh6B
 +1pxSvtHGAddyTEn7oM0Dme09oRJBRPfTSgwGyuHi1DFLORC+Xvni9Uz2kHwT0E9JA/+
 u/s26w6PpEEhfzjYqnFPvzrmsmZSQyqYXjU6KnMD1MJYzc3XXkPtZ1nWr2Y2IfDy8nZe
 VANyo1AVRx739fsl4QswiQxSXiAcDa+6nZRiS6WXsudrYxkQEVNYaEDDaUE/xgLLwMrC
 seCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754998480; x=1755603280;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHPK8C1Dne6eLi8JndPd6Oma0hxw8GsrBN7lcFLux/I=;
 b=S6CSRQotbGpzB+DdYdqN7gf15S9i0Btj9GEVu4Y9aqenTdkRx99IqFoRV/rVpGfg6F
 Hg+GYQmykRmPlLaZxX68K2XIwQmaDhz1Ie35n9ldMQIDqGoWHxyHyIkUcCdEkN/T/D06
 vjqVVY3tjGFIu61jja1WbhgNRhkrxC7zMDivj17ROa5Qk+Q0RO3agd8piyMUBWyBX515
 rm7jcc7D4BcqcHorPADGbZsJa++4IWj3ZwIIfzNgNPOuvM3dluVnqqqHpxVcJ+gsjnq0
 KW3dqCy6I0IK8R9w9uSlGZMczxy0wzmoHnein1fdy6ptcPi2yCr3VVOPWAJXKDvDpm6n
 md4Q==
X-Gm-Message-State: AOJu0YyQ5rfi6Xnh9OWhb/GT5lypTA8+94Q/IjWcwyaacV3iweZbLTo5
 pncSVyLZqBdW2Q1Q+IXhfFm/M5foOUkXhlz1gaNiq5nemAxjhcge9s+0DCdLxNMJ6qo=
X-Gm-Gg: ASbGncuJg7aKLSEWjgxyEIqdvt5PSAlrDyHXPwZxzWIhE5+7hq2NXHGIlM5v7jS8QPG
 7L6PzvCNPlG6kNLrKse+7tteFWIsfV1LQkEOP0EoADDdYmly769v0nplRSMS4mj0BHbC03CF7/r
 7TAnVjxv3iJcFnUxQF7T1cp3stGpqE24eH1qPBdKcsKw9fJlqYkiOnyBEyCvuw+KttrEs/GkImq
 6kWRZpnVhtCHrAqO47eMsJEWNVcAvqKyKDEvHdpLaDJ7PIB8aoQyQ/sw0B0Y9PxCf+kUquLGZff
 HyToZV6bZj4XwwtHMEysazlN2TzfnQOaWUTy7vQ4BH65AUrBHYI60HyHuuLrSh2XqA1UT9ez4fG
 FO9de602pCnnSPzbQZSfHl4bJ8CE01S9fHw0gEWrINq2NWa1BAho=
X-Google-Smtp-Source: AGHT+IEjP/kPPw9Lw+367MLXUBWf+O/UevZQc04xd/G9Vmi3RUOgnlyGpMfPG3Db3nZEj6A32Cy9Yw==
X-Received: by 2002:a05:6000:310f:b0:3b7:775d:e923 with SMTP id
 ffacd0b85a97d-3b91113c85emr2448076f8f.4.1754998479642; 
 Tue, 12 Aug 2025 04:34:39 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm44524027f8f.66.2025.08.12.04.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 04:34:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 12:34:38 +0100
Subject: [PATCH 1/2] spi: cadence_qspi: Off by 1 in test for timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-cadence_qspi-v1-1-0d693d810145@linaro.org>
References: <20250812-cadence_qspi-v1-0-0d693d810145@linaro.org>
In-Reply-To: <20250812-cadence_qspi-v1-0-0d693d810145@linaro.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

In cadence_qspi_apb_exec_flash_cmd the test for a timeout uses a
post-decrement on the variable retry which will result in a value of -1
after the loop exit, or it would if the variable were signed.
To fix this make retry a signed variable and test its value for being
equal to -1.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/spi/cadence_qspi_apb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 4696c09f754..0d4bc685f5d 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -354,7 +354,7 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 
 int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg)
 {
-	unsigned int retry = CQSPI_REG_RETRY;
+	int retry = CQSPI_REG_RETRY;
 
 	/* Write the CMDCTRL without start execution. */
 	writel(reg, reg_base + CQSPI_REG_CMDCTRL);
@@ -369,7 +369,7 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg)
 		udelay(1);
 	}
 
-	if (!retry) {
+	if (retry == -1) {
 		printf("QSPI: flash command execution timeout\n");
 		return -EIO;
 	}

-- 
2.39.5

