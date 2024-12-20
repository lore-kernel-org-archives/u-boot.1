Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5093AE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 12:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8580280087;
	Fri, 20 Dec 2024 13:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AHXd+/LC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C203E8021A; Fri, 20 Dec 2024 13:07:01 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 548708007D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 13:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mdg8edeqUcmtNNgpi+77UFT5bLH8DMjCyVG9fjFrTRS9Kw03Cd6xXosPsQjrQvWHflCDGK0UKhWMRTxfzAaIdWuyb3bKvgUZtznS11cpM3jmmLeEbuIYZA7hKlKqAwjcPmJjSNopAO7Zs6ToB461M2wLS4CVMX5ihYwGsSEv4mUL6YqjR3HgtUrm73V03C6IXXrZgQCbacD144k8xiZwsv8pt8QLeIYWz8QKaeHaomuEZx8FbjgbAvrOzKIuV+caHupdGDNTrKLlFMNlyhPN5db1vH+uXmmhQZp2qVUvO8tNb3vCT2NMiLmA21L8UCtfHUdQXrUMfhKnged6N+NvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CKnld0T0+dFOPh6uCjMx1Fq/kJX/TN6ZwlyxfQ15lA=;
 b=ndJrMga1GNVwmj2lXAdlKZeX9rxBMM8e/B0IG7W2sEB8O9r927OhZ2m7sr0FhD1pNE8Cch9DtNWNeH46gi8PAGrmeGrdiDjvqHTtB5Ms2O6PWLuH31PNE2B4fu+WlxPsTE6OqiLN9JxWf4oHJR2aMqYVTK7M8hs6H3vWxigz2CHcNE7zYLThbyabv8+QIkbqGFz6Tt/4ts1ShCNJZM2HFeFu07EKxD+7XI5DgySC2QUBRe6KuB6CuwHesF5d0sX37JKoXlsnln6oT8LAcgsewGN8W/ki0V7rv5DfmxwMvNJhzStx9G3jQqWLtFp7N/IbMw84x46viEmhYEXWrqUQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CKnld0T0+dFOPh6uCjMx1Fq/kJX/TN6ZwlyxfQ15lA=;
 b=AHXd+/LC9HJ4xyQMyveODjIOk7VmfDUPCB6apEikelHZwo8R2oCF2bPvHtuklpiRHhajGuXLLjNKRGk4x5HwXsC7ThxD+4I5/ak4F3fkcMhHEn9LgtyZDTIDJbQ2oetHYQhz3g9u/T3b8Rzy6L7wetHBKpiktWOVUKqp8cRNBcQc2SElkbVwHwvbMmvSczE7gUnBsr1ksg8Rj2zv/IVddh5TT4kUIKrCI8sGyBxsN7TFe8Hgxy6woAD55S8zIlsOGA5GBIVkMtnxUV7/Z0MfjpFrW1k40bjyCyBazkhFRgLin6GSrN0s472EC+x2YD2Ieh8GoIGtv4rsH75A5fR2FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DB8PR04MB6972.eurprd04.prod.outlook.com (2603:10a6:10:11c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 12:06:53 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%5]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 12:06:53 +0000
Message-ID: <582e0514-031c-4442-a45d-6b3d317fb9f5@oss.nxp.com>
Date: Fri, 20 Dec 2024 20:06:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: i.MX8/9: question about unused DDR PHY trained CSR board array
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 "barebox@lists.infradead.org" <barebox@lists.infradead.org>,
 dl-uboot-imx <uboot-imx@nxp.com>, Steffen Trumtrar <str@pengutronix.de>
