Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E285C36010
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 03:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603AD81E72;
	Sat, 29 Mar 2025 04:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FCFA810EA; Sat, 29 Mar 2025 04:13:06 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5254880050
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 04:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1tyMd5-000000004ZH-2yaf; Sat, 29 Mar 2025 03:13:03 +0000
Date: Sat, 29 Mar 2025 03:13:01 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
Cc: Thomas =?iso-8859-1?Q?H=FChn?= <thomas.huehn@hs-nordhausen.de>
Subject: [PATCH 2/2] tools/fit_check_sign: make key optional
Message-ID: <1f0c5a1f7e84f638f921278284ff6245d78e730d.1743217745.git.daniel@makrotopia.org>
References: <bf6a90e864b713db41bf788797554649eeaa0732.1743217745.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf6a90e864b713db41bf788797554649eeaa0732.1743217745.git.daniel@makrotopia.org>
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
 tools/fit_check_sign.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/fit_check_sign.c b/tools/fit_check_sign.c
index 3d1d33fdab1..bac299a70e5 100644
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
-- 
2.49.0
