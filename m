Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F75C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 09:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EDA82CCE;
	Thu, 19 Jun 2025 11:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tf5Zwnqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D8A82CBB; Thu, 19 Jun 2025 11:13:17 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4395E82B18
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 11:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2aoIH/7WGmhzGTrNrf255mczi/I2H+VkbcKe+t/uXFjt6IcaWkRum50VzPUzC6gY2HEo7mLQgSNqABTguMVuMbudqfHBFuYAhnqXtLfAHLnLqS8SEQka16OHca1ARPsGp9Pln1UrPDPKuiN75xxr/K9g8QXk9hzWjrYt4f3Lf4Ew+ugtYnCgNjg2FqmPm0yYCYU5p0MSQkiRRnTY2bvOFVHI99WmiQvtUf4G/qvCsbphLFMmXBshXC9Im/QYxYdD4xNDmn+CavLvzQt6aAkQxN0Aa0QR0nsIDrIvhQONFIMY0W6NXz3p8mL7fFqGOK3LFIIWT4niBWpQl67xdegNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9SFXt1PkDH8UdNC24NFQx/FV7oU5r0yoXgq08Cw/Zk=;
 b=g8h4UBErp55VMgudBJlJwM88TREdD9AMym8p3zWnYAIEEGkFaxUHzSEnlZECtR0vCu9Hgq7UR5TnoXG7GhVny4TgQk1YMujLuR2LHUdCqrPQn1D+3ueJzpdw7BWc3bzOYk7e7+b3aDZNGrghH9GXaRNHUHSyQ86Cn1Oa+9UOl3DBthgtPixMoPGq+b5w2QFcyos5rQPId8HPenR91gMgIZQEft1zdThX7M2F6v39eDzkM0/urYBRS5BJNIWkcMC0usrLLh51nrGSgxIjGn3xYz+3Y37IGlP8mlqTnVqr3Nen9Gqw0KqtOKXHBo/5iO0SS2jj0TdDqkSZtIk0RrMqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9SFXt1PkDH8UdNC24NFQx/FV7oU5r0yoXgq08Cw/Zk=;
 b=tf5ZwnqhYgNpyW31P8+gsA2ptgFr5GI1SDYN4Bjf5Hgoh/YNqjBbj4jlmQp6Aq5B8QhVmje+MtFDhywpOIJerXROifESmIAhsn1QZ/8FFIBFO/9bYAOCHY/tsS0ArBpORH1JQ8t2yvPjI7BEAz8g2wIEYau5AeSdrxeyLnfNflF6RB3590fZK+Nukl9JK5VZv51mo8rJOiumcOFMgx7tSzdDmMwMQovjtc1z/eN/nOPBiITN/9o1NhLIKeJp8LxmafB+xcLFQnwj9RY4imPfU8TyPI4EwtXegNlhCbhV5mhypSrdqSDggJd76qWkSq2tBRYpMUxZN9M4hSgU+FY9AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10888.eurprd04.prod.outlook.com (2603:10a6:10:585::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 09:13:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 09:13:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/5] imx: Support capsule update
Date: Thu, 19 Jun 2025 18:23:34 +0800
Message-Id: <20250619-sr-v1-0-631100a113a5@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACblU2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Mj3eIiXePEVIPkJMPk5BSDVCWgwoKi1LTMCrAh0bG1tQAxiRS8VAA
 AAA==
