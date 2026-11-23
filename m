Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50354606A331
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O3PNb5l4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LEG+R7Oj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F12340705;
	Mon, 23 Nov 2026 15:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nR2VnP7pAJo1; Mon, 23 Nov 2026 15:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6388E406F6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795446922;
	b=nbpD0nxj3ofTqxZbOdBJdewBf9OuQRp24wq/dZIye1AdqWz/H5zMXCQgPlLVpvEQ5q8R
	 A9LkdKMW3TE9XuMejzokpc/nWrXrF33tNuz5FE73ZBqDNFm0tx4OtgVVt4J0IDndprVt/
	 t+VrybWTgS4n3d4rfHSJA+q0M/4DiTUn9J9RJJV8fpvhurz+Dei8z6VwOJovhVqLJhDJD
	 xoIp75wviELK1uvFLHTBBsP6oFTAtbrJZRoiFG3MXa7F7rcLzuqt6tzCgJ4mpr3/fvAge
	 qH37NqRZNZ8BKL4E7DN2ND/9//Mtm3rjWaM2JQgNFW47WLXnG1QtWLKms5w8ux7SAlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795446922;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h4fEfx+9+60OWf7aEqHjX81r8vB7X7VESXWTPt6Vl68=;
	b=Xmt6AXaMR0KflWl1h4aBfxePr5QrKp3X0TkjS206Qw4PO+WG+ph7l1TefzHbv9pjnYyM
	 AWx6j9A91Zw8UAE8ja/4WHL/T1RPSgUOwhECdG6Q/aiYEBs1o6OzUcfaH21Wo9rR+c0ud
	 0XssQ+mgOnMEuAYkhKnzpz43x/P16jBMPD187QKq/+tIKTnLdmy+/WNOnxk41dTiuuk6d
	 2fvZ401rG+EamZsAZ8Y7o/shiaUDPdwtP2MBt+/9Tx4iygQbKstw4uXQ9oYJnns1Lw7at
	 uAWPW1EFfRdBvy0kmkdx9jvb4Z1oZCc7xUJ6Qo6MDtywqZM6JnSwqIT47qQR5UpDTRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795446922;
	bh=h4fEfx+9+60OWf7aEqHjX81r8vB7X7VESXWTPt6Vl68=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O3PNb5l4pbvTOmzvquM5VAKUHyRLU0TtaKUIjrJAGS4HoXC1tXy028Gmcio8jWc/z
	 hT/bOXh7C4UxYJS8QayF2hfpXElsCWTxHtghKoKbxgPxwnPx6J/nDu2nw4Xe1jZan1
	 TD8JnkTJ2HJsvG97R+GG4zjPqV3Knz4qb7o6eoOtK4c74Wamttu6tCY045gQ/gCEQ7
	 WLNcLYq1jwmne83vtn63zr2+BAYEJzAAwpbLHpsZgnUMFWKwoHJxA1rYdxPOmqRxaM
	 vBMbCuJKxHWkaHAH6nJ+P2ZoQXiwOczO6lIwe8YzzQBAplLS0oAa1V3ORQpqqug1vO
	 pvj3WEGLuOQog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6388E406F6;
	Mon, 23 Nov 2026 15:15:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 914BF759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77B794008F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:15:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LeXEa6bX8PsI for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:15:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B1FC640060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LEG+R7Oj
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1FC640060
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:15:16 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-702fd86d674so2237615eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795446915; x=1796051715;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h4fEfx+9+60OWf7aEqHjX81r8vB7X7VESXWTPt6Vl68=;
 b=LEG+R7OjKB+7eBzqfLtXyl5nm7+Nqeez9zbv27nlmd7Q3B5LG8DpQg2hAniiSoz5pO
 FPwWZWSQtC7EKUHBuGfVt4wPbD6u5WQCLQZ13jjS0SdRFUBkjQnLi3IiuzT/XwjEpM9t
 NarQpvZ6vBrBFBpG6xxuuOimlOAWNufIqNOA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795446915; x=1796051715;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h4fEfx+9+60OWf7aEqHjX81r8vB7X7VESXWTPt6Vl68=;
 b=0QUMMyx7wuenXk3j/8NAG2SykSMNFWVl4+6MyGwnnASumSdz4wPAfWXPC8iYgWIEiz
 BK2NeiPgPeARoyyhku9JSpALQLoth65kFAMScEGtdJvjPH4i3Xe+Xp70AQSlzwz5INGl
 zsmHpYQOkP5D35u05RzEVuidaTrAuepaiIC/O5RRJILfM3/fNa9dHbwkyiT8Teox1nrA
 au+8Oqxe7ZKovobG+YNbIkIKPQgPdwayHwNghtt82neA3ti5vJ4ESalZp2XY9bXYCuaB
 ha4MNYwFL80+HJC4m70dJ3cw8KN8pl/iiZdRzWOjlJtGuOG3VSbP/cQ24oXF5V78CFWd
 7Muw==
