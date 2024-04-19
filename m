Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C091DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 09:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C528886E7;
	Fri, 19 Apr 2024 11:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b+EtGyi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D323886F3; Fri, 19 Apr 2024 11:45:52 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C3D886CC
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 11:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-571bddd74c1so1510858a12.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 02:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713519950; x=1714124750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HVklAy+qSzBO559pr/KsbRMAwulsSpReQFNUPaUCM0g=;
 b=b+EtGyi6p1hzFtWTdepGfeyIQS7uty35MqP4wxHrSCX0y3Nw6Q3veAgHFJ2/6W4ZXe
 c1FdQDatWyu+3s85iJTapPDUu3bee4/W/tnqZBQYtdG7sVsqJJDUb+Szsc5Wn46SQRDZ
 WELIov7L9bNmFUyLDeSyYY1JyGEpVdxDQ20pelTejD5xNBJnLptH7hwdHYvzvixKB3IF
 Ei0pEFUOjZ+CtT+yVsZSMG2uq1rKUnBPjjD3eVm8K+iSi2ku44818DgIuO8NaTW9IpnP
 ISJq77ggAeTCCQ7huymItq3rI/qgDVdxTFHQ3EEd5he0TrYLLtSUYl4xylzjypaA5XA8
 9SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713519950; x=1714124750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HVklAy+qSzBO559pr/KsbRMAwulsSpReQFNUPaUCM0g=;
 b=u5NggeAbQhYd7qMik3tj64dpbZAtqhJKHxM/1wIU4LWI0pdNhjH50/U3q53betxl0H
 zn+u/umOJFCxpYQj4nEIPU0H9rwHl9yYLBgLgsbomgG4Vu9uiy+9q4B9VMOamEC+hnLC
 4JyUpkxFRsvgKI2IGDh/GL1kB0CpcQfp/UNtZ3yY0mqVsIwAULo8QBNwWHeXpFHljTA8
 00+7Ws6YhvbFZ9TPDEw78K+QKP3U/QJy7ZRJusf83VV5MwAhBCGXgG1fSF+TsfROe4Ae
 Tz+EyV0H2QBJggheUpG+wHw1Rvge03JYxzTz1+PlKmwu2/dEgSHGzl+rymxg3/GjWJ9D
 CVMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdafiPjp8aOTp44C4klenW4qmgNSElpv7LL3IfRFN0sW8xpbC32CyyVX0u2nJXbMXewuH9Z2quZOidsBTGG+llb8cbsQ==
X-Gm-Message-State: AOJu0YxkoC/uuwLa8wGt/sXlKzPuLznMO7x8CNrvTLlladoKOMjFzr/P
 UuJJLMaEqOH3qoi/pr/bpLx1Pjar0MPIpVY2zEt88IsyZYF3wDo5+llptzpqm0c=
X-Google-Smtp-Source: AGHT+IFYAiG3ZTeQ+zlfpN29kwW5e1iWdu0UAFSLquJzsaByIBUBSCKyo1pkX52pnNHRscArjaOxmw==
X-Received: by 2002:a17:907:11db:b0:a55:63de:9aa9 with SMTP id
 va27-20020a17090711db00b00a5563de9aa9mr991747ejb.49.1713519950023; 
 Fri, 19 Apr 2024 02:45:50 -0700 (PDT)
Received: from localhost.localdomain (ppp176092141112.access.hol.gr.
 [176.92.141.112]) by smtp.gmail.com with ESMTPSA id
 v22-20020a1709064e9600b00a55865b2760sm587299eju.30.2024.04.19.02.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 02:45:49 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2] efi_loader: change the error message when storing EFI
 variables
Date: Fri, 19 Apr 2024 12:45:45 +0300
Message-ID: <20240419094546.12653-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

When we try to store EFI variables on a file, we need to use an ESP.
if an ESP is not found, variables will change in memory, but U-Boot
won't be able to restore them across reboots.

Adjust the error message so users can understand what's going on

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- print different messages if ESP is missing or write to file failed

 lib/efi_loader/efi_var_file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 413e1794e88c..d5d347d50f8d 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -73,16 +73,20 @@ efi_status_t efi_var_to_file(void)
 		goto error;

 	ret = efi_set_blk_dev_to_system_partition();
-	if (ret != EFI_SUCCESS)
+	if (ret != EFI_SUCCESS) {
+		log_err("ESP not found.");
 		goto error;
+	}

 	r = fs_write(EFI_VAR_FILE_NAME, map_to_sysmem(buf), 0, len, &actlen);
-	if (r || len != actlen)
+	if (r || len != actlen) {
+		log_err("Failed to store variables.");
 		ret = EFI_DEVICE_ERROR;
+	}

 error:
 	if (ret != EFI_SUCCESS)
-		log_err("Failed to persist EFI variables\n");
+		log_err(" UEFI variables won't persist reboot\n");
 	free(buf);
 	return ret;
 #else
--
2.43.0

