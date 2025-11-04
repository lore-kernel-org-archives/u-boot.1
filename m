Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51738CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF29D83946;
	Tue,  4 Nov 2025 19:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="R17P2Y8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA858003E; Tue,  4 Nov 2025 18:17:35 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9311832AD
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 18:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHbIUMzr0vnadlBjAVEbqy7HYLFThlEjIl96i26HmOBaFysdnEf4Ac0wbocOxjC6wAd71TXc92r1oKWCdSLDQiaSZArRF8O/t1es7LvAnJLVTAZOZuQXcmgeThC+Iqy4oQa1rzXa3rXKlT2I0uU1pxr/SxZiEwS9UP4GIy51RXprC3g1gq44tq1P75cClRZQNousk6OKx3eQBVO25TSp+LeU06sxf3XZ2TOpBLI+8er0eCogpp0RLDEywmCvzN36lT8U5g1xLmvwLmhv02AWcnj51BpMDyQCx/u0lT7G7pcyqfWmB/aiMaONOs95Or8vZ4uL9KV42kkamwT8IA1g/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k8Bqn2v2K/yk0DrxsM5R62I7d7SlY8ih9Q0AVN9Rio=;
 b=H5mQCkz3Fo7hRO2Hku5xxX6bhc7KOR2jAUtYAxVYf0Gqv25fsQbQoLpp3agB/eV+2gXsVNZoRBzhBkZzBzSSWmPLRafhF1m8dCK30isbpEhe3/DucdWODKLZB8UdHdXM31gcgz9fULU7y/KExUDIluHJjKrInRvrG16dFVMHHMbJ8ZAU7Ni1S9QYw74RpjhXr6a6XO+J3RBZgWfRhVRyETqiO/JWOVZ5luWiwKzAWCpwQD6+VwSBV+nWwlot6R/M5rATaLSu+DtPjZbPa/JP0GtBxUX1mhdwsZ65IRNu9d6rqp9g7q4rSNuU9PAQhqqHR13WxgUiGU8cUm4hUFuK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k8Bqn2v2K/yk0DrxsM5R62I7d7SlY8ih9Q0AVN9Rio=;
 b=R17P2Y8rrMgRI8gsWBOaBOBhBGm9ZbQBRrHc4XuwEOTaUG9ADX6CdOWS7phIQHUL2ZhAlAJ60RJx/P8auJNouUZ9ApoqcI8I3s/r968EMYnO9oxB5A7ZteJ7px1nFVOvgWIuJ2/4CnHnTz3aNWn5Lzoo+mPjxjFXpoRAZAcdtF/K8LrzbfdhbRTLeCWvyhJOkcAzKHV67g84u4qG45971kae3j5O0u1xy9x8ysccKfAmQGVRZDW4Hsc/6yyl5q5l4TcxZNGf88U/4l4gdy9cBFW64/NpdnHV2KZWFdqWUoXmpVIWqO+lLuzfYE5i/iDrtYhg0P/FLMgfkGns51kLsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS0PR03MB8245.namprd03.prod.outlook.com (2603:10b6:8:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:17:30 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 17:17:29 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, david regan <dregan@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] nand: denali: enable ONFI detection for SoCFPGA SoC64
