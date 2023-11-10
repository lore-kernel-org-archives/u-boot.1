Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB37C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 10:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D59387467;
	Fri, 10 Nov 2023 11:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="YHPCSTvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96738874E1; Fri, 10 Nov 2023 11:53:46 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACBD8743A
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 11:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAxgc/Cfour0cGmYUgVQxOKEyLsh2y4LmjtqZZbQbX5A02woYBMyiTEe+D1lkPuuhjA1/H6wZo+yj/7CjCE/lO07jdjbnzllDIJuyBJd9pBBn2nGnUpPbbqs63BOijSXYzG5UYLFbm0dH58SDnbo6WFEKC2+Fu34A21cMRA1f/Pg+g2j0f4sxSN5IzVCyy15hvqE92b+CcygHRMCZEqgTkpYxoOilcgrPVQVJL/+xqRQWo+pKjmgH2uNJ5SoA+VUnWNrt28aIDJTeWfGI0Cp/HGSv3JR7f4hVALX/XM33I+jXsTcAJOAtCDKJyeDf3SE21cn8iMikOEifHHBGJtfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAoNuJtznQQg22vd94zPlUtlBYCKGj2E9bCtKYsJu58=;
 b=QSws4VVoiI0LgPUNSzjWxphAZZqo83o1/r7ygjhGLfwYi22gFMH2qvQyArW2zXQawbjTHmcYAXF3zQkgDtWfpUwsu+if2m3oex72UNLbZQD0190klHzhI/P9jfuC55ZWU5HcXBP6V1Qa3KFFXmF6xIROmbz9fWrq9w/eFDkIVz8nqE+XbTAYhDESwDeLG9jsagCZdTV334/wCpfPmsv2EzfkybZ+wcbjrPZCH+ewokSVQ0RFhZv51WUAagQXzQit9rbXLC+D0BMipzDNrW9Zb9PQxe8MJs4kEcieV9PXQf9hHKLw4H7U9TdxcFaDmpUda8VFDMzXYvQnB1SZKd5m3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAoNuJtznQQg22vd94zPlUtlBYCKGj2E9bCtKYsJu58=;
 b=YHPCSTvJgVwnxi2sTU2rxqjyG7ut9JJUwdcs4kSPyYV8V+OifwO1CZ/k84J6AZ1R6eFXSzwyCZ5skRA01Ow8u5K7KKbRuSizhL0QafqfNI3SpgWJrmM27sZkA5YbztYmiCxA+xky/s/7V3riirmHYKEZ92ljRdO0UIZ67mS0d4bYh9mdMM5anOc3C0VWTiiFamW2yH//DEbvqWF6sCNQp3hEQY9a3EDQ2YpmRQtIqoqEw5oif4z2x9R+yFHnHvTcJhRfMO7N03pa2CpxM63EmXR/cQf+m3DtC96jS0Us19bbDIpep9w2KAWHesh7tv7k2fUk/iqcqg/gH+UZ8WMMkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBBPR04MB8058.eurprd04.prod.outlook.com (2603:10a6:10:1e7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 10:53:42 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9a02:79c2:fa2c:3e12]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9a02:79c2:fa2c:3e12%5]) with mapi id 15.20.7002.010; Fri, 10 Nov 2023
 10:53:41 +0000
