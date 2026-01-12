Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D0CD2502F
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 05:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352F1839AC;
	Mon, 12 Jan 2026 06:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VlOLzsqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF2183A9A; Mon, 12 Jan 2026 06:57:21 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azhn15010054.outbound.protection.outlook.com [52.102.136.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E723839A8
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 06:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHoeAPt7p4xEVqJK6X5HcpobD9/VRxkSTtl7nJsXLmwj5TkeWUn67vLBdfp224RShg5NU0ptEgRML7+zqeRKFnTdR6m85JbURmQmq5gdi178w1DehOXjGbVUqamet23WaDfBLPQuXsZRo0bj9UrtWE8jg+gg61h3RlIFG9ViWqCFBcWZU8IxoX2Lc2rAb/JfCLCRToiPjcbtEVgTuMjng8rw68WVKhNzm/qfIdtF+Vm1hoatnHphwg7WezGOm2VfAzKVZtDFV2k0NSaMI/cZae/PUEdtdxtsxAmrJ6MiaONYHCqnZom+P63Gpwcw/1ajnOtwIAUyP2ugMt9AieWChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA3hJc4ucKDmus1mRJZCa9iaKWhUBvGvNSmCGQRd7vw=;
 b=HryyGSWdvcXDHHC0qpfYs9xkstpqf7HCUaDtw+Z1NI8rtbI/qSUxibQlspaUjlMk+hkmjdqsGUh6eDRduS4USFUt7sQ7SXAx7XfHH0o3H+grs+m3NQ66Fj6bEGvrvrTaw74uPIyh4iMnLs8EEoifhBDdZ8VT3xnNKNUqmov1LWgK1qy+DB6NqBSt/H9OPONlssAdWcPCL1WlB/9i1Flq0T74KyBzv+mNmUX59JrzcGYjxVWGbXTeNsWKegU5dnEEHecdaEAKp6tKLJ/CgEsELpI4ZlTJ+Xi39h4CVv6iBCXj7hN32QFF5ZKp0PXYxhW4KLrWDERVxue5PebHVRSeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA3hJc4ucKDmus1mRJZCa9iaKWhUBvGvNSmCGQRd7vw=;
 b=VlOLzsqL77ayWPgj4uxpANe6J7+XFpfk63dOW5OjwFQYZbIyfvhgwmsOg04y3m6L1iZXQIO9C3nr1T30isi250ASVuSWW4usIeqXyQxhm5pA9SqwrS+QZIfi6YcImW84OMukP/VRDeXzc0Rz7GsLYV2ndXy3Ws50yFFVemM4U6s=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by DM3PR10MB7925.namprd10.prod.outlook.com (2603:10b6:0:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 05:57:15 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::4d) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 05:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 05:57:14 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 23:56:45 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 23:56:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 11 Jan 2026 23:56:45 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C5uiXZ4165162;
 Sun, 11 Jan 2026 23:56:44 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Jan 2026 11:26:43 +0530
Message-ID: <DFMDO1DJJU1J.76LMCBNAY7I8@ti.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
From: Anshul Dalal <anshuld@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260109190026.58464-1-b-padhi@ti.com>
 <20260109190026.58464-2-b-padhi@ti.com>
In-Reply-To: <20260109190026.58464-2-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DM3PR10MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: e49b89ae-be34-4599-d282-08de519f6fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGxCeEd0ZE9jMyt4YmlOYlpvNzR1ZjBWSWRDMGU4OElCSHhwRDN2MHJzZGFr?=
 =?utf-8?B?cjlsNXpZeURiWFJIMG5XZTdaUWY5UlpOOVpSY2ZwS3hTSVNybFZxd0Z0QUp5?=
 =?utf-8?B?ZkRhVGozOFl6VU5nTldNdmlKcXcvWUFGMWFHbGVLVFMxanloM2xoaEIremJU?=
 =?utf-8?B?c1VGNUtVRGFRRmY3M3ZYeE1JZWJGRmMwNE1Tc0JkRExpZ3VWNVhNaVUrb1JP?=
 =?utf-8?B?Vmx2ZWptT1pDUmF5M2FYR2hjR2p0QWlQcWYrRWYxZ0N3QU1LckFpc0VJdjc4?=
 =?utf-8?B?Q2hzOGt2aFRvMVJWendTcjRSOGZjRGVrMVdzdVUwdi85c0htSjFCcXc1RGRC?=
 =?utf-8?B?aHFac1NqbHBUTGNIcjkrMEFDRnZBUGlDOEo0aE5FY3p1K1UyNFlhMGV5ZUZq?=
 =?utf-8?B?aXlqanlZSFJBVVpZbGR1WS85VWJMUEZTUjhiemVrK2tTdzFxNStMS2VMaldC?=
 =?utf-8?B?TkhLeE1FWVUxMzN5WDExWjM2UXNQT2dvcHNxdzFrU3RoOWpQU3RBcUoxVE0v?=
 =?utf-8?B?ZjBKaVdodGJXV3lqaHh2aElsZE1La3c5d0E0WjZoUlpqSEVzeEQ0bEdoNk5z?=
 =?utf-8?B?NGd1UG95UzJ1TnM2Nmt2OUdXOXZTdG43VUQ3RnhHWS9RZzl2VmFrK0hxWlpo?=
 =?utf-8?B?NlIycXd4YzhjNDRXZFMwcHVIUlFpYkZiYkpoUzZnaEJFUWlhVU0wMUMwV0oy?=
 =?utf-8?B?MmpQS0Y5c09sYXRJdUl0b0JsNnIxdjN3MG01MXZqdlBFRXQzem4rUEd4NGNw?=
 =?utf-8?B?SWNpVVRzV3dIQnp5U2RNUG9qbFFDNVp5ZTZzSnhBYjNlMDd0YWJQSy92bUJG?=
 =?utf-8?B?Tk1QM0lGWUdpN2sraFhuRHZSZHJ4MUZUU0ZBbFI4UTh6YTEzOUtwd1pqZHNl?=
 =?utf-8?B?RVBEQnVWcWdqZ2lTeVoyamNDNWUyVm1uK2ZmcHg1S1dnSk0yaXdZV2V4ZjJy?=
 =?utf-8?B?ZDJrQzZvMVd5bnAyUDVvMnA0V3pkZTN0bkVBUThBaUVTb25yVmZDK2ZOeWJ3?=
 =?utf-8?B?bEFsbFVrUmMvQjQwYjlZakcxL2ZGRmdYOG1mSXFNa21ZSkdQSk9NcDVtcVR3?=
 =?utf-8?B?RDZxdDZiK3FaRW9rL3NjOG12L20yemdHMEg1WjVjcGtzeFZDQ2dtdmNMYTNa?=
 =?utf-8?B?WmV5Y0xibGd1Tko1TWdDeFhLUWxQcFE3eDdaS2NMeC9YRERSUXlRczN2Ykhl?=
 =?utf-8?B?bXh1bUhsVXNIVk82bTZST1NaNTlRSWFocXMzZXFzRGVuV21HMG45Skl2Y3B1?=
 =?utf-8?B?SXVzOG1acVR2MSs5eisxc2xJTmpHenE0TldVZzB5NU9TYzQrUmdOZE5pMmtw?=
 =?utf-8?B?NlY1NjhYSkR6THg2amU0K2VhZ0xLcUJEc3NMVWE2ejhTSDZ6TGhiTGR6eGJq?=
 =?utf-8?B?VitHdFZWb05MTXZHUjBCRUlFY2hVZGxnQXV4MWdmTWJocm1yaDBLZHprejFz?=
 =?utf-8?B?WlcwTW5TWGxxOHlGL2puTFQ5S1BvTjRIUnJRTjF1dEhHbnY2Z2NIcGc0UXVj?=
 =?utf-8?B?WE9IYmdKTFBIT0pGK2xCSVpEWUVjQ1RZQkJ2dTdnM0ZZTFhPcjRUby95MkJL?=
 =?utf-8?B?R2lpMTBiZmlPcGp0bE1tWEhUUUF4UzJwaExIcFVUeVMwemt1bmVDUGEyb1Jt?=
 =?utf-8?B?N2xMZGdJVmpMMXRucUFBUkF2SjZwQ3MzbjFsUjlaTG1GcEw5eHRFM092bUY4?=
 =?utf-8?B?VmxDQ0k5QlVPSUgwWjV5VGsrdTFVaVI5dHg2Qng2dkJ0Uk1QeFRESmhFdFJi?=
 =?utf-8?B?Q1dickQxNG00aXNFNWwwT1diYkxqSGVWQ2hGRFhDV3NlM2RRVWx1MUI4TmxE?=
 =?utf-8?B?aFZQMnd6c2JyUFhiOTNqM0RWNUgzTW93dmlER05zVXo1M1ovVFFGUzVRZy9Y?=
 =?utf-8?B?VnphNnBJSHdSTVgwWVNVc1lIQUNXMDBJeHpMK3NLVG9iWEtiS3NPS0xDZ0pv?=
 =?utf-8?B?VWh6a0dRczFEV3dCS3VsNGFmYlZEaVJ5dTlmcUNqMDJlS21SdERISTBzUjFh?=
 =?utf-8?B?dDI0a2YvNlNuWmQ3SXRGb3R0WjNtZWQ4cE82dG1iQ2NtMGVoYTJ6WEdQaFdo?=
 =?utf-8?B?WXpxVUY1SzllRFJYdlhuYW1aaG0vMHdaRExHTTg1MUhZVkwrNVJJcG90a2F3?=
 =?utf-8?Q?snIk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 05:57:14.6425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49b89ae-be34-4599-d282-08de519f6fa2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7925
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

On Sat Jan 10, 2026 at 12:30 AM IST, Beleswar Padhi wrote:
> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
> packed inside the multidtb.fit FIT image. While the individual DTBs
> and the FIT image start address are 8-byte aligned, the DTBs embedded
> within the FIT image are not guaranteed to maintain 8-byte alignment.
>
> This misalignment causes -FDT_ERR_ALIGNMENT failure in
> setup_multi_dtb_fit() when locating the next available DTB within the
> FIT blob and setting gd->fdt_blob, because of the recent libfdt
> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
> version v1.7.2-35-g52f07dcca47c")

Is a fixes tag justified in this case? Technically the commit
0535e46d55d7 did cause the regression[1].

[1]: https://lore.kernel.org/u-boot/DFJ9947VLHEL.PCDIJCRU24BS@ti.com/

>
> Add the -B 0x8 flag to mkimage to enforce 8-byte alignment for all DTB
> entries within the multidtb FIT image.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  scripts/Makefile.xpl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index 5e65d7b2498..1183f5180ba 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -602,7 +602,7 @@ $(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_di=
r)/%, $$@) $(dir $(SHRUNK_A
>  targets +=3D $(SPL_OF_LIST_TARGETS)
> =20
>  MKIMAGEFLAGS_$(SPL_BIN).multidtb.fit =3D -f auto -A $(ARCH) -T firmware =
-C none -O u-boot \
> -	-n "Multi DTB fit image for $(SPL_BIN)" -E \
> +	-n "Multi DTB fit image for $(SPL_BIN)" -B 0x8 -E \

The patch looks alright to me though I wonder if as a next step we
should put the logic to ensure device-tree alignment directly into
mkimage since it already knows which blob is the device-tree (the one
passed with -b option)?

Reviewed-by: Anshul Dalal <anshuld@ti.com>

>  	$(patsubst %,-b %,$(SHRUNK_ARCH_DTB))
> =20
>  $(obj)/$(SPL_BIN).multidtb.fit: /dev/null $(SHRUNK_ARCH_DTB) FORCE

