Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81ADCD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 20:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 074E883FB0;
	Wed, 13 May 2026 22:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QwKmvuPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB597844BF; Wed, 13 May 2026 22:23:05 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5108583E36
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 22:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdhUVSGUluQXhUezuyE0ZWnJw8XI/K1viJf7Fq8VX8+d3gUuM+lLVk1Ncat/K8cLz7Hmg4TqfG7wRwxKY00SK11CrdC3Pjt4FcZYUDHhE7094pfCqODHKB0XRPqAtl08RQWqXMlqyliGum1pyNsOsrdEQEQ37paaL99WfNNOUyx0az8YtWmdBF9oGZdlaWtF3bVoCs16sRRZXLZbihneP4zAHRr/Yf1auXLetmpVifS63U+O8/92ArEfbr6A8IHtdx8fZ+yjSZSIUtv7CqtYeiFGQWv9UmP5eTmvGa9nhvFPX1bZPIGXYR6eGcFle1BS/pV/gXnBpAeWhg7k49clEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Duk9rGhPFpL0Zp0G+bOBwbe2BsQ8tT/GJMnZS2auQnE=;
 b=reQorlwbe3ENAvg54MEzTHn7XDKXHPXK7KD1pgJd4EsH6T9zr82BoccIiJhf83VdGpy4glHT1vWinXzL1clHQAqY4R8dPoUpnYDgDqyj6IQ/2OEm65ZxOBF09gvjZhb72zVI5uhrPnuDim42L0H12GrNN4C3XU+Owryvj5B6Gswp8eSVy5ynBoPddLS41z+WW/ORTrBUQlMxmQbdKQs/k1VTomQTu3v4IAyvm+CnwxfbLVHG6ocFdOUdBXWfZtsHaZlO1k3PgGRrJiuNvLEZ3mLcoXgvNeqxIMb+RDwMlFJzvsrUr3bUgl6J001Bn98wFjBQ01ymO8Nf5SXBjgjfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Duk9rGhPFpL0Zp0G+bOBwbe2BsQ8tT/GJMnZS2auQnE=;
 b=QwKmvuPs4bJZxhlUiyr1+k3+gZ3PeMidY5L4CD+a4cOolyq0CoXW7hhVDS4g36T53ybc75h6jzWCzGWWTmH0w2ZwEAKxx+wtI0psXRnmxTj5u7KJ+9bSPHG4/yA6LV6lbfshuZS6zZlMWyDMVrh/2gux+w/Jv0dx/wlSSWrzYKg=
