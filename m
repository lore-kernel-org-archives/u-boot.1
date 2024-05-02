Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3A8C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 06:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E5088C45;
	Thu,  2 May 2024 08:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="kmDikNmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2076A88C6B; Thu,  2 May 2024 08:06:50 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB1988C3A
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 08:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWLdQqEw61s6PybvMXffrqFzHIVI+KKgEHppSPUu41YO4/ZrslNc8Wfe+16pIbaz2c37Ghgb+Q5yPJBdCnPSs/jRNpIOnhzjxackM7By4FwuX3NtvIKZmFId7wmytnlATGFDcEXodmVtGBQC/dOKk3b+Pb9WOMOP1Z4xYCPVALq18k+fYiIvT9zgW4Avq1yS/4OnSmHIJsGIPFFsVr63/WPg84P6qdm/CSy654V5WWNpGBqRFGJpzO1e/hWx1FmH6APA8WWswLf6Ia779WH18puR5kPf9hMNia/nnYKJwC/bPmn1tOCSOPDeFUJmqL8lQy7uBz8EtrJIgDfpnqLsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIRHaw87AFHCDPNNT1nzobRGYN9F0SdCfsa17itiCpE=;
 b=gnCGIBHjPd4KqiAf13gnaX1zW5E7DHJu+CmhlTB337VxJAlUYU+KG8fTszxrzf5kNQ3qkcUeRSowihHY4+w4HxTzHi6ssg//wF13KBGIaTJMUj6sbm3t77BGLH2uKwyBOUVkVr3NdHsmzrTX7utHs+xrqLr0z8UdOYTCyxahZ7MkGBltRDTv5rJGAfR/hB93dkZAmVpjuxVqmst5mG6c9ILyLJED0nJm7nTauK7t++SSVzdtL620wxIkrgg6V53aSLW1fyQO6OmKcYcpT0bxrMhBawtNbfRTm7VIYTyHKV1j8AG8Mc7Vc0hkHPwnKXvsRbU1JJMaDMVjYeN8amv/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIRHaw87AFHCDPNNT1nzobRGYN9F0SdCfsa17itiCpE=;
 b=kmDikNmbwJrV2HZ0WLJRdkGWcWRKaGbptggmCETS80dWsHqn8WCBXEEDkLC0djS7f6141NVIc05m7B9fxK1pE1i7GzL/lY8oSNRnO4r9MX/0OqtJ/ptPkCYup4A+LlC4F3McdwLM7s0BnQ+lfAWCvo55MV/CZGn570itZvBCbh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM0PR08MB5380.eurprd08.prod.outlook.com (2603:10a6:208:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 06:06:46 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 06:06:45 +0000
Message-ID: <feb52626-c8ac-4ccd-939a-ea0d7495fe3c@weidmueller.com>
Date: Thu, 2 May 2024 08:06:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] board: starfive: Rename spl_soc_init() to
 spl_dram_init()
To: u-boot@lists.denx.de
Cc: E Shattow <lucent@gmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Leo <ycliang@andestech.com>, Minda Chen <minda.chen@starfivetech.com>,
 Simon Glass <sjg@chromium.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
