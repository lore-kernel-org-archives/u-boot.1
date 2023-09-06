Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1E1EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BEBA86A8F;
	Wed,  6 Sep 2023 23:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VHl8aiCu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cbWCXUXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F39A86A7A; Wed,  6 Sep 2023 23:31:06 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C29486AA8
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXh5gSNz9tTZ;
 Wed,  6 Sep 2023 23:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QyNvDOXC+xgEJHt+c9sCI7psHyHaivatsb314MXSm+Q=;
 b=VHl8aiCuEabpWT+QaolCjrC2FYzqP1Ww6z2B9b4db/hWJN5vpRQh6c2rCjeNFIukPpxLcm
 tzHJmZ5KlBaB9KDSoZcji4vmm5GM2p2IZBFi42RJigMRLBnCF+Esj9nUuVmwq/Sx2/l/3s
 1C14QBshPqKbFmcCrLpP5Aqc1ZP4Se/k2TlGXS1pzgjAV8diZ8Qpo2rztOHD/nOjNHPKW+
 KqdrEnJYG/ECg1aDFRLtGvlI94nyrBx7zD0nO5u2oL/tzRWf70bQaUoX+0Ls4FFIeAEsYJ
 jpdhzUxwSd2GvLuqvjhXRxodtui/2eC3kAfbDYGwW/J/WbGzhZJVEmXrwMF1Aw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QyNvDOXC+xgEJHt+c9sCI7psHyHaivatsb314MXSm+Q=;
 b=cbWCXUXAaWJ+mqFBEnPQI4cRsKZ3q+QFzVZrYR3NF+Ezmz026/qKnMhuLRc8Xf5zFtnSdl
 8LFBUv7bx3GHzSsurt8+v81VExERWcc6GnJp33S7lG0oKDBkcWmuHVF24EqoMeg/Hl79T4
 pYRtF3mIaQCzd3gNPWBT1Zc7V+5YL7LAT74iFHug2iChKVNKwIDu7WenaGZWeNRVQkq6jf
 GP26OON91pWOHdzwrZchxk4+eBCQJx/n9kBcZMOWK3T/iXIclqj8iJBy1ghSuFrhYwns9o
 qz4ERoRQAhgRZawkSRn4XLM6vRdQi6c8n3kjiBjWLX4xpG4odIMGIaFrGyf2UA==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 32/35] sysreset: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:12 +0200
Message-Id: <20230906213015.203437-33-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cquid56d4c9b71o1d3guaue16qj4uwu7
X-MBO-RS-ID: 1e497cc474f773d3f84
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/sysreset/sysreset-uclass.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 279b087d16d..6151b5fe03e 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -158,23 +158,7 @@ int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 #endif
 
-static int sysreset_post_bind(struct udevice *dev)
-{
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	struct sysreset_ops *ops = sysreset_get_ops(dev);
-	static int reloc_done;
-
-	if (!reloc_done) {
-		if (ops->request)
-			ops->request += gd->reloc_off;
-		reloc_done++;
-	}
-#endif
-	return 0;
-}
-
 UCLASS_DRIVER(sysreset) = {
 	.id		= UCLASS_SYSRESET,
 	.name		= "sysreset",
-	.post_bind	= sysreset_post_bind,
 };
-- 
2.40.1

