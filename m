Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9647CE7B04
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 07:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B877486D43;
	Thu, 28 Sep 2023 09:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="GsPqj7zZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78CBC86583; Thu, 28 Sep 2023 09:10:39 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8509586DDB
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 09:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHDpU8qJt2woDJeAG96zX+8oCSF5JKXD8X96hZhMe4QpAXYgsDeuKgcJ0FuQV5ktuDXDLPV/+GSkWYkOpGVoReL3oaT+Jqa4NGhNEZg5JrcjipDSRBRSfyFRsv1wjLlLwujciKlWzQ/EWVy8dHa1RNFCRFGAJlBXIIuTRhDgyP8ttzNS9w1wjLwLHMNdSDy0lIrF+zGTPZOGbaO7KeXWIIUziJwB9e116katRYihI1rT3LgCZfCxePQR4JEptYgPU+YfXHa/r+yg1p9MiyNL2kxL0o1JSLuvd9YZQM2qS6L3BgDJvkATnhqj5VEJDsTykcZyE23ZZ36CyVWfitZq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mE4LEGMv0AzSpxaahnpJvXMVCWxgegxh+jamN3K7CY=;
 b=nzAjh699u9OK2jByShnzN4LSHq0e7bodQUC1WYFJ+kfAvgAPJjTIIXQP3iNdUNB8VsLXkGabmZiPSFxg5dOYEd4pHCKYGEmfQtuUDoIjR3Y4qwWf1ofVBUWFdLIVVxwpi0gOhqVRWchG9DnexCEVrvhE9iDyi1qPfzqDmHLjnkyQetlRHNTBmfvqLx0ZSRNACCv9U9Upx5NTczbhdoLwASdw4w2dEfgMMRMX9PFRypQ2+e7wcxoLsrMCQjBJNf8Q9kTK9zt2VL/lLR/+CvQAzEIvcgAZZpqdMudBiEgCM2HRPBqneNMA8f5lShpaCehWJf6h2lnmO+lkMcaSUDEC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mE4LEGMv0AzSpxaahnpJvXMVCWxgegxh+jamN3K7CY=;
 b=GsPqj7zZQwFx4vunhptWpCFE/Wse2QDHMDPiJ6nLAcHKb+6c2Gw4OgQIwK6Z6HfZpsNc83RPTqmWiIu6BHSM2jzxSTehmsUbVyObwlpd+GaO3PX6iJ30Za/4iln4loXeVj5xpkS+g3BAEYt0uKN33F7m6kL8ReIZGxpJ8tBJAn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7302.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:616::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 07:10:32 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 07:10:32 +0000
