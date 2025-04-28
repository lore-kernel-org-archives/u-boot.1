Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE67DC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC3780FDA;
	Mon, 28 Apr 2025 12:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LhBbUwIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC6A8219D; Mon, 28 Apr 2025 12:38:30 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8758180EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRAJFiubn5M6XCBSTFbezXx/PCmlCXlYq//LseN24RxR6JG0CrwQBYEN0KeIecIFmtxJ7A2i8KZrBAR9d2U2bmqGTlHjM06XBNpGFwJtV0z57ce7IjYioQ0QBNlAwhqYiYaOCGGHXD0GevJZiEnrfkDyorkvFNVuPd7C6WyIx3KKwYT7a5hkSPQv+WxOphfAh8GD2mfRIX0ioE0EwuWLaCJ00qCmylMjIyKX9XW5oy/Sf9bvZg1jQBQz5VoVHJ93ZtYaIfEIVd02tX5x1eZS0pfLEMMgfx5dNbxRguLUweNJuVq/0salh2ItKbD9MIlpDMxyy1mRcMJ+NmyGNsFLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArTnAMIDZBfXoQNw0M/5PJCPVQTJJmWwL2BQcQC461Q=;
 b=SFkwjzjylUxoQK0+P9MgJeZpmFV52hvSUfqtGfAHIQTfqT8ojijM94rjbyrF8LOibLYGi1zMmOwGUMMTHLclXbQMg33OF1aPOvzsYwdC3QSfbq3FPL49tKu4dWtiEMFTiWgPQfH6W/6riXn0n+XWUIGNdEM5bIk1t5v5frNiaPEq9M6d1MbQ+7OxeEXPXXFZ0J44dSsux8srFLI0FIxqQY8PmagRxCSuvHpBwsoPtmo3GFlesh1aoDK52wQp0MU0LrQCjmjCBuyuJaCaGX1bH/0cP3aAX+3irjKeO8fqQ6dJ8ThXLkj7kez/dbjuAdm0yuKx1wa+roq6dcrKFJE2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArTnAMIDZBfXoQNw0M/5PJCPVQTJJmWwL2BQcQC461Q=;
 b=LhBbUwITWZSyRKjgwXnNmP3gApWybOcPBeu3mGOYqV7R1JYB8jydHXwwQs1znHh/PXA5xiOBNWmbq2cxgByetDIVqN3uCsGCZANin1aZbUypHug6TF7jXXjvD7Dfb+U9uSONB3vUcsPHkOVK4RVXR4bd9fUhe0xpp21FogHXJh5gAgki6GyG0J30+Ef5iyIT/GagxBgBCFoDoM+nDeylZUvi4lufzLBhneJzVm47q8BTvPNy5ZXyFhhySE7HUpecILhDgohhRasWc9Px01PDRDlv7eSJOS2Rj3npzSjlfyYnmpvfSkdbvs75+OnuQFFlOUHa2AWyrB4JCQDBbSo+Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10393.eurprd04.prod.outlook.com (2603:10a6:150:1c9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 10:38:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:38:26 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:24 +0800
Subject: [PATCH v11 01/21] firmware: scmi: support to manage SCMI protocol
 drivers with a linker-genetated array
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-1-a3df9c340ace@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10393:EE_
X-MS-Office365-Filtering-Correlation-Id: af566ff4-c2dd-485e-1c72-08dd8640cf06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TC9CaTRKUVVnaHlrdTRDL1RXNVdRZHRiQUlUU1lsRkYxQXQwWWZrUmNCZEFN?=
 =?utf-8?B?WDIzek95M1Y1MUJqcVFYa2M2QmdqMkpFNEZlVGRETkdnaDkxRUJ2bU5FZ293?=
 =?utf-8?B?RFpORmhHMnp1ODY2UVdxQlFwS3FpWnlJK296Ny9TYVVpdnJjOERDZE56dzd0?=
 =?utf-8?B?R0ZFK095RGFRRnUrUjcraDVvaFBTNFp5UXB6RDJLb2JXTk9yMlZmNEJQQ2tR?=
 =?utf-8?B?NVNlUDJlU3E2QldYQlE5MXJ4dnpRZ3NjY0M1WVROaVk5M1BZMS9ZM1hpL2Qr?=
 =?utf-8?B?NUhWWERVMmFlR25uN0JNVGxmTGFFY3ArYnY1ZURIdUp4YnlRci82S2hhQU83?=
 =?utf-8?B?cElTdCsvc2lPYkozcHlvbE1acE84Y2Y1WHFWWndOZ3A4cHduZnkyM0RZVFIr?=
 =?utf-8?B?UUZBKzhFa3laeklLSTkwakFRV3g3bGdJbHU3SlZjYmxkWXVYUWE4Q28ybnZw?=
 =?utf-8?B?RGRDeG5pTFhGQk1MSytIY1hUTzVqdUJic2sxNFhFN1ZJWnRGVWhrblUzU01a?=
 =?utf-8?B?UDdkV0pxOVhiOGFYREJpY1VuQmRUcUdYZ0JLU0doMkpHb1NPVXJoaisyQ1Z6?=
 =?utf-8?B?eDEzc3d5UjVPanFJeUJMMzE3MTduRW8rZFV3M1pKa0lGL0ozRHRHQytOVVV6?=
 =?utf-8?B?Mi9EV1lUOXVHcXcxaVI1S1VWWnVmQlVST0x3Q3BOL3dYQVhWL3FHdk1oeTVU?=
 =?utf-8?B?S0Y2NGw4MGduYm9uRDc5akJraTRqdUl5QWVNaW1WZUtuclRoSzZwS3NiMkZN?=
 =?utf-8?B?bGZUQWtQbkMvOEJvSHFaRlRIbmNqQU1DMjhXd2dLOU9VazhMMm5QTG5sd3d1?=
 =?utf-8?B?TmJra2I3YXhiODJCQVJxbU9vSGJsUGtORVo1djJRNlRoTDlRNjQzM2ttakc2?=
 =?utf-8?B?QjRHdTg2V0NLeXVVNS9SNEtMZHhJcG81bGI3UjFxZ3g0V3dBZXhMZ1J4aFlm?=
 =?utf-8?B?eDB3azZtVDZ2eGlNbGgvTFdDU21TZVJ3dUl4a25QYnZvU2gzL0xtZllsZ0l3?=
 =?utf-8?B?dmVuS21jR0pUNVJhMGlYOGExV1R1dUFDNHZ3dTdNY1FVbWFoZFdVSlpmUzZZ?=
 =?utf-8?B?ZFZhYWpaYXlTc3dIM1NVMWpod0lsRFZ4S1VSRC9qTXlYZFdaRkovVjZsZ2Zq?=
 =?utf-8?B?Si80RWlpdEhVWkMyb2V2L2ZUdGVLSEVna2RaZWxiMGRIbmY1bEQybERXa3dn?=
 =?utf-8?B?bHFQWjBkUmZJQUNnTEkzdnNSOHhvRjRkOHVJdElXcXc4TEh3WXJMcXUrbG5K?=
 =?utf-8?B?UDIxRUl6cnR4dXRwMTJleWFBdHVXMjFvSzh6Y2ExQngva0I1eXYvcnlwNFd0?=
 =?utf-8?B?enc2R1hjUDdKSXhDTUU1d1pOVUpxZlptNXlrY0hFeGh6Y2YrcmNQUGgrSFNa?=
 =?utf-8?B?WHFpNGJVYWpXbCtIZHBBWWFoc3pydG9vQm52WDhQYmxOQ3dOY2U5M1hoKzIy?=
 =?utf-8?B?YTZMRW11emM0NnlUVmh3djBTRml1L2c4Tnh3YlJIZ2VzOUt4WmY3Ly9yUGZJ?=
 =?utf-8?B?eC93Y3c0eXMrOUJXSGkzSmRsc09ZR3RROGFQUU4zT1lQYVVsWVFIMVozUVRH?=
 =?utf-8?B?aEVkaXRjUzA2WDMxWkROTUx6aVBqR1NGNTdBZk40OHZvd0F6R2dxQ2QvM255?=
 =?utf-8?B?VkhFV1RVeFkweThPZVFCbmVzZkJGWEpQTTkzckFCM2FEYjBSdkorVFJiM0po?=
 =?utf-8?B?QmFCeWRZZkZLdmtnWDJjR1JEeHgrSm1PRFJnd0xvR3MxUW02WUZYWTBobXlu?=
 =?utf-8?B?bm5LSW5ic2h1cW1qUUx1dC9XaVpBdVZield0ODlPb1gvYzdqckozeE1TVlI3?=
 =?utf-8?B?TWhVUzFWSGtjWGNrcW5WbU1jNkVJOXBKVmlKWkNpUE1HZXYyR1ovNUJRTmJE?=
 =?utf-8?B?TjBtTmlpdlpsY3RTdHZDR2ZFQzNwMC9ZUHRFU1VCWmJ1d1cxZFJzOE93aC93?=
 =?utf-8?B?TThzNXA2N3FQUldhcnRWZVVWS0xrVWpPd2RJdHFGMU5UNWwxVTc4Rm1henJM?=
 =?utf-8?B?YktLUmFzbzlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkRkamZFZUZLYXdvY0ZobWFuOEVHelYvanllSWNxT200dGF6Q2o0RXZFTll4?=
 =?utf-8?B?MTYyNjczZkJ4bEp1ckozVDFQQVNmUmZtUUdjbHEzMDFSUzdhL2p0bUNDTXc4?=
 =?utf-8?B?QytlQ25zNkVOYnNma3dwMHUwTjRudEhkaUVSZXh1RkhKbTM2d2Q3MlljbTRa?=
 =?utf-8?B?YW5IREllbXJ0UHg2anNDYzliU0ZJbFlOdnF0aksxa3czRFJTRVVlSFpjRmJm?=
 =?utf-8?B?Ujh4Y29mMlV6SkpNdVRXSjF1RCtiWUljeFdmOVM5aEZFWGlFN0N2VVRzbUgx?=
 =?utf-8?B?bEVIbjB2TGpLdkhicTZxZFFoSm5KYk9xcFdidUdxQllkR0QvcEZLTUlvRzBB?=
 =?utf-8?B?cTRIVDB2WWY1dW0wZ2JyZ2ZPYVZYTVB1YXdnYnlPd0hPZC9pU0psbk94ZnVG?=
 =?utf-8?B?M0ExcmE5dHIrU3ZzQy9lM1JTQ3ZEcVhsRDZ2c2VOK2lDTWRXSDhia3hTRzl3?=
 =?utf-8?B?RVpFVm10NEtFd00vR1YrYUFnTGVJOCtoRkRRRm1DeHp3c1pVQ3FIN3N5b3No?=
 =?utf-8?B?eU1iT1Y1NnN6TTI2YWUxcHl5RERHcUVuU2k4dE5Gam1obG5pQS9NT3pWNE9k?=
 =?utf-8?B?SnB0alBPREMvMDhxb1NNZU5YSUNpOHZVT2pURkJsVHY3WTlHbkV5UWJQQjk3?=
 =?utf-8?B?SmIyVWFjYzdPQW1Femw2a1lPZHBSK3l4cXJCNHVSWVh6UGFjc1ZTSDhNTGlK?=
 =?utf-8?B?VHdYeVlQeE5mSTNKNXpjWHRRUGorQ2FORElHVTdBQTJSRFRIY1dVY3VrM01s?=
 =?utf-8?B?MjlQQjFmamwwQzcwVzJ3SG8zSEYvV0NGb2c2a0YxOVZjampXNTNqajhyNnkw?=
 =?utf-8?B?bVZsZjgxZVF0bDBQcmtTM0VBemZzaTd6cnR1bXB6Zy9BUGJmVnpXa29KVzY4?=
 =?utf-8?B?MFVhTEZtUGptdjlTWUdCbUhkZzVNVlMrZ1NGZ2FucWJyK1o1eGRFWVlNVWl1?=
 =?utf-8?B?ek53SFRjblBQc3ZSMUJQenFJSVVzM0dJTkhiU0d2Z2xzNCtNVEtFSGF2ZFZZ?=
 =?utf-8?B?blBGQmQ4Nit2TUJPUUxQMlJxYXRSbjd5UmRtejlRb21uMWk0ckVhYSt1ZW9U?=
 =?utf-8?B?eWNSOUQyRTBJdE85dTk5QWFGUzg5ekdycmRpdy9TQmhiY0JYbjNBZnBsSWxm?=
 =?utf-8?B?ZVBGcktqbjBFaS9Kak5uOTRYNE1TRE51UU5OVkdSd09Jb2N3OEdYcExRWE4r?=
 =?utf-8?B?K0tjNWM4WlQwbkhJVlhMUzAvMzFhMjVCeHZRL0NQOTdoeTRmYjlweDR3RThL?=
 =?utf-8?B?YjFYa1NwK01UeHJIQ2QrNUJPbnpCK0ZXOVVQYm51RXFsV1ZldGxBbXlmV3d0?=
 =?utf-8?B?VkhtNWJFWS9VZHFTS2JRakNCYTFzUHdwcUlJQVNvek5YY0tYb0NBQWUrZXJD?=
 =?utf-8?B?VVVVZ3JPSGJZR3hUUXlveVdNbTZTNFBXRGVIT1JDR0QxMjNHZVVBNUMzcmFZ?=
 =?utf-8?B?OXA3QVd3OVFOQkpjZmppS0RxWHJNTHNScEJBNWtvbEkvRWNNWFBZQnFKNSt4?=
 =?utf-8?B?aTB1ZTJ2ZWw5UzFXZEtUWVluQ1ptSnV4YnV4QjhMaEVRV1UyS285Wk5NalZC?=
 =?utf-8?B?U20yYWFaTmU0SmtoUzlweUxvNkpCM2lvYVp4cGd5bFZRZWdTNExlVERvb3R5?=
 =?utf-8?B?eFFwOEZUS3VrV2kxNmhxQ2ZKV2ZpZnpMR091WGNEZkhVSmd5Yng5aXcrYzNv?=
 =?utf-8?B?eUVMbUsrRmFlZEQwYi9sQmdtNUQ1TnVwZXRFMGg3SCtPT1N2TzRwUGpnQi9D?=
 =?utf-8?B?MThjLzhudzMvOUN2QVVRSGFMVG9rUStmaVlFR0ZvamZvSENjZVI1eVNDU1dO?=
 =?utf-8?B?aTVxdzcwQklKOVphWFJpV1hiaWZaKzhhZnZKTWtPOUd4RnBtUHJvZlFibTYw?=
 =?utf-8?B?QWt1c3lNZVJ2Z2FHUStVcytycHdrbFNFZjVObmVmbEI3MzN6K1JNcDdOT0Jj?=
 =?utf-8?B?SC81RmYxTTFsSTlkS0FiMnI1SFlYa3dObkxNdHJTMXlZbzBQK1NsenQ4bGpl?=
 =?utf-8?B?RE9GYk5HVGZUWjJjdk5LRTVBT1hjUlZUS0lqaXVFQnUzSjFIaSt2b21iSlZF?=
 =?utf-8?B?WFdJZXRITUhkc3BVME4yNzhod0xNT1hJNTd4MTRhODIvUm1qQi84MFd6TzhR?=
 =?utf-8?Q?E5ojD/J1VrQRwb8EGWrmnS+mS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af566ff4-c2dd-485e-1c72-08dd8640cf06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:38:26.7441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9GpO/RSAbJuTPanu6JrusnISazuY7jhr0n7T3S/5oEWZNiI/re/zHVw5VpyjZcAaMVigkwtYZj7eZBCw6XkEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10393
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

U_BOOT_SCMI_PROTO_DRIVER macro is used to add a SCMI protocol driver to
scmi_proto_driver list. scmi_proto_driver_get() function can be used to
match a SCMI protocol id and its driver.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 16 ++++++++++++++++
 include/scmi_agent-uclass.h               | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index e6e43ae936a..ea79cfa0cf2 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -352,6 +352,22 @@ static int scmi_fill_base_info(struct udevice *agent, struct udevice *dev)
 	return 0;
 }
 
