Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD760C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 17:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CBD98215B;
	Mon,  5 May 2025 19:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a8DcMPag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411D682161; Mon,  5 May 2025 19:46:09 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EFA8210D
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 19:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 545Hk3Io835876
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 May 2025 12:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746467163;
 bh=qskVEGH1c2EugITw3tY1hOBn2qX0BBJqRgbq5ZuXdsE=;
 h=From:To:CC:Subject:Date;
 b=a8DcMPag7k+bL4E8alnEyckDCJNvh6D9lVFG94SJPQjYLPKrxqY1Ye/+1jF4QrCX8
 rK/AbYSuAG/DPX299VZ7MEe6z+Uf/hkBIyzoNXLPBBRLGYQLRI/B/mPpdr3pWFuc8L
 nM2m68yESILNE6xRtCggKiMQgONjqQwwCb9g1LWU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 545Hk3s3103870
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 May 2025 12:46:03 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 May 2025 12:46:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 May 2025 12:46:03 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 545Hk2ch061328;
 Mon, 5 May 2025 12:46:02 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Prashant Shivhare
 <p-shivhare@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] board: ti: sec-cfg.yaml: Fix OTP write_host_id order
Date: Mon, 5 May 2025 12:46:01 -0500
Message-ID: <20250505174601.273860-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The write_host_id is the last element here and order does matter. This
may have gone unnoticed before as by default all elements are 0, but
if this is updated to a different host, it will not work. Update
the order so write_host_id is the last element in all current secure
board configs.

Reported-by: Prashant Shivhare <p-shivhare@ti.com>
Signed-off-by: Andrew Davis <afd@ti.com>
---
 board/beagle/beagleplay/sec-cfg.yaml     | 2 +-
 board/beagle/beagley-ai/sec-cfg.yaml     | 2 +-
 board/phytec/phycore_am62ax/sec-cfg.yaml | 2 +-
 board/phytec/phycore_am62x/sec-cfg.yaml  | 2 +-
 board/phytec/phycore_am64x/sec-cfg.yaml  | 2 +-
 board/ti/am62ax/sec-cfg.yaml             | 2 +-
 board/ti/am62px/sec-cfg.yaml             | 2 +-
 board/ti/am62x/sec-cfg.yaml              | 2 +-
 board/ti/am64x/sec-cfg.yaml              | 2 +-
 board/ti/am65x/sec-cfg.yaml              | 2 +-
 board/ti/j7200/sec-cfg.yaml              | 2 +-
 board/ti/j721s2/sec-cfg.yaml             | 2 +-
 board/ti/j722s/sec-cfg.yaml              | 2 +-
 board/ti/j784s4/sec-cfg.yaml             | 2 +-
 board/toradex/verdin-am62/sec-cfg.yaml   | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/board/beagle/beagleplay/sec-cfg.yaml b/board/beagle/beagleplay/sec-cfg.yaml
index 088b2dbaf11..3686ddf6bdf 100644
--- a/board/beagle/beagleplay/sec-cfg.yaml
+++ b/board/beagle/beagleplay/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/beagle/beagley-ai/sec-cfg.yaml b/board/beagle/beagley-ai/sec-cfg.yaml
index a41374b30c9..e9a9d526cfb 100644
--- a/board/beagle/beagley-ai/sec-cfg.yaml
+++ b/board/beagle/beagley-ai/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/phytec/phycore_am62ax/sec-cfg.yaml b/board/phytec/phycore_am62ax/sec-cfg.yaml
index ae6939eee9a..ce7a1d66dc5 100644
--- a/board/phytec/phycore_am62ax/sec-cfg.yaml
+++ b/board/phytec/phycore_am62ax/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/phytec/phycore_am62x/sec-cfg.yaml b/board/phytec/phycore_am62x/sec-cfg.yaml
index 088b2dbaf11..3686ddf6bdf 100644
--- a/board/phytec/phycore_am62x/sec-cfg.yaml
+++ b/board/phytec/phycore_am62x/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/phytec/phycore_am64x/sec-cfg.yaml b/board/phytec/phycore_am64x/sec-cfg.yaml
index b61551c3208..2cb1298c4a6 100644
--- a/board/phytec/phycore_am64x/sec-cfg.yaml
+++ b/board/phytec/phycore_am64x/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
                 subhdr:
                         magic: 0x4081
                         size: 69
