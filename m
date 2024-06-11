Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB00C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 15:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E9D880A3;
	Tue, 11 Jun 2024 17:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hj25l7jI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751B788655; Tue, 11 Jun 2024 17:41:26 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2602::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B62880A3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 17:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHfnx/NdUqDgAoXw7hsBINXVgh+dTjulYIg8vrj376+QiFnQN9PDlozyTcaqa6ADnomLwjD2tpYfkdwT2ZPL9O0puRGvl/DEbPcDvA9ciwjkHbaBQws6zdrJJULHXQR/v1aTMxD7G9boFkc08dp/8NJjYM6jOq85QUvni2uFxdqhCpqjeU2drYPOn0HBG525k3Irio1aVPwW+27exONPlHOm0eruPhkAr2+tJaRJHuZqE9g3hPs1E8fkqxzzVe/PUhANATSfYza76JeYara+ixHpmW79vkm9fjpft7vL1siRCMie8+YqLbDLuFZVJEp4E0/YHNvNwFDLpT8uqg6Kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P1zKZ/of43No1PsgqwcZWypPogAOkIU/Pa6Ujbza4c=;
 b=UoF7Sit8zkQKMIC3r+Intjx0X0ZI8aOBNCgdOAlmS5fFXUhFZV9I3r2fe7zcydnBe8SuTf4w0ZkDdlt7rsABDpeImxseJ+C7f7+DE36OFoTXgcoermNiqCkHjjZkhQ6Okd1HI//Qsc03QuIzG4ioM78+LJtOtV6FOxup7ZSJF7Soyl+jBon0QyHuMWRZGYvqm1a3UgfHkj8AVXMOJHqOnkDIMgOg7lrQocM5Yt/wWbRIfBsKHC9ERh4+3RM+IHXUedNu6ZCadPQWI3BU3l07olUZMxCcTk8OKTW8fLHz5wW3OYxEiu0zKT35mlsr701hKOSPDG5m+R/uIx9iXy69pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P1zKZ/of43No1PsgqwcZWypPogAOkIU/Pa6Ujbza4c=;
 b=hj25l7jIe964K11cfeOAfDq+qulJxz9Bj5QKlsOp6RpLcyfdgUKaot5QJYloWrktUnwMTJ4mf6/9J06tekH4uOO70I1CgvL7DCeMzYKaCS5fXrBl/EqwYk2k4Mf8X9IftLqkA+xEVxQ0c3Csvly8xs14Wdzx+dpjDkHAXajdN2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA1PR04MB10398.eurprd04.prod.outlook.com (2603:10a6:102:44d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 15:41:17 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 15:41:22 +0000
Message-ID: <374a3eee-e24c-4acd-abc3-f69f628a285a@cherry.de>
Date: Tue, 11 Jun 2024 17:41:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: trini@konsulko.com, hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch, 
 u-boot@lists.denx.de
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
 <34fcbe3d-f361-4671-8d27-e02f9a5dce9c@cherry.de>
 <20240611152733.GA441859@vamoiridPC>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240611152733.GA441859@vamoiridPC>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA1PR04MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f8842a-31ad-4b47-45a4-08dc8a2cf1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGdwRmxRc2hpZko0bUEvVnlzblUvV3Fyd2laSTd6ZEROZHp4d0VSNVByYkRr?=
 =?utf-8?B?b3ZMWkVTNjkrQWNMUUh5OFQrNlJiTC9BMHo0ZjBCTGk4TzRtRDdEM215UFdw?=
 =?utf-8?B?SE9CdHJYMFNHdzFsVm5sSnZKQ2h6ZUpXRUdwRWdUQXdmR0tjYU5vSDU2QWdD?=
 =?utf-8?B?VHZBVHRaelF3OEhiSEl4ZktMTUZjR3RpSHVWY1ZBWVVLampKNm9oeHdjU04z?=
 =?utf-8?B?a3Z1dElHMDBjRFBZaEVjSjlBVVdycEp0N0VFOTdIOHNTclhERlpldlF2aU5p?=
 =?utf-8?B?a0FPUkFxOE5CZ3R4MlZseWlrODVQZE9NWWQ5NG1taW5GZ3YzZVAyb3pyRkh5?=
 =?utf-8?B?bEt2ajdKdDlLRWVxMkVCZW16azl5MXVmK0J4RFZ3UG9LWk8zdEp4ak9DYmlB?=
 =?utf-8?B?RUszZFM1TDhjL3Z0V09QWFVPSUhla3NnNWJlSnJ0TjlaL0ExbUdwdEhmOVkx?=
 =?utf-8?B?eE1OUTBUM1piT25RSXZzbmc3VkFqZi81bGxNV0hOMjFaQ2pKQXVwTmoxZjJ3?=
 =?utf-8?B?Z09xOWVvTERtT0liSVNybHNFc3NDT2dDYStPcURXelZuc25keCtURE5UZnlj?=
 =?utf-8?B?ZXdFbHU2Qktack1tRHdOQzdMRFNLMzExc3lzRXdieXFKNWl2TmRxY09jZE10?=
 =?utf-8?B?SlQwZ2x0blJNajJ6VWswNmt5enFKRWIvU2FVY3ZZS2taQ0xDamZCSWpEdllO?=
 =?utf-8?B?R1d6L1UwVUN1bDlHdXdrcjU2K2wxR3NLYTlkR0FTSjFrR2gxUGVDS0FtZXZZ?=
 =?utf-8?B?ZzJlVXE2Z0JNNk9FbG01YUNLdWZFVWQ3WmZDMEh1MktrNUwxUDJmbk5sMk1B?=
 =?utf-8?B?S0dZc1JZZ29PWmV1bkVRL01MejFYMEh4b3ZoVDhtREtyMDNvaiszTmprMVY0?=
 =?utf-8?B?OGJIRUUvbzdBa3JObG5pdXlyUTBZMzhIUzJjYytkM0N2UGoxN1MwNzFiOWRx?=
 =?utf-8?B?d1JYWkUrQTNVM0EvVlJwQzZuZHBKN1VmUFk2UnczTUQySVpxZVhlVUhHazU1?=
 =?utf-8?B?azRPVlhNa3pMWGdpenZnMXlWSlg2TWJQOFJnZjhsRkZHM3l2ZllzRm5mdkNl?=
 =?utf-8?B?QnpiTFpDUER1RVJoLzdnYkl1d09qN3ZDalNjd0p2Rm9TQkwwckpidmI2OEZF?=
 =?utf-8?B?N083MjBkMHczMk1UNXZCZlBLSzhqS1NWaHI0cHgyUU01Y0t0Q0xSd1VUZVdw?=
 =?utf-8?B?SFcwUkpTZ0ZTL085RmxiWkhZcXVaaFNEQlBLeE1DQ3hKd2pRL1pSVW55YUFr?=
 =?utf-8?B?ZVh0VmhXWmdWdEJ6YmZrMGFodHE5QkNiMFluZFFSbms5Znk2ZEZWa2lyb0li?=
 =?utf-8?B?THpLYVRETlRRVFV0eDJrTWlPMEVnK1NCQTYxMUo5VU9vWmZzaGpGc04vUFl3?=
 =?utf-8?B?b21RRHdENXg0MktuTytQQmN0RDkrM0ZmcW8vRlE4ZjB0K2NXcnVrOElRdEVl?=
 =?utf-8?B?cEFYbzUzS2lMN3dPNHdsT3pFTDA3L2JCOTBlTEpVS3MrUDB6L016MWk0SU0y?=
 =?utf-8?B?ZXk5ZWdrQmpuVytjd3BFWi9FR21RbjYrdER4UzBTSTI5bCt4WDFNZHk2eS9s?=
 =?utf-8?B?RTcyNGs3Z2VGNmNUUDZLd1lvVzVIRkRDdFBqTE9xRi9LUjZUTExCNHo0eElE?=
 =?utf-8?B?Rm5vdXZFTkFwSjQ2R0Vqa2NmaUc0L2NOa2xwOVljMFU1NUwxaTZ2VGtxMHJ0?=
 =?utf-8?B?dG1YTjB5UkFwVHRIVk9LVFR2STE1WS9CWEpKVmk3UDNZeVdyY0xhNHJUZTZW?=
 =?utf-8?Q?Bo+a0fTnkMI9815DzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230032)(376006)(366008)(1800799016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJKSE5jRlJWY0dKTHdFQlV6NEw3ODJVREEwS2VsWUppV3Y1UjBva1lsaUpj?=
 =?utf-8?B?eTUzNUUvaWtxSzFxMllMVGVubmhxNS90NEJ2QkRBNGhKWGppTHY5WjgxLzhy?=
 =?utf-8?B?bm55NjZHVVY2blFia2VJY2xoQzlOT29EVXMyR3RiRGJaS01aaG5TL2h3M0p0?=
 =?utf-8?B?Z1NZMTU5bG9KemxnWUVIWUlwaFpGbElOUTk0ajJUbGl5TG9XTzNJSlBBMCtQ?=
 =?utf-8?B?c0dGbmxGS082enJXMkZ0RHVFY2EvMDJnckp6U1dISUZvQk5FcW1xTzAxbTQ0?=
 =?utf-8?B?enFMeDBUOTBvblJTSnU5cXMwRFltT1lmMGhIbUF6cUEwY282UEUxQUwzbG5i?=
 =?utf-8?B?M1JvU1lYajNrd05nTWJidGRZUjZsaVFWMVlYMFhIYWR6U1VYN0MyS0dpdEdV?=
 =?utf-8?B?SG1jcHhGZDdKWEFQR1IxUEw5My9aak9jZEFiR1BIWGg5c2VWdDI4WVNzRnFY?=
 =?utf-8?B?cUJIQ3c0VDEyUEJML203aE1hUXpzZEVSSWx1TlNlQTFRb2ZkaER0dXcySDR5?=
 =?utf-8?B?a3VHMys5Rk5jTzBDbWNETGZ6QlVVSmhhbURrUWU3SWJjRXVJUjlxU3E3cy91?=
 =?utf-8?B?MEkvNjNjK2xwdlNudlVlRG5RRUNzSk5ZTWJ4YWpqeTFQNTkwSWNzOUYrOGV6?=
 =?utf-8?B?S0dEUU9sZGs4V3ZrU0RFTmZmeHVhZUZsQ2hTbi9kUmxTenp0M1FXTm1TV0VM?=
 =?utf-8?B?NlJNbXczV2t0NjRJQ1lrV241YldjeGZ3a0ZwY0huYmxwUCs3bjI1MFFLaVhn?=
 =?utf-8?B?d0UxZXpnZEpUakR1Y1ZDbDBOc29BUVBCR1dvNnM5UDJYMnpjdEV3ajNFWmh2?=
 =?utf-8?B?MVljUWJ1djAyTWFUdngrUjUvVDJlVzBqaTRZcGZnZEpaNWRYeStMbm4yb05I?=
 =?utf-8?B?d2lXUHg5SXQxa3QyY3EwSFgzZisvWmhuK1AxL2ZCSkNhdzA3VkVBbEpsbk0w?=
 =?utf-8?B?ZTVVbEdTelNLU21OU1pMTXVNZEh4dWYzc2VZVVQxUDFiaUtGeDJYUnRWNmpp?=
 =?utf-8?B?ZDJaZEwrejltNGljeEErV2sxeGpla3Evc1Z3dldHMndOekQxaFRHVFN3ZkR3?=
 =?utf-8?B?dGs3b25VWFpPN3QveXdYTklFZ1lnVFhNbDFLc1l0K3ljakxkZjZ6Z2JtTWVk?=
 =?utf-8?B?SUlpeHpSZG03eGdrU2I0K0FOSXFJMkI0V0lJWHRrNjlNVzQzNjN6ZlFLVkNt?=
 =?utf-8?B?RTdQQ1JLbktsZFJWOEdFVFk2WllzazNBQ0ZyVDNybTMxWWZ0eUNyY29vTFQ2?=
 =?utf-8?B?TmtIZWdVd1EremprN0dWNWZ1aVNkaEtERUV6MFpKVDZkRjdiS3lJOXRkQW5p?=
 =?utf-8?B?bWw3TlRzTEpMZTNkeTNteUZ2QzRtS1hUcnNxVWJIcCtiejFCWkdRQkxOSzJE?=
 =?utf-8?B?bjhTSWFVaGxuVTZENndGT1RuWW5wTEs5OG9Tci9XVjNqb0FSeEgwbEV1cldr?=
 =?utf-8?B?dWZxclNadFk3Mit4elpQL2o1RUI1aTFTRERQM1A3bDhRUmozYTZVdkdlVS8w?=
 =?utf-8?B?eXBjaGRYTEdzRGdmbHBEdzZSY290MTBEaStXOC9lZlk3SDIzTHBWSUFQVDgy?=
 =?utf-8?B?Z0hlakFJajdySjk0TkZpMVdsUDF2OFU1eG96RE5kZnZsUDcraStaLzlpN3Zv?=
 =?utf-8?B?dGo5M1EwNDBxeGI4bU1VRkJuQVVrTE5jVWxUQk9rVXplcCs0YzRJbE9HR3da?=
 =?utf-8?B?dDB6S1hzZzEzVTdSajZkNkx4ekNuOEcwMFd6OWJ3aExVeHpUWGEzeFpISUZp?=
 =?utf-8?B?UTlraXovWkNuaTlWa1dENnJHYmh5aHlZVlZBVE1YZDY0alJNUVROT1FmL2NV?=
 =?utf-8?B?NEpIUTZBUndKZ3diWmRxYVVyeHEyd1UrMmRSdlhITEpKekZCazcrUkZldUJC?=
 =?utf-8?B?UUNqK1FFUHZwR1ZTdE90ZngxNDFnRS9FZ0tNQmRYcmJLT0VldUc1ZURLNVZ3?=
 =?utf-8?B?NVl0U1cwYitwajVpYzduR1E2dkhyVVFVRnFxOUVzdU1GVEoyeHJKMlJvWW9L?=
 =?utf-8?B?TDZsSlpUL0FpMnhWT29lLzZSc3JPYllLR0cwTnZqaXgzRGNxSy9ya2ZlMzFB?=
 =?utf-8?B?aEtPejY4TUZBR0ZxaFpTWkRYT0pkZEN3RXVPZ2xGNXVMRnprMjhIT2x1RkRM?=
 =?utf-8?B?aUdRZnVYQ1p2MGg4OTJQTEFXc3lCb0wyaGZtVkh3Y3p4VVhKbFJmd092dGV2?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f8842a-31ad-4b47-45a4-08dc8a2cf1ca
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 15:41:22.0772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGPFltFPUFNtUv0Bs5G/MOqo7+tjOVeksBAbu35tuM5Gn+MmHnFQcfHRyzzUVYsihrQd2IhOLSwnBCv+5R49Tg95xtM1Q9cqo1lH1gZjak4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10398
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

Hi Vasileios,

On 6/11/24 5:27 PM, Vasileios Amoiridis wrote:
> On Tue, Jun 11, 2024 at 11:33:12AM +0200, Quentin Schulz wrote:
>> Hi Vasileios,
>>
>> On 6/10/24 8:51 PM, Vasileios Amoiridis wrote:
>>> Add support to save boot count variable in a file in a FAT filesystem.
>>>
>>> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
>>> ---
>>>    doc/README.bootcount                          | 12 ++---
>>>    drivers/bootcount/Kconfig                     | 53 +++++++++++++------
>>>    drivers/bootcount/Makefile                    |  2 +-
>>>    .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++---
>>>    4 files changed, 50 insertions(+), 29 deletions(-)
>>>    rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)
>>>
>>> diff --git a/doc/README.bootcount b/doc/README.bootcount
>>> index f6c5f82f..0f4ffb68 100644
>>> --- a/doc/README.bootcount
>>> +++ b/doc/README.bootcount
>>> @@ -23,15 +23,15 @@ It is the responsibility of some application code
>> (typically a Linux
>>>    application) to reset the variable "bootcount" to 0 when the system
>> booted
>>>    successfully, thus allowing for more boot cycles.
>>>
>>> -CONFIG_BOOTCOUNT_EXT
>>> +CONFIG_BOOTCOUNT_FS
>>>    --------------------
>>>
>>> -This adds support for maintaining boot count in a file on an EXT
>> filesystem.
>>> -The file to use is defined by:
>>> +This adds support for maintaining boot count in a file on a filesystem.
>>> +Supported filesystems are FAT and EXT. The file to use is defined by:
>>>
>>> -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
>>> -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
>>> -CONFIG_SYS_BOOTCOUNT_EXT_NAME
>>> +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
>>> +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
>>> +CONFIG_SYS_BOOTCOUNT_FS_NAME
>>>
>>>    The format of the file is:
>>>
>>> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
>>> index 3c56253b..d3679eb5 100644
>>> --- a/drivers/bootcount/Kconfig
>>> +++ b/drivers/bootcount/Kconfig
>>> @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
>>>    	    Set to the address where the bootcount and bootcount magic
>>>    	    will be stored.
>>>
>>> -config BOOTCOUNT_EXT
>>> -	bool "Boot counter on EXT filesystem"
>>> -	depends on FS_EXT4
>>> -	select EXT4_WRITE
>>> +config BOOTCOUNT_FS
>>> +	bool "Boot counter on a filesystem"
>>> +	depends on FS_EXT4 || FS_FAT
>> Do we really need this 'depends on' here? Especially if we have a choice
>> below...
>>
> Well, probably this is redundant indeed.
> 
>>>    	help
>>>    	  Add support for maintaining boot count in a file on an EXT
>> The help text is still mentioning EXT here.
>>
> 
> Ahh, I missed that.
> 
>> I would recommend removing it, or listing the supported filesystems at the
>> moment. While I assume you tested with FAT, I assume that with FS_ANY, any
>> FS should be supported?
>>
> 
> Well, I tested it with both FAT and EXT4 and it works. AFAIU, due to the
> implementation of the filesystem handling code in U-Boot, if the fs supports
> a write a function, then it should work. But I cannot test for other
> filesystems apart from FAT and EXT4 so I think it's better to limit the
> option to these two.
> 

