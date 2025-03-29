Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D3DC36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 23:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69ED780EE5;
	Sun, 30 Mar 2025 00:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A128171B; Sun, 30 Mar 2025 00:24:37 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B29C80BA8
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 00:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1tyfXW-000000005Q1-1ob9; Sat, 29 Mar 2025 23:24:34 +0000
Date: Sat, 29 Mar 2025 23:24:31 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Thomas =?iso-8859-1?Q?H=FChn?= <thomas.huehn@hs-nordhausen.de>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 2/2] tools/fit_check_sign: make key optional
Message-ID: <ce89b990d74569dc0eea4b1ff3929b3514436744.1743290511.git.daniel@makrotopia.org>
References: <bf6a90e864b713db41bf788797554649eeaa0732.1743290511.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf6a90e864b713db41bf788797554649eeaa0732.1743290511.git.daniel@makrotopia.org>
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

Allow invoking fit_check_sig without the key parameter, allowing to
validate only checksums and hashes for unsigned images.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: check key_blob and only call munmap in case it had been mmap'ed before

 tools/Makefile         |  3 +--
 tools/fit_check_sign.c | 19 +++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 237fa900a24..8b984eb60dd 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -63,8 +63,7 @@ HOSTCFLAGS_img2srec.o := -pedantic
 hostprogs-y += mkenvimage
 mkenvimage-objs := mkenvimage.o os_support.o generated/lib/crc32.o
 
-hostprogs-y += dumpimage mkimage
-hostprogs-$(CONFIG_TOOLS_LIBCRYPTO) += fit_info fit_check_sign
+hostprogs-y += dumpimage mkimage fit_info fit_check_sign
 hostprogs-$(CONFIG_TOOLS_LIBCRYPTO) += fdt_add_pubkey
 
 ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_FWU_MDATA_GPT_BLK),)
diff --git a/tools/fit_check_sign.c b/tools/fit_check_sign.c
index 3d1d33fdab1..32d0fdb8829 100644
--- a/tools/fit_check_sign.c
+++ b/tools/fit_check_sign.c
@@ -45,7 +45,7 @@ int main(int argc, char **argv)
 	char *config_name = NULL;
 	char cmdname[256];
 	int ret;
-	void *key_blob;
+	void *key_blob = NULL;
 	int c;
 
 	strncpy(cmdname, *argv, sizeof(cmdname) - 1);
@@ -70,18 +70,15 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s: Missing fdt file\n", *argv);
 		usage(*argv);
 	}
-	if (!keyfile) {
-		fprintf(stderr, "%s: Missing key file\n", *argv);
-		usage(*argv);
-	}
 
 	ffd = mmap_fdt(cmdname, fdtfile, 0, &fit_blob, &fsbuf, false, true);
 	if (ffd < 0)
 		return EXIT_FAILURE;
-	kfd = mmap_fdt(cmdname, keyfile, 0, &key_blob, &ksbuf, false, true);
-	if (kfd < 0)
-		return EXIT_FAILURE;
-
+	if (keyfile) {
+		kfd = mmap_fdt(cmdname, keyfile, 0, &key_blob, &ksbuf, false, true);
+		if (kfd < 0)
+			return EXIT_FAILURE;
+	}
 	image_set_host_blob(key_blob);
 	ret = fit_check_sign(fit_blob, key_blob, config_name);
 	if (!ret) {
@@ -93,7 +90,9 @@ int main(int argc, char **argv)
 	}
 
 	(void) munmap((void *)fit_blob, fsbuf.st_size);
-	(void) munmap((void *)key_blob, ksbuf.st_size);
+
+	if (key_blob)
+		(void)munmap((void *)key_blob, ksbuf.st_size);
 
 	close(ffd);
 	close(kfd);
-- 
2.49.0