References: <20240424074339.210851-1-lukas.funke-oss@weidmueller.com>
 <20240424074339.210851-3-lukas.funke-oss@weidmueller.com>
 <3707b3b7-8ded-4c97-93fe-491da21feb0f@gmx.de>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <3707b3b7-8ded-4c97-93fe-491da21feb0f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::19) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM0PR08MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c992d92-9387-4a25-06b7-08dc6a6e0be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3kwa2ZReWZXN1FSdElVRXorYVYrc3FrelJGbk1oaStHOUJTR0RJUmdhR0la?=
 =?utf-8?B?NnVCTllCQ1lsbXRIRUdlTnhEdWNPUzFOTHFTZ0NYckttZHNURlhGYzdQRmlm?=
 =?utf-8?B?eXgwNXhaZVZsVlFGZ1pNbGxJb2NFWWVKVEJsNSswRGc4K2hLSHBqOWZXVjEz?=
 =?utf-8?B?T1djNU5mL1FSM1VLTDdCbmtoeHEzWDdYaDJVWWYrTGNQMXJBck9KQWUrdVh2?=
 =?utf-8?B?QWVOUlVxeExCTTcycWc4aW9hRG80cWI3R0d5cWJNMVU5VFFVbW9MTEVhMGFP?=
 =?utf-8?B?YjVFbDR0L1FZd0RBSHBjbFE3dkE3WjlabUZQSzRNdGdWN3B6a05ENlRad1dU?=
 =?utf-8?B?Ty9Uald1eFVldlE4VWVnZVpPTytRN0hVNHBiQWQxTUFCTDRWNWVER1E2Mlpz?=
 =?utf-8?B?L1VtMkFTTHh1WHpVOGh0WnRBMERpY01qcjZxME1FRnRJNk5NVjJDUnEwS01B?=
 =?utf-8?B?TjJtMzR0VFZFRUR1VkNFYVJJajkvZ3dmSHhmanNBZk90d1o5cXVEYVRZRkgv?=
 =?utf-8?B?WGl1V3BTdnF0R0orZEhDYm1MVVNBY2NRaHV3d3hWTWE1RklScExwZFU5SGhp?=
 =?utf-8?B?OGE5Z0x6M1NYQzJoWXJPVUV0NGFjRGVsZXhkemZScmpHUXZYZXNuOHU2VXdi?=
 =?utf-8?B?eVBTNml1NzBWN1BqS3FxMFc1NzJuV2RaM0VEZG9FZTBXamRwZkh3Z1NwNURz?=
 =?utf-8?B?dXZuOUcwR3Q0c3N6MVlsVWcvRFZUYTMvd2Y0MEk3cjFpbzNBc3diVGMzWkI0?=
 =?utf-8?B?aWE3bzEweGV1elE5WlFDNGp3b3F6ZjMxSjJnUklLbU45YXFESXh2SitoaEE2?=
 =?utf-8?B?YWlZM3F4RjJCeHJEakNQaDFvMllnNi90cEV6VUZGN214SHpYcFNIZnFTL2o3?=
 =?utf-8?B?NmJveEQ3OE12QXlyMVUwN1Urd2MrOXBMUFpkbjBaRURMd1JpcXdrN21uSzVJ?=
 =?utf-8?B?NWY5ZWxiazBNZ0dPZDJFcEt4SlNwLzBGSmFuNUhXWDRCRnhyK21jeFNaVk80?=
 =?utf-8?B?REtUWVo4UlhEelZDNU1wR0l4YS9FZmluMGl3RWcxd2hOUWFXQkJldzg1UjdD?=
 =?utf-8?B?aDloOGlJTjJaUW93MjBqdUtiUXhWWSs5Y0J0QjFPYUNkZ09KZGVzamxiQnVB?=
 =?utf-8?B?N3BIVGQvUnRyT3RMNitQQThvTXlpL0lyOUpUTEZTUjJBU1R3R2tjbmdEeG9O?=
 =?utf-8?B?SUUvbHdrcjFxUEFHVUlLT0VXZ3pVaTZwT1JxZGxkeDA1OUU2R0ptVHgwMGho?=
 =?utf-8?B?TjUrVEFsQWhUYXZwR2hMaGFScy9MK2k0RjBEMWxFeFlnT3BOT3R5QUsxTVR4?=
 =?utf-8?B?WWpCb3VXc09hYXBXRytrcStBT0hoUjg5NG1wS2Rjbk5VQzhMM0tuc0FGckJz?=
 =?utf-8?B?ZkIwblVPRFlnSmVZNGJEZnZYYThTYndTa2dLU2pQNTd3T0Vua0F4bWIxU084?=
 =?utf-8?B?ZTVPY3M3c1BxdUVQT1RjSXZSaEQyWjVTV05XQWVkQUptaXZzREF6VzdHOGNn?=
 =?utf-8?B?Tk9FemVWNnZYZFBNQXlTQytPWEt3NmJ5YzZSSVpWQkdjWjhQTUh3OUpNaFBD?=
 =?utf-8?B?aG5oTkd2aFE0MlZlQkZpTlhuQXJVUHMybHV3TVR4NWVGU080a2RqSzltOUhE?=
 =?utf-8?B?SHJUeWIwN3hHdytvQ1hpc0JtSVhUMHdOeDFpSTJsV1NMeG01RHk5MGFXVXR0?=
 =?utf-8?B?Ujl1TnZZSzAreUJBQ05HaWxJRlhoTTB3YXJqVXRsSWhVTUc0RnpITC9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJJTHZnMmdZd1g0ZHFYN2VmOUs2NllUQlJNU1c5UWpWYTFvdm5RaDJzbDlV?=
 =?utf-8?B?WWJ0S0hvMk1sSHhPRzZIcmlxSFVsd0E2RlpLZ0NqWVU5eDJNaERRZkp3N1Fj?=
 =?utf-8?B?NTVaMDNybGFOTjMxTTc3Tjd3RUVZSXJkazQ1OVVGZkp3eEdlcC9SQ09vUDYv?=
 =?utf-8?B?WlNKbTRmL0lNa04wcDF3QzcvWFVyYTdIL1lmMDU1WEZZRGZrU0YrK0RueEI3?=
 =?utf-8?B?T1dxdlhPdmtLVllwSHp6Y3NYWnVuMnNLbDA3clBTY1FWUWEzT3pxUS9sOGtk?=
 =?utf-8?B?ditWRmQwT2pHVmdVdHd0bHA5aFZHR0diSEp0WTNQNXVmRkQ3Zkh3SG1lQlNV?=
 =?utf-8?B?aEJPZ1ltR3pSR2FEUXlNQm5wbTBvc21sZWxobTM1Z1YrTUVkN3NsK1BPSEpP?=
 =?utf-8?B?cmVaQzlYOEIrTThMRU4zMDBhT0pFUXNuVHZTSVNLY292b3RuRlpFSytxc0FM?=
 =?utf-8?B?QjJXeCtWNElYcC81WFZtVjcyb3JVSm9zSnBzQ2pQK3RLS0tXUzJzTUFaV21N?=
 =?utf-8?B?TFJyWlQyOXc2VkNXNEE4V0J4MmhiM0ZaU0FpWjNOc0tzTVV3cXI0NjNMSUV4?=
 =?utf-8?B?K1pzeEpDTTl5eXhqTjNQQzEzV2Fvb09RMWdzZWluN25ybkdIaHhtTGcyZDFh?=
 =?utf-8?B?STRCYy9WbzRXcFQ0RUFhN010ay9FQ0FGelRkSzFZY3NQbjFFaTgyd0xSTlFh?=
 =?utf-8?B?R1RNUHNJUXlxcjk2V1V3UUMvcElhbXEvZmZaNkhxQTkrY0hjSGJ2S3c3WEVY?=
 =?utf-8?B?anJ2ZGRxLzE3VjlOODYxbEVrSElOR0o0K1RoWnhIcUIvNTZRSUxvUC9rbjNB?=
 =?utf-8?B?UnMyYjVkZWl5Q0dBUlpFYWgyYzJPSFRDSlVQelJUaFBMRWVzL051UkE1QTlw?=
 =?utf-8?B?UEVSc1JoQiswWlE4UEI5eERoREN3Z0lyelBCN1hiVGJFd3lwTW5iYkNCd0pB?=
 =?utf-8?B?dGgwRkorRzZDZzF3YnByU2dWSXBUa1J0alJQTmxPVThCSjRObkNQUm54cjl5?=
 =?utf-8?B?aVIvT0hQMGNTUjUvUGlrTHZhb3BEaDQ4MFV3RHhkeFNwb1VIYlJ3eXB5VURO?=
 =?utf-8?B?Z0VMM25EWWo1a09LREF0ZGx3cEpGU09CWFlVaCt5QVB1clgvVGovT2E2NDBS?=
 =?utf-8?B?bE5EQmxLVVZGbGQxY2lwSWVsRlJIS25lbExlL013cmI4ZENRdnIvTFNiQjBV?=
 =?utf-8?B?aWthTHJmM2FPSjFRUmhnbU9SaE9LZUdMU0F5dGVabVpNNHJycVE5Mm5paEpj?=
 =?utf-8?B?a08yd3B3OGlaWGloajBreGtZOHNlMW5kSys1THg0cWhPNURzSkFxS0tWcU9Y?=
 =?utf-8?B?aGZTOGJEVEl6dFJ5YmlsSFNSckVJbi9JQkFPQ3F0TmxEaExCdXlEd0J5VnFD?=
 =?utf-8?B?ZDJXb01IM1ZFdFhLWW4wVlRjaEtjU0h0MW5aaUxkcVZhSUZoZEZPTXcwbldw?=
 =?utf-8?B?ZHZ3RHNwMFd5RnA1N1pIdEJCazZEWTFwaHZDSlNMYVY2Z21FTFRhV0FhYTFt?=
 =?utf-8?B?RFk2YzFOUFk4aU96K2FlV04xK0lPdXR3WktQWmVmUnlPenpKREZqK2o1eFdu?=
 =?utf-8?B?b2VTaTNZbXBmeVpaSS9mMHJ0N280V0dFSlQ3azcwTEdOVmJaUDlJaFlkaVpX?=
 =?utf-8?B?eCtVak0wN1VJcEZUa0NDa2dlZnlFb2xsdVA5b2hZTFozZUp2VkpuTGNUNjAy?=
 =?utf-8?B?V2UwbUhtWi9xOGoybk9ZSzZPV0Z6ZzVIYlZWVHZBVS9Gc3lPeUQyR05FczR0?=
 =?utf-8?B?SGNPdTlpdDJjUXJNRGVMUkZuZ3hmamtWL2lNNWZyOTgzWHlhOWJIOUo4dE1W?=
 =?utf-8?B?bnNpZ3JocXRCVW8vaGJPSnJ6dzZXeENWSEFPNjFHak5oSHBHTUk1ZTB3NjZK?=
 =?utf-8?B?amlNam1xdUVHT054QVZudHIzV0ZrajRta0MrdGhrdnZqUTNNbGZad2NLMHFJ?=
 =?utf-8?B?cHJuWjZjdjZkZ0tmWVZ4WXpwaWN3NHRBSy9hSHAzWlAvNTR5NFYvS2dOekNR?=
 =?utf-8?B?dXBVeEtjZVRrbkpjUEl4SGVjKzNER1dSaUhRaEswR3RaRjlDeVlwNy90SDRO?=
 =?utf-8?B?WEhuTFV5TGpZMTlubEpJazNxMTAzUVpCOGwyeDZsMTNRTUhTdzdJQ3hrSGtn?=
 =?utf-8?B?aDlYc2xERDFmeUp1YjlaOFkzUzQzY3hHS0dtaDhNUUdCa2ppODdSdDVFUWVy?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c992d92-9387-4a25-06b7-08dc6a6e0be6
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 06:06:45.9233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnQ33bpLNo94Ay+G2s9k0hUrNzbKo9GpgdrmOwjGTL9SXYP/SLG2KB7WUh3+d2Akx8j6vGAf+4C2jZLNCT2NWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5380
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

