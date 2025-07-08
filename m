Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71873C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 15:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4991833E8;
	Tue,  8 Jul 2025 17:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kkbv/wIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E04832F0; Tue,  8 Jul 2025 17:25:10 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330EA83285
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 17:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c85so6255216a12.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751988308; x=1752593108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSOBVOCtCg8RyLSMTZs3IWZ/v7JXRDHcSOVcIMEQ8hc=;
 b=Kkbv/wIeRVtwmpsNpM1xSsZwXX1vogLyxZNDfHPZJMTHZYiXHOIqNEe6iGde/6aKuf
 ClSHOv/4ZiwhV2Sc3W8SkFpwDlSVqG8xYlbCqIWLQOnMlqUiG38tgpo9sL5NgVuyHlEI
 huAP7eQc+tXmOkTWs3ilvMg/b4pQh6DnHsX8ZVmJKMpxKXbKiVwgWB0j8r9SfjQD4xhX
 lSeafPnjDffUzbpBSSUU9I0GIz3+ZwPDheNXAfziuPnw+NpWL5X3oJEUv2dqFIBbgSln
 b6GwNgdc5Qzx4jPWcnu9AZpJD6ibTvSsskDMM2vMX18/m8O2iXskBGaQRvCC6T9tryCx
 O/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751988308; x=1752593108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSOBVOCtCg8RyLSMTZs3IWZ/v7JXRDHcSOVcIMEQ8hc=;
 b=T5RC52ES0hcw0xovRfPOZaIAa4P1BQ9J/HZgLdK/bEGR+KLJMysaawaBOZxObOY7xF
 uf7WcTrPKSDb6utKDmxAFNTG5QRckIbLFwNhZYydEJML7aOnFu2w/g/2kaNTJX7TEF0B
 iqDLb3U57MpmA3M8MXjxhW3xsVLgjMjVLnA9NTx/ZIrw70VIuGq/M+HMVAFMBc/4IEWH
 nb5wsmY422WvKfbbjURRbZqWcikLtE6NvugHkQ+f1Icct54cz1DFXZbC7yIwGXXtcfV4
 1To+57Pq5PvDVZEbjiuxiK4uK4CEjfXWFIjXkD4DdMjsOF8XJ1Agu8rDV/X6fnUeQSO+
 HyrA==
X-Gm-Message-State: AOJu0YwTKosPw7UWeRzxrHJFMWyFMpLW/8K6nxzD6Ha5Zul0Xel8KnWH
 d4AYc4pA7KNHOOi7DkPgHeILvgTNDpF9rwpxq29NUnJPsvh52x8msyQthwoovcxA
X-Gm-Gg: ASbGnctRL0hWF5zFGhl85x5yrPpjGbhyA+79FKI8iyc2SZP77wVI8zcb+XRYFqaRt2Y
 r0O8uS/zDxB4msmS3HKO82AwQSuvjvSlJ9xEdLkpBf1IIvpo44EEnAh8fA1YKoF6tmDA7DJ69F9
 mM1yjLGWijwLVSh8cS9FpG5S9dep3zm+riyT1saYfJJmTXqHHQJayb2Y17On1XcvFAqAWd17Cwm
 9oka45M7saGBg6LnjYWRH1mE6L5MhQxCYLqpIyXW/2jaL4dXomZpQaVnoiO/xGRG61iPVvMLybw
 Eu4UHLruYN9lmNxkigucQu4hUG5dX9bWCjs5OTYR+rXG+TsLx60/aIGlOWDY5l15
X-Google-Smtp-Source: AGHT+IEvmvFBb3r1yl6eRmQ2FAlzZzL2QVZdVHr62Z+abzWzl2awsNSxcwm+GE7xr9RsD8Eu2geA4g==
X-Received: by 2002:a17:907:9451:b0:ae0:aede:8a2c with SMTP id
 a640c23a62f3a-ae6b069d5demr412254766b.32.1751988307291; 
 Tue, 08 Jul 2025 08:25:07 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d931csm921950666b.10.2025.07.08.08.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 08:25:06 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v5 3/6] drivers: fpga: correct compiler errors and warnings
Date: Tue,  8 Jul 2025 17:24:48 +0200
Message-ID: <20250708152455.1214487-4-vtpieter@gmail.com>
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

Errors reported by GCC 14.2 when enabling FPGA commands and
drivers. Also many style fixes as reported by checkpatch.pl on the
diffs. Most changes in stratixII.c which has been reorganized as well
to avoid the top function prototypes.

