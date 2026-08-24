Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A925BC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F6A240693;
	Mon, 24 Aug 2026 07:22:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9e-1YdRPT4lJ; Mon, 24 Aug 2026 07:22:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787556170;
	bh=N4IvesaEJCutnKCe7eqDL7WnV+NWCRSzKjKNmOl1jKo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tc5PrvTzB/lbS0FEQDZ+YqzfWX+lx6dXpj0W5Oi9VsCsarbxeGUSRhg5iZCatbaxp
	 h2Wr03JNexbVMDLO+CoqHjz34bZRAeZfd5UKmjVfU7I5tZQf9Ny/IMMdIuI95Ct9h8
	 HyIU0sdVfSv9SjDVWCj861p/J0QFATRAcrQHtvsA/MHSqKKTKuRfddYmXIoZ2dciGa
	 MorsK2nhDtDjv37cM3wNjA59N2sxHhbQFnVZ80yKqob9ZRBzn/TEFI+DjUS1lO9iPp
	 3bCNRUCrZ4iNZsXIpEahwp67/kFfvTyosMmmVwiYTX4p5enS8Og0QpI+JXFVofCaye
	 FyEGFvfNPGF6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A54784062D;
	Mon, 24 Aug 2026 07:22:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41DC2386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33F7D60632
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:22:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgServ30VYHr for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:22:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=MpuoTVfp
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BC1A60629
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRVo3duwmOVI4tksnProU2BBVJZBUWzoumTyBlWaudNkmlnkeD6A2rMML0CSRgmfxZQuzDFHm91N+FB30+eXNLaZ939xGCP5inblkVzAzL+9rl6Pu5m7AaoJpbjxBXfalamDge2uLq89G8T3X6pr7XVhsNOqs9r+q7lB15zP2qKkW9kDg3MRu5BpBw81M+TF494YBfN5XL0PLOIqnXjnieyEGM5xuhVu9esqpzdA9EKLxvPMAuC8v6nCVJbyxUKObUTRYrCFcmGqtnBYx7hoBSu/IbzU0eaqvqEDUn/B7tS5dq5fhOxK21I+AlZPVTkUwuX2ZXNI3OoL3q9p4bmnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4IvesaEJCutnKCe7eqDL7WnV+NWCRSzKjKNmOl1jKo=;
 b=poRHA52T3ypwLMvxLi9gkPsKYM3eUjHxj9R9cWzQdKG4ITY/DMwLv2p3bwrdWckuSEhgQhs4SXLDMnSk3iyUgiBjBrr3vdvKWtMV/76Q5t4ExyZ8j7sNZWXRZ1i6uIi3d6A+vQQHhxyMdufzy1dEoNoy00ICNyW8Z1msaweKNeKD6kA1D7NO4TdV81rAtXjWfuCk7ufbGPduyFgYt4LeKd/micjJDCh4wRtpeHOwwxgdgkitZTajseHqYwkblBM5X2vSVgReD9EcvD2QkR/o6YsPf8sIHqBB3ta++3G+u/Yzam+CXh3Hvl3rh7KispeGlrgZ4FnJVr6RL/UQa1i+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4IvesaEJCutnKCe7eqDL7WnV+NWCRSzKjKNmOl1jKo=;
 b=MpuoTVfpHcIvRHIyoiDS/gvDTP6/qUJN3dF2nyVV9CH4gee7YMehzh+S+7HIUaPINoZMu9pjUH2EA6B4izYwv4+cRcq7h9xemLu3oB+72YDhhZg6r/C7hEXYYA0/+VfLmesYQUE/ao/3POzDrfdaAXEu0TjCIHsKWGz51vpxrdU=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:22:43 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::32) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:22:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:22:40 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:22:39 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 1/5] pci: Add pci_generic_mmap_write_config32() helper
