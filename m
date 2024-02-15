Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384E5C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 14:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76A987DD3;
	Thu, 15 Feb 2024 15:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="cjvfjr6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2EDE8785F; Thu, 15 Feb 2024 15:02:01 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B6387E32
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 15:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpdJ0HfIwpPIDjrIwHJMxn44NzqyBk4qZcNt0kXiLSwQ4ruP1UVn/VbIM8KXyqiiNrcc0AyPFjSxVaMWQOxGQ3gtOxLt1HcUFmEt93aFZXNsconZKvtuJxnOsbfgPq4lIIY4XEiB+Zi/LNHj6eEURjJsnzI7wR4Vx1jfUewlCpSZja0OKywBFv6HoS+wedKX+ONHFoG9utA6DpxJwIC2RfLt8pMRdgzBC1wE3BinkqELIfIIEvDgRROj3klg/p37S9RuUs8AHTIkwwSKRvDcXn9TcNdPGUYDvsfBZHaFQwl/ZWXwncr6AZOOoUpawt4aB+uFey8bhEbPrm91mdXFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GGgGZigQscwzhvmrKmX+A4jQaFkLWc4epbGBEAQRx0=;
 b=BxPu3sj9iDxfoHeQ7b7OQriDMMdFM8uPUcyM8Mq5AnA9VKBG/BirG8qab4xQuRfN8916FahYwlLxp9iV3DUwr2YtnZe+RrK3XPiqp9zIm7t+wdA6BjnVPZAdOyVM4glNFcqnBPsAhi7/Vq+V6QJTaJE+E1cLqlOxgPDD8U6ATTXdH4Ix/PAav31558+adDZwabkHpxc4PebR7s4gwo7Bgs/2vi7cgFVlU7PhQaL37kyTrCy5RUPc/FLbYAI5WseoxmbYDYNzoqCy9FGC1ri8qecAlq6bWorry1xm2r+byZ+3rhoTjoTLyEM7pxtIpJqA/49VFeTdOdjQuvSPZ5t31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GGgGZigQscwzhvmrKmX+A4jQaFkLWc4epbGBEAQRx0=;
 b=cjvfjr6i8YumRuVVozmJB8sPLIT/SxCx+YECopyqpBEk3ojLiwTK0BcDX7yQDv1M9Z4/pbx17PM+mavO6OdApPvrS5mV62JQuG6LeUHPO1RZ07h/+2I9zimRtTMD16ZuWs7JVd9TVRIyZvYTsZalFnVyOD5soQj33aezWRz/2pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV1PR10MB5986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 14:01:51 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 14:01:51 +0000
Message-ID: <8d2d2e08-d1f2-4076-ab9a-82c536a4d5bb@kontron.de>
Date: Thu, 15 Feb 2024 15:01:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] doc: board: Add minimal documentation for Sielaff
 i.MX6 Solo board
