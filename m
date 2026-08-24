Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068E3C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DBDE80DC6;
	Mon, 24 Aug 2026 12:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D9fXOExz1-Y8; Mon, 24 Aug 2026 12:28:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787574528;
	bh=lOxPyCR0F+/+6E9u6sAizUM0vJ/9gnj9p9hLK8/iFnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QbAwPo+/p4yNuBoE19JL8ebBdVv/jc/q9AJ7aEkvnDhJ4Qfe6C7XvBbpetDjhBvs2
	 a7kbEhIXgXJoVvF+FmMy7CLSdV5q4DvfBBkYQO1Q7rnHb0J3SgqHKKLJeq6vgTwuFu
	 3EM7HntrdnK4WskzF5pztKorZ8nS45cIYwYwiz459CcctyYIEcbx/WZUNJxET6grWd
	 MYOUWnNOpvruleDson0OBAKBofGowtDY6Q0xxdmm/Xn93J5UDic+Aphi1+CYO+/REb
	 lAZB99r6jnHlUatqmXJLCK8yf6UVLZEtLrfhxeQOdo/KsC/8EX/lglmuuv8eVr1q1e
	 edloUbz+zZweQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD89380BCC;
	Mon, 24 Aug 2026 12:28:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA2E6279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC1174007B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cW-lH-NjOZpW for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:28:45 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=OixDr8ZW
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F30B140029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idlno26zl79yGmaSVkJe1Apt+aowV+IhfbK653mJyjShWUBFMynEt9bfBzcVm5ofpoBF3JGx9RPsXSBLuuvhetKOfaoWCk3Quq/3FAIZjjZCk4ZcAb2d45uZL8TrNTueGXxm0XZx1UpVkOcTIwQPETgGa34NdHnJe6613qr0/NaI+VwNX/Wksqg5ZeI0cMSWdBu07qy2DR5LLnaCrmY+GDBlVQ7pveZH1cMaAw9LbX8WHVMvQipa6HzEoUgwc/CEuySSPNMJtVzde+fXrQElq5NpmVgwYkoJBVxnCKvvj9jmeizbdCJyBh7/lsliYnb55zWvs9N0XiqYr8pzx7rerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOxPyCR0F+/+6E9u6sAizUM0vJ/9gnj9p9hLK8/iFnQ=;
 b=rsvZzvT9VF7jQoqAApUUB1elBSPh4UNoqq+w0Ic96XoWtS4MS3vJz1WDKtWyKHlzc92TkHcSjaRRlGDOA6LmdnFppCBuVZA+wFppHfjKxQIHLlJ9xYwTtYPoyMT1C8XinpqOZ9UMMRG3m0pa+oVOIUASCBOuleDqE6KakTnRNJ8HiX3BohelCXMQbFj8K1qRdp0O3ceu5D4+/MNV9XwfK0911/L+RRKI7mzaBpOFYqSULWcPcaX45SuHCZcmt7/1CN220oabrjsL9mA9AKejswGXBdaQAPnxfuJQWdvRefrGzVFDiRg0vrDh8azgoE6cGvbutTr1rZFmN+HS/mXptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOxPyCR0F+/+6E9u6sAizUM0vJ/9gnj9p9hLK8/iFnQ=;
 b=OixDr8ZWT39nzp1Yf0KqRCMA5frBL2LBPpyGi+uR4w+wBYywLthCFBw2xB3SsJ3Jy4h8Lj2sTrHTSoJ3xocRYR0RB57fAhi7yb1E9DzckG59VP9SVb20/pyIFUng1Pjmkh4tJpzjdwpX273vNxNajPvc6oObX5wS6fFNweEMbb9BkM1lFY21geLcqgQo5IeXIGPq7V/rnc5OdE2XPfNmZ75PYUhJlpeVopqT0NpWtIXDUzC0rx/OIF+WVsEiNEs6/vZ4Ax8iWaiGbDB//oaaoesubqKZUybrOpflV2bNnPjJWR2HWNjF49N8DQza/BRb4ZePbc8IWPUm1P3Gq/CSOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:28:42 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:28:42 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] configs: ls2088aqds_tfa: fix NOR flash write failure
