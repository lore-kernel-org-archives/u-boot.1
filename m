Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1557EE7071E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20D1D86C40;
	Thu, 21 Sep 2023 13:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BeXIU8Ut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96158864C4; Thu, 21 Sep 2023 13:21:05 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555CF86844
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQJEFLJS510dO5fRn9r/L9hc1tBk1Vg+oN49qSJ2iB6PDa2SgrM1YQxi/hGDafTN9H3vHRXoMNFsIOkaXfluF1AYAjSSoz9Ob6YiNcsXsCA4xqaHpcF93fb/04wz6DuWgsCdpKaYgB8sQNhtMHpIFi8pnwQNnXf6eyLxku3dDMndO8wzBrx+u4kkX/NfGsSSTaW3OigIcTbr5Ov6XPMT8aNRhHubvcpRzEixsi3W1UJpa4bGelRabfBM8KW/fbtVux4GLiFoARh1RBWKRvc1WRkDBtpVVnTLzSUM4n+j1DUkUBxnEwq5nIrDna6m/8ZAOokh0bDL355ZdwnCMusnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1synP8UVlQxn8MqhjrOf8YsV4wLD+7e6pApz6srZLUo=;
 b=JtXG3nTUwB1AC8UytKQXeIWzmGjewHwxTUeglNrROO/2MTyCckpeaxDz2gpDRcYqNCZB5Lr+3FMYgw3nEztBqohvLek0U9BWWX43fUxwARdH1bLcls3fTwbGHw2JtyOOy0qVAIWkd+WUIB6VIt2OofpzgI97LxRZt68sWARQV+rPYfdhlbRPxZGr/5YxObenu/pgmVUSseZ+blpt+0ocYYlmaky9j25j6+YqbKGoUPRu7+TkD9I0qplqV5XxCwRHvq2NaSc2VlMECisQARdWDXu3BNKK6njXFvyjORjy1luQjPMekPk/s4wv7AzKjnmU/Ub8pri2Z/i+uJ7+2RHeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1synP8UVlQxn8MqhjrOf8YsV4wLD+7e6pApz6srZLUo=;
 b=BeXIU8UtQaVgPOnF9mAR0X1Ug629YKk0ue9CgGQtcX5PwYwWszqAEVr0C/rTruvP9GqElTrfubp9MuUnEtDcaCcrhi54+LfKzJIU74Ud+4nz9p87zCkicrX/0/fvYx+zufo5u2pi5/BbMtWWLUX+ciUefjr2ooAZrl2zI+uMQk0=
