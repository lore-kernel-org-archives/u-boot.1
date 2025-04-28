Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88248C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE0D82982;
	Mon, 28 Apr 2025 12:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OekGmQeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A42882905; Mon, 28 Apr 2025 12:39:38 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 990A082145
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJ9o079UzQJAXWfTjdJ80Djo4Jqu6mPqsCoPIdAEt7Dnp1EA23eUIviXlYpftfxlTXOD50WRmx0VEkcFbmByFOA6Gqbtt08Lp1h64VteWk2d1GmdMKgSnhIuVkAZGJDsNQByQFe7nJQeWVBaxHZ48RNEJ3WMmGw+kxNVLQ3+Qi86W2VsEWAifzzMOuLeBlH+b7DYN7tqjqI0gNI9/M8XkPXkEnO4XCdsUL2pzrsdN36GcuV6bo4svkQDZ1TKkPfxOGyWAyV1rzHGl3E1sN/L9qpTxE74smSvkTt30gJa6JsVkBgGOMmhpNPHB2Dr2j854aF/enB0IQK4hhspLoaVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g0SWdObg8lVEGXhgGO4ZLxRvem+7sEIy5wQ7gxqngU=;
 b=X9DlrXIi1Jt2kWqPS4z0rpAIv1MPjlR7YaH/Cu0F2EdNCw3hBAHZjYmzTyOcW4cL1m1GW15xoVkg3tJUthHH0k3Y7VDE5HvBhKXZm8fBEjPdbhYFdhuRYdwfvZf/TYuHPLye14tHk4UdDNXFDBR6QudgxQdqDQDGWkKzJshDu+SPr2fD6hWlzjb/O9bguIlxzK0Kjf0E4YtD3x7A6lZqMUGXurGvQFgtZBPr2PIVXVzcazITdVQC2AKBSpsRnSW4BYillcENu9iGT3+J0VBzHjySQdHBaO66Yby9+bIsp4nhFaEa0SgmOvv2eo2M5X03V3UwNPBlmjePjNPn/rgIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g0SWdObg8lVEGXhgGO4ZLxRvem+7sEIy5wQ7gxqngU=;
 b=OekGmQeqGGIlr/y3o+d8+ylPAanp5Obu+LL8HViYKNRzj7U65f/tekPYWElWYUsts8+5WJyHe8HTl1omw7AuFBEtYmxlVm+gdUEd0+D2Kn78hb8r+geeLyJAz0zGODXLkNTPqHRgScw/+fvcZe/7bq69sfYaayv48kX72IO7szeuGXu5Q4Gz5Wj8biX7MUE0RS4JKQ2hBQvm8oUQnoA1AjDEz3ey8Ii0feJlmHFfzEojuz5zEwgL3HTN8dym6q9HCHFviMiM75vnKrgecTkQJmZX3uCXZQ4adxP68Unhdv0xmgWB3AXLXSSdsKo44RYT4MrBFbexhwu20VmJueLxSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:39:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:32 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:39 +0800
