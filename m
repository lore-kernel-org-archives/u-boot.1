Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D063BC43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9456884A1C;
	Thu,  2 Jul 2026 19:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="Zx11O9Jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 048B4848D2; Thu,  2 Jul 2026 17:28:37 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d202::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A92841F2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 17:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEy6Wgg5ZKEjGBNZ577D1tZhufh2iECgYthZ1VG6+25YamMEVkwImfAbRnzWDiYbwh3QlNee1Kfh3IBINH5k/WhN2ohsv4XOBusQz7YoBGrUlAitkQfGHn2H3J3YDzA+cIX0UUyEQJPWKwoU9rHWtovhh3H7wI7pOtuRgFxB0lf7LdtCFL0SQDtX/uTuYO2MY+4Ye4utRM647FXBZmp0UNDcqsDd3tA1oFYkQtJAb7z9Yq4QK0ot5b1RQuvPp0bXfD9rmmWCckCJlf90VIYUzBkWc9nnlXQmsT2ikhOtVuvMRvn7sATkcCKv4FmkXp4omKZXRjPjEk+Gt3/dOErWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pdgrv23dFn21IGR+Kp/iv73nBEQqFuylJfb5SRcde6s=;
 b=qty1xTvVmCN4yyHlroqUVbPZALTUTeMTOkOb0gfkk0tFUZs5xdWUJFbZdKoe98rwuhS38d4YVtecYIBb4HT/qFh+YRY5gNHMTdQJoe4YhadlokVnQbnDYp5cYoCaqwfBHTVYvSrdaou//9jGYeU+Oaa2wp66MPpOV6BmdWQV8Ib1nw++ipxL7aIBGsRTk/rB50ODSLF3eg2Ogrq4E3J565O8jiPG1Q3MPfzkP3KcE5C5vupllI+F6t4caiQ77Q2mzbk3/Oyh/gD4lK6LGvFD3hHV7E0ItKyIflK/hYyaZwP4VHWcXWe/+8vX2j48PAuZmal0XWaqryVw5UWxjIH2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdgrv23dFn21IGR+Kp/iv73nBEQqFuylJfb5SRcde6s=;
 b=Zx11O9Jjwfn3SLBytU0RP+K6fKl/ufF7nNZmfAMYs3c7+92vhMeABqqoR6wzVkVAUkEu1Hs+INM9ZuVjKWWLfNrQXV0GvU48H3tXs7x1/IPE8hvCZAVjvJ5GB5nRLMz9ejitdMCq8piEFxLOcxB4BYW/Uz+ENkvqf/KsG/EEokFNwHxzkxcVLO4IaYjGz2qwKOnv1ByOCf7df/S4N0ZtiL6U98UIu1rQV8UIRulFgpVHmedx6fuvu/h3bwldnq07ilDr/4HEMP02lXBCNeE2iEEXwFljQKbwaM+Y64VVVmHGhSxCTrf9r0w4XJiBjKoA+NK9n+WAmMvoju/LdDZeEA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS8P194MB2190.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:632::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Thu, 2 Jul 2026 15:28:33 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 15:28:33 +0000
