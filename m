Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897EBFF8867
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D57B841DF;
	Tue, 28 Apr 2026 05:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ojIpq0OL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B30284178; Tue, 28 Apr 2026 05:10:58 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC72841DF
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKWMOtw9PuEOrG4JOERQjyHG2D2CC+uzmDdR+00QMgz1s1JIN6pgFThuI7sXJP1D/fNfVWsfloFuS6AEHLu/23kGxGvA38Z6fVdZmtt2j2MO5AAiZQ0+MPtNKgxFYDR4c9lCLVI1RZTayDPLlIxLUa/9ka7/sPvk++Dw0VndpGoiRC62mSQJXgfalBv/E/2BMQRwDM6VhyVA4MBPDPwwmrvvkOyu49Llg8PY8JLGC2MlUL/U1K06ZT5cml+BJssiROTwhJdMbKoDcCuclzZTptwC/d3KazzIvU36b5Ef7uCc/j66YQ8mZQpPllHolHeZms9xtIii+88bzqGbpmsUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsgz+ixd+wZAxpZl5E6Qo18bI2DoPMxDQGLK9i2IQs8=;
 b=pQDModSrPAJsmK0/OgqyazcQhSsxaiUBssxWLIRB67o2i2rEZbnfH/eSXPbBklimIIiZFB5iZyf9vuDDqDAaqC+3ERcs2vXM9bFLrfBT28Tac8uCSdz8THg2ufc2Kc9J3pJGExe26qL1kH9SAV0C4b+SfdlDp0zar4dMhjTTEH5/JjXNdn0bTgZ9vpvAo+a/DHDnwlUIV69vEHyFAiVX9DhbZ1RNhcWClXs389zn7t9JJUw1RmpD2ucL/NzBSoVzMWqb6CVWY9S0Qf5vF0GVKDa1CdLAYWRlj6V8BdDItR8IP0lE4OytqibpVDNMlyVM0kxn63VAih7qEuggx01Ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsgz+ixd+wZAxpZl5E6Qo18bI2DoPMxDQGLK9i2IQs8=;
 b=ojIpq0OLu6WLPQE5FzUPRZdD7oWwO632rJ0mksluLocNUNPZrEDqU/h7UDlgiP9Ni5WtmpVMAqNqkBXrVpRGS+Aymn7DVPiaKSY+Rvb0MjcFdpCK2aqeIaLKbnpRkUWPHrq4vwNiutgV66J4SRqgy5kAUUztbwc9G/qJwNUjkIU=
Received: from SJ0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:33b::18)
 by PH7PR10MB6130.namprd10.prod.outlook.com (2603:10b6:510:1f6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 21:34:07 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::5d) by SJ0PR05CA0013.outlook.office365.com
 (2603:10b6:a03:33b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 21:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 21:34:06 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 16:34:06 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 16:34:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Apr 2026 16:34:06 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63RLY6Tv4077730;
 Mon, 27 Apr 2026 16:34:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Apr 2026 16:34:06 -0500
Message-ID: <DI49CY1ANPIG.2ZJXQ5B7QUPFK@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCHv5 0/6] various memory related fixups
From: Randolph Sapp <rs@ti.com>
To: <rs@ti.com>, <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260422170946.3394481-1-rs@ti.com>
In-Reply-To: <20260422170946.3394481-1-rs@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|PH7PR10MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 1921e71c-2341-4da0-4d04-08dea4a4b603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: GcNiHqpyYYGo2MjCqJznxrMpe5MIh/ghF6czIp7tSYttHIyc34FjYT7498jCrYGRBlo86JL9ixax0TFElYiDrDsNTI/+XBDU1OTAZNb5XpVVnmgBMWy88WuBlQwshhApt3umInR/X5+CRc2+QQpdWaW9kisfx7nb5ORGSNSKPHIrI4FrRKytHh7XY81XkCSKK2xZppUd5y3TRfq20Xtw0U5xk0qgu2CJZGauaPyXXhhrzrHDotNSh4fJa9RCaReMGSNS7EdRfPEGNWUaNnJjTusq9LfGARal7g3Dpg9yTb/gJ6QaWEAysp451OVWwNree3FxDlxlf5djzZ49957/VBBT6B9+EIoPHigLU+0JUbwPkrmDzWo4yROEupFnLZqDnxf5VyYXPlv6Vak77o5Tnvl4U1dwb7CH6A/0yDXjtYOw7eKKO7OJZ99TfRx5tLUhusa0GaEESAuL5RUPR6v2FVyX8UhxGncQQgPq4xI5drEUvL/QipLGM/HTiJcJi/Csj2GTViKQEQmxBTG2Um+2fA/rxGZBlw5+ffsSkNYRuw7xfZtzKnJpy5Myya262eowlAH3NWUXK2gVmX3TjfAohHbKZJeJIsIvguKsccGFlLDIiZ/5/d38SHokL4ugICrVJ7Il/FJQXa94Hu40IS4b3gxUohkb54fcEU3y6i1dqjRXrrEOSimZtegHxMkgKWicg5dPKGk4TGdyvK/r7roXutTbPTQQE3xnE+ae9XYHoF/LEWgWt42ScwkaG5Df8fLSyP27uqVolJbp1dzRNDIAfjyo9wePLLENn1qNueasEDsidPRUdcz/bcOZea1s90hersqqcn6O2oL1llwjgoqd7g==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ktS7uMJF1hDMDhHsqIfJ+9EZKb4Cs7XcBnQrKtOs+zLxXTfi6Do8Ni1E6FXHVRSrDD4LujKvm+mvof8yegqymv3puUpG5uByLwDLf87nLWuwZHiu8PxA7z8LpjQbffy1z0vJF7Tk9EazLHTyGXYbwoBMoIVB1o1HLwy6i+42nJQVVplOauvpXuBZ/CB28QUXt5JorubNOtCPY4lMx2AEuyFMEpd0ZHMRRvG2MSkuPtzYCGH1lvcsPDa5COIkTAOhmFy3IDE8DXjh0mIgk5ZUumx2GOxiW5zKYY8lWuSPntPg5tkVqk/VFavLgBtxP27qid5nxd4JAyVrVSX8Xyyap4Es8FZ4YeDWmw33aFfu/QH5MEc59GiBs2iVdCM20QfFqcoOZWfcLCtkR9PrgWaPV/vJ7VHge8L7kT+dS2+qypBcoNYRj4+MCiyLi695WK5r
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:34:06.7129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1921e71c-2341-4da0-4d04-08dea4a4b603
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
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

