Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432B6D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 04:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D60980050;
	Mon, 15 Dec 2025 05:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nXq2y1n5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C33800B1; Mon, 15 Dec 2025 05:54:24 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AD68003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 05:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fa42NOCkvVAALjBPsOKTbXtPRslXqt1VrQBBUrEDG7yBCR9sEHqmbT7ouJ00w1QogVXItB/UCSCMMIRuO7pi8RsVaU0L4UeUU3b3z3hTZiFbBnjrB7+wI+F/PpTG0MgGzA4fFuBJedm/wkZTixAfvrCTF6uEHUSXLSLNFH7YowMJ7MgjNaHBnHRToZKBE1MwhcNeTvGRZ1jSRQfw/vnH3Zjybd5a4EFjfCTFDTvIsF8QWZcGsuJEbDHiZXDnr5ShC2glx1WC02Z6bFIdupR5Ha1o3R7sSWgIgCVPPJvFYX9PlFv8W83+LY2Zb/vhsud3oTDpIQ7iMKIiSUotoD+/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuBQOTKRm21e+2qrMhZ/TETUS8ABpTRN9VXIAyyqiRA=;
 b=fwFS9rgnP4I78iCcS17pz3Gp13S0Tni61k84OcKlSBLWIpKnrd/EVd0e4gXt3O0d52jyAI9vkCZeXNKGE8pwFn1hdd2wesukmmaPfvoiPM/nGX6iQeZTluAnuxeahjQxKaoLZrdUIM8uyQDOrEISMP+nBN2eXj122lxqpkP5QVaGXwX7TqLcEFz6fHUJeJbvtLnsAgphuMyb5rqJvwdnCf97YV9XNFlRSiAQNVMQRk9A4w+ggTOKyfAN2RzrvoKV4que8B3q5UsAinfoA2VqEQL95wa+inazirgy04XDfcs0aihH9/nR7BF7jTbTpdQWqh2vku2tDkCI5NhUsJDLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuBQOTKRm21e+2qrMhZ/TETUS8ABpTRN9VXIAyyqiRA=;
 b=nXq2y1n53iMkfngro9uHzMWa3+raX5G/iNV6YCVoamgzjf+8kIH9B1XeBQBrfEnv7o40JuIoNOgaY4pFfIE7G9ugovInxM7ig4TyAKkn81/THNgyF+vKFyEidsloYc9NaU/hUIrFTzLQ4O9Ys+rzOka/l5mgRO2ZW4h52nhtnsgW8tEZBV8R9qSQGhX+5N+ykAiE/fZ8KgHnu/QakaCNODGJ9e2ZT5a/zhZ7nUf+yg/yNzQu0+FuJ3lKa5QWA+Ali10XhS8D0J8zyt1ieBXvMb6EskuqLCzVM/3Dbjhynf2d+Wc2F9+x68ZNVCFMMdtu1/dymA4yqsHUGIwujxJKgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by CH4PR03MB7650.namprd03.prod.outlook.com (2603:10b6:610:235::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:54:18 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%3]) with mapi id 15.20.9412.005; Mon, 15 Dec 2025
 04:54:18 +0000
