Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5812AE7071F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2766E86BC8;
	Thu, 21 Sep 2023 13:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CQZROgi8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB0486BFB; Thu, 21 Sep 2023 06:21:58 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E5D86C9A
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 06:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAFYWQ34ymL25utkCC1C2LrWE2QKzJsGRvIYnjVP4ATJ1XeD4zd0yd+webPX+zhXELtexqFRownuU+THj8TlFQ6i89iwisryIXNji3hcckJjDbljdu7JnnXASsc/GrLe1HXKlIICKALooNflxLHTBkXHZXZ/YyWO0pUYIpQI0VljMK9TtxT2kkj0R3NXAymPu+bHP2b3UhoyIP6Xg3xanEkniEbZ8jJUee5jjsS99Y0nMS1K9Io/w1S6PM+PPG0uzLamgo+6ea7JZ9FsFUMVq+vTPDRRVu290ctnfhgMyeXlan31/BMnIOXC0B/uoMfwXO/4GylX0Kk5RP6udkEpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toiErde3x/v17V1JxxMqhK4SDIMOq8Lv3J0FWybWIaA=;
 b=TOJ8h574MALVoQK+BSy4gEIa2Whex2OOEW/aDqRO1b4aiqp7NraJGQt4V6w1jTeuJLTJtAx+5IDJSnVxFEFNVvp/fg2Z7SsM3gqMWIKvLBd/azuOPzYF/+lJ+0Ca9j1ol8QyNULJ374lPFiNqi1A2AZxYH5iJCfXx8wGs0D9Y5baTcu3hb13SpDHz/MDtlsVhratxPu7RuxNagsAN1S9acMTMOlrMRkRL4omIrr23lm/qM9bjw/yxPxFikg/QF+xp6WdxsiS/ihrz/dfTBPnBCEZjB6pVsMDa/fg/1PQAdfKl5q3HG9Ci+cHo2yOtF5tOyR32ZESAgNTB6evnPFJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toiErde3x/v17V1JxxMqhK4SDIMOq8Lv3J0FWybWIaA=;
 b=CQZROgi8YwUbd6XuN9EHfFVxF+pKs0SX3JMl/xWJQDLahq+qI62lKt8b3KtCXnweJzA3QJC21G8Xh5rgYv0oo4VT1ydFMZFxYNjxsYHwQ9bmcWNpNUOeVQpgkc3udawHzPYfaVkrg/kGk5JKHsQnAWpv4ke/5bj0OtEJmIF0U/s=
