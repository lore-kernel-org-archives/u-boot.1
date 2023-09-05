Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0992EC83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 08:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092728694A;
	Tue,  5 Sep 2023 10:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JPa745+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 202E98694A; Tue,  5 Sep 2023 10:21:52 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11A048654D
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 10:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3858LkGr014716;
 Tue, 5 Sep 2023 03:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693902106;
 bh=k/IMOvuzTXcDKP86NzqRD2XYGqGEeloa2PSHTwrmtT8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=JPa745+tCgdmbfHiK1QMTk9J9VVsKpgz3HPbp9uHSA7NsGPdJIv9039KmB14eOEof
 6m+yjoqpdFkXWUfP+W2znNNq7wTHtJfEqD/Uq664vYL+SO/PX/KwKdEKhADsLeBsoO
 M/dXNRNEi9WqeF5z7jvcnHeTlij8z/3e4zG6PNDQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3858Lksc014095
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 03:21:46 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 03:21:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 03:21:46 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3858LdLh016284;
 Tue, 5 Sep 2023 03:21:43 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 5 Sep 2023 13:51:34 +0530
Subject: [RFC PATCH 1/2] binman: ti-secure: Add support for firewalling
 entities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230905-binman-firewalling-v1-1-3894520bff8a@ti.com>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
In-Reply-To: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693902099; l=6787;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=o9UDvy0FaiIC0Qgh/0dEfEidSLiXfucU46RuxHHJt80=;
 b=ntrceEzOgYJy5p1FV2P5QPOMd9Vrx0nqM0k1IinNbKxNJh54/uO7+nBwJjHeTbRDU1F7/Jzku
 Vam8boZlzOWClxUdUhA0ICLYscpaQ5HPWvk7Eoy/ALw0/YiWoHqBT4g
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 tools/binman/btool/openssl.py   | 16 ++++++++++--
 tools/binman/etype/ti_secure.py | 54 +++++++++++++++++++++++++++++++++++++++++
 tools/binman/etype/x509_cert.py |  3 ++-
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index aad3b61ae27c..dff439df211f 100644
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
index d939dce57139..a980d10f4197 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -7,9 +7,39 @@
 
 from binman.entry import EntryArg
 from binman.etype.x509_cert import Entry_x509_cert
+from dataclasses import dataclass
 
 from dtoc import fdt_util
 
+def hex_octet(n):
+  x = '%x' % (n,)
+  return ('0' * (len(x) % 2)) + x
+
+@dataclass
+class Firewall():
+    id: int
+    region: int
+    control : int
+    permissions: list[hex]
+    start_address: str
+    end_address: str
+
+    def get_certificate(self) -> str:
+        unique_indentifier = f"{self.id}{self.region}"
+        cert = f"""
+firewallID{unique_indentifier} = INTEGER:{self.id}
+region{unique_indentifier} = INTEGER:{self.region}
+control{unique_indentifier} = INTEGER:{hex(self.control)}
+nPermissionRegs{unique_indentifier} = INTEGER:{len(self.permissions)}
+"""
+        for index, permission in enumerate(self.permissions):
+            cert += f"""permissions{unique_indentifier}{index} = INTEGER:{hex(permission)}
+"""
+        cert += f"""startAddress{unique_indentifier} = FORMAT:HEX,OCT:{hex_octet(self.start_address)}
+endAddress{unique_indentifier} = FORMAT:HEX,OCT:{hex_octet(self.end_address)}
+"""
+        return cert
+
 class Entry_ti_secure(Entry_x509_cert):
     """Entry containing a TI x509 certificate binary
 
@@ -32,11 +62,20 @@ class Entry_ti_secure(Entry_x509_cert):
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
         self.openssl = None
+        self.firewall_cert_data: dict = {
+            'auth_in_place': 0x02,
+            'num_firewalls': 0,
+            'certificate': "",
+        }
 
     def ReadNode(self):
         super().ReadNode()
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
+        auth_in_place = fdt_util.GetInt(self._node, "auth_in_place")
+        if auth_in_place:
+            self.firewall_cert_data['auth_in_place'] = auth_in_place
+            self.ReadFirewallNode()
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
         self.req_dist_name = {'C': 'US',
                 'ST': 'TX',
@@ -46,6 +85,21 @@ class Entry_ti_secure(Entry_x509_cert):
                 'CN': 'TI Support',
                 'emailAddress': 'support@ti.com'}
 
+    def ReadFirewallNode(self):
+        self.firewall_cert_data['certificate'] = ""
+        self.firewall_cert_data['num_firewalls'] = 0
+        for node in self._node.subnodes:
+            firewall = Firewall(
+                 fdt_util.GetInt(node, 'id'),
+                 fdt_util.GetInt(node, 'region'),
+                 fdt_util.GetInt(node, 'control'),
+                 fdt_util.GetPhandleList(node, 'permissions'),
+                 fdt_util.GetInt64(node, 'start_address'),
+                 fdt_util.GetInt64(node, 'end_address'),
+            )
+            self.firewall_cert_data['num_firewalls'] += 1
+            self.firewall_cert_data['certificate'] += firewall.get_certificate()
+
     def GetCertificate(self, required):
         """Get the contents of this entry
 
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index d028cfe38cd9..9e1cf479023b 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -98,7 +98,8 @@ class Entry_x509_cert(Entry_collection):
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
2.41.0