Received: from BN0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:141::25)
 by MW4PR10MB6438.namprd10.prod.outlook.com (2603:10b6:303:218::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 20:22:52 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::b1) by BN0PR07CA0018.outlook.office365.com
 (2603:10b6:408:141::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 20:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Wed, 13 May 2026 20:22:50 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:22:48 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:22:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 15:22:47 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DKMlDm230515;
 Wed, 13 May 2026 15:22:47 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 May 2026 15:22:47 -0500
Message-ID: <DIHTV2COJM6C.38XX35SDOM6Y@ti.com>
Subject: Re: [PATCHv7 2/3] test: boot: add a fdt reserved region check
From: Randolph Sapp <rs@ti.com>
To: Simon Glass <sjg@chromium.org>, <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260513015606.591384-1-rs@ti.com>
 <20260513015606.591384-3-rs@ti.com>
 <CAFLszTg+rP=UirpTzUZcg+qo0M2gY7T=BRxPfH=PV+aDSvnjHQ@mail.gmail.com>
In-Reply-To: <CAFLszTg+rP=UirpTzUZcg+qo0M2gY7T=BRxPfH=PV+aDSvnjHQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MW4PR10MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c06d3be-564b-4c15-be45-08deb12d67e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P37ybMa/NaGfAxAZgcPZnKHCkwh48YrYcbR2c45a1eh1VXGRgfDOxO+FpcFJ+0fCrveNo6YzsYuiViNNdkWoVW/vbxvZ6gqB6Rqa5/9Du9EvQN1zS+KhaI9F0Drk4P2AgPMeZNgUmbY9d2uvA/MMQrKFjqVATN7SpRf720KPrRrlvOqz76rGta1CQ6elKAx7OiQOkTiOqZw+InptiGtzU7DCSFO2EYOPSmjblJO7hNiI2deExsSVKxyc6/XMC6Ns2ZhMbWbwTBrGlrAT2Jq/S80rhrUF285dPzKxxpuYrolZSDumxMV13lFTIsea4u9CdLLOlwgntKsXgKTFYSQ0YKxSIydyNAMoVGlgtMKmqpKUWX1CWpqhCrAK4FJzC8ua0KWidZeefMtIm2gWNz/NkWtSiqNjj2aipv0unP4Rg1gnZpttuUqf/1GsQfxX4Z0aA2d0d3IHGJHwjnUNAp/bT0smP/ysa1wMyK4sXwM2mDcam4xfDvNXbJBNVmPZGZGhnwE7i5xNOZOHw9Hx/hgjT/0h2nADs7VEAin9EUAyzRrcXpqmFG8bVWT4JVS2/Q0jgutgh1mzUGe1IkxDrGkLCUVmfhyP6yIN1AHy+rT4UYzlOuhhw979EIcVATC/dn55m6DQ7cbOe2ZAtdIIqe2veUX0wQIPnMNFLuAf/lWiKVw/+xUpgYHnAp9EzYy9YHrifBTMkqZZrR3HvZCoL86AKrMTVzKHblrmkv9e0pN9ra8=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(4143699003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fHtSWi8nsH8yKHMQnR0KQLiDCWW5zXeJxJHC+b+h/qA0IgxMEtGWqJTnv5oGyXi0/N2idwdkuuYgpcrxLRk9BCoFHDpnmW7YpKJ6nvZS29MPL48QMeVtTTZe2DvlnS6LMXzmvGZrR3IuBsYclwAB+QG/LjyOKgeUxX2K+kMqw8YNfg+bERJV3bEcxwjo1ITEWPCx5sB06O3CDhTODtvpFlWuiRLPtVyYlupf6Aa4cY7jLbjzROYNYexiNMuUw/8Zw4xRNFlMHjD876Vymkp420jH3HdtPgw5EpmtOG7yyuh8gusWfCzcHkc8VHCWaJbu6OVvG1KxWO2hPrZXaP0P2uVKXKodwAvVSiq/fDYnxf9yba7jq+ZBPPmhO2rsoh3C6NWAVfib+Bi3Avm7qbwP1D5Vrvi6Dxlip1JYsZSaSIhD9iCr7jML/cqLJU1nm0qa
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 20:22:50.6674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c06d3be-564b-4c15-be45-08deb12d67e4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6438
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

On Wed May 13, 2026 at 11:34 AM CDT, Simon Glass wrote:
> Hi Randolph,
>
> On 2026-05-13T01:56:06, Randolph Sapp <rs@ti.com> wrote:
>> test: boot: add a fdt reserved region check
>>
>> Add a image_fdt suite and a check for boot_fdt_add_mem_rsv_regions. This
>> will ensure the user is properly informed of any reservation failures.
>> It will also validate that reservations are cleaned up correctly when
>> switching FDTs.
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>>
>> test/boot/Makefile          |  1 +
>>  test/boot/image_fdt.c       | 53 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  test/cmd_ut.c               |  2 ++
>>  test/py/tests/test_suite.py |  2 +-
>>  4 files changed, 57 insertions(+), 1 deletion(-)
>
> Change log?

No change log for a patch that didn't exist in the series previously.

>> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
>> @@ -0,0 +1,53 @@
>> +#include <fdt_support.h>
>> +#include <asm/global_data.h>
>> +#include <config.h>
>> +#include <image.h>
>> +#include <lmb.h>
>> +#include <malloc.h>
>> +#include <test/test.h>
>> +#include <test/ut.h>
>
> Please sort these: config.h (if needed) first, then the plain
> top-level headers alphabetically (fdt_support.h, image.h, lmb.h,
> malloc.h), then asm/global_data.h, then test/*.
>
>> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
>> @@ -0,0 +1,53 @@
>> +#define FDTDEC_MAX_SIZE (2 * 1024 * 1024)
>> +
>> +#define IMAGE_FDT_TEST(_name, _flags) UNIT_TEST(_name, _flags, image_fd=
t)
>
> FDTDEC_MAX_SIZE is never referenced - looks copied from
> test/dm/fdtdec.c - please drop it.
>
>> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
>> @@ -0,0 +1,53 @@
>> +     /* Loading a new device tree should be allowed */
>> +     blob =3D malloc(fdt_sz);
>> +     ut_assertok_ptr(blob);
>> +     memcpy(blob, gd->fdt_blob, fdt_sz);
>> +
>> +     nodeoffset =3D fdt_path_offset(blob, '/reserved-memory');
>> +     ut_assertok(fdt_del_node(blob, nodeoffset));
>
> If /reserved-memory is missing, fdt_path_offset() returns a negative
> libfdt error and fdt_del_node() then fails with a confusing message.
> Please ut_assert(nodeoffset >=3D 0) first.
>
> Also, blob is malloc()'d but never freed.
>
>> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
>> @@ -0,0 +1,53 @@
>> +     boot_fdt_add_mem_rsv_regions(blob);
>> +     ut_assert_console_end();
>> +     boot_relocate_fdt((char **)&blob, &fdt_sz);
>> +
>> +     /* Reservation should not exist now */
>> +     ut_asserteq(0, lmb_is_reserved_flags(start, LMB_NOMAP));
>
> What is the boot_relocate_fdt() call testing - could you add a
> comment? The reservation at start is already gone after
> boot_fdt_add_mem_rsv_regions(blob), so the final ut_asserteq() does
> not depend on it. It also allocates from LMB for the relocated copy,
> which then leaks. I'd drop it, or split it into a separate test with
> its own assertions. The (char **)&blob cast is a hint that the call
> doesn't belong here.
>
>> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
>> @@ -0,0 +1,53 @@
>> +IMAGE_FDT_TEST(test_boot_fdt_add_mem_rsv_regions, UTF_LIVE_TREE | UTF_C=
ONSOLE);
>
> Just to check: the test only touches gd->fdt_blob (the flat tree), so
> why UTF_LIVE_TREE? If you want it to run regardless of OF_LIVE, drop
> the flag (or use UTF_FLAT_TREE). If the intent was to avoid running
> twice, please mention that in a comment.
>
> Regards,
> Simon

As far as I'm aware, UTF_LIVE_TREE is required for this test. I've tried us=
ing
UTF_FLAT_TREE and no UTF.*TREE options and for some reason this restricts p=
art
of the parsing that's required for boot_fdt_add_mem_rsv_regions. Operations=
 that
should report errors simply do not without UTF_LIVE_TREE.
