Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5037C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 23:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03ADC88AF4;
	Fri,  9 Aug 2024 01:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uZGDcl+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE9A882F0; Fri,  9 Aug 2024 01:59:41 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8866A887E6
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7a9e25008aso184103666b.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161579; x=1723766379; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=es/KIY6CL6KY9XX8tCEPp9SwT/zLGIVmiGJ0iXx4Zf8=;
 b=uZGDcl+aetekt5v8hAf/PBRbuGXqL/sWKGeQpZVICsVD/JWQZtHZVSIuaTvgLGG9s4
 u8mUua+OtgOmaWzmiA7qAmTOON3k4tzqxBCpKhdam/0hH/YZLpSIosFGdrTR7R8U9jXi
 24RFtL2e+dU1P4o1F4h8vjaAOiFJiPqBlcCByMLyrlymxXL4tVag5YJRvlfv3l+s5CkI
 lSub4gO6CysWd0B2iYvFPQXpNpSIN02uMYFiG3J4V0np8CZEEgRLZJhSeF62/xU47BG+
 t+sBWTwkf4GLFvI5UKUzBoAvAtmbCSoSeLKoyLbw6OS6yIHoJn7wzpSfxxOMEsEptZ0J
 KjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161579; x=1723766379;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=es/KIY6CL6KY9XX8tCEPp9SwT/zLGIVmiGJ0iXx4Zf8=;
 b=V0zzmbLZSgJPPdDm4JW8XVkyO+baNMQDC33vMaihHVEq/uOvzLCUn1GXtROx7v+wxn
 sZTPOAbWWUARJ3z/F+iMi4TGzuPzKz9xqyv5sd/6jO3pqIIASL211xtwg6/avq9hD7n8
 lB9JicjuL+SoM5lykZNRNdbfSWgbPYQvCJ9ZDp3Ur/U2HelqauCnIln+YDdTM8fy8NAV
 5UBvhnTzQwyxoQVVVpeAIEvUcahcvgfK+PBoiIsh+d0jQpH2/qnVQ3PqW5hpfGqBZeuK
 8mZDuDDzOa+529xvDlsy6mTuctnGOmm35b8i6ib6owjFCPxVVREMrEiWjfku3o/OtSbv
 odpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/0iiISNot/yYJlqiuj9P8xTWKwNB1O5RGs1WbWbsKyD1FqJsWAZ0tvCnTLAAuMtozRLph27pqNiZVQr6rvFKty9lj/g==
X-Gm-Message-State: AOJu0YwF/WJAQuTHlxjt6E2hK6cEvxqQssfxNOvk4uSHU62ImyUMPf/0
 fGnBBCWBHlAHZAi0SQyjKmYnM4YeouXyXq88SuiKQ1PslQgYLu1a2ryuXL9r9Js=
X-Google-Smtp-Source: AGHT+IGuNGH9pm7huia140yvgUsGHFMn3B7OhA5/Noyq7i/uwHL5FmdmwxLko0nSX4enFFkrD9QNeQ==
X-Received: by 2002:a17:907:e627:b0:a7a:9144:e254 with SMTP id
 a640c23a62f3a-a8090beb7d4mr231932566b.10.1723161578701; 
 Thu, 08 Aug 2024 16:59:38 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:38 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:24 +0200