No functional changes.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 cmd/fpga.c               |   2 +-
 drivers/fpga/ACEX1K.c    |   1 +
 drivers/fpga/ivm_core.c  |   1 +
 drivers/fpga/lattice.c   |   4 +-
 drivers/fpga/spartan2.c  |   1 +
 drivers/fpga/stratixII.c | 132 ++++++++++++++++++---------------------
 drivers/fpga/stratixv.c  |   2 +-
 drivers/fpga/versalpl.c  |   1 -
 drivers/fpga/virtex2.c   |   2 +
 include/stratixII.h      |   6 +-
 10 files changed, 73 insertions(+), 79 deletions(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index 9cc51f04698..d51c380d7b3 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -302,7 +302,7 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 
 			data = image_get_load(hdr);
 
-			if (gunzip((void *)data, ~0UL, (void *)image_buf,
+			if (gunzip((void *)data, ~0U, (void *)image_buf,
 				   &image_size) != 0) {
 				log_err("Gunzip error\n");
 				return CMD_RET_FAILURE;
diff --git a/drivers/fpga/ACEX1K.c b/drivers/fpga/ACEX1K.c
index 3de9011ac06..e1514fc56d0 100644
--- a/drivers/fpga/ACEX1K.c
+++ b/drivers/fpga/ACEX1K.c
@@ -14,6 +14,7 @@
 #include <log.h>
 #include <ACEX1K.h>		/* ACEX device family */
 #include <linux/delay.h>
+#include <time.h>
 
 /* Note: The assumption is that we cannot possibly run fast enough to
  * overrun the device (the Slave Parallel mode can free run at 50MHz).
diff --git a/drivers/fpga/ivm_core.c b/drivers/fpga/ivm_core.c
index 3c9a01e5110..4ab5dab250a 100644
--- a/drivers/fpga/ivm_core.c
+++ b/drivers/fpga/ivm_core.c
@@ -33,6 +33,7 @@
 #include <linux/string.h>
 #include <malloc.h>
 #include <lattice.h>
+#include <vsprintf.h>
 
 #define vme_out_char(c)	printf("%c", c)
 #define vme_out_hex(c)	printf("%x", c)
diff --git a/drivers/fpga/lattice.c b/drivers/fpga/lattice.c
index 3f481e38565..29cf2f60974 100644
--- a/drivers/fpga/lattice.c
+++ b/drivers/fpga/lattice.c
@@ -350,8 +350,8 @@ int lattice_info(Lattice_desc *desc)
 			printf("Unsupported interface type, %d\n", desc->iface);
 		}
 
-		printf("Device Size:   \t%d bytes\n",
-				desc->size);
+		printf("Device Size:   \t%zu bytes\n",
+		       desc->size);
 
 		if (desc->iface_fns) {
 			printf("Device Function Table @ 0x%p\n",
diff --git a/drivers/fpga/spartan2.c b/drivers/fpga/spartan2.c
index 906649ea181..792e4033428 100644
--- a/drivers/fpga/spartan2.c
+++ b/drivers/fpga/spartan2.c
@@ -9,6 +9,7 @@
 #include <config.h>		/* core U-Boot definitions */
 #include <log.h>
 #include <spartan2.h>		/* Spartan-II device family */
+#include <time.h>
 
 /* Note: The assumption is that we cannot possibly run fast enough to
  * overrun the device (the Slave Parallel mode can free run at 50MHz).
diff --git a/drivers/fpga/stratixII.c b/drivers/fpga/stratixII.c
index 73fecd9dca5..3f984385316 100644
--- a/drivers/fpga/stratixII.c
+++ b/drivers/fpga/stratixII.c
@@ -5,92 +5,41 @@
  */
 
 #include <altera.h>
+#include <stratixII.h>
 #include <linux/delay.h>
 
-int StratixII_ps_fpp_load (Altera_desc * desc, void *buf, size_t bsize,
-			   int isSerial, int isSecure);
-int StratixII_ps_fpp_dump (Altera_desc * desc, void *buf, size_t bsize);
-
 /****************************************************************/
 /* Stratix II Generic Implementation                            */
-int StratixII_load (Altera_desc * desc, void *buf, size_t bsize)
+int StratixII_ps_fpp_dump(Altera_desc *desc, const void *buf, size_t bsize)
 {
-	int ret_val = FPGA_FAIL;
-
-	switch (desc->iface) {
-	case passive_serial:
-		ret_val = StratixII_ps_fpp_load (desc, buf, bsize, 1, 0);
-		break;
-	case fast_passive_parallel:
-		ret_val = StratixII_ps_fpp_load (desc, buf, bsize, 0, 0);
-		break;
-	case fast_passive_parallel_security:
-		ret_val = StratixII_ps_fpp_load (desc, buf, bsize, 0, 1);
-		break;
-
-		/* Add new interface types here */
-	default:
-		printf ("%s: Unsupported interface type, %d\n", __FUNCTION__,
-			desc->iface);
-	}
-	return ret_val;
-}
-
-int StratixII_dump (Altera_desc * desc, void *buf, size_t bsize)
-{
-	int ret_val = FPGA_FAIL;
-
-	switch (desc->iface) {
-	case passive_serial:
-	case fast_passive_parallel:
-	case fast_passive_parallel_security:
-		ret_val = StratixII_ps_fpp_dump (desc, buf, bsize);
-		break;
-		/* Add new interface types here */
-	default:
-		printf ("%s: Unsupported interface type, %d\n", __FUNCTION__,
-			desc->iface);
-	}
-	return ret_val;
-}
-
-int StratixII_info (Altera_desc * desc)
-{
-	return FPGA_SUCCESS;
-}
-
-int StratixII_ps_fpp_dump (Altera_desc * desc, void *buf, size_t bsize)
-{
-	printf ("Stratix II Fast Passive Parallel dump is not implemented\n");
+	printf("Stratix II Fast Passive Parallel dump is not implemented\n");
 	return FPGA_FAIL;
 }
 
-int StratixII_ps_fpp_load (Altera_desc * desc, void *buf, size_t bsize,
-			   int isSerial, int isSecure)
+int StratixII_ps_fpp_load(Altera_desc *desc, const void *buf, size_t bsize,
+			  int isSerial, int isSecure)
 {
 	altera_board_specific_func *fns;
 	int cookie;
 	int ret_val = FPGA_FAIL;
 	int bytecount;
-	char *buff = buf;
+	const char *buff = buf;
 	int i;
 
 	if (!desc) {
-		printf ("%s(%d) Altera_desc missing\n", __FUNCTION__, __LINE__);
+		log_err("Altera_desc missing\n");
 		return FPGA_FAIL;
 	}
 	if (!buff) {
-		printf ("%s(%d) buffer is missing\n", __FUNCTION__, __LINE__);
+		log_err("buffer is missing\n");
 		return FPGA_FAIL;
 	}
 	if (!bsize) {
-		printf ("%s(%d) size is zero\n", __FUNCTION__, __LINE__);
+		log_err("size is zero\n");
 		return FPGA_FAIL;
 	}
 	if (!desc->iface_fns) {
-		printf
-		    ("%s(%d) Altera_desc function interface table is missing\n",
-		     __FUNCTION__, __LINE__);
+		log_err("Altera_desc function interface table is missing\n");
 		return FPGA_FAIL;
 	}
 	fns = (altera_board_specific_func *) (desc->iface_fns);
@@ -99,9 +48,7 @@ int StratixII_ps_fpp_load (Altera_desc * desc, void *buf, size_t bsize,
 	if (!
 	    (fns->config && fns->status && fns->done && fns->data
 	     && fns->abort)) {
-		printf
-		    ("%s(%d) Missing some function in the function interface table\n",
-		     __FUNCTION__, __LINE__);
+		log_err("Missing some function in the function interface table\n");
 		return FPGA_FAIL;
 	}
 
@@ -124,13 +71,12 @@ int StratixII_ps_fpp_load (Altera_desc * desc, void *buf, size_t bsize,
 	bytecount = 0;
 	fns->clk (0, 1, cookie);
 
-	printf ("loading to fpga    ");
+	printf("loading to fpga    ");
 	while (bytecount < bsize) {
 		/* 3.1 check stratix has not signaled us an error */
 		if (fns->status (cookie) != 1) {
-			printf
-			    ("\n%s(%d) Stratix failed (byte transferred till failure 0x%x)\n",
-			     __FUNCTION__, __LINE__, bytecount);
+			log_err("\nStratix failed (byte transferred till failure 0x%x)\n",
+				bytecount);
 			fns->abort (cookie);
 			return FPGA_FAIL;
 		}
@@ -162,7 +108,7 @@ int StratixII_ps_fpp_load (Altera_desc * desc, void *buf, size_t bsize,
 
 		/* 3.5 while clk is deasserted it is safe to print some progress indication */
 		if ((bytecount % (bsize / 100)) == 0) {
-			printf ("\b\b\b%02d\%", bytecount * 100 / bsize);
+			printf("\b\b\b%02zu\%%", bytecount * 100 / bsize);
 		}
 	}
 
@@ -170,11 +116,11 @@ int StratixII_ps_fpp_load (Altera_desc * desc, void *buf, size_t bsize,
 	fns->clk (1, 1, cookie);
 	udelay(100);
 	if (!fns->done (cookie)) {
-		printf (" error!.\n");
+		printf(" error!.\n");
 		fns->abort (cookie);
 		return FPGA_FAIL;
 	} else {
-		printf ("\b\b\b done.\n");
+		printf("\b\b\b done.\n");
 	}
 
 	/* 5. call lower layer post configuration */
@@ -187,3 +133,47 @@ int StratixII_ps_fpp_load (Altera_desc * desc, void *buf, size_t bsize,
 
 	return FPGA_SUCCESS;
 }
+
+int StratixII_load(Altera_desc *desc, const void *buf, size_t size)
+{
+	int ret_val = FPGA_FAIL;
+
+	switch (desc->iface) {
+	case passive_serial:
+		ret_val = StratixII_ps_fpp_load(desc, buf, size, 1, 0);
+		break;
+	case fast_passive_parallel:
+		ret_val = StratixII_ps_fpp_load(desc, buf, size, 0, 0);
+		break;
+	case fast_passive_parallel_security:
+		ret_val = StratixII_ps_fpp_load(desc, buf, size, 0, 1);
+		break;
+
+		/* Add new interface types here */
+	default:
+		log_err("Unsupported interface type, %d\n", desc->iface);
+	}
+	return ret_val;
+}
+
+int StratixII_dump(Altera_desc *desc, const void *buf, size_t bsize)
+{
+	int ret_val = FPGA_FAIL;
+
+	switch (desc->iface) {
+	case passive_serial:
+	case fast_passive_parallel:
+	case fast_passive_parallel_security:
+		ret_val = StratixII_ps_fpp_dump(desc, buf, bsize);
+		break;
+		/* Add new interface types here */
+	default:
+		log_err("Unsupported interface type, %d\n", desc->iface);
+	}
+	return ret_val;
+}
+
+int StratixII_info(Altera_desc *desc)
+{
+	return FPGA_SUCCESS;
+}
diff --git a/drivers/fpga/stratixv.c b/drivers/fpga/stratixv.c
index 372f16d92d1..4b251994598 100644
--- a/drivers/fpga/stratixv.c
+++ b/drivers/fpga/stratixv.c
@@ -48,7 +48,7 @@ int stratixv_load(Altera_desc *desc, const void *rbf_data, size_t rbf_size)
 	int spi_dev;
 	int ret = 0;
 
-	if ((u32)rbf_data & 0x3) {
+	if ((size_t)rbf_data & 0x3) {
 		puts("FPGA: Unaligned data, realign to 32bit boundary.\n");
 		return -EINVAL;
 	}
diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
index d691f135e89..624493ad838 100644
--- a/drivers/fpga/versalpl.c
+++ b/drivers/fpga/versalpl.c
@@ -6,7 +6,6 @@
 
 #include <cpu_func.h>
 #include <log.h>
-#include <asm/arch/sys_proto.h>
 #include <memalign.h>
 #include <versalpl.h>
 #include <zynqmp_firmware.h>
diff --git a/drivers/fpga/virtex2.c b/drivers/fpga/virtex2.c
index 8e2c12bb58b..805cbac8082 100644
--- a/drivers/fpga/virtex2.c
+++ b/drivers/fpga/virtex2.c
@@ -19,6 +19,7 @@
 #include <log.h>
 #include <virtex2.h>
 #include <linux/delay.h>
+#include <time.h>
 
 /*
  * If the SelectMap interface can be overrun by the processor, enable
@@ -301,6 +302,7 @@ static int virtex2_ssm_load(xilinx_desc *desc, const void *buf, size_t bsize)
 	size_t bytecount = 0;
 	unsigned char *data = (unsigned char *)buf;
 	int cookie = desc->cookie;
+	unsigned long ts;
 
 	ret_val = virtex2_slave_pre(fn, cookie);
 	if (ret_val != FPGA_SUCCESS)
diff --git a/include/stratixII.h b/include/stratixII.h
index 3c06bb2955a..785cdf41cb8 100644
--- a/include/stratixII.h
+++ b/include/stratixII.h
@@ -6,8 +6,8 @@
 #ifndef _STRATIXII_H_
 #define _STRATIXII_H_
 
-extern int StratixII_load (Altera_desc * desc, void *image, size_t size);
-extern int StratixII_dump (Altera_desc * desc, void *buf, size_t bsize);
-extern int StratixII_info (Altera_desc * desc);
+int StratixII_load(Altera_desc *desc, const void *buf, size_t size);
+int StratixII_dump(Altera_desc *desc, const void *buf, size_t bsize);
+int StratixII_info(Altera_desc *desc);
 
 #endif				/* _STRATIXII_H_ */
-- 
2.48.1

