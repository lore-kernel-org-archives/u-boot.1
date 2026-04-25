Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9BBFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6911884312;
	Sat, 25 Apr 2026 18:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="isj48dzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF612842EF; Sat, 25 Apr 2026 18:22:46 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E78984308
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7)
 by SA1PR10MB997631.namprd10.prod.outlook.com (2603:10b6:806:4b5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 15:52:44 +0000
Received: from CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Sat, 25 Apr
 2026 04:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIa5NGv8ScZW2smNPL/JZwcWxOY+EnHVYbAkL9Qrh61/qwH4wnEwSLYgzcdS4ygsEV2pYPlagKdEXnqQYZIl2bi4WlVzor+V8+IajSnwmumbdRbPoE5h5OwxWI48mEL9JpyynOSVsj+txp6H1OweuG8CLOyt2hCPg68sZlFyTQ0LucBp8tKhEwqGzm0um8PoYmpQxXnIcWB7mgYGDZ8YQaY78i0ovX+De5I6rH3xkpnvwvAvpt5QBB39W6UKrEFQ6XSaywZ4VkABSbBqnOcnrjmp2eRZ4YG0QPMk/IDlNr0pZZLF6v8ia+xWl215Ok3rToRlYHtAvMGCV9HJ/K0j/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4WMNRQRw0rkO/maAMGlcy9nkGT8Ypn4kPJsMSNzHN0=;
 b=AUwKlH8s04SvgujVPp3cKgdBGBa7wqWkjh4Zt19161PG8i11yke4mBeOU5gFQGeEuJWgo160lreBKzwnhzPMCKYUaA9sZK+Guecd+MARWJ9sTjgIURi0LSyFHs6WbT8LjnDUSLf4geRg1IxhZJNCI2FUAglwPjNeYXCP4yfw8K+22uRu+kxt8hvEVfupcrma/8A/Bjhzi/uN1OOGtMP3nNkzffe49T/OLeTtuvrqqyCfneYIf/UUqd7pdsK3EZ892tOO31Aoti+SBILinqQ9Ne9M4lhxjWydUqDbrpshchk9Y77oiscYrE5Uw3rQhWUreCO5Bh8gz2SSv0ZQpcuJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4WMNRQRw0rkO/maAMGlcy9nkGT8Ypn4kPJsMSNzHN0=;
 b=isj48dzKGJkUeRTLh7jg0yEVKNF711fcDAJzouaabAZ9CjYn/2nnfDmjwQwSQ/337XIUYMPXgE9FOOIZ7WPVtvsBsI9PxNbY3mVJAlQ0T/YwwitAtGO9n+ih4RI3ly1c0fNL3VDwPYErHgXtmzCwpePnapiISjjMIAO1u+fy/NM=
Received: from SA9PR10CA0004.namprd10.prod.outlook.com (2603:10b6:806:a7::9)
 by CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 03:38:18 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::c9) by SA9PR10CA0004.outlook.office365.com
 (2603:10b6:806:a7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 03:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 25 Apr 2026 03:38:18 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:18 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:17 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk862903263; Fri, 24 Apr 2026 22:38:14 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 07/11] binman: openssl: Add boot and load extensions to
 x509 cert
