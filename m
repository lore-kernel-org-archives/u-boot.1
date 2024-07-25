Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B2AC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 12:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692DA86E85;
	Thu, 25 Jul 2024 14:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D09c+jev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E778800C; Thu, 25 Jul 2024 14:58:30 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2DA887C86
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4280854e236so3034665e9.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912306; x=1722517106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtxPpdu/icEAGpLxXdEVvUaRpUbIJuvBVSjL04hPKX8=;
 b=D09c+jevNCjLFmbKnsJppBwnkX1x/d7LUCKnkUVgBA4s61mJUQCxEG03kmXzN8xb04
 NkCTPlihm61OfM946G9BIOlQ+muYqN+svQk/TVAHIHVCafozcO48+aaljMYz3CWRyoKK
 DMDPJyvLnyCIvEt1joHO4CnX1z8OOxFCFIPc3eauVYQ0n9PdF6T2nIng33gwNM5Y/Kbg
 k50YBtCAHZHsYuxapDUH1UOqTOTAiooqSIXkUFbC5cNw1mLh/jrNDK6yxldChGm8xxb+
 xx1oXEcpg8HIvXAnBk8s63Q2fCp7KLYys0KnE7CkJmgasTHMhCijBHjIPsuWcQ4tupD+
 ieQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912306; x=1722517106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtxPpdu/icEAGpLxXdEVvUaRpUbIJuvBVSjL04hPKX8=;
 b=DxNERq9VVau2qooodesaIur0FhEfEi7UF9enGmVdZiX0uCKNvJLifypGvAgZ+qiZ+E
 D5fGxE/aw+Aw1tytwBQTJHDWZDW8zflyxShaHf7SWqyUJi+snL2ngJtlTzrBPZAmg7GJ
 /xIJDlMxgCA2UcaztFUuj2hSrN9dqCYG5wjlzPw6umEqasOAH4LPwAsIZRL5P7U4LdRU
 wN79RZ+S/FsX1itpT3VYg6icJrsSisbkjHIVCQ2ooa8dFXlnauTr6YoVF1SMQUjfnf5z
 AkknumjqjqhzGEljP2oVMVLtm1apTg/os+GdQdUaleNFG6kePYscITCI6KQp74KIkygJ
 XOqg==
X-Gm-Message-State: AOJu0YwraygtXSK27i71wqo2Vao8/KNzvcqA/BD9bdfG0BEqveFIaqAX
 VRQDtStX4G9+PpS7KJFjg5JDlf+JgzrPyqyCpUWRCiTAG/B5ca+MJ46eIflIHPnwjae8g2CiFJb
 X6FZ5KA==
X-Google-Smtp-Source: AGHT+IHOpDzTgYN28GnXeKRJyOavDUdUYUGlpX2DMR9mrWg3OEw4rELKwp/3IKdK+LIhlJ8CRACQqQ==
X-Received: by 2002:a05:600c:35c6:b0:426:67f0:b4eb with SMTP id
 5b1f17b1804b1-428055041a8mr16169825e9.2.1721912305630; 
 Thu, 25 Jul 2024 05:58:25 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:58:25 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Angelo Dureghello <angelo@kernel-space.org>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>, Stefan Roese <sr@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH v5 01/20] flash: prefix error codes with FL_
Date: Thu, 25 Jul 2024 14:57:22 +0200
Message-Id: <1b22bbc08cb0841256283114db7ae117d97c0155.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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

Prefix the flash status codes (ERR_*) with FL_ in order to avoid clashes
with third-party libraries. Case in point: including the lwIP library
header file <lwip/err.h> which defines err_enum_t as an enum with values
being ERR_*.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 board/cobra5272/flash.c           | 26 +++++++++---------
 board/freescale/m5253demo/flash.c |  6 ++---
 common/flash.c                    | 44 +++++++++++++++----------------
 drivers/mtd/cfi_flash.c           | 36 ++++++++++++-------------
 include/flash.h                   | 20 +++++++-------
 5 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
