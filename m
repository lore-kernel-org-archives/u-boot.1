Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B21C4451B
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E1A84E55;
	Fri, 17 Jul 2026 15:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ON+Y/v0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C7484E55; Fri, 17 Jul 2026 15:58:50 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3910D84E64
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CByshIZ6TSrIVgOyb4SYoLLD9AHX8CsUF8tOEFw1G8+/n+E6IOGCcVUIqjcb0Dva1JZrt4jluRP/22N0EK+aFhNNMnwtLkcewt5YMlj1Les3xW7f7dF1U+HzIgIfDXk+1P+ryo72g7gdoC2pZeuXmsv0cXzq0qGXLIqZ7DqlIi7e+2n2fIZ9yTmFrhHwmciMSKWbfosu5BTeOJsPL9HtOPnLqSq7fJ7HpF2+9mcJ7A04l4gmnpBy5MopCVivTFW8fThFLZ1GZ5PR3pQxmQQVXKcBDF4QeE0O/QfAXdDisWQJMZ/I+VpK+EXt+aZcqrkXBmlRfehTpmXauAPdWqRwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AFVz0q+/cxfV86NcFGRZjNmVXaxZjE0t2WVjoCag38=;
 b=ku9/RrQJ6VxfxIfB6xQ0i67toW3Yg8ymTg348EoIHpiJsuMHM8aWI9dvv54hj46BgA1C0E6eayiSEnJlU7VdGCO1IJtqfFsh7qwJtcYYo5dEZvoYc9jHNwvCXRdlAihD9vfNaOOh844xA2Vltl5CRD2z+hpfCkAWKplAXP7b+PDjZA/7Ssqknt7wAwaIPiM/LLnuSyKS5qvS/YmnF55g7/Hr41qYanLUr5+plIykJtd4Tjji0aDj7jakUtZsz+yJL5jAYyP2hx4mkdLWIIrsOCavKxBsyEp244nFldmgRRAjE5uzdbvK/M3dPPcebMtpmM5tKEDMB9c1Qx/xwNvvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AFVz0q+/cxfV86NcFGRZjNmVXaxZjE0t2WVjoCag38=;
 b=ON+Y/v0uPcWhvmSuvivoejjZdBMJTafYWQU+sBSAtl054kJ8VjNpG21JC6EG8FZk8SuiL1auliSS6brPYROIApi61gvBLhnhrPsi8TJsr7T6a2k7vxW6KKubgX7gK4ZEARSNZ62If6w3NwMoVHpWByGDPFGxoqywtpF5fPHwMcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:58:46 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:58:46 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 6/7] k3-binman.dtsi: insert keyfile and distinguished name
 templates in all ti-secure(-rom) nodes
