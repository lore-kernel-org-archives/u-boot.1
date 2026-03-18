Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A656FCD0A7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5578428C;
	Wed, 18 Mar 2026 05:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Wf7225iU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED1F8415D; Wed, 18 Mar 2026 04:02:36 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 390EB841D5
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lx7jIqMIBJsG03eIkRRAEc3G5xnXCgQlvdIitDnEt74rSNYPj25xSnkEoXqbXsq3jsHtrZdROl03R7TPPFFWppRkKb1Aq7SuVK+2lyMRx/NDatZTYD3uWmcl32jaNBBksL/cnPqfzXfgUsF+uJhzDRCUi0o4r4PA01CsPFlixanbRA/RNFx/sRWm++C96hEs+kPa3C1sTSymM2W8P85XfxqXakGA6QbJy7tcmvSA1OJ+gm+Ghy3DAVoDpED4WJ8PISQvOB7YEZ7oZx42NxfR1DFGtKvkrVf47cDgmV1bPwU0qJtsrThhizaqeP95rVLid27B3No7RLGyk3czAUZNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6Fzk34zCXgfmOP4myVDlkRjNL3NhjDoA4TPPNJNhWY=;
 b=yFBUgVfjIdOC8FEWzK6uDGwW6CYXdR9N+GloOO3rVhVP+mjTn6+umqba7nXO2Tx/i2MBYdm+n8oQFtQi8iL4lfqMV0+m/W78P6qsvDogl4L0hdSvFjmRts43vY+//cLNuzoWXkfsBhVGPZpFa91XI7FsCxFjLLt80+rsRuqNud7HKG1HAMfcq2oGXLTB696UTNsPaTGm1OpR895IrMH7GOFCH52akUiafhGFY+6okSVdF8ro/9m9e+MWsfjqaDXSM1cF+OUeUhTp3yaYBRHv7SwLY0xzwaOAZ982aB/0QMa7q/eBfAtYLVfenDl0SK1SNallGIZQVPXkLny7Fv/0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6Fzk34zCXgfmOP4myVDlkRjNL3NhjDoA4TPPNJNhWY=;
 b=Wf7225iUN7dI0ftwNbg7hREkA8bTdv2iM2SrsnP2Ou00bN36TuRCotoi0q+X3FXDDN8hVAyn3Sgvrs8EsAROSOlamu3dzuU1HoPPzGUc10zgpp9ZTIg8qu8xftCggiVAJ1okHEB3CA2uzr9+EJTor9p2DRt/3hI/sjoB55MG2iKME2Rjno3cWkyj6Ff78660akWlmPMcxFbYbEMF2Lgw9/lqAlhrJcdZzUrqBeM7iZlfs3cylX6TCufqYfkzfYbKmAcoyYexgh6WOkCv5CANncfxIEdbzumcZ6o3FY7xbsyAwCD5kRdc6NDqT3OypqhEZGyRLBH+8uqJyBlwYosJcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BN8PR03MB5092.namprd03.prod.outlook.com (2603:10b6:408:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:01:02 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:01:02 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 3/8] configs: socfpga: n5x: enable CMD_MTD and SPL SDRAM
 support
