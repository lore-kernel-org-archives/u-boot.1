Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0791AE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE8780196;
	Fri,  3 Jan 2025 07:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RYQHiMFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E420F80196; Fri,  3 Jan 2025 07:46:04 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5710804CB
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRNUZfgjmebTJr35WjbXNCzE+VZ/gWdrqRfjYobIGM5Nlqd3uLzjZqArElpl8MlUJlRZoXn6l1hq/ejgAWMXGev2nhLeA3tWEEAtadt4Jv+qBj1D2R+OHjhkFt2cEsHVH7SRzx1W2YfP5KgbPDe1h+jK/w90VgA4nlj4AHogJDrRDCZ/Z9Q9OO1RslB2DLpxdacmfZ2TVullzbxsU+3sMlCVKf7CLBbkYnmGhxaVSAGgBbBdBDCdGEfqlgu2+e7N5txRrrHivVTgLrsUjRTZDQPkdPNF4ILcJNghIStiPjIVmIODUGoazkjNqVI+S0JFzJzctLLWsnfHiONrVEFdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqbOh3e+DZ9lJ9katl8007z9+w/bilMQFO5QqOWb76g=;
 b=NzHKDVxEfFSCimUsFb7Nql9Jkfao/oKk1YFO1k6Q9qDmkm25aen3r9w1n0JmEWssoPf4FPETHO+xaupv1KAZ47gk4zjxMBM4KTUtnVCpQtvSYEPEqBbUWR8MIYlfIn2ew2W9ASD63i0Gn29rQ2NwsJDb1YFwGAEbJqEWwEW+0P3atlECJV2jEOB6iykjlHgCa3BcIPM+nyANwvLyJ0R1CqNiizvT2a3nvYuwjYH1b6Nh9m/78Whub3KiKKrT/++Eyi7YxKdJEduXul3IUNgXQvgcUxDp+Oub0puGAJqQdB7RG2JLwgQkfH8kHm9NCNC+bC3/KecspYnoqC2K1LHBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqbOh3e+DZ9lJ9katl8007z9+w/bilMQFO5QqOWb76g=;
 b=RYQHiMFRArQEgDZIajTcbvHr5TWHCH7U0OcwcWHBQSfQ8Yx+DEhJpjUlbf2A9FpO/jOrlO2bf0N6gJjz525O3TMDTP44CIUEim19XspQQJfuOKEV6IKgMjABwrAYQsUX8IDnkARruClg+z/lRD200fJvwZ4GkErnPFtzubZRFjnxRsk+u6YmOcRvv21dMvMaE/FuuSCk558lTPaUnC4Bgg4YmpL9lF0onyKXoz9xvBanB8qDvxtYEvX88ZwiSF64T8wEmmzinC0eN0C5p6XrgxFGNYYWEZaxnMKuP0vV6UwR6XnYj288JHWJ7AJ+NNrcS3FDszrpfjwz0pBe7xHGmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:45:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:45:56 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:37 +0800