Date: Fri, 17 Jul 2026 15:58:23 +0200
Message-ID: <20260717135824.2142135-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717135824.2142135-1-ravi@prevas.dk>
References: <20260717135824.2142135-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F6C5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::651) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9a58ea-a59b-4666-54be-08dee40b8501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9+1D/xArElvxhhjGUo75d6cy9kvNbfHejgtKYCXftuyHxRn6wizFPMWx5Q3VrH0W/I+CIy9d80vwS+PqSciFvxShXst4H8fE5bZtc5cUvUoFNNvO03H2XsjywWio+Ex8BeQwej5m9aw5J5lHue6WBM45WIZ8pSyBcEMw77/krb9Fr1xuvoOJm5SewUUwBXHitEw800aFxryHxue4L2GCJhhlR3CsiA0nQZM/hhH7ZK2t6ClJw1891Tu7EpqZ3fIc17a2++iJC/KeKCxIW1DMMi7eBh/5Llh6qkXexIx7MePp80nAR8bIQuR1V+wzZ4qmWJ+rPaaDTif3Aovu47w2R6FD5ANkT4epKcFtbhoevE6Wqk0kCyYgTwDCPegX6UbYMgaIbyZbslyaIx/mPqOY//4VSOz9ctqHY4t1IU6udU3Fl/w8YR/R61PRsrmyZlDrg8koUvpuSsZ93Unjgwcf6ZlJNoOVoIjULTdc26CeWAuquiiR/BVOmUxqLicgmStcvy9mZP3ejwXiCyXAVkWAmNhRTOPsMJlSAIRLzSh39R8wwv2cjZXuJx348KWOE9riIaci9Oa5cntmL10yjhtCqhWa78ioX7Wv/mVvRg1quxSWV4Wc7YREJ17oMJ+7xFPUTU++b+KGSq/Icx3ufsg4ohrezDoCGxWWHvFIKrevEWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e0U4reHCK5Hur7m8kMSJjIjCjkkOq0Aa3DBtke7UnbTZzY7TMeDawWowQDDg?=
 =?us-ascii?Q?DXulz9yBfVBErD2nhfb5GAx9hJIQknP+PmodiEy8Hs+eHSbrBurZosPkF4xw?=
 =?us-ascii?Q?7rwX0CvnZugWBaafEHEP7I1nX6ZT2KiKPZ6RgFyh6kYBZ8YtwhyK/PNsf8rM?=
 =?us-ascii?Q?ULEzW918kdppxSmZnqDA5fclXi+rqp5N8nblwtPyzkLBNy9Cgnpe+4boLevZ?=
 =?us-ascii?Q?ftXCiSwpSSfPNzMmqdYYipDdleaXcKKHy1q3YlY5JB1MyzLJNxkO/hCTWtRP?=
 =?us-ascii?Q?CutCbDKCbGMfYU/x4MJLaPqthx2bo+9CdgIahsuDW5DaiqvzmT399kpGt5Od?=
 =?us-ascii?Q?A+X0xWNbaDOiLG9G2I7thPsA5fck8mqZGTf1AEvL+v4QD6LoSLGKu0p+E0Ji?=
 =?us-ascii?Q?+0pNGuPTUUSJWBzyeBw7V2oqhNsaLePkPA0ir5e2Ybv/WNiA8wo96O5e7wcZ?=
 =?us-ascii?Q?Rcw7fZ+0ZKVm1YQ7rHWWZxxDIPyaJFxCt85PGqDinHfNXATKoPgdzsTBaOsT?=
 =?us-ascii?Q?0hd3FBe57BZnLLx0MuaPL26dy/Gz9hnAHAqq00YI9yn0qj74zjbRRweP0Wkh?=
 =?us-ascii?Q?QBiJBu99jvcmxkUUGPYyAehJb+SfrhF0ZTG/lBkSt96Q2YJqXgPIOR2jYuFH?=
 =?us-ascii?Q?V5CQZXGsAynWw2uJaSYI0Ylv9bqXVxl9ZSdbTMJASBi5z1FRnvtugvli2SZG?=
 =?us-ascii?Q?ab+AmOKx0x9Lpmm/9ymLpkM4miYHJcMXwwXhvdaAXKZ6WUN0TJ0FldwbD1Y6?=
 =?us-ascii?Q?Z9VeTgtCmlBpcXQppLFxy+rw3Ntg0oLuib0jvcg288HRvpOiUwarenj+YQaM?=
 =?us-ascii?Q?OA0/gxJNyJdq/BHIlJLUwDbwOxfJlBQo4BSOMbJumeVju5IZKRF2m9MjzYDa?=
 =?us-ascii?Q?wL91lnfbN9iPbSB5gEidkt1w96wviD3L0Vl7c8GPG4Zj96fU4wJizRnpXQ58?=
 =?us-ascii?Q?c6SXMvARpT9v/5FOr8LUnkr6CN5ScIT5fDWg6oFKdPyHfC79wtpzNiE2mxYX?=
 =?us-ascii?Q?TOOTAowjt391y8EhN5ESpZLYMEiMDeWlN4IphxPmG6AkmpJz3oxQB1G8HTet?=
 =?us-ascii?Q?vy8DdCIz36WrVPSWmkOzpUGcVgIdzhg72VFd+XMhDplX2wyP2V3nxmpRJYFZ?=
 =?us-ascii?Q?A1uTsv4QzvmkrMD8cWgTMvQ/GRHEKH4RPhlKWoAnrTxzO/Fx/NuztH/m1hzV?=
 =?us-ascii?Q?ENG69UAkYEHciwLCpqvGIMxcEByNXJq4uhHDbQbYVyGZg8oq3Q4nFpQMa2xK?=
 =?us-ascii?Q?SWo9wJQV+MGfs2b04QngVV6jg3DZ6fhcmMw/EPXGOMUopOrgen6cWYXSG+gR?=
 =?us-ascii?Q?Y0F/9YXnaPQJeqEb3Rbx2KwCyUNcfr8+rEQ60xdOOW6SbDO+jmafzwTjYWJb?=
 =?us-ascii?Q?E4PdLpmgvMQxlyaoFeUnmwAB2lLWdrR4kZ2VkItbuEvz0tobsP4hmlSSbQfI?=
 =?us-ascii?Q?ZrwBmfLwMtRzTDJuM7/kqBZZnbnB9nupB9QQ1ofmozsaFtJkuznpmdvMYPG4?=
 =?us-ascii?Q?X0Jl/RVBKpvAc+VGgMbFWID3Kx1YCbRFRe6JWljdRN012k/yMaaRSkKxML81?=
 =?us-ascii?Q?gm4Siidacs7rhB9lKT89DGPeNeRskYkPVDEbdSZvzt4RUTs1Ig3NHuWW5jjp?=
 =?us-ascii?Q?FERIDxhioT/mMHMyv8pXwJd9taVpdep3TfeJoA0j/a31nOVE6YKCyI4QUm6E?=
 =?us-ascii?Q?gYY4GOjkPASDtnFE+TkRg2k7FVoQ5X1jgNR/wyjd0penvQxdi0T2/Ej6YbVw?=
 =?us-ascii?Q?cbZzEgnFFpJf7FIa0fWCJP4plwoEZoE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9a58ea-a59b-4666-54be-08dee40b8501
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:58:46.2061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq9N56ylINFY+jZM8soUgk/X6a2RnpeqATuGijOMsPMHq0l9fb/d2D+q9eXRl9sEzZ7koyGQFurYatZu/4MHkZy87PxO+CtjRIwaqyP5x0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7426
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