index 157b71da85e..f2f8d027f6e 100644
--- a/board/cobra5272/flash.c
+++ b/board/cobra5272/flash.c
@@ -138,22 +138,22 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 {
 	ulong result;
 	int iflag, cflag, prot, sect;
-	int rc = ERR_OK;
+	int rc = FL_ERR_OK;
 	int chip1;
 	ulong start;
 
 	/* first look for protection bits */
 
 	if (info->flash_id == FLASH_UNKNOWN)
-		return ERR_UNKNOWN_FLASH_TYPE;
+		return FL_ERR_UNKNOWN_FLASH_TYPE;
 
 	if ((s_first < 0) || (s_first > s_last)) {
-		return ERR_INVAL;
+		return FL_ERR_INVAL;
 	}
 
 	if ((info->flash_id & FLASH_VENDMASK) !=
 	    (AMD_MANUFACT & FLASH_VENDMASK)) {
-		return ERR_UNKNOWN_FLASH_VENDOR;
+		return FL_ERR_UNKNOWN_FLASH_VENDOR;
 	}
 
 	prot = 0;
@@ -163,7 +163,7 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 		}
 	}
 	if (prot)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	/*
 	 * Disable interrupts which might cause a timeout
@@ -220,11 +220,11 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 			MEM_FLASH_ADDR1 = CMD_READ_ARRAY;
 
 			if (chip1 == ERR) {
-				rc = ERR_PROG_ERROR;
+				rc = FL_ERR_PROG_ERROR;
 				goto outahere;
 			}
 			if (chip1 == TMO) {
-				rc = ERR_TIMEOUT;
+				rc = FL_ERR_TIMEOUT;
 				goto outahere;
 			}
 
@@ -255,7 +255,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 {
 	volatile u16 *addr = (volatile u16 *) dest;
 	ulong result;
-	int rc = ERR_OK;
+	int rc = FL_ERR_OK;
 	int cflag, iflag;
 	int chip1;
 	ulong start;
@@ -265,7 +265,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	 */
 	result = *addr;
 	if ((result & data) != data)
-		return ERR_NOT_ERASED;
+		return FL_ERR_NOT_ERASED;
 
 
 	/*
@@ -306,7 +306,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	*addr = CMD_READ_ARRAY;
 
 	if (chip1 == ERR || *addr != data)
-		rc = ERR_PROG_ERROR;
+		rc = FL_ERR_PROG_ERROR;
 
 	if (iflag)
 		enable_interrupts();
@@ -325,13 +325,13 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 
 	if (addr & 1) {
 		printf ("unaligned destination not supported\n");
-		return ERR_ALIGN;
+		return FL_ERR_ALIGN;
 	}
 
 #if 0
 	if (cnt & 1) {
 		printf ("odd transfer sizes not supported\n");
-		return ERR_ALIGN;
+		return FL_ERR_ALIGN;
 	}
 #endif
 
@@ -369,5 +369,5 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		cnt -= 1;
 	}
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
diff --git a/board/freescale/m5253demo/flash.c b/board/freescale/m5253demo/flash.c
index 334518a4bc9..ab5d2ebff64 100644
--- a/board/freescale/m5253demo/flash.c
+++ b/board/freescale/m5253demo/flash.c
@@ -72,7 +72,7 @@ int flash_get_offsets(ulong base, flash_info_t * info)
 		}
 	}
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 void flash_print_info(flash_info_t * info)
@@ -369,9 +369,9 @@ int write_buff(flash_info_t * info, uchar * src, ulong addr, ulong cnt)
 	}
 
 	if (cnt == 0)
-		return ERR_OK;
+		return FL_ERR_OK;
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 /*-----------------------------------------------------------------------
diff --git a/common/flash.c b/common/flash.c
index 24ddc8bee72..a64e51a9b5a 100644
--- a/common/flash.c
+++ b/common/flash.c
@@ -110,13 +110,13 @@ addr2info(ulong addr)
  * Make sure all target addresses are within Flash bounds,
  * and no protected sectors are hit.
  * Returns:
- * ERR_OK          0 - OK
- * ERR_TIMEOUT     1 - write timeout
- * ERR_NOT_ERASED  2 - Flash not erased
- * ERR_PROTECTED   4 - target range includes protected sectors
- * ERR_INVAL       8 - target address not in Flash memory
- * ERR_ALIGN       16 - target address not aligned on boundary
- *			(only some targets require alignment)
+ * FL_ERR_OK          0 - OK
+ * FL_ERR_TIMEOUT     1 - write timeout
+ * FL_ERR_NOT_ERASED  2 - Flash not erased
+ * FL_ERR_PROTECTED   4 - target range includes protected sectors
+ * FL_ERR_INVAL       8 - target address not in Flash memory
+ * FL_ERR_ALIGN       16 - target address not aligned on boundary
+ *			   (only some targets require alignment)
  */
 int
 flash_write(char *src, ulong addr, ulong cnt)
@@ -131,11 +131,11 @@ flash_write(char *src, ulong addr, ulong cnt)
 	__maybe_unused ulong cnt_orig = cnt;
 
 	if (cnt == 0) {
-		return (ERR_OK);
+		return (FL_ERR_OK);
 	}
 
 	if (!info_first || !info_last) {
-		return (ERR_INVAL);
+		return (FL_ERR_INVAL);
 	}
 
 	for (info = info_first; info <= info_last; ++info) {
@@ -146,7 +146,7 @@ flash_write(char *src, ulong addr, ulong cnt)
 
 			if ((end >= info->start[i]) && (addr < e_addr) &&
 			    (info->protect[i] != 0) ) {
-				return (ERR_PROTECTED);
+				return (FL_ERR_PROTECTED);
 			}
 		}
 	}
