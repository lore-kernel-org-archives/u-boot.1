Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264BBC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 01:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E5CB84A27;
	Fri, 10 Jul 2026 03:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ACEsVEIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2C384994; Fri, 10 Jul 2026 03:10:11 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7644484994
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 03:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfToqnxCgTJ70CVXSkQOj9tc9Qr2x2NQF3VV7TE7Rn1MrhUxCuJkMbTE5VSt5mdyK5XjMkQ8HZtu8ImYiktg+M9+SEU95J/KDpYT/vm1WXITLW8o/gqnfVeEuMag5zbRLkWCELkDuiwgFguFEnAEmo6C13LOWQ7Idxiyl0hu4osDO8yX6o+AcTsBgja4XMCE/oRxABJIDITgtQFMXmkvCxk6t6YV5ZVSh/Qwx29dBHx3IOnwr3Dj5T87PWq4SK/z9UHFGV2m/Ws0X5D4JoMdr0tzcqpz+keDD3vs3ZZyT/sjEkV1TmgL0rviHFJwZ8nLhh7WphbZXvRIydoIIv6P7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaM8dn463g7YHaihglekLsroWPA8ULEKrz433fPz7SQ=;
 b=gnPomgjiBdjlFXdw60FSoMqGiNZ+gc/FxNGJ31NkWfKZveD/vm2Ky1AV8Yuw8TXSsbWHEe0lkepBAaytHC2hZN0bpIgLKQQML59s4Mm+KgJV7qv2ygFyGqJehHttjN1G94IOtAm+3GLCrjDUZyoiwJsAK1ffJLTBsVBctL+DlAUfzGbtlkJuVqrBcnbD4wB+LuHGhIV+NfniR5fEYJxOwf7l+aW322uLqOkb8WkhPsQdNNMobYI0jctrctQs24RyFoecmPH/NPWC/X0MRwcsuIsg6onybrFuNhl2qTwTWIMlyG6XAZrW9480CdrZxdim1NK02qeTKFmKHJLcAsmyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaM8dn463g7YHaihglekLsroWPA8ULEKrz433fPz7SQ=;
 b=ACEsVEIos+JATWORmFGdEylfT/b3NcvUwLj48G/OkLBniQmDdL2uEo0LhZb1qYMiWc/wZUJzIjMt1ICm0OIeFLz6Zz9ui3AIFlrcWxpEO/IcKElXzvXtbaob/Wtdp9NjnZax7XwREM8trYzw+KQNHdfEgPPjjW8sxwIbhmtWJga+it9ma5M+FsNkduA5CWF9JAQvzrXKTkjZie2y4UOqo2yBxhOLXOaFLDHruauf0rX16nGhFDVtTYlUGzNRo0wjE1HlxB5hbOhQIwn/wt0dcEs2DDrwT66A1OK84+hpoIky+Q+KYxr6Pd1a88oJOCfx32Fdgc2q1KiX9n8fcJ7O8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS3PR03MB989146.namprd03.prod.outlook.com (2603:10b6:8:39c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 10 Jul
 2026 01:10:05 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 01:10:05 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 2/2] arch: arm: dts: socfpga: Update system manager core
 registers masking bits
