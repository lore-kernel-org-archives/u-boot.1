Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3699C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 08:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9BCE8861A;
	Mon, 12 Aug 2024 10:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BCXVxOsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8089F88680; Mon, 12 Aug 2024 10:56:36 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AAC388266
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 10:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJjwS12L9KnlUYVbcLpw3XFiN0/4xWfGg8J7VJbjCHnLc+F1VxZ2+54ngWruFCkRIm6xjM9kRwpxEuUIXKy1pMx7XVLMVZFL9axegy+X2IxGCBvLxbJ2y0bJvaBrhNAaM2BXEtFb3Y4M4ramKjTjQh66GvfFukYqVHU9tWYLRdloNjJgLEi+wYiyg8R4EfDW7EeDYWGE0vhme+BbOG6scQ8B12JxGn1vK7va4Dn/R+vr2xWPkA8ZlouglxnCwG6mTww5F0hVeXk/aTVieVBQy5PYI9WAMja79NNxByUlbkzVXcM8q0pHP4WQKMTeitTdoxLO+kfXrU4IUZ7qNyX0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KjxlNKebbSl/F91O/yFs/6UGfOry5fm9/0OystLr1Q=;
 b=E2I3W9vKGFtMbff+giPBXROWOXgmVTjkPsPlCql9LEGiZMidt8JgJa+/RW5a/80jZSZvmNezYIzRL0H0hs1teLdtXQ2ENeX5qOmbl+Rd7lfyO3ZG36L3lrfqT9bEz4GvRgz1iCEeea56emELA5ncdx0XnGRf1EI0q+qurFFufFqG8TTzlckgtxWSNfOAHIF3W6UiLV4VZgnfs+bcN7lCMJuwBp3kvJ2a6I0aSVvCy9PrW0Ft2IDx7yWr2Kb/pklDeXHVRcqxlcc7x7TAh+WFWZjoXgn3IRiUUg2A5Br49C1dUKuoTvDQrWmj5ogF341Zp/lnVyiwWgqUFr9k+yzMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KjxlNKebbSl/F91O/yFs/6UGfOry5fm9/0OystLr1Q=;
 b=BCXVxOsgov7TwA3ar6nW0yPVqDypKXlOcfTIWflbbHNUufDpsEVDn9kQXIgtNPHtDEtzdYKpEkufl8eTaZjn1GkXVN6Mv8pgb5Nws9OrZJeRrVeleUuauIBC98drXefXsWwGXWgoHY+hA4d9PCRDzTFUXjqbXcuat09d9c0jMN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM8PR04MB7267.eurprd04.prod.outlook.com (2603:10a6:20b:1df::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 08:56:33 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:56:33 +0000
Message-ID: <2c9402fa-17c1-45a6-8823-d18d1ffe128b@cherry.de>
Date: Mon, 12 Aug 2024 10:56:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] log: Avoid including function names by default
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-8-sjg@chromium.org>
 <94949f6b-9f82-452c-9d38-5c8683a21ddd@cherry.de>
 <CAFLszThRvPSiZrsQEzbMS+Lg=sB1jijEMj9F=cG3h0MQH76t5A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThRvPSiZrsQEzbMS+Lg=sB1jijEMj9F=cG3h0MQH76t5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::6) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM8PR04MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6790b2-dab7-4493-2496-08dcbaaca9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm16MXVXZ3RNOGdxSjZacEd0VUdpcy9nQTRuM3dzTzA3d3pmdjZuNXVyUmhM?=
 =?utf-8?B?SDBmS211VWRJOGx6bjlKL2gzcWRBSm1tdFVqamVST1BpdlYvak9sRWRubUp4?=
 =?utf-8?B?aWhUcCs2d3haeGVwdkcvV2p2UzNqcmJ1cXd4VlRoU0J3aG0vS0VxZXlFZVlp?=
 =?utf-8?B?WlQwdWVpNldvVCs5TGdodDczN2R4cy9jU3kzU3JhRERUVkdDT3FJd3A0UUZI?=
 =?utf-8?B?VDhjRVczeGE3cmRudWF6aitYYUtFd3ZXRitGNGI4TjRnNzE1NmtpK2R0NjFa?=
 =?utf-8?B?TEErcXhqVk5JNjRwTUVoTFJVRGszM1JMY3ZXWENyQXdhZWNHcnUrTHlPNlFJ?=
 =?utf-8?B?NVRWSUQ4Z2J4NjJxbklaaUNUWU41bUpjMThUd2FISUMyNXpuaS9WMDB5VlRC?=
 =?utf-8?B?RWpiSEZKbjZjQVQwWTFXbVF6dnZnaHdsQ3lvcU5aY3lVektvRmkwR3RldmdF?=
 =?utf-8?B?TEdwU2JCYUhzdDdkd1VlREl5ZXcyR2ZzcmtWN2NsMHVXeURzS0gwaTV3NkFQ?=
 =?utf-8?B?ZGVFN0JWOG5aQXR1ckZRK0ZKSGNlWm8rbXpZak9zQVRyQ1dpNzNGcFhUQm95?=
 =?utf-8?B?dVE3MWJxZVNBbm1wOXpITDlIWlRaN0lqSlN1NCsrV1daTG9haCt1UUc5UG9X?=
 =?utf-8?B?emx2dUJBNDEzaFpKOFdKTkRBOHdNcytFaFAxYjVUV0ZQQUNkd1hNTUx3SHpU?=
 =?utf-8?B?UUdoS2dOdTNxdldLc2hoSkYyNHNqODNiUktuKyt6dmdxVWxBK3UrS29sYTJC?=
 =?utf-8?B?VXF0ODNBa3lRSk5wSkV4OVQ4TU1id1lNT2pYSWs5a0VhQVJ4UVFkelgwVnNC?=
 =?utf-8?B?bFBDdHR6cXl6TGhIWVl6WkYvRWI5UHBzWjNFQmtYRHpaZ0ZYVHI1VmhRMEdn?=
 =?utf-8?B?VzBVSklydWJVdHFOWnh4SXFXTzFPVHQzbUt3WUdPQTBGMWNsZVg4S1BPWjRO?=
 =?utf-8?B?UFp4RHhLc2o5U0FiUjVCeEdRenQxN0J4TklJSGlzdjMzR2JjclNLZWIrR3ZG?=
 =?utf-8?B?YUpFQWNHRlZUMEZtZDZuRUd1ZXFjUHFJNWNUR3F1SnRkcmErd3k1RTBjekhr?=
 =?utf-8?B?WFhyQUN5OThBc0RuVStSOWJ5emhrQUV2TUQvYTlnWXZhdkpxZC90cHM2b2d2?=
 =?utf-8?B?bUExMmM3VStjeCtSSFE0c1BuQkJxSFl1dlZISW41cWhuVEFQMVR4SlRUNHkz?=
 =?utf-8?B?alVQZ2VVSzFvMDQ3TmsyR1BNWU1rdEdvMGIyZnAya25pbzRKalRYdENhU0ww?=
 =?utf-8?B?ZkZocGlCVS9WTWlkTnd3aDJFeUNlRlR6cHdDbDdDTDl6Vk5KUUV5WU9DeFhG?=
 =?utf-8?B?MEFXcGdhM3o1WlBuVHkvSmsvL2VYdUNxZHptTmVkUXcrWEMweHBFSmxjWFpl?=
 =?utf-8?B?S3M0d2UralVsQkpkY3I0MURHUU1qRGVNa00zamwrMEFBempNV2pDeEY1LzJD?=
 =?utf-8?B?cnQzUW4vUThpZFBCc2p3dkFlaXpiN25CS1g0TEovMzlTN1lFTnBZdVZOeHM4?=
 =?utf-8?B?dlMyZjh0M0NGZnJTK05IU1RHeHR5eHpySmM5aEtaZkhvY2VEVXYxN0VVZUda?=
 =?utf-8?B?dmVzemVIZ3VBRnpUMFZwdm9haVMyc21BWkRVeGI1bEFYdW1ZTWJ5dlhvNytC?=
 =?utf-8?B?MjVvam5iTC9Ra3NZMVpyMThIUEFGZ1VzMEkrczVySmlUSjVYVWVwVk5sekpx?=
 =?utf-8?B?c1Bkd2FkSVF5VGl5QTdiVTdWajdMQXMrMWNCWjB6am1TOFBvYkg5cTNrMms1?=
 =?utf-8?B?MTFNQXhNRHN1aG53ZE9xQmJvR1NrZnFzVkJ4NTQvOFgvbC9tcWVuek8yUlQ2?=
 =?utf-8?B?Q2RWLzR5WXVtQmp0QjJlZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5BK0xtUzRzMVI3cHkzOEpnci9MYzZCc3hEcm80QUhkMFRJb0hZUTMzZG53?=
 =?utf-8?B?bnN6ZXhFVXllQmQ4ekkzZjBnMm5ZOHZVLzJyNWZOK0FzRFgzT3hBbE5kTEEr?=
 =?utf-8?B?SS8rQ2ZKeC94blF2dUFIeTZnZjZsZXZKd3kxSzRucnZkcW1HUDdWdms0b0tC?=
 =?utf-8?B?b3pBTnY0MkNweUhGYVBSQytkSHVvVWY5TkZPaUtBWmNFZWZkK1g0ZUJGM0lZ?=
 =?utf-8?B?UzVjQnhhRzB6ZHpvUzB4NzlaY1FmZEpTdWFGRWg5OVgvOVZKSEM3SEFybjU1?=
 =?utf-8?B?UzRBZ004MWtmU2ZaOHArMlRzUkVoMTRER1dvUDk3MW9tb0gwd2xtcUtrOURu?=
 =?utf-8?B?bWVyWWUvRFFwNHFMendqRUxrckxJL2dvT2IwNHVMUXNWR3gyOVVVcU9mclRh?=
 =?utf-8?B?VjI3Y0JvVVJQMWdXcFpOak9XRGhDdmNmZEFHd0Q2N3U2SXR1UjFJTlV3NXhr?=
 =?utf-8?B?RFp2YTBNakdwTHN4L2tTNTJGQW0wQmlRdXlidWtKN3RmM2ZUK2kzWVM4OXd6?=
 =?utf-8?B?bGRjNkNNdUgwNktNdStMcnNqMXR5bnhsajNGS2Q4OGM4bldEaTRSak5aQWI0?=
 =?utf-8?B?YkI1MDJNNlJ3TUlzNTQxRGlHVVJzanFZcWNxaDJ0M01OZEY3R09vbGZHS0Nq?=
 =?utf-8?B?QjBxbjlYTnBaK1dhMDdiMU9iYkdOTkFELzRIUWlPSFBjNVR0aG5rM3owMCth?=
 =?utf-8?B?TzJ2Nkppa1JaMXNXV0ZTdGE4Q3ZXalRYZ3pxMDQxbXBnL25Cc2k5RDFoN0I4?=
 =?utf-8?B?R3VLeDJQOHdyb1BKakVGY3hEL3B4bythMG1CSGdic0ZpRmQ0UFV5bklCUHhU?=
 =?utf-8?B?Qno0SnhiTWwweXB0WDZrOG5TYmp2Z01WOUo4Q2pHeDhwZmw2MGFWcFNLekhD?=
 =?utf-8?B?RDZDcjUvWkt2YUJwSEJaSFFha1lhak1PZHRkbkxIeXZSNFZBRWNkWmFlaUtr?=
 =?utf-8?B?Wm9ZNDZIZWtzaHVKSE1hanExaUIwd3FMOTQycmc1TU9xUGtCRGwrSFhiQkF4?=
 =?utf-8?B?SkRURkQ0ck55clE1N1o2alNMUGNEUkZBNWZUcVBpcjFVcGM1SjVjcm0wN3Vk?=
 =?utf-8?B?YUZDbkdpTFliWTNQVCtxcmtsREI5bisxNXljT3JReHg0THpSTG9Zem92dWVV?=
 =?utf-8?B?MVM3S3JUQmplSDlyT05tRGVCc3FrMXNqT0FEbFpXOEJybzNNUWxGYXRMZURI?=
 =?utf-8?B?TVptdTZpbHJ4MjNIQzFJcmZaVGNwS2RPTVVnL015SUI5OG5sc2N2dWQ0c2FV?=
 =?utf-8?B?ODQ2NnZwYllScDJHZy9kYnBLTjA1Qm8ra3V2dXVrVEgveWhZWGZxR0hXNkxv?=
 =?utf-8?B?V244M21wYmJyb2tjbzVVM25RcURzQ3dDeDJlQXFHS3dsK2FPdVkycEhHWUdt?=
 =?utf-8?B?dGYrbmZKRUpEeTN5a0VQWGIrRGFOTUphUm8zaWhZQm5pcjJUOGxRYkxqTDRa?=
 =?utf-8?B?dnpybi9Ma0lxUDZKQ0dEY251KzZvSUJKbkZEVTVsREZPVWJ0bHMydmlsQ0Z4?=
 =?utf-8?B?Q3Y2WVFvejduYUxyeWx0Z1JUWGdKdTlJTVhFTDRLYmdob05DZGIydWp6SnRJ?=
 =?utf-8?B?eVBRNGFrQkxmMmtTQm1lRWkxeXdDZEs3MThXeW43c00wSWZjaWJrNU1LUXNJ?=
 =?utf-8?B?UFROcDNxcFYydHp0eWpqVUZrNCtrMTlhbjVEVFB3c3RtRmQyUDNUOUV6bnVr?=
 =?utf-8?B?MERCODh2U0luSlBNVDVNZ2ZWR2o1ZXFNWEpEQnh2a0UwQUpZUXhBNEdlOFpi?=
 =?utf-8?B?QW81cDA4OTNOeW04aGlWS1NrUG1VNDhoeU5zNU42aXFwS1dwTTJYN3A3SjhS?=
 =?utf-8?B?bEpKNkpISkp1S3Z4NlZlOStScTQ5SmJ5ejFkbzQ5S2Z1TG4vTTRwWUVDY0NH?=
 =?utf-8?B?YTZWVk80dEhkeURkYVViM2w2U1YxTUxNcUVzczlhTWtQQW1Jenc4M1Z6L0M2?=
 =?utf-8?B?NUhaaFdtd0tzeTNvK1I0U2dVYzVtNld3czhTQXF4VXhNMlFkNmthT1VmNXBn?=
 =?utf-8?B?dGdIcEZ2RFlFUFN6d3FaTkdydkdMNjdXSktZckpuTnIzQWJPaDkzN2ZoRUcz?=
 =?utf-8?B?YnFKSW95OFZ1VUFrNGN4bWV2MWp3ZGFTSVVNMW5KeStPbU5MOUxJcCtVUFNx?=
 =?utf-8?B?TVk1M0RkOTFJYkgveGdieEpSMTI2SGpIR3RHbWtMTWxOMDRTQ1Fxd3ZQaktB?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6790b2-dab7-4493-2496-08dcbaaca9f2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 08:56:33.0704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOOy+yDhtJrMcXFszvZllT89edczQ8F+g+mFqYFRpoGsyCNqTvGNdTMsehj13SfcTUME/o+x5KNel/N8I3KEKM+hDRtAa30R6MX8fvE+PQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7267
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

