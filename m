Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C81C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42000805DA;
	Mon,  3 Feb 2025 10:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NbfPpJz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71CA180608; Mon,  3 Feb 2025 10:36:23 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBA4801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpsKHPqAenQUFWmimcD0jAW20d2vRAmqWc8020JVYNdkll2C/ThWrR2Ru9MBU33lMDjePrNdkoVEHMTvoMbk3i4y+qkpzTwWqUftshfAVrq8s7b8aiFW1Ee4Jaz1ab4WuidGZJYAmwQIakfs/NiMnb+s2o58i+3LC2NTPAbVqqIQkv4FyfUxxDyGPKiO5hHwraMxZCfmSTG+VNe0S4lhAehhr5pgVjHeAjIBknHB4MVAAh0T2g4nGvT2umN9fWMJyJsc88rMvl7mX0ZAU556SpM0znZp3zIcGxWzuwq2fy5bfmPjnzyQ82axAwH2fGN9frm/rxaIbgp8gWIcyBnUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoFysEl5OgXv9KRlxMFfx1HhC8rZaIHK4AQNRGkhVa4=;
 b=Nsw0rVnEuRQoPCugpTbi7DR8sKWaFbnC42sWYBTis5qIBQIDyJUdOBaBkNjeOqps+FzPdlwn2h08Y0ZXOJRHEZjzAXok4qW9eTqm9D4G8IatF+H2uhNnD81LEWRIpreH4Ce9Ry7+DzkO+bYIW537mjnn00XncfUu1NO0uT5Q6oR7LLlUNHTgsJu/BFXcbGC96vtmRaB4Q5L7lLcrcTzifz20u8CpgpOTmJ5H/NRgJleO8zk3H3XxSUUMFzIAgrN9Od/AeitzE4ymexEjbABVh395qxjHRBQiafVPJ4W5icbUHbg95j2OvBrwT23pDILTc+p/3hVf2FhbVg8IxJkisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoFysEl5OgXv9KRlxMFfx1HhC8rZaIHK4AQNRGkhVa4=;
 b=NbfPpJz7nod+zByXoIoqBTFPwCn79eW6/Ef+E8mrbuj9cKBelR6202vNPU2ffutPgQXtjyWcpKPl26FqoSIjwQUhgnJH8ZuOIqFWjtZMunpITl8EaEG77MTxSnShPqmj02/FLosb6oLnezyKVBN4/9BOauPR7F8PBp7xeUc4M38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 09:36:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 09:36:18 +0000
