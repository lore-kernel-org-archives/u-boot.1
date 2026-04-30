Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D0FF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 10:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2681584686;
	Thu, 30 Apr 2026 12:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pepeV8LC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 654F5846AA; Thu, 30 Apr 2026 12:01:46 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 771378464E
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 12:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSzJqJE1Uy5YHKsONOIqs06lQNSr2zUy6vWLQbGEMohgxDvcvbA4Hf+RIrz3oFvmR9H/l6mgG7x/eUBVnB+5iQYfYDtNOtbho3+Q+DuzFpal6VnsMsl8AXUbcR+3AgW1migEjkmEJ1e7mwZ1+srqNmmDG6jDzl8dSydCzfoF/CnOrWsLx7NCPUaOLQvSY1ptq40ffklLN/+616oQf7s0HRbLy6H8Er6RcpjHLCfZSxhPPuJLKGTNCWtrgDVIglLzb/ho911FQ6f9xzgHQ7vcRENu/JYah3sXT0D0lCOKaz89M8wm9fBKnPd3uaj/B/q7q9FNt79g4nqPKOVMXJlDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSh9s0xPYias3xJXJ/fmm/zldQSHfQNBpRjxn4+RTaw=;
 b=ZAyuJ491pwJyrhkoYZ39J5huQhL7Bidh5KnLfVnXGI95c77ARuuHI6+UTPpG8Sf772uBoyF0z4TabwwvoRNon7Eg4nXs+E9k4C5sOC1lEy6qvDDpMHZtJvhTOiLcIUaKXOKE3IQZ3mLnsPBAcMoh3MYJ/3y4xUVtAxByHsG1UQOJtQsYM34yE5/GJhEJKOIkm5BJ4kbQV7d0s+8neQR6DU2An37k9gusLl8DjPnj3o8ApyZE5x1tb+WU2EdHoPujaA3TkQBFIN7QuUvKtPDP3I7Jm1RnfORyoortnoEuyeRXx4KvQewItaTjg8eaLSm6v0gLeCGv/A/+I6NSfM2VKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSh9s0xPYias3xJXJ/fmm/zldQSHfQNBpRjxn4+RTaw=;
 b=pepeV8LC8u38nFYtBW5HTu7coSEZCaBTFXda1PWfRKw1dyXaTJnKCFapSB+Dvq8mH4BNB1yMlVIIHn3BlSIe+RKjXZgjpMtE4ch4761aWXPOhZsUAXUnro1p3CJbIuseF7WrZe2aO85fG7h873wbvaBs4LNyliSvTn/M/rFMsZIotbY5JQBkkH5A8iAYiaKfcvZYTSQXj7sR981Ur/1FjzzgoOU8Yl4uowP8mce3kgBr+siEPrY3CYUmwKMNKa7apr6IFp3lvWrG+8xhs14Bv6KMpg2RTDCgcLmwohFJ/NIHwWRcnC9f2yL1iEorB63StpvwD7bQV6iWroXA+JmelA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB12156.eurprd04.prod.outlook.com (2603:10a6:800:317::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 10:01:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 10:01:39 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 30 Apr 2026 18:04:10 +0800
Subject: [PATCH v3] net: fsl_enetc: Add support for i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-952netc-v1-1-9a0b2641a56c@nxp.com>
X-B4-Tracking: v=1; b=H4sIABkp82kC/yWMwQ5EMBgGX0W+8zaptgSvsnHQ+pffoaRFJOLdl
 T3OZDInIgWmiCY7EWjnyLNPkH8yuLHzAwnuE0NJVUqjpagL5Wl1Ii8rUxW10bazSPUS6MfHe/p
 i12j/Lm52Irc+C1zXDWBuNglvAAAA
X-Change-ID: 20260430-952netc-168485943bab
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Christian Marangi <ansuelsmth@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Yao Zi <me@ziyao.cc>, 
 Robert Marko <robert.marko@sartura.hr>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Thiery <heiko.thiery@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Jacky Bai <ping.bai@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB12156:EE_
X-MS-Office365-Filtering-Correlation-Id: 3340217f-fb3f-40ea-3835-08dea69f792e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: j8cKy9nd6MTdOHCJGuM1pdeIEV3JBDWhv/dfIG/wKj0WPCBykRVka/0Abt8QqkCzdFgdZKtoe0MtSCx9pD6q7w9j0DXIaFf6qftw1kBShfh+lWWuV3U5sVlIu37b6vT6JhQnBTDzTRingriWxz/F6VpZN6d7mNgqkcjpW+wNaJ0dbXNn6CiusFgq7JjB+dhUfz2Xgk83mu80Ws69Zha6hHYyh5db0IP73oBN/VpSlnWoV5XvhE9SMGgydgl7O9pQ15M4F7JiAQZ9s+aG1fHSB5SUo9axCR3s0BXXXKz7LOstAwxMjRcziL6MwpG0vFEBjE0sv10yF25QrjK7RhmcBIIFZmzlI//88FkY7S//A2Tt7UL3ZI4W+bmcD60d+gZwS5qGZzhSmskJV3rdOvkH3MtSnFpVeLZkfTwQ+hNds1Oa7D2KKrrY0vwMBebVL1+ma9q3AqDyH/6Ft2qKtokz03496V4aYEtw3AoYx+KcFYtQzeEyPrPGM8J4f2cuucMTTYn+7QAt9MYNcEVjDBdWoUsmJqNSddUyTzlaeKCKDRXKhw0DfpL00IXRiRidrEIP47+cwtrEEatHqXxTlfXMAglmRv1avfMhDyYNY4W6nMRCpzspEVBunYIMb7OWkPrkNsZgkYzPufdmjgkTKaiPStbOIKn/gT0I4WeAcezSBP4RmO0bnBRFEEGSYV28FHt6nnGzROocdE+f3HbCDLqv5P5uotO5pPXQcYRsL8wZoR7UJCcNPpEzPCLJleReWqV44Y5C5qrcINtshSHS7mMDwOnx+2QLmVM+EuWwY1H3uG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U254MGpFOEFsOUhjYVRjV2g3dFVZL0tENHIxTFlEc010b0tZaFhaaUQrVFpT?=
 =?utf-8?B?bXB4VlUybXE1WUtWOFp1dm4xSjM2UHY4REI0V2RCbkFhclZJYzF4SkpiQ2Zz?=
 =?utf-8?B?MXNyWEoyWW5XYi9Ia0xWNU9YU0RCZlVSa3ZQejFpNnR0ckhVWEFLdW5zNDEw?=
 =?utf-8?B?SlF6dlowS25DQmpVZFowWDJNcXY2STF6bWl2WG8rbU92eXBucXNaYTVJdUJK?=
 =?utf-8?B?OGgzMjF3R0VMcDlyZm1VTlByVmJBSGdOTVZFd0c3VmVueHpwRVNUd2RxYmJT?=
 =?utf-8?B?QlYrRDRwK05VUjA2WnpUWWVvZ0ZKdy9keSt2Yk9odzFyaHFlcUZ0b1U0ckZI?=
 =?utf-8?B?Y2dRSUgyRGR4cnBLemd3Z0ozUGZkUXdXTTc2Qlo4a05pRkVmT3VTUWNteDVh?=
 =?utf-8?B?b1BlT1g1U3FHcXR4OU9qVngxbkVTYUVkWlBmRTJEaW42elF5eGpZbk1rSFJt?=
 =?utf-8?B?SUVDVGFPKysxUVJLRGRXUDYyWThjdUNnRytuVi84Kzl1cEhCTEtIVUg1OTY4?=
 =?utf-8?B?c0s0YXNoM2EzNWJ0RnNQV1RKUURqTGkwQzQ2dVJ1VWRjTGRDZGlPd1pPUEpF?=
 =?utf-8?B?Mi9qL0xnM0d5Z21PaVZ0Qi9vVFdEZjVZY0s1cjllckFkazZ5V2VRcytCZ1lF?=
 =?utf-8?B?MExFbElSN1RhT2N1N1NkdW4wTFFhdGhDM1BHcDBETmk3NXNGNndWWUo4c1Bp?=
 =?utf-8?B?Z3hXSGxRampacDVBdE50SCtib3pRazJZN2RyY3FKZXVweTNxNlh4REdVY3Zr?=
 =?utf-8?B?aHhJTncyZm9WdkFadXZjdTJCaGZHTjAycmViTGRUY2h6ak1xWWZNNXpERTVW?=
 =?utf-8?B?SHlneE9VYmJPdUhmWkVhMUs3V3dtQ0V3akRtdE9pQmtFam4vL2RJdU5hd0d6?=
 =?utf-8?B?dGtjZ0wwb2orNWtBTmJFcElGV0F1T2hyUU9FSWM2cWVBL2c1dXhpdFQ3amc5?=
 =?utf-8?B?R1FneDVNSStjT2M2dXdJZ0RwblN1bS9BbE8zTzNNV3k0Q2FrM2ZsYmt4VXBn?=
 =?utf-8?B?UU5FYXRHR0s2ZVpaZFRWRzZqOHpzdmJQUk1oa1llK2t1VjUyTzZJazMyT1E2?=
 =?utf-8?B?MDZ5RllEd2tMR1J0T3ZOUmhobURaa0hMdkpVOTNLNnNOaVlkcS9xRXJuSFpP?=
 =?utf-8?B?K2tpZ0FoYU1BZDE5SElkZU4wSk1Cdmx4Nkd1c0VVcEN6d2dJT05XL0RWMGll?=
 =?utf-8?B?MWVqRmJKOVpqYzAxYlRSOVFXZnRzd0JjNHNzUEVuU1VWNWZ3SFZ1Zkx5NnhI?=
 =?utf-8?B?Y2pMcXVDaVVIejJQVmZWVE5wQXhWekNSM0lDWk1MRVJHRVd0MnRJYUdUSXVN?=
 =?utf-8?B?MzVFYm1VdW1SY2ZiVWVjRjRFemhDK0c2bTlOUXZLdEhNT0JKRU9YZmowTUNu?=
 =?utf-8?B?UDJXTzRScFdOK2tuZnZ3Vmtra2p1a0pVbGgxWGNiUi81UVdIMnNhY0tLYzZv?=
 =?utf-8?B?N0RLR01PbzN6VWt2NnJxNmRYaHFZRTIwbWdqcEhPcGRmQ2ZNblBiek9qK1ZQ?=
 =?utf-8?B?b1BFSld5clY5Z1I1YitJbUMxZzVpWXE3NTVSck01Zmx1WnFicGdEMDQ2UXNH?=
 =?utf-8?B?Ui9oTzZOZWFSdzBpVXJQcTNBKzVORXh6R24wUkEvSG5jS1BmNUhNSnB5KzVm?=
 =?utf-8?B?Mnh0Y0pPVTRXQlAwK3kwWjRpNVk0OGc4S0wyMTZ3cTQ1aGJzRmhnMU9CUEhR?=
 =?utf-8?B?UlNpT2dXanhycjlKc2h0WTBYdEVEWjdrQ3lNQzQ1SS9GRDZheFBYZ2RaY3dM?=
 =?utf-8?B?ZURwRHVFenRjcE1VblBxNGNmSVliTWNCZE1VY0h4N2RTYjBJeUpEQTcrL0Nn?=
 =?utf-8?B?d2IyT0wyVEJHZkFacXRlZlZoQStFRGtGSUtFZ2M3VlpIMThoVythUDgrZ0ho?=
 =?utf-8?B?R1ZuazRabzJwL0g1Ry90VmR1S095RlE2aGRzSzB6WXdGeHE2cTQzN0h2WEN2?=
 =?utf-8?B?b2taSFlKZndVNEF4NUd5dW16SGZDN1RUSjRrV2Z6L0d2VWxnK3FCeVF0bHlo?=
 =?utf-8?B?TUN0VnpzWHdGSWlEYlI5YURoM3FFWjJEQTRmWThHOFF0dHNVdms3Q0pGdWdi?=
 =?utf-8?B?OCt3TlowNFFEbUtVak8wZWFUaGh0WFRxMzlsb1F3M1BXcEEyNVJlWjFCRjJs?=
 =?utf-8?B?TEtQZEtTZmxrbU94Q05tTmJhZ21FdHlsdnpsSUJaVzBVWTA1TG44OXJhS29m?=
 =?utf-8?B?TUkwU2ZxcndYaEhqTG1iNU5HUkJxU0pEVmxiZHAwaTMySnhqS2NGakc3NlNX?=
 =?utf-8?B?Z29nbDJBVm4xT1gwNk92WWluQlQ5bTBaLyt6QTVaOWRWMmhDdjZtOGd0Qnkx?=
 =?utf-8?B?bnhBUm93c0hFZDBaY3hEbVJaci9sL1lHalZqdFUybFJGeWYxaHZLQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3340217f-fb3f-40ea-3835-08dea69f792e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:01:39.8171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGVQEs8gl7dGq92jUXpL7RuPx2GcXpxN6wqEzPcMhivsz79rIPJSrjuEkVx3g1ziD5YAFnEPTiB02skusIw+IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12156
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

Extend ENETC driver to support i.MX952 platform where 2 ENETC
controllers are located on different PCIe buses.

Key changes:
- Add enetc_dev_id_imx() to derive device ID from device tree "reg"
  property for i.MX952, mapping bus_devfn values 0x0 and 0x100 to device
  IDs 0 and 1 respectively
- Implement imx952_netcmix_init() to configure MII protocol and PCS
  settings based on PHY mode parsed from device tree
- Add i.MX952 to FSL_ENETC_NETC_BLK_CTRL Kconfig dependencies

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
This is a resend of the v3 patch series with the first one patch
removed.

There are no other changes compared to the previous v3 submission.
---
 drivers/net/Kconfig                   |  4 +-
 drivers/net/fsl_enetc.c               | 28 +++++++++++++-
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 72 +++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 666618681df..f2e838b84de 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1018,8 +1018,8 @@ config FSL_ENETC
 config FSL_ENETC_NETC_BLK_CTRL
 	bool "NXP ENETC NETC blocks control driver"
 	depends on FSL_ENETC
-	depends on IMX95 || IMX94
-	default y if IMX95 || IMX94
+	depends on IMX95 || IMX94 || IMX952
+	default y if IMX95 || IMX94 || IMX952
 	help
 	  This driver configures Integrated Endpoint Register Block (IERB) and
 	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 206f1a381bb..2e0683e8f34 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -74,10 +74,36 @@ static int enetc_is_ls1028a(struct udevice *dev)
 	       pplat->vendor == PCI_VENDOR_ID_FREESCALE;
 }
 