References: <8074530f-720b-4aea-934b-c0643c356617@pengutronix.de>
 <PAXPR04MB8459A8BB89FAB50D6871EA9388762@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <2200ece8-593b-4ac3-be3e-b05570165e5e@pengutronix.de>
 <d4acb710-7c80-4b71-862e-cee0a16d8cba@oss.nxp.com>
 <30375711-d4a8-4e53-a804-a721d45e0ac1@pengutronix.de>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <30375711-d4a8-4e53-a804-a721d45e0ac1@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DB8PR04MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: c21ef607-e987-499a-5c2a-08dd20eeca92
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzBPcUlzcEF5RUowc0lGZGFUTlJVUTJUWElyUHluZ2swTWRrLzg3NGhvenB2?=
 =?utf-8?B?L2RoMnJyaUFnVFpIc2VqSlpkODVmVXgzV3J1eVk5QjVBM1FIdzRTU2o0bFdw?=
 =?utf-8?B?UnFZMGprL0hPVHd4UHJBUWJzWjdqbno0WXNTbnlTRDB2dVkwVGNzUU5pa1pz?=
 =?utf-8?B?b2FDSCtjL1ZtUkFxRzB6MVdaWGNWS1pON015YlphWXhiY2dDYXl3dGpJdUt4?=
 =?utf-8?B?WjNadUZRTmcvdW9MdTNjY3hxSnRXSmM2NC80OWhMQ04xenhkdnArYW1LOGJM?=
 =?utf-8?B?SnhSUlVmOHF1a1Y4ajN5U3N1eHF1YnVWTkg5OXVKUVJYL1ZjMXlPYmU4RU5y?=
 =?utf-8?B?N3dFZzIyTXpidmNEMmRUWW95eGpRR0JkTjF6VGUvT3dlUUltZUl0UEFsRGxM?=
 =?utf-8?B?bmw4dWlNekVGbjFRaVIzeHNYS3FlM2RZQjc1WU1tQVRjd3ViS0tyZ2lBSGtR?=
 =?utf-8?B?SmZiaWk0Rk96aFZ5Mzc1L3Vpek1Xb2x6TndYbk5JR3NrWTZxUDQ2ckY3ZWRo?=
 =?utf-8?B?NTQyN3NlMDVNbkRCWjRJR082ZjhaMlg1ZVY1amRBMTVaWS9kaXM4bVJnNENJ?=
 =?utf-8?B?UWFJNldaUHFpWk9hWXBCaURvYmpvNVB1Tm5Ed2FZK3pDQVpIUHRQNmJuVzBE?=
 =?utf-8?B?SHp3Y1FMUTlYT01wVTdkNXFyMDhMalAwR0paeUZldkV6ay9TZEdvU0o2VDFZ?=
 =?utf-8?B?cDY2NlE5TFQ5OGRPcEhBc25WL3p6SHpnT1pnb093ems0bFZqY2N3ZGU0U0dS?=
 =?utf-8?B?aStuRjlDZ2tEeGdheVdmSTRGQUNNZms0K1BJa1RsTDN1Ni9ITlJ6QkhuMi83?=
 =?utf-8?B?WE5mYUtNbXBSaU5nb3pqaElveVdEbWhocDhYNGcxZEd4Y2dmd0NncTM5ZFdw?=
 =?utf-8?B?T2ZrY3lqei9NZ2tzeEVpTTRHWURwWnFiYmN4SnpoOHlJcXljOXVJaEVTcGhR?=
 =?utf-8?B?MVJnaEJHZ3FwTVc0T2I3OUZVTEpvWkROUDNTR3B0YU9pTkJHNWhVcmhabWU4?=
 =?utf-8?B?eDA1elozbittN1plUllkQlBYMEdOb2xobE9GWTJOZmNMaWQ1aEZvUTEwVEJK?=
 =?utf-8?B?NFR1SmdyUDBkUGYwSFpBR1VXVDFaOCs2RUp6bkNnRHlvblZSaXc3d3h2MnNV?=
 =?utf-8?B?bThMVWtNWkRmNk0zamF4d1FZY09IZVNMaXVNL2xVTjYrR2s2OE96MTlhL25W?=
 =?utf-8?B?TWZhMHNZZXptWFVNV0w1dFJTVWp3eDNXWXVsMGxCS203Z3Z6bDBQeXN5RUhj?=
 =?utf-8?B?Ym16alJaaGxRcUVzYnRMcExsVXR6ZDE2b3VRbXNpc3R2ZDNZdXRUM0QyaDJ6?=
 =?utf-8?B?VGNoMVlyZjNGeERiSDU2THpHYzhINVZ2NURMM2pXQ25Zb0E3akppTUtQZ2xt?=
 =?utf-8?B?Y044UkFUcU9MYWtJOUpaYzcvdmtjL1RsTXM3WTZQbThWMHc0MmU1YVpmU0Qx?=
 =?utf-8?B?bGJCU0cyaDcyd0FKaStyeUw4ZG42YlRUeFRWRFlmNXJJN3V6aktqY3k1WjVN?=
 =?utf-8?B?SEpnUDcyUVFia0E0dTNSbTNBZmw2V09IZmhIeWxmVjV2b3pQaVFGMVo2T3JZ?=
 =?utf-8?B?U08vYVdvNFJBbGtqL29Iaytkay9XdURsMVlhWmtuck8yMVVFNDAyMW9IeElV?=
 =?utf-8?B?OXpVa29QeURVd1ZKY1ZiUE5GT2lXb3FvQ2dqMk4xR3VPMTViKzZxaWhkSkNn?=
 =?utf-8?B?OHR0Zi9ZMEFidTJaVDNmV0kwSFFaL2VnTjRNbE1KQk5WL3Z0dTd3ZlZUeTh3?=
 =?utf-8?Q?DwlaIilamnrETBtC13RBJUXkHvoWshvWCRkEBKX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXhqaXE1bHoyUEIvZGxBOFg3L3lvVzIzWGJtaFRGemxRS3NuVFJ5WFJaM2p3?=
 =?utf-8?B?UWk2Ulo0YVVibEp6Y3JJVjNjZkoxS01DVVpxTmlOSUlVWTNVaTFDSHA3V1l3?=
 =?utf-8?B?Z1FLbkJtN04wZ3JFVDN6Ui9LM0F6bXh6RnU3ZWhjWDNLT2x4NVB0R09ZbVJm?=
 =?utf-8?B?K1NPZ3ErUFBiendyaGZIeGFGUUdTSS9DUTJvUllGd1FWUFEwRVBvOWprSTlp?=
 =?utf-8?B?L1BrUFRDbTloa2NWM0FTeHoxaFduQ0gwOVNFVW5rU0lYREd0ZmpYU2JKUHNy?=
 =?utf-8?B?bnZiVTlOc0JBVWlKT2pmR0Z6K0FqbklxZHFiVncvRWRmTEtTem1Kc0lxNUhx?=
 =?utf-8?B?WEg2YjErMTgxaTBOVDk1cTV5STVmM3c5bm95ZnNBTEZHakhCRnl3Q0VZTTZI?=
 =?utf-8?B?Zm5yQnRpUVg4N24wazdxTm91dHVhdkNsdW10ajdMUDRsQ0VWSndqSEhlYTBu?=
 =?utf-8?B?TmlYWmg5cGFtaEVIcENnOFFpZllDd29aQnhxZFI4SVlXQ2pxSGUrNDc2V2x3?=
 =?utf-8?B?UVUvbWN6N20xaFEvNm5VTXFmcEpjTGdkNVhQbStHeXdEYXYrckJndGk2Zkww?=
 =?utf-8?B?djRhSTl1UDRwM09EbW1Zd2Ztck1BNVBteEF3SW53bWJLK2hXbjB1djZVRjFC?=
 =?utf-8?B?Mk1abDBvL3VuOW5VL3Jrck1Vd1hTbklSZmlHL0VjbFVPeUl3N3pvNGpEQy9v?=
 =?utf-8?B?QWVpdG9jOWQ5eElrc3EyRGwvY1dZcnl1UEd4N2Fmcm02amtRUXVNMXJMcGFP?=
 =?utf-8?B?ajJnTHdwc3IvaU1OY1l4UXpxcFRkNWZoUVJud1BLMmNxYUtqNTAwYXVOOXZl?=
 =?utf-8?B?cnNLNDl2ODdPbUVhbW5RaXB5Q3phZFU5bjAyUDhOakVySTdEN1BwdGxUakw4?=
 =?utf-8?B?SjRpK1Z3MCtQS3hRK3FNYjB0azJ6Rlg5bGthTGRuZE9YK0djZ2ZXb3pSRGlZ?=
 =?utf-8?B?REpWNEhrK3hNb094M3BLMmt5VjI5cDVwZ2dIRm83MnEvUVNaUzRaNXY2TVNx?=
 =?utf-8?B?Snh0QUw4S1ZkeXJpWm1kblV3VVBBV1RQQmNBempYUW9rSjNHaGlHQXBLTFU3?=
 =?utf-8?B?L01oeExva3F2bXF6YUJVUVlaRm9nUlE0WXNmNFQ2dVNjWTNlQ1UrNlJlTDRN?=
 =?utf-8?B?RzV2NnZUcGg0M1ZrYkVxbEI0RGxGcGU5SjNTQzh2YjBwSWZXRHZFcWpvR0R6?=
 =?utf-8?B?dVljdUJtY1hUOGlkNXpPd1BzZkZmRlUrT2FxUEsya0w5SUo0WTkrYmkxNVUy?=
 =?utf-8?B?S1pQRDhycm1obXU5Y0hxUlc5T04xY2Q3RWRvc2Q2U0dYVEVHVG40UW9aV3NW?=
 =?utf-8?B?MkwwNE40QzR2WXdlQTVEYUFXVXg1MkRiZnExa2g5ZENTU1EwbllDazFLRkxq?=
 =?utf-8?B?Wk1GNGx3K1hrQnkxWmFvaDA1a1ZMOWE2Zkt1NGJ0aklsVmo4VEI1L0w5Y1I1?=
 =?utf-8?B?WkRqRC9FTmlna2ExZ1lDMVIyQisrdythL1k0MzZCTEtEd2NNYVhiVWlydERj?=
 =?utf-8?B?cHBSaWVzZ21tMXV4RjRJSkticlRoc2NPVW5jRzVESmxDZzNOVURRbUFVNWlJ?=
 =?utf-8?B?RG5NMG9yeVYxUVkzZWw2Z2JLUEVHTDhsa2dlc1Rkbzd6eVNNR0VCMkN6ZTlK?=
 =?utf-8?B?TjJIZXVBcTZybU9Td3NhTzlhS0tjbEVTL2NESVRldXZQbVVtcTlZOEJQa2tq?=
 =?utf-8?B?TEFpeEJDRVFvc3V0Z1BZRDNGRWRUOVRCZnlhS3Evelp3WHF0V21GekduUllp?=
 =?utf-8?B?RXBCMmlXODNjVE9LRENUcG9NeGQrZUhvVnRiclU3OFZ4TjZwaEFiSWJPNnVU?=
 =?utf-8?B?VEFHRzZ1YU10TGNZMURmeUVoOUN3MTlHazhPVDNGODBZT2tRMmR6VDhBbUlV?=
 =?utf-8?B?aU55RDZTZHVSR2VWeVhnamdVVnFIZURLWjltQ1lCT2VYUW5nMHgrekFwZEdU?=
 =?utf-8?B?SStETStxRi9yOEtrbmZPQkhLOGV0TXViYktpN1k5eERPYzhKcjg5TmFlOW9Y?=
 =?utf-8?B?UVpGQXNYU3RCelpwMjJ6WUw4a1NtejlyTFhZVWZGZisza1NmVDdEa1NlcGdF?=
 =?utf-8?B?UDc0c3NMYnEzQUk0ZlpsMDFoUm0vNEZQTmNkOWxHUGZMbTQ3OUE1VEQ1Ullj?=
 =?utf-8?Q?HiSKQsijyEAOY1O+gTLWXcIS3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21ef607-e987-499a-5c2a-08dd20eeca92
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 12:06:53.2668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7b58VWOiAirqRW4/DUTpR4lUImk6K7a1PzDJc+omXFEJAcMPG0fFcdouTGH3G09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6972
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

