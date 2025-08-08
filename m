Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA89C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 10:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18BFC846C1;
	Fri,  8 Aug 2025 12:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HvhxAqUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C97A7846BE; Fri,  8 Aug 2025 12:04:33 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082C6846B7
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 12:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vhx5ZE4oMfhRW/O3XXwFjB0OxJDNkv7AY40TGDUFNUuncG56mPvpXnI6X0P1rvfc7NAvnor/jcwX385jXNj+R5FQiYsDCI/M4wJKydgzBYIRnpkOqIjhdpdI/JgmMbkiMmNiGWawexajDeMT2YG97dRG5J3BifOATx5GnH6GRHISwl3HmHYiYkH9Lj8/xNzcokt+0s1AjxRuQT7iMkca+ljMFzOIEP1D3MXNGudCsHJctv1tArG4kvWwuni1Fibc09G4Fua0ZctptkVKdToWXyuSBPE8Z5WU2BMI3R5ZYT8z3TO349UwwW/Ypn2W9Ve9h1hjorboLGf1aDCnQ19wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNaSZmBbruR0iUbCPl+nNeOOhsHFW+AvCUZTmYuCESw=;
 b=yd1jfYnWry9AWzSNJO5uyg5Xd9KKWFsMUdHyzvQ78rEhKOIEn7qLNlnyraGYqLyirncSUtohPQajd+dUwKkFLADqmPgBxdyvVtTo8CAzzrngQhZQY2R9zSvJeWaJBUaLpEITePS9FWbz6IXr14LAfrkeH7jD/45Khpv8Yxz1f5vx0qRpQj/An2M3ocUNE2SudxH9mkqZByDHRiiYpQD018pWGCUvPjVtkpUDen/e275mDkImj2Mk6N5yD6/4i48k+dVL3AcOsExH4B9IURgQkitXJLG+t+8Xe1mWSQlFDL3PriI0F2QL4llZuyZcq1+Z2lw9GNF/vaOmwOO96cSWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNaSZmBbruR0iUbCPl+nNeOOhsHFW+AvCUZTmYuCESw=;
 b=HvhxAqUjSciBT9ovHjdsWsQXEnZhdRMnk+2kyYpBve0UnYsMNBOypSzdomKpI8jyOmef9R7msVejerG3DrKA+E5+CKhD25FYMCdrRDaAt7cquOieZusBGPfi8kX3k+pOQw4NKvRY+7T5RD0FlcLa/avOhHXmG+2Cm1eyGRApa40X8SOM1ltP143ygRN//LKyKzs9CmTQmuQpGfsiYO3NaGDTzRj6zntky3qGh7g454RAVjfhOYSr2GQDwyz++XWl5RC9V80+K+dWzG+MXB8yG3J2NXkJlpIzQyHyeG4vU1LGZClrbrp3NgGSqZns3WAJKx3wq2AjO5xRajtM6pkbbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB7113.namprd03.prod.outlook.com (2603:10b6:510:298::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 10:04:24 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 10:04:24 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Date: Fri,  8 Aug 2025 03:04:10 -0700
