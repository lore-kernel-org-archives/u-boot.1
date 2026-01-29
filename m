Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9096D358EC
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A3B83C61;
	Thu, 29 Jan 2026 10:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B4dkomDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867E983B5E; Thu, 29 Jan 2026 10:40:02 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A9DB83F2E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ6jvqZWG34Ac+RnvLXI03xqoA3FmANceQ3YY1FkGeQnCnI5RQNCgQrsCuXGCwECLitQviBl1c8TKtVpWQhm1D3KM+8xZH3+vvGXXp7D43BfqDrZ8uhBJ126qPsO/TZoc4wx+yIs/RNaE2UaO6+YppRCaePSva5D/QMfNH/sTl3dq1IW0O5lwtj1KUgdJPu7zB4MZdAK9aMUQSl8HqcUqIfoo1ZDiXtsJAg1fKj6Y2AXKLozTC4TUoXm++JD1aAjlkc/nPLTHlU+4ses+Pinam20FpAfYhdFTDlih6qUiBaXRkj0KIHxcejBanf4vsjHicFnuFLDRlrcnElU5SELiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjYfWoRCaLKK/fAaRnkxyl5aSLgWhPz8pdGhW3Ba2E8=;
 b=BKJtq/ftNX7je4YQRRkQ8ZohMB31TBs8siSQhfrg3qwoY/94gHFRferLJ6jqlxTKwV0Ql/l+Rb520Mt2UnoxaOikNNoae2yzECl0MlA5U+iLJQkmOS5Gf8yu55nVPtlTTl9JZ5Nypi+qAulcqyYoe1vuU80sJCMkPmgkgJZ/dkbn+HSHKXTSHohyPFZpU6Xivi/VxI+vd9ITTq7xqh+TeqvQ8yMu5S85ytl8qqrLCmanEKu3a+nEE9wM4YvLqGiUVrmlhc9TzYoERmd0pBqiprlETlGaHjL51oBEkolIHiLdt5lPaMWV0kvJu9vSla4PtP1h49whpYJyPReLNQ7X+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjYfWoRCaLKK/fAaRnkxyl5aSLgWhPz8pdGhW3Ba2E8=;
 b=B4dkomDtvu+MsjhPFMtxNGlsLWbU8afodBNAuuqI59s9MaX1gYC21GKCGY8u6Y2NkrUzbjv9RWXSBJeYU/jfns9Sl639+ch6M/+ElJSiiwQZanv0yTpopJnXnMfT2As1NUY2XP1SMJtgTZTlsMQwWfh7Q9mUg4xBnNFBIXpYqoODYBOIFg9sYMXr5Bp9IkbnCiAF9xR/ioZuzObIWtsUj6SSpz/LCOq3eeV/kPDhTPhDfpggcxHpdAWin2FWDCVlCSieIbFk/Sy3MmWoYMiCtaCi7bDb+acaBmco8EGtexK6cWJBcTub2cQUv3QMzNnwhHQjK92ponvUEP2snwOm6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:14 +0800