Received: from PH8PR21CA0009.namprd21.prod.outlook.com (2603:10b6:510:2ce::26)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 04:21:49 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::bd) by PH8PR21CA0009.outlook.office365.com
 (2603:10b6:510:2ce::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.9 via Frontend
 Transport; Thu, 21 Sep 2023 04:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 04:21:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 23:21:47 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 20 Sep 2023 23:21:46 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>, "Algapally
 Santosh Sagar" <santoshsagar.algapally@amd.com>
Subject: [PATCH v7 2/2] serial: zynqmp: Fetch baudrate from dtb and update
Date: Thu, 21 Sep 2023 09:51:30 +0530
Message-ID: <20230921042130.21139-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921042130.21139-1-venkatesh.abbarapu@amd.com>
References: <20230921042130.21139-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8a0081-d416-46c7-4c26-08dbba5a460c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaEaYACEoo4Etz8XRXtaoN4xtAwucYqZMj5FkRhUjWIOQ1uINDiljEpK6L84FOWT3C1BZbsYtBEd11YOQnC60ngEfY7Bskn+EFrEX6Sdgh5tNlK9DvuRyxZou+IEfRp8PZP3H/qvlcqLKb7teyM5aTFThU8jtsTq5A+hYlSBQw//q/l5+p3LMml0YXufrFbHQ0YztxORjn9MfqXpGEiIsAx2eXpqMUjMEyVEzWXBtOfKlgWCVnyhw7vK2q+6Bm2iPwbNbf9bKvvS5mSvE2526gfrVO3aOrS6JcCNlRiFjrmKAkSeC3eUnIIIa+RNAu70uQXUmlEJIBjAR+HurRLMoI/u/uWef/+YQLcLSxYcZ/uxvmfwK5+vHidZwy7OUJm/jZLQS9k0S2yWScENqkF2yQY5bKpvDZmPMk4t3mFj6tEJ6NKQRzr4MqPwPciEKSSu09LvaVDsfwPWCsHkvFcwvS3naNcfQt3cWmwB15ho4f5qZlLipjKerJI570iWrfZbi67ILQ4l4lm9ZIcKaxOPKrY6UJiheJwMaBtcm8E92oRZLC9gzgfSHxIyw9KRh6O3+Vnp8TDbTgpIXNWDNDcVNxAm/Bgd/yhk8eIYBAxF8PTv8bn471lEWeZc6FtYb5RfSoSBSRNDQWlXMVBobBhx9x2/r3uX5Zh9gQEqiyq1ugmNrv3ksiKL+5rcJlfBA8JY+/HtwH00iDWHf1nSGrtF7kbt4hEM9xQuIggFAIHvadhk7rE3V9MdW5fZWsoR9tzyIC5rWkrYvsOhJivPNvImdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(6666004)(478600001)(47076005)(83380400001)(426003)(26005)(2616005)(2906002)(336012)(15650500001)(70586007)(70206006)(54906003)(316002)(6916009)(8676002)(8936002)(5660300002)(1076003)(4326008)(41300700001)(40460700003)(81166007)(82740400003)(86362001)(36860700001)(36756003)(40480700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 04:21:48.7466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8a0081-d416-46c7-4c26-08dbba5a460c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:25:12 +0200
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

From: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>

The baudrate configured in .config is taken by default by serial. If
change of baudrate is required then the .config needs to changed and
u-boot recompilation is required or the u-boot environment needs to be
updated.

To avoid this, support is added to fetch the baudrate directly from the
device tree file and update.
The serial, prints the log with the configured baudrate in the dtb.
The commit c4df0f6f315c ("arm: mvebu: Espressobin: Set default value for
$fdtfile env variable") is taken as reference for changing the default
environment variable.

The default environment stores the default baudrate value, When default
baudrate and dtb baudrate are not same glitches are seen on the serial.
So, the environment also needs to be updated with the dtb baudrate to
avoid the glitches on the serial.

Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 doc/README.serial_dt_baud      | 41 ++++++++++++++++++++++++++++++++
 drivers/core/ofnode.c          | 18 ++++++++++++++
 drivers/serial/Kconfig         |  9 +++++++
 drivers/serial/serial-uclass.c | 43 ++++++++++++++++++++++++++++++++++
 include/dm/ofnode.h            | 14 +++++++++--
 include/env_default.h          |  6 ++++-
 include/serial.h               | 15 ++++++++++++
 7 files changed, 143 insertions(+), 3 deletions(-)
 create mode 100644 doc/README.serial_dt_baud

diff --git a/doc/README.serial_dt_baud b/doc/README.serial_dt_baud
new file mode 100644
index 0000000000..f8768d0e1b
--- /dev/null
+++ b/doc/README.serial_dt_baud
@@ -0,0 +1,41 @@
+Fetch serial baudrate from DT
+-----------------------------
+
+To support fetching of baudrate from DT, the following is done:-
+
+The baudrate configured in Kconfig symbol CONFIG_BAUDRATE is taken by default by serial.
+If change of baudrate is required then the Kconfig symbol CONFIG_BAUDRATE needs to
+changed and U-Boot recompilation is required or the U-Boot environment needs to be updated.
+
+To avoid this, add support to fetch the baudrate directly from the device tree file and
+update the environment.
+
+The default environment stores the default baudrate value. When default baudrate and dtb
+baudrate are not same glitches are seen on the serial.
+So, the environment also needs to be updated with the dtb baudrate to avoid the glitches on
+the serial which is enabled by OF_SERIAL_BAUD.
+
+The Kconfig SPL_ENV_SUPPORT needs to be enabled to allow patching in SPL.
+
+The Kconfig DEFAULT_ENV_IS_RW which is enabled by OF_SERIAL_BAUD with making the environment
+writable.
+
+The ofnode_read_baud() function parses and fetches the baudrate value from the DT. This value
+is validated and updated to baudrate during serial init. Padding is added at the end of the
+default environment and the dt baudrate is updated with the latest value.
+
+Example:-
+
+The serial port options are of the form "bbbbpnf", where "bbbb" is the baud rate, "p" is parity ("n", "o", or "e"),
+"n" is number of bits, and "f" is flow control ("r" for RTS or omit it). Default is "115200n8".
+
+chosen {
+		bootargs = "earlycon console=ttyPS0,115200 clk_ignore_unused root=/dev/ram0 rw init_fatal_sh=1";
+		stdout-path = "serial0:115200n8";
+	};
+
+From the chosen node, stdout-path property is obtained as string.
+
+	stdout-path = "serial0:115200n8";
+
+The string is parsed to get the baudrate 115200. This string is converted to integer and updated to the environment.
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 8df16e56af..42f51ca93c 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -895,6 +895,24 @@ ofnode ofnode_get_chosen_node(const char *name)
 	return ofnode_path(prop);
 }
 
+int ofnode_read_baud(void)
+{
+	const char *str, *p;
+	u32 baud;
+
+	str = ofnode_read_chosen_string("stdout-path");
+	if (!str)
+		return -EINVAL;
+
+	/* Parse string serial0:115200n8 */
+	p = strchr(str, ':');
+	if (!p)
+		return -EINVAL;
+
+	baud = dectoul(p + 1, NULL);
+	return baud;
+}
+
 const void *ofnode_read_aliases_prop(const char *propname, int *sizep)
 {
 	ofnode node;
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 4d27034c3f..7fdf600dc5 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -24,6 +24,15 @@ config BAUDRATE
 	  in the SPL stage (most drivers) or for choosing a default baudrate
 	  in the absence of an environment setting (serial_mxc.c).
 
+config OF_SERIAL_BAUD
+	bool "Fetch serial baudrate from device tree"
+	depends on DM_SERIAL && SPL_ENV_SUPPORT
+	select DEFAULT_ENV_IS_RW
+	help
+	  Select this to enable fetching and setting of the baudrate
+	  configured in the DT. Replace the default baudrate with the DT
+	  baudrate and also set it to the environment.
+
 config DEFAULT_ENV_IS_RW
 	bool "Make default environment as writable"
 	help
diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 067fae2614..e5304b397d 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -154,12 +154,55 @@ static void serial_find_console_or_panic(void)
 }
 #endif /* CONFIG_SERIAL_PRESENT */
 
+int check_valid_baudrate(int baud)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(baudrate_table); ++i) {
+		if (baud == baudrate_table[i])
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+int fetch_baud_from_dtb(void)
+{
+	int baud_value, ret;
+
+	baud_value = ofnode_read_baud();
+	ret = check_valid_baudrate(baud_value);
+	if (ret)
+		return ret;
+
+	return baud_value;
+}
+
 /* Called prior to relocation */
 int serial_init(void)
 {
 #if CONFIG_IS_ENABLED(SERIAL_PRESENT)
 	serial_find_console_or_panic();
 	gd->flags |= GD_FLG_SERIAL_READY;
+
+	if (IS_ENABLED(CONFIG_OF_SERIAL_BAUD)) {
+		int ret = 0;
+		char *ptr = &default_environment[0];
+
+		/*
+		 * Fetch the baudrate from the dtb and update the value in the
+		 * default environment.
+		 */
+		ret = fetch_baud_from_dtb();
+		if (ret != -EINVAL && ret != -EFAULT) {
+			gd->baudrate = ret;
+
+			while (*ptr != '\0' && *(ptr + 1) != '\0')
+				ptr++;
+			ptr += 2;
+			sprintf(ptr, "baudrate=%d", gd->baudrate);
+		}
+	}
 	serial_setbrg();
 #endif
 
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 0f38b3e736..f0854cc28d 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -942,12 +942,22 @@ const char *ofnode_read_chosen_string(const char *propname);
 ofnode ofnode_get_chosen_node(const char *propname);
 
 /**
- * ofnode_read_aliases_prop() - get the value of a aliases property
+ * ofnode_read_baud() - get the baudrate from string value of chosen property
  *
- * This looks for a property within the /aliases node and returns its value
+ * This looks for stdout-path property within the /chosen node and parses its
+ * value to return baudrate.
  *
  * This only works with the control FDT.
  *
+ * Return: baudrate value if found, else -ve error code
+ */
+int ofnode_read_baud(void);
+
+/**
+ * ofnode_read_aliases_prop() - get the value of a aliases property
+ *
+ * This looks for a property within the /aliases node and returns its value
+ *
  * @propname: Property name to look for
  * @sizep: Returns size of property, or `FDT_ERR_...` error code if function
  *	returns NULL
diff --git a/include/env_default.h b/include/env_default.h
index 227cad7c34..2ca4a087d3 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -42,7 +42,7 @@ const char default_environment[] = {
 #if defined(CONFIG_BOOTDELAY)
 	"bootdelay="	__stringify(CONFIG_BOOTDELAY)	"\0"
 #endif
-#if defined(CONFIG_BAUDRATE) && (CONFIG_BAUDRATE >= 0)
+#if !defined(CONFIG_OF_SERIAL_BAUD) && defined(CONFIG_BAUDRATE) && (CONFIG_BAUDRATE >= 0)
 	"baudrate="	__stringify(CONFIG_BAUDRATE)	"\0"
 #endif
 #ifdef	CONFIG_LOADS_ECHO
@@ -118,6 +118,10 @@ const char default_environment[] = {
 #endif
 #ifdef	CFG_EXTRA_ENV_SETTINGS
 	CFG_EXTRA_ENV_SETTINGS
+#endif
+#ifdef CONFIG_OF_SERIAL_BAUD
+	/* Padding for baudrate at the end when environment is writable */
+	"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
 #endif
 	"\0"
 #else /* CONFIG_USE_DEFAULT_ENV_FILE */
diff --git a/include/serial.h b/include/serial.h
index 42bdf3759c..31a97ca9cf 100644
--- a/include/serial.h
+++ b/include/serial.h
@@ -337,6 +337,21 @@ int serial_setconfig(struct udevice *dev, uint config);
  */
 int serial_getinfo(struct udevice *dev, struct serial_device_info *info);
 
+/**
+ * check_valid_baudrate() - Check whether baudrate is valid or not
+ *
+ * @baud: baud rate to check
+ * Return: 0 if OK, -ve on error
+ */
+int check_valid_baudrate(int baud);
+
+/**
+ * fetch_baud_from_dtb() - Fetch the baudrate value from DT
+ *
+ * Return: baudrate if OK, -ve on error
+ */
+int fetch_baud_from_dtb(void);
+
 void atmel_serial_initialize(void);
 void mcf_serial_initialize(void);
 void mpc85xx_serial_initialize(void);
-- 
2.17.1