Subject: [PATCH 01/11] mach-snapdragon: refactor board_fdt_blob_setup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-1-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=AYiBDIfhJ3LhiwbAt77sIqn/keoGsEaX+pWza/Rdc5Q=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvnvaBE/O7x6V0nIUgyFs1ZB9SbJRas9oIRs
 vb8tZr+2HyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb5wAKCRAFgzErGV9k
 tgunD/97SYatgSHizLC67D0jr3gkS3A4uN2Zrs2FBc3qHKoPFnDM0h65XBzADHs2/l8X45qJLGp
 4g95YhfqRCpjlFTsPvGtOe3jndPtjB8kebmlz2o3SfCgfAHch+Xs73J99cKjGP0sD6rgRwTB7m0
 RIgSyCxS8ZtxkEJ6P9jSStb4lm0Xp8Q4bACqoHdR8A/br/dAd6766H7iQxLY6s9R38Q6ukLsu2Q
 ZqbF1rCH8A8C3nf8W7MUAgJ2Uuv6bVffFHe9VtPMsYUIIMrRdEEF9vL3+np7dr0ZtxzJIbcWpTD
 1vtUq41nklCy+GyS+82p7BprAU/sbfYD+kuMSQH6sDLtlD9FTKk5114vNPFwO7Tl872hMnPNeEe
 23CCgNjmhzwDF5Hy5xxhuFd02XheXzw/0IcwH/hAKPIoKl8Dl1gf94bnu0SWyVMdFvHlWY87L2g
 /FN8auxPbduyygB5ZYz9VmWM5LOBgOwfXb/faFeu6b5/pMwKFQfMQ4jAt9zjoWBVRHbPYQ2iHPB
 CeA82e8ziwBRgJXcRmDKjix4LXNr5Sbb5aDzJQNOa3Z6uDCfTdkgRMqP5z7KS109wrQoFBiZkZm
 h3bAyI/+snqRaqvoN9jEDZUkrH8UpaHWkCOUIWYGwgOnVO2uhQx+OYk2CoxeOy0iGoheGLbdASE
 ayC9HLmDEa/bdWg==
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

If U-Boot has a DTB built in (appended to the image directly) then this
was likely intentional, we should prioritise it over one provided by ABL
(if there was one).

Make this behaviour explicit, and panic if no valid DTB could be found
anywhere. Returning an error is not useful in this case as U-Boot would
just crash later in a more confusing way.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index b439a19ec7eb..2881de28a0a3 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -17,8 +17,9 @@
 #include <dm/uclass-internal.h>
 #include <dm/read.h>
 #include <power/regulator.h>
 #include <env.h>
+#include <fdt_support.h>
 #include <init.h>
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
 #include <linux/psci.h>
@@ -84,28 +85,37 @@ static void show_psci_version(void)
 	      PSCI_VERSION_MAJOR(res.a0),
 	      PSCI_VERSION_MINOR(res.a0));
 }
 
+/* We support booting U-Boot with an internal DT when running as a first-stage bootloader
+ * or for supporting quirky devices where it's easier to leave the downstream DT in place
+ * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
+ */
 void *board_fdt_blob_setup(int *err)
 {
-	phys_addr_t fdt;
-	/* Return DTB pointer passed by ABL */
+	struct fdt_header *fdt;
+	bool internal_valid, external_valid;
+
 	*err = 0;
-	fdt = get_prev_bl_fdt_addr();
+	fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
+	external_valid = fdt && !fdt_check_header(fdt);
+	internal_valid = !fdt_check_header(gd->fdt_blob);
 
 	/*
-	 * If we bail then the board will simply not boot, instead let's
-	 * try and use the FDT built into U-Boot if there is one...
-	 * This avoids having a hard dependency on the previous stage bootloader
+	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
+	 * Bail out while we can still print a useful error message.
 	 */
+	if (!internal_valid && !external_valid)
+		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%#llx)\n",
+		      (phys_addr_t)fdt);
 
-	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt != ALIGN(fdt, SZ_4K) ||
-					       fdt_check_header((void *)fdt))) {
-		debug("%s: Using built in FDT, bootloader gave us %#llx\n", __func__, fdt);
+	if (internal_valid) {
+		debug("Using built in FDT\n");
 		return (void *)gd->fdt_blob;
+	} else {
+		debug("Using external FDT\n");
+		return (void *)fdt;
 	}
-
-	return (void *)fdt;
 }
 
 void reset_cpu(void)
 {

-- 
2.46.0

