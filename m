Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04C1D3EE9D
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 17:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378AF8397D;
	Thu, 22 Jan 2026 18:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wMPRXANm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC5D2839DF; Thu, 22 Jan 2026 18:21:16 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B45680077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 18:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=66eb=74=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1769102472;
 bh=UULmg3aJXtgX9UlbVG16hB/PEVwhCHy09998xKvjrYU=;
 b=wMPRXANmFk3lmNTnuV9AaRZN+3towiGPlwJpipDxjAAFzorq7J62NXZUiiXag4nY9KQ6eWLgy
 5bZ4Z44QKexX0FnH2JIK5Vin46/RvKcf1ciNqjOLEO9FQuMQ+1GYwIQ6cUA1FbwiXz459zTirQm
 egVkV0QJMUlglaNKkJWsbvMxxbd15SKTkdpl55DDFjqaCS1Fs28eTycIejlBxEzBhUrgO3Z/rkD
 5DiAn8vhFglVPTTnsdalNi2lgWRa3elPY6AwQGinMJIOGlaHq7Uo4m3tGHXW+w5d9Cllo70Zes6
 XgqKPobatwalLzc/gjdeprLjgtAzd6F1iBuv3f2QDU2A==
X-Forward-Email-ID: 69725c822b5b170a2cf995d9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH v2] armv8: u-boot-spl.lds: Place binman symbols at end of
 binary
Date: Thu, 22 Jan 2026 17:20:54 +0000
Message-ID: <20260122172057.3212673-1-jonas@kwiboo.se>
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
v2: Rebase on master after "arm: Update linker scripts to ensure
    appended device tree is aligned".
---
 arch/arm/cpu/armv8/u-boot-spl.lds | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index d9963846c4f4..b732133ce76d 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -55,6 +55,14 @@ SECTIONS
 		. = ALIGN(8);
 	} >.sram
 
+	.binman_sym_table : {
+		. = ALIGN(8);
+		__binman_sym_start = .;
+		KEEP(*(SORT(.binman_sym*)));
+		__binman_sym_end = .;
+		. = ALIGN(8);
+	} > .sram
+
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
-- 
2.52.0

