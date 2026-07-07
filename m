Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0236C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 03:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E76818494B;
	Tue,  7 Jul 2026 05:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DaThfh9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B6F6849A4; Tue,  7 Jul 2026 05:57:18 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E0A801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 05:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkaLy1/AU68TxMBzfz9PahNmZCp95p1oJKNpOnEgsz+O17Jmlnl4TRFW26r4HqLvLrcAhCfwYhLh0p4iaYzfjGyQh0sEBtiw/NdxPVzTnvM17rHplIm3bEeKLV/6paZljBKrusWDcqK4TqjJIwjpTZSszP4ZhSLfl01QYuzhr78OeW6sf9Al1yjS0qr8WyotYnVdEw1UriORImMid9v3dEET5Yb4j+TjCu+lwc35uFm3VCWu/CXbFR+RbZ2W+o0QPIdQI+iBH4emSGMiJXTatg9/LnNOoA/mAg1rt0J9pZ8I82hxbw9pacHmohQcZ29yPS9ZZ1jnZunqR11WvuOh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q781YHYwpW0qN+dSMOXpefzMXSfKoZoP0v4Jfb5X04g=;
 b=IqIH20VITQ0LI/ZCvf8HFUu13ZK6vst+v/S90au56QTFfoG5fHnMy06ZM5eg+DAN6O6Ho/DPPm9KPJz0ZA9FmMNFTLX3+CdhZcGI8Nwwkyy6FShdzKNbV1+yjpmZ+W7i1vkCIkEDtX7ZgazqjQDsNFf76tWezPqEYCqkXttjsHU4dFvkTIIh28m0JQX2WyQIhKUlsYBujf11ior3WbWptjdmbG0n6nhhqLBjpDBLkeGxZ3JEyuWzL82P7wCp+i8YzijnXrD2RdZ7kECvq226nvC5rvtDhCKsgVj+vKh/7WfsO6TzRaJhCZBtkQmnS7Egy/qk551ASSGFpTmTvp71TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q781YHYwpW0qN+dSMOXpefzMXSfKoZoP0v4Jfb5X04g=;
 b=DaThfh9p/bnmNcz/Cj5TmGyqgB42kr60K3xLTtZUfBEqpY2BpzZWbTfQgP5TViC/3YzL/EPKsCYLEC2Lw/4jizZO2SSF+pI2KQMIbbel6W7G12OVfTeT/rPtMqi7lC2WliKj6irfUV5Xr6gRhf6v4Ef9Iayn0eyAipMSpGWjkbl/PQo3xN5vMr7ktJeA5uPs4ZOIR+O8xtszgUWPvlUaQD0pgUlWtxKjgQI7yR0KjfHs2Ji/J5WV+i4L9e73wYGpk7MmWPK9MszA+bD8bXIJBtwjw+Zb0o8TJw/pFcarU/HcKkdfHnmvXjqskGhxjHAvXO7AiPxsl4o3lH3jjAZl3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by DU7PR04MB11235.eurprd04.prod.outlook.com (2603:10a6:10:5b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 03:57:14 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 03:57:14 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 07 Jul 2026 12:00:26 +0800
Subject: [PATCH v1 2/3] net: fsl_enetc_xpcs_phy: Add 1G SGMII speed mode
 for i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-imx952-v1-2-1262c7c6f7e9@nxp.com>
References: <20260707-imx952-v1-0-1262c7c6f7e9@nxp.com>
In-Reply-To: <20260707-imx952-v1-0-1262c7c6f7e9@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA1PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::22) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|DU7PR04MB11235:EE_
X-MS-Office365-Filtering-Correlation-Id: 8960fda8-4fbe-4b8f-1510-08dedbdbd44a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|23010399003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: jvt6L3foaMT6yvQHQah+pPuNaCttputd0bN5G7Ql2UhFIzVAhr39Cn5ZuLdeQE8zrl8/qxiKMSrZZA8/tY92+mcRnbTW4nfdZE5oNg/FabDurm9SRuuiJ3Cu1KzACdpLuoECoudMxOMaWBHd16m4qKbclSTBBPIWmxiIxDgXNmMqO6SN1P/vKN+7LgyFStZokp9YFOlbxbiCHMg0lBB5K0n6Wjbc8r9i1Sm996H0+hVVDVfV4XmW2OyLCoivrwd8Gmf9gNbTcv2FnL6tU71U7sRX6KDY9jkwyy7LiCTW+FA9B9zQ1fco6uI8TXOj4V0422+hhUaNhFkCb6k9BOvDAeRBivfWjGF/lC5JxfZ2sVL6UFg2NrCikS+KC99L/TWkY5bJ/dDA69fgvvcYWo4NnxZ0V/a/pcNVv6v5SJtIgzNPTbPq89xHHE6bUINlMsT6EpS1UURVSYvIAEIYMbMKArT8QsbVO8siryiRdolX21oPrmebGcB9NIaXjkWwguz1witWVSOQI2bgITc13X52u7ndDXoT9nDmsKV16d4GMazwPaPtRSxTLkhIw2iykEM4kimaqkrL8O/liWTEmL3ij5KRzm/UUEmVSO/pSAwOXDGzfJVYHY6xbyqJEYA4RsF9fm1v0CX+AgobCqQ/GqSFpSCq5qRhHHJ50c+kCH96VH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFVkdmFxUnZYSEtsM2ZuTlFPbGhtcGVMQUdkWjJmTjdLR1ZlaGFYZjhPS0ph?=
 =?utf-8?B?YWhDSnBMdGo4eEVWV2lmSDZLYWtpY1ZnR2RjaTlJTzVSZTNLVjNJK243cDlS?=
 =?utf-8?B?L0hFQkhvZW52YzdMcEJ2V2pUamY0RWhPM3ZzRnh3bFRKZjZjREliL0QxLzZu?=
 =?utf-8?B?bGVjejNSenVBSzZyUFJyVlY1SHlKaitXSEZjNUtSZEZQdW5Dem1ReDN6WDBF?=
 =?utf-8?B?MkIzNFNwYitndm96eFZRbHR2V29ES0E4WnlzNUxJbTVxYTZESnVtNE1EWmFJ?=
 =?utf-8?B?eDZyQnFZVVVzaXNNTWVma2hjVVFIZnY3UTNJQVNvcDRMMG5qelNFYkFHMHZr?=
 =?utf-8?B?bGY3WGhqNzVKSEFVUkw0YUFzMzFyVVJOUHdyUkk2WlBVRmVIUFRuTzB2OTZP?=
 =?utf-8?B?QURGbnpGWkE5L2hHUmJTa3gzNDFROHlCRFB2aTlabUg0WkFPTmthVVZ5QUpm?=
 =?utf-8?B?WG9LZ0haUTF3TVVRcjRWbGV5aVU4aWE4ZHZReTN6TzRoUUdBclM5cUZ3ZWU1?=
 =?utf-8?B?cHg1dDhRWW53VWVxazhKZWlLclVUdTl4aTRpZzEwRkZGSkUzdHE3VTE3Tkww?=
 =?utf-8?B?VjNSWXpreksycUgwMlgwWGNxU1pVT3NWbkhUOFBHUVhlV1F1QmpaZW9FaUZX?=
 =?utf-8?B?YWFhSUUrbU5nZFVra1JOaWVnb2txSUR3M3owbDdFbG9seEpPRy9KODhHcWha?=
 =?utf-8?B?TU5LUjUzZGZRd2lVeUpwY1RGc3F6U2J6eWN2R3dCTlVla1NzeVlBdHFqZVg4?=
 =?utf-8?B?MjRoWW1DWUZoRkR6QTlqRjFCUHpxdFBNdmp4TGVEVStOQ2NnRlREQlFBOU8z?=
 =?utf-8?B?S3Btb3hFNkVEcGVsVlA3Smt3S0twV1pmbHZiWmRaVXg0U1MxTE9xMndBaW1v?=
 =?utf-8?B?V1c3MGdYdVhXR3N6ZkhCZERVQ05FeVNRcExwNlJCb29QUnI3UHlwcnByVS9h?=
 =?utf-8?B?VXd3QmlyTHErKzIwcXhNSFBsM0FBYzdwSmR2YXdndWZyNzBZMngzVTdpWUpW?=
 =?utf-8?B?SlF6RWwvYWg4TFNENisyTitqYjMvUFZRTzZpbjBZMHkxUEd1L1E2ZTVpVk5C?=
 =?utf-8?B?TWpQZGlMY1kxcGNndUJDWkF5V2NSZlc2TFcrUncxdlBMTDA3OEJvazkwTXh1?=
 =?utf-8?B?UFo0NnJWK2FGK1p1Rlh2Zm5VTFp6bnAzdTg2VkJ1V1pzYm5qdk0vcEVQZEMw?=
 =?utf-8?B?UVFWSE9YZ2F6b2FSNm8zcm9sUGhmazh2RXUySnM0Z290ZzdYbTdhZ0NmQXZu?=
 =?utf-8?B?SHRZdy8wajZkMUp3UkJIZ2tyZ3FBZUppL1B0OGdFTEJzV3NUZWU2anM1Zzhu?=
 =?utf-8?B?SDU3b0JsRzE3amN6dWErN01SbERLT2pnSzkxT3lrTzl3TlNQTjJ5Rjc5elpL?=
 =?utf-8?B?UTJpZkt3aFhrcU5MZEFOODNjUzZOaGtwMmxSZjZEQzRjV3lSN2VSRElsMDFJ?=
 =?utf-8?B?ZTJxL2VGd0VtdWxHZnJjQTJjaWM5a3UrU09ZZnlSTEhwK1FvZDdxYTlXbzg0?=
 =?utf-8?B?dnEwWnE5a2J0WjRrRXBCOHlKNHl2QTRLZ1Iwd2dnblAvcVg3bzM2cTBVSE8z?=
 =?utf-8?B?UUVzUGlqOVBtK2h5czFpVE5Tcm04YXVieXpVUXgyQWFhYTY3T1gzZFB0WDlV?=
 =?utf-8?B?OEcrRlczbUIxLzdtTUJQMmFLV0MxNW5KR1lqMk9jVUFUZHB6ZktKOGhPN1Ja?=
 =?utf-8?B?QnNwQnYxZFVjbEo5K2YzZUxGaEVmVkNTcGxiNmdaeThLZ2ZqZXBJWmpxejVH?=
 =?utf-8?B?RXFONVJDVUtSUGFiekJwY3QyMFZxQWZ0clY1Q3g4d3B4bjRKa0lZcUo5T2p1?=
 =?utf-8?B?dkFnamVOYU9OSlljRkU5eFhYVDhVdEExZndDRlcxZTNGSEFFTTJvT09HUStT?=
 =?utf-8?B?QmpjTGdCZlZpRTIzb2xYUVB2WDJ4amp5REN0VGlOaC9oYXd3M3pwSlVwd1JX?=
 =?utf-8?B?WVF3dloyaW1hOGphcnVyMDNqNWVVNGtoaHdhMkxkMTV2Y0tJdHM5ZVpwQi8z?=
 =?utf-8?B?VklnUmRVRklNdXA5QlJDbjEzYndxYWxMcFRxUVhEcVBPbjJaUS9WZmZtQ01R?=
 =?utf-8?B?YlFmR3RCMlV5R2NYRGhiL3BRUzdBclNOTmJhNitZZHl4dG9QRmlNZGFqckk4?=
 =?utf-8?B?U29PTWxzbU5ybEZSY0g4cC9KRGNFdFpCd0k2R25zSURKSjNiTHFEQUtqV0Y5?=
 =?utf-8?B?UUV2OEQvV1RyUUZrbFllM2JEeTZCYkx3eHFJeUtsTTBhUUVYMXJBNHRRQ3pu?=
 =?utf-8?B?ZTVpUEFqUW5sWDROZzkxYVJaMzVpd3BFVnkvNkZTR3FQTzNGVUFwQXV6MklR?=
 =?utf-8?B?NTNJNi9LTFRrUEpRZDh4Z01KelBDZTBCVHArK1RnUnJicGdTcHlVbTMxUnNS?=
 =?utf-8?Q?Xd8cA6Kk9zFgWNMYahqEDeR19qXTYqVgWrAz8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8960fda8-4fbe-4b8f-1510-08dedbdbd44a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:57:14.1579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JhSmlKg9zqsYJNcFlIOJMat472Gbf57I0/+tYWO3TAFHmYvXDPXss5+FcrbnIbquZPgAtU5MVFsuIcj81r4fZcYMsnHUd+H9nn+ahV3dCMkxwnxUYnMAIOYZP00owZt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11235
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

