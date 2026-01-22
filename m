Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A937CC44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6404C83B27;
	Thu, 22 Jan 2026 00:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z5wPiOiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6704983AC5; Thu, 22 Jan 2026 00:52:29 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8D780077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEoYOUh7SfdzS1LVIcW9Jm0MPhGHhIbYkijxurJAw2Vy78soA+wWQOkHj6mhBlDpG0BeoK4HmjUPzGm93LUCHh3OyIvFU7/tRCwiCC/7Xg4F9EKxYR61o3ct20/qT/gi9TZA/13chZnz8apxqZRCJZfrHdrWA0l7o57O5Vpyhym7rPmdBAty96Qp/nuSpzGzriehNX2pGgG3uvGWeZApkwnEOetIIsF+7BcQTzT44cWSnVstW1+VYMf5r5ZcCcHkR/Gq6rjZ12O+KWk3l3pXnCzGVk/7sFxEQulfhOS5lAbac01z8XLhGubGgxdiIAZ5lcBZTpxTMd1PmXGE4RQyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k42BJplsTJrlZHTvXGFJe1gJvIGAU9XZfWr7Ca3TNow=;
 b=ycwGOlRAMw4dBS552GIt4+YpfBS0Ct8PcNjXnkxLw3SoGmLR7e9cXNQLvNNC5JZoCiKDqSahWm5xryVVtNR7smOswnJxZ+nNIGl1oFdeMKVcn1osacHoBB4LILSzH9J5/TpTneIsu81tZtHep3uW44NOOhV/gBO42m6QRHaKjK/Elh+2ttHi6xPdi/leiOL37aXy6eKKKNItnhBxEcFOIoxxn2LteXW4LUcysnr5zKhA694VlyFWztJMqdG85hCFLSURqSgZ8FKaJT/7uaeT7KO6+soCmaKsoOwpiQLciBuhuacAvMD2d7Q1SPWzvvdLwUJNMwZ5IGVyv7awUvW3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k42BJplsTJrlZHTvXGFJe1gJvIGAU9XZfWr7Ca3TNow=;
 b=Z5wPiOiw3JsJbivTbrAnas6TPzQvuUOi36yzDFcqzrQhRKDMKLg6S8DSOax8OprRewX+0S9rr20CY/f0HzfuoIXFFKY55tKclNOl4x3WFGt55WH0V+zi8J9z9ErZh6g0YvD7Gf56CPKgRp8+/zTYpMAZy5C1/qH3+CxwxHbFoilyyQ3kXkb+FFThQMyEcZ2C0JLWo+cFXLV1GnqQS6xmwjg0XdrzOBAORk62UEzK1Js36HAgkXliiru9axpdVfHJG1CbqAiMASP+bX2E7ZWlwTtu7KEk0qsTyYYx3wWJs88yax4VFJ9YjvCEker/ctizM3xi8o11a5vsGSvmeUNu4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:52:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:52:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:52 +0800