Hi Ahmad,

On 12/20/2024 2:12 PM, Ahmad Fatoum wrote:
> [You don't often get email from a.fatoum@pengutronix.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hello Ye Li,
>
> On 20.12.24 02:58, Ye Li wrote:
>> On 12/19/2024 6:27 PM, Ahmad Fatoum wrote:
>>> On 30.09.24 08:38, Peng Fan wrote:
>>>>> I now have the DDR settings for an i.MX9 LPDDR4 board in front of me
>>>>> that has different contents for struct
>>>>> dram_cfg_param::ddrphy_trained_csr than the default.
>>>>>
>>>>> I will inquire how that came about, but in parallel I wanted to ask you if
>>>>> this is supposed to happen and to alert you to this issue.
>>>> Thanks for raising this issue. I think board specific csr should be used.
>>>>
>>>> I will check with DDR TOOL owners on this.
>>> Did you hear back in the meantime?
>> We have discussed this internally. The DDR tool may generate different board specific csr. Currently in DDR retention, because we load csr + ddr_phy_pie, so it is safe to use this global csr.
> So ddr_phy_pie contains the firmware to the DDR PHY µC and it will
> train the PHY and thus will iron over any missing entries in the
> stored CSR? Is my understanding correct?

PIE is not used for training and does not contain firmware. It sequences 
PHY initialization like pll lock, power gating, etc.

Normally its configuration registers should be saved as a part of 
ddrphy_trained_csr list. Our DDR expert thinks the major missing in the 
global CSR is the PIE configuration registers.


Best regards,

Ye Li

>> But we agree this global csr is confused and waste some memory. It is better to switch to the board csr.
> Thanks for the confirmation.
>
> Cheers,
> Ahmad
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
