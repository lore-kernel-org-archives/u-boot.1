Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9B0C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 09:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BDD881F66;
	Mon, 23 Jun 2025 11:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hL0Rz9T5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB6880548; Mon, 23 Jun 2025 11:58:16 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163898210D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 11:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBPEVfNRAUgX8MAqH05jRxAu7v3qV/dt0C7LZqjlkv7pwt8F8qJ868k7/EigtMz/KFJQ6kE+RU1YFrbak75i/5tVJwyhbzfAbeE5PUKp6nypHumAkLENULiTq5PdSQAQTd87/Cbtm+2ymyVZTQT6CAjoa2dAOVbHyuy1y5Y3cxhUByg4GBn3CR+LgB0ETTZgzYar5enm2guw9BB/E0x4yblF8PApFa7zDAyQ3Vln19wiNy+a1W2I9nAj5u8pIvkfxke5vkQ+aICpdT2yVuMPsEH6zvIA1vjHGZzRn7UkQthBKRnyT4aCNWmsr1ubzDFH64W4xl1NpTE3Ci+th4uaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XAxYuFefWkP/ma/HP/6FcrHg97uSVqRtD+/FYWlRCI=;
 b=iZXO9+ulxAf1xhjq+U9VgvzV2TFgrAH3DXfTM/pKexCkJjwN4px6e9aEqBq0JMfIvTl5vscLilsHZHTwRfgaoPj2fwBpmw1jhBEZKuXZrGwXAlGWye38v0cirThzwfR8Rlc4iTcm3GLEqL+SkJp8IEIgGZQLUKz1MJw2LLzrzalWx0tgAaGH/fwQNvGhHowY1qsZBhiPfwTeJAVHCF/DYgC17Gp1Fy52H4539Vyoiv4mWsIRG6iqzqt39iGB1OjqftAnankUrNsPZYyRnJo8ThBuhqC6uXLv1GIKzIo/RXsi7Cgf9EzBESvUu8LQKNQ6nJ6TO4nzyJRZ/0BqylnBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XAxYuFefWkP/ma/HP/6FcrHg97uSVqRtD+/FYWlRCI=;
 b=hL0Rz9T5MM+pmC2H6dYH4+6rPckuKn9DcLWmF16F2CEnvY/GuWfKfBWALIrQOoV89h2El3/MWGYC+5pjmAnhzMlPHeg+MaQgp2YSa2qbPMrimsdKdmgsh173+HlZ+msDuMc0Nc+rZZlCrN+56HZp1ofZ4eng7y1bjhX88WJD5yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 09:58:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8857.021; Mon, 23 Jun 2025
 09:58:09 +0000
