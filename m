Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B12FF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 04:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D03C80F0E;
	Thu, 30 Apr 2026 06:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ugfTQczV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BE783693; Thu, 30 Apr 2026 06:28:38 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7DD480086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 06:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SceY4P66d3teCl3mDIUAE36Xz8pSrwPOz3mWj8OJ/KIq9g4C9HZ+LcWtqEEQLMtAC5X4Ul+VtaBLwrcravVMWvPlECPa984JgZo/GvGMarmhozYozpSVwfNBJXLM6u/ieXJV9xntoWUJVW69UJLQaNGOQkFhgPEYpZfsqQ0++hv2NUn1yGm6ql7jIFYnB0aXFcjh8IgwJHpA4y14T8fZsxk+cInblYntoXJ1h7o73NK+HctdLCtAYRwkeh6lvQyx26rDcKagnRz5kxsRqgZ22zZEdmcMS1mPK5VRUmaxqt9tt9HP9a+GxsD80tds6ViLZGGvbnLMFB3+HAtq400RJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ariQzsXJuBiK/VonAqjkcGFxycDfvCbUyfjNZmA1hK4=;
 b=BnHjpAZuYTBt7AgzQ3CvsI9OL7J39aROsiBKbATGiSJKCfQ9ceyterOL8+8DIiiWEjVVYzf1aAaRvuijNfwkuytV1DaQT5KwtXIFAZMghbJPlpVH9SMrAT44TxTn2AfMAfgaVTxvC0o//fwgbOBgNb7dppbuExw9c6Y612LaFSinG4mNtvuGw0IRFfxUEdOW5rdwHuklBy0NykoRZTCkGCm/mXOj5aQUkXxy+6m/NmAToDBkWTaO5iJkzx9EETJUiGPWHat82Xz0n2HiK1knf3nWpboL94NpIPOuVNf5lCro0Ou0s2Wnjq5zF+HpiE093qQQ3WJOP74XDEgJuPhG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ariQzsXJuBiK/VonAqjkcGFxycDfvCbUyfjNZmA1hK4=;
 b=ugfTQczVjcjgTmwjS4mThzeoWARaqIj6+CyUPm3fo0+TFlDYlFZ//UaLHcGUYaqq0dkQ1tOScPZP72JAo3XKL8ZHuFtFzHgbk8GJUNRGOqRfYlWnBXOotacwHRvvvYvw1D1Et5A7Tu6BTpgHcfSsxdtyiC3A8JL02mma/H3bdVisoRI9SGhhLhiJcJPnL/NyEMtHgLDpwcLb73zseC0uoQqvywwtqsktV7kaZ6egwkIArEY5EhQ8l2FkMgnWayrD6C7KLHrqui+X86fkuRPPzNZVSBv2xMyJzWC2lRMVpHwoxeQArV6kwxq1to8dErEAdrDAte4zDNp5M/g2IkU4oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by BY1PR03MB7190.namprd03.prod.outlook.com (2603:10b6:a03:52d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 04:28:31 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9846.021; Thu, 30 Apr 2026
 04:28:30 +0000
