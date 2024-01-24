Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B66C47258
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 02:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F61F876F3;
	Wed, 24 Jan 2024 03:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QPh9VGon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59FB287579; Wed, 24 Jan 2024 03:15:23 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470C3876F3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 03:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bd7c5b2439so2883260b6e.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706062518; x=1706667318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HnHBYOD+trM8bf1rd3nFdBFZMrD1M/GLlCH34cHy0iM=;
 b=QPh9VGon5rtm2yOvhq4H3q/1cspgkZ2UmwAaGqpuNby9gQb4n36AD+h2/dtw5OSH7U
 lk92HcvXxjeiMQ8EIqxOMUfHx0CEessQ2IOBs2xdecXOeMneTUIG7ZUZPKnSu+UwGeJ9
 eBU4UGhoUMMeG+K8hDfa8BlFabiBsoB7eLOhK2G2El2CqulzPRykuizkE1InicUctyFO
 w8+NVzVm3oJa0m3wm2T/uajf7+S7EuOvVptmadvlS/4lZaUiFl6rLAbT5EJLLSti+9RN
 mGRZIbfl43uItIR9mpjaIEDqKoy6WtvcR5jH6rmWiR5h313jjOlt06IMYMQHkUSvAkU8
 7y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706062518; x=1706667318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnHBYOD+trM8bf1rd3nFdBFZMrD1M/GLlCH34cHy0iM=;
 b=XNrbJ2wBKQj6jJk1P6fSdZbyxbTZoCWIwbWvHVi9Rsg2hQKHnfaUiveQxolm+5IYXK
 035QR+s2ywsod2sP3/+W8VSfpbjdOO44JEi4VLqdCq2lRoKhJmzxIV1khPxExtH7cvFw
 x8umcV1bHZoEX8q8Cd6DaUSvEt9pzOaG7NwqXj1jDfpHtu8vU4OkKK+e0CicZpWq9AiI
 u4k3PCNXbuQ615IP+qUQIz7XxzIhR7OWCZb41Yo6hklV6ffhzZ2t/gcGIDLvnhsBvXju
 xuddqGrRjQhdBD+c18JNoOn6S5NDo9ABWQF3GSQBivsEJbkclc5dPZdWspfKiuSyx3cX
 ougg==
X-Gm-Message-State: AOJu0YxsIYTDZYvG6KsaX0RKCU7oFIAOrvdLvzcK+WKPQI0DUyPP6yEa
 xSCLVUha/ccqn0w7XcQj6/7MHERDP/P5gjlLCUi6OrC0FuysXmSinWzb0IUX
X-Google-Smtp-Source: AGHT+IFG9TqN7t4OhG5ntLVk5R50c3EzxCRjbYFf/O8YUIXYqmwcehitDQDRjxdpTjbe5qF+OPHXXw==
X-Received: by 2002:a05:6808:d4e:b0:3bd:4d4e:841a with SMTP id
 w14-20020a0568080d4e00b003bd4d4e841amr881730oik.118.1706062518409; 
 Tue, 23 Jan 2024 18:15:18 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab
 (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
 by smtp.gmail.com with ESMTPSA id
 d16-20020ac851d0000000b00427f1fa87e6sm3996108qtn.56.2024.01.23.18.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 18:15:18 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jesse Taube <Mr.Bossman075@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Mamta Shukla <mamta.shukla@leica-geosystems.com>,
 Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
 Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Simon Glass <sjg@chromium.org>, Jassi Brar <jaswinder.singh@linaro.org>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Mikhail Ilin <ilin.mikhail.ol@gmail.com>
Subject: [PATCH v1] tools: mkimage: Add support for i.MXRT FlexSPI Header
Date: Tue, 23 Jan 2024 21:15:16 -0500
Message-ID: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Modify imx8m Flex SPI Configuration Block to work with imxrt.
Add more Flex SPI configuration options to Kconfig.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 include/imximage.h | 42 +++++++++++++------------
 tools/Kconfig      | 21 +++++++++++++
 tools/imx8mimage.c | 41 ++++++++++++------------
 tools/imximage.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+), 38 deletions(-)

