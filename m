Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA53C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 09:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2466870D5;
	Tue,  7 Nov 2023 10:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="V67YVq5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17D7870D5; Tue,  7 Nov 2023 10:56:46 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::712])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB011870B8
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm0DZbQ6qoXDQchVWmLe8ct65tQTnmkXHi58BcZxk/lv0e6Le4fiwnH5AU3NLgKrKhWdQbH3xFDNqlFvxRhZarAD9Pe9okbs+rrc1Y1kFfcYPDI7NsyZ9lUsYx32P5bPd6UEtpF/9N3R+jBF7+tYP/nfwPjbunQn7+XNfIORb1Z65aFXevcqdTCP+FHXnufXI0YsX9NQOPAQShuvN35NtgJiqzlgtCtDF2opg7ZNLglhP+TDvEE4PCDDumJU3Z7Pzvt2zTqZ0YlK+hpdY+JhqkELDX2SckwJTSM4PsA68GzwSojFtWC79w5LwCGkCU7FCxSrwyu/Dd0xsWwrWDXQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvEXjPEhNJc3gpCB4crYWcKH+PZgY1N+++pOkNOmKuM=;
 b=ZYPRy88cmY2GL9vq8JbiabUHLRZ3IgeFU/O2+SMVEG2l2eA56XLruNcmPDLWjRZZzNfUFIVKQkmUxnBV6FSqoyHwaEpN7x4m2naLv0WwCApCN849kwQ5rVWGsDmZscLJp8RGwhi5EI3sfby57Xp5sAjjJtYkHbHZfxYP4oXBz8FxRiORerai3UBviZOxYzuR9ZbQIGkwLkIKvI2JaVtN//9HfBv34+R2+6CFwb+L+gWWcB0GxVrHdN4jXvHtMxbExXIaqbwAtmY36tLSsuVmxwJCqPGafBJeKuS+J4WAW9phRGyUpDxArtZ2pQYg68dd106eSCNl4jnwTFx6TA+S6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvEXjPEhNJc3gpCB4crYWcKH+PZgY1N+++pOkNOmKuM=;
 b=V67YVq5Ptoq04tir+Z8z03oC1edMwJbq84ausB9myq3XLft2Hylf6Ya1WP5UCFbuT9+YMn1R8tYU/4J8QKGnmDv9LcMHTGYIy8ou5fSMTpKh848sx263RzZzMjtrJctsNjZEfQLdt/gJjvsfEBklzdJ2Lh7ecQgK+cl8sbwhsYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB6611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 09:56:39 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d76:c11a:5c3f:3245]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d76:c11a:5c3f:3245%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 09:56:39 +0000
Message-ID: <7a1345b9-8844-48e9-a1b5-8c7508cefeb1@prevas.dk>
Date: Tue, 7 Nov 2023 10:56:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] bootm: Handle compressed arm64 images with bootm
Content-Language: en-US, da
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Safae Ouajih
 <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>,
 Sean Anderson <seanga2@gmail.com>
