Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1697EE20A1
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 13:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172EC836D3;
	Fri,  6 Feb 2026 14:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sFs60tO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4B9838FA; Fri,  6 Feb 2026 14:14:46 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970708352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 14:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=t-pratham@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z840+DLKZE2aOTc3lbt0U30Go337I9kvwqlC0GcBK7tGtyyoWL4fbeGAA/npqi6ClV/9Etb4/z6zfbu1ozU5hZmGlGE/geLoGQ2RzqhqSSgzVnNhcP2Mx7PGCm45RmMQ5I+gaYzKw/1NjCL+Uqmg8B2q/AMW1yrhySO+F/tK8jCrK2uqToJSlZLG85aR5PGfiIZgbgNpDr/z//ThGK+9Y2ACBHcGjvD1mj21JFoFrbNonqVwVw9hpMykxh2PsMWMsqm+ZgVukPK28N/ky+j3oajamEdM5v7ODvacoNQhRCy06XHiS83MoAk2lP1ZTliSUhdMXH+8oSEIv0tS2BgHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2mWOr53Xf/1u+FicYeg3jCOcqzZVD98gwI83sTwzdE=;
 b=n4HG91CpINegua93LnipEYlsTqaPdU6hW+N8vWJ9Q4PtdiCffhptc0gunGRk3mAJrVkAkSDVeXQUA4eeUiUd7BTIti3bgh/wW3nNl/iLMm/Oq20Q1sUsX+GSVzCfyq6DFZ71lS6NJMvisUWco3W2bX1YPOzh/57sqAEawerDvhBfjMPR2O0hBKRA2FBgE173mmvO7EjEQ2kh5KtFeirpZ2bkfjj5nKaY3DO3tB8Bs53zYkTBKxMTvPE2DIjhdZtYWWIYuAnkHeInvLJH1R9YVxGkyjrkSkAhooMHRei9WzDC+bf0AiiG0eZfmcUi/9a9HA/A2XMrwHvTRRJpVHzz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2mWOr53Xf/1u+FicYeg3jCOcqzZVD98gwI83sTwzdE=;
 b=sFs60tO3A9hDH9oehxo6thMdcf1iPhcHefjwWNae+qaKXrFJw6aTkzht0fn7oiEVRnKjVxbl24hbwby6H/XqznRsz6zHYhkhKbjDu9nw/GYVEV8wtd9gDcs5KSqN9gmbGt3Lod4WDK7tJsxgXF48TSrqdjbbDlLomc+nI3GYeE4=