Message-ID: <BESP194MB2805AA926AB13692A1DB397EDAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 2 Jul 2026 17:28:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: versal: Fix snprintf invalid size argument
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB280518E35381D7CF2CB50C60DAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ce38a9bb-4d54-44b8-b6e1-b88d8eeb9c83@amd.com>
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
In-Reply-To: <ce38a9bb-4d54-44b8-b6e1-b88d8eeb9c83@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0096.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::11) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <7e0a1e3b-d24b-4812-a49f-f98f82e73051@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS8P194MB2190:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b76113f-2af1-4fb7-0863-08ded84e93ef
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRfxGI0BTN71v+8xUTc/To6x+OWP0uKniLEFo6+vvkrgbCCoAvmuuthDRf8Vy3aSrsw+cd83dgqSiM/XwphzjtPa7k+T22u6gwYfsAEuSdFEexGtc1H589Qnrr1e609GQ3WFdTnkwtkUIYkFIRO5nL4pDUHiFsT7wSVDfUCznqLrm0K9JA4TGo6fmOpUZP4m+4eh+MmvpNXPGVv7gdf1/JELxZSdernK6XR583xA6KC2BDu04vNTb4j0J5b67UPIr7IVWG/AEXRQEXZrd2LA4fS4hYgOeG7B4DVYjPOaghqmbMOfIovZMrobh6CYToGFeuZH5DdGDVfyDFcc37MK5J+rQr9ipC7JkIYHa1vhpSHDwDeB+mt61tVdjte3Ts50PfY5S6F2BVPMN6mTZ2tjNen6xyvC3kIJBCEGGClqpmq2Jq3no0fVN7Gur+dlYZ9Kej6oJsIiNFm6i9wSEM5D2hClRof1+mvw/v8ImbSVmgNsDWSP1sNcNYNPaG2zud8uPsk2jtLyZZ+1281jt9CqCdFA7MYmQEXCP8Mz7ky5rLYYh3ICD1Y0HGtzOEVXsUy4nP/p13zBCmcW/+oM1M1teM3VScv1glaHgMm1GveK6mdFD2po2Xx3XjF22UMGBr5owkU25BrSLE+hQkx7zMnljVPETm2Bl3oZKw4U4LHzAFTgh7Z8nHkQK/+O5iGZHRZrQdhVVAwVOVsBi27nT8r86+mCvqb6QNqNtki4wpj1YCZAk=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|8060799015|19110799012|25010399006|5072599009|37011999003|23021999003|15080799012|6090799003|24021099003|55001999006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1V2dWN4ckpuRXUyYUwwQVJGa25CTDFSdisvQTI2amk5VjZPQXIzRTZFSEFz?=
 =?utf-8?B?eHpNMkFxY0RRQmFza2lSRXlua0hxSWw1dER3NmNCMm9LZHZGVHBZYVE0Zkor?=
 =?utf-8?B?cjA1dGs3M2FaM0N5YllaZUdMT3I1dktyalZzMzcxbnJxN0JwcldVeEh0Qlow?=
 =?utf-8?B?SHY1Z1ZoWUhkemVWeUFqbkYzV0p6cWw4MVBEWFhueDdmeVcwTmJBdHM5SjFV?=
 =?utf-8?B?UGl2SmtyQzBsaVJCMHFjYm5JWkJENXNrcHRnUUpyUC9WOHAxQ25tdFFTY3R1?=
 =?utf-8?B?dm5JWGh1YWFMUHFCVFNhcnZSS2NISzZxU2dCaE1mcVlHcUVQdnJyMkZZd3dP?=
 =?utf-8?B?Vkl1cDFIVUlVekJkK2MvRlpFYmswY3p6TVcyWG4yYU1RNlh1WWZmTGU2YXk3?=
 =?utf-8?B?Z2xZQWtoQmYvWndUNjJYNi9MS0NyTEMwMWVocmNnM0pxU3dTYlFFRlBwcG9P?=
 =?utf-8?B?OVBUWEJsY2ZlUlRqbHJVM3lvbXA3eUJEL3pYdWl3cWUvYWNZRGNSNllkcXJW?=
 =?utf-8?B?eDNRUTUzMnpqL1A2cnJ6YVdLeS8zSFVnUGR0MHlmY1lSQUo4SDVtYkVQeVNx?=
 =?utf-8?B?VTl4Skx6c3FzRHRaL1g3WTg4OVRid3AyWjdBbHQ5Rkp5R2sxNUV0d29pRmc2?=
 =?utf-8?B?dTFUVDczaXp1WksvRG5XOCtvdkoxUiszY0IyRHI5U2d4TjFnbHJaK0pYZEhw?=
 =?utf-8?B?WkdRb3FROE80NG9JYkFyR2k4Z015T0QwRnQ0eERZUDYrSE5HQjBKSGFuV2da?=
 =?utf-8?B?WDRQWDExNmxzd09CcWJQUHdQSGtSVWpxaEdwQWk4a3BmNUdabjEyaklKRTl6?=
 =?utf-8?B?RTZPbjl6d09oU2Z4ZlhQdGlxeVR3bWwvMllNRzNXVHlOM3JuQ0t1OUhBTkND?=
 =?utf-8?B?NTlGZkVjdlM3UWlxY1lRQURhalZlcDJQOG9rQzFQZm54V0ppL0FwQVoxbUdG?=
 =?utf-8?B?dHZRQWU2RC9LejQzZ1FrUzlIeUFUbjc5Z2ZDMUtYUWc1ZnBIQVF2YU11SGRr?=
 =?utf-8?B?bzFsYnhmZjVtRWtZWFJsZU5GSmhFNksyT1NhTjJoSGEzNWszaVl6RHhPK3hF?=
 =?utf-8?B?dmFuekllMUd1eVFlWXM5VUR2QjVLa1pBd2Zocm1OS2ZoK1gza0tIMDBFTmsw?=
 =?utf-8?B?WjFEWEpRVmZMdjNGVjlZckMwZUQzR3ZqUGx5RS9tZGI4eUUwdGcwdmtvOWNq?=
 =?utf-8?B?dEFDTVFJMnpONFNzNy9IVW9vQnd3RWxjclpFK1J3RWg5MDF1bjhIMFJ4QzJm?=
 =?utf-8?B?WTkxYkZIdXhhbHgyaCtCem8rMXVpS0ZyaVJqUWZaU3Q4S0lEalpFYjlRQTNV?=
 =?utf-8?B?dE1Cb3R3U3hCWW1INWZyZ1BLaDlMK2l6UktESllYMUNWR1VSQnQvTjhsQUJV?=
 =?utf-8?B?eEZnYTZEMnAzcmc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkd2ZjhycVlrM3l2ZDU4SjVvTEVrQy84WFNlb2had1BqaXFDSS9GaXhTcklV?=
 =?utf-8?B?Z04yYXBQL0pML0tRUnZsOHFZek8wWmdwMDhReFNBM2Z1MWpiajFoS1hHL3RO?=
 =?utf-8?B?WWllZTlMeUg0MmlPeVFTbVJPYnh2cXpnaExtbXhubmQwcDZUU2pEa3BLNUhk?=
 =?utf-8?B?Q0t1aCtXNVhNQXROVE15SkRjK1VCT0RVdnlnVTJJa3lCc0lBbFZSTFdVZWRl?=
 =?utf-8?B?RmNlVDh6SFlmOEwxanZSV0dlYlpMVjhHcDBLSlVtcUpHN1E5d3FQeDFEZ2xU?=
 =?utf-8?B?SE1BOWFjamlCOEhtNzFpQ2ZzWXFUTUFqdlZiLzk2aEhVZEdpelo3bWpyeG1m?=
 =?utf-8?B?STN4L3FxRG5QWFdndUtXbzk1WGJYcitYbjJxUlJoVW9ncktMbVlOek04MjJl?=
 =?utf-8?B?RlV2T1FpeWorZkJvRlFLVGxlbmkxbGlzcnh2NTliVkxsUTNueDdYalFDd2Nh?=
 =?utf-8?B?amZFWWFQb053WlU5bjJTM0Z4cVBONjZDVG5DaE94dEQ3ZGFQVmhiQzlaeWQ5?=
 =?utf-8?B?Qm51bldVMUVnMW5qZS90SjV3MUtDamF2SFRLc0ZLNW1vYUplaHZvWm5sVHBM?=
 =?utf-8?B?N0dkdkN2UmdyWVNkUlFuR0NkeWF1M3FoNVRLN2IzLzRuK3hUaUVRM2FaOGx3?=
 =?utf-8?B?aVlvaWVsaDVmcG1Wc09qZSttdG1xNTF6TTJsTkhaYzZodnFzVlFoSnJhd2Nr?=
 =?utf-8?B?VThVdTRPYzhMeURyU3N6YlgxSWNjdnloQWhlcGVxUlF1ZlVOaWhjbThCQm1Z?=
 =?utf-8?B?dDRRNzBiMUh3QkM0M296OHhIK3NaeHFrdDNVYkpCU0lGOWZCTVF6a3ZvTXEw?=
 =?utf-8?B?YUpKNjk5bTl4Y21UTjI2S1Nnb2dBVXc2ekpqREhTVkRGam1aaDlJSkRUdG01?=
 =?utf-8?B?YjE4OU9Nak5vbjJCc3FqNVpJL1ptOGVrSmh6b08rdG4wU1lheXNhbUY5MmNH?=
 =?utf-8?B?a2JHb0Vodm9pcDMwS2ZGYjBtbDJPeXlzazI4ejB5aTNRUkpWQnc1NnhmQ1hl?=
 =?utf-8?B?MXlQRGVQNWRnTFpIbTR2dDRjYm01Tko5T2JvMkMrd1BoU0ZiSXdsOFNiSDVM?=
 =?utf-8?B?V09mMFhFaUNqN2ZIZlZvdjZWbWcyNSs3eEQxZGhuTGIyaFEweE1ERWF5Rk9P?=
 =?utf-8?B?c3Y0R3BTdXl3SHlJazg4WlBvLysrODVLcFNsdDFGbHNVZU9nK0Z2UGR1Nmdm?=
 =?utf-8?B?cXJUeXQ1UTlGR3lqMm91OG5nZHFvR1BFL25MMzBuZ0xWaElvQXhtVmFjVDE2?=
 =?utf-8?B?aXNlOUNISUNBa2I0YW5CT0I0WDg1UVA4U1V0MFBwRTUxMzZRMU5lRlhMNmVv?=
 =?utf-8?B?TWtPU3lCaHpaVFZyS1NrLzJFc2xoOUEzcnEwbE9zekh4MGFDdlo5OVNwUW53?=
 =?utf-8?B?SUVJMndDeE1JTWhHL1psNjVmMUp4TTRHVG5oZnI0T2hTS3JNaTJDaTg4eEVE?=
 =?utf-8?B?TnZRdW1RQ0hISm5tM2h1WTNyUFlaWlZ0ZVdwekZ4ZW55ejE2dDFyUW1nZmFR?=
 =?utf-8?B?V3RON0sxTnpxQTg1SHhHU3Y5NEdaWC9wWXBSVHFwd0hFTWdvQmZuOU1jTWNj?=
 =?utf-8?B?bjlNdTJiMkd1Z0hjKy90WnE4OThzMEJHWURwbEJ1MWdEZ3N0Mm83dVgvNng5?=
 =?utf-8?B?RHFVT3Jla2pQU2VXRHY3dWlrTXltUFJCTXVDVExqOVV1ZlNCTllSeVF4VSta?=
 =?utf-8?B?WCtnWVRrK01XclljT1VzSnpCNVZXbFFyTkJYMjZRUjFMYzVIcGNIanRzYWdJ?=
 =?utf-8?B?c0lBQzdKNVVtd0Z0OW5RTUxmQWpMNDFjYm54V0EwYndyb01sdUx1blBGMCt4?=
 =?utf-8?B?ek16U2UwMXJtd2ZmSXFDeUVKY1ltaWtuZUlWamRkOEt4RmJ0d3ZIZ2s4Ykh5?=
 =?utf-8?B?Kzg4K1RIVVdaNXZJTWtJcHZEZzJoQWNVemtaR2RBRzVMOVg1a2x1dTl2dXRD?=
 =?utf-8?Q?tp/Dt99s6r96GGMeIWNR4x6Zg02/4kF7?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b76113f-2af1-4fb7-0863-08ded84e93ef
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:28:33.7331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P194MB2190
X-Mailman-Approved-At: Thu, 02 Jul 2026 19:22:54 +0200
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

Hello Michal,


On 7/2/26 16:40, Michal Simek wrote:
> 
> 
> On 7/2/26 15:54, Francois Berder wrote:
>> buf is an array of size DFU_ALT_BUF_LEN bytes.
>> It is gradually filled with data using snprintf but the
>> size argument to snprintf is kept at DFU_ALT_BUF_LEN,
>> making it possible to overflow the buffer.
>> Fix this bug using the correct buffer size:
>> DFU_ALT_BUF_LEN - len.
>> Also, replace snprintf by scnprintf, otherwise len
>> variable is incremented incorrectly. It is now
>> incremented by the actual character count written
>> in buf.
>>      v2: Replace snprintf by scnprintf
> 
> this should be below --- not to be the part of commit message.
> 
> M

Do you mean the last line v2: Replace snprintf by scnprintf ?

Francois
