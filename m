Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE32CD3445
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 23:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C74884BF6;
	Fri,  8 May 2026 01:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HquQN9tS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ahjz0h6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B67C84BF6; Fri,  8 May 2026 01:26:07 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A7D84B67
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 01:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBSzw1wGRz9tRh;
 Fri,  8 May 2026 01:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bvaOgMcdFvqnSGMeHdU2GW22j2gaeT6CCNZkAghnQcY=;
 b=HquQN9tSgktcumtZPon1+8HQI3PfAcrOkUQgrvr/D5QYbAfgwGklirmtT8pTkuMMMR8HsW
 9UeD8GKOvqMfkwCk+hHBlspjj1alOK1Gn3s/pb3+ZYOWqHmENOgVcTkDKy+Yh23uo17Aem
 4dWV4THrCbBlg/GuH01BrJj6uc8bbZInjbPGKDgr8wcVowKoYjzadMsUu0EMUnRlsCyCuF
 TI8/BJN2fXf6j6lrdIdtFqTCTMGdhIyu9RLXNaI/+rmSX2uvvoCH5C8gXFsY7+svp30yB9
 lKkNzn4Qb9CKUWvHAWl125guxNsBVKxatrvlAgpN26xeaytTGrBuIqsDMgSbqQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bvaOgMcdFvqnSGMeHdU2GW22j2gaeT6CCNZkAghnQcY=;
 b=ahjz0h6nxK3uWzQ55DduJjXXTR3sgn0qJLBuuhDZdgptJtM5VsWC0eh16v7KsY8WhJYwlY
 VYqlE49TYnDfbmP4ZVqixC7orK8L9IBtN2jZXYKJIj8FzqgDzufJkTL8F8aVYZNKrPicHb
 rrPYu2np9u/+3gD00r1FAsdFz9cOlNL6NCNLH4pIIU2uyAANcPw8Jpb/h5SO1ljICTcTJt
 a+sYR3RGhO16zW7moyYCxeC+4da+Q69x5J630LQ84xtOlM9Kzrt+rSuxEb5keqKYlLphUV
 QLlGHjnKjEWdUGI7nooaSaazHk+4vx0fUYqtVE8GAkAR83TuSfDkNTqrKDUq2w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm: renesas: Generate u-boot-elf.scif for R-Car Gen5 RSIP
Date: Fri,  8 May 2026 01:25:35 +0200
Message-ID: <20260507232558.304204-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 044e3f227125472bc56
X-MBO-RS-META: 1srns4dbah3dcu89ia8kkdtozqimiypw
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

Add target to generate u-boot-elf.scif for R-Car Gen5 Cortex-M33
RSIP core. The resulting .scif SREC file can be loaded using the
SCIF loader to start U-Boot on the RSIP core.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-renesas/Makefile b/arch/arm/mach-renesas/Makefile
index 652a392ba6f..e3133668e13 100644
--- a/arch/arm/mach-renesas/Makefile
+++ b/arch/arm/mach-renesas/Makefile
@@ -40,6 +40,13 @@ else
 	srec_cat_le_cmd := "-l-e-constant"
 endif
 
+ifneq ($(CONFIG_RCAR_GEN5),)
+quiet_cmd_srec_cat = SRECCAT $@
+      cmd_srec_cat = srec_cat -output $@ -M 8 $< -M 8 \
+			-Output_Block_Size 16 \
+			-generate 0x18402010 0x18402014 $(srec_cat_le_cmd) $(CONFIG_SYS_UBOOT_START) 4 \
+			-generate 0x18402014 0x18402018 $(srec_cat_le_cmd) 0x1ef000 4
+else
 ifneq ($(CONFIG_RCAR_GEN4),)
 quiet_cmd_srec_cat = SRECCAT $@
       cmd_srec_cat = srec_cat -output $@ -M 8 $< -M 8 \
@@ -106,10 +113,14 @@ quiet_cmd_srec_cat = SRECCAT $@
 			-generate 0xe6301264 0xe6301268 $(srec_cat_le_cmd) $2 4
 endif
 endif
+endif
 
 spl/u-boot-spl.scif: spl/u-boot-spl.srec spl/u-boot-spl.bin
 	$(call cmd,srec_cat,$(shell wc -c spl/u-boot-spl.bin | awk '{printf("0x%08x\n",$$1)}'))
 
+u-boot-elf.scif: u-boot-elf.srec u-boot.bin
+	$(call cmd,srec_cat,$(shell wc -c u-boot-dtb.bin | awk '{printf("0x%08x\n",$$1)}'))
+
 # if srec_cat is present build u-boot-spl.scif by default
 has_srec_cat = $(call try-run,srec_cat -VERSion,y,n)
 INPUTS-$(has_srec_cat) += u-boot-spl.scif
-- 
2.53.0

