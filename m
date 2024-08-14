Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FEAC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 16:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A19A3889BA;
	Wed, 14 Aug 2024 18:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="von4oI6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A242889E9; Wed, 14 Aug 2024 18:44:50 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADF288859
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 18:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpwzJS0lP9pfN00UxO93x+BboOkn+XNEN7d7/P60cXTzgcJWs6p9VLEIQKW5urOXWiVsYqXzldVxDn8bcB3B2McSBgMBR7HfmFZzuZaXK2q2Fp+kKghNQmYSbRTBFkj8tc/4x7ztKBJdFHSTr6c31Dd+vF1VvF4uovJ7QxOEOi2/r1xI/1CsvgxpyF7idqMk9Z8ULkrNyIz7PA5XlV85EdE0nkL0RsEwT8MxOvz67JQPTf5bA/cbGspwC6ySDdGtL8ixi/IimEWmkpa/zbDB3HgCGKIsgW/UWBTEEeGNQRXuILYyJ3drKh0ALbcm+SYBPQmmZ6ah+q+uHIrSuUAzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHwCWNCSegkRWrlYJODu37Truadq1cI3U8+3isxJGM0=;
 b=XcpJvEV4OpayjlxiW4D0sGveMSLlEeAwOhNOfEuWQTn1V8mEtrplh0M4WT0EWj3zB4WoY84UQmL1qpJ4nUAczKkarCjFxMMsuMyesYKH1v0VR2Za1Hbs+m92Eh6qn7DCzbBTNDtUX3r80AcMx3oK9XEzZlBQIkBhlfeAYE5KaQfQetx5/zm/e16G7SjkF+rQvLILW33yGtgNICvot42am0XExkpG7vZaWZMqcJVArGSO6jwwZEJgiIUFsMFUk058vE5hfjI+2dP5kQQVqjI2BPDKRUBhYfCSXqubS28N9maOdgYesfnur1yCsvq7C2smznKcep+0hO/1rDtRiwSF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHwCWNCSegkRWrlYJODu37Truadq1cI3U8+3isxJGM0=;
 b=von4oI6ZCYovuW1Wb18roPvgfXsAGCZfp+3wCjuJZoN0urXwaWzRBtZKty/PM6fGrEdOvv4ECUOPVrQ5IH+b9QYR8si6cchqv8HSaNP4kw7Jl/G0akdS8HiUwNtjy/TdfOXBsRoFeYUo/A3fTzmU+E3KahgXot2o3zrWv38UNK+KEFTovr7+HjzZ7sVA46BD8LaGfGwLz11swWtpK0KpZzQBbaVTaihreNsdP5pRJYXBKpWk5e6w1FPLZ+RqqY3x66Cx57hSxV0tR80XVz9Fxn86Xwx2eCalbDoEtLypqTZow3vEiCZ1pkKp7UHoS7ngLH+N0PqGVyk8Dg2ClGms4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 16:44:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 16:44:46 +0000