Message-ID: <1dcdd0c7-0160-4790-b7a9-ee01d6531100@amd.com>
Date: Mon, 23 Jun 2025 11:58:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] fdtdec: apply DT overlays from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, venkatesh.abbarapu@amd.com,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-7-raymond.mao@linaro.org>
 <9a5ed161-0420-4656-9fcf-6d122d4f6c0e@amd.com>
 <CAEfUkUL5L6YVbWtZrjitKuRPbs_3-=nr4i_1xtppi6CcXhhv1w@mail.gmail.com>
 <c6e4593f-fab1-417a-ac50-a4b0218793d3@amd.com>
 <CAEfUkUK5jhtFbYSF6m1grpwmd94+jhbq8v=7sVZAeHCs9yEUpQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAEfUkUK5jhtFbYSF6m1grpwmd94+jhbq8v=7sVZAeHCs9yEUpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0080.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 66aa85ad-5e92-4ddc-a537-08ddb23c7584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTJyc2xHWTUwcTI1amdoSVYzTlFnNVpnUGZHTnVNVjg2Nno5M1RvNkthNmJr?=
 =?utf-8?B?QmdkbzI5RHN2MVZqenQrSFBCZk1CVHNDdjFCQU56MnJSMDhKRzJyQUQzYmNR?=
 =?utf-8?B?TFJRajZvV0lmcDQrZmpaZXlnaTNxcWpDU2FuRWJsVGwzTCtSNnA1WHh5L0VE?=
 =?utf-8?B?L1d4TThqVkhFZXhXWU40MFd3azVNckdGK2Z6RUNienpnejlVZUcyQzZvamRC?=
 =?utf-8?B?cCt4aW9RNnNlVkNKSEJDdkYwN2RUL0N3TkVEZHhsZm5zVWlWUmNJenMvLzdo?=
 =?utf-8?B?aGRJcW5wV2pDYXpDbkwwSFZnYTh3aDVTbGE0T0I0LzNGUS9DcCtTdStWVmhG?=
 =?utf-8?B?T2xPRzhSbnBKOG9IYy91TFpuaE5LRzc1MFliTnRFL0VSSE95Zm9QMmRPNmo3?=
 =?utf-8?B?cWRHVjJmdFA0aU1Qa0JqMHg5aWFmSElreHVISlltem96QjBwR3JzbjUxZ3Nj?=
 =?utf-8?B?UmhoL0lzY21Zd0gzNE9OTWM3NWx2ZGhRWGVNVHRrTURTWFVsK09kTjB5MWg0?=
 =?utf-8?B?bmk4ZDB4b3h0L3V4dVo4bEdXVmdCbkFKWkNaV0FZQ1JnRXhRYndZUmZjdnRt?=
 =?utf-8?B?b2hsbGRzcHR0WmQ4QkgwQ3ozN21PQmpHZjBjSzh5bnZReGNPYUlyMlVwVG1L?=
 =?utf-8?B?UmlkbHRUNU9RMjEvcklTRU1EdENnckRTbDlXa2VDZ1Y5STZET2o3N1YyR3hm?=
 =?utf-8?B?ZURrcFU5aDlUYjhSTHo1WGtib1dzSFVJcVljeHdJaEYwL25hdzNDMVRabk1n?=
 =?utf-8?B?ZnRab2FlOU9vSzJtNVJnOGpzVXVYSjVzV0tHS0FpM2dtcWdmUzBLK1JyWWVp?=
 =?utf-8?B?VkU0U3lGTGp5QzdNOXJ1bUIyWG5vU2QyMDdjUVRMVGp0bEs2cWlmcktKZEt0?=
 =?utf-8?B?KzMrdnF1RzhFcWNYOEFsazlBcmthQmNNWlNSN093R3ozbHh4RnExaTg5QUJy?=
 =?utf-8?B?QUJEKytxS3hLZHJsMXkyNUgxSURlNXhDWk50SUFoSGdXVUt5bVNqcVlLVGV6?=
 =?utf-8?B?Qi9kVE5EcmszUFpXNWkxd0podi8wQ2xkRmZrSlgvSVg5anJMWWpYVkJMK3Zv?=
 =?utf-8?B?b0hHTTZYZnliRHhGQ1NuRjk1RG9UbUNJb3NvREQrUEdjOXlvaDFpU2NRVS9o?=
 =?utf-8?B?b0ZtMDV1Q2s0SEJwRmxXMWx4c0dCRDZ3R2c4cVNpQmduRHhleTJCMXRMb2lH?=
 =?utf-8?B?NGN5ZXk0Wkt5bHZGMW5vaFo1NDN0ek5pblROUm16STlhSUJqUzY3SVFUemVF?=
 =?utf-8?B?a3hVTjNwK1orVFFSVHdrdkZqVjJGeVFQSjg0ODZGQURveDNQVVVXMEVwcTVm?=
 =?utf-8?B?STFaSDUrcElvVlNDRklHNU5CcnNTa1hDYkNxVDVpNXBENjhvSVpodGtmTFNE?=
 =?utf-8?B?Q3NLTnRUZnJjVXhXM0hCdENhcm1kRjhrQjZzZUhzT2hUakRsVm1DVURHem9K?=
 =?utf-8?B?M0srYUxFZ1FuQ25BSHBvRCtCT3lENnNXM2FJNDVkanRLU08zT3dIdENkOVZz?=
 =?utf-8?B?U1puNmI3VDlBOGVobGNmU05nNnh1Q21zdlkxSHl3eEZSTndrZnE5c2JHZTha?=
 =?utf-8?B?Ujg0V2RSb2M0TkltNFA3Nkp2Yk9ESU84MHFMUEJoaEpURytIVVZWejA3Uzhy?=
 =?utf-8?B?UkRTdFo4VmRkRklhRGZST2xnRTFaeDBoNUc1bHgrN3psY1JTZGM0eEozdWhU?=
 =?utf-8?B?V0VuSG5lRGNoTFRTSkI1TlVVS1FMZ1lSL1JpSDRhVWh2Wm9MOXFtS1RhUXZm?=
 =?utf-8?B?WUhQdXcycDh5Z3prR0tIMHdoVE9ZL2ZTWnVXMVhhQnc5NXZWYTVOV1NwNllv?=
 =?utf-8?B?cm5XUkdSOGtvcE1iaVZWakQwNHRoZjY3ejVSQ21hQmlUaDIyNzlYV3Z2OWsz?=
 =?utf-8?B?dkVyeEVVTXI5a3FieGU1bnVzQkZ5bG5nKzJJdnEwQ0pvdWF1bFhkeW1xSjkw?=
 =?utf-8?Q?mzODng2JICo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmpWbG9USThjbEdML3ZaaXV6SHFLZ0NVYmxnSVBDMjFnSUNxTkhDT2htZUhN?=
 =?utf-8?B?NTNoSkFXQXRqOU5VbXBlK29IRWxDUXpHNUsvRzVzMm1KNEcrV0lXSXkveUs1?=
 =?utf-8?B?dmw4alU1Nnl3QWM5bmtha2hoUzJJMkV4NWFSbUZha25YbGdBL2t3aS9VbGY3?=
 =?utf-8?B?NktVYkhjQ3FSUHF6T2VLdXdKSFNhVUU1dnQ4eXhSdGNVeFBES0NtNVpPdC80?=
 =?utf-8?B?SGhlRCt2b0w2eU9EOFdzRThMSnpPYkFIQ1l4akExd3VkTmlIS3J5TTBJTlYz?=
 =?utf-8?B?djcvWVBnT0JxQm5GcldNREhqZHROSlJMQnFnMWs1ZnVkQjUvcjNGTXVwTkVE?=
 =?utf-8?B?OENQUjZsV2t3a0ZFV01WK1A1QzR0Umx5UEhHWDdRdFpudlhHa05pNy9pTWFY?=
 =?utf-8?B?czhNNEJSMzlXNzE5cy85N3hvU2FTMVNSK3dzSnJob0Mvcy81QndmWnNsdGs2?=
 =?utf-8?B?aE1ObkQ3c1hoWkNvTUplNmUwUjg0OUozNlVnMWp0THlkbUVtbC9KZmZpUUk0?=
 =?utf-8?B?R3pCaVFwelh6b1NZSFBJMXRIT2JBNTBzRWhnUGtJSjNmWFpqbkIrbVFCUE55?=
 =?utf-8?B?SHNIbVRBODhZa25iaVFWM1M5bk1aK05XZ3JlMVZnQmxnaXFZMkwrSnZkLzlB?=
 =?utf-8?B?R01HK1dCRjdOa1E2UHpmN3FJUDM4NCtqYVdaZ2lwZEFERzZJbnZpNktQWW1F?=
 =?utf-8?B?NVFYYVd1RHcvTlVkRTdEYzAyNXJBL3lhVTVDMmh5cXRlbTNlK0pDL3hmZEk4?=
 =?utf-8?B?S3Fpby9iK2lOTzRRbEVXc3dDN3ZabThiNTJjRktJWWhLelJQWmhZNHptcFh5?=
 =?utf-8?B?NWlyNjdRa0xjZ1VOZzFLQUZrdkxONTNUN0NLUjhpYnNiTVRrRVg0S0dRN2xU?=
 =?utf-8?B?eFl2RU81b0VLZUg1SWtqQzhySHNRbHBCN2R1Z0I4L3hodE5xVTlWWFZkZFJT?=
 =?utf-8?B?WUhxcjF0NWxtako3ZC94M3FuTlQ2UVZ6UlJQZlhpUVNtcVowQWxjYjdCdit0?=
 =?utf-8?B?bytaYkFDcnJvVkl1MEhES0k3bHFCc29TS2Iwc2tJR1MwK0tjRW9ueDZMZzN6?=
 =?utf-8?B?TGZOU2hhZkl2b0dOM2IyNGxBOERrTGNHNnpZQnp4OWY1S25CTmRPYXd6U20w?=
 =?utf-8?B?VzNZSm96ck5EYjhwSXdyMFoyRC9wK1JhZENpQ3ZtMzBCTStHdEVJbWlkaVhO?=
 =?utf-8?B?RFlRRjFEU1JyVTFPTzhvTlc4Z0dPaUptdEs4cC9ob2lVdmZiYTQ3ZlFsbmg0?=
 =?utf-8?B?bjhjNmRmeTNrRGFCNmUzSGVaU1dGdkpaN3lScW84K053cE90aGlFSC8wVTh2?=
 =?utf-8?B?WHZMbkJETDN0Q1dHNjA0aVVkaDVwVUNGNFllQTRoMDg3YTl1cko2b0R5WXhu?=
 =?utf-8?B?T1pPWHA4NjhwU2s4dFVZRHdNSllSeU03Z2owU1BWMlQxaXBZc0YyMlZtOU9U?=
 =?utf-8?B?YWhwVUJGek1Bb3diRjJ6anlpc0MzZ296WU02RWxxT0ZYNTIzT1JqNFJjWEFj?=
 =?utf-8?B?ZHIxRFlYT2JGMVB6UWg1MXd0eCtRZWxEWmdPblBLYXFibXRhcEdEVFpzSFcx?=
 =?utf-8?B?SW1XZVJoMkxVMVpTV1dJaUJ6akFEdmZ3N2k0OVJhS2VmNXU0a0pVRExWUWd3?=
 =?utf-8?B?YmQvNzFhMUJ1U25TN2crS29wU1ozLzU0NGh1T2FJczBxeWlVSnVCYzdQenJn?=
 =?utf-8?B?YnZNOXp2cGNDbllHNzFnMHhWL01tcGdEd0swNUIwT3lmeUpmMDBDSHRZOG1V?=
 =?utf-8?B?VzhKSEpabHpaMC9PdmRvWlAvVjlFbk5HTHk1U0ZUS1BkcDhGUWxSQmVZTS9j?=
 =?utf-8?B?S1JuVEtCQmI0NThnSWIvaVVpRFJDeDBuR3E2L0dyOWNNNGtPNkxuZWs2QWRN?=
 =?utf-8?B?MytQMG0xak8wLytGQ3lhdlJwellVekxtUTJ2RW9OTVUvNkhJMDJ0dUdja251?=
 =?utf-8?B?NE5rL2MxV2lReHF1a1BEMW5wZG9mTEpydVIweUYxSklWY3pyTG9zeWlXK1RB?=
 =?utf-8?B?N05UR3BQT2loOHVQU3ZhTE5aVUdWZzZ3bHY1aDVoSXdDMHVaenJRVkozUVA2?=
 =?utf-8?B?WG9STHpSU2ZrOXM2cmhqazVQckNHNjVSU1JwY3ppVFBLdVMyUDd1ZDM1YlFU?=
 =?utf-8?Q?QUubpS5N2T1Ce+LQDmwI5A2le?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66aa85ad-5e92-4ddc-a537-08ddb23c7584
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:58:09.7505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNzlD2lMKSRWfW9MUga9tP85HFL3iLKIFdREF0+Eu/mtqls3wLrYpVDQbgFhQvNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
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

Hi Raymond,

>>>> Isn't it also worth to check if existing CONTROL_FDT has enough space inside
>>>> that new overlay can fit there before resizing it?
>>> By default each entry only contains the actual size since bloblist
>>> (aka transfer list) is designed as a compact data structure and there
>>> should not be a waiver for CONTROL_FDT to carry additional spare
>>> spaces.
>>
>> Right but you can build dtb via dtc -S/-p to add additional padding. It means
>> dtb will be bigger which goes to TL and should be possible to fit overlay there.
>>
> Yes, a developer knows exactly how big the merged DT should be...but
> it is only DT specific and not a common case for applying other blob
> data.
> Maybe I can add a DT Kconfig for skipping resizing for the use case
> you mentioned if all reviewers agree.

What I am saying is free space calculation should start with looking at free 
space in base DTB. If it is enough (with pad) do nothing. If there is not enough 
space then call your code.

Thanks,
Michal

