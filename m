Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C8EC54E5D
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 10:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27CC87D06;
	Sat, 16 Mar 2024 11:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="L7UoZQAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9193287D06; Sat, 16 Mar 2024 11:09:44 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F0587C68
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 11:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A985941E32; 
 Sat, 16 Mar 2024 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710583781;
 bh=9efknwjTF7BdkSwQ6guWK9OYcog9yW8Cocy2dYAzIeg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=L7UoZQAOWwspKqWpwUy1DCGH5CY/KLhtPmWQah9XVsjx+NxT2mzxpZ5Oh2/62tRgX
 ZC3nLOfJ+XXhzbac7LqANLbyAd6n1KyhEehvdqyMJs+9q5U80cvXMoioijkk350AFV
 orapzrirDGwpNvmjfOI+P95LDmhUWaWvLW6cLX5D9LE2SyJeBjQAuLM76GVPdsNUlU
 QNcTcTYEjS3T354xFqHydDjb117sNl9M22zjwbchxqQG0zIoL7mE2qCVcPgfPnBhf9
 japBHOr4Vw6GpuV0mVrgpXLBZqrmll8Dc2wh7Z9jJ3lsmTKiEyOylbXx/1oVgpiaTs
 atQb7lqiNR4IQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: typo Synopis
Date: Sat, 16 Mar 2024 11:09:36 +0100
Message-ID: <20240316100936.59818-1-heinrich.schuchardt@canonical.com>
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

%s/Synopis/Synopsis/g

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/acpi.rst      | 4 ++--
 doc/usage/cmd/bootdev.rst   | 4 ++--
 doc/usage/cmd/bootflow.rst  | 4 ++--
 doc/usage/cmd/bootmeth.rst  | 4 ++--
 doc/usage/cmd/cbsysinfo.rst | 4 ++--
 doc/usage/cmd/cedit.rst     | 4 ++--
 doc/usage/cmd/cli.rst       | 4 ++--
 doc/usage/cmd/dm.rst        | 4 ++--
 doc/usage/cmd/fdt.rst       | 4 ++--
 doc/usage/cmd/font.rst      | 4 ++--
 doc/usage/cmd/for.rst       | 4 ++--
 doc/usage/cmd/history.rst   | 4 ++--
 doc/usage/cmd/host.rst      | 4 ++--
 doc/usage/cmd/md.rst        | 4 ++--
 doc/usage/cmd/mtrr.rst      | 4 ++--
 doc/usage/cmd/panic.rst     | 4 ++--
 doc/usage/cmd/part.rst      | 4 ++--
 doc/usage/cmd/sf.rst        | 4 ++--
 doc/usage/cmd/sm.rst        | 4 ++--
 doc/usage/cmd/trace.rst     | 4 ++--
 doc/usage/cmd/ut.rst        | 4 ++--
 21 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/doc/usage/cmd/acpi.rst b/doc/usage/cmd/acpi.rst
