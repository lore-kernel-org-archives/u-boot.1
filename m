Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9336FEE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E29C4869F0;
	Wed,  6 Sep 2023 23:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LreFqvwJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vd2IUcCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C13869F4; Wed,  6 Sep 2023 23:30:48 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1E8868BC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXP6d61z9t0P;
 Wed,  6 Sep 2023 23:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OR82C+bBds4oCAeIJ1gg5XiN13E5oJYbR829FPLtBU=;
 b=LreFqvwJiiIjroujijiNBWuSq1C9MQC1PoSu5p4jKLivzkAV/7XYMxIRvgCsUBUvMvIkQN
 1R8yF9Bvb8zcptxu5I7NKtppSTpmwEnQGfgsuS0yJJI62ExKcxbhxHEWUdgssjBDuleJQq
 dhZu3gNrhefPqsKGGdEzlofK6CkQRbZUFBDBG5JjKhyzN5k8JoUYfHwIp8sNoB+MQNsfcJ
 8HksgLUre3WO5cD9x5kQi3l4992JwjqJVct8xEZSE0m5RN0cDFtfy2PjMR+6rpxw5KaRWj
 zI+G+4F3+crPryZg+2cxUV3FY0lzqCyJ/NgP6Z6uqm335E9rZg0xQHj8D/GJhQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OR82C+bBds4oCAeIJ1gg5XiN13E5oJYbR829FPLtBU=;
 b=Vd2IUcCKbvl2I2ruGeDLbR65ivrlqlLi8Wn/xZIilbfPHcgSrxYP9k90KGv4d+sP8bMwGh
 UMoGIXcnM9fivpFrydhXlOMXSL23ZG6BdkHS4J24fVuh1Tk1SuJEw27gl5Gp2B8ird9mQf
 7IxZVMWlSCKoqi/tohfvs6lxOZpksB2ukEMCTmQUtysb+CJkAF6j5NV3toGwimOakN/kpp
 EezaXeheAEW0OPCoDm/vCZnttLExxAMv5c/86Y01vqDnOc0z/nlshWnMITR8b+FeW+ZzTd
 tIS0OPm80SopCQXc9ua4rq7rN+JIQW1RW/qsXBzxh3U3wH0QP3xzbmAO1piwkA==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 09/35] common: stdio: Remove unused NEEDS_MANUAL_RELOC code
 bits
Date: Wed,  6 Sep 2023 23:29:49 +0200
Message-Id: <20230906213015.203437-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 11cebdd43d958d5421f
X-MBO-RS-META: cs6yqhfessygtqfmy57zh5416g1ddsh9
X-Rspamd-Queue-Id: 4RgwXP6d61z9t0P
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
 common/stdio.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/common/stdio.c b/common/stdio.c
index 894cbd3fb44..010bf576af0 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -293,18 +293,6 @@ int stdio_deregister_dev(struct stdio_dev *dev, int force)
 
 int stdio_init_tables(void)
 {
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	/* already relocated for current ARM implementation */
-	ulong relocation_offset = gd->reloc_off;
-	int i;
-
-	/* relocate device name pointers */
-	for (i = 0; i < (sizeof (stdio_names) / sizeof (char *)); ++i) {
-		stdio_names[i] = (char *) (((ulong) stdio_names[i]) +
-						relocation_offset);
-	}
-#endif /* CONFIG_NEEDS_MANUAL_RELOC */
-
 	/* Initialize the list */
 	INIT_LIST_HEAD(&devs.list);
 
-- 
2.40.1

