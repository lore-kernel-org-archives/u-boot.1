Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BF51048922
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7FB83EF9;
	Sat, 28 Feb 2026 02:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YHhN1EIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A224583EF9; Sat, 28 Feb 2026 02:43:32 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8398683E81
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZzhyaMDCvEFU+/nQCFbitecJnPi6m78z/StVex6Z5G30st/QVeT3fNjIzMqGL/4UW1YhK705rO7a4yOp5L84+pY+7rOCY3Ck8P3b752RQHcHJ254VIPel50r8++8xUymCxvqAJhk8xx+WP6/H7H3B8uSG30JZD57ThNNx7rqAprVbbBrpK32SmkXIDuTnOv8yJMAeyi4w6odZ9jusqCX/Ew/UYu/k5HEHzjaBfq4ExWXHfTi9XeexV145Iy08U5DufkadRHSpxDLjxFuaO++DIKwCqQmrx0uKDT0bk0n6y9HPwofwjNkG94EGIcRf3G4RCM9lRjuz39l880AUOMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3UsWtWrOHe/l1u6MtbjAdeUmVbJMHhz2M4nhJYmG2g=;
 b=wqUEpEMwyCBxNwiRbKIkcZdYH9jMoKrN1eSGVZy+742N0e0BIHdTSQVtYvU8Qzcpws6CRKKzrhZvBEUGMAp1rWrRAOH9v7/x7/p05okTE0wntyTfiAMu8U/jAQ6Ydm2ucMmFJhtYJwJs77LzMYCgBk2Ja4RCP5fp3ls8anfv7dj73QeIPI0cXe2zk0fyuadV7EglZ3iR7j5ggJAnR98J7JP64Gsfvdfm6S9X02sZ8nmNSIIWogjJOMywh3RhAS/4sr0/dT8JxM9fVj96WKMJ3mECJ53dPVs5SoRzlsD+Zbwv6juy22S9teYpKm8DTLk9PrIT1/gBDY/8ilKswMMhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3UsWtWrOHe/l1u6MtbjAdeUmVbJMHhz2M4nhJYmG2g=;
 b=YHhN1EIU8/SMElNNuRCW0aQl8dMIYZsbPnTSY//Bj7l+9X6sS/udmveO8dmgTD885tfA4JXp+X0lHD3qeTl0Idk/w9E9iyfuw+m/jjLMr6RajjEdT0Pn4JYFg+U5qemev9OgEtDsiwIbQywWKyPI4wunPmfAn1C3C56ivWVEatn2e2l8UQEl8/+uAjyqHGz3B3WDNTdK8buDSvOHW0iWxi0JN/HfjS4fGUYdv8eQlVeSl8o7h758GvcYNN2/3tH39SUZeoxjzBJ3p9iygAP/K0t3scFOBbu1KGhxxFZi6+/DZ1iP4iT1Br/VKwSB3o4L+lTqp9ZmhWLiMtGhj7kvMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:43:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:43:26 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:24 +0800
