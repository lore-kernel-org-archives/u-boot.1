Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EEAFF8869
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 17:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A4E83BC4;
	Mon, 27 Apr 2026 19:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aWykAaa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C73A83C14; Mon, 27 Apr 2026 19:17:17 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF2383AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 19:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDCosF/waYxoFBumcwhC+NAjKJEvUhrUP3RK++rQ+LCqyAu3cFTVGqKFcTzG33hjZHFCBZfrwQzWauM6fbrWq6FabfrGm1d29rNJOfb8jCUJxXxMQSafwHyV7LnaQu+/RAC7UAC7XmLlRV3uQn5SdS68poRnWeR2cJYSQINWRxp1BoaRtgwdvrxaIeLeUKOhiPmW2EENSThv3r6RIdMer72cAj6LWgJUMpbjV8GXhaYrhaHZrktZAhSIJzfwzE3tN7rjjDW9NbX8XQ7EdniUeSqLynsZEXnSRcBV07bS7BkkbbmhZ0Y8olvTIjLTAMyfg6DM58jc2DWIfmbGL83lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlPlkfH8G2OKOcERlH45NoB6z7lvXSeclW8SaNmNVik=;
 b=Yaf5/w0slCPm2LB66uZmJOE7ZeFd6Lo3Y6BE+Tns9KjX9wnxjQ0O/0sbCuvWw6ZWIbwGDAhdc0KqD3s555ItZMR/tYseUfVFaDRJau9xbY1hF64nZugfb79C7r/omZApxrOOkDJHD2dyRhPGj5m347lyi7/I5hmphvmNukoRuBiji0a8g5ea+gMiWXY31hptz3j0Fmr/auH9tScERm0FZVBH/bu7vSV06vPdGDNUp42jR3XgZIlytRnkF+gXoiPWzqddT874aHnBpmKJNlHxAj+NQjnc/vjeaUyV2hd9u7ThZuE66RIRNKqcNyIZqfMUuX20sTD4RuhjeCuNMYJSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlPlkfH8G2OKOcERlH45NoB6z7lvXSeclW8SaNmNVik=;
 b=aWykAaa6VgRE0zws3JR/1TuTeakDSpyltovqU//s7ry6KLgqdcvLNsap7WrK8ANKByUW4pGGcs0yWOwWVExvrLbR6HFFmhK7GXCv5S9hZhWWibih+WJyUBJtzDvDoqBe8nA2NhFUVRDVlNTTkoQld1sQX76495xwJWt4cEWYpjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GV1PR04MB10252.eurprd04.prod.outlook.com (2603:10a6:150:1ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 17:17:10 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 17:17:10 +0000
Message-ID: <d09d6f4c-f0ab-48ff-aa80-c53b697b0130@cherry.de>
Date: Mon, 27 Apr 2026 19:17:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/squashfs fix overflow in sqfs_find_inode()
To: Jared Stroud <dllcoolj@archcloudlabs.com>, trini@konsulko.com,
 joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, u-boot@lists.denx.de