Date: Wed, 18 Mar 2026 11:00:29 +0800
Message-ID: <20260318030034.25889-4-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260318030034.25889-1-chen.huei.lok@altera.com>
References: <20260318030034.25889-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BN8PR03MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 2908903e-7347-41f8-c544-08de849a9673
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: C6Df+o2yME1MnRV1GEWt9ZQF8mWtiiZXDUxeEDjrTuznfYWzcw9cSOS4SYNBU5AFVXkGxkhTsg8m/Vx7ycRGVBHtHb+5FBsZbHfk8taAq1MC5PdZa1ZG0UsXW2KynGnXJ4kDKmnhnhaO7pT5ZM01mcEFzOxo886PPdLWt0LoqWYar4UZ/BCZ9gCJ1ya4sf+PjzJgX3XOj+UZrPOMBks8jlSaEAfjbbzF6Etq9/E6yMr8obEBFPBDMOZWMuSZk5j840I+mBqaoOFJ6XK8bnvUod/4p+9aF4m112S38AoHP2c3MiJ7uTx+b2/Df3GHezoDbCzwepGc0uTpsVaBivGhQi+1KHLNzasXMzmmi+dEu7S9gkY2yBUB/Kxtko+8cvj4xAXw6qWqKscFZkVAfkhqcvY/k0VlMB+npANOZ8dZlTDxGAJ8aqejJB1ReP5ccNX00YeDAfkt71EtRXmWEx1sCD5gDKwNkXemEC02A4VmdqXYOOo8njUNiffxMnlvdQv/fwmgzxqPkYuYafSzVT49aQ0bYmKsRaaidBAM2BmvH/JbPc0g6d1HzcLVXD5zFCvfgKJRl0YG6LiHRDXnzzRbNlW9RKklqJwJj0M0aaGWEvUzHFO1Tyue5l0L1tfvyqnEJtMMCha/w8+3y7wd1G4D0aSOP0UUrVIpYuoAT732cLY3TuuGi60TjNW4dIInR2pleSNTQ0dLBIMS8wge5GSpEvzKQE6DghI8ZPjIDy77tcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xvSR9+eKHs3fqNFjpO8Meqkwst9FY0Tl0TbjezfPjG4ktWJbwFTeV8QyyIs?=
 =?us-ascii?Q?FA1G7+ftKwCgn8f0H4E3UU+YGkYpFnczc4VElaIwR3ESw5jTNq+vmGdLfNvQ?=
 =?us-ascii?Q?wTJDfDI4HodpIxneH/1afZCKFI/qhLnfzL+FNXXAfkKtdNeZiSTHEqir/BZV?=
 =?us-ascii?Q?buc74RO1SNfLOV8AziLsK41GnPhb6y/wMVuj8t1N9txTiKDilCBFKpHpEO2H?=
 =?us-ascii?Q?HuYksnCrfCxqLyRIJ9OtC5XQwYj6/man0ciCnyVEMORh0Z6lqB7xoykyyvIZ?=
 =?us-ascii?Q?YkZ0/I+JQw8y8xwF2ubI6Sl7Ohobl+ARmPvcN3iHMo7d5ScBygdF79BiH2lk?=
 =?us-ascii?Q?q9vnNPPsyVsYq5VZrs8liZ5pwHJPkDKZ06N1tK2BFHOqSzfA2wxPnVBU+Yzs?=
 =?us-ascii?Q?jf2/M3P0n5doO0Q6dvStsW1fOWJ6Y+ZXsf9HrpYsYTIKEC/or/149Db9i13W?=
 =?us-ascii?Q?DcolE3Y0PhmsSX9s2fkksqFNzd86darJLGv71zMvbDU0/oVyw8j1HbX0WkHe?=
 =?us-ascii?Q?ZIhmEUcJcUdz2BzLs3p19nEEKWGrAgP5vM6esgmOWvCF1xn0elph/f7gtBZd?=
 =?us-ascii?Q?JOTRS7o/20SFP1vI07fvQrr/ae/xrkN81Wvn8XR0MCCzeden0/DTtId3OXES?=
 =?us-ascii?Q?WT31FKKa8/+E6bgnIPbzLbESGR8t/T0nLsbMeVo90JC++X1GBvCAnk3WvKi4?=
 =?us-ascii?Q?Je66TjYRhxB/ZcsxhcHLwtWZ7V5OG3RAu2aHEIV6o7nxE1Xd0N8eDv7TlgDs?=
 =?us-ascii?Q?osGi9ntjzPeH0BLkkYuOYb5+pIoNfgLRiCdk42CYmmXCs0bkD5/F7WsRjDhD?=
 =?us-ascii?Q?l5Gm1WNa01xd5MQOQdURDJpDE+AXVjP/G4F+hh/G8UM6EtA9XmnpHRHAeptp?=
 =?us-ascii?Q?swisVSam+IJRgrFUjyHtUsEgxUDmvIY03c4Xx7PEgo3R+hNC7wfFjZm87LaG?=
 =?us-ascii?Q?jAYX/vUswlUNP0ps7Z9tcXBXNYWAANXPbcBRI83XnznN5VVlKJ6aeB5PDPyo?=
 =?us-ascii?Q?oEm4xbMW6O6UTa4tTQsCa344JhubdJ93Qb0WJPnHVchcjn2864k9xIxWZY5M?=
 =?us-ascii?Q?Ip/ykoGonU9oqsRcBkRInYtAMwIw1FXn5tYQvkL8Mrfhba6chPRCuQ25MTmH?=
 =?us-ascii?Q?835oDyvZtWR5qUlg9MkWup5VoLsCmzLpWVosKuAXdL+4E5ikO2maPy6pEqlF?=
 =?us-ascii?Q?CD+BwRGsmtE7YZqLdU4LVaR4ayIZUMU0tT94BV9SuisTuBjEcNJqzRLsquE2?=
 =?us-ascii?Q?TduHx492LJW8kkPwRQGzgUgN/9dXQR+XLVI1SwuVgb3avMsVPvQek+4g2iVz?=
 =?us-ascii?Q?NZAixb243kY5ifAPVTH3dVV+FctYzmOMrSqRPK1JPQGe9yCMxZlngvr8tRsO?=
 =?us-ascii?Q?UHj7e22JD/EjiyI1r/wnEEF3RprZzAcvNDkc/hykesqsNnevHEvjqWAYG7sa?=
 =?us-ascii?Q?PCtlC05LIOGTbGjZZLiBCGaH9Q1FSQ+TDOt5fkbigTamiKGcEvbLW9zVGNGu?=
 =?us-ascii?Q?3S5jOFdZOjMuzVto/z1RG2PGTjk63hcraoSrMoNeeT3Ronz05RainZW5javg?=
 =?us-ascii?Q?Yc8kcNUNYeRbj7QuilCwdO9zgR02CSmRmNJ+5NjqxGjfCJtfgeq84HBfMNFv?=
 =?us-ascii?Q?IxxzAHUXXSL+is9GI7Zas5pPoL5BnwI8WlcB4P4I8Ou/MFM6kKGLEvv4M8Lx?=
 =?us-ascii?Q?JNyVqpgs14AfHmUc5x+juhCfUMyyiajNvuP3wGnRo6yjxCbMz50t2qWyItNS?=
 =?us-ascii?Q?qAw82e8hF8S9GcH8TOa0p/K41W5qaq8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2908903e-7347-41f8-c544-08de849a9673
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:01:02.0735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObdwsixBP94Tu0sHr7RIIAWTfMXKAviVu6cCRKGQ1GzbHudLHAj7t0vtB+uVCo2Nuf3zYgZg+19MapRRioL9UhG5bJMi7O4jrowd3rn5EUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5092
X-Mailman-Approved-At: Wed, 18 Mar 2026 05:11:17 +0100
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

Enable MTD command support and SPL SDRAM driver for the N5X platform.
- Enable CONFIG_CMD_MTD to allow MTD operations from the U-Boot shell
- Enable CONFIG_SPL_ALTERA_SDRAM to initialize SDRAM in SPL

These options align N5X configuration with other SoCFPGA platforms
that use the same SDRAM controller and MTD framework.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index e32eaacf0ad..7f567cb92a0 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -56,6 +56,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -69,6 +70,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_SPANSION=y
--
2.19.0

