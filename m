Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF42CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D96B848F3;
	Tue,  5 May 2026 14:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="uk1e5Q1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6119848DE; Tue,  5 May 2026 14:39:31 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917D1848CE
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HN+WfmdwyxlTbfPT3opCpu3Qnhbree5otix4GhQ8gSPbA7dJsrPFD4cJ/zfv2PYofAJqh9kuMKSp/e4P/qDG/JrCwjZ0YDL8VkQoLiveBK1DJMhTSTzSSEhk5kNDfw5Of6qz5q+S+Jbb/lxw0zedrlgMEfVbcVrucFDSywtChAoFZYH24fiybzXHPxFLIpGYTlPQfDW+wP6mdjSnm7Im8su3AT9wm1HiV1289RXcG6XSW0WSHq9Jt4XH3DejypkVqLPh7dT6eOxmGJDwXlNmWlem0vLQTxI7VooTNHrujKGL7GoUvBVdqmnQsySD/wQ3etK3xacVQoZSlalotCWygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKTDbpOoEyPCe7E5EQ+TflYlbfiml1bRl3FS2ELpTmY=;
 b=QPQq6gcGhKa9PL1EWGpCbVo5JpmRVuW3J1Itm0VVwb44BNzCRAX3GoM/QWt8tIKI4uBUZkoKWg17hpolgGltSHSXEROW8Oy+SLwGZYXAsjRu2J4EBg6hCnpvv1bHN2itjCZpdhu67AfdglwjtTojBQ/+DQbWBH1X136PsU1VkQHoNnDFGPjRHXosJuvn3VYX8+xTas26QL3Tqh/mydAwU2Z/lj8zhft60k/stpGgD9J8NJLcDlOKbsLDJir1gwVm1WVhdhvj7rwPvElWVE5knMkD2Gq3D4Rwqsw1cjrxMdMvoowra4Jlqybi756GSfib+H4RjMPCSgCifFWERVyJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKTDbpOoEyPCe7E5EQ+TflYlbfiml1bRl3FS2ELpTmY=;
 b=uk1e5Q1bTNpAZjxJXRTj76FaEqEW2W7PgXPht5fPZ1JPyHMeIPSuvxmFL4zHviYVotQWl9tCYjfDko8keoeHbpzmP7Jp1O713+yEoTj4gZ/x+GgCZpGMmAejJQTs+Q873rkEhk+fnIjRRzA7XRC9Vgf/CvLxkc7DXPGt1exu5bcfQURGtJSZuDFupdzoztoJ3hr55j88Int+UDhI9RaT7rLlTJfL7Xi44OqtcXxvPUh85cr5NhEWzTXQKR5smsg4JydtVN0NwuEFuVpKlGK1Nkdazb6TRcRvWPJRTmKc5U6LfQ7nALA7B0zU+9ur3uQk6PlCS5i3AiNRcHpJ28czmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by GV2PR10MB6408.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:39:26 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:39:26 +0000
