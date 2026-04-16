Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B532F8A160
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 12:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79A78420C;
	Thu, 16 Apr 2026 14:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="DI9gQ5ti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B278E8421D; Thu, 16 Apr 2026 14:14:50 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A0CA84227
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1776341685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6TiHASRdDV4npufrOw1f/c0C8AZ/ZN6uHIJKhIF3Li4=;
 b=DI9gQ5tiPmpcYjXXwB9YKNMaLkgTyY/KggS+/AgwTzkfmh4Re4lS0Q2Gsrc+5QDki8opu2
 9OzEGFyisVZ6CgGTL2MGCI1hH22myL+rMWmO6y/5J2GCvf4fCPhuSRT/Dcxg6qkaokARGH
 fKKdFEHP1r9CWTXaYJV0qG9lpiGjXVo=
Received: from archlinux (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 505cfa7f
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 16 Apr 2026 12:14:45 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, u-boot@lists.denx.de, sjg@chromium.org,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 9/9] m68k: set proper u-boot image size for initial boot
Date: Thu, 16 Apr 2026 14:14:31 +0200
Message-ID: <20260416121431.20852-9-angelo@kernel-space.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416121431.20852-1-angelo@kernel-space.org>
References: <20260416121431.20852-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There is a value of 256K hardcoded as u-boot image size. This
produce bank tty as soon as the image size grows over the limit.
Fix it by using value preset by CONFIG_SYS_MONITOR_LEN.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/cpu/mcf5445x/start.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/cpu/mcf5445x/start.S b/arch/m68k/cpu/mcf5445x/start.S
index f0264671d38..ae0e7c35d87 100644
--- a/arch/m68k/cpu/mcf5445x/start.S
+++ b/arch/m68k/cpu/mcf5445x/start.S
@@ -114,7 +114,7 @@ vector192_255:
 	/* Image header: chksum 4 bytes, len 4 bytes, img dest 4 bytes */
 asm_sbf_img_hdr:
 	.long	0x00000000		/* checksum, not yet implemented */
-	.long	0x00040000		/* image length */
+	.long	CONFIG_SYS_MONITOR_LEN	/* image length */
 	.long	CONFIG_TEXT_BASE	/* image to be relocated at */
 
 asm_dram_init:
@@ -292,7 +292,6 @@ asm_dspi_rd_status:
 	move.b	(%a3), %d1
 	rts
 #endif /* CONFIG_CF_SBF */
-
 #ifdef CONFIG_SYS_NAND_BOOT
 	/* copy 4 boot pages to dram as soon as possible */
 	/* each page is 996 bytes (1056 total with 60 ECC bytes */
-- 
2.53.0