Subject: [PATCH 09/12] imx8ulp_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-9-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: f67f9194-1aa9-4896-beab-08de59481f0a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3NtUFZZQ0RFc2FTcmpsM2tsYXRHTjhhSS9KTDlGNFpCTkJxZ1JubWVENjgy?=
 =?utf-8?B?b1lVWlJtZVoxLzh0dXNPaWdqRTBIenJkNlNaSVlxc1FORk9CNEVUNWNRNEdi?=
 =?utf-8?B?MWF2aFIxcFdORTdtckNVVkZ2S2UweTdkU2tQd0Npby9YMXhOcm9QeTZzRFo4?=
 =?utf-8?B?ZEEzNC9zdVVieGU0bHBiNmdFMXNTOVRmeVRlWmtkQlA0THBqQm55ZWs5R0pn?=
 =?utf-8?B?MDZUTG1WVnE1bWFGZGRQRjRobThBTFVNdFZxRWQyVmpsRm11bEgvY0NNRkNv?=
 =?utf-8?B?WWJtb0hpZzRJNDQ0RGRHcmNDazZNdlNMUXc1NFk1ekVoekVyZ05FaUQ1VzFz?=
 =?utf-8?B?MHV1SzUweFRwYmFJTmxuNXVVK1BLYTZyM1ZZL1ZPM1VkVXM4VE5FZXM0bkdQ?=
 =?utf-8?B?ZUlnZEF0WEJUdnE1aytkRmUvYWx5RFE2M3ZLOUNxS01rMEI0cnRJZWtNSkVm?=
 =?utf-8?B?QlB4RmdEc09WRXdnTk5iVklxWEV3ekduNDVCNWpDR1ZLZ0I1WjRRK25xdHZ0?=
 =?utf-8?B?SnRSdTl0NlFIbTlWU1F1dlZOZ014ZitmcGtKT3FXRFNhUkNoalkvSGNKSUN4?=
 =?utf-8?B?cUpPR3pvTWREVmkzd2JNQjF4YTVkeVUwV0JMeEg4NWNNSmY1WnhEWXNKL0FK?=
 =?utf-8?B?Z2tKU2p0eUlNcTdNUmxQTUdlN1UvN1lSYm5uNmk1aXFLUXNlN0JtWjJyRURQ?=
 =?utf-8?B?NGpXOTNOL1F0aisweGFkbnprTTZqS0ZKY2VqL1NkV1Z2ZXM5ZE5ScllGV24y?=
 =?utf-8?B?MENvLzRhNW5tWEFKVEY0ZDgzbmRrOVR6SmlMR3lOZ005ZW95SmVQS0tiU0ky?=
 =?utf-8?B?MmM5a1FJL0dpeWpvVW5mVExOcGlJbHZpcUF1d0UrU1FTZWdxRFBjQ0Nvbys3?=
 =?utf-8?B?YmttVlRrKzdZeEF0cGV0TXQxMUcyTkhWMXBIT1lITndjMU1xdmV5MmJZcEMw?=
 =?utf-8?B?eitmNXg2Tnc0Wjh3QmhUaVhyQUo3N3RlVzZqNmFSRFJXYUhlVVA1SUxyQU9w?=
 =?utf-8?B?TmVaVzlpaEczTFQxNi9SOWZmeE41VEkrS1N2TFNCM0pSdmhqeEU0ZmMxMVlF?=
 =?utf-8?B?aGFrUW5IUFU4M3NaNmdGVDZvQzR2ckFXZ2FIVGJBV2JXclQwVVJ1Vk5mcEdh?=
 =?utf-8?B?WWZJTHQxalhpM2xvYjJLTWU4V2JYQXdPYzRFRmhBQ01UbXZMMWFNWE1kQTlw?=
 =?utf-8?B?YjFQT1ljRVZkaHdjNm5NZ3R4dGVLbzlLTWRGMENUQXFlZGhWTW9SekVpYXlp?=
 =?utf-8?B?TlRxTExPRUdnelRVLzNTNzg4SGVLenZWYlE2QllvL2F4bktScEdHcC91OGZT?=
 =?utf-8?B?VGdUZDlyK3JjZW0zMlE1R3o2Mzd6UG9CMEI5clNsc3VNeEF4S2xMZFdiQ0pC?=
 =?utf-8?B?eWhwMzVzcnBKR3FiY3AyQkVkcGZSamk4Ui9jeno2Q05CUkJWWEM5c0VWV0FY?=
 =?utf-8?B?eFNaOTY4cHhibVFkbm9PN1RKbkpJcmJxOGhjQWw5eGFudDRSdVlNTExJY3F6?=
 =?utf-8?B?NUEyK0k3cUtiWC9tYzBPRG0rS1FraHQ1OXQ5cGhzRDRvWG9rd3lQdjQ1RklO?=
 =?utf-8?B?WDR6VU5BSWpLZ0tXcWppd3o0ejhPOENHaWxKdGhmMHlGdEs3TUNrNkgzM28w?=
 =?utf-8?B?cmFYWnBYUjZQN2N2M2wycXExbWM4YTNKMGthSHlDRjdpdGFqUDdST2VUbFFj?=
 =?utf-8?B?c0xWdzVSWFZPRFRxcUxMOE1FWWZMVXAzc1I5NkxrOHZpQ0dhNXluV1pFRlNr?=
 =?utf-8?B?a3pDRUZVenBkeVA5WFU1UFZyQjFjKzdra0pIOG1XdUhtdW1RMSt2TXNzU3lI?=
 =?utf-8?B?M3VSajZ1L01BUGQ4MHJUWC9sUTlqYUVUVmppRjB5QmdWSStmRG9HRVQ4WXFq?=
 =?utf-8?B?OVF3THFqS2ZRdUdzMVR6Z0h4SVVnZmdHejc3b1dUUGZPcnZOTDZpY0Q0SGxq?=
 =?utf-8?B?cU9IdkFEeFFMTTZxREFqZTVZaFNWMVJTb2g2N0xyNDhFdjNNcktLamYwOXRv?=
 =?utf-8?B?Um85YXBNeFViSTRXRm5PREExL01ZMVF4dlNzTUQ5aTI3NzFyclY5MFVPNXd2?=
 =?utf-8?B?MWdLanRuVmk3NDdkUjZ2dzAycWRLU0lPRmNucDRTZXJSbXdVMkUrUmRJdGNB?=
 =?utf-8?B?ZHRXaHRGalFJTUp3WjI0empDU09Mbko1SEVDb2xPSTE5Y1dyMWpIYTdZcVNr?=
 =?utf-8?Q?djS+ije5rnt59yFwcGO3Fvc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktFVm9aN0F2SGlLWXNkZnJjYVYzQmU5U2hMeG9KMm5XOUl0NzVCdTNQNUZU?=
 =?utf-8?B?emRqY1U2RUJBQVFITEhLSVRkb2ZETVRJZXZXdlBWQkVQTVNZeXJhQmt4U1U3?=
 =?utf-8?B?TDNaNENKbkJXQkNQd1B6eUFWL0ZLOTFsdmk1WGdMVjdsWFZoK3FnU0hkTGgy?=
 =?utf-8?B?NXI1bXlpTERUSXBZSkZjY3JBT3NHMzBWSndWVWUxdDd2SjhCbU1SNXlsNkNL?=
 =?utf-8?B?TWY3R09yYVNsaWpiOHVabTlkZTZKL2dIcGlneTR0RndpN3dMdVozR1RRTW0y?=
 =?utf-8?B?ZnV4YmhRcGpNOFpvejZ3MTg2SGlwM09Cai9pMkRDZEJJOEV6NEY1alorTWIw?=
 =?utf-8?B?dUE0YWRiOFFXajFDbDVsWmRmQzExZUNWU2MxUXZUMmZuN0NRVXRvenhkODhH?=
 =?utf-8?B?cEJLZE9kYTd2dG0zcE1RK2YreG90em1GSzJTdlZ2Ylc3VEVqVGxRa0k0N3pp?=
 =?utf-8?B?YitHUHFUY200SXdrWEo0UlhaRlMzeHZxV3lkSnpRNEk1U0lER21IUlZTRmdY?=
 =?utf-8?B?ZE9mMkVaRW5ZTlc1OGRwb1RtdFlvSTFnZUxkQlNGYzN1YnV4SFVwb3FVeFV4?=
 =?utf-8?B?Zkt3TGZObFhVN0dXM3RFRWIyQlFKbC9uYUhlMk5Id2ZpbnFabDdlR1JRLzhh?=
 =?utf-8?B?ZXZtYXhFcnc5ci9BMGZXNEFkK1U0RER5Y0JEV2t4NXhHQkF4ekJTcmZhZll5?=
 =?utf-8?B?UW5FM2NsTHdBdExxRTV4R3duVHZxUUF4dzJLWWI1VXRpNlBGcjI4Z2JsVmcz?=
 =?utf-8?B?a0lybE5QWDNDbzhqODV2TFNYQmU3bmFJRlgzeThXUGovd2p5VHhRbHZoVG9j?=
 =?utf-8?B?aGRhdVV4VTRDZnMvK3NsUlY0aHRCeWRheW5ZTlYzSjlCbVplc1pHNzhNNTUv?=
 =?utf-8?B?OEI2UGdRV0pzNmVtdEQ0enh2R0lHS0hWdUpSalNYTUV5b0o4K2pSQ3NhWk41?=
 =?utf-8?B?dERwOWpObkE5R09EWG8yUGFCYU9zbWRNZGJwVmpCUnp3eUpibWJOdHJGTXdO?=
 =?utf-8?B?cGNvaUVRbEJCVDI0ME9Pa1hmWGlsNkVuOVE3TTNJQUYwaHJEZGtIS1BDNUJ4?=
 =?utf-8?B?N0JOYjBJdGNnM2VNbHMxT2UxbEpXcXdwbDJPMXhrMVFuU0JEUDVrcjlONDY4?=
 =?utf-8?B?VExTU1NJcW9wVXp1SW5xVnZwOXFNb25lUHg2bmxZQjNPVlhzQkxBbnF0Ym8w?=
 =?utf-8?B?dkdJdTUrSDhsYzRaWGQwT3o5QjRVeG5tajE5MWNSaW9qN2d6Uml2b0RvcDBO?=
 =?utf-8?B?bjExVU5QRmJpUEV1cXNXaVhYRkN3SXRJVTdocVNLWTVaNk94bXRGODRXdUpa?=
 =?utf-8?B?NTNMZjh1SFBJWm02cHA4d1BFSlBHdEViOEQxN3JNQ0JvMlV5UnJiTWszRk5G?=
 =?utf-8?B?elp6SGREdGh5VkVmQ1UxNUphdGpjQWgvMk5jaHd6czRJYjNjQWh1VEx4dHpJ?=
 =?utf-8?B?YTRuS3VyWWdGNDNoY2IzeVJKMDljZXpERmZYOHBrdzVycEJscjlyc3hvOUN6?=
 =?utf-8?B?OTBQMEMwbnlZNHgyUjZBZElxaEVaalo1QXF2eWVkK0tDSUdqc0xUWkxXZVl2?=
 =?utf-8?B?dUZYVjVGMDJXMUtja01qYlpUanFtcWpXdU8zeGtEYUxiT0w5QjdBUEUwcWl5?=
 =?utf-8?B?dkQ1aEtUdk9xc1pBVmtYOHI5Zk42akV2SmdNSzZ3cUJUUWtOQi9aRWQzenlh?=
 =?utf-8?B?YjZ2OGpSUlk3aHlpRnB3UUFJT3Y0NFA4OUYrS2t6aWl5YVNPdElxVUdSUVZv?=
 =?utf-8?B?TXRIWGNwRlA3UVcvVGgxUnp4YkZIVFg4c3Nhb3JMcW50OVo3MUpWdWdXV1Ev?=
 =?utf-8?B?U1RVQnNLVFNCcyt4SzRaMGxDSGp1bjhMbWx6Y2IzU01IWmgvTmdwRU9NNFBz?=
 =?utf-8?B?Wm5YOE4vbk4rVzdvcEJyWTY5cFVVK2JLUEVyMThpSUdRcHRFNGVKZ3IvZ2U5?=
 =?utf-8?B?bzRNU0tYT1NMZy9JeFNxZTdjK3VGQVJxcTB6bWZIM1VYcSt2NmpJa0N3QkFM?=
 =?utf-8?B?R1J3UWtRTnl5U1o4bHJDcFFrUlhWMjM0WjByNGZ0WUdLTlozQUJDSkJiSDg1?=
 =?utf-8?B?RVV5eEd3Q2RNeUE5TWhrYWFndGVsVUVhdXdMNlpYS3V4dkV5bFhERWh4S1lE?=
 =?utf-8?B?S01adFFZYS82UEhiVHRQTmtjMG92eVV4K3dtYjNZZXl4NXE2V2wrdy81bEY5?=
 =?utf-8?B?TzhNVVAxd1Z3U2h5L1h4VVhhTXNEZjFrTmplNytMcVVKbU83WWlIdm1veG53?=
 =?utf-8?B?ay90OGJyazIveWlCNmpqeDNyUDhBVWZMMHFGYjlYQ0FyVGJqcHFOdm0veVpK?=
 =?utf-8?B?aGp2RUpwUml1ODlpRFQ4R0NPcjcraUxpL1huY01MeEVjeEM3Q09Hdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67f9194-1aa9-4896-beab-08de59481f0a
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:52:25.4083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhvlH4x9eGhau7xcqKRlDiBVmfH8Bqva5O2dlTWDnnDz+yZhzn/grQoAzc4tAqCpWjvy8fVyQUK9Soha1UsddA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