Message-ID: <22fb819b-c1d6-4470-a8ce-d588ea8bc043@amd.com>
Date: Mon, 3 Feb 2025 10:36:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Srinivas Goud <srinivas.goud@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cb05adaf0758c2c4f1361f8665169897493638e7.1738164681.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cb05adaf0758c2c4f1361f8665169897493638e7.1738164681.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::8) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd178d3-2987-4036-336b-08dd443635e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEl0UURXbkNFUzIySW9xV0d4OHRYUFpXeGlZWnE3NnRaZGZJalZjWWlhYUli?=
 =?utf-8?B?eXVHdWEwNVVsTTI4N3B2dzhZOFUyQzVxNzNKUzc3MkxjNlZwTFZqWGhNYTJC?=
 =?utf-8?B?YjZMV01GaWc5S1QvNWEra01CdnFQUlJZTEVBYUhab1JPRVhMSXplUG5UMHY3?=
 =?utf-8?B?VEI1Q3N6QW11MzVZQ0pyNURHZnhwS05rRG5HU1ZZQlpac1k5MTl4bTRaRUQz?=
 =?utf-8?B?eVJGcWRjREJRQ093eXhvckoybHp0UFFUWnRDdmx0bDA2YW9oKzV4TElCNHg4?=
 =?utf-8?B?cXltYU9mT2wrNndyY1c4dUJudGNBS1VtRmc5T001ZWFROURDdGdVWFJYSi81?=
 =?utf-8?B?dzdUam1wVnFQVTJWNlAzYUMzUEV5d1hhVTRsa0dtRlIvSVpYcmdtSVUrdDNP?=
 =?utf-8?B?aG1rSWpSNUhtZFdmRFA2NnJjRlgxcWE2Uks5eStIeDl1d2pMNjZzUjF6K3N3?=
 =?utf-8?B?bnRZQkpORXJVNWp4Zjc2bWJvUHZvM25Ucm1Kai94bHVUWEh4Z05XNlpoLzZO?=
 =?utf-8?B?SDhRVXhiQkJVRzlzOWplTVNZZExSVzNpYmUvZDVKOC81MUo2WWVFSzhhc3Qw?=
 =?utf-8?B?M1crcVBTTWpLd1RPSERVZWF3a3hLNjRhcG1zdnJwMEttczF6NXRHZ1lWV2or?=
 =?utf-8?B?UFlwTndmcTlwOUpId1k0S05GQ3lUakoySUhyTFZibFY4ay9mdWoyK3hYcy9k?=
 =?utf-8?B?Y0ROOTFFVnBQc3M2dVNWVE5CYmxZU2p1RjJ2aXpzdmdlbzErQ0lkV1RvZ0Qx?=
 =?utf-8?B?N1lyMlVzd0NmV2p4QTR3cFV1THo5d0FNS3NlYmN3ZFlQN2xSMnpOTE9vdXkv?=
 =?utf-8?B?OFJGMGtITStSTnBtTFRvbzUzSUpKdUhEZFcwR01JYk9EeXVSN1RNcGFrZ3Vz?=
 =?utf-8?B?a29ybkZzeEZmQjd6eGEvL0N0RXJwZi96ZEZLSVFONlMrTGdGbjh4UW95Tk1i?=
 =?utf-8?B?azdlajFsSnFtMmRIdjRVcHQ2YnV1TzhIU281elpvUjF3VWVLSUc1aTFxcU0x?=
 =?utf-8?B?UlNOdmlEdXB4OHlYNW9QaUcydHdjbE1pNG41ZFRFa1dCYnNCTlBLajhOWFJZ?=
 =?utf-8?B?N2R6T3duR0FhQkoyKzEzVEQyVEpwbEJyakRwUW1Cc25oa3hTYThxaGFRbEc3?=
 =?utf-8?B?V0x3ZStoQ2kzWkFDWm9IU2V2THhFR0F1M0RNdmI2bko1VlM0N1FjaFhSU25W?=
 =?utf-8?B?ZnhPd3FOaEFESDE0YnhFdW5pWTliY2dlNnhUY1h1T2c1bG1YUTErTURiUVcx?=
 =?utf-8?B?TDdzNFJmeFp4emhvWDJiZ2w2RVdaWTNWTy9adm9vVUMvcG5xeCtROVJQaGM1?=
 =?utf-8?B?UzNPWVkvSENkbkQ1VzIzMmFrL3hPaVl6Wlg2WUNLR1RxeFpJcUc1WG1KZm1E?=
 =?utf-8?B?M3JXMHRpa2lCek9hcjRaUFBMZEdmY1MybzBBSnp6bXI0KzlscDBBeDNaVGdr?=
 =?utf-8?B?NHU4ZEZxRUpRUUtleWpudTdOME1wb1FiaDBEc1VuM094ZGxkcnZZeWh5c3Bu?=
 =?utf-8?B?TGJ3eHpVTE5JOEJybkwyVDBwR3dZL1F5RTdRVk1HTHpHQ21sYVRjdUpwQmdp?=
 =?utf-8?B?YXJmQklOZWxOODdGTGhsaStMNHhJNDNxRDh2elo2TG5OS3phcE1ZTGdMbHBP?=
 =?utf-8?B?Q1FBM2tSUXA0WlJlbGcrMnlOMXZTdlNBRmJxQXYrMkZyTWdCK3Q3UHROS1R2?=
 =?utf-8?B?bDUxcWhGOW5zSGEwN1VTS01JT1NNR1dCUi9EcWlMVnZub1dVWjcyWThKUkF1?=
 =?utf-8?B?SW1Mc1B0SjQ3VnRRQUI4MEtEaitFN3h5VFB2L0Y2YjFySzF4OVlMVlZqdmxn?=
 =?utf-8?B?NTRjTWV1M01LY2czYUJmT1pGMk95VGlmVU44RFg3QWVmTXVVT3RiTUxnZUMx?=
 =?utf-8?Q?YlGDgzzk/gCdn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:es; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEhtVFRuemo2YlFBdVFMZTVMSk1qZXlxMFFlSXU4SGNOOUw5RVFaa1pkMndv?=
 =?utf-8?B?NEVCbWJFVWRoL2JUKzB5UUJRVWE5VEU1UzE0dDU5aEhQNWphNVBGbnAyUWFE?=
 =?utf-8?B?STFwQXdpa1E4NVBtUURCYytaOU5nOGxuWXhuektpMG9ScUZzQWJZZ1FOY0Ja?=
 =?utf-8?B?Y3RMai9TS1BGamF0NnRhL2VXMnNpSXZOb0ZoeXZXSWpuVjVvcG85L1BFU24z?=
 =?utf-8?B?N3Y0NWRja2Z3NEcwK0NBdHY3b0d2ZVN4V0NMV2t2bkdoeEJLRlJZUkF6TFVx?=
 =?utf-8?B?enNON1NmWkxzMFB2SGZnc3hodHdKc0poY2NSaFZoNGt0MktIT3hVb016Q2Iw?=
 =?utf-8?B?MDVHSWF5dkpFWEp6WklNeUswZ3BDRko0WG56UWVkN1lpeFFIQVRnYzM1QnFM?=
 =?utf-8?B?L2JIR3BtTjEvbnpETUdEb2Q0bk9qbVp0N0Fxa1VaSWV0QTlwRG5ZVVQ2TTI5?=
 =?utf-8?B?TGR6NG5GWmF5MnRES0I0ZENUZGgyM0xmcjI5OEVMN1dPN3JBZnMwdk1HVWVQ?=
 =?utf-8?B?RFRXWWlFY0lzTldoWHdmeE5yR2hQbDJHd3RsM1JIK1pFWkloTWZ5UFptU1B0?=
 =?utf-8?B?anc3RlhZcTlxSCtMUUNNaTdKeFZzS2t4dk5UOS9qK3pYTy9LYTJ4R085QnZh?=
 =?utf-8?B?WDNFSHlPMVlTTjB4ZEdka1dxektmanZIczJkVFEwRjZteGJlZDdMcDd1OHF6?=
 =?utf-8?B?VWljejlMNmpxV3h0ZjNBN2dGc04wTkRpRDJyQmQzdEVnK1VoOHF0WVdHeEJH?=
 =?utf-8?B?a28zcU1lOXhKNjBoY1N0S1hTNndlY1lpT0tmSlZHQnZnenZIa09vMUFKQ3Rr?=
 =?utf-8?B?Y2dEdER0dHlXU25XWVdsc0lpNlBxQVcwSnF3VWRkanBOOXhpc0ROUTcvcHNJ?=
 =?utf-8?B?UWVZNTd0cS9yMUk4M1NWai9KUUU4S1BJQWE1ZlQrRGM0UDE2eCtsMngzRU80?=
 =?utf-8?B?bjFVaTkwaVV1UHJjaXFLWTFsRmFGczBvOXV5akJhZk5BQXBrbytUOS9kR0RY?=
 =?utf-8?B?aEtNeUYzWkVCcTNMQXcycWo0TnFDQUpVakh5MFBObDhpd3NZbGZGRHZsbm9D?=
 =?utf-8?B?MDYveDVWbGU1YmUwOGJNVm1NUkhNYURPcWIzOUVaa2dRUmx1WVdsdUlJb2lE?=
 =?utf-8?B?T014Q0w1TDZNYmgxVGhjYU56NktuMDNmeVduMXdtNGpzNzJvQzBVVllmdmxI?=
 =?utf-8?B?S0w3eUl0TGJBMkFJYUxteHZGTitjamtqU3IweVZ1Um9YVjY0TU5hdnNIbkZK?=
 =?utf-8?B?b3gzZTZIYkErUk1CUU5xUi95YTFLeWdha2xjME9zSWVoR3I2TXc4WFROY200?=
 =?utf-8?B?Ulpxem1PSTg4Yk1SZzNIb25yNW5FUHIxdm14MTdQOWVZSmVXa3M3QkFkN3F0?=
 =?utf-8?B?ZElWY1A0RTRKRG9rRjBhZFNtcXNkTDVBUXZLMEZYR1oxQVJpYWdXNExVR1Rp?=
 =?utf-8?B?dVRIZ2JJRXljcDVnRzFPd2YyZU9CWVdYTkNXL211K3pYNWZUVi9nWHI0Nk80?=
 =?utf-8?B?N3Z2T1pHakR5Ri9TYXNidWpVSjFMeFFqRXkwSGNTNkpYNTAwdkRobEdwY2hL?=
 =?utf-8?B?MUdKMTFNRnFxMGRiQlBKL1lzOFdHb3BSR1dvUllhVk5TbGdRZUluM0tFaWpX?=
 =?utf-8?B?YkZTZWNmbHRUa2ZNVm4rZmtVTUt1dk9VeFBNQUtibGxnZkFTMllnOHhlZFZ0?=
 =?utf-8?B?WlhOb1IwczFnMlhiQk1NVVlEMk9YMzFKVVg4SXdoQTd1S1ZraGxsaWpIdHRW?=
 =?utf-8?B?alZWMmp4RXFYVXRtY0pKVGJnWklNeTVMaGdzUVNHanEwZW9ZN2o0WVlDRnJk?=
 =?utf-8?B?LzBjenV2dm5iZkhwaDIrYjUvd2lyOTduQzNyckkyTlhnTTFDMk8zY3ZVZ2U3?=
 =?utf-8?B?WHBQcjRJNE1wVUZRaFQxUjkyYmQ0TktJQ0R6dmkwQm5RTlY0SFUwNldRSldw?=
 =?utf-8?B?MitnaVpUYVhkemJLMnZrZXAvKytsUkpsc0xUQjd5RlpsVStuN3BVWlJpcktz?=
 =?utf-8?B?WXpnbHRZbmhXWHpaNEgwLytZL1hRNkllbmZldGphWW5EdkxTQUxPeE9mUHZI?=
 =?utf-8?B?OWhiT2hpM3pZQlZTSlRzdWJvWVJIOW5HR1FXNVhRSHNOWEt2bVVGZTFGVkw1?=
 =?utf-8?Q?bJkczVWjPIxGE4cTG3ZGD1HYx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd178d3-2987-4036-336b-08dd443635e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:36:18.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOHxPs+zuphwPXSg3cVCCOyYx0Ut8322LJjekHVZ3W8/pUhlD2S/hmljMAhHQKsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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



