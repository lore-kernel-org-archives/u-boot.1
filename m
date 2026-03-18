Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8106910775E1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1206C83642;
	Wed, 18 Mar 2026 17:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OF6uIBWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FF09838FA; Wed, 18 Mar 2026 17:48:14 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 911D58352B
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyPIGesDme1ubXWTcqTYMLAGumjzsy2HG8Sl4uBdngxjO4SZl+vBbVb0x09lo8n37X+R/e1fGzq7Z8Yjyx9o848AtnToobkwIIKuez3uF/pBjj2VkdBlov7sKeMIbvC3WMgLksEH3EC7NZj56XwvHml4rwybY33LLiYlWih2rnNvBuVLkDEwMlDsK1Y3aMX1zRjaLzocOgZTVr+y+r5ZWi5k5FlfmR46Z3qMnAIr8SBRZ+WtgEi9umQetoVcXC9hurQxmH9GkfYglMZxiFEul5sfHM2KbzXGiHqwHT8Btsyahy96rbtIikmPXgE3NfQ4RaAiHK8zSinWKaBE8pixYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09kCXkzNgfzCEP7pyRdrGu90UzIg7yW44qGlQWU33eM=;
 b=qMpEvi+Ze8RS9T3NiWPnDg2Dz53qotveSUgl/kTLIBRaFulHH8u9ssxauYb6SQ8zofeob3z4WJAvRx/yU4e5UzFx06ZDQJRwLhYC/NwomPp91Yy4j35Qc0o6wByY3XDWnmv0NMtBBfTGWuCy+XVv00WqeXnj7nR4p1yeWuwnP9C8iVUNYRjPVy8uF+X3hH0SmhX05kpUehblUd7cfgsPIvIiVuNIhkWks2IFx2K0zT4Os/zznUJun8+mx800SqB9wRqwx37MsTGmrDquUTqmaTzjgIwlmCqtwCCKO0SdxOBsOVVxexfvycTlQSUPnKY1XVJ8+fpgEALXOcMI55BKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09kCXkzNgfzCEP7pyRdrGu90UzIg7yW44qGlQWU33eM=;
 b=OF6uIBWfMhWeSZXAPh+yhE2+wxbqR1Ocek5DMH0ajmLlXNY7Bl/WKqlCKlb3Ps3/UFjUs3ijcClmNZsZUqnScPA8s9AiBIrcgCXgi4RZusFxnaEEKCB3ejI05c4Mr4D4EF8C5cq3B1MpfPbwFSeOIBBHj2VWDTftPshNtUktRHY=
Received: from CH0PR03CA0409.namprd03.prod.outlook.com (2603:10b6:610:11b::17)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 16:48:08 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::9a) by CH0PR03CA0409.outlook.office365.com
 (2603:10b6:610:11b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 16:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 16:48:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 11:48:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:48:02 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 11:48:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: John Toomey <john.toomey@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shantur
 Rathore <i@shantur.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] efi_loader: efi_var_sf: Do not fail on blank SPI Flash
