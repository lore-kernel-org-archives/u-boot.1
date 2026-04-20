Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC34DF5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDE7844D3;
	Tue, 21 Apr 2026 00:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SDucWUTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC03844D3; Tue, 21 Apr 2026 00:03:29 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02CB8448C
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C645E40A1B; 
 Mon, 20 Apr 2026 22:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722607;
 bh=61HteiTE7kJ5RWc8vlJBZ3PRO5bgNDwO2Nn4ZUIknf4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=SDucWUTWWvnc+RVNG7VoYG1xSgkgqO7i+R7oNW3mYpNNVWkwDX+vXL3RYyJNx7edA
 3DPzRWVFCfm2TuTFULb4cFZiZsKY8s1BtZPIzQheQcUzTbGvBFvwnp0CXFPAYKN76w
 TX6rOg7hX8bEtrUGwQVQxfVr0VM6coaRehvat91AW563MOc8pc9cVY8Y9eRYwQhECr
 QrUma7zrqylkngHp+7bO8ayTLl/mPqGlQN8wVV8Lp1MWrS40IUTf0jQftOB8LMbeYT
 3WGgjbCZZx+7jy1izqXuX2NSPFRG2uV6FJqaLIv7DT7wVlSJZH2eiTwzAUv/EObgCp
 MfaAtKafoPNfFijw6ZnR9aMI7+nKA5UjJnYQKHSj3kdtnCysl16dMcGZz2268wUCZZ
 e2CoG2rHLh+Ci9fQXdL5Uin765v2PQ1r+cAirOGRFXfUVZ712hvUIuyXfu6LcBjmsB
 Kcw8IODMVuNnnPUB3/w6eY/C2fwCyNip7S3BH/b4i4/RYm8Au+qaqZXbGLZzRfK8ZB
 Hh/Q5C59cZaPbb3mwbblTOy5ZqIGUJ8egEVVeVp55RBWJU5cT2aOzoCAVgKLkKHSvf
 jQjEu42XYJem0aWV6Ur+S7tQQu/9K2jTyk8I9/0J54YpDLEYeol8M2cV577XzjtR4C
 X9FSG8G+iT8/hG1iO+zqJfss=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>,
 Ying-Chun Liu <paul.liu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/4] cmd/bootefi: move efi_init_obj_list() to the start of
 do_bootefi
Date: Tue, 21 Apr 2026 00:03:18 +0200
Message-ID: <20260420220321.71147-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
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