Message-ID: <72c5bd2d-6656-4a14-bd5d-3f896fc59247@siemens.com>
Date: Tue, 5 May 2026 14:30:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iminfo: also verify signatures
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 James Hilliard <james.hilliard1@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.4.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
 <CAFLszTiptqaM5PHyMR=rR+KEzMSbi0RLEsW41anQ+m229teE+w@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTiptqaM5PHyMR=rR+KEzMSbi0RLEsW41anQ+m229teE+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|GV2PR10MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 916b59b5-a59b-48c2-8c0e-08deaaa35789
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dY6yiYzrPctN1pJcK0y6l5dCo6hXaOlx/5AWLTpjF8ikua9NOxG2DKboyAx4GECuZrjViYEmKkZPxUr2CARXNdKdUkUHZ3A5Azjh5AJOSAHcoDsztADI8KScWDicUki5ilMX96xMVYCJpJTGMz09/BY+L5FgQloUMzWTDIMIPNFCXEV9nEa2sLX2jp5+C/FZ3JzY10nfhhNQznA0KWb8UbDzdpJLZwzTMTeYu+r1kJZMIDg0/z3SizFSbeTTj91Sv8IWfUHG1cf1jQRJVoc+CuhKJBd/fWm7jqAWmtBU7CczHZ1/oBm9565w+4eauE7W5GjvcoLeHztC6zKJH0WmWs/IXQRH1AAWl2sZnFifii52rp245vWVhi2xRLGTEgm9HfoAjd1+gwRZCsXpXtFGB4u45i9zIVXfCE/qR0fBQk+JFSI7WOAYkWJ1zOH4K2euB/AKdPFfiYZ2nKEF/Ju/BGuerHtpVTkCSxFwP0uWWyAcuWX5nWiFjUEooFi9IVzOPex6PaBiT1JgEGligaaCsgUwUnZkV3I6ZTQ21/2iyUs4DK424kr38wjE/5zhb3k3F4bW7IlXlyPxB5mTj0GETavdE8PxSQuiXM1xdLQx2ajuv8hfnBMdeh2p20LMlluRHFwpDL4iItTKQD7BSheeEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3E3cjVqU2tnRmlLSTl6ZkZIc1Y1aURnNHJiNVBHMGNaVStsUlFQb1N5eWdz?=
 =?utf-8?B?R2p4bHZKMmQxc2Nta3kvWERyMnpCWUt2VlpDK3A1Q0cxTy9qQ1NmNTJ2RzhY?=
 =?utf-8?B?VTZZNC9qWnY1SHZzT3lPQitwYkxJZyttV2RXZnBkY2Jlc3BOMGI2U3pUZ0tD?=
 =?utf-8?B?WGY3SXpzbGJ6NU9waFJ0Q3ErMTBxVHEvZWo2Ymd5ZkZneG45eEhqTmJUb2wx?=
 =?utf-8?B?Q1cvNVFkZFBiRFZBMWhrdDg0aHpUTVVvRDFYWnd0aVFBM25EUEQ3NXhnbEh2?=
 =?utf-8?B?UWpSQm5QNWNkd2RvMzYwRWdUdjJHZmRPOStqbWtkOThEWXRmbkcvWmdwZ2JZ?=
 =?utf-8?B?MG82RlJyWVZEWXhPR2NNMU5aTk5kcy84U3BLaHNwUmNHTWtFQ25xTlQ2YUZj?=
 =?utf-8?B?blZGM2h4R1YvR3RGM1FQVThWbnRXaklsd2VoRytEK2R0M2pGbXpzTVptSkRU?=
 =?utf-8?B?OHpMTlJnWGUreWtxM1FPdUh2MUJBdDI3cFd5eFlVTTZxZ0FnbmZUZDNnK1J3?=
 =?utf-8?B?R0ZsZUM0dXBtR3k1Y3QzK3NJQW9NWXhEMWF2d1g5NzNKMEhVQ0lmTE1udlZG?=
 =?utf-8?B?ODFLczhyVkVoVnA1RTk0N3hiMXo1OUtENGM2Q1JQR2NqcVhtSjZTdmRxVkZk?=
 =?utf-8?B?eHd0QW5BVzhDSDIweXlUbXJSS0diV1JldHBWbHFzb3UyZW1HblBteXo3VS9s?=
 =?utf-8?B?VmZvM0hIMVd1RkNZZUR2RmRuV1o5UVF0R05vTkh2TVMrSEpsUElTTVJ0ZDQ1?=
 =?utf-8?B?QkFLcGVldFlmK1d2MEZLT2d3Y1VId0lJUDU3TkdkKzFkS2NFMmhqa3N4dDJ2?=
 =?utf-8?B?eXgvTzhQU3M2eS9zL3lzT3hRN2t2VFlmMmw4Mk5xdFovSWpqb1ZhcERINDU0?=
 =?utf-8?B?eWppajQxUFNFTmNnNmkxWDRndnczK2M4TzViNm9ZWGtteHVSTXdjOE5GZmd6?=
 =?utf-8?B?L1B4WGE5dFpNdzJCeURLaGVUaW9VWDhsL3c5Tm1mUFJuT1Z1dzFLdjJiN3Nl?=
 =?utf-8?B?cU00MkdUVHNybnhwVVJ2OWlpNXRPa3BZam9UNHVITXhrTTZMdEZ0anI1QmRr?=
 =?utf-8?B?TzhJYnp0NUhMaE1PK2xHRnozcUJ2cm55ckR4ZmNmUURIbWJxL1dSaEtUU3FK?=
 =?utf-8?B?WVc4ODQzZ1h5YXk3UGxQRHMrYURKelpDeTk5aDZ4ZU90VEx0ZHdGTHRHdjBY?=
 =?utf-8?B?alJpTVVUampZemkyYTRUV0VVUURnd1BGS0Evb3Y2dXR3bHVBb25oTWhhMUtW?=
 =?utf-8?B?UHFtbm9VVDc4aEszdUtFM25JNEp5b3o1b0lyOExjanpUV2VuTDQvakZyc1Zs?=
 =?utf-8?B?ZGVIeWJIc1FIR01VOWxVNG5ydkg5MVdFeUpVakR1TFl0YVVnak85L2J6bGNj?=
 =?utf-8?B?WXhVcnBHbWVmMTlldUplL1FOYVdvTXdoTVZoQlgzRFdiRUY1N2syNDBXbHhI?=
 =?utf-8?B?SGZydE9NN1lHbjN2T2dqZ1EraWZOd1hHWU9QL1h1dnloMFNzMnU3alpDdDJj?=
 =?utf-8?B?dEp2NG4xZVEvb0NDZVd3ZWpiekxCb2kweVMvUmt4VzRTT1owa2tMN1RVQktz?=
 =?utf-8?B?a0VMeUF1ZHNiZ0tJTUlBcFNVOGduZGhkNVZvVklzUWtiTzdydDRyR1ArUUto?=
 =?utf-8?B?UVI1WTBNUmVLRXpNVCtiRnBXQVU4UzQ1TjkxNGFnRk1sVkUxbnl1YTNNVlAx?=
 =?utf-8?B?Zk9pVlAwWHltZWJFRkJvUzJMc2cvSVVZOUdXSWtUOUIrY1E4YjBVamRrYnU1?=
 =?utf-8?B?SDB4eTFzV0Via1ZUOEFwbW90WW9MZ3NZWnpsUnZrYkVYTnVqazFtcjZnVHRZ?=
 =?utf-8?B?VVFNeldVQzA0b2FRY0dya29ac1VGZGNQbVExQmRLRXlKdTJUWUpsT1J4T3lF?=
 =?utf-8?B?bi9mRmhPakdUckcvSDFMUmZoUE9rZzI5cVZDYlRZdjVsNW00N1lUclJHcEM2?=
 =?utf-8?B?U0xiY2hqSE9uYUUxVW1xenBUTVhPNDhXaVNIQ0lvcU9haHI1SjQzdHRadGJt?=
 =?utf-8?B?dUcxS2Rhalc1RW5ldU1GWTA2QkpRQnh3VkdMTGdDQ3ZmTFVkcUNSaVR4MlE2?=
 =?utf-8?B?T3Z6WXE4MnF6Q1hMR0dhWWVlRkRjYVdmQXYwUkVteWtqZ3Z4MkFvN2ZRdEVk?=
 =?utf-8?B?L01VRmVKMy93VzV3TWhqSXAyV1VLWWQ0OFlCZ2N6Mi8rY1psTmJXS1pjdVRj?=
 =?utf-8?B?MlduZkJLVWFrcnRCUzBTNWNWSmxvRDJGV29FWVNXVkl0aU03aGJKSXJrMWRB?=
 =?utf-8?B?TnVheC9OdDRVOXpDOTNkTHJhaW52SC9zR0JFRThldkhwRkZ3UmpwOWFobmhI?=
 =?utf-8?B?ZVhVK3cwK3pQM01OSDdtM3VsVFBXbEtsd0V5Ri9tWVAxaVVyVVl3OGNNWEpp?=
 =?utf-8?Q?Yq1JBKDVZmGd+K64=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916b59b5-a59b-48c2-8c0e-08deaaa35789
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:39:26.1286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7yJm0T2D/tmnoajYAirWORQdDdI4vtPrU1zs0lmQwsicYbG1n4awYkv0MIQj4x5RzW/+f0Va5SUv9CvyHzB9/w9ppY3cwKYleTH0PHyBv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6408
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

On 5/4/26 14:26, Simon Glass wrote:
> On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>[...]
>> diff --git a/cmd/bootm.c b/cmd/bootm.c
>> @@ -335,6 +335,13 @@ static int image_info(ulong addr)
>> +             if (CONFIG_IS_ENABLED(FIT_SIGNATURE_REQUIRED) &&
>> +                 fit_all_configurations_verify(hdr) != 0) {
>> +                     puts("Signature verification failed!\n");
>> +                     unmap_sysmem(hdr);
>> +                     return 1;
>> +             }
>> +
> 
> The subject says iminfo "also verifies signatures", but verification
> only runs when FIT_SIGNATURE_REQUIRED is set. I'd expect iminfo to
> attempt verification whenever FIT_SIGNATURE is enabled so the user
> sees the result, and only treat failure as fatal when REQUIRED is set
> - otherwise users on the legacy path lose the diagnostic value. What
> do you think?

Sure, sounds good.

cuLudwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
