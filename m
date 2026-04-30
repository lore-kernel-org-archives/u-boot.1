Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1077BFF8873
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2758845E3;
	Thu, 30 Apr 2026 14:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="dqFDSBFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FBA845C8; Thu, 30 Apr 2026 14:26:45 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09AF83A91
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20260430122643a69c1a1a8300020797 for <u-boot@lists.denx.de>;
 Thu, 30 Apr 2026 14:26:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3gHQkjgM74nNJQk4cbyCbHmYATe1/a9Tiu8211uf5Ko=;
 b=dqFDSBFRWSDqwmF9FwEs4IuNYGeIzDetV7eHwUa1w2uPagA9vLOCwd1liPyKY+xvtAOngF
 D7vN4SRC458bVEHVDAjFtReaV0yrM8C5HlqHj9VOLz9egZDRky/DJz/POGBgcysDDiNXtX0p
 37pQtAOTYtWJ7x6KobeIN9MA9NCHWedtrs08f58icdWMZ5j2LW0HIsKJZ/XRTBjxyMa90VnA
 OkbasUtEwbFA5PUySys48XvXra/o2EV5RQmdEJhGD216jc/5oxhwICm/NWSfIbvHiZy+hgEr
 FWoFL30LWS/wSaGLr6SKHDKd3S1jxPb0uvAG8sCyMo6vxyhp73FAOqjw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v2 1/4] qemu: overlay signature nodes
Date: Thu, 30 Apr 2026 14:26:00 +0200
Message-ID: <20260430142602.v2.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
In-Reply-To: <20260430122629.606153-1-ludwig.nussel@siemens.com>
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
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

(no changes since v1)

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