X-Change-ID: 20250612-sr-3ae0cb1ccd0e
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: ae93f9e8-ec52-4f37-83fe-08ddaf118404
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3I1aW5maFZkZzRFdE82SFFtTXY2Z1JJZUJ5emFhVHpXRmEzdU90Y2EwcUdh?=
 =?utf-8?B?djVoRzJ0TUJSUE1TZnNRSVF6UXZJY0ZJVEEyVEJmUlVub29MZDJsY3ByUHhC?=
 =?utf-8?B?YzNpTmJoZmFKbnVTUG9OWmxiNVB6M0p1Q3k5YWJqem41L2t4OFo1QUVicVFZ?=
 =?utf-8?B?bGV5TGFIK21WU0I2SVhDYmsxaGxmVHJVU1JNNVBTdk9GK0x4bU1hd1Z4RGxC?=
 =?utf-8?B?em04N0VhT09RN1c2R0VpQWIybDg5ZytzWDJBaWVRVVRGdFp6ZWVnMXpIMXZO?=
 =?utf-8?B?akxnaEx3QXMyNGdaeG5LMzFtTVVjWEpqRnJYdzB4ZGxHd3gvZng2aGk4U3lh?=
 =?utf-8?B?d0lqeng4UHEvOXVzb1pySmJ2MkRiZTg0dGZuVlZwVEpqaFhUTlB5eDB1V0E1?=
 =?utf-8?B?ODFQOHN6TkZ1YldmR3h2ZEJxUkN4R0NMVkxvVk5XQ0VCMnJrS3JLK0N3clVz?=
 =?utf-8?B?RnFFYWVibnRLbm1EbHdURjlTM2I4RHpRZ0Y5UEZCYVlXb3FKbEtxb1RXbUJT?=
 =?utf-8?B?SGZHUlU5cjMyRGZFSjROMFVoVytMMGkxTXVkcGE1aTJEWEVkanhtVDZHU245?=
 =?utf-8?B?bGlOZ093QlJiTU9UNllxSzJ3Yjlzdi8rejkzcy9IbmFEU09jNjlvVyt1dlJW?=
 =?utf-8?B?TDdzVlRVTWIzVjhyUmpLQm5qdkxnemFFSUxHMTIwRFRMckczZ3d5WTNZdGJY?=
 =?utf-8?B?WStzZEdJWk10MWZxalFBS1V3a3lGam04QzZtT2NKSTFXRGtiY0hDNlhOTGha?=
 =?utf-8?B?K1gzS2hBV0tNRmpyaTNVbGlseG5xYU9paytYMFlEU2FFRC9aS0xGNkxCdjMx?=
 =?utf-8?B?WDJ1Z0NZTU1YaTdQVzVSOE9ZM3l1MlVTYVdJR3d2VklYRFk2UE8wMVJjSUQr?=
 =?utf-8?B?ckVUblNxemR6Ukg5MEgxRXEzNS9ZOENsVHRzNys5Rk9GbXh6VjlGeUNzQVpY?=
 =?utf-8?B?aVdaNTlaSS9sZVFkUHl0cGxGL1JSZ0ttZ3FsMTBDWnkzQ0kwTkFxVEt0Y2Y4?=
 =?utf-8?B?Z3dURzk4d2J1MHNzNFVyVGYycjZ6dnZBNVJZT3dHQVRJY1dnVE9tNy8wdERR?=
 =?utf-8?B?WEk4TFdNZzR0VG5yY1lodjVEWUZzTnRyKzdPK1hYUTFwMEpaYnpoNE14bllT?=
 =?utf-8?B?RG5MVXlkQXZrUHliL3lIZEowUmdEK3VQT2N2d2VuV1RnL1YxdzNKYlNCT3Vq?=
 =?utf-8?B?QnNvVXFPWTRpYWY0Zkk1UGZjNU9KVHFzcmVoNlExTEZaOHRSSnZHN3VHYmh5?=
 =?utf-8?B?STRUR2cvSDd5cnpPZHZhWTJTb0cyQUVqUjRub2ZySy9zSG5VWEdOdlVXUGM4?=
 =?utf-8?B?NmRVazJZME9zcmc1K0lwNXA2TFovV2ttWGlLOFdHL1UzMlVlblFQVmNBa21v?=
 =?utf-8?B?TVFsTVlTT2JrYVV4RFFlaEF4aEJYWlB4WS9jd2tybFV2Sm5tZlJiblAvQmpV?=
 =?utf-8?B?SEwvUWdmbHg3QXZlaFV6SEhNeVRVVUVtd2R2YkV4aCtQT0VrdVlkVG1tZS9H?=
 =?utf-8?B?NUNnd1ZKeTNET2tWTGIzeXJkbnV6NWJKbmpoTjdQdVljZlJpaGRnZzZqWG42?=
 =?utf-8?B?TVdWNXRnalc3TDF5TzR6L3NESnlza0tLY0U5UmwzZ2hWU1hnaVoxcmFCbmp6?=
 =?utf-8?B?SXVGWnJxQTh6eWFqTEg5OUVkNTY3QkJkOVlzeVZDUFJ2Mm5vZjIxU015KzF2?=
 =?utf-8?B?Q2JBTiswUklZZDB0ZTFBMkk1bDV0WTZUd0JoL09KeDhiUjF3Nm5DRzRpaXVU?=
 =?utf-8?B?SjBFWHZtblFjWVU3OHBacWxWMTRXOWJuWXo2clVXR2ZuQmZ0ZDlzS0ZQb0Ru?=
 =?utf-8?B?VkFPS1M1MThXbHJIcWVBUk0xWW1QbWp3R2NpTS9QMndDd2hWb0s5Sm85UTVp?=
 =?utf-8?B?WFllRk5MSGR1QzljYmpXa21iRzFCQVZKeVMxcS9JN2QzTkdiNmkvYkN1YUFW?=
 =?utf-8?B?YjVsVmJEYXBYdTQyNkpENm8yTzBrWUQwKzRaSCtaMzlTMFA4TlQ3Z1U0NFVN?=
 =?utf-8?B?bEdTSWs3V2ZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cys3NEZzNzA5TU51Q2JHUm43elE1L0pScUJKVGNOTmNCeG1YRVZPencxdkRP?=
 =?utf-8?B?L1dnZmozdlRHN2p2L21ZMko0MVA4SUpGZnRRaXhxYkNlSmdCRnVFSU4wT3hi?=
 =?utf-8?B?Y2dXaWhCVEc4SC92dHhQeUZTUVp5WUVGTWU1L2tjc3EzNjNiMzgxVGV1S0NO?=
 =?utf-8?B?L3FJMmtMSElHcTFBNS9tYlZJbGMwWEo4eDV1Y3ZHWUJnR0JNR2lha1p6WnBl?=
 =?utf-8?B?Rkw2eGMyR2NrVlIxYitlRG0rVXJKMFdyZ2NjTVZnM1hFQVlnSXlzbUdXNTQ1?=
 =?utf-8?B?SE9PZFA4MWxBZUZBMFoyN2ZtVVVjVzBtTTM3UW9WR3ptWkZYM1lTSHBrRk53?=
 =?utf-8?B?REdQcTJnZ0wxcllGYzR0dXRLb1ZkVnZ1cnB3ZHhHbEQwV2VxRUZyOSt5Nk1D?=
 =?utf-8?B?OEJ1WjRPSkJmNzZFR3BYbHBiWHQ4SnhjbWlQeW9MRTZxdy9qREJaNGlOOXVx?=
 =?utf-8?B?REE0S2s0QWI2MUpHbHpoVXhLZmMzbUtjZXU1bWQyN0txUnhoeDN4OHRpdkI2?=
 =?utf-8?B?UUI2dzZGcE9hTWx4RlErQmV1ekJnYW5KVDYyNzBEcHMzL2NhTUNncEJsN3Jj?=
 =?utf-8?B?dWptZFZiaG9DbW9PbndCd0lsQUdlbTFGcGZvR3lML3hhOUdaUWpidXdjKzgv?=
 =?utf-8?B?ZkpQb3ZKNnZUM1Q0d2dxcmxTNWJTN0RiWGNTRDdGelJTS1k5RmxHdEFjS0gr?=
 =?utf-8?B?bXBsOGxzcm1JVXErMjBmQy90aHJpbFNwS0laSlVjSmRUR0ltRHhFbGF0OHc2?=
 =?utf-8?B?TXVVVzhrVGpwUmlkK20yam5JUkNYNjZPSmxrVnRHdzNOL2pjV3hMVDdPTldj?=
 =?utf-8?B?NmowSDIvSzc1aEh2WGVqZ3ROQ2xzR29Odng2Tm5yRml3M1pKcUNnWkFyN0hh?=
 =?utf-8?B?Tm9CQXVVOE4xSFpIMi9yZ3dYbldmSWcwSkFab3MxdEc3N0lqMTRCVTU5czl4?=
 =?utf-8?B?engybXh4d3cyZmNYRllMaWhCSWpzMkErOHZMZnNyY25GYTY2TUxSejZ6ejNy?=
 =?utf-8?B?OGExT0lIY3JLM096MUJGb2VpMTNDZWNPWXNlUHFaYXViOGh1d3VIdlZnQ2Z6?=
 =?utf-8?B?dVRzcGxtcUFnUzdNN2NGR2dOWEJNSzhvR09ENkhqaWhUMjNWcUl5UWlkZTVM?=
 =?utf-8?B?NENwTTdvSU9ETHFhNXZsQ3h3SzNlL0VSWG9VM2l1Q25FNEo3V1ZxUitPVVE2?=
 =?utf-8?B?Z2VPbXJDeVc2aTdsNTg1R2pwTWFodis0U1ZJM2lkRERydVNsMUhrUWpFSnly?=
 =?utf-8?B?azlmNFU2QzFxRXZYTFBLVDZkRlZnbVlkemVwOUNTbmhtTUhhc1ZlSHN5OFIw?=
 =?utf-8?B?WW9lQjk5VnJ5ZG1HYWt0UTNJdytQOEsrN3RKVmhobENwclpOY2o4SzdqNDE1?=
 =?utf-8?B?OUxBdlhkendQSktud3J3NWJNQ1N1L1hrRFBoV3JKSTBLUUtTdXprWmtsMk5X?=
 =?utf-8?B?RDRHSDZpTldzUnA0a25LVnRhMjJGQ3NHTDdWWkxqU1MvNGxzdEFGOUE1aE53?=
 =?utf-8?B?eHFSTXdFZGtwck4weSt6elJGcmlFdC9uWnRYSHBwTVNza3NTK3ZFb1crKzcy?=
 =?utf-8?B?eHBROUdzNlpDMlA2blFJRzJMNDQrRVUvdjFpVkI2YVloTkpZbGpCUlJWN1hu?=
 =?utf-8?B?WE5CRU0wTDFqMll2NUlRd2RRamErbzlZb0Y5dnlnTGpkS3JOUUFVY3lFL3My?=
 =?utf-8?B?NlhsSFlPYlZkUXBJNXhSa1lkTDU4KzkveVlhMmk1SjNyL1RpbC9OV25pdFVz?=
 =?utf-8?B?REZrTWUwcGtHQ2s5cUhHQVROK2JqcU1Ld1p1R2hGTy85ekNKQnlTTHBXTDBM?=
 =?utf-8?B?M0R4T0pOcXhFVitKWDlEWEYwaWxUUjdKZzAzTm5ycGZGaDRvc29hcjVlaFRy?=
 =?utf-8?B?UVJCMXltWG5hcndhSmphNS9jRFd4dk9oUHEyMzF6a0Q2OERYNkVPZGE1dnRv?=
 =?utf-8?B?dUkxTHV1WlBCY0IvNURIZEpPTTRoOW1BOGVTUk1ncW5VSkVqSUJBTTh1d1NW?=
 =?utf-8?B?NzdyVzlSMnpWdDMzbHZjMkZ5OUE4RUVPREluTFhaWm8yeW14d2hmVTBnRDNw?=
 =?utf-8?B?b3V4UmFnWmRncWNXQnMydGZubk1QQ2NVeXErMUEvWVlLdTh4YnFRRi85TjhO?=
 =?utf-8?Q?E55/AuAaV/J32lYJnKFW7fS6z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae93f9e8-ec52-4f37-83fe-08ddaf118404
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:13:12.3125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQeBWqtYFIy5g6TNCwLSZop5BDxPhG/WyMqseOTg17oEWoI0Rl8oQ1ly9SzSk58feG+Txvm7vdJtPOLE5LqDWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10888
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

