Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DACD10399
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 15:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B45788D13;
	Fri, 25 Oct 2024 17:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t5s5B1/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182FE88FC8; Fri, 25 Oct 2024 17:50:50 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F80688A7D
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbl5kFbvLkY+dmRutaT91s54dg3qDejLfGKCGtj7mvBLn6YqveupZI7z3DK/7aFu8Y/UoAbpfgBXXbraJCXtQTPPjke0Sfroz/riXWa4pFbbUPlbmXYudwVQFqTXyvcRhIV22luS06XOFy/a1QSweAth5DKZmCIDe3Mu63DxDNiGyfAGD+SdXt+mfesGPAG8Q8hu1oruOUlZuc2bPOoICklgj01psOvTsv1jQU7SvR4XvpRAQREr+ujcRluh4zKION66EFqsborh77Q+6bSVjEOPrQZpPcMdCTDLaVpDgQ48H2W8bhkPVFysWixw6jlAdAs2atv/whlLx48IW59L+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfncNkU/MxlQDltoJvZQWb9fWKuy01Lurfv8mMbi8e4=;
 b=jdcrmEVnqa9yfaIoShJzQYstW7LmYRfY+ah1+JSUy8sVIfbmgmSNVel0oGfdiogpS6Af1izWogCxu3oqe4XCa/gS7W2Vi54VlaIf5+Cs8hx3q4GKFC3ydzCY6O+QaaxV+7CW9M3EX+N9jrvQLgUvCdKegDTcupz2XQqSxbFRYeEoa+aNrDKerwGC6dc6UbhNEXhm7+dzqRq807zI24LmNu+nsKD3GwVZg6al6SvpDrCM0mYBMjWYjBbsFTXg+r90PrJTXJqtk8i05PlU+6thyrGYJFYwl1b5Pp/YoIpHOZOFvHfAoEvaF0gxpIBgOEIZaz+DMV8b3AhE56QzVyO8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfncNkU/MxlQDltoJvZQWb9fWKuy01Lurfv8mMbi8e4=;
 b=t5s5B1/29gLXWcyvsiVyfWzTO/hxH6oLgTHUYuPyXKzZfd9uozhVG0wt0Vog4kQ/2ZMGjLFuq40f2kewYby/C1ULym+bFcVYGidp+QGppsrV8y+U+t6cLNM2Hts6J62wOsoa2FeDX2sgT8sc5jELNv3KZowt72hZC1trSW9K1fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 15:50:34 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:50:34 +0000
