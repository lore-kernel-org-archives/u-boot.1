Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0533DE65293
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 15:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487D483C54;
	Sun,  1 Feb 2026 16:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="h6+8D36D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8132983B5E; Sun,  1 Feb 2026 16:14:08 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D7383C2B
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 16:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpo0qh/FhFLw+lnIpsEvHD+/OrcmdRm/RTMD5EFUHLZ3L17oyucxJHN1lDmuFnqi1i2T8PgLme0GHoVFdG13dqZs/4GYU+FfY8cNAYxPYb2/86Tg15XRmEXLLbTLpg7uG+A8U2YQ82Lm2nX5KwgSVbwi9i9eBt39llYXYP+N1pdA+F6a5TJyHlZPxEtwXS1pO4zqg6Kx5ba5MTjUdDRJdmO19GtugH3jxXsc14kxr8SGk77822z6FnlyFay61EJZDmgCLRyUOymfh0+rkbus6Z8ula6BvBWsmam50/IIxobiO97Oom7aqEh4tTWb24ETZNBeJEbhxyoTnH+FkIga9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3aMV6rgUYqFZD8kIMhDsr9lkNpXamu0dcsfvStAbi4=;
 b=KxxvRReFa3gBcfzpD9hFai7b9W62XQrbLRsXC8kCAAV3uAwvkMlTX0tAT7VK60+fPcFztYRySiixM+C1QiElRsFykUrfKyBkYL/l8Jw2xT9NV26FO3v1ZsLrYq8ET3l6+z5o4U+1nbxanv0L7xBo6YFs8xzLyXclPwIgg6Vl/j5lUnbVLguvPS7be4yqJPzFhSfA9/SHYirlA1/u7/F9dI5CmrYDj+MHQHY4XYpZBKvzcbm/Q7kYf0Mlmv8nGB6iQKWvi/RHaDpG9DWkzfCgQ65Eca1Ukj4ZbgFroLZVvVY1MrsKY3NMmFSNuFEWEI8C/gt0zMvxbIJY4ImfMNWhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3aMV6rgUYqFZD8kIMhDsr9lkNpXamu0dcsfvStAbi4=;
 b=h6+8D36D2TSSIHqHgOa2uuwGgfgWqpKPjwpg+HClj1n9adSbbRtT7uwutElBDAWR2dW8Vx2oh9qT01mqQ5AoDUYCfY0U9Y11qimMDPmSYyZWpZO4oEljmuoxPQ3aWabytxMnauloytkMOpzE4X6WyBZE6R2YhTalKpcfZDQcE9uPyFDiFT0+b+C1/i8XnhelCNXBshtkd639jWcmpOI672RhsPb/dayGEuTYxYjLTJsFEu81zP96Jw7pFlaQA3ZvgphjHbxFqEhrJ06Qavi9agQUuB9ofZ4D7Kh+jLE+K6RX6+ja5xlgr0UX5DmE1C/iSXPY53/Yfk49u3kmCCCeCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7901.namprd03.prod.outlook.com (2603:10b6:806:42b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:14:03 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 15:14:03 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v2 2/3] arm: agilex5: Enable SD card UHS mode support
