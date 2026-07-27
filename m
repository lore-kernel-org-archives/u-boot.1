Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBBBC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A29880E25;
	Mon, 27 Jul 2026 12:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aN3NyL_6gOaY; Mon, 27 Jul 2026 12:06:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E76CC80E1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153993;
	bh=o7RoOq8abzkFf6PzZliBtNSYugHWeDotTPzkC0kBD4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yCgAxvx97NdaBlDysk88ZhCiPfQX8G9jd45rE55xjNJ/E55/NKlkSKHWs7/zeqbBz
	 UXP3ytGGpyT2qvrQL1CxKcfKNg8yDHgd8uszt0WRxBK5dAG3ZsTh8HPhaHbddGYx6r
	 pkFqNDDMjRUJ37dcCOkVkn/u8h/zo+xHhjlKrwv++g4FQoT6r/cyw0QhSBZw9fZ3y5
	 SSwIlxRSU8jYbFFvMq/wbVHtfkDZ7f7Z6aQ6HSzx1FCPVVFr4gtam8U7uLmyicAqom
	 5BzTzk3KSASss7vHZ/W4eKDB3mZ5VGLOb/gtS1NOevjW/0jxhiOiA2kejtndkrdQrr
	 2waCAYueDwFcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E76CC80E1B;
	Mon, 27 Jul 2026 12:06:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 110284C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAB2C40065
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mQcr22iWp7NX for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:06:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B431A4006A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B431A4006A
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B431A4006A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK66-000JO5-3B; Mon, 27 Jul 2026 14:06:19 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK66-000I7f-2P; Mon, 27 Jul 2026 14:06:18 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 14:06:20 +0200
Subject: [PATCH RESEND 6/6] board: tqma6: add kernel device tree handling
 for environment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6_bis_spl-v1-6-27673934830f@ew.tq-group.com>
References: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
In-Reply-To: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=o7RoOq8abzkFf6PzZliBtNSYugHWeDotTPzkC0kBD4o=; b=lAmDhshO5UKhrM2GdKPXV9y7ak
 iHn9rRbOOzV07nqiQku3fLm8NADAZpjKr1ycusKInqxHYvdVzuiotFXu2UIOgF6gVNaqtC5Zs2nag
 J+fbtAqHHnO3+ulXLV9yiujQwqY6Xr6U+5uieMAaw6DZoTTRWTs7X/sR6rKo+NhtETg3wsN5roLl/
 NKnWJbScxfIUleLpWHgzfgHLNuUs85eYSqi+ewSjvlxkCK8UF2OeqjCbpSx0TMrOAZtnpSvvzpCRL
 XL1eo8k2bMEYjJmFIUAO61DOQ3iUHlQ3QAMY/05tqrJhMeS2MnkWYz5qhTnuAJKbrWtJdY023cpAr
 n5U+vOvw==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=lAmDhshO
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