Message-ID: <634d1a35-19be-4731-baae-3bb66d1656ca@altera.com>
Date: Mon, 15 Dec 2025 12:54:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] spl: mmc: Account for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
References: <cover.1765470899.git.jan.kiszka@siemens.com>
 <d9fd61b433a5101ed019029ba554c5900140fdfd.1765470899.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <d9fd61b433a5101ed019029ba554c5900140fdfd.1765470899.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|CH4PR03MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 655b0855-12bc-44f3-352b-08de3b96010c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG1Wd25xenFVOFhFWllMblJhb1A3aHVKUktnK1ltZlZIRTU0K3JkQWpEZXRF?=
 =?utf-8?B?Z0lheXJjNFYwdllSQU9aYmNPeUI3dXg1djdaTVROcGd6UWczaXM1RE9JeTh2?=
 =?utf-8?B?ZExsU2F5Mm1uTzUzVy9HNVd6K3lud1AxQUFWM1JPTE12ek01Z3p1MkZwQmVB?=
 =?utf-8?B?WHFVS05WOXdZKzZmQm16ZURvbXZBVDNjSWRuMGcxNGpoNGdKRHNzZEMxenZx?=
 =?utf-8?B?Rm1rZXFLd2hvVUErckRNMjY1dlRaN1FrNGhReVRGNTI1L3lqdXB2c3JHdHNy?=
 =?utf-8?B?UWFCL0E4UWhvQTM3Sjc3M3ZGLzVnQWFEWmxYNEVVV3g4NHZ0T2NXQW5tS3Vl?=
 =?utf-8?B?YlhSWkxDcmZiUGY5Qnc2SWJtM2trV3hqMmRxN1Jub2M1aTlOeFl1bGJoYzhK?=
 =?utf-8?B?K1dnajF4ZmhXSXJxRVZmZzhHd1BNbU43cHlpVFRBSzNGZHU2NWRLdDhDdWY5?=
 =?utf-8?B?ZkJJcVo0NklzajZKSGg0VkhqK09ZWG1UcGRjME9OajRLQWpCS0tNVHlzUUJs?=
 =?utf-8?B?czUxVlgyNnBQbjFNMGVGVmFlcWhjYzF2V3JSdHZLTWRQSno1UXYzOVRIVFVM?=
 =?utf-8?B?c1RKRmtHUnBmakk4dWxhZTUraDBkN0tVVkRxTFlvaWRManhZczlaSU5VYTYv?=
 =?utf-8?B?bSsvOWdFdnJ1QWQ5dFgwQzRkYkFZaHBXMnh4clFhT0RGTVNCSnMwK1VIR0Jk?=
 =?utf-8?B?ekJRZzBBWWJxdGRTQnlMSEpZZHo1dzU4R29NeG8zcGtxd0pGM3lianU5OVJC?=
 =?utf-8?B?WkxHTytFdE13UGF6SEhFMzlUcE8zd1F6djdkc0Zzd1dsQjFGTXVOT1ZKUHI2?=
 =?utf-8?B?WXFhU25MNmM4NXhMNWpKV3ZCdjkzaGdMNWtqdUt1dFkyOFFDRkIweEZQTzlp?=
 =?utf-8?B?MzU2bEI3bU4yUGw3UHhyTnl3R1hBY043bzQzNCtuTU43VGh5WVA3RThXY0lZ?=
 =?utf-8?B?NjVsQUUvU2p5NHAzRUsxOEd3TTdZajArc1F4ZG5ybFl3MmhYVlc3WDJsRlYz?=
 =?utf-8?B?ekh5S29RV0lYeXc2L2pEZCtUMDc5amRscUdISXdzOUZMaDgxWGdIK0FIdCtK?=
 =?utf-8?B?c2s4WVM1RGpWSktxa3NtSEp5L01JSWtUcUdZWmJnQkVpaFVIS0FLbGpIUjFU?=
 =?utf-8?B?MVFFaUpOZS8xaTVSdjB5L0pyUm9SVFVjeGRwWnlYQ29KeWd4djhiOEYyeWRk?=
 =?utf-8?B?K0l0SGwvbXMvZkd4TUc2bXBGSjlLR2RzMXJiTytrK0U2MmlJYkVPcDRUTDll?=
 =?utf-8?B?ZWNRQjByREpWV013WGJiRkpvZVVOK0I0cElFajJvd0k5TjJwMFpjbTBqTXNQ?=
 =?utf-8?B?SkNuY296TFZoN2lEYzNFcGFHMVZ2K0tmemFyZlNNT05JTUZCWmRwSzI5em5h?=
 =?utf-8?B?c1Rsd3JMNmg4UWcxbCt1RjdRZ0dZbWNmVEhKMGMxeVFUUkgraE9vbmhOYkt3?=
 =?utf-8?B?dGNxMkFtYy81N1I3YVhxN1h6UU1kajRpQjdNQmgzMk5rR1NDakVhM21uWGFW?=
 =?utf-8?B?MlpxMHgzZUZ0YWlOdmJSNDI1MU5sZ21MRFJDVnp3VDF1bGkzK2JWYVZiQ3lz?=
 =?utf-8?B?TEpYQzlsdWtzbTByU3ducmY1MG1QYUlXaTNNR3B6TkVsdlp4cFJWWmxXUGZw?=
 =?utf-8?B?aHhKODd6c01XMjg1V1JPcTYvTVR2TmUvSU9WZHlLT3B6NHBtRVVvMm51V0Z0?=
 =?utf-8?B?TVhNd3dJVUM3SjFlVFlkR0xWTkU0QmJjZjdZN0FYeDgzbmdQSjk2TWVaQkth?=
 =?utf-8?B?MnRCY1pRdkx6b05xV1Y1dm4wQ0NYVjQ2OVNEZHRySDhjb3BMODlYQkFhZ0gw?=
 =?utf-8?B?VUk0WC9YWE5QRm5WMmxiZFdJUGV5MEVLVHp3eTdlZFdZN1VmTWowSWVsZHhH?=
 =?utf-8?B?TC9yMTZ1ZXoxRGZoeHdMR01YNld6UUJ5S2RsMUR3OUVTSnF6K2pwdXB6Ly9k?=
 =?utf-8?Q?CmR3wOCcUZWZm/+AS2Zj6d6Xj/wtZ3Gi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJrQjNCeHpEUnNRUjVYYWJCU3R6YkxoVlBqWVNlRmhudjdSY0hQV0ovbkpD?=
 =?utf-8?B?eGVSOW96VjJHYzM0KzRYSCtyYVVQOHhtejlxS250VDdvU1kxSG01UFJaRXlQ?=
 =?utf-8?B?c1NJa2NEL1dSRmZ3aDlxMm9Uay9IM2lUY2JJdnI5MnZGc2lybU45Z3Fpa3hr?=
 =?utf-8?B?cmlncncraVRsOVhQVDVDUWQ1T29GYXgrVExrWlFkK3J3NnpFY0tYdTFpYk9C?=
 =?utf-8?B?WGdqV1dKQXZRdGFma1BDMHliWkptQWYxUDZ4ZUROVVF3Y1ZUamFqRlk0TDRn?=
 =?utf-8?B?Y0NuTnl3cmFoZDNxSjN5LysrVXpXM1h3Uzl4S25KbjB1UEhDUXN1MmFtUVdG?=
 =?utf-8?B?ZG5UaEltUDlYelVTNGM3aVZ4Y0JjL0pDWUJyUGd1M2RKSWo3cTdlMmxmaEY2?=
 =?utf-8?B?dk9Ta2FsZlF5VFA2dC96VjBreDhjd3BaV0NxY0sySGdNRFJvZmZYKzdBUlRi?=
 =?utf-8?B?YzBFNUJCNDlkbldHNWFCWllWeWFWTFRRamhRWWFLWG9YcnNhRysxUGdGTHA3?=
 =?utf-8?B?UG8wd0FRTTltK0llUmVwMlVoVkxCamJBZ0lRekY4ZzUvSHZRQnV2aFlkazdP?=
 =?utf-8?B?ZDFXSDZRRjBRTHNLUGpVZlZYRFhoS0owN1F1WXNsakxaSUZNcmk3MUJUa0gw?=
 =?utf-8?B?THc3TjdFNi9KVDdLRHVyTnBPcWhITkV5R0JEclhEUk5HNjBiWWVDcUEwNW80?=
 =?utf-8?B?ZnoydENmcmYwSlVnL3NxMXRzbHJ5Sk1iUWtjQkJ4OHZSNno3MlpLOG9Yb1E3?=
 =?utf-8?B?SmFqQ1p3N1ZhMzdxdEU2c3hGNmVnWFF0cjBtQ1M5dnNDZXlCNzFHMG1MMVBn?=
 =?utf-8?B?ZkpMY1pOVVNzR2F1eWsvTWFlQkM5VFNTUFlpc0hXNGxITkZFN3hXcmpROXJH?=
 =?utf-8?B?RVoyRG1HWklJODJ3c1Q4c1pzZVV5elNlMkVycVZ0KzFoREVkVHNUTEJvNnVj?=
 =?utf-8?B?aDZSeDQxcmM4Wi9zUlBQM3N4aXJtVmw5d25aTGkwN1AwQkZaOThvSWxIQTJT?=
 =?utf-8?B?Y0w3U1JEejUzWkdRWndlMU93aE5oRmdaZWdENEg1WlZuNmdWZFNZY2xXVTBo?=
 =?utf-8?B?N3VUbHZRVGdXa2VKK1JYaEp0dDNHOHA2OTZ3Q1JkbzBBa3JqZE92d05mcEk0?=
 =?utf-8?B?R01BWUVPcU9CWFhyWUJzQThPaGorbUxNc251d3RoUG9ZZS8wYXNhOUtnN28z?=
 =?utf-8?B?bUxmcElZRGgreHg1UktxUzFIYXJDUFUvbDhUU2tZWEVodXhOM0oyb0drOGZX?=
 =?utf-8?B?UHM1c1RQbG53RkJZRFl5VjdPSkpqelNwcWo4RXZ5cUM5M2VRVlBRdXcrd2Yr?=
 =?utf-8?B?ZXozeXBjTVZ2bDMwSHF0WS9oTTVaa0ZuT2t6Y3U5ajBYY21YUEU0N0xDZ0Vx?=
 =?utf-8?B?Y0pJU2ZqSHJzWkdBa0hyRzBpYWFJOE40U3VLOWVWZmx6bjhJMFVjOGo0cXhl?=
 =?utf-8?B?djFkNnNLMGFMTTczQU9ZZGcrK0xTQ3BNc0dhSExmZWwzTTdqY2RiM2lUMUI2?=
 =?utf-8?B?bUorZS9zMlU5TjVNTHVzWlhBMERJTU9tRHRPbnY1eUdMUWx3bWtPVnBYa2hw?=
 =?utf-8?B?M1Frcjd1WENya3lYWVZBSEpXOGFybC8weWovc2RaK3hDVVRUYzQrc1d1RHNt?=
 =?utf-8?B?RDlrK21CM3FWMW1VbWFIdUtrZzJsczYwOGlnbjMza1l0OTFGa1V0VnpTcnp4?=
 =?utf-8?B?b0tYL0N1YzBHWTBvYjd6TnFPalAvdFF1RUkzcmh6VTJlc0dDbzVrV010cmJM?=
 =?utf-8?B?QnRCTFJMRHcrRnpXazdldCtVTmo5OXFRVlRraElqNEpkd0Q4VzBWWW43TW94?=
 =?utf-8?B?VlRDckFGcnR6UFN1Mkw1MU90dVA2YTFVcE9UNHlacHJ4MjUvaHBNTUhwN2RC?=
 =?utf-8?B?V2NlU0JYelNlRDF2Y0xhNXlwL0tSclBBTVJJazZZdlI0NHdZNnovcTdkMHRM?=
 =?utf-8?B?QlpMSW42Q3JETEMvKzF0dXU1bzRuUEtCNWYrVkNIbUgzRlJnUGl0cjdwaW9M?=
 =?utf-8?B?bFUxZzB5YlZxazErbTdpTlJtU0J5QjlhQ1JQQ21KRnJsVDNoVWI4ZW1WQ2JW?=
 =?utf-8?B?c2xJZG0zemRMUG82UlJyUVJSK1hUaVlmYzNDbmdpSi9NMk5hN280UEUxTWlw?=
 =?utf-8?B?b1Fqc1lrQWN3VnNadkFPclFIVWZJV2JZNVdLQzliamhaQWQ3cE1iMHRpWVM2?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655b0855-12bc-44f3-352b-08de3b96010c
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:54:18.6438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGamlOcZZ8kVQW3pTWl0XdiJnMXxi0+2nla3StHJZ7ff6ggxjMb370ctdzD+PmmWyByrOBACvkFKBGP8aODIXQ7N/28TAbUtyJiQPST9tmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7650
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


