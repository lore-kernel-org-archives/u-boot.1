Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0D8CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E592B846B1;
	Mon,  8 Jun 2026 15:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pPlTAXQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D868405A; Mon,  8 Jun 2026 11:46:31 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DEEF807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNIGvaSj9sBpbDXbyInU7WgmcvoHlaGqTlXNov4j135N6AjthG82jSJRClKBpcsz62cd5CHTeq57MC5unTlcQzhgdx/Di4mlFo+GKis5qst3ug/ryOE8/hUxVwf5vG37OsQW6U1KMd9KpCAQkoxNBzEdO0vr07IsJyk6MCT5qzKB2gsIqdLkXnypz2QjgzASzY6DDzEUPnbSN9vUgn/5JBB8c0f7GDry0ZxlOa3LCeUmdLcvpAibPwAnjPlrbrCGz5ZlUPK0ni8uo8GP/ZOP9jL/fs13RoaKgVUr0KBs3ru5wP2jLvGrwQAniZAReSVM/p10PSoXsS/lMdCIBUC71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlGdH61m2NXVJH4SDGsNbspsM0/L40hkgGjbk+kxgjE=;
 b=Is2IGada1ZZW4j8GBCj/A55VzJhu0SjUzAeTi8j/RihQ1ic09I6+7E05jEGODUWm3y6ppAGPWmZ6kibeuf3ADGbVawACJuydMvhbTbr0mcD+ls/d/3N/dAtQCTvUksn+Rf+w5wEscBW5jjA0Xgxv/w9HXBzOFj/qD1C0L++yVRrWj95VnA6QGr3lwQ80iM1K8lZ5O1Mwy/cgzhZALxco5jOFFqFy02kWBahpyl8mmPENwafHkS1N1vl382whqdIjLkWXjCzg2f8m0YLROxzx71vgfm3nbrt3W/rVy87Ricm003Fvk+ScyWJ/U+AnYlFJwx8PT1O49V9AysqLyaHzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlGdH61m2NXVJH4SDGsNbspsM0/L40hkgGjbk+kxgjE=;
 b=pPlTAXQaOpe87MgkMdQ48pcOfHQtVMH0n6OAb8J4bYuN0K7/VfQzeZQfx5ZEXHvTTUydHiFOu+1PMdvdeq/XDtNUv812m23ruT7mDk+TlJr7YUttTh7eUN+B2FNePF9vdhfGv62mZauQQhhdYxkgD8xfWBaf5WlQGfa9vKeg5vH0LFF2VUnBry7uGCTcPgGGbhhLvbs0mo3ENjWfT1IgYda++CZ8V4L8LT7zguTxS0RSFApwmgyA5wICI99UlU34HFhyR0G1DXixmNsO7Q3vypfw7WGMSsHInX0Z3lbXLU/ahSITUH4bQefKYj43ZZOG0UOdVer+9tXhnO/oMcETtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CO1PR03MB5937.namprd03.prod.outlook.com (2603:10b6:303:6e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 09:46:25 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 09:46:25 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Alexander Dahl <ada@thorsis.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Danish Ahmad Rosdi <danish.ahmad.rosdi@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v5] drivers: fpga: Use FPGA_INTEL_SDM_MAILBOX conditional
 instead of Agilex/Stratix10
