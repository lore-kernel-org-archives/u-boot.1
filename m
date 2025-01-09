Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36251E77188
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA24806B7;
	Thu,  9 Jan 2025 03:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="drEJytUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BEEF80702; Thu,  9 Jan 2025 03:23:48 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8086F80602
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOAixHpYQl1aRJqx7OFWYK+cchjTuIl07kVS61u6Hlp5/dQKd17FawfgxwdITMu0lFQgX0P51K2tJSlkQ1wGcrUdkUhyftqQLf5tTh3i9QJXSiDWWsNGG/GmHwwE/sZAbLhCKGETrJPag15IgWpTkw0FxfCnhFRo2JBpoC6u6kuP2RbV7GtHpv89gRMGqtrz48WAsJl2S1XZno/PP3V+xav7lruesdizZ49ddQGzx+mKFLbp+Nj+D4Nsr3Rb6EkyJ5H24yq1PdUM1Q2duzAzuUja3DhED49/DpWb5BD6o4sknWYGBecvBmJjf9jlrA2pW1Oy/L9bG3eNaLIWQQM54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTb+kSeGKDT4vK6FTZOlVglI7ToUOWTKnAL9mF4UjFw=;
 b=rNg09W7XPRCkJ82rrjqEj7jqCy5h+dJCgtTLcHcurOlPmKccBaW6KZNhuxYk/PESukB54AsDpajdeEtmgO86h8AQNbV0isbe4+nZeCyC+gbGycpNF+uoqha0DEO952L5Vnfpr0wiPm1KyiunRF0dldwP4vqAsE99abgOfTDZX5dGfviSNDkyvSHsrrl45y4l8Opj0FGAsX87m3hdwt5Gt4ez+L1bA5UGDZgSPKgatftn/wc7awwZT7utjen9ddZf4Q4Tfo1iRMNkqFWFNxxmflP4YWpRDByr39htUYkZwFioj8GQ5BOdNyXMTqYwEBgUeMPQE621p3mT+BuRb0mbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTb+kSeGKDT4vK6FTZOlVglI7ToUOWTKnAL9mF4UjFw=;
 b=drEJytUGrPHOc6RBancxykJobfFD5ggjNX4Ce0J98AoqZTn8VCX4+AuG44GwFexjZggX7xB41ciThn3D/rBuKXTFk8l/T/o6jlAxzt/DuBrlMUF9GadM99HVpGUGR/2BDIm9eyF6vRk0mc0ssnzH4ygaVHkq0e7WNOLFOBzCAmUvsGcwf2jgHOVL7xMiMe0MRm1t1m7ZMYBXI6Ne49FoBgwSKl1ARLDUPloO+pXZOMHT7Mfoigz+eO9jAvFJ8rFJga65FIKU/5Gpg3orPelvtWPScnXzn31ASRyIMCaZaRFTyEirm0bvX71SFidiLMODCRGvyZDxbTiZhMjh3XIWJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:45 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:16 +0800
