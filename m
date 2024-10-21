Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DA2D15D89
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 13:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B5F588E42;
	Mon, 21 Oct 2024 15:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="yqJL2ZVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05540892D9; Mon, 21 Oct 2024 09:38:04 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E239F892AB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idyBwiIJ6dJ5PcznUhqf+k0nMeFOds5fVG6CeZEW5gMx43R86fhPNc0jjLL7hZWdoLgJ9YW9k6W3P2Epe83zxh8QrbaexbFucJzmnRKqQ4FACBPU1a59rxgkfFB3DrjUTswDhtVPZCIW/Rd5L2YKPcYQX12g5JtSJvddPYU//0n1tGa/6YP6PxfWwZOaiAuxk6iA+oYa6C0Y2xkzzry2Vc2ss/SAg8baRUJfEqEDiLKpyqaT3P/97E57mQWZQe3EFkXkYlDUvjzeq/4M25+Jq6Rz8AlW9U+oNYEr38qUMHNt1E4uiIYP5mhs0dVo54SwX3VnCVGJ+4f6T3j/gWOQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWAKXuDKyofXSoIDv0JxU3SlR5izpe24n49oexipdEU=;
 b=XuoEb504KVsyVgFX0SngZ6OBfEJCHczNoezJhWCcULwUR8bVnlnJkJntX7o8yiE40E3Ct0/t/d9bguczrlTuVJ+eVwQ2DlSGlsMeYzZCyqSNCNGy5Z2UE5aawLLe8lsDh5+oDRZyNB2eHSdEAZaTGxrTT6nEvqfiRSdz7vRjfxbtV9LliSLGeZNC+uU/pO1TniVtgHREjz0qPKJ3PWh1M9XHQyNdBg8c581hu9lJpwtB14W+POzVLZUical0R2tryj/qaipiOYtKDIMRezctR/VESKQ5LFX+2Bm2F0kE/FEbPtCOQA2GSAX+hNVOvA1gyT2OSVg4DR0dWnLtTa9FVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWAKXuDKyofXSoIDv0JxU3SlR5izpe24n49oexipdEU=;
 b=yqJL2ZVCS2SBtrGYfP4iPuC9J6eHTtMORZHQllh9T+JTWN+T09/UyV51uttdgM3/pE4PfPCSvGeiBRK5XpYdVwr6lPQE8AjoQF7yUXslNnOglM4Xn728j+gyU1FK6ovDpswBXCNCGv3y2UMYw0x8bMqTHM//6hDSaRj05ZeArMiQxy+OCxuJRGseU43Go2mdh6RoDqtUSNZOZ7dgYVRk4PWZe+IDmiAfIKKIKZJrQMHZiUUZN/y7xiWy3WayawwJ1mmlQBd/1yF6Xs7OKitQEhiJSxpXSKJ8PmUdFKBsv49PAO2IBrBUE+/KGCL0VwNRbMGakJw0jnN5fu31heVFWw==
Received: from CH0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:610:b1::19)
 by PH0PR22MB3982.namprd22.prod.outlook.com (2603:10b6:510:2a2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 07:37:58 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::4b) by CH0PR13CA0014.outlook.office365.com
 (2603:10b6:610:b1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.14 via Frontend
 Transport; Mon, 21 Oct 2024 07:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 07:37:57 +0000
Received: from zoo11.em.health.ge.com (unknown [10.168.174.93])
 by builder1.em.health.ge.com (Postfix) with ESMTP id 8E3BB1A2DF;
 Mon, 21 Oct 2024 10:37:55 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: ian.ray@gehealthcare.com, Brian Ruley <brian.ruley@gehealthcare.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 1/2] binman: nxp_imx8mcst: read certificates from input path
