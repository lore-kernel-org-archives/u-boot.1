Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E497ACE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 19:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8469E869AC;
	Tue, 19 Sep 2023 21:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="lSXXU4F4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 701808073D; Tue, 19 Sep 2023 21:15:47 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0719.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26579869AC
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 21:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXGSKu/8VTeNlZCceFMvltfczi8OAHDfwCbkQW6vPApOIfRHc8zEyXsDvmfe3V9KSfUYMoECT1wp/7dheRoYUOqZdOyHwCci1v36kn4kCRJIZXOp9Byq/u6FNzlSTv7yjL+JCGqyZoXpqk/gDkabnggx3j0vkvfmaD3Ps4jqWNh02tJnTRa/yckJuk0rWhobJdReS+OzKM7K/LwMSpD8qFPT6iEtp2QgkZPUzMGejKiKWjHF4ijLjx1//d3sIOPZ+VYxLid1HEuVMeiY6pfJxr+tuPMtTfqhfDXZ3pjpQqZkTsEPsG4sH9jUF9By/2loJyCQ+R/QS+0BDXgIXLaq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U5KtK2E1BJ6X6Xwg5mv/EI6jzfKJVU/YSoYaQX21wE=;
 b=XdyBwReFvEvYo2Q/ZSRpCXNlBSVykyG54mi/xxGGDv5neJgtrm0QBLMTZu1mMiJFFZWw7yNz+LyG3nlFLk+F+FZVbVT9n+mlVT62LSK6XOnaKmPzV9I3xu4qTuo44d2yb2GpQ58iwC2XUFt6ThELRHh+f/0miENbkmudKg2KTPe9wWaEmxaCIPsSejmHls9fJzBkEHL67/AIEjuuoi2oYIkWnppkfpvRuLsss7qsNNGS4dAesXumvt4fSdZdjHpXhGHzaCUCIzgMYvcAWt9EkX1sThm4RiTV6rKBKLOeMbaGc/kKACj8+9q3n5Ms7OzHmgulDEq1rILPgfTtKtBMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U5KtK2E1BJ6X6Xwg5mv/EI6jzfKJVU/YSoYaQX21wE=;
 b=lSXXU4F4d7PDrdMo35AojeddwI8aALP1srNenctdWDEw6XJXmvnnYJSWwK89f2t/TgGIcHKKLRspYAVbhTJSieDcBlZwrLCRydKjqB6dS8fO5Hi+VMRxAvNu1qVtjMQbtW/ZtHiwInhedSPsJ5IGtb3kqDzqk9pkhV34Su2cokc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAXPR10MB5325.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 19:15:41 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 19:15:41 +0000
Message-ID: <2c318328-2acf-cfd1-55e3-2074eda28929@prevas.dk>
Date: Tue, 19 Sep 2023 21:15:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mx8m: csf.sh: pad csf blob for u-boot.itb to CSF_SIZE
 minus IVT header
