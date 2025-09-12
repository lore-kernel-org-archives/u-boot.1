Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020EACAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 13:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D7F83285;
	Fri, 12 Sep 2025 15:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HqRlwH0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1512E833EC; Fri, 12 Sep 2025 11:41:35 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E595A83322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 11:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akM3gMiQOk1j58xjT1IR7IfcpkXan7FE3NAKI8q0x79kOkzARt4N55LZ1dvKQb4ak/xhwNilZczzkpKhIiituCnWR5/2sI6823CflrV0E+6hxKAHnP0nctDZYqkPbcJNZfEsWmLNZydHUiJGQpkQ+c79u4oJGH0eZqfu55LvpBc42SFBmY6ig4EDQdQYiYzu9NCpgiUhHieNTvCOBEJ4LVR7ztrLEHLemEJ8/ZzUoondyk+jpaTaYIcbK4v1qj0prC5fgYLspjrmaykqZG7bjS/Qgc1yv7LVOrWGkazZW8SCXmozM9InabtDlqd5jkRU0zpkZwQRBxGgiFHsz6iv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjEzOEmR2riwF3zwI6vo3zU1EAt3Sxd/JH9ybN4cZxY=;
 b=trB2GmJGsIiJfMaP2rom1VJr2eORsmC8fe4ce/tSz9eouVom4nuAN1Sg6FGZjX6QYnUQOKMPEo3aKmhgyEbni5E4SbtTKkibr6g8i6LnX1NbChcc0lCMo0ZqKocpRnXK/gyV9cic6nG3fM7qzO3EBUa5rBuAbC/oTNSO7GTffbtBB13Na4HGekorr+VkvA7ihFI1yJ6O282u//NXDDZ8xgfqfjIB6ip4tMFTOtlsdnbUO3YmNAoTv++lg/ga6BPCD7n21pDDWoQ8QH2dnnpD/gJLe/z2fF8xTFqpU5PbsMHyXrk5PFwMQYSWYHnMSMPWjCJWNa5g5AZ9OFh4u6pTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjEzOEmR2riwF3zwI6vo3zU1EAt3Sxd/JH9ybN4cZxY=;
 b=HqRlwH0Py+l7qv+RxUZVIF8ozMrw6VfA5ahIZrLd3U+XxI3f3lF9wVfE4ne1oM+zJUzxRe3aCU74dCLLQxWr5a4i+wrpwPZIoIE3AY81qAZLVVIeDPMqDK350x7HkO85EdNOXBvmx9BuLHKK842Rj/EiIunW708QUe8AAhAleMq1occn2GzPgOhbpAPiC7Gcm4WRYR/n2vyQdKYi09zkA0YCTpI0J4dwLslIkWeZSkdNMUQmQh9mpT5p0YmW4I6xbvYDkWLcqKSHcsutw2HQhIb/H8kTJpTrKb8nragjXAwDOb/6DS1PgRuQkDnj3VWzD6fgMrDoMnZFFO6QMzDsKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM9PR04MB8488.eurprd04.prod.outlook.com (2603:10a6:20b:41b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 09:41:31 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 09:41:31 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com, ye.li@oss.nxp.com,
 tien.fong.chee@altera.com, alif.zakuan.yuslaimi@altera.com
Subject: [PATCH] arm: armv8: Fix spl recover data section broken
Date: Fri, 12 Sep 2025 17:41:11 +0800
Message-Id: <20250912094111.319680-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM9PR04MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec7b470-e297-4a13-86a4-08ddf1e08dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/eXNb/KIcmBkZxzrPaLElT6EaqkH0ji+JzNUjbA4J2+5zrpLkir7R8v3J3cH?=
 =?us-ascii?Q?xfJI48miFsMwKrsJrorbmhF5yjAaYlS+PYQXWWSB5fK/HGgvGApyhoa3bSsG?=
 =?us-ascii?Q?MsNEVEdHgx+kmJeeh29IfgSxFVSKeK6obJoHF+6h7IbKt7br42CVHuTMxHTi?=
 =?us-ascii?Q?5HUxagubAUkKFqAMIbJOE968hBw1IeWu/ILDbr3ZjYvlxT3r1/2cvrCS+4Yg?=
 =?us-ascii?Q?ytaSoHAmxcstRL1nMiw1ZBDIyxnRNjzJj08HdK5+vF6BDgfAQA60EroIiKMp?=
 =?us-ascii?Q?iclf2XQ7e666sLbOshVg3QIaGl8KLKuJKUZ+aiF6PM2ze14BdM8gJxyCLnF4?=
 =?us-ascii?Q?Q17BTvx07Ub+fPKpJyvl3GxPMsx0e0CHAyeGcU3pP08hYINxr/ZIclwMW0v7?=
 =?us-ascii?Q?eMvk1t/ZFRz20JjvQO9mqJUEbXp3qN38kDIgQg0Eoe9eDn8D/TJQ+gbpk2p4?=
 =?us-ascii?Q?15J7yT/HW6T91u70inqkpH5TlmgMKXZ04AyWHRppuI34t3XJA4H7xb2dH6oV?=
 =?us-ascii?Q?3mN/RfLLGO2VXnC5i0fJ+mZmjCmfK/5w82oKLsitC+CAXWut4YJNNKSFLPzS?=
 =?us-ascii?Q?jdtdvN7gNdWObmFGs2D2KwOLa3epvbuVHTI+tO9riTe7+Wv+PVC/zvopZlZK?=
 =?us-ascii?Q?O8AKpmHOVMf9+hv1XNkVXCkJr0LXfr5ZpHsgEQUMusD2QIJVKEc56a4oYATx?=
 =?us-ascii?Q?1LiEuOZUx2Mux8pfLQvpTD1pt9RK65PfmnGERxqsafAtlGOGDyLBrBsdYMGa?=
 =?us-ascii?Q?5l/mVHs27eHpj4cBmhA/WI24rkdlQnhg8ya4+zA6LQw1zWChpR8Hg2p9zTTG?=
 =?us-ascii?Q?vklAmF5EwWCq72dqM5uhdq2YDDqnRfi5BBXxJBzQ8Ks7vY2/CcPXxSdlI5Df?=
 =?us-ascii?Q?qV84/yU6WJxGJwcaABGufyQGarTvhIV3AO/Lc0i0YeoojsKPXBSFwv5gxjO2?=
 =?us-ascii?Q?o3Lx2BQYoUDbfG1SrplsQEN/QyNDk+XQeC8TKOyrHmRtYZ4zIOewjS8g7Ucw?=
 =?us-ascii?Q?BLYiq3sdiCsJwK2qW5Zf5GfCgT5ywM54ItN6Sce21fFEYMrUDFBPO2Oje4AQ?=
 =?us-ascii?Q?qBY6AQE0tYHEfHyZjp+PhhNB2UHGywBy3vksDSXHo12CV2eO4Lk1LwzigwYL?=
 =?us-ascii?Q?b0YmzjzttHrf3ujnbZQLRurU2hbE8oJMSZ0BkWn/qIwG/lvK5lpOuQDQyIlV?=
 =?us-ascii?Q?E5xv+c8Xw78hqRwMVGhLbtOvPoaq2pgDIDPXOMS2fj/ZZ4FaliashnEEKNAC?=
 =?us-ascii?Q?ChTHMK80SlXOC0NBJcwxZadCqfn6C8zGZNkQdOYiQSUdpH+9RT38TuNyEjhX?=
 =?us-ascii?Q?pLuBOFCPgpcvAIAPheG5/5SO7OT7e7hzZ/MEgZY+mc9Ny/8Piwm0/YgiFtkV?=
 =?us-ascii?Q?6++dSFT9wgHUZBj77IgLlMJsF7Rvx0P1/kaCThnEi7e37D3+IINO0f4bzEyj?=
 =?us-ascii?Q?77Qa8c3bFirIcPv9GD4Q8eP7L1/SiGBsy7LFpuldDD0EgnwfXNt1kg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6F6E+dSq11ayBeFz8zeEc9gfgFfr2FNOM51H8n+9K9U7aYG2tbbYw0j42aBo?=
 =?us-ascii?Q?jj1MjhKkWVtFUXG+eUENqX4lY+rVVVYCKZBPS1sgxVGu79irtDDz8PO072zG?=
 =?us-ascii?Q?kXnvwBfPYUm+Aq4wBvP62/qj/+9kpWEmF3BUwjCe2HHp5ynA+W7EjRKm2w/x?=
 =?us-ascii?Q?ORLU2jrkJwep6Si+S+k5Cw068aprxZSoKdazpSNJZiwsHb9+Z7EOSV95kstf?=
 =?us-ascii?Q?IkNzpbVkWd1308XfhGpv4adCj1Y2ZWod11D/84bIEPyxaeJq2OIev7aPxiI8?=
 =?us-ascii?Q?nQAyImLsuYAPEZIJWfCsAEWvM7JQtFdMs/AvJ2AjakcT+tLvTC3/mjI+Ylgk?=
 =?us-ascii?Q?UJYlldAHHY1O9v8yJTdwcQncv3Bo+sRWdD0lE56sshmYsNvd5RJ59ubePbml?=
 =?us-ascii?Q?/8lGR6QqC4hoFGr0DmnhxH22uAsyTZKe3qApRmaJlCxrou3i9FQhKHA0jSBc?=
 =?us-ascii?Q?2bMXQQJncuySSC6ZfM72JDI45qQpY4sIgSrjaC35RvD9DeefqXVN/yRyi+fi?=
 =?us-ascii?Q?mfMLFYL50urDf3gbIchFhgNOZwoSKVp0rzKnqHPQrb8gWe3BZVYxoLVhsxwB?=
 =?us-ascii?Q?BSxZziAMVVQ6UpU1O7fWYDoZs41TgBgZlPHXXgTIUASEwS0D0aL7c9GGod5I?=
 =?us-ascii?Q?rNz3TkzEA/5PDX8nLY9lMl4Ml9BIm3KybH6Tvi4ukZFC54sbgJJOiMcdLFVJ?=
 =?us-ascii?Q?nrjCCN0VZ5rApmAIOsru8APeL3+066i5yNorK5nn8SrmqpiyErAZ/2GVJRPR?=
 =?us-ascii?Q?OOdaZFcBFR2pvrNQ1+ZURha/wLjGGXAU8kMGVrDPJom/aZJ+d7v0d6dKCiDv?=
 =?us-ascii?Q?ne69UR/mnHVFQgj8xUuLEYd0qXdFXdBYAJFIbv6qVLcCPLEqhiLfz9LJptof?=
 =?us-ascii?Q?AKvehsHJhKKXGB65HqfahiYzyg2jnKsKzoT/E3V4kPXag1jjGEbwuiqBp56v?=
 =?us-ascii?Q?U/ne2WL10aPxDe9rvaZTFsmEpE7t3n2XzNjd/3Fb1HWyrN3/AMWvMglVO+Mx?=
 =?us-ascii?Q?KK0XYy0DztcbItpcuzxG41U01d2G+MS0G8WAk853/T2XdzwoZeqJBzrvBz9Z?=
 =?us-ascii?Q?qLsm1+/t1teHwd1cBdHeO6hv7Yg7VykJNrc3DXSmryLopI6G6qMAbqv43xxd?=
 =?us-ascii?Q?xncPsys0x6vQEjMEatgusTu5wdqvqC9+D76bUOr3gpLJ6adkYetUvBhc1TJ8?=
 =?us-ascii?Q?CLS0D7a7Q6GQuji/TccfX7zOol4VyxEJ27ExhIBYTwW+QEc1IHv7jgHs95O7?=
 =?us-ascii?Q?sC5D9B+t/Mm9EL+GRy1Yd+IDaBKcmyXBXqc1ljqErtiuT6p18moDODwxcpD7?=
 =?us-ascii?Q?p1LqWyBxQH8uLfgZrA8InIIpVHiMIA9ioyZE6mBtMETwKaBGYjZIhKp2hz/C?=
 =?us-ascii?Q?c3u45ANNamrH3B9n9Fmj4MdK+oTjXM+wSrg2S/jq6V2mWGXxbCRxhovkCdW3?=
 =?us-ascii?Q?SDwITG5zx9S02YMkJLp+PuaNmkRIq+IFiJXU4I7NuUjX492FbPSi69wNDFYK?=
 =?us-ascii?Q?6kUcFSmX7b3ud3rKNxtvlxKkNJYOIN5ojPN9/RHCqO8rEZBkgfU5Vt7ZtbxJ?=
 =?us-ascii?Q?/PVmW1mqLSspulWKSxo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec7b470-e297-4a13-86a4-08ddf1e08dab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:41:31.1422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmtwxyrMoLSa/tm7EBv/yvy8nDq9ON7GxpnISxXcyNSaUH6lDGkvt7WzRn0ANuBI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8488
X-Mailman-Approved-At: Fri, 12 Sep 2025 15:04:58 +0200
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

SPL recover data section is broken which causes reboot failure on
some i.MX platforms (iMX8QM/iMX95).
The global variable cold_reboot_flag is assigned to weak reset_flag
function which always return 1, so restore never been executed in
warm reboot.

Fixes: 1c37e59bfbba ("arm: armv8: Improve SPL data save and restore implementation")
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/cpu/armv8/spl_data.c       | 6 +++---
 arch/arm/mach-socfpga/spl_agilex.c  | 2 +-
 arch/arm/mach-socfpga/spl_agilex5.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/cpu/armv8/spl_data.c b/arch/arm/cpu/armv8/spl_data.c
index 492353c93df..f4009e89a98 100644
--- a/arch/arm/cpu/armv8/spl_data.c
+++ b/arch/arm/cpu/armv8/spl_data.c
@@ -11,15 +11,15 @@ char __data_save_end[0] __section(".__data_save_end");
 
 u32 cold_reboot_flag = 1;
 
-u32 __weak reset_flag(void)
+u32 __weak reset_flag(u32 flag)
 {
-	return 1;
+	return flag;
 }
 
 void spl_save_restore_data(void)
 {
 	u32 data_size = __data_save_end - __data_save_start;
-	cold_reboot_flag = reset_flag();
+	cold_reboot_flag = reset_flag(cold_reboot_flag);
 
 	if (cold_reboot_flag == 1) {
 		/* Save data section to data_save section */
diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index 351848f16e6..48f258a37b4 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -24,7 +24,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-u32 reset_flag(void)
+u32 reset_flag(u32 flag)
 {
 	/* Check rstmgr.stat for warm reset status */
 	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
index 2e3597e97eb..1be347360f5 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -21,7 +21,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-u32 reset_flag(void)
+u32 reset_flag(u32 flag)
 {
 	/* Check rstmgr.stat for warm reset status */
 	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
-- 
2.37.1

