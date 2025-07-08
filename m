Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDE0C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 15:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F07833F1;
	Tue,  8 Jul 2025 17:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jxr/DweX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67247832F0; Tue,  8 Jul 2025 17:25:11 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592D683371
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 17:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ae3a604b43bso700388166b.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751988309; x=1752593109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCj3yzINjXr8H5gk3VXn/Q07HVcmN+758DosVLWQA3s=;
 b=Jxr/DweXapx641dfblUMEWKeFPcf4tjBIosLfHiY975nX1KcEkCvOHhWWodsYgu8EK
 8hLZ8kW8MR/m2ZiK3AUQVwBzt87JcJfXGKD1JbrOLA1SrP7ASS1fiaE2OZcxeBHTySQ1
 7V+N9VELvE3oInNSs63Nq1pWpnniCeDlh1CMLVIyB7mYRKNXoU3OT7dpXQsEuvFy9GHB
 Ifaxd9ahxpzmE6YVw/3ZXhxwup7vax4VKS8WKvNc9ymHOWbVeDdAoqmp8Bi2iZ2ktNE0
 e3qZU1WlskolBxme9TycDD/IGhrea3OhqerRms0w9m6/H7Itac/7V8GmkKorSGb8RIu2
 RZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751988309; x=1752593109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCj3yzINjXr8H5gk3VXn/Q07HVcmN+758DosVLWQA3s=;
 b=qePrxQ2sBcJSUSNEd8hwksWiHBM6WXI7zKx0AhmwEJ95yeHf/FurP6xBapqnFlAi68
 oB2CFiZvJyIF0xrFmuIRNonmkfisSeCQ9TxlOVut75YoPnI4xMX7KQIWQZf4VXOUtuPQ
 FgDLCNtmSKfk9r46Oc196j6bxanzcjVHlVNHAPcKOZ9v88q08oT2pwJFuEk033IL3ZPF
 kUqLA2YTGUiaFei94B+He//zjuovI/90BM5NBCKpizkdNqRwVx7jTVrlsiyXSeafiCeb
 0qw4JBfhd75un7BVJMZ+oxKuSgt126Qki9CVQsJFr+oPmM9EV+1yoQAdkkgWPNVE5bBu
 hDsg==
X-Gm-Message-State: AOJu0Ywn2nXBMo40B8cpxzeCbtGPNVosJkRjFywahXdEqr1nI6PiKrnG
 9lkvXxPhnnA1kibXCuwUFdZZqJ8Ix2U4EA2keOyakDe+iOLUbCovXLeNUqB4kd8l
X-Gm-Gg: ASbGnctMc2b/8f2s+9/S68EZINlWrIoUJYhdlFbDhNJ7EYtrTPsA4+d/oarhIkD/P/5
 Tc6CovJkeHhuLZBV6hrUlBvz5/Mn1KD59PypHKcVTKXDFOjXjsgksplb3WN4FJ7rHkmadd5t5qz
 /zCBLb5NyqdF+CtZIunsdTrHPKB7hkfvxBt+cOv/cKSz4WYZ7tHB7V0fdPEHFabI5PGekSjYxO7
 hA5Jw/1fy7C4q1tRyD5szSbQ/gT5FH66pKBTxEzRBzlsS3KECrFo9ZJRg7nHFKoHaAnatNd1Z+0
 KDzE9sDZlNU7RMp65zWds4MfHUK2JiX3uP/TbPcqsDs8O7Ua1fC49kvdlwZ6+n1g
X-Google-Smtp-Source: AGHT+IFu2vNeg5dWEkvo6p7B7Ao+Qry6mGiPdbQ5zV48oBPjiaSIXH+D+3wDZm7+hXslfWQnSUivqA==
X-Received: by 2002:a17:906:3598:b0:ae3:c521:db6 with SMTP id
 a640c23a62f3a-ae3fbdc844fmr1438788266b.58.1751988308496; 
 Tue, 08 Jul 2025 08:25:08 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d931csm921950666b.10.2025.07.08.08.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 08:25:08 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v5 4/6] drivers: fpga: cleanup printf usage
Date: Tue,  8 Jul 2025 17:24:49 +0200
Message-ID: <20250708152455.1214487-5-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250708152455.1214487-1-vtpieter@gmail.com>
References: <20250708152455.1214487-1-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Jul 2025 17:29:30 +0200
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

