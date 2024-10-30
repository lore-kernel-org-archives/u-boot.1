Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B602D3A667
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 09:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAEB4891EB;
	Wed, 30 Oct 2024 10:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Rxwv0Zs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B83891D2; Wed, 30 Oct 2024 09:08:07 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04DF388E77
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 09:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4qysthYBMw53zF55VkMvxTwXNplo7wAaFSfq79WMPkwc/na5nJjsE2r65n9i1oP/r2ppAzRFTm7jBl3YP/mYxrfnEJBB8d6SjgMJaiAJ7GMfUouKUzUBFzYWNHi1ejQ35tnr//TppYPvT+e+cfcFSW1xThX+D8eD01S35HkFVoBeZvkXpEvSRFcvLu9PxgfhTymk9Zn4Zf5xloWuaxbMBXsJ6uH2lEgTpgxTckVj4dlgQKcT/Mu/MLIEaJxLrDqfgicBjvBVdx7KrAlGfCAqA975KatPUSKm49daDtB+LiFeoWsUOzv9xVvl74HuNGV5JBNBQQJAVA8TKq6P6qWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp0ltjuBsw8DvAUm9dogDF49429MRE8JZSwWdE7Rzi4=;
 b=HNO2FsrzEeh7YrQPY8TgVpes1u2OOAcNqtpuE4ih9HMKI6u1Za9k1ECwKslhBe5iX54FyDen0e/kZESOhG4vyXGIsPsvlCnXPPC22J172GYVAk0PTLwldb4MUY2bn5SFLmf3KkT4lcpR6025r3NwsyzO2rq0z/OD+Ok70Qvyss2ncriotOyA/3qRAbjuqyUEFPrFlJpuirkwIwkJ6YFcsURP9HlYmMA9vCc2cH997TjWeAAGiotI3lN1Uw5WNNtzpjovJlFdIBKVqw3O9rOgvsi6yXgkqfAHrqeY3cxcsg8aXmCrF+oTmZucH3smkjGXW8B20ZQLkD1/mr0Nx91cUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp0ltjuBsw8DvAUm9dogDF49429MRE8JZSwWdE7Rzi4=;
 b=Rxwv0Zs1SsKeri1gEB5eWAeRgeQLEaULID02pZuIxAjGfy3eydtxuope5qfyxej5HWqLxwCsAoH8b3f/X5Q21I1NCRhCTbVsvHywgT9t1sMEImIaeQfcQQ3jwnsERYBkHowPnrnZNH3+gosXoPylDbEP62qbwE+Y2E/53cb5Prif3FlnOQcRLmTviaQwOSrNTODr+RGym75yGbb3Edb0lxUaUQ6HhNLu9xFknSrC7zBbLyz2oOJ5pBXltwjXi5pDyi3GKM1WdmKzJio4ElJ0JMk9B8Gsu7HTy6vOzOfJnV5sURPQUrsntarg1T6I+Km3Rt7iR02crtTlWAPngqCrgA==
