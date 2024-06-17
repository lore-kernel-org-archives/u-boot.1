Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B5C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666BC88366;
	Mon, 17 Jun 2024 17:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h9flOIWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A75882D0; Mon, 17 Jun 2024 17:33:32 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51ACA8831F
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-421eab59723so32691685e9.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638409; x=1719243209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0CMhQpQPKnCML8ZQNHlBapAy1uzEaVtf0jEJ481s18=;
 b=h9flOIWql1hluGaJ/kvUVlqIKocjKJjgC1MPbLbUroygo8lzQw0JirpHFs9bC/OYfN
 SoqrTFm7BgmkqrKkQw5zThoQgAXKWt3G6oOgX1kJLEWbtMzbrYV9tO9zVDUZvdEQNzGN
 sh3uAtY2EbbC407gjYFRA9Usk8pDIC6O8KxHZLAi0SIpCd8Y4LQZXjrJ4adWiN67Pl1F
 uhwYh7i8ViVxUChHeaiKXJs8xNK3KVuhrJx9XnED38N7z75KrbKE9rBPMKwXYW9ho6Es
 3wJX7n6930lyi0fjeaHx6d5W0AUyzVJ2zMURZaaXfxkrrQFfjPbr3R9S5Km7Y47ow52V
 s0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638409; x=1719243209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0CMhQpQPKnCML8ZQNHlBapAy1uzEaVtf0jEJ481s18=;
 b=s1X8/1m1p9fxYvYvZZ1jTI0nNkpUYf/qvofGKXtdkwmLCuU/WZSnyUdpNTt/uCQBnw
 ITMI9w8Yml5alUgZ7MIwIQgU3nFoxo0hogPkT5z7cHMaAKcUlM6Z5buEqME6y8NVT+/o
 VVoHhq7qw+PFEvJ7CHYe5W9UlFKNPIqLKhlH/jlOLbHdXSTZBA67QkZW38rDD6/rs2v6
 HD4pghizdQzbvB9ETFe9Pb/e0tfQWYAjLnDdLOPrJNAvG1TSWXZBmvmfrxewiw1pu+6l
 UzPouMKcpO1/8VI9l0hLiSe2jdgH80YHWpCj81Byb/vvjfn/0A2ysmZuh+ShbkSpnVMK
 /ivg==
X-Gm-Message-State: AOJu0Yw/Uv4VFVrVB99BkA9u7/kXimhFTx0SB1Go3j2xcxSJnYLSwtV+
 7Nksx2+t8YyfJj9m/QQYLM3+4Qc4wTpICDUZsxYPyyZfo2aw1SvZfWje9QoH9LyX8MzfZLDbNLO
 J
X-Google-Smtp-Source: AGHT+IF5utDHs9jKOFe6NslQf8pJOk2FfnwCyXdQcF06SW/wCRlBZBi3+0iGA+Yw7wcFYEYFV/n67Q==
X-Received: by 2002:a05:600c:444f:b0:422:5b78:1c8f with SMTP id
 5b1f17b1804b1-42304811928mr76833735e9.8.1718638409487; 
 Mon, 17 Jun 2024 08:33:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Tom Rini <trini@konsulko.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>, Stefan Roese <sr@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH v4 01/14] flash: prefix error codes with FL_
Date: Mon, 17 Jun 2024 17:32:53 +0200
Message-Id: <a8dc4451931828f757905d363b6d1bf368b829d5.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
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
---
 board/cobra5272/flash.c           | 26 +++++++++---------
 board/freescale/m5253demo/flash.c |  6 ++---
 common/flash.c                    | 44 +++++++++++++++----------------
 drivers/mtd/cfi_flash.c           | 36 ++++++++++++-------------
 include/flash.h                   | 20 +++++++-------
 5 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
index 8416af163ad..6464975f184 100644
--- a/board/cobra5272/flash.c
+++ b/board/cobra5272/flash.c
@@ -134,22 +134,22 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
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
@@ -159,7 +159,7 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 		}
 	}
 	if (prot)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	/*
 	 * Disable interrupts which might cause a timeout
@@ -216,11 +216,11 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
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
 
@@ -251,7 +251,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 {
 	volatile u16 *addr = (volatile u16 *) dest;
 	ulong result;
-	int rc = ERR_OK;
+	int rc = FL_ERR_OK;
 	int cflag, iflag;
 	int chip1;
 	ulong start;
@@ -261,7 +261,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	 */
 	result = *addr;
 	if ((result & data) != data)