Drop unused headers and sort them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8ulp_evk/imx8ulp_evk.c |  4 ++--
 board/freescale/imx8ulp_evk/spl.c         | 10 +---------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.c b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
index dc4054b92be..cc34ecdec20 100644
--- a/board/freescale/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
@@ -4,11 +4,11 @@
  */
 
 #include <env.h>
-#include <asm/arch/imx8ulp-pins.h>
+#include <asm/gpio.h>
 #include <asm/arch/clock.h>
+#include <asm/arch/imx8ulp-pins.h>
 #include <asm/arch/pcc.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/gpio.h>
 
 #if IS_ENABLED(CONFIG_FEC_MXC)
 #define ENET_CLK_PAD_CTRL	(PAD_CTL_PUS_UP | PAD_CTL_DSE | PAD_CTL_IBE_ENABLE)
diff --git a/board/freescale/imx8ulp_evk/spl.c b/board/freescale/imx8ulp_evk/spl.c
index 656c2723494..162b3a1a2e0 100644
--- a/board/freescale/imx8ulp_evk/spl.c
+++ b/board/freescale/imx8ulp_evk/spl.c
@@ -5,21 +5,13 @@
 
 #include <init.h>
 #include <spl.h>
-#include <asm/io.h>
-#include <errno.h>
+#include <asm/sections.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/imx8ulp-pins.h>
-#include <dm/uclass.h>
-#include <dm/device.h>
-#include <dm/uclass-internal.h>
-#include <dm/device-internal.h>
-#include <dm/lists.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/rdc.h>
 #include <asm/arch/upower.h>
 #include <asm/mach-imx/ele_api.h>
-#include <asm/sections.h>
 
 void spl_dram_init(void)
 {

-- 
2.51.0