Subject: [PATCH v3 15/17] imx: imx8mq_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-15-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfaab35-fd62-4e2e-0abc-08dd3054a46d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmpuaFdGajN5Z0tRWVQzWW9pSGxGbGg5UWxIZEpyZGl2NWxGaGlESFFUbXdQ?=
 =?utf-8?B?MW5XV0p4blp4QWM0alFGL2hKeUcrRTlSV3JyRjRZdzlZOXpGR2pTUzVseWcy?=
 =?utf-8?B?S2lSQkZnSUNwSVFWWDk2UWwzTzdMVnNyRklmdUxKRjczcHF4U2pMNXhxUlNN?=
 =?utf-8?B?MEQrQVY1elZraGpoSllHeHJKRXBXbDhaMzN6anp6cUtVeUVadzJ3clkzZjRo?=
 =?utf-8?B?NDhrSG5hVGFzTnEyUk5GTUt1d1VYR2hMR1NwZjA2N0FXS2tlQ0lPNTJCVllw?=
 =?utf-8?B?Y3l6M1FmVUxjZWszNjc4Q0xEM1lJc1lEUW8rR2ZCWXF3VCtjS2FJcW15ZTds?=
 =?utf-8?B?aXAxTWMwZWVMaFYzSGZLQlRpUjNoTWpTZHVsZFhsWWIxNkJNSlBjNkhQL3NB?=
 =?utf-8?B?anZZdXRWWW9HVXFvVGFHakNMV3lxTUlrRUVhWFFxR1Y5dUNWY0ozTUpSM21B?=
 =?utf-8?B?UDFlSGNBa2JLL0tpUWNOMkFaTFlJcStmMFFvOWhQN3JKaWVzSnZyOWdsRmVL?=
 =?utf-8?B?WWlPejBrNmFBWGZMS2M4Q0NYRW9mUzVENTRvZkpoRkI3UitDZ3JzU1Y2TDZw?=
 =?utf-8?B?U1YrT0wrVnlQQUxiUXgyOEFNdEZvZ0V6YlZucittVVZKYjY1VFFsNkYwckty?=
 =?utf-8?B?UnI2MEYwNXVjNnREL1RRWFc3UVZVZ2ZkVDhUcDVkcjBORnpENG44VmNyOU9L?=
 =?utf-8?B?VVd3ZEUyVGc5SlNXeFJaVkVRYkt6YnpiZUZvSVpMTEJBK2hybmd3RGN6YmJu?=
 =?utf-8?B?QjN4S2Z2bk5ZN2JRRThmc2pMRVBwL0t0cFlUMzlwakVxQVlJblVJdHhmSXRw?=
 =?utf-8?B?S2FiYVd0Wm5DWE5FQ0Ric3V3RlpuOWxHNElPYVp0OTZrYUg1VnRHbkhBbmJw?=
 =?utf-8?B?M0ZNRitKcytaSEJjWEl0Q3VaTHZmL3RKKzJRaGNYakQzMWllUGZRbVhaWTk3?=
 =?utf-8?B?allmUnQ3eGdFUk1GUnVsSEdBUXpudDl5NDhCQmJoSGdlK3ppaW9zWGxtMnh6?=
 =?utf-8?B?dXE5TDBwQlRtSEMzQlYzMWR3TGVMRElzeUw5a3F3QWhWNG9RRU5sUE83V0gy?=
 =?utf-8?B?NFpwRklmZ0xUU1M3dXZzK3Irc1lrS3FiUHN1a01iT1FvcVhLWEJwVjhLYS9T?=
 =?utf-8?B?ZzEySnZHR0FTNW45UHJhODdyd3V4OUx6N1c2cjZtdVB2ei9HbkI1SW91SE1a?=
 =?utf-8?B?ZXYwNVdOeDhyNFNaK3pHeHF0NGZya0FkYTJPek5iTEYyUFV2R3IwMHJkcnI1?=
 =?utf-8?B?V3hYNHBBQkpMRVBPRUF3ZU1MUWlRVTJXaC9UenRtZ3c2VVI5T0JlemdCUHR3?=
 =?utf-8?B?N3IyQ0Q0L1haM0hZUjVzWVZCU0MvTWtJN3BrbTlYc1hLc2UydTJLUzVHNHph?=
 =?utf-8?B?NENvVlMvUVk5OUREUFV6VEx2aldXK0I3TzRzbUZCazFzQm9mdG9IanltL0lp?=
 =?utf-8?B?VzdPVGF5NytkZ0l2QkVRemFJZHU2cEp0WXlSbTRvM0k5cXJkNGwzWXo0Ri9u?=
 =?utf-8?B?V2l1ajVSN2NobERid2laY2ZQbHF1YmgwWlRaZ1p5SzcvNU5ib0V2aVpBQ3ha?=
 =?utf-8?B?b1Mzc2dVQU45dzN1OGZoaVZVVGFqdnl6cE9LTFVwVmFBdWVUa1BwaW5tcEcz?=
 =?utf-8?B?Sng4ZWlNd0l6eGV5WG9ZMGFTbHNUaWNsQkdqSURkU2xLUFlOaXVLTWxGMlFl?=
 =?utf-8?B?eWt2anFDRWp2aGRyRExSSlJZSmxyRDVMdFpZRHNZeE1FbGFpaUtUbkhpM2FV?=
 =?utf-8?B?emRGejQ4N05XSUtrNHRUR1Q5Znd3M3krMzlwVG5TUTFNa3RmeXhiaGcrK3lq?=
 =?utf-8?B?S3MrdENoZzBXWWd5cTZvc1Q1ZERMVTNMamFiMkw1ZVJLbFNYZWZyUDQ0QzdI?=
 =?utf-8?B?RndadGEyTG5FRktJamV2NzYxckYxV2xEQy9DNWg3ZkExM3B3em9raXJCU2xM?=
 =?utf-8?Q?0UsYR4JSZGIl4+8ZH790RX0nv/0/mSL6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0krREtWRjJyNGw2TWtybG1objA2TXJkUnBGRTB0NFc5bS9UUXZvekwrZXg2?=
 =?utf-8?B?YUxaMHNCZXkwdC9IMHFsL21yWTBPckNvK3dXYjVGQlJzVWc1UmI1RkR2N0ln?=
 =?utf-8?B?U014TEEwSkRqR05tUnZBMHIvWHZZcGU1dHAyWDRhYkxLWUgzbm5lQzJha3Jz?=
 =?utf-8?B?NzhhbU9NRElkdzFvN1p6UVhnVVRxN04wZ0xybytMSHMvMGs3OGZYTWgzQXVu?=
 =?utf-8?B?VVowVi9oNklEMDhKUUQrTVVmenpWM1BqRmsyWEIvWmFwbWJMQmFJNGwxeVJO?=
 =?utf-8?B?NUppMjNDT0wxUmtCd09Vd0ZyRjlzb1FpeG1oTDdNb01QanpjSjMwZlhNd0Jx?=
 =?utf-8?B?TE5ob3FWRVoreVhBTFVsd0M3bmY3ZENQWVpmams4anFzRDg2bGxpNTcxU01v?=
 =?utf-8?B?a0JnNWVkYlFxaElsMnc2bnRFc2EveUJLYXhsdmpXaUlWUDE5YysrYVN1T0pp?=
 =?utf-8?B?WS9NVjF5V1k0alVyTUlHTFlLY3hxbnU0L2tWT3BzMnVGTGJ4NWNzQXVaRmVK?=
 =?utf-8?B?N0hvTkxkbGg0aVM4WEpaUjNjQWJXUlU5aWR4Z3BrbDBNazI2dW1hWlNIUWw2?=
 =?utf-8?B?dm5sVjhURFJtMkM4aG8ydFVrQnNmMDlrNFl3MWV1MkJxcy84SkhWVUV2UWUw?=
 =?utf-8?B?TVJXdFlzSkU4dWhJSm96QWJRS0l3Tjhudk5qWm52WUN3Y2d1SENOcEV4emtt?=
 =?utf-8?B?aERSbmVrZ3JmL0crc2FsRG8wZDg0RkJJRy9XdWl3dTRvOWI1UjBLU0xtR01E?=
 =?utf-8?B?QkZIb2QvUjdKWitOdnJuMGtTUTNJaGdSclprbWI2bEtRZElSTy82R09UKy9h?=
 =?utf-8?B?OEZkbmFJRlNwSmN3Sml2bXphUlpNQVNZa3ZjaXRiMGtEeEhXQWxJRHZ3MmF4?=
 =?utf-8?B?WlRKYkFWT04wTEFXY01jVUJidnV4RzRCSWQvc01YcGI0bVhLUTZDcWlJU1Ev?=
 =?utf-8?B?T0JVcllUc2g3OW1HajFmMTdhcWs0aFJJZjRCc3Jnb3A1L1FnTEp4bU54WWV3?=
 =?utf-8?B?YTExMnNiUkJ4SXkzcmEya2FkcllEL2N6SDdzNVBUZUVjcGwwYnY1WE1SelV2?=
 =?utf-8?B?ZTFvSE52c09QQTZNV09hdjhEVW5FT3NnMU9QMEJrb0hNaEVuSGIyZmhNRVlP?=
 =?utf-8?B?ZzB2V3ZkUXlTQUVEYnlmTG8wUTMrS3NkOFJKb2RnczlvNWFFV1dETWt4K2xu?=
 =?utf-8?B?bWE2OEU5RzNzS01uM3JmQTVKMzN1RkxyODRJUno5NEU4eFBBang0K3oxMXFv?=
 =?utf-8?B?UkdqU0dNOUxZUUJyYU1JWUpySk42Y3pKTk9qUTlnWWhIUEdMWEdJVmVSSVho?=
 =?utf-8?B?WUQxRVNaSk5vZ2RrZVlqZWZEbG9EaEdtbmF4N080NG5sZDJDRVNzZS82dGhM?=
 =?utf-8?B?ZW9QTjVhS3NFczZDTzlWeDN4OFdaNXZOUmFvM0RVVXR1K1JKNURRaVpkQitW?=
 =?utf-8?B?a0JwTHlGSysrdkx1VU5mak50cEJ2MHBQMGZEdWl2UEM3T2k2eVdVdFBxaE5a?=
 =?utf-8?B?dDBiYTRRVSthcUZ4L1hFQTdkUEtPSkg3ZDJoWkpiK2hscEZtd29pTkhac0FM?=
 =?utf-8?B?VGhEUnpGRGpRcnBiSjluSXhteWJYUldqZ0xGZ3k1SVdWSEVkOS9OOThseXN0?=
 =?utf-8?B?aTM0b2RhSTZkMDcvelRGYzNjUHpGUE5EbUxjNHpDUFpKNUNaVHpBWXBWR2Iz?=
 =?utf-8?B?ZFJuYkpFVHpnWmZhUkdkNVlrbGR2bHNnQVNqaFB5OXE5bnE4NU41clh6T1V3?=
 =?utf-8?B?NnovQy80Q2d6WGd1TVUxdmtnU0lyZzEwekQ1YWxwV2dDTlgrYTJZMjFKVEZX?=
 =?utf-8?B?TU1QU2c0ZEF5aTFrS21kQy9ieVdwNVg1T0o0UjlHOU5UNG8wc0RYVHFoQy9K?=
 =?utf-8?B?WXFtemREenVkZlBtdXIrMG84U1liYkJiYjcxSkFSRlRZbW1zUU5UdTV6eXBR?=
 =?utf-8?B?cktJaURwM2g5Rk1kS1RDRzNNV1MrTW04dFUxRHNseUZhVllsZDFQemJjdFc5?=
 =?utf-8?B?YXdTZllnYjBKZ1Q5MzFnRHhBb0dJekhQRHlML0wrb01sVlc0T3pqYnZzYVJ4?=
 =?utf-8?B?dkd6RVl1SG9YQ0J4K2xYZEkwQmVtSlhWODQ2akY4OFpjMVVVVzFYSlVTUmFl?=
 =?utf-8?Q?vQLtxAuI756sTpYs2CoXFrV6m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfaab35-fd62-4e2e-0abc-08dd3054a46d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:45.1614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGb6m6/X9sQ3mlk+9pKpAE6hxVLnmTL+Z4TSmQfyV1gPX1CiDF8m2UwHdHZuTarzKHAi7jXg7R179rT3eJ9pDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