Date: Sat, 25 Apr 2026 09:07:38 +0530
Message-ID: <20260425033742.1519298-8-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CYXPR10MB7924:EE_|SA2PR10MB4809:EE_|SA1PR10MB997631:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3e9a11-7b0f-4932-966b-08dea27c174a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|17002099007|22082099003;
X-Microsoft-Antispam-Message-Info: zGM0BuKEWhEVHIH7ZXy7zOvjww1sIImdTqpCOzOcq6lIb+fmEw/PwIFiZp8w6ZLd9R0osuao2EBWb60frLbphaLXyATP/gU3dmRH63Qg+i2FORr7SScyOGX/x9v8BR4PBma1X638AN3nNRFoeU3189VNIIbKinzcYHlj/vY9EuGIaknt1UwQcg9+/w6YDgYO4tMowpAFdmsk5Mf1JYWsE+znuvpYfGgfhK4lbX/kVKmwjTVFmVUi+6xRJq6xGhgPGafI51EcrcnSkgKXDds94jbXs832czJgi7GQI/73eX5uXvHX3rojnbHvyeqO2rqUqYvSzQ5ysuB0lfbohvl/Xap66eYCLGxUA4VyIQLg7LiLSMVmKO1KPllU5DCf6COsX9Q05lN4a20MkC4wPUw5luVZIgj+KIPiPuwy45FxclvklASOJWPXjhjRDRP/pBdAAKWW4qo9p68sl7VnuqAyGSpNxZKf3FD9x8r0In2Uax4Zzn69ufGleFQhMo7EDpz+PD9pR35uCbqrw4WRfiZ+xX04n5e/n/prX3jUY/Dli+Nw5VCeAtbC6UOWVE6sljIPQThJbS050eLEVTChMi94+wTw9YQJQ1DO8I8zzl7vD2J/NnVHlSSQfLsmYGicrVsYgOutUpcYJpUUmkDXUxzcFUq1APl3OavzI5hzpGCVRWFUrtKg8PvKYHta8e2mUy7aQlOwxjQIKCELLCygRKFkiJMAytiMEBJOtbPietoPx/Y0+zzr4HHGoZNnXEES9TiGEOv2UHnbbixxJ0/JTe2y0A==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(17002099007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Ms2dGmmWYeWYvkxeP/t/920fT2t+m4pj7WWNI7qTPNWCnKNev9crC+8SvoHOmKelv5ksM+uLyRVQu5gxNpSVlyH+TtL3jaARPXfQksa9lGfkaKlq/AWd2HGIUSKrE47si2LCzRW2yR7YRsqGPCw8ODODDsZaeS3yHYAV5lC8htWCpsOQCNVc2ZdUVtQ6XtPAnSH6z25t9uOdcnpxSiHjWXTM7IqQiwnJ1BAvsjkRXuycHJZIL2+FV7DCVYwxtiFdWtwWxIrNb0gRsTIZcdcuZuz9MC1JIrlAxyyTZHgggQExfo4znp9DSA1/dwsrbVjEiFbzPt/jxRT8MEp20bIEL++2pWgF/LwAWmHZxyT3JxdDf/lQjp5e5gIlzodND4xLIOE1vIcw/DaDjLjTlgKspkMPDbinU0i1S5b4XWlcePpzLjQg0jlKoos9WW6a/UH
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:18.2873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3e9a11-7b0f-4932-966b-08dea27c174a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7924
X-OriginatorOrg: ti.com
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

The boot and load extensions in the x509 certificate are required for
requesting the secure entity (TIFS) to boot a core. These fields are
defined in the binman node for each core that must be booted by TIFS
and must be included when generating the signed certificate.

Add support to parse the boot and load extension properties from the
binman node and populate them into the certificate. If any of the
mandatory properties for an extension are missing, that respective
extension section is NOT added to the certificate.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Simon Glass <sjg@chromium.org>

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-8-b-padhi@ti.com/

v3: Changelog:
1. New patch. Add support to sign HSM firmware here in U-Boot.

 tools/binman/btool/openssl.py   | 49 ++++++++++++++++++++++++++++++---
 tools/binman/etype/ti_secure.py | 18 ++++++++++++
 tools/binman/etype/x509_cert.py |  4 ++-
 3 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c447..35898aa488b 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -82,7 +82,8 @@ imageSize              = INTEGER:{len(indata)}
         return self.run_cmd(*args)
 
     def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
-                  config_fname, req_dist_name_dict, firewall_cert_data):
+                  config_fname, req_dist_name_dict, firewall_cert_data,
+                  boot_ext_data, load_ext_data):
         """Create a certificate to be booted by system firmware
 
         Args:
@@ -101,12 +102,52 @@ imageSize              = INTEGER:{len(indata)}
                 extended certificate
               - certificate (str): Extended firewall certificate with
                 the information for the firewall configurations.
+            boot_ext_data (dict):
+              - proc_id (int): The processor ID of core being booted
+              - flags_set (int): The config flags to set for core being booted
+              - flags_clr (int): The config flags to clear for core being booted
+              - reset_vector (int): The location of reset vector for core being
+                booted
+            load_ext_data (dict):
+              - dest_addr (int): The address to which image has to be copied
+              - auth_type (int): Contains the host ID for core being booted and
+                how the image is to be copied
 
         Returns:
             str: Tool output
         """
         indata = tools.read_file(input_fname)
         hashval = hashlib.sha512(indata).hexdigest()
