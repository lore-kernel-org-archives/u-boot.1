Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E288606A338
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gSrHy+Kg;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jusMwZbh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C04C407D1;
	Thu,  5 Nov 2026 05:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajcvCLJoU8AH; Thu,  5 Nov 2026 05:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2074E40598
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793855868;
	b=X23aA5QT1Q/3xYmH9h9JgylCzfEMr873y7rXWAOclS0wwyFlSxbm3E8SxhhMcka2CLiY
	 2NwfIxoLCMmXsDou/sZ+QKWo/O1ywUkpEUX87fNsKfeA1sxukHjvQF/WoN5r9qeYkp4xl
	 F/YdCSPAqu7QLMcwlkvdzVK/AGYVjra8uv56wdCLW1Bxk3OnOraYnD+uzRjXzRSl9X6vS
	 2lMqEG+GxNN1Dxz4WxOiJqs0czFKZZ0N+xh5+g84TzY84xLOM+7IGmcNVKUHXeBbXci18
	 krPYhBJOJbs8HDkOhge5SK7DC9QbecuvN8ULaMXPedxZiE5JanSc3ug9UxxFgMwjlfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793855868;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WLVMTfhy83efIPaxIrYf7Nkxaf8fSUOnTWPDy6uLw0E=;
	b=r70WQyJ16ilQuXpk1ucqVwdk46nqoy+ml7reo2DECmHNu7CMRuhWcEuCKwiYoEAeQ9NU
	 0suvpPSiSk/J9Oe/c8KAfXMPsAxaTWc9dZFDGnwzUoEqljBNh6T0iGtz+64M18ycdvI/Y
	 rZ/1Ocm924GjtnSK2Zi04mj95X+eHeS7obDDppshA12We5a1geyzv5g7759RxAx9OSW06
	 XFbcmdN1e2+odXysBAfV6r1DlEvFTm+G9+RYWI5ARYAA2sJtpm/jwyptJ72cA+hWQYqMX
	 uoJdNl88DHInmXkbYzIRXxN/EAU5KOucc91u1CL3Zr9tDBHXmiEaev5dhBk/D8Ei6VQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jusMwZbh;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793855868;
	bh=WLVMTfhy83efIPaxIrYf7Nkxaf8fSUOnTWPDy6uLw0E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gSrHy+KgsUQTSQo/F+dTo6h/AX26RJY6VMnnY7TrczpRmFjVNxk4trFyKrk0zJbQ6
	 j+rmI0DupzLQjjDCg11KKUeeJpg+0z0LuUYQVhnuiaL4qz/EIkW0ohjT/F/rI9j+DU
	 N2bEGrnCStg/Mkz5FR1G+Pb7MrfRbFXOTD//DP8HF6OxVffNScuYXXYVJfJ7UJyaf0
	 N+qLWhk1BFaXy0mKY67CgmwbnUC0lSCYt401pRjnLfoew+JhPjmcOcTaeJsqZH+Cjk
	 xLilhqB8kqEKzTYA9CvvPdcgI5Wb2PSaGisWCQdrzT8s9k68cifaIW2Voa9oT+pDqq
	 gYn3Ho9/pdzZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2074E40598;
	Thu,  5 Nov 2026 05:17:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95B8937B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E4D8407C0
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aNxmY_2EEpzs for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 05:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B281C40762
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jusMwZbh
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B281C40762
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLVMTfhy83efIPaxIrYf7Nkxaf8fSUOnTWPDy6uLw0E=;
 b=jusMwZbhKA/ghdNK016GOD8l8zFp9IFwVN10ACPdKtPqvB7D5Hr8KZUKyZ82Ln6gRDJ+cXO95uH5nvKQGg9mgor1AUvJOKlUtpFhYJNcfx3TCLvWbybNitH+CUlsOzp3r+64oqy/in1qNHKYgNcvwgObRHnbP+/LyeOfxKKLwlM=
Received: from SJ0PR13CA0196.namprd13.prod.outlook.com (2603:10b6:a03:2c3::21)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 05:17:36 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::4c) by SJ0PR13CA0196.outlook.office365.com
 (2603:10b6:a03:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 05:17:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 05:17:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 23:17:33 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 23:17:31 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH v3 2/2] efi_loader: expand disk device names with drive details
