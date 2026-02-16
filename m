Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A9EE7BD88
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA3683C67;
	Mon, 16 Feb 2026 11:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="puDHSz8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 058B983C67; Mon, 16 Feb 2026 11:28:29 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A9F4802C1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhMWNNVrIYkx42IIb+MyjEfVT9nLHDUGQiz/lHZGostMG/riYJoYTuLyPQJaNhWMdBmWHX0yeYAhWhVrgEVhsAFpqqGVJFLY+KsKfdr/mV1SNS/bJdw/6NGLTVSt2Xjf58yKQBT2D9k75Pq98Me2NoW6U3Prr+WxesO83DI969RWP/YSD92OyTGSz/6ZOyUUXPSYPHx0BP0/46ZfXufFQaM0ig1MqMYoCf0BKQADUCPGDdFzXSVLIuREMdDRdf9HKkIQwJipvIk6tmiymSyfbNNT+hbBtRWiz9z8Fqkc35pX08uWd44GL2EPnym5iZet/Z9WAWH2CnGTMx9mEy2esQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+8fV+OfBZ/UeXiKgRbeyyIJSLAyxuA4I4VXZvw5CY0=;
 b=OzHdFO6rtS/iwVD0Wdmo6Rt3upo3v519AeJmW6r8VrfdpvAhO8eSe51Fvzi394tJ9P7cS4A78cBwiWWZ2k5jeH9hw4LMEmY0dCw+M7+6ujLrGBjRVUpNzdyhE9vkD5TGZDN+JPfYTCBSlVxxTefBEXv97YJUC4PCpICjZS80oPwjfEjT0tTs6S7gD0/sIlCKj9zDN0Vu9AFpM8xV41EVwVW8jYvzuSDE8GfmTP6QJTPe1/6WWPBM9CALeHAQXvOmJd3NyetJXhJqVNbl8vZCcSVkRmZsDVSmV+ixYcaCDhSLLRCX28qziicK270TkdizUAQ0B543K79nXEaQnWoWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+8fV+OfBZ/UeXiKgRbeyyIJSLAyxuA4I4VXZvw5CY0=;
 b=puDHSz8NZCUmIneiRC7dvi9C5Qijy/dvmT2uvdGJn5AKd+lUtad0R4k0LgXm1KrJrEgVBAO2GVyISZ/ur0sihwMkVus+Dv+0I+MGDRfgY45UNJJjxkBz2NJwYlm5gUKJK2XE2IzW5hWfzrFndLlnwXnVbStYu5S4dmPqlSZh/pw=
Received: from CH2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:610:4f::13)
 by SJ5PPFA8FAAE4F4.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Mon, 16 Feb
 2026 10:28:23 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::79) by CH2PR18CA0003.outlook.office365.com
 (2603:10b6:610:4f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:28:23 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:23 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:28:22 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHj1147835;
 Mon, 16 Feb 2026 04:28:18 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 10/10] docs: board: ti: j784s4_evm: Add PCIe boot
 documentation
