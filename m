Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CF6CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 13:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F1A683FEC;
	Fri, 12 Jun 2026 15:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M4+de3o9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A2283FEC; Fri, 12 Jun 2026 15:55:23 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14626839A8;
 Fri, 12 Jun 2026 15:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfVIxCwZ0JyvDZQtpe9pzmcA3sz9QGuJ0Jh4kVqO/1oG1oHTO5qSgmgwDB2yxWr6nosvYm4xAP6GgfVLe3toEvG/d79ms/cTOntimTZdKBgIvip2cTqwV2P+pu4FhBs2T0BB+l+3fkW7cSgi06H2DnljDYPDQSFgySblXVAV/QyRXvo5uNZDsu7N4tj3YTeeNBGBgN364I+WgUi5JQ75lAITOR3mDLPQ27fqp4bvMSu4+o2EHgeqtzvN9nuaUmJOKIBk6tG912AyQKfF8whBi+3DbfMfkbD4HYpMAYS7rUTEsiFVUdJePUMrzy8DrnqBFU7+DYHIIh6Cu6yDWWZc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH/88aPjv1U9R0DJ+ggJo1R399X44EwjcmL0VVl+UqI=;
 b=BBy6n43gTXvTcuV/a7mNjwg0o7QPGdOUKBg7f6TcmtY46+O/2WL88kQQo8dIS/75UNjnZnOsOdUYabty3ESxXc4/jStbEdiVlBuDVp2ETT/qYnaQo6BGFYI3+zohIe+mDcvT9/pgFCPwDnoquUA6yhrJIMH/9bQYTXeDmdpfnmGGrecar9m2LGAvpbET5g8E05sL3Yh4noE8dFhL+Z2NA+r/PpZ+DDsILLlFSS2vtVxXUQEwxBnQeDl3Jwyjyisg74VznrL81FDTRDoKqiKcFompj5lVqd1C2A/pKfe79i+8W7W1H7St8iCenszk3bd9KGZaNmy+GacRWH4/ycxH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH/88aPjv1U9R0DJ+ggJo1R399X44EwjcmL0VVl+UqI=;
 b=M4+de3o9Qz49HyHRFa/JOK4gFYfL9m1vMhimMdW1B7GHofe4rQ8NRn5+ysivWXYrr3MX0MdlmkVZkhPy8XhzTHS70yZY7Fveh8JHJKsmw2b4mPZryQyC0a1ZEsQKuWqS4IVo2WX7u6IYGJwRm1Juw6zo2qqiifCV7XLuXwW7xMo=
Received: from MW4PR03CA0114.namprd03.prod.outlook.com (2603:10b6:303:b7::29)
 by PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 13:55:12 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::26) by MW4PR03CA0114.outlook.office365.com
 (2603:10b6:303:b7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 13:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 13:55:09 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 08:55:08 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 08:55:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 12 Jun 2026 08:55:07 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65CDt7NX3602930;
 Fri, 12 Jun 2026 08:55:07 -0500
Date: Fri, 12 Jun 2026 08:55:07 -0500
From: Bryan Brattlof <bb@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Paresh Bhagat <p-bhagat@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <praneeth@ti.com>, <vigneshr@ti.com>, <b-liu@ti.com>, 
 <afd@ti.com>, <anshuld@ti.com>, U-Boot <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH 0/4] arm: mach-k3: Add DM firmware memory fixup
Message-ID: <20260612135507.ndfsmjxs34fu6stk@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260609181006.460401-1-p-bhagat@ti.com>
 <DJ57VBSU0GI1.1WEU7NE9FYE46@baylibre.com>
 <c329501b-ae4a-4fd1-8fb3-0489a7f269a4@ti.com>
 <DJ71RUV8QWDN.4QHDEL6ZHAU9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <DJ71RUV8QWDN.4QHDEL6ZHAU9@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH0PR10MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 87447d5b-5d1e-489f-d2f9-08dec88a37d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|3023799007|4143699003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: fgaHL/L4utOBB0EI91gKxv0UOBxZfc4gvUbMFLDT6YBORHwDBCbxYQkh+b/eJcVbgc2t/mz/Thqwl3FOIZAsJ/ltOwL/yEGuWKesle7Fkz3ta7ZzCd64WanRGDLFdmzPJAZ7k6LTcJhX3ECT+JcxUXnNdRy89oLsHoRhUXBAYXsopTkG5mU+eXtv+wdxA3IAcZOXmnm3U89QbJxzCk637dK1ku3jWY5uyTxldkmShRUAcRCqlNCGzWV6hnB/qTw6WYI9WGB85uZ2hHRFQN1mHkG+pTn7RufV2V8XXJczXZrMgc/kTs2/oDxnnPtazmGj7iDX0mN9N46/neg2S6us0ldcgXXDOt+c61Vn/sXXQvuuVf9fMYby/zQ7jK79tM6t2oZ75xcnjSmQGGUd5ws+Zvje+HUluFeUTFpbt4CoqS7uUlGfjzCZ3ycBB+dUZJNDZoVOdlK1/gixiJ8kPHfXuF2Vr9G/bu2LUdYADfNJeNepuiddRVB5QZcyg6SYHQvDYt5ZR4oUUgd8x/wroMLHkYPIbEpGCLfhDJVYsUcNWK47L/ja/jAD9qkvILnNMn3QeCO31Y3E+gYT5WfNbWdjlKAfGJJWDYgKk1e6fuMqr8i8PcDXiUu1smnk9g+xH+UE6EW3WYPpmht69X2m90z+8CUyRKjF9AO0o8OaRMQEaHp3pD6/W5kajBLicUQ05XeMm9TtwRxlJzpSvZe6kg8MXYAbJV6neZxMHsdCTx4pQh4=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(3023799007)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 60sep0Rh59HmplK3sx2v37rY6inlRMmMdsxin/SLhwm4MfZ2isUpYvak0hsbmnGCa6mcukT8p15438J9asCC4Z4vgCGycDx5zvKgmXXJBjtQa/Ka4BtVKqOJGWFFSj5o6krGmJYrOEJ2j0CIhYHIsniCV9ztSNNT9G0IpabWU4nGBAwepjDf6UrOia2W/t6VyFy+OuDqr2WMYOOMPyZue0Ym8LUwik7+/bg/14RXGgPT2HyNBe1D/4rEiUBDtGS6o4DS3vXGpzvLxkWnA0/mQd/Rv8GCakim7HrBD75Kl2j1jc4Qb7G2e/Wqcudeee6tCMYcpAFiWY12XnpvbawvchwxL/V7nQGyRfD47fwMK+TVZTqWAfyUfLlLnTnZjQWZA2yW4t/mG4sfJVV+FrFCiCiVnyQyr5ihvOuX3zvf3LF6J0J8gWrfAK+gGGmwkZql
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:55:09.9586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87447d5b-5d1e-489f-d2f9-08dec88a37d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5795
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

