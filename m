Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9245BF8FA94
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 16:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CBE840D8;
	Tue, 21 Apr 2026 18:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SHSIIwpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9E284198; Tue, 21 Apr 2026 18:07:26 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73CE83E76
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5WdjwmeGFGqZznB5EMesNr4SdUsemErgRt2E2U7zYpIAh6CwzPky575VQoTHV4veChDoI+h7HWWKAIliXXj13FbKPxbZ8/5KrETWyfRT15m7v5tUMHucXP3Rf8qMuNnOgJp4Mrft4/5qjDFUuZEblcbYhsBirsQCZ8CgNmubcwd+7KruU6AC5r4hrBnvWk/ZmfjBYxR+ey0Ck0P/++YnzHcTz5XihjAsq2IKd9/t6tSrxAeJ8yu+hi2HY8bK9g04auXfRinSNZ5VmPeUfwjO6FarAq4647WTeXtl7aVESayt7WNV764Ii+a2M49Tp7FOgJANbnwhhpzd6Ht+9oiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An2VBIsWKSFMljehIBiS+CC+yyNk/HE/yRiyyjhTtKM=;
 b=cReh2ro2+HyYmGDZHf7mlVo2Ce6183iBgNMGgmCCR2FVe2HMJmU1jBDKfsNnh6IitpH/bXpmbR+hybhDxcT8wt8WziGi6q021/HTNSWCb75gzPP7QTiYrEc5Ehv0TGocP19/6SQeuJt/ZSHFHd/cmyao481v8lI2qEO62imskJEqmJx7PRv15Mdjh8GOyOT35hITQM1np/Yqj2GCIbntY5XxBqXg8/2TU+LQII0r8fFSI175FLvQXi7x5HeKRuoIfwA02n73vyPBFy77B9CyAIyHUVBrPW4mAOh/LmaIAx72bopHwV+U1jG8cIjsR2uAVncjdg7S/yxbxDEXmrbkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An2VBIsWKSFMljehIBiS+CC+yyNk/HE/yRiyyjhTtKM=;
 b=SHSIIwpNhYoDOouGjzeIs8QWELiK8KiBI4jG8UeUxqBy3HbD5mV4Xu9Ua7STyHXJM/hkqaxdNGPFFv1Quv7Pf65noF55Mn1dSFa7IZvBac65d92eVSJpsuf/FocUaHiIO6Bt++hnU+t9KwNwgzIEd1XkmWvDhGqUqMwj1IMTRWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Tue, 21 Apr
 2026 16:07:21 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 16:07:21 +0000
Message-ID: <ab44395a-dc24-4141-8211-16a16281d349@cherry.de>
Date: Tue, 21 Apr 2026 18:07:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc2_udc_otg_phy: fix compilation on non-Exynos
 patforms
