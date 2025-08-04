Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FC2C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40A583E18;
	Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DdDuNQlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA85C83DCB; Mon,  4 Aug 2025 03:25:24 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE2D83DAE
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhz2sH4VtNGEGbvrFdChnHBERmlLB2+DFx6f/lDCFeN1EXcSJQX2k4feELBl51ooP6Y129+q1qkiFGZghvi8Z1CHoMMEJwprsGpVwO90tcX2cx4oKGKztF5a/24Kyedw+U18KEgrUxsrqsVa9uQxcV4X8FAhP/YQLrkLVnESErAb4BFFQyXOeN4pnGV9s72G1h97/mr7/WkI3UOhDEZYT810ZEgBkbPxh3pL83y1mFKYXi1qQUY3sSeJI2EiYQMl/13/KJAl02F1xi0LW72vrkF5GN+B8J54+HCSZLByRBRS/DcRUzm296lYeTn9aqNZ4Ofrm9O10NhZps5BOWL4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvV6/biKXVuHiwS0ejNzi8M+9L8yEXnANso+TwVX28Y=;
 b=X+XbGUXnCWs26Azb3pA4Pj/fdGL4dDd+6t4ZvUQy/3esmyLiEPx9lu/9OiKT0ddtl5/eRtL8HR1RJKyZn3TsTlYJK1pxIwq0+vg+r1QJLijtLT/VJGeqrV6eZRqv9Yit+ZIjkeJCuPQzMJwVz61G6xJS54PZ78v/Ve+iiwp3YOVMf9Rzx73QcO0/x697cwepKgLrBoGMJKuGa3dux5+nIXITQssxH4JMbX6hSBnwYa3AQYkCScKkEicTN+76PC6CSAWlFZT2Z8Fc7lDU4bc56iB9wpD3iUwAqXHkE4U7dCRA5SjCnvHp8ukrJS57u7VBR+T36z2SmlPHwp5bAa5jog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvV6/biKXVuHiwS0ejNzi8M+9L8yEXnANso+TwVX28Y=;
 b=DdDuNQlKrT3oIaAC67gbeUgET7D3WZ5niyUwiQn1Hp8R7XHHjhGRH9sOypuFk8xdFHJwnQS/wTMST3uEINzF2fRVh9hGYG5XY6h0ajHtf578aJ3UzA++vjn6yOlHmoSLFQnH4SHCuBqbB0KKncwL4mblbPAc3+ojtN8Ej0yu/cq26yPLwzkJ7vG273FEg3dIj7qKOp5gRUrA6NRZIczoVNppGJz0iBif6ZsYIJg/Pttn9OhwxuGe03D2Q+0fhOyFVKx1HtEncpAqVSK5+nIx07J4ubZZ7oWcuYQvYUoQbu146NPWe2WnXZPc22W4hXl7H2N2KkWYZL9ehLblA99FQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:17 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:17 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 05/34] arm: socfpga: Update Agilex SPL data save and
 restore implementation