Message-ID: <045e178c-df65-40b8-9bcd-a32a789e151e@theobroma-systems.com>
Date: Fri, 10 Nov 2023 11:53:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] rockchip: ringneck-px30: fix modified boot_targets
 detection
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-6-cb493bfdeffd@theobroma-systems.com>
 <20231109212809.GO6601@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20231109212809.GO6601@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBBPR04MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: f3afb504-e103-4c7d-d83d-08dbe1db4d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Nag0DYutE4Vr1ER7tx7kehKKmqMHa7fNneb1eAQqkzinmP98Q3a/MWGRq3RdhoaMbq1Ybe4dOUHi/dG+Q4O2yqoLOWpgc9Rjce7injsIaUio9VoFp6sshRjaE6fsAPms4+m7c/A1i7BnuLijqhVe3XhXQlH/kC/AXN2ajoSLc2ZWiMgEIGMY/CV5YXm7CycJmj49UVxRTRZ4rqFYTdP5lw0x75bSvQXirm67gtZRhBzLydDho7UpcmYeO22/oYr37trNq9hnueBQNth695Ujcv12m4NTLohmfyR2tcqbXgMNO534nLLdZE6oWMEkoFN6Byx4sEfgl7ZaUqC071UwI2MrTioxS0Cs/IkPN6xgECsaiyS+Gol81tTLNjr8SCxQMopcm+jD3oqO231+QfQ2LxsyJ/zSkHnIyZsHMaV/M08XyjUAAcG5oFyUW5xLIPgyMZobdR5Uw7s62S6iHemIKkBjFCrT6k+8FCm9RqoXVWC7bQ64zP/xEn12Q6moT/WYX2OH0TIwbqJq7y7rBMf+JRrFZwkzwASxeCKe39Drhi4bPV9wrdRKj+Im1otV6bj1J7vWJGXSAXOB6SwkhuOFILJ2pZ3ijj77KChYxcDsC+GrdCMzFHEZOqS0ntGa4cpMhDHkjSU+D/6+WSggpiuyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39850400004)(366004)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(31696002)(31686004)(6512007)(6506007)(53546011)(478600001)(2616005)(6486002)(38100700002)(86362001)(66556008)(5660300002)(36756003)(44832011)(41300700001)(66476007)(8676002)(316002)(2906002)(26005)(4326008)(66946007)(54906003)(110136005)(83380400001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1M3MS9QY1BwVWxFODVRWS9wWmw2RW5FKzhtVUp2MFpsdVFuKzhUZkM2NWtY?=
 =?utf-8?B?N3BQeTFOQjJEdTNWUk9YTHdaKzRseDgzT0hIOG5wL0taN1VNYnlkWlErcWQ1?=
 =?utf-8?B?TWlJRzFXS0J0Mzk0MVBkVHArQnVjN2I2N1V4ZXZLdlVHY0xhbzR2NVdpaTA1?=
 =?utf-8?B?L1FHbEVGcStNbjkzRlNWUEdKZkFZQ09TdFU0bDhVM0NjdUxPSFp6S0x0Sm5C?=
 =?utf-8?B?WG5mY0Y2WGtBZHluek53NGxURkVKSnRCYnlmUzkxR05weTdoUHFnbzgxL2hB?=
 =?utf-8?B?clRNNHVJS05FeWdqWTlzMkdDMXF4a0F0RFE4bTBTNWtabThOWDlnUTlEZEgx?=
 =?utf-8?B?d2NyNkdPVVpYL2tYNi9TVURxLzZ6MjFhU0gzcWV5K2gyb3pzSDlHS085dWlU?=
 =?utf-8?B?dWs1ejVKclcrb0NQWnNqT1doWlBEcnJpMFNEQ2k1a0VmRXNibEFNbFRUL3BB?=
 =?utf-8?B?dVB4c05Xd0IwTlA5eTN5cHBiMDBSRUI2L0F3dk9kZE41Y0JFd09RaUpualdH?=
 =?utf-8?B?enMzWEhUalkyZk8yQnRFN2I5MUNQM3VKd1hHek9MTU5HSlNQVUdsdFMyc2du?=
 =?utf-8?B?SkxpSWdKMnhxVDRpT3FaOE9JSTNUZHJGOUV0b3NXUXdKVzZOcVJBMzBTL3VP?=
 =?utf-8?B?UHBqNkF2RkdQYW5oWWg2U3lvUWZya0wxUzdiakpXRnhZeTR4V29xdndnVGJL?=
 =?utf-8?B?WWxyRC9oWlMwWXl1RS9uSDVTVXRNNTI3QzZONDE0TEdhQlpHZnY1OWNWbUda?=
 =?utf-8?B?cVk3cy95a2xWNnY4WXhJMGRYZjVGVUhtZVNuZC84TmZLODkvRmVwRDRxSHlu?=
 =?utf-8?B?aHpNUzNCcWxDelZaeTNmSkZ4LzJjaXJaUWF1TlVzOWtIM25hdk1TZ04zWDJj?=
 =?utf-8?B?OEt1N1BrUjBweU52S1NLb2FzUllOMHRrWHZ3TGljL3lFWVR1ZVFEMGU2YUZ3?=
 =?utf-8?B?eWZIRzI5ZlVrTE10anNUTUEzalltdUoySUJCcWp4bEluWWVDSmx5YlN3aTJy?=
 =?utf-8?B?Z1RVUXJmczQvbFpUcFVZN2ZOV0xGM3JkUFFxNTM2cUo2QWY3WC81dWs3MXRK?=
 =?utf-8?B?bGlWdGRVWkNwdURNY1dNOW94Q2tKdStGUW8rOS8vVzg5OTB0L2FDdEt0ZXRY?=
 =?utf-8?B?L21FN1ZUUnA5Z2phTHhDaVZkNmVQQWNEWWlrNWFmS1F2RjQzZkl4N1d0a0d6?=
 =?utf-8?B?QkM1dk4wclZZOXA1K04zSVZ1d0hycStKMWtwcnV3WTE3Q1RWRzQvMVNYTlJH?=
 =?utf-8?B?K1hINnU3TFRwNXVXOXd1UTVoS0JYcXlkaHN4dTUyLzhYcWt0ZHdYajBYeUl0?=
 =?utf-8?B?aEhWZWtsUXdnWHkxV1F5ZGZxRUNyUFVUNVFsRjVETUM3OUg1cnlqM3c3VXRE?=
 =?utf-8?B?aGViK2xNSlJzS3RWWWUvSC8vSVRQVmJGYko0Y0dpZUdjbHlrVytKeWl2bUha?=
 =?utf-8?B?ZThUTUlZUUZyZFNNVVhnbS9aUW5HNStRZmR6OVF3b0JkeTJQMVZXQTdFdXB5?=
 =?utf-8?B?eEFZQU0vWjRoc2owc0tURUh4NXdsWGk3U2xaUVBMakp5TTFLV1NpdjFMVldG?=
 =?utf-8?B?UHRvZk5LeStvazdsU3g5QWMveHhGczV1ZnVkWHVyY2xWN016K0poTm82M2tB?=
 =?utf-8?B?VnF4cTFrbmJ2cThIYjJmNWZJdENRbGphMTU3WjR0cFJIaUxoQnUzaGNiUk55?=
 =?utf-8?B?djFhOHNoaXVYTGNmSkl5aFI2aGJxK1B5alVvWlNwWTVzaVBwZWRBbEk4amND?=
 =?utf-8?B?VUhONTB5VXl3VUFOZTB4aG11d0Q1bkRURXN5RURyUnJleERSMHJOWlBkRkFu?=
 =?utf-8?B?YUsvTEc0RVFCcVlMak1TeFdQUVU4aS9ycTE3SDU2NkhMWmV5QUdwVE1nOGJH?=
 =?utf-8?B?SEsxZnN0YnMyblZPZDlvbUZYa2l3T25hbGV0aFYxWFVCZFJwTHRPZmN3RCtW?=
 =?utf-8?B?TklNdGhLd0hEc0I0RFg4WHBVQU1VNlYvUFUza2FBc3lnenlFQ0RUQmVxUHhk?=
 =?utf-8?B?Sm1CMS9ZK1ZZVGpidkNBOUprQXJlYm9PU2xsUjgzd3htZmhlN2RTVUNpaDZ0?=
 =?utf-8?B?ZUlvamFlcHp2bG1FeUpCYjh2V2VWMVZnWmIxZGJtcFBpUkI2SjYxYzVLR0pD?=
 =?utf-8?B?MDlqZ0ZYTUlPTnI0LzY1S1RvSWNUV1V0OFpZUFk1Y3RTdlBxQVB5UHB5bUk2?=
 =?utf-8?Q?ZgxX5xrLZ8Ix5ZGZ3u8IBBc=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3afb504-e103-4c7d-d83d-08dbe1db4d5f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 10:53:41.9050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ag5Wii2QC0Vz9M4Ke65LJ6xbFqzBr23WoaiuisSfYPH3gS/Omw33pWpqHU42SbGFF4q+xjAGXwfG2PtAZsV0StpmD4H6/PrDvtFYoHlE1RbaZvKiWqG8zK760h1nI1mB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8058
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

Hi Tom,

On 11/9/23 22:28, Tom Rini wrote:
> On Wed, Nov 08, 2023 at 03:20:35PM +0100, Quentin Schulz wrote:
> 
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> U-Boot proper automatically modifies boot_targets to swap the order in
>> which MMC storage media are used for standard boot based on which MMC
>> storage medium was used to load U-Boot proper. This is however only done
>> if the user has not changed it manually, therefore a check between the
>> default and current value is done.
>>
>> This used to work fine until the migration to standard boot where
>> boot_targets value size in the default environment went above the 32
>> characters that env_get_default function can return, thus resulting in a
>> truncated variable.
>>
>> Therefore the check between default and current value would always fail.
>>
>> By using the newly added env_get_default_into function, a buffer of
>> the appropriate size can be allocated on the stack to get the whole
>> value of boot_targets in the default environment and thus fixing the
>> check.
>>
>> Cc: Quentin Schulz <foss+uboot@0leil.net>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>   board/theobroma-systems/ringneck_px30/ringneck-px30.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> This looks like what the puma-rk3399 is doing in 5/6. Can we have this
> in a more common location? Or would there be a downside to that?
> 

I can think of a few things, yes. Now wondering how far I want to push it :)

I could simply pass the DT paths to a function for eMMC/SD controller.

Or I could derive those from spl_boot_devices array in spl-boot-order.c 
and do everything automagically somehow.

Will try a v2 next week.

Cheers,
Quentin