Date: Fri, 10 Jul 2026 09:08:29 +0800
Message-ID: <20260710010830.5423-3-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260710010830.5423-1-boon.khai.ng@altera.com>
References: <20260710010830.5423-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DS3PR03MB989146:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc4fa0d-e9c9-4a4d-593d-08dede1ff9a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SehQDWlqwT0nncCUlXCm5/r1lkAi5T6gdB5/9qQmTKpLAdle+YnMJttc9suCQK9k5WfzfoVId0KCWvAYlKDh4blNnvnYIVQiJP0qGYo7nLjnRzSVJ58oeet6WqixaKvqYHN5owuNW3Ju2puQwyGWR9OWgcqwuKrkXEYoOz1MLjIwlG+5w/fkipz0pG77ydeRDXYS01h7MStiPVckxrdgWn63q+iRl6cZeKlYuJhIYwglkLrxqU8SfCXfIBX0rhC2jccNn5SBwVmyD2r+OSuBVuqAF6/dWaLk2I+ZAlOv9wb5XCsNjXbzN3pnO4fZuvNUhR4G7rllSZPdusqwDcVV3KH6IIiLsscgcQJK0Nl4HTWdPp1JgziYn2/iGglZQuSaXJ1fzy1uyov9nnr/dqul1Ldt7WC/OHRQrhbqOhGtv9sZT4AcIFdnejdRHwwcgaiZNV95hLvjSx3dlGCa8gi4KDMJLRlxzS9VY86YqRiJijD+ZvFECp2WjE5A5L0vsybj8uf+lEhmc+ucZ+62IhWqM1tUVyijckqJach47T6f6BEGmRAqFzdxo2HO0SL944UsXVGCe0dVo1fMUp6vRWnwyA/EABMB7FwcHhpkvMn0iTJFvV7u05woDAl8AY3tDZIkOjQ96tQerU1akhX77XL/uj0sJIh+RiKrhG8NWye8Wv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ngSxXQlQlDwGmY43rMYoj0tm/45oKebIitRAQbeGgiYNs1MtjGW731ENZB4f?=
 =?us-ascii?Q?Dmkhr8I3NE79Ehg7pUXcgdB3EB/YLacOiuJYDv0uLs3eLquXpBayDbFnHa4w?=
 =?us-ascii?Q?S55UtfrkOLui+6PpV+5YnE6NZoAQWJP+eXbEJR4rymQKoSIKyyunxrOAzwk2?=
 =?us-ascii?Q?LXoFFNFDQVJcTLCCcweLofgOz4+uVi39h/FIzTazk9nogm+Sf2qOZXUrD4/s?=
 =?us-ascii?Q?MHXQ0FrwXrpPZxl4tIomcalSUwArPlhqxpGikUgsJYPbL+YLjX9S6e0jbisF?=
 =?us-ascii?Q?wK17grcU9c9HQVU6JxMuP7wpWAkWuHIef7N2xtU2A2gZp8a2oZHNrkcW2iO0?=
 =?us-ascii?Q?tjlrrj4cFFTpX+UMm9iPvlSH0O2uW0l+Lg9Qbm03iiOFsFTfpTvEaHBlI3u/?=
 =?us-ascii?Q?8maBVZEvYRIXn335m9JEzgx+hyxGVC2eciicswgqVBr4w52+KUzwLG+a0G8k?=
 =?us-ascii?Q?rtT7xJdQM7ryJhhBeeGi564GOewKLsqKyecggOVY9kiHfpSgOh+hcvtlnE1Z?=
 =?us-ascii?Q?DL6bBGkAVbSx+5ll4Jr730VXbdFP2sYyXIFwbaqXN63q2As7+noq+b+vfkmi?=
 =?us-ascii?Q?i0Ct8I8f/2HsFsWW8iX8yabaH5aLcXAU826onxmxjtyaIBzefeGU5HmVMtpb?=
 =?us-ascii?Q?ez6fHS31McucxB7iG3g2lau3Wo+WlhCrbHpIoMFe1bkl8lj+VA/fjR5xvfgi?=
 =?us-ascii?Q?QQ0GzFwC4c7ljCKLIseHb/gYSU7WjdQonCWb5dtIk64/RJIbfQwAFd9bO3ye?=
 =?us-ascii?Q?1JtnH7aoiux9OqLhS2o1S7lK2o81aFLbLbrKAxh/9w1C4X4yL72vXlrBfRpE?=
 =?us-ascii?Q?gJSbRV/6OJSggPWmyP0C9ACv4i4K4UXJT0cQ8q0GH4dJY28QF3+BzWR8wjNu?=
 =?us-ascii?Q?rSJFu2++mCWAGAq2qcOZwlLlNkvRaX+svbdpdmvHbJbkCPs4TfvGEBOYHQYl?=
 =?us-ascii?Q?bTvjF+OxSqLpX3abat0ef8aePt/0uL1G+/jxQUtxGGTg3jNujxZ6MFRcelWL?=
 =?us-ascii?Q?qDFomQyVNqB5cpez3OCjeenRdNSlgzYuOFFPepzVIgpJkzawVh9kDJgIm9qg?=
 =?us-ascii?Q?E/HhS5aGyLF0FSTmDvhrOwlO0gzHIEtDwEJSwjAsoHh+i/DA7m3jYWC4MiS+?=
 =?us-ascii?Q?Ni+gqGBAcpjDaK/hN/Eg7GCw/+X8KjXZtItzJLE3BAkcqnAlm4JB/T+37RQO?=
 =?us-ascii?Q?ZhAFdK0OHFq0AzjwUaucvjEtEt0LN/mHY5HA41M9NTrsnBEzO4O4oUj/Xwdn?=
 =?us-ascii?Q?rcEn9VdFzAIJ6RhZuKhMPpzFWaxtvLVa20oEsJBD8oXAPIWt/KJbZlZN5erd?=
 =?us-ascii?Q?iEw6kLqnmX7LlIkhhKAW57lt1J8hIMoJJN4xuHlBYZ4pt+en1zs2D4E7Y0n4?=
 =?us-ascii?Q?R/U4eFeVXiqEbsjxCO0T3ltHgeRTXO9RBEvg2q+9O6eM5w153FkGFtetrVqj?=
 =?us-ascii?Q?HSAC8jORhUdOfef3SRXMaLA2++sbDLd75S3JziQvOu7ozASCobdEVJgFnwnF?=
 =?us-ascii?Q?iKwZ7NQbifmweh7rOfdMpHnB7QH2ieZ1CgP0A7RmpNbDuB0IfcD/bgZ6Sskr?=
 =?us-ascii?Q?fjl8TkLZt+54AH4jR3C0J55VCBazISFxi6HXLpo/i+ngQWJVUsMJHb4sd8cR?=
 =?us-ascii?Q?lvJoMAxGKojVczjG1YmrNrQSakA6ddO6LlL+VhOZtiG7CjtMEaza3b+gBZ5U?=
 =?us-ascii?Q?a7q7iDkoDGUUTr+3Mv6Bt1MEZTDmkAd/GweeLcTWrU6foY/9xxMwSaFTMZA4?=
 =?us-ascii?Q?tbiGhbpinw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc4fa0d-e9c9-4a4d-593d-08dede1ff9a8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 01:10:05.0500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPy4jyTbEwXn2Tgsl1iyPxmzPHIMSpyyCJfraPL/PsgkOJu/Ufcvwpu0qEACxFI6LpjmkPWK/TsuX9jveGTXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR03MB989146
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Using wide masks may modify unintended bits, which could break the system.