X-Gm-Message-State: APuU4Z8SylQ7yaE1hWRy3tMdHgbXgv4589WHxVQSzvdIqqM3rDxHxITe
 IH673lxhqBKq36cZ+F+m70RUBL4BdbRzuhmE1tTAznZ1JKrxBW3NyJ6HJkmcxzpZHm07XLUmBE3
 mCGVyaz0Ipwwc
X-Gm-Gg: AZFdTZeBoobnVpcPYhiv8D1p63VGq5eCpUGuqCDM3ZKnbA7UdpWCO7beWvcuoUrgfqP
 OYUboNptpJLU7zG/eTcci80VRKSuYkM5VKzYKqbk+G12+C6aRJNluXHNZrDcD7mYmp33Vpw1tfs
 p+xOr5zqdUFxlOi+xpnmS3ceNjOZRTYKz//AyJjywZ5HqwahinMvvmUZgY7VoWPBJITciWXnsgo
 IguYaxxsGffavf0cmvQ9JpTz8CFnPsjmZvC71eoUamJdzMpBVW6a+7FQkI0dYJgKcpmLNbWtOU0
 RUl6qST+C1peEZrDdlpLFU9Fqlow7cc6SrTKuZG7yRFK7mKM9+q3E+QTBdS5Al77SAQ5QPoF69y
 blgn52+T1jkQmCH2k/tEQN+nx97YKbpJF3OgBdr6BT7Tk4nAoY/Q7EwlnZCIoYoY24KVc4XVkpC
 j/Dwsz8AutTvZ5x8P3sD16Ouo5xJVpfC3Vq7W0Qh9ljANwdLtZRKLWEhoqd1n7qhXCo2isrGZyW
 FEHzwIlaU4svFoZcRuL4ASwBMfsgVUZKxF2VuB4GMCp13HcC8wATgMQQEOWVwpdXicYhN8hdgY1
 SzqIqMojdsLgXVTRIyZw9JIKb03qBcwNfA9y6hLZklNB4cj5ilSgZxeH6Hirtp6zWZGK9xdgybf
 fh2aQ7GV8JKU6vfUz6i2cAvolmlKB9Dm6Edg9y7EJcM5IgH0O9ivFHNfQ2F3rnLGN1t0sJUQLzj
 L07tzlawleC/8s+v1URnZsbuwFWGFDx191e65R/RZ1AFKCjTI3rh6LwIvEtN/mm8dxTsfL9kJps
 6u3
X-Received: by 2002:a05:6820:340a:10b0:716:db9f:682c with SMTP id
 006d021491bc7-71b3960e47cmr6488137eaf.69.1795446915508; 
 Mon, 23 Nov 2026 07:15:15 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b38015c46sm7490835eaf.4.2026.11.23.07.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:15:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] Revert "boot: pxe: support booting PE/COFF EFI applications"
Date: Mon, 23 Nov 2026 09:15:12 -0600
Message-ID: <20261123151512.1870476-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit 841abbc6d5610b3f9572df5a53d770206a930bde.

There has been assorted discussions of the functional changes and some
regressions this patch introduces, so remove it for now until it can be
reworked.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/pxe_utils.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index c60429a5e12b..8ec48a43bfa1 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -9,7 +9,6 @@
 #include <bootflow.h>
 #include <command.h>
 #include <dm.h>
-#include <efi_loader.h>
 #include <env.h>
 #include <extension_board.h>
 #include <image.h>
@@ -537,7 +536,6 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	int zboot_argc = 3;
 	int len = 0;
 	ulong kernel_addr_r;
-	ulong kernel_size = 0;
 	void *buf;
 
 	label_print(label);
@@ -557,8 +555,7 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	}
 
 	if (get_relfile_envaddr(ctx, label->kernel, "kernel_addr_r",
-				(enum bootflow_img_t)IH_TYPE_KERNEL,
-				&kernel_size)
+				(enum bootflow_img_t)IH_TYPE_KERNEL, NULL)
 				< 0) {
 		printf("Skipping %s for failure retrieving kernel\n",
 		       label->name);
@@ -803,21 +800,8 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		bootm_argc = 4;
 	}
 
-	/* Run PE-COFF images as EFI applications */
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI) &&
-	    efi_check_pe(buf, kernel_size, NULL) == EFI_SUCCESS) {
-		void *fdt = EFI_FDT_USE_INTERNAL;
-		efi_status_t efi_ret;
-
-		log_debug("using bootefi\n");
-		if (bootm_argv[3])
-			fdt = map_sysmem(hextoul(bootm_argv[3], NULL), 0);
-
-		efi_ret = efi_binary_run(buf, kernel_size, fdt, NULL, 0);
-		if (efi_ret != EFI_SUCCESS)
-			log_err("efi_binary_run failed (ret=%lu)\n", efi_ret);
 	/* Try bootm for legacy and FIT format image */
-	} else if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
+	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
 	    IS_ENABLED(CONFIG_CMD_BOOTM)) {
 		log_debug("using bootm\n");
 		do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
-- 
2.43.0

