Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C0BC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 03:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C644A8494B;
	Tue,  7 Jul 2026 05:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qKErP+qP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3C5801A9; Tue,  7 Jul 2026 05:30:34 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F3B8490A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 05:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZJ1xluLM4AnV2k7x6J6WB3zS0hcYAK+mN5SFnbCo26jForXO386aoQqydUIoDoE7EF7/m+hBUwDVxAwUMQMnU/zuqTOHxuVuJNEv99oOntf77NZ7Nyt60gL4Z0heZRH4n5uqqMoCnRKAvwSahSToVnc+DWHpOx9yRdyv0O6VojEDFTqts8wljw+RUDmka+RDcScKPTddWmID+VYkulhzULIyaiNxT/8AyHiUs60oP3AbobzRnvuXRkN90C2yyDOj8qIAx/GAusfMGXuBHK4BcuwcAKNRGKswuqVHDTyRx9xJYgl9TIaJxtVnRlSFq2e+At8J+r/lXU4iPaBIZgqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obBnECder6V0fR+/A7ffYzBgemGy51KzhYAqP63q41U=;
 b=PfSNvd5toj9Ipsx9lDzuPqjieL0kSK6D1gOFKUXDMQapycsvEdPBgJ/HLoDtsh5nsX7HonuYN7ydN1zuB/0/anEIyiECtXiglbpx0bXX4a6/GODHr33I+HYlY5yWjMhs40msxKgH3Z4EitLRgWX1Nm71zC1wbmoLBSi1mtrpfKHID46hdVFNoJXLQeVuaBl5hVeF2VdO+T6o1ubluTb672MxBrpQEA2SibWbevJ3MvPFMP2ZCYaP5hdV2gu8gH5rClBG1WqbJIeWDPdteV5A/IpCW0D+9gt7tqO12o9YKJYJ8lPwnsxKxk1M7hFtvVEoKSYeA1IKr4e+OnQp/QCDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obBnECder6V0fR+/A7ffYzBgemGy51KzhYAqP63q41U=;
 b=qKErP+qP/MjFphYxqLeAqM9O809LK9TZC6UwXweg6RGq3m44tJ5D5kQCnm0k77r1TRv6jmmmDrQpDhkFer8x6pBhqo09GcSfmBCbdfd7Olcx909A6j8BuB+oyd4Tpcu8LtCXeMWV/ZJUsDCqX2Tk1qNNrooAyZnHigM+999daID7aWHFDm93mA6Zo0gFkR9KhtNlT2Mrt9bxMQwtXXjzOMhK32axOk8lLLxXVyf0zthSI+USzGg+93tfWDLu/cm9OkMi3T1SvNimgbytWXUqUaIkMMtDeK7+V8t2FWOTxAaeMdM3sqlynmVKHmF0ME3G2xeWLDQhIuEsS4fcDh/9+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 03:30:30 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 03:30:30 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 07 Jul 2026 11:33:49 +0800
Subject: [PATCH v2 1/3] net: fsl_enetc_xpcs_phy: Extract common PMA MMD
 init sequence into helper function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-imx95-v1-1-5b4b0f03d5e3@nxp.com>