Message-ID: <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
Date: Wed, 14 Aug 2024 18:44:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7f714c-555f-4edc-c645-08dcbc806800
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEtFTVg5V3Z4bm52RHF1dllXa0VOSVdUeXpTbUZmMlpwaVZqRUM4ZzlHalpF?=
 =?utf-8?B?R2lHbjIwc3lhc3NpdWtFUHpPSjJjSGp0YTVJVWZ1TVhBMXQxOU1SMXRVSWNF?=
 =?utf-8?B?NVlvbENzK21CanRYTWFvOVFjVjRCUzFTcGMrdmlieGJPRnAwTVBBQ3Myak41?=
 =?utf-8?B?THVXczltSTdySmR4VzJsY3k2NmxwUmpDb1RkQTFDcmk0YWxoam9heHpNNmJO?=
 =?utf-8?B?aGxDWUlGSy9Fa29PbWdPWk44WTJxYkh0RnBOVHVDeUVIcVdKQ25tcVRMMFF1?=
 =?utf-8?B?RTBzTG5DR29jOUU4cXRVNkdXb3RhZGRyZ2ZHOE0zVEF0RFNLQ3R6YUlMdGZq?=
 =?utf-8?B?KytTOFN2WXlSSnM1emVPcHNPM04xdjJaNWtDOTJWdlpCaFBETlY3SEFKLzhm?=
 =?utf-8?B?RWJoLzJkbTIyY0doNVZYdzR2OXJrWjhlK0I4TFl1eGRYT1dSS1cwekpHcFRR?=
 =?utf-8?B?b3dKcVEwWkxVYktmYzhUZFZXY2E2NDlsVnpyL0NNRlFVZUt4WVBCL0E2eDhU?=
 =?utf-8?B?anBJeGRFSmtiYVl2bnlheXpFc2tWbXhDcmt5MTdxZ2xrTytXOUNnQWpzRVBX?=
 =?utf-8?B?MlBPaEdpOVJ0ZVBpRm1nZmQ5TC9NRlkyc3p1KzJJZWN6bEZWb0pxWlBJS3J2?=
 =?utf-8?B?Qk93aDJmY3FNOEtNVGpWT3h4WmFmTVFiUDFtTVlHZ2h6NC92S21SeDNrQlBI?=
 =?utf-8?B?czJ0UzlQZytFelRVbmhzbzJiN2hhWjN5RUZaK2VqRS9mZlVuOFUxUXpqZGt1?=
 =?utf-8?B?QTVjWkIxRUxqcWZ2NHFQUnpHZXdZVm41QzZiS2JJSWVtSjNRazJqUHRhQytu?=
 =?utf-8?B?d2Y2MExyLzI2MjhYV0QxSXpIUWN3b3M4ZGJBSTAyRTU1YnlVYVp0ZW5mQ1ZP?=
 =?utf-8?B?aWwyTTN5ZUZsbVU4dFgwdkxIZG1TNU1iMjdvMmVIektGdDBSMDFudThrSXFo?=
 =?utf-8?B?empiZjVsT0JJckMxa1c5SktBWGs5OEhpMVNhdmQ1bE9XTlROMDhLcUx1TTdZ?=
 =?utf-8?B?a3V2ckdROGNqUCtGNXRnRC9FSDNQNEtvbmlQaUpLZlhwNTYydm9aS2VoNTlL?=
 =?utf-8?B?RmZiTnUzalpYSHZDUEJkQXNzSUN4NndkYVljSGNxM3gzMXpDUk9rSTRCSEda?=
 =?utf-8?B?a09iQk5tRllzVHY0UEpFeDBkK2ZyaFZPYWJhdURPcDMvWXNNODRXYWFtT1pE?=
 =?utf-8?B?Zm0xVVNBTk1PZmdxQlh2MlZDOHZmR2NyanhaWGhGUlROTkNoeERURi9NWUhu?=
 =?utf-8?B?VDR6S2NkYmluUUgzdERJRTRDcWdMYUFSZWVuSzdaWGVkWWYvQzc1NENNMUE2?=
 =?utf-8?B?NUFsMno1RzhTMGlGSlV5L3BwbWVNYzEwaXhvZWhBN1l1d0U2M2RCbmZjRTJS?=
 =?utf-8?B?R0NRc2RMY0NQZno2V3pjbWRUT21tWnFqcXRNMjh4MFpycno5MFJlYnMxeHBM?=
 =?utf-8?B?TTUxQWx0QS9OVmtvRXJtTHRXM3o4Vm80YTQzdFdmWVgwMzdETW1rSTlsYk53?=
 =?utf-8?B?eUNDckpSNnhMWnlYeVlxVE1hTG1yM1c1YXJGaXNUejlVTjhZblFlWFZZQVMz?=
 =?utf-8?B?cWovYXN0czluODBpSDc5UE5oRjBhVUVnUHBjcG5MQ2w3bWpUSVBvdmpQM1JH?=
 =?utf-8?B?NVVQVW03bG5PNnhBRU5pVWlabkw2a2lUQUpJUnovSDExRnEyYlQwRjJsYytG?=
 =?utf-8?B?TkFJc1hWZnRSY21sRVl6VVdUcGZuMlNQTjNyU2JXejFIdnhkR1F1Yk41eTFh?=
 =?utf-8?B?dE5BOFNKb0JIbC9nbjlndmc2T3hTdmxMb21LS3FlQkFBZHBGMDViMGlzT2Ju?=
 =?utf-8?B?eW1xaWJKdzV2M0RzZEZTUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGRGTzBzWFVrUWRncWhVVmFieFQrZEtFeHBhOGhOcDlwUWZTdFZubnBoR3Fo?=
 =?utf-8?B?aFJLZWJmOVBOSit0Q1hNdmpiMTA3ODYvaXFCUCt1QktDeUpYNFZnUklpN3Ux?=
 =?utf-8?B?eWU0eStXb3RwYlpScGs2STE0cFF6SERrQTlzcndIQnVSa1hUTXdCc1JPTmNq?=
 =?utf-8?B?OEJBdkJxTklzTjhyQmpoRmp4R0E0T2dYdUk1SGVOcEEwYmdjS3V6dGtJSERF?=
 =?utf-8?B?UFY3MkhZakRKMDRyOXZSdThveDhkWkxoS0lIbzQyTitEYTdMSVNVUUwxN2xv?=
 =?utf-8?B?SURQeGRRbzJsTVV6NTEyRnRWSlBQVkd2bitWN045S000aU1JalpaY3N5blVM?=
 =?utf-8?B?OWEyYThpUkFLa3FqNWlkS1d0OVhjQzNtV3NOdDlnazlLQTg5THNjV3UzOXpa?=
 =?utf-8?B?ZVZWRjZhWFV1WktHdFNOMzRmNFRBUW13WW9lMnRLWmJIQnM2eGhzUCt2Y0xT?=
 =?utf-8?B?bU44a2NSazVpS1gvbzNWRkVZOThzUTJpOFBZNFNzR0xFd1Q1YURINzZMdUNN?=
 =?utf-8?B?UkNDcTY5dXk0Ry9jcGRsNVRucm8vUG40L1Evblg3ZlgrT0E2KzlnOVZEaVJH?=
 =?utf-8?B?UmpDZEsxQ1ZVMnJWT0wwRWxpRGxncDcyMEFKV2YzdGswQWlmRGJIcWhsZERN?=
 =?utf-8?B?cVlCRzE0UGxvRkUyeFNaVzdrQjVYaXo4VUpvS1RKUCtIRUV5TDZXSnArazcy?=
 =?utf-8?B?Ly9xbTZjS1dhZi95YmNwSThZM3B2ZCsvZy9YM09RYlpaRktMaXIwOE1FODJa?=
 =?utf-8?B?RmowdlR6d0R4blFQYU1uc1llWXdGUGNpVWZuSGlBdnk5SkJEUXcrNDVJb3BM?=
 =?utf-8?B?RW00RVdScFd3bTlOY3pGbE1wbGF2bzV6YUFrWU5FVnBtd29oMkIrTjdXTTZH?=
 =?utf-8?B?ZHZYQXJBWUwraTZJcHhCT1ZMKzYrWHpoQXRpU3NJcXNuR0w3MVp0UEZtb3JW?=
 =?utf-8?B?enJkODVkMzVTOExlVkdvU2M0NHpTa1M1VjFja0tsdjBoOWJkOElxaXdCQmRU?=
 =?utf-8?B?cUs5T0x3RnlWZmJUK3JNcFJRM29kMWNNRGh5d3hFK3RwNEdTblN4MlVlZzVu?=
 =?utf-8?B?TGZMYkVRWWdIdmNOWURobm9BeE4zZ1Y5VWMzdjJTSnN6T3BxMnVjemUrVlYz?=
 =?utf-8?B?dWdyRDdRV3BUU0hDeXFnY2x4M1VpY0NRZXl5Q2ZjR2cvMTNYNFpMSytuK09L?=
 =?utf-8?B?dm1kbkJJVG9JeExzV1RHWWFPNnh6TVBRZVdvdklQSExYQ3hzVEFzdytZalF2?=
 =?utf-8?B?UmhIUlBQYS9uNU5CMmRITTNJdHhESlNvQ242SDEyRnFJZTZCanY4UU53Z0JP?=
 =?utf-8?B?VCt2bGF4L3pKV3lNVDRiLzhCdlQzWmo0L1JzbnRtTlZzOS81SWdlSEtrZi9T?=
 =?utf-8?B?TDRMMDVORG9KY1JqV2FDdU9rejc1VjVueWxGclhHTURZY29CaTROZERBbkxW?=
 =?utf-8?B?ZEIwZHhJR2RPdHVOTTFnSmF3WE5UbFJWY2dWdDVNeXNnbnVxblkwbCtvSW1v?=
 =?utf-8?B?dEdqZStMbnJYenZZRHhBc25kU2lDS3lScytQNnNLbDFncUQ1L1ZGa25ybHhR?=
 =?utf-8?B?OG1PN3BBVTlsNGozbFNrV2F4UW8xRW5SVks2Y1I0QUw0dHZITjBRazY3RER4?=
 =?utf-8?B?T2lWTjl2dGk1SWQ1OUtabzdCdmdwelRSZzFXaWhZTHJpUFdIQmkxUkNNUzZn?=
 =?utf-8?B?d3J0RmYyUWZMWTZ1TVFPMlBiL2tpRFJaWTVHbXJjdkNZbHlkbWZxWG9sQllk?=
 =?utf-8?B?NWxsbkEvcS9Xam42Nk5PcURkTjlNUWdXMklvZ01jVWMyQS8wREMzUW1QQjVP?=
 =?utf-8?B?Ykd1dXR1ZFdlZ3lRcy94QlE2UUtuTm1LTGF3M3duRWNHQy9sOEV4dWM1NUE3?=
 =?utf-8?B?M3RYOC9sK0NhVyt6K09oWktaaitSYk1MeDhJTFBPVWYvU2NPZ3RNSFd1M09j?=
 =?utf-8?B?S2xNcHVWdWlPUWpmM3hIOW05TmhsUTRJdFJpbFZ6NklTdm1HTWdhVEVGYVVr?=
 =?utf-8?B?QnhLbStHUlRGWlpuL29KYmQzcDdadFpuUDkyb1BTdkQwTm9kbDFtRHRTeEtm?=
 =?utf-8?B?Qm5mS2NRWUp2VkVrUml5TitoalQ0V096UXpRYzNwT3pOR2kzUzJ5c0dSUlhr?=
 =?utf-8?Q?/e1zb9u+3roX5eW1BrLRhyhLQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7f714c-555f-4edc-c645-08dcbc806800
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 16:44:46.7881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oMACl6OoOW4wclf5dInDR0n0AtnntzWe0JOE3GQ7cGA0oO0/StRMaw8cbmgaT4+q+ugjkJQHCuzbCDYvgt5Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3742
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