diff --git a/include/imximage.h b/include/imximage.h
index c1ecc0b7cb..a951699d0a 100644
--- a/include/imximage.h
+++ b/include/imximage.h
@@ -210,33 +210,37 @@ typedef struct {
 	uint8_t datasetup;
 	uint8_t coladdrwidth;
 	uint8_t devcfgenable;
-	uint8_t reserved_2[3];
+	uint8_t deviceModeType;
+	uint16_t waitTimeCfgCommands;
 	uint8_t devmodeseq[4];
-	uint8_t devmodearg[4];
+	uint32_t devmodearg;
 	uint8_t cmd_enable;
-	uint8_t reserved_3[3];
+	uint8_t configModeType[3];
 	uint8_t cmd_seq[16] ;
 	uint8_t cmd_arg[16];
-	uint8_t controllermisc[4];
+	uint32_t controllermisc;
 	uint8_t dev_type;
 	uint8_t sflash_pad;
 	uint8_t serial_clk;
-	uint8_t lut_custom ;
-	uint8_t reserved_4[8];
-	uint8_t sflashA1[4];
-	uint8_t sflashA2[4];
-	uint8_t sflashB1[4];
-	uint8_t sflashB2[4];
-	uint8_t cspadover[4];
-	uint8_t sclkpadover[4];
-	uint8_t datapadover[4];
-	uint8_t dqspadover[4];
-	uint8_t timeout[4];
-	uint8_t commandInt[4];
-	uint8_t datavalid[4];
-	uint8_t busyoffset[2];
-	uint8_t busybitpolarity[2];
+	uint8_t lut_custom;
+	uint8_t reserved_2[8];
+	uint32_t sflashA1;
+	uint32_t sflashA2;
+	uint32_t sflashB1;
+	uint32_t sflashB2;
+	uint32_t cspadover;
+	uint32_t sclkpadover;
+	uint32_t datapadover;
+	uint32_t dqspadover;
+	uint32_t timeout;
+	uint32_t commandInt;
+	uint16_t datavalid[2];
+	uint16_t busyoffset;
+	uint16_t busybitpolarity;
 	uint8_t lut[256];
+	uint8_t lutCustomSeq[48];
+	uint8_t reserved_3[16];
+
 } __attribute__((packed)) fspi_conf;
 
 typedef void (*set_dcd_val_t)(struct imx_header *imxhdr,
diff --git a/tools/Kconfig b/tools/Kconfig
index f01ed783e6..667807b331 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -148,6 +148,27 @@ config SERIAL_CLK_FREQUENCY
 	  Chip specific frequency: other value 30MHz
 	  1-30MHz  2-50MHz 3-60MHz 4-75MHz 5-80MHz 6-100MHz 7-133MHz 8-166MHz
 
+config FSPI_COL_ADDR_W
+	hex "Column Address With"
+	default 0x00
+	depends on FSPI_CONF_HEADER
+	help
+	  Default 0. For HyperBus protocol, it is fixed to 3
+
+config FSPI_CONTROLLER_MISC
+	hex "FSPI miscellaneous control"
+	default 0x00000000
+	depends on FSPI_CONF_HEADER
+	help
+	  Default 0. [0x40] Controller Misc Options
+
+config FSPI_FLASH_A1_SIZE
+	hex "Size in bytes of Flash A1"
+	default 0x10000000
+	depends on FSPI_CONF_HEADER
+	help
+	  Size of Flash connected to A1 in bytes
+
 config LUT_CUSTOM_SEQUENCE
 	hex "Enable Custom Look Up Table(LUT) Sequence"
 	default 0x00
diff --git a/tools/imx8mimage.c b/tools/imx8mimage.c
index 21075c2379..939f829a9f 100644
--- a/tools/imx8mimage.c
+++ b/tools/imx8mimage.c
@@ -426,36 +426,39 @@ static int generate_fspi_header (int ifd)
 	.read_sample = CONFIG_READ_CLK_SOURCE,
 	.datahold =  0x03,
 	.datasetup = 0x03,
-	.coladdrwidth = 0x00,
+	.coladdrwidth = CONFIG_FSPI_COL_ADDR_W,
 	.devcfgenable = 0x00,
-	.reserved_2 = {0x00, 0x00, 0x00},
+	.deviceModeType = 0x00,
+	.waitTimeCfgCommands = 0x0000,
 	.devmodeseq =  {0x00, 0x00, 0x00, 0x00},
-	.devmodearg =  {0x00, 0x00, 0x00, 0x00},
+	.devmodearg =  0x00000000,
 	.cmd_enable =  0x00,
-	.reserved_3 = {0x00},
+	.configModeType = {0x00},
 	.cmd_seq = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 							0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
 	.cmd_arg = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 							0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-	.controllermisc = {0x00, 0x00, 0x00, 0x00},
+	.controllermisc = cpu_to_le32(CONFIG_FSPI_CONTROLLER_MISC),
 	.dev_type = CONFIG_DEVICE_TYPE,
 	.sflash_pad = CONFIG_FLASH_PAD_TYPE,
 	.serial_clk = CONFIG_SERIAL_CLK_FREQUENCY,
 	.lut_custom = CONFIG_LUT_CUSTOM_SEQUENCE,
-	.reserved_4 = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-	.sflashA1  =  {0x00, 0x00, 0x00, 0x10},
-	.sflashA2 = {0x00, 0x00, 0x00, 0x00},
-	.sflashB1 = {0x00, 0x00, 0x00, 0x00},
-	.sflashB2 =  {0x00, 0x00, 0x00, 0x00},
-	.cspadover = {0x00, 0x00, 0x00, 0x00},
-	.sclkpadover = {0x00, 0x00, 0x00, 0x00},
-	.datapadover = {0x00, 0x00, 0x00, 0x00},
-	.dqspadover = {0x00, 0x00, 0x00, 0x00},
-	.timeout =  {0x00, 0x00, 0x00, 0x00},
-	.commandInt = {0x00, 0x00, 0x00, 0x00},
-	.datavalid  = {0x00, 0x00, 0x00, 0x00},
-	.busyoffset = {0x00, 0x00},
-	.busybitpolarity = {0x00, 0x00},
+	.reserved_2 = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+	.sflashA1  =  cpu_to_le32(CONFIG_FSPI_FLASH_A1_SIZE),
+	.sflashA2 = 0x00000000,
+	.sflashB1 = 0x00000000,
+	.sflashB2 = 0x00000000,
+	.cspadover = 0x00000000,
+	.sclkpadover = 0x00000000,
+	.datapadover = 0x00000000,
+	.dqspadover = 0x00000000,
+	.timeout =  0x00000000,
+	.commandInt = 0x00000000,
+	.datavalid  = {0x0000, 0x0000},
+	.busyoffset = 0x0000,
+	.busybitpolarity = 0x0000,
+	.lutCustomSeq = {0x00},
+	.reserved_3 = {0x00}
 	};
 
 	for (val = strtok(lut_str, ","); val; val = strtok(NULL, ",")) {
diff --git a/tools/imximage.c b/tools/imximage.c
index b3da1f244c..2df4c7dd49 100644
--- a/tools/imximage.c
+++ b/tools/imximage.c
@@ -908,6 +908,64 @@ int imximage_check_params(struct image_tool_params *params)
 		(params->xflag) || !(strlen(params->imagename));
 }
 