References: <20260707-imx95-v1-0-5b4b0f03d5e3@nxp.com>
In-Reply-To: <20260707-imx95-v1-0-5b4b0f03d5e3@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0286.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::9) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|AS8PR04MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f8739b-ddea-4a1d-c054-08dedbd81898
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|19092799006|366016|22082099003|56012099006|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 94QutZvCCj/r2/g2/ritMwFD+C/P0a5jye7VRRHUHx5kqNBPNjYtCIGYFPFkotcA4c5nduY+G2kF8H8XdsVvkzQm8leRLaCk7w5dM44h9zN/AH7UxEtxM8gqxiAZh+Km6Iei4Z7BJG7dlidPATl5bsdW4QnknRqyUTHNanWpC+IE4tOPbmRuDMh4AalIrym3rwx9ITYdD29XOfFYt5FTZbcMiEn2sXvZz1JzTSXYRDTOTRKCYFfyM6Y+1ptwMXGoe9dVZiOYFp99HJs9TJET1tBbv47JRBF3gno0R5zA7tKpr/ftKIdT9eKlwc7j64jQfFLVoGEzgFfbx2m93Yq1RA2/bh00a+PlDj80/nsUlZRK+uwsFzGqWqbf8o3sG3q/ZGXSxXK8vZnPE+P2h/3Vao+Kk5JMrEuYAQLmAQgUOSDMj3Iv3eJBhB3mLfrHxRP9u++wFOba4p/3ARB2SH3G0zsa05bg5utcGqQ06FxpXOFynLj2Wt0BSt0DUulM0XQipGk9eFxzyHDdCuvmGLEWR6CXQv1w0bHwC0WvFDD5+upVneFWXE7AncmW8VpHCilBnNYHSNpJBcDvdgsmIclEpJwQ0n8/nCs5u79j+pkRnsp/WMdCGsozQu+A04IwkJvI2cfK/gKOx8+HIrgdvx1XCc7QgSJ9TkaXOQQ2gKd4E1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(22082099003)(56012099006)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9qdWhrWnJKZzBWS2xTN28zbU9Zb0h3RGhNOTQ0Smk5S050Mlg0dkthaENl?=
 =?utf-8?B?cU1QSXRGbU9RdnlYd3JpTURJZ1FXa212QWdQMEVHdy9kdW5SakgrRXdSUC8x?=
 =?utf-8?B?MHJNZHAreVgxSGxRVGhzTmFPYlBnTlB6R1BaOHlWem55bkRRTzRQZjdhSUd6?=
 =?utf-8?B?My84U1JPdmt4dm9wT3RzN2VXK1hYNHVqQjZmUGRVMjFscjVxeGQ5c1VJdThV?=
 =?utf-8?B?R3ZZRzdDbGorK0VxNXIyWm9GOGV0OUtLZGhuR2QwSUhDeGxjWHFGY3VLZDdX?=
 =?utf-8?B?Rm84Z3ZsdzJtdXlVcG9YZVpZamhSNzhGeWpJY0FnTkRGaVJGelJBUCthVmp5?=
 =?utf-8?B?U3I5RVZYNVhQN1EreGRBWjZPaEhYT0U5N0h2RnFtVWpaeXJiNlFJcmFiUzh3?=
 =?utf-8?B?SzI2V1dZZ3JRMzRpbVNvK0FBVTh4TWJuMEJKVGlqdDlCelZ5Q0hYZEs2TTY2?=
 =?utf-8?B?SUg5ZHNncjg5SmJVUC91UHdSTzE1bG9Kb2VrenZ2bVRlTDdJcW1URmpSUFFL?=
 =?utf-8?B?S3NBNlZDWEQzVCtHb09TVUFzb3ZLbkJBK3JXWWc3Z1kyd3B3OFVVR2xaTTJJ?=
 =?utf-8?B?c0RnRDBVMWV4Rnl1akJSaU5oN2trWHk3ckx5NmcrTlAyUUJLdlpyVlJqeVdB?=
 =?utf-8?B?SVBHUzZucCs0cnNwbXhoeUpOZmRmd2I2UGZpWWhwbVZWN29ac0VOWU1HYlJE?=
 =?utf-8?B?UDArSk03VE53MG5wSWJudjhyYXFrUS9UdHJXdkpiM3ZzTENsUEdPRjhueU52?=
 =?utf-8?B?dzJXamNSd3Z3cVVSVGQyc3hOcCt1SEJINUZQMU5CdXFQRTN3NHlmTnducFdK?=
 =?utf-8?B?WkhVZFZKREsxVGZCTlN4dk9FV080RmtFdzloL0U1QmpRbXZNeUxNM3d6M2Zo?=
 =?utf-8?B?clNXN0FwN1QyK0RzQ055elpyemE0YWx5WmJvK1lYZFVhaEZkZjdOcm5UbVR2?=
 =?utf-8?B?TVBGWnJXT1JmTWIrWklhU1lHN3QzTUFoOWZlLzl3aTBRVTU3V014QzBkMTk3?=
 =?utf-8?B?Tlp5NmFhMjErTlEzbzNsZTJsNmNhKzM2M2NYUDNqVWtLNTBxYlN5S0hET2I4?=
 =?utf-8?B?QmkvWkhGWjNnK3VFNW42b2lLUmVKeitzc3FHZ0lDZjdFQVdZclZBbDFwL2xH?=
 =?utf-8?B?TFNNRk5FbjByRktHeVBwYWpOMkZqR0VPb1hwcW91ZExSaDh6MHhXcGRkbU8y?=
 =?utf-8?B?eUVNOENHM2lZSHJHa3RSRDU3QUFlSzR3TGhVVzFsOTJnMnVLUENBZTFvZUVD?=
 =?utf-8?B?Qm4vcnNqM0VxeDNwN2JQTXBudG1QQ0toM29Pdnk4UnpXTEZ5OXg2cWlObTd4?=
 =?utf-8?B?UHM1RGE0OFFDM0NwUnllOHN4NTBYRmpZeGZmUTBhaGgrVlpwb2NSQnJxY1dh?=
 =?utf-8?B?Y3VXVVF1SElaUDl5S2lMaDYwK3E4NitjRDgrRVhVZE5YM0diNGhiQi9iOVdp?=
 =?utf-8?B?WlhZanBJQjBORWdyMWRidTcrOWFVQVhQdGEyOXlYQWRUYkMxNENZMGYxRXVu?=
 =?utf-8?B?dE1TV1lWdEl0UnBpV21lUEJ1cHh6dnJ5WXFvb05VR1djS0pDVUpML3djV0FF?=
 =?utf-8?B?VkdjZUNlbHFIbUFMeGRUczVsbVIxL1czYjVUODUvWitTUnlWYXZFZHU4Y0Fn?=
 =?utf-8?B?QnhLRkVKWWd0WXpGMUcrUUtJcnJoY1ZKM1lmampGYmUvc21nN2lTNmdrTG1S?=
 =?utf-8?B?MElLQmVuUWhnU1pOK1FEak1SSHdoeTZySXF0WHFRaXJSdDJyL3lDSXVOZUJI?=
 =?utf-8?B?ek9FK3Z4alNhWSttTVM2V1F0TGJzV0lyNUN4TWtZNlNwWWVuR0NRNGNpM1dw?=
 =?utf-8?B?dldKTkx5dFFzWUo5SzdxeUtPMjNKb2NQN1l6OUQ4Q3pYc1lnaTFYaGxNVmZn?=
 =?utf-8?B?NlVoMU9sQnpsZTEvUWY1cWg1d0oySTYvVnNOMkZxVzdLQzFqVlRibEJPWGpm?=
 =?utf-8?B?dlF6MmhkRHloNVExa2RNellSOU9UZjk1a2xuUlQzNDVkbHdGQld5TDJtQWRD?=
 =?utf-8?B?N0tQL3JxSlYvbkloamdyMlVSM28vaEwzQlpsbmd4RmNWR1NVeU5kczd2NXZw?=
 =?utf-8?B?N29BWDJZbzQrUXU2VmUrVmZnNnBod1Y2VzZlOTdPSjlGSGFsbitXSGs4VE9m?=
 =?utf-8?B?ck96L2YrYjk1b245S0o1ZlE1Tlk4ejl5Z1hLcE55VkhydVVZTnFkUlR6Y3ZB?=
 =?utf-8?B?SzIvMzZ5RUx4aVdObk96eThjbm42T1VqMzZxZENrK0xQUDZaMFBEaXdYTVc4?=
 =?utf-8?B?dHBJTS9XdE03d2F5d0R3Y296WXVpMmtaUjZrL3V6dFRneUg1NDVSME11Sm5R?=
 =?utf-8?B?T29ZeDl1QlIvTjlHT3BrRFRyWnA4R09yOWJOckEzQ25YQ1pjeWhGUEdHZzk5?=
 =?utf-8?Q?4LhodbOFzYoZxPbrig0Y7PVtFngdy8oHJaDTg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f8739b-ddea-4a1d-c054-08dedbd81898
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:30:30.6205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGnpyj0UKc3+M5ba5IYcg7ZxThZpKshkIoAbNq/au006exEQcqQW0nJ+xFrPj4OcvFumflSf21O0HguvlHjuH+Kxy6/plPaJj7dKDU3JQPDhGbH+K0B/0TIneGQPz3hz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8008
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

