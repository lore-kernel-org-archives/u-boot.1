Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A7BC4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 12:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A4E88267;
	Sun, 28 Apr 2024 14:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="u2YoFQOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF24188458; Sat, 27 Apr 2024 18:15:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B41618828B
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 18:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43REkY3G029531;
 Sat, 27 Apr 2024 09:15:45 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xs0vfrb7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Apr 2024 09:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4WtxitnEEjH9R5srLZ3fXnTaDf65e1KIhlrYOhsJwSm2GWVzfRD64UvqocE7NXYZWKfrIrkT7QP0NPH1xmXUBHK2KWGaBSuJUMvxD3ES4dLx5GezgoQY6VwFJpeWTj+Xr+KQOHtz7/KCr2lZ5EaOjZCy0P/Moku3hXTJg4gpV9p9y0A8KodBfKo7RUUxfEPFdK43TcyFKC20Ta00re9kfHGmX79Qm9gu5vY2n2ZJzoFTuufUqVP6v+QsmhcG1kp/fUqvbebpyBpk71C5BOqz37umybUwdxco1yj2uIZ909CI9N7FFG45+/N4wq1gS/PMSnV6v/eHI2EMlMDs2s39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xK3sLjdx+bCsbTQVz7tQOKWCC2hlisRUm3CuiMpGqs=;
 b=S4yM03dx+286tWzggUVT4zyecY34/+sYUh6UQNIaHBb1GKQsuizKwg0Hq5nv1+YF+lGSvUZH0mTmBLE5rMR94JJMC84cDnOdakUEBHmP+ux+c35ztX1hovE8W/v0zjcs57VjaAtiW5J9bTDrlb8p6sva25rfoL07wpMljqACfd4CZggfDhSlpsBuG6wWfzUuWoAihg093xUiNxda7UPL3YeeYV63sM32eStexNlxt5wtpd0XTjcFd2NKVMMzRVHBniGUK2cFtzkpNXlLumCqgv3nkQxCMi/fJ4l7fXJx7kzJzKrzDUiLUouw0vaj188VnaC+wDP5mF1aSgpShuT82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xK3sLjdx+bCsbTQVz7tQOKWCC2hlisRUm3CuiMpGqs=;
 b=u2YoFQOcBNHOr9lWjh0d9ERPjWDWggxdCDMONSEOfmhZ7HtLTFc1kwH0PdSa4GGBPvjKz+QDEy0lmKXPSeoK23iTOCPts4z6OKsA5jIzC2LseDMkXA+YPwHAy7jv7Ta0EI98Z6jqG3BVhQeD0EVGrohl8/BmTwNS+dAZBdkY/6U=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by BY1PR18MB5840.namprd18.prod.outlook.com (2603:10b6:a03:4b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Sat, 27 Apr
 2024 16:15:39 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::c0ef:b62a:5356:65cc]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::c0ef:b62a:5356:65cc%5]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 16:15:39 +0000
