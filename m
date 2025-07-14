Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D770C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 10:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5F3082CFA;
	Mon, 14 Jul 2025 12:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kvjPQ+M/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFEED805D7; Mon, 14 Jul 2025 12:32:34 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FFE982FC7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 12:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhfOhpU38RTZBqIbQiHpBbIJWSeXLa2TOyp/fXFNiudN7iNPHMaHirxdwXlfs+ciW7eOl/7QiLO/iX+2UPmTwMGfqFswMj3i0J8g5ubYjD6bVblMFEtoOpA0Ia1cqC8xrnqcvjjy/6T+KgKTrywervn62KQ7C6Z2JZeEujoUkqfUwmA56UCbIUX886k9ZTDB/tlc6ZaOymrRKxNhg52waai/VSpbqR1F93NFXlpoHntL4V1tVlqQV/AACojtmMJxFgRovQOJMV2hv5KvUZ3O1gEr9F8oIwQ9KZiC2joRw2L28j9PnuQEmP7jsNVybx/D3h6YtvTuvsGV3nn1xyvGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wXeZVPBVqSSZrRijEH+ZcE2bkMt/WpjVrSSNyCOoFs=;
 b=m9J1cblDKjAQjnxpX6zVNGk9sqs5NIJcFl2eteRRoLfb8wcflkFNGMeItbKIpVCMz+pGppslOB56BZ6Z+ejr5H49HAE3fna9j1fSRyC2RBAO9Q1rVJ2mtdEfY6iuC0KNVYEn1mC0jNVQRLKQJgfAFQ8l+IGmk0hsMP6IGT7Z2/HiNwanDDjofzlkA70lvF2UXHs9hzuy8oJJP8FIfE6mJvYXeFsfH+YrWabQ28esYrlxn7yep1aOPVLHMPY1NHMeOqFWC5wpoNcGfFsd3AKjXnr7Fmw2MxLvd/Vn6pV5NAUVMxwUmhYiNi5i6oh30ELLPna1FuCvglhRE4gSE6ek+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wXeZVPBVqSSZrRijEH+ZcE2bkMt/WpjVrSSNyCOoFs=;
 b=kvjPQ+M/lfr08kd3nrkTfwXki9/L/B5CaFog0qd5EZkKd3CaxCQhAKlOGEMk0YRx3Aw6aa3HlEdAQGd9WMREtDhyxwSswlvZFfa2BszSmMk/R8Xk9i6t6gbXzrMFUHb08sLpI0wrJiXP91hoedT9l8/ZkTW5yWE+oE1G/0iomKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10980.eurprd04.prod.outlook.com (2603:10a6:800:274::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 10:32:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:32:14 +0000
Message-ID: <699642c2-5fb6-4060-9f2e-496cc5ff2eaa@cherry.de>
Date: Mon, 14 Jul 2025 12:32:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: gadget: rockchip: Add missing dependency
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>
References: <20250702010346.18716-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250702010346.18716-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0048.eurprd02.prod.outlook.com
 (2603:10a6:802:14::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10980:EE_
X-MS-Office365-Filtering-Correlation-Id: 99934e25-6d68-4834-9ee4-08ddc2c1b331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUVMcU9JUlJkdHRHOFVhNzFVT2xmY2x2bU1uTzZmaUFQY2dPS2QwbTc5dDhK?=
 =?utf-8?B?eENFR0RnOU9UYzNWckNyM0VNOXl0YTN1VlA1bFdiTVBYWVVjNFVLenRjdVFQ?=
 =?utf-8?B?S0I4N1R2em9aSnZuM2JuVCs4c29JM2NDWk05elJpQU5uMi9QNVc0T3p3WmVu?=
 =?utf-8?B?REtWQXRVV3JjYVVxOUptY005WWoxWmFmeG53RlFvMCtEaTZhSGd4MzZ1U3NH?=
 =?utf-8?B?VnVrYkxFSGhMSFhNNGFHaGFSZTRURmIvMzNNVUJBbDBTd2ZacVhOS3Flb3dI?=
 =?utf-8?B?eVI2TUI5aTJXZTZ2N0IzV0xaRURDb2M4SU5ONHAzN2pIN0tRbE9jSjliNm5t?=
 =?utf-8?B?WE03aWpvc2ZSRHg2MUxoVHU2RHNzdFhkRnRyYzdSWEJBMk9Vb3lBWFBlMGZC?=
 =?utf-8?B?L2pHdlhBUHZDWlp0M212VVNuaDh3eHl3UkdJSnYrUzZaeVlidHM2NjBkWTNk?=
 =?utf-8?B?UmYvTjdtVnpUL1hoWklhQXRLNGRjRzRNRlRvbjhFOHl2UThDQnBSM0JiVEJV?=
 =?utf-8?B?QUhoRlpoTFh2RWNRMzJNamxFcEZEREltb2FRMnQzUFpibGpTa0Y3c2NVSmVq?=
 =?utf-8?B?U2VKMkVlR1dOUFZxdFFvd3VNbkszczFucWkrNXdVM3ZCYzFSWHpNMFIrdU1V?=
 =?utf-8?B?eWJQRHppNnpJYnAxcW5YMmNnWXNHNHhxZWNicHozdVJDaFY0bFdmYjc0YnQ4?=
 =?utf-8?B?S2h5V2ZYZDR2TjN3S2ZHYlQ4WXArd0hJbWdOZ2tMWHp3NldYZ3IvbG1KRUMw?=
 =?utf-8?B?Vyt1NkY0c1FDMm1jVy91eCtxZjRJUjM3WVFPdnNpSmphMzBiS3Q2UmdFemFi?=
 =?utf-8?B?WTNHUnVZY1puZzNmOHVDaEs1V1BZNkRVZStPN1VYUzIyVFJyWGpya09OaGhi?=
 =?utf-8?B?Zkp0MW5DL0FZZmVKYVc1ZWh6R1RwSEhLNHlLL0liRVBnR3hTc1I0VUFHT3VV?=
 =?utf-8?B?SU1vS29zcjljL09LZnAvM3FGa29CWU5xQ0daK3U0T09ucjJ1UG9TSXY5YXlI?=
 =?utf-8?B?ZnNLRUpBbmNhc1N3MXN4dklwWjQzblo5Vnk3eDRxdkVRWmFmMnNZaVFWQ05j?=
 =?utf-8?B?UzRjdXhvVmxuUURGK0d4aDEwMTNrMElDTTBQM1Z4QXB3YmhaVWhBcXROcTJs?=
 =?utf-8?B?T0gzcDhJb0FPQlZlQWpQNUI4cGYwYy9OQm1ubUdvOTYxWmQxQTYra2RyS3Nw?=
 =?utf-8?B?cnRxWnZhSkVaNGM5Zm9FdHRackVPR3luK1dxWjF3TFEwV0xPelVCVWEwcnJL?=
 =?utf-8?B?allEcVpLbUVuV1UwV09JWUx6M2tYQlV3cXFhMnpUZGh3N0kvTUM4K2ZLZUJr?=
 =?utf-8?B?dlJlNTJiZGxsQTFidEVsM0JCTHF5djVpekdsL1MyWUNOYU5NWm9HYTlRdHlr?=
 =?utf-8?B?TnlMd0VqVGRmS3Bxdk9Mb3R1WVNTekNiNTdsc0NFeUY3TGRyTmF0ZmdGSm1N?=
 =?utf-8?B?YUZyY1ptUXZNVzVqMllKWVZXYUFJdnZvZG52WEx5OGdzOFlYeENVYVc4bi9n?=
 =?utf-8?B?STFINWFaWmU5bml5T3BPZndvTTJ0K1pvd1NXRlEvcEI4c0N6aGpsYkF3V3dE?=
 =?utf-8?B?TW1UVVNMd01ZcUZKSW0wc2hqS0VPMDdGcnBOSndGTDQvVWIwOXltMTcrM3BI?=
 =?utf-8?B?bHNVK2J2VTREdktySGpzeDZBOUdlTDRYdDcvYUdiME1pMklyUlNoOGNSWENC?=
 =?utf-8?B?S0lwcXR5U2MwYnRpV25vTTJSMUtxWXJ2b3N1dkpEcWljc245bEVpMlFHSXgy?=
 =?utf-8?B?WkUvQkxoZlpjY01mMnNQYlNnYUQwanJBVkVleGZWS21aNGN5TG1pTzc2MDd2?=
 =?utf-8?B?cnM5Y3lidzFPSmFjL2NKUGxWWWFuL1E3U1FUNllHWEZqQUpTb3FuUEVjTksv?=
 =?utf-8?B?T0oyaDlxckZlcjRYdFl3YVduai9uenF6Z3dUZTc1N0hzQnRpZWUyUkFyV1B5?=
 =?utf-8?Q?jXH3WDUrXAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXQ5ZU5tVVczSzNhajZNeDZCQlE5SVZIck1LVVJtUGI4ck5JVzRUbTFocWt1?=
 =?utf-8?B?UGVUVUcwUytPRWtrbVpyUFlBZVJueHNnUmtua1QyVVNoSnV0NHV0OC91d2ZX?=
 =?utf-8?B?UGYxQzZwUXFpRDBhOVhrZUJScGc4Z21UOElFSGtYZ1FyVnFudjE5MEkwNXB4?=
 =?utf-8?B?WGg4TlVzV3lzMUNyTVYxMUhEcDRVbHJuakJOQ1phOUFQYVJYNW12K1hIWGlj?=
 =?utf-8?B?WExDbjRMeHEyUDZsK2RySGVTeXVtRlJpdEVYTUxDb0lMSFNaN1c3ZWQ4L3RE?=
 =?utf-8?B?YnNRR0wycmdVQmw5YzFBdGRVK3JhbThOMVUrVndiZGJxYTBQTm9ocVM4bnB0?=
 =?utf-8?B?MW9uT1dzVjBZVDN5QjE4V3I5dE5xY1VOZm5MYVF3dlFxZkt4SW1FZklnYkQ3?=
 =?utf-8?B?dWVXdTZIUTlnajFZVFpiVHdZODdXRlRtZmFONml2eWVxMmtUSHZIZ0o5cnZR?=
 =?utf-8?B?bmlicGljUER1ZTRjOEZ5V3BDdnkxeTZrWE40emVya1V3RWsyRmxWRFJjVXl4?=
 =?utf-8?B?VE9SdG96dm0rUDMxb3pleFJ1bWN4Z0ppVzBWQldUQkR6VTNVRlBTRGcrMnYy?=
 =?utf-8?B?aDlkaHl4MU1CMnkrUEJvTE91WDVSTVZqa1dmT2RoR2hRNlJkUjhJaUo4b3Vw?=
 =?utf-8?B?ekEzeTBRSVdRYWJsdnlFZkFZTlRXYTR4SlFiMURydE9ybzJtVzhaVGNjOXZY?=
 =?utf-8?B?NlJzZUV4a2M3L1N0ak1iODJENFFrbmlwb0RSWTdrRE92RVZ2S0xWb0ljaHlh?=
 =?utf-8?B?ZGg5eWErWWM2L2ZtaEJncXg3Ykh1Z21zUVdIbUxmNEp5aUp4R3liOWlKS3pv?=
 =?utf-8?B?VlcwbG1nb1EzMGxnUFBiSVoxMC96YkxsQlNiT0ZoRFRtcEV6ZXBxTWh5VGc5?=
 =?utf-8?B?cWR3eWJuY3BXTWp2Rng3Slc4ZHp2RmE4R3h6K3AxTWpNUDlwWkRURGVua0FN?=
 =?utf-8?B?bGhqdzMyR2xYRnFsNWxJUHU2VXprUEg4ZWY1MGplZFp2empQZWpqMGdZNHcy?=
 =?utf-8?B?T2U5S25ZTWFQQ2c3M3ZNNVpxd2tneHR6STg1TXJCTUVITHZML29QbkFvcGpw?=
 =?utf-8?B?YVBwaTd4MGkwVWRUalJla1l6UXBBUkNXZnFTcTJsdmJ0bFgwNmoxcUhkWTNR?=
 =?utf-8?B?OWxqQlBJcktWb1VOQ1Y4clVTck0wWnZEaGlPODNKcVdIWjhZNG9GWmlWSFNr?=
 =?utf-8?B?b1lLZHcyb3V3ZEhwSDVvL2lvanBVZG8yWGhaQTFmOXFRa2VVV1pTa0prK0No?=
 =?utf-8?B?aVpHNmU0UTR0MFFUNmZxMEVOVXM2Z3BrUmtrSm81VFdLN1lpRE42VVM0eDJ0?=
 =?utf-8?B?VXVObzBrRGVZN0dkQnA4UEwzYjNkbnM4VGVoaE5qUkxFeERHOS9xR2w4Szla?=
 =?utf-8?B?cTgxNmtUOWNDcldWcnFxT0FtSTF3N0xFaDFuMFpqQ3JOMHNQbE92ZjNVMnoy?=
 =?utf-8?B?VTRQZ1FVU2VOckQxdlZWcnlEK01oYWFaOCtZa1ZzYVI4RkNPSGUxWkVsRk15?=
 =?utf-8?B?WG1taWxSVXQvaFJtQUFkMjB1T082UldDSkFJV2EwRnZBUWJIRXdUL1I0V0M0?=
 =?utf-8?B?ZjBTb3czMUs2Vm12UFc1dFdPM1lPSXZwZWNCbFBxUUc3RVdMRXJVWHJCVDRi?=
 =?utf-8?B?OGh5Z2FFYlQ4TFNjM0xmZ0F2VmhaZXhDSkduOHNXYm56dElNVjl5eUxlSTdz?=
 =?utf-8?B?anFIMGNSL1ZLbkJ2STlTalF5YU1kMjlxMVg4aThrWHo1bDhobStmRXlmWUtT?=
 =?utf-8?B?dVArbm5DU1lRTjczdlhPbU8wMVlITERGR3NKNkFrUEhUc3JWQVNMa3pnMnN1?=
 =?utf-8?B?Q3IxK2JJWCt1ZEZLRmFVUWw4VUQwV1JjTFV0UURjOFJobzRUUXI2cHNDU09a?=
 =?utf-8?B?VFl5SisremN1Z293ZXhXcUlpWUdFUVhFY3F6NTVMdjU4MlRiMjgyUmdvTXJG?=
 =?utf-8?B?eDFoaW0zU2ltTkkvTVpoNVRVNE1CcTk1dkJVczJHa2tzcS9peEFwVGVUaWtm?=
 =?utf-8?B?Rmc1dHBDWlFWeVc1M1hSYkYwaXNmTmFBOVNJVjdZT3dRZUFWNUtLbHJuZTNX?=
 =?utf-8?B?bGRSRUVOTGpSVWttYVorUjhJZTFVU2tnZFo0OEJhSmpyNEsrQVdaSXloS1lo?=
 =?utf-8?B?dHhKUi9GYTh0NU1DMXFyVFp3cVNTYXZVZittYVQ5NjFDYWpUNy9qL1dvKytG?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 99934e25-6d68-4834-9ee4-08ddc2c1b331
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 10:32:14.8918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xluFsdJWz/hGH6tb89l2QioWgUqjg5oYFDXav0bS6ZQ3UBp0fApN4vzMDGFjyrEgRN+HKkw8YSj/p5kvOkQ5qu8MLu6R/0qlBMcJrBQrnAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10980
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

Hi Tom,

On 7/2/25 3:03 AM, Tom Rini wrote:
> The rockchip usb gadget driver cannot build without platform specific
> headers being available. Express that requirement in Kconfig as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
