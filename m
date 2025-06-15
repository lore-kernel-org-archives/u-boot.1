Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088CCC61CE8
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 10:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD95082CA8;
	Sun, 15 Jun 2025 12:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pQxVXwQL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Geoicd/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE5682B00; Sun, 15 Jun 2025 12:51:27 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F9582C79
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 12:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bKqgd1pDFz9svQ;
 Sun, 15 Jun 2025 12:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sL1JnXoKOvO0fzpXxXmc8Sc5r2MDlicgn20ErQ4oUDc=;
 b=pQxVXwQLksjIZk+mlyoiYsvKMAzRoUQFPyLG3FrYQoeXLjM0UdWfrTXeLExMRtu3hFiPOs
 db+zJfC7IxQwRXOvhIF+cXad+cY2C9kyiCttevDTjKjt21tKbcICmOvNHmvA0bYzeadGGd
 YAchbAt4XOEQSLa5QU7EUF48yerGd55OIRmhB8o43a2PTYY/VnY+vIRLm5fPXSHjHTfkim
 JHkjnxm48ga79h9Wx4rMj17tEmI49/SGRWykt1Yd2qVEW+B9mTz6kIShiqGaMLMwwplgzR
 00VEMciqk6Eo+ZZt9PrHDMkrFs5OB/eEfuUpLjlegxj3N9cQU+jnmS5zaqyyLw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sL1JnXoKOvO0fzpXxXmc8Sc5r2MDlicgn20ErQ4oUDc=;
 b=Geoicd/cntnCsp1siqtCir6/NfQprtmEY/AsZiIxPshFrfCnrRfKRoUirSa6tQr9eUkFzt
 nZ+2R92ZWqSmLuMYq84NhPfSVDkKtve5i95trGlH8zixXq50tpZWYm9NUm4WIOzGHn4XOn
 iStoRo0tT0+qI9qeIzuaUSQuG/1DdjglD91DcpOhvYAS2AKBltIvWOwc9hvVNEC4RXKmvF
 OZMAZggLROW6YGLxy0yaPmerW7bEnPDIK+89BDx2NKO1/mqizn330c9tCJKkQdHjA9nxN6
 HBZX+wNQypsxkd5W3/zP+EvSYFFpug7vAn6l3zD6n6c5EDUs4LopKFRjinUDrw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: renesas: Add Renesas R-Car Gen4 SCIF/HSCIF loader
 SREC generation
Date: Sun, 15 Jun 2025 12:51:08 +0200
Message-ID: <20250615105112.15330-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250615105112.15330-1-marek.vasut+renesas@mailbox.org>
References: <20250615105112.15330-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: aca35f29ed808d8b22e
X-MBO-RS-META: ozcmjh3wzto69nki6jwywfeq519rtsxc
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

Add Renesas R-Car Gen4 SCIF/HSCIF loader compatible SREC generation.
This is a regular U-Boot SPL SREC augmented with a short header which
describes where to store the received data and how much data to store.
This header is interpreted by the R-Car Gen4 BootROM SCIF/HSCIF loader.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Makefile | 10 ++++++++++
 common/spl/Kconfig             |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-renesas/Makefile b/arch/arm/mach-renesas/Makefile
index 3409437d75a..9165ceab4a3 100644
--- a/arch/arm/mach-renesas/Makefile
+++ b/arch/arm/mach-renesas/Makefile
@@ -34,6 +34,15 @@ else
 	srec_cat_le_cmd := "-l-e-constant"
 endif
 
+ifneq ($(CONFIG_RCAR_GEN4),)
+quiet_cmd_srec_cat = SRECCAT $@
+      cmd_srec_cat = srec_cat -output $@ -M 8 $< -M 8 \
+			-Output_Block_Size 16 \
+			-generate 0xeb203000 0xeb203154 $(srec_cat_le_cmd) 0x0 4 \
+			-generate 0xeb203154 0xeb203158 $(srec_cat_le_cmd) $(CONFIG_SPL_TEXT_BASE) 4 \
+			-generate 0xeb203158 0xeb203264 $(srec_cat_le_cmd) 0x0 4 \
+			-generate 0xeb203264 0xeb203268 $(srec_cat_le_cmd) $$(( ( $2 + 4 ) / 4 )) 4
+else
 ifneq ($(CONFIG_R8A774C0)$(CONFIG_R8A77990)$(CONFIG_R8A77995),)
 #
 # The first 6 generate statements generate the R-Car Gen3 SCIF loader header.
@@ -90,6 +99,7 @@ quiet_cmd_srec_cat = SRECCAT $@
 			-generate 0xe6301154 0xe6301158 $(srec_cat_le_cmd) $(CONFIG_SPL_TEXT_BASE) 4 \
 			-generate 0xe6301264 0xe6301268 $(srec_cat_le_cmd) $2 4
 endif
+endif
 
 spl/u-boot-spl.scif: spl/u-boot-spl.srec spl/u-boot-spl.bin
 	$(call cmd,srec_cat,$(shell wc -c spl/u-boot-spl.bin | awk '{printf("0x%08x\n",$$1)}'))
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 880192043c4..afa4fca7d0d 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1598,7 +1598,7 @@ config SPL_OPENSBI_SCRATCH_OPTIONS
 config SPL_TARGET
 	string "Addtional build targets for 'make'"
 	default "spl/u-boot-spl.srec" if RCAR_GEN2
-	default "spl/u-boot-spl.scif" if RCAR_GEN3
+	default "spl/u-boot-spl.scif" if RCAR_64
 	default ""
 	help
 	  On some platforms we need to have 'make' run additional build target
-- 
2.47.2