+#ifdef CONFIG_FSPI_CONF_HEADER
+static void generate_fspi_header(int ifd)
+{
+	int i = 0;
+	char *val;
+	char lut_str[] = CONFIG_LUT_SEQUENCE;
+
+	fspi_conf fspi_conf_data = {
+	.tag = {0x46, 0x43, 0x46, 0x42},
+	.version = {0x00, 0x00, 0x01, 0x56},
+	.reserved_1 = {0x00, 0x00, 0x00, 0x00},
+	.read_sample = CONFIG_READ_CLK_SOURCE,
+	.datahold =  0x03,
+	.datasetup = 0x03,
+	.coladdrwidth = CONFIG_FSPI_COL_ADDR_W,
+	.devcfgenable = 0x00,
+	.deviceModeType = 0x00,
+	.waitTimeCfgCommands = 0x0000,
+	.devmodeseq =  {0x00, 0x00, 0x00, 0x00},
+	.devmodearg =  0x00000000,
+	.cmd_enable =  0x00,
+	.configModeType = {0x00},
+	.cmd_seq = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+							0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+	.cmd_arg = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+							0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+	.controllermisc = cpu_to_le32(CONFIG_FSPI_CONTROLLER_MISC),
+	.dev_type = CONFIG_DEVICE_TYPE,
+	.sflash_pad = CONFIG_FLASH_PAD_TYPE,
+	.serial_clk = CONFIG_SERIAL_CLK_FREQUENCY,
+	.lut_custom = CONFIG_LUT_CUSTOM_SEQUENCE,
+	.reserved_2 = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+	.sflashA1  =  cpu_to_le32(CONFIG_FSPI_FLASH_A1_SIZE),
+	.sflashA2 = 0x00000000,
+	.sflashB1 = 0x00000000,
+	.sflashB2 = 0x00000000,
+	.cspadover = 0x00000000,
+	.sclkpadover = 0x00000000,
+	.datapadover = 0x00000000,
+	.dqspadover = 0x00000000,
+	.timeout =  0x00000000,
+	.commandInt = 0x00000000,
+	.datavalid  = {0x0000, 0x0000},
+	.busyoffset = 0x0000,
+	.busybitpolarity = 0x0000,
+	.lutCustomSeq = {0x00},
+	.reserved_3 = {0x00}
+	};
+
+	for (val = strtok(lut_str, ","); val; val = strtok(NULL, ","))
+		fspi_conf_data.lut[i++] = strtoul(val, NULL, 16);
+
+	lseek(ifd, 0, SEEK_CUR);
+	if (write(ifd, &fspi_conf_data, sizeof(fspi_conf_data)) == -1)
+		exit(EXIT_FAILURE);
+}
+#endif
+
 static int imximage_generate(struct image_tool_params *params,
 	struct image_type_params *tparams)
 {
@@ -917,6 +975,11 @@ static int imximage_generate(struct image_tool_params *params,
 	char *datafile = params->datafile;
 	uint32_t pad_len, header_size;
 
+#ifdef CONFIG_FSPI_CONF_HEADER
+	int fspi_fd;
+	char *fspi;
+#endif
+
 	memset(&imximage_header, 0, sizeof(imximage_header));
 
 	/*
@@ -977,6 +1040,20 @@ static int imximage_generate(struct image_tool_params *params,
 
 	pad_len = ROUND(sbuf.st_size, 4096) - sbuf.st_size;
 
+#ifdef CONFIG_FSPI_CONF_HEADER
+	fspi = CONFIG_FSPI_CONF_FILE;
+	fspi_fd = open(fspi, O_RDWR | O_CREAT, S_IRWXU);
+	if (fspi_fd < 0) {
+		fprintf(stderr, "Can't open %s: %s\n",
+			fspi, strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	generate_fspi_header(fspi_fd);
+	close(fspi_fd);
+
+#endif
+
 	return pad_len;
 }
 
-- 
2.43.0

