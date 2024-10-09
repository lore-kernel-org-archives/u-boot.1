Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD320CEDD90
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111EB8919E;
	Wed,  9 Oct 2024 15:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K8C7msWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F11648920C; Wed,  9 Oct 2024 15:21:36 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B6C188498
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 15:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFrkpnQ3cqUKaFZ1xNusae09QeVSjvF4PbqADjeubFtLEse7WVmROLNT+04p+VVT3X6za/B+iFFfxx5Whw8TV2+biYnORZJ/Vsyl9NqNUeM2J3CqB+QMjICFlcjM4StF21847IxwEpgYCqFIAZXifhhKKXKbMoU+CFMFBWil45WfTe3m3QOwRFUHUsT+VErHBrsBQ5Y4IEMkttM8x5s/uMzuFdUx/WMtdpxh7NN0y0XBy9EowTBXE7Y7cgyAVwYkW+n33qwnass2IumYSd1pRQmZEXXsTERxXc12nLWS4BTjeJQ7XuMmJxCkCsOR71S708nASEfasdbm8lY1stlMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOQYzMVtVLDuOWVbNK3V5batbGX5yLC1mFEujTV8aC8=;
 b=UXzTQ1jrZ00qBFPuiPsKgVhdYI8cofO2Ed2a5MTS9XLrmQP4XhpGiRY/v7Hmj94eBKwtQwAE2ObAxflJzh9oG5WFpZAs2SpN57ujWhbCVM4Mk+RhQVMSETFbq22kGIRuwhKkWmfAGxows+yf1Ba4cAc7ZNPTomQ5u/hjUm7fXnPurWCdKOOE0vVEXvnd+6YlhgdYn9xLZPFHyc/9UCsYei6BSqTzHEWVZkYwlfSecXz8GllYNXhfVTUl7tdPMePxOO9b5ORSvtEy73CzslNpYfRoE8zEK7Jh6SX9wQQgF3wJE90HLZR1zgRD5fQVIXJxVMrd1NrehBwdGxfRxv6LpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOQYzMVtVLDuOWVbNK3V5batbGX5yLC1mFEujTV8aC8=;
 b=K8C7msWESebjsLtt4S8RZ+tKeiuYuOpCUvFtVAzMfbrvyJ7QzywxQT38d9ebuhUcxSgKUIwBja0jlUvoNSRLTDeB9aaZhFWhLQgDZAhpSCok5ur6AL329xxZdhCt6mC6ObhjvVxCKLtnLcG18/0KaTeHxl3FMQTqLp0tsZ1H2Bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 13:21:31 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 13:21:30 +0000
