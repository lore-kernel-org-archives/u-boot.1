Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4506D206A1
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7DA88C7E;
	Wed, 16 Oct 2024 08:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ayX4jEB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174B288CC9; Wed, 16 Oct 2024 08:46:39 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD9D88B86
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wS8iK4I7RGmdtt3FcfSh3/M9TL9cxFfUs4thWOTyGjIGLsx7yKDyLMnwv7gZHdC8jPEqj/lw82JIEKMo1ITL2QL4RsJwNYUBALpx23t/XeebwcMtDDKWpyajtKSB8HAuE8STu3FF+OOhYxDDr7KAQKFzuLOxFPncFT/mOzDuMg+/G1Fr0b52AJuOpNDGRQ84aIX0vfD95gTrmveXVt6/Y97H/sKg84Ct1spX5STqgdht7FBVn0WYoyIZboA26SJMtyHOas7q+ou58UPgScjy+VeS96Dyi9b7GCSRj5fsXYdGtLA8ZxXR9xlp+3AhC74B9pGab2MEIaH56FoNwBVroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha+nctKOCm+YcB7Py28XWZXD8McbaDX+FINDw6SJQ8g=;
 b=c/norXkcVBQ1pfwRxtmZyUyafRpGH1pSI1VVf3TUiyI9XNA8IMXaMjkrqf48fLfFUoX99GuQcaKsLKHhSAv7IQFGWduBPed8IjsCem0TrJd3FoVS9NbZFRBxft+R3EHD3YXV8FbBC03EyrWbsNJmlJiZcSJrJ/a/44kkjVc9U74ufFP1ENW4216ugoNFdkNKnJU4KLwMhThQIgAtH5HkgA/PSdtK1wHjsHy1O5VP98GeDiVnUKe0b4mzoW3Oo91xDhIfqexkuHViUo8MCnJZejtip6c3pkp1eRUFfvS2c/bat2GT1vVFxn7HyeaRsw0k1Pw4qaHT/TFHB/D+jCVWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha+nctKOCm+YcB7Py28XWZXD8McbaDX+FINDw6SJQ8g=;
 b=ayX4jEB4q07NVIXwpVVVzzucSvPTTgeVTQjzTxrvjGZZehEODZjLJXRskqwpBvNYZIF5WpOPT9QKmwzsl8gWaG98QqqJoexr7OsADTpUADCQ5SUyvaz1CqR8aBgtwjxEB7vk4pJ7pcafVLFL7QYOo2dtEkKn56mf4/1rF3WGsgI8Ml3DScPAO5K3sAbVGn81WWa1IDECaK5Ha24PsYBASt55BT9UZnacE+SGU9DnVHzZa0vyGPuri63L/oVHUHm9cMO5m43C6yVAKrTiF/e5APhDr4BWOS3hTYV8tdWkCHiaG9j1nfVjfbVFaaSSpItgbu6odQhCknbZE9/4a/oFzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8878.eurprd04.prod.outlook.com (2603:10a6:102:20d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 06:46:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 06:46:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de,
	u-boot@lists.denx.de,
	hs@denx.de
Cc: uboot-imx@nxp.com, lukma@denx.de, seanga2@gmail.com,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx8: Add dummy clk
Date: Wed, 16 Oct 2024 15:50:29 +0800
Message-Id: <20241016075029.15469-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af769c0-a3ab-4ad0-4936-08dcedae4566
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OZ1JCyoUClKgVB/HsdizM/P9oy3VZ9uhAqB/MQPjZiGaxMbIjrc0SSpXX16s?=
 =?us-ascii?Q?RNQAuxQnnfoqrMWM4SRqoU/fcpuXdnyPXwqVEH4In2vrLaoy+aUZfJDIbyEZ?=
 =?us-ascii?Q?otZ8PN2PvzsqS+Tz8TKaUdI0egxJCkNgnKNtWJRZx5QnEA64emQclooaKBIF?=
 =?us-ascii?Q?c6dsuLBvQ9RZ3eAy9lGOT5mUzckdTDmpINhXPR8+hpglx2ka93HMaL5gMaln?=
 =?us-ascii?Q?NG6jiwGJdJGQUWqjGRMmaB1WqZ2eRqA6m/+8hzs+Frz5tzAdlqH205l0h9o4?=
 =?us-ascii?Q?e/E/H7f/7UmU4A4mm0fVOBMNvi1imNdcioqsiyDh3viQO1cvVfRFDNhLcQHN?=
 =?us-ascii?Q?tJXSzX6IA0+N+voE1zU6934xLDrP/Ko99Yj3lppKEAd4LP7vwMnN0JVavp55?=
 =?us-ascii?Q?+yX87555rfk80e0MsdHxOY12GrCx/o9U0lOfmtkfYRX82PG05tl1vCh8l8mI?=
 =?us-ascii?Q?IDCafQPvEesbbMFE14ECbFhRqeVFU8y88CIswCD9tna/9fZ5/ntr9Rse/uyO?=
 =?us-ascii?Q?zRkC4l40+tmDotq/H6LAR8V4bxf9VAMHLOYeehugZPfXPmP0LOGX4NQ2uaSO?=
 =?us-ascii?Q?VyxHkC6rjDnud2U8A1srTehxDZR/P0+g4fZRfT+DySw1p38jWBiUBJRbBJb6?=
 =?us-ascii?Q?jIZPHezT99k0CsKrPRTK1MaRIAlS/9kfreD1nmKL6qEEt9HPEPdUKQM6o4vf?=
 =?us-ascii?Q?clcmnoGaf22u2l9UoCiJKK8Y+ffxSDJnmv6kKr+6TP2VgP4P8nE8bW8JhIjK?=
 =?us-ascii?Q?akKY6OhnF/5P55NlTwCF2a/YWwHNreWgQOpfZGSj2pQ/odkei/pXKwyQJKOa?=
 =?us-ascii?Q?ogbL+OhvAIMQX02L6zfP/+HuiarjHe3wfso7TuWopos12dKjC58RSVMDiCS6?=
 =?us-ascii?Q?f9sBn+G9Dr8/EL8uWnDI+WIQXVG7/1nNdWd/sQ6XIaYdGetEbef7ESnX1zlK?=
 =?us-ascii?Q?76+U81jQo/TEtTNCjlIlJRF4oC8BAihHw6dRf+wEQ1LkXw++/G9WFc+0F9wz?=
 =?us-ascii?Q?te3L4e7J3JRbNBwucoH51wefnQmaB74mQgTh2VqkBgRU/BKJJwJ4X878KhU9?=
 =?us-ascii?Q?y3Xyf0AAkoocp/lzEABWn0mk9CM++YVNzf6xjpzzDnnXZHCGWi2WotxfM/oD?=
 =?us-ascii?Q?ienIUlrFufxer77yhgCEus6BwgtbSPGR7551y3e21aBPnYa+UdDIkdJ86neC?=
 =?us-ascii?Q?ke0nfmYpW7+pqVG0/GkKIv8UXfRuvia2Ha8MdT519UKIxPi14gw4y6/eR0qY?=
 =?us-ascii?Q?4Ao5R+Wmt6v5AR4DNxeY6eykJ+Aerxyb5S9l/X/wSVYc/r43aEPSZVOWoFDB?=
 =?us-ascii?Q?W/RGPntFymUA5tU3Gq5ANngJXdJxU9exYgsiiSs67/VKzg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y66wf8iVQJpBCOJxYmAFpAfgS3P9Iz7CWOX4+dJoNjzXk93UFd7LJrTRVQ0L?=
 =?us-ascii?Q?gnoWIZcxgpzsGWkDIrqNGfpuhhpE7P6q5otw5lWOEA8cKPYmKdaDW/jlhJfL?=
 =?us-ascii?Q?cwq95hKCYO5QciuzpuMGLkmpdNR4HzTcROTdddBQ2t0OVxpn8yPZkwHYbPLh?=
 =?us-ascii?Q?tt85rLGU3YTkAjkgjgMpKX93fbDpFpLf+eHh7yQb/DABycpJgIn0VKIlGwYw?=
 =?us-ascii?Q?1Sa1Hlo8e3hzqhkxUA1IfsNitehD4T9OYGCRTx9AJ/K1Smr/zMkSuVTYU0td?=
 =?us-ascii?Q?k5AL9csl+4g5IKIL4h6MFSxIEIUy/AW/YTL6+ipmfsB2dMzjifoXwhPIDwA1?=
 =?us-ascii?Q?YQ43HHzgfRQljjdU+vKAuITdscswqnsI7VXwl4J7UEDNVBnkRD5fBokMda5d?=
 =?us-ascii?Q?jttQ1Vl/6ZIkp9sfP9SKbOock1WjHedk84/pjF1SQE2is2rsjteL6rIfgQg2?=
 =?us-ascii?Q?nUCl92ymTYp3u4GM1cvxcI4R+92Us3/mryqOkTLbiY1yMrO0xbWKffmpqbps?=
 =?us-ascii?Q?/I3qVoRqpQudAGZg/PqXntNAsBuIWdFJd6DZ4SMdKq9y9eJrItHpqzYdUvaz?=
 =?us-ascii?Q?3xsueIA0jcvTCVRtSf0VbaM++UUFOTCEqwQs0PnX0oO6mjuzTAX2dFiTn0tO?=
 =?us-ascii?Q?N4NwPxqslS63S3U0MpgboWkguc1/EwDHcj5tRNtL92Xbt2nAz9bX6yB3JNpj?=
 =?us-ascii?Q?7q9W1bjWQ4Jgj6cOvD/yXSuqtPubFMU0rKC5+Au6E0Wtj+PWuehEFZMefO8v?=
 =?us-ascii?Q?W921FBqqlRK/IFjr4OPvS7mr5qzX8tScGA7x5qz2ZPI5tMaryk81yHO4vTeb?=
 =?us-ascii?Q?pGPY9SeFvGIR16yA22iTpl6qVXns3Ji1CfSJ+3LFYe+4me/2ioOEWTXI/ZiR?=
 =?us-ascii?Q?QPnQq7CKHcAL2CsJjaHHwnKspRSVNkpiYs0BTPk18fOGnLkJrynUzKnDS8V0?=
 =?us-ascii?Q?SBh+zjPDODhBMyad0LXeOCxpO1HW1/xk/dLzlOV2ak5XqxJcOG7oQWLla7I8?=
 =?us-ascii?Q?3QGcBvZRV+acUCLwwsU9uKsMlhwktA31P8jZ/bc2Wr9T6lZXWvBbaFfHww9E?=
 =?us-ascii?Q?agY0cQ5IsvwZQ0D+932ai6kAzaY66YSDLIzNdMBzBurFJnuG6HDay/VVX9AL?=
 =?us-ascii?Q?oJUA6VGVbwLDrhNyVKm2iJVMblwRJNQev6yRwUi88oJg4/7Nr/eLRTz+gCRr?=
 =?us-ascii?Q?LbStmZlqcd7xF5p1pxCk7JNdKlVmIeMaNdOG1ZapA56BXw4E45L+WX1g8lx/?=
 =?us-ascii?Q?fPJWhuE6gKIUaPc6Tytx+I26+8EP3un+/c6eOnoaSu9oxq64PIFvQzfRvrjE?=
 =?us-ascii?Q?0pVLO6w2U6573NgHnTqKq56+p0Srlf650rxiYUAcKLx2vcpi+xkE3Gk9jd8h?=
 =?us-ascii?Q?Ap9ok7elwECwoLicaGhIK2F9QQ4sUu8xVWie0nVHXNZrrV9pk/wwu86Leldb?=
 =?us-ascii?Q?VIDb1uxE0zyRATY1h6Yrg5Jt9rIjm5g9rzxLJFmawICaOFyZNnQoTptCpFsS?=
 =?us-ascii?Q?bKJbhoV0/O3l+BS7htwK/RKUHvHLoxpnldY5xfClEHF/MqdsiYysgrwjSZRd?=
 =?us-ascii?Q?XhOXlZev04wuXiALbE9SCTO6orG8lrc2WczTuxNf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af769c0-a3ab-4ad0-4936-08dcedae4566
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:46:32.7307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3arM7IV4QE0ldUB/nX6BsoBZ1g1ysXYgPebs0YF5gi54Dr0aitX2EbqjPvPBWyhr/sNlrtxJlXOadumN9z3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8878
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

From: Peng Fan <peng.fan@nxp.com>

There is a dummy clk entry for i.MX8QM/QXP, so add the dummy clk enable
and get rate. Otherwise "__imx8_clk_enable(Invalid clk ID #0)".

Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk API")
Reviewed-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qm.c  | 4 ++++
 drivers/clk/imx/clk-imx8qxp.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qm.c b/drivers/clk/imx/clk-imx8qm.c
index 62fed7e3e32..466d71786cf 100644
--- a/drivers/clk/imx/clk-imx8qm.c
+++ b/drivers/clk/imx/clk-imx8qm.c
@@ -48,6 +48,8 @@ ulong imx8_clk_get_rate(struct clk *clk)
 	debug("%s(#%lu)\n", __func__, clk->id);
 
 	switch (clk->id) {
+	case IMX8QM_CLK_DUMMY:
+		return 0;
 	case IMX8QM_A53_DIV:
 		resource = SC_R_A53;
 		pm_clk = SC_PM_CLK_CPU;
@@ -264,6 +266,8 @@ int __imx8_clk_enable(struct clk *clk, bool enable)
 	debug("%s(#%lu)\n", __func__, clk->id);
 
 	switch (clk->id) {
+	case IMX8QM_CLK_DUMMY:
+		return 0;
 	case IMX8QM_I2C0_IPG_CLK:
 	case IMX8QM_I2C0_CLK:
 	case IMX8QM_I2C0_DIV:
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 18bdc08971b..79098623bc8 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -51,6 +51,8 @@ ulong imx8_clk_get_rate(struct clk *clk)
 	debug("%s(#%lu)\n", __func__, clk->id);
 
 	switch (clk->id) {
+	case IMX8QXP_CLK_DUMMY:
+		return 0;
 	case IMX8QXP_A35_DIV:
 		resource = SC_R_A35;
 		pm_clk = SC_PM_CLK_CPU;
@@ -248,6 +250,8 @@ int __imx8_clk_enable(struct clk *clk, bool enable)
 	debug("%s(#%lu)\n", __func__, clk->id);
 
 	switch (clk->id) {
+	case IMX8QXP_CLK_DUMMY:
+		return 0;
 	case IMX8QXP_I2C0_CLK:
 	case IMX8QXP_I2C0_IPG_CLK:
 		resource = SC_R_I2C_0;
-- 
2.35.3