index a630f1ec5e3..9f30972fe53 100644
--- a/doc/usage/cmd/acpi.rst
+++ b/doc/usage/cmd/acpi.rst
@@ -6,8 +6,8 @@
 acpi command
 ============
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
index 658020e7c7f..f759abab354 100644
--- a/doc/usage/cmd/bootdev.rst
+++ b/doc/usage/cmd/bootdev.rst
@@ -6,8 +6,8 @@
 bootdev command
 ===============
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
index 16ba986dc8a..6519e4880a9 100644
--- a/doc/usage/cmd/bootflow.rst
+++ b/doc/usage/cmd/bootflow.rst
@@ -6,8 +6,8 @@
 bootflow command
 ================
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/bootmeth.rst b/doc/usage/cmd/bootmeth.rst
index 95651fdc7c5..2903977ee54 100644
--- a/doc/usage/cmd/bootmeth.rst
+++ b/doc/usage/cmd/bootmeth.rst
@@ -6,8 +6,8 @@
 bootmeth command
 ================
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/cbsysinfo.rst b/doc/usage/cmd/cbsysinfo.rst
index 8c03a85169d..80d8ba1b662 100644
--- a/doc/usage/cmd/cbsysinfo.rst
+++ b/doc/usage/cmd/cbsysinfo.rst
@@ -3,8 +3,8 @@
 cbsysinfo
 =========
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index b39d708281d..5670805a00e 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -6,8 +6,8 @@
 cedit command
 =============
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/cli.rst b/doc/usage/cmd/cli.rst
index 81487722f69..23e5ee7a902 100644
--- a/doc/usage/cmd/cli.rst
+++ b/doc/usage/cmd/cli.rst
@@ -6,8 +6,8 @@
 cli command
 ===========
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/dm.rst b/doc/usage/cmd/dm.rst
index 9bef2eeaed8..7651507937a 100644
--- a/doc/usage/cmd/dm.rst
+++ b/doc/usage/cmd/dm.rst
@@ -6,8 +6,8 @@
 dm command
 ==========
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/fdt.rst b/doc/usage/cmd/fdt.rst
index 3e8c32cdea3..71a9fc627e5 100644
--- a/doc/usage/cmd/fdt.rst
+++ b/doc/usage/cmd/fdt.rst
@@ -6,8 +6,8 @@
 fdt command
 ===========
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/font.rst b/doc/usage/cmd/font.rst
index adcd5126d0a..a8782546333 100644
--- a/doc/usage/cmd/font.rst
+++ b/doc/usage/cmd/font.rst
@@ -6,8 +6,8 @@
 font command
 ============
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/for.rst b/doc/usage/cmd/for.rst
index 4c98419b28f..729bd4db43c 100644
--- a/doc/usage/cmd/for.rst
+++ b/doc/usage/cmd/for.rst
@@ -4,8 +4,8 @@
 for command
 ===========
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/history.rst b/doc/usage/cmd/history.rst
index 564a1596655..b52b5b220ae 100644
--- a/doc/usage/cmd/history.rst
+++ b/doc/usage/cmd/history.rst
@@ -6,8 +6,8 @@
 history command
 ===============
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/host.rst b/doc/usage/cmd/host.rst
index 072497db903..a70a432b6f2 100644
--- a/doc/usage/cmd/host.rst
+++ b/doc/usage/cmd/host.rst
@@ -6,8 +6,8 @@
 host command
 ============
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/md.rst b/doc/usage/cmd/md.rst
index 9ea148a8dca..9a9919f9ad0 100644
--- a/doc/usage/cmd/md.rst
+++ b/doc/usage/cmd/md.rst
@@ -6,8 +6,8 @@
 md command
 ==========
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/mtrr.rst b/doc/usage/cmd/mtrr.rst
index c65618950bc..3c5c3ba3d43 100644
--- a/doc/usage/cmd/mtrr.rst
+++ b/doc/usage/cmd/mtrr.rst
@@ -6,8 +6,8 @@
 mtrr command
 ============
 
-Synopis
--------
+Synopsis
+--------
 
     mtrr [list]
     mtrr set <reg> <type> <start> <size>
diff --git a/doc/usage/cmd/panic.rst b/doc/usage/cmd/panic.rst
index ba5ea626108..39d32adbc99 100644
--- a/doc/usage/cmd/panic.rst
+++ b/doc/usage/cmd/panic.rst
@@ -6,8 +6,8 @@
 panic command
 =============
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index 58be38781e3..e7faeccbb09 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -6,8 +6,8 @@
 part command
 ============
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/sf.rst b/doc/usage/cmd/sf.rst
index 24d5dc692db..dfdca46e66c 100644
--- a/doc/usage/cmd/sf.rst
+++ b/doc/usage/cmd/sf.rst
@@ -6,8 +6,8 @@
 sf command
 ==========
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
index b767647d772..e828fddc519 100644
--- a/doc/usage/cmd/sm.rst
+++ b/doc/usage/cmd/sm.rst
@@ -6,8 +6,8 @@
 sm command
 ==========
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/trace.rst b/doc/usage/cmd/trace.rst
index ad6db123942..e798b2bbc6b 100644
--- a/doc/usage/cmd/trace.rst
+++ b/doc/usage/cmd/trace.rst
@@ -6,8 +6,8 @@
 trace command
 =============
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
diff --git a/doc/usage/cmd/ut.rst b/doc/usage/cmd/ut.rst
index ddc48ec42dd..45bc9ffbdc5 100644
--- a/doc/usage/cmd/ut.rst
+++ b/doc/usage/cmd/ut.rst
@@ -6,8 +6,8 @@
 ut command
 ==========
 
-Synopis
--------
+Synopsis
+--------
 
 ::
 
-- 
2.43.0

