Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD915FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 15:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A130D83693;
	Mon, 27 Apr 2026 17:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="PspsK55D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C25078416F; Mon, 27 Apr 2026 17:04:54 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A48EE83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202604271504518e9f35cfe8000207c3 for <u-boot@lists.denx.de>;
 Mon, 27 Apr 2026 17:04:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3uJ9tKjGteE1L3PXQEENsWHygkCp7cxfujTGzIlEb/k=;
 b=PspsK55DiHeWLO2vKl6l+tS7ETmyA00sAwYOk0u709HPDAbmq46R2t4ZlxR00tYtLrj0qG
 qpcIXxgUMaIMmMTtnzhhLGvGMGsyvrm9I1qu+AOCn45qaaFFFyyUCcu10NDCT0yy96P+TzAr
 rHJB3wecJdZROg1SWz7DYDUD1NUPeGPxzR+kGEk0A0E1oNGz+WwqV3h1RpYs/QxR7KgdSdsS
 jwCfNbL5xA5CEs5hlp/lGJN8YKrpD2IDH7hL8/6zyUNdJe3xCp10jzQ+4e9VPoJZz5eR2qcn
 RbHQ3H1PH40Dvlcu8IwzYkz/2hhe5GA9msUziewZEfYAmqv8wuEYd/tA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 1/4] qemu: overlay signature nodes
Date: Mon, 27 Apr 2026 17:03:38 +0200
Message-ID: <20260427150409.400914-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

The keys trusted for FIT signature verification are supposed to be
embedded in the device tree built into u-boot. When running in Qemu it's
convenient to use the device tree provided by the VM which doesn't know
about signatures though. So merge the signature nodes at run time.

Needs
  CONFIG_OF_OMIT_DTB=n
  CONFIG_OF_LIBFDT_OVERLAY=y

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

 board/emulation/qemu-arm/qemu-arm.c | 33 ++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 38f0ec5f2fb..460958b04a1 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -147,7 +147,38 @@ int dram_init_banksize(void)
 int board_fdt_blob_setup(void **fdtp)
 {
 	/* QEMU loads a generated DTB for us at the start of RAM. */
-	*fdtp = (void *)CFG_SYS_SDRAM_BASE;
+	void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
+	int ret;
+
+	if (!*fdtp)
+		goto out;
+
+	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY)) {
+		log_err("found built-in dt but CONFIG_OF_LIBFDT_OVERLAY isn't enabled");
+		goto out;
+	}
+
+	if (fdt_check_header(*fdtp) != 0) {
+		log_err("invalid built-in fdt, skipped.\n");
+		goto out;
+	}
+
+	log_debug("found built-in dt %p merging into qemu's at %p...\n", *fdtp, qemu_fdt);
+
+	ret = fdt_increase_size(qemu_fdt, 1024 + fdt_totalsize(*fdtp));
+	if (ret) {
+		log_err("Failed to resize overlay: %d", ret);
+		goto out;
+	}
+
+	ret = fdt_overlay_apply_node(qemu_fdt, 0, (void *)*fdtp, 0);
+	if (ret) {
+		log_err("Failed to apply overlay: %d\n", ret);
+		goto out;
+	}
+
+out:
+	*fdtp = qemu_fdt;
 
 	return 0;
 }
-- 
2.43.0

base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
branch: us-qemu-signatures