Date: Mon, 21 Oct 2024 10:37:47 +0300
Message-Id: <20241021073749.63-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
References: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH0PR22MB3982:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a87d392-c422-4064-dc80-08dcf1a34863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UiBlZHaEnzahHe6qQ7hNiukdUhcWjJSeaHXh/nwBX7LC5dbQrA3ZR/C4x1Kx?=
 =?us-ascii?Q?hWFmbWFIJDf0pDPvw64caRNBL46OoV+yvD4TVp7HMOdInmCONAAevLfP8xc2?=
 =?us-ascii?Q?QQMevhzm0qtKx1fmM9LP4xj/vYySCqTekeWrtDk1OlcTrSVq+gjd8+b7Iefs?=
 =?us-ascii?Q?pMoa+NLUjPcCCylLL0aIdTbN7mNv0yW5oJeaYOf7Is2W5ltiapuKMVZ05Agk?=
 =?us-ascii?Q?gMFWWQikFgZxmMxYRHbdE7E6cMVdmpy3JqljozlUeQRKcmkIxkCUQLtdAI0b?=
 =?us-ascii?Q?W6Vpwd4gdEzV1pQwVf6FgMECAuPa9HKawpgf2Zv8Hh/16ZQ4mevOgbFqky8r?=
 =?us-ascii?Q?e+q8ltJkJ+wuChEbCj0J5zu801rGB3s4RTXLI3hYIlQAhFOH/ZbUv0DXRZ4F?=
 =?us-ascii?Q?VlPN6XbpZV7lkuMLwbv+0lRPQLuW2aEgN0PGfGX9l0vhVFsyCed3n0VGwoym?=
 =?us-ascii?Q?9M6cm1Gd3iY1FdLFXZlrMAyPc4MvICrH23P4WuQpOrPgRt5fTfFEJMWuBhdb?=
 =?us-ascii?Q?lv00hRc9nyUbhJrcOJE+fQpNRiHECs+DALuAquWTXpq1AKbNSI9wsHFgBB6X?=
 =?us-ascii?Q?NzRa4j1eCFuK1Yr/DFFtONW/2wq3umhD1zIXluAz/oa8fKVFMwz7rYLTXO4I?=
 =?us-ascii?Q?EvTJbkDDXnnclFtB9bfHvi4q3mOdTEauqxHdD6oCjrxg2Q6lLcCtoWsp3nOz?=
 =?us-ascii?Q?TG8z76ZKxHQxHw2Fo0qvRhVSjMZdEIW4WFF4FLA7fWKr5/WsehTeR4tUJJvw?=
 =?us-ascii?Q?ly5pAJa8Y2zXORHoLpmBjJ4bi8eQJqg8934jFgnAUlqLT7TPd6LwjQWuJ8x/?=
 =?us-ascii?Q?NH54EEu4lzbpmAtRAv56C6rGE7oEE6jc4JAoyN4ilgZyI1mAcgObq3oQgNOQ?=
 =?us-ascii?Q?uIRReJ7Qe0kZilMbOuKIBG2DFAWqg50z3yyTY17dZ+LMA+sEBtUXgDSGK2XO?=
 =?us-ascii?Q?I4WwmOjH4CJvkuz7CxDn9WBkL49ClCr35lDhGFwoNCJlCW3HkmMBmGjUxaYM?=
 =?us-ascii?Q?HNSpUODJuNVc7ZUDHuGllS7cv0cBJvBq/MpnjtOzXBu5C2wju0FSAdSeEvgQ?=
 =?us-ascii?Q?mz6d9FVyJIVMYAUJ+0aaPqMxSCLMS5ZoQtYDDPVcjUEogiM3y6a50pW+LLbC?=
 =?us-ascii?Q?0pPL+fmXlnzeN0ewpJiNVFmIRXNJF4fBpW5WasdAy2HDbAXP9hY0dPiblkK5?=
 =?us-ascii?Q?BfqPoCfX5wyzopSoQgKvh3jRvGdEaW8Qwrh0VJ8AzL60TTj/J609iYrzAkKP?=
 =?us-ascii?Q?iStgsmZ7Ui7bkxYIt9ywx/6+yQodz1Owp3AA2yclA1nsJfm4rGgF93xU+wzF?=
 =?us-ascii?Q?RKiOJucPruUQauY0dFGyBlnhkDu/UMr4S/q/s06COvFlvxGSvSWb7UiqZMGO?=
 =?us-ascii?Q?imnVmvcyI7nLB/OF7EOg7BfdXeukVfVhG9b4Wi7NZHShJJwKVg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 07:37:57.5141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a87d392-c422-4064-dc80-08dcf1a34863
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3982
X-Mailman-Approved-At: Mon, 21 Oct 2024 15:02:15 +0200
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