Updating the mask values to only modify intended bits set by the value to
fix this.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/dts/socfpga_soc64_u-boot.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
index 09506718d83..044af97c6ff 100644
--- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
@@ -143,19 +143,19 @@
 				reg = <0xffd12000 0x00000500>;
 				intel,offset-settings =
 					/* i_sys_mgr_core_emac0 */
-					<0x00000044 0x0a000000 0xffff0103>,
+					<0x00000044 0x0a000000 0x0a000000>,
 					/* i_sys_mgr_core_emac1 */
-					<0x00000048 0x0a000000 0xffff0103>,
+					<0x00000048 0x0a000000 0x0a000000>,
 					/* i_sys_mgr_core_emac2 */
-					<0x0000004c 0x0a000000 0xffff0103>,
+					<0x0000004c 0x0a000000 0x0a000000>,
 					/* i_sys_mgr_core_nand_l3master */
-					<0x00000034 0x00220000 0x007733ff>,
+					<0x00000034 0x00220000 0x00220000>,
 					/* i_sys_mgr_core_sdmmc_l3master */
-					<0x0000002c 0x00000020 0x03ff03ff>,
+					<0x0000002c 0x00000020 0x00000020>,
 					/* i_sys_mgr_core_usb0_l3master */
-					<0x00000038 0x00000200 0x03ff30ff>,
+					<0x00000038 0x00000200 0x00000200>,
 					/* i_sys_mgr_core_usb1_l3master */
-					<0x0000003c 0x00000200 0x03ff30ff>;
+					<0x0000003c 0x00000200 0x00000200>;
 				bootph-all;
 			};
 		};
-- 
2.43.7

