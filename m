Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4814FCD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 05:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9CE84659;
	Tue, 26 May 2026 07:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="DRIJxjPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B88184671; Tue, 26 May 2026 07:33:25 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 196ED844CF
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9auZi9ipWPVA72frU7jaEufkzKnq5MDgXyvs+tm1blK2TsqIacxDO5Cd7LMQV/mUXX6Q7ecuPHEEC7zU8D9SC8aen4W+kT5Hz1/5VzQgMS7OY3795zKz73VGXeC3XvPHuPo7FP8eL+oHGPb9vFN2G0Bsb1+5IzOO4JsL4LycuYWWP5ZaiCyD0O8I475D6jH8HFdc+0RZbTi+++N8a+o9YMV78tdi/dn5r5ghx6raVp4gG9UYo77zLZXWbUK0m/Emx2cIuQYQfd8/wVDs+Pi28Da/PkZwSwOiMyFmercPfSLq+uVMHjkEvg4Cx1yPMx+yRE8vTGrqUXJLFcGNxbuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IOdMNFhJhfdfc8kMhmUakzP3X5mQ95kliENu7ML51M=;
 b=ZSMw4x09eMzl0C73perUUwWTrMVGkkSMPkz6Aa/Tm1QT+mVu0iRXrX7cpK0Cn0g7BA7sgXOmynzs4dc5gCtXcmDTAJNMj0/0mrhMdGfVwHOaxDnLoTf0nNz89f/AKn58/sTchUM794aL2nU4drDtVceJVq3flMEAm9OOVRroPMmXnJcWdVS7pSqA6ZTlZQ379pdctpc3Bv1HPMbL7quJ2w37h+HT9v7pGOV4LNAbvTH2peb/BW38wrhed00Hh6HM6Yv2mj+zoFF/nF+7fhMkO0dCQoItA3JDi+dHSLY6unyLdgC3nBfSF0iGZyBoI4QIwtugIEVrSXQAEFO3qJU6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IOdMNFhJhfdfc8kMhmUakzP3X5mQ95kliENu7ML51M=;
 b=DRIJxjPk6rKDOuBYhjk8fEzlvdigWjjFrXHWlSvhW/dFrrpBQwzOsIk2LPi+lAnd/uQSTIGV9q+jyLoh9djTbJJP4oxj9hXHy0w47xvkcMN3pXQ+SO/hecYRIznWNq0WyQMRbp7hXDRskuje4LWmBblnTbhiXOFrO7jlMqatM/8nbUKh34mDD7n5NfKZBiDLxpT8Ilbk+YmKTlHd9M7FHG4T48hFQHe/dkcJa+G+imsNP5O3wxwetBwZnTIz1ulJtGD0LHPTRkxyuPAru6c+hVwb5TRmyj07msaRAb2ekBCdbdh55vPID1fUHkg8J4Sa4d7NydGFF/dG3UUYGJAkdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 05:33:21 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:33:21 +0000
