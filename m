Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02002C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E043D80E61;
	Tue, 21 Jul 2026 15:55:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5KUmDmhSHNco; Tue, 21 Jul 2026 15:55:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B547380E44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649337;
	bh=5Dgq1O/scuCTqPPyFkmjdFDJZP7bULCJScXbLSxo5NE=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qWi2iEbhbFyPunPRDlolo1p/F2RFMrACiEIn9+H+6NqZ12NH7HTz5rfivObG/V+4O
	 qgWGwfG+sI8StamSW/7/QPUDPKRDSO/cyP8raAzAxPUWCbRMEBAiv3DfHu/yAjWgIN
	 7AJWP6y++vWIHVAxpZCo64TXofGwYIq9mN9Qs6yUQDCjgaVc4DYwAWU2mRFNIF+mz7
	 6xrF9Vb59d+KZDZAGtThM9XWI5JvnZdP70feZ2mvdaBuKdXzKCDxAzJJJMOJbrWeQW
	 1RXKI21DKtkcA2ITK3clsnqx8f5TiTONrYwP5rX5g95rrE2DppavNqlKvwtlq9jo5p
	 T1q9UUa5YTNig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B547380E44;
	Tue, 21 Jul 2026 15:55:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4228DEB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 344F640071
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mT8EJYWD3xaO for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:21:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9533A40277
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9533A40277
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9533A40277
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:32 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1EEC63F982
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:30 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cefa1a2be6so96128995ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647288; x=1785252088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Dgq1O/scuCTqPPyFkmjdFDJZP7bULCJScXbLSxo5NE=;
 b=EarPKwJ4WtKc8KCmAbgM4Qu72LbFvLQXeaCGxFccC/lI6hx+mORlW5DfOk/mpkJT0A
 ZWrEcwXRM2V5owR4twpdx2yfPHe4ecjHWa6ho+NPF6xDzyzzeCz439fDSlmM7LD4iax5
 5J+rdF9QiKHdVdY3KTEvRHY5m87xfblBFZj3d5S6PlaZI571vDnT48TYbizlQDe+Gak+
 nSlSjbPeC+Zy60a83TrvAz8Ck9AZoKErl9WUah8EQky7Ts6YI+KiyJBkCfxgaC9p1t6L
 KwUQEQvOM+GbIhguuLVC+ahMcpINRe28I95fg3G4mFcIMlIZzgkGhLyUTTf3f2KkmBMT
 xvvw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMeoVk+Ms9UPP+6NtmtwyQJMPVlEHZ0fHEkq4sPG62dbOpIjTaYCPeXE1qYv7x/dbZQCInQVQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyF2Zbwhy4vpTStZWwiZD3//IS7IxIEf8+38NJRTVllJ8w1ep58
 6CmsLrFC8gSQesqXrJwAP1d3icWXnhvLqexbpxX6a6S3dbu2FB0hZNb3fZTekOVtsicJpowiKSl
 GUx68CdtUSzhTT6YlBGn0MgBLTQP2IAdnX8zScIvPcvqAn8S1lgwErQ5PdUPQgjrRMIjSUiw78h
 /Q7x6Knrajag==
X-Gm-Gg: AR+sD11uJuLy1ZsftFpph6TSOU17v3lgbVm11f7eSMQBlKU433V6um5+zv9jGXO0D++
 vjcYfOo8j7TtyabUsJxl9I9hjGYTO6atfhZYD+zJzu24ILrmPC9TU/PMMC5miscXEw7vw+6uyfW
 7onP1E8ZwrlgaKlWLLVoytQteT2l/VCGyNFcT327gJXaM5F3ktc9l2Eo2sg6Yu8WnZzCmItZ8qN
 iN/8lNh88bOSh2KotoIbZB85ScnlSSFBb9x6SFiOhLrdyfmCaaFRndnQuIG5hXWezGpG4ocReux
 ya4Jq3fzSviwBUYkfzGNZmVDiYZAk75FIxdgyz/gB6kpJEnQaOjgNy1pOQWv01sCkhk26Cg5QNX
 fZ6gHLUnrNx/1sNTf/pOkP7WG4pR5Cg5oXwvk8sQnmiRNGZ7S0h80+7kx3XojzqTm2LA=
X-Received: by 2002:a17:903:15cf:b0:2ca:be8:62d with SMTP id
 d9443c01a7336-2cf349b5923mr199384115ad.32.1784647288330; 
 Tue, 21 Jul 2026 08:21:28 -0700 (PDT)
X-Received: by 2002:a17:903:15cf:b0:2ca:be8:62d with SMTP id
 d9443c01a7336-2cf349b5923mr199383845ad.32.1784647287918; 
 Tue, 21 Jul 2026 08:21:27 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347119dfsm77733775ad.56.2026.07.21.08.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:21:26 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 2/7] binman: Fix FIT image overlap issues
