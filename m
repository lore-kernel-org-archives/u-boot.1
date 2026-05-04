Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D24FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687A68466D;
	Mon,  4 May 2026 14:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SskZmoI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F1E8466E; Mon,  4 May 2026 14:59:27 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65E08465E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqRt5cVO47YoIcg/K4sW7TF4mnoJZ5bvclqIYTMgDfJSyCYHPlTegSoFdyCpk9x0h0gkOiTflChPkFtU3zUxR/4pxpxmh86o7MDE4+Ze0+AioJJKNxW2RmNsx93ooDxOmMa8invcEBnQpdO4CUZm1+o5PSpoUFbZgV4eogI0gcPL9IjzJrGIUGC4tO+vH4UTMz1l4RvbgQ8omuc2biLwXA9c6QPSCtP6e7EdBP/NU2r89i6VP2TL8T3kQ0vw/ayDOCwUOo1uXMsXuwm0I609pvrQNX1rSpAQwE+LqbtI4GUbWPmQKZNgQN2Watdqvj/P+JIsNpv9/0LZOTA25+6yJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqIWJuft3z7l9tJkacgqeYPlqNj56WL86DSY9Fu5AI8=;
 b=Azfdzjm/uuXSWvjEPb9kFsXualo3i2oQnHG8jN6ub+cuFLNz4tzrQlKq3yHsAtcbsl+wdS9PR11VZJtXB39n9Q5kx5i6novb86HFMBQT9lohWC4nIPcwtg3EiI6ZGZy3ArFDvA/g4Kz2nPBIVSc7QgiAtbLfYb/XwVgZh6IGVNd61jCQJP0tvGqBb5sj8Nh2V+KVh8kPX+PNMbyFyQiJpZ+dkIKosLyO+k/KO0zivJ1IoTkniQ4/2/Xsy7TBJAKrLfr1bbnax8ZuBnNmDkHsktFpZ1KLZgh8HpteZVFu4+01nwVSe2MtOBDuFOkGCWUGz/tc3KV5a2Ko9t1nWNOiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqIWJuft3z7l9tJkacgqeYPlqNj56WL86DSY9Fu5AI8=;
 b=SskZmoI3r/2bC7TOnxqleIHTc6c4h5QXEO5a1eVnn9ziAsJx/NtX+42Xo99JvzBDaOYKw6pIIICuNJhkY7/kKsi2hWkRIXre1B/aGCrLNCIO+E8bF9RiEmDQREMxxcW52UNrCzA5h45ee5h+7R6wWTMXxiHGrJkM5E3jimr2GBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA6PR04MB11885.eurprd04.prod.outlook.com (2603:10a6:102:513::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 12:59:22 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:59:22 +0000
Message-ID: <6980d77d-b0d6-4b77-9ade-4201bb88cb87@cherry.de>
Date: Mon, 4 May 2026 14:59:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260422023131.2813748-1-sjg@chromium.org>
 <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
 <CAFLszTgQxCEYrCTyLkFiEtoDJKPBJKUJqGHFpUK0chb-wCV+DA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgQxCEYrCTyLkFiEtoDJKPBJKUJqGHFpUK0chb-wCV+DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA6PR04MB11885:EE_
X-MS-Office365-Filtering-Correlation-Id: fa22397b-1667-4864-13df-08dea9dcf65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5vlHS2vfVFeDJimiAh5kB/u2QiDgIegR3LJ2kFjW/r5EiWjc3iwrcgfcV4oZAb3BsftoONovhA/H1o2s4mVKtqz6R87xYrYCW3Jc0jmmgN2v30sZJM2/NaYYWt3z8vXhljZN2a/gxsWqMOmWkDTgr2HKEA21pHu2QisaOF2iIqJMOhbBu8FS1oNE6V4fqBanPLCGNFUbpwMOywxWwH5JD1Z8yztAUQTbF8LS7TB/BAfXpxLwqh66bogwemd69jqWZaAdiWwxD0+yKEjqSp2AUmt3WFYH1AsTtfkBf5hAGj6SM+mGjQfOyrkhpKa0rxEmDUCc8wWN6PXY02hEd628CheqDGJFQ4s/GsdoYgxk/X/XJoBFx4PZtwsIVYf0QgEEzGumpPUAlHhxDztot53krikCouf6xm25N6WDYsLUFuhbbX5jpCNyyFmNScxgWJh3azrV/1+rBnMemo2BvGcqp30tkNZ2ALgg0FeT7O/dqwRuAoaUCDc1lEnWSgt+a6yPQMKyxcvi+3V0T/J6qB+t5iZJzrnxsVJQ1O3Y4duvud8gtF8d0TVbdGBzSkSduAL3YShS840J8reldVqptw0Ry8SACvySaJ+QlP+rJicD6OWE6h/jMrPsxAkW0Mc1yHQFymClEVd1wf3UzMeg0ttap1pjTscoFtCebdmAxJcSbQFPGs1dACJqLpLENWt0q4H3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZsaW5CUnZoaGpaeTlmbWlkQ3NqTFVWOWtOazFEZk45czJSMm0yTGtldHRX?=
 =?utf-8?B?RnBvL0tkNllpSGhiSGhRRkE3ZFc3bXc4Yit2ZHF0cWlrMFBLcDBPMlRwV0Yz?=
 =?utf-8?B?OGxWVkR3TnFYRmlQdlpoOTF0VWZvUjlmMDhYaHJsTEFXaTFtN0dtd2pCenBk?=
 =?utf-8?B?WXFDL3ZCT0JaeEZNYUlJRm5ibWh4Q1FrSVJGTmZ1Y2tPMG1KQllGb0R5bm9Z?=
 =?utf-8?B?cDJENnBPZzNaMXpBUXBQY3pTWGRHUWlWVm9vWlVJeW5VYlVzeWJ6RElSSW9V?=
 =?utf-8?B?VU9iVXNNM25GcnVMcXd5VS8xRmFwb25RdWRMUU5VOS96aFVoMFp3WElwbVN4?=
 =?utf-8?B?NEtxTHpKWmtTZ3F4dFhSN1NkY1RyZ3pOWURXaVJUcDVlVXRUbEl1WXcwTFVS?=
 =?utf-8?B?ZjMvMXZOSjB0bXcyaEpZRDQ3Rk9KTEVDakVRLzlGeW80Yjh3MHE1Z0JaekN6?=
 =?utf-8?B?cHVHd3hvU3N4bnFqVVpYZlo5RElhYkFuK29LZ2dxTURxMEl4L2VmWnhiaEVS?=
 =?utf-8?B?S1lRekd0MWh4RkRSRkhOMWdkdlBaOG5GYmQzQnA3aGVCY3JyUzU4eW5WazBu?=
 =?utf-8?B?c0FvS3RkNVdCV1FuZzhqczEzMzVFWTE5Q2E0MEpJd3VnWThIVFRRM3NtTnhh?=
 =?utf-8?B?WW94VTYySld4Z2F3ekFScFRXejJnQ1hLMkdlUFo2NHQyQ3oyV2IrQlRHcFd0?=
 =?utf-8?B?SnNKN0NYWi9VNmRaODQ4Q09XTnBNN0J1ckE1R3BMaW5sd1B6SWlUdmlZYnRC?=
 =?utf-8?B?VlhnK3NXOFk0VXFCQktHdFRnc2cyRjlXd3pkNldabXhiT3lRT1BiUk84OWx0?=
 =?utf-8?B?RkFOdi9xem1KZ0hmK3d4a1VTSDc0TzU2Tlk3bXBhTUgrclFOZ0RIOFAyamxz?=
 =?utf-8?B?UWt1ODd3SExUdElvRGwvdEozeXgyUDR3VVYxR3ExZjQvSzVmUSttRmZxTkZu?=
 =?utf-8?B?MVBYVEFGZXhCV0Z3K3FmL2wzZVJLdklwWG5WU25sMXg5dnFtdVZPV3dsV0Nr?=
 =?utf-8?B?cXRQb2ptSE5HVE94S3M2SXhOdGd0aGFacnl5Tm1URlRqTU1CVWdTemVEdTFB?=
 =?utf-8?B?K3M5UVRvY05sMU5yd1FpUGczU0UwalFCelMwZytmMXJwZjI4MzRKVUNuMmRT?=
 =?utf-8?B?cHlxMkJDMXlGbVBrSGlJdFdVRC92bEVKOHRSTWVTOHdYb1hkRDVpVGg2TW9N?=
 =?utf-8?B?ZXdDQXdUdE5oUzRzRFJBNzZqY3Vtc0NkZWFWM2VWYWJQeTN1K0pZMkR1SXdW?=
 =?utf-8?B?SDZnVWJhZitsSWpLNDNMc0RGSjR4RUJxZzhwTWsxVUJVZzFkMkxLc09jam4y?=
 =?utf-8?B?VTF3YXY0VjRUZ1NhbVo4M2ZQTXhhUzJER01zZDVLMHI0VEhvSm9IOS9iN2JJ?=
 =?utf-8?B?RkJydGRrTW5oMHVONVhOVFA2UkNYUGcvb3ZXa1dUY3B2TTVreHAvdXpTTTNO?=
 =?utf-8?B?dytIaHpqbzJwVFhRK2FkQzU1NSt5R0tsd3pDZDhHWXYycmUzcXZzTTRjaWhi?=
 =?utf-8?B?TC9CYWpoTE1seWNDRFI4MmNCS3I5SWVsUzlGdVhiZ0FHY3JTTElYbEZRNVow?=
 =?utf-8?B?YkxaWjVnaVd4Tm42cVlhenlVaG5wTWh0NzJ1V3FMSHozd0FGYWNJMW9ERVRp?=
 =?utf-8?B?QzNlQ3BUdlFieGQ5Tm53QzhxaHp2VFBFQnFLV0NHSUVKTjRjSy9nakFmRjJO?=
 =?utf-8?B?L1E0WDExU1M1bUNFd3NlTVU4ek05WEtRUERwWXhyMjlHNWxIRXlLWWMrY3Nl?=
 =?utf-8?B?VS9oT2ZGRHM4ME0xWjJwWnFtazdDSXhCWmp1ZjZUb3M4MUlkcndoaWFYQnF1?=
 =?utf-8?B?US9EcE80WVBDNFdyOCtEcmlFS3RaK1MxcHkrVzNYeGFRRU56dnE4dVVTcEdB?=
 =?utf-8?B?YkZBODRWY2I3cjVFdTRqcVVhTWU1b1BpR2RBRm9xblhjTTF5cHZYT0V5OWJm?=
 =?utf-8?B?WlFiQnV4NUJZNi9OTkgzYjJReTRmcDY1TCtQMVRqc0YyNGc3b2JHdmlNT3hu?=
 =?utf-8?B?RXBBek5oTkQzSnlBREZHc1E5Y09FcFF0cmc3eVlySDFKRGwwaWFMeEhKbzVG?=
 =?utf-8?B?NVUwMkdqRnVLNEhFUGtxTUVRT0JXUUU5LzdEZ0xPRnpRSStBU2Jhb2FmRzZh?=
 =?utf-8?B?VVE1QytFUjdYcDhOcE1ocCtUSDA0LzlybHg0VGpoWXRNaXZVWVg4eXFpOHNU?=
 =?utf-8?B?Z3lYdmxEN245ZTQvVTJ1MnpYTnEyKzFjbE40YVVsUzdsSlk0ZGVBbjB4ZFZ1?=
 =?utf-8?B?cFlCTE94am9ZTFllR1ZTdUhlV3l1SVB0NU5OZGpnY1ZPQURwV1k4WlVoemlS?=
 =?utf-8?B?eDJmNFl1TXlnSUM3MSt1Zlo4b3R1b3hUcGNWQTRTYlA2MmZ0YlBKR21BWnpk?=
 =?utf-8?Q?03KjTWHCcPqmczjt7t1p69lCxhj7lKqsAwFLp0Dpe8i8k?=
X-MS-Exchange-AntiSpam-MessageData-1: tQt0iAvXIDb2NK5brOMs7wDZ7uYnty5ViYA=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fa22397b-1667-4864-13df-08dea9dcf65d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 12:59:22.5991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXl5b8qgaSyWD2LuoOCV59rvoTz+VRAwZCTWA/WFI44iWm0QuM45DPVcDhrO8EFS7Xl0uAva6mcZUqx0HkVuLG/oPG4bQOIU2Cv3vzREg54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11885
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

On 5/4/26 2:49 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Mon, 27 Apr 2026 at 03:14, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon, Marek,
>>
>> On 4/22/26 4:31 AM, Simon Glass wrote:
>>> When producing a DTB from fdtgrep, there is no way to reserve extra
>>> space so that more nodes/properties can be added at runtime without
>>> growing totalsize first.
>>>
>>
>> Ok but why is that an issue? What is the actual usecase? What I'm afraid
>> of is that you pad enough and you hit random bugs because you forget
>> that adding enough properties can now hit the size limit and you forgot
>> to add the logic to resize/grow the fdt when it's too small to fit new
>> properties.
> 
> I'm going to leave this question to Marek :-)
> 
>>
>>> Add a -B/--pad option that appends a caller-specified number of free
>>> bytes after the strings section and grows totalsize accordingly. The
>>> padding is applied after fdt_pack(), so it is not reclaimed when -r is
>>> used.
>>>
>>> Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>>    tools/binman/btool/fdtgrep.py |  3 ++-
>>>    tools/fdtgrep.c               | 31 ++++++++++++++++++++++++++++++-
>>>    2 files changed, 32 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
>>> index 446b2f4144b..7b393241878 100644
>>> --- a/tools/binman/btool/fdtgrep.py
>>> +++ b/tools/binman/btool/fdtgrep.py
>>> @@ -16,9 +16,10 @@ Output formats are:
>>>        dtb - device tree blob (sets -Hmt automatically)
>>>        bin - device tree fragment (may not be a valid .dtb)
>>>
>>> -Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
>>> +Options: -[haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
>>>      -a, --show-address                 Display address
>>>      -A, --colour                       Show all nodes/tags, colour those that match
>>> +  -B, --pad <arg>                    Append free space to the output FDT, for later growth
>>>      -b, --include-node-with-prop <arg> Include contains containing property
>>>      -c, --include-compat <arg>         Compatible nodes to include in grep
>>>      -C, --exclude-compat <arg>         Compatible nodes to exclude in grep
>>
>> I'm tempted to remove this and just tell people to look at the
>> documentation in tools/fdtgrep.c. Especially since we don't actually
>> allow the user to pass any of those parameters themselves via the
>> bintool, so it isn't actually useful.
> 
> I would like fdtgrep to give useful help, though. It is a tool which
> can stand alone.
> 

Yes, but this here is docstring for the fdtgrep *Bintool* module which 
actually doesn't support most of the arguments specified here. So I 
would say it's more confusing to have it there than not have anything. 
For sure we want to keep documentation of fdtgrep, the tool as in 
tools/fdtgrep.c, complete and up-to-date!

Cheers,
Quentin
