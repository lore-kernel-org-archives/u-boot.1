Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024F5C54E41
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 03:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E4AB87E1C;
	Fri,  8 Mar 2024 04:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MAX7Jn88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F4587E1C; Fri,  8 Mar 2024 04:38:27 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CFD87150
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 04:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e4f7e1af80so179213a34.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 19:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709869103; x=1710473903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1WLl5z9RipY9bRZgz65vMYVn9bonA88ZTuGSEY2xtpo=;
 b=MAX7Jn88hJKUYqeUxhj03fVpoAdwnCXttywN3CXP7j8f3W7EGpneg2Kqummn7TXoA7
 CGREMOU9rdrBzqJ44EBesvfU2ygqSN37fhLKFkUOITDJ9m5DXjjVKlSJmfjbmXE5tZUG
 QbvF58W3jpEA4VbCui8oKh6+9GJ1bDR8OOH38B6vw6LJKol2W4DRNQ2EN7nr9YBhUq/W
 8Q4yVwgrlWV3rRNCAmz3XO9tbdV2kehtVB6ejo7Prt4FoR89ee58O6Myl0FxCBrRsJ2t
 xpqMwrMf0G0/FXYpmeqwHcJTkAFyCLmGN1s/VbjP6puZOkMk2+Ub6oa5j/4ZJNNO91ni
 VMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709869103; x=1710473903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1WLl5z9RipY9bRZgz65vMYVn9bonA88ZTuGSEY2xtpo=;
 b=pPOA7gwBVtDgwiDLPi4Ydg85s9aip4nHfWvdXlBKNDTWd/BE7oww9iFryr3eMtiKnr
 sulh5j40B2KzS9gj4e9ocCSq51vBlhN3vb3eMlssFVkfQDHHlW4htrxvUiuWZOyHkNfc
 UAuTEK5vvpWW0ipRqhWvqCF2ieOt7eUBeou5H3pxi0yIB8UEUIW2lK82yvf1uL+huQCw
 t2dYygLr/5DiKtTDb8RQ2wESO0ggS8j1avoBeNmYRqf1OsTAVSYwFzsAFG+Y3g6UL9Gq
 2Rqjmh1L6OZz1gUjSgDCUZ+EWs77N5wLLkP6I4/TMCjDCi1TaZQC/WaiutPw3awXwTB7
 ctew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFFYuZaSNfGatIz7gwcvw6LzV5rU1wLnbeskHAq04LdI+w93N/OjCdkTAyfx0pjk98cQ9BHFIOtHdNsFA5ahgqtA5lKQ==
X-Gm-Message-State: AOJu0YzH2kZfCx0ktD7Rs2v8n8ULEie9iuK+H9HcYEJyFj80UjXkBfhP
 IUDA2F2OCyE02WZ5V/aEFO0/I0PCjJ1+t3g/xe7l2Oa/qRa7Ja8cZeQJb3tdSiY=
X-Google-Smtp-Source: AGHT+IFSyK35imijpnSXDQqUIPpoMsAAylFiloDJVj5yUC/b8cnSTAeHF2t5fKNFpTpYFTRAa+Sumw==
X-Received: by 2002:a9d:684b:0:b0:6e5:704:63fc with SMTP id
 c11-20020a9d684b000000b006e5070463fcmr4926029oto.34.1709869103612; 
 Thu, 07 Mar 2024 19:38:23 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 h5-20020a4a6f05000000b005a0c309dd0asm3660954ooc.46.2024.03.07.19.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 19:38:23 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Joao Marcos Costa <jmcosta944@gmail.com>,
 John Clark <inindev@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rong Tao <rongtao@cestc.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Jason Kacines <j-kacines@ti.com>,
 u-boot@lists.denx.de
Subject: [PATCH] Makefile: Improve generated_defconfig file handling
Date: Thu,  7 Mar 2024 21:38:22 -0600
Message-Id: <20240308033822.28727-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Commit 2027e99e61aa ("Makefile: Run defconfig files through the C
preprocessor") adds `generated_defconfig' file, but fails to clean that
up. It might be useful to have that file around after `make' is done,
but it's better to clean that up on `make clean'. Also we probably want
to hide it in `git status' list. This patch makes the described changes,
and also adds `-P' parameter to the CPP command that produces the
`generated_defconfig' to avoid generating linemarkers.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: 2027e99e61aa ("Makefile: Run defconfig files through the C preprocessor")
---
 .gitignore               | 1 +
 Makefile                 | 1 +
 scripts/kconfig/Makefile | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 330148119264..d9a64d742fd7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,6 +63,7 @@ fit-dtb.blob*
 /spl/
 /tpl/
 /defconfig
+/generated_defconfig
 
 #
 # Generated include files
diff --git a/Makefile b/Makefile
index a2bc9d590329..6fd0e92c7d5a 100644
--- a/Makefile
+++ b/Makefile
@@ -2205,6 +2205,7 @@ clean: $(clean-dirs)
 		-o -name modules.builtin -o -name '.tmp_*.o.*' \
 		-o -name 'dsdt_generated.aml' -o -name 'dsdt_generated.asl.tmp' \
 		-o -name 'dsdt_generated.c' \
+		-o -name 'generated_defconfig' \
 		-o -name '*.efi' -o -name '*.gcno' -o -name '*.so' \) \
 		-type f -print | xargs rm -f
 
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 5ce5845e8247..079add4d5dab 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -93,7 +93,7 @@ endif
 endif
 
 %_defconfig: $(obj)/conf
-	$(Q)$(CPP) -nostdinc -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
+	$(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
 	$(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)
 
 # Added for U-Boot (backward compatibility)
-- 
2.39.2