Date: Mon,  8 Jun 2026 17:45:47 +0800
Message-ID: <20260608094547.3026-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428053030.19532-1-chen.huei.lok@altera.com>
References: <20260428053030.19532-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|CO1PR03MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a08c3f-f19d-4d11-0516-08dec542cdfc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PQU/+V2j7ew6QfBHboICsn2sEibe7nqAP46NgvzBDJG5J8LDHC+n4q/jNO0g49dhvI6Syz6yTec3HTTiz1nomApZHitETNH3KLl0qn6ctic1Aa+uROlOpqyGQiPHCr2EbR874Jel8BmgtL7JD1tywjTnUxzYjvgxEC00tiop65y40zC5z7rUMcJJw05z2iO0o84COn32t+ACyRevdNnXOLCGvuMqKwBaztacjgoTFpwGcdvIGA2p96a/IrIxJ56WO/6hlaG9MHG7WU6+D2/16JkC2Za4Hp6OKngm1ooaK8qySTs3BtYqCE/JyfskdcQvDRiGsD1kB9S3A0PkybL5pMyKxGa96xkCcbIRzhOMBK4PgDZVNAMW9ip1YJTEOO1nXfGsdXHut5G+o1yBWoU32bkOdj5pBXqDP0VLidFAh2qxwWnHB3OlNgqi/LPea+Z8J4m8aIxmPS26xWHIi6nmMwVXD8nvY76Nv8BXZvATtqcjpCM2TJxPlCU7D2p9E7N6KDMcp0mWn9GQ0FoaxFohXwqFrut3OuE10YlMZ5NdLVr//7sGG9bF27UdJGPYZPYV3m45OTe8v5nOh3XncTlBtufxii+Qg3+bfmlBrcvcUgbwPacKpnuPrThltVZNsCLdOdlj4x8EG8tbgUIKbC+OamAbVmtP7+p2dsAXS+0H2gxajXdhZebGZrnZzOyS1l95ICIiaiivlBYNhJDSki4H4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?auho/pc9DFF3qM7OQcpi+shnAagxoDxkirUPCRbr4zLADO91dd/thszmr2ID?=
 =?us-ascii?Q?LzwHvMAjhHx3K16Knb3C7n9eU9lBEitBbCi7e8iDZA276hvM0s9jUBoYttO7?=
 =?us-ascii?Q?8w1GipU8hk/tEN1E6tIt8ykoBbPGkT1T0xFsS0ebjQPFMWuZxTiBhHZEBcPi?=
 =?us-ascii?Q?VTH8etrqIJftXPEv1eqy7uOwyfge64hWcFHbG0WcIm98+1+LoaVv8y8TpGDi?=
 =?us-ascii?Q?LZNNUs4TrHfC9I9t+OYNWK9SdcXKbogs8+l2tmgv9rfHD2wOQX9DDiy7h0p0?=
 =?us-ascii?Q?gT9zzmvKuIhbdP5J+uQL8WIuCKDcKpojj5pHNSAdBb/RwR7mXl9EgYYVLVob?=
 =?us-ascii?Q?PP4+E47k7CC5PxvO6XIocOFsmH56BQOxsJkr8Y1kUkiSJR2H3LFS2xO1Um49?=
 =?us-ascii?Q?Mudxf3z7vPmrx6asJ/NKomFxrYfeCbx4Kut084hi6yKuV6LPwruiL/YVS3B4?=
 =?us-ascii?Q?YY6umu52uHRPiHIihSwY88HfB/7E81hm5wiEFJAYHkJhigBEhyEEb0jEg2Wi?=
 =?us-ascii?Q?FflELV9vxKggWM+jhZ4VdxalN9zQZEVRW70xfUrp0P//dAZuvm0nWLCaLzAP?=
 =?us-ascii?Q?ImniaC2VyOSetrlGCaGwLfdYOFBmDbLI5ySrS3E1+P+qAHAOMhj+VUbNlLYv?=
 =?us-ascii?Q?AEYAMA5IV2ksN5PpFk51TtrUyWbhSnDcOYZWtduTC+J3tjy7QH3La6KI45+m?=
 =?us-ascii?Q?sCWUQmoHnRTmKgcVTjAGrMfbYZEMW5xhsEgvirXgP42q4Zh3iRgLsRZtgbFZ?=
 =?us-ascii?Q?CqBzy+9lJyL6wBsLf8+S6gGodimEiOuP96lUf23yeDtD007nX6YrSXi6xlys?=
 =?us-ascii?Q?Kn3EKTu875CGCDs+9nttIOmrqFypmUhTQd+WUzvb9+7tL0qJQ1r4aJtCLvjQ?=
 =?us-ascii?Q?sO0gbPfv7/hrKULePtRhU8RHRLHxOUN9FUAdF0RrxFtvo06rAijkKtdtlppe?=
 =?us-ascii?Q?kKVX2HyTXsexBWPJdSix/hG1igzviNLP6Lo92MpVfywRQTMeQLs3TFdJdFDG?=
 =?us-ascii?Q?KwDmjWbkWem8PtfiW+pRMgK7JCL9wmIpDPeldQTANz6KU3Rz4roygxB0d266?=
 =?us-ascii?Q?ltHtJP4ohlULZ1kzqziMnlBF20fbC1igDISDEqT6zWglCC094bhXlxxQaWaA?=
 =?us-ascii?Q?xp1Bhc7n6jUby4+8xEfTp+xac1w/BdfA8kDIGivTXXXZxhEAoNbnAaSpTiWz?=
 =?us-ascii?Q?Ii4/FAv8reE0JVKa8Mz6yMEveG+aGjfc8h4XOV2VHj3LLi6APy9JwFIVKMy7?=
 =?us-ascii?Q?AwM2J7rm5YpKDnK7Ar2vDl4sr7j2YruJ42hP9fhVZaVvGlOqnvbcS60eLaak?=
 =?us-ascii?Q?aiQ37v1r8MyIeMxR5pccoXz3vbJK/GsDAncnxQI3jGMouQzZqVbbWWHqZpfD?=
 =?us-ascii?Q?XJLkacjJrG5FkHhiNFE6G4o7Z07oaCF1+mvvthP2c3G1DTou7dq6hszTogxH?=
 =?us-ascii?Q?LixH08uch46nm2eUAmEHIJzUzKJ+2xtrJwUne906uygmhVDcHBBAqtbDCrlN?=
 =?us-ascii?Q?tgd7ne3QrhbpdHJWLTInKUBxVAxMP1aeKlet5mVYDejZNSQ0IDgaWIsZENBU?=
 =?us-ascii?Q?w7tV1C6gkOdBtEYOR1WduXEbv9mBsjFrzHb0FKjQhRIw2GreYMYVhZoG079D?=
 =?us-ascii?Q?VMaakLriBgRWvgeDPx8QiXC5cQuQPGgI5rCe8FJbpXqrp5zAdJvD+xuvwOzU?=
 =?us-ascii?Q?1g79quoNiRM/7SHi3aFg5aeo79i3qsuH0oflp9+r20MK4GAuNoPzJsKfXKLM?=
 =?us-ascii?Q?RAPf14vs95l4weZRjPugY6cOLtmxrys=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a08c3f-f19d-4d11-0516-08dec542cdfc
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 09:46:25.3720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvCDJn0iPCNxEKUHhs5/6c7xmxN1ufQu311U50zzMAvp/9R+uMe3jBsWEvnwjmOb1QDmjLuKg/6h4uNLEZ40sRJyfpYt7z2uOPrORQTMAQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5937
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:05:23 +0200
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