Support capsule update for i.MX8M-EVK and i.MX93-11x11-EVK.
Currently tested on i.MX8MM/N/P-EVK and i.MX93-11x11-EVK.
Capsule authentication not enabled as of now, this is on TODO list.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (5):
      imx8mp: evk: Add support for capsule update
      imx8mm: evk: Add support for capsule update
      imx8mn: evk: Add support for capsule update
      imx93: evk: Add support for capsule update
      imx8mq: evk: Add support for capsule update

 board/freescale/imx8mm_evk/imx8mm_evk.c | 22 ++++++++++++++++++++++
 board/freescale/imx8mn_evk/imx8mn_evk.c | 22 ++++++++++++++++++++++
 board/freescale/imx8mp_evk/imx8mp_evk.c | 23 +++++++++++++++++++++++
 board/freescale/imx8mq_evk/imx8mq_evk.c | 21 +++++++++++++++++++++
 board/freescale/imx93_evk/imx93_evk.c   | 21 +++++++++++++++++++++
 configs/imx8mm_evk_defconfig            | 19 +++++++++++++++++++
 configs/imx8mn_evk_defconfig            | 23 +++++++++++++++++++++++
 configs/imx8mp_evk_defconfig            | 15 +++++++++++++++
 configs/imx8mq_evk_defconfig            | 13 +++++++++++++
 configs/imx93_11x11_evk_defconfig       | 14 ++++++++++++++
 10 files changed, 193 insertions(+)
---
base-commit: a239cdc0bd4bfe5fce82368627fc55a5fa632e3a
change-id: 20250612-sr-3ae0cb1ccd0e

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