Extract steps 1.6-1.13 of PMA MMD initialization from
xpcs_phy_usxgmii_pma_config() into xpcs_phy_common_init_seq_1() to
improve code reusability.

No functional changes.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 179 +++++++++++++++++++++------------------
 1 file changed, 97 insertions(+), 82 deletions(-)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 4039690223d..006a2bd2238 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -261,6 +261,99 @@ int xpcs_phy_write_pma(struct udevice *dev, int reg, u16 val)
 	return xpcs_write(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg), val);
 }
 
+static int xpcs_phy_common_init_seq_1(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* 1.6 Turn off C37 auto-negotiation */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	/* 1.7 Assert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.8 Wait for more than 1us */
+	udelay(5);
+
+	/* 1.9 Deassert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.10 Power down MPLL */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	/* 1.11 Change RX0 power state to P2 */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	/* 1.12 Assert request of transmit and receive */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	/* 1.13 Poll for acknlowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
 int xpcs_phy_usxgmii_init_seq_2(struct udevice *dev)
 {
 	ulong begin;
@@ -436,93 +529,15 @@ timeout:
 
 int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
 {
+	int ret;
 	ulong begin;
 	u16 val;
 
 	xpcs_phy_reg_lock(dev);
 
-	/* 1.6 Turn off C37 auto-negotiation */
-	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
-	val &= ~MII_CTRL_AN_ENABLE;
-	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
-
-	/* 1.7 Assert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val |= PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val |= PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.8 Wait for more than 1us */
-	udelay(5);
-
-	/* 1.9 Deassert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.10 Power down MPLLA */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
-	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	/* 1.11 Change RX0 power state to P2 */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
-	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
-
-	/* TODO: check if it is needed */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	/* 1.12 Assert request of transmit and receive */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-	val |= PMA_TX_GENCTRL2_TX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-	val |= PMA_RX_GENCTRL2_RX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
-
-	/* 1.13 Poll for acknlowledge */
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
-
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		goto timeout;
 
 	/* 2 Config MPLL for 10G XGMII */
 	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);

-- 
2.34.1