Received: from BL1PR13CA0243.namprd13.prod.outlook.com (2603:10b6:208:2ba::8)
 by SJ2PR22MB4714.namprd22.prod.outlook.com (2603:10b6:a03:58d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 08:07:58 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::d9) by BL1PR13CA0243.outlook.office365.com
 (2603:10b6:208:2ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.15 via Frontend
 Transport; Wed, 30 Oct 2024 08:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 08:07:57 +0000
Received: from zoo11.em.health.ge.com (unknown [10.168.174.93])
 by builder1.em.health.ge.com (Postfix) with ESMTP id 3DEE09E1A;
 Wed, 30 Oct 2024 10:07:55 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: festevam@gmail.com, ian.ray@gehealthcare.com,
 Brian Ruley <brian.ruley@gehealthcare.com>, u-boot@lists.denx.de
Subject: [PATCH v4 1/2] binman: nxp_imx8mcst: read certificates from input path
Date: Wed, 30 Oct 2024 10:07:51 +0200
Message-Id: <20241030080753.129-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241021073749.63-1-brian.ruley@gehealthcare.com>
References: <20241021073749.63-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SJ2PR22MB4714:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eec215b6-4f8f-4d23-b8f1-08dcf8b9f72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cxSDaZws9oAbrDKNp+ErzHyCIxeBC6Q3J1gpNaBA6a23u3iRRZ8DDjfhylp5?=
 =?us-ascii?Q?q1ozVyN51ZDyQjY6yZdov/DuZv8yO4Mj8Svg37JJs8iYNKos9R5E9eCP+9JX?=
 =?us-ascii?Q?eEe6PpmC2BkAnnK4hqtcCr3KSYkd4gSZsZzJpD9dh//ORJbspV9ogRRMKuJu?=
 =?us-ascii?Q?G/w29PquxLmltS6CbsnxFBVspSPOcr9kmgIHNfx/cIHXR7+cQECd/CVXcQLo?=
 =?us-ascii?Q?Nzty5xaOfAA4pbgMqz0fbWQN36xAvV/B8CAnoFddQUKi6MJZFHBHnt+a58xV?=
 =?us-ascii?Q?LX5mob7Kq36RJQxv/93MByVoTnoPx5r5+EWD/4eWNlFOqaZ1G3lk8BwKm4iR?=
 =?us-ascii?Q?8v6KGzfgtLHosqkfEtC3b3lTWOQM0xQY4lje88MXWRFdCpYBLNTT0pb4+aSi?=
 =?us-ascii?Q?UJ7LmELUCn4GGLc35yx5t1gKfwh+OJXIMXTg6NIbpYO2veZEdmQq6tsSTzOH?=
 =?us-ascii?Q?ZaJcgb2wuYPtr+unklkABDv12otymbpdyh2P8P+vEEX56CCp0xP8/hWEgCk8?=
 =?us-ascii?Q?fr4ISNIeINsn+wKgFSO2iZjuFMYYpJTHub/D4UxmClkDJZ6sylqW6WUlTjjR?=
 =?us-ascii?Q?79bqQ+/YdOuvNiqMySyoawsYMntPwBIIuNjPv0i8oZ5LpBIVWGXHdVzdTAPK?=
 =?us-ascii?Q?aF9AbPvBFV49xARq+aEPZL0y2AKS6cSSa8hto0zw3WVrUqV8m261WKXRFeGs?=
 =?us-ascii?Q?gD8VFFoEq/Pqs9x0g9Xmm9TPq5gnQ61+WYMe+6LiHv1Ipf8ohKyNm5BlPzHW?=
 =?us-ascii?Q?Fuqy4Uo5ncwJbGscxkGEbioOHD2FatQpdAVr8bE+lqeXnrlC+afhOsa+o99M?=
 =?us-ascii?Q?AX0toccD4J6blQQDiQulhwrQ1DOj+ZgZi4bMLpo/dKoMwvLnGxqaq/vUfQjc?=
 =?us-ascii?Q?f7YLX56f4+qdYtkdYvwXOKFtzw22shr/cfVkixuU2ZJBokdtZTZ9CUiQgTHs?=
 =?us-ascii?Q?LwIzgT1TNSBzsfJOwb5TEa+thnlQNspNNIrRVuhPPAvWj86BTUbWqdPvqdvH?=
 =?us-ascii?Q?quJ2IBv9L9q9sIKG6B1mgxN0dKGZHkIFB/6P5z6t94e0KVrQZZWnMhRY0ThF?=
 =?us-ascii?Q?JvsYg/65hSssAm+3zHAR3LZaSCCP8fuHfRB9rcfEGNKrVkpjYHPmR2bvYzZL?=
 =?us-ascii?Q?1TnPu4OWH4l59YJv6hQ+fZCwPm2AGVxbsb5gCxU2OfoDx4jeHDJL09UNCvQ7?=
 =?us-ascii?Q?AKGAemiaVy7jQf0NYlDgbPS8QcfHMFMSaIbWTrvtHh5BkBmCzQR0mXm/uDza?=
 =?us-ascii?Q?2adFyvWDU29x/vWipkdZ5CRJkYmHFn5JHtfzjaNDyNK9ZsT9iWvBlHFwNLew?=
 =?us-ascii?Q?MK8jjUnyW7wW3la2Gnddm/unhIBzlCMJJstYGphJTsUDQtFG7pXl+AQxSPjF?=
 =?us-ascii?Q?7A0l3CDmF7CrZqklMtPElrLhTZ/153pWN1SJopPCgmMOWI4OPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 08:07:57.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec215b6-4f8f-4d23-b8f1-08dcf8b9f72b
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4714
X-Mailman-Approved-At: Wed, 30 Oct 2024 10:00:23 +0100
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

Right now, it is unclear where the certificates (and private keys) are
read from if environment variables are unset, and providing complete
paths in the device tree is not ideal. Naturally, it makes sense
to be able to decide where binman should look for the files, regardless
whether the keys are specified in the device tree or not.

Therefore, expand the etype to look for the necessary files from the
input path. Introduce a new variable to provide users the ability to
specify a custom path.

As a consequence of this change, the environment variables used to
specify the keys, e.g., `IMG_KEY', will be searched *relative* to the
input directories.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
Changes for v2:
- Added missing *.pem files
- Rebased on top of "[PATCH v4 2/2] binman: add fast authentication
  method for i.MX8M signing"
- Included a test for fast authentication
Changes for v3:
- Fixed relative path for SRK table and *.pem files in
  340_nxp_imx8mcst.dts
Changes for v4:
- Rebased on master

 tools/binman/etype/nxp_imx8mcst.py | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index a7d8db4eec..ff84b751b7 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -70,23 +70,26 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
         self.required_props = ['nxp,loader-address']
+        self._cst_key_path = os.getenv('CST_KEY_PATH', None)
+        if self._cst_key_path:
+            tools.set_input_dirs([self._cst_key_path] + tools.indir)
 
     def ReadNode(self):
         super().ReadNode()
         self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
-        self.srk_table = os.getenv(
+        self._srk_table = os.getenv(
             'SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table',
                                             'SRK_1_2_3_4_table.bin'))
         self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
         if not self.fast_auth:
-            self.csf_crt = os.getenv(
+            self._csf_crt = os.getenv(
                 'CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt',
                                               f'CSF1_1_{KEY_NAME}.pem'))
-            self.img_crt = os.getenv(
+            self._img_crt = os.getenv(
                 'IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt',
                                               f'IMG1_1_{KEY_NAME}.pem'))
         else:
-            self.srk_crt = os.getenv(
+            self._srk_crt = os.getenv(
                 'SRK_KEY', fdt_util.GetString(self._node, 'nxp,srk-crt',
                                               f'SRK1_{KEY_NAME}.pem'))
 
@@ -142,15 +145,19 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         config.optionxform = str
         # Load configuration template and modify keys of interest
         config.read_string(CSF_CONFIG_TEMPLATE)
-        config['Install SRK']['File']  = f'"{self.srk_table}"'
+        srk_table = tools.get_input_filename(self._srk_table)
+        config['Install SRK']['File']  = f'"{srk_table}"'
         if not self.fast_auth:
+            csf_crt = tools.get_input_filename(self._csf_crt)
+            img_crt = tools.get_input_filename(self._img_crt)
             config.remove_section('Install NOCAK')
-            config['Install CSFK']['File'] = f'"{self.csf_crt}"'
-            config['Install Key']['File']  = f'"{self.img_crt}"'
+            config['Install CSFK']['File'] = f'"{csf_crt}"'
+            config['Install Key']['File']  = f'"{img_crt}"'
         else:
+            srk_crt = tools.get_input_filename(self._srk_crt)
             config.remove_section('Install CSFK')
             config.remove_section('Install Key')
-            config['Install NOCAK']['File'] = f'"{self.srk_crt}"'
+            config['Install NOCAK']['File'] = f'"{srk_crt}"'
             config['Authenticate Data']['Verification index'] = '0'
 
         config['Authenticate Data']['Blocks'] = \
-- 
2.39.5

