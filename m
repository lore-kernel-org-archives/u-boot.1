Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1104EC87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 10:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A79D83824;
	Thu, 31 Jul 2025 12:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jx16kf3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 096858349B; Thu, 31 Jul 2025 12:51:25 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D896836D2
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 12:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so627335f8f.1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753959082; x=1754563882; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=23Gg6lHlFkvwEStsjh6qcg4ssY1f/pu0ecwkJSZ2rWM=;
 b=jx16kf3b4OEmcXz/NXLwivRj5kTTlEqz4qjaj9XvKHbTbDhynbFjMBsetxtZz0etYF
 Rea5BuknQQW2oIOCY0biz3TVxbKgSnflyf0gqznS9QT1cL8N98i8kjm+FOi/p9iISf6Y
 CCEs/EmyPXWiX7agO9js5cROQ3K/Z0yXqFbnjqZCEZDALNGu/UxFpuAKfhAVE6cpMtio
 6+rCrDRnlURmQ7qdC9OiiCPnoZhXXgVpJoBh5jKePfhQDdgZ9FrLI1hnbvws7qD00VgG
 DMErUwCg+jevWp4ypZPSKrdOmYvdJ0SoRFYGPCM50s9YzRDbOhEuFuGY4nrbIJaHIV//
 pNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753959082; x=1754563882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23Gg6lHlFkvwEStsjh6qcg4ssY1f/pu0ecwkJSZ2rWM=;
 b=lpmCBshBa83SI/RumwPz9bvv2RFP+uQejOoHvDzbhNzWuvWAepjlUpoI4oBN8s/IC9
 E+2n0vYiESp2xXlR7e2Y5T34eOXIbf79jZLPfRSNJvQeA3J6jRm8dQTgH/qNAolkIM3t
 CYuJ/vq/2aE/uVdWKDVJ9ABOYhq2Jvax0uuMHLYYPDxsMcG72sBVDd8bE/SgQEqdv6bX
 c1QmNeA7wtJeL6FeAWGmm8vxxrBg2KbM6whFJiXrCnQUWsUmmY2DBvQ6HYAfX1HS0vzb
 rDxM4iUgTX3aCXYUnNmcJgH7LYWRTrkG6JxcS3QmFg2OqURXTceTJBO/N/U0cPu9d1WV
 w9LQ==
X-Gm-Message-State: AOJu0Yxc7kKEC6McRSk5ZO2j4YYJQl2AvBW6s7wxFFVBaYQRFQH6uiRL
 pTPxYB4zcnGaAIY2Xqm30ZEQAXoCqEX9bJRisHwDMkkWdU6X15Ot5GrUBhJgMZbJ6YsulMUlA/W
 +ZLRk
X-Gm-Gg: ASbGncuX7PB4LFtCmPdApWqiy8NMDyRrXzo6Ns1F39raIOZWpxco7Qmgr3FAxXPXq5m
 Fivzumyuj/EOlYdkfXdIMM0XMwtW5JNQqOoxQQm2Bu5afg64M/AR7F/HKwWGuSw0VzhjLJQAPDu
 KT8t99nFqTNwpzeHCZ6qjLGCxJd91Hnbu3bh+AgIzPjC2VJ5IKc/CSfrVXm/e1IV9FNazmIShjX
 X1e7TxSrwfF3xJds4gbPi6bIByGXuoYR7JHnHZ0me+uA+LdiKev78tvb5C9g0cyaX+NMX3LcZ7w
 EAdsGZQQFRrqjhPzFMoU3t+ZwE22rFvISjjQvI0c1amnT2/XifJBH4crVyOIADLYLYgEt/jZclL
 QFgFE3V2fIkNpyBmjbVn+0ypAkuH1Qvd6QBozHv903ldaMdCyYQ==
X-Google-Smtp-Source: AGHT+IH+CiZ4a/tcFuNgOvxopuLTjM9/dkJdL99OF0s4NcuLzM3v5ossq1oixg+/Xatq+MbjW78P7Q==
X-Received: by 2002:a05:6000:2510:b0:3b7:97c8:da97 with SMTP id
 ffacd0b85a97d-3b797c8dfdemr3417101f8f.43.1753959082448; 
 Thu, 31 Jul 2025 03:51:22 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:14a5:dbc6:afe:7138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45895377708sm58900755e9.8.2025.07.31.03.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 03:51:22 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 31 Jul 2025 11:51:21 +0100
Subject: [PATCH 1/2] mmc: octeontx_hsmmc: Need parens in expression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-octeontx_hsmmc-v1-1-440c5f963e09@linaro.org>
References: <20250731-octeontx_hsmmc-v1-0-440c5f963e09@linaro.org>
In-Reply-To: <20250731-octeontx_hsmmc-v1-0-440c5f963e09@linaro.org>
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

The check for no response expected in octeontx_mmc_send_cmd needs parens
adding for proper interpretation.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/octeontx_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/octeontx_hsmmc.c b/drivers/mmc/octeontx_hsmmc.c
index 3b5e1221732..ffc8d4c7874 100644
--- a/drivers/mmc/octeontx_hsmmc.c
+++ b/drivers/mmc/octeontx_hsmmc.c
@@ -1545,7 +1545,7 @@ static int octeontx_mmc_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 
 	slot->is_acmd = (cmd->cmdidx == MMC_CMD_APP_CMD);
 
-	if (!cmd->resp_type & MMC_RSP_PRESENT)
+	if (!(cmd->resp_type & MMC_RSP_PRESENT))
 		debug("  Response type: 0x%x, no response expected\n",
 		      cmd->resp_type);
 	/* Get the response if present */

-- 
2.39.5

