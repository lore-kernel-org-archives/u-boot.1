Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392C2CD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE626846DF;
	Tue, 19 May 2026 14:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g3DY2hEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70F18465A; Tue, 19 May 2026 08:19:38 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE5984119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX5MZE/btGHzUaAFH2FGvsu/0qIeHwSR75wZRmn60pAjrpnqrG4haWTDuA8qXRBpEDRpIpZxSZSkCDrG56C5Rnfb4nm/Z2eiMm9tJxUw4Uhz1bqDrBqKzv2BEfDCluHxPFUJ9Ql9kttypwVF5Z8+CqPJCjaJTtyj7Ik4/6A4EMDkaNRbv0NAPXEDlNAocMcq4fM3hU4S71S6P8J0orrI6a4/ojRBMBsA4MWMFowXJ9IpiLOAaqFS4QHY6kHI11EJwq7hspBxYREqJVNX+Ru9BVCsDYS2vvW3JMHJpPdt4jrrJO4vRP7dk38FDSA/OMq20BjCjcXLV60A2xXCRKAoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umPeZlNvw68Zabeu7YskNnHKsY/si5yS0e/coGu5SEQ=;
 b=AGiX41dWJgYXkmqj4WcnLQG7C/CpGl//pRVIvGHP4OHz1ogTgGSBhE6J1s/zT72qjAr+q42oFyJI7GZfh2erfhrUYkiEvORsqRcUHLM6pxAFGrLC72lhA0emtkMu9YFaTZUlPg6hlA/jZWVUZCsquTEtby/NTn1KJI1xYTEt4dT0uEykJJJqxAPKvFTkh8bOD1W1BRS1yt3XjnmKaMUxuCciNbqjgZ3OMSVkmuLCkI/xfOgfWODRi6pvsbN3hUS46vK6Lj37iZ6ovHrrVZ1Lw7mKwlbysoGRbu1CKikXc6h2PBwRPxBft130aB5EOLZB5pok65LPEckFIu3CUQ4USw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umPeZlNvw68Zabeu7YskNnHKsY/si5yS0e/coGu5SEQ=;
 b=g3DY2hEIg8cxigngGSM6J/+5jpR0WeTTgOs4VcyR/9rJILGGIihPCyuVsmpDJtrn6dYwnJrMeazK2d1r4F7lcEVFXA3bOtq1linYJxNqyzssczfX4s5KFdSb11oF9VVA6s0wq3YkckuSXg+QlQLhTThw9O8KrTd15qatH5aeYrhpH3Lv1wfvjihfQoSs71ITAkW1MEPAa3pZ2Ba4N1WKef3uRH+Kb6rHphNNVeMNGumrjamNhFDPoC5ViFtZPCjCUuaQvZF7B1JXmR2wdyxMRf9tPOWlhrWPUcxGZUNTMMFCnlpTCVDxb+g3AkIIJAbtcNxPEvLtTxr7dA44PPKs/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:19:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:19:31 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v4 0/8] imx: Switch watchdog addressing from macros to
 devicetree
Date: Tue, 19 May 2026 14:22:00 +0800
Message-Id: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgBDGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NL3fKUkjITXVMLCzOjREOTtDQLEyWg2oKi1LTMCrA50UplJkqxELH
 i0qSs1OQSkAFKtbUAB4ntWW0AAAA=