Message-ID: <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
Date: Wed, 9 Oct 2024 15:21:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Add option for pointing to external description
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
 <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:803:14::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d32c4c-c77e-4f26-7511-08dce86549c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjROSlhWdG14NnlxRWVTQjUyUm1iWFhuTGFCTkFRREVoVXYrWGdpd0hEQkRP?=
 =?utf-8?B?aWxCZnNxa0ltWGNzVWYvQ2RhZUl4WVlIWjFUYkRNbVRwd2FBbHRpUjdIUDls?=
 =?utf-8?B?Mm5kdC9nem1IZWVGRUNMbnNZNGlvZ0lZZDYxRHVTeUdnMSs4R0ROUkg5bCtu?=
 =?utf-8?B?NC9kcTQrY0RvNDZtZllqc3RzRnhZa1lXVEFUbHNRaUFlOWxyOWF0NTNlWU5S?=
 =?utf-8?B?Y2NhcloxMVpya2VTVHQwZkVSOWVtN1Y5bmVPNjg2ZWIzTm9EVHVVQjc3SXV1?=
 =?utf-8?B?clQzcGVyWlZkS2NGVGNxQUNza0FaWFIrOEM0QXhWK0RKY1ozcUxMQkVQS0o0?=
 =?utf-8?B?elRGTzdtUVAzQjd5S3hKZXFla3VidFdoMVpJaHB0bjN2Uk15bmdjNlRJZlc2?=
 =?utf-8?B?dmxTYUo0MFlBcGhOaU0wMFVWVk5RUENYTTlMSTFJWmZvaE5wR1Q5eG5FcUho?=
 =?utf-8?B?ejJpMkxOeDB0dWwzQ0ozT2dmZzkyaWdEeUtpa05GOEtDaVRxcUxveHcybkQr?=
 =?utf-8?B?T3ZJNDcyeVprU2VzeFZUUnJDZjZxK3R1NVQ1T3I0UDQzaUdsOWpGSlkveTI5?=
 =?utf-8?B?eTl2QWhhUkxkdXNUWmhrU2o2SkUzRXpYblBhaHVmeko4YUhFTDFRdy9UdlBh?=
 =?utf-8?B?YUU3UjREa1MyRUl0K1VmTm1aNnovOFlvZzRiZ1JVSENqWTNoSGFCQm1zVDl3?=
 =?utf-8?B?emM5RmNZbkg2UldLZHFTeGJVem4wWEJ3aFE2VEg2MHVRV0dVVWZhSU5yUTdm?=
 =?utf-8?B?QmlCL1ZuMnBJS0xJZnozT2hFUnJtalZUQ3VzTXhHUkRmMVhyOFp6bW9iMWNN?=
 =?utf-8?B?dmdvTHpxNXZmdldIRVBIdCszWTVHeEd6ZHdOZDFqZ25USWNkMUo4Q01oMWtw?=
 =?utf-8?B?QUcvRWFaVEpBVHJxOHd2U0JYVkx2RGt3SmRZUlZBclU5Nk12NnoyZ2dQbTNP?=
 =?utf-8?B?cC9tbG9uL2oyWjd0QlRxclpCQ2V4TVlOYzRiM3JjKzlRMEQwa3lEblJwUCtz?=
 =?utf-8?B?WHhJem1lRkxmRERvM2NJR2F4SGdKaXZuVGh6KzVlN2RVR0hBMU9JRDNxSjVi?=
 =?utf-8?B?NlhHckxCRktuS2UydmJ5VDdGa2hURnlHaW4xZHB4M3RTSzdneG1XWkU0VEEw?=
 =?utf-8?B?Z0pJdlZrQmNWVVFQMVNOU3Z2M3FYaG5GTUNXTlMyOCtySjZvcmVsUTJqMGNB?=
 =?utf-8?B?WkhxbjlMeHFjTFdGcjJzMUZRLzhxc25xN1JxcjIzeXdJSnZnMDlUMmNlNEc4?=
 =?utf-8?B?eWp0L1VHVmczTStxalNkU2V1WGg5cjByWUZFOEk3Ly9OVTlUMjM4bWxxT0Zv?=
 =?utf-8?B?WDkzN2Zqc2J4Um5KTkVraUJnTEJ2dnNFNlE0eFlCa2FTMHBTM29hSmFQbEVJ?=
 =?utf-8?B?QVh6Vi9iOHBNV1pNMHZ6Q3ZNQ0tzdi9lcWRxK3NwTDd1eG9xR1ljK2FmUHgy?=
 =?utf-8?B?VC81VmNhQ1RVSmJiakdJMmZqUll3aUpHVFhncXJrd3JzemFHNnl6M3QrZEIx?=
 =?utf-8?B?NkxZYmRpa2d6a0hLUHVwZ0QvcU11M2p0Z3hva29HZnlpK0ZHSFpHRmIxZE9i?=
 =?utf-8?B?U1hDbGt0UGJNNXhwRThrK1JLbTZhRXUwanRWSVd4VnduOTNROTNJeDZUQ3lO?=
 =?utf-8?B?N25BdDhVdzB5YVA4WGs4SWxhREJRVXZUWnZBeWtHT09CeHhkSkFRd1FOSkd0?=
 =?utf-8?B?T2VxL0x3emtsMTVaNmxMcDA0STAzNDh4M1F0UDYvU2g4bnJaeDZYSi9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25tMS9JNVlvWXMybHF3VFhKZTE0OEswMDF3bFR1Z0R5V3NMYnlvR2pkY0dh?=
 =?utf-8?B?bGVjazVweStNQUo2b2RBVnorWVlubER3U0xQcHJ4TjFlMDdjUS9ReUhKd2ls?=
 =?utf-8?B?TnozZnVocks2TmtRZUhPSkRLZHQ4NllaVUQwK1VqU1Vsa3ZpOGlYaUxocDYr?=
 =?utf-8?B?WGo4MVM5TzJHMUIxMEF1YlZqZlcwVDVUSWVNWk54bi8xdTBCZ1ZkWGhUaUpZ?=
 =?utf-8?B?Q3FEQ3VBbVNYeEVlK2JzMDJOV29UUkYrZGhISTF0WVFhbUVrdURxVk1mNTV0?=
 =?utf-8?B?a2JXSmxxT0dMUWt5K1hXT0FYVFlPU3B5aUVOZ0tqNjhRU1RZY3B0NkVUaWd5?=
 =?utf-8?B?RXB0dHAxdU9QeXNmWnA2NEtpcnFKeGhIcDdQN1JXT05vZnlzR3BGSDJ5Tis1?=
 =?utf-8?B?c0UrVE9YOHBYeDJyeU5vU0FBZDV0dEtTcGxzTXA1Qi9WTHFFK1VEdmVTbkVD?=
 =?utf-8?B?azQ3ZFhDZXg2b1FiSmw4ejh5cUQzR0FtYVFHZnl0bmZucHcrZWM2cHo0Q01Q?=
 =?utf-8?B?aE5zRU9qdWd0N04vSmUzOE91OXBFSWFScXFlV3VZME1ac1daZlNoeVIvQ1c5?=
 =?utf-8?B?SVZCMjlTeEIxclAySkFxYklNMUt3N3ZYOVFURTYvN2Z5K3ZreWluNWkrTGJx?=
 =?utf-8?B?QmR4VlNPaWFDRS95U3crZjVBTGxESVZXaWRWUlpzYTRLV1lhTHQrTGZKYTVw?=
 =?utf-8?B?VmVhdTBBS0pCVVFOekFUM3YxSTdLeVo5WW1pRWNWTW9xaG9vaXc1TjRUL1dz?=
 =?utf-8?B?Y1A4ZXBZYUIzU3hCUERJZFJjMk10MkRmdW9GZlJVZkNYc2RPN2kvckpiR2gv?=
 =?utf-8?B?bitDZHRWWnZ6NStvZFF4blgyb0ZseW5VZWNZOUhMWjlONVhIeUZCcGF4azZl?=
 =?utf-8?B?cjNKelNPUnRYUWJmczFJUlFrYVpYVlpmWEtOT3NoczhXT3BQYWd6TDZKWDFL?=
 =?utf-8?B?N3ZweHJRZXVidUhNVzhvYi91MWZacHEwR1JkWVVKM2dkc3g0Mm1KbHRQWFhQ?=
 =?utf-8?B?VlRDak1jWFZPNTg5dmx1QmsvaUc0M01NT1poaTluY0dibkFQVC9mRUpBdlJX?=
 =?utf-8?B?SjM5Y3ZVcTRIMzhNVWNoZk44R2F1anVNYlV6RTJ0QTlSOGNHNy80empxWlNq?=
 =?utf-8?B?QS9PdWNTWkN3U3o5U1huYkpUOFF6OFZCS3hsTXozZnFuekNEUGNrSStOUmFq?=
 =?utf-8?B?VTdlQkJHMWNPSEZPcFpRcnRGWUZWTDNqT0RNUTlBTVJZTFZKT05ESmJaMFdE?=
 =?utf-8?B?TmRZQ2FNWWN1dXNaOXVSSDN5aDFYZ2w5dEFCd2g4ZTFxT3BpbUloaXBJUWFm?=
 =?utf-8?B?QTYxMFNkRzJHbnJyKzhKeStWVTVHb0FUcDk4VjNhNTlrRmNWVnpYTXdTMjJQ?=
 =?utf-8?B?UXliYk44RFNacGxyamxBQVkvcVlaajBadUJhMkdQSFIrMmJqYVRGVElrMnNw?=
 =?utf-8?B?RGRlbkFWa3BvN2N6ejc1OTJVcFN0YSsxSytuN3QzVFZhU2dqMWdYTGJMRDF3?=
 =?utf-8?B?WXRBM0trRUNGNmJZS1FJV2VybEFHa3ZtSE5VS3Z5Rk1FK3J0Z1hVaExhZDBK?=
 =?utf-8?B?dUs0dmM1bHpGK2hyY3MzenJOMGlUL2daOHVmNnhyWmFLQUVxT3RVN1lTT3JG?=
 =?utf-8?B?V3VGQ1R3Mm9MTHd1ekNncnRURC9uY0g3TW5PU1JaS1UySDRsN0s3aTFUUTJT?=
 =?utf-8?B?L2hYWlVUdWdqNm9zcXZiT01meUNvUWFEOHMwbWphUG5ZOElDd2dEaWQ0dDdF?=
 =?utf-8?B?cGl1Kyt6R0ZPVE8wWmhudTRJSGg4cmpabUdkdDNwdUR1WkduUERZYlVlc3Z5?=
 =?utf-8?B?RzM4S0pjRG1QRzNkMWVwN3hhc3hBSTBqS3F6NUwrcWpadzIxMWU5dWR2eGlB?=
 =?utf-8?B?RE95WEJhOUo3a0lqR3c0R2tnN2oxRDJaUjQxZW9UUEl2NGZySGlmdFBMTDl2?=
 =?utf-8?B?QkNrbVpadGtqZGplUDBYVHZKdGdOSE52ZnFtYWNGeWlXZFFyTUw5V0hVK3JQ?=
 =?utf-8?B?c0RZV040MFZ2M2lrZzd1d0t1Y1R6aWZBcDlyOXU4eDlObWwxVVlET09HWUpG?=
 =?utf-8?B?cGhuQ3NCS25MaitQeFE3U3NlMEUvRFo1L0t3bWhyWUhwYTVpUjBRR21uZlN4?=
 =?utf-8?Q?XWYKSckfCByF6FN0srN/Ot3WP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d32c4c-c77e-4f26-7511-08dce86549c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 13:21:30.9421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+TiLh9zeSunaLXAsFoBKHlT/UUzki2dwBmBUglaAzD5aZpQ6BFft/6v0iSn767F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
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

