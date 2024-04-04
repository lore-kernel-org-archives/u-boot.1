Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34611CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59086883C8;
	Thu,  4 Apr 2024 10:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NcPBBD9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F68883D6; Thu,  4 Apr 2024 10:14:04 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F03883C6
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-516ced2f94cso56611e87.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712218441; x=1712823241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8Es4I6W/ckZvI4pjafaxAdhh6VCVQz0Q/4qVZhLC9Y=;
 b=NcPBBD9rHGb+dCYhNFE0DSRSSOaCv9DDN0i3r7Pb5+BKcsS7PMFH/CXRYiyz/1DUXE
 GGO2lR+W5XURJz2A2uQSewrCfcOp++hoqYHmIGcCQbXU4B5obCW1z1sN/PlRrbIdS5BC
 Vm3YP2V3df+3rs+GwuxFlNRMo+Zr2izuftuhlxekbveD9mdxQUKpfkqMUFi842ltuD7n
 JSIQPmjTx3Q2YMtXuDICkjUFxWrOhLpU5LEIG7i6ymBMXK3JZtCn7Sk6SJDTVH/If92x
 v3dSnP49z9pCKjUiEuAQq2+Q6di0/OZ1/ZX/ni6+TPV0vx+6kAXAEj/mB6l+0qz4Ofl9
 XZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712218441; x=1712823241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8Es4I6W/ckZvI4pjafaxAdhh6VCVQz0Q/4qVZhLC9Y=;
 b=aOgpFmnEYGCzW55FOuYlrFxql6Y2H51xFhs6hUgHyGy8kwOli8xgDjBEqpOKdATTCO
 gR2RoQLNMopwIYtrF53lobiSKR2ihZZb8HFN/NJfvE2+uzrbP15GeELYaA0uwmw9BwM1
 UKbiaLnXq2V7oPYQ0hsXLeaHr2Au0s4UGEb2xzUOi34ipU1C1AITEmleytbs/RZ7fVSd
 DicuF68FwcsC8TAeAnGlKbMMTuQME1NqzSKEN2Jj+YEhetTNCTzL/w6Ie8SRS8vJTa6S
 Vl6+H/Lsuu4BkdgvDJvv1c63SIWFSH5Zw1dNKpgzAG1sayjG9jTR1uqhkC7e3Kmk7Xzh
 QLEA==
X-Gm-Message-State: AOJu0YzD+gsw5QyrzPA/cwKMV3oTzkjKovII40/YNH21BC2hkTKv3Z/H
 F7R3aEOKuTit1rL+E0XlQlHzZ0YYQ3JVxavTOticEmN5zymDyQ15SNmKV8l6tSPGaQ==
X-Google-Smtp-Source: AGHT+IForpt6P+c9woi/BoF9zjnK5BVwdVOab2aNZ927ollAlc+ZaVdxmczRwqTSQ7B710gR9UiPnw==
X-Received: by 2002:ac2:4c85:0:b0:516:c7e0:6493 with SMTP id
 d5-20020ac24c85000000b00516c7e06493mr1023626lfl.6.1712218440516; 
 Thu, 04 Apr 2024 01:14:00 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 z17-20020a056512309100b00515d53b1fc2sm1582577lfd.62.2024.04.04.01.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 01:13:59 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/5] tee: optee: fix description in Kconfig
Date: Thu,  4 Apr 2024 10:13:48 +0200
Message-Id: <20240404081352.3224643-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
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

Fix OPTEE_TA_AVB symbol description in Kconfig:
s/"write"rb"/"write_rb"/g

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

(no changes since v2)

Changes in v2:
- Applied R-b tags

 drivers/tee/optee/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 9dc65b0501e..db0bcfa6f15 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -19,7 +19,7 @@ config OPTEE_TA_AVB
 	default y
 	help
 	  Enables support for the AVB Trusted Application (TA) in OP-TEE.
-	  The TA can support the "avb" subcommands "read_rb", "write"rb"
+	  The TA can support the "avb" subcommands "read_rb", "write_rb"
 	  and "is_unlocked".
 
 config OPTEE_TA_RPC_TEST
-- 
2.34.1

