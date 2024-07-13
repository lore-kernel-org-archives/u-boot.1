Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9487C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 669FB8892E;
	Sat, 13 Jul 2024 15:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ESJfSEEM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vI+GLiOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F5C88901; Sat, 13 Jul 2024 15:21:55 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AA688905
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyn2SBTz9sZF;
 Sat, 13 Jul 2024 15:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Zk0Z0melEQhQhOkRqelm/841CkRCs53eAbZXMknfvM=;
 b=ESJfSEEM+f3yx3KOfT2L1pcPZShGJsYGgR+MpDUw5O5oWXCn4if3QH7I0WPPdn+pPd3EfO
 cgv9CK49cDVl1R0C1iW93jq49iTSyUUCguPD2kiByxd6oPGnhJRXY2EDv9dEFaoJyvQW6j
 1lcPudYx+5GyE0iEgsyKxidzB0Tl6FWnNBraJC3lnNJlxQTMGULxKEjPahirXCfsoMLzLS
 NTncYOzkBHg4uYE6jg4sPV6Nrre3rLzCStSwAGQz8EtpIus4La1x9YUwyzaW/QFaAWBBdi
 +631GrE1eup6QIBW7HQCQPIvWp/VdQyDVafFZBnolvPQJ/qHavQnQsPql13+hQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Zk0Z0melEQhQhOkRqelm/841CkRCs53eAbZXMknfvM=;
 b=vI+GLiOqHgexRLPwmilHD+kzYooXErtxaseWXZYPjDHKTNlfdtxlkwg6vMGKCw8QHgIjJW
 lDOTq/tB0JMqLQbM6QAk6aAzQFAfX/d3Prq+L707d/g0fFEIEuDFT88Vnmgwtx2W0FzcYw
 SeY1jd5+nQrh6JZEkQb3x3ZTJtp58Ci8VwKJopraA83v40Wrj2yFTbAMdfoKrC0+375uEL
 cTq6Lmaug/R/PwtUeqVVIj40RdbyChAzKTI6xkamkctNDvpPXHcTtbP8oKdkVBLXKl9/Ag
 FwYLTpCHn2b0UWBh/DIHznT8he7NQyEQRMIzocbu694KRjeJCWOeYOUoFWLMCw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 43/45] tools: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:34 +0200
Message-ID: <20240713132021.57650-43-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 239539a3f91ef7461c7
X-MBO-RS-META: 95kctzim8a1zqzo1yot3mrfspw55gxuk
X-Rspamd-Queue-Id: 4WLpyn2SBTz9sZF
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 tools/env/fw_env.h | 2 --
 tools/envcrc.c     | 1 -
 tools/fdtgrep.c    | 1 -
 tools/gdb/remote.c | 2 --
 tools/imagetool.h  | 1 -
 tools/img2srec.c   | 9 ---------
 tools/imx8mimage.c | 1 -
 tools/imximage.c   | 2 --
 tools/kwbimage.c   | 1 -
 tools/mxsimage.c   | 1 -
 10 files changed, 21 deletions(-)

diff --git a/tools/env/fw_env.h b/tools/env/fw_env.h
index 78c803c9447..060eea542cc 100644
--- a/tools/env/fw_env.h
+++ b/tools/env/fw_env.h
@@ -94,7 +94,6 @@ int fw_env_set(int argc, char *argv[], struct env_opts *opts);
  */
 int fw_parse_script(char *fname, struct env_opts *opts);
 
-
 /**
  * fw_env_open() - read enviroment from flash into RAM cache
  *
@@ -151,7 +150,6 @@ int fw_env_flush(struct env_opts *opts);
  */
 int fw_env_close(struct env_opts *opts);
 
-
 /**
  * fw_env_version - return the current version of the library
  *
diff --git a/tools/envcrc.c b/tools/envcrc.c
index 550f31038bd..09051800364 100644
--- a/tools/envcrc.c
+++ b/tools/envcrc.c
@@ -48,7 +48,6 @@
 
 #define ENV_SIZE (CONFIG_ENV_SIZE - ENV_HEADER_SIZE)
 
-
 #ifdef ENV_IS_EMBEDDED
 # include <env_internal.h>
 extern unsigned int env_size;
diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index f1ff1946bd4..037176bc9ef 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -102,7 +102,6 @@ static void print_ansi_colour(FILE *fout, int col)
 		fprintf(fout, "\033[1;%dm", col + 30);
 }
 
-
 /**
  * value_add() - Add a new value to our list of things to grep for
  *
diff --git a/tools/gdb/remote.c b/tools/gdb/remote.c
index 3cd04213514..f17bb06fb4c 100644
--- a/tools/gdb/remote.c
+++ b/tools/gdb/remote.c
@@ -45,7 +45,6 @@ extern "C" {
 #endif
 #endif /* alloca not defined.  */
 
-
 #include "serial.h"
 #include "error.h"
 #include "remote.h"
@@ -313,7 +312,6 @@ static int remote_binary_checked;
 		 ? (REGISTER_BYTES * 2 + 32) \
 		 : 400)
 