@@ -169,11 +169,11 @@ flash_write(char *src, ulong addr, ulong cnt)
 #if defined(CONFIG_FLASH_VERIFY)
 	if (memcmp(src_orig, addr_orig, cnt_orig)) {
 		printf("\nVerify failed!\n");
-		return ERR_PROG_ERROR;
+		return FL_ERR_PROG_ERROR;
 	}
 #endif /* CONFIG_SYS_FLASH_VERIFY_AFTER_WRITE */
 
-	return (ERR_OK);
+	return (FL_ERR_OK);
 }
 
 /*-----------------------------------------------------------------------
@@ -182,33 +182,33 @@ flash_write(char *src, ulong addr, ulong cnt)
 void flash_perror(int err)
 {
 	switch (err) {
-	case ERR_OK:
+	case FL_ERR_OK:
 		break;
-	case ERR_TIMEOUT:
+	case FL_ERR_TIMEOUT:
 		puts ("Timeout writing to Flash\n");
 		break;
-	case ERR_NOT_ERASED:
+	case FL_ERR_NOT_ERASED:
 		puts ("Flash not Erased\n");
 		break;
-	case ERR_PROTECTED:
+	case FL_ERR_PROTECTED:
 		puts ("Can't write to protected Flash sectors\n");
 		break;
-	case ERR_INVAL:
+	case FL_ERR_INVAL:
 		puts ("Outside available Flash\n");
 		break;
-	case ERR_ALIGN:
+	case FL_ERR_ALIGN:
 		puts ("Start and/or end address not on sector boundary\n");
 		break;
-	case ERR_UNKNOWN_FLASH_VENDOR:
+	case FL_ERR_UNKNOWN_FLASH_VENDOR:
 		puts ("Unknown Vendor of Flash\n");
 		break;
-	case ERR_UNKNOWN_FLASH_TYPE:
+	case FL_ERR_UNKNOWN_FLASH_TYPE:
 		puts ("Unknown Type of Flash\n");
 		break;
-	case ERR_PROG_ERROR:
+	case FL_ERR_PROG_ERROR:
 		puts ("General Flash Programming Error\n");
 		break;
-	case ERR_ABORTED:
+	case FL_ERR_ABORTED:
 		puts("Flash Programming Aborted\n");
 		break;
 	default:
diff --git a/drivers/mtd/cfi_flash.c b/drivers/mtd/cfi_flash.c
index a7826e81c17..e50502824ac 100644
--- a/drivers/mtd/cfi_flash.c
+++ b/drivers/mtd/cfi_flash.c
@@ -593,11 +593,11 @@ static int flash_status_check(flash_info_t *info, flash_sect_t sector,
 			       flash_read_long(info, sector, 0));
 			flash_write_cmd(info, sector, 0, info->cmd_reset);
 			udelay(1);
-			return ERR_TIMEOUT;
+			return FL_ERR_TIMEOUT;
 		}
 		udelay(1);		/* also triggers watchdog */
 	}
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 /*-----------------------------------------------------------------------
@@ -616,9 +616,9 @@ static int flash_full_status_check(flash_info_t *info, flash_sect_t sector,
 	case CFI_CMDSET_INTEL_PROG_REGIONS:
 	case CFI_CMDSET_INTEL_EXTENDED:
 	case CFI_CMDSET_INTEL_STANDARD:
-		if (retcode == ERR_OK &&
+		if (retcode == FL_ERR_OK &&
 		    !flash_isset(info, sector, 0, FLASH_STATUS_DONE)) {
-			retcode = ERR_INVAL;
+			retcode = FL_ERR_INVAL;
 			printf("Flash %s error at address %lx\n", prompt,
 			       info->start[sector]);
 			if (flash_isset(info, sector, 0, FLASH_STATUS_ECLBS |
@@ -627,14 +627,14 @@ static int flash_full_status_check(flash_info_t *info, flash_sect_t sector,
 			} else if (flash_isset(info, sector, 0,
 						FLASH_STATUS_ECLBS)) {
 				puts("Block Erase Error.\n");
-				retcode = ERR_NOT_ERASED;
+				retcode = FL_ERR_NOT_ERASED;
 			} else if (flash_isset(info, sector, 0,
 						FLASH_STATUS_PSLBS)) {
 				puts("Locking Error\n");
 			}
 			if (flash_isset(info, sector, 0, FLASH_STATUS_DPS)) {
 				puts("Block locked.\n");
-				retcode = ERR_PROTECTED;
+				retcode = FL_ERR_PROTECTED;
 			}
 			if (flash_isset(info, sector, 0, FLASH_STATUS_VPENS))
 				puts("Vpp Low Error.\n");
@@ -702,12 +702,12 @@ static int flash_status_poll(flash_info_t *info, void *src, void *dst,
 		if (get_timer(start) > tout) {
 			printf("Flash %s timeout at address %lx data %lx\n",
 			       prompt, (ulong)dst, (ulong)flash_read8(dst));
-			return ERR_TIMEOUT;
+			return FL_ERR_TIMEOUT;
 		}
 		udelay(1);		/* also triggers watchdog */
 	}
 #endif /* CONFIG_SYS_CFI_FLASH_STATUS_POLL */
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 /*-----------------------------------------------------------------------
@@ -810,7 +810,7 @@ static int flash_write_cfiword(flash_info_t *info, ulong dest, cfiword_t cword)
 		break;
 	}
 	if (!flag)
-		return ERR_NOT_ERASED;
+		return FL_ERR_NOT_ERASED;
 
 	/* Disable interrupts which might cause a timeout here */
 	flag = disable_interrupts();
