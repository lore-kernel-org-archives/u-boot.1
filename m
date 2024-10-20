Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE1FD3C92A
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 15:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FB438880B;
	Sun, 20 Oct 2024 17:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JDvUIpTw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NbNBm/uq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED178880F; Sun, 20 Oct 2024 17:43:43 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 281E388744
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 17:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XWjQh4DF3z9sls;
 Sun, 20 Oct 2024 17:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729439020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w41lzbJ5kcEoVaoPZkPA5CuDB+bmFN1+k7fgbXB6buU=;
 b=JDvUIpTwm6dLi4udWrSMnxS20DzdgHspw7/AxN/e1l2Jh4AlycJf5FFaTswTb7kUh+D6Ha
 OkigV8JFMOJ2PEAKy37Lu/aZZ+cWxRdn1A3uruE7X8pB8okwhVWAW9eBM41eCHwD5AF5mR
 nT8kcr9zT03+blDUJ0Qk1rANEUL6BXoV9ToCD9A4Vp3bRLJW4kflqG5iXiW8Nnq0Mvl5LO
 1KHRjdtFpjY4Nsw8xpChJ2Xrz524LdMFwGvw3dVHqkK7mMdglnQV6/7ELpujEQnHZBxjUL
 h8jZnKd0cpbk10qsyOesbXIRH3xiHAUMqK3Abn/2bFQQ+oOY/lASh+cFfihrsg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729439018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w41lzbJ5kcEoVaoPZkPA5CuDB+bmFN1+k7fgbXB6buU=;
 b=NbNBm/uqjRXzpLbE2/gD/gm/xv8GPH25ModuEePNiWXYUY5PLsVfTY8AqUq6hjUDCW1AxR
 vWCu3yq9Wl4RmJ01Iy0e4LaKFhZkQr4lVabB3OK0mQ0eBCTyLaADYCtqdnFEKL5Wju3SoY
 KkJiiUmp4frK4aJ5FxGLqxTxHcNy/oOrFdeeaiN+A+yx0Lxglf+E+Dh0KStOu1vUfos5+R
 zQ7hxepjz1cG9wj8saQhQWEZ2x+79/TuPtm4gnvhyN51KqFXs6yPm6edWUIJxypulNfoqI
 4ZMMp1lPoG9shba2BkQ4CjDWTgcuKE7kHsdUsVOwDE0vQKdt9ny38RlstCfNOQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] boot: Introduce BOOTSTD_MENU to control bootflow menu build
Date: Sun, 20 Oct 2024 17:43:12 +0200
Message-ID: <20241020154323.43308-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: u6eo7wgcxuc48x895qwc3xiw1okpwptu
X-MBO-RS-ID: 30dedb4940d5febd465
X-Rspamd-Queue-Id: 4XWjQh4DF3z9sls
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

The bootflow_menu.c code depends on e.g. scene_txt_set_font(),
which is only built when CONFIG_EXPO is enabled. Introduce new
Kconfig symbol BOOTSTD_MENU which depends on EXPO to prevent
triggering errors like these in case e.g. CONFIG_VIDEO=n :

"
boot/bootflow_menu.c:158:(.text+0x8851): undefined reference to `scene_txt_set_font'
"

Make the symbol depend on BOOTSTD_FULL as well to get rid of
the Makefile dependency workaround. Since BOOTSTD_FULL is not
available in SPL, do not define SPL variant of BOOTSTD_MENU.

Fix up bootflow test accordingly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 boot/Kconfig         | 7 +++++++
 boot/Makefile        | 5 +----
 test/boot/bootflow.c | 3 +++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 1ce1da6020c..418233b653d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -469,6 +469,13 @@ config BOOTSTD_BOOTCOMMAND
 	  standard boot does not support all of the features of distro boot
 	  yet.
 
+config BOOTSTD_MENU
+	bool "Provide a menu of available bootflows for standard boot"
+	depends on BOOTSTD_FULL && EXPO
+	default y
+	help
+	  Provide a menu of available bootflows and related options.
+
 config BOOTSTD_PROG
 	bool "Use programmatic boot"
 	depends on !CMDLINE
diff --git a/boot/Makefile b/boot/Makefile
index b24f806d5bf..0e0afad68d1 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootflow.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootmeth-uclass.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootstd-uclass.o
 
+obj-$(CONFIG_$(PHASE_)BOOTSTD_MENU) += bootflow_menu.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
@@ -35,10 +36,6 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
 obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFI_BOOTMGR) += bootmeth_efi_mgr.o
-ifdef CONFIG_$(PHASE_)BOOTSTD_FULL
-obj-$(CONFIG_$(PHASE_)EXPO) += bootflow_menu.o
-obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootflow_menu.o
-endif
 
 obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += fdt_support.o
 obj-$(CONFIG_$(PHASE_)FDT_SIMPLEFB) += fdt_simplefb.o
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 154dea70a59..0d4e966892e 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -857,6 +857,9 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 	ofnode node;
 	int i;
 
+	if (!CONFIG_IS_ENABLED(BOOTSTD_MENU))
+		return -EAGAIN;
+
 	ut_assertok(scan_mmc4_bootdev(uts));
 
 	ut_assertok(bootflow_menu_new(&exp));
-- 
2.45.2