Received: from MW2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:907:1::38)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 11:20:57 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::15) by MW2PR16CA0061.outlook.office365.com
 (2603:10b6:907:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 11:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 11:20:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 06:20:56 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 21 Sep 2023 06:20:54 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>, "Algapally
 Santosh Sagar" <santoshsagar.algapally@amd.com>
Subject: [PATCH v8 2/2] serial: zynqmp: Fetch baudrate from dtb and update
Date: Thu, 21 Sep 2023 16:50:43 +0530
Message-ID: <20230921112043.3144726-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921112043.3144726-1-venkatesh.abbarapu@amd.com>
References: <20230921112043.3144726-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: bca5399a-cdb5-4073-a0e5-08dbba94d3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EESybjnFMY+g3i7tP5CAMhgBifVuLdKphkmFKVrRc3zEnbqq4ic7xePJfQp2cX/KY1kmNbWzF9Cmug0Qg7ZC2xym2nvqnBbf/GMRmydLiK73QoYkP/fPU2WkhIokO1qoBTYx4+ePUKaQBtwnsdjMXcpngQl+RDz86QrHt1x50PFB6+kBnfKGYttyWBnyWDXmK9IZGDOLhiqVlPRgkvnJH0kPHY1jD9F8GYrlQuidZuxnY/6VjFuIdsCl+MFDJRClHBhr1c77HkDRiRRfvZuKbTsJy8945TxMgunA1O5gylRw8jlKGd1nkmsVDZrTBMFnxkcFck+vaGEqeipFJAak1ggZ8qfZMtpiTvna3SMvay2XtovxCCSayG0sxSO633G4iiwYoZ9wNimp1E9UiT3RdNoR+vEXhsNs/4q/Fq/FiQW8oETNqIKEB9Wc9fblIjjGISKjQszEmIlaJ3kLPKWaJdVfhBOWldi0tA+C9NLVGVvtjvcJadT7nt2l7rflF8oZN+/utiG1KEMgyzCLKq8Xh4fnW3ZtiFhK0bRRSej5SdHWJDKXQTFcNu+IqqCgzX56PC7cWmLcGF3uJSqEgRfQrkvC5bYogpyJIUyCzvTzZpF3WLcADjJ3JIngSGkO9EZ8/7diK5XsOQi71kwtnKJxhqnFmavbcnXIpdyP3xAves2eWmvrLw+U9ayJB9oIneSG3VVqU7h+G9q6QGX6uQIGf/ikF9HoKjs+58c2EthSbhavvxlc2cI27wPX5YyfERCp+R7OJh58rX1t63piLdNSOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(82740400003)(5660300002)(4326008)(36756003)(2906002)(15650500001)(316002)(6916009)(54906003)(8676002)(41300700001)(8936002)(36860700001)(6666004)(336012)(426003)(478600001)(47076005)(70206006)(81166007)(356005)(2616005)(40480700001)(86362001)(70586007)(26005)(40460700003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 11:20:57.3862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca5399a-cdb5-4073-a0e5-08dbba94d3e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
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

Also add test to cover this new function.

Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 arch/sandbox/dts/test.dts      |  1 +
 doc/README.serial_dt_baud      | 41 ++++++++++++++++++++++++++++
 drivers/core/ofnode.c          | 18 +++++++++++++
 drivers/serial/Kconfig         |  9 +++++++
 drivers/serial/serial-uclass.c | 49 ++++++++++++++++++++++++++++++++++
 include/dm/ofnode.h            | 14 ++++++++--
 include/env_default.h          |  6 ++++-
 include/serial.h               |  7 +++++
 test/dm/serial.c               |  1 +
 9 files changed, 143 insertions(+), 3 deletions(-)
 create mode 100644 doc/README.serial_dt_baud

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index f351d5cb84..deb57f146a 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1499,6 +1499,7 @@
 		other-node = "/some-bus/c-test@5";
 		int-values = <0x1937 72993>;
 		u-boot,acpi-ssdt-order = <&acpi_test2 &acpi_test1>;
+		stdout-path = "serial0:115200n8";
 		chosen-test {
 			compatible = "denx,u-boot-fdt-test";
 			reg = <9 1>;
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
index 067fae2614..a6291d21d2 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -154,12 +154,61 @@ static void serial_find_console_or_panic(void)
 }
 #endif /* CONFIG_SERIAL_PRESENT */
 
+/**
+ * check_valid_baudrate() - Check whether baudrate is valid or not
+ *
+ * @baud: baud rate to check
+ * Return: 0 if OK, -ve on error
+ */
+static int check_valid_baudrate(int baud)
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
+		char *ptr = (char*)&default_environment[0];
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
index 42bdf3759c..b21a452a3a 100644
--- a/include/serial.h
+++ b/include/serial.h
@@ -337,6 +337,13 @@ int serial_setconfig(struct udevice *dev, uint config);
  */
 int serial_getinfo(struct udevice *dev, struct serial_device_info *info);
 
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
diff --git a/test/dm/serial.c b/test/dm/serial.c
index 37d17a65f1..34b783e062 100644
--- a/test/dm/serial.c
+++ b/test/dm/serial.c
@@ -29,6 +29,7 @@ static int dm_test_serial(struct unit_test_state *uts)
 					      &dev_serial));
 
 	ut_assertok(serial_tstc());
+	ut_asserteq(115200, fetch_baud_from_dtb());
 	/*
 	 * test with default config which is the only one supported by
 	 * sandbox_serial driver
-- 
2.25.1