+
+        if boot_ext_data is not None:
+            boot_ext = f'''
+[ sysfw_boot_seq ]
+bootCore = INTEGER:{boot_ext_data['proc_id']}
+bootCoreOpts_set = INTEGER:{boot_ext_data['flags_set']}
+bootCoreOpts_clr = INTEGER:{boot_ext_data['flags_clr']}
+resetVec = FORMAT:HEX,OCT:{boot_ext_data['reset_vector']:08x}
+# Reserved for future use
+flagsValid = FORMAT:HEX,OCT:00000000
+rsvd1 = INTEGER:0x00
+rsdv2 = INTEGER:0x00
+rsdv3 = INTEGER:0x00
+'''
+        else:
+            boot_ext = ""
+
+        if load_ext_data is not None:
+            load_ext = f'''
+[ sysfw_image_load ]
+destAddr = FORMAT:HEX,OCT:{load_ext_data['dest_addr']:08x}
+authInPlace = INTEGER:{load_ext_data['auth_type']}
+'''
+        else:
+            load_ext = f'''
+[ sysfw_image_load ]
+destAddr = FORMAT:HEX,OCT:00000000
+authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
+'''
+
         with open(config_fname, 'w', encoding='utf-8') as outf:
             print(f'''[ req ]
 distinguished_name     = req_distinguished_name
@@ -138,9 +179,9 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
 shaValue               = FORMAT:HEX,OCT:{hashval}
 imageSize              = INTEGER:{len(indata)}
 
-[ sysfw_image_load ]
-destAddr = FORMAT:HEX,OCT:00000000
-authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
+{boot_ext}
+
+{load_ext}
 
 [ firewall ]
 numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index f6caa0286d9..bc44b684892 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -116,6 +116,7 @@ class Entry_ti_secure(Entry_x509_cert):
         if auth_in_place:
             self.firewall_cert_data['auth_in_place'] = auth_in_place
             self.ReadFirewallNode()
+        self.ReadLoadableCoreNode()
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
         self.req_dist_name = {'C': 'US',
                 'ST': 'TX',
@@ -126,6 +127,23 @@ class Entry_ti_secure(Entry_x509_cert):
                 'emailAddress': 'support@ti.com'}
         self.debug = fdt_util.GetBool(self._node, 'debug', False)
 
+    def ReadLoadableCoreNode(self):
+        boot_ext_props = ['proc_id', 'flags_set', 'flags_clr', 'reset_vector']
+        load_ext_props = ['dest_addr', 'auth_type']
+
+        self.boot_ext = self.ReadDictFromList(boot_ext_props)
+        self.load_ext = self.ReadDictFromList(load_ext_props)
+
+    def ReadDictFromList(self, props):
+        props_dict = dict.fromkeys(props)
+        for prop in props:
+            val = fdt_util.GetInt(self._node, prop)
+            if val is None:
+                return None
+            else:
+                props_dict[prop] = val
+        return props_dict
+
     def ReadFirewallNode(self):
         self.firewall_cert_data['certificate'] = ""
         self.firewall_cert_data['num_firewalls'] = 0
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb0..b6028f6be84 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -102,7 +102,9 @@ class Entry_x509_cert(Entry_collection):
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
-                firewall_cert_data=self.firewall_cert_data)
+                firewall_cert_data=self.firewall_cert_data,
+                boot_ext_data=self.boot_ext,
+                load_ext_data=self.load_ext)
         elif type == 'rom':
             stdout = self.openssl.x509_cert_rom(
                 cert_fname=output_fname,
-- 
2.34.1

