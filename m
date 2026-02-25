Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC1DFD375D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 13:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B18A83E8E;
	Wed, 25 Feb 2026 14:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fUV4QFhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A244D83D77; Wed, 25 Feb 2026 09:55:46 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 992F082A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqvvVm2M9Q7lMxQCDI6nrTYLYTz8VUrL87Ipo7m/+7tFTs/IBE3d1/UgjetqUrMyqpT5tD15pUk8QvrLPdXFnV3d75YEvtip5r5b6cxQKvDLDMHCGl89uvCVHBw+0M+JlXPd48aP/iBU9aZKKsqCYeVhxLjUX1CcM3sN/5W5eXlNtvoMka2hn+85F6tTf6cIJ/KtpwtXc8C2JE39PKzYZ8dFVKAmPrBPFlyq4BHvO6MzsqItnRgAtILJEaA+05/TSiYzkMGV6BpI9dpxztiQdnhNkHcL4kskf8lkazXwASo2vlu/5vOKGReMb0+YVvRC239dTJcFxlrhd4sny97ALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfD8NYqFdvdVXzk2OlxhWAZeB+D+84suoxxn/CGJnJw=;
 b=Qsun4/5n9oETDCk+vnLFQqi39pq15i1jfj8U2QEYklfDu4ueY2fHJXDTjvJaMx1ckekUZZytwe4ka2zz33KcPguCmBfjD4ESe6xbxcTlpC2B7SM24Qx8+1cZAuEb8xgS/Z39ErXZJt0ljjyuLSvSp3mKdCWd9pbt5g1BW5O872bBsqxk0DCpumkEmpdN1yzH8HkIQIOU1nwPBwhDYh5A1tcA1ge0kkHjaQLcUmIvlQhx7Opn4TLMM/DkCIxoRl07/e4BVPvANj4SFf7FozdNBl9O4Ksk6lAmQEeIIsnnRSOr+1/wZxJ8q7sT8hZWH6T6LY7flCA1HU5M9HliqnbNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfD8NYqFdvdVXzk2OlxhWAZeB+D+84suoxxn/CGJnJw=;
 b=fUV4QFhcPObhifMOylb8Z97hHUA8Ibj0FEO0caOLj4CVx2ufnTW2lVCiK+MGGoolU9TqjBsYPsJrpqTMY1g1YghUcdvQxTDPSs79WJDIsAn7PnOz42gN7M7KbLlT+GJX8v0h1IQSqWNJyiC6ALITspU1eGNwrB4r1vEUaNlAEz01I6SLCND3N36M2JFnJAKII+cSit2Ik82/VRy3Tp7dJsYQGlddboBM/nf7z+d3FDpA7LJJt8PN4Djqs42s++E1n2ew8CtxDU9GJXChQAW4eRgtfZiRsdgt2hZcaSayHv+1rFChyhIQXMcJcGOySZHTlygsYeder8BtigyPM6A85Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MN2PR03MB5181.namprd03.prod.outlook.com (2603:10b6:208:1e5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 08:55:41 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 08:55:40 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Mahesh Rao <mahesh.rao@altera.com>,
 Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Lok Chen Huei <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] arch: arm: socfpga: Fix data cache flush issue
