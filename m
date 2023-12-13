Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0362FC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 07:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7AF87646;
	Wed, 13 Dec 2023 08:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="QYzhGMjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60918779D; Wed, 13 Dec 2023 08:59:44 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2575487646
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrZwk6acP8QctzlEfG//L43BNobg3Gs7PuHHG6S63jrLUV7GzShlmyOQmf8WP8Pb+iSS0qoSZHhiw5Edj3MB+Usb4m+ai2+9Wl0lEVU3sq+Mge8I7y7dzj0/u+I4BR7tng9LQqBer2VbwMkuIz23JbIOXYu9iBDUBtsUV8D8B1Q0giYjULRzvWoYlaLB7tjEVleKeOXXlybpoexgyCHTsEQ92GVd/i0Lpqrcp7I5VxZ/R/d+nlvxv/nP2798XKRAwT2m6euLbukgIJBplHSS9Hmzkh4TuywF+2h7GiCZP5RKD5du36sXwoOlhhSZMESgK52lMQT0Zs33YFlZn2NKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DonRC/rmo1D2eCQesWXPwBxPQDU8ITGNn1OrJ8Gk4Fc=;
 b=fqirhxnonh13JzjTrjKkCsarXv3sjh9NHK4cjhk/aS6B3WOqf/bXsPnvB108S3Dc/fCOA+ZUus8o9Qk8P2R89jxnDT8WHUyilJesKIXm+vjjOYfDD4K7bOgFoSjFFAGqipx4og6oeh1L7/gUeHRrGgpCy6/DVuxyibIrpa4EIIiG3lWOgyHVvD9+zwFzy9WIvKIybu6/MT+IYjDotiUGjoafHzAvcoDHg0LjQiyoRBKG/pefST3c6FjwPl6pPV9V1lVjsAnb8jtVcOIGuxPa480jCLL1TNHepoI+sQOleOnbmXqCmrg+ApqAWonjYh+Qd0vTHy8GPjlkLzGLWtOmFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DonRC/rmo1D2eCQesWXPwBxPQDU8ITGNn1OrJ8Gk4Fc=;
 b=QYzhGMjSvuaaoqWJDhYG7OE3RTb2owUn2ekXRZs4S/fX6b+ZdGVd5BC0E6Z27ghGdjvZz5F6q94AMsvN4tw/cjaSOacuFw7BYAh8x1rHHeHiAsLL4f/rf+u4JwULEI8QmT0KsTIOnU4rL9M9+XwmrnnQ/3P/K2A7FFbhZ9vTzYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DB8PR08MB5530.eurprd08.prod.outlook.com (2603:10a6:10:11f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 07:59:40 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Wed, 13 Dec 2023
 07:59:39 +0000
Message-ID: <b83134b7-5862-4c22-b43c-c11d4e0e7a1e@weidmueller.com>
Date: Wed, 13 Dec 2023 08:59:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Enable setexpr command to print cpu-list like
 bitmaps
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke
 <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
 <7e505616-9053-48f6-a282-c6ce8a09a531@gmx.de>
 <4f39df6f-2871-428e-8977-36a89b6cdc7c@gmx.de>
 <5f58d016-58d2-4e73-8fb3-503313f91496@weidmueller.com>
 <06e44317-5907-4b64-bdbf-ebdefd199655@gmx.de>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <06e44317-5907-4b64-bdbf-ebdefd199655@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::20) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DB8PR08MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c285fa-fa55-4080-4b04-08dbfbb174e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5aUk/8lWHYRh9A6IimWXF8uhIiswJtLMHi+4uM74pPhgtb7UZcGA+y2l3QCcfB+1v391JqTemd7WwaekzcIiOoxlNrxdytMufQT6Hl8Q2h1UEF9sZLSaW7ptM22Eum04O78efqsnvGqq/r2L46S831iBjbg6Vn9UwWtIF+sRHihMd/ONzLmEEc89tmiLfJaOY6PueYEBipxXynsAyniEr5c6bcMRT/22QImjlcNJ1yUFaN1+1LgKVop0F2q1kLEWQRkrsGdVNttCA6zdLQouyXbY0g3WX/uk1nRq+zrEHLEZGlo8QoUAD5hnzWOMPqrJBnzOQt6NNfqvVwxojSLADIHIyjPwCx5gSgs7LvV73uTFQdEgds3jlc+2M8H2w5v0zgr2kx218OkgoVqn+PU26JbaTiKbLHJfDEhZeQ98LDlKDywSgQZkkzEGV8HFbnJxSiVFIg0GGI6KlMrbO7G9WWEwiXzKrfUP78bwMM4auAsGoGu9Rh0au7+Uca2GRcxKfam1Ji+2ZXs9vp9+O2O9j+d6vKhhcLLq4BboZW3q7IkMmfTYpbU4EeS3enGnql+R7AmjHDo07A6tgAIhtLbJ80z1TxeoN4T5QdBEQw+5D0z85zQ2blONgL669iBKs8ocOMONqJArkQjW54mCHLAgu1oZ25gl4OKv04nGSuTe0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31696002)(36756003)(86362001)(31686004)(66556008)(966005)(66946007)(6512007)(53546011)(6486002)(6506007)(41300700001)(26005)(38100700002)(83380400001)(2616005)(54906003)(8676002)(5660300002)(66476007)(478600001)(4326008)(2906002)(6916009)(316002)(8936002)(87944015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2ZNa1RSWjNtQTdiejFkSFpzZ2UzQWNRT2ZkQk9GSlBDcVZ4QW1kR3NKUTlw?=
 =?utf-8?B?b2JhTEk3d3AxSzhPa3I4NFlGekNWMFRiMk9lb2FRL3dva0hadU1ZZGhCcXJu?=
 =?utf-8?B?M3RIZ1FHd1c2bnNVb1FGb3lGNkN2RWZYeVN5VlNrWW11SnBaa0U0eWhjSkUy?=
 =?utf-8?B?NWJlSWpLTmdBM25XMmNuUWRWT1E3MEJHVXNIelozSk5YUEFwRVo1OTVDY2tX?=
 =?utf-8?B?SWFUMkkxYWhQTlRXNjh3SitCUWowZkNQTXFDZUxjN3BkQ3FLSFFvajhDOGJq?=
 =?utf-8?B?Q3RtRXZNMkJmSzhTVitwbDNGNXVWNHdpa1dJU01PcTlNUy8xQmtoc0tOMnlu?=
 =?utf-8?B?Z0VicmhONy85bVE1NlNUZ1RDdTNzZS9ZTWhFSjdESXFnTEd0b1lhajFENi9P?=
 =?utf-8?B?NFZ5cDF5bjFRTUJ3aURza1B1eWhIMnZneXpCNmx5RWp5cUZsWFF1R0pqdHJS?=
 =?utf-8?B?R1J1S2VRS01QTFFFdWxVZVJ6L2ZWcy9kYUVPc3lSOVpYeVFacjJTOWYrbEFO?=
 =?utf-8?B?UVhVRE5WSDZoenNORG9yOERoLzBHb1Jpck4weGRrbjJtR09OTjZFUUJhZHhT?=
 =?utf-8?B?TitBMFI5NXdPOE5Sem9Jay9hYnE4d1BMb2RwR1R3S0VOQU84b1Q4WXlLcWdX?=
 =?utf-8?B?WTliMEtZb044Y0QxZUdNWUNodkNwc0dBcUV4Vy9jVnMvNEV4bmMrczZkajV0?=
 =?utf-8?B?YXFzWk1adXdJeXVocGZNSmRIQjFWd0J1TTRXOGlLRTBCTERVMXdEVVJZdGs1?=
 =?utf-8?B?cEllK29oS3F6dlc5RGVPbzhSZ2M2ZGpkcXZ1MkZBdk80YTAvNVBSVmpFRUUz?=
 =?utf-8?B?bnVHN0FjanltcTZFaEdVam1zSzFFQTlqRU42M09DSTh4NzkvcmoxOFFSSzl3?=
 =?utf-8?B?K0hIRzY3a0NiMGVxNnduWnhNVFdCTjlnNzR3Q0kyYXFjMGZ2dklQWll0djcz?=
 =?utf-8?B?REJ4NTRxcEdtbDA3STFtL1pxd3N6V1NuY1BBcTUwUWd5MldOcjJxTHBLNk5C?=
 =?utf-8?B?UXBKQlhQR3hRbUtZUmo4a1YrVncyRmtqUThWWVZucnB2RDkzV3F3YmhLTExn?=
 =?utf-8?B?SkNndERNbDlDSys0MnVSaXdCaTVVcEpkYWFidWQ4cys5ZTRETFQ2STVVUkxa?=
 =?utf-8?B?TTVORUo0d3BXbzBwYVZxUEFlcVFacnJyVkxuOGllTHNPZXhneTl4bGZDMGh6?=
 =?utf-8?B?bWlXUFBYR3FuWm9vTlgrMXVOZnJSdEVqU0doMG41VUx5OGpVYXdGbTBtTU02?=
 =?utf-8?B?U2d2bW4vWk5Xc3ZMSWsrYVlnN1Y4WkE5Z0JUTVYyUzNmQTMxUFdtQUp1eHp4?=
 =?utf-8?B?ejlFTHd3LzMybE81aUxlQnZ4Nm1LR2MwaUMzY2VpVEF6SFVLNkQvdG5LR2hO?=
 =?utf-8?B?TEdaK2dCOFdYSEltNCtIQ2x4M0JqM0ZBZ3AxY0hOMDZZOVR5cExVeFRvM3ky?=
 =?utf-8?B?bHBNU2NGWkFJa3lMQkNGQzZiOEZXZlZDZnVJSjNHMGVlWVlBSS9lVjByUyt1?=
 =?utf-8?B?K1k1Q1N2M3BSRTk3QW51enVDSmlVYngrNG9WSHBBZnRCelRsRENhZy9qN1Bz?=
 =?utf-8?B?dkhoTFBqKzVTVGIwQlBzS2pIL2dDc1VMblVCL3VWTGNzSmc1ZTF5c25meStt?=
 =?utf-8?B?Yzdoa2JMdEVITzNuSm0zaXdXSmZBc1BTcFdIb0p1QUcvREwwdWpzeU9iSDJm?=
 =?utf-8?B?S2lDNFZ4SWY0R0VxbTU1Rjd5Q2s1alc2WGZGWnhTbVZCTDVwblNXR05QWW1Q?=
 =?utf-8?B?VGlnc3pLRDZ4U05iRUQxa0laTzM5NjJzOElVaUZuL3BvcFNUQnZadDZ6V3Vs?=
 =?utf-8?B?T0hSK3FRZnhqckM5LzBHTlBaMmNTbTZiZU9UYk9jeXVWZmU3eGpKbmMwSmVF?=
 =?utf-8?B?TU9MYVl1Sm8rL1FMOWZTTENNQ1c4VUNrVnVac1RGNko4TjUzdHZZZDFncTZB?=
 =?utf-8?B?dzFqVlVFTHVMRkJ0MXVNTVBVT1RKMzQvR3JnUWRhM0U1TTlZeFo0bGQyTk1E?=
 =?utf-8?B?MDBDZ1RNeFMxNFRRTGJmQTNhM1ppOXFNY1JoVi8ybVlkcXhRQ1hvSlFkVm9r?=
 =?utf-8?B?Q2RuYjdMTGNNVmFwRVU5MGgzTWduZGJYNmU3Rml1V0MwN2JXRzk5Z0cyL2dz?=
 =?utf-8?B?ZjE2VzFPdDI1TElGbXBWTVpnWG1BOVpwTWJON2kzV285NktISXdwcGNoNFJm?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c285fa-fa55-4080-4b04-08dbfbb174e3
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 07:59:39.3277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAnpmjJXH0UhAY5fgP3o/8/hmppZfQjRsfzFzM4xsZtR8IdbFnVxHzZbTPUGsRCcC5lgL/OwJ4kvZB49JVrpsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5530
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

On 12.12.2023 14:09, Heinrich Schuchardt wrote:
> On 12.12.23 12:56, Lukas Funke wrote:
>> On 12.12.2023 12:40, Heinrich Schuchardt wrote:
>>> On 12.12.23 11:13, Heinrich Schuchardt wrote:
>>>> On 12.12.23 09:52, lukas.funke-oss@weidmueller.com wrote:
>>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>>>
>>>>>
>>>>> This series enables the 'setexpr' command to print "cpu list"-like
>>>>> bitmaps based on the printk format specifier [1].
>>>>>
>>>>> One use-case is to pass cpu list [2] based kernel parameter like
>>>>> 'isolcpu', 'nohz_full', irq affinity or RCU related CPU parameter to
>>>>> the kernel via a separate firmware variable without exposing the
>>>>> 'bootargs' variable to directly.
>>>>>
>>>>> Example:
>>>>>
>>>>> setexpr isolcpu_bootarg=%32pbl $myCPUisolation
>>>>
>>>> I applied your patches on top of origin/next but your example simply
>>>> does not work:
>>>>
>>>> => setenv myCPUisolation 123456789abcdef0
>>>> => setexpr isolcpu_bootarg=%32pbl $myCPUisolation
>>>> ## Error: illegal character '='in variable name 
>>>> "isolcpu_bootarg=%32pbl"
>>>>
>>>> This produces some output:
>>>>
>>>> => setexpr a fmt '%32pbl' 64; echo $a
>>>> 6
>>>>
>>>> But the result is completely unexpected. Number arguments in U-Boot are
>>>> always hexadecimal. So the output should be
>>>>
>>>> 2,5-6
>>>
>>> doc/usage/cmd/setexpr.rst
>>>
>>> has an example showing this.
>>>
>>>      => setexpr foo fmt 0x%08x 63
>>>      => echo $foo
>>>      0x00000063
>>>      =>
>>>
>>> You provide a use case for %pbl but not an reason why you want to
>>> support %pb. If you wanted to use the output in a device-tree
>>> manipulation the %pb output would have to be big-endian formatted.
>>
>> I added it to be consistent with the kernel printk. Currently there is
>> no use case for it. Shall we remove the %pb or leave it in for 
>> consistency?
> 
> As long as we don't know if usage requires big-endian or little-endian I
> would keep it out.

Ok, will remove '%bp'.

> 
> Looking at the %pbl use case: What sources of the value to convert do
> you envision? When the argument is a pointer, e.g.
> 
>    setexpr a fmt '%128pbl' *$fdtcontroladdr

The dereference of an address in 'setexpr name fmt <format> <value> ...' 
doesn't work. This is only handled in 'setexptr name <value>. I'll try 
to add this to the 'fmt' case.

Best regards
Lukas

> 
> you seem to expect that the 32bit tuples are stored in low endian order.
> 
> Please, test the output of a 64bit number on a big-endian system. 
> You must not assume a unsigned long long to be stored as 32bit tuples in low
> endian order here.
> 
> The output does not match what is in memory. This needs to be fixed:
> 
> => setexpr a fmt '%128pbl' *0x8bae060; echo $a
> 64,66,69-72,74,76,79,82,85-87,89,91-92,94,96-98,108,110,112,114,117,119,121,123,125,127
> => setexpr a fmt '%128pb' *0x8bae060; echo $a
> feedf00d,deadbeef,00000000,00000000
> => mm.l 8bae060
> 08bae060: edfe0dd0 ?
> 08bae064: 92ac0000 ?
> 08bae068: 78000000 ?
> 08bae06c: 208a0000 ?
> 
> Here is another wrong output:
> 
>    =>  setexpr a fmt '%128pb' 0x92acd00dfeed; echo $a
>    feedf00d,deadbeef,000092ac,d00dfeed
> 
> Expected output is
> 
>    00000000,00000000,000092ac,d00dfeed
> 
> A buffer overrun occurs. You are reading memory after the u64 value that
> you create internally. To do it correctly you need to copy the u64 value
> into a 128 bit buffer that has been zeroed out.
> 
> Best regards
> 
> Heinrich
> 
>>
>> Best regards
>> Lukas
>>
>>>
>>> Best regards
>>>
>>> Heinrcih
>>>
>>>>
>>>>> && env set bootargs "$isolcpu_bootarg"
>>>>> && bootm
>>>>>
>>>>> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
>>>>> [2]
>>>>> https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
>>>>>
>>>>>
>>>>> Changes in v2:
>>>>> - Add bitmap format specifier to documentation
>>>>>
>>>>> Lukas Funke (6):
>>>>>    sandbox: add generic find_next_zero_bit implementation
>>>>>    linux: bitmap.h: add 'for_each_set_bitrange' iteration macro
>>>>>    test: cmd: setexptr: Add tests for bitmap string format
>>>>>    doc: printf() codes: Add bitmap format specifier
>>>>>    lib: vsprintf: enable '%*pb[l]' format specifier
>>>>>    cmd: printf: forward '%p' format string specifier
>>>>>
>>>>>   arch/sandbox/include/asm/bitops.h | 16 ++++++-
>>>>>   cmd/printf.c                      | 29 ++++++++++++
>>>>>   doc/develop/printf.rst            |  6 +++
>>>>>   include/linux/bitmap.h            |  7 +++
>>>>>   lib/vsprintf.c                    | 75
>>>>> +++++++++++++++++++++++++++++++
>>>>>   test/cmd/setexpr.c                |  9 ++++
>>>>>   6 files changed, 140 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>
>>
> 

