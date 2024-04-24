Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A22DC10F16
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 05:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7951488DA2;
	Wed, 24 Apr 2024 07:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G8j4e4Ry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FF088D9D; Wed, 24 Apr 2024 07:04:05 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 358D288D9A
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 07:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-418e4cd2196so49003005e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 22:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713935042; x=1714539842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juxT4SQiTHHzad/I6QIeWGWaFJiZ0GQIxFhJo9JKBcQ=;
 b=G8j4e4Ry7CddV2e0HEitC2wCU8OnLgC2AF69Az0qsiGCZIT847NTOIMON7cGvcBLwg
 HPFn5vQnIvNRmWmW+mzECw3Ex/PeKocIHCPIEZwBQmEZWaBa8Aqw0St+m+K87gyhrNUN
 KRHiF9Wbi7f1eIU2asI4ZZNc3v9B8fGcA0eUttUTcuQTVl+QalM8dtKfMtLiPn1Sn+Se
 UJADv0DLLuFmSJo8XLI2eKMUauK4iaC5dDynx6iYDQjy0JUmptkUFtY3vqiBjjULmz/s
 uAgACVnviahPQA59VX4JRqNf4Xe9LjaNu0Uk8Hirhl4ttVq3omx1rUIdRfNMhNu+D1Wr
 X4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713935042; x=1714539842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=juxT4SQiTHHzad/I6QIeWGWaFJiZ0GQIxFhJo9JKBcQ=;
 b=S8onHLW/gTN9slUm+Q9h0zV1i1snwzFkZ5rFlwjBmiIEHCgiCqyAd7B4+wZ0IXelkX
 K7aho+BkSMSFvlyD46oJhgm5j/ERDoOngTZQSnYdniwnttkMLp/PVYAY/GfGov2m6EJY
 pLZnQAjVtmwZg+mBwdRk0ZLU1cAjIQ1POLsWbxXoO8d2GxEI3rzjeJoGbYD9OSegy4Ye
 /pSFwZnjMMFvivKGMIyQB/gW9gmzLGAzsuEVSaPpKau3wW6ty7AjUGyxpZjjATAVdJt0
 AhlNO3pDLzR1SzOqk5l8CHsOEUUq7MV7XeAF4J5/y7trBleA6LdrRCne9d35YvajQ+Wq
 IQ5Q==
X-Gm-Message-State: AOJu0Yx3jHs1g9j/hWsWUFRnUPAJXv3D3/dKoerXL0mcInpWl/MXEUCK
 vN358yw0FYy6dtynJZji1cjirGhQDJqH7+btQUTM6YADDeo6ChhUVEIWycWBowGf+ydLpYNLAp+
 mI28=
X-Google-Smtp-Source: AGHT+IEGq6aRXNiFOsQkJmplxRflmE0R1VFDykWwa2l8INi6vK4/NpEifbOYrPrrEkIpymjDLbc/sA==
X-Received: by 2002:a05:600c:190b:b0:41a:a5ff:ea3a with SMTP id
 j11-20020a05600c190b00b0041aa5ffea3amr950446wmq.19.1713935042777; 
 Tue, 23 Apr 2024 22:04:02 -0700 (PDT)
Received: from hades.. (ppp089210108048.access.hol.gr. [89.210.108.48])
 by smtp.gmail.com with ESMTPSA id
 bi8-20020a05600c3d8800b0041afe0f2f17sm861032wmb.16.2024.04.23.22.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 22:04:02 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/3] efi_selftest: add tests for QueryVariableInfo at boottime
Date: Wed, 24 Apr 2024 08:03:51 +0300
Message-Id: <20240424050351.318724-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424050351.318724-1-ilias.apalodimas@linaro.org>
References: <20240424050351.318724-1-ilias.apalodimas@linaro.org>
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

Previous patches added QueryVariableInfo at runtime tests and
split a common function that can be used at boottime. Weire it
up and run a similar set of tets. While at it move a test which is
checiking for 0 available storage in the common code

Add tests for
- Test QueryVariableInfo returns EFI_SUCCESS
- Test null pointers for the function arguments
- Test invalid combination of attributes

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_selftest/efi_selftest_variables.c        | 11 ++++-------
 lib/efi_selftest/efi_selftest_variables_common.c |  3 +++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
index 39ad03a090d4..3c55938be1ce 100644
--- a/lib/efi_selftest/efi_selftest_variables.c
+++ b/lib/efi_selftest/efi_selftest_variables.c
@@ -52,14 +52,11 @@ static int execute(void)
 	int flag;
 	efi_guid_t guid;
 	u64 max_storage, rem_storage, max_size;
+	int test_ret;
 
-	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
-					   &max_storage, &rem_storage,
-					   &max_size);
-	if (ret != EFI_SUCCESS) {
-		efi_st_todo("QueryVariableInfo failed\n");
-	} else if (!max_storage || !rem_storage || !max_size) {
-		efi_st_error("QueryVariableInfo: wrong info\n");
+	test_ret = efi_st_query_variable_common(runtime);
+	if (test_ret != EFI_ST_SUCCESS) {
+		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
 	}
 	/* Set variable 0 */
diff --git a/lib/efi_selftest/efi_selftest_variables_common.c b/lib/efi_selftest/efi_selftest_variables_common.c
index 36bdfe6ff9c3..435ccf4ac13a 100644
--- a/lib/efi_selftest/efi_selftest_variables_common.c
+++ b/lib/efi_selftest/efi_selftest_variables_common.c
@@ -22,6 +22,9 @@ int efi_st_query_variable_common(struct efi_runtime_services *runtime)
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
+	} else if (!max_storage || !rem_storage || !max_size) {
+		efi_st_error("QueryVariableInfo: wrong info\n");
+		return EFI_ST_FAILURE;
 	}
 
 	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
-- 
2.40.1

