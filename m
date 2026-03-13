Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD682105F7AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A70C784382;
	Fri, 13 Mar 2026 15:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KURJKAmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEADB843A9; Fri, 13 Mar 2026 15:00:00 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98ECB84307
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnjGkcjfjm/f5+1TiZi//3s/t1mdeXx5bHbnPf3YTZxQL8Io+2P5z7IK32Z9vsJuzbVzxapjOAynFMCi79aY/nE4rGP6LliLJ03wSR1utDDpC3LQ5jqOa/bggICGrM7onsKR5sfC/Sd01sMzMiYtZ01CWGM3DTuMiDu8sNtaRe5oC8L3r7vG4WoiN3gawNSTvh/3afnWevklEcnCZ1biMTGUZJgwwe3qoBxxcoQLCTC3F+oM8s6vOyW6kjerFG2KH1Jn9sWp7hq/VNmNgAzIaaBgR8fElJYxcgGnEA68RasOiTUcT7cxPMMPC1HUDR/eOajNC2Sz7WSXxoF1wbgjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLqP4yQ3I8vtor9k7YTgbAGOep2a5jSQt80tFV9zSzA=;
 b=WmTiCd7fs8RTIriTUkHk8OIucpLo678ZVN56spDiC6smWCLZmIFYvuwL11tsQu6f6pe0dCSqw/yqBLVDepp9ysi+SqZm6pNuqOwcupU8B6E9V/wR3vfZq1pA2noId3/ZSJNzxirD5qcRqeejUkFQXcbltyGSYCD/b0Kuia1yPnLaqIRh6wWG+DucEOBj2iuyRRUJXIrYSe8H9mZRVzq0QLWGYWmVWO5oeqbTf9QK5QMJEhWUQhwJ/6VfuoT78qSzQgomoqvjnmBkEKoKr+lMax4kf4I4Ki3kJ3NV/EtzExafNbMhpnHQxw3pF9N3z3VQ1YkuSKPTqjBmIeJrYrUIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLqP4yQ3I8vtor9k7YTgbAGOep2a5jSQt80tFV9zSzA=;
 b=KURJKAmdYS5aIYkVZkrDUCCRTfvkMiX5ZSSuad1alwkcyijydfMCc0jmq2zWnWAGKe6klXy9IocetqN9E5GED7yICupqQN7oV9xMrGIyKGbo+vsa7ZAlpmZPawJwPoOY6W+rutF6TEoUIl1rh3H3P/7sYo8C/DTxTequbsuka3M=
Received: from PH0PR07CA0101.namprd07.prod.outlook.com (2603:10b6:510:4::16)
 by IA0PR10MB6772.namprd10.prod.outlook.com (2603:10b6:208:43b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 13:59:56 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::28) by PH0PR07CA0101.outlook.office365.com
 (2603:10b6:510:4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:54 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:53 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:53 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jp638000;
 Fri, 13 Mar 2026 08:59:51 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 19/19] arm: mach-k3: j784s4: Enable lpm resume flow for
 J784S4
Date: Fri, 13 Mar 2026 19:29:00 +0530
Message-ID: <20260313135900.3430264-20-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA0PR10MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: a7298eb3-4ff5-435e-1f2e-08de8108cd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IeJi7xgcNusK6XOeLjXVR5dXojpYmkDOcxrvhjj0/Tz/0dsRPLuPobYrh6p6MZB0mdkhHvG+CsDtZtIp1vMiDaqYX2MjI2vWHC8sTY3J05ndP/7hY3SD029kxw1fe8txxL322w0Uv4D2Z8wmUQ/DLp+cpkId22OWpPlRy3PGYO7ojedaJYpLg0j8kL3fWrZ3gMKTPZW6vEkCunooyn/Lf3ev/21suqzhHax/PMxwBZvdtqz6R+iX7WRQ12tqyEdTyVV8zYt8PeHIpvOs5eS9b6xTbSHG5QABbqOO6F3y5U23V49BBwWQnI+Y+4+Stoy7iUpCjC9/6Xcs3l3XhqQ8wgGfMxTn4nV2OMHr63aMttWWKuOgE3fZabZoPHLmvZOOF7EY8RrNZ/iF6qLwQhaXKcXUkEkkc4tURiicXDjV0+bR8u19kC7WHnSMueDK4CjEH9HqJV3H4rpTNiQx3IRz1lVQ1RVPcEUU7KRG2d28AYYgwIhx7to1LKXNMpibvX35DwGDhH0xXfAKgJpalbRpzz/2y/IlUuzMLO+2v7dMzi61XF4vzlbrC7B0LNze5acicGM702Mbt7gKqTQOkVLKbuZrYV41I+CHw1HQC2FSbIhCQ2XK5a6i37y+8kZO48Y4dNPTSX0SKWJydWP+fDdhqMJlfVoLw+D5icDWEvtBN4Rh38LBLW60usMXWYEu2vRF4EdHpnZQwNmHK486TNgUsVRcjua1uouBJegsPDdBPcDMyv3ftK8d2d6yQ7Dl8hbEzNEfZum1kxc/dBM2qxjyLw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /Ve6LovcRGDtYBDE4ys7EaJGVrSiKG8ZtCAj+gkOahZaOBPu20GFDLnsgwNehKuPdtdDb9sMP4hMDw+fn9mXwQPgrkGSN5FqRL3awbjDMHuLSuvlfHgURn+H2cyK0oeALdgJacDe1nVutm8W+8RcADvJEETErPWgEY7FQy2ZrCyuqcrwL2erXCfzHtF7zrb/eH4shvHuX23ZnfKCCicbnKHBeiBV5Ctsruywpm8oVuCFVhryxVnUCQYzf5o6CfdpnaPEswZivA1Pn6wKN6jkJNL8iU8zoVQtSGSPzOfApCdc+y7qhTsjRqFpRTLNSLlgezUivfhlejVv4DvRpnZ4v5aRR5iyCN79IncUokly63qOX+jT8eLpiVC/RUOVYQkB38Psz97y+XH0TwJukP8NAmo5vlZ6TxfRs74HuPVrJDhtxlMEmHICyOnuSYOScosg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:54.1459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7298eb3-4ff5-435e-1f2e-08de8108cd9a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6772
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