I guess we can let people figure things out themselves and add new 
options for when they have tested them, no strong opinion here.

>>>    	  filesystem.
>>> @@ -184,26 +183,48 @@ config SYS_BOOTCOUNT_SINGLEWORD
>>>    	  This option enables packing boot count magic value and boot count
>>>    	  into single word (32 bits).
>>>
>>> -config SYS_BOOTCOUNT_EXT_INTERFACE
>>> -	string "Interface on which to find boot counter EXT filesystem"
>>> +if BOOTCOUNT_FS
>>> +choice
>>> +	prompt "Filesystem type"
>>> +	default BOOTCOUNT_EXT
>>> +
>>> +config BOOTCOUNT_EXT
>>> +	bool "Boot counter on EXT filesystem"
>>> +	depends on FS_EXT4
>>> +	select EXT4_WRITE
>>> +	help
>>> +	  Add support for maintaing boot counter in a file on EXT filesystem"
>>> +
>>> +config BOOTCOUNT_FAT
>>> +	bool "Boot counter on FAT filesystem"
>>> +	depends on FS_FAT
>>> +	select FAT_WRITE
>>> +	help
>>> +	  Add support for maintaing boot counter in a file on FAT filesystem"
>>> +

Seems like I missed a typo here as well:

s/maintaing/maintaining/ ? At least that's what we have in 
doc/README.bootcount

