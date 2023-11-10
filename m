Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1943AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 12:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60DFD871E6;
	Fri, 10 Nov 2023 13:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qg5XKMtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB5787747; Fri, 10 Nov 2023 13:34:47 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7CB871A2
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 13:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWjvZ4C68yOC9p65iv0jpbAyjjk2S4oZ8/KeVDIwF9q8/xEX2zKqfaQHLcoPMc6QOGmEHkcoaOkFpnGRTHk9zeGTobrpc2TRf7ScueesSrWlRJFVlJpPm9u8hxN4zBZVcR4/Oi1uZ1FsAz1Fb9+swV1+p1h9mO+xo8kFrX02+WRbzoRG1xZ8eE2TrM8ojoLGjt5ShohXCEahYsM9cBxf9Vj7iWfwcpd4sZp4wqpfCMBWK55CLxvFMoXK33X9JqFY18BwHChp/6Fboi8ZdYHyy0LA8XzImsjiKYF9VUjwjTJ3291ZhyPcJMrIM+XERvchfC7ak2oMiKDdN9I/1VZv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHongQsc1qadLrb43klV5VBU1ipABy0hlJUOIgY4bV4=;
 b=XXOhMIvj+LoPQdt+W64Bi3yywcA3csrlZZtKpr1E1QBu9i7Mgfk8cU6gUd7EcuoiT61km0d2uyQ3nxTcN05phwrkTANuvaZtKPqJyW5GS3LqHiRhMMe07jyRoypUBenk271FFDc6MrZ2I18RcZKOgjsGU+ckQFcOJ3TRgtxyFg6QxNCD/r2iIE0GF1r6JeFuoCb8lIflmakJTs2zDOlHVM5wYYzjBgp/lkXZ70zboeh++2eDssrk38MvpXfEPpzRf5txtHOW1Pfwdr3VV/+qUQfM4w6wC8AORD4hzpaaMECbdrSjWlJ2+iIbiJTkak3Ig2kTH22RWRVL3DIHva4OTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHongQsc1qadLrb43klV5VBU1ipABy0hlJUOIgY4bV4=;
 b=Qg5XKMtcnoAnNy05lv44FKoaizUnuavt5TQCZ+mDhYyxxHD3YF+nb06MkuvBhWkPD5LESnMZAc+Qe5neqov/xF6QmV+cTAFpuZ2McHR9VedDasBl9Uy02/Y1YhkTcGllX0jhrrmrOjr6eVjpPDW3SyitslAAzyJss3ME3LtEAhM=
Received: from BL1PR13CA0283.namprd13.prod.outlook.com (2603:10b6:208:2bc::18)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 12:34:40 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2bc:cafe::9d) by BL1PR13CA0283.outlook.office365.com
 (2603:10b6:208:2bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 12:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 12:34:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 06:34:38 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Add multiboot support for SPL/SPI offset
 calculation
Date: Fri, 10 Nov 2023 13:34:35 +0100
Message-ID: <93903a53ad9358ae69991558b787f574797effbe.1699619666.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=6Fe3OxKnXfVBmVkiw4i2i3BS7O4BciKwlp/KkIp4AXA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQ/5aCJSjNX2KS/i1ZWfvkzYIKg1Jn5jq/+rzApvyxR/
 OPK3OdFHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAih0UZ5lkcU938fcWmhKT9
 TT+el7gabE0x2M0wv2KKtvnNpxOipsd7ed/nNN52YVJNEgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: c4341cc2-b93c-4a90-8a22-08dbe1e96885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejvBJon0K6jh6Xp5ycwzYE7GLzFgTOHb4ZFxl4JwtgNgQTCE9G3u2bGBu4gOepnzaH/s+gG1FTJnA2KJ8NdXzL3P10dGOEZBk37JrJhKUqOXVr+5Fmyap49gYVfaCpogUENuIkGrncx/mbihDyk01GDI44JZeWSDLSqM2WhRh48u4YJ0so/bF2QDu/DZl+tfFseNSRCiuzO9TqmUAoTP7B+dRrxkM0f1tpRhdjfiW+0/97L9iqNKJ8oJePU2V1NBmrCACGIrvxBXo1fD/mUypeDeUSvYX7F4rooUvDbKljE1T/7dQHyGiiFJQ8piNdtCot41AO9q3eEE0Qg6WkKODk43czyMJ/GCGQv9fmTEpwpQ5DZRffJYeeOvyiYiLWFrhlmbUG/ZvZRsdBGE78/79emD4iGedrAZGfNu0gY4F+DgsP/wGnrrcPDAZGaxECvZ1kSSmX8Ki4EWpzPi7HZugvk319a1IsN5zYstEXrvA8NeixtHKpfOPDM2vjIwHnZEDS1+/hJzABpGehIPvqZgZdFTxdNtihaHrS85x9HdmMtN2RYWF47uH1xJbZilcPVhC+64HKcMIWiQ9IHTvmNqra77jpGjGFSA85eciNzXrphGtboq46qQ2RP4QgJ2l4727d9g9rZ8ita+cnh1l/BTBH8owoBIW0AoawTxT3df6QyDfJHjCQGcCeWpWkBXUMf3zGKdqgqfJJmQElHOtpC87YqBiQmBjXvukJoWc1NGz126NPAyzedBvRfAVbJYYcgQ6LwqfXbdypzqRzhHkgn0mQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(16526019)(40460700003)(36756003)(44832011)(47076005)(478600001)(5660300002)(70206006)(83380400001)(8676002)(36860700001)(2906002)(2616005)(70586007)(26005)(316002)(336012)(110136005)(426003)(40480700001)(6666004)(86362001)(41300700001)(356005)(81166007)(8936002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 12:34:39.9956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4341cc2-b93c-4a90-8a22-08dbe1e96885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
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

In case of A/B update systems there should be an option to load the same
binary/binaries to different location and they should work.
Before this patch boot.bin with U-Boot SPL can be added to whatever 32k
offset in SPI and SPL finds u-boot.itb at CONFIG_SYS_SPI_U_BOOT_OFFS
offset. In case of A/B update systems that means that SPL is at different
locations but it still points to the same u-boot.itb which is not correct.
That's why include multiboot value to offset calculation to be able to
point to image from the same base.
It doesn't affect any current system which starts from 0 offset.

This patch also change Kria defconfig which uses A/B setup. Partition
A starts at multiboot 64, partition B at multiboot 496.

And also print message about used SPI offset which is useful for all cases.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp.c         | 15 +++++++++++++++
 configs/xilinx_zynqmp_kria_defconfig |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f16280308483..59feaaf6f32f 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -681,3 +681,18 @@ void set_dfu_alt_info(char *interface, char *devstr)
 	puts("DFU alt info setting: done\n");
 }
 #endif
+
+#if defined(CONFIG_SPL_SPI_LOAD)
+unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
+{
+	u32 offset;
+	int multiboot = multi_boot();
+
+	offset = multiboot * SZ_32K;
+	offset += CONFIG_SYS_SPI_U_BOOT_OFFS;
+
+	log_info("SPI offset:\t0x%x\n", offset);
+
+	return offset;
+}
+#endif
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index daedf1de01ea..a20df1a4072f 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -48,7 +48,7 @@ CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x8000000
 CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_SYS_MAXARGS=64
-- 
2.36.1