Date: Mon, 24 Aug 2026 15:28:21 +0300
Message-Id: <20260824122825.95712-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824122825.95712-1-vladimir.oltean@nxp.com>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1313af-a46a-45a8-d4c0-08df01db3b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|6133799003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cO5hpLkbgxmugar0tD0c/fcmyr4Gj+8TbW44ti6+hQzhG1xb9RHJsweeDv1PzIGfdw3+M9gkdwge8O7es79t+F+GEunyNzeObTy7YUqDE785P+TEZvs/2N2fqbRWnMMuH6+BJHFbx0JT1U+FyoA/SqXYLQcV6f88P7/hUfSajpJbULevhP8L+M4Wq5/BznDNTSwzvnjeAYNsIEL13XN8u8gEhTpIWIQyscYbbWyYHqPX3OzoOi88+qooMAmpX8xGf00IivRswnJ/QEWf8wQ2k+3uZECtaC6sRQRiIi1rU0JkFh3Kyc4kofshpPq++D7eq2DbwFq8XxIN0HRveCP/lWhH+aYVMEeGD3WEWzLfQRtQKQ4wXzfkjuH5xPhg3UX8O7yPwlQoOy1JA4aTxMmMrmDf+1Ueb9+jq2f31wt+oqLM7y600LKPrqWogkzy635pDvRruPGeElI0xY5NbvyV2E1lvTm2Z70X0+w47R5FlPCyMJMJsPurRIsv1Z2DgH2g7Dw5MnPuQfeCqKLzfgoCe4FJey4JtZM9Cf1jhbIE6YHBksGbbtAs9Y8BvGl9QdLe6Bbu3amhBvYLDiJRMFndt7fj2CxDb9TWV1z31HnF8s9Ok7Mbpgbc/nOluv8f6cnY4AmfwF+XBoASV0FmZZqFzBY1CrNsATkVLF57F54D6ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxnHXX2IiNtiUEQwQe+9sTVqlJrRdd7+Mo28kFp0zsnwEYwhejuW5Am7uhmw?=
 =?us-ascii?Q?FDV5QcsFhzIiknO7soMBrMOb05pukS2rzxiZA59h+mEAan947Sfnygva4dys?=
 =?us-ascii?Q?aHH4VwBXHD5x9cnr/nO4xiOGR4bdhWzdxfKj7RMe6wZhv64/7WjGVqoBeaNJ?=
 =?us-ascii?Q?Wjp2lIXniYnBJ6zTG284u2doUGeF5OM/8DSRntsmebBNQ7Mk3H9ZT4HJ3IRu?=
 =?us-ascii?Q?Bjg7fxIlKM6kAovsEKPpxs4rq4ArP1PeMrzs7QC37wYXAXEljvEUqH35a4kB?=
 =?us-ascii?Q?SqRQwIFDV/gU4zkBNBMnyRjK5DNCwrVoQGZ2ZJI4jFId9gEgK1svPg9p16CM?=
 =?us-ascii?Q?DHmyzUwJaAmbUQU8LpMSpXK+suZ4zwe7G1Z5lOiic+rwv0tOJfYAmV+TBKn2?=
 =?us-ascii?Q?ce9xM8milY6ZiCnvXLnPRdd9uIjCgD/ZGuNFpLj6o3nug4KqyvttALdzinjO?=
 =?us-ascii?Q?vPZhbnI0O5mFQ+DIbYlgGKmJ84LILfveKX2p7ubWbmDkaZQTxweZ1+g/w7as?=
 =?us-ascii?Q?OPtI/dzLuOJPL/z4792Gipgzc8JEJh0h9LMnMHfxv/PKFMXxf3qwwrygwnqp?=
 =?us-ascii?Q?6CiFhYDBPtYB9R/rCLNPmuH8jRCaKc8MtsMC3OwU79R+otUKEPP4YUwGjkNF?=
 =?us-ascii?Q?TmozXx6szoEbinmhG8OP8ysW9pa3EorEnu7hXCBnLWGLkLknV6sY+z7P4Q6k?=
 =?us-ascii?Q?JC4Ern3k8HTcptcao1nsItQ0eAHzIeWdKH9iBCUmKQTDPExzobq4mvEBFpmD?=
 =?us-ascii?Q?rHRiJdVaGfZgW/kT8iwJGnZQ4bVUBjSRR+qZQxNRDiC9x73L9UUXjnOa4gHD?=
 =?us-ascii?Q?Emw5lI6Nnoq+ni+i5RAWVupWEU2gPdusWYoobC+Z4FpnnvFsAs1Wm0MERCgc?=
 =?us-ascii?Q?k9ajoantL7p+dNdCLJAXJC0phkkqiB6/n3f4unWGJJ2u/5ikC4zYKi50d4Xn?=
 =?us-ascii?Q?qVb/NBkHikAb94DgohALz09wEJsn+OutwxlE7q3jEuQ1qCDRsddGEdeNHLZe?=
 =?us-ascii?Q?GlE4rBAi94qMrqF5ehjUN0TFKNpoRUMY703iQl9M5RAIu7VT/aNox46K5DJm?=
 =?us-ascii?Q?E6OnwRzE5WgnmAW0mgoZRnI4RWAbJdTE61lhkuDKQ0vMXQqZi2Q9baVPFLCb?=
 =?us-ascii?Q?I4291vz1QL70mLc3/8G0opm6XDON9eiBpamwVnggC+l5ri6t6sS29qFCYhbU?=
 =?us-ascii?Q?2gwWpJBe4/2D5lySuGkrcKQCtqDZ5FkHrJWjRFmUtkkBBG1Oy7t2x5LKqR4a?=
 =?us-ascii?Q?Uz0auYyg1zAf/OmDiyMxFxTp4H61iy+19v9qYFG1J6UW8plbHUqG9gIFOoQd?=
 =?us-ascii?Q?QN/xqbKKJX9VPif+DbPnIjYTsHZZSO3oCXymiGGuunVtQS0Li0M/2OdJXf9t?=
 =?us-ascii?Q?rkZcJ/WHrbm9+JgDGBRUnyWiz4TW00MqYNj3iGXAsMwxJCYCgL956PVABUbX?=
 =?us-ascii?Q?osghIcHGTYjY95M9L61n414RDIEAfhzgVdsO4zJ++HVL1kbUGeIPZvQXlJKY?=
 =?us-ascii?Q?ISTikLc0JR+jpDx4fIiX5ApClUhbrumIoNtsYx2YFVEMRU8puwYNgDHwOoXd?=
 =?us-ascii?Q?CG0+Lmkqj7/JnMW3uKcGdl511mlaouDpQt2EIqNp1yEEhhHKno0mDFuyoj8g?=
 =?us-ascii?Q?JGZ51xZYfTNFnmsY2eeLTkNRTQg1iKzUPqw88ygL5wpe7Iz+1d1WFH3pmV3f?=
 =?us-ascii?Q?EVyO9PCxvdbYzOkrr4jrkyLU0Sl4/nUThu3HMyFOswXhqzpj8VZdzitE8iWp?=
 =?us-ascii?Q?sHKtR+oZBg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1313af-a46a-45a8-d4c0-08df01db3b8c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:28:41.9674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvD1Wv8KFDejVGVG2W3QtdD1hr4GukF6kQbA9TKmCCrsKqu+15pLNPn28G4rsLra6yU08BNpkjz1nU0gJg6WTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

