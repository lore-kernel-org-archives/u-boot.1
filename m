Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87D606A328
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0YiZMAxE;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DmT0Za1w
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FEC440754;
	Thu,  5 Nov 2026 05:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LJlFfNqZCJDb; Thu,  5 Nov 2026 05:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2332440598
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793855861;
	b=ThXT0pPszms3qZmzDbbGRI/sp/mseAB825NgC64I8UgyY6hXJ7FtD6H0mOH8KL9zwZNJ
	 gbo6NibArNxQWkUogxy8fkA/xDWygfl238TXk+Cp3sqlCWtbFnnxFOkySHfBAckTkMQc8
	 fIO+bp7PihNp+JR1Nit4NTXw3RCNFEsbTxIX8dvYvYzWLqEvlBrzmQfMGHqhpaq6+gbSY
	 52A7ZHtDtoRLaZzSQgDoCfOmolmc6zEn8GBkNhXpoxX8YV+uEMpEveYhDbR89myM1wZkp
	 rd1DfUmCj2tPHPm8fb/tD1W+L/Zf00cooOifAtnDxpvAVmPSDbloqh+dKBloZuwP1Ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793855861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=XLqCKwHWm3lX4b+A4CU5VyVlAWncOlQ9xSOf+mcJ0u8=;
	b=nHjulIV52jxkQTk4ajovp8F5oqGJc5ERz37Aroihosb4vQeNE0shKpHc60Tr+StZYjcI
	 TP8Eckmr2nY8r5paHDykUkXN7Vt3OPwZdxZC485DT+lzyfBQfPlClbN1S0aDanBDHNLcJ
	 hMn+ZcQcsSQBDBkXlhD35Dr0Ei3TmM9d5F4q7up4Q79esEmDRHcDTrSEmscNkVDhcUwhb
	 c5+qP+iJ9pwM1RNAjm1FaPth3Y+vTRMuucko0xfTzdF70ThwnlBR3EIgkNQe5t9CIzt8Z
	 9nPh4P4dFW8E0zhrQVBOaQ8kanlP1BVJOEciZ/dRvBKsneKPc9/ljv4UO0jr8UqJ0OA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793855861;
	bh=XLqCKwHWm3lX4b+A4CU5VyVlAWncOlQ9xSOf+mcJ0u8=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0YiZMAxELd4BPoTGJUazhsVZTZYNTUDvXFniJkHuGff9IXPHhrvqermrF6WQVDIyH
	 hzCM/Lw/FgDZFfyj/l9fzedrdnZ1+FOK4jhU9pygjqoZEIXKNB4tETHrc6fX2Dh1Zo
	 9Ehpj/yqzIRKfFYYUdrTrIsUt2Oaaf+GCDnJQxaa0glBm5exgYNIcayUpnLbj2jP3a
	 ZjkCgfstgyPt+AHgmrAAwmrqYSzpGij5IxU/58o8dvvKlMAy0GF/yQh9lxlt+FzHXW
	 e1rhGSjvbqdfRBDXPzSssMX7UIu0byhMFtjZywuNq2Iw0UWxX1jMrTsq9IX6jraE4b
	 3092agepiBGXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2332440598;
	Thu,  5 Nov 2026 05:17:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E1F5634D
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2F23606D3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-muD-ygXn_v for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 05:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B51DA606A5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=DmT0Za1w
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B51DA606A5
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLqCKwHWm3lX4b+A4CU5VyVlAWncOlQ9xSOf+mcJ0u8=;
 b=DmT0Za1w9Ya3vzpeJPzIuE/4pHNFx8Oeupgeh2E9CwojuX7ktxweuTh3WkHJjQPGLkcyEuhOZN7zEh1YhsoKsL8GHsrJAkK37ERxP5ft1oCEVKFJ/+qU4auuJoJShlAPoVMSY52FuWBKGp6GlnkFAT04EX0kUmKPM5WdC/ZUtSs=
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 05:17:31 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6f) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 05:17:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 05:17:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 23:17:24 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 23:17:22 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH v3 0/2] efi_loader: show drive details in the boot menu
Date: Thu, 5 Nov 2026 10:46:52 +0530
Message-ID: <20261105051715.215560-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 63211a72-bbcf-4716-6d1f-08df3afc169e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|18002099003|13003099007|56012099006|11063799006|261021123027099003|261021121427099003|261022075727099003|261028144727099003|261102123227099003|261026140227099003|261022105027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 24MRFxjnO1TKeBqM4LohbYVVtdbZxQzRo9QyM8O9M28z2hlNGYTkh5IMbXEUO3NNBRSRjZH7TXM9hsj9i4u2UUbUXq6Tqzm6Bbc7HbU87XB5TnrKiWMHjjbxWy7xQBG6ZJcxFdLAFIgchhncBk1kWYbcVw2VQQ+z22GWqPuKEhl9MXvL7sZRIhmhsA1i2pDox3BEqZ02cN/WAc5rwg7+H7+hoB4+rrqpekU5zzFEb8JnBGAyUPqofEtgc2aaGgRj99EilK9YJsYG1P7ZwnY1jS4sm0gA8SEvU1n7V1VjKUE6vny1KkK8F9s6aU38OUIdqxCmKM/TajUX/dWKP+bKrii/vqoF6k53W+yTTAMnsIwhc6rynX6LvKQtXKn9SZm5Q8K/lrwsd4vGEVEQM73eh9OTnMUxlfNalmRlrXmmDsSkBf9ZugEukzS8NKHCjR6pdQjqwvdJaT02zPUgmMsvFA4f0krngPccHQTq5ziU/aPvRMeQhgr415CbLgsoG2bdu+9pCZK4GxFzCo4OwCN4UXU2KIyATl8Sap+9oy3MLouIynTCPTmoStj0rRoITGY3RJrV8IKtmVhbGLu4f5QNSPMUqpR6jAqCTolxVcPB4UXEZ2mPr5Nk9potI0L3L7vbV/DROTb+o8N3ZXDz/smirOFelwljWtaJS1hFBk2OYNE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(13003099007)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5fAm4IQ4a9MKrOKwxBBJD8xK7B1tIdxDgFoH+CW0CM5ultB8dBs5d/o6pgAD5HpWIezaxysdOXdc3OnRAw2ZvfWaJDJbQ7BPTYmYPKIY+ZkP9t0PVxhhhzc0VNRl1aHINFy+kIPGZpXAz+0nG2jBv+lZFJjy0vlHG9b4FRYHp4RhPr8wmnQT/x3qG5rQK0z5u7Tszj2/cz+FkoB5aGVIKRpUvIG8RtSy4Qt+R0SGd/TMermmY0X2ovRwkHIXCit5hhU1dB4JC9BXEyUxIhKNBdWZYqka2jWXxPcUX5luXHQH/oiFulu61CaUwUrUb0rVgKuWKD0tg+Jdd4EKkAvD3UB0m1/zI1untt3FSuFyo8eiRdIvxssHDaoUzRMl2uxvdURGmYBUYypbzTufehM16ZaWLFAMCytrY2KYCtEsTRn/rSNVHh9+La78FtCkUgLY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 05:17:29.4804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63211a72-bbcf-4716-6d1f-08df3afc169e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The EFI boot menu only shows entries like "usb 0" or "scsi 0", which is
of little help when several drives of the same type are attached. Append
the capacity and the vendor/product strings of the drive so that the
entries read:

    usb 0 (29.7 GiB, Generic Ultra HS-COMBO)
    usb 1 (28.6 GiB, USB SanDisk 3.2Gen1)
    scsi 0 (1 GiB, MICRON MT064GBCAV1U31AA)

