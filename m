Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78C6E7719F
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 09:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7741805C5;
	Mon, 13 Jan 2025 10:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="eMbXbtIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF996805DA; Mon, 13 Jan 2025 10:48:31 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8519801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 10:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUokh7yqE9L4abgBrlMMeif+qGdSiLtFZAZrd29x0B/fPARWjw0jo6iX229XJTgBL2BnRUwt6EoxBlGiwekLPKxHq69bf2SUFlB6kdiRPWf+iYA9sbZDBmmpjvvxmPmzWkwMsE1JqfUhsQpdbxrhGgRAiqm5KPbM1wNfKnnozpsT4adPj2gAyXYgI1xBw4Gepop2qtvJlq6/k7fGeZaSF2WOLu7xbHZHhf0F82In2M9Rpc7IKrdbwgjtsMSOUFC2AQlymfrNXz0ZB7af+mAelLAcTvf0lLADafFOECco4CUoUndepgR7kJbzkAQNgxYcTgwEQj0tJ/XB89MYfyhKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RkWf6R1XQlxCFa3TOptakzOTJR7qC3/gEXu8x0QZYo=;
 b=eLKi95OspUM0sIXvZtwd32BaERNSHC2mX31we/bp2GdNzgQzzvbAEzy9aHFdQ7rpdwXZLzv09Kv+6GaSbAZusjGit48KDWN+ogNxp7zA4ZasvivepVWOAPKcYUSLI5joQAp0JGC6dhTf6P6Sp4j2UVByzrgdb+acnTmOY/N+t/gUn/LOJMbmXCTUhQFMi9hBkh2be7gD6X+1ArKiFZPHOwUNs2cg4+MusgyCg10kANfV4Qrbhegte9x9T4NDjSTFw0AGYaM8XTPlA12BeiKwsAcsR6xcXlmdT3eSSqtgdZvH9qMbIz5zSRFx5Eo/0VkC4zosctPrdGt5X4XEM1MkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RkWf6R1XQlxCFa3TOptakzOTJR7qC3/gEXu8x0QZYo=;
 b=eMbXbtIKUcdbTXS2gVnh8icEfo0vW13gyYnecfOlY+uAf+pQRz+dpbpDlM2oaQ02T7o79rvlMkohpww68qu79ffJKn+4hOzEQ/WE7Z4ir0ANWBLuSAHZ/WypdLbRfSSSwmQNTkUIpF/2zx5tKnHvD6nf9INPqP1FoGEZIsHjLO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6656.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.10; Mon, 13 Jan
 2025 09:48:27 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%6]) with mapi id 15.20.8356.009; Mon, 13 Jan 2025
 09:48:27 +0000