Subject: [PATCH v11 16/21] binman: add a new entry type for packing DDR PHY
 firmware images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-16-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 8024bdc4-b644-4324-c16f-08dd8640f665
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1hCTHNJdEMwSG10VFVWNE9mSm9tN2lqMklNSkZLSkw2ZjhzZDZUY01keHdU?=
 =?utf-8?B?SmVNK29nWGh4SlJzdFJBeG9FL2tnMStoMWdncjVCR0REMjFmTlFQOThZWE1v?=
 =?utf-8?B?K3BEcVg2TnZrcWlVWUQ3bDZPMmVSWEpSMnl0T3NnaW5JL0pOekt3OFF2MXBV?=
 =?utf-8?B?U09lay9SZmJyNFBJUkt3T2IwelJwcE9lOTZQMy9kNlRrY1JDUG1pa3VUbmxB?=
 =?utf-8?B?c0hPaCt4NmVyTCtrMkMvNjJUTkFNbkxnMndRTDBZaUpyQ3Zsd211UTU5Tm9r?=
 =?utf-8?B?cDhrYnVTV2N4cTMwRXZ2ak96YWh6a1hROFdUMzhQTC9qNWJHL3JrY0dUSjI1?=
 =?utf-8?B?RHFuL0pHQXhhUHJpdk02YmQrZ2I0S1BRblZzWXNjNHpndmxxZWVqWjV1REt0?=
 =?utf-8?B?cmxLa29Cb29Fbmk2bWtXR2hJdWx4djgzLzEyOHIrbnltbkN0L0ZhN2N4cDVr?=
 =?utf-8?B?OEtVSUhNQlM5N04zMkIybVlzM0pZeTNqV2xkMGRXRlFINkM5MjJDODdaRVRX?=
 =?utf-8?B?ZVdURGJQcHVPMTdEdWR2V1UrOHVJanlmY25HdjdrdVJ4VVh0b0p5UTVJV1NN?=
 =?utf-8?B?QVo5THJZTDhJd1FGalZIR1dmS1hyT0tyYnpPYmdRMWZJNVpiYlJMV3lBZ2t0?=
 =?utf-8?B?c2I2SWxOUEVpM1drc2E3UzQ5TU9nWjdrUlVBSUpUQWh3bXpDSURCZUFWRWhz?=
 =?utf-8?B?T1lCa2RNVVRmR1lWZkJ3d1ZWMWRmdUZIUGVQOXoxMndlSFZYUFl4Y2ZZdS8y?=
 =?utf-8?B?T1ZkV1ptb2VmaFBwOGEyUWV2WlEwQmp0T1d1aGx3OC8rOEtCR2xraHhadllO?=
 =?utf-8?B?T0xXTytJeHRCdStyQ0llVUZvaVlSdW1kdHZhd2lyTlBSa0xCUS84REcvS3ZE?=
 =?utf-8?B?cnpsVFE4MVJrR3A3Rzc5aWs5ZmhEUWNqYy8vK1dCSmpPWVlvSzRmL0RITDFM?=
 =?utf-8?B?Y0V1eGpKSGppb2JXSUk3dmEvWG9MTHpFZm94VlJwWmk3WHM5Z2tDa1Fybmgw?=
 =?utf-8?B?UVd0dDdQamgreHo1VWVZUVo4NDlYYzZiYW9EOFlMc1k0cUMzMkxlaEpFYnBF?=
 =?utf-8?B?dEZUd1dOSkhueW00UVZWZVRKUkRPU3ZGQmthUnlPYTFsZFlQckZVZGY5MFR5?=
 =?utf-8?B?aUFhWTBoY1JnME1YZ1BzL3BlMXJ2TGhnNDRjWDhpam4xYnRsbkVMS3M4RWRX?=
 =?utf-8?B?djdkSUlycGV0b0NIUXdSenF2ZkEwMjk0dGlqZTA1T2tyQ2Z6K1hvM3lSWE9B?=
 =?utf-8?B?OTdiZTViZVBnSXJNQ1BvOWNKT1dlZC9YYmdrWkxXRDBKUDdmN2xPRjZVaDFP?=
 =?utf-8?B?TDdha3h0WE8yckpCL2lsN1N5K3MyM2lvSkVpZUFsTnJaV0dmVVlzWVQwcFZ0?=
 =?utf-8?B?VFFySTdsQkt3L2lFZlpydDNMVGFZUm1Xc0ZTWHVlbFVUcVNRWmlUbWxITFRY?=
 =?utf-8?B?OWxxOUhqSnNwamI4ZnIwU2grcG4yRGZiYUsvUWNZMXlmQWZ3VVpzWlFrVmNF?=
 =?utf-8?B?OHlyYjY2ekloOEtxOFhmT3NxNDhsd1QrY3ZBeFpMbUR2TXc4RUNUUGplbVVY?=
 =?utf-8?B?Mld6Q2NTVE1jRUZpM1Z6ZlM5ZGQwc1lXdERpbzBBTGR2UWNlekN1Z0l2UVox?=
 =?utf-8?B?WHlmdFhlWnVHdjJXSXhjaEkxOXBnSEFJZC9rMVdCU1pOL1lCNEUwQktLcWJ3?=
 =?utf-8?B?bDk2R3RiNGhNWndKcDJ4TnMzeW95cmtDSEdBNUR1YndsYWg2ZWFaTkVSRWkr?=
 =?utf-8?B?MWl4a2hETDdDaHZXazQ3VldDbHlvZGhXazM1LytPQUNqR0V2eVZ5c3IydUdJ?=
 =?utf-8?B?bjBjdnBGYjNIU2tkWXBwVmpIL2hZOEttNlAvUHJBdUxkdCtiOXN1M0xCS0h6?=
 =?utf-8?B?OHdOK1pCWmsxWUZsVUpJM1VmTWdEYUhmSzJHb3BRQ2xySGczdWxlSEZBd1M0?=
 =?utf-8?B?WjRIbk5mM0dXTjduVXFqT24wRTdEQ04yY0pkQlgzQTBUMTQwMVRkWE8ySUlS?=
 =?utf-8?B?c1pZNHlpOEJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0xad2gvdnZxeEZlMk53L2hYajRBUGUzall5enN2RVRaeEhhQkZQLy9MUzYz?=
 =?utf-8?B?R1VWbVZXVXJKTWlhYzMxbDdrVEZwOGdQa0Z1S1JOSVZibDB0OFd3V3JRUzJK?=
 =?utf-8?B?blRyRytwTHVOMVRTMnBvMHdGQTJ4bDJEOHhhelp1V24xaWlWSGZlaTNNaTRp?=
 =?utf-8?B?dkUxb0hwUmZoa1NCSGJTK0N2akpwQXJVeitVVkJiclU5amtlU0NtTUFDUWFh?=
 =?utf-8?B?V3BxQ0ZFWWQrSDBuaWZ2OEdhL0ZYY2JSUnAvSVVITUhiQ0xzVjB6TnR5aXFo?=
 =?utf-8?B?cFZoSm50QXhQbkdON210dWRyTUViUWR4dWdKRVovbUhSWWhwMm9jNDhLelJ6?=
 =?utf-8?B?UXZ4SnZkaU4wOFhpNU1tekxmei9tTVJMb0cxdW9oNVk2UEJmR3lCNDFFSFlO?=
 =?utf-8?B?ZlRIV28vVXpyZk5BcDE5NXQ0bFk5ZXFDVzdyS3I1RlpDek8rV09ocHRsT3Ba?=
 =?utf-8?B?Q3JBTHQxRFIyQVdrNnlrZXY3czgvM1hKSVF3dnlkQ05OR3BleWw1SmxuVFBx?=
 =?utf-8?B?eS80QzliLzBkWUcxbDBjbGVqbnhLTGJpWnQ5bDMwOFRXSisrTlhzSGtlVzNZ?=
 =?utf-8?B?ZEN3b1Eyc2EwaFZ6Z09VTiswRTc5eHJnaU9iWkR1VGlnK2wxVTJpWlk1M2hW?=
 =?utf-8?B?ek5RNVZZMkl4OWtQT2pFdnZZUFVZWWg3RGExeFVxcnpsWmRNZGVrcGJGN0pX?=
 =?utf-8?B?aXJvUHZmOVdVeGhWbSt0SXpOa3FFTGpZT09xZ1ZIcjByV2g4alVLUHYyeVIr?=
 =?utf-8?B?bVRtVWthTGcxZEtUTExla0F0U0JCUGtmcmtIUkxSczhmYXkxMTJvMGNHS1k1?=
 =?utf-8?B?VXZGK3VURnJ5QUpmSjBhS3EyN2sweGhqWVBxYmp2N3h3M2RZbEd4WVdMRHBJ?=
 =?utf-8?B?dVB0cVlwaXh5Zkk4RkRDanBqeGJ2dTF3K0ZNY1QwdFFwdElJdUVrWlVkRmJp?=
 =?utf-8?B?MmpRVy9lRjluUWxoN3VnRkE5V1ludzM2aE9pSW9NNWJ2aHVuWFc1UFpEY0p3?=
 =?utf-8?B?OGZhekhOZGJnOFp0T0lCTTA1NE8yK3d1cHdhRVk2RUNxbEN0YTRRQVBLczRx?=
 =?utf-8?B?eU9McmNVZHNyblVUakNNY1NLL3F3aVlZZnJyUkpMTGIxM1N5bWZwZFdkaGpO?=
 =?utf-8?B?MTQvcGI0R09heGJtTHhhMkdIV2Z2ZTAxRjdrazlCK1QxYjhVeENBYXhuUG80?=
 =?utf-8?B?aVlUejRqMkpPRElOVXNyekNMOHdrMjNGNHlJVDlwQ0pwcEUrWjRPdWdPQXdF?=
 =?utf-8?B?SUZnWXJDOGRhcEJ1b3Z5SjB0UEJnMGMzaDJGMWFpN1JybUU1Rng3Tm4za3hI?=
 =?utf-8?B?dkFBN3J2eE5QVGhrNnlJWGJrM0lHLzFNc0FHdm5WTkVQNnFNcENOTGFjM2Jq?=
 =?utf-8?B?VnA4Y216bUZhQUtJeXdQUi9VeDdkVk05UkFVc0gxRWJOM28xdGNyV05zMzhY?=
 =?utf-8?B?L3ZOVzg2TElBVTBIYWpwTzhLQm9LSVFsQ01LN2RpbDJtVlNXRjRCbzJ4SmY2?=
 =?utf-8?B?YzVza3lLSU1lcHNGNTBKOE5OSHNwTGdhNWZxZVR3Q3lsM09sVm1CSGpOVFNC?=
 =?utf-8?B?RkFIMW4yOFJDY0JVMVAxK21JZ1lZSVV6aXFTS01yQ0Z2QUJ4dkQvV001MW4x?=
 =?utf-8?B?WkpIOU9BQjFRa1JVMGFWS1FvWWgzV1JCMjlDc0lEYlRvNnBvSEhLRFhoM1kw?=
 =?utf-8?B?dENqeEdNV01tWFhxMjk0TFRFMGt3M0haZmw0TVA4Tllic2Jyc3ZoQk5zaVJ1?=
 =?utf-8?B?dVVDT3AyUnk3WTVpNWgvRW1jTXBrcVlFWWduU1RZSmlPbWJscjZUVXE4WkVt?=
 =?utf-8?B?a21DUmVNcEN3akQwVXZZTVBSUmc1Nm1MbXdXeUZSUUdNcXRybUFUYXVIOFNm?=
 =?utf-8?B?ZlQzV0lISE1hazlOd3pYcjFZRUtRM0VxWXFLMS9kQUJNZytlcERRSXJzMG8z?=
 =?utf-8?B?RjRaSHVwc2tza3BtQ0JWcjFsUERqaFNjbG9BMGNzRS9CSnlTWHp5M0JBZjNC?=
 =?utf-8?B?Uys1dzRpejczbDVlOHZEWDNJRW9URVRGZkZhWGFFdTZ5aDZKanl0SjI5VmRU?=
 =?utf-8?B?Mms1ZHZKWjNrenNZMjAydk9CVDVvWXNtQnlpZEIvUndjaEtOWUVkb05sSXZW?=
 =?utf-8?Q?qC9vjPn61Hjd9vU6g0n4y3Crg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8024bdc4-b644-4324-c16f-08dd8640f665
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:32.8147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvrbdsEn6wrbYh+6vHJ3Mnke2//87vAkqlyezOmnJN2LSPFKFYI39ip4EMqml3ACEEjgx2USVCZMipg8jylqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