@@ -899,7 +899,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 		shift = 3;
 		break;
 	default:
-		retcode = ERR_INVAL;
+		retcode = FL_ERR_INVAL;
 		goto out_unmap;
 	}
 
@@ -930,7 +930,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 		}
 	}
 	if (!flag) {
-		retcode = ERR_NOT_ERASED;
+		retcode = FL_ERR_NOT_ERASED;
 		goto out_unmap;
 	}
 
@@ -950,7 +950,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 		retcode = flash_status_check(info, sector,
 					     info->buffer_write_tout,
 					     "write to buffer");
-		if (retcode == ERR_OK) {
+		if (retcode == FL_ERR_OK) {
 			/* reduce the number of loops by the width of
 			 * the port
 			 */
@@ -975,7 +975,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 					src += 8, dst += 8;
 					break;
 				default:
-					retcode = ERR_INVAL;
+					retcode = FL_ERR_INVAL;
 					goto out_unmap;
 				}
 			}
@@ -1025,7 +1025,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 			}
 			break;
 		default:
-			retcode = ERR_INVAL;
+			retcode = FL_ERR_INVAL;
 			goto out_unmap;
 		}
 
@@ -1043,7 +1043,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 
 	default:
 		debug("Unknown Command Set\n");
-		retcode = ERR_INVAL;
+		retcode = FL_ERR_INVAL;
 		break;
 	}
 
@@ -1389,7 +1389,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		if (i > cnt)
 			i = cnt;
 		rc = flash_write_cfibuffer(info, wp, src, i);
-		if (rc != ERR_OK)
+		if (rc != FL_ERR_OK)
 			return rc;
 		i -= i & (info->portwidth - 1);
 		wp += i;
@@ -1398,7 +1398,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		FLASH_SHOW_PROGRESS(scale, dots, digit, i);
 		/* Only check every once in a while */
 		if ((cnt & 0xFFFF) < buffered_size && ctrlc())
-			return ERR_ABORTED;
+			return FL_ERR_ABORTED;
 	}
 #else
 	while (cnt >= info->portwidth) {
@@ -1413,7 +1413,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		FLASH_SHOW_PROGRESS(scale, dots, digit, info->portwidth);
 		/* Only check every once in a while */
 		if ((cnt & 0xFFFF) < info->portwidth && ctrlc())
-			return ERR_ABORTED;
+			return FL_ERR_ABORTED;
 	}
 #endif /* CONFIG_SYS_FLASH_USE_BUFFER_WRITE */
 
diff --git a/include/flash.h b/include/flash.h
index 0f736977411..ebf8881b0e3 100644
--- a/include/flash.h
+++ b/include/flash.h
@@ -127,16 +127,16 @@ void flash_perror(int err);
 /*-----------------------------------------------------------------------
  * return codes from flash_write():
  */
-#define ERR_OK				0
-#define ERR_TIMEOUT			1
-#define ERR_NOT_ERASED			2
-#define ERR_PROTECTED			4
-#define ERR_INVAL			8
-#define ERR_ALIGN			16
-#define ERR_UNKNOWN_FLASH_VENDOR	32
-#define ERR_UNKNOWN_FLASH_TYPE		64
-#define ERR_PROG_ERROR			128
-#define ERR_ABORTED			256
+#define FL_ERR_OK			0
+#define FL_ERR_TIMEOUT			1
+#define FL_ERR_NOT_ERASED		2
+#define FL_ERR_PROTECTED		4
+#define FL_ERR_INVAL			8
+#define FL_ERR_ALIGN			16
+#define FL_ERR_UNKNOWN_FLASH_VENDOR	32
+#define FL_ERR_UNKNOWN_FLASH_TYPE	64
+#define FL_ERR_PROG_ERROR		128
+#define FL_ERR_ABORTED			256
 
 /*-----------------------------------------------------------------------
  * Protection Flags for flash_protect():
-- 
2.40.1