On 24.04.2024 13:01, Heinrich Schuchardt wrote:
> On 24.04.24 09:43, lukas.funke-oss@weidmueller.com wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>> Rename spl_soc_init() to spl_dram_init() because the generic function
>> name does not reflect what the function actually does. Also
>> spl_dram_init() is commonly used for dram initialization and should be
>> called from board_init_f().
>>
>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
>> ---
>>
>> Changes in v3:
>>   - Reorganize patches such that each patch can be built individually
>>
>> Changes in v2:
>>   - capitalized acronym DRAM
>>
>>   arch/riscv/cpu/jh7110/spl.c              | 2 +-
>>   arch/riscv/include/asm/arch-jh7110/spl.h | 2 +-
>>   board/starfive/visionfive2/spl.c         | 4 ++--
>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
>> index 6bdf8b9c72..87aaf86524 100644
>> --- a/arch/riscv/cpu/jh7110/spl.c
>> +++ b/arch/riscv/cpu/jh7110/spl.c
>> @@ -28,7 +28,7 @@ static bool check_ddr_size(phys_size_t size)
>>       }
>>   }
>>
>> -int spl_soc_init(void)
>> +int spl_dram_init(void)
>>   {
>>       int ret;
>>       struct udevice *dev;
>> diff --git a/arch/riscv/include/asm/arch-jh7110/spl.h 
>> b/arch/riscv/include/asm/arch-jh7110/spl.h
>> index 23ce8871b3..d73355bf35 100644
>> --- a/arch/riscv/include/asm/arch-jh7110/spl.h
>> +++ b/arch/riscv/include/asm/arch-jh7110/spl.h
>> @@ -7,6 +7,6 @@
>>   #ifndef _SPL_STARFIVE_H
>>   #define _SPL_STARFIVE_H
>>
>> -int spl_soc_init(void);
>> +int spl_dram_init(void);
>>
>>   #endif /* _SPL_STARFIVE_H */
>> diff --git a/board/starfive/visionfive2/spl.c 
>> b/board/starfive/visionfive2/spl.c
>> index 45848db6d8..ca61b5be22 100644
>> --- a/board/starfive/visionfive2/spl.c
>> +++ b/board/starfive/visionfive2/spl.c
>> @@ -285,9 +285,9 @@ int spl_board_init_f(void)
>>
>>       jh7110_jtag_init();
>>
>> -    ret = spl_soc_init();
>> +    ret = spl_dram_init();
>>       if (ret) {
>> -        debug("JH7110 SPL init failed: %d\n", ret);
>> +        debug("JH7110 DRAM init failed: %d\n", ret);
>>           return ret;
>>       }
>>
> 

Any objection on this one?
