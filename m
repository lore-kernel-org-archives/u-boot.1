Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142C2E9271B
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 03:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF908397D;
	Sun, 28 Dec 2025 04:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gWWw1vWS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AGLhNC0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071B38397D; Sun, 28 Dec 2025 04:18:02 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26838392C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 04:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4df4Kz3cj5z9shn;
 Sun, 28 Dec 2025 04:17:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766891879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QtMRjQlchEFGZ4g+sF/0MRcMIjYEG6srdnCWWMPVEIk=;
 b=gWWw1vWSVwYA+TfEGaSTn6BD1hDEYBehgPeHX5U/jeEAif+H51KQxr3/d9I0/TpFnNDDVh
 P0kVpJXcBKXZBZMBWddrPw8nE99RxwR5+8QYVk3PC39q9lx+AkUXPM/Rch9d4uk9Qyrv4w
 Svrn39wBjXL8+CC0Qa952Bw8CCo6OLg2e6PgKwYsYfJIgN3ZlPImvxX8aF8nYlbfsdQ6Kq
 19F1Phr/OYG/IVtpZiqn0+q3iDpg08dvhsF3CD55QwtD6zTm45vWAVuXQgvkZwwsI4jOEC
 z5+xwUM47DHoF8Qz7EjRiBFRCRVRks/ys1uBCRnSnEm92Np7XwYQcXLbTpSREQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=AGLhNC0P;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766891877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QtMRjQlchEFGZ4g+sF/0MRcMIjYEG6srdnCWWMPVEIk=;
 b=AGLhNC0PE072w1hoMjBpFalC2OSPaU4k0NPqShvMbnn4z9ZlFlnVRdyj8roSTctenO/UKr
 1D+xbladpAtFeIlDuE/iunSgIAwKxpUUAMHCD5oaPy23XPKSMm0egVlf/Y7CKZGeW9QCIB
 PmrwKyH2NAsZTvzOWgco8skOUHrYJBXFRTLkN/c+S58O2Jb7q2Km5uuQao1IrXktbTot5a
 pYWQUmJT5SY8BGwszgf2CIK7oe0PSEV1fsEhsofXNBvtqdKJlPWyMjjbXplnZQsKSqXLDZ
 LAsXTs92GZpNvuomJVjTlix8jWuFWeQqGmt6pBw2X/9ADi4LRfBSX9/RW6jZJg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Huan Wang <alison.wang@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] m68k: Assure end of U-Boot is at 8-byte aligned offset
Date: Sun, 28 Dec 2025 04:17:27 +0100
Message-ID: <20251228031753.662212-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 38fzhnhk3nd6dzhjaur5demmrb9e9myb
X-MBO-RS-ID: 714dabb47bdcc58e7a8
X-Rspamd-Queue-Id: 4df4Kz3cj5z9shn
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

Make sure the end of U-Boot is at 8-byte aligned offset, not 4-byte
aligned offset. This allows safely appending DT at the end of U-Boot
with the guarantee that the DT will be at 8-byte aligned offset. This
8-byte alignment is now checked by newer libfdt 1.7.2 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Huan Wang <alison.wang@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/m68k/cpu/u-boot.lds | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/cpu/u-boot.lds b/arch/m68k/cpu/u-boot.lds
index 03d427cd36c..be1ad0170af 100644
--- a/arch/m68k/cpu/u-boot.lds
+++ b/arch/m68k/cpu/u-boot.lds
@@ -69,27 +69,28 @@ SECTIONS
 	__ex_table : { *(__ex_table) }
 	__stop___ex_table = .;
 
-	. = ALIGN(4);
+	. = ALIGN(8);
 	__init_begin = .;
 	.text.init : { *(.text.init) }
 	.data.init : { *(.data.init) }
-	. = ALIGN(4);
+	. = ALIGN(8);
 	__init_end = .;
 
-	. = ALIGN(4);
+	. = ALIGN(8);
 	__rel_dyn_start = .;
 	.rela.dyn : {
 		*(.rela.dyn)
 	}
 	__rel_dyn_end = .;
 
-	. = ALIGN(4);
+	. = ALIGN(8);
 	__dyn_sym_start = .;
 	.dynsym : {
 		*(.dynsym)
 	}
 	__dyn_sym_end = .;
 
+	. = ALIGN(8);
 	_end = .;
 
 	__bss_start = .;
@@ -99,7 +100,7 @@ SECTIONS
 		*(.bss*)
 		*(.sbss*)
 		*(COMMON)
-		. = ALIGN(4);
+		. = ALIGN(8);
 		_ebss = .;
 	}
 	__bss_end = . ;
-- 
2.51.0

