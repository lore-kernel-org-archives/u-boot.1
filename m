Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A987C83F03
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 03:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB20082F6F;
	Sun,  6 Jul 2025 05:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c8stFeLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779D982A76; Sat,  5 Jul 2025 22:57:23 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1618206E
 for <u-boot@lists.denx.de>; Sat,  5 Jul 2025 22:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo3068344a12.3
 for <u-boot@lists.denx.de>; Sat, 05 Jul 2025 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751749041; x=1752353841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zu7VvTWhMKC7LMh5UnlJRYAG3VccQ2JbAXMx4GfALyY=;
 b=c8stFeLjZM33j0bRCMS6+ily48uOivmdhMOjjSi1cmhlNIejLGp4IGTquLlc7SbjU3
 SsbfeCw9fY8JQ4dkG52kpiuCrelDiMP0Hif14c0Yl4Nopt4+OfJ7QgVyb6j75uyK5ZAo
 /BxSnxEkIa+luhfovnHiO6X10AbvNwN266109Oy8VexlpbRvpmNhnCG2ESXhqElPtGAQ
 g8rRJMqB6b9V7agGH/DirSYgF+aiF1J4cf8dRs5TcSrGToeehFEmlZkPzMaBWRAhay6Z
 Xbhbd5gvn/4of+KxCgKXxfN/773J8jeW7G7Ru7erm/O4d/FXBkrq+rPThmYTqrxM47mw
 TfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751749041; x=1752353841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zu7VvTWhMKC7LMh5UnlJRYAG3VccQ2JbAXMx4GfALyY=;
 b=HnKqqE6tA1DYSSrqCKdm5K/oJXcAMDnyDcqWU+g9rirtA7CqKHVbFtk5O/0U7Z4vAQ
 2V47GJw2qxwjGPs8T3SOXmP46+QXKW0LNSSxgQt42whQfb5rc8fT8EBBmQQllY7ZErYA
 vFKjy/bevp8noRfPKz8gXV52+fDryXjAMgEsLINngvXLDYx4JBV37e8sKLzuuuAzBgCh
 waNirJcQelaeDZsdb9BYCGQ3D1iIUYPToCqAh7Hh+xlZDmUA0i0zpzy0f2CvKfdstrlT
 j+Txq12dngC0Y6yDcUEFEEFchXOTVSYbqRWB3xxKGXARvysCqJaPdf3q/hlubUOQ4y57
 ASaA==
X-Gm-Message-State: AOJu0YxL8eFgaIQ4ElAxGV6nPcN1hWQ1mJ2XFW71gGIfNu/lkkJeUC41
 /usGRqG77Wo0/V6OFiBaVsO+jn1rNS8tUR82KBnhW4QF+rPWYBJGldlsr8F4gke7azk=
X-Gm-Gg: ASbGncvWRQ4T0qOQ1sOT8NJ/Belrnc8E8bW1kVRRftKEaC12DITH81WiIOK84idUDWz
 FJGBdFZ64rH9Hm2lOc+INb2JEeKEbliZmHhY9NyAI+pMFqyr+fsM9e57RXPUpjq6XXSy/YNpGgo
 z6MHV+eS4VBo3Y7to3N+fCjkfeV6J1lueL5rYs6C+HYYyc6wjk0wuf3qHbRma1uH3hVuYiAa8+7
 Vo96Ntl2KWu8ZCMIGQpyEat0k+nq95VYIp+c6ZfSQkMbIbNSMWh33FcK0uWvt0XjRmvCifAnxPL
 tCykvozH1aY91ufYUylE1J/Rha3lH3G5iemPJfMQbrn2e5SO8swu5ycB+IYASO1yaR7Rl2VeSfQ
 =