Move env to imx8mq_evk.env
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig           |  2 ++
 board/freescale/imx8mq_evk/imx8mq_evk.env | 60 +++++++++++++++++++++++++++++++
 configs/imx8mq_evk_defconfig              |  3 +-
 include/configs/imx8mq_evk.h              | 22 ------------
 4 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 28be6a22bf07e1341ec841bace149cdbb871fac0..76a8be7798c5d80a0384b1f28b1f18eff7b34e43 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -54,6 +54,8 @@ config TARGET_IMX8MQ_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MQ_PHANBELL
 	bool "imx8mq_phanbell"
diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.env b/board/freescale/imx8mq_evk/imx8mq_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..dcfe1c2f2d4118e5af01078e2e4402f60c2b7f6a
--- /dev/null
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.env
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_targets=mmc1 mmc2 dhcp
+bootm_size=0x10000000
+console=ttymxc0,115200
+fdt_addr_r=0x43000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+initrd_addr=0x43800000
+image=Image
+ip_dyn=yes
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+loadaddr=CONFIG_SYS_LOAD_ADDR
+mmcautodetect=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+prepare_mcore=setenv mcore_clk clk-imx8mq.mcore_booted;
+scriptaddr=CONFIG_SYS_LOAD_ADDR
+
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	else
+		echo wait for boot;
+	fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fdt} = yes || test ${boot_fit} = try; then
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index a3a2333c98268d17942cd76c654bad63406099a8..97ef352dfb866830b228e3e4ae77d78afe01ea8b 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -30,8 +30,9 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_PBSIZE=1050
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
diff --git a/include/configs/imx8mq_evk.h b/include/configs/imx8mq_evk.h
index 666f46ac105be6a7828bf54c388afad14ee1d1cf..2a86240e2c6dbf3e86e626a2b4a2c1311c68e8a0 100644
--- a/include/configs/imx8mq_evk.h
+++ b/include/configs/imx8mq_evk.h
@@ -26,28 +26,6 @@
 #define CFG_FEC_MXC_PHYADDR          0
 #endif
 
-#define BOOT_TARGET_DEVICES(func) \
-       func(MMC, mmc, 0) \
-       func(MMC, mmc, 1) \
-       func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttymxc0,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
-	"boot_fdt=try\0" \
-	"fdtfile=imx8mq-evk.dtb\0" \
-	"initrd_addr=0x43800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000

-- 
2.35.3

