Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239A5CFB421
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 23:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9045E88815;
	Sun,  6 Oct 2024 01:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q4+iz0xO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47BAD88770; Sun,  6 Oct 2024 01:32:52 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DD088815
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 01:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHnXcPJWIoA2PdyNhPiOHk1bOe6Rv1QeLTXnIkOz2Q2NJjx86w7eXt0h8Xr1LNcVABY/6D5i+mpqoVHnH5cZxNNIzRniDlgoaPsT62HH2/4ZooJH1dzI5gcWinr0DZZsas+ulmhgYR5USBwApZTT4LC1cVF1xbbyHLhGIzIhKg/KKS6zVsZeJpApMSPbUYkmleuTZCSbFkHVBTiaY7vV1GksZafrZqaYCYKNMA95Gl/dxgs5k0TOObo7Dmg9XtF2JXGIVXhIZhCZG6Yg0t8KLblDh988lofCmzTuzorBJtBtLHfVItLOZ3HkeXwHjVhkjO38EfRklc7llJm3IK7xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sUPQ/4Nyg504zkfzHrL1Ld/EjIv/h31AlvtFpNw9H0=;
 b=GViJTtgMqGXxnop4BXZV7lZ0V/2tsYhUF+Y3YJNOa8rV/4F3twcCJXchnPqCtTMSIpJRYxj3lAB2/GvPUQRY6hAFpRYOmdzhbPJpTVaDSlMmB8G1MNGTRKDNMQzmejAs8KYg54O6ha5tD93uixvaSPAqV1yOClS+cSorP7P/MWrrI8Ilf5Wdn67hJmc1k9ekRIq2hE9HDX9nwGk+KFOj2th7tYNR0hfpLB2jti0F0hskNYtfy+Ojc61EJm7f9ymtjzWXM8berNnoN5m6PNhf4FRtrp/qU8+byLl9odSYkouKROFSZfatSFwVkNp68MtEYHx1v9VgjlUT8gNPStTuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sUPQ/4Nyg504zkfzHrL1Ld/EjIv/h31AlvtFpNw9H0=;
 b=q4+iz0xOW2M4ZlfmHU0iv0clbcDWaJorgnD5zImBzPct9QR0QDJcBONrr3fIWxMaieb1b8wN6Ghotj0fDsMreGH2vyClnwpGE2tda/a5QLYx3zyl+oYa9tIuEFFhujCt+ip8v02CFdnWeH0QLfGFKSVhUAsCoc+QdcptVPK30F30FgvAjfpPgkHzMm/pz/WaToCD82yGJFhsaQvfYBxLetV4ZAvI/fdurrGEvuUaEt0X0kirHn4P78uw9KVHT9kixOfKEQrotR0kKZLF9OEHXsJgbTwJ2wiVqCS/nAn0PcW+2hchRSKTyXTUMmvlH/V1oQq4pEnb/xttdrUck4FLmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7584.eurprd04.prod.outlook.com (2603:10a6:102:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 23:32:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 23:32:47 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, peng.fan@nxp.com, fedor.ross@ifm.com,
 ye.li@nxp.com, seanga2@gmail.com, Alice Guo <alice.guo@nxp.com>
Subject: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Date: Sun,  6 Oct 2024 07:31:16 +0800
Message-Id: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 9196e1ce-571b-47b1-dcd9-08dce596052d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0zXInMY1B6J8z8veT7g66Cq1DdRmfSyWVaeRaasCahoVd6uIkKqzZjlpIDLC?=
 =?us-ascii?Q?dG9tL2ON7JpOyWmLwJDFsrHxFd9Jy9HzbnQNlIczwoPu4ozduceJWaTraJSp?=
 =?us-ascii?Q?tAOsubefos1UgX9JT/slkIbubfojZnIWNyp8VyKQq3G77odYsrGho0Y2XVGE?=
 =?us-ascii?Q?ayoBUMB9xDy70n0VOQPratFnUwdLNWAb8w143PnJGrlIjItTweFw1bnrrTB0?=
 =?us-ascii?Q?qS/1Oyb87mXXCLaZLjiCrgAEdUNa+HS9vYqkI4fpiKoL8MadnHftf0+SFqRI?=
 =?us-ascii?Q?zcXofwtvab/nkgZijtGVk2TYGVh11ZDuy9iKYbW3z0yOCKLffrniXxW1ki0p?=
 =?us-ascii?Q?An2zueN9xOcM8QTFec3T1BFlOyz0SViMJf9MjBQoK3sNutE/TbdDguOgVu/P?=
 =?us-ascii?Q?Isb7YbBvobWUFRcoqow16MbdqFEPLY6kQ7YYi/gI1wqCBjvRlNaT9dwbJXN/?=
 =?us-ascii?Q?W2Z5Bi5WIdQFz8JPPIKNDj9kuCbIGEdDyV3EwZkae2aNqwIcrMXCH/AVBG96?=
 =?us-ascii?Q?HIh3sIfSCMrm3RhGB9ckV5mtVm+rLdN555SrHCmkpzmf0Hd1sNGfszds+D6o?=
 =?us-ascii?Q?GCM7gdwvl0txAV5rvqtZ0WnRN8aNAY0fNLAxup2Rg2ZeJ3Mft2t8oIIKHLSZ?=
 =?us-ascii?Q?Ti/GAIjjdI9Sx9jvn/EWYPpEXGn/Go3zsBbiDulAPlG7Y2UAFFPoeYif6MUP?=
 =?us-ascii?Q?ZPzy3jvp8NBkidTHP/fwVJ6eeNMZykF+lP4CXlMG9kOJKkxgX0k1Wv7Jlbxo?=
 =?us-ascii?Q?plBV0BT74gVHDa3yvlTeCtECRpwzPQAIb8ygdIdKkDx9Hk35CVNwHv/53pv7?=
 =?us-ascii?Q?fWPkvDl6/C5XVnXjkO5HGLKzhVFNAz/gbJ8BsZ1qwIpZ2pjJgal3aqMDil/k?=
 =?us-ascii?Q?cyxL5uZ/3DXWVhxjJbkh97BvErIrFjtsDZKyPVweXLiER2i1HwEPyolDI+49?=
 =?us-ascii?Q?fPWsTChysWPY2S958sqXjU04HPyrfMeOXB/NqkS1TEu+NnSrg4JNKveKnw+5?=
 =?us-ascii?Q?DQPBbATr/ndkjAwHTNceKoxY/ZIwXmnDFgBgeYU/HNE0o8sm6UOVY9m3HHlR?=
 =?us-ascii?Q?bkeEIIzJmMF1GYVNo0o17VUraECtFICx047as+8Aqy8HOrEg4Z2ezQi1n2TB?=
 =?us-ascii?Q?Hvy2tuQNUc0FIJyEiafD49o+JMcVb5XkZDhFlfn7pc4At6DSSdy1Zb/X1wMt?=
 =?us-ascii?Q?6CA2YdP+EmQxWEU/CVchte2BiEFXyVkRl7+vNIZ+b9nbHrid+z8fu25zj3QD?=
 =?us-ascii?Q?mLUUp079PG5ld5O/MbuSmNDS1S6b4wy5hNWXSeL8smTGqEYJw17MKNdbysqr?=
 =?us-ascii?Q?22MukvjudxCjFHaJn8pSRGkzKiLtxO1o+qNTRPUtcgfT7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZOgLNf+B+zGXlqRs1XsiuUPEaC8um+XGOFNDmtwyzhaUHyUQny2d7tZk0xad?=
 =?us-ascii?Q?hTjmDuvzOyYm9HMM8n1tAVCJoOeCDlKcezkXoKmuLjWPavMeh1Aba5KpBF4k?=
 =?us-ascii?Q?I8ohYxmryAw8U53H27RKonko9Yx+mGcobti/AK4ulWJVmDS6KZjRzuwIyJ1x?=
 =?us-ascii?Q?VUq7u3bC/kOZ/TsRoiACx/iIPSamhs6YZikh+4eRAfWxA0TAewQ3+7n+uLgm?=
 =?us-ascii?Q?1tPPAHzGdmed1Qf2stZcSWXwzZgXsYpBXv0wPJNlzQO0vIrYPG7br04Pjel9?=
 =?us-ascii?Q?pUX0etrKeJ+3rC3mrKqgve4yUPHQPOURS4J0kEldcr0xN8RmhrK3QQNoyVv/?=
 =?us-ascii?Q?PbSaTYoKvtrch5gsTrtwOsLPSEErKxUxBnRx5VEUCoUXwCcHjl9R/a0FqDlM?=
 =?us-ascii?Q?AT0EEWxpJpOI9U6mjG7d+lwgw1+fMtbJiv6I4ZFz/XI6TFhdzZmjK3YZxgAu?=
 =?us-ascii?Q?2n5aB0b3KpyHZefB4p3nj2A8GfF6cOnsWXmsK3KMG2QI20ShGYF3p16rDvqf?=
 =?us-ascii?Q?bUAPNlrrdLM5ea49AtoDtlKB2aiUNcjqa4DLOTcl98Ly+UUVh4mLWFaz9BVS?=
 =?us-ascii?Q?EhsZoy5LboKUMPxA0PYV8kSm9BsIaLSB8YktgLw9qXD2R4zY3tg9ddBC03We?=
 =?us-ascii?Q?f+qpiRVZ0MD7dFcGmo0PgPIYkgtcMiuuZuyKKkC7GWIeQBqza9gM2Xutr90H?=
 =?us-ascii?Q?9BugV24KU9ayd6p6pDKGBEETiSc3da5O/ygRiOzoMJopMjhlEhRXNbJnoNpd?=
 =?us-ascii?Q?ZTzmspMiKn13WUfoqa9yHMkGfpNi1AHchSSdaG5xixmn58o6IgmAy5A4wsUi?=
 =?us-ascii?Q?Jo30w7agP+4T/f12SXnrUtVkTQ7p90FirabKKybLaIJlDay+GBWesvX/PzrF?=
 =?us-ascii?Q?/Y9eJWnej+rYkViEDcELVR0p+wTOh6YUaYFI65AxinBWRTjIcYRjRQ0mO9rR?=
 =?us-ascii?Q?LhN6c0G4qzxGXst/N94/HOmN8za6QyxbdHgeBryjeFf2TEf+41bQ1GTcr2zE?=
 =?us-ascii?Q?5w7X82SLYZz+CqUyCk7Y1xgC4xOpSiprjabKWlp0UMBRz59ieDTpmq429B0j?=
 =?us-ascii?Q?JBBN++NhSgOnm76kWOsMBfFpUO+rAruzfOpgNUmqdUXv1r1kyFp2vTKaRwgZ?=
 =?us-ascii?Q?gPZfjSrWRbgYIx5OZ6qaOukTrtqDamka0J2etnFf8Gj/03V6Vt+ewnD1wgOD?=
 =?us-ascii?Q?XiD/39GFgtmENKwb/Urtv6KyOGmJyupae6lTjz6aXN6NHpBGqGDf71HomSrT?=
 =?us-ascii?Q?p8fCxKIKdeooL9kfrQNAFSm7GSrMVRiByONaFrEC6BJjQrn3Jq2/UdlFSaMJ?=
 =?us-ascii?Q?6HVLtpisOVBaVIaMRg31EgizndcbfqG1N/jK+xNjJvXjuwJ8LCcSph+Zy72n?=
 =?us-ascii?Q?4LEFjOK102Lywy61ixkW8WRUZAMol699Ri1izb/a2ctynTW9QTtUYIsK0aST?=
 =?us-ascii?Q?b0RF8v+InNpT4+QpfTxy/xqRw6W6BTVvOmgcNIszxJGzl3GEMN0dPFPPB7tn?=
 =?us-ascii?Q?lNentHbMqYmPF46cbuXmqYyPn4rWM/JxbyNuGlw2HH8I7xBG/vP+gQb7px8b?=
 =?us-ascii?Q?HKiQRgV2W7+Ry3p3zHiQb1tfwHX8Bh93yDnLnWC0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9196e1ce-571b-47b1-dcd9-08dce596052d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 23:32:47.8433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0h/hncZQij1esSJWlwOjqeWfcZpQflqe6ocaZ0DKslJ7jYqvUOX5+ptKaL4w4/UiAgIcpLH9lDVvk68jZD+HQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7584
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

Make CONFIG_IMX8_ROMAPI could be configured in defconfig.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c..9d3aafd2f8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -179,7 +179,8 @@ config DDRMC_VF610_CALIBRATION
 	  the ddrmc_cr_setting on relevant board file.
 
 config IMX8_ROMAPI
-	def_bool y
+	bool "Enable i.MX ROMAPI"
+	default y
 	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
 
 config SPL_IMX_ROMAPI_LOADADDR
-- 
2.34.1

