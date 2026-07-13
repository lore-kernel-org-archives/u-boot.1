Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFBFC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B7F84BEA;
	Mon, 13 Jul 2026 15:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fg8Ttfjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D33884BF0; Mon, 13 Jul 2026 15:31:13 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069A284BE3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=O0ginQ6CYPEyEoB0wAkycLZt5/Z3M7FQGoTgUuE83qI=; b=fg8TtfjzIR0dmFfPe/9uu2KdFY
 iL/5j+x3Su7cF6BeQkKMrxFSjBV5+b1jX7cr1hG/niLLYDZJTO6Jw652c7aFlHxE4mIzlQnjwE53G
 NW7fpG3MTFKTb0wOAzuDjW4CrOPpYAq7ROZMXlxSlpNxs++BcaaW2qkaeMvGsAYjZcbNoiBxmSau2
 i7+20CySx/LoBOQpLH+yhdB8BxJsAlBNwP6xFfgCZt1KRdmBgcJcAUJmsvdG/p9628sHI7TyQtDqP
 s8o/e1X8Ud3SXRpqXiURi2iqhGKe8EM7VRjWsxcT5ypa0dqZCQRtT34s0OctBnS8w7EtrDjftnvSK
 2yAMBC4g==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHu-000DnB-1u; Mon, 13 Jul 2026 15:01:34 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHt-000Hfn-27; Mon, 13 Jul 2026 15:01:34 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Paul Gerber <Paul.Gerber@tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 6/6] board: tqma6: add kernel device tree handling for
 environment
Date: Mon, 13 Jul 2026 15:01:06 +0200
Message-ID: <20260713130109.321862-7-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130109.321862-1-Max.Merchel@ew.tq-group.com>
References: <20260713130109.321862-1-Max.Merchel@ew.tq-group.com>
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

From: Paul Gerber <Paul.Gerber@tq-group.com>

Set the environment variable 'fdtfile' depending on ENET workaround
detection.

The function tqma6_get_fdt_configuration is implemented to be reusable
for configuration detection in multi-DTB FIT image and therefore returns
the devicetree name without the '.dtb' ending.
Set fdtfile only if CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is enabled and it
is currently unset.

The model string is loaded from the device tree variant. Therefore, the
overriding of the model string is being removed.

Signed-off-by: Paul Gerber <Paul.Gerber@tq-group.com>
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/tqma6.c | 28 +++++++++++++++++++++++-----
 board/tq/tqma6/tqma6.h |  1 +
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index b740ac7d5b1..f4cd9915185 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -117,6 +117,16 @@ static const char *tqma6_get_boardname(void)
 	};
 }
 
+const char *tqma6_get_fdt_configuration(void)
+{
+	if (is_mx6dq())
+		return !tqma6_has_enet_workaround() ? "imx6q-mba6b" : "imx6q-mba6a";
+	if (is_mx6sdl())
+		return !tqma6_has_enet_workaround() ? "imx6dl-mba6b" : "imx6dl-mba6a";
+
+	return NULL;
+}
+
 #if CONFIG_IS_ENABLED(DM_PMIC)
 /* setup board specific PMIC */
 int power_init_board(void)
@@ -137,12 +147,25 @@ int power_init_board(void)
 }
 #endif
 
+#define FDTFILE_STRLEN 32u
 int board_late_init(void)
 {
+	char fdtfile[FDTFILE_STRLEN];
+	const char *config = tqma6_get_fdt_configuration();
+
 	env_set("board_name", tqma6_get_boardname());
 
 	tqma6_detect_enet_workaround();
 
+	if (!env_get("fdtfile")) {
+		if (config) {
+			snprintf(fdtfile, FDTFILE_STRLEN, "%s.dtb", config);
+			env_set_runtime("fdtfile", fdtfile);
+		} else {
+			pr_err("ENV: Could not set kernel devicetree, ${fdtfile} remains unset\n");
+		}
+	}
+
 	tq_bb_board_late_init();
 
 	printf("Board: %s on a %s\n", tqma6_get_boardname(),
@@ -169,15 +192,10 @@ int board_late_init(void)
  * Device Tree Support
  */
 #if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT)
-#define MODELSTRLEN 32u
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	struct mmc *mmc = find_mmc_device(0);
-	char modelstr[MODELSTRLEN];
 
-	snprintf(modelstr, MODELSTRLEN, "TQ %s on %s", tqma6_get_boardname(),
-		 tq_bb_get_boardname());
-	do_fixup_by_path_string(blob, "/", "model", modelstr);
 	fdt_fixup_memory(blob, (u64)PHYS_SDRAM, (u64)gd->ram_size);
 
 	/* bring in eMMC dsr settings if needed */
diff --git a/board/tq/tqma6/tqma6.h b/board/tq/tqma6/tqma6.h
index 0cf38a4d1e3..bc09087e3df 100644
--- a/board/tq/tqma6/tqma6.h
+++ b/board/tq/tqma6/tqma6.h
@@ -8,6 +8,7 @@
 #ifndef __TQMA6_H
 #define __TQMA6_H
 
+const char *tqma6_get_fdt_configuration(void);
 int tqma6_has_enet_workaround(void);
 
 #endif /* __TQMA6_H */
-- 
2.43.0

