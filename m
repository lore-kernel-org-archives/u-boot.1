Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ACAC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 16:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40042838DE;
	Wed,  9 Apr 2025 18:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qs7PNi3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D93B838DF; Wed,  9 Apr 2025 18:26:10 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CAC9838D7
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 18:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0kB2CG7ROmMHsjOt/B5atX2sswKl7i9YXVKFV5NbJDBzztM5nIe4PmrHfAItKwdIX8D5PHUuloRGIfQlchgSAuJo/zRVk+3Fwk0AJMMMoFL7AGhiT1DwKq64M1fldX3u5avGxvFloDmMXRc+3yAF/1GSuYO6dhIMXujk67g2VeI8o44P/Hgm/Le4Anv/cUl/S+aEuqbHnYLwN47scLRUVQ34fITfpuKbGXKTbmZ4h7fMh6s1D3hangWHI7MNGacts5sgGN5DgXSFBZfCI77MLqyxyxP2zi+k4cCmdt2keXAdg7Nxq7uIXZZYmWcTzBCTKEcpw2j8AW0k4ugcLOGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+u3+5XnQEpp6ZWf+EHYB6gu06APU7wcsPhVpWZ+0yE=;
 b=GHnEITJj7k4yHMcTB0lqG4OcZf9l6TDAY6OOGY5jlfTYtpXryRUarxMhPUZ+7m1ap439zpXSMVyzD4om2KW6s0Ga/HOyghhauS7w6YDCJ/S4ed7c3mWsDUD9hcSgLS8XRbOk/aNotsklDQn42vKdMg3Tm+TNNX9R4+MzMNlat5SvWmScNTFjWF/1w5UFHn8aYSMD7RGsPTy5nm+RqdmP2qBtqFuLw6xijtq+6kAy8zNBVYlezlBYTUV5C+gb+gpocKWQQI7ONhroa7cfgxnzX2+DmSjY62PflaD+4OAfxPwNMxzEaCcje0znsFa8zQTsYCtr/3WLeePleYnroTW1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+u3+5XnQEpp6ZWf+EHYB6gu06APU7wcsPhVpWZ+0yE=;
 b=Qs7PNi3WxXzQf27NCaEclD2bHyrYRu0VeaO+REHCANDormF9ITwnLoeMq/8r12CcDxgJoO+0fu7A9yM9nVAJRtHGpfw32YWw9h022VU4ddhyp7e46bRD4d98z0si2z6ZLcHzeRTDzKk6LGcnOOTMLWXmvUsLOX0qwQaDdb9j6MA=