On 1/29/25 16:31, Michal Simek wrote:
> Enable lwip and https on our platforms to be able to use it in a boot.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig       | 11 ++++-------
>   configs/microblaze-generic_defconfig     |  8 ++++----
>   configs/xilinx_versal_net_virt_defconfig | 10 +++-------
>   configs/xilinx_versal_virt_defconfig     | 10 +++-------
>   configs/xilinx_zynq_virt_defconfig       |  7 ++-----
>   configs/xilinx_zynqmp_kria_defconfig     | 15 +++------------
>   configs/xilinx_zynqmp_virt_defconfig     | 17 +++--------------
>   7 files changed, 22 insertions(+), 56 deletions(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 57a6a06df7cd..8bee002777a5 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -17,6 +17,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_SYS_MEMTEST_START=0x00000000
>   CONFIG_SYS_MEMTEST_END=0x00001000
>   CONFIG_REMAKE_ELF=y
> +CONFIG_EFI_HTTP_BOOT=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_DISTRO_DEFAULTS=y
> @@ -47,10 +48,7 @@ CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_UFS=y
>   CONFIG_CMD_USB=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> @@ -70,9 +68,7 @@ CONFIG_DTB_RESELECT=y
>   CONFIG_MULTI_DTB_FIT=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_IP_DEFRAG=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_TFTP_BLOCKSIZE=4096
>   CONFIG_SIMPLE_PM_BUS=y
> @@ -155,6 +151,7 @@ CONFIG_UFS_AMD_VERSAL2=y
>   CONFIG_VIRTIO_MMIO=y
>   CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_BLK=y
> +CONFIG_MBEDTLS_LIB=y
>   CONFIG_TPM=y
>   # CONFIG_OPTEE_LIB is not set
>   CONFIG_TOOLS_MKFWUMDATA=y
> diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
> index 87756cb26df5..6075c6a2beed 100644
> --- a/configs/microblaze-generic_defconfig
> +++ b/configs/microblaze-generic_defconfig
> @@ -46,16 +46,15 @@ CONFIG_CMD_MEMINFO=y
>   CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_SAVES=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_WGET=y
> +CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_EMBED=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_USE_HOSTNAME=y
>   CONFIG_HOSTNAME="microblaze-generic"
> -CONFIG_NETCONSOLE=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM=y
>   CONFIG_XILINX_GPIO=y
> @@ -99,3 +98,4 @@ CONFIG_SYSRESET_GPIO=y
>   CONFIG_SYSRESET_MICROBLAZE=y
>   CONFIG_WDT=y
>   CONFIG_XILINX_TB_WATCHDOG=y
> +CONFIG_MBEDTLS_LIB=y
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 081ad424a9aa..5ef5fd44fd37 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -46,10 +46,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_USB=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> @@ -71,9 +68,7 @@ CONFIG_ENV_IS_IN_FAT=y
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_IP_DEFRAG=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_TFTP_BLOCKSIZE=4096
>   CONFIG_SIMPLE_PM_BUS=y
> @@ -155,4 +150,5 @@ CONFIG_USB_FUNCTION_THOR=y
>   CONFIG_VIRTIO_MMIO=y
>   CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_BLK=y
> +CONFIG_MBEDTLS_LIB=y
>   CONFIG_TPM=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index 70e73ac7ad45..f228eef7c959 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -52,10 +52,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_USB=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> @@ -75,9 +72,7 @@ CONFIG_ENV_IS_IN_FAT=y
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_IP_DEFRAG=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_TFTP_BLOCKSIZE=4096
>   CONFIG_SIMPLE_PM_BUS=y
> @@ -170,5 +165,6 @@ CONFIG_USB_FUNCTION_THOR=y
>   CONFIG_VIRTIO_MMIO=y
>   CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_BLK=y
> +CONFIG_MBEDTLS_LIB=y
>   CONFIG_TPM=y
>   CONFIG_TOOLS_MKFWUMDATA=y
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index c2422c5b4dcf..fdf8bb361294 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -73,9 +73,6 @@ CONFIG_CMD_MTD=y
>   CONFIG_CMD_NAND_LOCK_UNLOCK=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_USB=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> @@ -94,8 +91,7 @@ CONFIG_ENV_IS_IN_NAND=y
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SIMPLE_PM_BUS=y
> @@ -160,4 +156,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
>   CONFIG_CI_UDC=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +CONFIG_MBEDTLS_LIB=y
>   CONFIG_SPL_GZIP=y
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 2258b59e3edd..1e8ec90ff533 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -84,11 +84,7 @@ CONFIG_CMD_SDRAM=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_USB_MASS_STORAGE=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_BMP=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
> @@ -120,8 +116,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SIMPLE_PM_BUS=y
> @@ -131,7 +126,6 @@ CONFIG_SATA_CEVA=y
>   CONFIG_BUTTON=y
>   CONFIG_BUTTON_GPIO=y
>   CONFIG_CLK_ZYNQMP=y
> -CONFIG_DFU_TFTP=y
>   CONFIG_DFU_TIMEOUT=y
>   CONFIG_DFU_MMC=y
>   CONFIG_DFU_MTD=y
> @@ -140,10 +134,6 @@ CONFIG_DFU_SF=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
>   CONFIG_DMA=y
>   CONFIG_XILINX_DPDMA=y
> -CONFIG_USB_FUNCTION_FASTBOOT=y
> -CONFIG_FASTBOOT_FLASH=y
> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_ARM_FFA_TRANSPORT=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_ZYNQMPPL=y
> @@ -231,6 +221,7 @@ CONFIG_VIRTIO_BLK=y
>   # CONFIG_BINMAN_FDT is not set
>   CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
>   CONFIG_PANIC_HANG=y
> +CONFIG_MBEDTLS_LIB=y
>   CONFIG_TPM=y
>   CONFIG_SPL_GZIP=y
>   CONFIG_TOOLS_MKFWUMDATA=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index c0721b65fd48..036268c79f77 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -59,8 +59,6 @@ CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_CMD_SMBIOS=y
>   CONFIG_CMD_BOOTMENU=y
> -CONFIG_CMD_THOR_DOWNLOAD=y
> -CONFIG_THOR_RESET_OFF=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
>   CONFIG_CMD_MEMINFO=y
> @@ -86,11 +84,7 @@ CONFIG_CMD_SDRAM=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_USB_MASS_STORAGE=y
> -CONFIG_BOOTP_MAY_FAIL=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_NFS=y
> +CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_BMP=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
> @@ -121,8 +115,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NETCONSOLE=y
> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SIMPLE_PM_BUS=y
> @@ -132,7 +125,6 @@ CONFIG_SATA_CEVA=y
>   CONFIG_BUTTON=y
>   CONFIG_BUTTON_GPIO=y
>   CONFIG_CLK_ZYNQMP=y
> -CONFIG_DFU_TFTP=y
>   CONFIG_DFU_TIMEOUT=y
>   CONFIG_DFU_MMC=y
>   CONFIG_DFU_MTD=y
> @@ -140,10 +132,6 @@ CONFIG_DFU_NAND=y
>   CONFIG_DFU_RAM=y
>   CONFIG_DFU_SF=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
> -CONFIG_USB_FUNCTION_FASTBOOT=y
> -CONFIG_FASTBOOT_FLASH=y
> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_ARM_FFA_TRANSPORT=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_ZYNQMPPL=y
> @@ -247,6 +235,7 @@ CONFIG_VIRTIO_BLK=y
>   # CONFIG_BINMAN_FDT is not set
>   CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
>   CONFIG_PANIC_HANG=y
> +CONFIG_MBEDTLS_LIB=y
>   CONFIG_TPM=y
>   CONFIG_SPL_GZIP=y
>   CONFIG_TOOLS_MKFWUMDATA=y

Applied.
M