To: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
References: <55f2f0aa-669f-4825-9673-419504e89780@cherry.de>
 <20260316181551.2109-1-m95d+git@psihoexpert.ro>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260316181551.2109-1-m95d+git@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fc0b85-5609-40ef-d8cc-08de9fc011c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TqcsdTHH9KV1Jy9Y41ONFWbKbfp3SKYdQJiwik7shwb0vM7dBkCWbz2ZyO0pafOX/RQ3LmBVklJ1L9scBtwA8LF8JMZHdsQW9d+5UEY6gCLTKQbmTwvSLDD6KfE0OeDkGEPlNPtkDdvA+S/B2vzo9JsjohI2EVxMGjKiv8VwzNt73aoK730ZIA5aqvJGc6gJkDZ9Iwp6lwQYBAvbOMkI6LgQuymm13qaloJzxc4OBzekUNTwonsv1UciqdqHHc5zxdCE1Q7thoyRs9iDv6rkSUMHn6GfWLUIkinYRLpgbl+1t0Ocm8SpzDsuFIO4M1m7ocUbF/Py+FcMegMTT826lJY9LYmMULLDXQD6y0OSVjDJh19wFUWgY5+IEy5hcF0VzwyP7qrmjEQCciFpwUqIObjdwJqojvVCIAVTlv/YHwULk4GVms6QSz5oygY8XwNYJ1IUu4akyTsY5XDlZIPmJ/fMvv+SGzOyBIW8+X3/vYV4ftRWjCYwP9A5ioj5N8MufALXIzmyfJwDNRss2h4tx50ULW31EzeyjTJTgx3IxjoSTMr2nf1+nrMC2JlU1GEOSXn2PY/2XWue/gA3GTlv4dsmpW11D3nSXlexSWuogeWXf6xYyxNHZkX/lYSLjUBBXkE1erpVj0ya1Kdzz9smNQrD6PmErQs3CCrRypXUtbQgDhM5SNLxhnEsh8oXtYyV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di80UGdQZCtUc2E5Q3FxUkRkOWl1U3lJWkRBeDVkMDIwa084eEdrRkZCS0lG?=
 =?utf-8?B?Qk14dXA0YkF5NTAvb0JDTDMxUm9hOThsUXlEWUI1OE1hTFAzYmJlOUIyc3lr?=
 =?utf-8?B?QTFjSUtOM1JWUE1iYWhkbkVGZUpBZ00vQU42dVZpTGJMcUw1K0xlaS9oYSs0?=
 =?utf-8?B?amN5QzdCTGNWSUtQd0VJcHZVWFluS3BHZFd2RFpZWGUzUHUxMC9Scjk2TndY?=
 =?utf-8?B?cDVZTHd2UDNISGVtZHFMK3ZVS2lXSm5vVGFVaWYwZkFtMWJhR3lXcHN0VTFH?=
 =?utf-8?B?eVdQQ3RQTnFLc3VGdDVLanZQTHJnQ2UvdTV6YUp2T2prRmsyZ3VacVo0ZDRu?=
 =?utf-8?B?ekF2VWlIRDJ1a1VSQmczQUt3QVBrYnBrZmNjK3FKWnZ2OWJOdk5LWjU4Rmtm?=
 =?utf-8?B?NDh0azBXV0hHKzFnZlF0aEFJQ1I0YmpzbS85cHRudnFQRnBtc2xNSThRekE0?=
 =?utf-8?B?bEo2bWVOVTBLMWtoVU5VNWdFQ01KNHZxNEJaOExhNjVqbzlDallwRDBRUlFY?=
 =?utf-8?B?Y3BUTVZpZXhDZ0VlamJHUTY0cSs0Ty9BR1dlOWFtVkJyRlYrRlg2YUY5RFhN?=
 =?utf-8?B?UnVyMzJMYUdHZytRd1hkVXMydEE1dDlXdnhBRjM5VGIxSnpZOXNVUE5qTnMx?=
 =?utf-8?B?ZmI1NXZxOElFN1ZxVm9sQjEvM3AzNFQxZGRLbEFRM0UrYzVrQWx4OEE5cGlo?=
 =?utf-8?B?dkJab3hqYzQrZkoreGxOZkZRc3A2c2xTRTF4amdhSnhnY1MvVVppdGRReDlU?=
 =?utf-8?B?ZDlvV01QN2RxbFlZQ0VILzZOdDlBa1B4eXc0VTAwL1BWdGF4bjFQYWJpSXZu?=
 =?utf-8?B?eVlkR05QRWVSSElaL3FSSzB0bHlGU1BBVkVOVUNyTU1qZEZ5T2JyMHpkdVNP?=
 =?utf-8?B?SWdYaXBqN2VaRG1ZYXJJOEY3TlRkOGRJL1NxVWUzU0l0cGVZZ2ZEaURDdEIr?=
 =?utf-8?B?MHlHMGpYMXdCUStHR3dQRE81eE14QVQ4bk1LYzgzTVhtWGhKQUdKK1Bic0RH?=
 =?utf-8?B?YXZZSUlMV0FIV2JxdmtIaFpYR0ZoMDVUSFJ5SHFaOUdlT3VQWHFTenB1M2t4?=
 =?utf-8?B?Z1RPcE5ucW1aOGVUQkRiR2UxWWh3ZGJLM1dBUGZZTldxeFlHL0V5TGRpYVdx?=
 =?utf-8?B?NTVaZVBSMXQvWThzaWpUU0xEdzk1YTd3WUpxSUVva3RzUERZUkx1UzJyc2ps?=
 =?utf-8?B?d0dxcWl6QWJQamR2dG5zSkNuRkVyMzNudDEzT21DdzdDZjlyYnI1QkcySnJt?=
 =?utf-8?B?VmVjdlgyS214NXRXSzU2WmxNNVhSMVBQRkExbElqY2hhT2twdUgrZmZhYWNq?=
 =?utf-8?B?ZksrUXBFRHQ2VFl1bGZZZlYxQkIzK3NWQjJLd0xpaGMveXJCOWlucFlka3hG?=
 =?utf-8?B?eGJndFhTUm5XNEpkS0hQUkYrSlJRSWRpSG1aR25xbjhrcjdxTjNhWEVaSzVB?=
 =?utf-8?B?Zm9FVU1DNlFFRFVzbWJrWXVKMWZmb09vZ0NnbWZGRnYrMlhoc3RpRkp6Rm9t?=
 =?utf-8?B?aHQxSCtjaXlDZUYveFdHRlZsUkhDUVNzWVNlQVl0RmUzVytveVNQb0YvbGt5?=
 =?utf-8?B?UnNJQ1FocVN6WSs5aXp4SmVyWWlDZTNEd3R4TkhrUmNEcGlWTHhNTk1VQUVy?=
 =?utf-8?B?S0E3VUxhRjAwM3NnRmVBbk9HdW1mMzV4UmxiOVpRcVkwekNyd3RnZ3NBa3Z4?=
 =?utf-8?B?eWxNSnY4OGo0ZStGSTNZTFl0WjJZT2F0NWEwSy84dW9KU0pqUVdibnNKVHVl?=
 =?utf-8?B?REZMUjNzckk3Smp0ZEZ0SFJxNmJ3dFQxQms4UzBnYzRWdUJGNmZmRHA3YzQr?=
 =?utf-8?B?bkFwVGJ0VElYNHRFSy90MmZCTW9JajRodGVoZUZ4ZUNtOVRrS0V5VTMrd1Ix?=
 =?utf-8?B?ekNyazVvcXhqUU1hTnUzN0NMOU1nSDRTTEZUQzEzdjdkcjVsdzdEeExGdk53?=
 =?utf-8?B?RHdxT3Vhak5yQ0cySVpQK1B2WHhvTy9QWU5zbE5BYlJGdWkvQlZoRFJUcDhW?=
 =?utf-8?B?YTRqL0hCeFdTbmxVOXI0azBDUmpoQ3NFckIzZXJITzEzakRJSVhNYnlyYkdy?=
 =?utf-8?B?Z1VMaVZIb3NTT0svNXNCclR4VW4rU3ZMV0JaRW9XdDhPcittcW9UOVhOdjJw?=
 =?utf-8?B?c3RQNnNaYkR1eEVrRXdjcG1WU2puWU5aeCs3Tm96clY2bWVGNGxYVDJzbnF4?=
 =?utf-8?B?SGxYa2pkT2dBQm1uQ1J3NVY5bzZHM256YWNWRkQxSmhMZC8xY3N4ckFneGxW?=
 =?utf-8?B?akY2VVczUXMyN2xkamhFR1lyTlhwclFuZWIyMGdicFV5ckdoVXFFdnVyYjRY?=
 =?utf-8?B?MXBleVhudXUvL0twVGlydllzckljcFRhNkpoaHhLRW03NlhXbkZkbGU4cXVB?=
 =?utf-8?Q?JhSvZpQrj9DmcG/e5/tlwJQZZGL+0BXO33A1k?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fc0b85-5609-40ef-d8cc-08de9fc011c3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 16:07:21.4831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEkGvvFBXkru5k+ZYDwyU5CDuOSXtl5YDQ3tEfH9jj6YlgQjN3HQN879T+kyOxa+62gqZL5KQXs5Rgo+jKjn4AL5dmWGeWXelmjMfR4Smvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
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