X-Google-Smtp-Source: AGHT+IH0JUJN01sPwtYFULkdxCv9krm6AG/JvRmJBHqsrRp0zFwpbuFKD0vNbsjDPw8KHg36GBHKPg==
X-Received: by 2002:a17:906:d54c:b0:add:fb01:c64a with SMTP id
 a640c23a62f3a-ae3fe7f113bmr641279466b.43.1751749040367; 
 Sat, 05 Jul 2025 13:57:20 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66e6f51sm399423666b.8.2025.07.05.13.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Jul 2025 13:57:20 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v4 1/5] cmd: fpga: improve user feedback in case of bitstream
 load failure
Date: Sat,  5 Jul 2025 22:57:02 +0200
Message-ID: <20250705205710.792370-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250705205710.792370-1-vtpieter@gmail.com>
References: <20250705205710.792370-1-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 06 Jul 2025 05:50:01 +0200
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

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

In cmd/fpga.c, change some `debug` calls to `log_err` for important
user feedback and use CMD_RET_FAILURE in favor of CMD_RET_USAGE due to
its long output which hides the actual, useful return message. Change
the remaining `debug` calls to `log_debug`. Remove all 'fpga:' and
__func__ strings as log_* has this covered.

For `do_fpga_loads`, move up the `do_fpga_check_params` call for more
consistent command output; use a constant instead of multiple '5' use.

In drivers/fpga/zynq*.c, change 'up to' to 'above' which corrects this
confusing/wrong statement.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 cmd/fpga.c              | 99 +++++++++++++++++++++--------------------
 drivers/fpga/zynqmppl.c |  4 +-
 drivers/fpga/zynqpl.c   |  4 +-
 3 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index 9dc7b63db5d..9cc51f04698 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -28,7 +28,7 @@ static long do_fpga_get_device(char *arg)
 	if (dev == FPGA_INVALID_DEVICE && arg)
 		dev = simple_strtol(arg, NULL, 16);
 
-	debug("%s: device = %ld\n", __func__, dev);
+	log_debug("device = %ld\n", dev);
 
 	return dev;
 }
@@ -40,26 +40,26 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
 	size_t local_data_size;
 	long local_fpga_data;
 
-	debug("%s %d, %d\n", __func__, argc, cmdtp->maxargs);
+	log_debug("%d, %d\n", argc, cmdtp->maxargs);
 
 	if (argc != cmdtp->maxargs) {
-		debug("fpga: incorrect parameters passed\n");
-		return CMD_RET_USAGE;
+		log_err("Incorrect number of parameters passed\n");
+		return CMD_RET_FAILURE;
 	}
 
 	*dev = do_fpga_get_device(argv[0]);
 
 	local_fpga_data = simple_strtol(argv[1], NULL, 16);
 	if (!local_fpga_data) {
-		debug("fpga: zero fpga_data address\n");
-		return CMD_RET_USAGE;
+		log_err("Zero fpga_data address\n");
+		return CMD_RET_FAILURE;
 	}
 	*fpga_data = local_fpga_data;
 
 	local_data_size = hextoul(argv[2], NULL);
 	if (!local_data_size) {
-		debug("fpga: zero size\n");
-		return CMD_RET_USAGE;
+		log_err("Zero size\n");
+		return CMD_RET_FAILURE;
 	}
 	*data_size = local_data_size;
 
@@ -70,51 +70,52 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
 static int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
+	struct fpga_secure_info fpga_sec_info;
+	const int pos_userkey = 5;
 	size_t data_size = 0;
 	long fpga_data, dev;
 	int ret;
-	struct fpga_secure_info fpga_sec_info;
 
 	memset(&fpga_sec_info, 0, sizeof(fpga_sec_info));
 