Remove `fpga_no_sup` to get rid of Werror=unused-function when all
FPGA configurations are enabled.

Swap all printf calls to log_* as this is now preferred and includes
the calling __func__.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/fpga/fpga.c   | 103 +++++++++++++++++-------------------------
 drivers/fpga/xilinx.c |   2 +-
 include/fpga.h        |   2 +-
 3 files changed, 44 insertions(+), 63 deletions(-)

diff --git a/drivers/fpga/fpga.c b/drivers/fpga/fpga.c
index f88267e01b6..2297fefd149 100644
--- a/drivers/fpga/fpga.c
+++ b/drivers/fpga/fpga.c
@@ -16,20 +16,6 @@
 static int next_desc = FPGA_INVALID_DEVICE;
 static fpga_desc desc_table[CONFIG_MAX_FPGA_DEVICES];
 
-/*
- * fpga_no_sup
- * 'no support' message function
- */
-static void fpga_no_sup(char *fn, char *msg)
-{
-	if (fn && msg)
-		printf("%s: No support for %s.\n", fn, msg);
-	else if (msg)
-		printf("No support for %s.\n", msg);
-	else
-		printf("No FPGA support!\n");
-}
-
 /* fpga_get_desc
  *	map a device number to a descriptor
  */
@@ -39,8 +25,8 @@ const fpga_desc *fpga_get_desc(int devnum)
 
 	if ((devnum >= 0) && (devnum < next_desc)) {
 		desc = &desc_table[devnum];
-		debug("%s: found fpga descriptor #%d @ 0x%p\n",
-		      __func__, devnum, desc);
+		log_debug("found fpga descriptor #%d @ 0x%p\n",
+			  devnum, desc);
 	}
 
 	return desc;
@@ -51,15 +37,15 @@ const fpga_desc *fpga_get_desc(int devnum)
  *	generic parameter checking code
  */
 const fpga_desc *fpga_validate(int devnum, const void *buf,
-			       size_t bsize, char *fn)
+			       size_t bsize)
 {
 	const fpga_desc *desc = fpga_get_desc(devnum);
 
 	if (!desc)
-		printf("%s: Invalid device number %d\n", fn, devnum);
+		log_err("Invalid device number %d\n", devnum);
 
 	if (!buf) {
-		printf("%s: Null buffer.\n", fn);
+		log_err("Null buffer.\n");
 		return NULL;
 	}
 	return desc;
@@ -75,40 +61,40 @@ static int fpga_dev_info(int devnum)
 	const fpga_desc *desc = fpga_get_desc(devnum);
 
 	if (desc) {
-		debug("%s: Device Descriptor @ 0x%p\n",
-		      __func__, desc->devdesc);
+		log_info("Device Descriptor @ 0x%p\n",
+			 desc->devdesc);
 
 		switch (desc->devtype) {
 		case fpga_xilinx:
 #if defined(CONFIG_FPGA_XILINX)
-			printf("Xilinx Device\nDescriptor @ 0x%p\n", desc);
+			log_info("Xilinx Device\nDescriptor @ 0x%p\n", desc);
 			ret_val = xilinx_info(desc->devdesc);
 #else
-			fpga_no_sup((char *)__func__, "Xilinx devices");
+			log_err("No support for Xilinx devices.\n");
 #endif
 			break;
 		case fpga_altera:
 #if defined(CONFIG_FPGA_ALTERA)
-			printf("Altera Device\nDescriptor @ 0x%p\n", desc);
+			log_info("Altera Device\nDescriptor @ 0x%p\n", desc);
 			ret_val = altera_info(desc->devdesc);
 #else
-			fpga_no_sup((char *)__func__, "Altera devices");
+			log_err("No support for Altera devices.\n");
 #endif
 			break;
 		case fpga_lattice:
 #if defined(CONFIG_FPGA_LATTICE)
-			printf("Lattice Device\nDescriptor @ 0x%p\n", desc);
+			log_info("Lattice Device\nDescriptor @ 0x%p\n", desc);
 			ret_val = lattice_info(desc->devdesc);
 #else
-			fpga_no_sup((char *)__func__, "Lattice devices");
+			log_err("No support for Lattice devices.\n");
 #endif
 			break;
 		default:
-			printf("%s: Invalid or unsupported device type %d\n",
-			       __func__, desc->devtype);
+			log_err("Invalid or unsupported device type %d\n",
+				desc->devtype);
 		}
 	} else {
-		printf("%s: Invalid device number %d\n", __func__, devnum);
+		log_err("Invalid device number %d\n", devnum);
 	}
 
 	return ret_val;
@@ -144,23 +130,22 @@ int fpga_add(fpga_type devtype, void *desc)
 	int devnum = FPGA_INVALID_DEVICE;
 
 	if (!desc) {
-		printf("%s: NULL device descriptor\n", __func__);
+		log_err("NULL device descriptor\n");
 		return devnum;
 	}
 
 	if (next_desc < 0) {
-		printf("%s: FPGA support not initialized!\n", __func__);
+		log_err("FPGA support not initialized!\n");
 	} else if ((devtype > fpga_min_type) && (devtype < fpga_undefined)) {
 		if (next_desc < CONFIG_MAX_FPGA_DEVICES) {
 			devnum = next_desc;
 			desc_table[next_desc].devtype = devtype;
 			desc_table[next_desc++].devdesc = desc;
 		} else {
-			printf("%s: Exceeded Max FPGA device count\n",
-			       __func__);
+			log_err("Exceeded Max FPGA device count\n");
 		}
 	} else {
-		printf("%s: Unsupported FPGA type %d\n", __func__, devtype);
+		log_err("Unsupported FPGA type %d\n", devtype);
 	}
 
 	return devnum;
@@ -181,7 +166,7 @@ int __weak fpga_is_partial_data(int devnum, size_t img_len)
 int __weak fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 			      bitstream_type bstype)
 {
-	printf("Bitstream support not implemented for this FPGA device\n");
+	log_err("Bitstream support not implemented for this FPGA device\n");
 	return FPGA_FAIL;
 }
 