Content-Language: en-US, da
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 uboot-imx@nxp.com
References: <20230919100017.43523-1-rasmus.villemoes@prevas.dk>
 <ccce016d-3756-fae1-e074-70d94a9f8f6e@denx.de>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <ccce016d-3756-fae1-e074-70d94a9f8f6e@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAXPR10MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 098e7eb0-1714-4616-558a-08dbb944d0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUf5WlzfTq2962YgzvulSTD0SDBk1JraS8Q4koVPXg7Z8WygsdkaAj7TQrB8Say7eNp/rIEr60mQxeHLZ7EzcvTv71J6KUyntr3RbPGZDZ2yJOmzZEBRr8HRJVllbmTVzDPIuY9WD4PEQ9mi1bKp3S42TsD1/pns4tquOG+vO8fcSxPCwncBnZRtZi8xR9N/xN2c+tJMRfWVNhV16Cz/uHX2W82eZH7jDUHk3VbrkbskyAm+kIUeszLx9KY3z6Tgyv9xK3xP4lWNtncPS3ZRJEF6wYKJTpSZuEu12EC/D4KbCvkGHZvZOSi+uOltN1mlPjGsNDzjDAdJWhuK2tmLBL5XaDBWJstlfd0HxYhMCkXv6xQrPl2CYQX2I8u0idt4h3JGYlSgnAeY9pKledxWjsdlgtdIWXH0/FA34TiBNPGKbY7X2qWmDYQ2npIdbLQc7MIg9hmX+R7ntBh7+wbzDdivKJhiT1SZ92Kxw0q19pPZndXmmr9cAxFlFrHz99ppifR5OgHMUqUKg0SUudR4BIC7Z8zveZAecSvF97vPX4wzsx9MTsFxNKA6r+VXSnq92pT6bKNYIwnhUOxQKgr870u95yg0GDDfv0EHr8AJywYVTEpD7azXsDrxpfd+VPyh84OcQmAsQyRRhTtNuAbNOHnDKGEj6eq/GyywYVohzHD6afJmizVAf9cWoDSwgMbG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39840400004)(396003)(366004)(451199024)(186009)(1800799009)(31686004)(966005)(86362001)(36756003)(26005)(53546011)(2616005)(6512007)(478600001)(66556008)(66476007)(31696002)(6486002)(316002)(83380400001)(52116002)(66946007)(54906003)(5660300002)(38350700002)(4326008)(38100700002)(2906002)(8676002)(41300700001)(6506007)(44832011)(8976002)(8936002)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ry9QeXJ6TEVrNGdUa09BOEF6UGxsVkFDWHZBMVQxVnZ1Qk51QUI1b01rM1hZ?=
 =?utf-8?B?amdhVksxNDRMUGVJUzNsdnlraTBFend0YnR3K29FNjV0Q3pnbUxWU1pzTy85?=
 =?utf-8?B?TWhCR1RRVE9CV2JWVWMvc3NaR0lrK2U4L1I4VVVOUE5tVDRxR3FETlJQejVO?=
 =?utf-8?B?U0J5bFVIQXZRZm00cFdja3JCeHhYeUZGYmNGZkt3dWt3UlpGeHFLNENwbzli?=
 =?utf-8?B?ZzU5YWN3cHZYcHlWRytFdURUSnlrSytqSEVuejdab2dnd1QrSFFtelkrK0xz?=
 =?utf-8?B?UHhxbXBhT1hzR3NIWjVvYVlmSDNIcUFkNUVOQ28wV2RyOHBEdm5VajJWZGtW?=
 =?utf-8?B?YVlsMk1QM3hxOEVOeDZSZ1dxa0RHdFlLRWdjb3kvcFE1Q1VvMnAyUVBIZ3Rt?=
 =?utf-8?B?NXRnQ2U0K1laeFhBdE55WUswQk5YT24vZWh3T01XWDhuWWJidTdiOUx3bE5Y?=
 =?utf-8?B?bXRFNWdwNTNPd25FSVZqR3ArVkljTUhVREdLbWpTTmUvSXgxYXo1MHFLdFFE?=
 =?utf-8?B?bnBLck9GZy9PdzN4cnVWVi9jb2trOGkwRk1uRi95NjlCR3ZQY2k3VFlWR3Jw?=
 =?utf-8?B?a1ltVFZlVExLd3NPMWo5bVl3QjVxbzhSMVMxWUtvejB3eWluSlE5YTBpYUV2?=
 =?utf-8?B?M3pZWDFXWFQ0QmJoWnlTNjVpUFh3dk5MMlV4Z0tTK3VVZG00eFZmYUxtTHNw?=
 =?utf-8?B?V0VDQW1ldkVacXdrdXBSYkJTOVJob3B1R0NrK0JYenFlM0w1MjcrT1ZMeGQx?=
 =?utf-8?B?VWlDVlZobTVua2QvVUdaejJzUG43NW8zVXdiZGxpYWNLMG45Q2xQdmd4WGhr?=
 =?utf-8?B?bGNhSExJZXM5UDJhNExYNmo3SlpnVG11RC9pZklBbGxrU2gyaEFlTGZnaG5J?=
 =?utf-8?B?aVJwSncrbHF2S2pyZjZJZ3pwRWY1eG5XLzh4a2ROSlRGcVc5ZUovTjdkNm16?=
 =?utf-8?B?M0VyTDNXeFNMQVRacHYxMW9CcUY0M1RIOFZhQkc2cFJDSk54SVJldHNZSnFk?=
 =?utf-8?B?M2R1UmxKMXZ1V29sdnpseXBRQjBnME0wVjBIV3hzSjJGb0IzTTcwOXFZSnVp?=
 =?utf-8?B?UjVGcjRKOWplWnRpS3RaYWZlclVRci8zRDVKdWxtY0tCVWYyZlFLVkF4T2tO?=
 =?utf-8?B?MFJmTzNRb0lxUHZUckNmQkxIbEFWMDF3VHlGK2JCcnVlbldjODAyUmFsSyt0?=
 =?utf-8?B?TERlUGVQQzFiWFlvV2thMXRDYjRiNU1UQjFPV25ZanNyeUR6bUxsbGo4YkVS?=
 =?utf-8?B?NThnNFJNNWU2MTAxT0NzbTk2SkhKSk5BRWxweDM5T0xaK3JneDRrcDlqSkk3?=
 =?utf-8?B?cWhNc0tsMjN0cEloRWtiZHdkWnBwemk1bC9UVWRkRm1LZWZITER5RmloNTBU?=
 =?utf-8?B?RFovR3dRWUlxeEQxbjloTktFTCs3T1lHOUFsWjJTejcyREthQlVHL2RsQzI5?=
 =?utf-8?B?NWJ3M0Rxdjl4b09OT0NySnRZcmo4bHNDbmhtcCtuRjlFUWhRb1F0N3hwc3JG?=
 =?utf-8?B?bHNaaUUxL29BVXZvMmlESmRaV3JJZHJ0OXk4ckJSMHIvdmNVUzFzTXZCVUlO?=
 =?utf-8?B?OGZyNkY4Vm52YWx6SVpma05GU1lFeXFhQ0dIVWxHTVE1b3IreHlEN0NQWWpB?=
 =?utf-8?B?cnlHUDdtbzFjSXZoNmhmQ2hXNElZRTluLzBKaXBHTEsyZTl3ZjNoT3RRVkRO?=
 =?utf-8?B?dHgweGpEZ1l0MHFpbzc5WnAzcmhBOUc3Y2xWUGdHR2c3azF4ZW1KR3V1L0dK?=
 =?utf-8?B?d2kzOUNJRklOdVhrQUZ0WnhRREhlYXg2REZPUHN0b3VlOGs4Undib09Jd0E4?=
 =?utf-8?B?OTI4cnpLaWZicVhLdjFDSHl4KzdzOU5JaWFyTzcwdXZRMU9BWGZaZ2ZvQndN?=
 =?utf-8?B?bGhOOTBNK0lvUngyaEtXWEg4L2EyLzdpbWc3c01kd2prYlJYdGp4NytCRW0w?=
 =?utf-8?B?NExTK1VTQkd2eEJTaDBKb21VZUpoUGtUM0JnZFBXU2tYL0EvTmdBSEFRUXJQ?=
 =?utf-8?B?STNKdEYyVnROL3VEbVIwQTFJeEQ2UWdQT3QvbTkvNjVMOXc5R3pXby8veTls?=
 =?utf-8?B?b0ZCUzNRNW1rS0VFME9vaWZpckM0dmQ5WEpjY281UVRiYks4UXFpcHQrekhM?=
 =?utf-8?B?d2NGKzZYTWx0MnFCd1pRRFVvanpabjMyazRYZm1UbUxXTDhjYVpSVTBRR1lz?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 098e7eb0-1714-4616-558a-08dbb944d0d4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 19:15:41.6532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBclH9WG8NBINSz5ezpmy31NHMK4XxQCwCPih4Vb6unATa/7j/AiuSXXLVEsB32rrxcgTWFRFF4ScT/aiQc2oUlmQ9GhsYTCGNQnSGctf1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5325
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