On 12/12/2025 12:34 am, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
> far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
> by chance as both options were enabled.
>
> Reorder the #ifdef blocks at this chance to follow the order in the
> Kconfig menu.
>
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   common/spl/spl_mmc.c | 17 +++++++++--------
>   include/part.h       |  3 ++-
>   2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index d8ce3a84614..1942e417075 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -106,7 +106,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
>          return 0;
>   }
>
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> +    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
>   static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>                                          struct spl_boot_device *bootdev,
>                                          struct mmc *mmc, int partition,
> @@ -419,19 +420,19 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>
>                  raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
>
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> -               ret = mmc_load_image_raw_partition(spl_image, bootdev,
> -                                                  mmc, raw_part,
> -                                                  raw_sect);
> -               if (!ret)
> -                       return 0;
> -#endif
>   #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>                  ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
>                                                  raw_sect +
>                                                  spl_mmc_raw_uboot_offset(part));
>                  if (!ret)
>                          return 0;
> +#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> +      defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
> +               ret = mmc_load_image_raw_partition(spl_image, bootdev,
> +                                                  mmc, raw_part,
> +                                                  raw_sect);
> +               if (!ret)
> +                       return 0;
>   #endif
>                  /* If RAW mode fails, try FS mode. */
>                  fallthrough;
> diff --git a/include/part.h b/include/part.h
> index 6caaa6526aa..ba4a63ddc75 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -461,7 +461,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
>   #ifdef CONFIG_XPL_BUILD
>   # define part_print_ptr(x)     NULL
>   # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
> -       defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION)
> +       defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> +       defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
>   #  define part_get_info_ptr(x) x
>   # else
>   #  define part_get_info_ptr(x) NULL
> --
> 2.51.0


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

