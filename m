Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8EBC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 16:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA1680283;
	Tue, 21 Jan 2025 17:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Q0ANXBXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6B2801F5; Tue, 21 Jan 2025 17:22:22 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675D580326
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 17:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 325E9148471A; Tue, 21 Jan 2025 17:22:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737476539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2zssWcWKDsaCN9iaF+GVDFaxfZgTAY61Tr0+m7lvtTM=;
 b=Q0ANXBXbBEN6T9r/kXMGXkUxqYoqDDm/cCfAaTZFY+pZU16gjTNAbuESo464IIzxu5ikQh
 t2hWHLdrbAtKPmhfxucGXSthI1COxHukUSRhnvTEtnLjciFfbwJyWN8HrVWoaSw30bgpZn
 2G3KU/n2CPSTaPHc8es9iiD/PO4paBnUW4D1w5f3T7RTqgIXEddaEdS2jaAahg3fnk0QkE
 zy5SATZK/EvOo43iYdFGkeMSEZn0s0KRFxSoaLYOAhgLyizVgz9JQ/dqRmyIysIuMoaA1c
 IUuO0OEhFcdZE2EldeXG0+pHRCIvv/bZ/FRUIp3jdaVhNPD7zlUzMgerkJaOZg==
From: Alexander Dahl <ada@thorsis.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH] fpga: Avoid ignored-qualifiers warning
Date: Tue, 21 Jan 2025 17:22:12 +0100
Message-Id: <20250121162213.1477506-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Fixes annoying warnings of the following type when built with W=1 (for
each file including fpga.h):

      CC      drivers/fpga/fpga.o
    In file included from /mnt/data/adahl/src/u-boot/include/xilinx.h:7,
                     from /mnt/data/adahl/src/u-boot/drivers/fpga/fpga.c:10:
    /mnt/data/adahl/src/u-boot/include/fpga.h:61:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
       61 | const fpga_desc *const fpga_get_desc(int devnum);
          | ^~~~~
    /mnt/data/adahl/src/u-boot/include/fpga.h:81:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
       81 | const fpga_desc *const fpga_validate(int devnum, const void *buf,
          | ^~~~~
    /mnt/data/adahl/src/u-boot/drivers/fpga/fpga.c:36:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
       36 | const fpga_desc *const fpga_get_desc(int devnum)
          | ^~~~~
    /mnt/data/adahl/src/u-boot/drivers/fpga/fpga.c:53:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
       53 | const fpga_desc *const fpga_validate(int devnum, const void *buf,
          | ^~~~~

Do some type and cast cleanup on that fpga_desc type file at it.

Link: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wignored-qualifiers
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/fpga/fpga.c | 14 +++++++-------
 include/fpga.h      |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/fpga.c b/drivers/fpga/fpga.c
index 1f6782537de..f88267e01b6 100644
--- a/drivers/fpga/fpga.c
+++ b/drivers/fpga/fpga.c
@@ -33,9 +33,9 @@ static void fpga_no_sup(char *fn, char *msg)
 /* fpga_get_desc
  *	map a device number to a descriptor
  */
-const fpga_desc *const fpga_get_desc(int devnum)
+const fpga_desc *fpga_get_desc(int devnum)
 {
-	fpga_desc *desc = (fpga_desc *)NULL;
+	const fpga_desc *desc = NULL;
 
 	if ((devnum >= 0) && (devnum < next_desc)) {
 		desc = &desc_table[devnum];
@@ -50,8 +50,8 @@ const fpga_desc *const fpga_get_desc(int devnum)
  * fpga_validate
  *	generic parameter checking code
  */
-const fpga_desc *const fpga_validate(int devnum, const void *buf,
-				     size_t bsize, char *fn)
+const fpga_desc *fpga_validate(int devnum, const void *buf,
+			       size_t bsize, char *fn)
 {
 	const fpga_desc *desc = fpga_get_desc(devnum);
 
@@ -60,7 +60,7 @@ const fpga_desc *const fpga_validate(int devnum, const void *buf,
 
 	if (!buf) {
 		printf("%s: Null buffer.\n", fn);
-		return (fpga_desc * const)NULL;
+		return NULL;
 	}
 	return desc;
 }
@@ -72,7 +72,7 @@ const fpga_desc *const fpga_validate(int devnum, const void *buf,
 static int fpga_dev_info(int devnum)
 {
 	int ret_val = FPGA_FAIL; /* assume failure */
-	const fpga_desc * const desc = fpga_get_desc(devnum);
+	const fpga_desc *desc = fpga_get_desc(devnum);
 
 	if (desc) {
 		debug("%s: Device Descriptor @ 0x%p\n",
@@ -374,7 +374,7 @@ int fpga_info(int devnum)
 #if CONFIG_IS_ENABLED(FPGA_LOAD_SECURE)
 int fpga_compatible2flag(int devnum, const char *compatible)
 {
-	const fpga_desc * const desc = fpga_get_desc(devnum);
+	const fpga_desc *desc = fpga_get_desc(devnum);
 
 	if (!desc)
 		return 0;
diff --git a/include/fpga.h b/include/fpga.h
index 44f2755a3f1..4cc44164b2f 100644
--- a/include/fpga.h
+++ b/include/fpga.h
@@ -58,7 +58,7 @@ typedef enum {
 void fpga_init(void);
 int fpga_add(fpga_type devtype, void *desc);
 int fpga_count(void);
-const fpga_desc *const fpga_get_desc(int devnum);
+const fpga_desc *fpga_get_desc(int devnum);
 int fpga_is_partial_data(int devnum, size_t img_len);
 #if CONFIG_IS_ENABLED(FPGA)
 int fpga_load(int devnum, const void *buf, size_t bsize,
@@ -78,8 +78,8 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 		       bitstream_type bstype);
 int fpga_dump(int devnum, const void *buf, size_t bsize);
 int fpga_info(int devnum);
-const fpga_desc *const fpga_validate(int devnum, const void *buf,
-				     size_t bsize, char *fn);
+const fpga_desc *fpga_validate(int devnum, const void *buf,
+			       size_t bsize, char *fn);
 int fpga_compatible2flag(int devnum, const char *compatible);
 
 #endif	/* _FPGA_H_ */

base-commit: 5d5ce5f25708077e354a5627ec92b643145992cc
-- 
2.39.5

