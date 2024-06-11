Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49F9C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E6BE8872B;
	Tue, 11 Jun 2024 22:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SAvMfsoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F8A88715; Tue, 11 Jun 2024 22:02:21 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BB688707
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-371c97913cdso24384945ab.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136138; x=1718740938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8nnk5jWdK3zZ581gHeC46n7Pfv/XYLITCis/5YnFTE=;
 b=SAvMfsoe8Ac80U6nL9c4gpq/lQz77jm2gdL4ts5OZPQbP8QxIUqIdRm18Wdx2uR1/5
 KYx8N5sTXUejKslTySfIGsbeVixdJ8wtRYCtLOSTU6vmNyM/0mEvBDrUxCh5slpN4I/Y
 mWpo26Gdw4qLJNkQDtoFchVqBFIA1PW1flqWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136138; x=1718740938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8nnk5jWdK3zZ581gHeC46n7Pfv/XYLITCis/5YnFTE=;
 b=q8t3d1llYbusJE1KIJ+9FlvLVeybxYhHRDBCjQHCtmuQ8PN7paVvjot47Qy0CPFX5I
 7dEjBCa7cgfYrFBMGWSo10DbX7FvUk+ZiFI3zpDQdlIFOh4rmL7ltJwhG92uQA/5rmQu
 zYbGhXcW9sb487q9I3mSf6wmcj7iFuSrHfoHM93BWESKk8MStxDtbZ69zUQYLehO1E8b
 hPB6JbV9Afi7YuR4T8ZBX24GujICjgrN4i8lXS+Ljk9jFulOPCgMT1xAq9rxOyR6U1FU
 z3NBKPyMcyg1sampicfrSdGWgStRxqI0PiuzBlSEweUtWbS7ka8qs0kuuxg6uiczgqC8
 Djdg==
X-Gm-Message-State: AOJu0YwqZcXGY3N+bjly1JaGtKMmPeMrexkA0VPfc/pfkMuJq/qNoGv9
 2B7YeytQIEvtBniQNQE0isju9vMDJWyaRTrmQU1QP9vBiBhxrYP/F2sX0IThUQhmwv0CXFu7m2A
 BYg==
X-Google-Smtp-Source: AGHT+IGOH6jX5317ACskWsO4dciHGtiKiXoIm++DfN94JWBjziiPrTq613jo09ki9vgA4i0acVEt8w==
X-Received: by 2002:a92:cdae:0:b0:375:adcd:e6db with SMTP id
 e9e14a558f8ab-375adcde918mr51905065ab.9.1718136137764; 
 Tue, 11 Jun 2024 13:02:17 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 04/42] binman: ti: Regenerate entry docs
Date: Tue, 11 Jun 2024 14:01:18 -0600
Message-Id: <20240611200156.2245525-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

Correct formatting errors in the documentation.

Regenerate the entries.rst file to include this recent addition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entries.rst        | 35 +++++++++++++++++++++++++
 tools/binman/etype/ti_secure.py | 45 +++++++++++++++++----------------
 2 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index ecccf77d112..f59c0341840 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1958,6 +1958,12 @@ Properties / Entry arguments:
     - content: List of phandles to entries to sign
     - keyfile: Filename of file containing key to sign binary with
     - sha: Hash function to be used for signing
+    - auth-in-place: This is an integer field that contains two pieces
+      of information:
+
+        - Lower Byte - Remains 0x02 as per our use case
+          ( 0x02: Move the authenticated binary back to the header )
+        - Upper Byte - The Host ID of the core owning the firewall
 
 Output files:
     - input.<unique_name> - input file passed to openssl
@@ -1966,6 +1972,35 @@ Output files:
     - cert.<unique_name> - output file generated by openssl (which is
       used as the entry contents)
 
