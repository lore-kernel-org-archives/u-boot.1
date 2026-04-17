Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A943AF436AD
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 14:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C66984307;
	Fri, 17 Apr 2026 16:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="O2xuK+VL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D89684310; Fri, 17 Apr 2026 16:13:25 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3FD842D2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 16:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIiRB12XwTOtb7205aCGJlu/SFkgBSp5bE61N+/yNSdl+2/lrK3GQFpBhbrXIA2FY5MiGywWxCorVxhJjoUd6qYfEFt5WryA7qH/pR1DCbpRcTvtFwtW7913uwj3ev5rQc4oWeMmiS/KbMC9hJXXTvAgBrXYIoVr4yBltPI6ztgjtq4c9X8stqKf/mG2AC0DgY3uWkB+0AgLx1OM1tNzuk4Es5ppmgFnvEIz3uOFrTcVDZy5glCfJccK7zv1KZuOBGYzQsqgHxEvzjpnoydQUhXDIPVrX5gXzA3dPwcgdc/eISHh+Dy1D+lFJ/8dT62vxzMpInbtQtQKGiYJTo3C4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsFP6k2rHTKoJpXrQD4XHN0IjDNljpxvlGoaB2m4HrI=;
 b=aQ+9RAMb0e1/1leCW6bEusFzBjyIMorTRVIGdygf5AYWRWbWtSInu2cZwnLfSbQRHwZxOJEYPWKxeYeRwV/gLNPD1uZga4wof//VtPt9KXuew7b/l0RPs+uzIgopU/YI+ImtsaEVvb1LoWbdxelOLn3bY+XStAkDqtawokFFxfRf3yFCQHo8z8NYTQbH/fl8hVvOWjRUOHLtgJh36kdunioXaYSQGQNH4RXhsCwUqLe8uGS+ir40ybKKW9+fHN/EkbQ1dt0XuaoB5qAvv95L/ScKO2rqiORJEgbr0WOOeB7UNDusaQOmkef2TcbexYnRxYQCQxRDYdvjocvRpkmd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsFP6k2rHTKoJpXrQD4XHN0IjDNljpxvlGoaB2m4HrI=;
 b=O2xuK+VLz5JJ2aW+3DOuZmx1AI2CavR2gI2L+ZOcU28DwTy8SgOfk9d6pKv3c5izcEVLjcdbu5JnA0j6W7JllHPJC/P+1GD9/pctfcysuF7w2nF1sw104A2bRbpGEvqn0OqnganPcenVjD2PdcSPT9xUl8OaPbxDW2zyQu3yeDVyVfzMFwMMPzg1ChsF4bFKlvf1ChfPrDSYHu3vtYT+cvnk1b+FjKMGCEE5vmpKxETgiL89raAYMXzQy/46q3IEtvtoLdS3fLIGroU6fSq+8XhhY3YM9gydMJTMfm0pENkUFwH8CWpfjo636NerIf0UN7ZqbYexvAkiP+UJR2UudQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GVXPR04MB12128.eurprd04.prod.outlook.com (2603:10a6:150:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:13:22 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:13:22 +0000
From: Ye Li <ye.li@nxp.com>
To: peng.fan@nxp.com,
	peng.fan@oss.nxp.com,
	u-boot@lists.denx.de
Cc: ye.li@oss.nxp.com,
	uboot-imx@nxp.com,
	matt@traverse.com.au
Subject: [PATCH 3/4] arm: dts: fsl-ls1088a: Enable SD device
Date: Fri, 17 Apr 2026 22:15:28 +0800
Message-Id: <20260417141529.1490622-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0084.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::8) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GVXPR04MB12128:EE_
X-MS-Office365-Filtering-Correlation-Id: d8396be1-623d-4ce8-6895-08de9c8b7b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|42112799006|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: p9cllFPAv5xUhZxkOO45WMSY4l/V4Wq+bScg3vUYejdu6ACm42YipsqEI+y0/FaOJO3a/8Q1In2PqoVIP0C5qugNN4MbOpifcLNlG+A4MWb2EaRLoGSUydwH+k9KkusCRRIxUOvPcQ02nRprfR0pyzrk2bS/6KUdtSof1suwSTY7r3IdwVWDag9dUj9jmJycpUFudEV47wEn3cZzS5kAwBRwBaCawjIMCNk+Qc9/cITStJlKpBjBPlasUByzLTeNA2PKXr6eZamKLfelXPTpVz78SprMadEiFBn8lUKvorTHJpnEL8HIjsn7YhzIHpANmy+P/uT9j4KZ304zFe1O2/sa6aLAOqU1RnIQzh71RmkH2HhLK+EIcE5UbRBbX1UQh76jFNLmrc49wjlpfxy/rzcqrcFv+I+vNhbljsTCJbdNXGa7UCha4H/UT3qrqtgtpi7M7foYx5iOlM0/xBgqwML74g/oEdXLPXVb/sZQjE1rb8KxodXuCWV7L9ycd9+SDTUsHmQN3rmUv4b9QTJyJDPqChiQEkJnFus6BQjbkIapfcUdHJvOk/F7AO3JN8aU72XX9CZHreI6FIabR5q95zdntpb1FJUgStkunv7jJDeE8tQNs+ra3hWgNDwAjiu3gSyK3f4o0Rp7VqDaWXWnYEFIkzZZ58qgWPkN1dZBy2oxyQcGUgms23X5xIMfmdE7UnCoxpczfPTsjv/pa+YTqsHdlCSNald1JJ6QlBeNPcCPyYBGJWboUCsN3AB+hYshrEyAS69MTEWW02XbcAt3ck5N0oFTic4dOw/dO2A2gDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(42112799006)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0JxMI5VidbodMY3RO4gA6nXgIzkU0Z0wkiu8Q9hSG6Zk/lrlE5QU/0xhnr6q?=
 =?us-ascii?Q?35OmbouOCWaL7GbtNpRXT5DwY1iBsuTI0ONuEn9vxpftEKw9dJaNrKFAeA4x?=
 =?us-ascii?Q?DkJYM+DpUr9QTlmcyuVzYV+RKyp8IdtokmVZCLmsSV68ozP45oppV9w+0GCp?=
 =?us-ascii?Q?FJMn6/+1lrF30vlmAmy/YjAn34F9K3ypxgT/i4KYLZbh8LRXK9puxgyZWTKM?=
 =?us-ascii?Q?QSSs4V/hKizsgEcKddgqa1fpQISC6M2mqJvGuauem4TbKBtE8NcLCsBK+CpR?=
 =?us-ascii?Q?bx8q3EqR253L5z59hmRsIdYJpxiIatuRMtexBqVsXmp/E6AgTuUJFzAosrOe?=
 =?us-ascii?Q?1dV5wjtL/ANJ4BWjMZU9KOZLRc+X6nOlsvz2fZMaqt8y/fOP7RO/7OOyBFb9?=
 =?us-ascii?Q?KVxvpCI3ngrUYYKLMpxGQbhgkhAbBiJS5O6oF+MwMT7t6BkGlbKoek1thMGp?=
 =?us-ascii?Q?V+yfZNEHVpsbbp5rRjg+gW4TZvqktXOmqe0tjbQ/jysxz4hifzUitTEl/IkZ?=
 =?us-ascii?Q?f1+jr9a6nVbHL6KoaZA2rwPdU4P+wQU83MC79lvyEK1yR5Y0VRXQa78uH1iM?=
 =?us-ascii?Q?cMGqMCBQWzMy6yEgcPCoqYrdq9pcKW/YwPEzOLcz3RyxI3vLQntxiHVxAL1s?=
 =?us-ascii?Q?NWnGGS5nTJkEVO/HVnxoKZEjuZjQDDhEv+0aE/1pH9+zCcuyhzQKq29Snmj3?=
 =?us-ascii?Q?OyvrbIJpcTuTz6kJT2BZZQrrWxhbJDx0oxcTsobEqiEf6ZK7pfCmshgBzJ26?=
 =?us-ascii?Q?DEyn6wiOgqmhVFAbvKy2qikUVH4Xtt7qwJjg0pe41vuGRorkqE+tGPY/LPkX?=
 =?us-ascii?Q?9cU8cOjo0Ku5zN05H+m2af1GgXKlndr0WgDwU5geAKCLquaVSj00SdEMx4XZ?=
 =?us-ascii?Q?qh3su1JY7m8FcoEJWPxi0Wc8XlgPDa4kvveY7tb6xkYs6al0iOtAyh3+AnTn?=
 =?us-ascii?Q?6sxUnT2GTgrNFC+MVTYtCOHUhdSuHOIG8gr03FqQab+P0CCdmsAdaFNUCU6F?=
 =?us-ascii?Q?hCEfVHZMyYq6leusdq6kWUTC8r4H3fksaMJHLQYjLQsFBKBaQYSbU/1Bd6B8?=
 =?us-ascii?Q?/IdZp3jzez3DzlyDanb7hGbKbUqADE0lIaLgdh7dBXF54YlxTlUPUt4GGot6?=
 =?us-ascii?Q?WMBQbV7IytF679wTvtmPx5h3LGoYEY4hzvxKjsj++1XjdJuyui5vipCSkFNY?=
 =?us-ascii?Q?AZobG6HQaAy0VEKskwFowIMzGTWdXN/yoIT0dc0Fs788dYGVCsTIoNoIAZSz?=
 =?us-ascii?Q?kVcK5YToQ5YcMm93InZLYoUxmqP9ouZ46ReDFltbHgepidfc8mzLkVmnWikx?=
 =?us-ascii?Q?I1hxs9031Q9T5id6wjpqxU350wH90Ob2Wg1oGCD/5wCYd6AF8g4MEpWM6qmc?=
 =?us-ascii?Q?4UNWjHSsgJR0eSIJCpObdjt9m0l6kFHoBTMeziruHj0f7Q5OjYLtTbBntdKE?=
 =?us-ascii?Q?IRo8zXt3W+0n3pR73r/OOg/4B4qWQr1BjPsvXtbSamfSXrr87JCDbaRDIMCE?=
 =?us-ascii?Q?NNWpjbDcQmo4C4GLMTNJmrrLiFtvBCobKhw0cVSFky4ruAlRpr+tofdVFpXh?=
 =?us-ascii?Q?qVRq/jS7oSxZ/tn8SU1re13wUjOQvaoEVd86+hrzAXRc1eyqkAT3PSOLuZUj?=
 =?us-ascii?Q?TK5VQt9syfkT5Ck9AzC1k07a+tnjie54xqWa5qcGk5X+O1bf9FsgawZ7+2K+?=
 =?us-ascii?Q?cET5SH783U3liuivryXJQipavPyPC95mPQ+QhhKTOwKPFwJv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8396be1-623d-4ce8-6895-08de9c8b7b70
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 14:13:22.1891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVHvRfm8VTMkVELKJ3IqXUJFdvsMK3iNQ3ekQF+2pgkZ4p5mCD8p/jtm+nurG+4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12128
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

Due to update of fsl-ls1088a.dtsi in previous patch, the esdhc
node is disabled, so u-boot can't to probe any eSDHC controller.

Fixes: fd4f7b0158d0 ("arm: dts: fsl-ls1088a: move and sync existing bindings to be under /soc")
Signed-off-by: Ye Li <ye.li@nxp.com>
Tested-by: Wei Lu <w.lu@nxp.com>
---
 arch/arm/dts/fsl-ls1088a-u-boot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/fsl-ls1088a-u-boot.dtsi b/arch/arm/dts/fsl-ls1088a-u-boot.dtsi
index efcfdd96aef..e2755740e5d 100644
--- a/arch/arm/dts/fsl-ls1088a-u-boot.dtsi
+++ b/arch/arm/dts/fsl-ls1088a-u-boot.dtsi
@@ -61,3 +61,6 @@
 	compatible = "fsl,layerscape-dwc3", "snps,dwc3";
 };
 
+&esdhc {
+	status = "okay";
+};
-- 
2.37.1

