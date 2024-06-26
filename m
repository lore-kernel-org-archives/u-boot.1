Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73736C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F43E88563;
	Wed, 26 Jun 2024 18:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YQFli4b5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 720A9884DD; Wed, 26 Jun 2024 18:00:11 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E1B884C6
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42249a4f9e4so51049245e9.2
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417609; x=1720022409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7dZ7EgYr0k6vuGV4Zq+HOmn5La1Qr8GHhYneKXIm/g=;
 b=YQFli4b5wUIvUC8RPnAy185KongUuMZS1AhClTYiIX+XXFEhHE+qsxUC4ZJWxEW3Ur
 ecvn0eZJvaNrtJi2adVD/+3uvUPd2826N6J7e8hlX3PyWb1gamJ/70H5uCd1urG3YPBD
 7rcZjO5Ync5zAmrSFl8qFbL6WDAH1fppeID84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417609; x=1720022409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7dZ7EgYr0k6vuGV4Zq+HOmn5La1Qr8GHhYneKXIm/g=;
 b=I/JOIRzgl9uVQUNk7khGu17HPusyyZZ6EHeCDXp1zrSkl/7NeUbiAQI/SK1C2nN15D
 LYg/Gbjr93iTwxycc7qNzOZi+1L1l4qsLi1oT4VeZbIvqmUzMBxoHq0hNNZuZucVWGDJ
 6dP57K67Ug9V4fN89JCnCvtW1tS7x/Jg23uwaNy88AbSRbBw/QE5cUk71UgPAbeg9tym
 NQYl1corq5Xq1vX6yjm28xzj3V2x7mCpEMx6BNFE7HieIZ97QNeHsxnJZR7fhwRhHMiR
 Ou4LcR2H/9dIaKM9YN2wB8RrP8aK669MOEcfPkli8OWyB0ZrQ6jJ7aYF+L6CCiP7XsOf
 CKtg==
X-Gm-Message-State: AOJu0YymgrYWP2uoKZcpfhF1WdQSzlRztrDo6JZy1U+j088+rTIgGU3v
 CQIwJ8746/90TELzqsDgJgWfqaVrVZtdDr+HVVhUNY3SdrD8eeom7sgO6l8SnXgSpa/zVzO+FgK
 jiA==
X-Google-Smtp-Source: AGHT+IF7Sgwu+f17dUcXBRb3gab8IDzxH7hCIhJtnHOegJOaeI4g16hmHcez3Y7FMKnfaIfpGmLA9g==
X-Received: by 2002:a05:600c:1c1f:b0:424:8e3a:d02e with SMTP id
 5b1f17b1804b1-4248e3ad244mr80865365e9.3.1719417608797; 
 Wed, 26 Jun 2024 09:00:08 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v5 05/16] binman: Keep the efi_capsule input file
Date: Wed, 26 Jun 2024 16:59:34 +0100
Message-Id: <20240626155945.278640-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

There is no need to remove input files. It makes it harder to diagnose
failures. Keep the payload file.

There is no test for this condition, but one could be added.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

(no changes since v4)

Changes in v4:
- Drop Fixes tag

 tools/binman/etype/efi_capsule.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 47da5da324b..03e55cbc4d9 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -148,7 +148,6 @@ class Entry_efi_capsule(Entry_section):
                                                  self.fw_version,
                                                  self.oem_flags)
         if ret is not None:
-            os.remove(payload)
             return tools.read_file(capsule_fname)
         else:
             # Bintool is missing; just use the input data as the output
-- 
2.34.1

