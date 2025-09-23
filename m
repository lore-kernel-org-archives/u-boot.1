Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C29CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687EA83526;
	Tue, 23 Sep 2025 04:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ge9LAWuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253DD83211; Tue, 23 Sep 2025 04:15:23 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9B383211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6XtJLj+I7WbG0aVDb94fsVBwLeWpNktD6Kw9wfobB2m5YNVmxYPr6rGQh6hMKhnYXTpod2vODA9rna2q7kQ4dju//AowiMGufI43wLgptItRkMdGzYeSnvGrrDjWc3IGk4UgWdZtYbuH0Ho4K0ZD4DAJcFLKC2bN1ImjyzjnV3AK4DptLdwpikHUWHdqXVpmYpR5ndhwtqPD4vveu+TYNqGmRNX1X3KqY8eFhNlk5/i3ERz9oycwfIIkwVlT3aMtutx5U42PWzbeisAgJg5XSYmioOL0FxZPHZQaM/HSyNdTmBA3AvnNmS//q00+EsE7FsDjLRj3CXsFTcV0SbQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RewQvKNPT0po/qGz1b6qkt2jSSLh8bB1FsOBAvqduyM=;
 b=P3tVKiAdhfp1awxJ64/rEQBBbSbouiPeNS7X9W7rPl6ZWy6Q16E967vaPIQrvm0adc5H9ZIpL1qT2qT5XpnGQDcmMRCvlZHSV8FGNcvWDCXJ1/vNwWABRDeqy4gE7mHrbAcGpfSAG0J18BZjhkDVyr0jrBxHYPEGvTew7hfomSVe6FsWWx35cOChfk6iVFX5hMdA9A8yoMd1vIlT81X3uz3CYK9H9Cv+5oFXgPvetJMX0NeFk/tg8akvWBL0PpECYcQyzX7MnXjm7MK7YP060fvxfIBJtPPp/WEKVUq/25uV8g5znAKcHjmIOfYKxEwIH+68fHC/AcAQkBbeAO12HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RewQvKNPT0po/qGz1b6qkt2jSSLh8bB1FsOBAvqduyM=;
 b=Ge9LAWuL1vJFqIWD55F7QhvaoaQkj/fR1h1aKhdh6sN4qTDoIlOldCmONI0Cg09Ve3mZvTSAqVKswsWintEdFn+JrQTidCnn73PGe69lYQAXtQv9u1B4y2nlPx0QKGG9TPyMQ4ghjgeslxcNGUOd3nmaPIo1IDIYPt33onnzXDqLKwlgzSf8it9eswOD07nyYLTpW5mybRVtF3mezUxxSOQQLd2i5hBNM0yRCYbw173isWthSNCrnKhF5P4aEC46jbfVXSjbzNi7S4x96YzUw0Vq7D51DMeV0zgwdKI2G+HWnXviN28yL0XvaH25PNgyChy8XG7MUdUs2gUTTJ9Ijw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:19 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:14:54 +0800