From: Danish Ahmad Rosdi <danish.ahmad.rosdi@altera.com>

Replace the conditional compilation checks for
CONFIG_ARCH_SOCFPGA_AGILEX and CONFIG_ARCH_SOCFPGA_STRATIX10 with
CONFIG_FPGA_INTEL_SDM_MAILBOX.

Signed-off-by: Danish Ahmad Rosdi <danish.ahmad.rosdi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
v4->v5:
--------
Fix Signed-off-by to use real full name.

v3->v4:
--------
Replace conditional check with CONFIG_FPGA_INTEL_SDM_MAILBOX.

History:
--------
https://patchwork.ozlabs.org/project/uboot/patch/20260428053030.19532-1-chen.huei.lok@altera.com/

 drivers/fpga/altera.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 822183c5785..xxxxxxx 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -12,8 +12,7 @@
 /*
  *  Altera FPGA support
  */
-#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_FPGA_INTEL_SDM_MAILBOX)
 #include <asm/arch/misc.h>
 #endif
 #include <errno.h>
@@ -48,8 +47,7 @@ static const struct altera_fpga {
 #endif
 };
 
-#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_FPGA_INTEL_SDM_MAILBOX)
 int fpga_is_partial_data(int devnum, size_t img_len)
 {
 	/*
--
2.43.7
