Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879D1EE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 718BB8412A;
	Wed, 31 Dec 2025 18:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Lu+XiEpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9696584118; Wed, 31 Dec 2025 18:36:59 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD6C84120
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9S+XVaeaDep78pbg0LStEdDtnUOFOhrN5ai1OLYJ9VDJWK8esl70fGjl1maEbNWQFW63mu0do2llzkMBAL85Wcuxmu2FcJI/r416g+rL1nsdkUWzc+y6rHdUFa1IcGxNN34LLQX4AztylvWp89mzelKthUgMHeTWCbKdwKaNpi1XdCmoTAL2dUtYrxJ/hK1XXg75/WoLj6grZT7xQ0Tr4sztApCxGJ3qKEZKjC0N3Nlr6KCxYDmw8VWqe+fUaDZnTg3GRLXx7cRc2TkgvlyiNjmYi7sXhuEkV+DOpgoj+8//3MoIsNLvBuIi4wKXlHRYXWqwu+pSiQ2s9LzOle/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n36EZkl3VwByKY78xguNxc0ZUGqNSvs5tHN+48ugwe0=;
 b=Wsc1ejc4Z1ZLIibMloOtSjmG6zRhUuUS5y0xyK9KOrzUWVnrqR01NfLsdFQ/XmLVl/bcn1vmosOoUMxNRpwQM6QzfQPM3GBzRM0smlc5v8LuvwlkhMGrlO3j8dSZTyxMHQ36BDVYq6Ub/i64fBbkCyihkpwdSdagoVOveknXS5QFvXSxibd24w6ZuDLLqnkeLVSNcDrk0Qfc+cCmvftrNcuwrmEFV0BCdjokM5Gm2JXlvLlFA9ffCDcdrmuW+SaPfSb4wLdrg1SoLRKyWT2kzrZ/l6zRd3YAQDrhMnhp1t+7+jT+sgymXKl4W66XA9jsxZaaUuYv0tvDmMMQi0LK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n36EZkl3VwByKY78xguNxc0ZUGqNSvs5tHN+48ugwe0=;
 b=Lu+XiEpC3+B4xRQ7dT1ziXn50Z0hVkdyVuOtW3XD95S051dWtCZVbSfYaTHk4nvFLaQfll0to3mRfdgIHzUM0KUd+qo7HBGnCO5vw2rcwZF8cHRBE0eEQgbJH4EYJqyu4EY0ppWIKICXWggEoI6BaCM62r8UuejiKW/6uc9nSxM=
Received: from CH2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:610:51::31)
 by DS5PR10MB997730.namprd10.prod.outlook.com (2603:10b6:8:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:36:55 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::34) by CH2PR15CA0021.outlook.office365.com
 (2603:10b6:610:51::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:36:53 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:53 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:52 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:52 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOqw2541396;
 Wed, 31 Dec 2025 11:36:50 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 07/11] binman: openssl: Add boot and load extensions to
 x509 cert