Content-Language: en-US, de-DE
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Frieder Schrempf <frieder@fris.de>
Cc: Kongyang Liu <seashell11234455@gmail.com>, Nishanth Menon <nm@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yannic Moog
 <y.moog@phytec.de>, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240215133527.216126-1-frieder@fris.de>
 <20240215133527.216126-3-frieder@fris.de>
 <a2e98f0f-f28e-457a-af95-0a33b6a75c4a@gmx.de>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <a2e98f0f-f28e-457a-af95-0a33b6a75c4a@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV1PR10MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de4dccc-2baf-46e5-3a5e-08dc2e2ea8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsGA52MPE4fMAh6Q8tpwY3OiDLJem8nqBvrWO0yLZoWl8XDaYxfNAauPM3l2VVhhMzJSyB7VE6O9d+T2VpqnB2DDnnUlCor0ZE4gusGH2aa53rD5qEPbDRjAg5LHVb73reaKAna3P+Gha2tn05wMkeCkNrPZ2BxbGLP4JS0X4aRDBOXQyvrnLZvkEDWXhUW6PC3Bj5FxoTwrAV43UrDZl6gqe51SpYzNKHg88rn5bTkP7EBMX1E/srw6J+aSEUvQWPkQL+49GwQHMQWQHSDfhvftSKkjd6zqSZBHDiG2B2GHgv9NVRIUKSHKGt0q+sjEqBVbQ9yaawrVeFcmHoY/XAJYg9ELwvY0LyCYKn4pZAvgtau1Zfkgia6HvSnPp+3YVq3pIUa0mAIdkkV8I5gX9lqS5jzBZxGYGkMQw/0T+uPT60Ihl8okXChEBvDLGK4JOfYynL8pwUj/eJ2uSs2NxCjc5v/yBUC5a/Xi24n8v3E8SQY0hY/q8IaktUlMCk3xOukDW63P5OlbdjpAcOQFsp4V3w4R1xtzS6VxlVwsbynnSPb1KQBMTm1ZCkioYnSs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(7416002)(2906002)(44832011)(6512007)(53546011)(26005)(2616005)(6506007)(478600001)(6486002)(31696002)(36756003)(86362001)(41300700001)(66556008)(38100700002)(110136005)(6666004)(4326008)(66476007)(54906003)(8676002)(316002)(8936002)(83380400001)(5660300002)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTUxb2ZHVmR6YUk4L0xsNlc5a3ZxVTBwem1hdE9sNDBvYW5wc3UyaGFEUHBn?=
 =?utf-8?B?c3BBWVBtZllqblRvZWJYdytHWlI3cExVeVlmS1ZaNmFHdkVRMUU5bE5uNW5v?=
 =?utf-8?B?MGRDVE1vNHFYbm40L3k4UG1iVWQ3VytxRkoxa2Y3RWo2RW12OCtLVXpCVWNu?=
 =?utf-8?B?QjdxQU5DalpqMkk3QTlRK1FZaEVqcmJKWSsrcnZMdE1VWWFkdktYTWtCeW13?=
 =?utf-8?B?eklDOFNQT1pSNlJ2b1N6S21wclVqV1BGaXRNWlROZWpickVoVndIR0tNM280?=
 =?utf-8?B?QkltVUdKOHdLR2lxYWVsa0NuY0FuOHpRQnErRU4vWXl3bTlNNkFGSStGdXc1?=
 =?utf-8?B?dm5XUmc3em1OejBobEQ4anJxd2g5SDFJdGlNTmZZSEdaTFNvQ3ZVQlpRZWUr?=
 =?utf-8?B?NW9mcStwTEJBdDFmeHlIQVlVSVBDRm05WVNpMTA4RndrV0FUQ3BMOXpLb0ty?=
 =?utf-8?B?RGZralF6RTZCb2c3WURvUDZtN2Z2aUorWkRpRHMxR29ELzhZWVEzQUZBblRN?=
 =?utf-8?B?T3E0T3RPUUxDZ0wzUlM4VWpZZ1AwdUhXYnN1OW1SeU0vY3VXQlBTOUtQUDJZ?=
 =?utf-8?B?WnhZYTRYMVpUYkIvQUhlelBvbHpxV0hKTlpKM21vWDdtVm1NSWwzOXlKN0F4?=
 =?utf-8?B?OGlKL0dsN1hTbHFaZG9VM0NKNGhvOGdjNE1WNlYyaDFyMHVZNTZrMGdaeXJj?=
 =?utf-8?B?aGgvdnk5UVlsWkphUDZHWkxkN0tUQUJzenhlWThPaFAxUVVhUHJJZlN0T2dP?=
 =?utf-8?B?SlhzQWxOcUpsOWsxRWNQRUIxbVNKYmNKaU5NV29ZY1lQZ241ZXJUQk1TdEZY?=
 =?utf-8?B?RndhMHFmeUhFeDJQVGU5ZFRhdlltYmJRVDdlSGQ0Qm1QWXlZM0pNTFBwREhW?=
 =?utf-8?B?aWFXcnhhLzJLUXJwbWVIQkIyK0xuMi8rbUhHMXNKNVpXdDNQTUtnM1d2bEhQ?=
 =?utf-8?B?cEpWSXo4OUJucDM4RlBsSWhrMHA4dWxrSWs5QWtDQlhtZmlJczhrTkNjMmM5?=
 =?utf-8?B?d3ZCS1Y5K3drN1BRZ1l1SXVVbldZMnJUSHJCTmRhaGRtMHJUWDV3ekRYUlpv?=
 =?utf-8?B?MWNhZFAzN05qN2srY253OE1iTCtKWklWRWdvaGtvQ2NhUG1saGJJZlVHdWFQ?=
 =?utf-8?B?SlJtWWtCSzdGcWlPLy8vZ0E0NWM2dmRuakpnMTJTSXE1Smg2RFV3c1NCOEZZ?=
 =?utf-8?B?TW43SmxQS25ZQUNxb1lVckJXNGhSOEhaT1ZaSm1wQ2FMd2hHaEtGQnhwVS9E?=
 =?utf-8?B?c3ZsTE5MOFltRldFc3FLbU1Nc2RvUUJHRnhtdE1iN3Y0MUdBdG9LZE1NNUM0?=
 =?utf-8?B?THNUSTQvbk1WUEloN1BOTk5semw2Tm9FbjFqM0U2SWxtUjFoMWtYaHZVbnZu?=
 =?utf-8?B?SnllNU1raFlrMzJ3blc2TTJManpWMmhiQitYUkxidmcrcWtERTJNV0t3clRz?=
 =?utf-8?B?Q1c4dG1TajZ6VFhXTGF3R2dlTm5QRTE2TnhIR3dTbVhZclVqZWhuQkpLOXZL?=
 =?utf-8?B?UmlWa1NORXpSODErZ2hFd2lBK2ppdzE1dGYrSmx4YkRpOTMwdHh0dzlBK1dt?=
 =?utf-8?B?dFllWkxHS2lFOSt0NUJKRlZrTTNzaW5uNlNVekVhR0FLS3AwRTlITytPaUdO?=
 =?utf-8?B?TnR5WWpBSGxvcENqZnlrVEZON0R3VSsrUlMrMWlDTWJ0ejh6S3ZtRzN2cmlT?=
 =?utf-8?B?TnJQcTR0QU5uR3RkUnltNVp5STZmbll1bFpXYmg5b3lDVU1KZ2RqeVFacC9Y?=
 =?utf-8?B?alVjckdPWFU3dEhqUzVHQlJCckpxb3hCeEw1NUJZRmlBU1B6WThFcHRmcFF2?=
 =?utf-8?B?cm96N2ZZSWJsR2MxZHYxa2xwdlp0REg0WGNlZEpURERqM05Nc0VPekl5TUVz?=
 =?utf-8?B?cUxYRXdqUGM2RllrbnFGQTFCaWx1blVobFQ4QU9QQUN3clczWC85aVhsdm5p?=
 =?utf-8?B?VXNUNnVMTllxdUZ3R1JQSlJ5WmV5SENwanVEZjYvMVJGWVRzZmFXVGJ5UzZK?=
 =?utf-8?B?NVNmaFoxT1Zab0NFRXVJS1FkYXl0RGtwdC9rajk0MGhyNGxUWEROUVlaMXZD?=
 =?utf-8?B?R25aRE9iM3NwTU5oTjJ6aVBuSyt1M1F2cTNuVE9hRklNZFp2c0RhbWhpK0lk?=
 =?utf-8?B?bnovYUdYcnk0SE8xbUpXbFhFTWtVblB6MUl1UXFuazhmZWFMU1A4NHM4Y0pj?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de4dccc-2baf-46e5-3a5e-08dc2e2ea8c6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 14:01:51.5580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujKjsrWWrDdotLjWycUYSufDl8Fwf7vxKYDBcq3g1uwu+hyohoVhLbT1VfBaE76sJ4jLtATbUtJW3NtjYrqalDzP3Ksl02bLDPK74RrYanc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5986
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

