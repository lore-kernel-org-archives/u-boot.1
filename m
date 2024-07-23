Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7000C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686A388813;
	Tue, 23 Jul 2024 15:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="jOPeXk4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9197288868; Tue, 23 Jul 2024 15:46:02 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22D780C58
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3mg5EiHEbx5Hrqf+SnzcsPKjWyTP9b0B7HJGLsf0yD9yXyDYFmR58WvOqPpQAI9E0vIWpKSl+EPF8TwEWnbyJtnMUBbtppwpsFGecI2pVa0CaR8H7TCaHGfqbeLPJ328s2J6VrsBFHLVk2ORtuHewDxVVkkkuMQF2S7/GH6Yx9oFPH+QKWWObz/5kp2tfhvHKDHurJ8/R7ufTnbaLYk5UCChDUAHnbStztYp8rI3bZ14fyHLoiTrKzs1z8NKyOL2pR2KRbvI6asdxJhAL+h++Him0VrJJhwHa6Mrttval0cewH8DieQ876sY9+6MT3cJ5B2b0Sa1wI3E4MK2t/Kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVUz9MeLV05ngaWdjjRsxW+FDkKLN1C41spdVJRcLzc=;
 b=Ql5lBwWETCTDdProCgkSR/g8h1EHR+I33YxRjXUzYWE4CDGP1H5VRcPEv6/jsvq11DIK2oGV7yxaroZYSxKqPN6ILVmmPwaVtxX/YRP2RhMcKjvacvhnllXEpQn6CJtHP7nBtknhaMPstM+9W1x2uCBC03F5sJUK/MCFCjNuKwWBCOFCa2MzKvtV5TiO/dpJVnRecgljyZNbm+IbSpjEVf7QXPtT1ixfb6I0aOuO+0R7GczNc3GQq3f3Y/xQPRnYfP383uSpAGGv4pz1SOUm8j/X1MwDQzcwKGMh2IUvhWigrGHaTR/Y6JzVIG0+lJQPldm7tsno1r5byDYzaMpZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVUz9MeLV05ngaWdjjRsxW+FDkKLN1C41spdVJRcLzc=;
 b=jOPeXk4oES9N2t2AwqTDyg7Nu9nJM/oO+TDNu9NdVZBHFvr8tucht8CAo9yhMv8HhLccXiimeOMY4Nu2rvG8Kmu7yKTO885mzhlRAY09RmXi1O6AFQ4h7FG/C9nhoxqfqlo18lkXz5xo4nWlQg5brg2CjYRgoe6pmkXHr8SQ56VzQdzXwkkcapzHPbiZUx+bCOUZ+AHRiBTVUce2p7nmqBb0KCUez3Z4f9MDe8eXtZgaoXGLBDmibWo/gSh+T5cJhG0fbej/MmZFsP5Nbow/xj5vJQVRnpwVnS6/NqgNPhBjz1qqhODBAoTK1jVueg0xFMcC7Sr2U9YOF0lcsqbbmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MR1P264MB2596.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 13:45:55 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 13:45:55 +0000
Message-ID: <6d1c015e-f6bc-472d-a437-20638b09cadd@softathome.com>
Date: Tue, 23 Jul 2024 15:45:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] lib: sha256: add feature sha256_hmac
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, sjg@chromium.org,
 abdellatif.elkhlifi@arm.com, u-boot@lists.denx.de
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
 <CALeDE9PSADyPUwBuHH46V2Of-HxyYJbo2VOdfQe-_soS6CHCvg@mail.gmail.com>
 <e874bdd7-273e-465e-8516-3207db9ea245@softathome.com>
 <20240717175806.GS561963@bill-the-cat>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <20240717175806.GS561963@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::14) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MR1P264MB2596:EE_