Add support for initializing 1G SGMII speed mode for i.MX952.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 278 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 278 insertions(+)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index a8c720786a0..e832f320773 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -225,6 +225,35 @@
 #define L0_RX_VCO_OVRD_OUT_2					0x214
 #define L0_RX_VCO_OVRD_OUT_2_RX_ANA_CDR_FREQ_TUNE_CLK	BIT(0)
 
+/* i.MX952 PHY_CTRL_EX registers */
+#define GLOBAL_CTRL_EX_0_MPLLB_SEL			BIT(7)
+
+#define GLOBAL_CTRL_EX_4				0x124
+#define   GLOBAL_CTRL_EX_4_PHY_PCS_PWR_STABLE		BIT(8)
+#define   GLOBAL_CTRL_EX_4_PHY_PMA_PWR_STABLE		BIT(14)
+
+/* i.MX952 VR_MII_MP_12G_16G_MPLLA_CTRL2 */
+#define PMA_MPLLA_CTRL2_V2_MPLLA_DIV8_CLK_EN		BIT(8)
+#define PMA_MPLLA_CTRL2_V2_MPLLA_DIV10_CLK_EN		BIT(9)
+#define PMA_MPLLA_CTRL2_V2_MPLLA_TX_CLK_DIV_MASK	GENMASK(13, 11)
+#define PMA_MPLLA_CTRL2_V2_MPLLA_DIV16P5_CLK_EN	BIT(14)
+#define PMA_MPLLA_CTRL2_V2_MPLLA_WRD_DIV2_EN		BIT(15)
+
+/* i.MX952 VR_MII_MP_12G_AFE_DFE_EN_CTRL */
+#define PMA_MP_12G_AFE_DFE_EN_CTRL			0x100BA
+#define   PMA_AFE_DFE_EN_CTRL_AFE_EN_0			BIT(0)
+#define   PMA_AFE_DFE_EN_CTRL_DFE_EN_0			BIT(4)
+
+/* i.MX952 VR_MII_MP_12G_16G_25G_RX_CDR_CTRLL */
+#define PMA_RX_CDR_CTRL_VCO_LOW_FREQ_0			BIT(8)
+
+/* i.MX952 VR_MII_MP_12G_VCO_CAL_REF0 */
+#define PMA_VCO_CAL_REF0_V2_VCO_REF_LD_0_MASK		GENMASK(5, 0)
+#define PMA_VCO_CAL_REF0_V2_VCO_REF_LD_0(x)		((x) & GENMASK(5, 0))
+
+/* i.MX952 VR_MII_DIG_CTRL1 */
+#define MII_DIG_CTRL1_VR_RST				BIT(15)
+
 static int enetc_mdio_read(struct mii_dev *bus, int addr, int devad, int reg);
 static int enetc_mdio_write(struct mii_dev *bus, int addr, int devad, int reg, u16 val);
 
