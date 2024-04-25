Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD617C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 05:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF9D88EBC;
	Thu, 25 Apr 2024 07:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EWWzKgeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10ACB88EBD; Thu, 25 Apr 2024 07:18:31 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D1AF88EBD
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 07:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so599907a12.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 22:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714022308; x=1714627108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9njVlxY+URj7SM1dSXGi3VJmiRfl04AVj95UvDee6Y=;
 b=EWWzKgeSsY+dHMoaNYhEW1Bl/B+n61PKEJBR9I7AS2wkMmnqIHBey3psIrSGFvzmq7
 fwk3s0wvzNj8qJOb6PkgihWZ/55SQ0vRSQ9z0l2e22RN1VeE4gKpeAQxAv80vfiL/DfA
 lXv93+Sdk3zZiO/3VOi2Gx+4OQ/sgS1C/TAVh9pQNzax0AyQ5bQC3pwFE0uYUF8aJ+ef
 ELgy8RqMvUenRXJDsyUxbTSEgTw/yh9Lh3Rq8ThVSgSl03KHQTsiXKEv8Ld20RV5VO9V
 2Y1qrGQdVFsBClztudFd+L5MjT3HCTk8U9XbL2Q5iQGLSIHOckbV9OhS4WEP10cLErSz
 vwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714022308; x=1714627108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9njVlxY+URj7SM1dSXGi3VJmiRfl04AVj95UvDee6Y=;
 b=VkDUcwIgcvo8LpAstXSuUWLsq5XqWdKzc3hP+iuIfCJa/l+OO4NZdW8qg/W46JAyl4
 VC308AobdAkqWzSkrS6//cLCqHc3664KNK2Oh68ucIRZXtTZgfsiT7SCXhV2yyVW7XU+
 pAS15tNFA5ZROo6vNzsUpIlYBtFkVexo3sMNocEpumraUUrVbNljDdpMfxmLmNMW2jbr
 T0dykSU0Wj9xSJ13Yrk7N7vDyZN4p20G+wvF2eUSHtUWZNgmUV4Hq8JCr3UKbMAqXjAM
 xGyeCGHlgnywicg0P2qeHus0dWv/iTAzsV0VAqsKbijYEej6ZJMiCn3pVuJrec6SEwul
 3Uyg==
X-Gm-Message-State: AOJu0YxrKrxHY0vT5ACUITBRC6vZ0a6UBkqrnb9xgQ2xGrS2UY9g4n2B
 mvoXZpTOfbnHKoMzqXL8ecPqvc6K+DlC3d88pIv5pJdR9WfyuwAod6dtogPR3/0HuLYmRSu2LyD
 VnNM=
X-Google-Smtp-Source: AGHT+IHKmmGQoM6choUFdAcgRVm3w56sFJqd84aYRFCXfr0Y35eCOa2ALaX7IvyePxkNOjWTnD2X1w==
X-Received: by 2002:a50:ab49:0:b0:56e:2cbc:db77 with SMTP id
 t9-20020a50ab49000000b0056e2cbcdb77mr3072283edc.33.1714022308703; 
 Wed, 24 Apr 2024 22:18:28 -0700 (PDT)
Received: from hades.. (ppp089210108048.access.hol.gr. [89.210.108.48])
 by smtp.gmail.com with ESMTPSA id
 l6-20020aa7d946000000b005723151e99asm1410826eds.95.2024.04.24.22.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 22:18:28 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 3/3] efi_selftest: add tests for QueryVariableInfo at
 boottime
Date: Thu, 25 Apr 2024 08:18:21 +0300
Message-Id: <20240425051821.338842-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240425051821.338842-1-ilias.apalodimas@linaro.org>
References: <20240425051821.338842-1-ilias.apalodimas@linaro.org>
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
Changes since v1:
- efi_st_query_variable_common() called with EFI_VARIABLE_BOOTSERVICE_ACCESS
  only
 lib/efi_selftest/efi_selftest_variables.c        | 13 +++++--------
 lib/efi_selftest/efi_selftest_variables_common.c |  3 +++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
index 39ad03a090d4..3d5f38c68978 100644
--- a/lib/efi_selftest/efi_selftest_variables.c
+++ b/lib/efi_selftest/efi_selftest_variables.c
@@ -51,15 +51,12 @@ static int execute(void)
 	u16 varname[EFI_ST_MAX_VARNAME_SIZE];
 	int flag;
 	efi_guid_t guid;
-	u64 max_storage, rem_storage, max_size;
+	int test_ret;

-	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
-					   &max_storage, &rem_storage,
-					   &max_size);
-	if (ret != EFI_SUCCESS) {
-		efi_st_todo("QueryVariableInfo failed\n");
-	} else if (!max_storage || !rem_storage || !max_size) {
-		efi_st_error("QueryVariableInfo: wrong info\n");
+	test_ret = efi_st_query_variable_common(runtime,
+						EFI_VARIABLE_BOOTSERVICE_ACCESS);
+	if (test_ret != EFI_ST_SUCCESS) {
+		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
 	}
 	/* Set variable 0 */
diff --git a/lib/efi_selftest/efi_selftest_variables_common.c b/lib/efi_selftest/efi_selftest_variables_common.c
index e29a4be74a57..453bc8709a6f 100644
--- a/lib/efi_selftest/efi_selftest_variables_common.c
+++ b/lib/efi_selftest/efi_selftest_variables_common.c
@@ -23,6 +23,9 @@ int efi_st_query_variable_common(struct efi_runtime_services *runtime,
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("QueryVariableInfo failed\n");
 		return EFI_ST_FAILURE;
+	} else if (!max_storage || !rem_storage || !max_size) {
+		efi_st_error("QueryVariableInfo: wrong info\n");
+		return EFI_ST_FAILURE;
 	}

 	ret = runtime->query_variable_info(EFI_VARIABLE_RUNTIME_ACCESS,
--
2.40.1

