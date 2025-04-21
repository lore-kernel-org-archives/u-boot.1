Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A30C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9EF82063;
	Mon, 21 Apr 2025 18:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YJhWunxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B6381F0D; Mon, 21 Apr 2025 07:15:11 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51CDD81DE3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 07:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vurfl45KnjojS84JRurxFWw+D9mJs9MonwL8GQfvBh31RVn3IU/B9IOpWoS6xuU/YZ/pq2sqTFuRLQmwZPlc1pSjXDXZc0ymtQ2mL9fjNBD1mF/l6LHKeXGGK0v7saQAbSBjvGGOemcnpO7sNrUSLBytv5abT+td92pqDxJ3Q1wOf9xM/bXAIPGEPBUTIs68nu8cx/iH12ItETUznPGfgUT9xZ7OZ95XI2I9Bb/7gnDW/OH9puhkXkehiCce2OPXa0LOsbq2UNkUdqzx+pYJdBXJ3P4C452YJIu1Pa82SDZ7XlXYnUCblK3XdlA5Z1w0TJ2fai5yymgwLC2bdYAB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdYdG2/rri/Rb6Jw5Ew0YyYpWr6ZaGN6CwFFHpyG6c4=;
 b=yglX8vUm2FK0y/487ME1x6K7ap1TrUUhbGfE1dZ5TLSgZHxMyCqReH96t0Ki2zg6w4V1H9r19JyQaKghDe5Hguvu0ER3kdmveukjIXX5i0lijLrM16z3c72GDxrl+XXOXDeLfsncti1n53sDjw66zJF7lj2DSuPC/Rlc+1t9wymq2bB/k/NcWd8xrk1ljAiZhw8jwGp+T6AoxgwWS01QTQ6DidsSp2cYiO9Ve0se8G9F4Ro6FyNClEXIjCMkAZxu0UrojDbYjDa5Kn7a/htNE15hEz91ok9fIo+pc2X7qnVlRd+5ub6PHh7Mlca5V93N+VYsZq+B8YIAk4PuFDvL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdYdG2/rri/Rb6Jw5Ew0YyYpWr6ZaGN6CwFFHpyG6c4=;
 b=YJhWunxrvV35udiVAShnAbNeYVWPAKz9qbET+HiRSjEEm0SktqHdn0fYwfl4d5QjoSZwlZJY1+VbLSudofOjPkvkln7CjJJy7l7tUXvcYOP5s2RoUOFyWX0rmeAaSjbhzzLaChLXGzrfF3uFYWrhg3uZQ7appxAX/9b8FOyIAJ3L476VlpPGk6iWdPet4Umh56xzM892Nu+e2H+ztN4L9udF4VgBj89nouYV9QHz+jlaXiyE0PN4g30GhRD6GhwhzRmCPcKU7z7saVgp81WkjrthDVl+Ss1Ht2j78VGMQKHHALPmG08QeVfG+d64Djq3ATfJs1+OYSCGrE+Lv903Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5621.namprd03.prod.outlook.com (2603:10b6:5:2c8::21)
 by SA1PR03MB7099.namprd03.prod.outlook.com (2603:10b6:806:330::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Mon, 21 Apr
 2025 05:15:07 +0000
Received: from DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b]) by DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b%5]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 05:15:07 +0000
From: tingting.meng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Danish <danish.ahmad.rosdi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v1 5/5] ddr: altera: iossm: Enhance debug information for ECC
 errors
