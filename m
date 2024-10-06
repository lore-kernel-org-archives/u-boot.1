Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33BECFB43C
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 23:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBCE688A1B;
	Sun,  6 Oct 2024 01:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="czvunVFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DB088CEB; Sun,  6 Oct 2024 01:26:31 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3030088A1C
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 01:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFkhNgRvOEMQtil8++JF9iuf1W2d8y9F2WyAR+r7xkcZDP2j2p8hA7J1aN8gh3sF1uxy0OW9ZhG52UcvdIaf3zZqHyIDatllNfPyJCnbCAQGmh6+8Z8QSdyJM75vcx2YNWvXEVwAIpZ77//j+HpjKYJ2b901RRUwCENX9AjF9/7xDItn5S0TK3L+ZBKre+ChL/OHR2vPKWKzyxuenowoSIqgRzw3hkngAPWoNGtzbTpPCxjEte2GAsgmyX1MqHr+tpLcuZ7vqOJlP9pQzLbY/1akZAeZvFQsKVXWGMPZ5Qgk+M4hgbgjAZWDmen/E/eVOMuQRfnrKuwHSBTOZi39NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxvu5jMb/kRm3uT4M5rQmmGsmQ4oIJDAs04sBI1rMWw=;
 b=vMN138x8jGsxvvuPZN7P/YLVfMemG6AndaYLLFugryghHONEWiPbQvEEMrrOTUtsQpk+8pvU6TSLsKvJUuWm6mhjMLsEGsbvzBuh3KdIDptQrNHdh//AklBSyv8FXO5OUBfGJs4sF4IwjlYqzWwuOB3Kh6VjVDFBbn357VTpFYbPd2jJuXOHUcGGr7iGxqHJsLwaIPBuXEQsWMPlHaOxb3tkHoa61B4l09PQXfs6KNlVQR/WA3hlF57oyBpIZBbaYPSS3bq/Xvh5juRqMK5IRPzFVtZjwvJnBWcbZBV6BcGRAo1CReJWYtRODO6TnFmgmCmIttmOeNHqHWswozCVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxvu5jMb/kRm3uT4M5rQmmGsmQ4oIJDAs04sBI1rMWw=;
 b=czvunVFGQ3vQepqPcIyef4sV6Ax+oN7e42GxsZa6lPLSkNkfPPlrFRR0B3+wwrWsGpx1CYU/5rGGUIXBUzvUoCErMcsb0f85wCKR9ziTqKmNExwkVpl2FcRF4oaabPxYi506oGVpsWKims5leZ1SwvY85ANQuXFl94iuEsPKlz/0EADVdSMad414geA1ue4KG6R14WWmkVneNx9b8dK/ValB0b+6XqaddWSlElmXjjRpwG2lHbUFZ+WnEgLXkh3P5Pbn6EEsCgahUUgMR4V69PRyvprVtbhLZT1Soz8HKlFkhCVQgFEPMKvDdRSDfbyN0MZB5gfJI8i5MZfNMBg25A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9217.eurprd04.prod.outlook.com (2603:10a6:102:232::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Sat, 5 Oct
 2024 23:26:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 23:26:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] misc: ele_api: Add read/write shadow fuse APIs
