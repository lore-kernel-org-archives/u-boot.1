Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C032C2BD05
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03C888578;
	Fri, 21 Jun 2024 21:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YBi3ag2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321AB8853B; Fri, 21 Jun 2024 21:52:17 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2512884B2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7eba486df76so74188739f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999533; x=1719604333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YY0R8rq6DkuoE0UFDOCcNS0eAuQQ2wEAKvjRBJHMBQI=;
 b=YBi3ag2cu1eNVuGtXQ0vtlXZTJRlhpnPOCeImEIKkCZuY7ptzcbR7wqoLgvOy2p5ty
 VdO/u4x/t7aCZOV31MJzqrppSfepGbLE/OEve0bQqKNuh2rUYKgCZGEgAmuohwoEWBSx
 ppPxeF/0DwEn3Sp92YAtaDeE40e33q7W5GBvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999533; x=1719604333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YY0R8rq6DkuoE0UFDOCcNS0eAuQQ2wEAKvjRBJHMBQI=;
 b=jipcuiwOCy+gNF2rHhIx8WEIH6xmQlEV+aEbsGwvi/qnlcgzc+rYqbDseFP+Hd/zN7
 cb4y2XHb2uGiSgjvC0S8xGxcJ3TGcPURYFnr5xD1FeTt/5VgwTj1cT89Ao2Fl5sIWlT7
 Xzqx8o27Wx3TJdtMoEo9vLoDKALaJf5kBiYhQHiwKkGiwSs7lRITQf33ZB4iW0aROXMz
 p7FLJHc3Jc5XYs1I5q/sDNwsYX+TGpNE1dwqYIdzjV1VyxTjCpoUF2menJagDuRABZ39
 l9CzL7RdU2EqYtkpaXARDuMHe72xFrpYBr3PcVTkOwAY0TtChDOAbWc8W0R5gtWvC4Fl
 nWFQ==
X-Gm-Message-State: AOJu0YyCAMIbmqWFFm8ifPk0m31NeSBzWAmnfC/R3sQeZUqXlZdvRrAH
 etYbETQoN6kYxKV4auNfTpBKB7d3V3IRxupQUb2yE0OBpN2I3U9+rNG37sJFjFLYMkYp05+UaWG
 W5A==
X-Google-Smtp-Source: AGHT+IE9h1higLuuSfxYToVRIki4yyBQ8dDOdp9ntfSpvPLYR+82lYnq2q/jnCRJpo03VbtWL0E+qQ==
X-Received: by 2002:a05:6602:6c15:b0:7eb:ff8b:e25b with SMTP id
 ca18e2360f4ac-7f39ab9fd11mr51926139f.1.1718999533428; 
 Fri, 21 Jun 2024 12:52:13 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 04/43] binman: ti: Regenerate entry docs
Date: Fri, 21 Jun 2024 13:51:25 -0600
Message-Id: <20240621195204.2675252-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

(no changes since v1)

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

