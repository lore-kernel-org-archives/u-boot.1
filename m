Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D64DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3FB584C2F;
	Mon, 13 Jul 2026 15:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="odo1Kid/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECDB384C33; Mon, 13 Jul 2026 15:52:39 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 042CD84AE6
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qz24HtbsyrPTH6NsLW/XAXglVUmsiSLJ99q3YHJ/MpF6Vjdl7bU1VCSaF4wPqgrn+6uv5Ig2ujVM6F/JJQQ7yEHAV/uowJYYsvldF5poMaIiT5Ab4BrsbMr/3yJNNX8hpUCI+jQgMzBBWRaBw1PVJzkegVKYCuZVk86WYNiU/qNKJDStkhERRQXbR8DmMJ6kcTEuxoDB45zdSKMl+2cn4K/M1d7+K1H+brWOCr4st3FBMOc8LoP1ERVjF0NlVJB6QbeNxCfyCcbnUoySkEQQ1V1/AC3dTutrnYQvODv/pZDzYR356piZcF+3ekaxDE4zWdILcz6Yln0xxITDsEkUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc/1GBIyvBaS7mWIMeKSVSGc8Rq/al9uGNuwd6gwNiM=;
 b=Ctmr3Mtn5yMVWE5kMiGuVgZmZfGZZeIgCe/cHprgfx+CwzuKYP4mcYzcIFElGOu/wGepguHGky6v/n8VXiAAFiuMLlezBUCJGqXssbce98czyCS46fj91RXGb2X9Zdx3OypW+xh57dlDJMF7XUwQi3aTHoJrq7kD3RyG+l9Do7XO1axAhizFyjfhS4k61xKC7IlPj7zB0PC4CIR3oa+NH+3Rl0Rli/udyLhEUH7MtQTVuRLIEo+9gnPnSuKx67Ij1TU6OxlLmOdHr6oGRoBPx8kDeeF1zoK4iI6wts6/uaMGZlN7Hk9KYLHG0qz+yU8Fsvd5Q5DamGEzBdA655THRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc/1GBIyvBaS7mWIMeKSVSGc8Rq/al9uGNuwd6gwNiM=;
 b=odo1Kid/DooB5VpMVgLSIk5n+W5lSMRsx2mz2Hgk2mwYPiTVrXZk/+VcV6trB8hiccUDCp+nGxDWVwExdyy7vU4H9u9fv/KZ9TTnRvkWYmmkqFq3t1WYWP4KO+GbSbsfS7iqXuCGcwPFLHqzqH+bSxBJDRbn1wQm/iIV9legy/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:52:28 +0000
Received: from PH7PR12MB7380.namprd12.prod.outlook.com
 ([fe80::28ed:346e:a324:acd1]) by PH7PR12MB7380.namprd12.prod.outlook.com
 ([fe80::28ed:346e:a324:acd1%6]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 13:52:27 +0000
Message-ID: <6051fd86-9f84-4a43-9788-1fa07510c4c0@amd.com>
Date: Mon, 13 Jul 2026 19:22:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] mtd: rawnand: zynq: Fixes and software ECC support
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
References: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
 <af5b229e-0466-45cf-9562-434dc0fa383f@amd.com>
 <6a9f0530-ea41-491b-b4f4-f7d03ee2fd3a@amd.com>
 <b22d644a-6d11-4ac8-9a38-82fd8ce5d5fb@bootlin.com>
