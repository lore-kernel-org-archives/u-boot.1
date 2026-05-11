Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E08FCD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8702483E36;
	Mon, 11 May 2026 20:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HhlJNZGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 237B383E81; Mon, 11 May 2026 20:45:03 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8BF83C2B
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaL4Qd+bPWtBtkZWmXOTKLykvJeJdEJPmzefQ2Hnbo3TiRw2fzcvfMrvPFAicB9lPbMxF9TkZxkCPqIt3jeX+9anmKMlVS/qZEUiZK/BjgKTpzeUPJ8RZtsPYR4PnCUhMILqn9JZPM0xbb1k4fG8bEY1ovO469HtqxAVCZiXGQ7mcca+KpmB3D4S9pHFFuLkr0ni6gyMxQa0U1sh3smbY9Bz46JYWcsEVUuQo49oSsO44KAFbMACdqQkadgmrj5vYQbple8JBsh7JIFkg045cbpgcz43rQu8XQuG0vQF4Pnpzaqavp8Tnx1ke1yw4MGB2cbcr845xQ+SsqX9ZOVtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+iaHjcZBDLJOyW+npGKlxit/zgL5AAsM03SyMtU8Dc=;
 b=i7uHzeJVTim9aA7PpxbDaEggpbJ27QdeBPf8S1GDeQSFA6Ct44R+UyqYex6tmKEXIDnj59fEUZN8Dh03mMR0ZTrcsJhikVf8Fb516che1gYjzLgmhXWWeiP7lEb62d51/Y/NEq+s/eAJBVw9TUvJoEEptbbGdDQht2s5GnEY063+HsW4AkTe+melc1jp6ktlQJ9YrsfnQTmKzBSV4veWwRIB8kaCvDVG012y/NeXJM8jZlIselfHa1aL3pV7ILVynRz6nXjtYqvpebeWs6aScmZLwD+T1HT1swsqhpjXOyY1Y+BIg3SFv7NJmTan2DFX+sTq1wg8sWL0lBFdni01GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+iaHjcZBDLJOyW+npGKlxit/zgL5AAsM03SyMtU8Dc=;
 b=HhlJNZGgdYprmKa2LOwEZdoCfLOl/9iD0oz9rzF1gOfk3DLDSFp6K+SBkYmxoemR0GDIrJW9SyThqQMUqIbuwvJDAGXrZhgeDOiHWny75/pBKn0mUHS8gGYhYc4S6M9wb5EguqdcLOkyJp/0itrFM6YN7bj9qN6CnoxaT3+ox/M=
Received: from MN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:208:52d::29)
 by BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:44:57 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::25) by MN0PR04CA0030.outlook.office365.com
 (2603:10b6:208:52d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 18:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 18:44:55 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 13:44:54 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 13:44:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 13:44:54 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BIisTr133307;
 Mon, 11 May 2026 13:44:54 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 May 2026 13:44:54 -0500
Message-ID: <DIG2J12J21HH.K196O8LVE6B5@ti.com>
To: Simon Glass <sjg@chromium.org>, <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv6 1/3] sandbox: add board_get_usable_ram_top
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260508222911.450165-1-rs@ti.com>
 <20260508222911.450165-2-rs@ti.com>
 <CAFLszTgDu56LqCfzXgZ2P=V6szOYytMSvj0LRn4u4S8YWOcEuw@mail.gmail.com>