References: <20231105200453.1887418-1-sjg@chromium.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231105200453.1887418-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0016.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::29) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe7ec16-9f48-4886-2358-08dbdf77d667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WihnkSjxjhC7fWzKKQ+DZHDvHZwg6z6tO46cEARfJ/hew6O8GeqB8DMPsXRA1ANtdjcN4Lcl73b/7LqmVFCCwl31Cbw4HE7Gm/sSus9EcVVt+09WIirEpo02hmI4rCZXNh3+UCG2QFBlhpvVmpgreHpEC91ukSxw0T6gNdbPQbWs1LHhgRiTRN7kOnIiqSXwKhEss6etXgLPkpQGxHZUK+hcIBjv/lK2+cNa+0aVcgOFkXUWNtU9umMuJP06S9RpylBFK8bkOY7dNQh4YaUlmRkoCNaQO5A92kM5W922YdtDH4nfDw3b7oLRT4KeBNaMdVOw4fgFzai3JBAeJ4cRXR2bO4ZwvJHEGZ8me/xOfMjpQzbKqdQ4SUkYcoga9crfqa7M1U2w7uV6mq68RGcwfuiZx10yKEh0/705IBCGOPUjHweFZg+4EedjadxpJcEThPZFMx4ke4c/GQPwLuw3iYEgh6W/abCStemBBP2ww49t24+rwlR3ks9Q6xbDkrvj7bspFMbC0ZX7Ghh8ZPLI4aO3X+JDqj45O9vwhObC0kTNrHf0eAg0vFwpMpUfI8Rj6wAkKaChb21P0I42j/emGsPSiAKQjSWqmGUEEQtSTPhxcu6zBmY+WqOq3D0FC3WwjtGMbCgDupuaGXAlNnyK8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39850400004)(136003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(54906003)(6666004)(38100700002)(6506007)(316002)(66556008)(36756003)(5660300002)(7416002)(31696002)(41300700001)(66946007)(6512007)(8936002)(8676002)(4326008)(8976002)(26005)(6486002)(2616005)(110136005)(31686004)(2906002)(44832011)(4744005)(86362001)(83380400001)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmQrR3pNKzZSYWhqeTljeFhUWU1HODE1MFNmZjZTMExnRWJMZjBNUlhCcVlG?=
 =?utf-8?B?SkNET3ZyakwyME5NUjJzVnJ0T2VOZ2pOZktabE45NEdiZ1Zxb1ZjWUFXalJS?=
 =?utf-8?B?UEQ5Nml5U3BVNVVMOUNGWVkyMG1sa0kvTEZ4NkJEQlByUERDTHVGd1J2dTBU?=
 =?utf-8?B?SnNrNGFNeUxLMlZMUmJ0MmJwUEU5L3NxaWhNaEdnVSt4NGd4QnFWVHBEOXBF?=
 =?utf-8?B?eFIvWGQ4NHc0UUY2VGNpZ1ZmWVlmOTlwVDRqUkhUTVRkc2JtR0RVWHdRZ1NW?=
 =?utf-8?B?RWljOGZjQUNjRUhhMXlHM0ZVTmVjaTFkZVRyQU8zL05LMWZlZTU3SHowMk94?=
 =?utf-8?B?RlllMUFTZ2ZDVnhRY0p3RS9zZVU4b21QUDBJSHNMQmd3QSswamtjSXpQenAr?=
 =?utf-8?B?SFhOTTA5dHdKbERlZzJma1ZpMWZqVDRFTFF6bW5vUitMdW1QcmNsQ3B3cDRP?=
 =?utf-8?B?WHN2bmZ5VHNMa1VMbTArbVEwRFZ3SFBrQUMraVNRQ3FUQ2RNeWlPK2EvQ2dH?=
 =?utf-8?B?WGtXR2pQaDAwOFd2a0lkQktFNFFQcmNOcS91NTIzSWRISXRzWThYRVl5NC8r?=
 =?utf-8?B?QS8rZTJGZkRiUjQ5VVdtVlNWdXZvN0NST2ZFNnRYZ0k5MHFBTllES3U2dGRV?=
 =?utf-8?B?dnBlWXdtb2tKWFhkcHU5SE9ONFlnV3FLUVFJMVJ1Zm5ZZklES0tvbmxMbHhQ?=
 =?utf-8?B?eFhoWnNabTl1Q0l3VGZScXIxMHBjUzRFSFl5K2grbVNmVG9ZTmhNejR1aFY1?=
 =?utf-8?B?eGY5U1lrTjA0K21MQWw2ZjN3SWpwVW5ielFPdm9haWVmd21uTUVocHdieFhG?=
 =?utf-8?B?R1RlR0lSMTluNGZKdjlBVTh3YTNaVnFnWlBwKzhUZmZkNGpCWGhOcWVJN0t2?=
 =?utf-8?B?WHVBaGF1VlNKTTg2NHVKRGgweHhEeVFLL1FHdzdvSHM5TUl5eW5wSjBzOFMy?=
 =?utf-8?B?NW5DMXZ5UGNObVpCV0lITThJVnNmK0M2UHlFMEM1cC94WWpzYTBZb1RpU0Zw?=
 =?utf-8?B?QWtYcVlVTC9MUmEyaU1TZFJIVnUvcGdpNjhKd3hUYVFvNFlZSGV5a01NSUdi?=
 =?utf-8?B?dk93bWt3Z2pmTUFBNTIySG1ZUzhwam1najZiUERpcnd0VVdMQ3B5YXhBYnRI?=
 =?utf-8?B?SEhreW00emhJaEdmczZPbU5ndUp6U0lZQUp1aDdvYWs5RWljWHZraUZsZ3lR?=
 =?utf-8?B?UWZjWTgwNncyZGJqaS82Y2lFMjRQY1ZhNlBnaTZDN0xpMDNocTZncWwzc0Ro?=
 =?utf-8?B?cWNIb2I5OVU5UFpCZkRFd2VyejEvdmF4VUFkU25wMFllQmdXcFJUMy9jT09a?=
 =?utf-8?B?azZUbVdDOS9WcFdQQ3M5eG9wUTI1a3EyNVhsSG14K1Jyby9nLzBIemEzN01r?=
 =?utf-8?B?aDYvcFliVnFDOVJVRTRBNUxBZmVSR0NkUkNabVVTbmo5ZUxRTmhRbXJhemNh?=
 =?utf-8?B?ZEw1aGVGRFZwMXppanZkOEw3TWJnS1FOSHBOenJBMDVGQm9Dc0Mxd3hwWnFt?=
 =?utf-8?B?cTVjcldxYnEwZG1qMTk2L3hkTkw5d2g1eU1CQVNzdFVpbmcweEpFVXRIb1RV?=
 =?utf-8?B?L1ZsekpsZy92d21xTUpzQ2NUWE5PY3hERVpmeGtqNkVkdkNESHAvek9zZGRB?=
 =?utf-8?B?aFRXeUdEWmRnQktDMW9rRlA4S3crYVhBNHZ4ekVVTkgyN0ROeEdJVDhpM2xm?=
 =?utf-8?B?cTB3NnhuSlFsWGQ2Q1VIdVF0YTRBOXU2enZzNmNKTllzcGUrNm1oRUdtSXFQ?=
 =?utf-8?B?SWNSc2NWRGNaUTdiRUhweW5hS0d3Q2dHK2NETnZSdm91MEtjUVJrTmZYaFFK?=
 =?utf-8?B?WW5kMmZHS2EvSC8wWkpFbU5tdnVUQVF4Z2pPenhqQWFwZWFIODRwWGF3QlFk?=
 =?utf-8?B?L253VTRNM3R0d1NHVVRSWmlRdkQ0KzJBdlBFUmRhcTVVTVVnM0xDZVRuM2xQ?=
 =?utf-8?B?amxhQWZ5b3h2L2JqZVg5OEpST0FKbjh6OTBUVkJqdlRoWTV0MklLenZXVEtm?=
 =?utf-8?B?Zko0QUpJd2t2ZlpiRGMyZnRBaVVZd2Uxdjl5aFRmY3RlS0NqcXUralIxWFh4?=
 =?utf-8?B?WDdBVElXMGFJU29SeGc3Q0FiMnZoSUoyN1p4WVlPcGVwYUVVQjN1STA2aTIw?=
 =?utf-8?B?R00wb3p3eEtTcWpGb0lkekVYaW4zT1h3TnRDUXB5MEptK2pZamNCTy9Kb2Y4?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe7ec16-9f48-4886-2358-08dbdf77d667
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 09:56:39.5396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psvojaiamazV20WBFbBlYK9RnkDzCMA2G2aqO9Hj0qT1/7QJWmMn3UxYAe5DEtWQJBYAi+o/G+3gLMYWMB0a+Z2M40vcSZqFuU5gwXNbELg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6611
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

On 05/11/2023 21.03, Simon Glass wrote:
> This little series corrects a problem I noticed with arm64 images,
> where the kernel is not recognised:

The $subject is misleading, bootm works just fine with compressed arm64
images, with the type set to "kernel".

>         Type:         Kernel Image (no loading done)
>         Compression:  gzip compressed

Isn't that a non-sensical combination to begin with? Decompressing the
Image.gz kernel image to any location (however you determine that
destination) _is_ loading it.

If you want XIP, obviously the image must be uncompressed in the FIT. I
don't understand what you're trying to do here.

Rasmus