Message-ID: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
Date: Sat, 27 Apr 2024 09:15:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
From: Ravi Minnikanti <rminnikanti@marvell.com>
To: u-boot@lists.denx.de
Cc: hs@denx.de, trini@konsulko.com, sr@denx.de, judge.packham@gmail.com
Subject: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip return on page read
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::12) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|BY1PR18MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: d522ebaf-c1d1-4e46-9c27-08dc66d5478f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzZ3RUw2TVREd3ViUnl5b2l4dmdWMWI3cXh3R2lKa1BoS0kydXU2SHdQWE1I?=
 =?utf-8?B?R2ltbVBQeElNQjdPRTNnbWJia2haTThmMitIVGpLTlYzeDJJcnpvRXdVa2RK?=
 =?utf-8?B?ZUVrMG15ZUlaeVlDMHBRYVl1MmpERDRHdEYvYkliYkd0SDZlSkhHdlNFYTM3?=
 =?utf-8?B?dU9sODNqajUzRERPcDVWQitRSjRKM2JJSk9lUDlzRVQ2d3V1RE5WSFVoSno4?=
 =?utf-8?B?eUV3K2RhQTQydExsQzJlejRnWWR3T04yNTNKYXcwa01BYUV1c21kVEN5bUkz?=
 =?utf-8?B?S0VyVGN2TVhBbWRpVm9zaGsrMEg4b2g0cVpCSkp2V09mODlzdzVyTnlKbk95?=
 =?utf-8?B?VXQ2K05vVlU5N3FrTG5lSW93ZmhiQVhKdUpZaWtmVEgzSVNNQ1d3ZTdzUHMr?=
 =?utf-8?B?Yk5qdEIvNlpCNWJxd3VnQWRmWVh0czMzRC9SR292S1d3Ry9ubk5ienVCTlFM?=
 =?utf-8?B?aUNZWWZFR1RQVWFWMGgrNEl1RkRmWDJLMndRajBzbHk0K2JHOEZ6UjFvT09j?=
 =?utf-8?B?N2dubFdoWWVkRUdFMTF1ZWZFUGRvUTRqWlZHMFpvck96am9sSW1lelh2M2Jt?=
 =?utf-8?B?amZyUktyYUx0YkMvSjBGekdsWngyU08vZmZJTUx2SzB4TVdzVGRxZ0NGRjNh?=
 =?utf-8?B?M250TG94KzcycVJSV2wrUkhGU0g5cU1Gd1BMS2tCci9JY0tiVGxtb0VZOXNa?=
 =?utf-8?B?Tmo0SGRDRDU1b2dwYS9PU3RkT3JZNC9MbXpOOUp5MkdwY2o4MTNkRDcxTWZU?=
 =?utf-8?B?K2QwbWVQOFVodlY2UGpzN01LUzRlZDRsaGtOcG5hYXNSVzB1YTZGa04vWGJ1?=
 =?utf-8?B?M3hEUXdBQzdOZlVFcVp1QVNWMkk4QWE4aDFwNGk3YklDS3BGNThZbzEyL1o2?=
 =?utf-8?B?eDR5YmtvZHVLT2xUNVVESWpuSVFIN2VnMmoyZDNzVHI1YWk1TzhBM0RibXAr?=
 =?utf-8?B?NnF0V2RkQkVtTm1vcDBtTnUvczNFSFltZnJHT1lHTWF2eXh3NUYzOE1sVHBY?=
 =?utf-8?B?eTBSa0ppaXp1U1BUNHJWRmRqR3l2VkRDTTZJMEdxSXV3V2kwUk0vKzFxRW90?=
 =?utf-8?B?b1dRQ3g3RUN2Y0RIKytlS2JwVjN0b1RmNWtJbkRuQmhYMHNTOVBUODRjWUJY?=
 =?utf-8?B?ZlFHdHZBR2d3NEhFMThocmdKbitKQUI4MWdVY1ZjYUxjYUZORXNjdjNpVXUz?=
 =?utf-8?B?WXhYeThWTG9tTUN2SjM2alprUEpYZGJlVDlzMHlaTGlzTnJPRDNvMkRmRWF5?=
 =?utf-8?B?cFdHZFgyQVVIZjhmUXRWTUxwZmlqK1pzc2FhNG5LZktwOGMyaEtqdVBlKytj?=
 =?utf-8?B?d2lMdm8wQWFxcEhmUTJNZU9xeXBURy94TVdsQ01sNHBZdTFXUVBRUlpBRlds?=
 =?utf-8?B?a3FWYnpDbCtmSkpWRTlrSGMvRDRNelYvYmdKUDFaVXFBY1R0eGxsaTNqcUF2?=
 =?utf-8?B?UHF6ODVhZkJoNUxtTDk4WnJQUzNFVUw5OWZoUHhWaFVZejdqK0h0ZTFCYUl6?=
 =?utf-8?B?VUFlNVhQYXlVVFAxUDE4NXVtU1lSZmxtSzJiRVVGaWlFcS9kL3BxRytnQ0d1?=
 =?utf-8?B?QVlJN2VDdGY1U24wRzIzdzFES3k0L2NRVlBhdlFiZlQzSGp3SUVjWVR4M3NW?=
 =?utf-8?B?MmN3YVJIc0JPcjg5Ui9iamtIWXdqRjluTXNxZEhNTDNtWkxGcy84MVI5MWVy?=
 =?utf-8?B?Ymg5ejNlVTNGNE4rWVdpOEdoUnF5ZGJQTy9RbXFGeEV6QTlMNEh4ZnBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QisvQm55TnlGekIwL1E2ZGU4ek9xVzBtd1RqRGpBYkFzMEticklqWG01amlQ?=
 =?utf-8?B?NUtpU2xoVEtqem5rcFZ2c0FSNjhKSytuTlBTa0c2cHFyUWxVU2JmQzJocUdE?=
 =?utf-8?B?WE9CQXRrUThINDlYSHpFdVBsdFV1cUR1ZTFNT2lVMk81VFQwTEVta1paZ0Js?=
 =?utf-8?B?MEs1alp4Nm84bUp3QWR5d2FyZW5iYzV5SEFYbFRwdEhrTk0vTEFkM0RKaW1R?=
 =?utf-8?B?L0hvU0RZMGtLR1dkZHVaTUlVMzh1K1hQVWlYSkRhUEpVMWxYam1nWEFaSEEw?=
 =?utf-8?B?NURoYVlJaUd2dU5DdFBKakdrcHJKQkdzS2g4R0lYYTRrQjQzSFR2STd4MC9S?=
 =?utf-8?B?NjBLSGxCeDJMK3BDMTNtbnhUS0JNVVJxV3ExOUw2YVRMVEUxUmtGMUh6RXpJ?=
 =?utf-8?B?aTgrbHl5Vkk5bldENHNQYzdQSlM1MnkzUmUzOGt2Rit3TWNMaDA5RXdpdnp0?=
 =?utf-8?B?eXJrZjVrdHk1d0pHditxRW51aitmV21nL1IwMWdLYkZXb3h4dTFzMVpoSWdV?=
 =?utf-8?B?TGtlV2p1ZVc1U1RwNEc1UmZhK2JNMTRoWjhGT0xZbHpUUEFnVmhTZ3U5V1Ja?=
 =?utf-8?B?cTB5RWNkbTYzYjhYcWxkOTh1K0lZODEvZUN2U2FzVnNrSGlGVW1zK3dQTno1?=
 =?utf-8?B?RHpEcXVxRWpqUFcrTDJwZjA2Rko4NVh1VlRpcVFqMUovNTRPWHhjc0VLWWpJ?=
 =?utf-8?B?dElqaXR1OE1BRHoxNjVTMCsvbVVWY3F3NFlKT04rb0J6SFlBOVBmdFBkcEFJ?=
 =?utf-8?B?Y3d2UmEwOGFpMFhBaVQ1NmRmRDZKb04rQ2hTdXB5UVB0L09jSzNFVFBnaWJH?=
 =?utf-8?B?Nk5DUVJIN2tuYUZIQ2tiWlhxeDRVUzhzZ0lPZWZsVE1yWUNjdDBkSGQ1Ujkv?=
 =?utf-8?B?cWFCN2VtbnlZMVlSL3M0d3BoSGx6bnZRRG1wSG5GR3Z1Rkdsbmkwb3NsQy9O?=
 =?utf-8?B?eExOMkNOdlRsR2t6d1Y5K1gyOE15aE5IVHhlQ25mN0hDZ1VGaklGYzV1NEpn?=
 =?utf-8?B?S0hOK1JCcVJoeWF5TWF6ZFJvT09iL09lM3E0cWFoZ2hJSUZIVTcrTlhxRnBw?=
 =?utf-8?B?d2tCMnlyQkRObU5nV1VqdlNHNVpPTkRTSmZ4cUk1dWozOC9KUVJLQ3ZIRjNO?=
 =?utf-8?B?YkhNZUlKUSt2TzkzYlVEREk4aVlqZXFMUVNqaFNFRXd0RGFDUU5Od2ZVdDZu?=
 =?utf-8?B?alhsV0lkRktjeGRocGl5N0pDNnQwZmZVeGVLV1VDU2NFeDdPeGx0YmUzWElu?=
 =?utf-8?B?cU1jWmtqUFBNTldqT1hhYjRyNG10YjM2VFJab0RmYVoxTm5YUno3Rmlwenk0?=
 =?utf-8?B?RlZLTElURGxGblIrMUFMckhZenBXcEFFdXpyMHFyeFF1OXFOM1RlOEJhWlQ3?=
 =?utf-8?B?eDBnODZtT2hoVFU3N2hyWTJDc2JCSDZKbjFUOEsvdU05Q2EveFltUy9NcUti?=
 =?utf-8?B?Kzk4NlpXS2xiSHR5MEN6TGlGZGpiNE1NOHdySlNHV0VJSTJicjdNNW1Nb2FQ?=
 =?utf-8?B?STUxWlpJTjhmNE4zeGh2U2V2KzJHY01jT0d5bVdKcXorRG1WaVlSMktmR2Ex?=
 =?utf-8?B?RVdQbjdtWXNqREtqSTVocUVTUE94Vm5WMG96QUo1L3dQcnQ1S1dFYUtFVnVn?=
 =?utf-8?B?eHlOUzBGTTZ3YVRYUm1TSlJQTUQvRnRCeVBwRmswV1B2NVVJT1ozbzhZNEZ2?=
 =?utf-8?B?OExBdkZPa0c3N0luYzlkN1NvZHUxWWhMM3A5TFI3OUFjblczQ3M1MkJnZDBt?=
 =?utf-8?B?L2IyMUs0UlJNR0xVMTlhWHJ1THNsZzR5UkFkRmdMc3o2M1V5YXJ5RllRdGJx?=
 =?utf-8?B?eGV0SXY0VW1OWlJ6eVVDMmRmdW5tNmFGOUlTbllVUldzVEhBWFFwa2tJeHlL?=
 =?utf-8?B?TGhnTDd3ZURSSFp4ZWxIL0JGZDFvWDdvZFFkaWJmYVpmbXNaVDd4UEluekZi?=
 =?utf-8?B?RDlhK3ZqRVN3YllrcXkzS2Fqdm5PbDg5UEJTajdwOVdGTHI2OHdLSzRraTFE?=
 =?utf-8?B?M1VUZ0VxSHduMDJaaVE5aVlnRUt1cER3MmE2SHRJMGNpaXNkV1o3d0hLRDNy?=
 =?utf-8?B?RmJvanhtTGFIV2VTaXFOY1U1b25hMWRpdURLell5Q1VwVFlzUTBORXVYdzJl?=
 =?utf-8?B?bkpqa2hpTHBPNlNaL0tDbVZiN2Z6eDlLV3pNLzVjRXVuR0V2RExETWJvSEsz?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d522ebaf-c1d1-4e46-9c27-08dc66d5478f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 16:15:39.5440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hW27c/Eb3ZSTJoErN8YY0Cgli5LKtbdyljm0IhMKqmLxF4MIrhOwZkuRu5O9WtV1y7/4wq0q6b/hHv6kUuCSJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5840
