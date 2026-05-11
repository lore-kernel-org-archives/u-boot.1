Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202B5CD4843
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 11:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3FB81E18;
	Mon, 11 May 2026 13:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Uh4QNXNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94AF68341A; Mon, 11 May 2026 13:18:46 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B1A801A9
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha2Gu7Aq+4upCAm232WT1fHLoSQcIOLX1cM54Z7hZczZLFZ0LJwITdpL82Ii7qBHKY29EZvNEubgsdskWo5XRseFKLrFvnHamh5GiHaVcRisI2i0i4AkYdJ60sn5GVPCcH68jbwh/ENmADXhterd62CmxGHwu3pB4DVCwIhJ9ZJ+RM91qGwohnyQuDitmWH/ylc9mEM7CZ4a6UXqUxghVGBLxjyLzOWn72Lv0u3cw5Zce3dL0+rpKzDBw9eU3zxriEwP9iZgOVUMFrVscRMBCVJ4wCQogjqikZMtUn3H6hCqBmVZCDxCWPXsy13N2t6gBpVfpU/j7/6k+0R5odDFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmaOkdH1LcugAQJbWsh2nxltuSc1pxoP7kvINVPvKpg=;
 b=ui5yEBRVAxdNY1pJJPbrQMNkg/GvpjrKfqC4fS3YJKj8ZdhFK/c39+IeqgAbgq7mnkhUiy/85z/S6BT4hkNZcy0XKM4Tx3F+Uh9IdBym1SKV2GDbKs+jC59ibnNfzLrrsHKjPRz9M3JhYqozGbrWHk1C9TA+7IojE4JS1SE7SyYVfbfnRYbc91aUAwvD/QCHEl3OXCZDEm4puXJEHYheuuSpl/wisBgggG9JOCM9Ckmcrzr/DgjiRlrELMBTBePuXjyGKzbktvj05/SQtKBsVq6n/eYX1FvUKBLO9WPqFNLmyG673LGbBfKGVabfKmsgJC7R2OYNZe/0GPYqAm9Kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmaOkdH1LcugAQJbWsh2nxltuSc1pxoP7kvINVPvKpg=;
 b=Uh4QNXNv+4oKXcyNTn3LOrK8jyhsn1Gv2EJSILC8WtF96w1neh5fJG5zOvcRNzTivIy2zfpU7UnRe/gOLBOQ5T3IHrktoE9e52S+sHa5H5qv+PN2v1WsGPh/8DOfbyXEEyXfKQud6JgrzqUj5bJB+84HOyriFAFH5OuKX1TCwkqw4ZnDFtiCTsTvDK0yjXNDv2IWG2dBGgHEiK1OxeVeylu6k+oMSJvotlDSV3b0Lz+j44hsqpoW0YHPwf0IgPO9vklsYJMU9H2gnJnykQGpKXT+EWR65t1ymyl2N0ZCZjXttMPtNUTJ3jyFeJjFfHjq/p4tOplkTz8nC1On8FNZJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:407::22)
 by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 11:18:42 +0000