On 14.08.24 11:41, Jan Kiszka wrote:
> On 13.08.24 14:52, Nishanth Menon wrote:
>> On 11:16-20240813, Jan Kiszka wrote:
>>> Hi all,
>>>
>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
>>> facing issues because I need to still build the u-boot-only overlays. It
>>> is also a bit weird (but works) having to specify
>>>
>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
>>>
> 
> Actually, this does NOT work: I just had a long morning debugging SPL
> which no longer started because it picked the non-filtered dtb. The
> filtered one ended up in a folder outside of the u-boot sources because
> of all those ../ and hard-wiring to dts/upstream.
> 
>>> for our spl dtb.
>>>
>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
>>> I'm a bit lost in the Makefile forest.
>>>
>>
>> Sumit: Any suggestions?
>>
> 
> I would really like to hear some better proposals than my local
> workarounds to far. They don't converge although I already patched some
> core Makefile (overlays are building now).
> 

OK, I side-stepped the spl issue by using one of our variant DTBs for 
spl as well - happens to work.

For the overlays, I need to add

--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+include $(srctree)/config.mk
+
 dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
 
 ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)


in order to then be able to do

--- a/board/siemens/iot2050/config.mk
+++ b/board/siemens/iot2050/config.mk
@@ -5,4 +5,12 @@
 # Authors:
 #   Jan Kiszka <jan.kiszka@siemens.com>
 
+ifneq ($(CONFIG_SPL_BUILD),y)
+dtbo-list = \
+	k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
+	k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
+
+dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
+endif
+
 flash.bin: all


Does that make sense?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