Message-ID: <70e3a9b6-229f-4db0-9034-19b04dde9f80@amd.com>
Date: Fri, 25 Oct 2024 17:50:26 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] xilinx patches for v2025.01-rc1 cont
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0214.eurprd08.prod.outlook.com
 (2603:10a6:802:15::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fe5b79-db25-4060-49d4-08dcf50cc333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnNDa1ZHNUN3N0J4bFA3RFJOYi9BMFF2ejRta1lMam02WndMdGZVMU5rbmhy?=
 =?utf-8?B?VE5CS0FWY0QxNVRFYTFhdmQ4eFBVVEdzcitQLzd2NnBwYlU5cE5PQjJ1Um83?=
 =?utf-8?B?TGtWNTJpaDJVUUhwamJLOWdkWWpLR1N6aWVTaWVrakVQZEtJUmxXMGFFLzVr?=
 =?utf-8?B?aGxqYTN2THRNcFl4Y2h2dmU1bXc0RVozaEZZNVVRTzNhLy9XSmpGUGEwUnN1?=
 =?utf-8?B?SWRUUm9meVV3Q0xaWi9mVDkzTDVvU3dSUjQ3WUxUUGs0dEFmd3FNL2JPMG9q?=
 =?utf-8?B?MGZMemlDcnlOcWNsQzJUT2FwaTE5L0dYVGZQeFNqYXNDRmFKanYxWTJSSXl0?=
 =?utf-8?B?Q1RGMmpzQTlQdjEzWkRCTERCUVVRRUVoZkM3VGFtSnZTbHJGODRCejgzNi80?=
 =?utf-8?B?WFdKeTFXSm5BWUJPQnVvQmtHMGxaSTJRZVBTYU9rRmhLMHYveDJYWTRoNUJy?=
 =?utf-8?B?ZW9HMmNGNVNSZjZCbGdac1pER3hLc2Q4SUNLSk5sN0RzMENId2QycDRkYnFZ?=
 =?utf-8?B?VXNSaG5nZ2RUSTd2WHU2a21XSHp1NHJYc0NKdmhoLzZCdDNTanBXeDJOUU9N?=
 =?utf-8?B?ZzdLT1lCUDNjZmxhbFRkMXlRYVV2a0JHbUsveFN0ZjRHaWoyK0xsU0xUbDIv?=
 =?utf-8?B?aUR5cmRrcks4MVBBT1JsSnlOSGtSN0lHSnJ5U2h4bmlIRFVtYitwbnRtUlRY?=
 =?utf-8?B?UVhoQXdrTDRkdm1Sem92V2ZwdjhrbUhJOWJnazlhelk1VW5JRkhBRkFnTXNP?=
 =?utf-8?B?VDk1MERmL2I2dlQ0M3NTYVlMQ2xsRGRwUFUzTU85YWFLdVYwWDhjc05veTU3?=
 =?utf-8?B?eEFvNzQzWkFUOVhiNDVDQ3ZoN3BubGlKeDNXRGRYRlErOXdkaVExSVNrNmVK?=
 =?utf-8?B?RU5LT093WDZSUGNQT1FRMkliSlFEcE5JRmxQTktWZW9SaTlFVzVFeUZ3OFJZ?=
 =?utf-8?B?UzV2UnNDcDdCUlEwekltVkxvMVZkVDFEbVJmM1pBK25UVXoxWHljVExEVkNy?=
 =?utf-8?B?cGlsZnY3NGh1Yk84cHJKOXAyZldlZjZRbFpuTXlLSXdpTlExa3dJMHFDbXR5?=
 =?utf-8?B?VCt0bnlxaWlKOGNhSytsMStGWWN5Z04yM2FidGpuNjVXU0pmNTAzUWNwNEk1?=
 =?utf-8?B?SVZ6RWRocDViMzBEVXh5MnhXV0lSU3kxV2VPcjRzMHJna1J4V1lXcWZ6Z2hu?=
 =?utf-8?B?ZnpkUVBzZUppYXVzMEU5NSt3VTQrR1hIWEl0azRXd2xrRnRqcmM4aEJFZm9r?=
 =?utf-8?B?RFgrWkZpdU43MitWbDc4Zmo2dHRKTldQUVBHUWc3bG9tVnpKQUlvcXpsbFJJ?=
 =?utf-8?B?NjljcXJITmdqUVFETUI0dWVna0wweWhTc2pqdUlEYXg0QkRseFdydi9FQVpv?=
 =?utf-8?B?bWkyV0FSN1RteEFVL3lTOEROQ3MwMUxjZUZSUERQLy8rNXk1K0luanFSMUxo?=
 =?utf-8?B?ZjdwY2hTa1hNRzNmdG1ZTlhXMUFBMGdSN0QyT0JjOE1Rak1YcVpFOEwyakJI?=
 =?utf-8?B?aTJGQlgzcjlwODdYZmlOS0RjVzhSeFVhclVjYjJXTkhxVUVxK0d5dUR3RnB5?=
 =?utf-8?B?RVFBOEhnWjNNT2xVR21VZG9EWWFpaTVLOXRUMkFla1hEL05hSnlkZmp0U2hw?=
 =?utf-8?B?Sy9qeXN0SnVxWjcvNmNWc2dvaCtHWmorOExiREhSNFg4MktXRHFZZUlndEJX?=
 =?utf-8?B?cEZTbTFCRThGZ21ybHBEUFVjM29oRys2UCtFYW1kcFFVdlE4OFZGNGR4REZ1?=
 =?utf-8?Q?OI1zSnLOjlp4E8bKaOfxC+zz4fZmDrxzpssboWS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlnVzVQWjE5TUxpazlLYTNmZTVFeXJva2tNZElTbjdrUTR0KzdseVlQUXZw?=
 =?utf-8?B?cGNCQlEwbVlzcFBGQi9LdldIUmh3amZBUnJ3N2o3OGpFb0N0OU9meGVGNzlk?=
 =?utf-8?B?N3ZDYnptdTJlcTBYbExadm12Z3lDWlRZdmdWYWlNQTNCZEZoQUpLS05ZRGlW?=
 =?utf-8?B?UFRTSUVkUWxnbEpJME85K0RUY0g5eWZhTVZDZW9PSlI5d0g2QlBWL2FkYWVy?=
 =?utf-8?B?RytiMVJKMGVEenV2emNLQ0tIdzFBbTRWbnBGME1oUHV2K252b1NKblllQjd3?=
 =?utf-8?B?TGc0ZC85VlUwRjc5S2RzekVJRFVtRG82RjRnWFc3a01EOCtobVBRMmlmY3JG?=
 =?utf-8?B?Y0ROUWsyMGdLWGh1U1pmRFpvNTFnVElheHp4SVBKUmxLOWtMRzduc2lMN25F?=
 =?utf-8?B?RWZQK2pSQ2kvVUh6WVJOUksxQTFRNjJQZldoNmJLcjUycDBDaXNaSlhBZWRH?=
 =?utf-8?B?ZWZvMHRaK1hzL1p3U3drZmhockJGMjN1NjBVTVZyN25nVXJTOGRnVTBGYys2?=
 =?utf-8?B?R0RTb3d1US9mK3luRWJuN3I0a2lLRHFIOHBTbmlHV1ZiTG0wWUR4OCtLZE1Z?=
 =?utf-8?B?NE5adEdBR2wxbVRtUXdBUGR0RFkwa3IyY3Q5YlZkclUwRHhXbTNMYk1EVlNn?=
 =?utf-8?B?T1RhSnJVeVQ2NDJkSnRtU1Z3dDlGaHhKY0FwbHZJUHZCcWs0R0JGdE5xSW00?=
 =?utf-8?B?bDl2Y3V1dUl4czcvRHFHMUI0SEVoaThXTnZsenRjU3Y1c2JPQ2hteXp4UFg2?=
 =?utf-8?B?c1pVWWRKaloyZzJkei9qZU1PNGd1YS84Skk0cDMvZWFTNjRVNTBaNzFrY0p6?=
 =?utf-8?B?bGlXaFMySExIMzkrS0I0amZRWjlFQnd1c0ZqTUhiWkU5cFBIRll4N29YWUVy?=
 =?utf-8?B?bGxWNElNOTczNnFDalNoQmp1TVJsU1ZKbzBja0lnZ2F5bkxsSW8rYlkwdmJa?=
 =?utf-8?B?UVpUKysweW5ML0dLdVNORFZ0L0kzdStvWU1FZW1DWUhaVU5QbFV2NUtZdHZC?=
 =?utf-8?B?dWtzNzN1MTF1WVQ4Vmk1L0Q4YnlqRFNLbmNiTDFna2tPbVc3UnJFenhYS3Zs?=
 =?utf-8?B?R2o4b1lRbU10amQ1UngwdHBwVTlERXhCL3BRa2RtVnlWYWQyZ3d6NWM3d1dL?=
 =?utf-8?B?VkZXYm14bUlOTDhzVStQcVlISnRaZnF1eWkxZmFEdERqMkNqT2xFVXJxTHBo?=
 =?utf-8?B?S3RPa2R1M2xJbmNmU1FyYW54Y1BMcGVaanEvQ3hYbGJ1TWhnc1g2WXdjWDl5?=
 =?utf-8?B?ZWRhaVNEdGowQnlvdG9EK1hZbW4wTGtSbnJONEtYeThvczVpV1hNaEFuUStK?=
 =?utf-8?B?Y01PL0RGVm9HOG9Nd1ArZnRzSnU4Ty9xa0xtalBhWkZFL2xOWmlTdDNJeTRC?=
 =?utf-8?B?ZGR5elAyTW5ybHRGcWJ6STArRGwvampTbXhZSlZWTEQ0b01QWWZxbW83TzdV?=
 =?utf-8?B?ZU9OOTVPQjhGSWxsY0NjU2E2aHpoaW4rZmVRTTRYU0FHVDgxUGJFK0R6aE5G?=
 =?utf-8?B?Y0xBOTN4Ykt6NGdkeU9DYTBSU055UVRiem55V2QwRmNaRkNBL1NWc2dwSG00?=
 =?utf-8?B?WjNSTzBmOXlIOVJzOGNmVEtNVGo5RHRSMi9pT3NuK2pxZzB5bFVyTEhMZmZV?=
 =?utf-8?B?MlMrbks4VWRLVTJ6VmhpZFRWZ2l5VE5YOWo2Q1N1c2diMlZBK1N3NkliR3hs?=
 =?utf-8?B?d2xORFJVdzNSWGw1MFF0U3BZdWc0K3RZeE9TQUluNndxd0twYllUVytyNFRv?=
 =?utf-8?B?UWhPZVd5a25MZmNmeFFOY2VFQVk5WjY1NkVWQXV0M1o3b3NseTdTVWJKYVl5?=
 =?utf-8?B?bkNNUnpuM2dxeXgxR0dla2RJalh3LzhKSGhTYm1QdlVycjVnd0pGM3pJeTBK?=
 =?utf-8?B?SDFYQ3pTVnpIVnBDRFJiOHByZDF4bFVBOTU4UzdmNUkybzd4K3NMR0EweWV2?=
 =?utf-8?B?Y1N1YnRNaEVBNzNwbFlnUXZqMnFjL0pLak9BSHJLWXdlUGwzSTdSVkVZUFFl?=
 =?utf-8?B?NjNpWDBQMTREZUNIMW14dTZURmVFUExPVjVpY1Bsbi9RUkprVkRlSTU4cEJK?=
 =?utf-8?B?d252QlI0eHh0YmNvcXNySEREMDhpMmMzem9Ua2tXVzRxM21lRSt1bVlraHIr?=
 =?utf-8?Q?oKTLxR5Fm+xbMLyvuqcYyINv+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fe5b79-db25-4060-49d4-08dcf50cc333
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:50:34.5666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvkazOzflNv9dF+Ht9bGkFXvnLs3hIViEjW/3amjNbQ8aJ/BqAhqQA5we8mFA5ys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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

Hi,

I have collected couple of more patches and would be good for me to clean my 
queue. There are some other patches which have been sent recently which will 
come later after review.

I am especially waiting for memtop series (sent today) from Sughosh because it 
is fixing issue on Kria platform which is regression because of LMB series.

Also would like to get rid of SPL_FIT_GENERATOR in this version but I think we 
are almost there.

We also started to upstream qemu model for MBV to be able to wire this platform 
in our CI.
http://lore.kernel.org/r/20241017072507.4033413-1-sai.pavan.boddu@amd.com

Thanks,
Michal

The following changes since commit 08ae12be8509daf3d1c5a148b8a50c0ffb6457c2:

   Mark a few functions static inline (2024-10-24 11:21:48 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.01-rc1-v2

for you to fetch changes up to b3d9c6c71412fe63320e879d89873da672e69100:

   .mailmap: update e-mail address for Padmarao Begari (2024-10-25 16:21:00 +0200)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.01-rc1 v2

.mailmap:
- Switch Padmarao's email to AMD one

zynq_spi:
- Make update_stripe static

xilinx:
- Update DT description for EMMCs

zynqmp:
- Update logic around RPUs and tcm handling
- Update bootmenu selection for Kria
- Add description for SC vm-p-b1369
- Fix comment about file location in zynqmp-p-a2197-00-revA.dts

versal:
- Fix logic around USB boot

versal2:
- Disable useless features for Mini configurations

versal-net:
- Get rid of current-speed DT property from mini configuration

microblaze:
- Fix scriptaddr location

----------------------------------------------------------------
John Vicky Vykuntapu (1):
       xilinx: zynqmp: Remove conditional check for bootmenu_default variable

Michal Simek (6):
       arm64: versal: Remove description for USB1
       arm64: versal: Wire USB0 in distro boot
       arm64: zynqmp: Add description for SC on vm-p-m1369 board
       arm64: versal-net: Remove current-speed from mini
       arm64: xilinx: Fix file location described in zynqmp-p-a2197-00-revA.dts
       amd: Disable LMB, BOOTM, MTD and EFI loader for mini configurations

Padmarao Begari (5):
       arm64: zynqmp: Print an error for split to lock mode switch
       arm64: zynqmp: Fix tcminit mode value based on argv
       xilinx: common: fix script address for Microblaze
       arm64: zynqmp: fix tcm initialization for mini u-boot
       .mailmap: update e-mail address for Padmarao Begari

Paul Alvin (1):
       xilinx: Add cap-mmc-hw-reset and no-sd, no-sdio property to eMMC

Venkatesh Yadav Abbarapu (1):
       spi: zynq_qspi: Add missing prototype for update_stripe

  .mailmap                                              |   1 +
  arch/arm/dts/Makefile                                 |   2 +
  arch/arm/dts/versal-mini-emmc0.dts                    |   3 +
  arch/arm/dts/versal-mini-emmc1.dts                    |   3 +
  arch/arm/dts/versal-net-mini-emmc.dts                 |   3 +
  arch/arm/dts/versal-net-mini.dts                      |   1 -
  arch/arm/dts/zynq-dlc20-rev1.0.dts                    |   3 +
  arch/arm/dts/zynq-minized.dts                         |   3 +
  arch/arm/dts/zynqmp-dlc21-revA.dts                    |   3 +
  arch/arm/dts/zynqmp-g-a2197-00-revA.dts               |   3 +
  arch/arm/dts/zynqmp-m-a2197-01-revA.dts               |   3 +
  arch/arm/dts/zynqmp-m-a2197-02-revA.dts               |   3 +
  arch/arm/dts/zynqmp-m-a2197-03-revA.dts               |   3 +
  arch/arm/dts/zynqmp-mini-emmc0.dts                    |   3 +
  arch/arm/dts/zynqmp-mini-emmc1.dts                    |   3 +
  arch/arm/dts/zynqmp-p-a2197-00-revA.dts               |  47 +--
  arch/arm/dts/zynqmp-sc-revB.dts                       |   3 +
  arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso        | 400 ++++++++++++++++++++
  arch/arm/dts/zynqmp-sm-k26-revA.dts                   |   3 +
  arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts |   3 +
  arch/arm/dts/zynqmp-vpk120-revA.dts                   |   3 +
  arch/arm/dts/zynqmp-zcu100-revC.dts                   |   3 +
  arch/arm/mach-zynqmp/cpu.c                            |  23 +-
  arch/arm/mach-zynqmp/include/mach/sys_proto.h         |   3 +-
  arch/arm/mach-zynqmp/mp.c                             |  24 ++
  arch/arm/mach-zynqmp/zynqmp.c                         |  16 +-
  board/xilinx/microblaze-generic/microblaze-generic.c  |   2 +-
  board/xilinx/zynqmp/zynqmp_kria.env                   |   3 +-
  configs/amd_versal2_mini_defconfig                    |   3 +
  configs/amd_versal2_mini_ospi_defconfig               |   3 +
  configs/amd_versal2_mini_qspi_defconfig               |   4 +-
  drivers/spi/zynq_qspi.c                               |   2 +-
  include/configs/xilinx_versal.h                       |  11 +-
  33 files changed, 551 insertions(+), 45 deletions(-)
  create mode 100644 arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
