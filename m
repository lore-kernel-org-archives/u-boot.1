Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8C7C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 18:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5135087EAB;
	Tue, 23 Jan 2024 19:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="SUV21tsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB1AF87E70; Tue, 23 Jan 2024 19:06:55 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7936C87A17
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 19:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Od/IBpFiC0e+MGFNxSF8I+1dT3OEb5dBUBOpL7RDmnOApDCZxOy5DIZpiIIF5Tz8F6MjJrqlcbKe+8rr6ZEJDbA8+3aDpJzYj77sY5UKJrb89lEOPMC//gyEZAro2Ndcb+9aOwzByfpMV6LPtRG8stW16MqU+1sm+Xw/EQnySmGmdYPSU4auD0E+hJ0e+cUGFuJWycY0D0JKUZQr6fO3mGb2gSAvSIy2MMHOzxX4o3lvpYeTf9faFn+lyTY15WmKVOvW/BPZZ9qLDm+cpRKjRE0m6pID54BVVAqU21ShtSHqbQmVsjTWbTyHJfL8F21KtlH5XkhBE/UER4SLYjOkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofKMWbLqLf5YvYHxdIFKd1Swdr9rxv0EWZDzZkU/VXM=;
 b=OfV/lPGkN3ZgyypGHDfcgsMhKK8T1GTEfq+XdFqHKOMNcPhEyo7bcTuDIBYWBkmqySxlUbKCBrcnCqeDE7QBJDdltK2Kp8Z2r/uUwwx6wow79laDPRs9BlJ7CHCC0bAKVnMj9OJ7VSWTeMZ50JQMM1O/vvfqbRlvBCKCFSjYDi1b0bmTGPcvE15JP25DABIFWPtCqjRdfQzwHxWQxPWarq1VtvxAhI4UFRpzoKX1amd5Z/x8UclFIsF3A3Kdfg8w/IQpDbw/UPt7MCkLeo3na/fGUONmrlcds8CSQb1xZdoHwgLRJ7++e7k8dgoLIAKuoJVvosDei9s4wcHdF07DoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofKMWbLqLf5YvYHxdIFKd1Swdr9rxv0EWZDzZkU/VXM=;
 b=SUV21tsuYW1pBEKU57S7gzD4CFQJN3Amdt58nphjDIfzuDcoe4tUv9f2XJhWY/FAOnyDWz4IVSDk8xWJhbCrkR94JMnLcRhS1gL6ht9wBdaTK56gD4KA1YwEmzEItWx5t3f4lbTPNNv2XbVWrxlhWptnEqQ7cegovcl1k1bOgBAruWmLW1endo4OFycXmO2pSV3lGgrPDZOFquD6dm2hPP/fqxURAUE5rnqfSHgUXByCG2cghryBf0OYNkY5ZpUbPKRTc2Mb2XHei3qY6CFRTSaWcuS5OoE8Hzc10SN7GlCKgCFbXkFV7XvSfiPD2pcDPsmRVZvUqZ8JyM7zEMVFyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 18:06:51 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 18:06:51 +0000