-                write_host_id: 0
                 otp_entry:
                         -  # 1
                                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
                         -  # 32
                                 host_id: 0
                                 host_perms: 0
+                write_host_id: 0
         dkek_config:
                 subhdr:
                         magic: 0x5170
diff --git a/board/ti/am62ax/sec-cfg.yaml b/board/ti/am62ax/sec-cfg.yaml
index ae6939eee9a..ce7a1d66dc5 100644
--- a/board/ti/am62ax/sec-cfg.yaml
+++ b/board/ti/am62ax/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/ti/am62px/sec-cfg.yaml b/board/ti/am62px/sec-cfg.yaml
index 46be354972a..bfd6a4e5dbd 100644
--- a/board/ti/am62px/sec-cfg.yaml
+++ b/board/ti/am62px/sec-cfg.yaml
@@ -247,7 +247,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -345,6 +344,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/ti/am62x/sec-cfg.yaml b/board/ti/am62x/sec-cfg.yaml
index 088b2dbaf11..3686ddf6bdf 100644
--- a/board/ti/am62x/sec-cfg.yaml
+++ b/board/ti/am62x/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/ti/am64x/sec-cfg.yaml b/board/ti/am64x/sec-cfg.yaml
index b61551c3208..2cb1298c4a6 100644
--- a/board/ti/am64x/sec-cfg.yaml
+++ b/board/ti/am64x/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
                 subhdr:
                         magic: 0x4081
                         size: 69
-                write_host_id: 0
                 otp_entry:
                         -  # 1
                                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
                         -  # 32
                                 host_id: 0
                                 host_perms: 0
+                write_host_id: 0
         dkek_config:
                 subhdr:
                         magic: 0x5170
diff --git a/board/ti/am65x/sec-cfg.yaml b/board/ti/am65x/sec-cfg.yaml
index 2ee503bace3..4e1abb774c9 100644
--- a/board/ti/am65x/sec-cfg.yaml
+++ b/board/ti/am65x/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/ti/j7200/sec-cfg.yaml b/board/ti/j7200/sec-cfg.yaml
index 4726ac24a38..36ba89410ce 100644
--- a/board/ti/j7200/sec-cfg.yaml
+++ b/board/ti/j7200/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
                 subhdr:
                         magic: 0x4081
                         size: 69
-                write_host_id: 0
                 otp_entry:
                         -  # 1
                                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
                         -  # 32
                                 host_id: 0
                                 host_perms: 0
+                write_host_id: 0
         dkek_config:
                 subhdr:
                         magic: 0x5170
diff --git a/board/ti/j721s2/sec-cfg.yaml b/board/ti/j721s2/sec-cfg.yaml
index d0f3a161a7d..02029918613 100644
--- a/board/ti/j721s2/sec-cfg.yaml
+++ b/board/ti/j721s2/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/ti/j722s/sec-cfg.yaml b/board/ti/j722s/sec-cfg.yaml
index a41374b30c9..e9a9d526cfb 100644
--- a/board/ti/j722s/sec-cfg.yaml
+++ b/board/ti/j722s/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/ti/j784s4/sec-cfg.yaml b/board/ti/j784s4/sec-cfg.yaml
index 9a1c1ef2201..b744777db2d 100644
--- a/board/ti/j784s4/sec-cfg.yaml
+++ b/board/ti/j784s4/sec-cfg.yaml
@@ -249,7 +249,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -347,6 +346,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
diff --git a/board/toradex/verdin-am62/sec-cfg.yaml b/board/toradex/verdin-am62/sec-cfg.yaml
index 088b2dbaf11..3686ddf6bdf 100644
--- a/board/toradex/verdin-am62/sec-cfg.yaml
+++ b/board/toradex/verdin-am62/sec-cfg.yaml
@@ -248,7 +248,6 @@ sec-cfg:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id: 0
         otp_entry:
             -  # 1
                 host_id: 0
@@ -346,6 +345,7 @@ sec-cfg:
             -  # 32
                 host_id: 0
                 host_perms: 0
+        write_host_id: 0
     dkek_config:
         subhdr:
             magic: 0x5170
-- 
2.39.2