>>> +endchoice
>>> +endif
>>> +
>> Since we now support FS_ANY, do we really need this choice at all?
>>
>> Alternatively, should it **really** be a choice and not just a bunch of
>> configs that depends on BOOTCOUNT_FS + whatever's needed to write on that FS
>> instead? I think we could have both BOOTCOUNT_EXT and BOOTCOUNT_FAT set
>> without issue?
>>
>> Cheers,
>> Quentin
> 
> Well, I think I kind of get the point but I am still a bit confused.
> Do you mean that basically the configuration should be done the other way
> around? Instead of choosing BOOTCOUNT_FS and then specifically to choose
> EXT or FAT, to choose one of EXT/FAT and then to select BOOTCOUNT_FS?
> If yes, what is the advantage of this approach?
> 

I'm suggesting:

"""
config BOOTCOUNT_FS
	bool "Boot counter on a filesystem"
  	help

config BOOTCOUNT_EXT
	bool "Boot counter on EXT filesystem"
         default y
	depends on BOOTCOUNT_FS
	depends on FS_EXT4
	select EXT4_WRITE
	help
	  Add support for maintaing boot counter in a file on EXT filesystem"

config BOOTCOUNT_FAT
	bool "Boot counter on FAT filesystem"
	depends on BOOTCOUNT_FS
	depends on FS_FAT
	select FAT_WRITE
	help
	  Add support for maintaing boot counter in a file on FAT filesystem"
"""

This way we can have defconfigs where BOOTCOUNT_FAT and BOOTCOUNT_EXT 
are both selected, the user would then be free to decide if the same 
partition on two different devices but for the same purpose can be 
either ext2/3/4 or FAT, without recompiling U-Boot just for that.

However, it would now be possible to have BOOTCOUNT_FS=y but neither 
BOOTCOUNT_EXT nor BOOTCOUNT_FAT set to y (e.g. if FS_EXT4 or FS_FAT 
isn't defined).

Finally, the other option was just to NOT have BOOTCOUNT_FAT or 
BOOTCOUNT_EXT and let people select FS_EXT4/FS_FAT and 
EXT4_WRITE/FAT_WRITE themselves since the BOOTCOUNT_FAT/EXT aren't 
actually used in C code. This is less user-friendly though.

Cheers,
Quentin