Message-Id: <20250808100412.9320-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a8b56e-6d17-420c-7e72-08ddd662f385
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Sjm4V3R1S8ZHBaLJu1XZ84ullMDPbVKX2IxC3t+VXAUYT4wu+2sTuYGZs3c?=
 =?us-ascii?Q?DDTMQ5BwS0QCba+Xw+nSp1c92jeWE7LbfROp7Q3dxYN9eTdqipilLlACqYGJ?=
 =?us-ascii?Q?ETxgl0uWs/dfLxEk8bA/Ouj9uV9rkQnFss7AqpUIz9Xu9Piqd3JpViKlgQP/?=
 =?us-ascii?Q?zTmkEM4ADiHvbhCmCH/u0cTVwKG+D7OVdpesjqesXpw204t+pu9EpKFb4UPl?=
 =?us-ascii?Q?ThQaxoFH4CF7TKfEal90DeiD8IyqKDM8QLjXhNoci/OE74zKbueN7mEP+0QP?=
 =?us-ascii?Q?u21SCjMBqYE9ifwe6J8um5ZSFYWivxDrmuvmhfMlp36fWMz72bnTwaAwMKH2?=
 =?us-ascii?Q?FGRP8tqXdVkoyhpmFSay9s0C8vQt6vjWLbhQbgL/ed1EhkYqYrrnqJmRa+3X?=
 =?us-ascii?Q?x9XVcXp5WkCzYstXR1wrLTsDIMGx6CgDDZdKMEFrbPo67QzQ7LpJF1m29V2/?=
 =?us-ascii?Q?8qZJcmXLYgfCs53H0wTLrzNeAsLXwmj199BPrAdF67bzyLK+Wm3IjHM4V0rb?=
 =?us-ascii?Q?8pdiV/Vxpb0zhMnsfVInWU9wROuSPA4KOkhK/N4h9oRay7/njUSMpjlvrZc/?=
 =?us-ascii?Q?imY+n5BabanvRAIQ5DO6uMxlWHQIkz0MrG05BjZA9IuWrt9dIMrPh5+o5+/+?=
 =?us-ascii?Q?fkUe2gaMvpVGDuIJKXgg/IO1FtkSTGQs2/OXfYMvLdE3bAThVZcedlKjnHa5?=
 =?us-ascii?Q?euIgAzCYybbClPqw8NcLlY94DG/xQ75QgREvRIKBt10gXWfcQInA0YZIBUBD?=
 =?us-ascii?Q?oiCeySsziWcg81TW6nDXktj8xDi9Q1M7NFFkBc76JJpEdZfFMPJQIjXA8m+z?=
 =?us-ascii?Q?SbdeR/W5yXeLLGAGwtVDi7xGxMgM44p78IOYD7vt9q/S1bERQyxbh/5m5TOn?=
 =?us-ascii?Q?stkWOdh1onFX2XCpagbIlziN/6grre9LxRMWAxc8kJc9GfckUqmlxN6B4YSV?=
 =?us-ascii?Q?SubYVQa1DOZxIE0EnfCDputVaIN0lrU1sRhDmCRi2U166/oA9Ba2BriGD05G?=
 =?us-ascii?Q?eRmH22Ib2wNu7+dG5703AyzgOB3Siw4niwsfDiiJzYIoOAPUSTu4cvY6+a2v?=
 =?us-ascii?Q?FtgrpJOmwtUoHHXMDdQArV5tuCIGzuuLLV/dN89hoS7nJvr3G76ZY65vQrPm?=
 =?us-ascii?Q?OtIeQJATLJwJWTtYrapeTgJJJF70hBuNSn8qWfu/0mbv49ss2MUPm1XhuO15?=
 =?us-ascii?Q?/93LqCbtQs9PszXulBX7eAuvj6vXiqJv/BpYlStVhfRKmwY4zIPW/GA1S8KF?=
 =?us-ascii?Q?9CPWi4iwglgdgGaNtzizQaNPbQ/Fyar8C//bQ1e64z5DQ0K0SAv3yDK1hTvM?=
 =?us-ascii?Q?saRN1lKNTnefPax5SeUuXO3cLhwwp4IpdMbH7DDHHZGETTmVykIpENPHLeqO?=
 =?us-ascii?Q?/wYcG8W8uyTxsyrRvv7eVbKBW6b8X79/krQNUwKDTnQPrWRhCk3NjqWD+xEr?=
 =?us-ascii?Q?f+VY8wXBXnQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/b6Squ0pq/nZjKxemAy4VM9Qx18im+MJl+rVSliA1cNcjXRlkFUrAXb739Jd?=
 =?us-ascii?Q?2yxGsSeXDbY79GEpkQrXn+D7azEw35aXn/7BwTtpWIlbM76pD+PYfCcHjKiu?=
 =?us-ascii?Q?JNjAAw0GTmiQtRCfIyHlYZQkC9rzUhqz6oagxjIyKcQaJj4l8HxU5y4tkPjC?=
 =?us-ascii?Q?iCZVzfwSI36FnU/7xvKaKNC0Mjb8kMunoWldZpd5dC+L4q8KU7VjrN1ZzTdN?=
 =?us-ascii?Q?qDMVe+w3/UjA2Q7uuVXu0MDU2Sl1odHF/817oKZwhsmNURttR6AJ/PLyN1HG?=
 =?us-ascii?Q?Nyr8EXqdilv14uhfdMI5673ONZWm4BBdgIgjJ3tV0hrrUUL17nRzooe9xgKq?=
 =?us-ascii?Q?joO9CCNFF2Ql5bMZsnswKQCGgujAgxSXDwj1EUj0iRHuu2JWI9dQUkgyzxIt?=
 =?us-ascii?Q?Dqax+BFegKv2rOah7WPdtGVPYQhMQCk505fhBjDeeXfuaZt5gmjtzAbBBeZv?=
 =?us-ascii?Q?yt/y1KFftNxq8AKNCCZBL79naExR5q29+2UcfXPhSG03buxca/dZ0dxIucwA?=
 =?us-ascii?Q?GOW6iAl8ssNijG5i9nsB9uShq+IyS5At42dM/ijoIiOom6fyaAak/DlVfhUc?=
 =?us-ascii?Q?mtXSUEWYai83Z3xhNsDfVTsBhIcWNFAGw6KKsCTz3/2+vCVAF4KmO6tP6utQ?=
 =?us-ascii?Q?6MBGtJsFBA10eP1oxN7jFuYDxhIwlx8l5C83+oLCyHjNGfgbNQ4ahv7MQ6Oy?=
 =?us-ascii?Q?DRerzttYrqGwNfXP2tby+bS7sEGZcE+i1QIpFk+C2JeDm98W5wjIe8eC0hzr?=
 =?us-ascii?Q?AjlvQCk0wl9rcrQ3NPrY6qmMPt1k8Av8D6vkfbbsK7K5XPG5Pzsj6zdtJvi/?=
 =?us-ascii?Q?y4HNEJ869kuX75239gmtaIAuss8/VBj+h16cBJnwcutQMxyV/4LpGTq0wsRw?=
 =?us-ascii?Q?6gtTnm7pHIMuw51DG5gNOcdXjasQP5RARZUhFk2CqGsgyGYNGtPNVu51d7HG?=
 =?us-ascii?Q?EfyDpZduh3LZG1lcMAzJKEa+5sQ/8CxTdIKFa0d2IPHPchbsAr2sjp3ujuQb?=
 =?us-ascii?Q?XWai/rUbJXSnTmOUN2bE/071Amy3b8UYZQOc+NSQHowp/lX4HP+NWz5buuLd?=
 =?us-ascii?Q?UziZM5wXdqutSq50bLKA+MpOFeTq6iAlBLhUL5PYEYNlSoRmf0KYXjdQ8smw?=
 =?us-ascii?Q?IFaBFx4YwHGlxC1uwKYUHn3mV4eItP0OsP4WipBwcVxpvEbKY4hl6xkUEmZ8?=
 =?us-ascii?Q?z/92pEWsX2QmAGQinW5IY0C3tqE8J09W97PWPJkNWWkyfB5hVm0FtMPRsljc?=
 =?us-ascii?Q?yvc+DYoFQP+hqsh2dtkTMct76OQJ92Flo8PPQ2mjePJnabhvidNZFM+Xhmpd?=
 =?us-ascii?Q?DOKYdR0ex1/UMsMTjW+0/qs3tSc/nfwPyxq2NipGAHz7HgIlBRwWrawmUN6H?=
 =?us-ascii?Q?BPJdYLG1UEohrdXDzHod8KT2+tSFCmDZoBPDuNLplX031J/Z3sg2bEpMBGo5?=
 =?us-ascii?Q?ZGLA38svkxbdpiyFGdqG/x/cxWO9+BR6KVJs1ZNkvnN9Akgyr2Eija0lVDcs?=
 =?us-ascii?Q?hw68zJqx7780PTZdbSMuc/W7EfJZsdu4AZ+d45GKDWZu0k59ftOAX+QnJsvV?=
 =?us-ascii?Q?azZIFxmcDbf2uxfj2b0wmDcF20r/NBT4zgzbW9rRcWgHyHNKzlIZsiXj4lMF?=
 =?us-ascii?Q?lcjyyXlfczsGa/htKh0lL2k=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a8b56e-6d17-420c-7e72-08ddd662f385
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:04:24.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkPit1mtvsqalbSLInkCc1dJdk4jCH5ztOHe4Av3Pl3DP2BSPU1yh9VEe1a90qqcF6D0T2OF78l4+WZmBBlSh25Tsxajf5HvvSyrkcNTJrL6OCAHZynL+fxa37Y+qkyc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7113
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

Required USB DWC3 host driver configurations are enabled
for Agilex5.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index cc812c7008c..859750f02e7 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -98,7 +98,9 @@ CONFIG_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC2=y
+CONFIG_USB_DWC3=y
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.35.3