Message-ID: <3fd4d611-891a-fc3d-7385-c2d621cf2eac@prevas.dk>
Date: Thu, 28 Sep 2023 09:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
Content-Language: en-US, da
To: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
 <6ac71b7e-d84e-10d5-e500-0d54e5d6c191@gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <6ac71b7e-d84e-10d5-e500-0d54e5d6c191@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0059.eurprd03.prod.outlook.com (2603:10a6:208::36)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 19256b8d-9f64-4220-c9d2-08dbbff200dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h152le/lV9OeCkvOshbpCtnOnYyI8Wak1tHypjNHXv2Pd3VdRMpj4pMyHg/ms9+lmmQdLoU+M0U2tM8LYTujXQgjrhCdkY4GOorsYTYrAzsrTMSs6WZcoyxr41wwOb0ReOxF2lAoeYyYKH9Hr3JnFkow23eZmj4LLrtkVYRn8Kmd4UlzKVcdmhEVHfANrFDcxIpBoQqhuMDMN63U27WKOPdSN/ofx/OqrpaeSlK5Eor2flkzz+su1Y4yH7wrMq9p6XRok4ZEA/KdYf1rhQ5K1OfvkGR3FFmqpjqoDwu7xuNHqZ5chtRgvexCl5Yb8oeFd/7KnTcUWuLp4xuL+lf+J3FaV0eRQ58Lu447BWv1po43IkqmVXI8lxJlNYfvGawaH1Qg61ALJ6QnD8VnVMf7a08XYLfTNfwuInDExRYI+4zUIsTm6ys+Mgegw+ZFCda5+fT8yYipcSW3YdlHsrDZwHu9P6lJf9XFtxq1cNcyQvZhwOzw/q4Zyv4sWarP3jz72MSLC5TMwKJ5pKJ0KGoCkcqzjvbAxyxJZ15eeh+ZmZcbZuOsFb/k9k3wEQUgGWX3YiX2RcJI4MOIAe0Ow/0+pC1jkF5PuFUp+MJT9OS4XX04mo/ArO04CX+kS/2QG8NnkXS9HyRnJ28sYGm8UcLSeOB+xN9jhzxTjFJDejrjylDLNBmOXKH5/CW0VP7PZPsB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39850400004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(52116002)(41300700001)(83380400001)(2616005)(53546011)(6512007)(44832011)(54906003)(66476007)(26005)(66556008)(316002)(8676002)(5660300002)(8936002)(6666004)(6486002)(6506007)(4326008)(478600001)(2906002)(66946007)(8976002)(36756003)(31696002)(86362001)(38350700002)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0pBM05oRGk0K0xCbjZqNmhzdXdVQUYvTFNtRjBnek93LzF0a0FWc0E2YVlr?=
 =?utf-8?B?K2tMWk5rU0dTQWRIMUxONmJuZXZvRFpWMjFaUSs5cFljRUM5WjArVmpVRWRk?=
 =?utf-8?B?bW90eUtsRGYyK2tQTHNScnBxdU9LVklSU0RPN2NXbDgrUnRtajhoK3RvUHNp?=
 =?utf-8?B?VUw4UVRBREVzL0ZGenNiWExlTWRWK3dOYlN1YTBYVjVqTmsySUtBc1JCUU5i?=
 =?utf-8?B?RU1RNmQ1SkpEZ3RzQVYzNDRnbEViU1o2K0dONW9BSUtrd2JjY1c1SUpnQU1i?=
 =?utf-8?B?YWFSVHNhNWFJaGhjRjN4NGVKL1Y2QkprbUFkbWpCQ2Jxd0pRTng0L3Q4a1pO?=
 =?utf-8?B?RVN2RGwzYVZOOUM0ZzdSeS9EYUd4ZnN4WWU0ZHoraG43T25jUGlyall2NnBw?=
 =?utf-8?B?Q1dNM0tIRHFtV01rby9ZTWs0TXo0Wm9NY0ViMWIyYUlRblBLV0grbXh2MXlu?=
 =?utf-8?B?NTJhK2t2QUhaZDZQZy9RVC9Wa1ovYUFyWjlhRU52WFlGblJ1V1RMenA4SURU?=
 =?utf-8?B?T1RlSEk2UjMxUFlSdE5NNXI2MXFZWFZoUGZ4WExPV1N3ZGR6cnpJMUZ6KzVY?=
 =?utf-8?B?RXVWTFI0S3JkazdON1phdXA0QTQxUld5ckw5V2hqWmgyMEFLc1I2azZORXoz?=
 =?utf-8?B?OGdvckdBV2djOEIxdEVwY3oyNEZwcm0yVGxHejN1R3FJeE1GejZ6UDhiT1Bm?=
 =?utf-8?B?OGE1Nkw0VHlIby9DNWJQMHFDRDZpdXJWQ25jbmtPVEJhUlJYdWl5YTllZnBo?=
 =?utf-8?B?bkdxK2VGZDdtWERiNWVMa09BdVNlUWdOemhZMkpDclhLWVMvM3BZWUtGb1M0?=
 =?utf-8?B?QUkvck0vdllOVGJsblZQbWE5b0hJM2ZHSWttaStEazM4bmQzWXFKOHVvRHhP?=
 =?utf-8?B?WEZuSUp5R2JtTm5mT0FVUmU5RWdka3h5QVJ0Q3FaRVlIaEd5YzFGU0IxZXo1?=
 =?utf-8?B?d3VsVitQOFJRNjMyVm5CN2taK001d3MzSWFGQWdqRnIxTXd4d2kvVFY4ZVhn?=
 =?utf-8?B?TDUrRTRtVW9QSGhnd0QyaWFZZDVHcW5vYUxvd05Ya3MvOFZ0WlkrN3VqYVNn?=
 =?utf-8?B?NGVMTm9ISTc1Y3hlZ3c5c1NDUWk2ekVoU1JNblBxWWNTVkh2cFNEcFordVN0?=
 =?utf-8?B?U2RWYjZaT0tpSnVScERFOU82NGRKcGp6SlFLclhhK3VQRU5TOEdrcFF1RU1u?=
 =?utf-8?B?M25oeUVRNUt6bW5IK1luem1OaUtjQTVYYjR0QTBRaDNaVDhkNDA1bXUvVGZN?=
 =?utf-8?B?bUF3Q3dWTmxNczZyM2hEYmRGOW1wbWxZVjJzZ01kNlNTdEtmK2hKaDhnTlFJ?=
 =?utf-8?B?TCt2Q3Q1QUNTZkkxQ0JKbTlOS0Fxc2QrSmcxM2NIZXduNmUxVitvVzlsYUFR?=
 =?utf-8?B?QmYycGdKVWRjQi9pZmFVS1JKY2RzUURoa1BWUXFMci9EeW5od3BrM0tETm84?=
 =?utf-8?B?eEc4dTVhVlFuUVNVby8wZnRuV2pJNFpIWEc2eUczdTQ0ZU9TTDViM0VjaTFF?=
 =?utf-8?B?SnljelJuZzZpSUZySmd2VnMxNnZkb2hxdXZRR0xiSlFXYUlXbExOT3ZZWDFL?=
 =?utf-8?B?cDduZkE3TFFVNmxGeXkvOTI3OFlDeWFoV2xDNkpnWkMyVk9UVTd4UWxkSCt5?=
 =?utf-8?B?bHFjNStYa3FjK0hXMXZOS0J4aDJ3YXBNanRPcDliK3pLckt6NWhSR2FiUnhv?=
 =?utf-8?B?RlhaMGxEeUhlM1ZPSVc1c2V4L3RSd2p0TkFpM3RLSE5QbzZ1c2dOdllWQWU1?=
 =?utf-8?B?ZkdUOWMwNW8vRFZkaDFBOE54NXI5alNrSFdScjVYdWxzbHU3NmJqT0tUM2pB?=
 =?utf-8?B?aUFFT3VzMmNZRnFNblppTzg4cmRjYjZhTHFWTFo2N0RFSFhrakNxMkt4QUl2?=
 =?utf-8?B?NEc1akdmRThVd0Zzbm1VbHZXcS8vUkJ1Y2Q4aktzdDhGdUNYT2hFU2UzWStl?=
 =?utf-8?B?YXJYTngycGU2NzFjVFJKZGVmMHg0M0dHdXFQWGxDOGJyYjZKOHpkQ1ZFRWlX?=
 =?utf-8?B?d0lkZC9CcmdZQTBqS2ZLT3ZWT1pIN2kyVjhPdU5oV1J4MUJSQkVjbm1Fd3F2?=
 =?utf-8?B?Z2F5YlRPTDFyOXQwcWE4c3dOeFFwVnRJY21NTWNYZWsvZEQvdmxid3hSRm5O?=
 =?utf-8?B?U1poRlJrQmNxek5HcVpHblF2QjR3ZWlpanNwVGRzTUZQWDZBS2xsOFg4S1ZT?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 19256b8d-9f64-4220-c9d2-08dbbff200dd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 07:10:32.1895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZ5EtUeqzm8rNAEUxN1giNbUAAY1bKz4TRw+HlLfE342Pq1/l21OpF+TNgOu1/Yz4TDEoCTp8XLqGK5pzm7pAnapDqOX3aWqiFD6lJNy9Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7302
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