Message-ID: <0b5fc175-76be-4b64-bd8b-48c9f502c8bc@altera.com>
Date: Thu, 30 Apr 2026 12:28:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] Improve handoff prepare on SoCFPGA
To: Simon Glass <sjg@chromium.org>, Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260423042824.3480-1-briansune@gmail.com>
 <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
 <CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com>
 <CAFLszTgouk66AOaL2o8PvH9EKNFabE=pjxpa9QpC_F--VhE9cQ@mail.gmail.com>
 <CAN7C2SC-MuqHK2+0vaZzZFi-up1L7=KcOSRedF6f6F3D9Uoceg@mail.gmail.com>
 <CAFLszTjz5SMpFMPjVd6tX5Lk9DKv3MMX+_qtkSgt6fztGceHFA@mail.gmail.com>
 <CAFLszThDv=YcuXUanOJd4MPeNdSiHSL2zH9jXAtbu+-8fRzF2w@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <CAFLszThDv=YcuXUanOJd4MPeNdSiHSL2zH9jXAtbu+-8fRzF2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|BY1PR03MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 1814af43-0ee8-4d62-50ab-08dea670ee0d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: wJIo6zCEIVh4JT6cxzZvlNaQeeCRl3FB6oIdMFGnD8D9hw8TjpQq9wGKGRP0wXcSvgat+yjyf56vsoPK834GLu2Og6rPXUFPmNIbmF4EIERwNQMYuTo7DF36UX0ktWjxm6Y+lkTqtGufCuKp/hwpfPJTB50APsDwqSl3x+2j6YNEtUP/3MKOi5Vdxx9bKb0hiAJQVJ9M297+ES9gleu2xllPn/CTvVDDoEBjYC5xlRYLp/dwAdLsFuS8plPrBb5V6HmVQwnCGbgivd3asFZItuZ79GmV8PYkhDuhFLS8Phx1oo+bMYMRXi72+YQB1+qdFWvxXxojtVpQ3RHxnTfFJvcXLvlg/ycBCY7RW7zMioODbgnoJ75yuJm7+kfkDxFI6QVAxePUl6jp/h5eg0AlYIbBapSxj73/Lh0ScWc/vfkvhNlVjlyF+iRlJYkk/7cWZLBd7ymUrXwr+oIOwDdrf3k/zhwwayXvfNm7F49uCUURzxbT9Jk+7bqsvQiCbnrJOUEbJZ22Vd9LXoqnFPvpwRMcFGYZ79TEmJ/2rC0BXhKFEra3nN+NFdb46PmDXGJNVAZyX6td1vKx8/FKPgdmRNnbQf5Yq9J4xvE3REVfqgceIWYdcq5XLzDcQ6j/TgvuHt2rpj7oKLGC02eDmm9qRadn8CP2xhQsIpbK5XJhpo8paVVRR1Lgdq55WmQ9eC0e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1EakVVZFlXWk9BSGpBM0c5R2RvalUxRi9ETnVmWWlzS1F1L0lJUFRKOXFI?=
 =?utf-8?B?MFM3VFdMamRKaDRNTFZoTytkQ0JRaG9xZWJDTUExdHJSY0FKbkJ1c2F1aUgy?=
 =?utf-8?B?bllUTUx1WTYxNE9na3N5RExob1QrL1lxTTZReVN1VGlEQmp0b0JoRFZZSmJo?=
 =?utf-8?B?T1BMUzdxOU1rbDFRNS9NOGsxSTR0OHJORkV4QUNaTmZsZ0ZTVnl1Rld6bTdM?=
 =?utf-8?B?Y3FyMmdpREEwMG1kS1krZGpDRnVsNDdCeDEybllVYk1aTE15cG1nVnk3aG44?=
 =?utf-8?B?d01KQjE1MSsyTzJDVDBvWU1yUFl5RGdaeUNQcEZUb3hBQmwwUC9SWDhmRys2?=
 =?utf-8?B?NjlNbFRjUWxURlVaM3JCNjV6VFdPQ3NNZDBrdEdkRzBuZm5zdkZEaXc0WE54?=
 =?utf-8?B?amlrdmlEWGg1QUN1aVRwa3RzNWtJWTN2bXFoOG5oZnBTQ0o0VUxKYmtJZWtj?=
 =?utf-8?B?a0tyVGRmY2RUbUd2aE1VVnlJWDRUU29RSENndlBjY1luMVpNUFR6NDgxd0ZT?=
 =?utf-8?B?T1V3bkV0TW9HaGp3K1llTzMwa3pmeGo0VTN2RVJsN2t3dW5QQ0FZZWR5SDUr?=
 =?utf-8?B?QktzT3lSU3lwRUtmMW5DdzdQU3VkM3VxSnJLNEJ5WGhZMHJsbUNETW55Y1Vj?=
 =?utf-8?B?NlJETGdLYys3ODVabXBJendPU3ppZTg5SUdZTkRjaE9EdzdaUGJkTFZjdmJT?=
 =?utf-8?B?aGt6eXRVZTdWQXZ3VzNpZzBlWjVRcFQweGx4alVJMWw2dzBKQ2VVK2c0Nm5M?=
 =?utf-8?B?VHl6QVhPR2RKdDNuVmlaQXVCTjlOY2ptdmpCeGRrcFlaT1ErRVZjOUhlL0RD?=
 =?utf-8?B?VWJYWllCdHJiQWxNQ0hlQUwzRnBUeHpLaWQrL0ZJcDNjZ0FvTXpOVVhzRmt1?=
 =?utf-8?B?dTJsR1YweVo2Z1RiMDRRYjNwZ2QvZ3BzZmk5c3VFSFpGR3RxeTVjYi9EeGNV?=
 =?utf-8?B?TUFHUjVtdmpLbzBrbGJwR0F2blA4TCt4T2hxZ0w0ald3NTZUS01CZm4xdVRO?=
 =?utf-8?B?a0p5b2JVZ01paUliaWppYTVRcmpJZThBaW8rZjNvOUZBQStBWDZ5ald2Rlg3?=
 =?utf-8?B?UW0zVnkyNU5aMSswRGJwQ24zSDlOSTdBTUY2emhTZUpUV3B6UVpOK3dSbjN1?=
 =?utf-8?B?Z1p5OEZOSmcvR2g5SXAzWDdIU1J4TmsySEFidS90d3pjK093TXJuQzdkQ0JH?=
 =?utf-8?B?c1BMVkF6LzhjalFaRjN1ZTlWd0VxQVpnTzdPank5dkl3amdmSmFtS2NER2lu?=
 =?utf-8?B?MVdDQjU5SGY1ZzI2UEVFYUlJM2dQa2FjRXBvWlE0UVZYQkNPeVZVeFo2WlFR?=
 =?utf-8?B?eGhjYUpLM2Erd1dNa0xsT1kzdTJBYzlGeTFnazBaNU51Wm9KTTNzRW95OWND?=
 =?utf-8?B?a3FvOXg2VS9CdlpvaXVEUElDc3MzRFJSWkRkcVFFaVlqQVdacEx3dVdtUEFD?=
 =?utf-8?B?eStCK2xnaGZrMnY2VWp2V2JQWDJINEcwbjJrc3gxYURtSmtVRzh5YzRzM0Na?=
 =?utf-8?B?Vnh3UFUrRVV3aUhvdXZ5U1NQNkpTYjVpcHMvalUxVkhwNkVjMnBKZmx2ai8y?=
 =?utf-8?B?K3FPbTYzTUZlSHZJWUpGamFKR1pKdU1IU1U5VlZKZ0h5QW9mRGdVTjU1NVRT?=
 =?utf-8?B?TTI0Vjhnc29vUE1reVByWlU5TjdYRHFnZnFWeDF2MHNReFhiUXBqRjJHb3pW?=
 =?utf-8?B?d0JKNVN0RTJOSU5BSW5xUWJVS1BuNitJZUhGTFdVVW1aWVVDTy8zWGkyaFNp?=
 =?utf-8?B?Z2xoNzE1VEJCblZkdkpMRW5YaE1TV0ppeW1IWFZ6cUN4MThzUmo2Y3U2YVcv?=
 =?utf-8?B?OExpSDQwQ1lQS0N6ZHJ1M2lPT0t2WGt6TUp5ejlIeUsrZ2tTUjJndmgrMGhp?=
 =?utf-8?B?WUtoU0lHQUQwWWxCdXQ4SXhteU8wK1ZtYjNVckJXeGpXeHlGdGdLQXdCaGJO?=
 =?utf-8?B?TUtzQXVTYURmQ3NvRTJ0WmQvTVUrNGY2dDJQS1Q5Y0J4clluZDRCK093QmVz?=
 =?utf-8?B?SmdlamVRcWhQcVB5dkFLL2s2bFpIbU1CRVR5VlpKNFFUdi9vaTkvY0hxSkYv?=
 =?utf-8?B?M0c5cm5tYzdDUUxHd2E5a212WTBoUlpGaE5uUDRsR3lzcGRkWmY5UHpsNHJn?=
 =?utf-8?B?TUNWWDhMMXBzVXhZS0hwb1VRdisrcTVoTU5NN0l5QkRoSEtaaWhxYXZMTGIw?=
 =?utf-8?B?T0ZMVmlGZFFlbVlaaGhBNlJLSldoT0ZjL2NrQ0FsVXY0UU0reldXVVlXRXR2?=
 =?utf-8?B?eDM2T09ockUvTlBlK3ZhN1dYVnl2ZU1SS2FMUDlDWnQ5YWQ5S29Eb0JBRkxN?=
 =?utf-8?B?NW12VXdiamFEVkRINHBaWFlnMTJNUllCWVB0SjFRWFBITmxITE1JYXNEMCtX?=
 =?utf-8?Q?byP8L/hpGSkV7xUY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1814af43-0ee8-4d62-50ab-08dea670ee0d
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 04:28:30.2529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkl0uDKaJ5SFKvKGB6hJOujnwtgVF6MupA63lz5Xh8HIlI8XXaE/YrL7W6umi1pvjfEvmPKxosJDluCY82jKGeXW369FpeDDGxaiPiBO0Vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7190
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