Date: Sun,  6 Oct 2024 08:30:03 +0800
Message-Id: <20241006003006.20162-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241006003006.20162-1-peng.fan@oss.nxp.com>
References: <20241006003006.20162-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d1b749-3ab5-42ef-e9ea-08dce5952186
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D7F11WejLZyox1jLs0vgEOruDXBWvVAkqaj5JmHeIq8VZanTT/pp/wdC1dtP?=
 =?us-ascii?Q?IZMVtZv0L2Fn8nW1QNAxhAgaAApIPaNr6RIRVn0bw1WBGmfJ/7P46MIpwLo9?=
 =?us-ascii?Q?VIP6fVy+DiYvrOXEBmNYfMad3FRCPYTt3My0GdXG0p/aXCmDCqVwSCy6lmb8?=
 =?us-ascii?Q?qVJn7mshC78gOJ/DU1760EPZG8fb432RTb3c6G5F6IC21gcSJqDTlELNQkvj?=
 =?us-ascii?Q?ebtBy5YTlJd/lFZ6MgY/xc3jq5zkYFJSTkCGCeSpn9bkv8mPwZQoc3dtyNFF?=
 =?us-ascii?Q?5jsZe2SMAQTYlC9pTx44BptHT3QIRhAcqKP0+tBQkCEdScp4sY84qNUAt/nx?=
 =?us-ascii?Q?E+6+EUhrTLMP77NZNNUxnmNOYRM7bhUY0v/YEvME+Z1LnVMPxtWq3YrFx8mF?=
 =?us-ascii?Q?weg0bVXxpALkL5sHC8wDRvgCy2k79J11mpjOk0I7mMqemBkxheyKNTjhsWS2?=
 =?us-ascii?Q?Eahv5CwsTqTT1XE0CzpGGPflQbkO9RjtQrnue7LsqBCMnC94zcn4YXgfnNBX?=
 =?us-ascii?Q?49kMy7jamnB7e1QP0Hqp7jILMnD1WfiZHluGRf9NOL1B3Du6oQoMMhZM2Gq0?=
 =?us-ascii?Q?QX7qCqZggrT1AqG45gB53yeF8Bjd8nmIXW25BRFTXoyfZYGLrXNFYSgMeGZW?=
 =?us-ascii?Q?1VTI+fmsGfL1I9z8LrCPaz8c+E2orMvrzGakt57KbSpCyr+qfpeDQTscDdb6?=
 =?us-ascii?Q?gaeNV4n8Dm8A46YJX8zAtiTm+t+bh3c9Qm+0Ai4iE9zJkMkZySlUoUneQBya?=
 =?us-ascii?Q?JQVnnEmsM2XE+C+GwS1p8sb5nPeXKc+d7xLDHe4tfSmdLHqz27dJ9IRtGjDi?=
 =?us-ascii?Q?7oLJ2jh3JSS4hmMIBO+M57BMEmYB6apR3HDkR94HWbaVCknFEkuOM3dkVeSj?=
 =?us-ascii?Q?kXxokq82Y3R945o5vl9i3J32DGtNVCmYjwngcDo2ZFlaXN/FLC30w3VGtQ/6?=
 =?us-ascii?Q?x6shb8LUw/wttI5oTezPAAmXsF7VA7qxkOpmxFLeI5P0R7FkTCAQ04hH/2TK?=
 =?us-ascii?Q?SEhkewzQgcn45kqd87nQXyxRoNTHTneAlsRPipZ1yVWYcymTSQ31noOcs7SG?=
 =?us-ascii?Q?rpKxQdP+GzX2V+lCnueSmOYeTZ7ZhSch2fjvlqSGwu2qQKC+7bQwiusRNqUn?=
 =?us-ascii?Q?inQjoUND28+0+DLTzektIjcw/vwHkrh4zwYMla3E5lt4XY6KlcRRtgPO/ah9?=
 =?us-ascii?Q?y9hTh2R3kDwccX6UA47o7YZplawfcGBTh0/nTDTnZCkNTrGF0ZEHevl3JW6d?=
 =?us-ascii?Q?BOWzHrwxeeK4DXSkcqRS2f4I17uIkfTxDTE8RM7HOGdRPPKfS5bE74J8Ajyx?=
 =?us-ascii?Q?CWPB3AccdciNx53N50/bo8+73zMde5A6mK0c/l0tTZKtQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?klqxC/iKhY+75cP+QNFxYUhFys5I6pZzLOQt/xVDyTRBsHjqEVK+0kcR2WQT?=
 =?us-ascii?Q?A+lUZgMPqLR21MCtYzv3e+vWRnGJScU2EInQ3dSv00lJ2K8BWHFgEVCSuBED?=
 =?us-ascii?Q?4ONMhWxRYlYYLXimPLAWBBbYxssyEk9RxlehrqIosbCpYfOd8DMxF0VxGD5c?=
 =?us-ascii?Q?/SIv6CVtIF3cTfxxfCTosginIPhW5hKvPDTKHUjOQB2Il3h5OfPhs9blJUL3?=
 =?us-ascii?Q?LQm8+P6JbkLTIuO+DZO64C/j2eudetNHF9VpMfChb/4P6VHz3PO6+XNn6nOP?=
 =?us-ascii?Q?BnM1UktikYhvu+/rmMnR3teJNU4pfgWa9cahsjj0McSrrbf4HLmSNBhH4eBL?=
 =?us-ascii?Q?qL03HG/L9fI1WeZ2Na2SIwuSNHKTEKUs/u0VaqXUXs4KjAAE7EiC62V0bjeS?=
 =?us-ascii?Q?DuCLK+p2F6APY7UqtfVtZo1XXtwVzRALPTKS7DLswqs63RpyPenZQA83KsV8?=
 =?us-ascii?Q?N71GF7sX2zlsLOXNgBY5eteqNsEzoOQ4vjWneE0SOlvrGz9JYhYy+QnHHNEV?=
 =?us-ascii?Q?7Vcw/wpHXDhxm0WKRL3P8qwHuh34ISlkkkN3MZ1bt1UUoUSMJup3mcpURtYR?=
 =?us-ascii?Q?WEgR4QwZ/uE7rPi2H/I7MO6WnrN15qW2ic1semDCG0bEDy9//B6vW79FYwBf?=
 =?us-ascii?Q?vCkXzg9ue63BvAAz1441fzsulaHEoHim8QWJd4wiaIGEvx2LWPKxwvsU34lm?=
 =?us-ascii?Q?YVHLa+edmlrpmGVOWVwJs1nXckOMbNNeHDEupw8rAtpjBVgOXDlEEFJkWPW2?=
 =?us-ascii?Q?WJEySf9qLvnqDv8AMnCkXpBkUTm4H+OdESqc8PuCTvHjZf1wUcZDQFhT1EzT?=
 =?us-ascii?Q?kR8g7uRrXiCGEC+z8IDyMYIKspAycxoFby1XXYyNWXgAN9RWlQs7o1ji8fUJ?=
 =?us-ascii?Q?/+AkSgSAcKQ/KSe0H08Pw4gi4fSfwtrVWpCiylvt7EVtpz5+iXRqpRT8D2cq?=
 =?us-ascii?Q?xZ3ypHqmp4yB5Unrmb9WrvF1pOzyj9oJJUOoLVkw/SS0M3vp3fY38w8sNRZf?=
 =?us-ascii?Q?FRafPjdmPhCVNFbMjtfOlV4XMJ9oQgAc47xUPsVQgb2cOx48o5JNrlw8YH6B?=
 =?us-ascii?Q?WATJr4MzuxNtUjuNW1hshpYbDb10oKEH+ZLqR/1Kv8XuYLvqMcHzbolqAH/3?=
 =?us-ascii?Q?fyihcVG+6g92OautpoF+f2NBVmvdscQWaCBilcB/RPB/FA+AGh+osyvxTg9y?=
 =?us-ascii?Q?bUDlTv/gyc3hLwErl7RtQxl7gjgRmAvQ7qYA0RbZUUHyOLGWt8T8bMgtpHf+?=
 =?us-ascii?Q?KktKVFP4oZ8s2warvvDj03fig+2OLC9UNbVmZZjd1B7Rqr0IwTI/2spaqEzX?=
 =?us-ascii?Q?B3MNUHmIlgO1s6zzBCI6d213QBLLrPneeyUnHzNIphfx1WGN9c0JCTBvVzCx?=
 =?us-ascii?Q?V6q8yMFoOEZXFVmBHnvOezyUkZuMUbIrIzhFfLGHWHpey2a+jDhvvIOPEFbh?=
 =?us-ascii?Q?HYoVKc/Jvs2tUqn1z4HyI19B61H1rsCK53yE5KPUDisVXplYtvilpwpzca5/?=
 =?us-ascii?Q?T9hIN6cNdRLHySstu35luvZ+WHUd8d9SQMjETpJTb+BfL1z4zn/EOonshvDp?=
 =?us-ascii?Q?WKfvgNW0xewTsEmNign3HMUaBKiyq7E5WHxmb10y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d1b749-3ab5-42ef-e9ea-08dce5952186
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 23:26:25.7108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzZPSaX9qvIDfy4Nkwnr4dzkihx+ZEyxxx0tP5lqrTtJzTbdcw9/qHRnG1dqNH5dNJWcZBzLGp0qrY4vfUKxgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9217
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