Date: Sun,  3 Aug 2025 18:24:32 -0700
Message-Id: <20250804012501.21811-6-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e14727-4809-4954-5cf4-08ddd2f5c4ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jg9YC9NpXAmnKZ40fsTWIYClPfb6nUKTXN7SDIVwKyVjlaZhzJxnkElaB33n?=
 =?us-ascii?Q?ewJi7+SxKSe2fHc2j07aLftOW15VTPuA8qC0N+dtY9VSizDYSd3yaNCbrqr/?=
 =?us-ascii?Q?VPURcWrViktLLfDwFDj0udKn/rwEXIEvYZOSPY26fUYJC/s1kZK52WwZVLZa?=
 =?us-ascii?Q?czYnwpzq1HbnqkuAOlWEKK0OPqGlXYULwiOdPn4TRJf9hrxIsENn0QAP+tF1?=
 =?us-ascii?Q?/c+VT/Wy+GsDQn53zscJjwNM4J1P9LB7WVHuuSvqjdM7AgKMIDcv9VODHnQI?=
 =?us-ascii?Q?YYP4rpB318RJ93706eVj/GFJg2+BBLX7ORultyj3VdItPnz741m3V6iONt9F?=
 =?us-ascii?Q?Nr8nYyiwuNn3NwzhhY2+LMp5FqHjlO9E8P+CsomL3T+T/q2rV3DW2tAiNSsG?=
 =?us-ascii?Q?iQWEDzpWNNpaTE9L7YVoyMfZ4vmq+IKnKTkgmhsgfG9i0oJUOUsx5kZQN0NG?=
 =?us-ascii?Q?2ADM6vU3LZbWupy+5CMr/WY1Iv5vQB0DzjzOU6xmVlAp8h/pmfFHt1Pqkurx?=
 =?us-ascii?Q?+dy5+wwQZssh6e103YMQMXD5dv4l9tFZHgKkAtKcw8e4f6gntLIGKh3EdsFW?=
 =?us-ascii?Q?nJ4eIktWgn0FeL7qVdUWdsdOoE8SgTOuQ9MevtzniEA6mp7wQXJgMJAVqgRP?=
 =?us-ascii?Q?wbgvT2USctXhmG7YAjQ9WfDTPi/4s4b+A4pTkOA64EYlc8u9Bup0V0/06n6X?=
 =?us-ascii?Q?Vz26C6H5TAZKoAW4wtJG3aQHJGMb84t8uwUi8DaNrHr+9aQK0CMHzlhITug5?=
 =?us-ascii?Q?wCn5bjHoF3KgRz81l1dbLpCNv+3uOeIEMzuS0cK2e/ZbETpV3I4gPg59k3zE?=
 =?us-ascii?Q?GhJBW4uYnT4k18G976PJ+K0z/ZgjNuva8Pl29Mno69ksQda2D0uCJiQEgT95?=
 =?us-ascii?Q?l4DwZOPm6nJkGrRpETtbK0Lo5wtRuAzbAQn/mDnLhkdJZd/GV7pzQJ3IEQ4K?=
 =?us-ascii?Q?dq1pVlQVoSCRDHbh4q2nTANaKedIKb9jRMUMPAjPTAFSOt8LhU71vLR/QvVA?=
 =?us-ascii?Q?ErWlkQno0YAS05eM4TF12i7hW5qo5bs4TWacQTd9yC4sSjqMlGT0IN7bGF7Q?=
 =?us-ascii?Q?bXF7ddMRXbBn2nUN8OxbtQLdxxpZheJp3LQhS3Rvdn0AKWMG/AVvNk0TeY67?=
 =?us-ascii?Q?XyPLWOG7AD4i8zpFCo2Vi8LEETiXdroWwGfQqv1HOc/wTIJ2bLyHkOCTeSv8?=
 =?us-ascii?Q?BsmybKHfF1lhdwmHkL6VMaN8EIS8hKBhI28Gin04MzJY4f8dAKW+fo/byfqu?=
 =?us-ascii?Q?LkQ7DY+Z7uOe0MEETwtW2DvCiO4WrYgRORBLjkNDTHjtX1KK7CcsXe6JjdaA?=
 =?us-ascii?Q?8q3QceW0H8vW76xfklUHF6AgdsqxBec9ie8acZdYHymOIY8FXHPxhtrPFa13?=
 =?us-ascii?Q?uht7N00=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jvaZROR6no9ThtT3gmCbSbVJrITlOPkZX5JTkdz+2iQ3lL7a6ojVGtf4YCFN?=
 =?us-ascii?Q?qIG/f7o0YvFbMsuXz4ZlWuz0P8fuxz6YKDiQFIGdfpPZ/+XIkqGby/Ayc43B?=
 =?us-ascii?Q?FY1sp7mVBC/Fl2Agrie3sONXfT/2zbWxnv6TLySMsOVcODIu//56Eq0MJkgb?=
 =?us-ascii?Q?iRHwQVBGH0tw/ezaPayXZQITRMn58cRfNW3ZXUXj+bjAIO7c1X82rga4EXHx?=
 =?us-ascii?Q?9cgMy1HR5Q5lH8VX8HpXXD0JXizB5knw46NLnk7BaoPonHImw2IhnCCQSU29?=
 =?us-ascii?Q?lj216ZgUxBXpozztxeE87nAgrfcCakhnohuH+JiPhNwCwiLAOm9PHUOXDM/x?=
 =?us-ascii?Q?/emuCWQFnZkBFvqiBmCytFyQen7lmRmb5Er+2gap9M8Djgnw3QwLQNSE+xti?=
 =?us-ascii?Q?j2g3pS+nJ8QdeZBhhaPcj8hMkyns4w8MWAenkLo1fkZ5890lG16u3Tklb7Zd?=
 =?us-ascii?Q?D3wPe5UIrsQYNuS7xyXZKBFBxWIjeMDDkvFR+XlLWDhzYMCV7zSzSGFhized?=
 =?us-ascii?Q?0D+2uBIfhGehgBW9Q1QRqWwQujttyNnW2iVzXE/VFrAuuk5QoMq77Z3JwsNS?=
 =?us-ascii?Q?gQ0JUkIdKl+5ljak/qjzuHwsx6+08AlLaekYz5m0SSWE1cXM5x5fF+sZM0LK?=
 =?us-ascii?Q?jlp85umqv4JWGR7y2qv06GukKTIG0mK6arn5iDokv8mOaaeyVicQwUxMs/I8?=
 =?us-ascii?Q?o4neDOX3tGurGE3TqiEVAAfey4ZVSanh2crWznSf1rN4mRBfev6Cx/O1vUn2?=
 =?us-ascii?Q?MnXE3dwg7BbKtNbehF+b5dbHp7TBevrvhvPuuLW09ZF5SFcRDQBkNw8Je8g4?=
 =?us-ascii?Q?ovNLWMvsGvDLgvzF8MXZglPxcJjn1u8H8LCvEIoHXI7RcUmLgZ6kVVJuVznT?=
 =?us-ascii?Q?qxSTCAF1PckyIarPSoYDntxeGEM4zLSBWWYBuR/Mo0E5oUE2hc2mF9pvTqzU?=
 =?us-ascii?Q?SBkmWhHcUdNaH3ZYJOP+TJNXrghxqGQZMLKb/dcwFhPDIsnnNsugvuxaBf/7?=
 =?us-ascii?Q?19oqlSC1YHEsAG8312SNMFDp38fuN4SJzMcC9zVCRm4fKVZkBeZIc3LgjI54?=
 =?us-ascii?Q?prfJ49PtVdr1DZAQ9ML8lAPjcFYbk+8TiqiaAVTWMGv1Ngrq2K1J60LiHxCd?=
 =?us-ascii?Q?p4FYBF5WpvfY+VxmDnQYJD5g4j5YUFiG+Nq9D53t+6OkWCNhvYYE2vykNjUE?=
 =?us-ascii?Q?j6O+11mdwPnoBnWIX205gIGPwA1vZDMNfQHxa96+CoOZJq+KY55D/059yMtt?=
 =?us-ascii?Q?PFYM1MWREycdEmj6+Gr9TbMX26Km1GGsx+4AdQGY/QrwAJzxmxuzOFgNmTQL?=
 =?us-ascii?Q?OzQgkCKFsUD7vTfexuNuHPCAeeu4XTJoRzq9jZw2g0J4uUkhkumq1gfku8hU?=
 =?us-ascii?Q?ltwac4+zKc/GLppiZa74jebr2eGycn0Zy7vpUQrSNu/7NsAyNiUB9QQJrSIi?=
 =?us-ascii?Q?UbZ4uifGML4JGwIIqThBD3AA1JIG7mR46zpgY0CV/RG68n6JhCMA2oVvhujB?=
 =?us-ascii?Q?HXAY0CGL0jngzTgHPG9O4UmCn3Fxie4vUf1bVMqsuECgg7gLn//whpjzUsIn?=
 =?us-ascii?Q?Y4ignrtNKjVUoVtEqSaeWi0norO6e7A2s40eITwHetJ3tczwVwOk3ThxAVsu?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e14727-4809-4954-5cf4-08ddd2f5c4ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:17.1339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dshTL6px6yI0dEWDzMEqnOU+dd2DwwlrPxqVmkUTc/DXdxUcATZFQ/SY+ugX32EBM76uFSz3LyCI5EblECrb1q/5Y0d5i795JVTB6DId8aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

Enable backup for data section to support warm reset in Agilex SPL as
no SPL image would be reloaded in warm reset.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/spl_agilex.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index faba0433838..322a7ae6fc8 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
@@ -23,11 +24,28 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+u32 reset_flag(void)
+{
+	/* Check rstmgr.stat for warm reset status */
+	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
+
+	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
+	u32 warm_reset_mask = RSTMGR_L4WD_MPU_WARMRESET_MASK;
+
+	if (status & warm_reset_mask)
+		return 0;
+
+	return 1;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
 	struct udevice *dev;
 
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		spl_save_restore_data();
+
 	ret = spl_early_init();
 	if (ret)
 		hang();
-- 
2.35.3

