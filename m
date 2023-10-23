Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1A0CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 08:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248008788A;
	Mon, 23 Oct 2023 10:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="QbUK1YMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17299878BD; Mon, 23 Oct 2023 10:28:44 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9929875B1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/AZNqlGvqHfAtvDgtOctJRHwdaOb48pBGCbHn+EepUEDs+JUpOd8/OxrnIqWKOQfZniXASAl1hTLeU/WT/YaejnztUuHvY7Ar05AShbp9puk9qDapsBIJ5SdPtUmFKt78oTV+t4SOZ1DzY7NrmVaLiaFA8fKCRFwx550YI8nVf9cd2Oijged5Qum5f9q30c7nTZjGqnweUC9x2sgXO46Ya414vB+rvbSgKlRVzSUfUJQkraVophFeu4jTKCWQibnLKL29CjEiEqjI82FSMtmyi8H0thU0FzZz6r1MSUfdlm7SQaxbqopgWGxw/m1N8sDY5RRM8apuxiDCC2up8OCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSolQe35OBnK6+uLS+wDXg807nwN5eM6zX4bY7dNzV8=;
 b=MgEFMgAw7zcyoFKMInCpiS4TvanklDL453BN+vEH2gWnOHDUH0rm4yzGhj2hj5lwBfpPqEF073IEeDADDAzESKsv1CBIRAD1ekDTdTpYIbEWz4xFgc4xV8dhOteabRjTaYNxNJNh60guztKHWmkLXJO+udrk9GKkq/evE4GOGgDsQPfgZiHOtS4Ind+sBcaBZFvFV0PoajH4qhEM4Y9xL/aiTTnRZEJ2Y1jXe0+EWXS1n55buo5UJJViT6cVOmIdt8uPcQhG1Z5hujaIfYTdw6WFSQM9uWX4u4z60nBKyh54i040qMk8A9VkSFz2e/6y2Re5Iy290t0b3U0lhWgYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSolQe35OBnK6+uLS+wDXg807nwN5eM6zX4bY7dNzV8=;
 b=QbUK1YMJImw5JEyYnsQALyrJlZeknI+YydEut2tDZDsfMR1ZGpZVJkCNNOeS4CMObsLrskVQdAJCuwkl17lhKK4aHfNsbTigujzK7NpxyhH5DYBD5/hsJU1DLV8e1qOpUbCMahqwXepBUq3newHlcMrDGhnZKoR6Inuvmro7oeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6232.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 08:28:39 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 08:28:39 +0000
Message-ID: <ec461be8-afaf-4ecd-842c-faeea8a6935c@prevas.dk>
Date: Mon, 23 Oct 2023 10:28:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] led-uclass: do not create fallback label for
 top-level node