X-Proofpoint-ORIG-GUID: YGV1-OaKlmXGo3ZAlHlcLigdikMMuvUQ
X-Proofpoint-GUID: YGV1-OaKlmXGo3ZAlHlcLigdikMMuvUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_14,2024-04-26_02,2023-05-22_02
X-Mailman-Approved-At: Sun, 28 Apr 2024 14:39:31 +0200
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

Once a page is read with higher bitflips all subsequent reads
are returning the same bitflip value even though they have none.
max_bitflip variable is not being reset to 0 across page reads.

This is causing problems like incorrectly
marking erase blocks bad by UBI and causing read failures.

Verified the change with both MTD reads and UBI.
This change is inline with other NFC drivers.

Sample error log where a block is marked bad incorrectly:

ubi0: fixable bit-flip detected at PEB 125
ubi0: run torture test for PEB 125
ubi0: fixable bit-flip detected at PEB 125
ubi0 error: torture_peb: read problems on freshly erased PEB 125,
must be bad
ubi0 error: erase_worker: failed to erase PEB 125, error -5
ubi0: mark PEB 125 as bad

Signed-off-by: rminnikanti <rminnikanti@marvell.com>
---
 drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index 1d9a6d107b..d2a4faad56 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -800,6 +800,11 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
 	info->ecc_err_cnt	= 0;
 	info->ndcb3		= 0;
 	info->need_wait		= 0;
+	/*
+	 * Reset max_bitflips to zero. Once command is complete,
+	 * max_bitflips for this READ is returned in ecc.read_page()
+	 */
+	info->max_bitflips	= 0;
 
 	switch (command) {
 	case NAND_CMD_READ0:
-- 
2.17.1
