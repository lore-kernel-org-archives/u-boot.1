Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA627C83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20202834EC;
	Wed,  9 Jul 2025 16:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="Sj1q6C0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E898349B; Wed,  9 Jul 2025 16:37:20 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95DC8350A
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjT6kcXaM5q+cNd6YILIgvMEm8zEXqWx50GLqfGYPy8ZBZ9wxexjZJeoS2jegMuZSrg0ntsP8qC4S6Egws8N1mOZlUFupouC9n99SzzT9O2MS+m20yPfafwKySYV9OBML7LfPLR0k6LMxHJd1aDgJASPtFUrvDG4uAvqjKb+OfCcRFHZ5io6FTwgf+FlbuDJNaO2FD/49ETIVq4U/iSyhV51kMOvlSXdkR2T6PtG9MGIHRsVJRlHVXgtIIUu9Z9FMQMQsiT0anxrZ8aITUB3Pl1DK5OPXCMR4KaHQBoxDpGi6sfnv+jpJsXkJ+keZTWuHIAtp1oqjL51GTG2xs8A/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf3RSiKdgK6n93qWC6JY+QrIWGhM6RR0NZnFEUbUhF4=;
 b=nGI/wGOtZneLO/J5sEXmVHk4qfOp4g6XPF706g0aqbNOOc/qVAWsx5mwqRAw4KsBnG3oEHstbXed2FhySFyfJEnd+eyFBiGESlgB1IAP8pvYHLnhqDYo2QliTwqT7qx2kmnb0X2tcNDHFgkvuSVi2q3Qiep0xqyG0RW19o/Z9pANET/JjAzHyRlGexw/Jypb3DoWXZ+N+HOJq27NPBmdTXK5arzvZuO6zpHdUebHl4Zww3UXLEBZ8IRpr96N6H5qS7MNx4YHyy2JPccdblSQjZz1Pio0SicuSjEBTaQByswZyq+qEtc4bSWL0+pLi8lNVf+U6Xkr7nKjAGFj5JoDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf3RSiKdgK6n93qWC6JY+QrIWGhM6RR0NZnFEUbUhF4=;
 b=Sj1q6C0cABvs7UlwiQ2qqx32DHK9ZQQbHefb6zqDkH/D0JlmuxXWtxE6vSodFgL8P6ATrHMp3KZpG03NAh7QP2HYXorvObgpBqV8q8NPA2367PLBu6typMs4iN23oj7cWvocDvzhk78pgfMUdcJuCDo7S3gAeLXolboZ7b3MODyVCYgmopA3/7PzOxy5BRKTNMBudN6ruejS1lcUcXGHg+1Bl3xg2Pqx4yeeyokhgOwfWV6x6WWFv2BaA7UF/KsrylMhkRnPb9CaUdSo9ujRiO+1Ga5VdJaNg+5QPISzh45sYEkD3/mf9bQwiIv6mLaMUf/vfvUqdWagUKpnGhFgXw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by DB8PR09MB4058.eurprd09.prod.outlook.com (2603:10a6:10:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 14:37:15 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 14:37:15 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 00/11] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v2 00/11] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHb8N72T32H+rZwHUG2JgOEnvFxeg==