i.MX95 needs to combine DDR PHY firmware images and their byte counts
together, so add a new entry type nxp-header-ddrfw for this requirement.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst                  | 10 ++++++++++
 tools/binman/etype/nxp_header_ddrfw.py    | 29 +++++++++++++++++++++++++++++
 tools/binman/ftest.py                     | 11 +++++++++++
 tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 ++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 780e9817fb6..4f05aa0a323 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1663,6 +1663,16 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_header_ddrfw:
+
+Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
+----------------------------------------------------------------
+
+This entry is used to combine DDR PHY firmware images and their byte counts
+together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_header_ddrfw.py b/tools/binman/etype/nxp_header_ddrfw.py
new file mode 100644
index 00000000000..655699e6ffa
--- /dev/null
+++ b/tools/binman/etype/nxp_header_ddrfw.py
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+from binman.etype.section import Entry_section
+
+class Entry_nxp_header_ddrfw(Entry_section):
+    """Add a header to DDR PHY firmware images
+
+    This entry is used for i.MX95 to combine DDR PHY firmware images and their
+    byte counts together.
+
+    See imx95_evk.rst for how to get DDR PHY Firmware Images.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def BuildSectionData(self, required):
+        section_data = bytearray()
+        header_data = bytearray()
+
+        for entry in self._entries.values():
+            entry_data = entry.GetData(required)
+
+            section_data += entry_data
+            header_data += entry.contents_size.to_bytes(4, 'little')
+
+        return header_data + section_data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 92df2a03650..fa174900014 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -104,6 +104,8 @@ PRE_LOAD_VERSION      = 0x11223344.to_bytes(4, 'big')
 PRE_LOAD_HDR_SIZE     = 0x00001000.to_bytes(4, 'big')
 TI_BOARD_CONFIG_DATA  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
 TI_UNSECURE_DATA      = b'unsecuredata'
+IMX_LPDDR_IMEM_DATA   = b'qwertyuiop1234567890'
+IMX_LPDDR_DMEM_DATA   = b'asdfghjklzxcvbnm'
 
 # Subdirectory of the input dir to use to put test FDTs
 TEST_FDT_SUBDIR       = 'fdts'
@@ -202,6 +204,8 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('fsp_m.bin', FSP_M_DATA)
         TestFunctional._MakeInputFile('fsp_s.bin', FSP_S_DATA)
         TestFunctional._MakeInputFile('fsp_t.bin', FSP_T_DATA)
+        TestFunctional._MakeInputFile('lpddr5_imem.bin', IMX_LPDDR_IMEM_DATA)
+        TestFunctional._MakeInputFile('lpddr5_dmem.bin', IMX_LPDDR_DMEM_DATA)
 
         cls._elf_testdir = os.path.join(cls._indir, 'elftest')
         elf_test.BuildElfTestFiles(cls._elf_testdir)
@@ -7848,6 +7852,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpHeaderDdrfw(self):
+        """Test that binman can add a header to DDR PHY firmware images"""
+        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
+                         len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
+                         IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/346_nxp_ddrfw_imx95.dts
new file mode 100644
index 00000000000..889f6f29860
--- /dev/null
+++ b/tools/binman/test/346_nxp_ddrfw_imx95.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		imx-lpddr {
+			type = "nxp-header-ddrfw";
+
+			imx-lpddr-imem {
+				filename = "lpddr5_imem.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr-dmem {
+				filename = "lpddr5_dmem.bin";
+				type = "blob-ext";
+			};
+		};
+	};
+};

-- 
2.43.0