Content-Language: en-US
From: "Kumar, Love" <love.kumar@amd.com>
In-Reply-To: <b22d644a-6d11-4ac8-9a38-82fd8ce5d5fb@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0303.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::6) To PH7PR12MB7380.namprd12.prod.outlook.com
 (2603:10b6:510:20f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7380:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: bf89cb4a-5d59-433d-4cd1-08dee0e5f9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|3023799007|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: X/24VsaGp3nYGqD4iLUnLSBew9FHl5OisxzV7/1gi2gd2JH1atce+X9w2ZBJ61904J7U+3Msi7Ba7p7gHyCgJx/WdakbYOedld/KvUTaK2atSAgmX4PSdxvKBrqoDI1i/Y/3JhTQYpQZ3fr1WAEEpqUl+4acaO08HDM5fFdlI0dJhGsWIRSTVda44zNZMYTY5+V+dI47K3iW2aBxre0/yKNNQBIizEypAFKRy+X16Bzdl448PgvCXDLOZCEwBbswHf0Zss6Hpke0usHEFihLUDPcniYeRQBrrGyYZ+hXpKB2v5jOgHKamB3jXr1qpJ5dYn17xkWGXlTYdvQjFNR+3QUZMNJDnrBxeNYpdgPS4a5Ulg2csyI1oFEgl1oC3XGiChVQq4JM0ZtTC/Ic53hrMAKX4PPcOoMu8Tt4xPAnkd2uGmRrN7fwqLvcebR+x8sGp6A76VuKGsbbBq2Gtzf3qgizCUPaeosbo01e4C7aL6tr3BBYwtT+GTQZTrEJHLwPMbdUpCT6m6fZjwDca8vMysQWbmzoZBuWLQIAiXNKKFI1P03F6WHS8HUwLkRt56lFRoRjFrk+PQGwHmSk/5nF7WcoZXgWw7WXVvBURkevI9aQ1RqWgnjsTOrIhBa0kPtmRHJLa9WS/8kj4hknYVdMQOiy5wKwrhckdHhSX4U+OOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7380.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTNxTVpObzlyQUxsM01vRHdYN3JBUFFnMlpZQUxmcnl6TWlXMGkzdldXVjZU?=
 =?utf-8?B?YU50MzRNb1d6dHNzQmJMZmYzc2xVdjJJY0RaNlE5WWhUNzZWWE9CblJnajRL?=
 =?utf-8?B?SEd1NmRmTTdTRUFoKzVzQXkzclVLN0V5WDlzMUFibkZPNytxeDdBeUkxTi9E?=
 =?utf-8?B?UkpncVhzSnJ5a1J3UWkxSmJ1c0FKSmY4U2MvZWpBSXByaHVnUFYwTDdKWWNk?=
 =?utf-8?B?T0ora2x2T2ZvTXFzd1E5c3pHT3Y2MThIM3k4VUNKWkxVR1N3cFVjYXBnL2JE?=
 =?utf-8?B?dWVIYk92cUsycWtVTitNT0lZb3ZBUUgyNkRISmI0bHlMZzcrdmk5WXNyU080?=
 =?utf-8?B?dUVFS3E4Z0hycnoxU210YmFxTTh0NE9rWnRsUlRkeEIzRkNpTDZtMmRzODFQ?=
 =?utf-8?B?UkdHU1JJYlhmNXcyeUxXcm9pdWlkTGN0aCtTcDBpVHJnck9LbE5HbmVuaHZ1?=
 =?utf-8?B?NVRCeG12VDAyNnR1VkNlUnc1WEl4S1M5UHgvK2h1T2dReFZUay8rRU5Ed0JZ?=
 =?utf-8?B?MnpaREo2azdCdnQ1S1lwT3ZpeTFaOHFkRWlCTituTGZkOENGNmoyY016UUZS?=
 =?utf-8?B?bnJGL0dwTWVGYzFyR1pEVUlOUzJLYkNleFhZRkhRWGw3L2hxYVpEMmxnbExw?=
 =?utf-8?B?Y0RESk9UUmpYbWRqRlVjdUZ3T2JmSE9jY0VLWTQ0VEM5ZzVZRFNweE14dGRQ?=
 =?utf-8?B?d0JPZUFvRmlvK0ZQcG55Sjg5NHFGOHlEeUJINmh4dUdtTW4wRG1ZY3pGREFs?=
 =?utf-8?B?dG0rSGdWTktxK0ZSdGxMakJYYUhzRUk1WnpKU3lWQktnM2NrVzgwM3JWMlhL?=
 =?utf-8?B?Tmg0cGIvZ2FqRmx0NHVYRDdxcjVzcHNHSUJPaFB5NkF3bExLa1VTTloyMEFQ?=
 =?utf-8?B?azVwVW14NTZ2VjV0VTdTcXdVWmpiSFFBU2Noa01pbkxZVTVsTDVuOFNyUlY0?=
 =?utf-8?B?eXp6YkloWDZxZ3ZTMGFVZklMWUhTY2RSNkd1WUl1U2lNZWprUUdlOHRkUWt5?=
 =?utf-8?B?ZmxEUWt6SjNJWG93bXdMUmorNkNmUEdZVUZZeWtYQ2l6WlFtU3hzNkVpNGJt?=
 =?utf-8?B?OUpSci9pSU1iYVhDeGNseForSTNmVFdjcXRCWVBmQk5ObzIvM2hUWUI0WGZn?=
 =?utf-8?B?YXhrMHNyZHN0c0toUkRMSzRVc0k2SEF6ekdvN1Z4QVFVRzZ0Rit0RGZrQTlw?=
 =?utf-8?B?YWJCVURwbm11VVpwREVIL3FSLzZyVlhhb3VMeUVlRUpwU3BrdG1hQWpaeE1S?=
 =?utf-8?B?TGFTYlk5OVpKVnZCT3h6TERDVE5PTW5nNEtxR09xdG11b0pwb09qNUN6V2pH?=
 =?utf-8?B?TDVMT0hmUlVHRzVHNFBzSUhLd0tIdnYzWFdXQUFjOFJqTUVFVlVmN3ZNRUhw?=
 =?utf-8?B?dkdPcDBxTi9SMGIwaTAyTDNwTFoyMGIzZlIrdWYyUzFNbUVJK2VtekkySW1B?=
 =?utf-8?B?VVNmQVNTeWM5UWtURTh5MUNuZTIySGRMUFovdm5zVnBvcm9iL2hLeUdOcUwx?=
 =?utf-8?B?UVZFN1NoL20vd2x5VHFOOFNDM05YbGRtNmpaVDhzZXhRZGhPZ3NkWlNCNE5J?=
 =?utf-8?B?bWIzVmJqd0hiRE90bmIxZjVRL2pDYTNNSVRoeGpTMElPckFOc0xWTDVaSXhE?=
 =?utf-8?B?TkpSaUFSTXY4dEFuc1VkcVRqRndQczRQS1B2d1I4RktsVlpDQncxcFRVazV1?=
 =?utf-8?B?ZVcvNXdzTmJEeXhBLzlrMUFJWXZyYWNaM2JIYmpnbm8rVGFwN040RVRNckFR?=
 =?utf-8?B?RHB0d2Rnd0FpQnJTdEZvVklaeFJSTkdYZWVjditCRG5xRkgyM2ZjR0hLZzdW?=
 =?utf-8?B?emIxRkgreXlDVFg0QjRZRDdaV0J1aEZFcXlDazc2N0hPR1FnclNHeGZCcFpm?=
 =?utf-8?B?UFZ2dWNWNldneE54amI4UFViU2FLVXF4cENSeHFSR09Hcjc2VHdZVGFBZ2xT?=
 =?utf-8?B?aHpVdEVCQ2k1ZkdHNHk0Tnh4UnR2bTM5bTd0RDROTHRNSVh6MGxVTVkzb0RH?=
 =?utf-8?B?eGM3SE9zaGVjWjBGWjNJV0QyOC9YMnlKb1lVZGUxemMxdXBwbnNpc1MvZlBD?=
 =?utf-8?B?ZkUwK3hnK2doUUlBYWdnK2p2Mnl1aW55UGpETVgzL2RKSjNCQUxWWDJKcGw1?=
 =?utf-8?B?NWNFNkZBQ2tleVIyK09mdFRTUE9lUmZTWTNvb3BhUjd4ZXJaOE5uWVliWThh?=
 =?utf-8?B?Yk5abFFHUitTdktQbll5STZFb1hpeVVjUWFqdFNLSWprS3pOL3RiK2xSaWRp?=
 =?utf-8?B?VzRMWjRYeW5zRDd1ZGdibnZLNWozVEtHc0dtZ2VnMlhuQW1XeElCQTFndUZD?=
 =?utf-8?Q?APG5MyysT8Xyk00/ka?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf89cb4a-5d59-433d-4cd1-08dee0e5f9a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:52:27.7460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNIuTPThC/nP2VIEL8M+64Q0LJl2sZirwS5dZ6Vg5aJH/ToNRXoqWnbjyWE2qnKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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

Hi Bastien,

On 7/13/2026 3:18 PM, Bastien Curutchet wrote:
> Hi Love,
> 
> On 7/11/26 8:36 AM, Kumar, Love wrote:
>> Hi Michal,
>>
>> On 7/9/2026 11:23 AM, Michal Simek wrote:
>>> Hi Love,
>>>
>>> On 7/2/26 15:08, Bastien Curutchet wrote:
>>>> This driver is deeply broken in many ways. Miquèl has cleaned it up by:
>>>> - flagging the most hideous parts (where Micron on-die ECC support is
>>>>     hardcoded)
>>>> - enabling DT support, eg. for reading the ECC configuration
>>>> - fixing software ECC support
>>>> - aligning the software ECC OOB layout to the rest of the world and
>>>>     allow a working interoperability in Linux.
>>>>
>>>> I then added a patch to fix writes when soft ECC is on.
>>>>
>>>> Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
>>>> Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
>>>> ---
>>>> Changes in v3:
>>>> - Add patch 6 to fix write issues in soft ECC.
>>>> - Link to v2: https://lore.kernel.org/r/20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com
>>>>
>>>> Changes in v2:
>>>> - Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
>>>> - Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com
>>>>
>>>> ---
>>>> Bastien Curutchet (DAVE.eu) (1):
>>>>         mtd: rawnand: nand_base: Don't overwrite read/write_page_raw() for soft ECC
>>>>
>>>> Miquel Raynal (DAVE.eu) (5):
>>>>         mtd: rawnand: zynq: Align the layout structures with the driver namespace
>>>>         mtd: rawnand: zynq: Add comments about very bad practices
>>>>         mtd: rawnand: zynq: Make sure an of node is attached
>>>>         mtd: rawnand: zynq: Do not fail the probe for no reason
>>>>         mtd: rawnand: zynq: Fix Software ECC engine support
>>>>
>>>>    drivers/mtd/nand/raw/nand_base.c |   6 +-
>>>>    drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
>>>>    2 files changed, 32 insertions(+), 89 deletions(-)
>>>> ---
>>>> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
>>>> change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2
>>>>
>>>> Best regards,
>>>
>>> Please test this series.
>>
>> We are again seeing the NAND write issue with zynq-zc770-xm011 board.
>>
>> Below is the log snippet:
>>
>> Zynq> nand write 0x80000 0x0 0x126f80
>> nand write 0x80000 0x0 0x126f80
>> NAND write: device 0 offset 0x0, size 0x126f80
>> NAND write to offset 0 failed -5
>>
> The exact same command works in my setup:
> 
> ```
> Zynq> nand write 0x80000 0x0 0x126f80
> 
> NAND write: device 0 offset 0x0, size 0x126f80
>  1208192 bytes written: OK
> ```
> 
> Can you please share your device-tree / defconfig ? I'd like to dig into this a bit.
> 
> I'd also be interested in seeing the output of 'mtd list' and 'nand info' on your side.

I have used the xilinx_zynq_virt_defconfig with zynq-zc770-xm011 DT.
Below are the log snippets for 'nand info' and 'mtd list' commands:
 
Zynq> nand info
 
Device 0: nand0, sector size 128 KiB
  Page size         2048 b
  OOB size            64 b
  Erase size      131072 b
  ecc strength         0 bits
  ecc step size     2048 b
  subpagesize       2048 b
  options       0x40000000
  bbt options   0x00028000
 
Zynq> mtd list
List of MTD devices:
* nand0
  - type: NAND flash
  - block size: 0x20000 bytes
  - min I/O: 0x800 bytes
  - OOB size: 64 bytes
  - OOB available: 38 bytes
  - 0x000000000000-0x000008000000 : "nand0"
	  - 0x000000000000-0x000001000000 : "nand-fsbl-uboot"
	  - 0x000001000000-0x000003000000 : "nand-linux"
	  - 0x000003000000-0x000003200000 : "nand-rootfs"
Zynq>

Please let me know if you need any additional info.

Regards,
Love Kumar

> 
> 
> Best regards,
> Bastien
> 

