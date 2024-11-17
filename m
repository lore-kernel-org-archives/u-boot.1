Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B13D10F20
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 16:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61DE8917A;
	Sun, 17 Nov 2024 17:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fyycw/35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E1A88F6C; Sun, 17 Nov 2024 17:26:12 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EB56892E5
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 17:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d416a43160so7704156d6.1
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731860769; x=1732465569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tG6rbhyOPoAd+yJyp9cfn3tVhv66O/8TX1Ro2SyrSsw=;
 b=Fyycw/35PRaDg8+orqkgQFDpZuqGEBrsDeIy9PLHBH1D1ZBMrSKSZq77iUTBCngQFd
 WFtiznJ+WsWM1iXQUrowPUn0SeMTCJGa1VSFspSwoKerVnYzzSxDNwJUMSrG2tMHnjuH
 fygtAm5GIOYy3cYtfLUiqHDys9U4mKAbZGO10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731860769; x=1732465569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tG6rbhyOPoAd+yJyp9cfn3tVhv66O/8TX1Ro2SyrSsw=;
 b=dgg7ocvSdbmL/PthyfXhbYNsWhVo0gbTP5r8L6ZXxkZhu4eUsZpA1Kz+iDa0ADNYcr
 0PVTia9Etb/ZhhXerCFRJq+rlkF1jDXGnCqP+61o2CtsPbRq8HOEQf+ENuCZmKqFmgHG
 CGMR3dka19By5pCOExoiBOWEZ1a7OU3uU15/HipsI+ootTo3Yj7bsnb2rYE/4ckD3fDV
 J/tPVIIoWmyOtk30RPHNubKUetzUlaWkMAENLhSExb/iFXExh3ymWTmSHJv2uep/hg4J
 exWsEQcMTWraW48C2yYuHqzwO+NofVKqiiqeI6/d334jbkQC63CTyMdjcIkNr7m0bHdP
 pkow==
X-Gm-Message-State: AOJu0YyZpkE3BnVr2soCoRsoPT4ilLCerIjpeeJ78ISqsMwZllfO7uED
 rHGiMIYpsP+kLdgkEH82nOCDfmSKwiA0npvRtJX3sAXbH+uWT4L+eUYkwKzt+5DNHpBAbxz73/y
 /TXI=
X-Google-Smtp-Source: AGHT+IH8awh7/nbQ84sgwCiItZfJqVpxBiE5pMxoNgymIX432yjVeesc42NAKBpKH5ww938nWe5RFA==
X-Received: by 2002:a05:6214:5289:b0:6d4:c91:56cd with SMTP id
 6a1803df08f44-6d40c915705mr97157546d6.0.1731860769246; 
 Sun, 17 Nov 2024 08:26:09 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35c9acad7sm374736985a.63.2024.11.17.08.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 08:26:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] Azure: Do not run "udelay" test on sandbox
Date: Sun, 17 Nov 2024 10:26:06 -0600
Message-ID: <20241117162606.3212279-1-trini@konsulko.com>
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

With the changes in commit 88db4fc5fec2 ("test: Update time tests to use
unit-test asserts") we now frequently exceed the limit on the udelay
test, leading to false failures in CI. Skip this test.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 .azure-pipelines.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4ecf76eaa0b5..a51db936d83a 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -320,12 +320,14 @@ stages:
       matrix:
         sandbox:
           TEST_PY_BD: "sandbox"
+          TEST_PY_TEST_SPEC: "not udelay"
         sandbox_asan:
           TEST_PY_BD: "sandbox"
           OVERRIDE: "-a ASAN"
           TEST_PY_TEST_SPEC: "version"
         sandbox_clang:
           TEST_PY_BD: "sandbox"
+          TEST_PY_TEST_SPEC: "not udelay"
           OVERRIDE: "-O clang-17"
         sandbox_clang_asan:
           TEST_PY_BD: "sandbox"
@@ -333,8 +335,10 @@ stages:
           TEST_PY_TEST_SPEC: "version"
         sandbox64:
           TEST_PY_BD: "sandbox64"
+          TEST_PY_TEST_SPEC: "not udelay"
         sandbox64_clang:
           TEST_PY_BD: "sandbox64"
+          TEST_PY_TEST_SPEC: "not udelay"
           OVERRIDE: "-O clang-17"
         sandbox_spl:
           TEST_PY_BD: "sandbox_spl"
@@ -351,6 +355,7 @@ stages:
           OVERRIDE: "-a CONFIG_SPL_LOAD_FIT_FULL=y"
         sandbox_flattree:
           TEST_PY_BD: "sandbox_flattree"
+          TEST_PY_TEST_SPEC: "not udelay"
         sandbox_trace:
           TEST_PY_BD: "sandbox"
           BUILD_ENV: "FTRACE=1 NO_LTO=1"
-- 
2.43.0