@@ -1479,6 +1508,255 @@ int imx95_xpcs_phy_sgmii_1g_config(struct udevice *dev)
 	return 0;
 }
 
+static int imx952_xpcs_phy_mpll_sel(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_4));
+	val |= GLOBAL_CTRL_EX_4_PHY_PCS_PWR_STABLE;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_4), val);
+
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_4));
+	val |= GLOBAL_CTRL_EX_4_PHY_PMA_PWR_STABLE;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_4), val);
+
+	/* MPLLA - SGMII 1G; MPLLB - SGMII 2.5G */
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0));
+	val &= ~GLOBAL_CTRL_EX_0_MPLLB_SEL;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0), val);
+
+	mdelay(1);
+
+	/* Poll for SRAM initialization done */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_SRAM));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_SRAM_INIT_DN));
+
+	mdelay(1);
+
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0));
+	val |= GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0), val);
+
+	/*
+	 * This bit is self-cleared when PSEQ_STATE in VR_XS_PCS_DIG_STS is equal
+	 * to 3'b100, that is, Tx/Rx clocks are stable and in Power_Good state.
+	 */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PCS_CTRL1));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PCS_CTRL1_RESET);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val = u16_replace_bits(val, 0x2, PMA_MPLLA_CTRL2_V2_MPLLA_TX_CLK_DIV_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+static int imx952_xpcs_phy_mplla_configuration_sgmii(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* Disable 2.5G SGMII mode */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1));
+	val &= ~MII_DIG_CTRL1_EN_2_5G_MODE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_SS13;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val |= MII_CTRL_SS6;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	/* Program various registers for 1G SGMII mode */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_MPLL_CMN_CTRL));
+	val &= ~PMA_MPLL_CMN_CTRL_MPLLB_SEL_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_MPLL_CMN_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL));
+	val = u16_replace_bits(val, 2, PMA_REF_CLK_CTRL_REF_RANGE_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL));
+	val |= PMA_REF_CLK_CTRL_REF_CLK_DIV2;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL));
+	val |= PMA_REF_CLK_CTRL_REF_MPLLA_DIV2;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL0));
+	val = u16_replace_bits(val, 0x50, PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_MPLLA_CTRL1));
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_FRACN_CTRL_MASK;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_MPLLA_CTRL1), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val &= ~PMA_MPLLA_CTRL2_V2_MPLLA_DIV16P5_CLK_EN;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val = u16_replace_bits(val, 0x2, PMA_MPLLA_CTRL2_V2_MPLLA_TX_CLK_DIV_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val |= PMA_MPLLA_CTRL2_V2_MPLLA_DIV10_CLK_EN;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val &= ~PMA_MPLLA_CTRL2_V2_MPLLA_DIV8_CLK_EN;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val &= ~PMA_MPLLA_CTRL2_V2_MPLLA_WRD_DIV2_EN;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_MPLLA_CTRL3));
+	val = u16_replace_bits(val, 0x3f, PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_MPLLA_CTRL3), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_VCO_CAL_LD0));
+	val = u16_replace_bits(val, 0x550, PMA_VCO_CAL_LD0_VCO_LD_VAL_0_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_VCO_CAL_LD0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_25G_VCO_CAL_REF0));
+	val = u16_replace_bits(val, 0x11, PMA_VCO_CAL_REF0_V2_VCO_REF_LD_0_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_25G_VCO_CAL_REF0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_GENCTRL1));
+	val &= ~PMA_RX_GENCTRL1_RX_DIV16P5_CLK_EN_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_GENCTRL1), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_RATE_CTRL));
+	val = u16_replace_bits(val, 0x1, PMA_TX_RATE_CTRL_TX0_RATE_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_RATE_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_RATE_CTRL));
+	val = u16_replace_bits(val, 0x3, PMA_RX_RATE_CTRL_RX0_RATE_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_RATE_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_TX_GENCTRL2));
+	val = u16_replace_bits(val, 0x1, PMA_TX_GENCTRL2_TX0_WIDTH_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_TX_GENCTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_RX_GENCTRL2));
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL2_RX0_WIDTH_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_RX_GENCTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_AFE_DFE_EN_CTRL));
+	val &= ~PMA_AFE_DFE_EN_CTRL_AFE_EN_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_AFE_DFE_EN_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_AFE_DFE_EN_CTRL));
+	val &= ~PMA_AFE_DFE_EN_CTRL_DFE_EN_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_AFE_DFE_EN_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_25G_RX_EQ_CTRL0));
+	val = u16_replace_bits(val, 0x7, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_25G_RX_EQ_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_DFE_TAP_CTRL0));
+	val = u16_replace_bits(val, 0x0, PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_DFE_TAP_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_CDR_CTRL));
+	val &= ~PMA_RX_CDR_CTRL_VCO_LOW_FREQ_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_CDR_CTRL), val);
+
+	/* Initiate the soft reset */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1));
+	val |= MII_DIG_CTRL1_VR_RST;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1), val);
+
+	/* Poll for SRAM initialization done */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_SRAM));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_SRAM_INIT_DN));
+
+	mdelay(1);
+
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0));
+	val |= GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0), val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & MII_DIG_CTRL1_VR_RST);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL0));
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL0));
+	val = u16_replace_bits(val, 20, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL1));
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL1), val);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+int imx952_xpcs_phy_sgmii_config(struct udevice *dev)
+{
+	int ret;
+
+	ret = imx952_xpcs_phy_mpll_sel(dev);
+	if (ret)
+		return ret;
+
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		return ret;
+
+	ret = imx952_xpcs_phy_mplla_configuration_sgmii(dev);
+	if (ret)
+		return ret;
+
+	ret = xpcs_phy_common_init_seq_2(dev, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 u32 xpcs_phy_get_id(struct udevice *dev)
 {
 	int ret;

-- 
2.34.1

