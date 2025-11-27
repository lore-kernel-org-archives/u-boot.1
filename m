Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448E9D10375
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 04:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1CA3842CD;
	Thu, 27 Nov 2025 05:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BaYazTA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F41842D7; Thu, 27 Nov 2025 05:34:47 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E34C842C4
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 05:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yANLSv2RRUlXPPeS83jBn84v5GCDFsd6/NT5vWQUlX1EGgxiIuy1oKqgFyjGPjVZa+p6daVbappygphOFQXnnOsll6ue/HMX1Hd4rl6TQBRgSPW2WPIoql/HS46dw3JBfWWDt33pxQPcf7YJ2q3SPy+OFhARG0Rh4NLI1AAohg4+13db243DMVhTnxAs8kfMfmjRkbmQtTdfG1p6blZiieqRZdLn8ekAcjOWJ+SnMCp6xr0KmXBYRYeEJt9aOmmZ23JHy10ZyP2OJcKH7drLXCJSiT7aExdBZUvCB59eeFcCU1JXhhI9bNPD0g4vHEWCtaW9khmgkHX55q63aOE7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSTUbqbbPgCajwVp9KkApSM08zjrImUlGI494L2vADg=;
 b=VCy+aVGGy1x3822WvwqG8klmNbuTWEo20eEOGpm+Lk9d9weS7Dhwb9FmrsLtAFd0SytTbf5kOeXqvCa5Yf1vjIzYznpOc74SCE/tyTir0/3oBQ0o0ZdJ80mHdGuSczS0OvL55lptB0XMKo6DvI5RejwrbUzzG9csc8OXtcsIF1fn0B7NajgwYcetoIr/zDYlTV09/1SfUeOsFCuFNUpC69qqXwNes2AV1UyuEpO57Bbn8ielCrXWUu9Ihurlm/vmfv7Ivc+PUrJ9G1oe0QmV55iGVh1jQTCgDBNQ9BATcjAHhmPmVXS/jOFk7vAU1cvv4KJp8ik0DQUiD2coU0yIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSTUbqbbPgCajwVp9KkApSM08zjrImUlGI494L2vADg=;
 b=BaYazTA0RsApq2dmGiMRAMq6RHBsHDjJVh9rf9M7YWPff4YowolLy55kaL9fI+F5ruEJNKfR3xdSs2KjQhmQkAiwxTSxoKhR0RrYbfpEiNrgORkVBlIAYg+/l6CNKl5/GKucoFRzrXOW2GrQXkJAJM+fBYB9gmZcVcq8HLqF/cHFj7l3Qr3BR3Wvw+0wnQnodObFWfUIjaqZEoQvL1WBi1Y+gxr/R/mVdd0dLawPppsU7vn6upVGELqLAObjXTqFVxxt9fkzcdbiSnlu4iaB4UhHf3cA7YGNd3x8/k5bBcqsSO7CQ0sHsjaX9eo/jcm5gUj2c3SgYCsleK29fKKc4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS0PR03MB7776.namprd03.prod.outlook.com (2603:10b6:8:1f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 04:34:40 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 04:34:40 +0000
Message-ID: <c7aa568c-a13f-4cee-967b-60da19040ac3@altera.com>
Date: Thu, 27 Nov 2025 12:34:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Jan Kiszka <jan.kiszka@siemens.com>, alif.zakuan.yuslaimi@altera.com,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <808832bf-e185-43f0-89ba-58941d2535c9@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <808832bf-e185-43f0-89ba-58941d2535c9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DS0PR03MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b19209-d4ef-4189-298c-08de2d6e4725
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTdmRmo3bE5UOFpJdlA0bURybXVsOVBLZHhJNjFPZ0oyTVpmQVZkcXpxeXlu?=
 =?utf-8?B?RWxhVnV2bFJ3dkZoVzQxMTBvMngxajVEOFFpZlZJZis3cGQ5ZGFvdnlJZDNJ?=
 =?utf-8?B?N0dvVFM2NGpKTElkZVlPMEI4L3BlY3QyMXMzdlNscStsVEdYT1k1Wkd6UGly?=
 =?utf-8?B?T0tYSDRHSTB1TkZURWVaZG5PVkdLeG5iTS9ML1JHRHFUSnVYeW0xQUtHSHpi?=
 =?utf-8?B?OE8yNjVyRFpVZWhCMEpsRkFQbXI2cWltTTd6RCtsWTFrd1ZYb0lYWkJQOHdt?=
 =?utf-8?B?NkFJM3FCbGlaOHNPYk14UnFPYWZMUjVHYVBqMEZzcjdObUhtUW1EWnlHK000?=
 =?utf-8?B?ZnZtdmJFKzY1Y2JtOUtCTHBDM0k2Zkl2RWdrT0JBNlpZNldmM0krbFJjbE04?=
 =?utf-8?B?OW5ySm43cUtmU0NVRU1rcXlwTDlGaGZ3Q3l4OXJTelNaVkV1Q01SYmlFQUF5?=
 =?utf-8?B?NGF0cWRIc2wxRDF2aXE2bnJ4VE1MenhzU1F1ajJSaFpqTkxRMzFINE1iR3lS?=
 =?utf-8?B?aURoQUJ6TlJRN1kxVTNXREd2aG5PYis1VGllbWR0bTdkS1RxZXBmYkl0M2hV?=
 =?utf-8?B?UktIaVBGckxFbnoxU1dsYklkd2diL0dBTzVLUklReDBuNVBCcEJaVW1nem1Z?=
 =?utf-8?B?TVRZQkJaVFNUVDgwRXhvNTB2allmTUZ4VmhMaTd2eFNiRmd1clFIYmJ3VWZI?=
 =?utf-8?B?cjVFOXBqTmRDQWVzdDVTaVR5T2NZSjJhdnRBQitjblFrT3g0Tm1ISXJjcEJP?=
 =?utf-8?B?TWt2Rk9IL2VQYmVGY1E3Uk5QaGxwKzQ3cWJSUHNnYmlaOCtvZVFPeUhtVndz?=
 =?utf-8?B?R0NwOVFxWkk2VHNsaFFJWHE0QUhlOTh5U2xxejVFaVFyb1RWdXVBa0l3Vkda?=
 =?utf-8?B?Mk50MkNzQ2puNXVDVFhiOGNTamFOK2k1cFBsRUVuN2tyaXJRbmVLRXFsajRW?=
 =?utf-8?B?cTV0aG9OU0U0SzJIOStrQVQwa29qbDFkRC9yNTdSSTZOMll1cHV4Z2RWYVIw?=
 =?utf-8?B?M3dHdDhQVWdCeGtXZXBoVUVXdU83VDRTMkpKbHNER2duS28ybUlGd3lkSzAv?=
 =?utf-8?B?TjBac3RlcUUwWjR5cDZiR2R4emt0Z3k5bXladCsyWWkxelJVL09RYXU4ZGlv?=
 =?utf-8?B?NWZycFM0aUJGcmtyK0lqTy9hWVgwWDd2NlpnS2ttM3AwT0JoVjlzSjRUMnQx?=
 =?utf-8?B?VjRjd2U5cEE3M0lranZXQy9pZTdjMHZsYVpJb2pHNXQzTVVnL2tFRmFGbHR2?=
 =?utf-8?B?Y3ZrMGdzTFh3aHlFYTdNeDJ4c0dpV2YvOHJwNnlwcEV1TzdubHAzei9zaGEx?=
 =?utf-8?B?eEcyejFiWE5hc0diSnZERlZjTnpBdTBEbHJmVUVwK1JhbnVldjJnRFp3anh3?=
 =?utf-8?B?T3pxWlZndVZRemFuYVpWeGQwT2lRdURuTW94S0RON3I2WjZLMy94bGZSMnp5?=
 =?utf-8?B?Z2JUd1JPU1NTTkIvaHJoMlZxcDJHNEtDTi9qNTV6ZEFUcy9Ea3lTNTVUK29J?=
 =?utf-8?B?L3VFYnVQZVBpNUtkRXBJM2t6eHFtZjB0b1d5N2p0eWxzV05YVHYraWlQTmZT?=
 =?utf-8?B?UVc2M2JNdi9PcUl6Q0NBV05kN3d4Q2grRSs2YWVhSUUrWFVFM29VQWNtUXV4?=
 =?utf-8?B?YW9oaEZ3RWZvOHdIVEJPVzV2YmRza3JlMHdPVUhmQW16Tk1WTU1hOFhsZldL?=
 =?utf-8?B?KzVrOTg0cEZ4NGFVM3RGd2N6eEtEdndkWVpoRGdST0VOSkFMdVRvVWQ0OS84?=
 =?utf-8?B?aVNlS1lIcE83bWRmRTBGM3NGMnc1dVdKSHdtZUxjc2Q4dWlzVE4xUjI3NzRw?=
 =?utf-8?B?Z0FtSWp2bjFQU2haTkN1RU9YQWVmK255Ry93RVdGM2xBQkNqVXdHUlRMUE00?=
 =?utf-8?B?KzFHVHQzVUhlUk9jTG0wSmYwTUF4RW5VZkQyS2MrWWtUT3dCZ21yMGVoVUln?=
 =?utf-8?Q?hhyRYUopYTZDC3hdZMRGmBOoeuMaDCHz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2lqenNGRUpuTDdDQVNwaERQR3V4QnNnSFRoZkdIV0JrTWROV1ZnRE9CN013?=
 =?utf-8?B?TVFmRzVsTlJLeEgrVXBhbGNwdFBHcHp5NDd3WDV0cjljOUxKakp0aHdqM0Fv?=
 =?utf-8?B?ZmNEK1dKME42WVozT09UMHBWK3d3N25aR081bytnSjAzaFJXZDZyOEFUUW9H?=
 =?utf-8?B?Z2NvTnNKbjBZTjg0Vi9BK0x3dCtZRnhkVFFjSmVRcXhCbTEvb3RZRWFvem1E?=
 =?utf-8?B?UjRGcjBLMHZHZHo4N3JaZ1NxaHRLVU5ZQjljaUVuRGNveVB1aHFZZWRYaWhr?=
 =?utf-8?B?ZVN2eSsydEhnNmMybWlQMTl0L0lXenFLWlhUQ2QxaFpjOFJRK0YzQ3pXRHIr?=
 =?utf-8?B?WTBwN2ZqUkU3ZVJFM2ZjYmtCdzlWVk1Jbk5Uck40Zk9IMXpabGs0ME5VTEZU?=
 =?utf-8?B?ZlZMandCbkM2amVrUTh1dUYydVhKL3djcUVMVXdwMHhVaGYvaEdXZisxL2Yw?=
 =?utf-8?B?RFkvK3FCOTNTTFhlck16SHFwY0VVK0xsb3RvVGkxUG51TTJpTk1XeU1EV01h?=
 =?utf-8?B?cW5mY3hhNEllZzYxeWNsVURUS0N3Sjg4MVh6WWh6b3FRWDBFcHFNZDdTM0VF?=
 =?utf-8?B?dEszcFJRQm9hUlZiZ2xFSXZPdmJEWjEvSU91OURJRWNNRVZzdnU4eFpjRU93?=
 =?utf-8?B?dmR6V2lLSm9NM2FrcXRPWmZUc05Wb285UktvNTdSRllnT1JRMmw1RDdtbGlB?=
 =?utf-8?B?RWY3SVlOUEFHTFE4SHVmVmdRTnVFMWFJekwxSU9OaDhSOTI2WVF6SWFBaGIy?=
 =?utf-8?B?SWJ5YmZXMmV5cnJ2a1Bybmo0OTdpa3hzYTQxTjFsaHVIeTdud3E5M2RwTEY2?=
 =?utf-8?B?VjI5cmtPNzFGMldSeUlvS1ZBUDZuR1pOVi9xcXplb3REcEdUK2dJRTVHbDVp?=
 =?utf-8?B?MzFUNlRlQW9YWWxCY2Z4Y1UrKzJnT0VWdnkrV000TnhaN1U1NzhrOHEwSk42?=
 =?utf-8?B?VllFUWpaaUI5MXR3V1VFcDlqWEYxWk5FTC9sM3M4SHBKcnlIUFlETFpKZU9a?=
 =?utf-8?B?UWJQZ2JONTZCczY3NGVCb2puY2RkNDUyaGxoanBpY2x3SkFSTlJxMDhaTVUx?=
 =?utf-8?B?ZHhucjhqbW9BbWhocGk0VG4xU0l4M3FrdEVkcy8ycHk5cWFlKzJaZytnbTJz?=
 =?utf-8?B?SHVYRXpiekNubVhYdEdiUVRUYnJYNFdMVFU5Ukd2dFRhTDJUL2FUTjhJKy9V?=
 =?utf-8?B?Z3ROcVFwZlhrRmxmZTJnV0poODlha280ZEZQbStSTERNRkV2dXFWeHZ3eDhy?=
 =?utf-8?B?akZyalBKYWxaL0hmTHUyVXlkcVc4dXU1cldYVVNnYkZsK3JRMDl6UkxwM0JR?=
 =?utf-8?B?ZExJcHVBTnRvZnIxRGlVR3BndE9KQUxJekVoNnpTZ0RPeUxjVHRNanJZOFdl?=
 =?utf-8?B?R1dHa0VpZHc3dVd3VE1DeDV0NjBKZ0RHQXl4elFmbSs5T1dYK2svZUl1VTZ3?=
 =?utf-8?B?VGpEVGhUVWJJN0tXcmdNd2F4elhWb1ovMUFzYUtLbzZvSTVFRmYvaXUwbnRW?=
 =?utf-8?B?L0tCQ3BQb2xDRFVod3QrMk5aZWU5TmErUVBja2Z0K1BzOWJrcUpHZXk3Vmc1?=
 =?utf-8?B?b2syT0RrSVBUNmNCZlZkUDdvcnlMaWh3d2VRN1lpamhrQmp2YWNFdTFxTWxD?=
 =?utf-8?B?YXRrUXp4SGd2aFo5TSt2WEVXMFIzbk1RVmVWSW1HbFQ4ZGpOT0tIV2NGYXF4?=
 =?utf-8?B?d213dmxDNU9IbE91bEpzdGk5SW9MNHhpN2FpTFZkZEloelVBanYyalRZSEFV?=
 =?utf-8?B?WndNMlJSbHJmZHdOZ2lDWEJUb1kra1FmVU9HQ1VnRVpUc09nK3JqbkU3R3U5?=
 =?utf-8?B?eXdVM1MvVGNDMUVUQlRKQTlJWFJzUjg4anA0NGVXZXZncHR4NTZXaUF2K09K?=
 =?utf-8?B?dXdmTXNaZy91K0libjB6dHkrUEMwbW0wTzhWNzBIdXpXcDV1cmVDaDg5a2Fv?=
 =?utf-8?B?Zlp2TXYxM1J3UC9OT1NkSjFlb1VKK0VpUUJQQnh4cVBJMjhobzNKcHA2WFl0?=
 =?utf-8?B?b2FReXlEZWxkL0RXdkZqZzUzRWFzTGRRK0FtbjN4YVFFbE14dllISFdNbUxG?=
 =?utf-8?B?TkxqY3FESE5qeTdCVWdJYWozY1Q4bWFOZWdZckxPeGVvbUQ3b0J0Q2sxeHZQ?=
 =?utf-8?B?SVZQOXNxUm8xUnFyeisrOCswdGNKLzJSNWF6ajIvaUVJZlBUdS8wQW11NEM0?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b19209-d4ef-4189-298c-08de2d6e4725
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 04:34:39.9867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFhoyyRI8lfQukzjk37k8ZDgW1rKv69lGP0jANGPdbb+WELf4AnhVJLVyS9JQU6dYZqPi5FppiKxEz+jho3SOyH8Z58q5+9oiZRAo9LvHk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7776
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

Hi Jan,

On 25/11/2025 5:44 pm, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On 25.11.25 10:41, Jan Kiszka wrote:
>> On 25.11.25 09:13, alif.zakuan.yuslaimi@altera.com wrote:
>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>
>>> Enable support for FAT filesystem with SPL for CycloneV instead of raw
>>> mode.
>>>
>>> Recent changes breaks CycloneV MMC boot from raw mode, and so we are taking
>>> this opportunity to migrate MMC boot mode to FAT as smaller OCRAM size is
>>> required, as well as aligning MMC boot flow with our other devices.
>>>
>>> Fixes: 2a00d73d081a1 ("spl: mmc: Try to clean up raw-mode options")
>>>
>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>> ---
>>>   configs/socfpga_cyclone5_defconfig | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
>>> index 2bec82b0625..2b2435a27bb 100644
>>> --- a/configs/socfpga_cyclone5_defconfig
>>> +++ b/configs/socfpga_cyclone5_defconfig
>>> @@ -12,6 +12,7 @@ CONFIG_DM_RESET=y
>>>   CONFIG_SPL_STACK=0x0
>>>   CONFIG_SPL_TEXT_BASE=0xFFFF0000
>>>   CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
>>> +CONFIG_SPL_FS_FAT=y
>>>   CONFIG_TIMESTAMP=y
>>>   CONFIG_FIT=y
>>>   CONFIG_DISTRO_DEFAULTS=y
>>> @@ -27,6 +28,7 @@ CONFIG_SPL_PAD_TO=0x10000
>>>   CONFIG_SPL_NO_BSS_LIMIT=y
>>>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>>   CONFIG_SPL_HAVE_INIT_STACK=y
>>> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
>>>   CONFIG_SPL_SPI_LOAD=y
>>>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
>>>   CONFIG_SYS_MAXARGS=32
>> But what about other boards for the cycline5? If you want to switch,
>> switch them all. This looks half-backed.
>>
> BTW, the FAT refers to a u-boot.bin file on a fat partition, right? And
> the SPL will be kept in the A2 raw partition then?

Yes, that’s correct. SPL remains in the raw/A2 partition as required by 
the Boot ROM. U-Boot proper is moved to a FAT32 partition.


Thanks.

Tien Fong