Date: Wed,  5 Nov 2025 01:16:17 +0800
Message-ID: <20251104171617.13432-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::22) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS0PR03MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 282e47a7-8cb7-42ad-59a5-08de1bc60885
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ysoFz6gFxFBeQxIr+neg2X/lZ4aF592W1X6gPHo3v93jrZf2j2fvP7X1t4pC?=
 =?us-ascii?Q?a/uMLA4A9p4e26tjiEOJmuYEk50LJpywwHGMAdDQsivQsqDh2OQnrYPb0tGv?=
 =?us-ascii?Q?1ANvXo7yzWXAVQHCA7mfp04Pan+wA+mUsKX9bJEBkK8BQnQTyZ1evp4VB3tq?=
 =?us-ascii?Q?P3IjhcKhSyISyRn439V/Anr7uEtPDiWZD4okIInh3rEqqH5gHFlUwwuinnFc?=
 =?us-ascii?Q?p5VVDCGTeLXZ49gZjnVMFCLJzZpbV0E0NC4lG/0JbnhdZ6H9Hh0j9ml6Wacb?=
 =?us-ascii?Q?6Kh1yxAjUBMwYHZeYjW7mIoCqqgvGXXq+LraC2ayFu4T+AhBt4/N7/W6Rvzv?=
 =?us-ascii?Q?1VpcqXsPpZektbEjfdf0+Iou398EmlvBfEKpxqaX1b66gOt9l1MlcCDh5A9k?=
 =?us-ascii?Q?h40x7hZ5WL7n7Ka6uu/WrzfveKw/4P0aUUbiWW9nfIoQyRKDKrX7h5X91jWI?=
 =?us-ascii?Q?lohK1S1lspARjr29idI7hC8R5YnmaIsADhrU0k3DIN7iSPDLN+iEHbrKpGyv?=
 =?us-ascii?Q?us8iGow8BKVhY0+xfyiOj2eCsD5aFCUyPGar56WOJAIqXV3opkpeGRQUAoiL?=
 =?us-ascii?Q?JxboY9AongOGv17JD5xTo6KB+c44BKwIYhqFnabT+Cnik9Ve+dk9nxJAzcdp?=
 =?us-ascii?Q?kFD5eU+oj5FUDm2MYHG9JgYJLbGNoeoGSdvbRGYP7HkiapQ6eLPyCb4DzloH?=
 =?us-ascii?Q?mnjnO6gfKRot4pcl/NUFik616NqPAXCKyJOYxwZOW6APYs1n3ea9bxmhRpd9?=
 =?us-ascii?Q?cPVdmGcRDJpXg7j0FRVSF9WdnfelOd2u7NvQpFzD96llnZfJqfe7nZ/rhYW7?=
 =?us-ascii?Q?t9JjKlvxgzW3SIgcvSieHqGKJbZymUr0nebmdZjAs5WStrattduMyQPfWsPC?=
 =?us-ascii?Q?37l1EUzozFUwM2Ufr7eVsPmBCwtJxkYeg/P3ZNQMOt8sukMZ1HYRe4dlLZOI?=
 =?us-ascii?Q?VpTUHk2aO86YwdQU/kIb0g6O/+JwDVytBEjm/p3KbTviPqudCi6bWwLfA+dq?=
 =?us-ascii?Q?hv6r1hJKziYdHciS02+zFVXcfIJgCKuA+CuufNvtDsj7WlkUXDyjc5XI/PHS?=
 =?us-ascii?Q?D0Oe5ETKSLIAXwO5pr5urt0NaIHbzYDq8p2+ZvHgpq08vyvUy1RtKrwcChFW?=
 =?us-ascii?Q?NZ4taoi6RheZ2/x4neOgMHxrxdAD9TWRVd5zIr2xQQy6NBG2AKw2Pcj+W1IP?=
 =?us-ascii?Q?mo7M/t4tFJK9Nfa9EOOhJHRhhMJXXB1ttYK12LnPdPXT1Zbuli1x20V+dwBv?=
 =?us-ascii?Q?jf/mwbfZGrauo9tpT7DfH+calMNdefWf1QsBJ6CjkbBxiVP3kEr7/cKP8LnH?=
 =?us-ascii?Q?P8bkWLigMNjlqAldTAokE3JH89ZUWQsfoKVuEfaMdHkpouBy4jmF0Y4m5jBR?=
 =?us-ascii?Q?Iq91OfVh6YRrQAuc3xuJHsIajU5PKvVjMYprQundCzjTxi65Ny2AoFdH0w8t?=
 =?us-ascii?Q?T7H1gABSRar/ysfM70Vvx8nwdl5vTUow?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wj1aKi8WvKnI43mJCHVZssWrWKii1KQhwgR+g+2Ks3ISClLFcssOxEavQoHs?=
 =?us-ascii?Q?czUsBzMUYvr4lSXkYGfICYLavWsFVbO5R3CjYegq9gCnCk8QAiWd/GowoO+z?=
 =?us-ascii?Q?t7HczyK1kYlbK8Gbz8bMYM71X56oqkWlh8eCVd+U/hD3Q/nsJSrUYqOnxRMn?=
 =?us-ascii?Q?Ej/K9RdZIwdngGMtVlQjXyFxFdKP6Gu2Rm9sCDFIFv0R/9IVZaVQt+KbB4id?=
 =?us-ascii?Q?+84IbYVMVbVuzZqf9A2SN/D4aeeIrZc03bTUKluzWko9X3lX9wwrFGhLtYCO?=
 =?us-ascii?Q?nK4jJisASCS/bjgC8qlRR0QMcGz66vk7+PK9VcBoqV3hIIEZdUM4eGIU1MPb?=
 =?us-ascii?Q?PWuYV+bRWs6QLjMAW4iBKZZ7oGgTZQN/zE8OxtSOsOOAJCMB5mpfcE4GYjT9?=
 =?us-ascii?Q?/CE4Nwxq0VBIi0uuKOKH5aQWhc/YHOuPWSlhe52ChJVtYW2bmTn1ePH7AJyh?=
 =?us-ascii?Q?QQQLodHZC0j8MHC+1Qtp7OsZh+N74tq7CiLYA0OiDCcQVAYnvIC/mDqOJ1dt?=
 =?us-ascii?Q?ct8IrBLa1d1JpNqsxkm3vLCrDEEEXVSaUr6uFXD38ssFafinYf8oEXBEa/wg?=
 =?us-ascii?Q?dKVaUEuihIQ1POa+HTPJm2xUt0j6nf7peGqxPB7K6cAlM5fiTc+VDbA580i0?=
 =?us-ascii?Q?eN0zxc3BibKFsSQvdHwwB9bbKErbLUpjprtPa9xkjJbXc7+aZZXXZbbBSixn?=
 =?us-ascii?Q?NEyju5GDl7o3RGoSYgsus8GBLHTEOqThXkNhVHMxxgE3Q2DW1UYb0SaX08Ao?=
 =?us-ascii?Q?mQ0kHmMSHu841D1nWjFnoJX6VEeKFixx/lGomgfILwhfjUg/Ma0TkrXlHSLE?=
 =?us-ascii?Q?+3JG49haeERg44lNp8KdruLEOPi3AOKLsj/QKBz+2+Rf5YSnf6Md9ljLUOCl?=
 =?us-ascii?Q?xbG5yh//lAVNQVGKzpq/rj5FkYfrow0J9GBRYm1eVHBK7VPzuNXS0Ai9DUgR?=
 =?us-ascii?Q?U3xf7zcR4JwET5Uo9eZlPD/x0SfqjYCRcwOBWKBfExqsnHzrsVc4uA9U2bgT?=
 =?us-ascii?Q?6SgWa7DpmLEwryZZSXnynLzhh2phjnEXIGD0iRvWgfm5FW5mC6yL3BtWZj2Y?=
 =?us-ascii?Q?dqLCbBkSCJySkJYDN5NVqugJN/tWmfUY5yLex5XI6nod2/anUVzWksnHSdEP?=
 =?us-ascii?Q?G7tPnKYxenEY3huwDhJMgr3dkZlXS36sxKJBwhUye+qyoCVGF1qeBzkbTynq?=
 =?us-ascii?Q?8fUSH9ZawkzAN4+L6H48YZSBPYR6Uc9N/uXZhG2qhr7g5zHQ0fnkwlCAIOde?=
 =?us-ascii?Q?ESscM76Y+DE8yrC0GkyNPKAMap0LzFXP/T02rMSs/cC/3JzpDjltqn9NR9yC?=
 =?us-ascii?Q?PZHR45/M4A+R5A96flrAEleynPxqwpFo2aWXx9JCLiVH61zZrS1ai38aZgPl?=
 =?us-ascii?Q?svRsne9xYg12uTm2l37wjbbTXf8hpVkdLyM7KmLJm4HENhru0QMt5RtedHnl?=
 =?us-ascii?Q?CZBaUCCTfByXoQzEk+pXBRm30JsvZhSnZrh+PRyx5KKWC3IwICdRc7jcFuqh?=
 =?us-ascii?Q?a4RZAw7sWu75b+QY44pD5b58QZeNow46+KXF9ilnxVdAq6WKrfB3xeNEfljY?=
 =?us-ascii?Q?cHX3CMqf8KqSPQXH/r0t6lL6f9iIsqLSrJXCuIU0+FaehJrA1/0v0fwC3c39?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282e47a7-8cb7-42ad-59a5-08de1bc60885
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:17:29.8359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAcc+kfyE5VEqB0svWEbwxvFpBeK5Id+oy6kyWevfXbYcJBoIK4pS4jfjkAGatdQ5kZbiekLwWdAzUDnD3lo1DNfYdXcG2mtevocWCyn8xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8245
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:32:11 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable ONFI parameter page detection for SoCFPGA SoC64 devices by
selecting SYS_NAND_ONFI_DETECTION in the NAND_DENALI Kconfig entry.

This allows SoCFPGA SoC64 platforms using the Denali NAND controller
to automatically detect NAND parameters via the ONFI interface instead
of relying on hardcoded configuration values.

The selection is limited to TARGET_SOCFPGA_SOC64 to avoid affecting
non-SoC64 platforms that use legacy NAND handling.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 754b99bf3eb..a658defe794 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -213,6 +213,7 @@ config NAND_CADENCE
 config NAND_DENALI
 	bool
 	select SYS_NAND_SELF_INIT
+	select SYS_NAND_ONFI_DETECTION if TARGET_SOCFPGA_SOC64
 	imply CMD_NAND
 
 config NAND_DENALI_DT
-- 
2.43.7