-	if (argc < 5) {
-		debug("fpga: incorrect parameters passed\n");
-		return CMD_RET_USAGE;
+	if (argc < pos_userkey) {
+		log_err("Too few parameters passed\n");
+		return CMD_RET_FAILURE;
 	}
 
-	if (argc == 6)
+	if (argc == pos_userkey + 1)
 		fpga_sec_info.userkey_addr = (u8 *)(uintptr_t)
-					      simple_strtoull(argv[5],
+					      simple_strtoull(argv[pos_userkey],
 							      NULL, 16);
 	else
 		/*
 		 * If 6th parameter is not passed then do_fpga_check_params
 		 * will get 5 instead of expected 6 which means that function
-		 * return CMD_RET_USAGE. Increase number of params +1 to pass
+		 * return CMD_RET_FAILURE. Increase number of params +1 to pass
 		 * this.
 		 */
 		argc++;
 
+	ret = do_fpga_check_params(&dev, &fpga_data, &data_size,
+				   cmdtp, argc, argv);
+	if (ret)
+		return ret;
+
 	fpga_sec_info.encflag = (u8)hextoul(argv[4], NULL);
 	fpga_sec_info.authflag = (u8)hextoul(argv[3], NULL);
 
 	if (fpga_sec_info.authflag >= FPGA_NO_ENC_OR_NO_AUTH &&
 	    fpga_sec_info.encflag >= FPGA_NO_ENC_OR_NO_AUTH) {
-		debug("fpga: Use <fpga load> for NonSecure bitstream\n");
-		return CMD_RET_USAGE;
+		log_err("Use <fpga load> for NonSecure bitstream\n");
+		return CMD_RET_FAILURE;
 	}
 
 	if (fpga_sec_info.encflag == FPGA_ENC_USR_KEY &&
 	    !fpga_sec_info.userkey_addr) {
-		debug("fpga: User key not provided\n");
-		return CMD_RET_USAGE;
+		log_err("User key not provided\n");
+		return CMD_RET_FAILURE;
 	}
 
-	ret = do_fpga_check_params(&dev, &fpga_data, &data_size,
-				   cmdtp, argc, argv);
-	if (ret)
-		return ret;
-
 	return fpga_loads(dev, (void *)fpga_data, data_size, &fpga_sec_info);
 }
 #endif
@@ -245,23 +246,23 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 	ulong dev = do_fpga_get_device(argv[0]);
 	char *datastr = env_get("fpgadata");
 
-	debug("fpga: argc %x, dev %lx, datastr %s\n", argc, dev, datastr);
+	log_debug("argc %x, dev %lx, datastr %s\n", argc, dev, datastr);
 
 	if (dev == FPGA_INVALID_DEVICE) {
-		debug("fpga: Invalid fpga device\n");
-		return CMD_RET_USAGE;
+		log_err("Invalid fpga device\n");
+		return CMD_RET_FAILURE;
 	}
 
 	if (argc == 0 && !datastr) {
-		debug("fpga: No datastr passed\n");
-		return CMD_RET_USAGE;
+		log_err("No datastr passed\n");
+		return CMD_RET_FAILURE;
 	}
 
 	if (argc == 2) {
 		datastr = argv[1];
-		debug("fpga: Full command with two args\n");
+		log_debug("Full command with two args\n");
 	} else if (argc == 1 && !datastr) {
-		debug("fpga: Dev is setup - fpgadata passed\n");
+		log_debug("Dev is setup - fpgadata passed\n");
 		datastr = argv[0];
 	}
 
@@ -269,20 +270,20 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (fit_parse_subimage(datastr, (ulong)fpga_data,
 			       &fit_addr, &fit_uname)) {
 		fpga_data = (void *)fit_addr;
-		debug("*  fpga: subimage '%s' from FIT image ",
-		      fit_uname);
-		debug("at 0x%08lx\n", fit_addr);
+		log_debug("*  fpga: subimage '%s' from FIT image ",
+			  fit_uname);
+		log_debug("at 0x%08lx\n", fit_addr);
 	} else
 #endif
 	{
 		fpga_data = (void *)hextoul(datastr, NULL);
-		debug("*  fpga: cmdline image address = 0x%08lx\n",
-		      (ulong)fpga_data);
+		log_debug("*  fpga: cmdline image address = 0x%08lx\n",
+			  (ulong)fpga_data);
 	}
-	debug("%s: fpga_data = 0x%lx\n", __func__, (ulong)fpga_data);
+	log_debug("fpga_data = 0x%lx\n", (ulong)fpga_data);
 	if (!fpga_data) {
-		puts("Zero fpga_data address\n");
-		return CMD_RET_USAGE;
+		log_err("Zero fpga_data address\n");
+		return CMD_RET_FAILURE;
 	}
 
 	switch (genimg_get_format(fpga_data)) {
@@ -303,13 +304,13 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 
 			if (gunzip((void *)data, ~0UL, (void *)image_buf,
 				   &image_size) != 0) {
-				puts("GUNZIP: error\n");
+				log_err("Gunzip error\n");
 				return CMD_RET_FAILURE;
 			}
 			data_size = image_size;
 #else
-			puts("Gunzip image is not supported\n");
-			return 1;
+			log_err("Gunzip image is not supported\n");
+			return CMD_RET_FAILURE;
 #endif
 		} else {
 			data = (ulong)image_get_data(hdr);
@@ -327,12 +328,12 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 		const void *fit_data;
 
 		if (!fit_uname) {
-			puts("No FIT subimage unit name\n");
+			log_err("No FIT subimage unit name\n");
 			return CMD_RET_FAILURE;
 		}
 
 		if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
-			puts("Bad FIT image format\n");
+			log_err("Bad FIT image format\n");
 			return CMD_RET_FAILURE;
 		}
 
@@ -348,7 +349,7 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 #endif
 	default:
-		puts("** Unknown image type\n");
+		log_err("Unknown image type\n");
 		return CMD_RET_FAILURE;
 	}
 }