+static struct driver *scmi_proto_driver_get(unsigned int proto_id)
+{
+	struct scmi_proto_driver *start, *entry;
+	int n_ents;
+
+	start = ll_entry_start(struct scmi_proto_driver, scmi_proto_driver);
+	n_ents = ll_entry_count(struct scmi_proto_driver, scmi_proto_driver);
+
+	for (entry = start; entry != start + n_ents; entry++) {
+		if (entry->match->proto_id == proto_id)
+			return entry->driver;
+	}
+
+	return NULL;
+}
+
 /*
  * SCMI agent devices binds devices of various uclasses depending on
  * the FDT description. scmi_bind_protocol() is a generic bind sequence
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d..842c56858af 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -115,4 +115,19 @@ struct scmi_agent_ops {
 			   struct scmi_msg *msg);
 };
 
+struct scmi_proto_match {
+	unsigned int proto_id;
+};
+
+struct scmi_proto_driver {
+	struct driver *driver;
+	const struct scmi_proto_match *match;
+};
+
+#define U_BOOT_SCMI_PROTO_DRIVER(__name, __match) \
+	ll_entry_declare(struct scmi_proto_driver, __name, scmi_proto_driver) = { \
+		.driver = llsym(struct driver, __name, driver), \
+		.match = __match, \
+	}
+
 #endif /* _SCMI_TRANSPORT_UCLASS_H */

-- 
2.43.0