Received: from BL1PR13CA0409.namprd13.prod.outlook.com (2603:10b6:208:2c2::24)
 by BLAPR10MB5010.namprd10.prod.outlook.com (2603:10b6:208:30d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 13:14:40 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::62) by BL1PR13CA0409.outlook.office365.com
 (2603:10b6:208:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 13:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:14:39 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:14:33 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:14:33 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 07:14:33 -0600
Received: from [10.24.69.191] (pratham-workstation-pc.dhcp.ti.com
 [10.24.69.191])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616DEUoR1290074;
 Fri, 6 Feb 2026 07:14:30 -0600
Message-ID: <73663e66-653a-4346-a976-bfa8fc11dff0@ti.com>
Date: Fri, 6 Feb 2026 18:44:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add a build time parameter to accept custom signing
 key
To: Quentin Schulz <quentin.schulz@cherry.de>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Alper Nebi
 Yasak" <alpernebiyasak@gmail.com>, Shiva Tripathi <s-tripathi1@ti.com>,
 "Vishal Mahaveer" <vishalm@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Andrew Davis <afd@ti.com>, Ryan Eatmon <reatmon@ti.com>, Neha Francis
 <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>
References: <20260206110439.1236201-1-t-pratham@ti.com>
 <3fc12168-7c48-45e0-986a-79acd9dffeb5@cherry.de>
Content-Language: en-US
From: T Pratham <t-pratham@ti.com>
In-Reply-To: <3fc12168-7c48-45e0-986a-79acd9dffeb5@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BLAPR10MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: d7064d37-e420-4204-153b-08de6581aed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1JOalc1Q2drbC9LaVo2NGJZdTJUa2FxeW9VUDhZcXUySm4rMi9UQ3NMUzIy?=
 =?utf-8?B?T01nZmhnL3QzMHd6aVdrQXc3U3NvdXBTK3JjNVExRGxmQ0FlNFNYd3pDeXE0?=
 =?utf-8?B?UW1KUDNFbE1kMlpZQ090bDAxcU92aHg0TlRvR2lacUxRNFJaaS8rTERLRzI3?=
 =?utf-8?B?N3BKMVFiNGtGSHBEbHAxTmhvMXQxOHVqdGFPWm9WanhDVUhzZjA0bzNYYzlK?=
 =?utf-8?B?YnF2cnBONTZGbXJPZEtNRUg0TGxqSk5ubkpsbitCdjdSNUc2Nzd2RWhZNC8r?=
 =?utf-8?B?WDl4SXg2QWc1RThrb2RObks5QTNVK2ZMdytnTks3K1VOU0NJbjBDRlVKU3Zh?=
 =?utf-8?B?dFBNb1lMSFZZR3d3Unh1a2xuMjhhZlFXMEkwUmVyWjhiYjR5ZzRDVGlTL09u?=
 =?utf-8?B?SXZ4SFFEZVB5MmtrUUNLelIySlBqMjE1NjQva3NxUDNUSG1JU0JUN3B3YkhU?=
 =?utf-8?B?b0dESnJySnArcU1GeWlBVTQ1eldFQzN2d2QvZ1NaRVFSSEU3M0N3YUxzbFRP?=
 =?utf-8?B?MXJYaHBnNFZzZDJWUzdGS3NrUysra1pSZWNpRWhrOFNCakRSZHBPTHlEQTJv?=
 =?utf-8?B?WGl3Yzk5N3VqaFJvb2FuL3czQk11d3N2QllWYWpuYnBRK3BUNTl4YmhGUXFS?=
 =?utf-8?B?QWRIRHlNOWpaM1g0TjFTTy9mVmVqcUNIa1lGZGNYRU1Ld0k4SkhqMTgwWXN2?=
 =?utf-8?B?a2dRRy9mM1E1UUJUcVBsanluUGZ3cEJqRWg2d3cxV1pnZUhpVHhobFFSSXBK?=
 =?utf-8?B?SGxPY0ZqWmhCOFgxU0FIRVNhcVdqdGhURmozYWtDUk9Ja0gxUEFmOFlJRG1x?=
 =?utf-8?B?cTJ4SExjbVpSSHpyeVRrdTJleFFRcXFIMlhWa2RYYkFSYjA5R2V0ZmgwT3pP?=
 =?utf-8?B?bkYrN29uZjF4Um5lNmZzdWdZVWhaTGhtNHZOcWtsdm1Wc1JoODBwd0dEWFV3?=
 =?utf-8?B?Rnc2ektjUUR3Vk5zUXlTT2xldlduZUppeHVqYXJ2a3BkVk1lZHdwT2hZdUFS?=
 =?utf-8?B?NGRxSnNUeHh4Q29zZGxPVG5IRUxNMkNFN2JUZ2Nxc1FWdVBmb0VpbWsxMDBG?=
 =?utf-8?B?OEZ5c1VHaS9PTlBsdWhyQnpEVVMyZEtvaSthUUdkQjRPckdBUTJXdmVYKzhD?=
 =?utf-8?B?TlJ2QUVLQ1ZaSWtEZDFtYWltNnk0Ri84V3ZFeVBRM2kxK1ZvajVSMHNkK0c4?=
 =?utf-8?B?eXp2N2tRdk1vZnVLVWVsdUxRclp5dEd5cHc4ZDdpYkhKa3l4L3ZQQTJyTThs?=
 =?utf-8?B?WUMyUTVOVHY3ai9vZnMrS1VHbVFrT1RyaU0wQWZDejljU000clFacWxYUEVW?=
 =?utf-8?B?WEZlaTM0aUZOZ0hjRGNEZFRWOXFuL1N5dTJaNDloU0ppTnlmbmtGRGJIS0Iz?=
 =?utf-8?B?SDJHUVZrd3dLcVFBa3JZTFRDV0tpdUxNeHV2TEIwa1VIMXhXMTcwNFlwbVBD?=
 =?utf-8?B?RVJwV29IRmdhZzNPV2dQWHdTa3l6SWw1Zi9LaUVnZmVmSUlNcUxrdGdOV1U0?=
 =?utf-8?B?a3hacDQyOUJiWUY5VUMwcTJpeVBaN3BmZllSbWtTRXlyZzcxUG0yNUNxVUNi?=
 =?utf-8?B?UjUyTHFvUzlCdEwvazFSbm0zUnRyZlBOU3ZJb3VBa0lUU211aXFST1ZCVDdW?=
 =?utf-8?B?MDZRUmZ1M2w2eXlmSTlEMGtsTkRGMkFmd1BRb0xNbms1V1ZoTW15dHhrUTY5?=
 =?utf-8?B?MGlLVitrcCs3SmMzSTNXdlZYdEFVbnBUWmUvK0VkcUNKMDhiQ01DWW14c3lO?=
 =?utf-8?B?M1NYU3Z6SzQxZ2hBYXY4cTlkVmE5c2ZFYTlnbVY1UTlGdytpeFkzSE0wOHRT?=
 =?utf-8?B?WlkrT1o3Y3g4bmd6YkJ0Q05kRkdaTGF4c2w2Z0FvZjFlaEVOb3pyYy9GdnBv?=
 =?utf-8?B?VXZ0bTZZbUx6bWNhZnFsUUkrY0djU2EwVEFvNWt1SVl6SWxqOGs2eWpzak9Y?=
 =?utf-8?B?UlhZeGVQa2lQdXhtUm9VOUViWkxFUXp0MFJMQkNSeTF2VTVhQmZWUk5sekU4?=
 =?utf-8?B?OFVKd0hLMGZBaEc1WVZIQzI5eGJRZk9ONVJSdGhNV3VaNTFUZlhReVdlUnY0?=
 =?utf-8?B?V3BFdDBEWXl2WmZWUlJtTUQ3c09XRVVOMytkUTM2eXN4RnNLMFIvUmhzd0lq?=
 =?utf-8?B?QWJtbzAxWEdqTno0QW1kcFByQzJ6OXhIU0xZOGgwVW9XdSsyVUFLY1pmZ09T?=
 =?utf-8?B?Y3cyYVNjMFl1VU95Z3hURTkvcHRJYUVWMWNGY29zYWhzQWhRbTExRGlBVjht?=
 =?utf-8?B?QUI3MnZGSmIralFwK1kySXZFQmJRPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ozm+lFcBr6vvD3ErxtETAdaOOTKVDBLpw89Vez+WYmd9BDLXWnLjF8SxPULU/+qpl16AUvaGVJpOu36NMY842vaRX2Hkk2gQY109k9hsJP6S4JShuD1vHq/Bfz7r77RCSy5pqaZnWvbvDnmN8GAx/yI+HXuE40ONrUygXBENsLwrWRsWMxlpASCVf9P7Wfh/S2taAWgmTMJ4p0/c0ShF8p2FSJNFFd/qOtQmZ5e5WR7XjKRBVKGWJ1rs07kxg+MNDRtskjB0cFX9ccduKLG8iI9hefZqvPVG/3HuvFaVjaakEnk3cguQnTPlwJcosJsLaQvtONF1kvSLtCiaXGzeVheeluCnJpnn/jCg+JfApnHRyyny/wxmcL7wTamzCJMr+Fvh5THi2527xhKSmiLgXXkJzs60sPX//u6ar8trxT4DV66Q9DPa/xUed1H8/cbO
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:14:39.0361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7064d37-e420-4204-153b-08de6581aed5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5010
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

Hi Quentin,

On 06/02/26 17:01, Quentin Schulz wrote:
> Hi T,
> 
> On 2/6/26 12:04 PM, T Pratham wrote:
>>
>> This series adds support to use a custom key provided via Make during
>> build for signing the bootloader binaries, and updates the k3-binman to
>> use it.
>>
> 
> Can't you use the same mechanism we have for adding the pubkey to the
> SPL DTB (see tools/binman/etype/u_boot_spl_pubkey_dtb.py)?
> 
> We use key-name-hint property which is a key filename without the .crt
> extension, you don't necessarily need to reuse this (but I think it
> makes sense) but sharing the logic for finding the key seems more
> interesting to me.
> 
> We try to find the key with tools.get_input_filename(self._key_name_hint
> + ".crt"). The paths that are traversed can be specified with
> BINMAN_INDIRS. This should help with not having to add yet another
> variable. Set allow_missing to True and if it returns None, then use the
> key listed in the filename property?

Thanks for this insight. Re-using the key finding mechanism from
u_boot_spl_pubkey_dtb.py looks promising as well as clean. I'll look
into this.

> 
> Also, is there really a need for separate binman image just for keys?
> Can't you have ti-secure/ti-secure-rom use key-name-hint directly to
> avoid yet another binman entry?

I have very little clue why our binman dtsi is creating a separate image
for key. It existed since much before I touched U-Boot. ;-;

The bigger picture in our use case is automating our internal Yocto
builds with different signing algorithms (RSA, ECDSA) for the same SoC.
This was the quicker and easier way to achieve this. I'll try some
tinkering using BINMAN_INDIRS + key-name-hint mechanism by modifying
ti-secure/ti-secure-rom.

-- 
Regards
T Pratham <t-pratham@ti.com>
