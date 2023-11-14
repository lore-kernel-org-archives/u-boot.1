Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00495C4167B
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 13:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394FC8747E;
	Tue, 14 Nov 2023 14:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dn1Wl1zm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89B3871E4; Tue, 14 Nov 2023 14:48:52 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F29387215
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso44006395e9.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699969730; x=1700574530; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pcPpqjCyVm/6ofdhTTiOBgtbsnh3mMlC3FejEkmFNLk=;
 b=dn1Wl1zmoxuaDSRN4Hd3tiEJ/bEltJlEzIiMJ3/0ZQEEj6TaKSbGEugr0h7EXe6fCe
 TSfiF5NrqNOLzwgbltKKA3jHE9XurXBncMY+gPwKpvPOwqE8rAfnflfykqyK38uthrKX
 McvVW9FZQpFRKNccF388jIE2E8AkcTc6PQJEe4icODOygm6Uw6pOBeYSrOBrLi+hYHS0
 iDrx8z8hICm5X2rwy1Oo55eLXuE1tX/Ir+E9utitTxBJQz2boFi+FjUrelcA52pMJSME
 gfAxTphowq3++fz7QrFjrVgGdhUmSPEQhATHAPeeRSsuoy9xi3KD660p8TRgZLZAhhgB
 Kbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699969730; x=1700574530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcPpqjCyVm/6ofdhTTiOBgtbsnh3mMlC3FejEkmFNLk=;
 b=ZwmjKcgIGi9Imk+qMv+aFSF9N6XLmTDSNV5byllSQlOG5k9yEO+9LlxMVxG46TjwN+
 UzcupxGUwsqJMDvpAYyCiIFEerp92z6UlPXISKoPeEU2O1jUAzTZ/Ek5lWiycN3dvaTL
 XpKND+s78Nb8Dk5hmgboXDIGjYy6IxAZM5wcPIx7o4NnLqpW4iQDu014Z5+DTYIQ2Ls1
 AEM7odHcNrynP7xKRQ0iwhOMNCLG7kYxYI2UnKgxWUdqvl3rfsfAMlj600JUdyRvUCVK
 bNxQGt7Tgq9fkgKe34X9xW0a8y6QZz1dVR7JKSc/OADQ3oA+BzbFvL0AWd+8TTHrMJln
 NT0w==
X-Gm-Message-State: AOJu0YwyPE8y/yEPLQeZCjGCkrgQuWyvXOAy0td+FQjmcCV1bY858Il3
 6BytuZWCCAqbZ37WfXeUixxwjg==
X-Google-Smtp-Source: AGHT+IEESsQLBh3/vcNClRhkOBiFllVcHcSM/C3t9nq8Lyf+4WEUzEsU8TnIYc+lYjXvlxLEaLiSig==
X-Received: by 2002:a05:600c:5247:b0:405:39c1:a98b with SMTP id
 fc7-20020a05600c524700b0040539c1a98bmr7567467wmb.20.1699969730577; 
 Tue, 14 Nov 2023 05:48:50 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a5d4b4a000000b003313426f136sm7804220wrs.39.2023.11.14.05.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 05:48:50 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 13:48:47 +0000
Subject: [PATCH v3 1/5] gpio: qcom_pmic: fix silent dev_read_addr downcast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-qcom-dt-compat-v3-1-88a92f8f00ba@linaro.org>
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
In-Reply-To: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=L/Hg6krN7n0rquWuC6IguNE2GC8qLGvDuF5QKrLiC1o=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgqgNytb5LBf4ePLMrTHFBiNz8r1aXS+ujxXXucGvPU
 OoM3tLaUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYSHc7IsKClzsyzOCdUuboj
 UfFeRN+R9x/efMue4VTpznX9ItOuAIZ/9s/f8i7e9zLW1kTi/Stj1q9nFvlacRzZ0HExckXytMJ
 oRQA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

priv->pid is uint32_t, but dev_read_addr() returns a uint64_t on arm64,
with the upper bits being used for error codes. Do error checking before
downcasting to u32 to prevent errors being silently ignored.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 65feb453ebc3..e5841f502953 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -221,11 +221,14 @@ static int qcom_gpio_probe(struct udevice *dev)
 {
 	struct qcom_gpio_bank *priv = dev_get_priv(dev);
 	int reg;
+	u64 pid;
 
-	priv->pid = dev_read_addr(dev);
-	if (priv->pid == FDT_ADDR_T_NONE)
+	pid = dev_read_addr(dev);
+	if (pid == FDT_ADDR_T_NONE)
 		return log_msg_ret("bad address", -EINVAL);
 
+	priv->pid = pid;
+
 	/* Do a sanity check */
 	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
 	if (reg != REG_TYPE_VAL)
@@ -328,11 +331,14 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 {
 	struct qcom_gpio_bank *priv = dev_get_priv(dev);
 	int reg;
+	u64 pid;
 
-	priv->pid = dev_read_addr(dev);
-	if (priv->pid == FDT_ADDR_T_NONE)
+	pid = dev_read_addr(dev);
+	if (pid == FDT_ADDR_T_NONE)
 		return log_msg_ret("bad address", -EINVAL);
 
+	priv->pid = pid;
+
 	/* Do a sanity check */
 	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
 	if (reg != 0x1)

-- 
2.42.1

