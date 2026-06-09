Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D52CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9768484F;
	Tue,  9 Jun 2026 09:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c4BUNa+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE1B848BC; Tue,  9 Jun 2026 09:19:37 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9E58484C
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/dmX+itMqfj9EhaQWPPT5Vv/lgrA1DRSqPVBZ63tYHe1XooVjmN4QmEgbf7fLpQFpcCDaYFo/QC4aabymrEim9327U+NW7/cA27oLD0pZlgx8iwnnqSXh1swC10wvHwanjDetef0/9Qw7ih+EWHzFEKuq1J81mZxZhjwkOiytF0U0cn4iMuhcDV8JG1s6qEjHB8h4mUA2PX1VNSJa5ESrMLYz5FUGqzZ3XRCR46j4ZhUxAQoKTOKwq9eZvqcUitAsbhLZ+ghkPY3MtvPTuTRg++Rx1y5vpu11bmpmYHhf04cIaG7XT03HDWrfjmHleEnQXvSooHVrvdSOWBemFQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ofQDjIo01Qx7wJtaxiXkYfRooaGmywZPag0NXHA5zA=;
 b=ogHeBiONenTCK9JlIl8lQxY/Y+DmEXLPmgSrW51DoeaZCZ83hg2gS2SBWtJnYhcM+sYVTgABFN5C34qR5x53hCTd1sXL6tTZkruN8ZK0x3L6i/2O8JF2a5tX/bX6ZUMFvQBAkQ3XVyZV8g0UHHpD8FJ696YsIu6rL6ALk/MTzNEftGXntGooBA6R9HoCt8w3EVoNanxjuudhmMFCnfbEXfR6/SQTZ5OT+756PvJA02O5qweekVN8nX5YTvvThHcQzKzAFOFWLOBlvDwetDpcP2QNLHpIF60P+mmUXLcI7Ngp9csctf4UM5H08fHmzZ3dv8xsJpj+pwRmeI5/29z7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ofQDjIo01Qx7wJtaxiXkYfRooaGmywZPag0NXHA5zA=;
 b=c4BUNa+j7/mhYoRRad6X0D0+7LFAYidwZB1sYYE6ntG+DvsT5ffbwFwhlH5wa0LEDe/Cc/Tl5ucPUDJno0cOHfaeE2uSxXwo2kYlFkssPX0L5AZakDb06vKQX7eNNhlm7PNJbYTLzmblns07k8gtKV7oJYLNO86MvkASMfZw+S0UCcbl1bnX/b8aK4UiZ5DS3iaOFDS7E3rKp9PJyPCw83WIDG9CC0Gk6/tGzqBjZgvGWup0dYOkbiSE5eg+MBBCURKbPgbZyKtlT+Bodi1BKFoE4/SIY5hDGwMKoOR/F4mH2tQqUahjAwGLsR1srnV85x+gEaRJ5WyxB2TOqUaGUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 9 Jun
 2026 07:19:33 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:27 +0800