-		return ERR_NOT_ERASED;
+		return FL_ERR_NOT_ERASED;
 
 
 	/*
@@ -302,7 +302,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	*addr = CMD_READ_ARRAY;
 
 	if (chip1 == ERR || *addr != data)
-		rc = ERR_PROG_ERROR;
+		rc = FL_ERR_PROG_ERROR;
 
 	if (iflag)
 		enable_interrupts();
@@ -321,13 +321,13 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 
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
 
@@ -365,5 +365,5 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		cnt -= 1;
 	}
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
diff --git a/board/freescale/m5253demo/flash.c b/board/freescale/m5253demo/flash.c
index eeb9cfd3125..b6b7df88761 100644
--- a/board/freescale/m5253demo/flash.c
+++ b/board/freescale/m5253demo/flash.c
@@ -71,7 +71,7 @@ int flash_get_offsets(ulong base, flash_info_t * info)
 		}
 	}
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 void flash_print_info(flash_info_t * info)
@@ -368,9 +368,9 @@ int write_buff(flash_info_t * info, uchar * src, ulong addr, ulong cnt)
 	}
 
 	if (cnt == 0)
-		return ERR_OK;
+		return FL_ERR_OK;
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 /*-----------------------------------------------------------------------
diff --git a/common/flash.c b/common/flash.c
index 848f44e59df..99fd84e2aef 100644
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
index 8ade7949a68..6369c7127c6 100644
--- a/drivers/mtd/cfi_flash.c
+++ b/drivers/mtd/cfi_flash.c
@@ -592,11 +592,11 @@ static int flash_status_check(flash_info_t *info, flash_sect_t sector,
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
@@ -615,9 +615,9 @@ static int flash_full_status_check(flash_info_t *info, flash_sect_t sector,
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
@@ -626,14 +626,14 @@ static int flash_full_status_check(flash_info_t *info, flash_sect_t sector,
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
@@ -701,12 +701,12 @@ static int flash_status_poll(flash_info_t *info, void *src, void *dst,
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
@@ -809,7 +809,7 @@ static int flash_write_cfiword(flash_info_t *info, ulong dest, cfiword_t cword)
 		break;
 	}
 	if (!flag)
-		return ERR_NOT_ERASED;
+		return FL_ERR_NOT_ERASED;
 
 	/* Disable interrupts which might cause a timeout here */
 	flag = disable_interrupts();
@@ -898,7 +898,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 		shift = 3;
 		break;
 	default:
-		retcode = ERR_INVAL;
+		retcode = FL_ERR_INVAL;
 		goto out_unmap;
 	}
 
@@ -929,7 +929,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 		}
 	}
 	if (!flag) {
-		retcode = ERR_NOT_ERASED;
+		retcode = FL_ERR_NOT_ERASED;
 		goto out_unmap;
 	}
 
@@ -949,7 +949,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 		retcode = flash_status_check(info, sector,
 					     info->buffer_write_tout,
 					     "write to buffer");
-		if (retcode == ERR_OK) {
+		if (retcode == FL_ERR_OK) {
 			/* reduce the number of loops by the width of
 			 * the port
 			 */
@@ -974,7 +974,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 					src += 8, dst += 8;
 					break;
 				default:
-					retcode = ERR_INVAL;
+					retcode = FL_ERR_INVAL;
 					goto out_unmap;
 				}
 			}
@@ -1024,7 +1024,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 			}
 			break;
 		default:
-			retcode = ERR_INVAL;
+			retcode = FL_ERR_INVAL;
 			goto out_unmap;
 		}
 
@@ -1042,7 +1042,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 
 	default:
 		debug("Unknown Command Set\n");
-		retcode = ERR_INVAL;
+		retcode = FL_ERR_INVAL;
 		break;
 	}
 
@@ -1388,7 +1388,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		if (i > cnt)
 			i = cnt;
 		rc = flash_write_cfibuffer(info, wp, src, i);
-		if (rc != ERR_OK)
+		if (rc != FL_ERR_OK)
 			return rc;
 		i -= i & (info->portwidth - 1);
 		wp += i;
@@ -1397,7 +1397,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		FLASH_SHOW_PROGRESS(scale, dots, digit, i);
 		/* Only check every once in a while */
 		if ((cnt & 0xFFFF) < buffered_size && ctrlc())
-			return ERR_ABORTED;
+			return FL_ERR_ABORTED;
 	}
 #else
 	while (cnt >= info->portwidth) {
@@ -1412,7 +1412,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		FLASH_SHOW_PROGRESS(scale, dots, digit, info->portwidth);
 		/* Only check every once in a while */
 		if ((cnt & 0xFFFF) < info->portwidth && ctrlc())
-			return ERR_ABORTED;
+			return FL_ERR_ABORTED;
 	}
 #endif /* CONFIG_SYS_FLASH_USE_BUFFER_WRITE */
 
diff --git a/include/flash.h b/include/flash.h
index 3710a2731b7..77bee42f76b 100644
--- a/include/flash.h
+++ b/include/flash.h
@@ -125,16 +125,16 @@ void flash_perror(int err);
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

