Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675F3D3B982
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 22:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A5A8394E;
	Tue,  9 Dec 2025 23:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GTJIeC+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB5983A71; Tue,  9 Dec 2025 23:32:51 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA136836C8
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 23:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 28D463F7D5; 
 Tue,  9 Dec 2025 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765319562;
 bh=DkS/TPNCrOVM7UDHRrzrfif/hg3LwhCThP17t3pSods=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GTJIeC+g1ZQYXfv8JPt+wa9P9N1vuqVsxWbQwoF5e5z68UJMOzMTdStgoHkv4TT1S
 ZWnwogd6e80dDcqCSf6WCHa4vLlp0/JTd3dNIghsLPFgQLLF6FYgnKZYVbYzyAtN0x
 Wmw5IIshH9XwCxCL8XGOVWG8eyAxSOpGJyenFVLgghNhkwcBcZuPuWYSQ2IOTTN5RG
 bSEOZoooO2+HFXb9mpfUXrIypiWorCPPrkgZDt0NPpCop+9m/kLA1WeLHNhv1sqo5C
 wNwt24YBRiNuHxz52fKeyTfhN0y0Xwp/Iu3AdFrv+aJM5hD05fGW7Olyg/S9U5W85N
 XlhLB4feklLiJm21HMdkYVXKRy90anoJps9hH65RLqtG/T0fmQ43CbEFfItDm8bkaF
 7tvFNVUfjuAsYCxo+2Bpar8WrbcOK+SNnKwFL4hkdLBgOFUTYRRDrMOeKu7bW2UlG4
 tc2ZMhRur94FYGV1lwtRjXoCOZNMKV1IuJQZzS2pGmn4LDATbi1+ZIoR/9c+95obOn
 vi+HRcx9I0kpEFXT7lJyLPzrk6GCH/lkeJoVdcrx2A2Gs326IufqjiTPsc664L0p1U
 750HoB862mLzvXVA4uzTfnAM7S6ebhQpwBBaJcDyiRGWvzfzUxbrVzrut3CGdKC12F
 BB95I2aA2aY1VBhm9BU4rP+E=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools: use setuptools 78.1.1
Date: Tue,  9 Dec 2025 23:32:38 +0100
Message-ID: <20251209223238.415022-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

CVE-2025-47273 describes a path traversal vulnerability.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/binman/pyproject.toml       | 2 +-
 tools/buildman/pyproject.toml     | 2 +-
 tools/dtoc/pyproject.toml         | 2 +-
 tools/patman/pyproject.toml       | 2 +-
 tools/u_boot_pylib/pyproject.toml | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
index ba34437fc53..7c9ab0f2a27 100644
--- a/tools/binman/pyproject.toml
+++ b/tools/binman/pyproject.toml
@@ -1,5 +1,5 @@
 [build-system]
-requires = ["setuptools>=61.0"]
+requires = ["setuptools>=78.1.1"]
 build-backend = "setuptools.build_meta"
 
 [project]
diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.toml
index 68bfa45c3f4..274042df155 100644
--- a/tools/buildman/pyproject.toml
+++ b/tools/buildman/pyproject.toml
@@ -1,5 +1,5 @@
 [build-system]
-requires = ["setuptools>=61.0"]
+requires = ["setuptools>=78.1.1"]
 build-backend = "setuptools.build_meta"
 
 [project]
diff --git a/tools/dtoc/pyproject.toml b/tools/dtoc/pyproject.toml
index 9f59788e616..cc96cf784c6 100644
--- a/tools/dtoc/pyproject.toml
+++ b/tools/dtoc/pyproject.toml
@@ -1,5 +1,5 @@
 [build-system]
-requires = ["setuptools>=61.0"]
+requires = ["setuptools>=78.1.1"]
 build-backend = "setuptools.build_meta"
 
 [project]
diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
index 06e169cdf48..91802c8cc27 100644
--- a/tools/patman/pyproject.toml
+++ b/tools/patman/pyproject.toml
@@ -1,5 +1,5 @@
 [build-system]
-requires = ["setuptools>=61.0"]
+requires = ["setuptools>=78.1.1"]
 build-backend = "setuptools.build_meta"
 
 [project]
diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index ce2355084ac..a860d134551 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -1,5 +1,5 @@
 [build-system]
-requires = ["setuptools>=61.0"]
+requires = ["setuptools>=78.1.1"]
 build-backend = "setuptools.build_meta"
 
 [project]
-- 
2.51.0

