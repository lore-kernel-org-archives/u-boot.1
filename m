Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117CEC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 10:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EAEA87BD3;
	Wed, 24 Jan 2024 11:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WSgRQf0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF0787BEF; Wed, 24 Jan 2024 11:58:51 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E44876EF
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 11:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y67wNktmXD8Vp/bgOQSJWWjc938gl0UjTfqT3pueugj24LaclTYqeS92eEYrxHLsbFyPdqFsabfiZx/xRx2hr/qZdmmm5qZXuTO4WUNoHkVE4sDvsaYpmStvoe3wtdXMKcsk2c+Mo+95gr+Dmw+Wylofhj2njVo2uUNdHKb9gI5PJ+scnudyOKBe5vabuxKVoFadGnmcDCHELzyPQbQQ0Pz04g/Xh83acM6/dDXNWfP+r41VIbnOjFhRggh2YdvQt23Sh6o+wodfPt9nDF8Jt6IH4kj4VgvaAZpByFamI2pCGj+M4sSlVwDvw+RS4zRYs31OepC9ibjVGOJi4SfRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FQWJGH/B/qqRO7s6OlGJp9xzblGa3rnHvLOgt0eh/I=;
 b=fgvv3o+Loq28P4/AUxynThtmbd39rK2FsYwIQq9kMZMtGjYBY4zG/MQ740qSQZB0WX0K2/Z23RN1IeT3gQVX97gMpJYlQjy4FBB7MsKqScKhm+slHgbx38kdvp5I7hGVpEu8iS8a7i6fV5xELc+Omb5F/P+v9B2G7oSwMjGB40UVwelyY9WqOEZb2b6Z9cxcLOWclwVQ+3goY2miOx3QZuLjZ78djICvAekrYvPCdMc0C/lGy4oClOfDRSo8K8bFzDN7x07DGgh2wisHFs8oVmRd0zsc05acijggYUKwRVURwn6Zi9gY0CqD8sHBzYAoc/yCqrpVMrdc5lprgsZmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FQWJGH/B/qqRO7s6OlGJp9xzblGa3rnHvLOgt0eh/I=;
 b=WSgRQf0U2LzrwB915hpTZzsaHZ9CfNhLf6psuyUgQpUnyq01amxuRAIHjdUR3lHtL97HLo5HpG6f1BHT8sKrsBqfuR3fwkKp3+2HHi+KeNXeRArQXqtIPiw0uAVvUT8LAo/FAa8iMPQuRLbUkf8p97pMFIZ42uItXt/LrsGE/hI=
Received: from CYXPR02CA0075.namprd02.prod.outlook.com (2603:10b6:930:ce::28)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Wed, 24 Jan 2024 10:58:44 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::13) by CYXPR02CA0075.outlook.office365.com
 (2603:10b6:930:ce::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 10:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Wed, 24 Jan 2024 10:58:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 04:58:42 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Martyn Welch
 <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>, "Svyatoslav
 Ryhel" <clamor95@gmail.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 "Tom Rini" <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: xilinx: Enable EFI_HTTP_BOOT by default
Date: Wed, 24 Jan 2024 11:58:40 +0100
Message-ID: <b78a7d8b0100c724f657c0997b273e073cf31a14.1706093917.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=R2UIyb826TSLNAjYjoy+x4PeKZeBQw0jn2AdODCcTOE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQNb+P+f1TklmtcJXlQZ+dltdgja+41bL13z2OZQaaJX
 /JU5nKWjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARa2uGObwrp15nvG/U6Bmk
 dXe79sFfQpG/BRkWdNsn8d3awPExWJD3hNPDzXevGs1aBwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fad3538-1ba4-46c2-011d-08dc1ccb6eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAKrPbhGy9lvWFSjesJ7FOAiGve13IsGRoXJEvkpJUjxZZHdWtkkSNHboOkeLoPFGTSKeiK6LkKwVOJmQ0zz5DSvYFX3MNapgF2za/PMDyYnxmlslBqKHbicig4TSfvomQ/3ebNmmNhBCzNtGypYEzFLmCMxvFjksqtyYEwqAMXCUtDqFUcvEcq8vSPETmubQ9x0sfnX5U5KcAIQPanZJFm2ht2EP8vMQzsBg8cnVBCvuyDuw1ewYc0SiFf+7GmWV3jlynLHuKHswCR8Z58gKrVBPmTAI1ob5Xh34NPDmIDHmCaVm5qq4bXXtO6KXp6LVToCI9ahTjqm8VrsMx9eAZpII3uP07+i2DzxUwTYlzEWZZdNqmzVn8r2HcLwxbBo2+UmqqY+QYOr5jmqOCcVVLR9q1c1x1dBEnTmiT/s/c0H6uD7sVKNgfZJUqaEsr3HcUXlL1xkWtKqhzeHuToA54C+qJKB0TOjolJtHlmYy4/sDN30YrdnUS//ioX9+ajdDWjOr5tMi1X5lSXMLm7zF76qROP2zE8HzmNfaZha0EzcFDSGg4z/IuHd7xO6b5PtLAzVFVMQl+h8HwTbDtWwxVLpW0Gh+H2yDTB+la8emo+V1+UgULXu5cVdoNR30Vm6I5H5e8V4TBYKeLzMbOWgxD71I4rWz2DklSN/9fg80V+yokyVeTAD54HaQoV2/OFkrKt13GtSP+5LwyNuLCmwmkVd/wESMt6aBcZxOVyFPp1V8Vumf/eyaPzzMDHVbyA93uXhY/WOOIprYs2uD/19hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(4326008)(8936002)(8676002)(44832011)(2906002)(5660300002)(36756003)(86362001)(82740400003)(356005)(81166007)(478600001)(83380400001)(16526019)(26005)(426003)(2616005)(336012)(41300700001)(47076005)(70586007)(54906003)(36860700001)(70206006)(110136005)(316002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:58:44.0059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fad3538-1ba4-46c2-011d-08dc1ccb6eb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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

Enable EFI_HTTP_BOOT to be able to booting OS via http.
In case of that dhcp server is not providing dns server IP set it up via
setenv dnsip <ip addr>.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

I am ignoring defconfig sync because it needs to done because of
cda3f81b06f5 ("cmd/flash: Make this default y for CFI and NOR only")
anyway that's why I will just enable feature and Tom will run resync at
some point to remove automatically selected options.
---
 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynqmp_kria_defconfig     | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 371d14eb89b7..0f1d990936f3 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -146,3 +146,4 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_TPM=y
+CONFIG_EFI_HTTP_BOOT=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 5f76a305ab32..3c55dd8dcde9 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -153,3 +153,4 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_TPM=y
+CONFIG_EFI_HTTP_BOOT=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 0dc6c5b6877f..28b28f68411f 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -224,3 +224,4 @@ CONFIG_EFI_SET_TIME=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_HTTP_BOOT=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 2742e38b599e..1fcae45e95db 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -242,3 +242,4 @@ CONFIG_EFI_SET_TIME=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_HTTP_BOOT=y
-- 
2.36.1