Add support for resuming from suspend in board_init_f for J784S4.
The resume state of the SOC is identified and lpm resume
sequence is followed accordingly.

- Extract context address from devicetree and send to TIFS.
- Power on the rproc cluster.
- Replay the certificates attached to saved images of ATF and OPTEE.
- Resume sequence for context restore and rproc resume.
- Image entry to DM firmware.

The context address area is firewalled by TIFS to protect it from
other hosts. Same with the resume flow.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c         | 65 +++++++++++++++++++
 ...-j784s4-j742s2-ti-ipc-firmware-common.dtsi |  6 ++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index be04f88d23e..37b2f584db4 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -270,6 +270,48 @@ void k3_spl_init(void)
 		k3_dm_print_ver();
 }
 
+void lpm_process(void)
+{
+	int ret = 0;
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	save_certificate();
+
+	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci, (u32)mem_addr_lpm.context_save_addr, mem_addr_lpm.size);
+	if (ret)
+		pr_err("TIFS lpm save addr fail\n");
+}
+
+int extract_lpm_region(void)
+{
+    ofnode node;
+	u32 lpm_reg_addr, lpm_reg_size;
+
+	node = ofnode_path("/reserved-memory/lpm-memory");
+	if (!ofnode_valid(node)) {
+	    printf("lpm will not be functional\n");
+		return -ENODEV;
+	}
+
+	lpm_reg_addr = ofnode_get_addr(node);
+	if (lpm_reg_addr == FDT_ADDR_T_NONE) {
+		printf("Can't find a valid reserved node!\n");
+		return -ENODEV;
+    }
+
+	lpm_reg_size = ofnode_get_size(node);
+	if (lpm_reg_size == FDT_ADDR_T_NONE) {
+		printf("Can't find a valid reserved node!\n");
+		return -ENODEV;
+    }
+
+	mem_addr_lpm.context_save_addr = (u32 *)lpm_reg_addr;
+	mem_addr_lpm.atf_cert_addr =  (u32 *)((uintptr_t)mem_addr_lpm.context_save_addr + FW_IMAGE_SIZE);
+	mem_addr_lpm.optee_cert_addr = (u32 *)((uintptr_t)mem_addr_lpm.atf_cert_addr + FW_IMAGE_SIZE);
+	mem_addr_lpm.dm_save_addr = (u32 *)((uintptr_t)mem_addr_lpm.optee_cert_addr + (2*FW_IMAGE_SIZE));
+	mem_addr_lpm.size = lpm_reg_size;
+	return 0;
+}
+
 #define DDR_RET_VAL BIT(5)
 #define GPIO_OUT_1 0x3D
 #define PMIC_NSLEEP_REG 0x86
@@ -322,6 +364,9 @@ void k3_mem_init(void)
 		}
 
 		if (board_is_resuming()) {
+			typedef void __noreturn (*image_entry_noargs_t)(void);
+			u32 loadaddr, size_int;
+			void *image_addr;
 			/* exit DDRs from retention */
 			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++) {
 				k3_ddrss_lpddr4_exit_retention(devs[ctrl],
@@ -340,6 +385,26 @@ void k3_mem_init(void)
 				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
 							       &regs[ctrl]);
 			}
+			printf("Initialized %d DRAM controllers\n", ctrl);
+			ret = extract_lpm_region();
+			if (ret)
+				panic("Cannot find valid LPM address range..LPM resume failed \n");
+			image_addr = (void *)mem_addr_lpm.atf_cert_addr;
+			ret = rproc_load(1, (ulong)image_addr, 0x200);
+			if (ret)
+				panic("rproc failed to be initialized (%d)\n", ret);
+
+			image_addr = mem_addr_lpm.atf_cert_addr;
+			size_int = FW_IMAGE_SIZE;
+			ti_secure_image_replay_cert(&image_addr, &size_int);
+			image_addr = mem_addr_lpm.optee_cert_addr;
+			ti_secure_image_replay_cert(&image_addr, &size_int);
+			loadaddr = resume_to_dm_f();
+			printf("Starting ATF on ARM64 core...\n\n");
+			resume_rproc_f();
+
+			image_entry_noargs_t image_entry = (image_entry_noargs_t)loadaddr;
+			image_entry();
 		}
 		printf("Initialized %d DRAM controllers\n", ctrl);
 	}
diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi b/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
index 455397227d4..f285f4d65b2 100644
--- a/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
@@ -125,6 +125,12 @@
 		reg = <0x00 0xaa100000 0x00 0xf00000>;
 		no-map;
 	};
+
+	lpm_memory_region: lpm-memory@ab000000 {
+		reg = <0x00 0xab000000 0x00 0x00300000>;
+		no-map;
+		bootph-all;
+	};
 };
 
 &mailbox0_cluster0 {
-- 
2.34.1