Date: Mon, 16 Feb 2026 15:58:38 +0530
Message-ID: <20260216102858.2745657-11-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SJ5PPFA8FAAE4F4:EE_
X-MS-Office365-Filtering-Correlation-Id: 496dbed7-03f7-409b-7482-08de6d461d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eGbWzMbZ+uyKrGV9BwBJpFSm3Ez8mqIggBOfBww50hoe7gqvbmqwzt+KknWO?=
 =?us-ascii?Q?mEdo7lR/yK9ye/Y+dudfZFWqoWPW6ZBVlohJrcO0erdRtOwptu8W0ofnSbJ2?=
 =?us-ascii?Q?0ZBB2+Bp/L/zYThAslWqkIu3t/JI4zlzXmqfBofIK/96EV4shV3ShgPInrJ+?=
 =?us-ascii?Q?wDus87/GMMPMrhj2vK0AfpYAWJGS3/n+pK4UJaFBp2LFTI2B4QeyqoeloLU3?=
 =?us-ascii?Q?LAJbzjJqSOi3qnSrUVitklcE1+seEqmkrZObJfg1cV+Qybp2Njh02HKmJdOc?=
 =?us-ascii?Q?W0H0oriEh9IwBDruWh+zCgos1rHU8SIGWHceJadaCLnY0Hizamc63m5a610B?=
 =?us-ascii?Q?v3L8Zt6ZGsvWBVjdFn5Zhgi+qNknnS1AvWC2EAbXLCwoSEnrcknqy5hRNyxp?=
 =?us-ascii?Q?YmYz9ign40aVgLfHdeqqUwqlGmUFXnCCk3njn1bqZpgCxvE8uwCITLN2jeCy?=
 =?us-ascii?Q?1ZZ8LUTIoQBbemkRUPMUNbtefVltSHExxfThOBwK6jNNH+SCF88fbgkaYaN5?=
 =?us-ascii?Q?SMSsHOmDReF6cVwcLIK5sX1NRXOxcFn2rKsp2Nml02ZZKIDHhwWjkQEvhZJu?=
 =?us-ascii?Q?Kt4orFrVd2DT920nujEy+STy57lS9TnRmMRLZfv+Kg8kchZbMXmSAtRftFO9?=
 =?us-ascii?Q?4P5Su1NeVXeH+ebVTMKBJEpH9bCyrssrjYgUPLX3iVvlW8unqJSYqpe96tgc?=
 =?us-ascii?Q?KcTzFF+8013ZWkXU8BQFx0wYQx05cK5PZmVoaI073+JUMluwvT0mSQN0Gp/3?=
 =?us-ascii?Q?yWjgeijdHj57raz1CyIVmQgeW4yj+ZDpIPb/jzWn/ixP3AN1y39YiFGQPrzT?=
 =?us-ascii?Q?qTf63GVlZQhwBX8hr8gCyikInntrtkMputWwLOneHlAOz8vVPZFZpLqtADSi?=
 =?us-ascii?Q?h9/rDn8v9AT/BRSt1betGvNobhjq9w/vHLnPO8jhkpoQCEMPaYCCaWf7Q+j+?=
 =?us-ascii?Q?UF0KBUmn9+1JMXXlCaMKd9cyxnJzhGu/Q2Gfd1HFuAHIfePF8D8kyHmSXGAh?=
 =?us-ascii?Q?aDZNq+L6sDJPnn8Riq0xiRUEup/+Y5MjsAunEo1SSaA1q5RabBLGREqhOtGX?=
 =?us-ascii?Q?koBxmPnVsFzdD/dtL3JB5zmZNcH2RFLji2w+rzDqBbNeUJmuZ6OyztMmWZqX?=
 =?us-ascii?Q?5KcWfV2V0um9lIo5H7oJVmhn/rZTZtgyAug3ANzYT+iRiHJN6+cFnKpglUdJ?=
 =?us-ascii?Q?hkjHYEpfcz2ftvPlPZ6zfupxZLDl+fMF4MraQF47gjvIPH7xHMk/+9CkGnQO?=
 =?us-ascii?Q?BNkrju0oMJvXwzfomyJWG2ywO+aNWN7BsL3q+UO5oMYsDFm9NQjtIxfzV8f7?=
 =?us-ascii?Q?w2TCuqPsCVZbk4Ygj+Z3/eEHGu/bYADPOlHX9ZwDBdK/zbtIeol1hoSgaik2?=
 =?us-ascii?Q?BVuqRTvQEuHzMMYhMGMLpjWW7etZDAeEQbG8gXG62qg7v907c3eHxgsuefvF?=
 =?us-ascii?Q?NBzhTLAsk9dATIGd6IK6BGYlVtVQMRH+oHSu0vKvoUameiVp3KbhBV9sJHh3?=
 =?us-ascii?Q?OjfkYQOeLcXFxW1MYq8MO9vDjFJLpplWDh0sh6Ug0xLuPwbUJOH0NedFCABD?=
 =?us-ascii?Q?VjSBYOFaZ1sHHG2B9qt0moTfiyHP5WMncbCP5MoKiJLZAze//E6P78l147Oz?=
 =?us-ascii?Q?i578tWYjVNhhodoLJ5MP0CL9fbK4nbLbspxxu3jBtazEVg43srqaRCMoWzsy?=
 =?us-ascii?Q?rBybHl9Iu9FtxFAsl9HwompkDYY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EefF0gKyfF78kTJAu/AaV2XvUiPJ4M7SCjiGIftzpAVsSZnrxTHonJIjv8XKtfjPqz6WVwLxHcwUlfaIyzEjUCOzrvIwyll+tEwaGvvMJudzx2mmvodo4tRhfAGnovXbYeXNVrHihrnFM3Gpx9kCuAkGHzXhrTIJXGAcYiOu3Kc5LnanCTYBIiyWlXQ4pE9VjVCjBNKncBmJ8CfQlNC2kkE0h9ztPVxnk7SLXEYjF5eqARPs8co0WUEPWmSgoWykFcD/UI/AFpadE6B3HjPEafd37fUREYbRrXrKEjVqvVtB2xVKQcFmMPhaewYXQ4Q6z9EzaOPzHrQb8+0WrUrAiLyflWbB2YXCchG/WwdCx0x8XtX8tw+l6o2AZDgqcD3rCJ3ljNpPnUbbP4MTvSCOb5Bkg5T/eduSdrUiBlRcpsEGA/hIBfBhkC7wYFsbSUlT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:28:23.5211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496dbed7-03f7-409b-7482-08de6d461d14
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA8FAAE4F4
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

