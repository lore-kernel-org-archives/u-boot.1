Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3811FF99C89
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 17:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA7A841C2;
	Sat, 18 Apr 2026 19:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CRGx8vH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0CB836AC; Sat, 18 Apr 2026 19:58:19 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728F783FC0
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 19:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8E05340D65; 
 Sat, 18 Apr 2026 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776535097;
 bh=Cpe+8hW0HVaCXUUx8cvMdW1CXgJEXBcf2/vPZLnThhw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CRGx8vH6xw0lC7Pb0ZP5JjkI7LsMpavBEmtf7uGeP8jtWGigdFb4edO3iTER7gCHS
 TI0iSauAO+DkZ5v1xVR6mwhVTajXIvhpWTLsu/bcRxKJflvGIuFVnV3z7jF0hd8d4h
 iSprHLvOzlingppDwar6dk87MgxazgW+Gn92veHPkNxPCs6GJd78wus1b6pKVOnYKy
 qzvx0zANVT6bdezwBEscLAcCTf6wrV0rL3au2HQwW6gRNhbzrJK6A/RejF7BtU6I/+
 /9erhJ9T0qOJVtdeiuhVRve6BqqGSVuq4il0KpZYUxZffpeseANkATlkNgqj1dx945
 lWKAAwMbfAQL1BBOwo4mdCiHamhr3dHMzQtdM2vTzY7m5J4z3RkpSCnfQNFiHgrA7n
 usvYX8ZFVIV6o3uIsvo8bbYQDSB5HGKMLD+b1Rf7xnp8X70QnmgOc2D/tgMahGb9mJ
 8h6hGaTa0GWM5iw4B23/RxX4c2zOHDIXn7fNhPhnYzfnyfeiTEkwwflR9QWBX6OT+j
 iwQpR3IgxlboqzaoktHUZxHVgaVD7Kxtvq7Wcb1kEHlgkhslB14vtGHbQ6wvVfMFSq
 mQui5f49NBpJDf4wTquYUKzGGPe7TxSv2GT9vBLtMREMcLkwcBz1gj5Dt1sIIS4E2X
 wUbL/FPPHAKhLkIV6pGvUmHc=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Adriano Cordova <adrianox@gmail.com>, Javier Tia <floss@jetm.me>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] cmd/bootefi: move efi_init_obj_list() to the start of
 do_bootefi
Date: Sat, 18 Apr 2026 19:58:13 +0200
Message-ID: <20260418175814.5731-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418175814.5731-1-heinrich.schuchardt@canonical.com>
References: <20260418175814.5731-1-heinrich.schuchardt@canonical.com>
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

None of the bootefi commands can be executed if the EFI sub-system cannot
be initialized.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bootefi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 85f41c3b0a0..6dab709e507 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -142,6 +142,14 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
+	/* Initialize EFI drivers */
+	ret = efi_init_obj_list();
+	if (ret != EFI_SUCCESS) {
+		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
+		return CMD_RET_FAILURE;
+	}
+
 	if (argc > 2) {
 		ulong rd_addr = 0;
 		char *end = strchr(argv[2], ':');
@@ -179,14 +187,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
 	    !strcmp(argv[1], "selftest")) {
-		/* Initialize EFI drivers */
-		ret = efi_init_obj_list();
-		if (ret != EFI_SUCCESS) {
-			log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-				ret & ~EFI_ERROR_MASK);
-			return CMD_RET_FAILURE;
-		}
-
 		ret = efi_install_fdt(fdt);
 		if (ret != EFI_SUCCESS)
 			return CMD_RET_FAILURE;
-- 
2.53.0