saveenv fails on the LS2088A-QDS board with:

  Flash buffer write timeout at address 580500000 data fffffffffec6fec6

The NOR flash (Spansion S29GL01GT) is connected to the IFC as a 16-bit
device, as reflected by the CSPR_PORT_SIZE_16 setting in the board
configuration. However, CONFIG_SYS_FLASH_CFI_WIDTH is not set, so the
CFI probe loop starts at portwidth=1 (8-bit) and stops as soon as it
finds a valid CFI QRY signature, which it does at portwidth=1 because
the S29GL01GT supports x8 mode and the IFC byte-lane routing makes the
8-bit probe succeed first. As a result, flinfo reports "(8 x 8)" instead
of the correct "(16 x 16)".

With the wrong port width, all flash commands - unlock sequences, buffer
write, write confirm - are issued to incorrect byte addresses. The
AMD/Spansion chip rejects the malformed write command sequence by
toggling DQ6 indefinitely, which the cfi_flash driver reports as a
buffer write timeout.

Commit 53879b17382f ("cfi_flash: Fix detection of 8-bit bus flash
devices via address shift") introduced the address-shift probing logic
that causes the 8-bit probe to match before the correct 16-bit one.

An identical fix to this one was applied to the ls2088ardb platform in
commit ed56fda586fc ("config: ls2088ardb: Add config
CONFIG_SYS_FLASH_CFI_WIDTH"), but it was not realized that it should
apply to ls2088aqds as well.

Set CONFIG_SYS_FLASH_CFI_WIDTH_16BIT to force the CFI probe to start
at the correct 16-bit port width.

Fixes: 53879b17382f ("cfi_flash: Fix detection of 8-bit bus flash devices via address shift")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 configs/ls2088aqds_tfa_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_defconfig
index 79e1c0c70187..6b499c4dbfbc 100644
--- a/configs/ls2088aqds_tfa_defconfig
+++ b/configs/ls2088aqds_tfa_defconfig
@@ -83,6 +83,7 @@ CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_EMPTY_INFO=y
 CONFIG_SYS_FLASH_CFI=y
+CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
 CONFIG_SYS_FLASH_QUIET_TEST=y
 CONFIG_SYS_MAX_FLASH_SECT=1024
 CONFIG_SYS_MAX_FLASH_BANKS=2
-- 
2.34.1