X-MS-Office365-Filtering-Correlation-Id: ed24579c-2216-4152-4e21-08dcab1dc64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2VVMC9NcW5CNjBxTWxLLzZSZEFaU2kybDVoNXh1ZTZ4OHFTbXBUNGdiZ3FV?=
 =?utf-8?B?RmZBNU5iTUFWdi9pWEhYUW4yTC95SFI1cVRTR28yWllDajRMb2VBdW5DVFpi?=
 =?utf-8?B?OWJFSnByRm9GamNEWjhaM3lVU3JaUGZIa3NIZnVwejNjK2RQbEltQlRITVpx?=
 =?utf-8?B?UUhXTllMRGxzZUZ3ZDBrQzVFaWp4T0hwTEVVbzF5bGlGYkdqRzBPOTBlUG9Y?=
 =?utf-8?B?WE1Rd2t1NTE3WHpnZ3lvdXdIK1dLMjQ5L3FlUCtVdXoyRVFidTgwQmFMYXg1?=
 =?utf-8?B?UGJoZEFUSWp0b0JrcTJkcC9rMnVQWjNpcUJrRExWa3gzcmlaRmNOa24wUWdK?=
 =?utf-8?B?aVdlTGN5d0UxTUoxeGRiQ0tMNG1YVytITVM0S01NSFZqZ2kxcndkSDN5RE1t?=
 =?utf-8?B?aEhvcWlyWmtrTHhMZlA3M3o3NCtVaUxVdFNkODdGYkgwVVVoMzVCSDJwcUdj?=
 =?utf-8?B?cVVsUExhK0o1MmlqQ2ZDT1I4TnZlaks4RFB2Y1BPNHovWkl3THBXOTcvTDd5?=
 =?utf-8?B?Z014Y2JoNHVvRG5MeS9zeE41WnpONkFuN1RhR3ZDdW1VZ2loS2piNDByZkVB?=
 =?utf-8?B?WVptbzJXS1dYTnY4K1RaVFJlaFB0VDFZN1h5KzF6L1VZR3p5cGRWRVFOaFcy?=
 =?utf-8?B?K1Q3Zkg1d3lkYWFvWXJBakZrRURuZmgzZDltRS80UlhyQ0srVEM5dENJcTZm?=
 =?utf-8?B?SjF4Wmd0TlExcGlZa2MrZE4yZk0xeFVaK2hadUFodWhMYjQ4b1dMdTliQ1dz?=
 =?utf-8?B?cjNPTGJVRzZKS1FLdThYdjFpNmxvUnJGZFBRTVBCaE9QeWlnd0lnSjdLT1R6?=
 =?utf-8?B?UWN5VWJMWEtGWFd5Z1llMjFwZ2JENTM1aWNwM2JNelR6a0hxZDNuV3M1RHZB?=
 =?utf-8?B?U0NQbDJicmtIbmtEMm1RaWd1aGFiMERDaGhSTEkxSFRYZUFXZUdYM1hPVWtI?=
 =?utf-8?B?RGIwNzU4QVFzRHc5YmEyWE01VFI2bXpOWk94cDQrS2w5akZNOEdNZHVPbEpE?=
 =?utf-8?B?eTE3djR1L25adVdtYTZ1V0pYMGlObW5uWWhPQkhwMnI4aEdhVS9XYTNIY3V0?=
 =?utf-8?B?WmxGeVZDVFIyM2lNVE9Xb25LcEh3bTRNSGIxeXJkb0U4SFpIdmJIT0c0UTJ1?=
 =?utf-8?B?UWY3MkU3Mnd4dUpWVTFrUGJlcnlxZStIQVdmUDBrWnlWSTR1cGJvZU5qUlFJ?=
 =?utf-8?B?c0RXZzJqODcybmpQMTZyOHpwYytuL3BsSitibFNudmpzZkFpTnZzZmtIc3Ny?=
 =?utf-8?B?azkzczBhcGVhRVhObExkeldFbGk1dFI5dFBuY2pEelhnZFdVVXpud2VrNnBP?=
 =?utf-8?B?ckw4QzJldloxTXllWGtVazI0dnIzb29KcXBGQTQ3cFp0WUtxZHlZWU5haUFR?=
 =?utf-8?B?eTVjV1pDWlN1aUg4RFYwejI0SDZ6NTdFUk92SXBaWDNHWktvYjZ4ZEh1V1N0?=
 =?utf-8?B?NGJGenBxVGdwbHJ5M09hKytRKzMrWElTa3c4dmxJR3NxOUlGQU92eUNYNjlr?=
 =?utf-8?B?S3ZqUC9BMkdZc0Zxd0lyRmR1MUVhT05waGJscDNqU09TS2FUeTQyUTJMNW9M?=
 =?utf-8?B?SThvYkluMm1FQXNVeUpaT0diRWxUakh3M0F6WXJyTGN1OXRFK3IxNHk4cUlt?=
 =?utf-8?B?dDIyVUFLdFVYZUdIYk9IeGtIVHNMQkQ4N25Ralp5ZmdWdWtxbG5BUDhScWNk?=
 =?utf-8?B?UnYxU01XRmpYVlYyeUk3QTczeU9ya1NUaGUyNWFtZ1NxM0gyU0tLR0ZlS3Na?=
 =?utf-8?Q?H/HRE/Lysjz85q+KP0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWRHaHlDaTFkYkovMU9DMGFnRytPeFNpUFhoQWxOOVdCdFk5Wk03czM5WS9z?=
 =?utf-8?B?TWh4Y3U3QWtMVVYrK1I3NjUzK2ZwWTdSeis0S211OHFrcHgvVlB3a3hrYmQw?=
 =?utf-8?B?bms0SkE5a2o5aFp4c3pXQVF6RlRkL1UrQnJjaGFjdnFJblFtdVdDS0dxa3JG?=
 =?utf-8?B?RWN5Z3V1dk50VVpVY3Q0MWFKR1psMm4vNWY4TmRsMkppK29CWWVyQkl2UmpC?=
 =?utf-8?B?M1BNWE4wNEpNMWdMcE9WNmY4TldkNVhMMTRXRG9WMnE4TU5NVG16dEt1NUdW?=
 =?utf-8?B?NmZBUk5OZmxPQUdJRFlObjZhdExUdEVsYTVtVmw1a0VadjJpWDVscTFQL2xp?=
 =?utf-8?B?cnRBMmo4Nnh4WjQ3QXpKZDZRQURyRXRMU1k1VFlmd2ltMEVzYXlVbU44SlNl?=
 =?utf-8?B?ZEp6OFVMazZnbitSUWJYb3psaVc0c2pvV0NEc3VBS1B2WjJGRzRzZGpYTTdG?=
 =?utf-8?B?azY5SURpamZnMzIwbHpwazA0d29hZU1NS1ltMUhTYzh4SWRsMTVpWS83RTVZ?=
 =?utf-8?B?VWRRcE9OVXN1Mm5oU3JNZ2Rad3Q4d3JrdXd0UVdSVnVDMzZweHFoUEkydXJE?=
 =?utf-8?B?d2hZcUgzaFkwRFV6d2xLSk00VkZrdkhkK3pIMkdYUmpSRzF0TnNBcCtWU1FL?=
 =?utf-8?B?Y0xvc0Q5SE5tQjBoeEpha2hGcHFwSStKU3Z5eHFzVnJwdGJwNXE2MTFTWWtT?=
 =?utf-8?B?RitLZHI0dkZNb2ROSlBnZXZyd3M0bEdoQy9sb1FiWFJzUUJWTWtETksxdTly?=
 =?utf-8?B?TURna25pTkQ3ZmtNNUlxOWZJUGw4OUVmeEpIZ1YwSlI5TFRHZzdmRWwrK1ZY?=
 =?utf-8?B?bnRGdWZudlZpNDRMNXA0ZWd4NGtXV1V0dmx4SWFyWGlsbkxRU01BQkZnc0k3?=
 =?utf-8?B?NWxnbm5TaG56REVxc2xpcGc2bHZQd3hQSnZrQ3hqLzF6V3M4cWhrRytCQmlC?=
 =?utf-8?B?TGY5UFRueFJwMzQrQ0lzZDhsa0dhR1lpSFhNZGxvMW8zVHJaRGVjdHU2RmN5?=
 =?utf-8?B?RHlnWHgxMlp3cnNJRUtrbTRMQmIyNmU0YkdkV2Q1MWtBMnZydEhQNlRBeTZx?=
 =?utf-8?B?cmlFNTJuOFh3Ynh3OWpaZHlkN3FLZHM2WXZLZWNlVFk5QTVCckJWdDhkMzhZ?=
 =?utf-8?B?Z3Y2Vmo5emtTR2JWRm5sbkZhQTJJaHZmajVtRUYwZUFqOUljL0pjNmtQNkVK?=
 =?utf-8?B?WFlUZ3MwMFpib1ZIZUNOUGVPMkVPMVZ2KzhDeWs1SGVOV3BjT2tSWlp5MVR0?=
 =?utf-8?B?WUdoemJqRk02LzB0VmtqalVmbUxQVVNzTHFOcWtBQ0UweXo2d2N4K05xc3NY?=
 =?utf-8?B?Qk8wSjdKQ0pEb2kvTGVFKyt3VHdlZVl5U1Z1VWpKTXVTWlRCMTBpazNtN2Fk?=
 =?utf-8?B?YkpsVDIrWnV1elRpb3JrSTZKbnQ0Mm1TUUNKV0xrSW9GRUttTlp3aWU2VUw3?=
 =?utf-8?B?a0NNYy9ZeVM4WGNCWm1vRHhobTd1bUphTk50T2FjOTFYYWxOMDRlamZtenlD?=
 =?utf-8?B?V2E2cEd2bUJNUEJCbW1idmk3akxuWUd5clpJanNiUjRtcnZjL1VjR3p0aWEr?=
 =?utf-8?B?ajVvZVFJTFNFTloreVhzY0EybDg4aUpsZmtZS3FZc2lHdXFRM0F2WkF1RGpp?=
 =?utf-8?B?Nllya0RIOGtTeWlzc2tvRHdzeDhvaEJ2ZXQrc1Y3NnlKY25CbGl5cGU0Rllu?=
 =?utf-8?B?b0NlY0hhZWxiRmR3bHE1MHludmhnbDR1S0djYkNMdlJCQWk3OHM1Wkhra2xx?=
 =?utf-8?B?bnN6cDJQd09neE9WSmJvSStGeThJRGFOZFd6ZmFqeW8vOWxyeUpmY21CU1Fs?=
 =?utf-8?B?SDIveFZ6bUt3QjdHMzBQdmQxaWRiYjZlWERYQWhHVEZSTTJyWDJ6eDE3ZTFz?=
 =?utf-8?B?MHo2WkpuQkdmQkllNU1rZVZJNDR0VStjQ3Q3U3pwTUI4VUMvQTVuUml3QWlD?=
 =?utf-8?B?bllaV3RSZDVOWUNRamxDWm1KVEZwYWhJbkw3amRRakpkTlNzTzcwa3hoWUo1?=
 =?utf-8?B?TmgzbExOcEpQUG85QmVva3FURU16ODZmSVN4V0l1dDJSLzc5QUpLU1hLMk12?=
 =?utf-8?B?YVJBdGFScTdIV3ZwemQ1RVhRRVZZbWQySGhVdEdiWVk5dDJpWUE4UzlVaHln?=
 =?utf-8?B?RWNnSEMxMW9yOGJ5ckYzNitKYWtVejF6dC9aUFBmRjFOVDJsL1d0Q1k4SXdU?=
 =?utf-8?B?dndUS2UweGRTRkEzeTFneDRNaVBkOHUzR3BjOVJhZnBjMWNSRDl5dnN3TXZE?=
 =?utf-8?Q?vrFSI9wznk/o4M7emCGLoCGUDRX242ZlJ8194u08UM=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed24579c-2216-4152-4e21-08dcab1dc64b
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 13:45:55.1589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Nq7QpctR3H5zL/4SjCXWbwHNBdZn5aihWJz8Guo0KrRaJsRYwTmrKvZjYpsWieMNe85j39xgOiRA9cG3mpo5opFoMEG6o2MToibvFTURDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2596
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