Date: Thu, 5 Nov 2026 10:46:54 +0530
Message-ID: <20261105051715.215560-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105051715.215560-1-padmarao.begari@amd.com>
References: <20261105051715.215560-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 839d1cff-f477-4c43-3f18-08df3afc1a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|261009223027099003|11063799006|261022113327099003|261021123027099003|261021121427099003|261028144727099003|261022075727099003|261022105027099003|261026121527099003|261102123227099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XVbg+uQ0LJIXMZbYi0euJVW854k4GkV0iugYyWqyYqjlSQVHmWqx8rrccHeU4r0Yn41ZMI+YxRGARgwCb34niHyVFWkXAavAKuoso2ZbY2HZaq8EQ+s3mCpQAoNc0emHpLh2UrkYUl9G52Sasfw1xDXEzAsUwulWqqpHUz5FjnW4PRbe7d+23TO6X2diShuWK0wdXzs2VlwGsM5sabJPoY4Eyh5X/P+vxUmn48AGp04npbVBscKhLp53oBBh9H0jnVKrpy/gP20Nerku8GcdZhC2UvdESFWQsYbOlVwAiF4E8bN+uMPYuh3BiKc8z0m6jmTOI+PqNjBIElvBFFEbuouEo21TWOcHJh9VCCigGR+KIZ7J1al3pkzqhDR1Pye52P1VdZO1XKhPARtox1M7q7YxAHZ69+L0djI+s88kYqR0ZP24ySxnllxzY0TrkMwdld/mbbmz044uaALpZPLvO5vHv4JkxhlDoPpaXdBOebINdGb7jk0DwwIgZIvM7OjZJbY8tvUZg0pLOn6/yAjYolSFTumy01ifUbMnbmRNvT/E31njIuz9TpuK0rIb3WVCEZFyO4mr1nxEGc/y8vm8YtoMxbz7efoHYPVdaaLCWCk2BKVHDVhSu6ugoZqIPum+av3LFiP+nCFTCAeAknyONqYOIifBedfz+084G++phjtPmaqQZyQRN+Cd9c9/ACE+7CS2NtNpgFEh60roC3eGmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(261009223027099003)(11063799006)(261022113327099003)(261021123027099003)(261021121427099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026121527099003)(261102123227099003)(261026140227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QRtRNmjXH6mecekOJwytbzm9IQBoixpfjik8XJq42SktJ40JWhJ0vSiqO2Kp+msbjNbyligKx8uKLPIjFdrqGdrkF0GKyzCH3EClvHBAN5WQ0bOeDCzBJI3xaHORXyHe8Ii2BsrHvtCxzGpo4JmXMyUF/tm0/IzdBmn5i8CewiIG4Dftf82sr7U3WSbw/xyXE9bDl8mZNMP98xVuaTgJEN89aNjq2gsJpbYejbIOxOfaRMEbUBU2oJbEFXL/Mp1jePexhfD4poc0MekLNUmKl++5htusFDZbg7FyVEHdBvWnvADUGqSmsDxxmEnLCDPK+eakrax8I1KxwtvaXcitRvp5mgyl/Wul/JwL0/5lnLP0yXPdxs2DSysBK9RovP/KGDBHN5dqkgACcpS8NJhXL1IGyTKYMoG7Vhu1/a3SQZ+luxtrCK4j58wRuowy4Wjs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 05:17:35.1437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839d1cff-f477-4c43-3f18-08df3afc1a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Increase the boot menu device name buffer so that extra metadata can
be appended. Append the disk capacity and trimmed vendor/product
strings to the device name so users can differentiate drives in the
EFI boot menu.

For example, the U-Boot boot menu now shows entries such as:

    usb 0 (29.7 GiB, Generic Ultra HS-COMBO)
    usb 1 (28.6 GiB, USB SanDisk 3.2Gen1)
    scsi 0 (1 GiB, MICRON MT064GBCAV1U31AA)

The menus are drawn with absolute cursor positioning starting at
column 7, see bootmenu_print_entry() and eficonfig_print_entry(), and
the titles are not truncated. A title which does not fit into a line
would wrap and thereby corrupt the menu layout. The name is therefore
limited to 64 characters, which leaves the longest description above
at 46 columns. Should the identification strings not fit, the
capacity is shown alone rather than a string cut in the middle:

    usb 0 (1023.9 GiB)

Note the limitation of this approach: the description is built from
what struct blk_desc carries, so devices reporting the same capacity
and the same identification strings still get the same description.
Two identical USB sticks, several namespaces of one NVMe drive, or
several sandbox host devices remain indistinguishable:

    nvme 0 (953.9 GiB, SKHynix_HFS001TEM4X169N)
    nvme 1 (953.9 GiB, SKHynix_HFS001TEM4X169N)

    host 0 (64 MiB, U-Boot hostfile)
    host 1 (64 MiB, U-Boot hostfile)

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v3:
- Print the capacity with "%.1lluZ" instead of snprint_size()
- Order the local variables by line length
- Say in the BOOTMENU_DEVICE_NAME_MAX comment that the size includes
  the terminating NUL, and why it fits 80 columns
- Do not mention the linux/string.h include in the commit message

Changes in v2:
- Reuse the print_size() formatting through the new snprint_size()
  helper instead of open-coding the unit selection.
- Build the suffix with a single snprintf() instead of a chain of
  strlcat() calls into an intermediate buffer.
- Limit the device name to 64 instead of 128 characters and fall back to
  the capacity alone when the identification strings do not fit, so that
  the entries stay within an 80 column terminal.
- Document the limitation of the approach in the commit message.

 include/efi_loader.h      | 13 ++++++--
 lib/efi_loader/efi_disk.c | 66 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 7b865fe900a..e9c387b7f9a 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -292,8 +292,17 @@ const char *__efi_nesting_dec(void);
 #define EFI_CACHELINE_SIZE 128
 #endif
 
-/* max bootmenu title size for volume selection */
-#define BOOTMENU_DEVICE_NAME_MAX 16
+/*
+ * Max bootmenu title size for volume selection, including the terminating
+ * NUL.
+ *
+ * The menu entries are drawn with absolute cursor positioning starting at
+ * column 7, see bootmenu_print_entry() and eficonfig_print_entry(), and are
+ * not truncated. A title which does not fit into a line wraps and thereby
+ * corrupts the menu layout, so keep it short enough for a terminal with
+ * 80 columns: a title of 63 characters ends at column 69.
+ */
+#define BOOTMENU_DEVICE_NAME_MAX 64
 
 /* Key identifying current memory map */
 extern efi_uintn_t efi_memory_map_key;
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 4a3ace3a304..28181e94932 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -20,6 +20,8 @@
 #include <part.h>
 #include <malloc.h>
 
+#include <linux/string.h>
+
 struct efi_system_partition efi_system_partition = {
 	.uclass_id = UCLASS_INVALID,
 };
@@ -814,9 +816,69 @@ int efi_disk_remove(void *ctx, struct event *event)
 
 }
 
