Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAB6EA71B5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 01:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B9CC84286;
	Mon, 20 Apr 2026 03:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JHVbr7Lt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S9wsuu4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5692842B7; Mon, 20 Apr 2026 03:23:57 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E180D80433
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 03:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fzSSC3YGdz9tlP;
 Mon, 20 Apr 2026 03:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/jZbCz8pkzYe8pvgBOQePmBJbCGJhIDXaMxzibPdXGo=;
 b=JHVbr7LtxEG//Erase3iz+Hv1zPuC9jDcSNGi1MWUBLbRgXB4xmduQ9Ux8hHC/Ps87b/Vx
 KSskr7t4NrOxvuLmFt7cr/v0BPSY6JEmjTHKvp8LRGbdgZQj9Ug+7K7vaf5c96zv7rwS2t
 BuNeyKhGIn+95MJO7AvT6qBCJWL2km3n62FeTYm0a5OAD+2+dWBNe8tg3cqHeeFDrcrnXP
 uIQlKeiS1ZhcQPFk4LbAdbw0S7Nwm2f/2nXSgovnqW/A4QhMeqsjajOmP5LFaT0xnts5Qf
 sxDkxkaMl/y1PERjTDxZUN8KIfegGkk6NZQIgUlobgly7FVf3LYnMhcNLK++Kg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/jZbCz8pkzYe8pvgBOQePmBJbCGJhIDXaMxzibPdXGo=;
 b=S9wsuu4ksg3y8XjXYJutCyAp5CHpBBqGddXwUMd3ErrL794NOeaWTfXkzjbizgTdxwX5hp
 ryjOe/7aIy/zMF19nFnSrfMwdASJE3zbR5BmHTsqBmyX989zHWyR6A5fAUezqaM/P23LbN
 ZEHHaXY26QQ2GrFBuEzdN2B8mrgNJF+GM5CTgf/NMDuRCugfWzXkhGkARM1N+pFADXAZc5
 PWgJvaYS7XricuULM21FCNWMJlKU6eoNIYe7K63bikNu9lHcPudAlWmAwKtfYt9HSSWj1h
 bQ7ZTwPKoRHKKJBr283OvvcHd/LftLrCQs3rEmN8Q3fmCeQFcFwLVy7qG3/R4w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
Date: Mon, 20 Apr 2026 03:23:26 +0200
Message-ID: <20260420012348.400492-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xturz89g1fg77yqr45zqog6riqfez9nx
X-MBO-RS-ID: b3c85ea9681649db3c5
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

The fdtgrep command will reduce the DT to minimum size, thus eliminating
the extra padding configured via CONFIG_SYS_DTC_PAD_BYTES. Reinstate the
extra padding by running the output DTB from fdtgrep through DTC with the
-p CONFIG_SYS_DTC_PAD_BYTES flag again in case CONFIG_SYS_DTC_PAD_BYTES
is not zero.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 scripts/Makefile.lib | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 7386353e0cc..443d6cd09cf 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -806,9 +806,16 @@ quiet_cmd_fdtgrep = FDTGREP $@
 # ---------------------------------------------------------------------------
 # Pass the original device tree file through fdtgrep. This removes various
 # unused properties. The output is typically a smaller device tree file.
+ifeq ($(CONFIG_SYS_DTC_PAD_BYTES),0)
 quiet_cmd_fdt_rm_props = FDTGREP $@
 	cmd_fdt_rm_props = cat $< | $(objtree)/tools/fdtgrep -r -O dtb - -o $@ \
 			$(addprefix -P ,$(subst $\",,$(CONFIG_OF_REMOVE_PROPS)))
+else
+quiet_cmd_fdt_rm_props = FDTGREP $@
+	cmd_fdt_rm_props = cat $< | $(objtree)/tools/fdtgrep -r -O dtb - \
+			$(addprefix -P ,$(subst $\",,$(CONFIG_OF_REMOVE_PROPS))) | \
+			$(DTC) -I dtb -O dtb $(DTC_FLAGS) -p $(CONFIG_SYS_DTC_PAD_BYTES) -o $@
+endif
 
 # ASM offsets
 # ---------------------------------------------------------------------------
-- 
2.53.0

