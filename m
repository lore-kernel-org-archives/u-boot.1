Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81910F588F7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8469384297;
	Mon, 20 Apr 2026 18:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dNe0KUvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D6B842A4; Mon, 20 Apr 2026 18:31:59 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA6584258
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNZ3W7DSNgjqx0va7oZ7Oi5o/nLb3JE1iWSMYSaq6SdOQxaWYP5AmkA+vCa+nJVYMNYVfyTxeAXoMyxNTcZrtoct1L0ocEjNQLb/SzRoclb81THG1o67Ovp61AYVyX8z1nea2RofKho4xhY1aLXhrbzKmOftCM89t/IA3H5XmoBwc70b7L1ChNz8+s9oHIPeZC7a+eo2iRXqvK6Q98q+vx+DOTOOVSvswZgpBO5o7Fz43BmZdqP6Mvm+ZIbE9tivy6v1WrxeiUukFEy7C94To+Pb68vkQxdT89f47be1yE+gXo9QSOA1SN6Ick2Mr/pwP4lWa4pxkY9PRzG9noKq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D33iInUjXrRdg+PDHYVvVtaZSyT0PKIKSKxPjC/SYf8=;
 b=Te12uYbiiIRyKlH1uid9/h1ujUxabakKFFG1K1TQozU6OC2jTkl8muq3g8ZR4HE6gUzzJx27KWGjeT3mIR72FlSin5ePuIqKmwoW8yw1ZP5hSOdM9RF5oxC8IyXtQ71BAdk7xtUAPjJxAGQbR209WZrolNBhIPyc0CI/+xstOZVp6FVJ9+2TBJxYC92ATS5koE+k1bj6PMS4w7lJiR1p2AdFJ7yitS7AbfYFbFQY3ahfVULvmwtRvpdTzjUdJTP+rnnZ2AMMEH3xtpL8PZy+LZTq6YVMUVUe1nMdAVBG3zXTEBrIHLl/pODMxq0S4gyj0TvZAi/Q1DGcmzTCYVhGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D33iInUjXrRdg+PDHYVvVtaZSyT0PKIKSKxPjC/SYf8=;
 b=dNe0KUvUetrJR1SpfgOjEtePJ4jjdQyJlrEf6uZT1Sq/cvfYwObgoNtmJ1/78d44yco3KvVoNmIqeguCYYsn6eaPAKK2hPIDgiREqykdWLwU4PIN7lnPCBQJRWOytFyWwR2/jcDIonshdALaRPwsAUawm8ljOhY3VxjaznVtK6I=
Received: from PH5P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::13)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Mon, 20 Apr
 2026 16:31:53 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::d) by PH5P220CA0010.outlook.office365.com
 (2603:10b6:510:34a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 16:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 16:31:51 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 11:31:48 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 11:31:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 11:31:47 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KGVlk52964155;
 Mon, 20 Apr 2026 11:31:47 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Apr 2026 11:31:47 -0500
Message-ID: <DHY4JO0JPJZK.AT7IQD6A36IE@ti.com>
From: Randolph Sapp <rs@ti.com>
To: Simon Glass <sjg@chromium.org>, <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 6/6] memory: reserve from start_addr_sp to end_addr_sp
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-7-rs@ti.com>
 <CAFLszTh0-1qCbN63_6Yr-jnmWQWYEa3epaLp95JhTJdMdVcPSg@mail.gmail.com>