@@ -190,8 +175,7 @@ int fpga_fsload(int devnum, const void *buf, size_t size,
 		 fpga_fs_info *fpga_fsinfo)
 {
 	int ret_val = FPGA_FAIL;           /* assume failure */
-	const fpga_desc *desc = fpga_validate(devnum, buf, size,
-					      (char *)__func__);
+	const fpga_desc *desc = fpga_validate(devnum, buf, size);
 
 	if (desc) {
 		switch (desc->devtype) {
@@ -200,12 +184,12 @@ int fpga_fsload(int devnum, const void *buf, size_t size,
 			ret_val = xilinx_loadfs(desc->devdesc, buf, size,
 						fpga_fsinfo);
 #else
-			fpga_no_sup((char *)__func__, "Xilinx devices");
+			log_err("No support for Xilinx devices.\n");
 #endif
 			break;
 		default:
-			printf("%s: Invalid or unsupported device type %d\n",
-			       __func__, desc->devtype);
+			log_err("Invalid or unsupported device type %d\n",
+				desc->devtype);
 		}
 	}
 
@@ -219,8 +203,7 @@ int fpga_loads(int devnum, const void *buf, size_t size,
 {
 	int ret_val = FPGA_FAIL;
 
-	const fpga_desc *desc = fpga_validate(devnum, buf, size,
-					      (char *)__func__);
+	const fpga_desc *desc = fpga_validate(devnum, buf, size);
 
 	if (desc) {
 		switch (desc->devtype) {
@@ -229,12 +212,12 @@ int fpga_loads(int devnum, const void *buf, size_t size,
 			ret_val = xilinx_loads(desc->devdesc, buf, size,
 					       fpga_sec_info);
 #else
-			fpga_no_sup((char *)__func__, "Xilinx devices");
+			log_err("No support for Xilinx devices.\n");
 #endif
 			break;
 		default:
-			printf("%s: Invalid or unsupported device type %d\n",
-			       __func__, desc->devtype);
+			log_err("Invalid or unsupported device type %d\n",
+				desc->devtype);
 		}
 	}
 
@@ -265,8 +248,7 @@ int fpga_load(int devnum, const void *buf, size_t bsize, bitstream_type bstype,
 {
 	int ret_val = FPGA_FAIL;           /* assume failure */
 	int ret_notify;
-	const fpga_desc *desc = fpga_validate(devnum, buf, bsize,
-					      (char *)__func__);
+	const fpga_desc *desc = fpga_validate(devnum, buf, bsize);
 
 	if (desc) {
 		switch (desc->devtype) {
@@ -275,26 +257,26 @@ int fpga_load(int devnum, const void *buf, size_t bsize, bitstream_type bstype,
 			ret_val = xilinx_load(desc->devdesc, buf, bsize,
 					      bstype, flags);
 #else
-			fpga_no_sup((char *)__func__, "Xilinx devices");
+			log_err("No support for Xilinx devices.\n");
 #endif
 			break;
 		case fpga_altera:
 #if defined(CONFIG_FPGA_ALTERA)
 			ret_val = altera_load(desc->devdesc, buf, bsize);
 #else
-			fpga_no_sup((char *)__func__, "Altera devices");
+			log_err("No support for Altera devices.\n");
 #endif
 			break;
 		case fpga_lattice:
 #if defined(CONFIG_FPGA_LATTICE)
 			ret_val = lattice_load(desc->devdesc, buf, bsize);
 #else
-			fpga_no_sup((char *)__func__, "Lattice devices");
+			log_err("No support for Lattice devices.\n");
 #endif
 			break;
 		default:
-			printf("%s: Invalid or unsupported device type %d\n",
-			       __func__, desc->devtype);
+			log_err("Invalid or unsupported device type %d\n",
+				desc->devtype);
 		}
 	}
 
@@ -312,8 +294,7 @@ int fpga_load(int devnum, const void *buf, size_t bsize, bitstream_type bstype,
 int fpga_dump(int devnum, const void *buf, size_t bsize)
 {
 	int ret_val = FPGA_FAIL;           /* assume failure */
-	const fpga_desc *desc = fpga_validate(devnum, buf, bsize,
-					      (char *)__func__);
+	const fpga_desc *desc = fpga_validate(devnum, buf, bsize);
 
 	if (desc) {
 		switch (desc->devtype) {
@@ -321,26 +302,26 @@ int fpga_dump(int devnum, const void *buf, size_t bsize)
 #if defined(CONFIG_FPGA_XILINX)
 			ret_val = xilinx_dump(desc->devdesc, buf, bsize);
 #else
-			fpga_no_sup((char *)__func__, "Xilinx devices");
+			log_err("No support for Xilinx devices.\n");
 #endif
 			break;
 		case fpga_altera:
 #if defined(CONFIG_FPGA_ALTERA)
 			ret_val = altera_dump(desc->devdesc, buf, bsize);
 #else
-			fpga_no_sup((char *)__func__, "Altera devices");
+			log_err("No support for Altera devices.\n");
 #endif
 			break;
 		case fpga_lattice:
 #if defined(CONFIG_FPGA_LATTICE)
 			ret_val = lattice_dump(desc->devdesc, buf, bsize);
 #else
-			fpga_no_sup((char *)__func__, "Lattice devices");
+			log_err("No support for Lattice devices.\n");
 #endif
 			break;
 		default:
-			printf("%s: Invalid or unsupported device type %d\n",
-			       __func__, desc->devtype);
+			log_err("Invalid or unsupported device type %d\n",
+				desc->devtype);
 		}
 	}
 
@@ -363,7 +344,7 @@ int fpga_info(int devnum)
 
 			return FPGA_SUCCESS;
 		} else {
-			printf("%s: No FPGA devices available.\n", __func__);
+			log_err("No FPGA devices available.\n");
 			return FPGA_FAIL;
 		}
 	}
diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
index c46513226d9..28c68faba55 100644
--- a/drivers/fpga/xilinx.c
+++ b/drivers/fpga/xilinx.c
@@ -49,7 +49,7 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 
 	dataptr = (unsigned char *)fpgadata;
 	/* Find out fpga_description */
-	desc = fpga_validate(devnum, dataptr, 0, (char *)__func__);
+	desc = fpga_validate(devnum, dataptr, 0);
 	/* Assign xilinx device description */
 	xdesc = desc->devdesc;
 
diff --git a/include/fpga.h b/include/fpga.h
index 4cc44164b2f..a144238e66a 100644
--- a/include/fpga.h
+++ b/include/fpga.h
@@ -79,7 +79,7 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 int fpga_dump(int devnum, const void *buf, size_t bsize);
 int fpga_info(int devnum);
 const fpga_desc *fpga_validate(int devnum, const void *buf,
-			       size_t bsize, char *fn);
+			       size_t bsize);
 int fpga_compatible2flag(int devnum, const char *compatible);
 
 #endif	/* _FPGA_H_ */
-- 
2.48.1