Date: Wed, 18 Mar 2026 17:47:54 +0100
Message-ID: <5309d3fda1bd6b8151358c3889525795f9e3aecd.1773852472.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=SVh73o0q/FeEAM7uyV6TL/FYX6BmfevtB6nWGSCkVTg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTuum6t/Vzx7NuftnYJkk75h2vkdrPXW/uycVt+fr33Q
 bD0C87mjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhI8UyG/9FdCvcKhC9JdrD6
 e5+cE3yxin3p431Zmzx3+t7w3hKY/ZqRYSHD1Z5HT2fNeSaxTuz0nrzw1zv9koTktrSeyzitfLJ
 lGhsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: f20944db-fba6-4638-e320-08de850e214a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: N+kRSxX3E6AkOXpER4a+PKwtxR8F92lpQWt4mkeVWb8csBRpEUIYe8TpaPrUFrdVfUz8w/NQNdlHI2vnAJbpJLGV8HSXTbgdLWZhD13ePXiBUwZCZoB6pR+yqrQTPvsx9cSpKu/og9rNoex6a6RNej2dp7OB1l2rb8ImhMAI8pOqG+tQYmXCgMN/pMs69v3HLG2lNrFChXEy5tr/Lp+J7HqmKurhoLNedEDTGQyLwQ/hRwii39okkRB9RreCXQAsV0apsz5/Gu6YE9mUtWX6ds68Uyk5SmqZ3Xotwh7Qub+ucSC9cvIpQPPlln+7dZwIlfrzLQCj6DigKkHO/CID7AHMPhjKRXf7ZLGOuRdvWspo1c1HbhVO+NukphoWDy70+s7wemmO8UwjvGzJBl33e9lm/j/mFCBrVa6mET957LfcqHmmo0V42E3t9YTVCoTECPdjKJBaWJfDAEZDwwJjPi4iaY+ZS5x+HM0otn1AG2OFcbvFGBioXcbGkDLXPWJEfBrz/aBWmF4yUlB/LQGi6GoC04F3NDeXBE+/1sbO8E+xV9TO5Ei1jmJMZpd/yJ+wWphlnXvoR+A2ncgkB3VdZm7XXrGlSCpbo7CYZ/VvDHUvyIb0Bnaw1uPYmhJNa0jeB6w0L5/c0RhWG74DS5lmpgJUr5OBwooxdEcdgcXnEB/3PDn4o+j5ngwhYw7/Swtq2+wszrlQxvPWckLb8qVWNkv2RrbBsef51bNYYoNnLqcIJKIuVdfX9XVpMhfK6vuXI9gEWoFg72ESEg8D0nYvEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fJRgBTikV0NyHQ1oJinEJ4V+eKLBb5hDK4BtLBCGeQbLqjnqzKpK0YzbqP5tVXfdiVE1pQu62cXrcqSqfetY5lmf6QjVNFMPA4+znvxHEofBq5S7ww66Xy9vVXrVrW80BatKiQFmKaYGR8SfRikFeZzYF46asdkiid9u0bWzPlueicU4ak9iFFChfHFUJnsgh/4JZAVMKr5AEQowtgsYXbQwAG44oOyBD5pmVOa0zEA83nqwlPfXN5mQJhNS26skTrUBvr0ZRnejAHEwPKHHDiGVQOu4f2puj1nmczzpOt/lN6YcCKsh8bwUX8pb6lAJ9S9ym9ct8rPRnv8U3tVrLp9xEh/wvd4Q2YRPkd1XB7emuln+no/Lzpwc1EpA6/fVJVZRFlMu+crc9SmG25xsTFjbGYGodTHDOPauZLWc3M1qeNKTQR3Mk1j/i+hjEiUb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 16:48:06.7423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f20944db-fba6-4638-e320-08de850e214a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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

When SPI Flash is blank (first boot or erased), efi_var_from_storage()
returns EFI_DEVICE_ERROR because efi_var_restore() fails on invalid
magic/CRC. This prevents the EFI subsystem from initializing.

Check the magic value before attempting to restore variables. If
the magic does not match EFI_VAR_FILE_MAGIC, treat it as an empty
store and return EFI_SUCCESS, matching the behavior of the file-based
efi_var_file.c which deliberately returns EFI_SUCCESS on missing or
corrupted variable files to avoid blocking the boot process.

Similarly, if the magic matches but efi_var_restore() fails (e.g.
corrupted CRC), log the error but still return EFI_SUCCESS.

Suggested-by: John Toomey <john.toomey@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/efi_loader/efi_var_sf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
index 6eae8d464645..a1dc81e17434 100644
--- a/lib/efi_loader/efi_var_sf.c
+++ b/lib/efi_loader/efi_var_sf.c
@@ -98,12 +98,15 @@ efi_status_t efi_var_from_storage(void)
 		goto error;
 	}
 
-	if (efi_var_restore(buf, false) != EFI_SUCCESS) {
-		log_err("No valid EFI variables in SPI Flash\n");
-		ret = EFI_DEVICE_ERROR;
+	if (buf->magic != EFI_VAR_FILE_MAGIC) {
+		log_info("No EFI variables in SPI Flash\n");
+		ret = EFI_SUCCESS;
 		goto error;
 	}
 
+	if (efi_var_restore(buf, false) != EFI_SUCCESS)
+		log_err("Invalid EFI variables in SPI Flash\n");
+
 	ret = EFI_SUCCESS;
 error:
 	free(buf);
-- 
2.43.0

base-commit: 85854708c4d707d9db8ec84c11e1686a32198d91
branch: debian-sent3
