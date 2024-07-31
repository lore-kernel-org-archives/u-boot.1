Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CD0C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC6FC88A08;
	Wed, 31 Jul 2024 19:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y/BPdUZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE5B88A68; Wed, 31 Jul 2024 19:30:31 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1795F86FB1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a1d3874c1eso345482585a.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447028; x=1723051828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqPM2YmbpCRKC9VzGH7IRLcYkh/d2Vs2xaAKf7b96FQ=;
 b=Y/BPdUZ0dxas9WnDFroIvfrayzrO8Rf5o5u9ZELMPBIVxxMU4Sf2hSzCZdF8nr4vUL
 PY/dEqvp3fJoNCCGc33yOy2GgOPh9m4U3asSC/4VPMS3VNWHMMzWgfkXNkv+1JMEGxFq
 ZsQ7/ycDx4zu1RgSKTaHw4tZaHbNw6SnBOpF3hFffGuboFyG3RjOLk6XapbyCIxVlJ01
 bIDBNki9d5YAEd+2JPKMAU+b9fDJAB0zfmQzPhr19QYWyb5m/EGE3SarzbQvIMjb2K1Y
 /lWbZGZPG36x7DA7AiXsQFanIeRtkW/Ldic2stbIk6CeQ3YLrk2kPF7onSSrSwaNztVB
 oAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447028; x=1723051828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqPM2YmbpCRKC9VzGH7IRLcYkh/d2Vs2xaAKf7b96FQ=;
 b=nprLX4mL6W7m6TpdVRTJUR4BLT9GXeBZ4KFAPqR8JpCFIFQ6tAH9/ejHKlFdwRg4Oe
 2Y4j97oMDS+f9SMs4qj5os6gj69z9hEY5zGcjxKpS+Y6Sf0dcgIXx5BhfAsvTbuRnY3T
 SydX3a6vDGX9AF9A0g7XZpOlVNaHMRD2cNBrLRZr9WmHyKNIksv3hnvLLE6Aaj8XXjzw
 BdnCrd7YC0MbdvG4xiDOfjhkGr/mTO6B1McrQW9iswbIGr6BtWp083MrVSKPaAjvpbRd
 bmuq/FNtR1sSl+8pdhuFlsN9isK7vgrF+zlgrswow0UEl1FZNQAOFywiwSr9JBgMtexo
 ldUg==
X-Gm-Message-State: AOJu0YycqKho30nxrDGT5CDrj7EwtLaia5L3rwLiHBTccmEVJ/DBUK1x
 5yuOVc0fYIOtj5Cj4J126Qcl3YkXPHVVbtumhbRpdAd5nxOimyc53bL5+K3EOwd/qAPQT/Z9iX9
 DABI=
X-Google-Smtp-Source: AGHT+IE0FsRfVZnDUmkOs3fCzzVU/P9vNtNQ3qdWIv8hr6n3oOseLv8jrl349Q6Zw2BcmG7LIckuOg==
X-Received: by 2002:a05:620a:1728:b0:79d:7423:d040 with SMTP id
 af79cd13be357-7a1e52ce39fmr1829169685a.54.1722447027699; 
 Wed, 31 Jul 2024 10:30:27 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:30:27 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 11/27] mbedtls/external: update MbedTLS PKCS7 test suites
Date: Wed, 31 Jul 2024 10:25:21 -0700
Message-Id: <20240731172556.1348487-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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

Update the PKCS7 test suites for multiple certs.

The PR for this patch is at:
https://github.com/Mbed-TLS/mbedtls/pull/9001

For enabling EFI loader PKCS7 features with MbedTLS build,
we need this patch on top of MbedTLS v3.6.0 before it is merged into
the next MbedTLS LTS release.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.
Changes in v3
- Update commit message.
Changes in v4
- None.
Changes in v5
- None.

 .../external/mbedtls/tests/suites/test_suite_pkcs7.data       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
index d3b83cdf0aa..2dd1c56109f 100644
--- a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
+++ b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
@@ -14,9 +14,9 @@ PKCS7 Signed Data Parse with zero signers
 depends_on:MBEDTLS_MD_CAN_SHA256
 pkcs7_parse:"data_files/pkcs7_data_no_signers.der":MBEDTLS_PKCS7_SIGNED_DATA
 
-PKCS7 Signed Data Parse Fail with multiple certs #4
+PKCS7 Signed Data Parse Pass with multiple certs #4
 depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
-pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE
+pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_PKCS7_SIGNED_DATA
 
 PKCS7 Signed Data Parse Fail with corrupted cert #5.0
 depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
-- 
2.25.1