From: Hrushikesh Salunke <h-salunke@ti.com>

Add PCIe boot documentation for J784S4-EVM including boot mode switch
settings, hardware setup requirements, endpoint configuration details
and step-by-step boot procedure.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
[s-vadapalli@ti.com: simplified and documented the pcie_boot_util program]
Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 doc/board/ti/j784s4_evm.rst | 305 ++++++++++++++++++++++++++++++++++++
 1 file changed, 305 insertions(+)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index d858dc7cdbb..fb767bedbf6 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -299,6 +299,10 @@ http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
      - 00000000
      - 01110000
 
+   * - PCIe
+     - 10001000
+     - 01010000
+
 For SW7 and SW11, the switch state in the "ON" position = 1.
 
 Boot Mode Pins for AM69-SK
@@ -330,6 +334,307 @@ section.
 
 For SW2, the switch state in the "ON" position = 1.
 
+PCIe Boot
+---------
+
+The J784S4 SoC supports booting over PCIe, allowing the device to function
+as a PCIe endpoint and receive boot loader images from a PCIe Root Complex.
+The PCIe1 instance of PCIe is configured by Boot ROM for Endpoint Mode of
+operation. Hence, the PCIe Connector on the EVM corresponding to PCIe1
+should be utilized for PCIe Boot.
+
+Hardware Setup
+^^^^^^^^^^^^^^
+
+To boot the J784S4 EVM via PCIe, the following hardware setup is required:
+
+1. Configure the boot mode switches on J784S4-EVM for PCIe boot:
+
+   .. code-block:: text
+
+      SW7:  01010000
+      SW11: 10001000
+
+2. Connect the J784S4-EVM (endpoint) to a PCIe Root Complex (e.g., x86 host)
+   using a PCIe cable. Both boards should be powered off before making the
+   connection.
+
+Endpoint Configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+The following configuration options are enabled by default in
+``j784s4_evm_r5_defconfig`` and ``j784s4_evm_a72_defconfig``:
+
+- ``CONFIG_SPL_PCI_DFU_BAR_SIZE``: Size of the PCIe BAR for DFU/boot image download
+- ``CONFIG_SPL_PCI_DFU_VENDOR_ID``: PCIe vendor ID advertised by the endpoint
+- ``CONFIG_SPL_PCI_DFU_DEVICE_ID``: PCIe device ID advertised by the endpoint
+- ``CONFIG_SPL_PCI_DFU_MAGIC_WORD``: Magic word written by Root Complex to signal image transfer completion
+- ``CONFIG_SPL_PCI_DFU_BOOT_PHASE``: Current boot phase indicator for Root Complex
+
+By default, PCIe Root Complex mode is enabled in the device tree. For PCIe Boot,
+build the Bootloaders with the following content added to k3-j784s4-evm-u-boot.dtsi:
+
+.. code-block:: devicetree
+
+   &serdes0 {
+           /delete-property/ serdes0_usb_link;
+   };
+
+   &serdes_refclk {
+           bootph-all;
+   };
+
+   &serdes0_pcie1_link {
+           bootph-all;
+   };
+
+   &serdes_ln_ctrl {
+           bootph-all;
+   };
+
+   &pcie1_ctrl {
+           bootph-all;
+   };
+
+   &pcie1_rc {
+           status = "disabled";
+   };
+
+   &cbass_main {
+           pcie1_ep: pcie-ep@2910000 {
+                   compatible = "ti,j784s4-pcie-ep";
+                   reg = <0x00 0x02910000 0x00 0x1000>,
+                         <0x00 0x02917000 0x00 0x400>,
+                         <0x00 0x0d800000 0x00 0x00800000>,
+                         <0x00 0x18000000 0x00 0x08000000>;
+                   reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+                   interrupt-names = "link_state";
+                   interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+                   ti,syscon-pcie-ctrl = <&pcie1_ctrl 0x0>;
+                   max-link-speed = <3>;
+                   num-lanes = <2>;
+                   power-domains = <&k3_pds 333 TI_SCI_PD_EXCLUSIVE>;
+                   clocks = <&k3_clks 333 0>;
+                   clock-names = "fck";
+                   max-functions = /bits/ 8 <6>;
+                   max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
+                   dma-coherent;
+                   phys = <&serdes0_pcie1_link>;
+                   phy-names = "pcie-phy";
+                   bootph-all;
+           };
+   };
+
+PCIe Boot Procedure
+^^^^^^^^^^^^^^^^^^^
+
+The following steps describe the process of booting J784S4-EVM over PCIe:
+
+1. Compile the sample host program (provided after this section):
+
+   .. prompt:: bash
+
+      gcc -o pcie_boot_util pcie_boot_util.c
+
+2. Power on the J784S4-EVM (endpoint) after configuring boot mode switches
+   for PCIe Boot.
+
+3. Copy the compiled sample host program (pcie_boot_util) and the bootloader
+   images to the Root Complex. Check PCIe enumeration on Root Complex to ensure
+   that the J784S4 EVM shows up as the PCIe Endpoint:
+
+   .. prompt:: bash
+
+      lspci
+
+   The endpoint will appear as a RAM device or with multiple functions:
+
+   .. code-block:: text
+
+      0000:00:00.0 PCI bridge: Texas Instruments Device b012
+      0000:01:00.0 RAM memory: Texas Instruments Device b012
+      0000:01:00.1 Non-VGA unclassified device: Texas Instruments Device 0100
+      0000:01:00.2 Non-VGA unclassified device: Texas Instruments Device 0100
+
+4. Copy ``tiboot3.bin`` to the endpoint. Use ``lspci -vv`` to identify the BAR
+   address:
+
+   .. prompt:: bash
+
+      sudo ./pcie_boot_util 0x4007100000 tiboot3.bin
+
+   The sample program automatically writes the image start address to
+   ``0x41CF3FE0`` and the magic word ``0xB17CEAD9`` to ``0x41CF3FE4``.
+
+5. After ``tiboot3.bin`` is processed, the PCIe link will go down briefly.
+   Remove the PCIe device and rescan the bus:
+
+   .. prompt:: bash
+
+      echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
+      echo 1 > /sys/bus/pci/devices/0000\:00\:00.0/rescan
+      lspci
+
+   The enumeration will change to something similar:
+
+   .. code-block:: text
+
+      0000:00:00.0 PCI bridge: Texas Instruments Device b012
+      0000:01:00.0 RAM memory: Texas Instruments Device b010 (rev dc)
+
+   .. note::
+
+      When the Root-Complex enumerates the PCIe Endpoint after a 'remove-rescan' sequence,
+      it is possible that the 'BAR' appears 'disabled'. If so, writing to the BAR via the
+      'pcie_boot_util' to transfer the bootloader image will have no effect. In such cases,
+      run 'setpci -s 0000:01:00.0 COMMAND=0x02' on the Root-Complex after enumeration
+      (with appropriate DOMAIN:BUS:DEVICE.FUNCTION corresponding to the Endpoint) to enable
+      the BAR.
+
+6. Copy ``tispl.bin`` to the new BAR address (use ``lspci -vv`` to find):
+
+   .. prompt:: bash
+
+      sudo ./pcie_boot_util 0x4000400000 tispl.bin
+
+7. After ``tispl.bin`` is processed, the PCIe link will go down again. Remove
+   and rescan the PCIe device:
+
+   .. prompt:: bash
+
+      echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
+      echo 1 > /sys/bus/pci/devices/0000\:00\:00.0/rescan
+
+8. Copy ``u-boot.img``:
+
+   .. prompt:: bash
+
+      sudo ./pcie_boot_util 0x4000400000 u-boot.img
+
+9. After ``u-boot.img`` is successfully loaded, the boot process is complete
+   and endpoint should boot till U-Boot prompt.
+
+.. note::
+
+   During the boot process, "PCIe LINK DOWN" messages might appear in kernel
+   logs. This is expected as the endpoint resets and re-initializes the PCIe
+   link after processing each boot stage.
+
+Sample Host Program
+^^^^^^^^^^^^^^^^^^^
+
+The following C program can be used on the Root Complex to copy bootloader images
+to the J784S4 endpoint:
+
+.. code-block:: c
+
+   #include <stdio.h>
+   #include <stdlib.h>
+   #include <fcntl.h>
+   #include <sys/mman.h>
+   #include <unistd.h>
+   #include <string.h>
+
+   #define MAP_SIZE 0x400000
+
+   /*
+    * bootloader_file: Path to the bootloader image (tiboot3.bin, tispl.bin and u-boot.img)
+    * bootloader_mem: Memory allocated in RAM for reading the bootloader image file
+    * bar_address: Address of BAR to which bootloader image will be written
+    * bar_map_base: Mapping of the BAR Base Address for the program
+    * load_address: Address in BAR region where bootloader is being transferred
+    * transfer_completion_offset: Offset in BAR region to write to notify completion of transfer
+    * fd_mem: File descriptor for opening /dev/mem
+    * fptr: File pointer for bootloader image in filesystem
+    * magic_word: Magic word to notify completion of tiboot3.bin transfer to Boot ROM
+    * use_magic_word: Flag to indicate if Magic Word has to be written
+    * file_size: Size of bootloader image
+    * i: Iterator used during bootloader image transfer
+    */
+   int main(int argc, char *argv[])
+   {
+      off_t bar_address, load_address, transfer_completion_offset;
+      unsigned char *bootloader_mem;
+      const char *bootloader_file;
+      int fd_mem, i, use_magic_word;
+      unsigned int magic_word;
+      void *bar_map_base;
+      long file_size;
+      FILE * fptr;
+
+      if (argc != 3) {
+          printf("Usage: %s <bar_address> <bootloader_file>\n", argv[0]);
+          return 0;
+      }
+
+      bar_address = strtoul(argv[1], NULL, 16);
+      bootloader_file = argv[2];
+
+      printf("Bootloader File: %s\n", bootloader_file);
+      printf("BAR Address: 0x%lx\n", bar_address);
+
+      if(!strcmp(bootloader_file,"tiboot3.bin")) {
+          transfer_completion_offset = 0xF3FE0;
+          load_address = 0x41C00000;
+          magic_word = 0xB17CEAD9;
+          use_magic_word = 1;
+      } else {
+          transfer_completion_offset = MAP_SIZE - 0x4;
+          load_address = 0xDEADBEEF;
+          use_magic_word = 0;
+      }
+
+      fd_mem = open("/dev/mem", O_RDWR | O_SYNC);
+      if(fd_mem == -1) {
+          printf("failed to open /dev/mem\n");
+          return -1;
+      }
+
+      bar_map_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd_mem, bar_address);
+      if(bar_map_base == (void *)-1) {
+          printf("failed to map BAR\n");
+          return -1;
+      }
+
+      fptr = fopen(bootloader_file, "rb");
+      if (!fptr) {
+          printf("failed to read bootloader file\n");
+          return -1;
+      }
+
+      fseek(fptr, 0, SEEK_END);
+      file_size = ftell(fptr);
+      rewind(fptr);
+
+      bootloader_mem = (unsigned char *)malloc(sizeof(char) * file_size);
+      if(!bootloader_mem) {
+         printf("failed to allocate local memory for bootloader file\n");
+         return -1;
+      }
+
+      if (fread(bootloader_mem, 1, file_size, fptr) != file_size) {
+          printf("failed to read bootloader file into local memory\n");
+          return -1;
+      }
+
+      for(i = 0; i < file_size; i++) {
+          *((char *)(bar_map_base) + i) = bootloader_mem[i];
+      }
+
+      *(unsigned int *)(bar_map_base + transfer_completion_offset) = (unsigned int)(load_address);
+
+      if(use_magic_word) {
+          *(unsigned int *)(bar_map_base + transfer_completion_offset + 4) = magic_word;
+          printf("Magic word written for Boot ROM\n");
+      }
+
+      printf("Transferred %s to Endpoint\n", bootloader_file);
+      return 0;
+   }
+
+This program copies the boot image to the PCIe endpoint's memory region and
+writes the necessary control words to signal image transfer completion.
+
 Debugging U-Boot
 ----------------
 
-- 
2.51.1

