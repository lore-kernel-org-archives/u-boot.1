Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80083E63F37
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 08:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9248063E;
	Mon, 16 Feb 2026 09:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XhCSfSYJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78E0183C6C; Mon, 16 Feb 2026 09:14:18 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66DE880325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 09:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQrJuaAmS3hirMt73pdiVNRYCdOXT/VRrcdnJJSGcH7b+ndNxK/C49L8G9oJZo8678DmlyID/1xRIC2Lg7F4A1Oefm58iPNmOxAybhJIDXgtHgUrYWmFe/t58NMP5Aecxv8FPMNkJuw4IcyUHVaNFXTb+L/CIfW+7LSiJ+9RJvAx49rT6J7TS8vQ4YufatAlO6luyEQ/ak1+XGZzr4bmZT1VpZK7QxHV+X/XMccD2XR+qVEf0bn86Vp0tR0H8asL8pbKHrj6dTgGCy08cZNY35Z00j4qKtfkJP+PXby9sz4zm/XWL5sOWajmyADkIoTM07kZtj6bd3bue/6LCFj6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5zpZR8rOVMz3qcnX14JWCVyn6gov+0PHZZ/+Z/0UII=;
 b=k5hl4r5rojj3xvYXcL2jKoaHkoGpE7wUDgATe7MDNVmeOwkMMOG02YZ0+/B1N2pHhWwdIaEfiQMs5vrDvOd1KFZKaB6Xs9AGzA1AvoFsBQ2QEQSAvtorN1/sGVymorjwY45hlU3EswUjToarvclofGTq9QCMiKiZUq9/fJDowzMa+sZ1oXQ3goqStUpHp+doaA5xZpvr6KwnqpWDmwJY1GUs/GHDG/AN0XNE1KiN5L2ml9gGYxh4uBjkAb9Z5VlSTZJQGmvfpjxlpn3IvhMrXXhFoR//h65YhbQJXFkxxVB425ZMVzPp/LSnTxaXg2jry8JRACVYQG1h59+6ZGh4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5zpZR8rOVMz3qcnX14JWCVyn6gov+0PHZZ/+Z/0UII=;
 b=XhCSfSYJJWZjXAZS5Z/WqtYb/UBzYSJDyvilyOyj/gXR0E3XpsoV9bWax1C7cbdf2Bs4Ad8VsdpqSJMX+kBG8Pm6Bki+ttvmDEqi71sz2t4ni441SMsJgdLXZiFYD6770RKp0uKUZAK3WsbqVnBXg0qGHXd10PeLeaXHiOY5Mcc=