On 19/09/2023 20.27, Marek Vasut wrote:
> On 9/19/23 12:00, Rasmus Villemoes wrote:
>> When built with CONFIG_IMX_HAB, the full FIT image, including stuff
>> tacked on beyond the end of the fdt structure, is expected to be (fdt
>> size rounded up to 0x1000 boundary)+CONFIG_CSF_SIZE.
>>
>> Now, when the FIT image is loaded from a storage device, it doesn't
>> really matter that the flash.bin that gets written to target isn't
>> quite that big - we will just load some garbage bytes that are never
>> read or used for anything. But when flash.bin is uploaded via uuu,
>> it's important that we actually serve at least as many bytes as the
>> target expects, or we will hang in rom_api_download_image().
>>
>> Extend the logic in the csf.sh script so that the csf blob is padded
>> to CONFIG_CSF_SIZE minus the size of the IVT header.
> 
> On which SoC do you trigger this stuff ?

imx8mp

> (or rather, which bootrom version, v1 or v2? they each use SDP or SDPS
> respectively)

Absolutely no idea. I just do "uuu flash.bin", which seems to DTRT
automatically, I've never figured out the esoteric uuu language, and
I've never found any actual documentation for it.

It also doesn't work without
https://lore.kernel.org/u-boot/20230919134932.134678-1-rasmus.villemoes@prevas.dk/
due to the spl_load_simple_fit() abuse.

>> +
>> +# When loading flash.bin via USB, we must ensure that the file being
>> +# served is as large as the target expects (see
>> +# board_spl_fit_size_align()), otherwise the target will hang in
>> +# rom_api_download_image() waiting for the remaining bytes.
>> +CSF_SIZE=$(sed -n "/CONFIG_CSF_SIZE=/ s@.*=@@p" .config)
>> +truncate -s $((CSF_SIZE - 0x20)) csf_fit.bin
> 
> Can you use dd(1) instead ? I think dd(1) is more portable than
> truncate(1) , at least I cannot find truncate(1) in opengroup specs.

Certainly.

Rasmus