Hi,

On 10/9/24 03:55, Simon Glass wrote:
> Hi Michal,
> 
> On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Adding binman node with target images description can be unwanted feature
>> but as of today there is no way to disable it.
>> Also on size constrained systems it is not useful to add binman description
>> to DTB.
>> Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
>> target from DTB for binman itself.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   Makefile    |  2 +-
>>   lib/Kconfig | 10 ++++++++++
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
> 
> Doesn't this defeat one of the purposes of Binman, i.e. to document
> images? We do want the .dts to include the image description. What
> sort of problem is this causing?

We have two boot flows.
The first one (default one) is using Xilinx FSBL for SOM initialization with fit 
image (DTBS) + u-boot.elf + tfa.

The second one is using U-Boot SPL instead of FSBL. This flow is used by 
buildroot for example.

In perfect world I should describe both of these flows. I sent description for 
the second as RFC here.
https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com

but it is also reasonable to describe the first flow but I really don't want 
both descriptions ends up in the target image.

The second part is if you look at RFC and how fit-dtb.blob is composed. It is 
one DTB + DTBS which are composed from overlays.

xilinx_zynqmp_kria_defconfig has
CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"

That's why binman node should go to this DTB but because other images are 
composed with overlays binman node is spread to all DTBs inside FIT image.

It means one binman description is in fit-dtb.blob 14 times which is far from 
ideal.

Third part is that I can't see binman node in DT schema or bindings that's why I 
expect this will be reported and I can't see any code which removes it before 
handing off to OS which is required for System Ready IR.
And IIRC removing is also problematic for measured boot.

Thanks,
Michal