Date: Sun,  1 Feb 2026 07:13:42 -0800
Message-Id: <20260201151343.27560-3-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
References: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: ca107e88-3f0d-46c1-4b73-08de61a487f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cqq6LComhynmZvHO1pwKUnypVVh3jBuhCSljn1bE0/rw9M9oFuAb+OeoUCT9?=
 =?us-ascii?Q?kXsVxJqm4MBxt26Mw+cHkrmNTBBvR0nq5MjUDvYgtH+P95XZ1D6zMmkHxaWX?=
 =?us-ascii?Q?gxdjuwQQthc+tlakj9zyjY/wMA2EOv8ngWbHLIyHKwDOFvF7dfJZ+Rx3iWo8?=
 =?us-ascii?Q?DvRopHyaSZ4tYsCNwhgMwCuKrWh8gIMLSYpHhQW5OV6mDAMbJzAxwVuQ/AVF?=
 =?us-ascii?Q?s7V4m5sPO1fghkNoLLD6zpsAhfLf/trDWcoVjEFgbxdH3vn7Z7OBPP3kkbVk?=
 =?us-ascii?Q?dZoAPFX3iXaxnrY5AA4XbkA23getFpGxh9WWK0lXSfBfW6upsdjE3ypfLqXI?=
 =?us-ascii?Q?+vUmF/DmUZwa2z6altIAY1St7JqfEx7sQOodWchvN74dahUZcUqccuDCysCK?=
 =?us-ascii?Q?ty42j1+BADpXXyvSkTpWOFjzPORxvtHreimSlJMHZNlVB+jMIu7aaEbii9kR?=
 =?us-ascii?Q?UaOBuq8IuoihWgf4e7YD70WK07Xed0Nv1rlzyJq0lS/32rTChAuRLPtZ6RMQ?=
 =?us-ascii?Q?NgzuPNOLbbcurpd7lE8EtuJkaR9Bdhta7q3qLCyn1MxfuyEKKp0KJ11e6dF/?=
 =?us-ascii?Q?AU71bZox500D0UsZPxO+yo1Y32ciqLXfENpNUo3mFstGervmKhNCryqVWal5?=
 =?us-ascii?Q?JOKRTrW/RM3QeZBx2MVEKs383qKiSUPeUOInKuhb4erPCG9t7KCqUwK41yAR?=
 =?us-ascii?Q?ldOn56tHDASnStH/vMoBGNq8BwUi2QBkT7RXy0Z7bou/TslFBIofRuwpyB77?=
 =?us-ascii?Q?Snw9smZIRJJ7BDjuE8fwzX+WLINXnip3rGY1JvdfmwetFh2362VjTGt8qMYT?=
 =?us-ascii?Q?4gXo2kjTHlqnvaZRfRuV0fiumO1ybjbisl7Nmo/8OiQT19z2yD7Ms69X4OJt?=
 =?us-ascii?Q?fImqZJlxzeI9FxeVaprZPgsi6AcnhAfCEes7Mn23Uz8TFqHSs71m8gpm5GhE?=
 =?us-ascii?Q?JRZ3unE8idMU1PBKETruovYu/WOF02AZr7hwC6tCOrFwxImV5AKo34Xo49QP?=
 =?us-ascii?Q?SvHs5xhXqiZmvDDTDmIIi9xdL/H/nlAlw0Q4elYoLhU4iX6CVEQkoXWo7tAy?=
 =?us-ascii?Q?GhhhLvpS07PQwRs0jivdrUgATJMoKZ3NWj3AWmpCAdgr8oaNYDZMhntCe0xj?=
 =?us-ascii?Q?p8L4pAnwJjqry/hTDnz9dw4s+IDsQtDXtJ/Jwb5656hXhnLp+mUwaP67ma/w?=
 =?us-ascii?Q?DCXi3ptE74JSpA4hADnF7TQKsbiIkiTz7PyslipMDZR2/65MNbXF8bfEjHDV?=
 =?us-ascii?Q?tcW0LERzAuAu5oewN8YqmuGfULjFO1226AejdijX0/eemCAquP49xbWC6IIC?=
 =?us-ascii?Q?bw97LP3JR2yU+bZG9FKUmFA5FjizY9LnfeNPKSttZD4vDTzhAvbyJCP/FLtn?=
 =?us-ascii?Q?wwn5gFT9eIkXFyd8IWb/3HS9xtNAweEa3EFTT9TNYa/oASSFIOVzk+qsEQat?=
 =?us-ascii?Q?K2469nh/2Z5DA+cF+IIr43ikbZ9K5kot2prqyG5hQ6cASDESBzUp5HxVmYBa?=
 =?us-ascii?Q?ax+N6+2LLD2dbejc7hTVaoES4N5xyxEi48OwZ495dzH3NisWAS3Ah723ns/p?=
 =?us-ascii?Q?p7Em6uxB6Qq3IwOUBD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XVOxkkqdn9XZmjRqotM5AckwnPZd8BJUvyjyB3XuymLxA/v48wDMxpyaCjsB?=
 =?us-ascii?Q?t6Hnqd/lSkFMUWlsxkF6MCIFRjhHltqkIGQ6OcXzuxktPyIR+h0diyfiRdfc?=
 =?us-ascii?Q?hUNxam/Fg0QR1Ei3lGUwY+hkog7rt0+GBBE25OW5dSigkwYXL1Ly+lJe+T+J?=
 =?us-ascii?Q?9Y2Xbwb3kSmHWBUTCvEgHVkh7yvSyIaG1B+SSm9Dpo9Je8FZBN6WIgU2sWSp?=
 =?us-ascii?Q?OsYojNe39z6XVvDb+gZkh/75rU1LZIWqrTDum/gZef0VzEJJyiUXzzb1t4sY?=
 =?us-ascii?Q?o4d8U8svJMbA0RfYvgHN3fEdzqMrjEkMeepDPt0dKc+HnboCGJNSQJMG0+oW?=
 =?us-ascii?Q?h1InyVlOz78vFEpeJ1+QJimaXdGL1RsEXzYDdBBhFJ/VlD8VuKGEa4ZoKC5/?=
 =?us-ascii?Q?ijO1KKaA6u4rPP4RxgLkl0inIpBZTcPKS2IvmtjFFp2PZlfrvy09RnjHNwPw?=
 =?us-ascii?Q?v/dd6gVuX4KXIrPnNcrIHKxCg/ImZWw+1DBo9FkHF8SdXxmEBsBskQyOZtQ9?=
 =?us-ascii?Q?I4bEoGoWZnv66Itf8dHZLyYxII9FeGhN4J+R/g4vFdqlyjiUEJM4LVDWvFhd?=
 =?us-ascii?Q?9BSXx7JLMlsz//zwciuoUMr72hCLdItVDrzrDiURJQn3b0dLY56kBYEHcLs6?=
 =?us-ascii?Q?ZlwDeb657OYph/WpZzZ2jpfL1g29g/qsSvAR4JmI779xS6zv6HFr71xMiZQV?=
 =?us-ascii?Q?HsDisIev1WCeDX891/H15daa+/FowSXJ6vLlSsHa+E8OnKPU/flgscr11ChT?=
 =?us-ascii?Q?B2chEDBvXOFwD2RpgSdXGD+5kEit5t24n9FmpfGSMsH0yOS04A/FSp6E9yUJ?=
 =?us-ascii?Q?zUGZc+5A1gWFyZfay16NdXKGMDtOtTuBmKE7A1poTl/RVQCNCpbBDPwOSUmN?=
 =?us-ascii?Q?/6u+frp+nsJOgCHUSbjDwa94gqJp9IMnpi6qkHjjjm7zIhWF93fvigvCEgP7?=
 =?us-ascii?Q?fhnuUTzvpu0T1jmX3VtBwro7S09Xt1r6cpOILpU+zVgKoRxcg1XiENpEc9bo?=
 =?us-ascii?Q?mhNIMB+st1nJk5imwOqL6larjnJMzr81i4jNDaWyXiLAZbutI+txaxLt7LRV?=
 =?us-ascii?Q?KvBqY1Fdw2W6WWsddNwGQttnIU96Kl7v59YYCJU+WzCxf4eeEkbRDR0cHk8L?=
 =?us-ascii?Q?3nRGsgy7VPF489x0Bh6PsJV71tSD4pCOgdh/ntqKoP4WccTyOQhIrJSbiKfU?=
 =?us-ascii?Q?skGNPHY8QtovRr9wHKXwuUqGDIqIMJmv7vPV/kKLv4nfZYyq5b6yuUSdO1p6?=
 =?us-ascii?Q?41P0E4Yif4sUK8XIR3MzB2fn1BUunsAk9EaF+Pp8UohNfoiw4vRt59KATNfC?=
 =?us-ascii?Q?hsTK0P6ceU58DiLGNpkyQFzq4SLSElWBWcByYL4mmsrpHhdffiF8Rhd9wFDR?=
 =?us-ascii?Q?vkmlxMFMWay60FrS1vhDSO33hhiJFfwg5ceCFUlnZOVbm5ZWFSDTJJWwxghj?=
 =?us-ascii?Q?GWL8LEZBS16GjgVn929/uS7BBy7+khksCN+kRZybFKmSGIGaOITxPPngIBBD?=
 =?us-ascii?Q?81m3oCxvlc+++V/blrL5OS/Gx0Dj+daobJ7ms50v/vCK/HLm9y3ZE0eyO5Ij?=
 =?us-ascii?Q?IRo7uw6OvTFIfiCB7yeWeXKe2gv82XKNXdgQptAXfAIL0sRYV5WXLldO+8C+?=
 =?us-ascii?Q?SLUsn/aJyA6KigprBIMTlSPXT1pp6X22RVfojLJ4aCWlr83pKd76bChnw3Pd?=
 =?us-ascii?Q?S7nKux4FFGLKuxPkTG0W51Ww7YAif0y0GTMZrXyuJT4GhATr4hnZYvrAPx4R?=
 =?us-ascii?Q?LlmY++u9HbuTk0Zoiwa3NSX4igtwHZg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca107e88-3f0d-46c1-4b73-08de61a487f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:14:03.0114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjxTJ7aHLqf6XVaDerz9WuVRrczyC9zZpRdxfd24Koqhxy27pAJq5N8rDhkiCzrzhW/s8PFo1f1DZaZlm3tZVIEoHr/16CZElaTmgLThIOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7901
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

Enable Ultra High Speed (UHS-I) mode support for SD cards on
Agilex5 SoC development kit.

Defconfig changes:
- Enable CONFIG_MMC_UHS_SUPPORT and CONFIG_SPL_MMC_UHS_SUPPORT

Device tree changes:
- Remove no-1-8-v to allow 1.8V signaling for UHS modes
- Add sd-uhs-sdr50 and sd-uhs-sdr104 capabilities
- Add sdhci-caps and sdhci-caps-mask for proper capability reporting
- Add PHY and controller timing configuration

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 25 ++++++++++++++++++-
 configs/socfpga_agilex5_defconfig             |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index b443e57b1cd..c03f78b2fdf 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -110,12 +110,15 @@
 	status = "okay";
 
 	no-mmc;
-	no-1-8-v;
 	disable-wp;
 	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
 
 	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
@@ -130,6 +133,26 @@
 	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
 
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
 	bootph-all;
 };
 
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 5fbc49b2307..8a3f9563af2 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -87,6 +87,8 @@ CONFIG_DW_I3C_MASTER=y
 CONFIG_MISC=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
-- 
2.43.7