Received: from AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c6b6:6479:a04c:99a2]) by AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c6b6:6479:a04c:99a2%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 11:18:42 +0000
Message-ID: <dad3e201-d209-4ea8-9d19-422c635e1e06@siemens.com>
Date: Mon, 11 May 2026 13:18:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] qemu: overlay signature nodes
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
 <CAFLszTiTCsLgdAasexCb5Gv1zkdAo6m47D2MEgYxqwpkfAZoNA@mail.gmail.com>
 <79f3438d-a6d9-48a8-8cdf-01dde7b5e2b1@siemens.com>
 <CAFLszTg_EFGf6CTJsNdnFiJrxYKm8799ZDA+wEgLYXEqQ-3_xA@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTg_EFGf6CTJsNdnFiJrxYKm8799ZDA+wEgLYXEqQ-3_xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::20) To AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:407::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB5016:EE_|AS2PR10MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0a3dc4-47b9-49a7-9e8d-08deaf4f0eaa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799002|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info: G4UI7CQhtq6EIuRPuyY8b/thby9fWABNQ6LhxWeO6XyrgnjS+L1IGKx9x0v8wN/+Nt5z9auLX0nmnNbxZEa42/qqvsznVn4ep6uCP9Em9na+Wk6JNlDeTjzMIWmqV4mZIMoxSJm7x+Qup1ZbU7ikQ2ldK3faAZ0k+6VOChAdDd3Mgac7qyLQ6f+zK3RftWvOavzn+P/3Gtb7TXzl5qNwqsHr2sWPEobX1mDT4Vnpy0J+I4RE/fzGwooNdT+nv6Ff8m6KJZ7pCDm3XrH2QEz8PagmaZv7ft2uUEuH8ZpAGRk2tVkKeYPwKaqP1cSwukPSkr6YnclwVio/DiJUJ8n4FO0Tu7o3/kDkqD+FYyNf13/5RnXfNcnqK8TCuV39cYR5A/5TjSzpE6HcB7kybxM5JZOWJdCkJ4TxzfnGnM44bszHCYJzsLUKEk56sGoNiA+o40K+ccoA0nDGccdnWLtE3ystHxFFjE5ZI8SY/hrWcTPkKSJGi3b1WGsVg3XQwLLYFs8gNnKdOZWFYRJ0iJEbpdQ2ZklJ6apXspJ8zgyiqOzm42JNw4y/QkTaON1udZS4Sz4eP5g84R2XU7rsQ+u+ZjpTwyTJQEZY8wVljO4KJoABtV/khJUYb1en2m4aom6fv3e6ofk1AfB9s5XLyCv3rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799002)(55112099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHovQjhBVGZ0SUJiRlYvRmhpeFRlMk0zMTZ3WVQ1TG8yQTd6NHRmcmRCcElF?=
 =?utf-8?B?QTNLVjZOQXN3aEN1aTlMbllzYThxaFlsQnI4QmJBQ2M1RmZCT3cyVHpiTlVK?=
 =?utf-8?B?djBCVDJDeWZEc0NPdWl6OFhLTUhaek1mWmFNdDA4N3oyTXdkYzdVRHdPVE5P?=
 =?utf-8?B?ZFNlWGpNcWpyY25VMFpCVkdtaDQ0NEs1bmpsamovQ29ITXBrYlU2ZVVJTFB0?=
 =?utf-8?B?T2tuRlBORUoxNEtOYWZtcjY2UFdjY2U2emZTK0U2TnFyT25lVlRPYVpjZDFz?=
 =?utf-8?B?cVZiVFF3RjVWUWltSEU3T2c1L1NuTm1rcXpNamlBQ091L1h2ZE9JZitDeGZk?=
 =?utf-8?B?dk5XbHNMUVlVRVFSTXIxNVNNMW4zTTk0YjJmbldQTnFxd0tEY204L1ZkS3or?=
 =?utf-8?B?NVM5bXRIeCtzY2ZUUmx6THh2OSs5eFRzRDhBYyt6aHpvL0JEdUFVWHlteGtQ?=
 =?utf-8?B?UzJOa1AyaXNYR1cvYXAyT1hpbFE2T0xZa0dzbUdmWkZ4RnBZaXNtc0xLYnYy?=
 =?utf-8?B?c1NDdHpJenJzTWtMK3dIb2lEcU92UWpBTnJGN1JtUHlHbWhKbGRZMFM4Wnl0?=
 =?utf-8?B?Z0xTQ3lZL21CWEtoTUJYWCtTZDl0bm9DcjErVlJWZnZKTzBrdnB4L3pUeUZH?=
 =?utf-8?B?NEpFS0FSWVpzMmFPdkswbmxYYmZVbnlSSUxTaG1TRkE5VmM5UzF5cXBpakpn?=
 =?utf-8?B?YmQ0cWtEbkh5QnMyYS80dVdIM1AzREhSQ0QvQnBrcDk3bkdGYlF6L0h3VFhS?=
 =?utf-8?B?d21OUDRsWXhxZGtMTzNsWVhqaURsNHpoTERsOW5EWEZ2bi9OVzZvc2kyYy8y?=
 =?utf-8?B?SUZCakQ0cFhNbWQwRGR2TjVaajd1dnVGa3pqL3hGcVZoTlpUZDZHOEorUTgy?=
 =?utf-8?B?bUo1eGE3eVFaSWNjMFNGVHJJbU1PSDV4L2dPUFgzWkRJelk2M2RPeTNIYi9Y?=
 =?utf-8?B?WXlUOTY0ZmMxSVhCcCtkL3dmMXgvUGk4YTVvSmhqUkxVaHozZnZGSGpoOUVE?=
 =?utf-8?B?K3dRUHl4b0JFaVVKa2Jwa0Z2NkRNV1JuNHpGemFmczY5UjhJbUdJa0RkZ2tt?=
 =?utf-8?B?L3lKNEw3aVgxZ1BQZjlOMnYvK0xiQ01yaHJ0VlB2TmVYTFVyeGx4NnVtN2RU?=
 =?utf-8?B?NUJ0RVNVRFZyY1ladUpqSmtBaWRDSU9VVDZ2MzVmQjFOMGltRURuUnR4Vkdh?=
 =?utf-8?B?eFZxVjBTaERKdzEwbHhLSTN5RU9JUERHV01KNFZ6Y1lKRXc5eXcrcmJZYXRO?=
 =?utf-8?B?bnExL29ZNTdWMDNxeXFZVUdIS2JSWXNNVnFaVlJjc3NZanJJbmZMSjZNWkIv?=
 =?utf-8?B?Qk9EVURxckdNSEt0blF1L3NaKy8zMVhqN2JnNk1LbzJROGJWRk1iSFAwM1JY?=
 =?utf-8?B?cnFVeWw3dWo4SVVrbWFORkdabVFuay9Ia2RaMWkzRlIzeWpPTW5rbHdyLzJR?=
 =?utf-8?B?TWhKWkxaSXhteXY1ekJlaTh3WE11M2FOQ0JqNGdyNnhwcnkwcE91aVVOTity?=
 =?utf-8?B?L0RnVHA3Zkx3WmpobVNZVDI5dmEwcXFVUmVNcmE2TG1raFV2cFZGY1lKRlJa?=
 =?utf-8?B?SlYzUjVRVFphenpXajhUYXZ1MmJsenVpWmdZaGU0NXpFK0FJLzYxVmttOGEz?=
 =?utf-8?B?eDNmR01ZcVJrdlFXTS9za241QkNnMnFWUHEwOUg5a3JnQnh0K0ZSMW52czN0?=
 =?utf-8?B?Rk5SUEtnYmdxV0wxUnVtZlF5dk0wV3RMZldPR0RQaTdDZkFYSE9HbFhrR3pB?=
 =?utf-8?B?QVRKblptZEtUdHJTUkMxcWNqeVR1ZkFrak5ieXlySVBxQXN5WWZwWm1hMmpn?=
 =?utf-8?B?NVhhVUVleW9uVFRoMlMrK1VuMHhBOWNWRXcvR25IT3kzMEFYNUx0OXFxYU55?=
 =?utf-8?B?d3ZCc3hHVHlrTENybURVamM3WHB1ZytiVUZtS3BkRHZTNUpoK1lLYzFJNW14?=
 =?utf-8?B?dU9nazhsTXJFVkhhSWNzeE51dVVmYWYybXdrWGdUeW0yU0l6WW4yZFhxVk4x?=
 =?utf-8?B?UUhVdktMQjZjYzlUUURFV2tTTmlhdFVRYmZLbXlOd2JSODBzWEM2VVdrVVYv?=
 =?utf-8?B?VUlUcTUwRnB6Q3NtVEFRM1RMd0EyVk9BTWlzS2RZYnprTVJ5Qzd0Mk5PZWQx?=
 =?utf-8?B?WExxNDdrcXYxMjVwU3ZZUkVIMXFseFFtT2YwMjhvRFRtT1lFeTA3d2l2RUFj?=
 =?utf-8?B?MTVFOUZvV3UxbFBPdGEzdzJpbStKbDI4ZzVESU5vSFVpeWRlVmg2MTZ3blI4?=
 =?utf-8?B?bGEvd3hnTkIzQkptVTR1TzZWbmx2T29XMWpDZnNnZC9xUE1MWmlhUTBoR28x?=
 =?utf-8?B?K2lqOEZqWGF1NVFmNGs3cUV5bnJXc1BjaElpRHk1bVh1OUp6N0c0ZjhVVG5n?=
 =?utf-8?Q?/6UzDLq4Cj26Av8Y=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0a3dc4-47b9-49a7-9e8d-08deaf4f0eaa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 11:18:41.9388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvuQ+dWLBKCkjqLUzZ3eirzZj2z3PczRdMO1/KrlL+16tNFMXVdkj/XeyvEGtac80O/84yzKShX6H52AuHcvW2mxZ2LFsC8S6hCoxJ58LjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6823
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

On 5/7/26 17:33, Simon Glass wrote:
> On Wed, 6 May 2026 at 09:29, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>
>> On 5/4/26 14:26, Simon Glass wrote:
>>> On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>>> qemu: overlay signature nodes
>>>> [...]
>>>> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
>>>> @@ -147,7 +147,38 @@ int dram_init_banksize(void)
>>>>    int board_fdt_blob_setup(void **fdtp)
>>>>    {
>>>>         /* QEMU loads a generated DTB for us at the start of RAM. */
>>>> -     *fdtp = (void *)CFG_SYS_SDRAM_BASE;
>>>> +     void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
>>>> +     int ret;
>>>> +
>>>> +     if (!*fdtp)
>>>> +             goto out;
>>>
>>> This runs the opposite direction to qemu-sbsa, which uses the U-Boot
>>> DT as the base and overlays the QEMU DT onto it (see
>>> fdtdec_board_setup() in board/emulation/qemu-sbsa/qemu-sbsa.c). Done
>>> this way, any node in U-Boot's built-in DT that shares a name with a
>>> QEMU node (/cpus, /memory, /chosen, ...) will have its properties
>>> merged into QEMU's, potentially clobbering the hardware description.
>>> If this is correct, please explain in the commit message why the merge
>>> runs in this direction.
>>
>> IIUC the FDT patching happens before relocation. QEMU starts u-boot from
>> a ROM at address 0 so writing to the embedded DT does not work. QEMU's
>> provided DT is at a writable RAM location so patching that one works.
>>
>> I don't know which direction makes more sense really. If you say merging
>> QEMU's DT into U-Boot's is better then board_fix_fdt() could be used for
>> the merging I guess. Looks like that could work with
>> CONFIG_OF_INITIAL_DTB_READONLY and CONFIG_OF_BOARD_FIXUP set.
> 
> Hmmm now I am wondering how this actually works with sbsa. As you
> point out it's hard to see how the fdtdec_board_setup() works before
> relocation...I don't have the energy to dig into it, though.

AFAICS SBSA relocates u-boot into RAM via 
arch/arm/include/asm/arch-qemu-sbsa/boot0.h on startup.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
