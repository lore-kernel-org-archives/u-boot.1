Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC8FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41E684150;
	Tue, 28 Apr 2026 10:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Uibj4Kox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C41CE842C7; Tue, 28 Apr 2026 10:35:29 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36ED84119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAURNzxX5akwc5Jc7O8VPDSXrTs7gPZfcQKmxu4gKfZmXqCtUt1BCMpOF6TpQjrqPPMDISztoPBeK/0p8fXfzxCdXiOFovQK6JHII9VcFsFpYkEXa6ZWleLFrL4w4KrZlCGWijrhKB9mvyXCg4Rs1JKK0GB4iDxgenPeiNmqF6oRQnKFQsCbWnHqP+qDXUnjPxHkiH7AzSsB0XzXyQ+u/02Udb9cRlbxEP8lb0ZlBTAUKBVtq4YFMxDmP/wGMahgPDFAgWbGPJSJBO8QepG0yri4RqO6FZU13CTnyIJ5RmCso7STJPQKcOhzBMgdYETBDUfugosIwrvB05BHcE7/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl86grqD+O4+FPqJ9LAIuvrccnhQaG/IJwd4Qto/iUg=;
 b=sfQgEkTd03O3GDh5UiNW/K5yf/ma/WRzVWZ4a9qRDJKo6V7GB2sBggatcCmWxvuxjPh7RvgEBYtDXRABG1CK4osoIMPtzL4IxbBSnHVfNrJS69FTmaehRRDm6dAy1ahU956ss5oLh/sKHDygtmqe3jAGtuUtP7qonn/NP4GOc+/X7JTi03d32wQXIp0iOw/yJoeZ/mvQTkVph3ktsZhgJBjN+P4eyhKRrvNGrBdi4huSGq00L00YCSXO+QlqTTfFOthCSVh2yYYBcgD/AHNabgZs9BXSNnXdceVi7t9iS+8bhdAOBQNCjDRhrpzrxdzanM1bgxi5diap676xJjJ1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl86grqD+O4+FPqJ9LAIuvrccnhQaG/IJwd4Qto/iUg=;
 b=Uibj4KoxoPFwVOCmvMnB14VWDBYFOIhxC46EnJL67sRRNs/pRDV5/aDyZItLst+K8cJkz2PPgdQza/X8lo3RRLRsU9h79UhjGSHAD/w4sFmWJ+g090ZY32M/hx0pldfbxauZmgyowiZM1SDq82Abk+onRmU/C7aBaxOvLWrSm5kH2D+uYd4uCaJFz/CYwK2R8unGuNEcWlEufh5FKYUCA8NOXTYUbBPwEFK1VfHVCkFGDR0K3xteNPhHopp4nnUMQzcbCQed/WRlY4nSVC49JOeGkBJ+ppA6nMfyQElZ6y73f3qi0+IZWXRXIQxm6nzBNg8aSyTarnreXEfpahEMZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by PA1PR04MB11336.eurprd04.prod.outlook.com
 (2603:10a6:102:4ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:35:26 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 08:35:26 +0000
From: Ye Li <ye.li@nxp.com>
To: radu-nicolae.pirea@oss.nxp.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com
Subject: [PATCH] net: phy: nxp-c45-tja11xx: Fix incorrect usage of devm_kzalloc
Date: Tue, 28 Apr 2026 16:37:33 +0800
Message-Id: <20260428083733.1803100-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::6) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|PA1PR04MB11336:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dacefce-6db8-4bb8-b1d1-08dea50118c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|19092799006|366016|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sDx2jMHwp3UVNwSfclTxcvAGOIdD1Rr0txXYtZlEkbWegAnqT43rNDj/qRjN5uI73FeDxCOoAGdQtGS74t50DDa7FnvwR47SHXq7fD5RUrL8bxovZC2+V23fDSy7UsxqnThRcxgc8U+0guRV4TLWC9PIGQFL5dhcAW3RqhaOKv1Yvybf/jTwIpHTU18y+Vs+IVz8GUUq1rFsFlq3QXt99vuZOZ4ZnVQOvVfzttVVztjOZDicMoWppKdrX0o4EPfDN24vpkPqftttGUMn2uHmJ+qdCx4TqpRr4FXLs2c5Y1gZwRMkHq6bXoIOYxp+5AgbX1sBQBWEBjZ9j1dy6tdOXOoG2Sy3TmK/mNW56ozJgHuomtZ9hdkyZ07jSXPBJXAkx42SBFyvW7IocvRYZeAc4fOonnkVrx4ymr75XgnNc9T4aLi+dmvROjlwQgUjLzz4O+7LslwO66bc8l/SgOxSJmkgHjPmgnCNYGhSfOazuHc7i0ggd9rgvyy28rB9LKtd1TlqwdZJvD8FTeHlMRYzlEduRIixkDrhqBtSn6DCfP1LwfPqRSJ9e2BZuIGGGrxdjK3QNoulkjwn3RFmT2pm53SeWXIla0Ea4KtTmWOYBpJS0xAg8rGdmAZQAqDfzof8iDhvsG3a6yn1WormOfrk68nxoHWg8jLwh6FI2xNhRTL1j3ZK34qxDXdvnBdubh3eNtsfpbns7tPr+dUBpoJL6yT6/uZpgwo3k7hwYYxQVSPRT5Gw7Kkh8qLyw1AHEeh8lPwUQ8qf2xHxkcCIz8Vx7PMV0ATtyKkwhOD+oGo7QTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yPFR0XXfNFQOTeYAMj5QDLnw+/Y2EsjRThOdBAARdcwuIOsTOgKLtFesenMu?=
 =?us-ascii?Q?/RGlZQUH3SmxtUIJXxqa1Oi7xnIvwOZnv9EDNQZ9fEhPhISmVl61BTBAGRmy?=
 =?us-ascii?Q?z1dH2pJOSH8yVQvcWlrTIe1bakF+o9lxWNcCJFHAoA8nZGIvwHOeY8VKHkLI?=
 =?us-ascii?Q?l7X6cLbMHNkvijHsPJvC86itUwojhPHqqgorfSSobBYuttiYric7oGB8ipDt?=
 =?us-ascii?Q?ABeDqxf6ixbtIrZReYEahsTg7GwVBOUxG/aH3yVYqag0f2JySwP2pwh2ck7T?=
 =?us-ascii?Q?pLEnUtBUWR3H5GQC3Swqu5vqSVtttiRjrB6OWIt09XddpwxTfsvjVvMkStVM?=
 =?us-ascii?Q?HSTPPQi8LhvfCXM0CpVZZpdEYYZtv2pAYCiFG0s8KgTyIygCceRZbsX8b4GE?=
 =?us-ascii?Q?AAPo56KAykTtDIeO0wi3ZvZYfGYtOdmg0vb6SRAuX8OOgkETFwMn4L6SunqO?=
 =?us-ascii?Q?r0F0VxT6B1k+nzAV9UWqhlNXqtZN886nccZ1NQo2m2WrNn5vRZ92JquZgcg6?=
 =?us-ascii?Q?Ool6d1Lquu8mKU8//uZ6w4btF53swHwbQXXbBZHokIGHDw4Zzte5WisKbjoT?=
 =?us-ascii?Q?2Zy3y3HX1jiZIHC/8fJWr4Qd68GzGXsrlRiIurRTDFnZI7TMvN+6WakWC7JE?=
 =?us-ascii?Q?thoymyedvrcC106N6NwjevJa89KQs5kUNzuJiTkXPuSXB2l0EUH9JtuYRus0?=
 =?us-ascii?Q?1Lh/4o/S7eLafvy1hwcHTweeIg5i1LMYdscsRV4cxBH3FRlR0uaKv8Xwy2oh?=
 =?us-ascii?Q?g7ROX3outehRz9DLHEw2p/EFwBYioYALo8D0jd4d/iYxmVzLlv1KL0tTRoQt?=
 =?us-ascii?Q?7bKyoCI+jnQjyaJ/76X6jGe3boSl2YZaXegFEZSo4/1KYUiiJmKvM3BRl2Ib?=
 =?us-ascii?Q?HQ65blGck0asjBQLNGeuan6vN5lSqWfN07xGYRmptarZiDMtYYbN9YSwgQ7y?=
 =?us-ascii?Q?u+TRG1kGoTIYfvTnAbh3Maevv6SXZnYuvDE0IXfmFabEoCm4kLeIahnpvPRH?=
 =?us-ascii?Q?vOmJ+S+5f/vH/taWqDnUlogPWU6iA6KSQXdbKXcfvPT9haB310dh4FSqyKRp?=
 =?us-ascii?Q?sH+Ebj5X0ID3fOD2Lb13eIOpxCgBgDnTV9u410Dq2CK1kLbiqwHj+e56qCg2?=
 =?us-ascii?Q?ufcuv9My9oEKR5J3TpbjnuzNns/GYaHHFxBhNAxygzS3unq//47YQ46vqymE?=
 =?us-ascii?Q?Et6sXdqEpRAJc6f0U8Hrn+zZ/SQ1Kp+flkvBcKICemzfy1BNf9g1UhokYHxP?=
 =?us-ascii?Q?U6Jjexw3vqoog20eR/Xnzev9CCY8WSAjf8zPvyWOBmQRTY5/JtwLgebmrQfX?=
 =?us-ascii?Q?WE75N1z1RQ7OxP9SZdTzsdZk6u8I7obTltA/jyPeTLHE24WcqETkTcBsJ3pb?=
 =?us-ascii?Q?2RJ5vniS8y5sDDFW/5/rd2Rlma4xGLuul8vN9LjMxAEiQlP9w4YRe5Kebb0A?=
 =?us-ascii?Q?EQfIGIiHLFXQyKt+kJCEefsFBa7/UQgoEOS0K5wxsd3lduO+AV68CXQPxyDf?=
 =?us-ascii?Q?SDe8gTM1m1RCwUfNS1007+RDziLOeuoT4oPpYPxb2QDq8awP+5cvmKpa/PMB?=
 =?us-ascii?Q?X8rAzOMDmihOqOPHc/zOFm2mJyul5z7sZPaZNmgv2Z/z/n0Zrq1ZNtRiyXBY?=
 =?us-ascii?Q?+2aneSK49LHgPUn9M54lOUiicZwJS8dxr0B2lhW9rumFaRWgkczv3odoavj7?=
 =?us-ascii?Q?X0E/+jRZBNM8pzcwyZUSwel1zxecX+co3bpG0cNNNwzxPd/B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dacefce-6db8-4bb8-b1d1-08dea50118c5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:35:26.4885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJEWuUuquCt4UBzlIIcp+63/fr7MJlH4+g39HgXrK2FgqMcy+Amq1Mc7cU/eQt3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11336
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

devm_kzalloc needs to pass udevice for first parameter, this phy driver
wrongly pass the priv in phy_device. And because the dev in phy_device
is only valid after phy_connect, in probe phase this dev is NULL, so
we can't use devm_kzalloc, replace it with kzalloc.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index a1e4c3d053b..9814ac498ed 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -343,7 +343,7 @@ static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
 
-	priv = devm_kzalloc(phydev->priv, sizeof(*priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.37.1

