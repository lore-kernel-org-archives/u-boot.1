Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C9ECE79AD
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DB886C7E;
	Wed, 20 Sep 2023 05:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NuPws52W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E92A86A84; Wed, 20 Sep 2023 05:28:07 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A7486BAC
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1vZ6n4l20ghbhyrXNT1nRNg5StOhMO9C96zzQdIqU1JY6pa+jH+QFCP0Po/zveXsBSsxN/CotzZos2kX40wW2/n3fSrfIcqOplcWNNjGHS0ElQW5L/MKhjBACt7mNSda7ivBB3sLcozgmPCcGTlQUE81FiFEy/tk7Geo21EYrtCnSm6sHAz56q0QGwxz+zJYmTsLEKBvIc4Cl9pdUgMYITZTl5jZiGFCPGplnU7OxkERvf5CL/zvSEfdEoDSBD0Ce8WmP9opwSR8etZmrzvzQQWn2RO93VqlQQYZ97QgppTzF/4H2rgWJpToIFXpYnb5Lk7ypCpSH3pH50Thn2BdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toiErde3x/v17V1JxxMqhK4SDIMOq8Lv3J0FWybWIaA=;
 b=Tq9+j7j/cAzaTNKs77yCpf1WRWDz9qmsUGPQJ+XbXbLlBkj3djLSkKyL5rX66Ofje184BJCi4kD4P+9n/TgKnLlvO7sTVLCN6cfbYe8hcP7tb2X0fSd+TzVK48CEx4N3K2b/jRMeRNNrEeksU/RFvDZuTL2HC4JZwrvvFVOsGxgXVjbJFkqIoKNfC/TaZKZQJgszR2cQFqy5GGKIxw1xzwQemZHMpUSPbIFwd7xWZpuZY3+q9DMaAWasMAKfN3+FPBv+ebL+Est8UBUczvvTlx4r65ztfkS53NCv7NTwzKLSNXzRa7Jg5g23kAic/V+r4yNMWO5uoEL3VX0w/vcaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toiErde3x/v17V1JxxMqhK4SDIMOq8Lv3J0FWybWIaA=;
 b=NuPws52WvkJ37m2a+3NFzo0rGer6j9nn+VO6JXnE6ljuRNBShgUwZaAuusYPuoUs+enzqBfzEiyTJDS3OvbHMU/2XU7Y+1wbHEcYeHirk2wbSRyBOSTRn5IsKVb+M/UL7E9FbXqOjoV6nveZdJ97mKopW+PT82FXtcfKrSt0YhU=
Received: from DM6PR02CA0059.namprd02.prod.outlook.com (2603:10b6:5:177::36)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 03:27:57 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::93) by DM6PR02CA0059.outlook.office365.com
 (2603:10b6:5:177::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:27:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:27:56 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:27:54 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>, "Algapally
 Santosh Sagar" <santoshsagar.algapally@amd.com>
Subject: [PATCH v6 2/2] serial: zynqmp: Fetch baudrate from dtb and update
Date: Wed, 20 Sep 2023 08:57:25 +0530
Message-ID: <20230920032725.21748-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230920032725.21748-1-venkatesh.abbarapu@amd.com>
References: <20230920032725.21748-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 889aedf2-4483-4b1a-ca2d-08dbb9899575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xR+WSh7KDcSpTe1hiHFJui33etubvtVUdBoNGLc6ABNPzb+tXuxX/U1KLiaPatXR1ca2XPUmYoi7VHLhTts2ZcrYXKnikI2wkFW6X33CkoToD++XFb9xCKpdLDrWeiJ+A/GMqUgHTARgzyuO53p0fGQpKw03C2kgfTz8cbUOJZulufgBzuQZ256HJZdyyj6geIjiOqMGtLWaYixsMF6EkpJP2Cut4KuGejaULiLHGfNn8gVUJPn+cXh5MuJQqu/P9fN24R7uKocw8X5nodIoUrrnCYcm3/aJgBto7UgJ0LTHIJ0MwnQIlIPue+jHJyrIoKxcNQPRCQ1AshkkoxdOtGI200QXivDUKahv3A/cQMJnaQImrf3s4m5QWt02/yx701D3JsMh6yN+t8APhe4DEnL+o84QVK7PLEGmpZAHwRW4ntvXKIRM87imaHyUmdvIBd8xMR9IxNjsfMqbAYKAtIdm0FpEvT121qYIPmyx4j/bH54DdJXhQhfx1VzUrsD887irGgzEtPYRJrsp9kWfaEb8sW5jGZc7gvJt21ae5RKF8f4o9dMLPzRT0VcEzp4yLjFnlKn6XJukpDOE+OM5YfQqfgvr82UEofnL8PWc6eToFJXRcIBOIIHXmAnQp0OdXYu+RY166F4op0rBEVZaPLVhcIEjKsxI3f5X8xr9dpL/ek56NV/Cyd27+ReTzU2K2We465PX66Q57j9CWfte56d9Ej1hZL8qWGbqkoEG2K44Vg+cMmHoYrOlznonapoxvw7QaREofXz9E8CY/HBGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(6666004)(478600001)(26005)(1076003)(426003)(83380400001)(47076005)(15650500001)(4326008)(2616005)(336012)(2906002)(70206006)(70586007)(8676002)(54906003)(5660300002)(6916009)(8936002)(316002)(41300700001)(40460700003)(40480700001)(36860700001)(86362001)(82740400003)(36756003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:27:57.1458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 889aedf2-4483-4b1a-ca2d-08dbb9899575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
X-Mailman-Approved-At: Wed, 20 Sep 2023 05:42:43 +0200
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