Subject: [PATCH v3 02/12] cpu: imx94: Add support for i.MX94 in
 get_imx_type_str()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-2-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ed1c63-a8d1-4db7-d8d6-08ddfa470b1b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmhmeDVOajZNN2lvZjhVM2ovd1hPbEkxUHZ3OGRlV1ZkYXBzamplUTJ3NXFv?=
 =?utf-8?B?bnpDS09OWFYyUjROSzkzZWp2TmN6c0JJaFdYbFRsQ2xjSW93K3dIOW5XdkxY?=
 =?utf-8?B?R01Qc1BIaTE0ZzBoQ3RkV1k5M0lZZ0trTHJUbGFLSktuU2hPbXZXYStpTDhJ?=
 =?utf-8?B?V3RBd2lwSTNZYmN4Zmp1VEt3VkNORWhYanNkTUlSdTNoSmxIQ2JaeVNiTXEy?=
 =?utf-8?B?bEIvUllYN2phbHlsVlk2enh4cTgvdHJ1MFZnTnc4NDlOZWxkRVhaUUNHT2NO?=
 =?utf-8?B?MWtyRGhjWkhReEpzSG4vMTRyZmpJOTFOd0dGL3BZYTZaS3dURlV1b1VabmF4?=
 =?utf-8?B?RktrblJmcDgxSktVL25kTWNkOFpwdHcrOExiZjR5c0FPYkJUSkhSWVN3amZz?=
 =?utf-8?B?LzVqNkRkSFFHMzc5Zkprb1dJak1NRmtRWlpnaXR6ZllDbEI4ZEVaUWF4MExu?=
 =?utf-8?B?a1RVZEhxSEVpZGc0dHhMYlJzeUhxUTc0TXJoODJHTXhSckZTdndFcnQvak12?=
 =?utf-8?B?Mm1GQkNYajcwMHBYVHRBR09kSkZtQTJDWG81dmZnUTc5NVVSWkFoQXRTakYv?=
 =?utf-8?B?S3llcWtNUmVnRDl2V0lyTkRHQ25lOFRhOTQzcU9DREtxTFhmaVhBY1NPeWwz?=
 =?utf-8?B?WGl0U2JVMzEwbE9iNEs3OThTc002b1R6K2g2aVlzeUpTdUZCUGdmS3p4NXZB?=
 =?utf-8?B?MmFzenQwdUVVTFZWa05lKzhmaG9JR09NdFdTSzV2R3RDalA0V1dXcHhBcVk3?=
 =?utf-8?B?OGhyNmJVUTcrczNXSnA3dW5ZUHJLQUdoaTBnMEZrcXNEVXo2Q3FBNHJQY2NS?=
 =?utf-8?B?VnMwcHlHT0tVdWl3eXNDVlhiNTVqSEtIT3J1Q3NFTk9mbGxXM21XOE9jVDVz?=
 =?utf-8?B?TFZvQmJKaGtTMmJiL0M0cmNCS1pTRGlyem5FTXE4YnRGT1MxOXkzVkVWU3Nl?=
 =?utf-8?B?aHVtWWNrSEZoT0doZFByOTVXYlM5cERQaHBHOURPeDNRQlpkdER4K3hnMUNB?=
 =?utf-8?B?UUxZT0kvOFN2NmdLRzBPUjNyWkM3SzZOcFlSOVNzYmJJZ2RUaEpyMmVXSUxm?=
 =?utf-8?B?R0ZQdndGQThBRlhYYjZpUHZmT2c5Q1hGUy9qdzBBS2g1R2NlQXhwWEI4a1hI?=
 =?utf-8?B?Vk41cE1zbndGL2h0RkxYQ0pEd1lDV2hnT2l0TzlCa1dIbFJTTjM2Mktpbzlo?=
 =?utf-8?B?SThUUVdIZEZuNXVuV2hjTXJ0MUVQRWx2YUZmTXFLQ2RlQW9kNGxKRDgyQXlt?=
 =?utf-8?B?eVhTVGxNOWVHaFZhUnVkZDRiWklaWUl5RkpZMExqYW9VYkh5bHVFTnhzUHVu?=
 =?utf-8?B?eUpTdzNrODBSZVZzcS9xbDZtb0NXaXRldmdvaTFTR0N6QVpoYWtEUFo2N0Mr?=
 =?utf-8?B?S3YxSW1jakNaY015a0UzVVVFbENCRCtmQmtLb3lTSlIxdnQ4VXJwOUsvNEdz?=
 =?utf-8?B?dmI0Y1BURXhHUHN4MGVGczdORWgwNHYvVDRkSEVJVXlldzgwQUs5N2VaeWtI?=
 =?utf-8?B?U21qS1h6L0I5L05QRVVKVkQ3bGZPMEcvZVFJaXlvRnFCZVp0dkZNOER1QUtk?=
 =?utf-8?B?OHBBZFRlcGM2WEhiTXlqYnNvNEFGV2doTXRrU0IxWGNxWFpqUUdXM1A3NlBU?=
 =?utf-8?B?WFY0UDJ0SmE4U3MzRlVqQlV6T0ZROVplelB4cHlyUnlZcUdCeWJ0bFZTb3Jw?=
 =?utf-8?B?MDNLU1B5MTdONjZ2ZnpUSXNUdllFRDJIRUNHendzWUhCNVkzRC9WYTBXVEo1?=
 =?utf-8?B?UVR6dlVHOWQzNTlQWGR6VXV1NzBEZmNXenRUYUozb0k1R3BQblJmVkZkR1Yw?=
 =?utf-8?B?c1JwcmJTSzlVYnQ4Y3V0SnNWQm81YWtyZXk4RklnTkxZK25pbW5STGgrSkNW?=
 =?utf-8?B?VVBkMkE5Nm55b21aZFk5QU5sRXdRK1Q4c2pmMnVOOWpuYUZYNmZuMFNvSUV6?=
 =?utf-8?B?M3hiOE1GOHhmOXRYMXBZcFpPUUhFbHFlTEpQYU41UDdBK0V2eHpOd2g0UUxi?=
 =?utf-8?B?T1VXbCtDeU93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lpTDhMWjNCaTBPVVVxTm8yemNXWlBIZ1gwcDFDMzZhbkR5RTc1VXlsWFMz?=
 =?utf-8?B?bGlSU3RWbDhBVmZvYjRqZkppTlFkU3hKc3B6Ym5NUVRYWXRmNmthNHpaWGtt?=
 =?utf-8?B?d1MrY0ZMRHZGZm1XYXFnc0RiVURTQjdRV05yM3pGTzlmTHZsOE8wSmtNSnM5?=
 =?utf-8?B?ZzBUWjJGL0tEUjFVSm9qcjRVVmVlZG00MHR2Qjh1UldKSGxKek1KbzdHVFAr?=
 =?utf-8?B?VVRUdGFNaUZqYmRSVWFoS0IyME9nRGpBT3dPLzJFZ2lEVkh0QVV3aGIvWENB?=
 =?utf-8?B?MGltV25JbG9tR3RuYnF2NVdsSTlXVkQxeU5BS0pqSi93dVowOWZ5Y3VwU2NO?=
 =?utf-8?B?dXdsTmg4eURnUUNzV2g1bWhzUGczUTZYcElrVXFHZXRCTm10bTBxTE01WEMw?=
 =?utf-8?B?czZWRXZVS2RzTUt4M2tQL2xDVUFWU0VuMm9pOTQvUlBaUWhwdU5OcExNcFFp?=
 =?utf-8?B?LzZPQTA4bThveHd1K0x4d1p0Nk9LbDBKSTFGcW5HbFdYMXBtanh0aHFscEZs?=
 =?utf-8?B?UDBCV1lWMzQwRmNKNFVNLzFWQUV6cDVXd013b2VwOVBITVVwVFE1NWFzTlRZ?=
 =?utf-8?B?eGp1c3kwWjV3RGRIRVppN2ZaYUZxNk1MQnBjZ2wzREIyR1pSd29CZklEWHpW?=
 =?utf-8?B?NTZ4WHcwV2o2TklOanE3ODZ2dk0raEVqSnZBb0RrVHpDaVoxaTcycWthbWhN?=
 =?utf-8?B?Z2lUUDcxMS9rZnJXdVJOY1phMUhnZzlrRUNyWm5oWEllMExOOEYyaTVzMi9F?=
 =?utf-8?B?RnE5a3E4d3kvQ2NDSCtSSWdIZjVURHczT2dVcFgvelpyV2lUKzQzM2ZxWXNF?=
 =?utf-8?B?aU8xOW5ReTlZYWl3SzZNSVFBZHR5c2VaR3VBWG5GelNEc0Z5eW9jY1Q3S0Ri?=
 =?utf-8?B?SmRiek56SENLb09yNkpXOVYrbE1rcVVLRzNCMnpwOStVdVdDeGszdFhlbkJn?=
 =?utf-8?B?MEhJTXF3RDVxMG1RUzlHUDdHNU0yenR5Rkd6ZWJHZTNIZzFJeEE1N0JKUmhG?=
 =?utf-8?B?aWw3Z2JIZ3FEcG1xcTdOeGpyRE5HTWQ5UEQ3Z2FNZXpGM2g2alI5RXJjVzVH?=
 =?utf-8?B?M1hLS1p4ZkdyaXI0R0NqSnl5U21PbUFRYzR5TUZxSkIvVmZXVTFCRzRFQ0Qy?=
 =?utf-8?B?YnpGRVUwVUVndHFvUmVZeUxWWjQxN0dQRlhtbWhNeGN4cDBzaDZ2UHVvVVNz?=
 =?utf-8?B?VXRGaStyekh1S3VEY1Y3c1NHbkhxdzdmY0kyR0RMU3I5OHR1eERZVnF6cUZz?=
 =?utf-8?B?ck5yS1F3bkpjMCtqNG5LRjdaSitUL3ZFamRjbkFNY2dCVld3cjZ4OENWT0dj?=
 =?utf-8?B?TS9IanNMWEd2MlVwNnBVQVBjaG0zQkVuZDB6Q282Q29hK0U5N1VOSGNraEFq?=
 =?utf-8?B?aDBvRTdlQU1ON0E3Z3hwZkY1b0RURk9hQVNrV05xdDJwczdWY3FISUw0L3Zi?=
 =?utf-8?B?Tlo1TjBPZ3FXQ3Z5ZWhDc1VjRXV6MmIyaUlQK3diL2dQRTU2S2R4Vko3Z0dk?=
 =?utf-8?B?N1Jqa2hOZGVVdkFLazR0UkI1bFBjNElQOEs4bTR5QjJJNkd0ZFRIT1Vydmds?=
 =?utf-8?B?YUJXOEtGVTkyZzlmUWlvcmx3dHRRZko0b2dtVmE0dUlTQ2UxUEIzeHJ3RDJy?=
 =?utf-8?B?cEFmWWRpa3VudHkwcDFhejRoQkhZZUF3eVFrVTVlV2ZtSW4yS21aQVRUdnlB?=
 =?utf-8?B?OHVHN2t2dUlNbG13Vk40emxYZlFVTnhQNk9XQ0h3NjUvbVpvalp4cElZRW9j?=
 =?utf-8?B?VjBrNkxWTkpZZkovdmxEdzl0RWc2WlBWY2JtdGI3QmhQeHM0ZTM4RDQrU2po?=
 =?utf-8?B?MnhnOXV1bWY4Mmk1Q2tteXVCaWdaWEw2L0NFUUpQT0w3VllxemF1WmNWRm1W?=
 =?utf-8?B?R0xVVWdjSERRQTJGa0h3dWFhWk9Cckp6RGlibng2MmUwSzRjVEVjVlVVd3BJ?=
 =?utf-8?B?OUdQamhYWHZONkRRUVZSUG1jNlFwTEo5RXpWd05OcHl0elNmQ3UzMjhQNGFu?=
 =?utf-8?B?ZVRhUjZlc2RrNDZDeEhtcEV6RFROME1zZDhwRFlwS3JBeFEvOWhjS2hUOEpN?=
 =?utf-8?B?WDloL0ZBNmxZZHBpVjZLRjU5YjhDSXVnb2VqUjJUL1VtRy9OYUpYRHNrNGhI?=
 =?utf-8?Q?dMrgGT/sr73eLr0ErroVgiBgr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ed1c63-a8d1-4db7-d8d6-08ddfa470b1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:19.4075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYACiA49GQ1vn+t2tw5mFpnmeoqgW01cPbrq9nqaj4opbUAJAAa7Nq5aSyQZiAxe/JAhADJWkaEsiKaMgLHLVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
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

Add a case for i.MX94 to return the correct string identifier in the
get_imx_type_str() function. This ensures proper CPU type reporting for
i.MX94 platforms.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 950630453f9..630919a3642 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -113,6 +113,8 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "91(01)";/* iMX91 9x9 Specific feature */
 	case MXC_CPU_IMX95:
 		return "95";
+	case MXC_CPU_IMX94:
+		return "94";
 	default:
 		return "??";
 	}

-- 
2.43.0