In-Reply-To: <CAFLszTgDu56LqCfzXgZ2P=V6szOYytMSvj0LRn4u4S8YWOcEuw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|BLAPR10MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 61954da8-a97e-4630-8278-08deaf8d652c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3M9TvHRbVBuVGt19rav4fTCbfFvHpw5JgmRllWtAW4hVmiVIpB1xIVfuHtKM4ZG0YlCIueWveimC5eNPU+yLSZRnYvtjZD+PGb/4vfF3loPUI0pJuwLgcOd3JiOp7x2Q8R4MQp+uBmKlncSVp+Mh1ukzCrITJ6jJzlauZmjOdyEH/Yp6+wvGjifEpEKdOHLSu0OVgboApQ907vZ5YV90Hkf4zuz93OmwFkXq/9wdFVFuGWoA/Lkm4YRirwh2NpwcOxgCemTGSIO3OSZGpGi1snOs0Jw6GxrBQF6FUSnOiLAicHjhYVtlIPgrX/2WKNoueKfboPmxoCu1VvDsmkbyqfhrMlXuEe5QLAkz56QPbVxVrqpkauG8UmCG5xzvfE01rBUDUvBE/1Hl4qhT0Ex5A8pAJ87kAlEVFLxw54uNIpA42gSXBs9R8zGbAGn9nD/hpx5Swy1TrMS6C5E0nEV8a3/klPmeR5tdVikpqEAJng61+XmgC/tf0Chs0I5rsG7ZxrvnszlezOaDMCXvh7KZMy98KmajWnEvb0Q7U5jj+dREkkdfPHGqKYpQx63eiyNkndDkqUUzLjGL32ABMGxMOHDhJ5qjbqBii3s6X79yfMWPCn8T9eTzRAuLi97G1O/A2QdpbUYEYaW6xS2pv0ioK7cjWk78KDru5beDi/i+7U6TzHOjNvsTSOwul0eCu1JXGFbg/wtIg6MzCIkvgI4pqT9jstCn1ZvDRZ0gGuBegc8=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 43YBwmPRjW7yxBqw+rX3e0jzRr7fTQPEFlCybDnD3CJKl8BabXJIj7BDKMIlRZXxnnUn0FjL0ciXBbCyu1XMalYImdJ5RpEA9NHr7OGd3DiX0LZY6it3v2QXL83kkpCK2cotccqSv7XT/NydhG1RzH7CMTrF3jtOLw5PcEWO8UJG8Lg0kOqJgPchAXXS5n6Mda9MLPA9Hl91D1kQN8kiJLsiWIvGm/0uWhPYPQ4TFCAy5BdRXJFPkXDhX/WXj3eTvQns4qJGs/1AkHUaQE82zUVdP7uUjG9rhs2KR9XeHihAPrtqsE5CInjCYXosJ0bSrjPYgBCGcWp8ffB2dYVxGzhVucpl4hwAsmt5PTljN9BDBmdbqS1FjIdW7CSvMyy7Cjg7MmZbbA2pp8FoDntxl2APrd9MEBus4lxWGG+1kxbl0DtOhJhZ2vPnoryNBhWq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 18:44:55.4693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61954da8-a97e-4630-8278-08deaf8d652c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
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

On Mon May 11, 2026 at 1:26 PM CDT, Simon Glass wrote:
> Hi Randolph,
>
> On 2026-05-08T22:29:09, Randolph Sapp <rs@ti.com> wrote:
>> sandbox: add board_get_usable_ram_top
>>
>> Add a board_get_usable_ram_top definition, since currently ram_top is
>> equal to ram_size. Attempting to actually map ram_size with map_sysmem
>> results in a fault.
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>>
>> board/sandbox/sandbox.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>
>> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
>> @@ -105,6 +105,11 @@ int dram_init(void)
>> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>> +{
>> +     return gd->ram_size - 1;
>> +}
>> +
>
> Please describe which caller actually faults on map_sysmem(), since
> that is the real motivation.
>
> But this contradicts the documented API. From include/init.h:
>
>    The returned address is exclusive (i.e. 1 byte above the
>    last usable address).
>
> See the weak function in common/board_f.c

Ugh. Why is *usable* ram top exclusive? That's returning an explicitly
*unusable* address. Fun. Suppose it's my fault for not reading that first.

> If the real problem is callers doing map_sysmem(ram_top, ...) and
> faulting, you could fix it in those callers (use ram_top - 1 when you
> need the last valid byte). But I could take a look if you point to the
> code.
>
> Also, this uses gd->ram_size as if it were an address; it should
> really be gd->ram_base + gd->ram_size. It happens to work because
> sandbox's ram_base is 0, but it reads as a type confusion.
>
> Regards,
> Simon

Fair enough, but it seems that this board definition will not be required g=
iven
the above feedback.