@@ -390,16 +391,16 @@ static int do_fpga_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 	fpga_cmd = find_cmd_tbl(argv[1], fpga_commands,
 				ARRAY_SIZE(fpga_commands));
 	if (!fpga_cmd) {
-		debug("fpga: non existing command\n");
-		return CMD_RET_USAGE;
+		log_err("Non existing command\n");
+		return CMD_RET_FAILURE;
 	}
 
 	argc -= 2;
 	argv += 2;
 
 	if (argc > fpga_cmd->maxargs) {
-		debug("fpga: more parameters passed\n");
-		return CMD_RET_USAGE;
+		log_err("Too many parameters passed\n");
+		return CMD_RET_FAILURE;
 	}
 
 	ret = fpga_cmd->cmd(fpga_cmd, flag, argc, argv);
diff --git a/drivers/fpga/zynqmppl.c b/drivers/fpga/zynqmppl.c
index 2b62bbbe3cf..1199b249e36 100644
--- a/drivers/fpga/zynqmppl.c
+++ b/drivers/fpga/zynqmppl.c
@@ -191,8 +191,8 @@ static int zynqmp_validate_bitstream(xilinx_desc *desc, const void *buf,
 	}
 
 	if ((ulong)buf < SZ_1M) {
-		printf("%s: Bitstream has to be placed up to 1MB (%px)\n",
-		       __func__, buf);
+		log_err("Bitstream has to be placed above 1MB (%px)\n",
+			buf);
 		return FPGA_FAIL;
 	}
 
diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
index 3e86d854a01..a8ca015a8a6 100644
--- a/drivers/fpga/zynqpl.c
+++ b/drivers/fpga/zynqpl.c
@@ -360,8 +360,8 @@ static int zynq_validate_bitstream(xilinx_desc *desc, const void *buf,
 	}
 
 	if ((u32)buf < SZ_1M) {
-		printf("%s: Bitstream has to be placed up to 1MB (%x)\n",
-		       __func__, (u32)buf);
+		log_err("Bitstream has to be placed above 1MB (%px)\n",
+			(u32)buf);
 		return FPGA_FAIL;
 	}
 
-- 
2.48.1