Content-Language: en-US, da
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-2-rasmus.villemoes@prevas.dk>
 <6d33180d-f611-43f8-9b73-9ec44eafd277@denx.de>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <6d33180d-f611-43f8-9b73-9ec44eafd277@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0104.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::21) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: a5942376-6637-47f9-f79c-08dbd3a20f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOxBWQbGiQRjfln7RLJ5nW15QHPm68OEVOBqZLfGzqdPGtDl0uT78tMUU1yQAwkJKCh6AKGraVuWoVHZuGujN+tmlCeydg1a0Rb4jku090VPAfyoIhfOn77Sjg+duQ+sd1oUMmnirVtqtsijRbDjOWeKx6PIZgQIrwPSdMW3NNDxNBxJAshQKCZ0CzuHX41uHAdFX61zj6QauyFVvZN26sEd4FR/pW2u2B/TKTQ0PqqDyzhfAuaxA70T6HTNLlccqznbNNILRh291wF961+kPecikscKT5OFcq3expNQDtGG1IZHraa0WedgLkAisvraPNK78wJEQVkOoa5a0NqsLTstyAQlDJznbyHeKMFrbfciPLMRTxK4lg9n/8Ui73vq+Wh1KLRl1z13uWYSWy0/SNiF5UI90hdGEHKosq7SQe48WR3KxRxr52pWGev8RbB00WHQIFL9KXselg/08MDXv3US7ZktHJtT0EBQjEy2oKYTuBkF9BKTOl4NWvecc6DfG9a29Jq0pwXak8AptN1h2ZrP5s+6BeuYx2p/ZHcypatxD7LMNZC8gt0y4/8Alkmht52ocWQROsLVZ/rA/ithhKKS82JS16MdzuBXjtSRZ7YrAacedkNgjhEoQ4k14SG2igD+rAcHPuXTQwRK5m9hDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(39850400004)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(2616005)(6506007)(6512007)(53546011)(38100700002)(86362001)(31696002)(36756003)(26005)(44832011)(2906002)(6666004)(478600001)(6486002)(83380400001)(41300700001)(8936002)(8676002)(4326008)(8976002)(5660300002)(66556008)(66476007)(66946007)(54906003)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2dGRFVHaFRtN2JTSnhrS2t1UVdoSWtzZ29mVUNMeFl4ZnNHZGEzTFZIdmtY?=
 =?utf-8?B?REVLQysrL09JdVJVSWgxTlZaRlo0d3pGbDhKSSs2bW1sMWg5RHVwTExxWkVa?=
 =?utf-8?B?UURsai9rMHZVR255Q1UrMnB0OWthZkVtVGZkRlE1Y3hmSEFZK0N4a0lBSDd2?=
 =?utf-8?B?cnZlRGhJWmp6YWlSRDFtS1NtVEIzUmlhZCtwcndZWnhGenhhVlNUNUVlZXdu?=
 =?utf-8?B?S0VpS09pQkdqWHNvVFVkcSswWXdLQUlDNW5HaTNoZkZaNlI5MTlkSTlEeE9a?=
 =?utf-8?B?UU10dURMWFp5ZEVVVXRUM2t4Uk1LalBPWEY0QWo4RVBERzRuZEVwM0txVHRT?=
 =?utf-8?B?NGNyb3d2M2VDODVQOUhleHR0Z0hJaDg1YVpyeVM0eVhLR2gzOS8vaGV2SnVo?=
 =?utf-8?B?MUVmOStBcCtLald0UGE3cHBXcTNoVzBUSjZNTnpmTmdvK2RaUGNkTS9vOVJW?=
 =?utf-8?B?cWF4RVM4bkd5VDBZWUtsYTU0Ly9uL083V2V1cmtSWVBqSjZxVkk1YWIxUXc4?=
 =?utf-8?B?WUdPdk1XTnZ6UVh6aE5ZMTRIVXgxSlM5YzRWZTRCR1loR1JlY3N5V1JNWGdG?=
 =?utf-8?B?NWlUNVl6TEoxL3EzUWlFRnUzKzcxRDBFRXlPSkUzMmQ2WGZBc0VkdTJLQlRp?=
 =?utf-8?B?VFZJYlYvNzJULzRPcXVwL2p5cVVUTDRCcUtwL2hLR3pRZ2pWMHBHUUNGZ1dj?=
 =?utf-8?B?S3JIVllSQ05pT2tpTVU0UjRWMDgxTURINzdVbnBmRGk0MVlHU01iQThiSkI2?=
 =?utf-8?B?bGZWbE9Tb04vV3lOQmNaN2tHWkxjTGV6SE1OMndwREFJR08rMEtSVWtIZXlN?=
 =?utf-8?B?SnlQTXB6SlNqVHY0RnVpaEpsQnNMWlhSYXZGSnVMUUM1aDhKRVB6Rjh6TjM5?=
 =?utf-8?B?T3JVSE5heFc4bTFiaGc0TEJxTTNnSnFBQjg0ckswcWVSMkN5VzJpUkF0RzEx?=
 =?utf-8?B?WUc5VDFCdEd4NUZwaEFiQ1JhZHV3aXJKREdwRXpaOG5WaEUzbWR2Y1dPSjRt?=
 =?utf-8?B?Ty82Y2xYSVJsdndNKy95YXNQZ3ZCQlZ4c05zMXgyNmtMUVRZaGU1MmJmT3ZO?=
 =?utf-8?B?TEtWRFpFbVZRMWNsdC9SUENwUDZZRHhyVjVlei94QUloa1cyZGpTWVI1Y2ww?=
 =?utf-8?B?SW1KdkhGSDQvcFlNSGFxK29SbFRMWXIxblF1YVAxMjF2SjY3NWw4dTExSXVu?=
 =?utf-8?B?c0tNVzFIZnpRenBKdElzVmUySVNydGFwSUlzdFl4MEdKMFJaZlZJRGYxRCtu?=
 =?utf-8?B?Z1F4bFE5SVZheEpIMWxzUVp1aDdVOXkwNFViK3RaZkk3czRKNjR0OHVOalNS?=
 =?utf-8?B?YU1pVnJETzEwUGZPbmJpVFpUS0d6a1ZiWEhxd2xtVFRpTnBuSzJjWGw2bUMz?=
 =?utf-8?B?NEtYZFNXSklmcnRXbFBzWGE2aVUrNEpGMm0zU1c4L1RzZi9vNmtscWJVZWtL?=
 =?utf-8?B?Y09Wb0JneE9NMytZVzZ1cXNnN3AySnl6Tm8yS0JhdDRRMU93aDZRRFVDTFRM?=
 =?utf-8?B?d1l6RTBHVzNianU2NUdGb1N0RkdQdDh5RGtGbmE4cVI3YWtzQlQrSVVJN0Zp?=
 =?utf-8?B?R3hPeTdxRmRyaXEwZ2RxT0NsM25SMGdsZE5WVCt3cHdUV0w1L1QzV3UvWk1m?=
 =?utf-8?B?TitqdFd2TVpxVHlxYkg2RUJyVEllOTZQa0FicnJld1BtTU1wMXJnYldDOXFQ?=
 =?utf-8?B?U2NEK2VhajE1U1R3dkxkczNPTW4ya2NqZEtEK2p6SEVVYTN4TVp2eUNqTjBv?=
 =?utf-8?B?bitjTHlsaXdhaHdQZVQzMWUvVlZ2ZlRSbFhKTzduQlc1Wk55c2pwZTdQZU56?=
 =?utf-8?B?WWx0VW9mU3dqdEFGVldaSGVBVXZ3SHVIZk05R0pNMDYvbGJoSzNoNGZDdDR1?=
 =?utf-8?B?a0ZudlBKNVE1OVcybU9VOWpaLzBETnRpNjRpU3J5cDI0Q294VG9oWUZBU21B?=
 =?utf-8?B?V29LYk00UjFDRTVnc291QXNORUl4YzczZWZHTTN6cHlGQjZraTFnamZack9s?=
 =?utf-8?B?VFRYc09mOFY4SDFHa2Z6bGE4bTQrOTdLR3dXZDVCWVdkMDR1YUFIbS9QWThm?=
 =?utf-8?B?cHlFbHJEQ0YxMnN1Q3d1RUo0RnRXZ0VkdERUZ01PODRMUUVQYUdnalVrNEdJ?=
 =?utf-8?B?aFBrUzVpdmJiRkJsOGdLUDVmSXVsNHlySXJzNlE1TkZvemNvY1piaFpNbGpp?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a5942376-6637-47f9-f79c-08dbd3a20f22
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 08:28:39.7152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EK6FMdaHbuCccvoCHOBvwsPSTJ2L1ZGXZlQTyCcaJPEJ3yZQ5jeNnD84lREdWrUOwTstqDFHcWfVjTNx2xLnuZBvNjGi9C/dkEa9dniuEiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6232
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