On June 12, 2026 thus sayeth Markus Schneider-Pargmann:
> Hi Paresh,
> 
> On Thu Jun 11, 2026 at 8:14 PM CEST, Paresh Bhagat wrote:
> > Hi Markus,
> >
> > Btw Had a quick look at series
> >
> > https://lore.kernel.org/all/20260609-topic-am62a-ioddr-dt-v6-19-v6-0-16afba97fbe0@baylibre.com/
> >
> > I did not know this problem was for other devices too.
> >
> >
> > On 10/06/26 13:42, Markus Schneider-Pargmann wrote:
> >> Hi Paresh,
> >>
> >> On Tue Jun 9, 2026 at 8:10 PM CEST, Paresh Bhagat wrote:
> >>> This patch series addresses DM firmware reserved memory fixup for AM62a
> >>> and AM62d:
> >>>
> >>> 1. AM62D is missing OF_SYSTEM_SETUP config, required for FDT fixups to
> >>>     be applied before passing dtb to kernel.
> >>>
> >>> 2. DM firmware reserved memory region is insufficient to accommodate the
> >>>     binary. Analysis of the DM firmware binary using objdump reveals that
> >>>     the resource_table section and .stack section occupies memory from
> >>>     0x9c900000 to 0x9e608000. So increase the reserved region size from
> >>>     0xf00000 to 0x1f00000 via fdt fixup. Add new configs in Kconfig.
> >> I am wondering why you chose 0x1f00000 and not 0x1d08000?
> >>
> >> Also for am62a the firmware linker file says it is shorter:
> >>      /* DDR for DM R5F code/data [ size 27 MiB + 364 KB ] */
> >>      DDR                         : ORIGIN = 0x9CAA5000 LENGTH = 0x1B5B000
> >>
> >>      https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti-arm-clang/linker.cmd#L175
> >>
> >> I am wondering what is correct, the linker file or the objdump you did?
> >
> >
> > Yes apart from the objdump output I noticed a gap between end of 
> > wkup_r5fss0_core0_memory_region and start of secure_ddr. So intention to 
> > fix the bug and use all of the available space.
> >
> >
> >>
> >>> 3. The existing fdt_fixup_reserved_memory() used a delete/recreate
> >>>     approach which corrupted phandle references to DM node, causing DM
> >>>     initialization failures. Fixed it by updating nodes in-place using
> >>>     fdt_setprop() to preserve original phandles.
> >> I haven't looked at the code yet, why do you use a fixup instead of
> >> fixing the devicetree?
> >>
> >> Best
> >> Markus
> >
> >
> > I had a discussion with bryan regarding the device tree fix approach. He 
> > pointed out that firmware and kernel versions can be updated 
> > independently which can lead to unused reserved memory. So bootloaders 
> > should dynamically update the reserved memory based on firmware 
> > requirements before handing off to kernel.
> 
> Maybe I am missing something here, but isn't the firmware distributed
> together with u-boot? u-boot gets the devicetree merged from upstream
> every major version. So isn't a kernel update independent of
> u-boot/firmware/devicetree update?
> 
> Also do updates to the memory regions of your firmware really happen
> that often?

This originally spawned because the reserved memory size in Linux's DT 
was wrong. Fortunately it was a simple math error and yeah we should fit 
it there as well. But the fix exposed another issue. 

If DM _was_ to change its memory layout we don't have a way to fix it 
unless we keep the U-Boot build and Linux in sync. Unfortunately most of 
the distributions do not pin them together as tightly as we need for 
that to work.

For SoCs like the 62 you are correct. There hasn't been much of a need 
to change the memory layout at all however for devices like the AM67A, 
AM62A and AM62D we've found people are starting to use different 
firmware to help with whatever they are tasking the DSP to do.

The fdt fixup approach also has the added benefit of allowing people to 
try out different RTOS builds without having the headache of needing to 
modify DT to get the board to boot.

~Bryan