Date: Mon, 24 Aug 2026 12:51:45 +0530
Message-ID: <dfa217d94694c145439be412fd815b44a7617882.1787554549.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787554549.git.pranav.sanwal@amd.com>
References: <cover.1787554549.git.pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b1adaa-bb95-4709-d799-08df01b07c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g6QmZmckxdADBSVtztyzh7j8uJXC8/lmmjPNseRB4yWKWZLxyspKiYkR0Oo/tiakzWngMnifffxLoXc5PQprH7NjP5C8KNk07DwMV4MDZ4lr2ALRiMw/u4ljyEzlPiEvRRHlc1W96P0TvePeYTGlxCgJ9/sRc0ct6Zdu5lFvj2ezpNQ5DzUTd+3iO3ez3Q+NrswPDv1cQn03HIRDMfUAqloPnPy1VFJLytDO5YqlzAaWH2wE5Pr2OBQwHXH6j+k7dtftJXMFxCr1wdFOJQD7BKYl5A13JZ5u89tSA1HrGJ/RSX0BdE/BLrYDx9E1OwrFOBreeZJP9zq0apeEJAmFidve59kGmxNPTdtw6W3XkTr4PsEiY1DIlWuUJpJ3WJ+3adHsZ5lubEDiq5hqO3aAERbroVwOGft7GE/FRvsBRHiAyp6bot728qEsW2/zzl6OVURmcgSWw7BLfoABMXNfQ+U6rO4Bc2lfu5bFC0cW0pEq6l5BY/nKllXaHV45pXRfsJ2/GhpNQqK3VPiUGJbl5uvkSupTjuO/88/RESqEPiPw8ZxkwB9rUl6w7LiVfUb5fdE34T8M/ARSM5IbdERTYX33suqiU1sbaFAjP/81Hayzr5iy12ybs+FGtQpWrB2eh9zX+bl6PulOV3ejRfa8Y/Zqqj5UgMSLZ2ji5v/8ccqP8W7KOLgb3RWu4fAKotIUZ1nc/Ge8ew5QWwKlST9jeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zybI9L4vbKPshDb+Jr6kxjN1IIt2FIMTU5pMv32kJ7R+UweIMkeU8/wBL2boma5GZrwQ8Ri0qlcptehMQRLh8hJB+y71Rd/5GPAJZcwv5xuGAlT4XjJo66mXy+el2NoEvudgkLZJ04Odpth+LLXPcC2jjrkK1ZnwH3ieEuLR07XjqX5o04kUjQVG3m3nbV4NGzKUkjKbtTfbVYbLW3gBN/zuvPHVh9Fclrjs7xtYlBroC8QGasRw15cGVSnQGIhWLxBI+OV2ziXxRyySV4v3RX52W6le7oe88YJSvIxBw3KHRg1PDHY9jsAKGA9YuDYtRZ7hN3exunVhYoluI3vI+Rx6MzaP6SpMGDf/nb8z+uIiwPnbc2jgqm/m0lxXz81imDpwsoUHtVb/pdGSRiLHd0uDV8gks7qeoi8ebLZfMpKFRYKMT7EMjwMaZBeYURbF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:22:42.4296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b1adaa-bb95-4709-d799-08df01b07c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Some memory-mapped PCI host bridges only decode 32-bit accesses to
their configuration space and either drop or corrupt neighbouring
bytes on a narrower access. Because such hardware only ever reliably
commits a full 32-bit transaction, the only safe way to perform a
narrower write is to synthesize it in software: read the containing
word, patch in the requested bits, and write the whole word back.

Add pci_generic_mmap_write_config32(), a counterpart to
pci_generic_mmap_write_config(), that does exactly this: it
transparently promotes 8-bit and 16-bit writes to a 32-bit
read-modify-write of the word containing the requested offset,
leaving 32-bit writes untouched. This mirrors Linux's
pci_generic_config_write32() (drivers/pci/access.c), used for the
same class of host bridge.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 drivers/pci/pci-uclass.c | 42 ++++++++++++++++++++++++++++++++++++++++
 include/pci.h            | 26 +++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 4bdd1f7477f..f4ce630118f 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -618,6 +618,48 @@ int pci_generic_mmap_write_config(
 	}
 }
 
+int pci_generic_mmap_write_config32(
+	const struct udevice *bus,
+	int (*addr_f)(const struct udevice *bus, pci_dev_t bdf, uint offset,
+		      void **addrp),
+	pci_dev_t bdf,
+	uint offset,
+	ulong value,
+	enum pci_size_t size)
+{
+	u32 shift, mask, tmp;
+	void *address;
+
+	if (addr_f(bus, bdf, ALIGN_DOWN(offset, 4), &address) < 0) {
+		debug("%s: failed to get config address for offset 0x%x\n",
+		      __func__, offset);
+		return 0;
+	}
+
+	switch (size) {
+	case PCI_SIZE_32:
+		writel(value, address);
+		return 0;
+	case PCI_SIZE_8:
+	case PCI_SIZE_16:
+		/*
+		 * Some host bridges only decode 32-bit accesses to their
+		 * config space and silently corrupt neighbouring bytes on a
+		 * narrower write. Widen the access to a 32-bit
+		 * read-modify-write of the word containing the requested
+		 * offset.
+		 */
+		shift = (offset % 4) * BITS_PER_BYTE;
+		mask = pci_get_ff(size) << shift;
+		tmp = readl(address) & ~mask;
+		tmp |= (value << shift) & mask;
+		writel(tmp, address);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 int pci_generic_mmap_read_config(
 	const struct udevice *bus,
 	int (*addr_f)(const struct udevice *bus, pci_dev_t bdf, uint offset,
diff --git a/include/pci.h b/include/pci.h
index 4b0facd6dcf..108d97a5d54 100644
--- a/include/pci.h
+++ b/include/pci.h
@@ -1151,6 +1151,32 @@ int pci_generic_mmap_write_config(
 	ulong value,
 	enum pci_size_t size);
 
+/**
+ * pci_generic_mmap_write_config32() - Generic helper for writing to
+ * memory-mapped PCI configuration space that only supports 32-bit accesses.
+ * @bus: Pointer to the PCI bus
+ * @addr_f: Callback for calculating the config space address
+ * @bdf: Identifies the PCI device to access
+ * @offset: The offset into the device's configuration space
+ * @value: The value to write
+ * @size: Indicates the size of access to perform
+ *
+ * Like pci_generic_mmap_write_config(), but for host bridges whose
+ * configuration space does not decode 8-bit or 16-bit accesses correctly.
+ * Accesses narrower than 32 bits are promoted to a 32-bit
+ * read-modify-write of the word containing @offset.
+ *
+ * Return: 0 on success, else -EINVAL
+ */
+int pci_generic_mmap_write_config32(
+	const struct udevice *bus,
+	int (*addr_f)(const struct udevice *bus, pci_dev_t bdf, uint offset,
+		      void **addrp),
+	pci_dev_t bdf,
+	uint offset,
+	ulong value,
+	enum pci_size_t size);
+
 /**
  * pci_generic_mmap_read_config() - Generic helper for reading from
  * memory-mapped PCI configuration space.
-- 
2.43.7

