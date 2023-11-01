Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419A5C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6F187714;
	Wed,  1 Nov 2023 19:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="HMVGa0ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C1AB876DC; Wed,  1 Nov 2023 19:37:36 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20801.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::801])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED01587762
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvvtsDkqHdiiwsL2ACuy9kr26EL+ZRWKjyHH9qXezi3t5n48E4imzcnojleEENzYddSNa5N5v6/v1WI9yoZT3/2qiLwkfdRkQfb2LamLyaEnMTxC+cUs1adbofuuBbPvDUltIt00Jre9wql7vz7ZKBXcYtJwTbDnui8wVlgcut/5nzWlw2Xfnbp59/kcZdYENeknpHluopVyzyvRFS5iVbAxE8C6GiF92Xk1eTTDLlqWTdjLuVyN2hiU9cLebK8IKwpi5cGOt841BsPTIo8quiEs9rKbcZEF3mtLW0zuK3wK9IE1Oow1epfNI1Sp6qcFaG70qTkvp+9DvkCTq95j4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwtMUjCVe12v3MTQHrDrnnh3C7G19f0a9IMvgwBUa/Q=;
 b=cL9y7/yRvF3LEC/R8qVTK/tkBI+w9/kPVKmvSVP2TY2jSEaBBX1PAfAu2siqItzSVuXlSRVwSL6CO4/4sngbK8xbuLsyT4/GbPx4f2xsWe92vMK9RoI+xJwpPL4M1TUD/MfmVdJcQa9bWoFdoYsODgPgcQxDHtLxLvqDAIleGXs8VzQBvP4zpSV1xMAAR2WTPvaD5jwLtOEtmdRZrE4CyS8tIyjxUhyksLFL7VbN8IxYzbIoZGyEphnr3tFV9NLRD+TB3IY4ElSJq2rhWFxvb+HjW6QUrLTOsFh6FozpJyTNV1VRBfxaEVPq7rjPi1yFHpvyhp44BtvcRBT4dUmXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwtMUjCVe12v3MTQHrDrnnh3C7G19f0a9IMvgwBUa/Q=;
 b=HMVGa0ouwVoVxoEDXsZNm1cHaDmQdiRuCedpA146cKVzlyCIUK11PYE3pBf1QL3fPeONrTuyZPCV5N0EetkC3clET9nMMn/UX5KCX0kP/4goWGSccQhHhHgruLm8yJKULBZ9GBRS7C3+jViOfrPcd+EE8QXH5cY0jl116RJf2XYoEMzp2LVyJzMupPu5vOg+HGy4XaJ/SWNRsf5TjIa14pYLWF+t4NaDjABDfsiX3faXIi3Eiyzr5aPCxkfldGquD4PfWXAtMDixCgTT7MF/bWd5WhH2UvBi8I6AVO6XgLUn6eW0JqhTAMW9sB3jq/DuaZDiliE3JKfqm49e8DqLbw==
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11)
 by TYZPR06MB6308.apcprd06.prod.outlook.com (2603:1096:400:41d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 18:37:27 +0000
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::15b3:c9f7:221e:ead9]) by KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::15b3:c9f7:221e:ead9%5]) with mapi id 15.20.6954.020; Wed, 1 Nov 2023
 18:37:27 +0000
Message-ID: <KL1PR06MB6964F8FB84EA5744C01BD48096A7A@KL1PR06MB6964.apcprd06.prod.outlook.com>
Date: Thu, 2 Nov 2023 02:37:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/5] clk: export clk_register_mux_table()
To: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-1-49ec18f820bf@outlook.com>
 <36a30ab5-652c-80d4-5e33-c0be3cde113b@gmail.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <36a30ab5-652c-80d4-5e33-c0be3cde113b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [Oz4WE4L7zgQhxpTKNPJBcZLBtTny1Qb+]
X-ClientProxiedBy: TYCPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:405::27)
 To KL1PR06MB6964.apcprd06.prod.outlook.com
 (2603:1096:820:121::11)