Received: from SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:14:10 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::9a) by SN7PR04CA0165.outlook.office365.com
 (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 08:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 08:14:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 02:14:08 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 02:14:07 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Frank Wunderlich <frank-w@public-files.de>, Heiko Schocher
 <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: muxes: pca954x: Add support for pca9848
Date: Mon, 16 Feb 2026 09:14:01 +0100
Message-ID: <72cadba2a21e9d5723d54994b898d8a6880042e0.1771229639.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dItq0WwcfW4Lcy28pVpoOZ6r8ERFoc06wEpzTJJUGrw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWROunhKdPP27WveB1z5yaxyaB2LZfwU58/Glv8cg44/M
 zsW94VDsaOUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAmsm4RI8OPCg3DGeubG7Vs
 r3PdrudmXq6U+I/t4MeN550U+9aGmasx/E95s1fsm9Dc4q7tZ0/22+96OfVvwNUHBZzNYuZ8QXN
 /1PEBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 434555a2-e805-424b-da4c-08de6d335c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lEZ5Xoo5GSotWIdAJ7WD6pEofT+BrQcWMzy4mIJ4PnrGZiT2WNzqMGZIPA3Y?=
 =?us-ascii?Q?0Z/gxPcOWMKGcTk9vsuh5NWlidAeOGx9eIgeVc+necl54eBf6WODMh1SJS3p?=
 =?us-ascii?Q?V0KrBPwJ6uABfZJa13ftaTroBSnW0Ht/rnzUbnWNnLhKE89Hb70zG06VplAg?=
 =?us-ascii?Q?Sv5zOG5EFXZhltbbcRHPo1z5Z1Sp3LYsbNvlSX/kc5K0rtJab/Nqc4dtnIjt?=
 =?us-ascii?Q?nckmCjKtLm9R8wIqOzn81wh6P8mAalrHI2SUP081xgMxGi9BZgSrZF4YG3LW?=
 =?us-ascii?Q?agB/ucZ0DyZyQ6HPNfc8S4eqibVsg2++O0Ed7oNlFkG7hQibFSqn6Vaaus2K?=
 =?us-ascii?Q?zigFt/OA2OSzPUhzkmSqfJaLtwGzMcgj4vZXTMZwYfqT3y+MUbPjKBNbXOwb?=
 =?us-ascii?Q?sF7CpGOgpLVTaFL0vsE5PP640Z4f54OJaVH4WRzS6plFH/L9NAvVPpAlqeIu?=
 =?us-ascii?Q?wrvRSP15ksRBwpeNdUpedW45Hn1FI7zxux3L0AVkvYgAE5Kjy0h+ua127ot6?=
 =?us-ascii?Q?abMQa/nZiz8VU8EAQK2jL8YAb10BVn+lg7p6Drt1sEzj2BxH5qWajfkoTjC1?=
 =?us-ascii?Q?9WyvhQyN4fSgIPA7pfE6GsTjEvk4ryZwCxXnSZj/GZUxyNZFCAEunUgejKOE?=
 =?us-ascii?Q?vPKijQMjzCJRJA5i5fcpna5ptTxFVXRRFQQii5zGVZ/+OXalyz4nytNqsUYm?=
 =?us-ascii?Q?dYlFu2S3Z/+km8QUi200/P0jn4WRVUDlnP4BWxp2oteLhHN3jhfMcevsD/sb?=
 =?us-ascii?Q?OqFfPdgcgNNEz9REMYuEdf0/nkC4kECv+8z3uG0xpGbGlaio9iZr9FtUwtVr?=
 =?us-ascii?Q?n7XkHhCW8eo7lx11xaYKK6aHdrnLddC61C/vyjdpSJ74Sdsr7J1QtnXpTNj/?=
 =?us-ascii?Q?m047ZTDJfT7fMg+eaZPU3eReTB13+23mWOvDm9mlhud8KEIADiCN9kHmQHZm?=
 =?us-ascii?Q?s0vOzYsO3LXLVS/n8vpOSd82r3PCzF862H1ECL7tOYn3m+bPZRfh8oqlnyn7?=
 =?us-ascii?Q?TCdcha2e4iNnpmOU2iDXpLHgCQoJTmvXspm8l2SPdZCO91vGuN6wXhtwkUVW?=
 =?us-ascii?Q?VZcF8sC8BQ/U/TjCK8NyJxrwgYuoJL7abjMquAsYx5Eq1p0ryR62QPXAUdyK?=
 =?us-ascii?Q?uqSiZqGF5SrSUNEy/62yX8+2u7A3D81yncaD//LmzURDvGbT/T/7uNDgym6a?=
 =?us-ascii?Q?Z9XGAF/uBYil1kbEwhAQY9CWxlaQdEcGsVAI7OUsxPvS+yQDSBtjRISwjcae?=
 =?us-ascii?Q?lJn0RSUknyCrWyG8NDfrQclVkMBv074ZeALrW/iuGC3OOX8E2cboLKC7vrlT?=
 =?us-ascii?Q?1ddW+yDjGsSII30Ps48eD69kXcea8va3e6gEN91i3Z+ZDqIsFlFR3Ezgctr0?=
 =?us-ascii?Q?IOmR3KwKl5cZOMX5O0AW0lZNGPCsYET1XOBWIAkrgajISwi7e8Xcrq7aebCO?=
 =?us-ascii?Q?FEnsOoUxL36UfXx4aUGj13APPYMJyYAKTn03so9NnzG8MwU7fKmTFPrxk56j?=
 =?us-ascii?Q?Xgu/2QR/EC8Dn2st8NlzPCQWv2A1fy2Kkq6E3sy6wxvqUfP6mWASFR8EcmB1?=
 =?us-ascii?Q?YkseegclgXszsq3m/jpkHWE+Xc9NoISTXFeOimcx77MBTLoEDIqJSaCJSei9?=
 =?us-ascii?Q?8hl2+B/+uv1aUXwlo5PlRKU3z82pmXzhRsie3mKuNvbaBtZg36wLgOAwLg8q?=
 =?us-ascii?Q?9Fsblw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FgaA4VyA5LL6nkyl7q5busIV0wujHK7S7+KIzxXcQeXLvcS/zqg3RRpQsMA8NMv7zuqHcjE8TrcUPax8ff0RX69y+/xrhpzN5Z0jX0VszGgPOOGJ+oVK8q+HyH2tcKTf1QyoqKoxV2nLm5/SQVGiSNJMzOOHaY29mLDYv6+FvaBWUdFzk0i5IYeSHyM5B1PV9lNKU/kIMg9oH9rw53kNI764pppWi5lm2FC1n7DKFvpC2I69o6Q+KgNdanRFUMOyot2PWBRY+fkQdV7RFYx8XJQimltLqzr/yxT1FNTtvdcZZZBdjGLfU49JxzivthQYLQfSEoOw68Z/t0BjfhKtuL04khKny5iKQFL8n3R8oJnE45RF1ru8Vu+Z9I304FND14FMMMIAzvAdjBd4PiH5h+UG+ozeMbX+W5r89PX3y8MsTb7IzOdKP9Ga3RlQSIuu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:14:09.5151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434555a2-e805-424b-da4c-08de6d335c7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756
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

Add support for PCA9848 chip.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/i2c/muxes/pca954x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
index d13947a0d9cc..3e933acb24bc 100644
--- a/drivers/i2c/muxes/pca954x.c
+++ b/drivers/i2c/muxes/pca954x.c
@@ -28,6 +28,7 @@ enum pca_type {
 	PCA9548,
 	PCA9646,
 	PCA9847,
+	PCA9848,
 };
 
 struct chip_desc {
@@ -106,6 +107,10 @@ static const struct chip_desc chips[] = {
 		.muxtype = pca954x_ismux,
 		.width = 8,
 	},
+	[PCA9848] = {
+		.muxtype = pca954x_isswi,
+		.width = 8,
+	},
 };
 
 static int pca954x_deselect(struct udevice *mux, struct udevice *bus,
@@ -152,6 +157,7 @@ static const struct udevice_id pca954x_ids[] = {
 	{ .compatible = "nxp,pca9548", .data = PCA9548 },
 	{ .compatible = "nxp,pca9646", .data = PCA9646 },
 	{ .compatible = "nxp,pca9847", .data = PCA9847 },
+	{ .compatible = "nxp,pca9848", .data = PCA9848 },
 	{ }
 };
 
-- 
2.43.0

base-commit: ed6e970569b45c02a354f443502ed7616e0b0adf