X-Change-ID: 20260519-wdtv4-58862a14ff84
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joseph Guo <qijian.guo@nxp.com>, Francesco Valla <francesco@valla.it>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Brian Sune <briansune@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, David Zang <davidzangcs@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Fedor Ross <fedor.ross@ifm.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Simona Toaca <simona.toaca@nxp.com>, Anshul Dalal <anshuld@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: dcde43dc-4358-45dd-70d3-08deb56e96ac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|18002099003|56012099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: MRIx1B6a1YekH8n92LaYI4k7IKGjUeXpc3RWh9wvrXWeMkA93WIhks9kzhgIwWOMHcpMe00yeHNwWXAU33XRQKwjTgq13ZuxsVoGkWamYQVitgpBHJxOnL3sEaDJ+F9dCYZm8EGPMZfzljbxwXpUywQkZFwvhzPeB3KKNSrjj+LFkHCzyoCtWFbj0wz/Jjni+dzG0ZzBl31YOSfDCaK9dlmOp6tUqUPPP/rh8oA6Lx4/D9TvIjLHYjPL7SzTBPmjPw1q4ETsK64HB17kTnRiLDoKAQZ2wi4/U6JWgyMzbliz8UkrFeefd13zqANXcHVk1HyCs6p1t2dqj8QYqPmcN8YUhSeyYCcGqf/n7e/zGuJ4CloJbppc9rwgga9Y4WxQ61Tn2C4VfK1/3vqO/pzW3kv6RAvLSM/I1nchTSEF6iA+MOHMs21N7YATujUIv432drJJ9FKRY3J2N6Y5IK0pWnveLye+CRCQfBCBu4VM0us/g0S2xUpZeojGWGNj2/8ikB4KkhFZtG2cEJbge7LXfBvxuIdJH4mNPzVq8FY+zn0f/2cVeUmxbEZr3G4By+/0TamnloSlCJtHv/iqRnEfi/4ujsy/jYeCyCKlb9VNdZGbWL0jMeRNzYF/IvykwI9nuDGQCb+4MWLgxcn6oZoIDo/hscho+NCZCCEgUMBWudu4+0sr3UTx9WCoHyO6eSAsBAjeCGOukszlil5QMOIrskEXgbrftiUVTrduKiofZ3dmV1KexrBYaPiPFTRtiLx+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(18002099003)(56012099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWt0RGFlNDFKMDYra0pVSnBjaTlJbjNIN3g4bHozd2kvTHpmWUR1bWx3NFRX?=
 =?utf-8?B?ODAyZWRKdHR0OUkxdzZPQ1ZBaW1rdTFiRFY3RTUvenNFSnVGQVBQRE1aT3Bu?=
 =?utf-8?B?Z1FDckVtT05EUE56Y2JUZC82U0VJZndJLzRRejRXZjFWOGZjMW9QWTVLMmU5?=
 =?utf-8?B?UDcwaEZlYWxqWE8vNXN6TGZGdVB0amFpUzRnWERzRldKRzVZUEt4YkRvY2xX?=
 =?utf-8?B?TGRhMDFFTi8rMnM1TDZWSzZaV3RnUEYzN3RQMU5aNHRrZEFNaDNVOHlvdnMv?=
 =?utf-8?B?RWF5dEdDVk1vWWNGV2J5dDlBSDJlbE55bytmRi9wNHpIVUV0aUx5QTdVMEpm?=
 =?utf-8?B?NjRkVXV5Q2RiWnkxWE85VDIyeUVGeWUrYkdKTE5zeGhwc0xmV0ZrQVBhKzZr?=
 =?utf-8?B?SGdvV2JaMUdRanJ3Z2JVNTdEVVVKS2c5bnBvTmtibkFYUjNuR0EvQzJMaW0y?=
 =?utf-8?B?MzNzNnN1TUpiZ2FLUFNLN3VncDhBTGtYUTFCUE9wMCtkdFk3R1VHTjc2cjAy?=
 =?utf-8?B?bE91cy95cE9aMWtEY2w1VlBhQ3FPeG5iM0F2WENIV1NJbjkvVjVmcm9ld244?=
 =?utf-8?B?K3Z2MnhnRXFkVWJpMzZ0dUllYkVtRHdVczE1ak5pTGRsWERWbWVVc1pRcVpz?=
 =?utf-8?B?OStPbFBtNkgwK1oyL2JCbGFkTDlpaTJFeHFISjV1OUk1dXU3alBqWEM1cm85?=
 =?utf-8?B?Q3A2L1V6WkphVmRhMkNMd25DUlVRb0Nwc3dnK1NJV0JQRGtROGZPREhtNzhC?=
 =?utf-8?B?d3YxTXNJSDF3d29JNy9NekNKTXRYQ1RrWUE4OXNXMjdIUjMzRU92NEJneFBR?=
 =?utf-8?B?amozeEpBRXVISURSdFUvYStUcUNEMkM5UkU5RDBxcFR6dzN3d3VQSlZTR2U2?=
 =?utf-8?B?NTdRTGcydkZHdDdQd3ZvWjFudEtqUzBZTTJMUkdrNENJT1plbVlxR0JtRjVC?=
 =?utf-8?B?a0JTVndlUFBhOTJPMFovVE4zQktxUjNRV3NWTjBEalA5K0t0TnBQODdiSXlw?=
 =?utf-8?B?ZWExQnRQenh4Y2tFSCtZQmhicWp1empjVzRhcVdpUmI5alBCOTlnTTVsNnhR?=
 =?utf-8?B?L0l4cmtQYTlzSUppdmdJTzFYU2FjWVphWlpEdURCT3J3VnFYbi9SWWVCTTVV?=
 =?utf-8?B?THl6bzUwRFRBZnIzdHRHRldMUEY1UHVJMTc3Yk9taW9IVmo3OXRadHAyQkN6?=
 =?utf-8?B?Nkc5VHZGSEpiRmZPWVRtc3Y2elJiRHVOTzdHZGxaQlJJaVczeVR1ejVNdlgr?=
 =?utf-8?B?Q0owWGZKd2FlQVJzVTdYdXhDcmdvQ1d4UkgrSGMvc3FVRTJwYXg0OCtUd0ZO?=
 =?utf-8?B?L3R0L2tOYmhHakpDMzZuYkFCTXhYRVBqL2NocFJMcE5VczlJYTJGUkxlcXFV?=
 =?utf-8?B?L2RUZndwMGg2VGpQVGRFTkl6WGMreUVVUGhFdGtsclJOdXlKTmszV0V0MS9F?=
 =?utf-8?B?eXJOMDIxa3lIQ0RFd0lxY1RWT1dranNLRlRlYkZjM083S3pVbmlmSUhLY2tO?=
 =?utf-8?B?RVhLSlJiMjJXMnlOVjA1TWl5TGNFa0RIck9MeUdFVkgyNHNXcmwreEtvQjM1?=
 =?utf-8?B?WmliOVVtQ3pwZExGUTNtdVBzYUUwQjZ0cG5Ed1RGREdnSG5SU25GWGdVRyts?=
 =?utf-8?B?QkpqTnVkRlVXRDdtK0Zya2ErVU1nbVJCMHhWaEFZdUtOaSs1Mk8zdS93Z1R3?=
 =?utf-8?B?VGEzMUtRSTkrQnhBUm15K25BUzE2dWVFNWlRSHlUV0Q4b1RGYThOMFJCK3Nq?=
 =?utf-8?B?N29kdGwwK0FZZVY4WjFVVE5zSmZueUR0M2JBQmdQdlRkQi9lbGVldzJrT2NN?=
 =?utf-8?B?VWNWeURCTWpteUVzSEpqckpqTkNWWHZuTThia3cwNm5SRTlaZGtqdzk1Y1V1?=
 =?utf-8?B?TCtoVG1RZ1BuMGpkK1llSXpwTkxyWWR1NnBodCs1SG9rb0tndnJWSDZEQ0My?=
 =?utf-8?B?UjU5citmaFhrazR6MUxvbzhZRWZNSlluYnZvemJCZ1FTYmRFcmMvYkR4dW1v?=
 =?utf-8?B?ZEFJdjB6UTVZU1lkbW5iU2l1UUh5aTd1V3c0dW9LUEFiRk9wcFNEYjFEQ0hi?=
 =?utf-8?B?NXd0Y0RENEJwbTVON0NCME5qcm9PSXhwQTI1VGlhRUhTM040ZGFUUHdVNTRN?=
 =?utf-8?B?dXBQSHRqdjhuTTBGRzNaSWZKejh5VHlvZUFldURLN002WDRNaFl6ZEw4dmN0?=
 =?utf-8?B?Y2lLQ3Z2TGEvLzZrN0tDOU1lMjJSNTV0M2xEc0dMZWdHdDRIYWxXWjJ1VXN1?=
 =?utf-8?B?SUxJY3NhQmV3R2d2TEpLd2hOV1p1c2I0bE1vai9iQy9UWWRmWFgrdVgySEl2?=
 =?utf-8?B?NUZjRVdKQlJYcWF3ZTUzMmdVQXIzOFhvVHE3ald0VURZOHdUL05nZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcde43dc-4358-45dd-70d3-08deb56e96ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:19:31.4484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GT/GuUgCqsujPos+0f7D2AamujA1SxRVli0SOMgdm54DeS8DRt0NrStFdVjDvVr6J08gPKZbaI/Ns5fv9fuLBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453
X-Mailman-Approved-At: Tue, 19 May 2026 14:56:05 +0200
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

CI: https://github.com/u-boot/u-boot/pull/974/checks

The watchdog DT changes have already been posted to the upstream Linux
kernel, addressing the concern about avoiding unnecessary growth of
u-boot.dtsi. Linux DT changes are available at:
https://lore.kernel.org/all/20260512024850.904551-1-alice.guo@oss.nxp.com/T/#u

Changes for v2:
- Iterate all watchdog nodes in device tree instead of wdog alias
- Delete non-DM implementation of the ULP watchdog driver

Changes for v3:
- Convert imx7ulp, imx91, imx93-frdm and imx93_var_som to CONFIG_OF_UPSTREAM

Changes for v4:
- Replace ofnode_by_compatible with the ofnode_for_each_compatible_node
- Reorder patch [v3,5/9] and patch [v3,6/9]
- Merge patch [v3,7/9] and patch [v3,8/9] 

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (8):
      imx7ulp: Switch to OF_UPSTREAM
      imx91: Switch to OF_UPSTREAM
      imx93-frdm: Switch to OF_UPSTREAM
      imx93_var_som: Switch to OF_UPSTREAM
      arm: dts: imx: Update watchdog nodes for dynamic base address lookup
      imx: soc: Get watchdog base addresses from device tree
      watchdog: ulp_wdog: Use driver model for reset_cpu()
      imx: Remove hardcoded watchdog base address macros

 arch/arm/dts/Makefile                            |   4 -
 arch/arm/dts/imx7ulp-com-u-boot.dtsi             |   2 +
 arch/arm/dts/imx7ulp-com.dts                     |  79 --
 arch/arm/dts/imx7ulp-evk-u-boot.dtsi             |   6 +
 arch/arm/dts/imx7ulp-evk.dts                     | 133 ----
 arch/arm/dts/imx7ulp-u-boot.dtsi                 |  17 +
 arch/arm/dts/imx7ulp.dtsi                        | 461 ------------
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi             |   4 -
 arch/arm/dts/imx8ulp-u-boot.dtsi                 |   4 +
 arch/arm/dts/imx91-11x11-evk.dts                 | 875 ----------------------
 arch/arm/dts/imx91-11x11-frdm.dts                | 773 -------------------
 arch/arm/dts/imx91-pinfunc.h                     | 770 -------------------
 arch/arm/dts/imx91-u-boot.dtsi                   |  12 +
 arch/arm/dts/imx91.dtsi                          |  53 --
 arch/arm/dts/imx93-11x11-frdm.dts                | 603 ---------------
 arch/arm/dts/imx93-u-boot.dtsi                   |  12 +
 arch/arm/dts/imx93-var-som-symphony.dts          | 323 --------
 arch/arm/dts/imx93-var-som.dtsi                  | 111 ---
 arch/arm/dts/imx93.dtsi                          | 906 -----------------------
 arch/arm/dts/imx943-evk-u-boot.dtsi              |   4 -
 arch/arm/dts/imx943-u-boot.dtsi                  |  19 +
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi         |   4 -
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi         |   4 -
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi |   4 -
 arch/arm/dts/imx95-u-boot.dtsi                   |  14 +
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi   |   4 -
 arch/arm/dts/imx952-u-boot.dtsi                  |  14 +
 arch/arm/include/asm/arch-imx8ulp/imx-regs.h     |   2 -
 arch/arm/include/asm/arch-imx9/imx-regs.h        |   9 -
 arch/arm/mach-imx/imx8ulp/soc.c                  |  12 +-
 arch/arm/mach-imx/imx9/Kconfig                   |   4 +
 arch/arm/mach-imx/imx9/scmi/soc.c                |  13 +-
 arch/arm/mach-imx/imx9/soc.c                     |  14 +-
 arch/arm/mach-imx/mx7ulp/Kconfig                 |   2 +
 arch/arm/mach-imx/mx7ulp/soc.c                   |  22 +-
 configs/imx8ulp_evk_defconfig                    |   1 +
 configs/imx91_11x11_evk_defconfig                |   2 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig     |   2 +-
 configs/imx91_11x11_frdm_defconfig               |   2 +-
 configs/imx93-phycore_defconfig                  |   1 +
 configs/imx93_frdm_defconfig                     |   2 +-
 configs/imx93_var_som_defconfig                  |   2 +-
 configs/imx943_evk_defconfig                     |   1 +
 configs/imx95_15x15_evk_defconfig                |   1 +
 configs/imx95_evk.config                         |   1 +
 configs/mx7ulp_com_defconfig                     |   3 +-
 configs/mx7ulp_evk_defconfig                     |   2 +-
 configs/mx7ulp_evk_plugin_defconfig              |   2 +-
 configs/toradex-smarc-imx95_defconfig            |   1 +
 configs/verdin-imx95_defconfig                   |   1 +
 drivers/watchdog/ulp_wdog.c                      |  79 +-
 include/configs/imx8ulp_evk.h                    |   2 -
 include/configs/imx91_evk.h                      |   2 -
 include/configs/imx91_frdm.h                     |   2 -
 include/configs/imx93_evk.h                      |   3 -
 include/configs/imx93_frdm.h                     |   3 -
 include/configs/imx93_qsb.h                      |   2 -
 include/configs/imx93_var_som.h                  |   3 -
 include/configs/imx94_evk.h                      |   3 -
 include/configs/imx95_evk.h                      |   2 -
 include/configs/kontron-osm-s-mx93.h             |   2 -
 include/configs/mx7ulp_com.h                     |   3 -
 include/configs/mx7ulp_evk.h                     |   3 -
 include/configs/phycore_imx91_93.h               |   3 -
 include/configs/toradex-smarc-imx95.h            |   2 -
 65 files changed, 198 insertions(+), 5233 deletions(-)
---
base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
change-id: 20260519-wdtv4-58862a14ff84

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