X-Microsoft-Original-Message-ID: <4ee3dd66-a201-4d1d-9cc4-27e30cfe8c5c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6964:EE_|TYZPR06MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fa7f38-0f07-4687-ad91-08dbdb09982b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMZxCNdJYkev2O6IxpJoa4TONGA0I9PgNsHI7pMkKpm0y8srwxVibJh5FZavG9FoGMcrUBIo7nCK+ASn40P8ucHHb6Bt6XlxqnXFiiTkUyt6lFE8M05EANisuQO0LVJp90HuLpd/1ZHV1gxMhp0cUebEsQwZpMzCZuUP2t1TAG5adrszcCavxl4A30xDX7OQ9DGnMKCghfln0mmO7ffHNYW5kNkipL+UsoMkIAhiN9F+5CTHKjfvk9FyJjCY0kee4r4aU7zCwRqxIQyNHaR4R5YYGbdWkUdDW4Ftbr9ljxpi46wNi7utV1jAR+xaYyaFeSOfIQbRGOmBK1q3ZpEerKiwersLXR+DYpIwrguveTsMw1L+tWeZbjGBPqqgJGpcOla3zuQstcZV+QtjJiQ1G84PSk3oDTBNyf5dMUsFgjRwfQqdhULVcdt+vI5F1za9lgZ8KrajXTA3LoLeseKDSdwaO9zlB09aWtbU07geqL/9wT+T7bo1kwvhuEuuryKbMr4Q2+0CgirIW36+/ImNed26+ITixv8MHsYxWv5Qd9mUnREHSRGooAbhwLTmqBUr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFBKTkk1WFhJV0lVVTFxM3BUR25rWUdPZjRQWmdnTnA5VU05WXlRa3dkbCs4?=
 =?utf-8?B?Rk1TZWQwODR0SEZUamNCOWZKWXdWK3gvNEFhVUZCQmZMOTRvRE1CSkNjQ3Ju?=
 =?utf-8?B?S0h5OUNseEg0aXM4U1pKcmljcjhIYUpvWUJ5akZWS1QrdFBnNkxMNlBOSVlv?=
 =?utf-8?B?TXpRQk92RVg5T1RXMVVSdUsxQWJVMC93UmE3MEdZK3p3c2t5ZVcxMmhBWVdW?=
 =?utf-8?B?M3V5di9TeUQ3aHUrWHdjd1RMVXN2b0ZrRi9YeldiL3FXNTJpZkYxL3RqNzFB?=
 =?utf-8?B?VjFmb1FPTWhYbVRxbU5raytwaVQ2a1RiQjZQV3NpeHJyQS8zbzNHYnU5L2o0?=
 =?utf-8?B?L1ZsTmM3Rkc2Yy9sQzg2QUI3RDRMQXA3ZTF5NmE4c0JjcDRUQVA3T3oyS1F1?=
 =?utf-8?B?bGtXMFFoSmJrYTViWnEvNVhOby9idDlXd2NwVXBEQ0d6TG9JNFl4QTl1emRJ?=
 =?utf-8?B?MUtuR2MvWlZpN0RndGd5cFdWdE1ySERxTjd5bkxTcDNkc1RYMEpzbWpEK2dn?=
 =?utf-8?B?ZU5qamRnZG0vclVSeTlaUWR6WmxFNUEvVmRPWE83Rzhiek93ejY4NEtSSUJE?=
 =?utf-8?B?TDZ2ZHJibzE1dmpDR05PRzM0RDhacGg2cHNMRjJwaC9XNU1OWm9ocmg2dEZr?=
 =?utf-8?B?d29JV1hIaXdURXhjZnJSYVowanVDRWtlK1hoZGdZaUlkeHhLZU5iaittT0tP?=
 =?utf-8?B?Wmk4VGoyaFgwZ1ZUcytSa0s0NHY4U215RlhwcHBrS2gzL1FJYkdrZmxnRHN2?=
 =?utf-8?B?Wm55WFVwQlV3U3BONlp0WkRwSHZoU1FRckFkcDdDUnpnbUVQbHlCUFV1aE5N?=
 =?utf-8?B?ZGtxUzR6ZUM4WkdQWnJ6ZmJKUEdxSmJKMlg4R2c2TGltZnl5MGZ0dWpaMytx?=
 =?utf-8?B?ekw0VXN0ZklZNUw2enVVZDF6VEF3VFFsN1UvZmE4QUxYU3c1dDBJbTVRRG4x?=
 =?utf-8?B?b1pOSFprcWkzbGt5VXcwbGpqYnpQOXE2ZFUzZGxHNHNoNmljV2dNWURVdUlS?=
 =?utf-8?B?bTE2bkJ6TmVrRGVVNmxzWUtYNDlHR1BvQ2VDRENCa2ZFb2RpQUZZbzZEV0My?=
 =?utf-8?B?cXlXWDFnbDQxdXAwYzlGcDgvL291NWgvYUw1MlUva1FIZGhaZk9tQm9EY1Jh?=
 =?utf-8?B?cXRmT0gvK1pKVXR3M3hnY29MOE5DMTV3UDY1QWpPRnA0VkJOVVFPZ0FQUjlI?=
 =?utf-8?B?Nm4vMTVtVWVhd0puMElOWEtSajRhTHA2bjZPRFViQnNaVHFMUGVRZi9wUVJ6?=
 =?utf-8?B?aFhuRGlkUGh3YkxFR0lkRERyWnBybEtzaW01MTNRR1pnelVVU1VaRERmTjFS?=
 =?utf-8?B?a05Sbnl4UDlpdmpDTVBLb1kwRk51WEMvQTdYZFNLYjIrUlZwcUN0T0RQMFox?=
 =?utf-8?B?NVAwNjk2UzE4cHh4dExGZSs4M0dWekoyWDVQMnFBcHl6ekliell1M2hBd0Fn?=
 =?utf-8?B?ZmNmM0FTcTVUMW9EbXF3WFh2blUycU1seStXNU9FY3V1czU4a2tOMGNSS2Jq?=
 =?utf-8?B?MjJtYk5TSDZVNVpSQklFL2pnSlA0RmZzbFZtakV6R2M5WHh3bWxmTzhEdjlo?=
 =?utf-8?B?WWhGSW9zaWJhNUFzaHA5RXdJb0E3TWMyR1d1cWsvWXU5ZENVNHNsSEVxNmlv?=
 =?utf-8?Q?q6pmYHBVwGnlCQqVvK2ORRGZegOjdy+viT0rYCzKXosw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fa7f38-0f07-4687-ad91-08dbdb09982b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6964.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 18:37:26.6634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6308
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

On 11/2/2023 1:50 AM, Sean Anderson wrote:
> On 8/17/23 13:04, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> It's already implemented in clk-mux.c, export it in the header file.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   include/linux/clk-provider.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index b8acacd49e..801404480b 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -247,6 +247,12 @@ struct clk *clk_register_mux(struct device *dev,
>> const char *name,
>>           void __iomem *reg, u8 shift, u8 width,
>>           u8 clk_mux_flags);
>>   +struct clk *clk_register_mux_table(struct device *dev, const char
>> *name,
>> +                   const char * const *parent_names, u8 num_parents,
>> +                   unsigned long flags,
>> +                   void __iomem *reg, u8 shift, u32 mask,
>> +                   u8 clk_mux_flags, u32 *table);
>> +
>>   struct clk *clk_register_fixed_rate(struct device *dev, const char
>> *name,
>>                       ulong rate);
>>  
> 
> Why do you want to export this? None of your other patches use it.
It will be used in HiSilicon clk framework driver which i will send
after this series is applied. And this function is exported in Linux
kernel CCF. So i think it's fine to export it in U-Boot as well.
> 
> --Sean

-- 
Best regards,
Yang Xiwen