Hi Marius,

On 3/16/26 7:15 PM, Marius Dinu wrote:
> s5p_cpu_id used in drivers/usb/gadget/dwc2_udc_otg_phy.c is undefined on
> platforms other than Exynos.
> 
> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

I believe the reason this was not picked-up so far is because you forgot 
to add the right people in To: and Cc: recipients of your mail.

$ ./scripts/get_maintainer.pl -f drivers/usb/gadget/dwc2_udc_otg_phy.c
Lukasz Majewski <lukma@denx.de> (maintainer:DFU)
Mattijs Korpershoek <mkorpershoek@kernel.org> 
(maintainer:DFU,commit_signer:2/1=100%)
Marek Vasut <marex@denx.de> (maintainer:USB,commit_signer:1/1=100%)
Tom Rini <trini@konsulko.com> (maintainer:THE REST)
Junhui Liu <junhui.liu@pigmoral.tech> 
(commit_signer:1/1=100%,authored:1/1=100%,added_lines:13/13=100%,removed_lines:20/20=100%)
u-boot@lists.denx.de (open list)

Try to send a v3 with that fixed. See 
https://docs.u-boot.org/en/latest/develop/sending_patches.html. I 
**highly** recommend trying out b4 (https://b4.docs.kernel.org). See 
https://docs.u-boot.org/en/latest/develop/codingstyle.html as well.

Thanks!
Quentin