Date: Wed, 31 Dec 2025 23:06:17 +0530
Message-ID: <20251231173621.1069988-8-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DS5PR10MB997730:EE_
X-MS-Office365-Filtering-Correlation-Id: 143a7b7b-5173-465e-cb36-08de48932ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JJhOxSglT4jv0vMVoWdFr15woEciznQ3HFKFk4Y+upNigIF/SkT+yvIX4pLa?=
 =?us-ascii?Q?hXrJMua4PTwtXACIoiApLSUpxhLFVyCsVWeTkVOAFjgQt8gxJY5UHnqIq9nX?=
 =?us-ascii?Q?xvCj4scuu9jFr2A+8wyOdtPINtqz7h2Y+Mq38IGnSn4E3A8oSDyw7NBKQrzb?=
 =?us-ascii?Q?ngRoDriJzCzybm1oID7QoH5fVA0ax1jTk7Brvuy+roCBbFq2B1BYUKXHqBoB?=
 =?us-ascii?Q?3/7KRmtAY0yvC6MzNL1t+T3KAKTd0if3BJnlQ4t2UYt9kfNwYQCPP83dnFrE?=
 =?us-ascii?Q?+XbxhoEtX7hwDE5ltPVh+KduwXUAdnNwmCaS9k81nAwIw+9rcldJpHf83nfR?=
 =?us-ascii?Q?bTUyzxPjX2s9llKgntIrVXvtRim9BzMpAXz6MLdY327I2K8PW2QpvcpWrAXL?=
 =?us-ascii?Q?e1oOj7ic7qeLdUpoQlIFgw7xfSwzeZ3wxNyz0oJQKEujvfTh0RR8tCyz8CqG?=
 =?us-ascii?Q?F8GdfK7YYw2f9ZiucSuE6QuDeOSCWRGHbaKTBcr8lZrfG3vllbCVz9lQjd5b?=
 =?us-ascii?Q?A/qMoFejHFHl5ts2NSSU49pAXNufdi+SL4cdSAaYJfbvvBb9imLJfiSSgeAp?=
 =?us-ascii?Q?Jy7IN1c82dfxUjzUNZVa73e/oruM/Jrg407A+LmOhmqrm1gvhQmhKSi+b2Hu?=
 =?us-ascii?Q?jfjnUY9xvOgXYPomj4yd1+NHFMf04YGnfcSCnhjzb/aCT34IZZA9t+nwUXBK?=
 =?us-ascii?Q?fzGpOQVyjiY5hSP8YLTOVLLhHArh8LcyjV21uYIS4KjBlTi3ac0VJ0xDyWFD?=
 =?us-ascii?Q?qxbPlc3MFFKyt16qbS3xmiIX0abvHkduCPEMo5sdcyZLac4X4wsXZtWwN6rB?=
 =?us-ascii?Q?LWY8uGYZYThsCHUMvMKjAdLTrg0jLgvrfcZyqQKSNXZsFKku6u079CwUfsa1?=
 =?us-ascii?Q?y1tjqVwdX60DJrp2gma+/H95j9eHkbaNr4r2FJE6BcvbvJVGvM4jE4G3vVdz?=
 =?us-ascii?Q?200vKO6a1Idb05zbzAkYfNR+rpVrm8SAEcNm3MdN6u3N1GU3uKNV6EBkjzsZ?=
 =?us-ascii?Q?GxuHzJng87Org/YLPGarrZ9iA6lo3Ydvxqb65fRAMXmOocvwRNWGmONz4SRU?=
 =?us-ascii?Q?nNPdnST8DTE4jph6WGUddWRoLTr3lELMmZ+uy/4A64s1wF7XoWnXG9s+gbZc?=
 =?us-ascii?Q?sF6ZmoPKzzN+Yzi6J33nm/auc4PGiGuSbum5Ky1bBlJKFrfdD28Z0qN+iedp?=
 =?us-ascii?Q?jz9XOvTpC6R7hz/Lbxkm1JAo9RiGOwThGbpT025rhsF+zh3w/hHliLBvwDVP?=
 =?us-ascii?Q?AN1/QkYBMW+n2bJZ1QH9yKDOGzQpg5evb+vmxuwNLSPcF2r53JKVBtYw8Phz?=
 =?us-ascii?Q?YpRv/f8WxWLbedELyTntQ47RZt9EioovYg8ZXx4o2ZhMd4ylgiUzMst+m8h4?=
 =?us-ascii?Q?dapHxkwH0LIibqS/LpdlF7KpIv3AnR+YUnQtPjwqjk0SkZIjoNCUvavOrO4L?=
 =?us-ascii?Q?gK6hWh0YebM40GA/wv6SrpDGnRuBdOpL8NBr28OAiIsSNvfa/rxoH6pW+XJp?=
 =?us-ascii?Q?I9UI/jHUUnMv+Xy7P/v8hlw4LK0WRiviX5CdyBzOSGKf2ARCBifn1faKEnyv?=
 =?us-ascii?Q?gCTZuUONdVe1jXTBKYo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:36:53.4683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143a7b7b-5173-465e-cb36-08de48932ffb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997730
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