Date: Wed, 9 Jul 2025 14:37:14 +0000
Message-ID: <8cea92e8-457e-490a-b8e7-ba47b5d4059b@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|DB8PR09MB4058:EE_
x-ms-office365-filtering-correlation-id: d013de67-e9b8-4f05-a034-08ddbef6191d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SDNtQ1FqUHVDeDhCak0wWnlnM3BxUUNRMkp0SHcxTzBNK0VWYUJNdExWdHlQ?=
 =?utf-8?B?WlM0dmMrc0trREtPZXBnUXQ5cC9PY2N5WTBORTdaZGl2WU1scHhCUzI3SitL?=
 =?utf-8?B?cjY3cGJSdG9CdTVWV0N4c0pRazY0alk5clFKTmk4c0ZrTlVVV2lMMk9tMWUz?=
 =?utf-8?B?T0ZkSEdPazJySFpkdG42Y05EZVJGclBjMDk0L2wveG85SHA3dGJLQ0JlQjZP?=
 =?utf-8?B?UkNZSkxpZ3UxR016SEcxb09vemdJeTBPbER4eWhBZEpqWXhIVzQ1SjdTWHhQ?=
 =?utf-8?B?a0YzbDl3NldkcWYvM0prcEFoQ0Nsa3BtOUpReEtJYnp0QVlKeFZlL0dwSzFT?=
 =?utf-8?B?VjJzWnR0VTRwSUtsRkpsYWJneGU4bnc2bTNlMlNLemgrODdEQmsyY2hyQmht?=
 =?utf-8?B?WVA0dHFOTzFLTm92eURzcm9DeCtZUFEyR0p1WFR1QkRyVU5sRkNUazhQVTlE?=
 =?utf-8?B?K04yRVh0bWMvdzFDbkR1Szc0S2tnRjBZSzdjVjgzSkNIWlNOK3BqRGpRNnUz?=
 =?utf-8?B?d0VLTW9lSHJkSnd2T0gzejJlRm9xT1piQ0UvZWhmVmhFWGtHbkRoWHdQU0Y3?=
 =?utf-8?B?b2VzVlplc1ZKOEJPbWYrU2hHSGVsVTR5aGZBVzd0M09YK1U4eU8zVEpMbTZ3?=
 =?utf-8?B?eEVMTzQycDFmZ2M5WVBTVmJmVTROM1VHblJNbXg4NFRTcEg5UWJuNVFJTGNR?=
 =?utf-8?B?S0dabjhiajJwM3R1TmhEcTFnS21PQjBIZ2NueEpFRU5neGRMZkRzcFZmNUpN?=
 =?utf-8?B?M2FDV3RBUWVmSnlRd05nQVY5UloyeEc3VjVtZnJ3M0hENlpBRVhHNDcxQVZz?=
 =?utf-8?B?ZytLWVo5MC83VE5WZkVQYm1IaFNsbk5RczgzQXArTEt4WmE2RXZJbnNINXdK?=
 =?utf-8?B?djFiMVE5Rm4xTTN2K3o2SEtOMG82ZWNZK1dZNVcwRmUyWlhNczVrRWdFWjFJ?=
 =?utf-8?B?VHY1djRjeVRBNitpUVZ6aDA2NjRvTXpRMG5hL0R6VUY1YllUeTF5Z0htejV2?=
 =?utf-8?B?OXU0VEMwaXdpaS9yaTJGVjJIYk5na0JWSzRUdUo3cVV4T2VicXVvSXFBOWlS?=
 =?utf-8?B?VUVrczZwV2trYXZoT2lzeXhhSzZFcWowZTY3bkRaRnRYWWhDQTFkNTE3ZFF2?=
 =?utf-8?B?Y3IvVDJHU1hjVHhpcVUwWVlQeXc1T01jWDROTmRjcitNQ1B4VkNJcGFSR0Ux?=
 =?utf-8?B?Z2FqM0NXeFZYR3E5elRlVENGQktKUGkyUUN0L0RwUlVsb1JUYmJzME84Q3dG?=
 =?utf-8?B?VXcrWlQyVTQ3Y2NiY1JSY3NOY3dQcVNWYld4eGJpdHE4SVhuNHNCbnlwWHZ6?=
 =?utf-8?B?MXhwSHRXZEM5VmZTVWVRTS9OczlMVVA0ZTVSbnZvUUVXaEJCMUdRVytrZFFH?=
 =?utf-8?B?MFFUTjRLdUo4MmxuTkU5eENrQmEwQytQMzBpQTlscHYydWliQ3Z3YjJKLzNa?=
 =?utf-8?B?eHdGYnJ2QTRkMHhJeG5xRG9NcXQzOUlRMXVlT0o2VHJPeEVrS1k4ZWZ0TVBE?=
 =?utf-8?B?V2dRcXVaQnBaZ3dPQi95VFVwNTdieDYxSkw4T2xWaVJKdS92UXpqdHpZK2hR?=
 =?utf-8?B?aGZzVGpvVlhVZi9FR1BjNEdGZC9IdXo1TkJhS09yRUF5TUMwMGVHRmpUM2o5?=
 =?utf-8?B?RXlBVlFlYTRBU2tlMVZ2ZkIvamwvaEhvQ3M2V05XZ3U4c0p2MG0zbUtHaDlH?=
 =?utf-8?B?a1l2MGttSFIrWW5VNWFUa1FFbk1zd0lCSGgxODJIS21LeEcyUGpFSDJmYldV?=
 =?utf-8?B?dVBHZmdDWXNCM01yNU5HVlk2eWlhOUdWdDVDZ0V1SEMvUFduWUVlc1R5N3c4?=
 =?utf-8?B?N25KdW5GZE9mOHNzRXZrNitsalFxTHBubW1USG01d3hqSmZaMlZ3bVB0Mlh0?=
 =?utf-8?B?cGF2SEVadkk5YVR0N3hQL2VuNThnQmdnbmRzaVUzWDNNdWVXRUo2WlA4T0RU?=
 =?utf-8?B?SHFxMDRya2d5czA5bjFQOHVib3NOaTFzVVRabmp4ZmhmTE1vUnB2eGZ4REt2?=
 =?utf-8?Q?7xVN0BmSFJ3KqAmj9ckLpXjorrzUxw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVZXRi85aGRHZjFWbFluOE84Ty9ld3JWVzZMSXZVeGI1UVByeUdLU1ZYbUFs?=
 =?utf-8?B?N0VyUzVvanRZOWhhd0djdEJnTDdXdDNkZXh6U0I5cXJOWUs1Mi83TkZDRTVs?=
 =?utf-8?B?NW80bDc5QnlFT3ZiSmJMYkdhWTBWZzk5WkNEcUVwaFRycGdROWZuMUwxSXdD?=
 =?utf-8?B?T0tMeWQwcmpLaS9BdDg3akNhTjJEVlUyTGtRVFA4TlF6ek91dHA0dWsxbjEy?=
 =?utf-8?B?dWljOEZ3ME5Wb2hlem5qQ25NSEx2ZjY3NEtwSzVZblRYcTNtQWgvaWRXZGlI?=
 =?utf-8?B?YVBBbnpIZ1gxUTBVNitkTVg2MXlQMkpZZzNLcWU1aFB3UDhxaEtkT0lNekE1?=
 =?utf-8?B?Z0kxdTFKTVZGR0pzRlpGUUhUd1hrL3gvZk8vcHpmNTVRb242UTZ2bjBwaGVu?=
 =?utf-8?B?aGF0cnJBK2lRWEtPRXVablJSaCtkbG1YUzc5c2EvZWRreThLUE8wQVkvSk4x?=
 =?utf-8?B?aGNNTTFReEl5SzFBQW53c1Z3WnN4Z0ZGUmw3M25EZzNqTFh6VVkrbnBTd1Z1?=
 =?utf-8?B?NU9rdnh5V2tVUHRETXJYSS9xeDF0SjVCMytEM24vSzZuMGJYUE9QSUdZUmo4?=
 =?utf-8?B?RnpTMFIzTjdPNmVTb1crUmcwbHJpMTc0VmdkcDRYbGk0b3llNVE2RTBReHBz?=
 =?utf-8?B?bjBjbE5TWEloaGs2b0Z0bWhBbjl3VzgxK05qS2ppckx5RWdpbE1meWFOR1NW?=
 =?utf-8?B?bTlsbGFuSlBaYjl3WElOWXFMb3lPUndZc2FLK1hmb2M3NGgrRGJFSWU4Uzdh?=
 =?utf-8?B?c3p1WGxjNFVtM0lqMUowc1VvSGdrQ0hicVh4VUJtbEd1Q1c3Z1JCTVUzaEhY?=
 =?utf-8?B?a1U4UHRkdHNtTDh2a0pUaEtmNEZRVzdiWThzaGlqWkNqT2dCSk1ITThZZlBU?=
 =?utf-8?B?bTZxbnNkeUpGZXJDVzl1QkRzZ05QZDJyY25kZ0FOVGRZMU9RWnRvTnh1UXhJ?=
 =?utf-8?B?Rm9xbkltd0p2VFo1K1Y1NkJkaml6TW1ZZlpqT0kzSWpVQUxtU0ZBS1FKNmlo?=
 =?utf-8?B?QkVWbktrSVRLc1gwQ3Y5SjJ0bnZseG1sOGJpY1o4cGZPclErNmpaeW9PNFZY?=
 =?utf-8?B?alRFVDZwbC9jR3BGRm1sYlM2NVdKS29PRVdsM3JxQ0p4Y2VXb3VkdEdkcGpT?=
 =?utf-8?B?YW1nZ3F6cW45YnlrVUtCbVFlNC9jeTZ0dllzZXk3ODBkY3RZbk5NQStkbGlC?=
 =?utf-8?B?K2QxWVpzWHczR2p0UWpOYUpvVThNV2pTbVNTM1JnSUlRM1V0am1BTm90Qll1?=
 =?utf-8?B?QnpKMzVQTWw1d2JNbUx2N056aFlZcVhDbTNMMEZIcXFjQ3ZydGcwNTI5cU9u?=
 =?utf-8?B?QzRjV2tDclMzdTRuay9lK2xTRG5SNVZqT0N1UUFTcmtQa1luNWg5NDVlNVBY?=
 =?utf-8?B?Y0MzenAvdFVJV3hHYXdoMlYwam1JWGdSSWY2UlAyZlFRK3RJQUoxa2d3UDl5?=
 =?utf-8?B?OW1RTnFXbXdDaTFmOWJxRVF3Y2RoMVlick5vU3hhTGh5Wkdwdk9kaTNIWDA1?=
 =?utf-8?B?YWNkMnZvRWtFRzljQXpOOEp2WDlJV0U1MmdNYkdOeXZ1ckd1bXdWSUNEZkVW?=
 =?utf-8?B?YWVXWlF2RTFQRUdFUEpKUVMxM3JEK0daUk5JcFVwbGx3Sy9DZEFtNUVCei9Y?=
 =?utf-8?B?dGRidGRjeE9RdGNITGNPQmxrcExTQVBvcjczTGNEbEh6SmpWRlMwUGJIclh5?=
 =?utf-8?B?RUhpY2V3d3pGWldVZjVzejlQNmRib3dYT3JGWUdTbzhsUFROYjQ5SkZVVzZQ?=
 =?utf-8?B?UVF0b0VoOXM3SU9OR1pPUVJkSGwrdUN2YUN6dVJldDZhQ1Jrd3dIN2Vma2ZN?=
 =?utf-8?B?Vnl2b1EyVzhJWkdzTWE1RE4yYURnM1NiTXNlN3JNbnlzNm0yRVFKZFNKZzdM?=
 =?utf-8?B?c21wK2hKMzBtTGtaU2JXYWZZSnZORmg3K0NmbWVDVmtRVWlaUU91OTlpSFRE?=
 =?utf-8?B?L1NIN3k1TFU3SU45K3UxNXFwYkR1RUpsRmI3ZEo3dDVSellibzdvMXp3bmhR?=
 =?utf-8?B?UUFYdGdYTnBBWDRzY1lCcjNaYy8wdW55VDI1TmV2bVR3cWw0L2g1NzJTQW5w?=
 =?utf-8?B?a1cxSDd4bjFyZnJVRmk0WFdoWlFocEFOYWRnZlB3VCt5dUJZV3hOUm1jdXlo?=
 =?utf-8?B?WC85MTZCS0dQN2NyRE9DRklobkhaOGFQTjQ5R2VGWVFaMWE0YnZjTmVKbGJu?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <252CB19D4387A042836BEAD9E8383BA2@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d013de67-e9b8-4f05-a034-08ddbef6191d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 14:37:14.8612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJcmHAIvON1mTrDS5LbhSbHx41/R6zLV3kFcOwZYt+rjYtE7DpRFnhLK8PdeIEygw8TOSbwXcAVPb2q4AINFEz9PrJ8vimcFo4+tF1u0t5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4058
X-Mailman-Approved-At: Wed, 09 Jul 2025 16:37:44 +0200
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

SGVsbG8sDQpwaW5nIGZvciB0aGUgZm9sbG93aW5nIHNlcmllczoNCg0KaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2xpc3QvP3Nlcmllcz00NjIyMDYNCg0KSeKAmWQg
YXBwcmVjaWF0ZSBhbnkgZmVlZGJhY2sgd2hlbiBwb3NzaWJsZS4NClRoYW5rcyBpbiBhZHZhbmNl
IGZvciB5b3VyIHRpbWUhDQoNCkJlc3QgcmVnYXJkcywNClVyb3MNCg==
