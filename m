Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3873F8DFC5
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6C3840AB;
	Thu, 16 Apr 2026 23:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wzChdkIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70670840AB; Thu, 16 Apr 2026 23:12:28 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2B683FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMJ+A4ZJwhaL19SmfG/mDMV7ASjptAJvxudFsbtc8uqRoMjqXugPqeDVPuCVIY1FOcMG8VSnjO1fUCGZRom6wnWWRNZdJGf7ONNNbg5hoHD2KYo/CYaqDvYjOnQjkhrwe7Et0cxEjW1uF9RBQk1ph5x3yjuWmG/NKioQ+2Dfr2aIusOXASGQN+un+TMDpksTw1LhW4yhGpCv8v+Et37DeOzg1UvRvg86a8URATjL0cUKGWEs2/KCbuot5Hk04Z8UtWvq30vFYnTZEO9/E1lVN4wHC99lNsqZo9GselSfsWHeQX9OGQjWxRJIYUhuGM4aB3kt7OV5N6cE35d4OR97oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nebaiDi8b0ajLYVEqJKPP5obxtMX2cLJttOCVD99e+g=;
 b=VGVn2bjMV4knqIs6iXeLtauevKGN2zetr6rMtAYRhDhMUZFQpHDwHdJwLHkoAuv99SY68evZ8Zxp53n24dcXHoqShvlMQIsgQUzokRPTnB1DOoAl0uFcMdxFQ8pmJqPnvIRHRBzwzsF80MtgTAWT3AJeji/aFCdHn6PoLy8th8t0dYgut/ZnWeJjLOiUVW9vQarK5yTDQ9VEiMYCjdsP7KgiRfj6Y0A4G0Q/DO6DxtEcQmV0z8ozZavjEeQMR1mkZnbmq6KyBmlwT3UwMC04Br2MmfWy+YnzXK9rgaCsH6yl4/Phz+JmGoXaL6IWjUPFRnTYNOUFuScBr4fJdx9gcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nebaiDi8b0ajLYVEqJKPP5obxtMX2cLJttOCVD99e+g=;
 b=wzChdkILgDmbwp1+rlFjE5NxbJhTQ9vKzg8qsJx+IqzpxIuE17/hACOJHa8hEGXIs+G6c/klhHq1BZZRIdKwoTyxEVeKJtawdjrnzuAcHoB4wg1lMGP3c3aoSHTqJKbwAcKFW0BXzNs/Q6hPaamINSic1yW/oOTgIRYyFe/TxLo=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 SJ0PR10MB4653.namprd10.prod.outlook.com (2603:10b6:a03:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 21:12:23 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::40) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 21:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 21:12:21 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:12:21 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:12:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:12:21 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63GLCLRs711294;
 Thu, 16 Apr 2026 16:12:21 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Apr 2026 16:12:21 -0500
Message-ID: <DHUW0ASRTCZR.8TB6FRJ580PY@ti.com>
To: Simon Glass <sjg@chromium.org>, <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAFLszTiUDtH14YTn8tPifA4cjOV=2h5MEkOGiGm6x6sQuJ-AZA@mail.gmail.com>
In-Reply-To: <CAFLszTiUDtH14YTn8tPifA4cjOV=2h5MEkOGiGm6x6sQuJ-AZA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SJ0PR10MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a69552-819a-4426-a490-08de9bfcd9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Eyz0J6cQv3KqeMM7ZZyKmPuhMJgbAo9p6eKZTY+dT7wgmIs/0bBt6H2LYKXvbEQq0S66exrk5cWkoBwE8E5qZnbG28SpIKH5ZTNQ2nt4UNpIbb3RciUPprxWXkbh7or5KR3e1oG9wOF7xgKZ4hdcCSXoHQxDPJb0xxByASbDlYw/gAIAgK0z8gotQu7/UHmqK6oXMcukGMOC1X42MeKTyCjzDpkKcD+R2zZblan7BO/Z4yT7lDM1qwtJLsL1FjemHlPNXdb+TzcHMAfKptkbffmhLwaWknrBDrP1CN/h6YyB+9V+JGojFn946XwDKcxK0YJerg9q/6CPkCXIpp4Y4O60ZG1UDiSpdSwivRCU4NOHNY/pUaDixIFKIWUizYJVTpq5Ap0Y0h0bPhcK3IFHowli+3nkVgkROGSCQTm6vLRPHQzD5beyX6M2odkK2A0Rk9v68fysFDsk5KlxP0ddI3xWHuQmvADdqHkcL5+MMZ2aRFAmxE/XXTNlBKjgshoIdMpPFNvjBHsDY4RsN37bd3nMxE4PwuoWzd5G7tq5XILjQkos/KztYa0w1VmNuOu/FagheAU/8jmQ8IeNkeBHtc/AlkWgFAaXRS3cZK9st3DCgaKQSkB79CiaATWEHCk4nTp8P6gNsId9qvV5fctewJ+MAlm+6Cd982sCOQjUrBZdqetpAEKHI3FHGaOr/Diow+amDKjK0fJPHfNhKPUg3py5OcIV5KvZ0o5gSaqAijthTIqcdlbF00Sse+zQHYQJBS/009QlXrsWutodxglHHg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aM3yI/6I3FbQPVjcrZBJvXPINdtDJXh/pDUm9ksfVsk2vJaVGT24iekr9BauFEl23FW9ozZZmZJI1zOPd/cGT2VeHV37E5sz0FRL6T0Ysat1apzvSiO7Qy/KWDrtZ1nW4ybM0mTln9LkDl1WW1McFLNZ57B0PMLDKhQGt3oju2s8WQIuIFNJ+edCESod9t66OMgy9SOWeKv1UF7bRwtwfiEl5z6/qK9B+/nLtceEVr5XaOV+m3drfrY7RDwGlxMSB+czyKnz/q6VM5eeyj8oN9CsUIgLP51d3rEiV+3Fc7mfuLfCB1Almp5CFmRiTCxgbnpqlfIQ/e+W66amfa9d/WI16sA3F1+kUwHNVazE5Urpna2zyh8BcJnW7QP/YWB4VByemKBmdPuA/qSBeYbdSreRta92TCTBJgPPpKeznhITTpFCpqx/o8Qgbc3DvJKl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 21:12:21.9214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a69552-819a-4426-a490-08de9bfcd9be
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4653
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

On Thu Apr 16, 2026 at 4:02 PM CDT, Simon Glass wrote:
> Hi Randolph,
>
> On Tue, 14 Apr 2026 at 08:36, <rs@ti.com> wrote:
>>
>> From: Randolph Sapp <rs@ti.com>
>>
>> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
>> parsing a new device tree and properly warn people when a reservation
>> overlaps with an existing allocation.
>>
>> If we don't at least warn the user of these reservation failures,
>> there's a chance that this region could be freed and reallocated for
>> something important later.
>>
>> This useful warning mechanism was broken in:
>> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_rese=
rve_region()")
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>>  boot/image-fdt.c |  5 ++++-
>>  include/lmb.h    | 14 ++++++++++++++
>>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>>  3 files changed, 47 insertions(+), 5 deletions(-)
>>
>
> With bootstd we maintain a list of images attached to each bootflow,
> including the address when loaded. Could that provide a solution here?
>
> Regards,
> Simon

Hey Simon, you may have to elaborate on that a little more. Are you suggest=
ing
we treat FDT reserved regions as dummy bootstd binary entries? That might w=
ork
if it counts as an LMB reservation and we can dynamically update it if the =
FDT
is reloaded/changed. I haven't looked into that too much yet.
