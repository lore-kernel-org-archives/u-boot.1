Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79743CF45D7
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 23:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D6683759;
	Tue, 13 Jan 2026 00:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qczQdJJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 241C783942; Tue, 13 Jan 2026 00:58:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E978003E
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 00:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f435=7S=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1768262326;
 bh=I0mO+L1fdN19LJfdtJ8vGgJ/YaAE+besBceg+yhg0qk=;
 b=qczQdJJeQLT/vKYH46beP20wWvCUkHwKXq89yiiNWaQlSHwm9pjLyZ5qFbi/1/x2xHkxBsGOS
 /oDKLlbcRoBzEg4CwAlJ+zSJhQ9hpcD881Yr65UY6Bl1zGqu3aybq7NHyXDjsJRHNFVNbA73nMf
 7pt4t72jIMpuGGufPC5lJy1sZnD2ib9lcxQUFb5JJBJtWghE1MAv+svI9cELM4hMTIdCXaIgM5+
 FA7c4EZW0Z9LMY5/w7vO4IG1H48/r39Dv7zJgLHhqUEVsjN0kEV9XYWqH98YFql4a/MLjxByB1O
 aUXCFgl40pMo0YK+FAZP3YDs7vVhhxIvD1c+qGdaYqkA==
X-Forward-Email-ID: 69658ab3e6f5eea3667aac8b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] armv8: u-boot-spl.lds: Place binman symbols at end of binary
Date: Mon, 12 Jan 2026 23:58:29 +0000
Message-ID: <20260112235832.3043626-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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

It can be useful in xPL to access symbols from binman, such as the
offset/position and size of a binman entry.

Place these binman symbols together at the end of the xPL binary for
ARMv8, similar to ARM and RISC-V.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/cpu/armv8/u-boot-spl.lds | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index c4f83ec9cfc4..4c7252f942c9 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -54,6 +54,13 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	} >.sram
 
+	.binman_sym_table : {
+		. = ALIGN(8);
+		__binman_sym_start = .;
+		KEEP(*(SORT(.binman_sym*)));
+		__binman_sym_end = .;
+	} > .sram
+
 	. = ALIGN(8);
 	__image_copy_end = .;
 	_end = .;
-- 
2.52.0