Subject: [PATCH v2 10/13] misc: ele: Use dev_read_addr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-10-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc5f9eb-8c9c-45b1-3171-08dec5f7747d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|366016|376014|1800799024|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: PN27FrDtiCU1uQfNjsCKUNrFWV50bDETnQb166pU6yW846NaMaYPTiQLXmQ/o3hYeZ+rpLHOdMKrgP+zJELfMTnw2H85BORQaHbcqpA8B7+yDXy0aot6UVUBTS2iIbI/PFmYKfGMD5HVaR4VdYfW1eiqvzk9e2oQXZVXm1X8fh3HZBScMMoAGZQq2jSTD8sDXxgWLAd8TtHodvql6SNuGL6a/KAmzMEiFj9/XOXK5dOztb46BbLelvvT+aqZYFEjVp6gSVlrFT2qvhImp8NTe79ohfI8Y8VrG/DFWC2mcoA63BcuGxwwhzkuTTCPAeF9YURk1kZM8/KmOfxhRWLNnPvUNkDYz8nSmhvaolrhgpH1+pmkLNZYPaNgu80h/P8UM2sCe3JxsfnMXuOaKZbfo9X6OGPhEJ56MG/lD7jVr0T37QVTmq7cEnFL+fLeRoPrZQJ9iv3bhSfEfaxilBPxHQjSOi+eQtS6be7yGYTFG1B5Jva5Pp/+SBAwj+Cf4OwrA3bHm5emyuRABdOVwZCjiDUFeyP2bgxPmAKPrZuU9q8/SuABocf9Zn5vY1GtnAma2QJV3XOaaFHJABybuKjwocs9qlp4hlDLGy+4iy/ZU1hpw5OLiZlP5RDjSd9PZ977l0fgCgMfjOr/iPjjSKDIBp5ny9PgAoBT02TzIXuy/e0inWM/u1mwPn6UvaSln1qmXHypILKxyTxMv1Q4FuRO4b6eLpNmxtapVVkDYVI/xL0B01t/E7EpCl6EwdMmd0M9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(366016)(376014)(1800799024)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdnNHVLU0RESDA3WE5qc3BnZUN1NE9SSmp1ZE5EZEpjUmV1VVArMmtkNi9B?=
 =?utf-8?B?YVErazhDeSszK0p3UmNYRGlMaUFRcUFGS05sdUZWaXJkMnBaTFNnN0M2ZElR?=
 =?utf-8?B?OWcwQWlHL3NXWHo4djU5eXdMUlo4QTVMSmRCSkp2Skd2U3dDWTluU1FGdWZY?=
 =?utf-8?B?NGF1VERhRHNlbThwZ2xSMFN1LzBDMlRYZGI0ZTVQOGxudkpEU1ZQZ09UTnBW?=
 =?utf-8?B?TTFGT2lkOVI3VUJzWjkzcktQVlNJeVl1ZkxxZkpFRnNOM3BvQm91NXRtSlF6?=
 =?utf-8?B?dW92TmdOVlArbm1Ja2hYNndnNHZYN2F2V1RMQ3F0czU1OFdteksrTStkcFZs?=
 =?utf-8?B?QzdFaytCSFJpcXVnQWk3S2oyVndTaXpReXFZeGEyRmtGTlBMNDlKRjYrU3cz?=
 =?utf-8?B?VUVUSG5FQ0VXaUYxQ3dyY0Y0b211VkxZT3VRV3JjRGtITkg2WkRsSXdDcjJy?=
 =?utf-8?B?K2plcTBYc3ZUMTc1bFB2WkRrcFVhRmhrZm9YUktQQlRDcVJJQUI5MWJKWnpL?=
 =?utf-8?B?dm45bmJ5YzY2amRoM0tFMk9Vb21WMVpxbXlHYlJZbEpES1dJNG1oYVBydjFU?=
 =?utf-8?B?dTdWL0dCd1JjSkdyZ1hLSGV5SlFJUS9TcmpNakpJcEdqQzVXcit5K3BvTkVn?=
 =?utf-8?B?RGxPbVVhZVkvR25MclpMVkZYRjZPRncwM2s2Mm5JMEV6VUowOUxSNC9FR0FY?=
 =?utf-8?B?MUhqMnpKVm5KRXA3a0lqN0ZwQXBGVmhTdlZOb1JGa3kwL3dsdjRZa1YyWWtR?=
 =?utf-8?B?SkcxWmJUa2JnTHI3M21CQzM5VmFycVJXcFdYQ25ORmZWZ3A3dnhnd1ZDQVg0?=
 =?utf-8?B?aDJZaG9YaTN4dXhxTlFJMmhUcWRkR0Q1N2FlQ09meVRiNTZJV0dyNlRjWm1o?=
 =?utf-8?B?YzZnNE9kWjErMXNtQThocGN3VWxLT2p4THN6WU5Eei9xQzlVRURVTmxKN1gy?=
 =?utf-8?B?K3dUQVk2TU5IYThoR3U3c1RIeWhOT0lDdlFySVRlbXFMRmFheCs1Q0ZVeURP?=
 =?utf-8?B?eGk4TFdZZkpaTHFJaW92UElmenJmb05iQzBjM2lDckhnUlRkbzAxMEpRTTR4?=
 =?utf-8?B?QTVVcFlENk1PNElxdy9vaGIzalV5S1ljZHFCV24zM0FrSExLSmZEZlBCd054?=
 =?utf-8?B?M2hQOExETlo1My9RZHVjRW9aTU84V3lyR3JmTVdvN2VIQjR0RnBETGpHWVJn?=
 =?utf-8?B?Q3ZvNHRZTTFrQVFobXg5dUNxR2NxcE0xQ2ZIR2RqWHN2WnRDbVJ0dmZBWWt6?=
 =?utf-8?B?RVZWbG5MSnlLSDQ1TUhST3ZSS1AzRGExNlVTTFBKUUk3NEgvSm9QdDBhS1M5?=
 =?utf-8?B?WkJjM1hxVG1IczRyajZGdDdjZlJoblNiclBFcGlvRWNpak56blVSVlJaQmhH?=
 =?utf-8?B?b1NaaFZnQm52SDBQMDJrV1pKSDE5NENSSzBRbi9KcEVxQnNYam1qMnMzVEI0?=
 =?utf-8?B?bmUrSUxnRDlUNmRUWi9oZFA2dm9YelpmYjJvZlhqc0xVNHFIMVRGWC9HSG8y?=
 =?utf-8?B?MVpuMmFQMUlWSjIvRUwxS01pdm9tMWJPUXoza1MrbmsyQUxCcDJzN0YvcG1C?=
 =?utf-8?B?UUQ3aFR5ZENrSWx4UVdDYjVzWjBjSkZTMllIZHBEVXB0Y2wwRDVIZ2dweDhM?=
 =?utf-8?B?aytFb2FMVEpzc1VIcjdiRnVZaW5IY2pOQWFTdm9Hd0xNUktuaWViYWlhSkxz?=
 =?utf-8?B?VEpvc29JRmJzQktsNjZ1VWNLNnB1Ykx6MWQvYVRKTzlaZm5tR0VlaG1BVnlD?=
 =?utf-8?B?QlE5Z3VFbTVQbWs1WHQwdlZPU1JiMjZqaEl4MEhUZ2FmYzh0MDVQMkUrdUlw?=
 =?utf-8?B?OTJIZjQ4aDlVdVR1enA1MndZN1c1WXk3V2hCelQyN3dyMlZEN1hhRzlvTTk4?=
 =?utf-8?B?SWFPVGpKYWFhUkhWMlhxNXdyMmJ1MERzeitQdVBmdkd6Y2pXbWFWY1NsdU0r?=
 =?utf-8?B?S0RSUWtwaUQ3ekdHUExTd3Qvb21QY3JmUzJBS2tUbC9udldZdTZ5cHNNY2U1?=
 =?utf-8?B?WlRHaHVhbkVWaVNaY3BHZExrOXZ0MXZNVEdDZjROVGlYRHNVY2RQTnIrTlh0?=
 =?utf-8?B?bW1JblNLdHNhcW9Fdk9LdnVrdEVoSG4xam81ekxaLzVzS0hLYjhDdzk1THgr?=
 =?utf-8?B?dnpwMFNVUjJqTG1DSlM0RUs2RU9ZMFNmeWVrbUtzZXVzUDJEN3JiWGVVVE0w?=
 =?utf-8?B?YVY5MnFzUGhEUEtDcW5QUi90cmNya2IzOWNKN0dLdXorbTQzaE1ZOXRoRVhs?=
 =?utf-8?B?ZUlndFkyZmdWM0toMFlIWWVKcGg5ckJyY3JvbU4yNHlOQzI3L2pFL3pYTm9R?=
 =?utf-8?B?Nk4vcldNMGcrQzdVd1JROUhSNUdIQ21ZZnF2dklwS3dMM2lOTXMvZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc5f9eb-8c9c-45b1-3171-08dec5f7747d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:33.5863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQv0RgRcRaOnDHAXVyUZfZm0NH2DPkDFtELCz/q38u1XqrPmtCM234ZdLL1WctWB2dst6pB0WYPK/vKsmLrJAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755
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

Use dev_read_addr which supports livetree API, otherwise driver
will fail to get addr when OF_LIVE is enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/misc/imx_ele/ele_mu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/imx_ele/ele_mu.c b/drivers/misc/imx_ele/ele_mu.c
index cdb85b999db..65a4779c041 100644
--- a/drivers/misc/imx_ele/ele_mu.c
+++ b/drivers/misc/imx_ele/ele_mu.c
@@ -209,7 +209,7 @@ static int imx8ulp_mu_probe(struct udevice *dev)
 
 	debug("%s(dev=%p) (priv=%p)\n", __func__, dev, priv);
 
-	addr = devfdt_get_addr(dev);
+	addr = dev_read_addr(dev);
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 

-- 
2.51.0

