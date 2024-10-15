Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF231D1D896
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 18:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AA28897F;
	Tue, 15 Oct 2024 20:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="llVOVPGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BEC88753; Tue, 15 Oct 2024 20:29:40 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B52080245
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 20:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7ac83a98e5eso12451785a.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729016977; x=1729621777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RxcCyoCXcqTrSlEFKxiUCq6CT4q4/L2815rKnHCJq6A=;
 b=llVOVPGSXKsZiuKFTYUaJaUc7SdG3uGGZr2nCWh3VbGBzmnANZZSBiwqMWrRGUoRJ9
 fLfzdiRNq3SDK+VhuLULG6Amk57NbVT+r8NMUruwk3K1P1xKigRv+gAA7tlzw8/jKv7v
 CBxPICWCD3ZtdEEnh1oxwjh8TQP97qKbAWAGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729016977; x=1729621777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RxcCyoCXcqTrSlEFKxiUCq6CT4q4/L2815rKnHCJq6A=;
 b=nhFAmDOdM4j8JRMg1xg786B6JCMIWIzrik3sziQG8M4YEtbSOTcmxftToy6OP1zGFq
 k4DaCV/F2YsfHYO2J9LfNU+V8Yy+NSLuMvCTR9XKAySojYFK2ITX5NiH6lHdFGAwYMg4
 E0g4hzcVSznRdF44CdInhyXnnCyIMB5nQV0gUcqMpargDvMf+nIjOmIm1hSP9UALDWh3
 dQCqJPPs6ofowP3wsCff7+ZpBEdnaO3lRZ4y/QfjCQkNcPbFwoO8Cv9Fv4puSzzXHXSq
 g+bpWwhK0n3GAktYkMMyUeJOynC9hMFdN0rND2hGfjP9mEM3wAgyRT2F9bDgg+Cll+yx
 ZJ3A==
X-Gm-Message-State: AOJu0YwuaXu+F0s6Wg/AhpLpW2ZnLKOQNhzGSbBZtvySr7UoQXsi6or4
 5BYeclOLDpJ3FXqOV1S0WR7F2Qhiz5vH3voIzkbBIRt9TVxckgmMB8BKrikQROo+L1UfWNnet4W
 CUh4=
X-Google-Smtp-Source: AGHT+IGyykd1T7MSW+xDghNm8BgUd5C2XHrTLSP2X/fBJ8nXNfucFinaz0eqi0R7tf4KUao7+LbGAA==
X-Received: by 2002:a05:620a:2445:b0:7ac:b99b:48ef with SMTP id
 af79cd13be357-7b1405136camr228911285a.10.1729016977340; 
 Tue, 15 Oct 2024 11:29:37 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13617a2e9sm99504085a.66.2024.10.15.11.29.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 11:29:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Do not test "sleep" in QEMU
Date: Tue, 15 Oct 2024 12:29:34 -0600
Message-ID: <20241015182934.353099-1-trini@konsulko.com>
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

When we have platforms being emulated by QEMU we cannot rely on the
"sleep" command running for the expected wall-clock amount of time. Even
with our current allowance for deviation from expected time, it will
still fail from time to time. Exclude the sleep test here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 9 +++++++++
 .gitlab-ci.yml       | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b66d49a62ba0..11f1d5ad20a1 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -400,12 +400,15 @@ stages:
         evb_ast2500:
           TEST_PY_BD: "evb-ast2500"
           TEST_PY_ID: "--id qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         evb_ast2600:
           TEST_PY_BD: "evb-ast2600"
           TEST_PY_ID: "--id qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         vexpress_ca9x4:
           TEST_PY_BD: "vexpress_ca9x4"
           TEST_PY_ID: "--id qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         integratorcp_cm926ejs:
           TEST_PY_BD: "integratorcp_cm926ejs"
           TEST_PY_ID: "--id qemu"
@@ -464,21 +467,27 @@ stages:
         r2dplus_i82557c:
           TEST_PY_BD: "r2dplus"
           TEST_PY_ID: "--id i82557c_qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         r2dplus_pcnet:
           TEST_PY_BD: "r2dplus"
           TEST_PY_ID: "--id pcnet_qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         r2dplus_rtl8139:
           TEST_PY_BD: "r2dplus"
           TEST_PY_ID: "--id rtl8139_qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         r2dplus_tulip:
           TEST_PY_BD: "r2dplus"
           TEST_PY_ID: "--id tulip_qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         sifive_unleashed_sdcard:
           TEST_PY_BD: "sifive_unleashed"
           TEST_PY_ID: "--id sdcard_qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         sifive_unleashed_spi-nor:
           TEST_PY_BD: "sifive_unleashed"
           TEST_PY_ID: "--id spi-nor_qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         xilinx_zynq_virt:
           TEST_PY_BD: "xilinx_zynq_virt"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2a52e15d0fe7..d938c7f31d68 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -306,12 +306,14 @@ sandbox trace_test.py:
 evb-ast2500 test.py:
   variables:
     TEST_PY_BD: "evb-ast2500"
+    TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
 evb-ast2600 test.py:
   variables:
     TEST_PY_BD: "evb-ast2600"
+    TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
@@ -323,6 +325,7 @@ sandbox_flattree test.py:
 vexpress_ca9x4 test.py:
   variables:
     TEST_PY_BD: "vexpress_ca9x4"
+    TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
@@ -432,36 +435,42 @@ qemu-xtensa-dc233c test.py:
 r2dplus_i82557c test.py:
   variables:
     TEST_PY_BD: "r2dplus"
+    TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id i82557c_qemu"
   <<: *buildman_and_testpy_dfn
 
 r2dplus_pcnet test.py:
   variables:
     TEST_PY_BD: "r2dplus"
+    TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id pcnet_qemu"
   <<: *buildman_and_testpy_dfn
 
 r2dplus_rtl8139 test.py:
   variables:
     TEST_PY_BD: "r2dplus"
+    TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id rtl8139_qemu"
   <<: *buildman_and_testpy_dfn
 
 r2dplus_tulip test.py:
   variables:
     TEST_PY_BD: "r2dplus"
+    TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id tulip_qemu"
   <<: *buildman_and_testpy_dfn
 
 sifive_unleashed_sdcard test.py:
   variables:
     TEST_PY_BD: "sifive_unleashed"
+    TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id sdcard_qemu"
   <<: *buildman_and_testpy_dfn
 
 sifive_unleashed_spi-nor test.py:
   variables:
     TEST_PY_BD: "sifive_unleashed"
+    TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id spi-nor_qemu"
   <<: *buildman_and_testpy_dfn
 
-- 
2.43.0

