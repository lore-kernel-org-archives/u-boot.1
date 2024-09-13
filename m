Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7627EFC6185
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B6388DE8;
	Sat, 14 Sep 2024 03:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zunfBA8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845C488706; Fri, 13 Sep 2024 18:09:34 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A56F887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c34dd6c21aso16866526d6.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243771; x=1726848571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTwCfHkhBXxWUAePRFZhMsR0S5nJbbTZR3Qfjw6Z6uM=;
 b=zunfBA8fOCwG/7PDx18e/uIztXCkGV53fhNOC/Gy450h8W+vw062gdbXpIiQk/0tLc
 P+3UvBdk+VeJZhEyQWGKEk0vXeURxVrvQbLwOJAuTZxCy1x/c8/WJiA3R7SG7A2yR+Do
 Q6ufgFdZEl9IUwsMoXVcJe4MfBBFIsNoQzkssZWG6FWLdC500rpgSxsQSLMPBMdoDphk
 MqG72+1ygmiC9GXOdqYaWVcFMUFPI+HeZxtlhzzJVSRUYYasXkVU3ebkZ+ZeBZNdRw4l
 lisvO9WBd5K8paqG6k8eD4A0Ti6krlkVQ+GbPtMpO9aG3rjvUu3Gm5hh/s8MmWg+lo81
 hNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243771; x=1726848571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTwCfHkhBXxWUAePRFZhMsR0S5nJbbTZR3Qfjw6Z6uM=;
 b=JrdwVjPssICNbckKu7f8pH0SbUTMGHiDsodimmtQf/1MKIWWzFCc2sP5z2TfQS3CVY
 13wMLqaSIQhOi2BRJShu9nme5/hoLVqt6NJnmBElA66x1NEi2PN3DKVNRgc+2HpD4fra
 mjmrOsGYt/HP3xYke73HkSOqmPr0cr1oOeOoPZfGt0BCXfeTlNXaLXdhnU4vXfTLM95L
 fulX5qb6Hk0MfHo7vtunkUQIy3TPzJXgVCm9v/e0Ny/oMz/I6/zS7GqT5PJ+ZPu80Y59
 q8ItmeMdoFYx39qpf7SWnXw5aBdEWIsRK89k22ZoI5+uLt41xWh/v1DW9Avts0QZogai
 5QZQ==
X-Gm-Message-State: AOJu0Yx+UiOp7kgH/T980VIitB69ff100NjyqTcywB4hMfrvOW5HWoSM
 ka0HN7ytVEiNt9VdFBDjoy2yvfqcwV72X9+weOP5CP8YuTvIRy0swAUKOGgGChdfeR//AZOaERU
 R
X-Google-Smtp-Source: AGHT+IF2kCsajyaZQyGcprSRrYVbfYgs9TVuTVG+kr2H5wz1Q3+VKuXjNbtVVIFOCf5hipb9hZbYvw==
X-Received: by 2002:a05:6214:5b86:b0:6c5:4b90:b5ce with SMTP id
 6a1803df08f44-6c57352f5eamr105644826d6.24.1726243770527; 
 Fri, 13 Sep 2024 09:09:30 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:09:30 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 11/27] mbedtls/external: update MbedTLS PKCS7 test suites
Date: Fri, 13 Sep 2024 09:03:28 -0700
Message-Id: <20240913160408.2199558-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- None.
Changes in v3
- Update commit message.
Changes in v4
- None.
Changes in v5
- None.
Changes in v6
- None.
Changes in v7
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

