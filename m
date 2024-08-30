Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB38CA0EC5
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F308488A58;
	Fri, 30 Aug 2024 12:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aSjsyKmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CEC1889C9; Fri, 30 Aug 2024 12:17:27 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C46088744
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bb6d3e260so14392875e9.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013044; x=1725617844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fp96vph0u3LjTjUbSViPrH+ii0sG4RJ3x6MobPU/VNY=;
 b=aSjsyKmmEQCzO2ltFXjc8xjdPUyAjjp1ARUk1znbg9wUX51kCCmNOFJ4l4GNWRGHIR
 d42Sxauz8qJrOqzCId+B4oowa/giVMI2dX5kCfjAAd6nTNJwcxgV1zmrJEnvd9y4jOjp
 gqjZYEi2O8jMfxVbnDXr3WnvHZwsTTVl+EEn1tzU1efWomAkCiIXrdqUsGBZKRkvF+nZ
 7s4/FtQjjdGifsfiR+1qTIoO7EWnfYDcfPmDH1p+vfs21CRvTrQYDdnRDEhdeSJmmVuL
 +4fdcQo7CbUdidqPg9qC/Smtp1TWOwvp17+4wDDJ0Qw7Z5/swxjqm1iCgq5av36Ihs0I
 VuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013044; x=1725617844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fp96vph0u3LjTjUbSViPrH+ii0sG4RJ3x6MobPU/VNY=;
 b=jvAT5vfs8tW7u5A2joGNDGc7KO34idPmQ3fnsjjCVrtkVIoBaGZP7EKr8T7rG6C9Eb
 WhAvj2s4SXBTULpNt/A840LT0WvrtSbyepXIlgAyPh+q9KeiGdljiXaYehKV6t0jIzo9
 Itq0vesD1CH67JiGDqD5KS/8/nCbs5Vysmz9oOOYUcBLHV8ZGNY89q6a4vqDHx46wfr+
 PTBQx5m3QBE8ZNwKHt9sjuq3cWUKUd9xtrR7Oesmm3Urahy2BmwRDj1eY5nHKJl5TCLT
 Jsb0G+HN09vFtTp+pFWr9hcbg4NEv5A8qpl9JkCz5fV2ly0YNt1QQE+SXhr/lN6wA6Oq
 sV6A==
X-Gm-Message-State: AOJu0Yx8dUnPduqDsugYcvBHRqvfQ+qi9zu07nzHWD0lM88n5km6Xf51
 BMyvoMBnfP5Uqv13FJScYykJaZZE32UbHVs83/hH47hKpFL7m8qQSxsx+ZQeCXDAdYtuYSvYzpJ
 yhcf6xA==
X-Google-Smtp-Source: AGHT+IEpZBZ5J84sZ7Ki0AE9/alzunshlb9GdFufXUqqPF2nsOrBTIhieAdCQArbwxFNN38QtOONvA==
X-Received: by 2002:adf:e787:0:b0:371:6fba:d555 with SMTP id
 ffacd0b85a97d-3749b546e9cmr4070692f8f.18.1725013044234; 
 Fri, 30 Aug 2024 03:17:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Angelo Dureghello <angelo@kernel-space.org>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>, Stefan Roese <sr@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jason Liu <jason.hui.liu@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH v2 03/16] flash: prefix error codes with FL_
Date: Fri, 30 Aug 2024 12:16:46 +0200
Message-Id: <22c43e47bd1eeccd277cba0781d6ac8218cea6bc.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/cobra5272/flash.c           | 26 +++++++++---------
 board/freescale/m5253demo/flash.c |  6 ++---
 common/flash.c                    | 44 +++++++++++++++----------------
 drivers/mtd/altera_qspi.c         |  4 +--
 drivers/mtd/cfi_flash.c           | 36 ++++++++++++-------------
 include/flash.h                   | 20 +++++++-------
 6 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
index 616842e62f..d324aa6ac1 100644
--- a/board/cobra5272/flash.c
+++ b/board/cobra5272/flash.c
@@ -135,22 +135,22 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
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
@@ -160,7 +160,7 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 		}
 	}
 	if (prot)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	/*
 	 * Disable interrupts which might cause a timeout
@@ -217,11 +217,11 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
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
 
@@ -252,7 +252,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 {
 	volatile u16 *addr = (volatile u16 *) dest;
 	ulong result;
-	int rc = ERR_OK;
+	int rc = FL_ERR_OK;
 	int cflag, iflag;
 	int chip1;
 	ulong start;
@@ -262,7 +262,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	 */
 	result = *addr;
 	if ((result & data) != data)
-		return ERR_NOT_ERASED;
+		return FL_ERR_NOT_ERASED;
 
 	/*
 	 * Disable interrupts which might cause a timeout
@@ -302,7 +302,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	*addr = CMD_READ_ARRAY;
 
 	if (chip1 == ERR || *addr != data)
-		rc = ERR_PROG_ERROR;
+		rc = FL_ERR_PROG_ERROR;
 
 	if (iflag)
 		enable_interrupts();
@@ -320,13 +320,13 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 
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
 
@@ -364,5 +364,5 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		cnt -= 1;
 	}
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
diff --git a/board/freescale/m5253demo/flash.c b/board/freescale/m5253demo/flash.c
index 334518a4bc..ab5d2ebff6 100644
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
index 24ddc8bee7..a64e51a9b5 100644
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
diff --git a/drivers/mtd/altera_qspi.c b/drivers/mtd/altera_qspi.c
index c26615821c..e5c8df750b 100644
--- a/drivers/mtd/altera_qspi.c
+++ b/drivers/mtd/altera_qspi.c
@@ -96,7 +96,7 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 	ret = mtd_erase(mtd, &instr);
 	flash_set_verbose(0);
 	if (ret)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	puts(" done\n");
 	return 0;
@@ -114,7 +114,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 
 	ret = mtd_write(mtd, to, cnt, &retlen, src);
 	if (ret)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	return 0;
 }
diff --git a/drivers/mtd/cfi_flash.c b/drivers/mtd/cfi_flash.c
index a7826e81c1..e50502824a 100644
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
index 60babe8a80..32bc65e7b6 100644
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