Date: Sun, 20 Apr 2025 22:14:55 -0700
Message-Id: <20250421051455.31365-1-tingting.meng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To DS7PR03MB5621.namprd03.prod.outlook.com
 (2603:10b6:5:2c8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5621:EE_|SA1PR03MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 458d3c31-a6b7-4502-52f8-08dd80937b01
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iLxHNjIf65j2F0fry31Oa30brff6xGewDQSNkYyX7rjemD1/wemQp5519k/M?=
 =?us-ascii?Q?oYHffUGhRYHx3cQ3J3qeB3juEosGxukfTncx56S2krRwPPrNsqIfp4ACOH+H?=
 =?us-ascii?Q?7Xiaz4PU9WKi/SoTUQQBuXFdJ2mokiUkHYqxVECC0HWgV+OH9fEYGcIKxtjn?=
 =?us-ascii?Q?ESSncwU3bWLqwmiWQNK155mNFTZtplSjNlvY7aryHtseG9CnFox1e2viinus?=
 =?us-ascii?Q?Bbg2gR4IoJBByPETmBWyn3hQCB7xA1DcLWHCANBf0zv5HFtHX7Hpj3bJq2E5?=
 =?us-ascii?Q?utvEY5qLk7BUWfEVq/ovj+UAmOv5yZlt4fHU/dXWX2GQwbVaNABVCZTHcZR2?=
 =?us-ascii?Q?s2mpoWqxAX3aJkQh6KmrCH0PEC8y2+AQV21rMrHbmkaVTN0dqO3UN4npDeSD?=
 =?us-ascii?Q?HNoGsyS4qPcCmTLR/pb6o4XP+7mORw0drEw3Wemy0kImnoVqROKa9jsAwk2F?=
 =?us-ascii?Q?1fw1hinr1Qg3rhIRtnrAU8StepiRR00AFNo5G+SwORuxB0uVp0ln4IaS609L?=
 =?us-ascii?Q?925CykSjz9tB8L/Eaw5eCyeIm8RvNI7HbCQUvSlpNhpMTTPzUGQDIgNz6x4S?=
 =?us-ascii?Q?9Sqg+RsLV+s34uxpQF+OqIdCnAS8YdZ/bk82V7RHPTP3wEXz38aNonTb0lKb?=
 =?us-ascii?Q?r6P/mgDRapz1Dnt77Q0PXslnrfHcNBb68xLbeuaRP0K3d6ybuLJm6ekb+1A4?=
 =?us-ascii?Q?BIIZ/XUIzXkjOy6PQFvKYo5VpR6yGnGNp/xIf/qXAup2A6U/JOKToyhPTcNs?=
 =?us-ascii?Q?nALBHrcNcD5uGbbaKUXxrJms2E50J+sSZCeDsf8ORvYxLU2SH0wbCXSwNKbn?=
 =?us-ascii?Q?Ziml/Kx35EMbZyb00aXNMYGYtxDBGDoQyR93kFIH5Pn7HL6TTil2J2plun64?=
 =?us-ascii?Q?bp2iY2PwczWCfGhv9XgYlaoOTP1LOSNztlqPizomNHB3UFNQVwwA7ILt+sXE?=
 =?us-ascii?Q?wFYSJ08t9HLv6jB8WgDh+e5UWBL1+sWzR+8Wy1IU3ErJObIDNgYseoubLBVd?=
 =?us-ascii?Q?JXI5UL9LEFh6oUn7Zw6IlxST0dPeo2DXuHtz+MarbcJ4Y9eaQHrM121EjIBe?=
 =?us-ascii?Q?V71Q4skXC0LtW6GHIDcNKXhl6dxjGC3J8MmSGXld/LbyBs/q0ukHMPiNRWGt?=
 =?us-ascii?Q?xqiB+3J+nU7US8anXq+7+HYmhgLpBgzmF1upwAuhe2YDrJBBM53uv2gJNZJ9?=
 =?us-ascii?Q?qc89b+ErFqZ1x8dVsrLc2U9bL6d694hWpDE7b3OnAzVAu0u0Fmit6cnRUP//?=
 =?us-ascii?Q?ypmNtdZH1SFd8axWSNN6gHwaBXZMBtHjpEQQeCY1TCRcwyksru8QDpMGavIY?=
 =?us-ascii?Q?TKufCtgUAsZeVxSzoawH7tavn7+Rptu30SdUyjlmbivFHe5AGru0RT88YX47?=
 =?us-ascii?Q?Z5IFDSKPph+vu5VAjr8m6mQnAlGUYgH0n3WiRmiUHpfMLkxv4CYG7L4KF/2i?=
 =?us-ascii?Q?tegwBht1d1g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5621.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?70xANqxVGTbNTfEAvoUQXtpncR4IZwPJvvIZNnqUsrA8igGaQOUfgSn+Fkmj?=
 =?us-ascii?Q?u8rr7jo8ikjsuKkYtYQFPDge7w1tCP7V2dcdm2vN2onLz4HPARDulC4ITT6f?=
 =?us-ascii?Q?gKcBqtyM0C8WvEqDrIPVTZ6L6vusZsvxXfaonpr8vjaMuqcUDrXpVLsB/YrG?=
 =?us-ascii?Q?fxnTCDTRfcyZrUzkexhOcoggr95QFhOVyatRZrKuwU45MBgEvPxiTey2vNiy?=
 =?us-ascii?Q?mNWtTJijcfTPQtQbfK2E0NG6e+PigeN+0l7bGQnDoc94PejXkoH1vYE4WQH7?=
 =?us-ascii?Q?70wH5aDAnGwRQkH2gjfKdAptajVVjCxr6HOzUNs8i1lfodL5YJJ3Pj1xgkji?=
 =?us-ascii?Q?/k/uA5SzcdBXCix7J7EBjkB7NbvrIocZkGY7SuEtljGxTwB2TkiFxUhFT3sN?=
 =?us-ascii?Q?2bv6VCP9KuQxssjAKHsJCwgzIK5tVhcBjBshJgMA1axYs3CpUqZgfsX9PMJ0?=
 =?us-ascii?Q?GW0olRFyRVAXMZf/g35gX1WXDDFIW+rgBFxwVvxR1B1bwdtbgWgHKJ5vDlsY?=
 =?us-ascii?Q?h0rz4geDvzjPFRZ8ZPHkjdwL23eSwiaGtOR0bWRmJSsxbKfmv7iwXkENk3zN?=
 =?us-ascii?Q?1AlYM9+VTxlX4U1/+WzPuaglxIwDEjwiVQ974TCS1gnbCZXjFI4PkflKJB1b?=
 =?us-ascii?Q?vuOf/ibmDDtwmOJz6aKRTRe5P4liu5x/n7QliYCJx4ZW44Vi9CcNY3MHGMTi?=
 =?us-ascii?Q?2EZgpRjDfwPEOBZi0gFB2+qDzW6y+7PFZcwnIYEGTIX9xnd+YLxGDbxwICMq?=
 =?us-ascii?Q?P+IzZ8ZPiYHTU38lJyI/hwcNQ6GVbhvOBDs+6v36O4RjH5LpMVh5iTTXXq0E?=
 =?us-ascii?Q?0FshFpCs2GBdO6q9e01pLDtJJ1QHB1pLvnoOjG7rwABcNX4lyT1rMm/b4MDS?=
 =?us-ascii?Q?xPiUWaSqI66/idc8C9AbCfmTrGKuIHj8DuZ04oa0SizurCZrUHM4iiTzd0sH?=
 =?us-ascii?Q?q8F4/G+difpUImHMKrZDZJlxeT9P1MOJZYwIy3ie4mQctkHrW7tk9KvpKI9V?=
 =?us-ascii?Q?/ISfGa2bmMYGKLCVM20nP+/mpaLC6EmPDXUjthASpAAXdMNsHrpw4xSsVKal?=
 =?us-ascii?Q?WLjZcFBFioSCgTyZE8ROzrbEQrGT21XsEfppvcMYonEmEqQrA3uTRHqOrNBw?=
 =?us-ascii?Q?2ciYXo3tAsJP8EyMg8Cfwfv4xsGei61VRRHLIIkZm/grQ29SttF6q0flKbZ1?=
 =?us-ascii?Q?WnPg8UOTPfKYcS1bjnYP5TEpLuQf+FpRfyEnHFs6+m1tRHAFI/5E6OduI5UL?=
 =?us-ascii?Q?3pofUyjSHDlJ7rKMgVNwn1Tj/T6hE7auld6kYh/pwppDqn4zdYiN7dEtHpXr?=
 =?us-ascii?Q?tPTIh5LzDOMZEmZlv0vBJeD7bu40mdyiwxHfo9EBeb1j4eW7OEgL9deusT7y?=
 =?us-ascii?Q?D/pJqbsOts0kZDBpnbW024eIy0P75TXvm4KBMmEIcaBxZIMH3ANZxzClyquX?=
 =?us-ascii?Q?ypFyfsyeT0Nk2ZOTOf35M9jQL0A3Rw7kx1t+dShkX+fFZNawEh+v3UCH3TXm?=
 =?us-ascii?Q?YQLhHP+Nt+ALvx/n9xlDdZfmLarODhMrT9mVDv6kL4mRf/eZ9GFmvbEpSXrA?=
 =?us-ascii?Q?42SscF/EvLFT3ViuuW4wbDIcps7AE/uIDuLDSxujdwdieo3dqkT546C21vBP?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458d3c31-a6b7-4502-52f8-08dd80937b01
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5621.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 05:15:07.0128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRLEAKNkIMHJYkg9JfyIh180vb0Dxn/6I7EpOa8lTKujTVOo/nc4R/KfBCXJ96heVKraoLAYxWp2c32v6ZV8DNgUaPsWby7vZ+Tk5XvCjZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7099
X-Mailman-Approved-At: Mon, 21 Apr 2025 18:51:44 +0200
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

From: Tingting Meng <tingting.meng@altera.com>

ECC debug information was enhanced to improve the readability of error
messages.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 drivers/ddr/altera/iossm_mailbox.c | 64 ++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/ddr/altera/iossm_mailbox.c b/drivers/ddr/altera/iossm_mailbox.c
index 26602858777..fc09dde3f9e 100644
--- a/drivers/ddr/altera/iossm_mailbox.c
+++ b/drivers/ddr/altera/iossm_mailbox.c
@@ -98,6 +98,7 @@
 
 /* offset info of ECC_ERR_STATUS */
 #define ECC_ERR_COUNTER_MASK		GENMASK(15, 0)
+#define ECC_ERR_OVERFLOW_MASK		GENMASK(31, 16)
 
 /* offset info of ECC_ERR_DATA */
 #define ECC_ERR_IP_TYPE_MASK		GENMASK(24, 22)
@@ -106,6 +107,8 @@
 #define ECC_ERR_TYPE_MASK		GENMASK(9, 6)
 #define ECC_ERR_ADDR_UPPER_MASK		GENMASK(5, 0)
 #define ECC_ERR_ADDR_LOWER_MASK		GENMASK(31, 0)
+#define ECC_FULL_ADDR_UPPER_MASK	GENMASK(63, 32)
+#define ECC_FULL_ADDR_LOWER_MASK	GENMASK(31, 0)
 
 #define MAX_ECC_ERR_INFO_COUNT 16
 
@@ -167,6 +170,24 @@ struct ecc_err_info {
 	u32 addr_lower;
 };
 
+struct ecc_overflow_error_desc {
+	int bit;
+	const char *msg;
+};
+
+static const struct ecc_overflow_error_desc ecc_overflow_errors[] = {
+	{ 0,  " - Single-bit error\n" },
+	{ 1,  " - Multiple single-bit errors\n" },
+	{ 2,  " - Double-bit error\n" },
+	{ 3,  " - Multiple double-bit errors\n" },
+	{ 8,  " - Single-bit error during ECC scrubbing\n" },
+	{ 9,  " - Write link ECC single-bit error (LPDDR5 only)\n" },
+	{ 10, " - Write link ECC double-bit error (LPDDR5 only)\n" },
+	{ 11, " - Read link ECC single-bit error (LPDDR5 only)\n" },
+	{ 12, " - Read link ECC double-bit error (LPDDR5 only)\n" },
+	{ 13, " - RMW read link ECC double-bit error (LPDDR5 only)\n" },
+};
+
 static int is_ddr_csr_clkgen_locked(u8 io96b_pll)
 {
 	int ret = 0;
@@ -628,16 +649,28 @@ bool ecc_interrupt_status(struct io96b_info *io96b_ctrl)
 {
 	int i, j;
 	u32 ecc_err_status;
-	u16 ecc_err_counter;
+	u16 ecc_err_counter, ecc_overflow_status;
 	bool ecc_error_flag = false;
 
 	/* Get ECC double-bit error status */
 	for (i = 0; i < io96b_ctrl->num_instance; i++) {
 		ecc_err_status = readl(io96b_ctrl->io96b[i].io96b_csr_addr +
 					IOSSM_ECC_ERR_STATUS_OFFSET);
+
 		ecc_err_counter = FIELD_GET(ECC_ERR_COUNTER_MASK, ecc_err_status);
-		debug("%s: ECC error number detected on IO96B_%d: %d\n",
-		      __func__, i, ecc_err_counter);
+		log_err("%s: ECC error number detected on IO96B_%d: %d\n",
+			__func__, i, ecc_err_counter);
+
+		ecc_overflow_status = FIELD_GET(ECC_ERR_OVERFLOW_MASK, ecc_err_status);
+		if (ecc_overflow_status != 0) {
+			log_err("ECC Error Overflow Flags:\n");
+
+			for (int i = 0; i < ARRAY_SIZE(ecc_overflow_errors); i++) {
+				if (ecc_overflow_status & BIT(ecc_overflow_errors[i].bit)) {
+					log_err("%s", ecc_overflow_errors[i].msg);
+				}
+			}
+		}
 
 		if (ecc_err_counter != 0) {
 			phys_addr_t address;
@@ -661,15 +694,20 @@ bool ecc_interrupt_status(struct io96b_info *io96b_ctrl)
 								ecc_err_data);
 				err_info.addr_lower = readl(address + sizeof(u32));
 
-				debug("%s: ECC double-bit error detected on IO96B_%d:\n",
-				      __func__, i);
-				debug("- error info address :0x%llx\n", address);
-				debug("- error ip type: %d\n", err_info.ip_type);
-				debug("- error instance id: %d\n", err_info.instance_id);
-				debug("- error source id: %d\n", err_info.source_id);
-				debug("- error type: %d\n", err_info.err_type);
-				debug("- error address upper: 0x%x\n", err_info.addr_upper);
-				debug("- error address lower: 0x%x\n", err_info.addr_lower);
+				log_err(" %s: DDR ECC Error Detected on IO96B_%d number:%d\n",
+					__func__, i, j);
+				log_err(" - error info address :0x%llx\n", address);
+				log_err(" - error ip type: %d\n", err_info.ip_type);
+				log_err(" - error instance id: %d\n", err_info.instance_id);
+				log_err(" - error source id: %d\n", err_info.source_id);
+				log_err(" - error type: %s\n",
+					is_double_bit_error(err_info.err_type) ?
+					"Double-bit error" : "Single-bit error");
+				log_err(" - error address: 0x%016llx\n",
+					(u64)FIELD_PREP(ECC_FULL_ADDR_UPPER_MASK,
+							err_info.addr_upper) |
+					FIELD_PREP(ECC_FULL_ADDR_LOWER_MASK,
+						   err_info.addr_lower));
 
 				if (is_double_bit_error(err_info.err_type)) {
 					if (!ecc_error_flag)
@@ -682,7 +720,7 @@ bool ecc_interrupt_status(struct io96b_info *io96b_ctrl)
 	}
 
 	if (ecc_error_flag)
-		printf("\n%s: ECC double-bit error detected!\n", __func__);
+		log_err("\n%s: ECC double-bit error detected!\n", __func__);
 
 	return ecc_error_flag;
 }
-- 
2.25.1