Subject: [PATCH v2 12/12] imx93_frdm: Update IMX_BOOT_IMAGE_GUID
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-12-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7c987a-d3b9-4a84-0d5e-08de5f1a5d5a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVZWbFBIZURCNENBWjFGZkgxQjdxQ2Vva21FQi90eWZMa1pqaUdibUxEQ3lM?=
 =?utf-8?B?YXZXSGVPd0s1bXBFeGorNDR6NFMveEVmVUtUdVVyN1ltTDg3dVg1dWo4SDRx?=
 =?utf-8?B?Qmg0R0g5UEJZQzR2S2NWdUhicjhqWXFlWFY0Nk4xRUNCR0RtRFVqa3dvOU93?=
 =?utf-8?B?dElwbTFNMjUwSkRrVldXQUhMeThMUVlJb2xGQnJoRHBLazdNK0gweXpxdkV0?=
 =?utf-8?B?aFFucUlabTl3cURkZk9CRjgyQktrVVNCRzVEdG1aUG5zK0QrMWZYQm9SdDFr?=
 =?utf-8?B?M3dPUUVoRjc4T3l1SkkwZU1qWEgwZWUvTVhhVG5vd1J6RmdPNkpvZzRnV2t0?=
 =?utf-8?B?ZW8yVlRobVJESHhNWklDUkdXVEF2dTdSMkhiWEVkZ3RDZWpQQnhEZU9zU2lt?=
 =?utf-8?B?NjZDeHlKSzVBWVJPbVF1b2lPY3RLdG5TM3J1V3U1aVZ4cHJ1cEVndThwVlR6?=
 =?utf-8?B?ZmR6WGtzRnBQT2xIZlRmNnNjTWNOV0F1TDYrUFZ0QkpIV2xpdCtjc25zWENy?=
 =?utf-8?B?M0lyWm1xYXBIdjQvSHE2bWNZcGhrNEhkWWZCb3FDVDF3V1dlRTlYeUxrZDg0?=
 =?utf-8?B?bjFrSW45MmJJYzFvSHJVYlp1T0dMOXcwWG1jeUdocnhFZE82bW13bjV5TjZH?=
 =?utf-8?B?enptaXJaM1lyZFdBVW81SnZKZUdRVWptVDYyNzVET1dZSGZ0eHFEZDJGU2Iv?=
 =?utf-8?B?UEd3RHZTMlF6Y01ZTTZOTjZaSGR0bkxuS054aHdjajJLSGt1cHRoZmxiVUxy?=
 =?utf-8?B?Z3lPTDVuQ1pRTUs4N2RnSTlMWEYwZmlESGNEZkg5SEFTb2NwZFNwOEo4ZlRi?=
 =?utf-8?B?bkk0QlBGTU1CWDRRdFJkRDNGY0pXclhhM21oZEF6cWtMdVVXeVZqUmxMRmRw?=
 =?utf-8?B?d0pKMGU2Z2ZxS2JpM3YvbUpXVENOTFlQTTdhR1o5bi9Rd1Flc3VHZy9uWVdZ?=
 =?utf-8?B?OUc2QThlSXk2bVIvYmNCRWhMM0huM3BBU05aRHAza1p3ZTduZWVtUFF5aWFY?=
 =?utf-8?B?QWMvUVI4UmlXREdEaVcxMWRDSmVudFQ4OWZlTkJiVm84eW5YbnpMUVN2QnJu?=
 =?utf-8?B?dEY4aTZuMytrNGpxTnRBbHFqTzk2TGd4cGo4K01KelB1cmRqNzlPNUw2aVE0?=
 =?utf-8?B?QityTG0wVDd4TkZlaW00NGVBVEt6OTdwUnJCbkNGSlJZSlZnY2xNM0o3Yk9v?=
 =?utf-8?B?cjFwbjNnWUNjL0NhN0NLK1JGYWdmKzZQK0J6eEtKeERocGZiK2wrWUNyWDN2?=
 =?utf-8?B?MCtMR0t1dnR0NldSRFBDemNZOVdUY2JNWG9wbmtnS0xhR0x3Q0hJL3BCWG9l?=
 =?utf-8?B?dGJibHF0SnR0TWE2SWJZRCtSUVFhbXpOYjFwQ05EUnNQeTRhZHVmNDVyc08y?=
 =?utf-8?B?enU4cHh5dE80L2pMdWtyQ2Zhb1VKNytYU3Z4WS9IL2NySVdHSG8yWDFZaGw4?=
 =?utf-8?B?bkZCV1VkU2FSSkh3bWF3M1ZXM3BUU1dodVVmTlBYTWdtYzlPYzcrSUxuZkpK?=
 =?utf-8?B?d2dRSmZNSnR2VXFocWgxN0lnVExjRFNLU3ZPdjdYNzI2Ri9IdFpMUVFWeld3?=
 =?utf-8?B?NFJxSUp4Q0R6ZVM1R1plN1loaTZkV1ZVTmxFSzJvSTZJaXFBRTM3ZS85L24v?=
 =?utf-8?B?Wjlpc1R4R1kyV3g3SlhzRUozWG9kY04rMHhhNFRReFJ2d2hIT0NBRjZ4eWNi?=
 =?utf-8?B?VU1lY2UvbElMRlhSWjg0Y05vRXBJYjEvVEVDd1AzKzVnd2NveEgzZEJLcDUy?=
 =?utf-8?B?czN1amtUVGlBQ3h6dFlTNFloVUcwVFBuWFU0SWlvT0g0RUhqTGc2Z3dlN25x?=
 =?utf-8?B?NFE0MjNNa3lSWk9vMXdLeFp4cDQrbU9pd1hlZzFMNG84aXJpTTI4M1BwbUM5?=
 =?utf-8?B?bzI4WE9QZWowdFpENmtpLzFBUjlLNTRPTkZhTFZ3NXpqR254aTVTUVBYcnBM?=
 =?utf-8?B?N216Z01JVFptMWFKL2owUTF5SDNITDc3L0x0ZGFTVStxUUVNMXBnU29GRXN4?=
 =?utf-8?B?c2lqaEJXYkUxallIbTJ5Wi9mYmxYSmE2eUNHa0RJWmUza3RzeFEwQlNvODk0?=
 =?utf-8?B?eEM0TUpSVmhXRVlTTjNVLzlJSk1HYmVTc1VmeWpEcGtqTUdmQ2tjYnZpRzU1?=
 =?utf-8?B?K2R1UVlRbHRBNFp6aXZrVUpvUXdERGNhUGdORVgxY0VZdyt2d1oxeGJyRk1o?=
 =?utf-8?Q?qUEzcuIkS0PyKfbMVs55sQ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG9uRldMN2dkbFVLRUw4RG5yaTZCWUdUWXBnWWhEb05pazkveENMZyttWTFB?=
 =?utf-8?B?SlltdFByc0hCb2FuYmk3Y3VhUEFpSDdnTnNLay9qUzV5UjJaeDl0WXdleHNI?=
 =?utf-8?B?cE81R21UM1B4UHEzQnlxdjNtVDFQNzQ3VnJENkZ6bkEzd3FkajRYYUM5OHdp?=
 =?utf-8?B?OXBJUDliZnhvZ1FEVWp3dklDd2dqZ0owZUxOcVFaMEFzZHJNdDJYVEEzUVBZ?=
 =?utf-8?B?RkxrdC83UTNpck1pelAzSUlvZlV0NW4vZDJDcWMwcm9EYlZrRTEvQzVlaXBq?=
 =?utf-8?B?N25JNjFLbkl6eG1VY0hFWWhRQmpxaUliTDZBSjZUTEc0T29UY29SdEZ1aHM3?=
 =?utf-8?B?NGdYbTg2aUNhOHpDcEZxZC9VcHh4UkdjVVlkR1FPMThCYnBmdUdoK0dYYlF6?=
 =?utf-8?B?RGM1aXA5bXBub0dVU25idE5ycnNvZ2dEdzg1ZVp3RlFaTFhleSs1OW1GWWxN?=
 =?utf-8?B?c0orNnR4NWJqT1YxNDdzSktTOEJwQnJmMTBIU1FReng4OC9CODdvbFdCOUhN?=
 =?utf-8?B?YmkwcG5yaXhNZmV0Z24wVXhvWGM5TVpUaWpCZkNEY3Z2ME0zc1lsOVVQSFp0?=
 =?utf-8?B?WWZIK0FuQzFxZzJ0Y1lwLzhTOUM4Y0RIR093Y1J0T2NLZyt6MmJMekZJZTVJ?=
 =?utf-8?B?RGNKblJXU3pZaWtDVEQrcldxbnBQRUF1QXlveURSdVowYWxjbDJrLzZsU3oz?=
 =?utf-8?B?cjRTd2xFQXI5d2VHQmFNWDJaTWpqMGNlaHRPMHBqSVI5VG5WMUxFeHVEZUlP?=
 =?utf-8?B?c0dlOGp4S0lRckNWZ0cxTUpJNFVzZzRScmRXbmdab0E5aDlUelBvL1p6dVo1?=
 =?utf-8?B?RVM0cXA1c252cUNvOGFsRDRhb254UTl6WE12SE9NM0NjdDA0eWoyUWVpT3Rq?=
 =?utf-8?B?UmZ3Qmt3anRvd3BCa2FWVXhKa3hQSXJrWkVRTm1yUS9SL25uc3FBS0JaQmsv?=
 =?utf-8?B?NmVXMXlwRmdQa3pMRUtIUTVwaFJhWHA5Z3V2RnBpbmZNbGhLY1lkQmgzWUdO?=
 =?utf-8?B?QTlGM3NVZE9menhuOHRvTldSR2VnNmZQV2J6T1FrQ0JVRDByWkd2ZDBueU5H?=
 =?utf-8?B?aWJVNUlXM1dpNC9Fcm1FeDRMSnUzbXlqS3BBNEYxOFNFeG1MbHo2UnU0UjJx?=
 =?utf-8?B?amVMMjdMangwemxxSkpHcVlFR1pLSG5Kc0d2VmR4NEtzeDk3eDA0TGcxbTNF?=
 =?utf-8?B?L3c2TWNwMFlHRk8wQnlmZzlyUDRvQ2JSVlhpb0pvaGlHYTFEZVg2RExvM3ZX?=
 =?utf-8?B?OTlkWDNaSkR2dFNZb0JYYStmT2lGV05aeUhFL010cTMxaGgzVW9DUms1MHdt?=
 =?utf-8?B?VWo1VmlkTW4xSDNSSDJ0K1h1enJYbXlsbmMxWnNkN3owUFB5TEhVQTdXWlc3?=
 =?utf-8?B?UFBaUWxHc29CN2FzQnk4SVpxME5iSjVYeUMzR05GQkRuc0ljR3Y4eFBWNjB4?=
 =?utf-8?B?VlRldi9TWkdXcDd1MXpaL1R1dk5McE1rMkdXalRWY2dReTRaRi96bXRIejJv?=
 =?utf-8?B?c1cxUnN3ajRsZEh6UmRSQmNucXo1cDhTVVovNXU0Wjk4T1F1WDh3alAxcTh0?=
 =?utf-8?B?Vlc3LzF1UUZLQXNEem1PUE91eExRSVFoWDUwL1BxZEx0RzFvL1FSRXNSZFB3?=
 =?utf-8?B?NWxQRjVXdDdmenR4SEdUWWxDbkF2eDFUcFJjWVJXN24wVnhzZ0NVNFJDNW1s?=
 =?utf-8?B?YW0xakN3alFFZFIzeklNNkFBRFlyZlBuQk45VUV1WWFHamJCYW0vc25kOFpp?=
 =?utf-8?B?aWgwSmlENHAra1ZlUXNBUHk1TklPNXVjcWJEbVh1SzBJS3BkL2FlVjk1azBI?=
 =?utf-8?B?eDAyMnpwTzZTMUNTcWRzdU0rSDkrZXlEKzRsOFVwU2ZXZzFDc3VxWVhxcjc3?=
 =?utf-8?B?VWVLNCt6Kzl6N0UwUDkveVV5cWVpMUJ2UlNEQlVGWjk4ZmRRdnQ2clJuamw4?=
 =?utf-8?B?K0U4NVBJWEl4NGNRY0xQUFRJRU9mdmZ6VE94U0NPb1lwZFV0b25vQjBFbUhl?=
 =?utf-8?B?bXIxbUEwUWhEakY2OFR1WmlKend3VTN5c1J3Mnd2QW80bDdUTStxVUpoeDdR?=
 =?utf-8?B?cVNYR1RNY3hEUk1xVU9yRlJvcnQ1cXRlWW9ZZ1owYjlHZ05KR1ZWWHJrY0Y0?=
 =?utf-8?B?VWZhMlJjY1RzL2JrWHNOVWdCWjJ6SEVwWGk5NHVRVjhOZ1A4L21GcERpMDcr?=
 =?utf-8?B?ZWR1cllCRy82ejZhOWdZWHJTSWpCYTY2Tis2VHc0dml6VjZvblJWL2psOVhp?=
 =?utf-8?B?Nnh2TkxMai9tbHg0QUJnaDRQN00xUmcwMnJ1Mm5qejBuYzNESDRhNjVWQ25J?=
 =?utf-8?B?ditYa2VHdTNhZVNVK0ZkUmpySU8xNDdDeUJTNXZzcmRlMVJ5VlN1QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7c987a-d3b9-4a84-0d5e-08de5f1a5d5a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:57.4978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arpKi5nC24ItNgwYNWjQHwmjlj/VWP+hySXYPAvEe8nqf3ELVyMKpwbzaPdQDDCNUSNdAMhKCLe0mE3A68I7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

Reusing IMX_BOOT_IMAGE_GUID from i.MX93 EVK is wrong. The ID is per
board, so regenerate one using uuidgen.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx93_frdm/imx93_frdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/nxp/imx93_frdm/imx93_frdm.c b/board/nxp/imx93_frdm/imx93_frdm.c
index d97720795d6..fb78a9bd036 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.c
+++ b/board/nxp/imx93_frdm/imx93_frdm.c
@@ -16,8 +16,8 @@
 
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
-	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \
-		 0x2a, 0x44, 0x8e, 0xda, 0x6f, 0x21)
+	EFI_GUID(0x6f86db61, 0xcda9, 0x489a, 0xbd, 0x36, \
+		 0x2f, 0x7c, 0x65, 0x1c, 0xa6, 0x5d)
 
 struct efi_fw_image fw_images[] = {
 	{

-- 
2.51.0