On Wed Apr 22, 2026 at 12:09 PM CDT, rs wrote:
> From: Randolph Sapp <rs@ti.com>
>
> Nitpicks and fixes from the discovery thread on adding PocketBeagle2 supp=
ort
> [1]. This does a lot of general setup required for the device, but these
> modifications themselves aren't device specific. For those specifically
> interested in PocketBeagle2 support and don't care about these details, m=
y
> development branch is public [2].
>
> That second patch may provoke some opinions, but honestly if that warning=
 was
> still present I wouldn't have spent a week poking holes in both the EFI a=
nd LMB
> allocations systems. Please let me know if there is a specific usecase th=
at it
> breaks though.
>
> [1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
> [2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2
>
> v2:
> 	- Remove additional increment and decrement in lmb_free_fdt_regions
> 	- Drop the patch to backfill EFI_CONVENTIONAL_MEMORY
> 	- Adjust the removal loop nitpick patch description
> 	- Change the reserve memory patch to use new end_addr_sp
> v3:
> 	- Update lmb flags to use the macro documentation for constants
> 	- Change efi_mem_sort to use list_for_each_entry_safe
> v4:
> 	- Fix typos in LMB allocation flags macro documentation
> 	- Rename end_addr_sp to initial_relocaddr
> 	- Keep the map_sysmem dance in the efi u-boot reservation
> 	- Use the active device tree pointed to by gd->fdt_blob to clean up old
> 	  reservations
> v5:
> 	- Keep return value as long in boot_fdt_reserve_region
> 	- Fix formatting in initial_relocaddr patch
>
>
> Randolph Sapp (6):
>   lmb: allocation flags macro documentation
>   boot_fdt_add_mem_rsv_regions: free old dtb reservations
>   efi_dt_fixup: use fdtdec_get_bool
>   efi_selftest_memory: check for duplicates first
>   efi_mem_sort: use list_for_each_entry_safe instead
>   memory: reserve from start_addr_sp to initial_relocaddr
>
>  arch/mips/lib/bootm.c                  |  2 +-
>  boot/bootm.c                           |  2 +-
>  boot/bootm_os.c                        |  2 +-
>  boot/image-board.c                     |  2 +-
>  boot/image-fdt.c                       | 55 ++++++++++++++++++--------
>  common/board_f.c                       |  9 ++++-
>  include/asm-generic/global_data.h      |  7 ++++
>  include/image.h                        |  2 +-
>  include/lmb.h                          | 30 +++++++++++---
>  lib/efi_loader/efi_dt_fixup.c          |  3 +-
>  lib/efi_loader/efi_memory.c            | 49 ++++++++---------------
>  lib/efi_selftest/efi_selftest_memory.c | 21 +++++-----
>  lib/lmb.c                              | 41 ++++---------------
>  13 files changed, 118 insertions(+), 107 deletions(-)

Any more comments on this series?