+static int enetc_dev_id_imx(struct udevice *dev)
+{
+	if (IS_ENABLED(CONFIG_IMX952)) {
+		int bus_devfn;
+		u32 reg[5];
+		int error;
+
+		error = dev_read_u32_array(dev, "reg", reg, ARRAY_SIZE(reg));
+		if (error)
+			return error;
+
+		bus_devfn = (reg[0] >> 8) & 0xffff;
+
+		switch (bus_devfn) {
+		case 0:
+			return 0;
+		case 0x100:
+			return 1;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return PCI_DEV(pci_get_devfn(dev)) >> 3;
+}
+
 static int enetc_dev_id(struct udevice *dev)
 {
 	if (enetc_is_imx95(dev))
-		return PCI_DEV(pci_get_devfn(dev)) >> 3;
+		return enetc_dev_id_imx(dev);
 	if (enetc_is_ls1028a(dev))
 		return PCI_FUNC(pci_get_devfn(dev));
 
diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
index 8577bb75632..0c87d80ea5c 100644
--- a/drivers/net/fsl_enetc_netc_blk_ctrl.c
+++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
@@ -35,6 +35,7 @@
 #define  MII_PROT_RGMII			0x2
 #define  MII_PROT_SERIAL		0x3
 #define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
+#define  MII_PROT_GET(reg, port)	(((reg) >> ((port) << 2)) & 0xf)
 
 #define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
 #define PCS_PROT_1G_SGMII		BIT(0)
@@ -97,6 +98,9 @@
 #define IMX94_TIMER1_ID			1
 #define IMX94_TIMER2_ID			2
 
+#define IMX952_ENETC0_BUS_DEVFN		0x0
+#define IMX952_ENETC1_BUS_DEVFN		0x100
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -567,6 +571,69 @@ static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 	return 0;
 }
 
+static int imx952_netcmix_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode child, gchild;
+	phy_interface_t interface;
+	int bus_devfn, mii_proto;
+	u32 val;
+
+	/* Default setting */
+	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII);
+
+	/* Update the link MII protocol through parsing phy-mode */
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		ofnode_for_each_subnode(gchild, child) {
+			if (!ofnode_is_enabled(gchild))
+				continue;
+
+			if (!ofnode_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return -EINVAL;
+
+			interface = ofnode_read_phy_mode(gchild);
+			if (interface == -1)
+				continue;
+
+			mii_proto = netc_get_link_mii_protocol(interface);
+			if (mii_proto < 0)
+				return -EINVAL;
+
+			switch (bus_devfn) {
+			case IMX952_ENETC0_BUS_DEVFN:
+				val &= ~CFG_LINK_MII_PORT_0;
+				val |= FIELD_PREP(CFG_LINK_MII_PORT_0, mii_proto);
+				break;
+			case IMX952_ENETC1_BUS_DEVFN:
+				val &= ~CFG_LINK_MII_PORT_1;
+				val |= FIELD_PREP(CFG_LINK_MII_PORT_1, mii_proto);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (MII_PROT_GET(val, 1) == MII_PROT_SERIAL) {
+		/* Configure Link I/O variant */
+		netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
+			       IO_VAR(1, IO_VAR_16FF_16G_SERDES));
+		/* Configure Link 2 PCS protocol */
+		netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(1),
+			       PCS_PROT_2500M_SGMII);
+	}
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
+
+	return 0;
+}
+
 static const struct netc_devinfo imx95_devinfo = {
 	.netcmix_init = imx95_netcmix_init,
 	.ierb_init = imx95_ierb_init,
@@ -578,9 +645,14 @@ static const struct netc_devinfo imx94_devinfo = {
 	.xpcs_port_init = imx94_netc_xpcs_port_init,
 };
 
+static const struct netc_devinfo imx952_devinfo = {
+	.netcmix_init = imx952_netcmix_init,
+};
+
 static const struct udevice_id netc_blk_ctrl_match[] = {
 	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = (ulong)&imx95_devinfo },
 	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = (ulong)&imx94_devinfo },
+	{ .compatible = "nxp,imx952-netc-blk-ctrl", .data = (ulong)&imx952_devinfo },
 	{},
 };
 

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260430-952netc-168485943bab

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

