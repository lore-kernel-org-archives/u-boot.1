Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630D4E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B8D80447;
	Fri,  3 Jan 2025 07:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Biy719oN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D170280447; Fri,  3 Jan 2025 07:46:30 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEBFB80584
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8v4kziWJNgoaMkzjBvjuR5EvW4JNApBnSUJXYt3gcJhyhVZM9LltKrQ0wWs3gztvr372axiGF8TJKJRUoz6ZpRplK/xYESg73HT2Z74XXRP5m8WIVdjfRVG+pQ2v+NQZTjKDmkDp1qHfYW2tTv7uESLMrJHNGrmzJ6Ql21MlNhjr4fGcgsGOWpRTxRdQrIOCi9qfvjfvLDjwEk/k57R9yWkmEAvA9VS7NQwPoOXDBnT8QZLTFBGRfRNLA5cXP+4d8TRS+f9P6pI/SU02ITi0RQKLZuyQNughiRrjwaGCHwVZz316uKkowenbHmE2/T8R3i6CmfBUQXhvpkXZCp8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+SshC//O2KgQppU+e/3G5MR+J3uebQ5bSQk9mMigR4=;
 b=I5Mc9l5iy64oWGVirrZOeMRs/zdOTfWTKCedrWpIoEigqOuCl4NYSC+mMd4W8jTQujwRI2YwbiL+9uhQz4S4ph0L7d2ugirXgszn8WItQ8wWYGHU+8VvSpf+DaNL07p16VKvwjjplw/VQZVA9v7lbrrRrIjBcmVII7nK7hdNrJ9aLQPVEhvOigtJ3CSTLSXfXDcMfGup7tRyHIiEoR84EBL9LfCzJcOPjOI4ICZtAeeqWljPyAcGgDzqPmlGLS1TsLAd36IpSwbya2IiXvbWjJU+g5PqXnMAYmHPXtDt4DXKb1HB3IPBy7gDweYZupDmtON9+NuvSV0p5/iiq5K25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+SshC//O2KgQppU+e/3G5MR+J3uebQ5bSQk9mMigR4=;
 b=Biy719oNdPCwUOilknh+N4+Lzi+mtrVyU0xAnCbO1BbzrV7lyK455LV5B869X9VYvNMFeAqLV+4mfGBhZmyWMz+ur5eOETKTVLQjbcEwSlJHVg/6JCaYCUSyLmD0Vj71lo/Bsr3dUJMf4Uk9X6l24xrM8NJMuV0+EmlACs3ldqtRwt4H0rVmDet2ZXNNDaYyDJT+aTWg0wM3lhPRISXqc6j8HMtxOfqOz9JBktXrLk6cer6pEjUyA3ocDbXHuylnpNzEA9IAJpIIld7erLhxsACL5De9FZR75P9f9j8Mg5sOKaXN9cXswep9HnK/2ybg1IeRcK6zopHQWGiFU+/e+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:21 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:43 +0800
