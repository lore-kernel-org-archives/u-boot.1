Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93D2C46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3139D87A54;
	Fri, 29 Dec 2023 11:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ln7fSxnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465ED87AFC; Fri, 29 Dec 2023 11:46:48 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0303C87A54
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkf5i075605;
 Fri, 29 Dec 2023 04:46:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846801;
 bh=0eo7H+eEyYJehf0oLYRCFdKSH4wkzWD5HaQ6hB/uNtM=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=ln7fSxnCGTlEWKw6opiAQzQudFMk4BVla7kvoBOHqFhTVwqFPsMd46+K345+CA+7d
 nS7q1YsGG3Bi9FkGvXCXYOoWIc6fJtPnnRS6iRCTv6+s55Qv5vP60aRun3DT4CF0Fv
 cZen1CtK8rfbcXXzt62XDTJJ3P/JmNjyU6FaElYY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAkf42065749
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:46:41 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:46:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:46:40 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7g072641;
 Fri, 29 Dec 2023 04:46:37 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 29 Dec 2023 16:16:26 +0530
Subject: [PATCH v7 2/9] binman: ti-secure: Add support for firewalling entities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231229-binman-firewalling-v7-2-47ed4af303fe@ti.com>
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
In-Reply-To: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=9653;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=7U9LmEFvs9YBCRicK/QfHLia0nv/zet1Br58i19fql8=;
 b=qwMXyMIEm5dYVYs7UgIdBGboX1CqhtpF9/JRY2dfIdLQTQMk8HS2Qrf9GfTKbRy1Z+xfCMaWM
 HaJ5i9Wqaw/B0hd998SXDw6ldqvFGI+mp2YHB4mgbvq62DwJ08A7DMZ
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

We can now firewall entities while loading them through our secure
entity TIFS, the required information should be present in the
certificate that is being parsed by TIFS.

The following commit adds the support to enable the certificates to be
generated if the firewall configurations are present in the binman dtsi
nodes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 tools/binman/btool/openssl.py   | 16 ++++++-
 tools/binman/etype/ti_secure.py | 95 +++++++++++++++++++++++++++++++++++++++++
 tools/binman/etype/x509_cert.py |  4 +-
 3 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index 7ee2683ab236..fe81a1f51b1e 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -82,7 +82,7 @@ imageSize              = INTEGER:{len(indata)}
         return self.run_cmd(*args)
 
     def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
-                  config_fname, req_dist_name_dict):
+                  config_fname, req_dist_name_dict, firewall_cert_data):
         """Create a certificate to be booted by system firmware
 
         Args:
@@ -94,6 +94,13 @@ imageSize              = INTEGER:{len(indata)}
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
             req_distinguished_name section extensions, must contain extensions for
             C, ST, L, O, OU, CN and emailAddress
+            firewall_cert_data (dict):
+              - auth_in_place (int): The Priv ID for copying as the
+                specific host in firewall protected region
+              - num_firewalls (int): The number of firewalls in the
+                extended certificate
+              - certificate (str): Extended firewall certificate with
+                the information for the firewall configurations.
 
         Returns:
             str: Tool output
@@ -121,6 +128,7 @@ basicConstraints       = CA:true
 1.3.6.1.4.1.294.1.3    = ASN1:SEQUENCE:swrv
 1.3.6.1.4.1.294.1.34   = ASN1:SEQUENCE:sysfw_image_integrity
 1.3.6.1.4.1.294.1.35   = ASN1:SEQUENCE:sysfw_image_load
+1.3.6.1.4.1.294.1.37   = ASN1:SEQUENCE:firewall
 
 [ swrv ]
 swrv = INTEGER:{sw_rev}
@@ -132,7 +140,11 @@ imageSize              = INTEGER:{len(indata)}
 
 [ sysfw_image_load ]
 destAddr = FORMAT:HEX,OCT:00000000
-authInPlace = INTEGER:2
+authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
+
+[ firewall ]
+numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
+{firewall_cert_data['certificate']}
 ''', file=outf)
         args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
                 '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index d939dce57139..704dcf8a3811 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -7,9 +7,44 @@
 
 from binman.entry import EntryArg
 from binman.etype.x509_cert import Entry_x509_cert
+from dataclasses import dataclass
 
 from dtoc import fdt_util
 
+@dataclass
+class Firewall():
+    id: int
+    region: int
+    control : int
+    permissions: list
+    start_address: str
+    end_address: str
+
+    def ensure_props(self, etype, name):
+        missing_props = []
+        for key, val in self.__dict__.items():
+            if val is None:
+                missing_props += [key]
+
+        if len(missing_props):
+            etype.Raise(f"Subnode '{name}' is missing properties: {','.join(missing_props)}")
+
+    def get_certificate(self) -> str:
+        unique_identifier = f"{self.id}{self.region}"
+        cert = f"""
+firewallID{unique_identifier} = INTEGER:{self.id}
+region{unique_identifier} = INTEGER:{self.region}
+control{unique_identifier} = INTEGER:{hex(self.control)}
+nPermissionRegs{unique_identifier} = INTEGER:{len(self.permissions)}
+"""
+        for index, permission in enumerate(self.permissions):
+            cert += f"""permissions{unique_identifier}{index} = INTEGER:{hex(permission)}
+"""
+        cert += f"""startAddress{unique_identifier} = FORMAT:HEX,OCT:{self.start_address:02x}
+endAddress{unique_identifier} = FORMAT:HEX,OCT:{self.end_address:02x}
+"""
+        return cert
+
 class Entry_ti_secure(Entry_x509_cert):
     """Entry containing a TI x509 certificate binary
 