From: Ye Li <ye.li@nxp.com>

Add ELE APIs to support read and write shadow fuses

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  4 ++
 drivers/misc/imx_ele/ele_api.c          | 66 +++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index d4ac567e7ed..19d12696a1e 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -47,6 +47,8 @@
 #define ELE_ATTEST_REQ (0xDB)
 #define ELE_RELEASE_PATCH_REQ (0xDC)
 #define ELE_OTP_SEQ_SWITH_REQ (0xDD)
+#define ELE_WRITE_SHADOW_REQ (0xF2)
+#define ELE_READ_SHADOW_REQ (0xF3)
 
 /* ELE failure indications */
 #define ELE_ROM_PING_FAILURE_IND (0x0A)
@@ -154,4 +156,6 @@ int ele_release_m33_trout(void);
 int ele_write_secure_fuse(ulong signed_msg_blk, u32 *response);
 int ele_return_lifecycle_update(ulong signed_msg_blk, u32 *response);
 int ele_start_rng(void);
+int ele_write_shadow_fuse(u32 fuse_id, u32 fuse_val, u32 *response);
+int ele_read_shadow_fuse(u32 fuse_id, u32 *fuse_val, u32 *response);
 #endif
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index fd57928c5f8..62cf1a137ea 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -268,6 +268,72 @@ int ele_write_fuse(u16 fuse_id, u32 fuse_val, bool lock, u32 *response)
 	return ret;
 }
 
+int ele_write_shadow_fuse(u32 fuse_id, u32 fuse_val, u32 *response)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg;
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 3;
+	msg.command = ELE_WRITE_SHADOW_REQ;
+	msg.data[0] = fuse_id;
+	msg.data[1] = fuse_val;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, fuse_id 0x%x, response 0x%x\n",
+		       __func__, ret, fuse_id, msg.data[0]);
+
+	if (response)
+		*response = msg.data[0];
+
+	return ret;
+}
+
+int ele_read_shadow_fuse(u32 fuse_id, u32 *fuse_val, u32 *response)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg = {};
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	if (!fuse_val) {
+		printf("Invalid parameters for shadow read\n");
+		return -EINVAL;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 2;
+	msg.command = ELE_READ_SHADOW_REQ;
+	msg.data[0] = fuse_id;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, fuse_id 0x%x, response 0x%x\n",
+		       __func__, ret, fuse_id, msg.data[0]);
+
+	if (response)
+		*response = msg.data[0];
+
+	*fuse_val = msg.data[1];
+
+	return ret;
+}
+
 int ele_release_caam(u32 core_did, u32 *response)
 {
 	struct udevice *dev = gd->arch.ele_dev;
-- 
2.35.3