+/**
+ * efi_disk_append_detail() - append capacity and vendor info to a device label
+ *
+ * Appends a " (size, vendor product)" suffix to @buf when the block
+ * descriptor carries readable capacity or identification strings.
+ *
+ * @desc:	block device descriptor
+ * @buf:	label buffer to append to (already contains base name)
+ * @size:	total size of @buf in bytes
+ */
+static void efi_disk_append_detail(const struct blk_desc *desc,
+				   char *buf, int size)
+{
+	u64 capacity = (u64)desc->lba * desc->blksz;
+	char product_buf[BLK_PRD_SIZE + 1];
+	char vendor_buf[BLK_VEN_SIZE + 1];
+	char *vendor, *product;
+	char capacity_str[16];
+	int len = strlen(buf);
+	int ret;
+
+	/* The longest size is e.g. "1023.9 MiB" */
+	capacity_str[0] = '\0';
+	if (capacity)
+		snprintf(capacity_str, sizeof(capacity_str), "%.1lluZ",
+			 capacity);
+
+	/*
+	 * Some drivers, e.g. usb_storage and nvme, do not strip the blanks the
+	 * identification strings are padded with. Use copies as strim()
+	 * modifies the string.
+	 */
+	strlcpy(vendor_buf, desc->vendor, sizeof(vendor_buf));
+	strlcpy(product_buf, desc->product, sizeof(product_buf));
+	vendor = strim(vendor_buf);
+	product = strim(product_buf);
+
+	if (!capacity_str[0] && !vendor[0] && !product[0])
+		return;
+
+	ret = snprintf(buf + len, size - len, " (%s%s%s%s%s)", capacity_str,
+		       capacity_str[0] && (vendor[0] || product[0]) ? ", " : "",
+		       vendor, vendor[0] && product[0] ? " " : "",
+		       product);
+	if (ret >= size - len) {
+		/*
+		 * The identification strings are too long to be shown in a
+		 * menu entry. Fall back to the capacity instead of displaying
+		 * a string cut in the middle.
+		 */
+		buf[len] = '\0';
+		if (capacity_str[0])
+			snprintf(buf + len, size - len, " (%s)", capacity_str);
+	}
+}
+
 /**
  * efi_disk_get_device_name() - get U-Boot device name associated with EFI handle
  *
+ * Fills @buf with a human-readable label such as "mmc 0 (7.5 GiB, SanDisk
+ * AJTD4R)". Capacity and trimmed vendor/product strings are appended when
+ * available.
+ *
  * @handle:	pointer to the EFI handle
  * @buf:	pointer to the buffer to store the string
  * @size:	size of buffer
@@ -834,7 +896,7 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
 	bool is_partition = false;
 	struct disk_part *part_data;
 
-	if (!handle || !buf || !size)
+	if (!handle || !buf || size <= 0)
 		return EFI_INVALID_PARAMETER;
 
 	dev = handle->dev;
@@ -862,6 +924,8 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
 	if (count < 0 || (count + 1) > size)
 		return EFI_INVALID_PARAMETER;
 
+	efi_disk_append_detail(desc, buf, size);
+
 	return EFI_SUCCESS;
 }
 
-- 
2.34.1

