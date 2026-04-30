Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1ABFF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 09:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CDCB84662;
	Thu, 30 Apr 2026 11:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aiTPJI1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5357F84666; Thu, 30 Apr 2026 11:54:06 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA708464D
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk9xmH/jzfy02ccQg0vDReSmKSTgJxr2GCel1wuLSjCpIV+0sQI1sx+d+DAirTJqlukyc+IjuLvt+5eJb04EZSS20+Ey8AQtyfKgdXQeyB4kGGkml8hVt9qVM1IksAQDLkyFffEagW4DiwaZgo4d+befQtMUm7yWNi3kg8laB5h2Lz5I+WsWv9jv7ClYq+jjodAxEPDF22OrSo23WLq/p9kx2Y3rBTMTtjS3RekTdJgjBfwpVlepFdM6wgziQKgFgfN2/7WLgfMzxXG4lvJ1ghyAZmZn4lbFHxMnRtlmjpydzoOTg648D2IUDVAtxeRuRUaDZ8niuCzj4/wRkBfNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7HbgbiHEFSrc5lHhJ8m+RC/kiUlMhLVol5xA7Fb9QE=;
 b=tV0SFLWN9Hh1KtxU1zM3jiX7BubJ2BWMKFol3BPHFxuXhD0lwJ0+aiM63bKb9MfbG4c2PkVT+cHwXMJzPKQ/3JMCFZk6F4TOoMds9wwDQK+bdqIZ69qzpyQakSDfAuEO5/oZyBpbs+5grVWq9YuSpgiTq0PMczzM5bTeckGsV6Dg+L9d1hbO3us64LDxHzk2zrHx9pbJ5k8LLdnrFuXXDRK5J250sJPKcRKCUQOG5LFQ0U8pd0gZxvMaJ1cAV1EKk5j3FoaS1VzONu0c79LFktXRBSYw++ASQrSq1lfRb/3Pp0n41uZu/TK3S5lzkxCjYr0hva1HfLfs1uiseowhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7HbgbiHEFSrc5lHhJ8m+RC/kiUlMhLVol5xA7Fb9QE=;
 b=aiTPJI1INzOlYeJx82js2HLU9rUau+XfkhjTvHLoyLgSHi5A9RbKZnsnZdnat5vINz7uMTDcs3xkSc9lfQkjScss1asoiMqVyfgjaoLPuovi2bHfQcjLJa6M3A22dZTX/zKP1ZTspMwLkqf5RmE/66rI7dNt/2MDnE9x0XdnbY3koSklom2Zf2WsRoDMO/KDdPjHgc4eUj6jTBOJZu9lz3AX6MuZdwZCfXbV7Xl5FE3hrzzfyttoNCeWorN5iDF02Mij5d6IjlVfDVHlXJrv7pv2nJwdVRIkb06WGUcha9ddF722x197Z3d3VLtCp2fjGZlUte6lUzd2dvVaJRYjjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV4PR04MB11875.eurprd04.prod.outlook.com (2603:10a6:150:2ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:53:57 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 09:53:57 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 30 Apr 2026 17:56:27 +0800
Subject: [PATCH v1] net: fsl_enetc: fix the duplex setting on the iMX platform
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-952net-v1-1-c90943a1d5e6@nxp.com>
X-B4-Tracking: v=1; b=H4sIAEon82kC/yWMzQ5FMBQGX0W+9W1S9ZPwKnIXRx0ci5IWkYh3V
 yxnMpkTgb1wQJ2c8LxLkNlFSH8J7EhuYCVdZBhtSp1nWlWFcbyqiizl1JbUmQwxXjz3cryjBnu
 K/+fC1k5s1+eA67oB8aMfim4AAAA=
X-Change-ID: 20260430-952net-9aca4ab6ad23
To: Ye Li <ye.li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV4PR04MB11875:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf89740-c17d-4f2b-dec2-08dea69e65b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: NNKdHh8aldaXTVXXDXzEOYPWRATdnLOCP7c+xwy/dL8pCeIAgfia5Nnrh0afNrhuO0Bkmw98TS4mgw8tAq7K69cBNdsYDtKd1BrPOKC6CTi2FL2nv+PtyOOuGyfq3y6AlxBD03LHbUVxaRqT0NxGiHAJphxryWxiMOWS6yAL+jlxYp3j6r5jDSoVrZzt7f4h7zUuvbAIrBFv0dvpHhSU6uwi3UOlaU29gB7d6fRmozaQWjjt+F/Xk1k/76ZjOcWPuYud+knqHYm8peUZ5Vok7WxB6fGDWx5fNU5QlG/Bz3yq9YWIYggFVumwIK50FZSpesGLdZdxSPvbG6WfOH0ar+n8RMYHF+y7TZ0bScKZYokFBnrZgF6M+Pd+6AQJ7myj4q90VCfSK3YXYB9lJ8FGVU5cNJobeppQk0h/NJ5kBLNH2/fAdyCS1vmm7FdsaCG+M3htYSIsx9HOfIi4cmwaoB660F+b/E0VehVPq8tKWXI4503dVNEeMaYT8noOcAZiZj+mtwTGK75B1cX3JtfgXCbRJSfJd5x7En9UfWq+O7Vf/+JpPB/b81rIF92FXzDDY/OBpXBWkgtKr6bj/LtZdnfx8iiK4uf9dcuvLylGp4qeiorjwxFa6TB1yEUq2QT66Erw4tVtV45mTMBybHD9aKa4ZCfC3N3haOvEH8DUa9wx/iEzpvxkU93Rikw5nyg5mfU1rMrZ0UJkRSQ2k8oAQOZp8PxrvWeoZ2SkCeo4hZB2KNL3LsjqiPS4pCSF/EAQmY+JweAKaKqaq1bI+UsQFxDozyvoxsjADYi55eHd3Hs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDVqb2Y4ck1PL0JKTVcrWnphMGRjaktqOUxRT3d3NGF1TW1WWWMzZzFmUTdZ?=
 =?utf-8?B?SjEzVWNCTTdDQ1dOWnR2U200UFFPM0xTQUdDZVpGdU9tVkNHeGdtays1VnJO?=
 =?utf-8?B?S2pZQ29WckNMamlmV29Zb1RsK25vV1VwWi84QjRHYmRySzRWREZncDUyaSt5?=
 =?utf-8?B?djNyZGh1TEZZT3pjY20zQW5veXh3bk5aMUlCbmFXc2Y3SXBTbGdBc2dtSmJV?=
 =?utf-8?B?YjZhTno3UTRocG04aGZsaDUrYUhRN1NaeE1DeG1VMDVlN0ZKSW5oMzdYZmdT?=
 =?utf-8?B?M0JFNS9wZDZxclJySEdwd3VXZWYvRmthOWdnOENVd09wZWpqSDJHMjZWNUt2?=
 =?utf-8?B?eUk1Q1dXc1p4NDBDVG1pR29OMGFmQktua0djejFqSGtIUXN3ZnJGa0dzUCtj?=
 =?utf-8?B?T09xN1ZjSmFDTzdkSDZTN243cG1KTXlYemJTUHJhR0N6WnhiMVZTV0JZN0hR?=
 =?utf-8?B?N3JyZXJjMzg5S21hZHhjbS92eGJNbThtdXlsK0FPdGFCUWc2UE9ESktVUVZG?=
 =?utf-8?B?VVEzUWI3WktnUnZWV1dHK1dvQjQxczdKNHdYeWd5cStqblpZVXRONnEwOXN4?=
 =?utf-8?B?Ukx1MFZYTUQzbDJHb0l1amdsbzk3UlEyVHMvRkpXa0RLWTVyREdVUjRwRjZ1?=
 =?utf-8?B?QXBNNFZkeGNrRVdhbnFWZWN4d20wOE0vRkd3N1RWYmxySDN5dzcwTjBFNkNt?=
 =?utf-8?B?cHcybHFzckRETExkK2tubjRHR1o0c2JPTU93NEloYktzM2p6UDZMS0NsaEJQ?=
 =?utf-8?B?Y3FidjIrRkw1anVQMW9sUm0zb2JPekJOQWdXWjliT3VRSDM4ckJlS1VvWGlO?=
 =?utf-8?B?NnRRNnFtSzhuNXNqbnFyaldibkpFSW0wb1N4YUx3YW1QWTZCb0dVRlprRDhj?=
 =?utf-8?B?WERTS2dtZzFMMFZLanlnaERsM3JQOThFeDllYVN4cFVVSDZCTjJTM2JsbklU?=
 =?utf-8?B?L0RiN1d3NnhNeiszY3lYNTg1VzB2K1FTMjJVVy9xamFVbTdTSk1uK1Y4Q0xR?=
 =?utf-8?B?cy9CYWRRZzdpU0dCTURXUTVVMUIzYkRDa2g1NUY5V1VVY1NCR2EvNitFS0po?=
 =?utf-8?B?QkJYQ20yZlNCaW55bjZMazlON3p1RUdDSDZNYktGUnM0Q05UVjlhS3lmbmcz?=
 =?utf-8?B?M2dOWFBjSWhYaUxtUnh0NnJmUUlSYmk3cVdac29aYUZzUzMxRVZETFZkWkgx?=
 =?utf-8?B?SE04VXVOZkNZVE9CeFRScFYrRGk5NzRIVXZtbDA1aGJvQnRzbGI0UkhHREFD?=
 =?utf-8?B?dThvTVl4bFhZZCt0b0NyZDlpanUzYmszUTFhM0xkdWhxVkJ6Zm5JaitxK200?=
 =?utf-8?B?NUVzSWxyZnE5bHphaHBXNmtPb0h5RTRJQktBeCs2ZGRXbWM2WTFaVEVGMXdO?=
 =?utf-8?B?Y21YZmhTMjQrYld3Rzl4U0ZsQXlQdXlOWkpSeWdRNHp0eUZDUnYrQWl6OStt?=
 =?utf-8?B?OUxEZ3JsRmkxYjBKMU15T3R1L1ZFWTFMUWZJRWh6OE1XMW82Yk1rY1hPbzJq?=
 =?utf-8?B?c3pKODJCQmM5NThncDhIS1hJM3Z0b3RHa2N6QTdNV0x0Z3Jja2Q2NGNXR2Rs?=
 =?utf-8?B?cGtWNFdtM2ZNeDJDbm1MaGNHMWk0d1VNWG5ZMXVscjVMMTFYcDNBUncyZDJr?=
 =?utf-8?B?aGFTaE1icmhIK3NscW9QcWF6Tm12MTROZHNHZUJZZXVCaFB3N1JTWkdWZ1Nj?=
 =?utf-8?B?MkN5ZzZ5RTYrMS8ydzhOempwcUVEM056Vi9ZNGZCVjhuVml2ODBZYlpQMGky?=
 =?utf-8?B?SmppYjRFTDhiRGltQWVNVkRQWHVZNTZmUXhpSUFTdHdRaGJrTzV0dFJKYXAw?=
 =?utf-8?B?a0g1Q1E5TDl2emxyWTlLVDlTUnBsNzJJc1d4UEE0dldTOHBLUkJYOGZReWMy?=
 =?utf-8?B?c3Avd2ZPb1NMMFBXSE1XTHlhSlU4cEt5N3l1eDNxME9DMlQrTUh2alE3aWYz?=
 =?utf-8?B?cllyMml2dnVmTTlJYmxOY0ZKYjZwTTdMMit3Z3NmbkdMRHEvcDR0YlZxRUZm?=
 =?utf-8?B?MjlCSzAzeDZXdnR2N0d6NmZCa2dIK2tMK04xenBRSWozSk5VSjNpRzhHakdX?=
 =?utf-8?B?QkdFaGV4VFRnT3YyUGRrZzhmUVhMb3hscWY4TlBoMTRVdXdEWmxWOGVrNWdT?=
 =?utf-8?B?TDBRck9Gc3JJemU3SmlaaWEzY0l6UzFoUWdReU9RcnFKNTh3L0xJMWUzYk9p?=
 =?utf-8?B?QlhlYi9RU0lMOXpQdFc1OUdQWGJ2Nkc4ZDFQWFkzL3JSNDB5d2JyM1FPM29s?=
 =?utf-8?B?WFJlVEhVdVpSQlJVY0liZGFOZk5mVTNTN0x2bXNMTGxwbk9TT09STjdkZytp?=
 =?utf-8?B?VE8yUFEvTm1oSVlsZklRSlF1WTB4LzJWUnhZakdZSGF4STdhM0Fndz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf89740-c17d-4f2b-dec2-08dea69e65b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:53:57.7355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aDe5o01VWwAiP3KEVJ23e3xhSzO4HGeM6VH42Zm/ogqF9UYh08RaErIIzhdy3k60yZS0GK8BAC0smI1Inxuxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11875
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

From: Clark Wang <xiaoning.wang@nxp.com>

The iMX and LS platforms use different bits in the same register to
set duplex, but their logics are opposite.
The current settings will result in unexpected configurations in
RGMII mode.

Fixes: e6df2f5e22c6 ("net: fsl_enetc: Update enetc driver to support i.MX95")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
---
This patch was originally part of the "net: enetc: add i.MX952 support"
series, and is now sent separately. There are no functional changes
compared to the original version.
---
 drivers/net/fsl_enetc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 206f1a381bb..b07193e4e83 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <pci.h>
 #include <miiphy.h>
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/build_bug.h>
@@ -396,7 +397,7 @@ static int enetc_init_sgmii(struct udevice *dev)
 /* set up MAC for RGMII */
 static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 {
-	u32 old_val, val, dpx = 0;
+	u32 old_val, val = 0;
 
 	old_val = val = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
 
@@ -416,15 +417,14 @@ static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 		val |= ENETC_PM_IFM_SSP_10;
 	}
 
-	if (enetc_is_imx95(dev))
-		dpx = ENETC_PM_IFM_FULL_DPX_IMX;
+	if  (enetc_is_imx95(dev))
+		val = u32_replace_bits(val,
+				       phydev->duplex == DUPLEX_FULL ? 0 : 1,
+				       ENETC_PM_IFM_FULL_DPX_IMX);
 	else if (enetc_is_ls1028a(dev))
-		dpx = ENETC_PM_IFM_FULL_DPX_LS;
-
-	if (phydev->duplex == DUPLEX_FULL)
-		val |= dpx;
-	else
-		val &= ~dpx;
+		val = u32_replace_bits(val,
+				       phydev->duplex == DUPLEX_FULL ? 1 : 0,
+				       ENETC_PM_IFM_FULL_DPX_LS);
 
 	if (val == old_val)
 		return;

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260430-952net-9aca4ab6ad23

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