Message-ID: <1f49dab3-e809-4619-8ec8-ec96526f6faf@theobroma-systems.com>
Date: Tue, 23 Jan 2024 19:06:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] rockchip: find U-boot proper boot device by
 inverting the logic that sets it
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, heiko@sntech.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 u-boot@lists.denx.de, jonas@kwiboo.se
References: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
 <20240117-rk3588-spl-boot-dev-v3-4-72cb989e6da8@theobroma-systems.com>
 <afc5d7e1-030b-48f4-b414-ab4a918debb9@rock-chips.com>
 <ff2cd476-e230-41e9-b9b9-bbf15f8fcfcd@theobroma-systems.com>
 <20240122175426.GO3652023@bill-the-cat>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240122175426.GO3652023@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: fda169aa-c19f-4bcd-567c-08dc1c3e12ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKdk5vNhnryPHExepGtRyKCjsavJr4522ps8KbLN0Dw6RI/i8ksDC6Qk1o51P4jZJDpQRZeV25hfdGakQJT8jwQICUfJInAsKMlSzuem92KHSndjv22/ozJB9z0fSFNEQ9ydwanr5eYV1YJN5YtC6jZCvTrecsF/G5crLwcnLZJiYnN3g7+lFJr5O+2vOJI9xiIOqAhYbKbNES0uFx1+BoMfEmXxZ6AM/t/WKC/DwBNj/HJmo4Cd/LZZnZX9826fn9nk/xuK+fweXitmYSkrHCi2Cs7d1IF9XHAmg9EE1MO7Ec5r7h3z/csy7lj2juCwmOf24Ll0Jo+MaTka5BpbFu5fCXh7tRvMJsfChL8fqBTVvP+OZUUUqY13pFf1CjBAmm0DZZ2iq60DkufgBhzbM+flvfy/nSAUcvHD/X+Fs3cXnFYij2GddeSYmoeynG7APA3EZO768UXFIDGHvMWyJ+66TsFr0VyCPNwe72ntdsK2SuzuPh3cGXWJL5BvouiONs4SqCBKgltnNbNnZWW3FJ6+eA103/Y6B/gNNVzH7oGN3IrQ5BRTpWv+bOSaZv7FPyMG89G47wxKB36/LxKBgVE29y11HrWQh/D54erdkm+/sq1Q6xUlpn/nt/wFtATV20daTDbaj6YV3CVyjCAktA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(41300700001)(36756003)(86362001)(31696002)(38100700002)(478600001)(6512007)(2906002)(2616005)(83380400001)(53546011)(66946007)(6506007)(5660300002)(6916009)(66476007)(66556008)(316002)(6666004)(54906003)(6486002)(966005)(8676002)(44832011)(4326008)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUZseTFsTlBTc0xMV0dMdmRkYzYvenRvaFloamVmR2VkeStsMXUwT21Ha1c2?=
 =?utf-8?B?dkN0aGwySlFROE9Dak5nT2c1amhseDF0V2lvMkFUVjZCcWNWZE0rZWZqS3g5?=
 =?utf-8?B?ZDk4anEwejlHT3g2Y20wSlNqR1NpeG9YY1VNekMreVlwS0RDOTZ3QW92ZDU4?=
 =?utf-8?B?TnptdVhwQzhhQVI2cFdvWnRMN0krUmFTY1ZQQkEwRkdwWGZKSTJ0NU1MQ2ZW?=
 =?utf-8?B?VmxpTC9KWmZxbzhhV3VDTzN1MzJyWm4wZmNOSG5sdTU0cGZuWDRIZittRml1?=
 =?utf-8?B?TG5LaS9JSjNuYmdsekF0ZS81YWVycXA2eGZvQ1NMN1VKcDV4VU00RTR0eHcz?=
 =?utf-8?B?dllaejNieWJHcktVYnRtY1B1WUxxb1hlUW82LzdVZHBtSlZ1eVBWdW9kL244?=
 =?utf-8?B?ZVBWNXBwN3dmNUx3M1FuQTVnN3FLRHZiNXlaYktBaE9UTi9SRkZUa0MrN21o?=
 =?utf-8?B?YzJ1M1pqOVJUSktFNFpadzExbHZSMUVDNnpWQlEyNXhqak1oQnM5MmJQOHMv?=
 =?utf-8?B?Q1RxWjN2ajNjYVNTYjVEMXJmTldrbDYrekc5cHVxOXVrdTV4blN5NlBXOG4w?=
 =?utf-8?B?YXVNcy9lSG9XUTVySjEyekE2WlFHeGhXdWVqYnZEN3Z0UWVRZVBaRU4yMkF3?=
 =?utf-8?B?NWVnOE8rM3ZDYkxZUFZrdkZhckR1UWlhRHBRb0g3VTVFdHZ4MGRXV1ZDaU5l?=
 =?utf-8?B?L3N5SWdxZWJSaGlqSmtMZmdxaFc1TmxxZGUrWW9uNUcwY0JZWjh5Q1luTEVP?=
 =?utf-8?B?M3RwSEVwcG5QYUJ6VHJHNGpmdFVNbUEzZERLV3d3UXRDbEVxV2FUSkxRaTNj?=
 =?utf-8?B?d3pxWmZsMG9oM0dHNEdRUGg5OXdJTEc2a3NhdmUxV25GVmpHNW9wbUdSeXdG?=
 =?utf-8?B?OFdxNGYvcENBQkZ1QjJNOUJkN0NxZHVKbUE4b29XdzlaSnhGTEVSdVI3aTgx?=
 =?utf-8?B?NVM5amwzcis4ZEw0d0dEOERVY1JHWXc4V2xrT0I2WFVYQ3A1TUwwRnpQQWUr?=
 =?utf-8?B?eW9zeEZ6c3E0VVJjbk1zdkpKTXJ0dmpBY3FYZ0NuN01UdUpIbFkyVWgrTUFr?=
 =?utf-8?B?RDNGcHpEWU5SaVpPbFVGeFQ4ZlNvTEpUVW96bDlTdk1mNjFzMGpLUjdRUVln?=
 =?utf-8?B?MDRORU5sNnYrWWhaRlN6VzZWaWlVYVBEYnpQbUZwRTZOMXYrOVphYXVKVFYx?=
 =?utf-8?B?aUFjYThiU0R5Q1E2MkdLdGFXaUI2YmxoOUkzbGpZbVNHNEtWZ2JMemYwS3l2?=
 =?utf-8?B?S2ZDUWZFTjEvbzNZM1oxVmt3ejlXcEtheGZtTExOWHNsajZIOHd5cVVudThG?=
 =?utf-8?B?cVB3UEM2dUJQazQ3T3pGb0xMWHIvRXZTd3dhSC9qUk1SMXlYVVVkZTZUa0VF?=
 =?utf-8?B?RFR6TzNOS0lCQmZmT3Z6ZkxPZFR2YlU2MVdrajVpdWFJR2tQU2dQemx5REZM?=
 =?utf-8?B?TnRuNnVKdVljTFJXNTB6Y1NCLzg3M0NNS3NPUGd6endMblpqVDRybXBGODlX?=
 =?utf-8?B?L2owemU5Q05mdXVFcGpkTUZYeHJzVzM4RUlxVE94aWhjRGIxSEY5ZWlwT3BV?=
 =?utf-8?B?dGVhTjYvZzVlVytVSzJxZThwUG9KWDQ0dXRNRTZWOVhoQWJNRFVDYnBVZ01I?=
 =?utf-8?B?YndLb3hObnlDai82VUZzb1pzTDlmLzZXTzJnMkFLL1FnNkZkYjRRbXdwVSsr?=
 =?utf-8?B?WkJyYS9HMzZEdnJ1Ym03ay9CVHkwSXhLUGZ3bEY4MlVsSzF0NGZhZEt2Tktt?=
 =?utf-8?B?UHoxVEhIbm9BaUZhLzZHaHI3eTB3Q0N5NHdmTC9ISHVmTXpLY1ZOeW9nak0w?=
 =?utf-8?B?dTlDS2I1ZXQ0elY1NGl1eTNiRW1pRm8vK2NRMjlJU1Z2dUtSQVJTY0FBaC92?=
 =?utf-8?B?clBmbk5LY2RPaERDOFdIVHhKQVhlSU96NHZTVnFZdW1KUktUUlpCZjhDaW03?=
 =?utf-8?B?YW5YaUQ5S1ZBZGtMU1ErTUEvc0dHV1FhOUJBL2RXV1ZoYUtBWHVUSi93V3Fx?=
 =?utf-8?B?SmU5OGo5d0U2WFRhMmc1Y0lCYTlVbWY5c3F6TjI5WGkxYlE2YTBwQzErMHZ2?=
 =?utf-8?B?Wjk4eWh2QjErSS9VbFBPK1p5VkRrb3Y3M0hScWRKbHd2QXV0RzlBdUdKSXBF?=
 =?utf-8?B?bzlIZk85Vk10a1JwT2d6NzZRb0JzTTlXZ1d1NUdtRFhGeFo4QzB0NGNDcGs5?=
 =?utf-8?B?QndnN0x3SGZFb1EvZTYwVllXSnducjA2OWtaTHgvN2tHUG5ud25XS1YydWg0?=
 =?utf-8?B?Smw0Z0prNG9vMDloUWlsRmVxWHZ3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda169aa-c19f-4bcd-567c-08dc1c3e12ca
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 18:06:50.9428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrYrtJNztD4Y7/LI61eTMI7J4usEUL9vUd0mvo/EVLbxOglD7TGms9eka/t93z1R/NeQ413KuXgLJJmkCVgr0ItiGvD5caLdV88xXpy9cIfSOATuOZ0IMvE44UL3E7KW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301
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