On 19/10/2023 15.51, Marek Vasut wrote:
> On 10/19/23 11:58, Rasmus Villemoes wrote:
>> Many existing drivers, and led-uclass itself, rely on uc_plat->label
>> being NULL for the device representing the top node, as opposed to the
>> child nodes representing individual LEDs. This means that the drivers
>> whose .probe methods rely on this were broken by 83c63f0d1185 ("led:
>> Move OF "label" property parsing to core"), and also that the top node
>> wrongly shows up with 'led list'. Some drivers have since been fixed
>> up individually, e.g.
>>
>> e3aa76644c2a "led: gpio: Check device compatible string to determine
>> the top level node"
>> 01074697801b "led: gpio: Use NOP uclass driver for top-level node"
>> 910b01c27c04 "drivers: led: bcm6753: do not use null label to find the
>> top"
>>
>> Binding the same driver to the top node as to the individual child
>> nodes is arguably wrong, and the approach of using a UCLASS_NOP driver
>> for the top node is probably better.
> 
> Note that
> 83c63f0d1185 ("led: Move OF "label" property parsing to core")
> and
> 01074697801b ("led: gpio: Use NOP uclass driver for top-level node")
> were applied shortly after each other, so I don't see the point of the
> aforementioned rant.

What rant? I'm merely trying to write down what I found out while trying
to figure out why 83c63f0d1185 broke stuff, while acknowledging that the
fixes that have been applied to some drivers are probably the approach
in general.

> I sort-of understand what you are trying to do in this patch based on
> $SUBJECT of this email, but not from this wall of text, so can you
> abbreviate the commit message ?

Sure, I can try and make it shorter.

>> -    if (!uc_plat->label)
>> +    if (!uc_plat->label && !dev_read_string(dev, "compatible"))
>>           uc_plat->label = ofnode_get_name(dev_ofnode(dev));
> 
> Is there an existing driver which has a top-level DT node with "label"
> property ?

-ENOPARSE? A driver doesn't have a top-level DT node.

And regardless, this wouldn't change anything for a top-level DT node
with a "label" property, as we're still unconditionally first trying to
read a "label" property, this is merely avoiding adding a fallback value
for top-level DT nodes (using "having a "compatible" DT property as
proxy for that "is a top-level DT node"). So I really don't understand
what you are trying to ask.

Rasmus