Subject: [PATCH v3 02/17] firmware: scmi: smt: Interrupt communication enable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=1953;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=AsqXw33M59VZNR1ELTRjnl0N6o5X/Dg4olHYCTHhcX0=;
 b=KUs36akPU/EStLWrrX/0nFPFjvfrODnyz5L6LFWkEyqZowpU7TFkTZdKR8oMZRulClHWoY7Gc
 1Q7wQN14nnlCwQ45nOmjVGmvaoPyidNkqN2Z76CvipuF/k5lTz0fFxz
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f1c139-b6b9-4616-c5d4-08dd2bc2466b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFdwc2xRamU0VlAyRU54ZmxNbUhqSjlvTkZYZnNIZ0R2SFlIZExJZm9jdVVI?=
 =?utf-8?B?eldGUUxoMmVPWHJCNHRQbkF4V2N0NkpWM1ZudXp1aW1Zbko2YkQ4anl6TkRm?=
 =?utf-8?B?TE1hU0V3dThkSU5vWHRabXB4elFzYnEzSW9UcHB5K283eWZXdGFrQ0EwT0dY?=
 =?utf-8?B?MTJVWnVUcWc4eE52TWRqbXlEOW8rcTlxWlNodlJxekFSc2FtNUtpQ01IcTRM?=
 =?utf-8?B?dXQ5bGV6alNsT1VkdkdwYnB4NWtrRzBhdW5IL0pWRllhemFhZTNkNEEvWWR3?=
 =?utf-8?B?emhqWFo4SS95amlEK2ZEYUtmTHl4KzBhK1o5S3I5MDlRZ255cWdLcklvRi9x?=
 =?utf-8?B?cjJ6RG5KTndHNkdwOTl2ZG53dWJVK3QzaDRwdmxqTDVFVHFDUmFGb016WExK?=
 =?utf-8?B?cWdsZzZTbXk1LzhPanlDbmF0bmUxZW9xSjlYWFlSN3hxT2w2L0xYejgyTzFP?=
 =?utf-8?B?QUdRcHYycXVqcEVmSEdZTUNVYk8xUkFWT1FuYjhEeGNxc1c3SU9DLzVOK05k?=
 =?utf-8?B?RHZGRHFiZ0ZzOHBsai83ZnFCSXhsMlU1TFdWTjNNMWF3UmdIbkdjRmNYMHFS?=
 =?utf-8?B?TkVCaUhuNVBsZFptNzBOd3pGUitTZk5uNStVM1JRejJybGNOcE1HQXQ1QjVN?=
 =?utf-8?B?bWtMQjFRUEpvSFFTUmIrUG1GYUNrNFJpTUoxZUw4VnRrdzV0SVZaaDVFNmxS?=
 =?utf-8?B?YkJtWi96bkhuWnZOWE01NUYrNmlYMkNMblBoNHRiY1BLb212TEpWQXlNbUhE?=
 =?utf-8?B?ZW11bUlKckhKYW5MN0I1L3lhbWJVcTZNMzhmM3hLY1VPenNVdnNrY3ZORUs5?=
 =?utf-8?B?bkY1MWhqZmxiQUNRTzhxK0tneHROUW0xSUlHbTJuOXZsOXAwMGUvWEJxS2tu?=
 =?utf-8?B?UW5WWUZmTWhXeDNFLzROWCt4VkU5ZGk2UlRnemxsd2o5cmZ4bjRCNWhTK3hp?=
 =?utf-8?B?K0JZeTdpSEc1emNEa01KZFNnbGZlU0dodDJSUTh4OUZzZHZSWkt0SW1xcncw?=
 =?utf-8?B?bUY1ZFlUSEVzVGlVSjJjczJJcERaWk4xMU1CRnpBMDROMGRoTGNua2taSGN2?=
 =?utf-8?B?YWN1SDVGVTdRcjhGZGVVRURodGo3N2VDOUlVVWJXWmNJTnlneUVKRm51ZE5S?=
 =?utf-8?B?WTc2Wmh1czMrVWhycXJ6VG5jbURteHpIenV4d2M4cTNXVENCbm95R1lXK1JY?=
 =?utf-8?B?bXNuLzdDdW9UYnlvL3JCcHdDb2hMSWVnMEJCSEtqdnBucjBzT2JBb2J4M2Zu?=
 =?utf-8?B?MHVZT2paaEhRRzBOYkFNVFlJMTRPVkhXLzZid3ZMd1gyMHNqWDJpdHdRM0s0?=
 =?utf-8?B?dUl2ZnpBTWhyMlR3MmdrWkVNRjEveTRRRlNmcHJkKzJEQWFER3lrU1RhTUI5?=
 =?utf-8?B?dVVxdGdqa0pILzMrUkdLbkJOWXVBQTMyeWQ2MVNqazdZaDBJc3lvRCtZeW9C?=
 =?utf-8?B?OThmSUtIT0w1NGRyeVd6WDhnMUpTM3NIcmp5OTAvZVp1YTZKNU05KzQxdG1t?=
 =?utf-8?B?cmRDRzFrS3Z1c2NpQlVjRGo3S0RkclRQN0tVcSs2djlyS2ZZb1dGM1VrOEhI?=
 =?utf-8?B?Sjd2MmlBWGI3WkJHSHY0RnZOWWFhdG43elVzWGNweWhINnQ3RkhLMTRIck85?=
 =?utf-8?B?MTdkK3BLTkZ2MldBRFR3czh5aDBiWXYwamV2VXRPRGh1OHRIenhJVjJSRzE3?=
 =?utf-8?B?Vk9oMDBnSXlIY1BlaFQ0Sy90TnBnV0ZCS1QyK3VQbU5MZlRBaCtOR1NzS3Vo?=
 =?utf-8?B?SjhLUCthUXlMSXdYWUN0M29qdkplS3FmOTVwRm11YnNzQk50TVVadzdLU2k3?=
 =?utf-8?B?aG5FcnowN3Q2QTV5TzNIY1FFZGEyQUNyZ2RVSHh0WTJSUEVyaTFOaDdURlZF?=
 =?utf-8?B?Nnh3aEd1eDhhb2hGd20xL1drN1VhRWFuWWx6VzBXSUkyTEtLTjlsWjlweTVq?=
 =?utf-8?Q?u0vIAX+5RTuIqcF5CPnrMRkLN7HymCgy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clFQbnZCMlZPQzI0SFJURHB0TXJvaEJCenZKWGFwbXV1aStDYS9MaFFBUG5O?=
 =?utf-8?B?MkFPbWQ1VEFMMFI5RjcwU1JLQXRBTTZNakRGMnV0azk0dGM3MC9qUElJV1BQ?=
 =?utf-8?B?NmI3RGxlRUI3aHVBOFovUldXTkU1bjRxSjNzaFFYNm5sWHJ2YStGYWdnRVFa?=
 =?utf-8?B?MUF3cUtNVkYvODNWTVo2QVBvQUNzT242c2NQamVQRkdDalUrWmtiRS9rQ092?=
 =?utf-8?B?ZVlnNm9NZFJjZmx1MzM3a2VJaTQ5M0NlNzhvQVNtdUwwNExFVzd2dGxFbmc4?=
 =?utf-8?B?UjluZDlEd2ROT3JnVEtoZVFoL1hUckZuZC80Y1hBRVF4cGFUTTROY1FrNlpo?=
 =?utf-8?B?ZjFHWlNjVkl6N2NBcEcyZTZWSDhVVlcyT244SHoySUVlTUk2ZnI0YVRSMyt5?=
 =?utf-8?B?QzhaMW9uYjJNamhPMUY5bGw3OGNBYUFuSUJhQzBYeERZV09VQzNNcGpISTkr?=
 =?utf-8?B?cUV0QXRkQjY1anNnYVBmM0ZEUWJOTWRPUG9qaHRNaEpORGdKcXk3eTh1am1t?=
 =?utf-8?B?ZDdQQ09IVzk0UWlFWVY2eHZPbEs4UFpiWHJTZWRERzNZQXQ4Nzk0YURkenJx?=
 =?utf-8?B?QTJweTlMd0MzdTJxaWRFYjVtVGJ1d3pxbGhLNDY0OGFpY0t4dTBKUHJBUjMr?=
 =?utf-8?B?QXhCWXZGVzN1UVZyVGZydkxxcTZpYXpvSWI2OGczdGRnVzlPVFVrcDRQeDFF?=
 =?utf-8?B?Y2VldFV3VHI4MEhyVzJOUENGM2RBSHcvbFgvalQzV2NuajljdzJML0xqTDAw?=
 =?utf-8?B?Mm4veXM4Vm5STVpzbVMvbjlmSlJCOUk2SUt0N0VnTXo3RDFUOEJsazZlcXZM?=
 =?utf-8?B?KzFXaHhzK0tnZnExS3dUZkhSQ3FpVGdCMVhZYkkwUDNtSTBjSkNKSlRhS25i?=
 =?utf-8?B?VFQ1MUE2aFlQVUlXY1RmWnpjZHVZWGg2ak5XK2VyNnBsNnhaVG9UR0ZCZmlR?=
 =?utf-8?B?cXgvTit2WVBlQi9jUjNaQ29jSG5WTkdnZEhVamhsMFlYZXFNN0FzSkt3VlYx?=
 =?utf-8?B?ZjNwMjdDaHhFRndYKzNZbDZIU2dnc1RxaGlINUdZbjJ6b3FjOXR1bk5jY0sy?=
 =?utf-8?B?emQwcnFLRThXQkh0TWhSdXFqZksra3RrRjRpclF0N280Rmg3NUkxSnI4VmFs?=
 =?utf-8?B?VGJlVm5CQi90b2VENFNWbjhCL2RjZlJEb0R0eUZiLzRhaVFGQTlDc3ZKNkVR?=
 =?utf-8?B?cFdTaGZFK3cxWmpPbUJIcWcrUDhLdmcwNGR2Y0xwRmcwVjUzWkFObUhaSTV5?=
 =?utf-8?B?MlhDU1dsTFh0L2FZMkc0QzQ5WmlINlZ5M3RQZWhTanpWMGhWY2RJd2ZBOVJh?=
 =?utf-8?B?dFYzeFJpRmdqY3YwNVhrMzc2Szgzc3ZEK0NIbWNaT0tES3ExM0hkTDFhYTZH?=
 =?utf-8?B?eXBFYjQxemRUUG5abThNSTJKVDJKMHNGS1JQbFZ4ZkZadW5RbnkwWWxKUUgr?=
 =?utf-8?B?ZlZXQWNBT3VOQ3ltbHh3bEMwV3VPaGFnTUdHcDVEeVUrRXdmZlRuVmtKSE1V?=
 =?utf-8?B?enJxMnNZM296S1ZRWDlJRDZ2RTZGTGN6bm1BYmVNVnRVbk84eFRPdUxkcjV0?=
 =?utf-8?B?dzRWd3E1S2VhTTVFbkhNb05GK0RCVWJ5WDJWQzFYRU9vMGJhbVQ5ZTh3MFR3?=
 =?utf-8?B?b2QyZ1YybVV0Z20vWEYvNS9kd2pDSTYvZFJQeHRQREgwS1gzUjNaVzQ4MDVh?=
 =?utf-8?B?bi9NaWFMemwzSlZCdGViWkVqWnhucEdSM3d4YU5MaE54OFg3Zk5MZHY5aTlt?=
 =?utf-8?B?c09neStsZiszRmN2UGIyVHlUU0R1aG5VTFdtTzJ4VTBDVXRMS1ljT0E4VHE1?=
 =?utf-8?B?SWgzM3A4bktwaGszKzhrblF6dk1jRXp0a2NuS09KVXYvY0MzVUJXRTNveW1B?=
 =?utf-8?B?NTgwN2RmdWlhbzUxb2dXOS9XaVBDZVE2UmVWK1ovZG1YVzRnUUpZaFQySTFq?=
 =?utf-8?B?RW9qU1pOWVVmeGVCdlRHU0ZDdjY0by8yMVE0QlRwbmxXL29NL2hxN1VldmFl?=
 =?utf-8?B?SStCY2IrLzNkdlQra1pNY3lzRHdITUdIcGpzbkM3RkRTdkN5a0xhSXYvQVZ1?=
 =?utf-8?B?WEE5OGQwMFE1RXFlMkcxYjdYY2VEVCtLMjJMZ1pkK1VSV3Y1MlVsY2NFbGFR?=
 =?utf-8?Q?ktTxZBn0jp6bGuXl2ZlVgMx7B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f1c139-b6b9-4616-c5d4-08dd2bc2466b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:45:56.2527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Rw4bJIWJiSKof+z0YvqiMTWiGarNkJAy1Rp1x8W66nHgnaiz5Ugzl1JlLQp6jo2RrAUxTGqegaMtU7MEHi9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10054
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

