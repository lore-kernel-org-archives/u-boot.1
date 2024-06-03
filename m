Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1455C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 06:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4FC879AF;
	Mon,  3 Jun 2024 08:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="YBLXX90s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF30A87C7F; Mon,  3 Jun 2024 08:48:09 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F20DA879AF
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 08:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtoXNl1EQN0n7d0HYrTv4xFCmrSMpyYYrCIZEOxE96c2uNTz8f/0g4QaZtGFmX00z0iL938ucsBARlnPree4RSJPSGkMS8ORxO7EOt4qzMigg6xZT1XpQUXiWiVnpL8Ugbfqdmg6HM8+CaNAwW1vB8s9KZrjiZagPYCnHPPOOLtofz/TLsxhCsikFMaBqrHdHb3KZFiFUj/nRT6NUCD601Mtb5gzlNLn0LwEwY/+oSQdqfT9gfoMcsOEHWTZZ3nvNnxiUACrzu5/I1/0PbDPNs3FNtE8qKu/OrFUxd2YxKx1R9ZzCGLtcciKi3Qm9myJmHMqQy/WDeU9oW0MIoM9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTh57Yi0WX4uLZzQNPp2Iok9GnKRehsdp5BgREcy3GQ=;
 b=AypeoChYid7bjt8Em25QHb+uBVy/TbdwsCXXDSzY8yGB4OdtML8/Tgjd3oI2ND+3/8IQiu5ReQEdC7yi+yBB4gmoL/lmCIQbNIqONTCYMh5vHH7bcqZTvyiz9P9Q34Fmhq50MrPqCmFRBt4BVUlEenhrJCLlohcqJY41OpfLsFb2+rf79a0YuIdsI/mIE5Q43ZppnKAr/yI3H+wB0AJGD1RC+JyXRlhH/qzZx7GsgcfWTJUbekh2W4U3jQnp8fOsVyBsRiHVocI8N1jfJXM+SVjva2vAjReKIClqZmpspxBGNy8re0O0tI9tg/8fGxY8AT0069ZnkV+OMLQGfGTvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTh57Yi0WX4uLZzQNPp2Iok9GnKRehsdp5BgREcy3GQ=;
 b=YBLXX90sXuTGo8FfgSU6e0lxP0bk62E/eXWckC3fonZgJzruUmOrJeehNH0EfEx5WP/nCm7mp9zPOAvkenI5QvAecGSxmoEZCM7ypD8h8pAtIc34erOBHUeaJaj+nNgFrhnke6cOE8Dp3zbJqtDyh4PSjJ31Iwg1GkeRDMW+B4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS1PR08MB7404.eurprd08.prod.outlook.com (2603:10a6:20b:4c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 06:48:04 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 06:48:04 +0000
Message-ID: <d2b0a4a0-e811-41dd-82a4-bdab0f82df39@weidmueller.com>
Date: Mon, 3 Jun 2024 08:48:02 +0200
User-Agent: Mozilla Thunderbird
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
Subject: Re: [PATCH v2 2/2] drivers: misc: Add driver to access ZynqMP efuses
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>
References: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
 <20240515124125.732487-3-lukas.funke-oss@weidmueller.com>
 <b02310cb-ac56-4fe5-9b72-f145563e2145@amd.com>
In-Reply-To: <b02310cb-ac56-4fe5-9b72-f145563e2145@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS1PR08MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: ec062f13-c814-4b7e-68f5-08dc83991e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azZLVXVKbU16QjRrM2pqK3I3WEx2blZVUVJ2aC9TKzdQdzNWNEUvbnZjcFJP?=
 =?utf-8?B?NHNQdWxQeWZTaUVZTkVUd3pDQ25VbTdMcHk4UHhnS2p4TDIzYTZDR2svbExa?=
 =?utf-8?B?NmlONk5COVYyNlYwUVozSHMxRmQ4OG1ianNWWVcvdVBQekhRbGV2MHlkU2M0?=
 =?utf-8?B?bG9KMGNpUGRXa0JjWURRRUUwUFk4enpNNEYvZGNwUzNSSWhrNjcxU2lWczNR?=
 =?utf-8?B?Ykt1TnZaeDVkYS9UZ1RJNnk0MlU0NUxXRGZYbW9RMS9IS0Y0NGgrYUpwR21w?=
 =?utf-8?B?cDAveWR2NVpGWWgveU9BUFFYV3IvdWw4ZWlDcHhJYlFpWGN6RXhmT01ab1FC?=
 =?utf-8?B?TDNLNjh5YlMxci9STG1XSHEyYXdybDY5S254d3BQTTdudlRkMm80eGI1Mk44?=
 =?utf-8?B?T1BZRmlJYmdmL2FwRWtsVzBsM1hIVFZLeTM0cWYzOGZlOFRWV0JJMHVYUDNK?=
 =?utf-8?B?T0JSTEhnVy9JTVBhQ2tUMFpTNE9oc295OVpUOXZ6TUNjbWRmZnNlQkFaZ2l6?=
 =?utf-8?B?QWtrUEJJU0E0ZHRVZXJmOWlvM0IzQitINTBJWlZMY3BXajJrblQ2WlUwei9t?=
 =?utf-8?B?Zm1OeXR6azM3ZkhtaHpEQi9ja3pqVEx0L1hqOXBxSlhkd2M4RUwrOVBxWnlm?=
 =?utf-8?B?SG95VTBYREEyTjBoZDZVK0o0RzVaaVhRMHJ5SmxLY05SYkNXd1k2YVgvOTFG?=
 =?utf-8?B?ZUszYUZ4aStSbUcvbXhFRmd6VmljYUs5cFFDVXJmWDM1aDRycGoxa1Y2STVu?=
 =?utf-8?B?RUxnbGNkZGU1eVpjRm8zbXpxakx4dzNLS0lKWWl0WGdVUkdmdTdxQS9OMnVX?=
 =?utf-8?B?d09LOVc1QnNIOHduRktVTFluZlZjSVdnSWNCbTdwTHZjMmQ1WDFXcUprdFYz?=
 =?utf-8?B?S2ZqWll2RnFYVW9PSVpZcklzUXpXcWYzcExMMUdXTHJJY3NOcFhzZ2phQ2ph?=
 =?utf-8?B?eVhiZFJpWHpSV1IwQ0dCRStwUC9PbGtleU8zbExYbWQ2Q3JLV0JMc2Y1Tm5T?=
 =?utf-8?B?OXZ6bEFSUllUNXk0Smt4VjhwalRjOXFoaS9MckhFeDk1TmdmZXl6SEdGOWhQ?=
 =?utf-8?B?Z2JRVW03OFkzTDlGREFwT1JSSG1jTGI1czFOVTNiT0JTZTdBZXZEcis5aUxt?=
 =?utf-8?B?V2FjVncvNmJmSUk2Q2tKdUUxZzdBZm5iSzZnTE1uM2ZuQytpdjNxQVFXN1pT?=
 =?utf-8?B?S3hzYUZJSjJ3YmZ3Vnh3elJSZmYvcDlSWXpwN2RWZHNuRFFIVEFwV1pFaDhM?=
 =?utf-8?B?RWo1TXZPdU1sc3ZSbndtejJIUHM0aHgxUXBCT2dJaEx1dWVKUE9DcVFpbWU1?=
 =?utf-8?B?L3QxRkw1QlBXT204N3d0b01IdkZOTEdRb202OU4vMEJ2Z1ZjeU1LQVRtcTZQ?=
 =?utf-8?B?MENRblRPNkNXU2hCelZDejYwNExncUphTS9MZDRjcWpYWE1qRVpidEdIL1J0?=
 =?utf-8?B?Q1RCcFcwU0VRamprUWR6T0c2Rlg1cW5MQkREOCtmenV1M1JuMCtMenpVM3JY?=
 =?utf-8?B?Rkl2aXlNVlZFeTluc2dVbjRPUTcvQ2IxMGd6VXM3ODc0ajUrcndjZk5NNXcz?=
 =?utf-8?B?U2hXaFhDVnNQSS9PZStTZ0pRS2N2UTBSZmpjWmYrUXFYRTU0SGsvK0VrM3Zy?=
 =?utf-8?B?TUpXcUtzMkpmYTRZNTZrankxOGw0QUo5eFpDZXNveXJ2bkZqeHdmQ2RKS1hH?=
 =?utf-8?B?aFcwV0dic1dFL0pSUWJJbHJkQjc3eG1iTC9Kbm1zWTQybG1CYUR5QTNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDMveUNMRGord2pYVW1qSlRWaStlT3NoL2t1M1lrUENFTUczR0tiZU81Z0h1?=
 =?utf-8?B?Y3ZRVURldFZYZkZNS1p6cjBiM2ZsUzh1K3pUM0ExYXNhRlF6eVZTc2FHSmRQ?=
 =?utf-8?B?dEt3ZG41Ti9yajhYS1VPbnBuaFVINHhwZGdOa0xkUUZZTGgzOU1HaEQwcFM0?=
 =?utf-8?B?bllCNnZQOVBsQm4wSEFmQXJCRDNUa1l2S3NqNjQzRVFjNXQyQmovNFZ0THY1?=
 =?utf-8?B?SnhnTTd1dEoxWE1sSDczNStIRjQxUkRiUkxSU0FyN1E4QVNNK285YUxsdnVu?=
 =?utf-8?B?NjVGUWpZYkY3RWltOGppMHcySW8rNHl1d2NaOVlWMDNSOU1PNW1KbnZKaHhZ?=
 =?utf-8?B?aHZiVDlMK1drTkhtdUVVaUxlb25zczJJVlJmUitWNzBZVzlQSFo3MW9raERo?=
 =?utf-8?B?blNEN1p2dVd2NDcwOVI3bERxdktTdUgyYzZqb2d0ZFpFM094ZjJJL3RYM2xH?=
 =?utf-8?B?QUcxTjExVjZVSVBjc2pWVXFLZ2JyMHFVZnpGVmtpRFRhT2tBQnVnK0pDSmVR?=
 =?utf-8?B?Uk40VkkrdnlSQkZEdG9RTkI0SlFYWU5KdXBva0s0VmdoV01mOXJveFgva1Iz?=
 =?utf-8?B?RUp1TXAzV3NWM0NGUGpiMWo1WlB6TlpFeDl3Uk5FTXI1RDJRMUNUZmExTTl1?=
 =?utf-8?B?TE1pZEtLQnRhRUVGdllEOXFwYTdZRkQ3UWFCNW5BMFdSd2ZCQzgwM2tManpV?=
 =?utf-8?B?TFFlOEo0bjI4Z1N6dk5Ha3JVZm9XTFBUR3o4RzUyUGF1djhQcTAwb1k5Tmpo?=
 =?utf-8?B?bjY2VUF1ZFkyODVxMU5PdlhqNitmcVJySkIxMFRGUHQwejl5UHZqR25JSFJC?=
 =?utf-8?B?NGE2KzNUc2VsSHVFWElDOSs4dzFvOWptTXlSQzBPanFnY0VNOXNXWnlROXI3?=
 =?utf-8?B?MjFVZ1AreWU4WFVhUTYxNFFYRm5BOFpJaHJYMTZ5Mm5Db3UzNTZMZ1BvWHd0?=
 =?utf-8?B?V0dlc2NWUTM5QURGaFNONkEwV1hUSWJiQitKV2x4cTJJRmRGV05FNTNtb3VO?=
 =?utf-8?B?cFhWK0pjOHJpRWdpaStFcnIzOWUwMEdUaGJjUHBtZlVzSE43MVdNM3ppYjMv?=
 =?utf-8?B?RUljZ2pnMDV2a3NkL0JXc2cxU1lQYnJvYlBYdktoVjN5YVVYMFJMV3h2dGtQ?=
 =?utf-8?B?TUJtcDNYWm85N2laL3RJNG9Ea3ZVNzBKOXF1YXc4K3M0YkQzbUd3Y0xnS3pT?=
 =?utf-8?B?WStXR0s1NFNBM2JWSnl4dUUyaDgra0dkVkhBRURKN3Q0eGFpaUVhdEdPK1BB?=
 =?utf-8?B?Q1hHZ1BPZ2JpU1o5Y1ZvSGd4bDRROVlPSDVTVXI2Wk90U1NnaFJyWWVpTTNW?=
 =?utf-8?B?VXNpbWpHeHJEZ1hWTmtBWHBIcmFuWmJBNDFPakdKNU9lMVFtS1RrR01Bakd1?=
 =?utf-8?B?T3ZvTndMS1h3dVZzOWVsdjZreUdzZVVqaHBOOEpLOEIrSFBsVWtqUkxKTktI?=
 =?utf-8?B?RkZqU09yZWljN1J5aktYRlJTMklMbWVXVGlWeGg3aEJVdUdSK1JDOU56Wnh3?=
 =?utf-8?B?N1hxMWY1OVF6eEZhOVZYbDJreTVHMDF0OEFzYWg5amxkc1BKaHZNRE1HazBo?=
 =?utf-8?B?UXo2YmFFNlNVVmsxZ0F4SGRyenkzSkF4Tzkyc3Q2WHFYcXJmMmxkOU9GNzFJ?=
 =?utf-8?B?TkZOOEkxU0FzVm5peVZHTnAycTlrak9XM2U3TWhPdzhUZ0VnTnN2WE1UVjR6?=
 =?utf-8?B?VW1zMDUwdTFpNkZFaURWRkphaEM4SFhTWFdIM1NKdFQ2TXZXWWx5TzZabjgz?=
 =?utf-8?B?RmtLKzR0NzdZTUU2QUdKTVFzNEhxRURtQWFFWVJ3K094dC9NZE1nNUtKR1VM?=
 =?utf-8?B?ekhCNzFkUXlGbzBaTUw0ME5CN2p2ZEhWazcyK1M1eXB1NXJCQTdkYTdxUXk0?=
 =?utf-8?B?VngxNFJhRmRvSitMYXd1SnVycWtDR3o1U21TbEFyRDZxVnYyU3htcGpOYVhV?=
 =?utf-8?B?QjV1ZGdpUCt5M3k5VjhDcmUwZ2U3OFpHZVpDazRGOGJFalhaSnRQR2c0Mmtx?=
 =?utf-8?B?VkgyZEkyNXFXclFkVFAwVUxvb1B6QVdjT0Z1WmFpcFRZMHk3ZzJ6eHJlTDA0?=
 =?utf-8?B?anZKTFVWVTRXcXZnVFRKUUJYL0VKQldpQ0tXV2RYRkZqc1JiTTJtNjdna2Yz?=
 =?utf-8?B?RG9NZlpZeHpjbHNveG1RbTB3aXF6Uk41L0NFb0VoV0dJTzIrR21xMG05Q1dB?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec062f13-c814-4b7e-68f5-08dc83991e3e
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 06:48:04.1129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L61XsBOhzLk+WoxBhDkx7YSB/if9kYyEHjqCr0bazuQ66e0rxDZkaip2g+yomcUB/lP+epSajcbka6Sg05i0AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7404
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

On 29.05.2024 16:40, Michal Simek wrote:
> 
> 
> On 5/15/24 14:41, lukas.funke-oss@weidmueller.com wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>> Add driver to access ZynqMP efuses. This is a u-boot port of [1].
>>
>> [1] 
>> https://lore.kernel.org/all/20240224114516.86365-8-srinivas.kandagatla@linaro.org/
>>
>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>> ---
>>
>> Changes in v2:
>> - Drop vendor specific fuse cmd, use existing fuse cmd
>> - Minor code refactoring (reverse x-mas tree)
>>
>>   drivers/misc/Kconfig        |   8 +
>>   drivers/misc/Makefile       |   1 +
>>   drivers/misc/zynqmp_efuse.c | 324 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 333 insertions(+)
>>   create mode 100644 drivers/misc/zynqmp_efuse.c
> 
> would be good to get also 3/3 which enables
> CONFIG_CMD_FUSE=y
> CONFIG_ZYNQMP_EFUSE=y
> 
> in zynqmp defconfigs (virt and kria) to have it enabled.
> 
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 6009d55f400..c07f50c9a76 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -298,6 +298,14 @@ config FSL_SEC_MON
>>         Security Monitor can be transitioned on any security failures,
>>         like software violations or hardware security violations.
>> +config ZYNQMP_EFUSE
>> +    bool "Enable ZynqMP eFUSE Driver"
>> +    depends on ZYNQMP_FIRMWARE
>> +    help
>> +      Enable access to Zynq UltraScale (ZynqMP) eFUSEs thought PMU 
>> firmware
>> +      interface. ZnyqMP has 256 eFUSEs where some of them are 
>> security related
>> +      and cannot be read back (i.e. AES key).
>> +
>>   choice
>>       prompt "Security monitor interaction endianess"
>>       depends on FSL_SEC_MON
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index e53d52c47b3..68ba5648eab 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -92,3 +92,4 @@ obj-$(CONFIG_ESM_K3) += k3_esm.o
>>   obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
>>   obj-$(CONFIG_SL28CPLD) += sl28cpld.o
>>   obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
>> +obj-$(CONFIG_ZYNQMP_EFUSE) += zynqmp_efuse.o
>> diff --git a/drivers/misc/zynqmp_efuse.c b/drivers/misc/zynqmp_efuse.c
>> new file mode 100644
>> index 00000000000..98a39c1ebdd
>> --- /dev/null
>> +++ b/drivers/misc/zynqmp_efuse.c
>> @@ -0,0 +1,324 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * (C) Copyright 2014 - 2015 Xilinx, Inc.
>> + * Michal Simek <michal.simek@amd.com>
>> + *
>> + * (C) Copyright 2024 Weidmueller Interface GmbH
>> + * Lukas Funke <lukas.funke@weidmueller.com>
>> + */
>> +
>> +#include <compiler.h>
>> +#include <linux/types.h>
>> +#include <linux/errno.h>
>> +#include <zynqmp_firmware.h>
>> +#include <asm/dma-mapping.h>
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <misc.h>
>> +
>> +#define SILICON_REVISION_MASK 0xF
>> +#define P_USER_0_64_UPPER_MASK    0x5FFF0000
>> +#define P_USER_127_LOWER_4_BIT_MASK 0xF
>> +#define WORD_INBYTES        (4)
>> +#define SOC_VER_SIZE        (0x4)
>> +#define SOC_VERSION_OFFSET    (0x0)
>> +#define EFUSE_START_OFFSET    (0xC)
>> +#define EFUSE_END_OFFSET    (0xFC)
>> +#define EFUSE_PUF_START_OFFSET    (0x100)
>> +#define EFUSE_PUF_MID_OFFSET    (0x140)
>> +#define EFUSE_PUF_END_OFFSET    (0x17F)
>> +#define EFUSE_NOT_ENABLED    (29)
>> +#define EFUSE_READ        (0)
>> +#define EFUSE_WRITE        (1)
> 
> I did compare it with the latest upstream version and there are some 
> differences which don't need to be there. Above macros for example
> 
>> +
>> +/**
>> + * struct efuse_map_entry - offset and length of zynqmp fuses
>> + * @offset:    offset of efuse to be read/write
>> + * @length:    length of efuse
>> + */
>> +struct efuse_map_entry {
>> +    u32 offset;
>> +    u32 length;
>> +};
>> +
>> +struct efuse_map_entry zynqmp_efuse_table[] = {
>> +    {0x000, 0x04}, /* soc revision */
>> +    {0x00c, 0x0c}, /* SoC DNA */
>> +    {0x020, 0x04}, /* efuse-usr0 */
>> +    {0x024, 0x04}, /* efuse-usr1 */
>> +    {0x028, 0x04}, /* efuse-usr2 */
>> +    {0x02c, 0x04}, /* efuse-usr3 */
>> +    {0x030, 0x04}, /* efuse-usr4 */
>> +    {0x034, 0x04}, /* efuse-usr5 */
>> +    {0x038, 0x04}, /* efuse-usr6 */
>> +    {0x03c, 0x04}, /* efuse-usr7 */
>> +    {0x040, 0x04}, /* efuse-miscusr */
>> +    {0x050, 0x04}, /* efuse-chash */
>> +    {0x054, 0x04}, /* efuse-pufmisc */
>> +    {0x058, 0x04}, /* efuse-sec */
>> +    {0x05c, 0x04}, /* efuse-spkid */
>> +    {0x060, 0x30}, /* efuse-aeskey */
>> +    {0x0a0, 0x30}, /* ppk0-hash */
>> +    {0x0d0, 0x30}, /* ppk1-hash */
>> +    {0x100, 0x7f}, /* pufuser */
>> +};
>> +
>> +/**
>> + * struct xilinx_efuse - the basic structure
>> + * @src:    address of the buffer to store the data to be write/read
>> + * @size:    no of words to be read/write
>> + * @offset:    offset to be read/write`
> 
> a little bit different description compare to upsream linux
> 
>> + * @flag:    0 - represents efuse read and 1- represents efuse write
>> + * @pufuserfuse:0 - represents non-puf efuses, offset is used for 
>> read/write
>> + *        1 - represents puf user fuse row number.
>> + *
>> + * this structure stores all the required details to
>> + * read/write efuse memory.
>> + */
>> +struct xilinx_efuse {
>> +    u64 src;
>> +    u32 size;
>> +    u32 offset;
>> +    u32 flag;
>> +    u32 pufuserfuse;
>> +};
>> +
>> +static int zynqmp_efuse_get_length(u32 offset, u32 *base_offset, u32 
>> *len)
>> +{
>> +    struct efuse_map_entry *fuse;
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(zynqmp_efuse_table); ++i) {
>> +        fuse = &zynqmp_efuse_table[i];
>> +        if (offset >= fuse->offset &&
>> +            offset < fuse->offset + fuse->length) {
>> +            *base_offset = fuse->offset;
>> +            *len = fuse->length;
>> +            return 0;
>> +            }
>> +    }
>> +
>> +    return -ENOENT;
>> +}
>> +
>> +static int zynqmp_efuse_access(struct udevice *dev, unsigned int offset,
>> +                   void *val, size_t bytes, unsigned int flag,
>> +                   unsigned int pufflag)
>> +{
>> +    size_t words = bytes / WORD_INBYTES;
>> +    struct xilinx_efuse *efuse;
>> +    ulong dma_addr, dma_buf;
>> +    int ret, value;
>> +    char *data;
>> +
>> +    if (bytes % WORD_INBYTES != 0) {
>> +        dev_err(dev, "Bytes requested should be word aligned\n");
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    if (pufflag == 0 && offset % WORD_INBYTES) {
>> +        dev_err(dev, "Offset requested should be word aligned\n");
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    if (pufflag == 1 && flag == EFUSE_WRITE) {
>> +        memcpy(&value, val, bytes);
>> +        if ((offset == EFUSE_PUF_START_OFFSET ||
>> +             offset == EFUSE_PUF_MID_OFFSET) &&
>> +            value & P_USER_0_64_UPPER_MASK) {
>> +            dev_err(dev, "Only lower 4 bytes are allowed to be 
>> programmed in P_USER_0 & P_USER_64\n");
>> +            return -EOPNOTSUPP;
>> +        }
>> +
>> +        if (offset == EFUSE_PUF_END_OFFSET &&
>> +            (value & P_USER_127_LOWER_4_BIT_MASK)) {
>> +            dev_err(dev, "Only MSB 28 bits are allowed to be 
>> programmed for P_USER_127\n");
>> +            return -EOPNOTSUPP;
>> +        }
>> +    }
>> +
>> +    efuse = dma_alloc_coherent(sizeof(struct xilinx_efuse), &dma_addr);
>> +    if (!efuse)
>> +        return -ENOMEM;
>> +
>> +    data = dma_alloc_coherent(bytes, &dma_buf);
>> +    if (!data) {
>> +        dma_free_coherent(efuse);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    if (flag == EFUSE_WRITE) {
>> +        memcpy(data, val, bytes);
>> +        efuse->flag = EFUSE_WRITE;
>> +    } else {
>> +        efuse->flag = EFUSE_READ;
>> +    }
>> +
>> +    efuse->src = dma_buf;
>> +    efuse->size = words;
>> +    efuse->offset = offset;
>> +    efuse->pufuserfuse = pufflag;
>> +
>> +    flush_dcache_range((ulong)efuse, (ulong)efuse +
>> +                   roundup(sizeof(struct xilinx_efuse), 
>> ARCH_DMA_MINALIGN));
>> +    flush_dcache_range((ulong)data, (ulong)data +
>> +                   roundup(sizeof(struct xilinx_efuse), 
>> ARCH_DMA_MINALIGN));
>> +
>> +    zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
>> +    if (ret != 0) {
>> +        if (ret == EFUSE_NOT_ENABLED) {
>> +            dev_err(dev, "efuse access is not enabled\n");
>> +            ret = -EOPNOTSUPP;
>> +            goto END;
>> +        }
>> +        dev_err(dev, "Error in efuse read %x\n", ret);
>> +        ret = -EPERM;
>> +        goto END;
>> +    }
>> +
>> +    if (flag == EFUSE_READ)
>> +        memcpy(val, data, bytes);
>> +END:
> 
> this has also changed and was commented by Stefan before.
> 
> efuse_access_err:
>      dma_free_coherent(dev, sizeof(bytes),
>                data, dma_buf);
> efuse_data_fail:
>      dma_free_coherent(dev, sizeof(struct xilinx_efuse),
>                efuse, dma_addr);
> 
> 

I see.

BTW: Is 'sizeof(bytes)' correct here? Some efuse access will be greater 
than sizeof(bytes) I guess. That's why I changed the dma-alloc to 
'dma_alloc_coherent(bytes, &dma_buf)' in the u-boot port in contrast to 
the original code.

> 
>> +
>> +    dma_free_coherent(efuse);
>> +    dma_free_coherent(data);
>> +
>> +    return ret;
>> +}
>> +
>> +static int zynqmp_nvmem_read(struct udevice *dev, int offset,
>> +                 void *val, int bytes)
> 
> please check variables types.
> 
>> +{
>> +    int ret, pufflag = 0;
>> +    int idcode, version;
>> +
>> +    if (offset >= EFUSE_PUF_START_OFFSET && offset <= 
>> EFUSE_PUF_END_OFFSET)
>> +        pufflag = 1;
>> +
>> +    dev_dbg(dev, "reading from offset=0x%x, bytes=%d\n", offset, bytes);
>> +
>> +    switch (offset) {
>> +    /* Soc version offset is zero */
>> +    case SOC_VERSION_OFFSET:
>> +        if (bytes != SOC_VER_SIZE)
>> +            return -EOPNOTSUPP;
>> +
>> +        ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        *(int *)val = version & SILICON_REVISION_MASK;
>> +        break;
>> +    /* Efuse offset starts from 0xc */
>> +    case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
>> +    case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
>> +        ret = zynqmp_efuse_access(dev, offset, val,
>> +                      bytes, EFUSE_READ, pufflag);
>> +        break;
>> +    default:
>> +        *(u32 *)val = 0xDEADBEEF;
>> +        ret = 0;
>> +        break;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int zynqmp_nvmem_write(struct udevice *dev, int offset, const 
>> void *val,
>> +                  int bytes)
> 
> here too. offset for example
> 
>> +{
>> +    int pufflag = 0;
>> +
>> +    dev_dbg(dev, "writing to offset=0x%x, bytes=%d", offset, bytes);
>> +
>> +    if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (offset >= EFUSE_PUF_START_OFFSET && offset <= 
>> EFUSE_PUF_END_OFFSET)
>> +        pufflag = 1;
>> +
>> +    return zynqmp_efuse_access(dev, offset,
>> +                   (void *)val, bytes, EFUSE_WRITE, pufflag);
>> +}
>> +
>> +int fuse_read(u32 bank, u32 word, u32 *val)
>> +{
>> +    u32 base_offset, offset, len;
>> +    struct udevice *dev;
>> +    u8 buf[128];
> 
> 128 is correct number but would be better to have connection where this 
> number is coming from. MAX size is 0x7f which is 127 but that connection 
> is not visible from it. I am fine with the comment to say it.  Please 
> look below.
> 
>> +    int ret;
>> +
>> +    memset(buf, 0, sizeof(buf));
> 
> I would call it before misc_read not to waste time in error case.
> 
>> +
>> +    ret = uclass_get_device_by_driver(UCLASS_MISC,
>> +                      DM_DRIVER_GET(zynqmp_efuse), &dev);
>> +    if (ret)
>> +        return log_msg_ret("uclass_drv", ret);
> 
> Above c&p from Linux is using dev_dbg structure and here you are using 
> log infrastructure. Would be much better if you can use the same.

Can we use dev_dbg here? Since the return indicates that 'dev' is 
invalid here. My idea was to use the dev_dbg for the Linux port and 
log-infrastructure for u-boot related functions.

> 
> 
>> +
>> +    ret = zynqmp_efuse_get_length(word, &base_offset, &len);
>> +    if (ret)
>> +        return log_msg_ret("efuse_offset", ret);
>> +
> 
> And here please check that len is below 128 to make sure that we never 
> overwrite stack. Other entries can be added and it should be spotted.
> 
>> +    ret = misc_read(dev, base_offset, (void *)buf, len);
>> +    if (ret)
>> +        return log_msg_ret("misc_read", ret);
>> +
>> +    offset = word - base_offset;
>> +    *val = ((u32 *)buf)[offset];
>> +
>> +    return 0;
>> +}
>> +
>> +int fuse_prog(u32 bank, u32 word, u32 val)
>> +{
>> +    u32 base_offset, len;
>> +    struct udevice *dev;
>> +    int ret;
>> +
>> +    ret = zynqmp_efuse_get_length(word, &base_offset, &len);
>> +    if (ret)
>> +        return log_msg_ret("efuse_offset", ret);
>> +
>> +    ret = uclass_get_device_by_driver(UCLASS_MISC,
>> +                      DM_DRIVER_GET(zynqmp_efuse), &dev);
>> +    if (ret)
>> +        return log_msg_ret("uclass_drv", ret);
>> +
>> +    if (word != base_offset || len != sizeof(val))
>> +        return -EINVAL;
>> +
>> +    ret = misc_write(dev, word, (void *)&val, sizeof(val));
>> +    if (ret)
>> +        return log_msg_ret("misc_write", ret);
>> +
>> +    return 0;
>> +}
>> +
>> +int fuse_sense(u32 bank, u32 word, u32 *val)
>> +{
>> +    /* We do not support sense */
> 
> avoid we - imperative mood please.
> 
>> +    return -ENOSYS;
>> +}
>> +
>> +int fuse_override(u32 bank, u32 word, u32 val)
>> +{
>> +    /* We do not support overriding */
> 
> avoid we
> 
>> +    return -ENOSYS;
>> +}
>> +
>> +static const struct udevice_id zynqmp_efuse_match[] = {
>> +    { .compatible = "xlnx,zynqmp-nvmem-fw", },
>> +    { /* sentinel */ },
>> +};
>> +
>> +static const struct misc_ops zynqmp_efuse_ops = {
>> +    .read = zynqmp_nvmem_read,
>> +    .write = zynqmp_nvmem_write,
>> +};
>> +
>> +U_BOOT_DRIVER(zynqmp_efuse) = {
>> +    .name = "zynqmp_efuse",
>> +    .id = UCLASS_MISC,
>> +    .of_match = zynqmp_efuse_match,
>> +    .ops = &zynqmp_efuse_ops,
>> +};
> 
> Thanks,
> Michal