Date: Tue, 21 Jul 2026 15:21:01 +0000
Message-ID: <20260721152110.283998-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721152110.283998-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 15:55:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784647290;
 bh=5Dgq1O/scuCTqPPyFkmjdFDJZP7bULCJScXbLSxo5NE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BfGBZKe/vn1yCvLhU0yR05nUbDFrakeHvxnjvDRTsZ+t9Hy+R2+Onio/c5T34nazh
 UvMxv7tSHeSuCDYphZvYco7JPdH2aVbVTqCpDEhsqY/2bZvJPLcWcOpTIXK2bcxYYf
 PFGaxX6k6XN/EO03IS+UcHsj/n/Rlb77JGEGVpKDB/g21H4WqXOV5C9G+5i1k2c+ac
 C2RVsHQLHxbE/VbvWLjVI/PY1GRmqajPynjSa8K0E2DBQya6WSOPXD2WeKTmrVGR9o
 jV7+YA032TRhbw4++qfzfF9FSvPP+VauvRkVE4cZyIWrIs6L8B/IPp93f07+a4N25w
 zR7nrKA+syNxwjfGB1Y0dEGhpBMI16rCh5drs8vn0Fz4aZKU13HGPelVX6G0vj0amM
 cEyTxp5qBMU9LlemAdN4CyXIqTem26uzhUHcqAtxcpH9i6qsISl2KZvM3GaxxY5e6Y
 hSURFGGVXG43EvEtVlVbE2o2q2B1qOISySRNl7Hgmv852Zp683wFDN5dVZxpVlQhEQ
 vFdkPW4NWhgQakRaEtAw4dq29ERKxpTiqIyZHTDw3aLHOydw8c5PJwtHAOInABI4eS
 bY5795cSLW3TX/iq9RyDXN3d8EPVSXpVmuXQqP5jgtBEZ/dK9f3hx//fXZXbozH69n
 CBaDKxlvKJl9G0lpdfU7A8ZA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=BfGBZKe/
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Several binman test fixtures describe FIT images whose configuration
references both a u-boot firmware image loaded at address 0x0 with a
size of 0x2e bytes and a split-elf atf image whose first segment is
loaded at 0x10, so the two images overlap in memory. The upcoming
mkimage load address overlap check refuses to build such images,
which makes the tests that run these fixtures through mkimage fail.

Move the u-boot load and entry addresses to 0x2000, clear of the atf
segments taken from elf_sections.lds, in the fixtures used by
testFitFirmwareLoadables, testFitSignSimple,
testFitSignNoSignatureNodes, testFitSignEngineSimple,
testFitSignEncryptEngine, testFitSignPKCS11Simple,
testFitSignPKCS11Object, testFitSignMultipleKeyPaths and
testKeyNameHintIsPathSimpleFit.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/test/fit/firmware_loadables.dts             | 4 ++--
 tools/binman/test/fit/key_name_hint_dir_signature.dts    | 4 ++--
 tools/binman/test/fit/signature.dts                      | 4 ++--
 tools/binman/test/fit/signature_engine.dts               | 4 ++--
 tools/binman/test/fit/signature_engine_encrypt.dts       | 4 ++--
 tools/binman/test/fit/signature_engine_pkcs11.dts        | 4 ++--
 tools/binman/test/fit/signature_engine_pkcs11_object.dts | 4 ++--
 tools/binman/test/fit/signature_multi_key.dts            | 4 ++--
 tools/binman/test/fit/signature_no_nodes.dts             | 4 ++--
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/binman/test/fit/firmware_loadables.dts b/tools/binman/test/fit/firmware_loadables.dts
index 2f79cdc9bb8..d344036a11a 100644
--- a/tools/binman/test/fit/firmware_loadables.dts
+++ b/tools/binman/test/fit/firmware_loadables.dts
@@ -19,8 +19,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/key_name_hint_dir_signature.dts b/tools/binman/test/fit/key_name_hint_dir_signature.dts
index 96e2126dadb..33b4ff8ea02 100644
--- a/tools/binman/test/fit/key_name_hint_dir_signature.dts
+++ b/tools/binman/test/fit/key_name_hint_dir_signature.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature.dts b/tools/binman/test/fit/signature.dts
index 9dce62e52de..1c25d52cba4 100644
--- a/tools/binman/test/fit/signature.dts
+++ b/tools/binman/test/fit/signature.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_engine.dts b/tools/binman/test/fit/signature_engine.dts
index fd374e0edd2..ba4df53a0c0 100644
--- a/tools/binman/test/fit/signature_engine.dts
+++ b/tools/binman/test/fit/signature_engine.dts
@@ -21,8 +21,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_engine_encrypt.dts b/tools/binman/test/fit/signature_engine_encrypt.dts
index fbcde342c65..40090431459 100644
--- a/tools/binman/test/fit/signature_engine_encrypt.dts
+++ b/tools/binman/test/fit/signature_engine_encrypt.dts
@@ -22,8 +22,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_engine_pkcs11.dts b/tools/binman/test/fit/signature_engine_pkcs11.dts
index 60ba04c13d4..8d86c994afe 100644
--- a/tools/binman/test/fit/signature_engine_pkcs11.dts
+++ b/tools/binman/test/fit/signature_engine_pkcs11.dts
@@ -21,8 +21,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_engine_pkcs11_object.dts b/tools/binman/test/fit/signature_engine_pkcs11_object.dts
index 5226ab4c6cf..48cd963476d 100644
--- a/tools/binman/test/fit/signature_engine_pkcs11_object.dts
+++ b/tools/binman/test/fit/signature_engine_pkcs11_object.dts
@@ -22,8 +22,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_multi_key.dts b/tools/binman/test/fit/signature_multi_key.dts
index 77bec8df1e5..3b8da190b42 100644
--- a/tools/binman/test/fit/signature_multi_key.dts
+++ b/tools/binman/test/fit/signature_multi_key.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_no_nodes.dts b/tools/binman/test/fit/signature_no_nodes.dts
index 267105d0f68..2ac600b1c70 100644
--- a/tools/binman/test/fit/signature_no_nodes.dts
+++ b/tools/binman/test/fit/signature_no_nodes.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
-- 
2.43.0