On 27/09/2023 21.02, Sean Anderson wrote:
> On 9/19/23 07:37, Rasmus Villemoes wrote:
>> In some cases, using the "external data" feature is impossible or
>> undesirable, but one may still want (or need) the FIT image to have a
>> certain alignment. Also, given the current 'mkimage -h' output,
>>
>>    -B => align size in hex for FIT structure and header
>>
>> it is quite unexpected for -B to be effectively ignored without -E.
> 
> FWIW, this behavior is documented in doc/mkimage.1 (which should also be
> updated if this behavior is implemented):
> 
> | The alignment, in hexadecimal, that external data will be aligned to.
> | This option only has an effect when -E is specified.

I'll send a follow-up to fix that, thanks.

> And, for additional context, the documentation for -E is
> 
> | After processing, move the image data outside the FIT and store a data
> | offset in the FIT. Images will be placed one after the other
> | immediately after the FIT, with each one aligned to a 4-byte boundary.
> | The existing ‘data’ property in each image will be replaced with
> | ‘data-offset’ and ‘data-size’ properties. A ‘data-offset’ of 0
> | indicates that it starts in the first (4-byte-aligned) byte after the
> | FIT.
> 
> Based on this documentation and my understanding of the code as-is, -B
> controls the alignment of the images themselves, 

Yes, when -E is in effect. My patch does not affect the case where -E is
present.

> not the size multiple of the FIT.

It is _also_ that, but mostly as a "necessary side effect" of getting
the first image aligned. In order to achieve the desired alignment of
the first external image, the FIT structure itself is aligned to the -B
value, and each image's size similarly aligned up to that value so the
next image ends on a -B multiple again. So with both -E and -B, the FIT
structure itself is indeed also padded to the -B value, as the `mkimage
-h` output suggests.

What I want, and expected from `mkimage -h`, is to make the whole FIT
have a certain size multiple, without using -E, so in that case the
alignment of the FIT is the primary goal.

> However, from what I can tell, this patch does not actually
> affect the alignment of the images,

No, because the images are (still) embedded within the FIT as ordinary
values of the data= properties, and it's a basic property of the DTB
format that those are always 4-byte aligned, and you can't (easily)
change that [1]. Which, I suppose, is one of the reasons U-Boot invented
the "external data" mechanism - so for example the .dtbs embedded in the
FIT can all be guaranteed to be on an 8-byte boundary, and thus the
selected one can be used in-place when passed to linux.

> but rather adjusts the size of the
> overall FIT to a certain alignment. I find this rather unexpected.

Well, as I said, _I_ was surprised by -B having no effect based on the
`mkimage -h` output, so the two sources of documentation were not in
sync. The man page was/is correct wrt. the actual code.

Rasmus

[1] There's a nop tag one can insert, and I think I saw somebody
actually suggesting to do that to align the embedded data= properties,
but it's quite error-prone and inflexible, as any subsequent
modification of the .dtb before that property will ruin the alignment.