References: <DI3DOZXB8ES4.12PBN3MVHW911@archcloudlabs.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DI3DOZXB8ES4.12PBN3MVHW911@archcloudlabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GV1PR04MB10252:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fef647-dec6-4116-512b-08dea480d0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|17096099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8OtlreEwFf21UNotkMtvMahdsl/AaaY7WxKM/hlESHFjla5ICO9DYVpQm+r/0pHgyFRj5Y1Q2vgmyxH4AS/2yjF8nSyXwCNsg3HxhFYEsD3+42gnU9mr8cO91HtRsyDEUG0175SYHBBKivvDsNHcAT3ZsMmcry6XA5HdEzBMvRY4hcIX7DOnW9LR0P4WLImiLxwF7aovMBgBzEmU/mlZOADDPsPYWe4PFFn+c2UhPWi7IPoWwgWrQZId6UhUev/BkYSpruVl5dnpAKhn6WEnL5puQ4kiul7Gab0e6NUplKJH5q7OWEn7HBXEuIbkNIEeoJEbrnxhdMJTIhSJzfi1AHWCiGvqcbizTIMHJjX3Q4dxqisxiJshDyQBPoTR8mqIPppNrUYIHWDPsQFIhJ/zI8OPbJySAJy1AHYfYzwknJjvXUmTm7kqcbkR7gWe3dTh8ALJ6N8saFGtRRFXBEXW7Ve1R4KgpF2dOXEDpRR7QbxDYA/FWjYpkNLYq4aLcSclfrBC9TXcQHepg2UWTyWcewT6Tz2IbZBWYYFZSUTw7y3S+HBOSr8Doi614zlappEkANyLY5drq2Y1XvYUnr1dKiYZXojd09T0HetdTrMgni938KmV7+kDefgEk1NsQ3IMNZgCxOVxd4gKNHoEEWoDVnNwpPVrmeQAfFETKL1xESeFXi3bmzt0j4xhfPkOwXV4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(17096099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eElDTStGMXZ0ckQ5SkFnWmpmbU42dHcvU0ZoR0JZUWJMYWRMa2RFMTRBaXht?=
 =?utf-8?B?d2tqU1FweUZwZG11WHN6MmNMVVVLdTNST1RhT0NuNW50VDEzRE1FNjBGWnFM?=
 =?utf-8?B?NE1xRThWS0NOQUpaQXVkYThNN1BIelI4TWVFQnljZm9XSVhGeFJvUm8ydHlO?=
 =?utf-8?B?Slp4cWFGL1lJZFhiUThtczJUOUZ5aVRIYWVPV3poclhmQ0JiRWg3Yjlha0hn?=
 =?utf-8?B?bk42TW0wOU42WWlMRW1QeDFTbms4TDlZbmFtWUV5NEQzZjMxd3o2M2hUaHpT?=
 =?utf-8?B?N0tmZ3R2NHZNaFFMTW5TZ1l4VXkxVTNBYVJXSjdrblBKY0wxcFdhWmRKVWFR?=
 =?utf-8?B?dkJtbldzblMrZDdSa2Q1RXB5MmZoTGdjcnpFVHJBOXlrSFpXbTlJMFIzcnJr?=
 =?utf-8?B?blErdUpmY1BOeld5Zk5Qc3RvYTZyaXZockxxbWNKMUZMRzFGa056dzZYVzcr?=
 =?utf-8?B?R2E5Vnl2QWNXYXJ4RnB6bGdTQ3ZtVk1qWkN3bmtxb0NqcmxSNWNEenpHQy9Z?=
 =?utf-8?B?MlBic0crckt4QVJPSjFVZnZGbUI3SEluMXJRb2ZsVk1raXF2Z1ZielhDdUpS?=
 =?utf-8?B?T2FLL0VnNmV1WHhDNVRZNzNqN3QrTDIwdndHNzl4dVgybnJtdGlVV2MzN2cx?=
 =?utf-8?B?ZGRGUVg0RlNsbU5PQzIvNGt1LzRNaXBkSWo1dk9UckFtRjBrMmptcWxnSlov?=
 =?utf-8?B?bkhSbXZHK3hhYngvVGxMcTRyZ1U5Z2NvUFQ5RFppaTFoVWtGNXc5cE1JTFJE?=
 =?utf-8?B?ZlRyY0hXSXlkNVVlNnE4STNhVWVMVU9hWDRtOHN5OGpkS2RnRmF5YnVZMmtX?=
 =?utf-8?B?enNlMXVvNVZnM2dKdS9MMmo1Z2k3OGxXTXN0Q0NvdFV4RHRFbjFReE42ZTNh?=
 =?utf-8?B?cCtWUjd0MFFRS1lRTTcvY1ErZlU0OEpVaENDTE1UZHJjMU9kWXFGRSt3bzhu?=
 =?utf-8?B?V3ZLU0MvSENya0ZpVHZpSHhXOXdtbS9jQlhXcTFqaXI3eTNIb2x0alF5UC84?=
 =?utf-8?B?OElObG40LzBFS2Y1WTY1dEM2MU9SV1hkSTRubW15MXJrSkdyWXBIc3FXMHAw?=
 =?utf-8?B?TzhzYTQ4TkY3Qms5WjNqMnRZYTUyRXB6dHpHUE05RFJqTWFzbnJPRW5TSWtR?=
 =?utf-8?B?RVNTekFzampnMGFoaWxNSytRNWx2OFhWellMaUlwckZoK1VFVEM3Um51b0F3?=
 =?utf-8?B?TTVORHh4elltcy9SZkVBdXNibi93TGdSbEtqbTRKekhJRlU2UytoODI4RE44?=
 =?utf-8?B?YkVWUDdvUHBZeFl0bCtuVkFWeUUyaSt5U0FIcEhrdy92Uzg4MFlWdDNOUzBK?=
 =?utf-8?B?RTM3bHZrYW5tbTNtTTcrS2srMC8zSSszbDlMSm9UZTh5K0d4SkZPRmJHUytR?=
 =?utf-8?B?Z3YrWUJpQ0NldXlwT1d1QnUzMFBzWEpBMlZYQWh0eXE0WGJKbVFkaFprSzl5?=
 =?utf-8?B?b1Y3c2o4N0NTTEJsbXhpMExOVzBHYU90MVdtY2NndVJLWHo2dGg0aExYb2pQ?=
 =?utf-8?B?VnBPOGd0Q3JIVlNmZ3JFd295UUpoNHZqV25zVjlXcC9oaXQyRzhpUUdsS0cw?=
 =?utf-8?B?MXBUOGEvWitUV2V6Z0kyaC9LSTE4NzA4d3RQMWJSVFh3dWpUZDdpZ09IRENy?=
 =?utf-8?B?dTJ0dEZocmhJQ1R5cW5CVnJmb0NsVm53TkJVaFNZYzVLZWdCRm5rM2IrMlhM?=
 =?utf-8?B?clBnQmlEUnJvK1ExMzVOc0E1Tmg0YU91QzRPM29uV2x6Q2p4S1lTMW1WZ1BP?=
 =?utf-8?B?cGJicXE5VVYrM3Z2ZXNYekFuZGV4T0U2UzM0VGdGYWplZWNpaFJ4dnBKTmxl?=
 =?utf-8?B?Q1E1SEFjUVZaYzFEWlNlYmpMamxsUlFOZTdNN0lxWVRqeVJBUXltREVYSHFG?=
 =?utf-8?B?VCtQZGVrS1k4RHNHUDNuczFuOXRBSWpNbk9WOGpKNmVmTC90ak1QMitVcXNJ?=
 =?utf-8?B?TnIybTBYMUF5NE5ad2I3NVRZRi9jOEJtR1F0NUNGVUxhWDFETE1mY09BcEVR?=
 =?utf-8?B?R1V6eVN3cjNpQkpwUnA0elBNaEt3YTloaTQ5MVJJemZRVkg2UEpoRFlXcXpt?=
 =?utf-8?B?SzlNSXRya0ptc21CRzRpUHFzMWpLYUUwYitsWTRTV2I3UVlKSTdEdGt3aWJY?=
 =?utf-8?B?RjVYdFpRRkR5c1BwYkdySE5wNTRWVE9QaElNRmhRL2QwOHFvRkRoZVpMVGwr?=
 =?utf-8?B?ZkpVbHIwWUZUZk5QMitqL1lJN05TVk10NzI3VXFCVGJNY3VLTTFvUUFscSs3?=
 =?utf-8?B?aUVxeGlEVDRlcXNrTUx5YUlkVENQNGlGeXI0SW1zaFlCcGpJdStKd2tqZEpX?=
 =?utf-8?B?aDV1M0Y5OGF2WU9LQ0VJa3BHMWc2SkttSWp3L3FHQkhVcHRxT1JUaXFicHVF?=
 =?utf-8?Q?FTnjAnKziLwVIrnHiVSKQwpJ8QQpSqx48TVlI?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fef647-dec6-4116-512b-08dea480d0f9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:17:10.3334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4qlDY7jouJ/nS276IlUFAORfMZtRfmi8rKuSdAZ8ahbc1UyacjqAOEbdpt4rPld/NYrydIYUEOxA8O6yLZn2/vSTqH7VJCNUQ0njReDVcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10252
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

Hi Jared,

Thanks for the report and the possible patch.

On 4/26/26 10:45 PM, Jared Stroud wrote:
> [You don't often get email from dllcoolj@archcloudlabs.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello u-boot list,
> 
> I found a parsing bug in sqfs_find_inode().
> While fuzzing the file_size attributes of the squashfs_reg_inode structure, if the file_size attribute has a sufficient large value, &base->inode_number will jump to an arbitrary location in memory resulting in a invalid memory access and crash.
> 
> I tested this with a modified file SquashFS file system and U-Boot Sandbox with release 2026.01.
> 
> ```
>          for (k = 0; k < le32_to_cpu(inode_count); k++) {
> 
>                  // 3) jump ahead in the inode_table from new offset
>                  base = inode_table + offset;
> 
>                  // 4) attempt to access location in memory
>                  if (get_unaligned_le32(&base->inode_number) == inode_number)
>                          return inode_table + offset;
> 
>                  // 1) large file size is read here
>                  sz = sqfs_inode_size(base, le32_to_cpu(block_size));
> 
>                  if (sz < 0)
>                          return NULL;
> 
>                  // 2) file size is added to offset
>                  offset += sz;
>          }
> ```
> 
> The crash and resulting ASAN output can be seen below.
> ```
> hit any key to stop autoboot: 0
> => host bind 0 random3.sqfs
> => ls host 0 /
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==75950==ERROR: AddressSanitizer: SEGV on unknown address 0x000067128936 (pc 0x0000006689a1 bp 0x000019b354a0 sp 0x7fff2b718600 T0)
> ==75950==The signal is caused by a READ memory access.
>      #0 0x0000006689a1 in sqfs_find_inode fs/squashfs/sqfs_inode.c:131
>      #1 0x000000660c79 in sqfs_search_dir fs/squashfs/sqfs.c:489
>      #2 0x000000662af6 in sqfs_opendir_nest fs/squashfs/sqfs.c:977
>      #3 0x0000006238e3 in fs_opendir fs/fs.c:669
>      #4 0x000000623c67 in fs_ls_generic fs/fs.c:66
>      #5 0x000000623fc2 in fs_ls fs/fs.c:537
>      #6 0x000000623fc2 in do_ls fs/fs.c:881
>      #7 0x000000623fc2 in do_ls.isra.0 fs/fs.c:870
>      #8 0x0000004eae8e in cmd_call common/command.c:582
>      #9 0x0000004eae8e in cmd_process common/command.c:637
>      #10 0x0000004da9d6 in run_pipe_real common/cli_hush.c:1672
>      #11 0x0000004da9d6 in run_list_real common/cli_hush.c:1868
>      #12 0x0000004db112 in run_list common/cli_hush.c:2017
>      #13 0x0000004db112 in parse_stream_outer common/cli_hush.c:3207
>      #14 0x0000004117eb in parse_file_outer common/cli_hush.c:3299
>      #15 0x0000004117eb in cli_loop common/cli.c:306
>      #16 0x0000004117eb in main_loop common/main.c:86
>      #17 0x0000004117eb in run_main_loop common/board_r.c:584
>      #18 0x0000004117eb in initcall_run_r common/board_r.c:776
>      #19 0x0000004117eb in board_init_r common/board_r.c:806
>      #20 0x0000004117eb in sandbox_main arch/sandbox/cpu/start.c:584
>      #21 0x7fb1a66105b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4) (BuildId: 5e8f131adc80bf454af46edf4a1527ae61e1b968)
>      #22 0x7fb1a6610667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x3667) (BuildId: 5e8f131adc80bf454af46edf4a1527ae61e1b968)
>      #23 0x000000401524 in _start (/usr/src/u-boot/u-boot+0x401524) (BuildId: 7121dd98eb40baab73fe6c0941c8200f29e1ad23)
> 
> ==75950==Register values:
> rax = 0x000000006712892a  rbx = 0x00000000009dbaa0  rcx = 0x0000000000020000  rdx = 0x0000000000000000
> rdi = 0x0000000000006fd5  rsi = 0x0000000000007abd  rbp = 0x0000000019b354a0  rsp = 0x00007fff2b718600
>   r8 = 0x000000004d5f348a   r9 = 0x0000000067128936  r10 = 0x0000000000000501  r11 = 0x0000000000000001
> r12 = 0x0000000000000002  r13 = 0x0000000000000001  r14 = 0x0000000019a0e900  r15 = 0x0000000000000001
> AddressSanitizer can not provide additional info.
> SUMMARY: AddressSanitizer: SEGV fs/squashfs/sqfs_inode.c:131 in sqfs_find_inode
> ==75950==ABORTING
> ```
> 
> This bug is similar to CVE-2024-57254 in that memory operations are occuring based on inode values.
> I applied a similar fixed via the commmit c8e929e5758999933f9e905049ef2bf3fe6b140d, re-tested U-Boot with the crashing file system, and successfully avoided the crash.
> 
> ```
>   fs/squashfs/sqfs_inode.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
> index ce9a8ff8e2a..addd76cc07e 100644
> --- a/fs/squashfs/sqfs_inode.c
> +++ b/fs/squashfs/sqfs_inode.c
> @@ -135,6 +135,9 @@ void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
>                  if (sz < 0)
>                          return NULL;
> 
> +               if (__builtin_add_overflow(offset, sz, &offset))
> +                       return NULL;
> +
>                  offset += sz;
>          }
> 
> --
> 2.53.0
> `

Please send this as a proper patch (we don't accept patches sent as 
attachment) on the mailing list following the instructions from 
https://docs.u-boot.org/en/latest/CONTRIBUTE.html and 
https://docs.u-boot.org/en/latest/develop/sending_patches.html. This 
will make it more likely to be looked at.

Cheers,
Quentin