Hi Simon,

On 8/11/24 4:50 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Tue, 6 Aug 2024 at 08:16, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 7/21/24 5:25 PM, Simon Glass wrote:
>>> Unless function names are requested, the logging system should not
>>> compile these into the code. Adjust the macros to handle this.
>>>
>>> This means that turning on function names at runtime won't work unless
>>> CONFIG_LOGF_FUNC is enabled. We could perhaps split this into a
>>> separate option if that is a problem.
>>>
>>> Enable CONFIG_LOGF_FUNC logging for sandbox since the tests expect the
>>> function names to be included. Fix up the pinmux test which checks a
>>> logging statement.
>>>
>>
>> I now understand the statement in patches earlier in this series :)
>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Changes in v2:
>>> - Update commit message to mention the runtime impact
>>> - Leave assert() alone since it is only compiled in with LOG_DEBUG
>>>
>>>    common/log_console.c      |  4 ++--
>>>    configs/sandbox_defconfig |  1 +
>>>    include/log.h             | 16 +++++++++++-----
>>>    test/cmd/pinmux.c         |  8 +++++++-
>>>    test/log/log_test.c       |  4 ++--
>>>    5 files changed, 23 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/common/log_console.c b/common/log_console.c
>>> index c27101b8fe2..9376baad664 100644
>>> --- a/common/log_console.c
>>> +++ b/common/log_console.c
>>> @@ -38,10 +38,10 @@ static int log_console_emit(struct log_device *ldev, struct log_rec *rec)
>>>                        printf("%d-", rec->line);
>>>                if (fmt & BIT(LOGF_FUNC)) {
>>>                        if (CONFIG_IS_ENABLED(USE_TINY_PRINTF)) {
>>> -                             printf("%s()", rec->func);
>>> +                             printf("%s()", rec->func ?: "?");
>>
>> What about setting _log_func to "?" if LOGF_FUNC isn't set?
> 
> That would require all call sites to pass a pointer to the string,
> rather than just NULL. I suspect it would increase code size?
> 

I probably missed something, but log_rec->func doesn't seem to be used 
in many places (common/log_console.c and common/log_syslog.c).

log_console_emit() is only called through log_dispatch() itself only 
called from _log().

_log is called from:
- cmd/log.c:do_log_rec(), the func parameter is provided by argv[5] 
which I assume cannot be NULL because argc<7 is checked.
- common/log.c:_log_buffer() which is called by log_buffer()
- include/log.h:log()/log_buffer() which is modified to swap __func__ 
with _log_func (so __func__ or <insert placeholder> which is NULL or "?" 
I suggested there). the rec->func argument cannot be changed from any of 
the caller.

So I assume we would be fine?

As for the size increase, I would hope that the compiler knows it can 
store the same string at only one place and then reuse it instead of 
having it in many places, but I know nothing about compilers so it's 
just me guessing :)

In any case, either is fine by me!

Cheers,
Quentin
