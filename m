Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF05CE909D3
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 16:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F0483E4C;
	Tue, 17 Feb 2026 17:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="IKMKw4Hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA4283C32; Tue, 17 Feb 2026 17:39:23 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC95783D0B
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 17:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D103A110AD7; Tue, 17 Feb 2026 17:39:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771346361; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=GKfN29bmpNSmTJkH2olG1NrBQVk9IztnPTBuuB4/v/0=;
 b=IKMKw4HzbDLFmvzf3zNIdKJe51+WLInWKrHXxfOybFE1fkeDOFX3qRDvzwo8Q/UFhbUuZ7
 Ab3qzVURFoLVfJfwxWSZ3Z0yXfwnpJ57j0qvdMVGKp5mYtm8QSKTTD4OWrwUHw0mBzoBqo
 4ibYAayw0m2jz1YbVQXnYHQvHWVuOhEYgqorTRO+cu2whaIA/a6M44L8wd2e3UqgzDw6qR
 s5KCz+vBPj41BPzvKusfA3uTW/r2RRmQ+/cXLSICTv4beiFzvDKC400QNfugG6HB+cm7o9
 /G+dYv8TosEpbgxDJwTE0M4bdcTF7R0SKbMOLvk4aT1TAseqyGQMj+lrisIO2A==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Heiko Schocher <hs@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v3 08/11] siemens: capricorn: always detect emmc device
Date: Tue, 17 Feb 2026 17:39:08 +0100
Message-Id: <20260217163911.31878-9-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260217163911.31878-1-hs@nabladev.com>
References: <20260217163911.31878-1-hs@nabladev.com>
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

drop Environment variable mmcautodetect and the board logic
behind it, as we want always to autodetct the emmc device.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

(no changes since v2)

Changes in v2:
Added Reviewed-by from Peng

 board/siemens/capricorn/board.c               | 13 -------------
 board/siemens/capricorn/capricorn_default.env |  1 -
 2 files changed, 14 deletions(-)

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 34e7f2d1713..ba6c96a409c 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -357,16 +357,6 @@ int board_mmc_get_env_dev(int devno)
 	return devno;
 }
 
-static int check_mmc_autodetect(void)
-{
-	char *autodetect_str = env_get("mmcautodetect");
-
-	if (autodetect_str && (strcmp(autodetect_str, "yes") == 0))
-		return 1;
-
-	return 0;
-}
-
 /* This should be defined for each board */
 __weak int mmc_map_to_kernel_blk(int dev_no)
 {
@@ -377,9 +367,6 @@ void board_late_mmc_env_init(void)
 {
 	u32 dev_no = mmc_get_env_dev();
 
-	if (!check_mmc_autodetect())
-		return;
-
 	env_set_ulong("mmcdev", dev_no);
 }
 
diff --git a/board/siemens/capricorn/capricorn_default.env b/board/siemens/capricorn/capricorn_default.env
index c8b5b3d7da3..ad88f7ed770 100644
--- a/board/siemens/capricorn/capricorn_default.env
+++ b/board/siemens/capricorn/capricorn_default.env
@@ -45,4 +45,3 @@ kboot=booti
 bootcmd_mfg=run mfgtool_args; if iminfo ${initrd_addr}; then if test ${tee} = yes; then bootm ${tee_addr} ${initrd_addr} ${fdt_addr}; else booti ${loadaddr} ${initrd_addr} ${fdt_addr}; fi; else echo "Run fastboot ..."; fastboot usb auto; fi;
 fastboot_bytes=124c00
 fastboot_dev=mmc
-mmcautodetect=yes
-- 
2.20.1