In-Reply-To: <CAFLszTh0-1qCbN63_6Yr-jnmWQWYEa3epaLp95JhTJdMdVcPSg@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH0PR10MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: f2056f92-c4e0-410e-d5c6-08de9efa53eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0P00kkh5POro7hUmWYpk4X5st+Ws0+Ym6/vV57avHm2+yGmXsdeClTyIBe8bhfLSmCywHV1cRC7YeHzLqQtfHJmZZirBx57QECGsHK4yziV0YCZnukimOmBNbH2bAcCOz5G35Rws0Sjc7LrNZeEAGi4mpbQNL1RVZTYTr5XaMTAgdFxwRuzqMIkYkvCWVfD8RgJvxjv0cAA1FFXyH57+2ftyzX/ojb1Z+Y9BzKeajjca4efNTVHwG3lBotCBsWj0R1NxclPLylynJVK2WAMyB4MtfchcQLqaPj7PO8KTstYv0fDt0DCM25vx2uDE9MtkHO0LDpvp91WPlWAp9iEvHLW0EEd/VVNf8BNgEnPKcyGMPZjLHxMEe3QCP3pcm91qMWxePXvdBlSyQlUQlLnT9NLdkYofa3uR6JaUYJpvWqCN7RvsV2lDM0lEh2DLZ7JUCu6DSO3pztrdKY12Gl+c3glDtY9oxPKB02+Bs/PSO7QqVvElX+C57UVvxeSbZEUgn2tCorzDI751tS7kgSNzBKNUcQ2CMvMexThJg7AVMoiz/qhkWh3gn1g1sk+a/ov+ugZpD7gUuK1xkemusJyFtgD1p24QcDvSsEW1Mefx9AtRh2j+LQuMdOyc4ExC2onfdEbHkDd0e51gzER4p3UCHpt66TuNL1fBqnUh6wC9mrtsDW7SbzttQHyRpde8M5421frkggs6FNvTW+TQ6tP7s3pQuKKSeamF0wV3jh462JsWpRtYft04X3NCc0hCzGEKXhVaUZS9okTNYcL1t9yrlQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d94bmZYozH6GjHZSzyxm3t68ebtGZrL4LYNiweZc0ScGqCngsVLgYeCP2Cpo37CRThgABccFT9nLwV5nWdVHt7eWTKNv69TOYSTRzNFvxD9LNfc+qxG9T5j2c2vCJNJKOto4oqJjSwAoi1lDsEEO5Z9EPDmJYcXYMk2XCmow3Uh9zaCPZrcgzfkyX2YrUhFFV1Wtk7O9I6mu2sBQB1OEZ8MsE7JId3Cfam/sCZRtMdSKm469Z4xuAnvi6OM2/rn4TPsuMZPrVg737j6uldQml93iEDR86cUDQH0spgC4WagCbYr+M2AhY85NJhA7AKVFAzdCPjNpyDQ8pbS7BMv+uOk0jnUxIA88tnXI6NL5KOLHGZtVAJyQDTeyuzXc0dPDnZJl8sRZ8JF8OvrLC34dBg4l1XmwOF91sVbyPlo++rQEE8oX4KCv5Qa/SnLfFYcg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 16:31:51.9327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2056f92-c4e0-410e-d5c6-08de9efa53eb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
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

On Sat Apr 18, 2026 at 10:52 PM CDT, Simon Glass wrote:
> Hi Randolph,
>
> On 2026-04-13T20:35:52, Randolph Sapp <rs@ti.com> wrote:
>> memory: reserve from start_addr_sp to end_addr_sp
>>
>> Add a new global data struct member called end_addr_sp. This stores the
>> original value of relocaddr, directly from setup_dest_addr. This is
>> specifically to avoid any adjustments made by other init functions.
>>
>> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
>> gd->end_addr_sp instead of gd->ram_top. This allows platform specific
>> relocation addresses to work without unnecessarily painting over a large
>> range.
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>>
>> common/board_f.c                  |  9 ++++++++-
>>  include/asm-generic/global_data.h |  6 ++++++
>>  lib/efi_loader/efi_memory.c       |  4 ++--
>>  lib/lmb.c                         | 41 +++++++-------------------------=
-------
>>  4 files changed, 23 insertions(+), 37 deletions(-)
>
>> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/glo=
bal_data.h
>> @@ -115,6 +115,12 @@ struct global_data {
>> +     /**
>> +      * @end_addr_sp: the end of memory currently in use by uboot,
>> +      *               should be the original value of the relocaddr bef=
ore
>> +      *               any other allocations shift it
>> +      */
>> +     unsigned long end_addr_sp;
>
> The naming is confusing, although I realise where it comes from. This
> is actually the top of the U-Boot reserved region - how above
> reserve_top or initial_relocaddr ?

Fair enough. I believe initial_relocaddr is more accurate to it's behavior,
though reserve_top would be more accurate to it's intended use. I'll run wi=
th
initial_relocaddr as that kind of hints that it shouldn't be manipulated
externally.

>> diff --git a/lib/lmb.c b/lib/lmb.c
>> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_siz=
e_t size, u32 flags)
>> +     if (gd->flags & GD_FLG_SKIP_RELOC)
>> +             lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len,
>> +                         LMB_NOOVERWRITE);
>> +     else
>> +             lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
>
> This changes behaviour for GD_FLG_SKIP_RELOC, doesn't it? At present
> both the stack region and the monitor region are reserved, but with
> this only the monitor region is reserved. Is this intentional?
>
> Regards,
> Simon

Ah, good catch. Forgot about that unconditional reservation in the old path=
.