+Depending on auth-in-place information in the inputs, we read the
+firewall nodes that describe the configurations of firewall that TIFS
+will be doing after reading the certificate.
+
+The syntax of the firewall nodes are as such::
+
+    firewall-257-0 {
+        id = <257>;           /* The ID of the firewall being configured */
+        region = <0>;         /* Region number to configure */
+
+        control =             /* The control register */
+            <(FWCTRL_EN | FWCTRL_LOCK | FWCTRL_BG | FWCTRL_CACHE)>;
+
+        permissions =         /* The permission registers */
+            <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
+                        FWPERM_SECURE_PRIV_RWCD |
+                        FWPERM_SECURE_USER_RWCD |
+                        FWPERM_NON_SECURE_PRIV_RWCD |
+                        FWPERM_NON_SECURE_USER_RWCD)>;
+
+        /* More defines can be found in k3-security.h */
+
+        start_address =        /* The Start Address of the firewall */
+            <0x0 0x0>;
+        end_address =          /* The End Address of the firewall */
+            <0xff 0xffffffff>;
+    };
+
+
 openssl signs the provided data, using the TI templated config file and
 writes the signature in this entry. This allows verification that the
 data is genuine.
diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index 704dcf8a381..420ee263e4f 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -53,10 +53,11 @@ class Entry_ti_secure(Entry_x509_cert):
         - keyfile: Filename of file containing key to sign binary with
         - sha: Hash function to be used for signing
         - auth-in-place: This is an integer field that contains two pieces
-          of information
-            Lower Byte - Remains 0x02 as per our use case
-            ( 0x02: Move the authenticated binary back to the header )
-            Upper Byte - The Host ID of the core owning the firewall
+          of information:
+
+            - Lower Byte - Remains 0x02 as per our use case
+              ( 0x02: Move the authenticated binary back to the header )
+            - Upper Byte - The Host ID of the core owning the firewall
 
     Output files:
         - input.<unique_name> - input file passed to openssl
@@ -69,29 +70,29 @@ class Entry_ti_secure(Entry_x509_cert):
     firewall nodes that describe the configurations of firewall that TIFS
     will be doing after reading the certificate.
 
-    The syntax of the firewall nodes are as such:
+    The syntax of the firewall nodes are as such::
 
-    firewall-257-0 {
-        id = <257>;           /* The ID of the firewall being configured */
-        region = <0>;         /* Region number to configure */
+        firewall-257-0 {
+            id = <257>;           /* The ID of the firewall being configured */
+            region = <0>;         /* Region number to configure */
 
-        control =             /* The control register */
-            <(FWCTRL_EN | FWCTRL_LOCK | FWCTRL_BG | FWCTRL_CACHE)>;
+            control =             /* The control register */
+                <(FWCTRL_EN | FWCTRL_LOCK | FWCTRL_BG | FWCTRL_CACHE)>;
 
-        permissions =         /* The permission registers */
-            <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
-                        FWPERM_SECURE_PRIV_RWCD |
-                        FWPERM_SECURE_USER_RWCD |
-                        FWPERM_NON_SECURE_PRIV_RWCD |
-                        FWPERM_NON_SECURE_USER_RWCD)>;
+            permissions =         /* The permission registers */
+                <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
+                            FWPERM_SECURE_PRIV_RWCD |
+                            FWPERM_SECURE_USER_RWCD |
+                            FWPERM_NON_SECURE_PRIV_RWCD |
+                            FWPERM_NON_SECURE_USER_RWCD)>;
 
-        /* More defines can be found in k3-security.h */
+            /* More defines can be found in k3-security.h */
 
-        start_address =        /* The Start Address of the firewall */
-            <0x0 0x0>;
-        end_address =          /* The End Address of the firewall */
-            <0xff 0xffffffff>;
-    };
+            start_address =        /* The Start Address of the firewall */
+                <0x0 0x0>;
+            end_address =          /* The End Address of the firewall */
+                <0xff 0xffffffff>;
+        };
 
 
     openssl signs the provided data, using the TI templated config file and
-- 
2.34.1