Hi Brian,


On 30/4/2026 1:14 am, Simon Glass wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On Thu, 30 Apr 2026 at 02:44, Simon Glass <sjg@chromium.org> wrote:
>> Hi Sune,
>>
>> On Wed, 29 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote:
>>> On Wed, Apr 29, 2026 at 10:21 PM Simon Glass <sjg@chromium.org> wrote:
>>>> Hi Brian,
>>>>
>>>> On Tue, 28 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote:
>>>>> On Tue, Apr 28, 2026 at 10:04 PM Simon Glass <sjg@chromium.org> wrote:
>>>>>> Hi Brian,
>>>>>>
>>>>>> On 2026-04-23T04:28:24, Sune Brian <briansune@gmail.com> wrote:
>>>>>>> Improve handoff prepare on SoCFPGA
>>>>>>>
>>>>>>> Ensure qts folder header files are properly updated by isolating
>>>>>>> the Python execution environment. This prevents partial or failed
>>>>>>> script runs from corrupting the target directory.
>>>>>>>
>>>>>>> Changelog v5 -> v6:
>>>>>>>   - Clean HANDOFF_KEEP comments.
>>>>>>>
>>>>>>> Changelog v4 -> v5:
>>>>>>>   - Change HANDOFF_KEEP condition to if [ '$${HANDOFF_KEEP:-0}' != '0' ]
>>>>>>>   - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
>>>>>>>
>>>>>>> Changes:
>>>>>>>   - Implement a temp folder for Python script execution.
>>>>>>>   - Clean temp folder automatically despite execution failures.
>>>>>>>   - Gate the file replacement process on the successful exit of
>>>>>>>     the Python scripts.
>>>>>>>   - Execute the replacement (with or without keep) only upon script
>>>>>>>     success via the NEW HANDOFF_KEEP=xxx variable.
>>>>>>> [...]
>>>>>>>
>>>>>>> arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++++++++++++---
>>>>>>>   1 file changed, 36 insertions(+), 3 deletions(-)
>>>>>
>>>>> Dear Simon,
>>>>>
>>>>> B.C. the server is down and I don't expect Google to have an auto fail
>>>>> mailing recovery.
>>>>>
>>>>>> I see 6 copies of this v6 patch in patchwork, so I wonder if I got the
>>>>>> right one?
>>>>> I will try to respond to this email as politely as possible.
>>>>> Please reference from "patchwork.ozlabs.org" list.
>>>>>
>>>>>> The per-version changelogs belong below the '---' separator, not in
>>>>>> the commit body. Also U-Boot convention is 'Changes in vN:' rather
>>>>>> than 'Changelog vN -> vN+1:'.
>>>>>>
>>>>>> You could try using 'patman' which will get this right for you automatically:
>>>>>>
>>>>>> https://docs.u-boot.org/en/latest/develop/patman.html
>>>>>>
>>>>> 1) I only do basic software
>>>>> 2) I used ./script/checkpatch.pl There are no errors, warnings etc.
>>>>> 3) There is nothing to do with the patch itself either the software
>>>>> nor the file itself.
>>>>> 4) I am not too familiar with patman
>>>>> 5) There are many better things to do rather than complaining about
>>>>> the patch headers.
>>>>>
>>>>> So forgive me I really don't give a damn on whatever the header requirements.
>>>>> If you feel this is not passing the patch standard simply reject or
>>>>> label all patches to
>>>>> "Changes Requested".
>>>> That's up to whoever applies this patch. I am just a reviewer :-)
>>> Hi Simon,
>>>
>>> I am going to ignore all your mail in the future.
>>> So review whatever you like, don't care.
>>> There are many patch not following whatever rules or guidelines you
>>> mentioned.
>>> Just review those as well. What a waste of time on your emails.
>>>
>>> As politely as possible!!!
>> Oh, sorry about that and also the server being down, etc.. The
>> maintainer for SoCFPGA will handle applying this in any case.
>>
>>> Brian
>>>
>>>> The reason for the formatting rules is mostly so that maintainers can
>>>> apply them without manually redoing the patch, etc.
>>>>
>>>> There is also this which might help (although you might not want more reading):
>>>>
>>>> https://docs.u-boot.org/en/latest/develop/sending_patches.html#commit-message-conventions


I have reviewed this patch.


While the functional change appears reasonable, the patch cannot be
applied in its current form because the commit message and version
history do not follow U-Boot patch submission conventions. Specifically:

- Per-version change history must be placed below the '---' separator.
- The required format is 'Changes in vN:'. Custom formats such as
   'Changelog vN -> vN+1:' are not acceptable.

Maintainers rely on these conventions so patches can be applied directly
using git am without manual rework. I will not correct the commit history
on behalf of the contributor.

Please resend the patch with the commit message formatted correctly.
Further review or application will only proceed once this requirement is
met.

Best regards,

Tien Fong