Hi Heinrich,

thanks for your comments. I fixed all these issues in v4.

On 15.02.24 14:53, Heinrich Schuchardt wrote:
> On 15.02.24 2:35 PM, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Describe how to build and boot for the Sielaff i.MX6 Solo board.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Changes in v3:
>> * include docs in upper-level index
>>
>> Changes in v2:
>> * none
>> ---
>>   doc/board/index.rst                  |  1 +
>>   doc/board/sielaff/imx6dl-sielaff.rst | 32 ++++++++++++++++++++++++++++
>>   doc/board/sielaff/index.rst          |  9 ++++++++
>>   3 files changed, 42 insertions(+)
>>   create mode 100644 doc/board/sielaff/imx6dl-sielaff.rst
>>   create mode 100644 doc/board/sielaff/index.rst
>>
>> diff --git a/doc/board/index.rst b/doc/board/index.rst
>> index d0f9f355d2e..62357c99388 100644
>> --- a/doc/board/index.rst
>> +++ b/doc/board/index.rst
>> @@ -42,6 +42,7 @@ Board-specific doc
>>      renesas/index
>>      rockchip/index
>>      samsung/index
>> +   sielaff/index
>>      siemens/index
>>      sifive/index
>>      sipeed/index
>> diff --git a/doc/board/sielaff/imx6dl-sielaff.rst
>> b/doc/board/sielaff/imx6dl-sielaff.rst
>> new file mode 100644
>> index 00000000000..24dd67ccaef
>> --- /dev/null
>> +++ b/doc/board/sielaff/imx6dl-sielaff.rst
>> @@ -0,0 +1,32 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +Sielaff i.MX6 Solo Board
>> +========================
>> +
>> +The Sielaff i.MX6 Solo board is a control and HMI board for vending
>> +machines.
> 
> Thank you for providing the build instruction.
> 
> I had to look up the abbreviation:
> 
> %s/HMI/Human Machine Interface (HMI)/
> 
>> +
>> +Quick Start
>> +-----------
>> +
>> +- Build U-Boot
>> +- Boot
> 
> These lines are not needed. We have a navigation tree on the left side
> of the generated HTML page.
> 
>> +
>> +Build U-Boot
>> +^^^^^^^^^^^^
>> +
>> +.. code-block:: bash
>> +
>> +   $ make imx6dl_sielaff_defconfig
>> +   $ make CROSS_COMPILE=arm-none-linux-gnueabihf-
> 
> U-Boot does not use floats.
> 
> make CROSS_COMPILE=arm-linux-gnueabi-
> 
>> +
>> +Burn the flash.bin to SD card at an offset of 1 KiB:
> 
> Copy the flash.bin file to an SD card at an offset of 1 KiB:
> 
>> +
>> +.. code-block:: bash
>> +
>> +   $ dd if=flash.bin of=/dev/sd[x] bs=1K seek=1 conv=notrunc
> 
> Please, remove '$ '. It makes copy and paste more difficult.
> Anyway $ is the wrong prompt. Only root can use dd.
> If you really want a prompt, use:
> 
> .. prompt:: bash #
> 
> conv=notrunc has no effect on SD-cards but is needed when copying to an
> image file.

Thanks
Frieder