Message-ID: <1ad10326-67e3-42f9-b8e8-b8a19781f1c9@kontron.de>
Date: Mon, 13 Jan 2025 10:48:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
To: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
 <20250106013311.GA8414@localhost.localdomain>
 <CAFLszTi2ya3V4SDfpZxLzzyAdyM9KN0MGuZPnK2XeO8wRNw69w@mail.gmail.com>
 <PAXPR04MB8459B6A69CA0713B0B51058988102@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAFLszTg8UHbgHnFM-6JjYFK5pd_+HW61_jzMM-eeV9+hQgOspQ@mail.gmail.com>
 <CAJaLiFy2FTtxgsb4N8GB8wxTsgyi=oPzSnjznsa_DRAbTSTixw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAJaLiFy2FTtxgsb4N8GB8wxTsgyi=oPzSnjznsa_DRAbTSTixw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: bf178f68-0469-436d-3bd5-08dd33b76e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THdLQitET2NPZndpUjgwVW1PMUtncGhvM1VITGJmY3pGUklzVXVhUXE3cEpF?=
 =?utf-8?B?M3QrU2s0UW1wdG54N1BjK1FGNnlBeDN2Z2lQbUlnNU9RUmlPRE91T0NpK2ZP?=
 =?utf-8?B?dXAvck91dXZTS1IxSkltSTBEb2gzUFUvYzhQOTlwVkxMRWVDWHliT29CYzBk?=
 =?utf-8?B?WDdyZW55SlZJbnVZcUR3ZG1KZ2phTVRsK0g0UFEyNFpkVmlOQ01ZSzFvZXhk?=
 =?utf-8?B?RUNQbnVCeUlsSGtqL2VaTHMzM0ZONEUvTnRDNGFycTQxSFpZazNHZ3EvUzgy?=
 =?utf-8?B?dUs3NTY5dzA0c0EvL2dPd0hNNXZTZ2wydXRqV1V0NnlLa08zeXQ3YU84WVY5?=
 =?utf-8?B?RGlkWWh4VkFEaGVIejdIWko5VG91Z1BSMmZqZXM1ZjBJbDlFN0F2R085bnZr?=
 =?utf-8?B?cEdXbG1tUTQwMnJjWW1QWmt3aUF2Z2hxZFBKWTByWUU5ZGR6UC9acDgvaS9X?=
 =?utf-8?B?QjMxeFJwSVhaQldhZkg3LzFXMkErNUV3ZTFJZjlXMFcrbE5XWEY3c3JCazY2?=
 =?utf-8?B?ODU4TWtDUGpzOExpUlRvRkxjbzZOa0tvNTdUSmJMZ1BIdmhmSjJsandodnY1?=
 =?utf-8?B?TzFuZkxFNkcza2JINUtFaklYMEJkYURrL3BjemdoYUJRYld0MnRYaUlET2VY?=
 =?utf-8?B?bkR3NEhoaFYvVFEwVVNJbCtuM1NZWFhxUlVoaG1jaDE3NGwvdVBoLzJsRzk0?=
 =?utf-8?B?d2ZSMFBLMGlzOTZZbWNZUGMwMVdVeGlKRnlqYkJBRDZvc3dNQkhzVUdDN1p0?=
 =?utf-8?B?Zi91UnV1OGpZa2N4NEZVaW9zbVZEZXhlbnNkKzlRWHpiS1JNSnNNNUlTSWZS?=
 =?utf-8?B?T2QvcGNDY3FrcEdHbWx5U3lWaVM5OHQ2SjJ4UGpCY05wUG9XNTBwYWhXY2FY?=
 =?utf-8?B?M1R2WmZRVTB4K3lTeFhMQUo3NFZjN09ubEkzdTlmdnlwSDFpSHlBSjJxcmlH?=
 =?utf-8?B?QzhMMEJaWXBPTkFzTmhUcytScmkvWjAxMGNScDB4YTFvTkJ2b0h1YVU3a0tQ?=
 =?utf-8?B?L21TM2xsTzZmVFhnNHEvcnhQMmdncGJxUVNrczVXZmkydFJUTTR6NEcwZUtJ?=
 =?utf-8?B?NTNhU0NLVnhMN1c1bjRma2Q5YmRPMFFrbTUwSTJ5SzdISVA3WXk1TnJXWGpw?=
 =?utf-8?B?akNyUHRRZDNFZDYrNE5DcXNDM3FQSk13Y3huaHpGazVuWEFadlVacjN4anA5?=
 =?utf-8?B?UjkvYjEwWmx3Z3JESWkvQnJBeE1PNC9lNUNjV0JxZnI3Q21vaGlISXltbXdh?=
 =?utf-8?B?bUdRSzBRTEE4UFROeEtYaXRUeDRyMVFZTW9RSTVaaDRZMkdMVnlTbW1LcjJU?=
 =?utf-8?B?NEZLWmlpNEVhQ0pESUFuL29uNGtzUG9vZHk3RjF0VlhYdlZ1Y0xFMlc2aGt0?=
 =?utf-8?B?d2diZHYwSFZkYi9JQXZnbmYwb3hFbCs1N0lNZkl4cnJMU2pJamh4dnRpM0dR?=
 =?utf-8?B?WHV2RzEvUVRkWlhXLzRkZjBueHRWaTI1Sm9pdG5YeWdZY1FpQTNIZk1oOG1s?=
 =?utf-8?B?aHpnYmM3T0pobVJrQWJzOGdYazZSV09oNmNvVG52SWZLWWpORjBlV1VXNFkw?=
 =?utf-8?B?bXZ3bUFBaHgzNkhMZUYvY3dhYjNsbkUxNGZIS1hkZk5LVHY0Qy8rZ0w1SXVW?=
 =?utf-8?B?Q2R5ci8yRGthZFovR00zWFE4T2p0KzBqYmtKVWhiNGxvcTBSNG45Qm4zbFNp?=
 =?utf-8?B?YnlwRVJVQWJTbFRpSStTUkw2TW5YbWdaSWxJRW5hTDJDM3FoZE9ZMkI2RGg3?=
 =?utf-8?B?OEJZays5YmhIVS83MFp1S3FFejdQbk1tUm5RTkpSVm9kZFJ3TE9IeCtmbjRZ?=
 =?utf-8?B?VGhFNnhMaDM1TnhWNTNZcTJxVk4rWEdnQTFaRWdmcmlNa2JobVIreHlxWktx?=
 =?utf-8?Q?HPcU5MWrcrtCe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWRUUHpKcFJMcmVrN2ZPWGtoZHN6ODl6TkdZRnhQZjBEWmROVWRqbkwraHVp?=
 =?utf-8?B?ZnBTVEdsUDRTVzJxUDJtWTFQb3Y4YjlDc0FHQ2FhUlBPMFlubmE5Qm9xSFNh?=
 =?utf-8?B?emg5bFJQMUNIWVE3MGJYcWhFcTA4bDcwZDVIVG9iRWw0YkZlZzNFQUp3MEFO?=
 =?utf-8?B?NjY1OTdsclRNelhtY29uR3pkSjMyc2lvWGg0UVlBRXF6SmFkc2lVTDc4ekl3?=
 =?utf-8?B?QU9uMUdmcEduREZLS2VqL0dnbWdoWGF3MThNZXVxMGdRbzZsenk1YkUxVlBp?=
 =?utf-8?B?R1cvYVZzYS9IMUV6cDkvbUlqUFdaaWREaXpjREJFc0x0VkhvY0wxbjdvdzRu?=
 =?utf-8?B?MXFLMUZ4VVAxMm10R2FMSHNPSko5MHhvWkdWY08wNEhHRG9ESXlyaUd6Smxj?=
 =?utf-8?B?WUlXTlo0N2NidFZreTBZYU1HRXFscUNNYTZ1dEFUSTBDN25tSGFQRW0vVmkv?=
 =?utf-8?B?NUJwNEI2ZDVmNjVNcjBmZ0NTVWxTWjFSWVY5cE1iZUhWOWF6L3poWTZ1WDVo?=
 =?utf-8?B?Y3FuTVFXQzFRRXlKZmZodTZIREs2VnN3N2NrcTNzTlZEVkg5YVl6Y3R6Sy9w?=
 =?utf-8?B?TlpuTUFSYlpCWUwva1YxVFpxQ1ZxTDNrenhicURCbmU1MUZ0eTlqRXFpZ0tp?=
 =?utf-8?B?Rm9WTmhGUjFyVjlZOW8wQkxSM1VjSHFRTEN2WFpUbFhXSnhUWFV5Ykp1RFpK?=
 =?utf-8?B?NlZyOVFYdVRlc0VDREMxSmFoY3lwRjV1MXNsUjh1ZCtIdXFZRDhkL1hIZmxZ?=
 =?utf-8?B?Yy96eCs0Q1E5REtjQitHTERVV1FEbzMwWEpMMm0rZEpaRWI1c0lRUEQ1dTRY?=
 =?utf-8?B?OFF6NUFrMm1mbk40VlluY3lsWEg4dWNTS040ZGNacEhobEdLOTJZUzNYbjVS?=
 =?utf-8?B?Y2d5ZnNvZG9pQmJKcHJBQVlzdU5pUmIrSlYzSlVtWDRMTUVrL1dqS2REdDdw?=
 =?utf-8?B?R3ZHc2dhajV3azg2bGk0RzZuNGdQeFROVnhpb0grQkIxc3NMV2hxVHdqOTJj?=
 =?utf-8?B?Y1M0RGJST2RUMGt2UDUzVDVzSHFYNDlJa1llL0gzd2pUSHhsZTNLNDkwa2Nl?=
 =?utf-8?B?R1RsVEVmdU9ocEdUVHNiSXdPU0o2V1pXV3UvdXhZNmpHTmtwQTYzNU54SzFy?=
 =?utf-8?B?ekZrMVJqU1hGUTU1bmpBZ0svNGp6aFA2WU56anVGN2hNUytwa1U2Qno2eml5?=
 =?utf-8?B?ZzVCdE51SXpIRjhFWHdOenlhS215Qnk5SVBpZ292SzZQTG16QVdvNjI0NTN0?=
 =?utf-8?B?WFRrRkw5dEFkOVVxcDRnTTErZ2FpVEc2bHVZWUMrR3F2MDJ6TmVUSHBnaXBh?=
 =?utf-8?B?SHNFUW8yMGxJUE02RllKcks2S3A5V0tUa1NyR1BrelJ4NW5ZN0pWbkUzL09Q?=
 =?utf-8?B?cGpOeVVMdkhic0pkZTB5N2t1RWxoUU4xcGRMYk9WZE5Fd1plN3VFZFEwcjNZ?=
 =?utf-8?B?anI4UmgwaFcvQWR2ck41ZU1LeGlEMjZUZVNaWW1BUjlCRmZaOXpJUXQzOGN2?=
 =?utf-8?B?Yng3eHdXRTJ4SEtSb3pKZFVNakxjODM5akpaTmlUN09kczlZSml2aUJsQ1Rx?=
 =?utf-8?B?NEZST0s3NzFnMlVyZVVmaThKTWtMZUExemhOMlpvcXhWRzV0MjZnZFpBK0dG?=
 =?utf-8?B?Y3JETndpcXN3RUNhWmUxcWhEc3FsOEhSSGMxQWFlKzFTZnQzcVQ3dWFOeEdO?=
 =?utf-8?B?dVNuQXlHL3A4T0NNeENkaEx2cGJZODlGT25zcHp3bUxOazYvUFZJcVhPSkt6?=
 =?utf-8?B?ZVlNSExaZFFxRWRuRWQ0TitOUHlxdG42MjZkZCtJeTk3U21DQ01ESE1DMFp1?=
 =?utf-8?B?OTQxOUNQR1RWZzFyV3U2RzhZQVRKRm55a1RtZWFBaUZYVHhDdEM4bVRXUmQ0?=
 =?utf-8?B?MC94TzN3Uk5odTRWVmhpWHRQaTUzTkZRTUg0akZUN05RUGh1RUIrNW9DYVpi?=
 =?utf-8?B?dWJCWFNydW4zMTUxdUppZDhoaUV5YnFtVklMTlUySnJRNzBsNlUvajdMWTVQ?=
 =?utf-8?B?SFBPUGgyRlNMT3JtK2loSUV1d204MlBrOUtEclhnVVdIRllwVWdGQXlVZElO?=
 =?utf-8?B?MnVSdVlwa3JqRUoyTjZpZWtsWWtTRWZpQTNmUFFFSWpLNWs3UVlpcjh4U3Yz?=
 =?utf-8?B?SUZxTDBhbk02UnNRWUdtR3g5WmdVcVJrRmw3YzdrcTBOZGpBQkZPZytOV0w1?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bf178f68-0469-436d-3bd5-08dd33b76e2e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 09:48:27.8266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcDzt7oseNFwxS6gQrK3G2C6SPDZ7sWMrlrGnBTZDlVGfE62mR2o90ltThZoixew9S4vRVdNwAjFo4qjI/SSdO79pPmodThhK0y9plAOIEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6656
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

