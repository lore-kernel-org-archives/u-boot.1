Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F33C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CF982102;
	Mon,  2 Jun 2025 18:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FuOp7H+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C036181D6A; Mon,  2 Jun 2025 18:56:34 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168F181FEE
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552GuTM9211136;
 Mon, 2 Jun 2025 11:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748883389;
 bh=NSZ/oqh1wof1QMwRciRvm/C3DGA0JSP4Hb3x6NLHuYQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=FuOp7H+9REmNCOlyXNtIiidRHFj/JbLaXZ6imbayriIk3UkKZYrNfxq2eOPSphjVj
 aqFoMVg8LeCxvKA3EkAy9AgfkzpQaumFpY+3n3x0N41MFMivBB0PXmN4PpHA1fE3s2
 WWrxG0t71my9aoXXJcuI4lcI8HtSfZ2+Xxr8+/h0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552GuTBq3002894
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 2 Jun 2025 11:56:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 11:56:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 11:56:29 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552GuT8F3252358;
 Mon, 2 Jun 2025 11:56:29 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 2 Jun 2025 11:56:27 -0500
Subject: [PATCH tiU2025.01 2/2] binman: openssl: disable JTAG access by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250602-am62xsip-v1-2-ae8aa62b4b6e@ti.com>
References: <20250602-am62xsip-v1-0-ae8aa62b4b6e@ti.com>
In-Reply-To: <20250602-am62xsip-v1-0-ae8aa62b4b6e@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>
X-Mailer: b4 0.14.2
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

Typically for boards operating in production environments will not be
monitored and so will not need JTAG access unlocked. Disable the debug
extension unless asked for in the binman configs.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/btool/openssl.py       | 16 ++++++++++++----
 tools/binman/etype/ti_secure.py     |  1 +
 tools/binman/etype/ti_secure_rom.py |  1 +
 tools/binman/etype/x509_cert.py     |  7 +++++--
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index 2e128e477bce87568b6d9647bbf2666f9770d732..c91d8990a1dc9151bb8fc831c0f1bff2d91b014e 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -153,7 +153,7 @@ numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
 
     def x509_cert_rom(self, cert_fname, input_fname, key_fname, sw_rev,
                   config_fname, req_dist_name_dict, cert_type, bootcore,
-                  bootcore_opts, load_addr, sha):
+                  bootcore_opts, load_addr, sha, debug):
         """Create a certificate
 
         Args:
@@ -214,9 +214,13 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
  [ swrv ]
  swrv = INTEGER:{sw_rev}
 
+ # When debugging low level boot firmware it can be useful to have ROM or TIFS
+ # unlock JTAG access to the misbehaving CPUs. However in a production setting
+ # this can lead to code modification after it's been authenticated by outside
+ # parties. To gain JTAG access add the 'debug' flag to the binman configuration
  [ debug ]
  debugUID = FORMAT:HEX,OCT:0000000000000000000000000000000000000000000000000000000000000000
- debugType = INTEGER:4
+ debugType = INTEGER:{ "4" if debug else "0" }
  coreDbgEn = INTEGER:0
  coreDbgSecEn = INTEGER:0
 ''', file=outf)
@@ -231,7 +235,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
                   imagesize_sbl, hashval_sbl, load_addr_sysfw, imagesize_sysfw,
                   hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
                   hashval_sysfw_data, sysfw_inner_cert_ext_boot_block,
-                  dm_data_ext_boot_block, bootcore_opts):
+                  dm_data_ext_boot_block, bootcore_opts, debug):
         """Create a certificate
 
         Args:
@@ -317,9 +321,13 @@ compSize = INTEGER:{imagesize_sysfw_data}
 shaType  = OID:{sha_type}
 shaValue = FORMAT:HEX,OCT:{hashval_sysfw_data}
 
+# When debugging low level boot firmware it can be useful to have ROM or TIFS
+# unlock JTAG access to the misbehaving CPUs. However in a production setting
+# this can lead to code modification after it's been authenticated by outside
+# parties. To gain JTAG access add the 'debug' flag to the binman configuration
 [ debug ]
 debugUID = FORMAT:HEX,OCT:0000000000000000000000000000000000000000000000000000000000000000
-debugType = INTEGER:4
+debugType = INTEGER:{ "4" if debug else "0" }
 coreDbgEn = INTEGER:0
 coreDbgSecEn = INTEGER:0
 
diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index 420ee263e4f92727657d949d45a63c99809ecafa..f6caa0286d97c774fa4f2931f82ee9a98677b8d4 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -124,6 +124,7 @@ class Entry_ti_secure(Entry_x509_cert):
                 'OU': 'Processors',
                 'CN': 'TI Support',
                 'emailAddress': 'support@ti.com'}
+        self.debug = fdt_util.GetBool(self._node, 'debug', False)
 
     def ReadFirewallNode(self):
         self.firewall_cert_data['certificate'] = ""
diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
index f6fc3f90f84ab1b0a9c806a966d508abfd6f3eee..7e90c655940902b266507cf142680d984b8d22d4 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -87,6 +87,7 @@ class Entry_ti_secure_rom(Entry_x509_cert):
                     'OU': 'Processors',
                     'CN': 'TI Support',
                     'emailAddress': 'support@ti.com'}
+        self.debug = fdt_util.GetBool(self._node, 'debug', False)
 
     def NonCombinedGetCertificate(self, required):
         """Generate certificate for legacy boot flow
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index 25e6808b7f94cee76e18e2b5de22c09f91e3afd3..b6e8b0b4fb099871d8e7f731ee3e7c5d52e98b85 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -52,6 +52,7 @@ class Entry_x509_cert(Entry_collection):
         self.sysfw_inner_cert_ext_boot_block = None
         self.dm_data_ext_boot_block = None
         self.firewall_cert_data = None
+        self.debug = False
 
     def ReadNode(self):
         super().ReadNode()
@@ -114,7 +115,8 @@ class Entry_x509_cert(Entry_collection):
                 bootcore=self.bootcore,
                 bootcore_opts=self.bootcore_opts,
                 load_addr=self.load_addr,
-                sha=self.sha
+                sha=self.sha,
+                debug=self.debug
             )
         elif type == 'rom-combined':
             stdout = self.openssl.x509_cert_rom_combined(
@@ -140,7 +142,8 @@ class Entry_x509_cert(Entry_collection):
                 hashval_sysfw_data=self.hashval_sysfw_data,
                 sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
                 dm_data_ext_boot_block=self.dm_data_ext_boot_block,
-                bootcore_opts=self.bootcore_opts
+                bootcore_opts=self.bootcore_opts,
+                debug=self.debug
             )
         if stdout is not None:
             data = tools.read_file(output_fname)

-- 
2.49.0

