Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBABC87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 00:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E67283BB5;
	Mon,  4 Aug 2025 02:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vXrHto/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688BB83CEE; Mon,  4 Aug 2025 02:47:38 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6AF83B5A
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 02:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsuUIO3vJJQkpV+69GKbdY5MfczqPT4111m6DKn0lob40wDzog59gnsdZFebVtn6vegZC31LI6rhI/Sq1N4PG1wv1QkwbBpmPbnt6fq4U2h1Td6nJtv3SLT/MULHQMMmCniURq8OAzl3tRaoQgcU5VtB9dwLHPTLxeKbfB+b0SI+i4ecv6BlU61n0UMeBKvh/ecI+MxkZS2RkcMGyKqP0O6JfG7JpY1/7uRx45yrCJcNYSvGv3F9YKGPpR3AuyqbgyBlfgqFtSm3g5VnhWcmAPyOmzXTFIi1+Swo8JugoUQORCvYPechwsnJUpV6yVjhuD6O7QqOPostl54UaTNZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PagCVTj3kPe/NdTWalWFQadfAznkT/amKZU0AuKOvOI=;
 b=VnzEPDxLwAg/bWVyk6g2vW96gLLlmeHO5Ggp2juPWjqu/3fhmJR6M+p32FcSoLxS1nVgiKL9zNaj/Lwz4OigxN+BLrdqtrju24PueqHAJBaSh7VJj8nd5hyoYioEmmiEouyCxdLcWartofosO7R8pkXc5+oxd28+2LwHjTUNqle1D3Oc9QOuf/AH0oeTj4NEKzVp7Ef1bR4O6heZM7SJhEz8y5Eqyb5Xh1jIFWBlHc1AbDquBLXlDGW6mT8kY4ijVRKteC15LklZ24jkooGLS31MXEXYMj7xLTv9BZ4FajTcsFI2aDafYpwNLi4jsxet669awq0A8Cp5Lcq4ZcLrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PagCVTj3kPe/NdTWalWFQadfAznkT/amKZU0AuKOvOI=;
 b=vXrHto/ZvzR9ktECAO0deHuo4jn0XP/7vG/DYEYfi2hCpZ1oSLHvx9Y7rCbBqpZLYCZX8XhjKem2BToAtxR6T7Nk1hWpS9vxw/R4EgeUhO/JvnQqllF8caC3QrzAiXZa6ZKmCQwwupsyb+NLw6gqZFGIKTkaLjtiQFgmis/7o2wgqZt+zHI0H+4Dr8+IcHF6+K/ge7MG4vnEHqqruyzACzZlScETH8hFSqhayCmUsai33iGYSuIccU09mEPERdnrN8oiEtANzmiAhglQEn2DckfYa0FOE4syjTFexsH2OmICMwsDLXGzAg5zGHExc6UW7sen1c/3cj1pxRpnxq3cjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BLAPR03MB5556.namprd03.prod.outlook.com (2603:10b6:208:297::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 00:47:31 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 00:47:30 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address via
 clocks phandle
Date: Sun,  3 Aug 2025 17:47:10 -0700
Message-Id: <20250804004710.10222-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BLAPR03MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dbfae0-cf58-48d2-e35d-08ddd2f07df1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v9h3wQXTxSKNg/maVt2xTO/9gqz4AjVXmjr0XEISTSk8Piz4ORoW7KkGDxCW?=
 =?us-ascii?Q?VvRHDPBh4yqKAGkfVTldaZfZpUuwa7qae899kZe5Lc4H8lT5HgtunqNzNIY0?=
 =?us-ascii?Q?4e///rMmnFrGvmaoWHr3Cg6sYxtV7ME5CC8fNdIxeA7OfyhlhkgGuwXLxeCE?=
 =?us-ascii?Q?5PVk43698aU0lTBmyoO3rCO8lCTgV9mc25+FEorrlaBjauO2Sdcr0Vz0kSfZ?=
 =?us-ascii?Q?nwakNfVlzJ62dtr6K6M9W3fMyL3v8M7O5yOYZ+F0li6FLxpGuguYWzqi4q9c?=
 =?us-ascii?Q?n3k61qI45aG8qqxj/T/T7LE6mGzJTJzotIGsUXMq/f5Fl7sTwo4IswbQZD4Y?=
 =?us-ascii?Q?qRYz0T/n7ZJOpuz3+/m3yP81eipJRS6sni8HTDezUlQFpYwk+SgOl9t4Ojxt?=
 =?us-ascii?Q?pXbo9gKKUdcrTSxUOqVCzV0xOv/ZyGediB+YfllGgOjHhDBE6Xa+vCAKt3qv?=
 =?us-ascii?Q?Lu63GuYV9yhOLV5jCQ/7ND0aokVua29vvZKmEKzuA3QTf7Bg+ahAqQlzlfew?=
 =?us-ascii?Q?gPSMR8ZihMZWLeQuI/K52vzIAkbIQdpva260MAGy2/5mbKTrOSUfxHz5kE7O?=
 =?us-ascii?Q?zqxv2AoYWS7S3oY9yLUf3Xln5Bwys23IXvWqk7r/zQs/CsHxlcxZIsjEBEe8?=
 =?us-ascii?Q?jiULVclSNV4cs7S6Cp1+CKZ/BzLeW0dDcnlW2e5gNPmup21cCDF2oddcnY8c?=
 =?us-ascii?Q?qmz984cPVVKru0duq3u0sB6kOnezige8GPfIxjMiBmUxvVSNbZZAv3BF4JUI?=
 =?us-ascii?Q?IDccsL9O6hjAObf+pP31ukW/VG/rQELNmb5BQuU6GQ9TEMmSNlUF027OVNZs?=
 =?us-ascii?Q?J+wbjV847knx4HuejMWn+VaPQMpnFvgZlMFx9AV2pD4pxu09U/Lao0RmMSK4?=
 =?us-ascii?Q?RDZPHLPFJVryKHh78MHWPAjVifIHsGXcLscm1ud1L7rzukp/paaGJYXkwf0j?=
 =?us-ascii?Q?+Z64zlbq18pS+dfWmPvDy6231mrV/jvw1/LRD4WQFNV9Ndn2Siv5WFpcPEJg?=
 =?us-ascii?Q?AB4HZsmZhB9msKdJ/qfLJt8suniaIdkbzmJujxv8CLr7+fktBqjmcME/qVzj?=
 =?us-ascii?Q?FTg2QePJEAU/fG1kYSyFAe9zWGjnrvvMCF+dqP5X4KOUSFu5o2PNOBEPp1Vp?=
 =?us-ascii?Q?6SdoJsQUP4ooDn05PqfKs0KYAgeT9xkIlwSrEkhpMp9Po93tdqZ3DlUj+oyE?=
 =?us-ascii?Q?2FD/6oV+UtzyOu17wM57aA8LiOzoVCAK9uxEUnK4faNOGHAqOa/QjSM94nQo?=
 =?us-ascii?Q?OMzrHPnbGCrLyxivAukNRFLmesk5ua1i75FGxk3bRlWDlHDmyzNyXKkXdx0b?=
 =?us-ascii?Q?LD2TAoasP7YaH5PjI5LvDbdjccZx2jPQP/t/Hsl1rpYUHYK4BKFemEFSdUXl?=
 =?us-ascii?Q?SLHLNLXU0HWKHqm/DWZstRdAknNYs8G380+IDPlSg5CSVgtdlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7hnVuls1q8+DGazoX2eg0e1FtjdBELdmzzvRz6GFO1stOONXH6Qs2z22Lpmw?=
 =?us-ascii?Q?YFP71BYDF9G0+DU65dF2g2Z9c72X3tFOwy82XMZbmthDv40hW7kQG66JYLA8?=
 =?us-ascii?Q?k2j2qZt/Ao94wN3+sM5gJMA7wPrX7jWWftVjoJmlxXEdlQGfDuqdlkk8cxSs?=
 =?us-ascii?Q?GKRQtEKGo7I00Xssgnw7hxYpgxd87OIClBd5ly1uXSruLuEriXir5oD4oVy3?=
 =?us-ascii?Q?nHRiMnIxM1X6dJSbbKQ6MmTztbeYuKOA5BViUwXcNqQ7CIt0g/Lwvj9OoeJI?=
 =?us-ascii?Q?M9BydZ6ztYr9QoUeF8J70qegB+qTAaKpdExlXhUC4nHRCKugJt8vWLdE2+cR?=
 =?us-ascii?Q?P3Cr9GF3qUFk9VuWb0vZPHBqSucaUJP3avn+GGt65PxwtBR57cn0EtFoZ2R8?=
 =?us-ascii?Q?gtKDBSWZy2NgycWqn8m98SBm9c1lDXt8lGZAWcDHCk1KkQxh+VAZaQFzBGRb?=
 =?us-ascii?Q?Kjx6uLMFpgTomsyBNapHxmxrYL+TMy7cftSinbHSVXtK0r2pJMG/j8ouzyHo?=
 =?us-ascii?Q?GwPYwtqmpwPQFPwvfnNcCZluXd6XVYGJo3M2vryiC0/eBdFZz5r3jGz1x6SJ?=
 =?us-ascii?Q?JmCZiC+An7ANo2aoHFDUSK/lPsEKMLrEhnSz7RzhCJdKtFPk5/HNGe8QlJWU?=
 =?us-ascii?Q?QNC2EHkP8VjqjCRViJFhXj+7oKVSc+8MilN8KDsjVn/mCwfbXHebga0jp/s+?=
 =?us-ascii?Q?FJTs3/BFOBuyKIhPYRvfLoEBz3n8IRTymSbf2iciRUH0YYes+UlzryKGTZEZ?=
 =?us-ascii?Q?6X6eWWtqRFSpoaUHU0QNr8NLVmJJHMpIIN/y14adViFyCsUMGIqfExlmd4tM?=
 =?us-ascii?Q?AaNyUWzQukjvEIDK+yIkC4hCj53S5h2TPGYur3TX7ic78jwlMoh4gAFNh82C?=
 =?us-ascii?Q?EEQ+7nxSE4uLQqiOFktq+fA1xT5+4YDUxrl8HAUq7sJEkh9nw34ESjd0e18K?=
 =?us-ascii?Q?fvP4uISvCIoTGc7jxvCnYdQaMGwyf/tZPGs5xwqNVy4ggNCPDVUnU0hFTUKd?=
 =?us-ascii?Q?hw4z8ZavA2Ts/xLYn8mHw9YHU+WmKs8yRXP5aZDrEtBWt968Vd/kTLT3Nv5+?=
 =?us-ascii?Q?7v48Lt2C6CMwBsBSPeUQPoB4PwJSbj7+2WBgASuTGMRfLJRjMjZmjRGgz5rC?=
 =?us-ascii?Q?PPmCpw3zjXcFC5Wi60H2S++c+SB3NcNuq2YYN/gc8+7IJxM+Ovbn+OpzFPxv?=
 =?us-ascii?Q?gayRfHP7qNKsEZYc2BT/daP0oRN2lLPrCxVWN4P6TothbY6rmQiL/uHXLtki?=
 =?us-ascii?Q?wj/GWB4BUdPAdFBgS9vtvNRxT1OCtj5ZQvcwdUxEE6hK553Lf5AJxgUZY/ai?=
 =?us-ascii?Q?r+GDCI/C/v7eq5+xLHMVGrtb5/mlyOGdA4kjKxYEOsjef/UBJHl4GgzW+ZSs?=
 =?us-ascii?Q?zLdVuBbejLikQUGtZ7vtsXNdxYFBk4FUW5UMNbS4NAC058/kSlb29gPWjy+/?=
 =?us-ascii?Q?aSsAE5E5XLmOwHLepva5QgdE2jlLDVb38MKpK8WTNl19zdZeB+snEs8LVzB4?=
 =?us-ascii?Q?tiuZ7kph/Qo1RKysmaKriqUsxBu1ght/+Gl0tOC1rHEehAs2HzX8Y19cmAO7?=
 =?us-ascii?Q?4MJHo+Pcc8lM0zaeV1QRrPBGN4qd0uDVDVLkSMySXzOKTwtEaxRFBKTNyqC9?=
 =?us-ascii?Q?yjyKV3FhR5rNJw48CChv5gk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dbfae0-cf58-48d2-e35d-08ddd2f07df1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 00:47:30.5591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R+P+MuVxKwfuSWuWGMABL66oVImc1/nvi7gUNJyS4h1YZxcp+mvScDCPRioJYMbdqI/iVG2iaggaNvUgMbUdULBoUY47z9URIyk6XG+dks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5556
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

Improve the current clock manager base address retrieval by probing the
clocks phandle under the mmc node in the device tree instead of probing
the clock manager node name in the device tree.

This will help to make the driver more scalable for more families as we
no longer need to rely on the exact node name in the device tree to probe
the clock manager driver for its base address.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/mmc/socfpga_dw_mmc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index 3b86bc9b18c..ff1dd0055f8 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -54,17 +54,28 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 	u32 sdmmc_mask = ((priv->smplsel & 0x7) << SYSMGR_SDMMC_SMPLSEL_SHIFT) |
 			 ((priv->drvsel & 0x7) << SYSMGR_SDMMC_DRVSEL_SHIFT);
 
-	/* Get clock manager base address */
+	struct udevice *mmc_dev = host->mmc->dev;
+	struct ofnode_phandle_args clkmgr_args;
 	struct udevice *clkmgr_dev;
-	int ret = uclass_get_device_by_name(UCLASS_CLK, "clock-controller@ffd10000", &clkmgr_dev);
+	fdt_addr_t clkmgr_base;
+	int ret;
 
+	/*
+	 * Get the clkmgr device from the first phandle in the "clocks" property.
+	 */
+	ret = dev_read_phandle_with_args(mmc_dev, "clocks", "#clock-cells", 0, 0, &clkmgr_args);
 	if (ret) {
-		printf("Failed to get clkmgr device: %d\n", ret);
+		printf("Failed to parse clocks property: %d\n", ret);
 		return ret;
 	}
 
-	fdt_addr_t clkmgr_base = dev_read_addr(clkmgr_dev);
+	ret = uclass_get_device_by_ofnode(UCLASS_CLK, clkmgr_args.node, &clkmgr_dev);
+	if (ret) {
+		printf("Failed to get clkmgr device: %d\n", ret);
+		return ret;
+	}
 
+	clkmgr_base = dev_read_addr(clkmgr_dev);
 	if (clkmgr_base == FDT_ADDR_T_NONE) {
 		printf("Failed to read base address from clkmgr DT node\n");
 		return -EINVAL;
-- 
2.35.3

