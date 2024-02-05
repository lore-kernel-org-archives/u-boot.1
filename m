Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDD0C48291
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 08:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E5B877CB;
	Mon,  5 Feb 2024 09:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="S58UB4n1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8077E877CB; Mon,  5 Feb 2024 09:41:40 +0100 (CET)
Received: from SG2PR03CU006.outbound.protection.outlook.com
 (mail-southeastasiaazolkn19010001.outbound.protection.outlook.com
 [52.103.65.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B76E86EEC
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 09:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMbTAMLrdf/GUa1fhzi1FyZOykPfE7RaxtfnRc6MZFOqx834Iz7iRAfIko4Z0WdqUiAUliU1ahIt9oFThju6fl6G9HzT4w6oL+7qVJ+hpA8BdiT/njzRfn9snqr64kqy4+3OH22UiG75Gk4GaAZOZzcUekfeiVj8o+EkGZu0NKf0ASRBViQWIke4JP09s+e1WZbt3t3Sz4l2ic1iGwFba4mFrYLINlgWhEkLCX69FGJm6b68cHT/GfkVg/ut5lixxew28ALMwbksPQPfjbZGVFkkH2wVXjQUNLj3kb7/wXwviCpuuVhmiVwXJ473mUejuL0d1Q2O5lZNbr3ea6Otbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BU25E3bkXaEWVNHCeGIn72t3D7/UNhV7QoTXba86vY=;
 b=CUB1T/VjgvbvufOe1n7LeD6Cd6vari8JcW/S3a1DOJC0x4nFB3POZWKsjhFT7dRHNEz1PSuUq0p5kGy9LlMUvL7vbqrsB/Mvu+Ayhy/h9n4IqqvFrve0qZyvEQZSV+RiKgYHq/XcPBf/o7PQvKNDl/JBAzUhzV4M7ezkNSWMx+9WoLucRTtFKpLJqA8DVgSCVV1Trp6nnNF7k1RlgV2aPPMkx03E6nqpICYfjnS5V14b1jHletSQ2L7KnvOOPMuxKnbOqZeRonRK5LwG8J/+MWAsR83MajfKNYfL23cIJcd7Lq8ms4xJW2riwvp25y5mX/GN60yQKQiry6TjOeqAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BU25E3bkXaEWVNHCeGIn72t3D7/UNhV7QoTXba86vY=;
 b=S58UB4n1g2/5P/aNjItv5VUWB2VTdpLBd1WCI5QSEO3XyuxbYhf85rzjsR7ZZA05zsntlJ59sIX0CMXHH1dsfDlNIEFG7G+n9dIK87ivAeU6G8/nZgIblt14+G3kjKBSSvrI+79CCdyCbn21YR1xLDLDNa0BrrVow5MvOopf18FTmb1RKoCR3nM4TqeGoloNmhotJCVXcD0oZtmNWlU3n9DPezGBYbmpBR/ugwhtZT/a7Yf4wSeONzQzfi0sRU9M6bPNEf/joOxPO+Fp/UD4CSbbi7uBnZk3orsQ6PxkoWtAMDCT74p7Q+ZfielMGEuc53Potwi3bXQFro7EG0aBPA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB4446.apcprd06.prod.outlook.com (2603:1096:400:70::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 08:40:27 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 08:40:27 +0000
Message-ID: <SEZPR06MB695948BE8408B8E785F5322D96472@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Mon, 5 Feb 2024 16:40:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] usb: dwc3: handle return value of clk_get_rate()
 correctly
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
References: <20240203-hisi-dwc3-v1-0-448050c7b690@outlook.com>
 <20240203-hisi-dwc3-v1-1-448050c7b690@outlook.com>
 <137f996e-4426-4079-8b61-227f734e22de@moroto.mountain>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <137f996e-4426-4079-8b61-227f734e22de@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [tacxaT+uGwQaKlhrfpwxOTkVn/mLF3ahIutosPgWEPyK5nnDs4IZFRRRwnKBKJLT0Kx1K+0D1m8=]
X-ClientProxiedBy: TY2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:404:42::35) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <0ebfdf1c-1899-4ae4-a6cd-a8c290ec7abe@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e0ecd7-ef4b-4b12-c8eb-08dc26261a4f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wA29q/D/JzUBaYLjgFGOWOY/Cf+a2LBE5rfBdYo1/AiW6+jN/keF5DgVFRALliXc/XZht5ct29Rv4zZSzs2vz7d6Vcyq7P8fmBie0lQSMoz4WuOWnzNzAroieJlxUmxGlXXSjDRS7XOdaZYZWKRp/rM84mnqZieWDVIm16oirCAR7j/fUqmv/1G76d8AELwnmnux4h/3xyTrUJjmyf1ZDKkI7243n8f0qag5AAIQRLc2jVh/yT0bedyfk9nx2ioqqzeogtueWlOVArtXjDm9a7JYemBIkn0mRBOzn84ydm5YtoXzTzpaxJxIqSPps4R81s2byb7zxPYmzYqzqYxqXnpExESJbaScaJPaSPQ8vEuX45AXJVw1NE/LNeh9whk4dcq5MH736Txzw7IAXlaAYbymYfqnQTfsM3Wnz+Dm/G/abA8kfPQPyCA8ZmI+1QhnoFcaet87zbbLjMyQE9Tm4hk3rpO+mOyiLE45UKUYHut5BkuFA2hJbe3a9EFghPwHvpl/B1rQqTDvjw9/bH2yaf7wBItsyQlXTOT6av9T2d3KcDkWLwpvA3tbjgahdXds
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a05naTVENEJsOUVhYVVQV1J3WENINXE1WE1HSStlcEs0OXJmWWhTOUgyQjRW?=
 =?utf-8?B?K1pobEV4dkZlR1RVU1Niay9wUWhBOERhQi9EcmJqOHd4TjJJM2lZREVMYVBB?=
 =?utf-8?B?MEZIamoraXVOUGQ4b2pGZGRHSWk3R1BPRnZqVFFUSmlWM0VGWjJXUkpPdGNt?=
 =?utf-8?B?RVR5eFl4UTZoMFlBak16L2psdkRZQUhFMWtIWHp2WFlFNWpoTkFGc1c3a3VJ?=
 =?utf-8?B?Q0M1MkQ1MmRJYzNWQ3JuTXVZQmdXcTFpNFJ1MWhuVHZBV3luRlNYRjRJd28r?=
 =?utf-8?B?ZTkySVk1ZFYzelFRM0JNeExCenNhbmI4S0VSNkJSV3A3U1RENStMQjhtYThZ?=
 =?utf-8?B?RFQ0QjA5blBEdzg5VE5oME94ajZWT1ZWQmJmODAzTFArenMyNlpldFE0dEZC?=
 =?utf-8?B?V3dlOVRXcDdOeFJzNHkyMDFHV2xNUzdQN2dEcnN6WmJoTFlod1NXS1o0a3ZT?=
 =?utf-8?B?cnR0bW54eWJySDRGNFBYdmk2RlRUVEVLYkcwaGY1QzJXRS9jK0Mzb2p3YzR3?=
 =?utf-8?B?Q1Zudm9Cbk81akdZK2FrK2dUeVFHY3d5RG1QM2tJZzNuVGJacmlmc1NQRE81?=
 =?utf-8?B?UWNyZldQUVFDWjVmNzFyWUsrSHk0bk1aMmFRcGtoTDROSjYvbUFtZ21qa0dh?=
 =?utf-8?B?SUM5K0htVEtUTXFHMkZEY3NzQXEvZ2lvVTl4ZjBhWGpDUVh0T2g0RGRWc0dK?=
 =?utf-8?B?TVZhRXFEQnhvN0lXSnJqdGpMdXpXSzlzVDhQVm9WMXF2ZXVMVi9nZzFHRlhz?=
 =?utf-8?B?bWp1bm9zRzI3ekZiU3VsK2FsS1d1OG1sRWNEd0lEYkZaVmliQTdYSGdGeWFU?=
 =?utf-8?B?OEVVUjFpaVhsZVJURHc5OGdzb0tITCtGVkhMekUweWpZS2NkMjVBdEdXV056?=
 =?utf-8?B?YndCK1djZHI0bk54VU5tV0djTE5SSjcyVC9WRVhmNCtuTlZCVHpwRm43Q21Z?=
 =?utf-8?B?TDVwMFU5MXkxOWlRcGpDNWpDKzFaNFdFYlhlLzBSMUFlTTUxeVNrWHFYOUZr?=
 =?utf-8?B?cWdvQWJZam52and2VVNIOUVzYlMrSVFGUVBpZzIrSy9Galp6dSt1amplWVVa?=
 =?utf-8?B?bThrdEN2bWlnc1BtcFRZZ0VuVGQ5VGR5bjNQUCtoVHRuejdIOS9GZVBxUS8y?=
 =?utf-8?B?U2JCZEEvZVNiL1NtNE1KVk0xQk5JTTNVSUFHWk9ROUFyeC9JaHl5Y2RTc01M?=
 =?utf-8?B?Mi83dEFDZlJYc09ZMG9CNFZVTDdaZml6ZEpmRU5DaHkvRjdseEhFM0ZzekpD?=
 =?utf-8?B?cXJrZXlCRWxVaEhKNjRQZmhXU0RLK3dzQllRNGY0WjdiZExFbTR1NDZzVGhP?=
 =?utf-8?B?NzBDelg1VXJrTVhJUk1yRDhjT3c1UUIzOHFrR09SVWpBYktLUFllejJ4WG5G?=
 =?utf-8?B?MkxCTTdqQTFndFowWEgzRldsS3Q4Q29uS3piRU1YeWtqTnJnbnRTQ0t0dWla?=
 =?utf-8?B?RTA1dXk5VU1TdzVjWVJMYjl5ekhybElGRlNyLytiZ082alFYeDUvSWhKUUNT?=
 =?utf-8?B?NUhEU09RUHFKdHF4UGhrckpvR0k2bkFBcTI4ZjBDTUw5ZDAvTmxHMjhFR01k?=
 =?utf-8?B?K28vTDhpY3lmTjgraWhuTTBMcCswMnRVU2FwbVRlSWtSYTA5ZWlPMUdBYjZz?=
 =?utf-8?B?bE1EVlREOENSSlg3bEc0RU1NYTM0bUNNZXZQMVNqbysvZDN2UEZmRkE3ZWx6?=
 =?utf-8?B?Sjl0SzVJNW9Dak9YOXpycWRhUG1Ocy9sNDR1K2VjZWxCZk5qTktpZTVUVTg1?=
 =?utf-8?Q?I5PwupkIMYsOQGqQNU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e0ecd7-ef4b-4b12-c8eb-08dc26261a4f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 08:40:27.3399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4446
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

On 2/5/2024 3:25 PM, Dan Carpenter wrote:
> On Sat, Feb 03, 2024 at 07:01:54AM +0800, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> clk_get_rate() return -ve on error, not 0. Fix it by replacing judging
>> NULL with IS_ERR_VALUE().
>    ^^^^
>
> s/NULL/zero/.
>
> I'd be surprised if clk_get_rate() *never* returns zero.  The Linux
> kernel's clk_get_rate() function returns zero and not error codes, btw.
Yes, it's really surprising. U-Boot clk APIs are a little different from 
Linux kernel's. Sadly it's a bit too late to fix it since there are 
really plenty of existing users. Maybe we need to put some hints in the 
docs.
> regards,
> dan carpenter
>
>

-- 
Regards,
Yang Xiwen