Subject: [PATCH v2 06/13] imx: container: Add i.MX952 support to
 get_imageset_end()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-6-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd1e29e-9193-4463-b8c8-08de766ac43b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: G1pXMMmZztvWaGm1KFoV69thnlpRWTqCxaCHaVOwq+9LcwFTREhlKwfNy8gBZnFdc5XEs6dJDkCjpDF51oUmfkqeORAmiu1sQyS0JVFZ3TvW0SO+1bSOJLS0I2A6LHH6jFTT/a44IBwAkoUUexK6aJQwGpXDku81XXS7Gk/hIQavEiUDX17HjKWLpJVgbLU2rhsEkRIMoRZwLGNowfgu9bGRQE4T+G4nnxeEBomlP52Yn4Blb9SIkuT/IXYHuruOPK5UDGgKeDK4qMsIbG5ywJs6cuBjYVo0QG/i0DE+TvHjX2cf183YxaF7xs79pEiAJNCCjI/dVKMmp4VembCVKLLfAvgkmKU2qAJvUpaauXCZI8l6Oax9BjoC1e/oh932+e91uK1Snzmff3LqStIV/VsujyfCIK62Q5vzfQqVAThti6VmbmgZJ6bLq2M4cGlHSYx01NsMQ3lLHMjkmzQDENE7mKYvVte8gZ3slXKwC7NsNiplUaKQ6LMmzX1Nhp2lciNbQOlRXJY14j1ooDjhNwZD+iqZD7KVqi93OEewgDYL2pHuxVogrlcfZQjOIT6nh+r69Kv8I7jG5UtL/0vY3JhXKhMc/V79dAOxi5YpESIjriIu2UAvOaaYtTFnoJn/rf8K83P358XNYi4swYjFxo/1KearSdtuQnruPGSJF3xRz7UPZAgN0ayA2i1Q9ebo7mpQ9zQulG6sF65i9hmadKd/0XGM8f48UVnYG265EqodG5/B4u+cDyArZSRwNwhuIcsq3UwGLOklJlEUbwXoUtn/wlLtWw1rgZWfw4hwdRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T09BMjk0aTgyS2s4SFhaSEo2SUlIcVNGQ0Y1YjNkWXRCSmRaOXQwUWhxSGhk?=
 =?utf-8?B?ZGFIbWpkcmRtR2UwSkZkRXdWbndMZVRTaFRxSW02Zk9XRnluSWMxNXc5V1ZX?=
 =?utf-8?B?NnZxeFV2Z2tFUVBMOTAzTnp6R3I4ZzJ0ZHlkbEV0WGozSFFDQXg1SUY0R09p?=
 =?utf-8?B?VUpLNTNtTU5YTG91RTNDeHpwTEQxdThhY3ZOdGVsU0pCWjhJd2NBUHNpT0JN?=
 =?utf-8?B?QmUwaXhqQnlhdnJRZFlIV1NBTitkV0xBYWdBcUc3NER6NTA3ODhlSFlJeXpD?=
 =?utf-8?B?MXVFVUNEYzY4bzVSblpGbHFobkFNSzVaSmp6OCs0VEY0cmQxYzBxd1U2cEc5?=
 =?utf-8?B?R01pQ2xoWTFKY3hTZDNOTG1udDVpbzkzS2dIRzN6bGhxaStsVitLNThvZWYz?=
 =?utf-8?B?OVh2V2dIZW95S2J5bCt2U0U3eTIzelZYckJPNGtEL2szM2FrbDBxdGtXeC9R?=
 =?utf-8?B?OXpsUUxvSjU3TDdDT3J2WlkwK3BxVXlya2RhTHRKcFVrMWZ5MFdGaVVtUy9L?=
 =?utf-8?B?RGpCNVl5ek9RUzB5L2MwaXQyVktLbDFLL2xMM0MvQm9ueFFyeWs3SHowb0pa?=
 =?utf-8?B?Y3dGWDlzbTk3ZEhxdWo1MXhBRTBmRkNjQ3JUU3ZmN0xCcjFNNkNRckpXRTBm?=
 =?utf-8?B?NEVIK0ozL0NxclZmSGZPbC8vMkxjejQ0UWRkT3pqZURyR012ek0rTXN0K1Rv?=
 =?utf-8?B?Sk9Md3FpczNuNWlrWndDNkNjMkV3bTJyL1VMV1ZoVUM5TkJlKy9lMG1MejRQ?=
 =?utf-8?B?eEZ1MTA5dDdla0hERzJiUnlaNFJ4aUVWQjJ0OEhuT1hMNlYzTEUvUUpBTzNK?=
 =?utf-8?B?eFdiMCtiYVdWOE1LYlVIekkwNjIvcndzTzFBSnVDWEVwNFdoQXpDVUExdmVZ?=
 =?utf-8?B?Vmt0WEJkQ3lRSGRTZVU3dWlmYWpLa2lUenlsNWhYMHNUcXBFQTVqRk1DNWh5?=
 =?utf-8?B?Ri8rRGpmeXgraEV6QkpUYUR0T1YrV1l3L1hRT3haYVFJM3hMTm1KVWdSalYr?=
 =?utf-8?B?NHIrSVpLa1F3RjVWbVUzOW9Nbysrd3JtMnljUDNXSzdqRWZRbHQ4V0drZ0g1?=
 =?utf-8?B?SXpiRFo2cU4zSFZiN3lCdUpTcTE5dGJwamg4ckRVVXRZNHJyV3IyZnhkcitD?=
 =?utf-8?B?SkpJZmFpOUh3SllNaVhLMkVvNjZLdHZXdFd2ak9kclJCMkNDRGFNUCszeFFU?=
 =?utf-8?B?TE1haGpHQ1dEWndPeC9LYjZLeXJPWHBsUldtSlJ5N2xUM1V1ZkxNbm9rVnlT?=
 =?utf-8?B?ZDNqbGQwRjR4bGVaVjYwU2FaZ1Zna2VobGEwczVlanR5eEhSTmczN0xXbWNI?=
 =?utf-8?B?WmY1RDNFUThIdUUwSkk2YndaZExnaHYveG0xSWxPNnppNm1HeW9ueWpFdkxl?=
 =?utf-8?B?amFyVzVxR3k2NWJJakJ5Um82Y2tqSGcwdnVNZ0lCRUpnb0tCVFhZQTFIUExn?=
 =?utf-8?B?QndQR2kybUszNjFCTkNMQWFOZGVuVHI5VzFET2sxeDdEWW4vVmZUV2pJZmdG?=
 =?utf-8?B?RDRpR29FMWNsdTJQYjNiQjBmSGJFSlhXQVpDVjVNdmg4SVRINVVYMVNpSVJQ?=
 =?utf-8?B?OE81eks3TDB3SkRVakwwTlZEb3hwRHU1Zm5mbEdIRElKdmkyMHg2eXBYV2Zy?=
 =?utf-8?B?NnNod3ZCUkFKZmd4dUdONkhRWTg3S2FQYTFEeUpoQ3A2QVE2NWtidW5BNDVi?=
 =?utf-8?B?SnhFTExJaWRIVkFqc3NIWGo0OFo0cklOU3BWbkFVUjVFbDg4UklxdkF4Q25J?=
 =?utf-8?B?NFE2U2FoODhacWdYVEQ2OVlsWnc1aFdLdHIwU2dVYWcyV3JPQUx5Yk5MYjlG?=
 =?utf-8?B?ZWZiYjROWHpvMndEWkNWdjEwcWt4R2szZzU4NW9IdEdYUTBUejNtQnJlOCtn?=
 =?utf-8?B?V0xQc2FBYTJ4bGNGeGp4YnhRSm9LZ2xpMmdGNzduOEw5WmVPdndrOU5nR1hl?=
 =?utf-8?B?NVJYS2dBZGFsNHRMd0U0bzRCay94MUkyc3J0N1YwSlU5YUdlWk1kc0x5ZDVw?=
 =?utf-8?B?YkllWXYrZml3ZG5TcElYMlRXcjlZUk02VVVzSktqS1dPeUhvQkYxRG9oRlZl?=
 =?utf-8?B?T2N2cDF0SmZLVUVwZ3FTbEVFV2dHTkRZZVpFZ0dRSXNKaVBSV25kUjZHZVlh?=
 =?utf-8?B?ZEN2N2ZvanJ1aWxyVlBQVHBxaUh2a1lMa1ZhTUxibmw0NVRYSTBmK2dNOUZw?=
 =?utf-8?B?SDdSVmloVWhLWlF4R0dXVVpZc0J1RDl4WkY3OTJBSm0wOXM3NW5FSE56enhw?=
 =?utf-8?B?M2RJM3dLTWtpVU5BTzhqbmlLdkozSzNkNTJGMDVRWXNXSkZrR0tTWHVJWmRD?=
 =?utf-8?B?QXFGSDYzVFp4dmt0L1ZETVlRK0NxV3pzUGdjL0FINStWZ2psWHlmdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd1e29e-9193-4463-b8c8-08de766ac43b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:43:26.5616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25UkhuSMpK/lRjGFFbVuPEgGTIIcnfO27ctCQEmeFfMfo6McUVrcVEd0QGTVIeqUfloFkRDD1VDQr32asFR9jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

From: Alice Guo <alice.guo@nxp.com>

Extend get_imageset_end() to handle i.MX952.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 78f2488cf6d..7bfcc9d7e9d 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -297,7 +297,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	if (is_imx95() || is_imx94()) {
+	if (is_imx95() || is_imx94() || is_imx952()) {
 		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 
 		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
@@ -321,7 +321,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
 	if (value_container[2] < 0) {
 		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
-		if (is_imx95() || is_imx94())
+		if (is_imx95() || is_imx94() || is_imx952())
 			return value_container[1] + offset[1]; /* return seco + v2x container total size */
 		else
 			return value_container[0] + offset[0]; /* return seco container total size */

-- 
2.43.0