On 1/22/24 18:54, Tom Rini wrote:
> On Mon, Jan 22, 2024 at 11:49:23AM +0100, Quentin Schulz wrote:
>> Hi Kever,
>>
>> On 1/18/24 11:12, Kever Yang wrote:
>>> Hi Quentin,
>>>
>>> On 2024/1/18 01:22, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>
>>>> BOOT_DEVICE_* is set by spl_node_to_boot_device() depending on the block
>>>> device number associated with the MMC device the SPL used to load U-Boot
>>>> proper from. It is NOT related to the mmc alias in the Device Tree.
>>>>
>>>> For SPI flashes, all SPI flashes will return BOOT_DEVICE_SPI so there's
>>>> currently no way to know from which one the SPL loaded U-Boot proper
>>>> from. Therefore, let's just find the first valid candidate in
>>>> /chosen/u-boot,spl-boot-order that is a SPI flash and return that path.
>>>> This is a best effort.
>>>>
>>>> While the original implementation may have worked, using the exact same
>>>> mechanism but in inverted fashion makes it less likely to have
>>>> surprising corner-cases or side-effects.
>>>>
>>>> A nice side-effect is that all existing and future Rockchip SoCs now
>>>> automatically have their /chosen/u-boot,spl-boot-device set.
>>>
>>> Error happen in some 32bit SoC:
>>>
>>> +arch/arm/mach-rockchip/spl-boot-order.c: In function 'spl_perform_fixups':
>>> +arch/arm/mach-rockchip/spl-boot-order.c:242:31: error: 'struct
>>> spl_image_info' has no member named 'fdt_addr'
>>> +  242 |         void *blob = spl_image->fdt_addr;
>>> +      |                               ^~
>>> +make[3]: *** [scripts/Makefile.build:257:
>>> spl/arch/arm/mach-rockchip/spl-boot-order.o] Error 1
>>>
>>>
>>
>> It'd be nice to say **which** boards aren't working so that I can reproduce
>> locally :)
>>
>> I eventually figured we have GitLab CI/CD for your maintainer branch/repo
>> here: https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines.
>> This also helped me figure out this wasn't the only build failure and I
>> could send another patch before you had the opportunity to tell me I had
>> broken something else :)
>>
>> Giving the link of the failed pipeline would really help, please think about
>> it for next time :) Thanks!
>>
>> For people interested in build-testing all Rockchip platforms locally, I
>> used the following script:
> 
> Please note that you can also build all of the rockchip platforms
> locally with:
> tools/buildman/buildman --allow-missing rk rv
> 
> It won't be bootable as it will fake all require blobs, but all
> platforms will be built. And buildman can be told a number of things to
> be built, but "rockchip" only catches the cases where the board vendor
> is "rockhip" rather than ARCH_ROCKCHIP, but "rk" and "rv" catch all of
> the rkXXXX and rvXXXX SoCs.
> 

Ack, will be trying this one out, thanks for the heads up.

FYI, it was also missing "px30" among the terms to pass to buildman. Now 
I get 101 boards, the same as with my script :)

Cheers,
Quentin