On 07.01.25 12:45 AM, Tony Dinh wrote:
> Hi Peng & Simon,
> 
> On Mon, Jan 6, 2025 at 4:15 AM Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Peng,
>>
>> On Sun, 5 Jan 2025 at 18:14, Peng Fan <peng.fan@nxp.com> wrote:
>>>
>>>> Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1
>>>> EVK/QSB and i.MX8M EVK
>>>>
>>>> Hi Peng,
>>>>
>>>> On Sun, 5 Jan 2025 at 17:27, Peng Fan <peng.fan@oss.nxp.com> wrote:
>>>>>
>>>>> Hi Simon,
>>>>>
>>>>> On Sun, Jan 05, 2025 at 08:30:55AM +1300, Simon Glass wrote:
>>>>>> Hi Peng,
>>>>>>
>>>>>> On Sat, 4 Jan 2025 at 16:19, Peng Fan (OSS)
>>>> <peng.fan@oss.nxp.com> wrote:
>>>>>>>
>>>>>>> Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd
>>>> as fallback.
>>>>>>>
>>>>> [...]
>>>>>>>
>>>>>>
>>>>>> This also switches to a text environment, great!
>>>>>>
>>>>>> For bsp_bootcmd is it possible to create a bootmeth for your use
>>>> case?
>>>>>> If you would like to take a look (separate from this series), I could
>>>>>> help with any issues that come up.
>>>>>
>>>>> I just give a quick look of bootmeth, seems needs extlinux or
>>>>> bootscript (boot.scr). But both are used on NXP i.MX release as of
>>>>> now. In NXP releases, we put all script in the U-Boot ENV.
>>>>>
>>>>> Do you have suggestions how to move to support bootmeth.
>>>>
>>>> I'm not entirely sure what you are trying to do with the bootcmd,
>>>
>>> With a single u-boot, we want to support Fedora/SUSE/etc and NXP
>>> Yocto releases.
>>>
>>> So add a bsp_bootcmd as fallback to run NXP Yocto releases.
>>> NXP Yocto releases not have extlinux.cfg, nor boot.scr, we just
>>> have simple uboot hush command in bootcmd, simplied saying:
>>> run loadimage; run loadfdt; run mmcargs; booti ${loadaddr} - ${fdtaddr}
>>>
>>>> you could write your own bootmeth, e.g. using common code from the
>>>> others. For example, bootmeth_script.c shows how to run a script and
>>>> bootmeth_extlinux.c shows how to run an extlinux file. You could then
>>>> create C code to perform your 'bsp' function, e.g. a new
>>>> bootmeth_bsp.c.
>>>
>>> I will give a look, but this seems we need put the "run loadimage and etc"
>>> in dtb and needs bootmeth_imx.c to support it.
>>
>> Note that my suggestion here is as a follow-on to you current series,
>> which I believe can be applied as is.
>>
>> Anyway, as a starting point, yes you can use run_command() lots of
>> times in the bootmeth to run the things you need. From there you can
>> potentially change some commands to direct calls into the U-Boot
>> functionality. The idea is to be able to locate the bootflow as a
>> separate thing from booting it. I am quite happy to help as well.
>>
> 
> Can we call this bootmeth_internal, and have it read the internal
> board/xxx/yyy/bootflow? And then this "default' bootflow can contain
> the envs scripting to boot the board when all other boot methods have
> failed. Of course, it can also be executed manually at command prompt
> like other bootflows.
> 
> I think if we go this far to add another bootmeth, it would be nice to
> make it generic so it can be used in other boards.

I agree that a generic bootmeth would be really helpful. We would like
to have some simple A/B boot mechanism (using RAUC) and I think
implementing it as bootmeth and sharing it across different platforms
and boards is better than implementing it in the env for each board/vendor.