Le 17/07/2024 à 19:58, Tom Rini a écrit :
> On Wed, Jul 17, 2024 at 07:08:27PM +0200, Philippe REYNES wrote:
>> Hi Peter,
>>
>> Le 16/07/2024 à 18:56, Peter Robinson a écrit :
>>> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> Hi Philippe,
>>>
>>> It might be useful to have a cover letter explaining what the plans
>>> for this code are, great that there are tests but adding code in
>>> without it being used isn't always a feature so a cover letter with
>>> some details often helps with the context.
>> You right, I should have added a cover letter.
>> My goal was to add key derivation and use this feature to fill a key
>> manager,
>> and then provide those  keys (or some of them) to the kernel. So the kernel
>> may (for example) add them in the KRS.
>>
>> Do you know if there are some work or interest in a key manager for u-boot
>> please ?
>>
>>> Also if you're not aware there's work to integrate MBedTLS [1] and I'm
>>> not sure if that also may provide the functionality.
>> Good point, I miss it. MBedTLS has the feature of key derivation.
>> https://mbed-tls.readthedocs.io/en/latest/getting_started/psa/#deriving-a-new-key-from-an-existing-key
>> So unless someone wants to use key derivation without all MBedTLS,
>> this serie is not very useful.
> Unless you object, I would really prefer to have this been a feature
> U-Boot only has with MBedTLS enabled as one of the goals with that
> integration is to have U-Boot leverage existing and well
> audited/monitored codebases for security sensitive code paths when
> possible.
>
I don't object, I also think that a feature should be only
implemented once.
I just have a question on this topic, I am planning to use
a key manager in u-boot. Do you think a key manager would
be nice in u-boot, and if someone has already planned to work
on this topic please ?

Regards,
Philippe