This should not make any functional difference, and downstream boards
that already override the keyfile property via an explicit .dtsi
fragment for each node will continue to have precedence over the value
coming from the template. But this makes it much more ergonomic to
have the keyfile and distinguished-name have consistent values
throughout, because one only has to override the values in the
templates and not each and every individual node.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/k3-binman.dtsi | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 2c9e5b619b7..797c271bdeb 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -150,8 +150,8 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&board_cfg>;
-						keyfile = "custMpk.pem";
 					};
 					board_cfg: board-cfg {
 						filename = "board-cfg.bin";
@@ -165,8 +165,8 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&pm_cfg>;
-						keyfile = "custMpk.pem";
 					};
 					pm_cfg: pm-cfg {
 						filename = "pm-cfg.bin";
@@ -179,8 +179,8 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&rm_cfg>;
-						keyfile = "custMpk.pem";
 					};
 					rm_cfg: rm-cfg {
 						filename = "rm-cfg.bin";
@@ -193,8 +193,8 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&sec_cfg>;
-						keyfile = "custMpk.pem";
 					};
 					sec_cfg: sec-cfg {
 						filename = "sec-cfg.bin";
@@ -287,8 +287,8 @@
 					load = <CONFIG_K3_ATF_LOAD_ADDR>;
 					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&atf>;
-						keyfile = "custMpk.pem";
 					};
 					atf: atf-bl31 {
 					};
@@ -303,8 +303,8 @@
 					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
 					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&tee>;
-						keyfile = "custMpk.pem";
 					};
 					tee: tee-os {
 						optional;
@@ -330,9 +330,8 @@
 					load = <CONFIG_SPL_TEXT_BASE>;
 					entry = <CONFIG_SPL_TEXT_BASE>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-
 					};
 					u_boot_spl_nodtb: blob-ext {
 						filename = "spl/u-boot-spl-nodtb.bin";
@@ -419,8 +418,8 @@
 					compression = "none";
 					load = <CONFIG_TEXT_BASE>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
 					};
 					u_boot_nodtb: u-boot-nodtb {
 					};
@@ -521,8 +520,8 @@
 					load = <CONFIG_K3_ATF_LOAD_ADDR>;
 					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&atf_falcon>;
-						keyfile = "custMpk.pem";
 					};
 					atf_falcon: atf-bl31 {
 					};
@@ -536,8 +535,8 @@
 					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
 					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&tee_falcon>;
-						keyfile = "custMpk.pem";
 					};
 					tee_falcon: tee-os {
 						optional;
-- 
2.55.0