-
 /* This variable sets the number of bytes to be written to the target
    in a single packet.  Normally PBUFSIZ is satisfactory, but some
    targets need smaller values (perhaps because the receiving end
diff --git a/tools/imagetool.h b/tools/imagetool.h
index a766aa2ae91..57be608210a 100644
--- a/tools/imagetool.h
+++ b/tools/imagetool.h
@@ -256,7 +256,6 @@ time_t imagetool_get_source_date(
  * for ex. default_image.c, fit_image.c
  */
 
-
 void pbl_load_uboot(int fd, struct image_tool_params *mparams);
 int zynqmpbif_copy_image(int fd, struct image_tool_params *mparams);
 int imx8image_copy_image(int fd, struct image_tool_params *mparams);
diff --git a/tools/img2srec.c b/tools/img2srec.c
index 75efd76e0e3..5a6d3259f3e 100644
--- a/tools/img2srec.c
+++ b/tools/img2srec.c
@@ -109,7 +109,6 @@ static char* ExtractDecimal (uint32_t* value,  char* getPtr)
   return getPtr;
 } /* ExtractDecimal */
 
-
 static void ExtractNumber (uint32_t* value,  char* getPtr)
 {
   bool  neg = false;
@@ -129,7 +128,6 @@ static void ExtractNumber (uint32_t* value,  char* getPtr)
   if (neg) *value = -(*value);
 } /* ExtractNumber */
 
-
 static uint8_t* ExtractWord(uint16_t* value, uint8_t* buffer)
 {
   uint16_t x;
@@ -139,7 +137,6 @@ static uint8_t* ExtractWord(uint16_t* value, uint8_t* buffer)
   return buffer;
 } /* ExtractWord */
 
-
 static uint8_t* ExtractLong(uint32_t* value, uint8_t* buffer)
 {
   uint32_t x;
@@ -151,14 +148,12 @@ static uint8_t* ExtractLong(uint32_t* value, uint8_t* buffer)
   return buffer;
 } /* ExtractLong */
 
-
 static uint8_t* ExtractBlock(uint16_t count, uint8_t* data, uint8_t* buffer)
 {
   while (count--) *data++ = *buffer++;
   return buffer;
 } /* ExtractBlock */
 
-
 static char* WriteHex(char* pa, uint8_t value, uint16_t* pCheckSum)
 {
   uint16_t  temp;
@@ -173,7 +168,6 @@ static char* WriteHex(char* pa, uint8_t value, uint16_t* pCheckSum)
   return pa;
 }
 
-
 static char* BuildSRecord(char* pa, uint16_t sType, uint32_t addr,
 			  const uint8_t* data, int nCount)
 {
@@ -223,7 +217,6 @@ static char* BuildSRecord(char* pa, uint16_t sType, uint32_t addr,
   return pa;
 }
 
-
 static void ConvertELF(char* fileName, uint32_t loadOffset)
 {
   FILE*         file;
@@ -240,7 +233,6 @@ static void ConvertELF(char* fileName, uint32_t loadOffset)
   char          srecLine[128];
   char		*hdr_name;
 
-
   /* open file */
   if ((file = fopen(fileName,"rb")) == NULL) {
     fprintf (stderr, "Can't open %s: %s\n", fileName, strerror(errno));
@@ -348,7 +340,6 @@ static void ConvertELF(char* fileName, uint32_t loadOffset)
   fclose(file);
 } /* ConvertELF */
 
-
 /*************************************************************************
 |  MAIN
 |*************************************************************************/
diff --git a/tools/imx8mimage.c b/tools/imx8mimage.c
index 939f829a9f7..d60d293e649 100644
--- a/tools/imx8mimage.c
+++ b/tools/imx8mimage.c
@@ -5,7 +5,6 @@
  * Peng Fan <peng.fan@nxp.com>
  */
 
-
 #include "imagetool.h"
 #include <image.h>
 #include "imximage.h"
diff --git a/tools/imximage.c b/tools/imximage.c
index 2df4c7dd491..467d9f27d2a 100644
--- a/tools/imximage.c
+++ b/tools/imximage.c
@@ -793,7 +793,6 @@ static uint32_t parse_cfg_file(struct imx_header *imxhdr, char *name)
 	return dcd_len;
 }
 
-
 static int imximage_check_image_types(uint8_t type)
 {
 	if (type == IH_TYPE_IMXIMAGE)
@@ -1057,7 +1056,6 @@ static int imximage_generate(struct image_tool_params *params,
 	return pad_len;
 }
 
-
 /*
  * imximage parameters
  */
diff --git a/tools/kwbimage.c b/tools/kwbimage.c
index 4dce495ff03..d1cbced28fc 100644
--- a/tools/kwbimage.c
+++ b/tools/kwbimage.c
@@ -804,7 +804,6 @@ static int kwb_sign_and_verify(RSA *key, void *data, int datasz,
 	return 0;
 }
 
-
 static int kwb_dump_fuse_cmds_38x(FILE *out, struct secure_hdr_v1 *sec_hdr)
 {
 	struct hash_v1 kak_pub_hash;
diff --git a/tools/mxsimage.c b/tools/mxsimage.c
index ead61d0cd63..42df0698ca2 100644
--- a/tools/mxsimage.c
+++ b/tools/mxsimage.c
@@ -2058,7 +2058,6 @@ static int sb_verify_image_end(struct sb_image_ctx *ictx,
 	return ret;
 }
 
-
 static int sb_build_tree_from_img(struct sb_image_ctx *ictx)
 {
 	long filesize;
-- 
2.43.0