Date: Wed, 25 Feb 2026 16:55:30 +0800
Message-ID: <20260225085530.18706-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22)
 To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MN2PR03MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b4a13d-108b-4833-a87b-08de744ba6fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k4GRbi9w4yoE1DTosOZPVcTKk1GBgoYZQD3XFYSSb/Oc3NUYSWYyt8sdZ6fQ?=
 =?us-ascii?Q?QdZeB5rbLCVClbDFDb4RwXRbRiyU/MOBbdL2ihNCHoNP/Rza2JfRdpFX5PGB?=
 =?us-ascii?Q?4FchC4ZdaGlPydvgIrlL3jFnVum8LTxpeVcXZwzp3oY1agoDctC9AdO+A0IU?=
 =?us-ascii?Q?gaLYYzFzIhr0cjgG9uTU+DiLQ10M9IYL+IFalwLqGelS2csbwnOE5UHe8gT1?=
 =?us-ascii?Q?wZ5AGOIAXC7d0dB6Eb9qVzX2Snvx54nsCTz0VwFtJ2Pn+AlHT8AYXxXdONgR?=
 =?us-ascii?Q?bl9QWrPLfnPFUQgVVmNYnnIjWsXjI46Uk8V0ip2bDzxOcW6fR0OC8i/cNDto?=
 =?us-ascii?Q?7SlJMKshYxRigR7TQ1nX+KrrqjqPD5W22ZhutY//vFDTUlbEPZOqjWuHulvq?=
 =?us-ascii?Q?ek3QVXdzDuhTMbn76JvQQ9sF+4vcmYF16HtfBCMCX94GbIKAqoEfHLg4RVY+?=
 =?us-ascii?Q?YFJxdaZRE7g+WqXLiOR8hpXj1CriYKwtWYesRZFPn99+GZ6uNx7muq6dBnGr?=
 =?us-ascii?Q?QfKRdrLR26KfTKfczPaoMcjRvRfc/GfuELYOHa6Fk01Zu2S1FnCLZJsr3b2i?=
 =?us-ascii?Q?9f/xBPsoLMrZCde6uThC3EgGtx8kMBT0QTlAnePUEY7oI0EEd0EsVQLhOySR?=
 =?us-ascii?Q?BSQsJ7mPjfKuG/U6J/vuUxiafxYAgT8SS/gmagwuHFApRV3NLXG+mR9efZx/?=
 =?us-ascii?Q?e1bAfHrSAJig4AljtMhomqJxPzqrEa5XctWH5J3/NOFuB0dFogvFMLzGYi7W?=
 =?us-ascii?Q?LlsL8sdJ4oTcEISZEe5Lv+jbonuWaKEX3G9+KLJ8208ptQxXS3pi633fE8zy?=
 =?us-ascii?Q?HOeXP4XQJSCdizkYEnTK5hjx03+6Fqc4nKu7a7UIqAemgAB/SZvlaojXqyK7?=
 =?us-ascii?Q?cKv/Xv/01h3G9BDhHOUpIYjrNWPGUV20VC/9Y+22j69p9WvwwOedlosT1blx?=
 =?us-ascii?Q?nHbPouIVT09iu+7cDNPbOXFWaKI436LsFxFL12o0FCNB9RA7BoMDxOYL/Pqr?=
 =?us-ascii?Q?pbAqh437Buxdmg9jBvGImfWK7vqLKZeWpGmH7x+0XTyoDRCpjuijLZ82d0VB?=
 =?us-ascii?Q?tcNwi/62AwRAcrJgm6EQupG48ZvOqIJDSsGxZFTnMBs8y7OcGPfh13no+oJm?=
 =?us-ascii?Q?i1Qy4JRnJZ1x8SFuNRgBDBsaE2jk3KEnQc7mfoRCmdlVuMQkEr6zuB23NcVM?=
 =?us-ascii?Q?XTPMG8nk2q8OJhzHs1/kVxDGB4oqhdm926wOEeO3JXgoPWpE7EwYdKjT5XxJ?=
 =?us-ascii?Q?KA8mIUXdZB2MOzfOb5kp48VawQOT+juB5Oxg2YRHxYpdGihvdIiUjPzHQKYE?=
 =?us-ascii?Q?1YnC1CFl+AbR4Ws3H5vt8Ds42UDWlgHf+qbct/DV8+kixEsZ7FqGm9Sj8VZa?=
 =?us-ascii?Q?lmbysYFurEjM5bACXRXLu0IjwVuI/UNRyCMRknwwShlqGKjzf/xb7xVYSf6i?=
 =?us-ascii?Q?xtr39y63Q77GPFTowXDRz6PytgyrBV5Kb9EiTnj+dny0RCCTNOtrNCZzMUXk?=
 =?us-ascii?Q?H2s0TQUo7VxrnWoAAAMGeFp3f+8AFIdJsIzjFqXnPKs9VeDPgH7FhDG0EaS6?=
 =?us-ascii?Q?A2HRtDmDapKgx+vJiTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?igwSlpS0AXo9FpKhTU132RECwTiGFn33+adgVLv3CblyR4esu3YC2z3XxjPB?=
 =?us-ascii?Q?I8+PAInzKuaOM8cP+QSxm2Scq+r/6ogajJEbYs5ccUF638GT8xTijBZJwe7y?=
 =?us-ascii?Q?sEBBEmsW47m1M+XYtbRkhoZrMCKfoaif5tdvybFZtgg95g5GaNWZ0vP6bLQE?=
 =?us-ascii?Q?TaM6MjfHtH5lY7F2PO0chwAmmdHdQVMr9ecf8I82WRxK+ZuQixVkRdDxZEYU?=
 =?us-ascii?Q?UrMEKAOVHDyuHy43TbiGCaS8mrin9tiy82iFNQwpZ3gSFAp1A2omJ8LeTrPd?=
 =?us-ascii?Q?Vhip9fXI1iNn5kDsEy7frXnuX3W5u5crGWbD11JQdrFJrTdyZk5Q1BJRCevq?=
 =?us-ascii?Q?AMWld4Mb89yGDDzLAOJY/0fae79RYmdAA7KtsBAchXUf8hJVLptHdffJE+hB?=
 =?us-ascii?Q?JSbPkVpl9hBHXBQ7LyCnI+Lgtk7o8zz2vd4kXTuJbr5WEb6ll3mK0J5M8RC7?=
 =?us-ascii?Q?lqvogaawRxRgk7l771HGdXPFPOMNBSGRD3rbf778el1yOjQymuMc7Pb6cCy6?=
 =?us-ascii?Q?5QSxWcJF5jcLOKyUiNJZ3AvQfW4vwYiBWqhpHlzWsFd335gkwK01VZEBMT3z?=
 =?us-ascii?Q?8rblBkVHoa4EKOVYCdmx0xEhZCnH/Vpx2br805lVrYh2XGgdTaW48yxfYiqa?=
 =?us-ascii?Q?g7K729sq9rV+MoJ8B2C5Z9PGbLQsCV34goNM4CplDTBOxfVhgUtmA2wnTMP8?=
 =?us-ascii?Q?VkAsBf/uB9pUhA97vEMCm6off79XeynbnGHcqBYojtfCZwM16imvzVXf+E6w?=
 =?us-ascii?Q?H2EuqMGCSs9V+SUhQtfGvSa3OdU3O62vWF4PA2K1MKT6xyKKrMPpk1B+LGPA?=
 =?us-ascii?Q?waFVpUVM5ad/4XzT4I8pkXs6fI93OFBwq8aZFtKx7ES6NHcIf+2GGHYOJYeH?=
 =?us-ascii?Q?iq3O80/0TpE+GMdv88wwjtwsgn6RyPa/pi/Menb9UcSWE015LclBkPj7xTDI?=
 =?us-ascii?Q?FwUO1F3hkH/M2tMIWKi7fZ//7nuOpNRVR5KIN04MRmbvVFd15tlXpuL1KGhg?=
 =?us-ascii?Q?yWcabJPCa78kHFdmP1qtEGNZ8gkEolUxpO9+PmsYTllc2tAWL/7y/ejpXNTT?=
 =?us-ascii?Q?M8Y0onFhRDIiS3eMpd6ElkVC/K4qp0+Wm1J9CPcr9DiCjAeoB76/rXq7cUl3?=
 =?us-ascii?Q?HfFrz1dDwtEF4Cmbm0jonTZAwwP3wfjBoFN3NKGbu2XFZCmqTzTNl8/cMHrV?=
 =?us-ascii?Q?dPz05/7y0NYh0f4AYAZzO9d19aFurYevEZu6EAeI6IySfKJbgxL4iiv8t+GZ?=
 =?us-ascii?Q?6MLngB8gzKFE4xKCTXXgE1QtHlhNgRbDkuwZvYAZY594LXtzW4wAmGxkI3l8?=
 =?us-ascii?Q?9OZ5gGtt1XkE3GbpfvuIFdzFHP+fBn0tmlAXHEc/6L/3Qqah18L97Nrmm6NS?=
 =?us-ascii?Q?na2b7DadQdMlxfKJ48ELbR+ru0sUaTEiIIMY24V7jwqTEdHh/srvc3qTnlzb?=
 =?us-ascii?Q?9Qo2Z7rOHPbZZ+pNSHqZAbbbUzDO59jwtwgzWp3DgA0x5X99E+ULmLBPnDZO?=
 =?us-ascii?Q?OJnRFhUPuF0TKfiCSGcx0nPidBdE2z5Nq0P7Q1+E8mlsQJoLJgEhHRdcDV3q?=
 =?us-ascii?Q?IqCYLV11Ld+EcK7Q2knfLw1K2vE+QmC6aDEB4jhVvwgL12HWlCLFHwLXbYsu?=
 =?us-ascii?Q?4H9gAu34oFukWdIgjXKI2JIEDm2Y1iFYJlxM+UphpUKLWmUrsN8W+esfMnYq?=
 =?us-ascii?Q?dAi4R4TJzmi1BW6Wtk5DxFMkSUpE3BzC72iMm+tb3VAhE//2JEWi5vpIFF/L?=
 =?us-ascii?Q?N3BjM9OgCg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b4a13d-108b-4833-a87b-08de744ba6fb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:55:40.9011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXsugcBshh0Nc1Qj/eNo3ezpF8XSM1clbr1AbMEvr001KVh+zLxXcCZkt5w/qnRfyRJPDhy3f0eB0KgGqMYmBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5181
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:19:09 +0100
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

From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>

During flushing of data cache operation, the stop address
was modified incorrectly. This led to Linux certificate
authentication failure during VAB flow. So, addressing
this cache issue with this patch.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/mach-socfpga/smc_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_api.c
index a531030f5be..87834e59206 100644
--- a/arch/arm/mach-socfpga/smc_api.c
+++ b/arch/arm/mach-socfpga/smc_api.c
@@ -44,11 +44,11 @@ int smc_send_mailbox(u32 cmd, u32 len, u32 *arg, u8 urgent, u32 *resp_buf_len,
 	args[4] = (u64)resp_buf;
 
 	if (arg && len > 0)
-		flush_dcache_range((uintptr_t)arg, (uintptr_t)arg + len);
+		flush_dcache_range((uintptr_t)arg, (uintptr_t)(arg + len));
 
 	if (resp_buf && resp_buf_len && *resp_buf_len > 0) {
 		args[5] = *resp_buf_len;
-		flush_dcache_range((uintptr_t)resp_buf, (uintptr_t)resp_buf + *resp_buf_len);
+		flush_dcache_range((uintptr_t)resp_buf, (uintptr_t)(resp_buf + *resp_buf_len));
 	} else {
 		args[5] = 0;
 	}
-- 
2.43.7

