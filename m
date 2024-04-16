Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5871AC04FF8
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 06:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAC288278;
	Tue, 16 Apr 2024 08:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W14Turwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E51A882AC; Tue, 16 Apr 2024 08:55:47 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE0DA881D3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 08:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtBxVWJG3qcoT7VPRy6lxlfV9cWYnSJ/n6CPsUUktbJlwVyGkD3GzGKH6kGQv9eXc2fjQWKC9YVjHNaneEvprjFm91x6uVfMREdugWqunyGvA3dZooiFJw6agpms/yYEktt8XT+n/0Vr3LUdQYP65kKHCR3oTWB1LypzW2xw5QnbE5x0n3T+j2c89Dd6pHOJsdG0eqEEaZxRuXMQxFOlbQFi+lJTBHUTLESbEwHHbkWngcPnvke+wgpZk2i7+Ru4gY241k0iVc0fPrwXu0ByyXvlX1KGP0tNYc+siEYW5cRTv78pCuMic/Lb8oTBsLSzK44gKyQCV2jqF2lSuXdrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3yaygZb4Btw6czwQr76CgtXgyPoYyjidpaKKlVwi94=;
 b=ZbowNgtBZ8FkRQLPPyvRsiUTnAkBDiyr1voIkM6pu34BvFDFd0MJfhB3fC3lBQJu2Q9JXClfzcXq/qPJgq7Zfh4mL+zazC6SvDaMLLpSyjROyU/WxsqJMCVxxgi0z1mXfdST36Dc64ozosDgunalSyx+FaRapjeT2zxD/GeI6hq42+V2MDpxEJVjip3E0NFnMG6Mrbhps+z+a2l2dwaNfsHTaszjrjh+ashTEKDdInPHhJCnv/2JfRjxgg0VtaygZOvU4kGgPccf7MNTEnAW3XgWZOSekcNvY8YM6/uKr/1rdY77EH5tmM4m0GN5DGh4BjeHhvMkxi/DS8WQ6fnPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3yaygZb4Btw6czwQr76CgtXgyPoYyjidpaKKlVwi94=;
 b=W14Turwxmb0P44LN41jd8vU5b6l5pRdwdj6zeRQGsVNC9hhX+rB5fJe6VOSoOR3qY3WVH2u+6eCf8HUPgP03EsCbBabqluGR94RTA7Ki8BTSpTbblfGE8H+ROYMSV1NJPewzmGd0472wF7Je3uNWSKkDbGay69cSExZ0pwAn5BM=
Received: from BY5PR17CA0035.namprd17.prod.outlook.com (2603:10b6:a03:1b8::48)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:55:41 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d7) by BY5PR17CA0035.outlook.office365.com
 (2603:10b6:a03:1b8::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 06:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 06:55:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 01:55:37 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Eddie James <eajames@linux.ibm.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/5] Kconfig: Add missing quotes around default string value
Date: Tue, 16 Apr 2024 08:55:17 +0200
Message-ID: <e7206c2695459ad0c1a1f0040d9bd286c2fa109a.1713250508.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713250508.git.michal.simek@amd.com>
References: <cover.1713250508.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ZNkfZezUcA0TlnAHPpBP41YOX1mh9bkFXST0I64iUYE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQ5hZvWPIs6/T7ayW9atc26tLRHc61lUe3Fw3cP7O7v+
 Otafed4RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIdTeGeUYa7u9KC/JlLp4/
 dufgnldrr/i8X8awoPviYtV/30NLX9hOSzgeZ71m6l65CwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a81321-3c66-4999-1b59-08dc5de23aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpgYCua6YqLjxiB+65QJb8fXlEUCb+ss4wBH4w5ZUj36DOJuUNnVZJURb+Ei34Ls8ioc+TbBWGkj5qehk0IbtXn6MJ+auUynJJslU+nOcxi5Vl+F2L5DAmM1FFe2mdZSaxxxEJn9k2JC2Xxv9P7Pbx/Ri5MEmdWF1FagfK1V9F6AULme4itDafr59l0In7X6XDbH5u1G97vyUrwu19B20w9sSNiANQBe67RAvWfGYRiuu6hd3UmgRHOoqCJmB6DoG5LQZMLU8izU7uvs9sIY8v7nh5j2YxV4hsCiisqN6X0GiWEpivL8gVxCx10OrSzlFET5U6Zw6PW92WZA7xMNNZ68tPZ6q3Y6XeDZKsUSYpoMLOSdhAtD5rX4EYOa1HTIxzK5zOtlalMHn0v3bLdNGTp/ux3L4Xew6l1jrUAEfMRDwAcs1ecIp1uS/hyQwJrlyCkPaPSJkn1brSuG6kSNFXGqtxkWMHtOTTEIOoQ/23e+11oKeGBBXZf/RE932WjUOriKmLrmvRQdZwE7v7GXCS00FzeQZ7cys4hAFH4uK/wJJ7gMFUUGoEQwdfkJaCkb1MFWm7uf8pFyRYE6yH2I2EziCf77DjzRuE+ecqguqAaOvSvW5X2IgoBiaF1Xx7PxrAR3oG5U4ri38idUx7HRdgf3yaVeBSzQJC47E8kYUo/phptHMgciacIdIOfVtxf6n1hRbkgA9QQ9Uug5QKZeDSv5UysDddS7ExZ4oqEOJSVk+AjvFoAwTfnO9fu6DC+J
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:55:41.0880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a81321-3c66-4999-1b59-08dc5de23aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

All errors are generated by ./tools/qconfig.py -b -j8 -i whatever.
Error look like this:
warning: style: quotes recommended around default value for string symbol
EFI_VAR_SEED_FILE (defined at lib/efi_loader/Kconfig:130)

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 lib/efi_loader/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index e13a6f9f4c3a..a5ab7d1b262f 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -129,7 +129,7 @@ if EFI_VARIABLES_PRESEED
 
 config EFI_VAR_SEED_FILE
 	string "File with initial values of non-volatile UEFI variables"
-	default ubootefi.var
+	default "ubootefi.var"
 	help
 	  File with initial values of non-volatile UEFI variables. The file must
 	  be in the same format as the storage in the EFI system partition. The
-- 
2.44.0

