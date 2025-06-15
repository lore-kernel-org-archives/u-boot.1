Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE94C71150
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 10:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620AD82C79;
	Sun, 15 Jun 2025 12:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="akCV3YzV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ao7yTyVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1B882CA0; Sun, 15 Jun 2025 12:51:26 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1EB82B00
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 12:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bKqgc27D8z9smP;
 Sun, 15 Jun 2025 12:51:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IkCxAYJyD8x7G63bcN/YX+SQ1/vD8OYv46HhkxYizbI=;
 b=akCV3YzVVBVksJxYGny7zqM4GqxRhiEEXaDPMRQALnPkOvewXmEPl2S24avYdsEop1LSNR
 X4wKAI3Uzwb9nMo4+XBokT0EfD95iU6JpVPMihxgdDiM5mDJ0Y81lFzYlKAWdNAE4EU66A
 yLptiqMBQOtxmlDNYprS5XStiWjUC+NyosdB26uJ1Jxp8c1tHdjBG8iDLiOGIIgnjPui7m
 21tpV4SMOehiVaYG8pc5l8tJhijTC/9XvVW+ZwnNFLj+Dq9epKFA0IHuyhGOi6AkFp1VrK
 qbJ1YMcZ3L/H5B1PH+8jLoCpkE3dQ/lkq8xjy2w0l73skDEvjVd+bUE1SE8pSw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IkCxAYJyD8x7G63bcN/YX+SQ1/vD8OYv46HhkxYizbI=;
 b=Ao7yTyVzLcBMz0QRUbRpIj9/PPChvH4//FK1cPS59VKtQuoSPZfcrGS3Xmf6nz0+oxFyem
 1BAWu+XbDxbIe9PrBa835Th2H7VdN1MtGWJoIGNCA5IseIaa7bPO5ZFN4ldNhkLG8E0BT5
 YBV1NBMiUj4sukfvv3D7nD2/05rJz5HFdLmsHdQ49jLrS2W+WLt5aRZBowxwe+cZjF1Ka2
 7QGqHkMqOzobcfJRsC8j3QPCDqDi88hAYVV0WQzmJ6Euu/i9dtmv9JdGM1xudP00K16nhS
 P/SUmZ1+OcLA32nH8eW/HCgUoNK6hHa2l02qGjdKnWALViyH5n2AOgxXRp8Fkw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: renesas: Convert SCIF SREC from u-boot-spl.bin
Date: Sun, 15 Jun 2025 12:51:07 +0200
Message-ID: <20250615105112.15330-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: r4a6wfq8t5cf7qffehmpx5rioyuixkx4
X-MBO-RS-ID: 10988052e0acde55d2d
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

Convert u-boot-spl.bin instead of u-boot-spl ELF into SCIF loader
compatible SREC. The u-boot-spl.bin includes SPL DT, while the ELF
does not, which leads to failure to start SPL via SCIF loader due
to missing SPL DT. Fix this by using u-boot-spl.bin which includes
the DT.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-renesas/Makefile b/arch/arm/mach-renesas/Makefile
index 317fce02d2b..3409437d75a 100644
--- a/arch/arm/mach-renesas/Makefile
+++ b/arch/arm/mach-renesas/Makefile
@@ -19,12 +19,12 @@ ifneq ($(CONFIG_RCAR_64),)
 obj-$(CONFIG_ARMV8_PSCI) += psci-rcar64.o
 endif
 
-OBJCOPYFLAGS_u-boot-spl.srec := -O srec
+OBJCOPYFLAGS_u-boot-spl.srec := -I binary -O srec --change-addresses=$(CONFIG_SPL_TEXT_BASE)
 quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) --gap-fill=0x00 $(OBJCOPYFLAGS) \
 	$(OBJCOPYFLAGS_$(@F)) $< $@
 
-spl/u-boot-spl.srec: spl/u-boot-spl FORCE
+spl/u-boot-spl.srec: spl/u-boot-spl.bin FORCE
 	$(call if_changed,objcopy)
 
 srec_cat_gte_160 := ${shell expr `srec_cat -VERSION | grep ^srec_cat | sed 's/^.* //g' | cut -f1-2 -d.` \>= "1.60"}
-- 
2.47.2

