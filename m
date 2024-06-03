Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2469C25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0097088353;
	Mon,  3 Jun 2024 14:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ci0y7/RU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F222188365; Mon,  3 Jun 2024 14:49:27 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00BBE88292
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso563621966b.1
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418965; x=1718023765; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lxK2ugEbGSKN7sRXDYunMJj2LB7aLL5crETjpykvPOY=;
 b=ci0y7/RUHnl6c69bvlLMe7rJ6CMszu/CVa1pdktLYmITTnRXycKxZ7vuoiXHvkDqH9
 Fymscg66BD95xhJlu5wX3hJi9cJ5RRQD6+tdMWL+L7+ggt4zVBX4L2dW4b8rH1R1D9dt
 n5yBmEbTm+NqsyzMKn2ZlOVLrebTiDt6JBiD6E/JW7m+uU9gfJmbjvMoHGtjr91D9eYV
 zHAFgxRnL06HWlTV39UYAlCBMQLYOCGVhLN66QRPdqGEmvcz2HmNMdQrZDe6eHq+jgbO
 ElYxj+ENGGy90EpVglQsvNVC9A87N8ppdxT5/6vb4gxqr50me+Dd7su6/+SpQbivwEmG
 E0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418965; x=1718023765;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxK2ugEbGSKN7sRXDYunMJj2LB7aLL5crETjpykvPOY=;
 b=DCJyAZ8xAKtPf2zepjB/gWyeSHnWF0XOM3rzsqRzblghi9ipRzT0Wd7lOK5IyN5E0M
 Tu0uBFaYHbXI4wuwhf/Xi1sVzxQJHY1DQMxY/lMSOxeXpTrn3rrGDQVFkp/DQLHg1lMA
 YVEVd0nsILI5iE3rBqVk25UsxXiZy5FiEjWexeWpgTrxUltgsUZkrj03j/cEnJFAw0Ak
 x/SSEtkb4N2tWzsdog8NMZHkcw7DymQ0poTkS1xVoEwmlkCsvT9kWw7C0XZAR/ifoeFN
 DqGDSl5LDLvedq9ZizyuZs/VigeNx5TVECYOesPo0A2aaOu2CpEi5itl7xeu5m/6fyEi
 1UuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZXUY4rhswpbaSroQMS+g8NhnbF5+MKxC8Ew0mX10cxzwAcBT/YJXEVrZ4uisfer22j9S8JP+GrHuL05AHGF6jN0DJ0Q==
X-Gm-Message-State: AOJu0Ywuh+PQztDTPyENenU5OmnwqPtrtAmfBZ25bnk8CgEQvGMPcSnr
 +BDDsrbHDDBViLM0caE+TXL2crnSK4bZYPVMePqasIj+4t5z9I0pFfLF1NywfU8=
X-Google-Smtp-Source: AGHT+IExHB8LaCEk637BSvxPtvZHWwlZzs+nDHs73+CHVMnXEhH5F4UdU6vGaGN+MuPwJbm/bAGKaw==
X-Received: by 2002:a17:906:280a:b0:a68:4aeb:e32f with SMTP id
 a640c23a62f3a-a684aebe420mr595679666b.2.1717418965510; 
 Mon, 03 Jun 2024 05:49:25 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691cd07c72sm98917066b.170.2024.06.03.05.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:49:25 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 03 Jun 2024 14:49:21 +0200
Subject: [PATCH v3 6/8] mach-snapdragon: use SYSRESET_PSCI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-b4-qcom-capsule-updates-v3-6-fe2e083289ec@linaro.org>
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=M6iptjEymhuqp1KfmFS4RPhJ/d89vJi1LDpR7tOtX6Y=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmXbvN4eIuLx7/d5rRBLZdZiVhkCDzk3e/CGVqV
 i4fK+d2ER6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZl27zQAKCRAFgzErGV9k
 tpcQD/wIhtab1iQX9CKKtLe8AdimmpMIQh+IVraR6zx/A24CG/VZM8W3IXETpsThF3tWPDC8KZp
 gJmgfzXq6PNx4FqCSVCGRqvzxNMnYXe1LM4Ya2hPyUJL1K0V7qVkHh67R3Gr8pc7KzbFpGqLa29
 AJFcL823Z8zchyTfCjzE1UGH8qGt6xXimAZGq7aatq990OTESJNS41dN2+TdmTuGWyI0dA2RwkZ
 oxOlT3wrlVw9GKqnlvU9Fu8QIMGbA/kAOfc1/UBeD/zMq3LZA+/SEoREoiogeSoNojvQlV7X42N
 WnPNlDWnxArz6EzLO2F9/UPofROqA7v880p9f7OAPb9oNLfEEf/r8x3iTCRSxjb/aOeNV6cbUj3
 YM0aBXRZ8LCSbHA8Plq6Ux17/OVeNpbNxGQwrKIIiU6PUPEtkiH+/xh2QVfw1JFIE/ZTP3iwfof
 EbJH7alsc/DaP4o0WurU12fYoymtNwXLuYRmtnu2yT+FtEImTYSe73rCVrzbqTXKUEQUiYj9kqA
 TdYgQyZUSfWPHHBcW0rPKaB3/9PxOOt+YiPbMBhkZxgVz4xBTTtDkgqoNm8McvL+DGd8lq4jyfZ
 vZaglobiuJM0VCOR7XbHYN9rV1xXDy89nzDlqKGF22V68B7RIWa2OqxUrfC1vkCJYk2BHjcwGaa
 6mwF94tJbYWblEg==
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

Capsule updates depend on SYSRESET, which we currently don't select but
instead use a custom reset_cpu() implementation which just calls
psci_reset().

Clean this up, drop our custom function and require PSCI reset.

There are some Qualcomm platforms that either can or do run without PSCI
support, but we didn't handle these properly before anyway.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig                 | 2 ++
 arch/arm/mach-snapdragon/board.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 39ad03acd2e4..0d5161358e33 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1084,8 +1084,10 @@ config ARCH_SNAPDRAGON
 	select OF_CONTROL
 	select OF_SEPARATE
 	select SMEM
 	select SPMI
+	select SYSRESET
+	select SYSRESET_PSCI
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index c4a3394706e6..b0d9a65bb8f5 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -106,13 +106,8 @@ void *board_fdt_blob_setup(int *err)
 
 	return (void *)fdt;
 }
 
-void reset_cpu(void)
-{
-	psci_system_reset();
-}
-
 /*
  * Some Qualcomm boards require GPIO configuration when switching USB modes.
  * Support setting this configuration via pinctrl state.
  */

-- 
2.45.0