As Heinrich suggested in the v2 review, patch 1 adds a Z suffix to the
%u printf() conversion, which prints a size with a binary unit, instead
of adding an snprint_size() helper:

    printf("%lluZ\n", 0x113000ULL);      /* 1 MiB */
    printf("%.3lluZ\n", 0x113000ULL);    /* 1.074 MiB */

"%.1lluZ" prints the same as print_size(), which a test checks. Patch 2
uses it for the capacity in the boot menu.

The roughly 100 callers of print_size() could then use the new format,
and print_size() be removed, but that is left for a separate series.
print_size() also works with the SPL and TPL tiny printf(), which does
not support the new format.

Changes in v3:
- Replace the snprint_size() helper with a %uZ printf() format, as
  suggested by Heinrich Schuchardt, with documentation and tests
- Print the capacity in the boot menu with "%.1lluZ"

Changes in v2:
- Address Heinrich Schuchardt review comments
- Reuse the print_size() formatting
- Add a new snprint_size() helper
- Build the suffix with a single snprintf() instead of a chain of
  strlcat() calls.
- Limit the name to 64 instead of 128 characters.
- Document the limitation in the commit message.

Link to v2: https://patchwork.ozlabs.org/project/uboot/list/?series=520652

Padmarao Begari (2):
  lib: vsprintf: add %uZ to print sizes
  efi_loader: expand disk device names with drive details

 doc/develop/printf.rst    | 30 ++++++++++++
 include/efi_loader.h      | 13 +++++-
 lib/efi_loader/efi_disk.c | 66 +++++++++++++++++++++++++-
 lib/vsprintf.c            | 98 +++++++++++++++++++++++++++++++++++++++
 test/common/print.c       | 97 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 301 insertions(+), 3 deletions(-)

-- 
2.34.1

