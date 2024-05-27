Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D48C25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 443CA883AA;
	Mon, 27 May 2024 19:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XyqwcU++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98033883B6; Mon, 27 May 2024 19:18:00 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC13D87EAC
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5751bcb3139so13129525a12.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716830278; x=1717435078; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4QFnjJkoDCSX9C4/0NHjltbmE9XPV1RDNc1JdmYfbQk=;
 b=XyqwcU++RNMTAc5IK+iqceNoDvOFkliSykwp7eF9gsEtcjG+ZWdWVuVyA7xxLg0sl9
 FI6g6lgECVfcbQNevuwT22fi1twy0nSUrBxcInPAthdWQxJho58Jqzhyher/KNYXOBnv
 NHg3EewO8t9ix9YTS/PkR1mRUVALljWnliTPfntumwkw4rgT5MKLe+PXUlndDRrHhaQB
 zRHfmlv6t4Vus31h6i0MlIRJKnGe4rIMX9WWj4YJ+QAyShj+xHeLzhMKPIQvk7RbgpY6
 JdgQN+fde21yGfSllZ7KizhjcSLuzqA0WuJs2859u3bAXDfWgrbUPZTpjZblz0y7ja0r
 giVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716830278; x=1717435078;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QFnjJkoDCSX9C4/0NHjltbmE9XPV1RDNc1JdmYfbQk=;
 b=vS15d9COxnD21jfJ7HdfEX+hj4SW+uPvfzH8zfNRwBdxxAPTpNDaOu8e1ssBLU4aWS
 JoV8T0ektHJlVbjYgaWs7DWqgn5qyE6j7fiEPtEkTkFzSRR38xsLNs5qgHd5u5a8uy8W
 sFB/Be8q/kbzHQ1LZPMwSNAIHB4mnIQ1/Ivp/R28vd+nBH9KVwxLGk6cedl5XiUfNWTZ
 zCFB7sZzTamCxdUDJM1eSu2B0q+9xFmMw7xb48h+543rNQpjD54+Aom6NybEMA0Y3Yh9
 Z7Hcad3ITh1WKKWHSqq25tASVAvZo6+xK2pZXN4DcFAb537jZB564vGz6dt2DoUH+GEh
 Mm/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJnR7s7olU+AxuDu4cTLWTz+3Jlhs1lP20DqXCQ6VImvoTUoczn3E0mRQx8OCEIires+WuTC/3Mtg7Tm8F1vCh7Q70Uw==
X-Gm-Message-State: AOJu0YxSQLPkc/R3l8jbxjpydLD1WTXi9ZNAliaIPEIv5eWDsBlgSsT3
 HOfqZ2Xpyt4pnt3N5u8JDtXM7OveR7odFdGQ+epoUuZKV9gVymrT9M4voq0KdnE=
X-Google-Smtp-Source: AGHT+IF1aAvSkgjoZTfO0LftPlPYNWVVvE5EEs1yFWbPo7nFE9esAWaQzF1CNvhw34oxziIrm6F3Fg==
X-Received: by 2002:a17:906:24c9:b0:a5a:1b60:2345 with SMTP id
 a640c23a62f3a-a626407be07mr645783366b.4.1716830278145; 
 Mon, 27 May 2024 10:17:58 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b874sm509469266b.163.2024.05.27.10.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:17:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 27 May 2024 19:17:54 +0200
Subject: [PATCH v2 6/8] mach-snapdragon: use SYSRESET_PSCI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-b4-qcom-capsule-updates-v2-6-47583d7ad428@linaro.org>
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=y7tfmVs5LE0B4TOHlkExbnL0tgQdbo1XT64nqioQVZ4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVMA+fKxrxJ7Byt9BIU64qbipAadoiLcYdO6v3
 sqq5OPSggeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlTAPgAKCRAFgzErGV9k
 ts+RD/9rSuKa5HzjmAMVzGUNcqqgip6jwfuPUzaw5cKDfaGEpVKFczAD/9inf1+yLdBxFwrUt8U
 Qe+e+0WZGhVgwmc3ho8cHeC9YC8HPcXnsIL8HbVTyWBSTZ3n8TFuV/9NkkWH48lo6Bft0dByQtl
 44gDBGu7pwHUBcIa/LnGnMh0syxhVlbrX7G9TAqnveseDZzIGSaSfJHif2S+I5pL/4Z6HGSZVcF
 9cVsaT+e29FWO/GUqQOexxZVQx5awn5vHwW5wsU/A+3CJslQjyukosBobBL/wC860qPp6hOkgiR
 Rd+22M+QxsrfpoZr8AnwcWWnbLtVU6f7f/ZQBrBWmDe74neMP7VjKEkRDsuJak/z93/6R/TQrdW
 t1KPWoZxXQJhPsbCz0+OLTnWS8kp5lCQvoC8POw9LQPN922HZXL6VSsZFQNw0VUJH45KoXr5dvV
 9tb27C1Bjx1fl4D+bqsVo6Iyq79lNRpDr8GI2xflMMV0quiRcRnf2kVsC1NELS3PxmEKSGVFuRB
 cs7PeTZ/zhjRHdfZWtCXBdqWiSTN8Yn/mxucVXCxCTT68XrrUxuk9O3rUYO5snB1jq1YRFl56EA
 JZ0LdJqX9UHgOk07Yg2ZVMwTEfnnyBloJh2FMGXZ0iJelWWh/AXelyxdipk/fjCmk1Nic2H5qjs
 g9q0sKIvY0sg1aQ==
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

