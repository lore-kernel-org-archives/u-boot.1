Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05149D767EF
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEBA89293;
	Thu, 31 Oct 2024 18:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="MialAQKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A63889177; Thu, 31 Oct 2024 16:36:54 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33D788DB1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 16:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puj3H9dBzo4rCTICPoQSplmlmWpf0eRejq8nVJSrIyU0hrlOVm+paucfwnv0b3XMgvm5jwxBuq90qMEf+hm4VkA6sIAVLrQjlt4fLHAafBhRUqahIAkVxGe5RQy33w4Jzl1EjuxQ6Y6T8EFtL7dStFA5V/NaAs1R67leu+lBaKaAfe1dWbjPqZLxHFgWQr3CtkG8nFdE/L+1bPZeNzTzq/euEIC5kMttS9jBFD7RZzh9Z+nStgU927N9ThuH5iqLjYag7lNLytYkOGc9ZJ/vTViqNg3L7y/ARhJpyZ7WWq2WF1g71LMQGNWZtEkYuY+Yypo+KqHB76t7E3LVgMr9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkdeyYC6qdcenTLUrmI2Ok4VAdNt4mcMT4Pd2Q5ApZA=;
 b=cHhngZk1snY7jvI1/K6Tf821im9oRkULy7734EKOrivmm3x6NeU3oIEsnuSJmWgsa3yqsu0B1kvtf8Hyap2dn4CKDAIRxayoO2o79sxkGHhiFM9VBI+IDNICBky/2TPARdV7j/mVqZSrj1GxJLz7EbvizEzM7/J6VL5YsrcZNIIVvTgH+I/7VSoKgrQdU+3txps4+j3WMdx8ALyu5+AHSaaJAZvV0qZOfqgugeusQUt3tB9v+wj8HHtT4/zULRhYxzxwqmZcfAcM9K1izY6CjObupfh/pdIrtVng28Y1x8/eQVxK02qpXYuoOVBHjhHtnPSgeRmE/f8ni1p1OAji9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkdeyYC6qdcenTLUrmI2Ok4VAdNt4mcMT4Pd2Q5ApZA=;
 b=MialAQKdTntfX2grnNfcWLtNQ0NveuOtnZzo2Cz5882XcAe05lWrmjrjMXtV+hTmPR+rmTzFj9Sr8o5BIRzPyffPKU4cWU1eRJTbJdYqsXSgQL46hn3Xq3oU78SsYlubhwqP8VJ08j3G290EW/v6CiYd4mVpyJHs56JZZJyoiNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by LV3PR22MB5078.namprd22.prod.outlook.com (2603:10b6:408:1e0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 15:36:42 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 15:36:42 +0000
Message-ID: <bc19d568-ee97-4cb2-b936-a2e183969821@phytec.com>
Date: Thu, 31 Oct 2024 08:36:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: am62a7: Provide a way to obtain boot device
 for non SPLs
To: Bryan Brattlof <bb@ti.com>
Cc: trini@konsulko.com, afd@ti.com, w.egorov@phytec.de, vaishnav.a@ti.com,
 hnagalla@ti.com, j-choudhary@ti.com, a-nandan@ti.com, nm@ti.com,
 sjg@chromium.org, a-bhatia1@ti.com, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <20241030204023.2421381-1-ggiordano@phytec.com>
 <20241030215400.3pf3d4tv36p6krdm@bryanbrattlof.com>
Content-Language: en-US
From: Garrett Giordano <ggiordano@phytec.com>
In-Reply-To: <20241030215400.3pf3d4tv36p6krdm@bryanbrattlof.com>
X-ClientProxiedBy: MW4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:303:b6::34) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|LV3PR22MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 299f14e8-8ada-4f44-d4d0-08dcf9c1d1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDBPZzhycDhmdlBQMlAxWS96Um8rMjRxTTBleTlibUhIK1c1MEFjSVFYRkRs?=
 =?utf-8?B?OTdIbVBrUXpQNTdoZ1NEbUs4NEtSMVZiWVpMQXhQdmxkb0F6QW9pYnQwdklw?=
 =?utf-8?B?dUg1M1NCd2l6emJNYTZhRkNwVW9SVUxZTlRCY0lLaVMzYVl4SW9KWXlGNGxm?=
 =?utf-8?B?Q3dFNnBsVGpkcmc0cXRMcnMrWWFnTVU4aDBMNkk0Yy91c0JKSVFhZmZLdkM5?=
 =?utf-8?B?ck1wZ1F1WitibHBPamk1ZVZQV3lzeEI2MWVHR3RoUHBITEpScnljbWNKZWxJ?=
 =?utf-8?B?NkJMZ1lYMXd0eE9uaUxlUUw5NVVoOCsvdE1uZC95RHBocVJMV2ZDdnk3cGRa?=
 =?utf-8?B?UFdXZmRaR2xYeVhUcmJzYTc4dTVyalllUEl0UXpORDlkL2VENC9haUlScEVR?=
 =?utf-8?B?SXFUcmNIdGp4OStUK0RKTWtOQU5NZkRGMWNoYi8yeTFWTGVnWm5YTzM3T2hw?=
 =?utf-8?B?K3hqVThpQkNxV2x4SEF1Q1F6V0VPTEZ1MGJ1Tk9FTi9sZVgzdUlsdm9XK2h0?=
 =?utf-8?B?Zm5yd1d6UkZwWnlLVjlDOFord3E1bnI0Ukl4RTZLTDlmdytPZWVHdXNjMWRt?=
 =?utf-8?B?dzIydndxQlJ4KzBmQUFLSWVtUHFDWU8rUi9zZEt2QlM2K3dTVGx3TVJORVhn?=
 =?utf-8?B?UjNyZnB3anFRNFJ0S1dpMG1qRTlTbWthaVpBczFDcU1Db24waDRhWVlmSVVy?=
 =?utf-8?B?UFI0QjJsUFVRT1h4cFpZOHVaNTExMEtiTTRJaG5jeEZlcmlUQ0JING1qSy9H?=
 =?utf-8?B?c3ZhajI0anFrM3VDYkJWOGl3MzFvby9RQ3pMcXF1K2Z1ZUNWbXZNS3VVQnNZ?=
 =?utf-8?B?bmdYZnd2amtaLzRWUjI1cVZwOCtCUGsvckFRSHJzd0ptMVBnWGdMbk1ody8r?=
 =?utf-8?B?QUs1THp0bmdWMnppOEFtWXBLMDIwQXpWM3drK1FQaVRmaTk2ZS85RlYxandp?=
 =?utf-8?B?OVB5K08vQTBSbDdjQVAxaDFRcTJSQkh0VFBDd2tVN3U0TkFwUnhCTS9VZzFn?=
 =?utf-8?B?SEhnSUllVnpXak1kZXZreGdFUG9PSVZ1U0YwMHNwU0tEc1dnTFJiZ2FXWEU5?=
 =?utf-8?B?d1EzaThxUDA1dGFBNEh4ZVhkcG1BdW9uNjVxN0E3bnZOTU0vRldaMDZweVB0?=
 =?utf-8?B?RWZOdmtMR1VTSXloY2FxYmVrL1RQdzREb0l5d1R3RUN0Vnk0dXcxcDdsUHhE?=
 =?utf-8?B?Ui9NOXo2bDdsSjBhd25QNjFyekFVNzVOWXQ5NWpremlOT3dxRUsySUFOYjM5?=
 =?utf-8?B?cEtYWmFaaWpJRmFQVzZhQlQ3RDI4QytWUTdQK2xDTDRwa1djSUt2ZzBmYlVn?=
 =?utf-8?B?OWZDN2Zoa3NKVkhTaFFZcTVDdGJqMlhNdHZPRGZFTE5WWGtWc3haWVBMSURo?=
 =?utf-8?B?RVZvR0R2MnV2MnU5elNDb0d1NVZEZUliVVhZVnlhaTZWL1hQZVY0UlIwREtu?=
 =?utf-8?B?Z24zQy9LNW9wcUZnTFJKZXo3V0xWTDJxWm1wcUxPd3k5dGV6Z2ZwbUY3eU15?=
 =?utf-8?B?VG1DcytkTkRIaks4MnpLRzFmVnNTcEtKN2JrZGpnbGdzWEdQc2hXMmdYSDg2?=
 =?utf-8?B?Y211SzNISTVUT2djNjlmVjRDNkRvbUZMWmtiMDFGRlBMRjhNK0FncmxJNlpO?=
 =?utf-8?B?dHF4K0tZVzhnWC9teXlIZ2dDZ1Q0anJ5WjlIcXEySS9NSUhhazMzcGRERWhR?=
 =?utf-8?B?SVBJNnZHMTB5V1pwSm5LUmU0dzhzZzdEQWJiYkR5bTlPOUk0UjZOejJ2NDE1?=
 =?utf-8?Q?P9EOmb6Xwg/pg72gcVUcf7x3ht/6YstybA0Jt2h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(8096899003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlpcHRBeDF1M0krYVg2TWlldFppYy9PMHd6TXFOTXZsWUl2UVV6dEh2d0Zt?=
 =?utf-8?B?U1Evd29xTFl6dnNPTXl2STI5UUova2NjSFRMMDRveDF2cytNdnJFbVVYL1U5?=
 =?utf-8?B?K3BVWXJETmhzV0FXSG9MOEJ2TDUvTS9YNStoY2gvekwxNEsxQzZ5cVZWdklv?=
 =?utf-8?B?NmZpMlZpNjRWOUFGdDVUaHNyN3hFWG9nemZJNHFHMy94ak1rNmp3WmdHUGxk?=
 =?utf-8?B?YnRMQUpDbjNIMnZGTU9wakU4c1NaY2hvZHBaL1FvRlZsOXhZdzViWDhEaDRJ?=
 =?utf-8?B?blUyRFc2WmJGbEJwcG5ZRlY1aVh5OEZlTVFJNWNGdlhRLzFZTnI3cEJqLzl0?=
 =?utf-8?B?NW5sY2o2blNPK25qVnhSQzMvaE9veW9kTUxWL0dGdmEvcGUya05rd0V0RWdh?=
 =?utf-8?B?TVlmeUk1UmFac3doUjYwTUNhaXlMa0orQ3VZL3YzRktYT0lUSldtcUxSeld6?=
 =?utf-8?B?SWFxeUZMNm12bEhja29hR3l4aUsrNTBZYVZ5R0ExZmtmTHBFckRPMXhxajIx?=
 =?utf-8?B?TnU3aDg5cVhRWThnUXNud0NPWUtWaEdJQUZ4K2F5aGpIdEtDSXlneldIM25t?=
 =?utf-8?B?MkZRVWdobmpEakQ4ZjJZc0RONWpCUlpQSGUwVGs2N2IzWkYveG9CZW9vM0Rn?=
 =?utf-8?B?ZDVWbW95dkJDbzRtQjJ5SU1DWmNJdmtocVlUMHZzbWVla0JlcUpCTjVJbW1O?=
 =?utf-8?B?ZmxVejV5TGR5c0pvQmxXc3RiWjg2TVdMSnk0MUZmVmZmYUgvOUgrWE8vczRw?=
 =?utf-8?B?SUY1eGVTVTZKK0FBYnc1VHFZbVJFaEsxTFhGdytWNlpyNVZqN3AySmRXeFBq?=
 =?utf-8?B?Unh6S3MrT3JhaHRUazErMUlCRVdHZEZETXNpdzlhcnM0UlcvZ20xSC9Gd29R?=
 =?utf-8?B?d2lnRmJNbi9Rems5RysxUGpmSmR6VFh4aDVBdFQyYldOUmlib2pYcDNPZU5V?=
 =?utf-8?B?aVQrd095anplUkJBQ2pHeDUvbThNZGtSUEJHWWFKR1d6bGVpMjdOb3Q2ZUYw?=
 =?utf-8?B?Rlk0TFI1c3ZhcEQ0WlJFNldrNlYrbjJKV3U1alFCSkJQUW5PSUJyUmxINEZj?=
 =?utf-8?B?cmVBbXRrekRmMWc2SjhiRGVQbVp0eTJTTm9PZzFvMXo1eUJmOEVzaDRZbGZH?=
 =?utf-8?B?RkxHSW9GaUtNTlZZOExJMlZOZGduY1Zxc3RnT2VSczBadEtiTmliTUtXTGg2?=
 =?utf-8?B?QTVqNkhYNVdjWnRzcXRtNVNEdjVpWThmUXBtZjN5ZGdVdEEzTXErdk01cFl5?=
 =?utf-8?B?WnlwKzhkd2lGY2JyUWgvZmF5NDZFYVRKRDNaSEw5aEwyRHFrb2JsUStveFZZ?=
 =?utf-8?B?eXJiRTg2bUNXYTlOVjhjd3pZeHFlbWIrTmR3WjFGemdsV3pEVzlYcnpQeDda?=
 =?utf-8?B?OWNiamxiN3dxTVZvR2Niem9zZzZQSmNPQ1ZBY2ZyTUQ0ZnVTSkFRdUI3Vkpk?=
 =?utf-8?B?dkszSVlNUkNObEJtaDFDa1NYU0dpRW5RR1M1VGZuRnIvNmRwL3cyb2M2LzI0?=
 =?utf-8?B?OC9ITUhsVXAzbUJJMVJ2aTk5WjYxNGpsWjZvMFlGdmlSS01uWnFqZ2tXWnY1?=
 =?utf-8?B?bUh5UEVVYU4vRVVrWHYzNFJwd21saEFBTFlkd0N6TWFVSFdEM2R2NUcwS1A1?=
 =?utf-8?B?dk9aVjZCQjRNVFJOcW9WRUdvUmFpclZMMmJTWEE4SkZpUkRrYTVxRktiOEti?=
 =?utf-8?B?a3VGaFZkRTBWZkd5VWNaVzhEYXZxOC9vSzhwRTFIMG1LblNhVkJZL3ZYOXox?=
 =?utf-8?B?WUZjcjVnWmV0Q00yMnNYbzd4cDB6SW1XN0FYbjE3bjBBTG8xMWU5VjZIVXhq?=
 =?utf-8?B?WFJXbDdBNkxxWEZqdmRSZVBKd3JZRHc3Y2JEMjhkQ2VueFZicU9uMWpjejdC?=
 =?utf-8?B?ZlpvOFVPYXJEb2g2UjZ5ZThxeGk4a1Fiais1STloM214bklvQzFNK3kwR3dV?=
 =?utf-8?B?a3NJaWt0OXg3dm9SNzhuS3RHV09QSWRzU0l2K0FmL3lDbGI2V3dUVzZnVDlC?=
 =?utf-8?B?N3k2TEpJbzVzN3NTd1c4a21UMitvMG1xUDd0TjQrMXZNQkE5RnVGVFJKUG53?=
 =?utf-8?B?UFpuc3JXMHJKeDlYQUtlWldPYUVGY0Q5UHd1V2RyeGRkaHREQi9IaXM3cml0?=
 =?utf-8?B?RWR4bVl4Q0hpT21lcWZDZDVDSzZQRk9JYmtUZWtOMFZMMFR1QmdZR3FUdDdZ?=
 =?utf-8?Q?0LAf/pb618Y2ewvu8BsJ/Lc4QZZASkg2DofLRRQvRtFg?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299f14e8-8ada-4f44-d4d0-08dcf9c1d1b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:36:42.4844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QBHAcC/qc0pl4lO7jLwcd9Wi4BQMV8++ItVYpmBQvpOwWCGW9AImgyxuLQZ2gLOSg4gKMqr50n1EH4VHRCQKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5078
X-Mailman-Approved-At: Thu, 31 Oct 2024 18:13:37 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey Bryan!

On 10/30/24 14:54, Bryan Brattlof wrote:
> Hi Garrett!
>
> On October 30, 2024 thus sayeth Garrett Giordano:
>> Introduce get_boot_device() to obtain the booting device. Make it also
>> available for non SPL builds so u-boot can also know the device it
>> is booting from.
>>
> All looks good but I'm trying to understand the scenario. Are we using a
> bare-metal boot loader in tiboot3 then packaging U-Boot proper with TF-A
> and OP-TEE in next phase after DRAM is up?
We plan on using get_boot_device() to figure out where to store the 
environment and for proceeding with the boot flow.
>> Signed-off-by: Garrett Giordano<ggiordano@phytec.com>
>> ---
>>   arch/arm/mach-k3/Makefile             |   1 +
>>   arch/arm/mach-k3/am62ax/Makefile      |   1 +
>>   arch/arm/mach-k3/am62ax/am62a7_init.c |  97 +----------------------
>>   arch/arm/mach-k3/am62ax/boot.c        | 106 ++++++++++++++++++++++++++
>>   4 files changed, 109 insertions(+), 96 deletions(-)
>>   create mode 100644 arch/arm/mach-k3/am62ax/boot.c
>>
>> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
>> index 8c4f6786a5b..ce09a30e58f 100644
>> --- a/arch/arm/mach-k3/Makefile
>> +++ b/arch/arm/mach-k3/Makefile
>> @@ -10,6 +10,7 @@ obj-y += common.o security.o
>>   obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
>>   obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
>>   obj-$(CONFIG_SOC_K3_AM625) += am62x/
>> +obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
> Yeah I don't know how we treat 'x' here when alphabetizing things. Do we
> treat it like a literal 'x' or is that just a regex alias for .+ IDK.
>
> Anywho, it looks like we created a second entry accidentally. But the
> substance of the patch is sound.
>
> Reviewed-by: Bryan Brattlof<bb@ti.com>
>
> ~Bryan

Your right, I added the second entry accidentally. I will send a v2 with 
it dropped and pick up your Reviewed-by: tag.

Thank you!

~Garrett