From: Viorel Suman <viorel.suman@nxp.com>

When interrupt driven communication is supported, the transport allows
the caller to choose between interrupt and polling driven
communications. To make the choice, the channel flags are used. i.MX95
uses interrupt driven communication so that Channel flags should be set
to 1.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/smt.c |  4 ++++
 drivers/firmware/scmi/smt.h | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f45002490ab64a6bc997eda93a8f4681d99b..e5b902dcb0e641065f4c0faae6bc6660a7e2c6af 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -48,6 +48,10 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	/* Command should complete via an interrupt so that set Channel flags to 1. */
+	if (IS_ENABLED(CONFIG_IMX95))
+		scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status())
 		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),
diff --git a/drivers/firmware/scmi/smt.h b/drivers/firmware/scmi/smt.h
index 9d669a6c922666c48e7dce4c0affd7b47cb137e4..768b0f4c8a8d1cc7966530e724d278d72c2a167b 100644
--- a/drivers/firmware/scmi/smt.h
+++ b/drivers/firmware/scmi/smt.h
@@ -84,6 +84,16 @@ static inline void scmi_smt_put_channel(struct scmi_smt *smt)
 	hdr->channel_status &= ~SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR;
 }
 
+static inline void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt);
 
 /*

-- 
2.34.1