@@ -17,6 +52,11 @@ class Entry_ti_secure(Entry_x509_cert):
         - content: List of phandles to entries to sign
         - keyfile: Filename of file containing key to sign binary with
         - sha: Hash function to be used for signing
+        - auth-in-place: This is an integer field that contains two pieces
+          of information
+            Lower Byte - Remains 0x02 as per our use case
+            ( 0x02: Move the authenticated binary back to the header )
+            Upper Byte - The Host ID of the core owning the firewall
 
     Output files:
         - input.<unique_name> - input file passed to openssl
@@ -25,6 +65,35 @@ class Entry_ti_secure(Entry_x509_cert):
         - cert.<unique_name> - output file generated by openssl (which is
           used as the entry contents)
 
+    Depending on auth-in-place information in the inputs, we read the
+    firewall nodes that describe the configurations of firewall that TIFS
+    will be doing after reading the certificate.
+
+    The syntax of the firewall nodes are as such:
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
@@ -32,11 +101,20 @@ class Entry_ti_secure(Entry_x509_cert):
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
         self.openssl = None
+        self.firewall_cert_data: dict = {
+            'auth_in_place': 0x02,
+            'num_firewalls': 0,
+            'certificate': '',
+        }
 
     def ReadNode(self):
         super().ReadNode()
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
+        auth_in_place = fdt_util.GetInt(self._node, 'auth-in-place')
+        if auth_in_place:
+            self.firewall_cert_data['auth_in_place'] = auth_in_place
+            self.ReadFirewallNode()
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
         self.req_dist_name = {'C': 'US',
                 'ST': 'TX',
@@ -46,6 +124,23 @@ class Entry_ti_secure(Entry_x509_cert):
                 'CN': 'TI Support',
                 'emailAddress': 'support@ti.com'}
 
+    def ReadFirewallNode(self):
+        self.firewall_cert_data['certificate'] = ""
+        self.firewall_cert_data['num_firewalls'] = 0
+        for node in self._node.subnodes:
+            if 'firewall' in node.name:
+                firewall = Firewall(
+                     fdt_util.GetInt(node, 'id'),
+                     fdt_util.GetInt(node, 'region'),
+                     fdt_util.GetInt(node, 'control'),
+                     fdt_util.GetPhandleList(node, 'permissions'),
+                     fdt_util.GetInt64(node, 'start_address'),
+                     fdt_util.GetInt64(node, 'end_address'),
+                )
+                firewall.ensure_props(self, node.name)
+                self.firewall_cert_data['num_firewalls'] += 1
+                self.firewall_cert_data['certificate'] += firewall.get_certificate()
+
     def GetCertificate(self, required):
         """Get the contents of this entry
 
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index fc0bb1227867..29630d1b86c8 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -51,6 +51,7 @@ class Entry_x509_cert(Entry_collection):
         self.hashval_sysfw_data = None
         self.sysfw_inner_cert_ext_boot_block = None
         self.dm_data_ext_boot_block = None
+        self.firewall_cert_data = None
 
     def ReadNode(self):
         super().ReadNode()
@@ -98,7 +99,8 @@ class Entry_x509_cert(Entry_collection):
                 key_fname=self.key_fname,
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
-                req_dist_name_dict=self.req_dist_name)
+                req_dist_name_dict=self.req_dist_name,
+                firewall_cert_data=self.firewall_cert_data)
         elif type == 'rom':
             stdout = self.openssl.x509_cert_rom(
                 cert_fname=output_fname,

-- 
2.43.0