From: peng.fan@nxp.com
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] misc: k3_avs: Use dev_read_addr_index()
Date: Tue, 26 May 2026 14:50:03 +0800
Message-ID: <20260526065003.2742336-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: e640df91-a357-4637-0c5f-08debae84cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|19092799006|11063799006|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: MUl3qHUsk3VbgMgFW8g9ZN8TNSw+icgzAZmEGen9ysiTGcj4e/u98YgGpsT5RKgd/2MNA0aogZaeBCXtpE/YcCE4idzrwIkv7XPetHPu5bbYa4FNR9bRFruHIztAy13tIJHU+hezjl0WApEYb5x0sBdrSuPoMRbVeqCBI5BRvLiSwKxwEVkHFLPkeQIzM/O0pLPhtYTRxWtS3iR+Cx4mNvaVf0xZJ6F76mZtQlneanj9rvnS1nAil2R5paZg6klRJo4W5grRxN4cIoyVOGFXA+FzT2dDoehI8TTt827d2k/MBt/5OLsQGzx6sZixKYLHtb71jFX4Ok4NJ/QvXdd9QyPUKuIvyt7X/pq5wZxy0RaUSh25G1OIEMl85R8i6m7lYzCV1c+YJBdZWoeISKHjGwpr62gggNzPTZlPL5j9KvkAMehH6+9nA/1urn1yYIMrXJ25UdBGoddEpDT2QFG9V1n2ACFjhEBEkVAvqlApAVxTbRlUcKDX0RpnLB8lVQDV8FWa6gkSp+RPkVCavDCkohHoxanFrNTgxnQz13PQC2zQ3YqvOczBiZHL+wr0aJ71hFJHxcZKs5Y9K1DFc0Mqr9bbh70pItvfCwjNK58MU2+5h/0SAZLfVgywZ+exEyVUdvErSg5TC5ps00sDR0SwSrZUI9db6SkMIEiEPnRa59RclnBKeNHeTP/nhnoxGRLWfgiYznAfertv7RszYmV7+/SspGGtcnoP7HG/8nnE2byNj7jhK4JBgUYy24qO6zcX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(11063799006)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KFYN8mB+38p6DfPXg+n+9g8iRozCWmMvsgJJ48tNWkzFChtnt2OVqjyrJgIz?=
 =?us-ascii?Q?EX3y5wcmAq+1E7yAbPjnMOxwz474C5/uZjBAHW7pcc/xwbkXRhPesDXJOcKh?=
 =?us-ascii?Q?a0UWNWXYCdYkX1TY6x50FgMD2UzAuzg7n0Cc1DdIyOII5CBjlFPPHz6WFhJ/?=
 =?us-ascii?Q?AwsQ3dK42S7n9bKm0idwdeC92zFI6sv1q09s6a8TfQGRtJ0xK5iqwpll+elY?=
 =?us-ascii?Q?FVsnHAvGL9w3klE4cb1axeDnbrtN2BdzRhW1HKmnXOVpUuagieXIWUPnhyQU?=
 =?us-ascii?Q?n68XzypPbBCKGlBAVC2U48wEzrmgixJB4e9PSz0DmNSGaDVawm77d/QaGUFl?=
 =?us-ascii?Q?57q+8ZgD3scTMfk23tB0rcCa3WT/qO253pp6dVwsN6ZnunjuD/wtKTAubOBP?=
 =?us-ascii?Q?NJwC4za+Od2cL1qFIZkLp7clZmHW+n8n7cuMEZAutEbqG3K22nkIO3u1txc2?=
 =?us-ascii?Q?2xQZHqe0UQ+scSkf5p21ZJe5dpjjRl8j4qdjgaXLRFYbiZsbEHAp265mkMJB?=
 =?us-ascii?Q?MXHgQNbBY4E13Cugr5dEjv56R8A8d9oz49da2y/sdD8H8gbA4BmsYjEH3Ei6?=
 =?us-ascii?Q?O5oXVSG+E22MEm/JH7p8VWfULRTzJLGsYea23sCO6GX+C/rXevpUfhiaH2BZ?=
 =?us-ascii?Q?1P2M6QRJT3X+Re08/t7beQNupeChVy4Sw8F4QOaVyN7KOKS/rHfywtgkI2dL?=
 =?us-ascii?Q?WpYJVhU/e4izSWkMut0WVWs/l/bb9RzR6l5HTEcbt0y8HRIh3uGly/WuKwud?=
 =?us-ascii?Q?/mlMBn96yOZNqkqX7sq/maq2yFR/EHCaihVwHPQpTgZpdNfR7LsO5i6dshdW?=
 =?us-ascii?Q?A4Jh4Xk7yyV7GogqR5WWBjjqG97VAxwi2HB740DXR2uwqhaEiQmMjGJWb9qk?=
 =?us-ascii?Q?0DDy9YmuF3f0qmEUlA9i26MzUb5jkbCcMFWgQZzzPztRn3NP7jBqUTWsDiOh?=
 =?us-ascii?Q?Lff5EzvKeGXnT/JE6mcUb7ExepeW7Yt/VubmDhq54HmgRwXA1F8+aSc+GYUz?=
 =?us-ascii?Q?3s46VdU+DCuhjmBrRxiSGjk223qsFjf22+0uZJ9jrjE18JyMWBBacU8uLDQp?=
 =?us-ascii?Q?M5mrfE5bwWZAZ8q9OaPcKtsXBVDRSafR5dXRCTWaH3v/gn3fo43EnU/wZQ1W?=
 =?us-ascii?Q?MlGXlTevnrxBY9/d/f2Qbd515K5+mBAJrVIBQshXzHkxfPda6YeYA/uME1Q/?=
 =?us-ascii?Q?nZKAGIV27PcS4efaEtpv2evMlneah3TLF1SPWqvQVmSguBv4md0RrVtubaJ3?=
 =?us-ascii?Q?nJD9zdvuhjkzuyCvFWCKDHZWFdEbm4zkD3HoTjiOUFBbTKd1qIQ8aA88iaJ0?=
 =?us-ascii?Q?hAHJNeD6yIyMi1M6em553Uu2arAXMeSsOYsot9qhLbiJvqMUnSLwHXt56YhT?=
 =?us-ascii?Q?apPivMzbcfcDwYt8iJcvpGYNEm3rd1aKYoohliqBGKLsdScAf6FEI08GHCt5?=
 =?us-ascii?Q?UKdXpPegpBa/f/0Wz7632XukeE7kwVhSRgvni1cCTPDVEKoDQQoOOL2hLlBW?=
 =?us-ascii?Q?HKJt7sD3nm4oQTSAD2CaMNx2M4IicCHEVSIuS5gIOYNjM1WUObO7xpn7fDqg?=
 =?us-ascii?Q?W7cesMoWTmmyeA7M7pkgAGvMUJ/tUBoGgr7gS5NQDoTVO9NEjt6YRmH4vpFP?=
 =?us-ascii?Q?tc/SlSpJrszqN6+GRdIgKRP0L8PcsEeFbm4BJWwKTFcwvCVxkyTNpdXFZ79I?=
 =?us-ascii?Q?uq7uD8RkLTlz7/uCSrVeIrs1wZVGkDKQ8m5GIUtifiWx4UaZUwCe1/d5jr5W?=
 =?us-ascii?Q?NUInmAg7UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e640df91-a357-4637-0c5f-08debae84cad
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:33:21.7492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFotGJ4PebpnM+Cpe/Eu5m90OQm9uyGIvsLBYsGZUY3oQTlHlOkNR9BGe7wRaFwnYxAktXUUk0x5LkeduYoofA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/misc/k3_avs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 0774e0a4c9e..a885c99c547 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -300,7 +300,7 @@ static void k3_avs_program_tshut(struct k3_avs_privdata *priv)
 	void __iomem *cfg2_base;
 	void __iomem *fuse_base;
 
-	cfg2_base = (void __iomem *)devfdt_get_addr_index(priv->dev, 1);
+	cfg2_base = (void __iomem *)dev_read_addr_index(priv->dev, 1);
 	if (IS_ERR(cfg2_base)) {
 		dev_err(priv->dev, "cfg base is not defined\n");
 		return;
@@ -319,7 +319,7 @@ static void k3_avs_program_tshut(struct k3_avs_privdata *priv)
 	 */
 
 	if (device_is_compatible(priv->dev, "ti,j721e-vtm")) {
-		fuse_base = (void __iomem *)devfdt_get_addr_index(priv->dev, 2);
+		fuse_base = (void __iomem *)dev_read_addr_index(priv->dev, 2);
 		if (IS_ERR(fuse_base)) {
 			dev_err(priv->dev, "fuse-base is not defined for J721E Soc\n");
 			return;
-- 
2.51.0

