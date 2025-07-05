Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADEAC83F03
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 03:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9160583015;
	Sun,  6 Jul 2025 05:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VyAvUql1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E34482A76; Sat,  5 Jul 2025 22:57:27 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60895809A5
 for <u-boot@lists.denx.de>; Sat,  5 Jul 2025 22:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ae0b6532345so536608166b.1
 for <u-boot@lists.denx.de>; Sat, 05 Jul 2025 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751749044; x=1752353844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCj3yzINjXr8H5gk3VXn/Q07HVcmN+758DosVLWQA3s=;
 b=VyAvUql1UM+Pt5jl9jG/YTO/Y8Ub5jG8Tk3AIO+DIrBn4nBqyxo2piWQcIKzBM8vTC
 Ghb32e0Fl0VTDEd0Xp8dSlcvJK7BGZ3SVUfoF62Y4GyoqzXzQyqc0yQbSk/3cutYgUdP
 6+jtSAU3YXyd/WJFQywGVJM39Fd3RLsCxzRRAhLagvQZ7oWmkIV3cFDE57w/ABYC8JTO
 gP8nQqc4z2S5/m5Z5AXKAZd3N1CWFsnZqp0s5XCH/jazLxIzuBp6a973l513cecZsaLo
 sl+yiUpUBw4E9SU+eMCrlwkiPIbMFKTQpL7eWUgJypS7IToiFh837+3WJL29IRZDL1Zi
 ua2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751749044; x=1752353844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCj3yzINjXr8H5gk3VXn/Q07HVcmN+758DosVLWQA3s=;
 b=Q8nczSOA75tYO4+/cdek4t9lFRobiA2tJjlucFv9wYQeQhnJPD17S3cb+hpiLB/bcm
 7GSxaz1bAY6rNHfjKT9VNSXATAAqmsNtCgOLTg7gQH8cAZ7HhDiWwO8XrQzbhGHDzB35
 PL7OfCQTjtRcpsGeZ6g2Qmwi5LCdNd1BJF+KNWb6E8fls8NPmT9CZsWQKRer/o7IzezG
 Ct7pviDx/whkc06wXYkzTETnfyeDOCku9+/OP6ePInm9Ut0kQkrBE0LFTDHrXM868v2N
 vxtbjNh4JQhNmmhRbXTR6fcDN06LX2Jme9ggNcAlSC13YEmouDdfNpntc6Z9jnX+XPcd
 Ep8A==
X-Gm-Message-State: AOJu0YyacWTA/elh5zFoQ3ZgG1Rxz4GencLndNRojnN6DvP3qsxal+WN
 +S1kLtf+LBSZYDuCkr6pATSE1RJ38jWhja9IzoAvn9FX0Xz131GGI4Gqcz0fT7TKca8=
X-Gm-Gg: ASbGncuy0ZfJ96j7cl/XNn+Ieks1eA3NgNrBVJsKHb2456eFwLQ/mYdoNIZycgapoS2
 7vJ/VrqINX2QDM27tLgXiNeee2O0TFFNpdGMnMPBjusB0N0os5uYp/em2uobW/DF5UFxDsHsD2n
 OLMPkppaFcmdCFo+J8G1NNXT0BzozmHhq6ZPrfC/PFtDEkv0KmZh6hJ8sa2d+B6yrmXPZFdJi7C
 cR/U2SwXVAt/og6t8mbL/iPnSCA2WI/S/u27eaT8hnLxAmYNDAvCVISCAawM/SbLa4KXNB5FD+V
 +WFAeSfBcnauYrVNZCxuipc1kBV9SWAdwtRprI9Jm/d81IjNpZ7yG6tX8x3hG7ip
X-Google-Smtp-Source: AGHT+IGBOJyHMlgGiSmV/A1x9CNER3XSuDnvIM5NdXVGCtUbjNco1wHV6vFz7plmEJGr8Mp98oV1OQ==
X-Received: by 2002:a17:907:e90c:b0:ae3:a753:615b with SMTP id
 a640c23a62f3a-ae3f82d9c7bmr697889066b.19.1751749044173; 
 Sat, 05 Jul 2025 13:57:24 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66e6f51sm399423666b.8.2025.07.05.13.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Jul 2025 13:57:23 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v4 4/5] drivers: fpga: cleanup printf usage
Date: Sat,  5 Jul 2025 22:57:05 +0200
Message-ID: <20250705205710.792370-5-vtpieter@gmail.com>
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