Subject: [PATCH v3 08/17] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-8-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=1122;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=HRRzAfMPwiG7DveKXwQ+yoWXXYk1m3p+yIzjFi+h25Y=;
 b=UF0h/960jOVgyV/35ILpaJIfvbfZMd9j9AL6TIE4l9bh1Jd0TBr9IUiYclKunN4uRDjpmdfkV
 o+zaM1fQcO2BWnQyKqCZ58Pz7r0nf/RnThLvrL2NTt1nJkjfQ6/TFsT
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7a9d75-f607-4f11-a082-08dd2bc255aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFRmaE9obEQ1ZnFqck8xZXNpQWtIZkZOS3hlNHdyY2xabDNaTVVYbXFCNDJp?=
 =?utf-8?B?dzRCczhvZDBxTUhqcDR3RGtNbCs0YXN4ZS9rbUlSRnN2TkplRDA5cnBBYnQx?=
 =?utf-8?B?OVZSWU8vdXZuOFhvRzNSQW5Ob1ZyZWFqd2p2NFc5ZU5xTWVPS05LSGc2Rmlp?=
 =?utf-8?B?bGEwdFMrei9veVdsOFBPNGovY0tPOHdYSUNwR0g0ZHJsMUNoeXhwaUgyTTh6?=
 =?utf-8?B?TkdHU3RZL0M4WFlJN0Q5WndUOFBHYm1PSTlqdUhrczhKNmN4UG52RmpEVE1I?=
 =?utf-8?B?anFwTkZ3TlR1YmxLaUhrUENaU0tYTWYwSEk1V1R0SlNRMUxPVUFLVjdPZEVs?=
 =?utf-8?B?Y0REdGp3emFMaE0rODNSaWUvdzY2dnhnRVdld2pRcVh2NkRuL1FtL0R5WVNl?=
 =?utf-8?B?MC81T2Q5UFMzL1VXTER6OTFBcmpEVTcrOXJrVWU1MkkzZnlCUzFvU3RHdlFy?=
 =?utf-8?B?RDA4MEVQc0RFY3l4ejA3S1RqQnRJVjEvSGw4a0hibjRHdFZ0QWMzVkxXWS9B?=
 =?utf-8?B?MjVXQWVsZHpPMWpNQW9NR3J6T282K1pHeE56T084UGtDY3pDVVJzY01nSHdJ?=
 =?utf-8?B?dVBXU1BaVWJuc3Z1cjZHS3JVZk9ibFl1azN3RE1jR1ZJR0FZSklLQ1BqUStK?=
 =?utf-8?B?MGNtYU9wSWpGQkhPTTkwam9ldnpIcUd5UXNVUDdXSzRZeFIyaG82Y3RYTGZ0?=
 =?utf-8?B?SFZNM0JOQUtyQmMySG5ZaHVBaFJ3cENFUWh6YVhYM0FNSjFrNmZzRHdBeWcv?=
 =?utf-8?B?dVdYSnhpbUtpd2MxVlJ5Si9DcEVrUTJkUW9tQ2xaVEVsVHFKSnViR1hDOEt4?=
 =?utf-8?B?dmZCaGI0aGFYdGhvVitEdW1HVVlJdFliRVZTakJBUjI3cDgveEh0MWNJWDdm?=
 =?utf-8?B?d2F0aTVnMTk4WHF1K3JJQ2h3MllpTEkzQ1lQZXZCbzFBSHVmTWdTRXFNdG1T?=
 =?utf-8?B?ZlY3M3QySysvTmdvd0NOQ1NXRGpWTTlHTVlCM3lqYjNIaWt6czEzbktIZFU5?=
 =?utf-8?B?UHoyYXJuejJQZytQRVlURlJQMW1QNFdWMlNYbi91bzlxa0pNZjBmWi9FUkx4?=
 =?utf-8?B?YlhDeDd5SHZTSzhIUVNteEo3ZXBub1lLeWJqNlpXS1VMa2dZTGttSlVRNURS?=
 =?utf-8?B?TmdYWkRLNGdSblVrLzc5MWVFVnNudG13YUhUalRySjkrUldaT2YwNnhITmMz?=
 =?utf-8?B?cjV0b3RjdjI5SmdvWVlmYkdONjBnTzdna3UvRzhrdmdDcWQ0ZkhVdlVuSnlk?=
 =?utf-8?B?VlIyWis5YXdTRHNjcUN6cjBMaXUrUEVxMGUybEFjd3p3TTloR2MvOStaY3Zy?=
 =?utf-8?B?ZlNTMHlrVnBzcnR1bGRpMW92TGxJRmpNZVNKS2toa2Uyd0loQWN3dUtld0ti?=
 =?utf-8?B?N0g5a1RuZTdoZ28rK3RUSHU2THNrc0hyVDFIbnZ0d0c5TmtEYSttK1VlSUYr?=
 =?utf-8?B?Zm9aWmxQS2NZL2htOFQ0bVdSajI0YUtDdzhma20yM3NvZDJVT2krSjJYd2N0?=
 =?utf-8?B?Wi8rV2JSRHVmRXBPNlVJVjM1YUxJY1QvamIxVlRrMWRQRittS3FuQUQ5TzQ3?=
 =?utf-8?B?RmdQdTlsTGY1SFRnSFZ1bjBxUkJiR2toWCtoN2FJcjNaYzJKNEphZzhlSnFs?=
 =?utf-8?B?b09YUitia2twOXN0TzU5cyszdlo0amhUQkZhRkNCREdIa3BQNXhvM2FBRWhw?=
 =?utf-8?B?QWFwaTh3NDM4U2JDcThWMWFNMWN0UEdUYmNtM3VlQ0VsdUFIaDQ4K1NsQXJj?=
 =?utf-8?B?MlFNeDlPVlFHY3lNaHVxV0pRRU1BNWhKcm1yZklzamlkYk9kNElzVFJ3OS9L?=
 =?utf-8?B?eG4xVHdpZHozREF3dHQyZkQ3eXFBdEY2aXI4WEVZWTZOdWVvWWl0elYzRkRT?=
 =?utf-8?B?VUxhLzhNQzBRWWZ4aER6cUJSNVdGM0I2eXRCcGZIL3ZIcjYyUFVRYzZzRkhQ?=
 =?utf-8?Q?gBlwKuku032vDdT12xYzoqp8r8ggSRNs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUl2c2Z2andraVZWc0JOMVFDbStsNXBudXVsc2VQRUtqeWw4M09XdmY5K3ZF?=
 =?utf-8?B?QldwSjFXL1NaaTRkdmUyTlBwTHJYeVhKQUpKQlVGMXdsZWgwcFdKN1dIZ0M3?=
 =?utf-8?B?UmkxT2hGRnZlWTBIbm9Jek9wS0pQRk5iU0hoSFpXVkRqcW9lZVJLWEJySmZm?=
 =?utf-8?B?THR0Y2REWDA5TS9yaWlnYmcvN0dIUERpam1QNVRQeG1mWVd6RDE3STREWlN4?=
 =?utf-8?B?L1NRYjlXUHlxSlJKL3o1dEt3WjUxT1hMQ0RJNXE4QUM3NWZtaUZJRnRZVENI?=
 =?utf-8?B?L3FLSkp4WEh2akZJSFhNOGdON05NWWZ3SjJLblFmSTh5dVlicmVyQ0lPQlo0?=
 =?utf-8?B?RDJBU2tpT0lvdDF6K2xPUXJSd1U1UFJkbzZvYTlyV1h4Y1l1YlUvYlE0VTZa?=
 =?utf-8?B?QWFSb0xOT2w1WTRCMmgvenVNKzVOQktBK2VKczNFMzVZQjM2MFd6Y2Z1WGpR?=
 =?utf-8?B?TkY0Rmc0ckdmVHpXNWFCMDh6WjdsOGhTOUtib2hQN3U5dm1BcVhhMEVOUElz?=
 =?utf-8?B?OVVkQTJPN2g5VW1xVlJiMFZkRTEwcHNuUCtmUjBSNG9vQnlzOWhnVDU5bGt3?=
 =?utf-8?B?U1oyUnJtck1vdTI2UThxWTVoSkZqbElBWWkvU00xaFVYbTd0VVJYWTZpYWFv?=
 =?utf-8?B?MUljMEorTFRzVHk4N3AycURhZFlUUDBnTDZ4cmc0Vk5keUNHMlh6U0tqRjlj?=
 =?utf-8?B?NnV2SHRrL2VwdU9CNEZZZGNzYnZ1OGtFT3l5c1RmaXNySCsxdHg0a1R5OExy?=
 =?utf-8?B?eXFxZGtKcHZxRlZ6Z0lqZ3Y3WFNiaFlBUWtGT3ZUNHJVL0RWaU5sT3RiM0Yw?=
 =?utf-8?B?MStWTENIVG1BSk1DVXh6b3hWb1FTRkRCcnYxUnAvS1JGVW9DVlV5Yjd2OEZX?=
 =?utf-8?B?V1A5LzFpV3NZVWVScjVYcTdvcm1Qa3JYUFN2Zk9xWkhMRlRaTldvVTZScExZ?=
 =?utf-8?B?cUFrRUZuTlppS25QTUpNdWlabHNXc1ZWWUF4WEViZS9QaHp2RjEzQmhyZXky?=
 =?utf-8?B?b0JFbUFlTkYvODV2NnlybEppTkpjTm5zYjdEOWUzMVBLN3Z4dHM4elZJdm0r?=
 =?utf-8?B?SU9WNm9mNTdFTzBQcFlzbUkxSDlTeTJHeHdUcndkbGFoTjlNcm0wR2k2cWVR?=
 =?utf-8?B?S1NTQkRkWjNjeXdEZkhDem44YkEvbitTUEFsVjlacXNGU2k1VjBHYXEvemgr?=
 =?utf-8?B?THN0OGdsRnJVakVrN2E1Y00rSUpNZkxoNG9HTm1vWVlCUGtSMzBKSDhMcitu?=
 =?utf-8?B?eXpZc2RPSEN5NWdQMjl2Smg3U3NrbWUzWjlOUU9NbTJOaWxJWDVQUnJFUVgy?=
 =?utf-8?B?R0tNUGJ6bDBHdXRYaVdybS9HbVNNWjdicVZXdGhOSHZPY3FwZ2NEVXVPUU5K?=
 =?utf-8?B?T1E1MUZTZFFMclh0L2ZMNlZaRFFZZE01Z3lNdDFvVzA5cHp1N2Y4eXR5ZDZ0?=
 =?utf-8?B?d0xmSnpzTXdZSENvRmlBclAxaEc4Tjd5a1p4QmwrWlY4cmNpY1J3OUg2dFg5?=
 =?utf-8?B?Q1pLVU83RXkvTUhvNnBtLy8vYloyaWlRVTVPcm9tTllSd3JkM3NSVmN2Q01k?=
 =?utf-8?B?SC9Bd1hYdGkzM0NSVDZBSEZuYlhUQnYycDJoTUtWWnZuaytweGd1UUw5bitV?=
 =?utf-8?B?RlJnbW9XM2w3QUtzaWVQNzVyd3U3N1ZtR1JZdk1Ub1ZjU09OUDIwaG8vQXIx?=
 =?utf-8?B?UEFBMTlvWmNqOUVYNWVBaFA1VjlHUitmSEhSVUxFSFlzTTZTVVNTRVl6d2Nh?=
 =?utf-8?B?d2pPKzRHWHd4MSt6SWpiM0dpOTUwWFBlZ0RVVGZOV0tQNVVvOUxvNFo1K0Fv?=
 =?utf-8?B?WjNwYVRFQkk3bmdtRk5hZHJ0cjh1b2I1cmtNOG1IdGU0RlJBUVhvTitUSHpl?=
 =?utf-8?B?MWNNYkRkWHJLRWRiVy9LdTN1VzFNNGY1eFlZdnVPSTM5Y000STdrQkozcnJL?=
 =?utf-8?B?T1pCWFF5SzlpcmgxTFdOVGZrTGxNaFlWU2hoSjZUWXdEZmdja1pQcFBOU1o3?=
 =?utf-8?B?cDQzMUxYbThiYkN2RlhxaXNCTXVSb3JweEhqUnRRMG1IemE0QTJDQ0xFVm5k?=
 =?utf-8?B?QjlUVUt2c1VVZDFMVU5hdjVydytrVDVXcmdIV2Q5dkRSQ1N6RE00dWdQZnBl?=
 =?utf-8?Q?CbRgchN+EaRig2ONO2reLGTS2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7a9d75-f607-4f11-a082-08dd2bc255aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:21.8132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeyDRY9m0lFgcj/nDBx4bDttWY+EryNM/xSIqGPrVLwZyfDCFgNSahEG2xkyWJh8tN7kKP297113s04Z+X3Esg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
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

From: Ye Li <ye.li@nxp.com>

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. The number of elements of @protocols is
specified by callee-side. Currently, set it to 4 is enough for i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/scmi_protocols.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 9607433c3276f9aa18044c414a5bde3143726cf4..3c55d228cb641bc6c0e5ca7ac885efe84b41c66d 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -141,11 +141,14 @@ struct scmi_base_discover_impl_version_out {
  * @status:		SCMI command status
  * @num_protocols:	Number of SCMI protocols in @protocol
  * @protocols:		Array of packed SCMI protocol ID's
+ *
+ * The number of elements of @protocols is specified by callee-side. Currently,
+ * set it to 4 is enough for i.MX95.
  */
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[4];
 };
 
 /**

-- 
2.34.1