Received: from SJ0PR03CA0126.namprd03.prod.outlook.com (2603:10b6:a03:33c::11)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 16:26:03 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::de) by SJ0PR03CA0126.outlook.office365.com
 (2603:10b6:a03:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Wed,
 9 Apr 2025 16:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 16:26:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 11:26:01 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Apr 2025 11:26:00 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>
Subject: [PATCH] board: xilinx: Store board info data in data section
Date: Wed, 9 Apr 2025 21:55:53 +0530
Message-ID: <20250409162553.588285-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 171b84a4-da6a-4377-b10a-08dd77833890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?amtsppWTcNKVfwf8znDVSGFtA6Oer/eyLxjB4WinSDYPWx/Nn3gbOZFcaclB?=
 =?us-ascii?Q?6lgdi8tg1gU9c6K4IjsZ112/cfYVA6TEjafTYEDxx5pgjFI/VLuNbQujtovV?=
 =?us-ascii?Q?cQwrW2+FkalWP+vbL7hzRcNIyPx0g4VZytRehPA2sp+d8F32WJnE7U2CnC/B?=
 =?us-ascii?Q?i3fitW4Mp6slnH6prd9RenP4qhC1V+pnl4c9DqU+IUEY5pOCblqKDKUBvM07?=
 =?us-ascii?Q?PuQ6pWTE9yGz6NNTus9ot1VDdLAXjh+zi1VjQV7qPeM2rCnurDJRpmKoDHjk?=
 =?us-ascii?Q?H+VENUDypvIoZQuMP6Vvv6PA5SKe580G7aWGPhPsq5ycx/lVCjJwRO7wS7V9?=
 =?us-ascii?Q?AYmF8UfjE5UOf9CMWHU8mCdRmaUceNEV6JFGHFdHMLYCmc7pAagCRIPjsa59?=
 =?us-ascii?Q?H9LJJqSI9Axtsa+KNaJbMQw8PsU+9uixswSWRibmSzfVe1A7H2xbXrGuVrcS?=
 =?us-ascii?Q?l+TlJCxs9pXxqd5r+hPw3RVtrsLn6ytoE9e0ewvHC+NG4zjIASWwysWgpQN8?=
 =?us-ascii?Q?lSyd9qLq+hSmpqneTFneskSrw+iaUYkOTY+b5lsYQLCaRRmnMZll4E0RCjJ0?=
 =?us-ascii?Q?Lebgm5QBjMcESTVfJjwujC3px8gzCkUhWpKcbhGi6iAtIZiG43yhuBdOjmZr?=
 =?us-ascii?Q?kUFNHh5Ek4IQj2eC9Ff6thZDnEv4yreAA2R+aZ89VHo9IJHp7vL4XT3KQcJz?=
 =?us-ascii?Q?Kkp3LiNjeBiocSi3pZLoJKON8IyEvLvNapYo12gQ9Chx4osgjSYrJFz5+92i?=
 =?us-ascii?Q?RPY+DYg264xB+4nQv0MgY26Dxgo+0ZGFoWW+voy4Sgdw2KL9u64O0c+hH4rj?=
 =?us-ascii?Q?rRVi62nSagieCvZUJwS/0TMY9jKVL0kEy3RjXbJ4e1OYCPgNVK+L+/EiYCrL?=
 =?us-ascii?Q?edbcg43vdd/dmJz6cFCpFf5Ivs5WPz+434D0ou1Ubs+jDpT06SkgW+nZ/wWk?=
 =?us-ascii?Q?oX8oNlVaa7VlRF+GI/7KNjDE7cCw1YyGYKF54kcDBJi3hw5WYcVoQ5Rq9Qzy?=
 =?us-ascii?Q?ma1+uAuwMgbE4dioMkW5YQy1O8ZSXkRQNs6gYLSgNh3NlwShuxciWTuNZali?=
 =?us-ascii?Q?ipbburWCK4+nbP6gXV4cws5a4+iwZLIkiO00RawqhM352pkGXXrmoTlgmgw1?=
 =?us-ascii?Q?Hcz9+ecSy9UUIVMkiAnX63vgCMUiQV5rassMFalRNceyketx0hG6MNLF5yZk?=
 =?us-ascii?Q?Yot4RKTyNCbavQ8fzssdOQJtz6OR4YTYu3uwma0o7t458P4fkwLJxlYshben?=
 =?us-ascii?Q?k8Y2+x4TzLliR576LWAqL6lOkGebdsU88SYT7cTIRuAihC3RjCMl57ptHyO2?=
 =?us-ascii?Q?+rpMnh5Ajz62pYTMC1HKrDL0yzJ6PD2qiG1Hk6F/fV6DmHLbNDNHTC7OtsoC?=
 =?us-ascii?Q?aGY/d9bTNMJktlVRSWtu6kcVvZ05VVK+u035vN/EOFrDtNEaC1en4YzPhVf1?=
 =?us-ascii?Q?QNv6LM0T+lmnfA1h50qAG7oFUYlgBFJacwdipV52zmWfZQ1H6JTjnRK9AUxb?=
 =?us-ascii?Q?ZWmtTuuEsqIMLBo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:26:02.8656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171b84a4-da6a-4377-b10a-08dd77833890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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

Line 171 in README is describing that before relocation no code
should use global variable because global variables are placed
to BSS section which is initialized to 0 after relocation.

In the case of ZynqMP, where DTB reselection is enabled, the EEPROM
is read again after relocation. This prevents the issue from being
observed. However, in Versal Gen 2, where DTB reselection is also
enabled, the EEPROM is not read after relocation because it is not
yet wired in board_init(). This leads to a situation where the code
accesses an incorrect memory location, because none is really
checking the board_info is valid or not. To fix, move the board_info
into the data section and also check whether it is valid or not.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/common/board.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index deea6c71103..8ffe7429901 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -80,7 +80,7 @@ struct xilinx_board_description {
 };
 
 static int highest_id = -1;
-static struct xilinx_board_description *board_info;
+static struct xilinx_board_description *board_info __section(".data");
 
 #define XILINX_I2C_DETECTION_BITS	sizeof(struct fru_common_hdr)
 
@@ -468,6 +468,9 @@ int board_late_init_xilinx(void)
 	ret |= env_set_addr("bootm_size", (void *)bootm_size);
 
 	for (id = 0; id <= highest_id; id++) {
+		if (!board_info)
+			break;
+
 		desc = &board_info[id];
 		if (desc && desc->header == EEPROM_HEADER_MAGIC) {
 			if (desc->manufacturer[0])
-- 
2.44.1

