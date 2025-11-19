Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03AECF58C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F85E83FDB;
	Wed, 19 Nov 2025 18:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ylLyooBD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B0BHNNj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD5684015; Wed, 19 Nov 2025 18:44:54 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3B558391B
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dBTQC4f0Cz9tB8;
 Wed, 19 Nov 2025 18:44:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763574291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lrkRdv24TtFJK5NYMT2qLGE0/BKCF3Gq8QAGNENW1Ws=;
 b=ylLyooBDATG4On9NpQwARxUlqItajqP8X2jGPqS+ZS36oU/uypll981DcxZa1KUcE3/Yw9
 QDlCQizGYyfOvo+o8XmghZK3ksu6AalDr7YwzfZPR3/BNva1Q62zHcXZACMSJliUKM73yw
 CdCeQ825V6V3aSfYowbQtfhoM7x+CitTrKvOVxqNuqHAEEYu5pfsZJ1DW6RTCFDpF1fIV9
 JecaZLgN013UzIPM85/oRdjVK3wHlOvzaLg0DKdD7RAPdDD0nImPxYcVKs56V16gJ+lxGJ
 YUfln6ueT8KiQue7MFGIkIrHURxIBs7S2Xm7Zxfzf66DqlPmgYncnKwcvtkbwA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763574289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lrkRdv24TtFJK5NYMT2qLGE0/BKCF3Gq8QAGNENW1Ws=;
 b=B0BHNNj2QulUb9m2ChAxLsk0CTFxTLBcMj9RkZz4WlvZVI+CjnAfPxHSytuMxOGoCTd077
 /TBkmkFIVP9xiax/8/SLGvSWBTiwfi7B+kB+pPgOVQherQLWbxla3gg6vWfruKavSgDrna
 KWpsAuv6WI2zHinPYxCzLtEJdhQFjmMajpiNigF0si1ZCJy7RwLiuG8ReCFsY2Fvz0S+H8
 FqcGkEmSHsM/7GJ898NIplly7GcZbrUbRecEOBKYkzFYl33MFJ4OXLuH7k/InLVlqU2Xyp
 BpaZ1PUeSOlqWRKU+sr0PIpXXKXaNayKIGjL3rDny+vPw1nRIhPLrsV7UZtOUw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] sh: Assure end of U-Boot is at 8-byte aligned offset
Date: Wed, 19 Nov 2025 18:44:36 +0100
Message-ID: <20251119174447.58640-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dcd8161ed06cb4b3cc8
X-MBO-RS-META: kw8xh75ha86mzuurf7x4kmh5ptjmy43b
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
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/sh/cpu/u-boot.lds | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/cpu/u-boot.lds b/arch/sh/cpu/u-boot.lds
index c31deecec65..81526f5bd23 100644
--- a/arch/sh/cpu/u-boot.lds
+++ b/arch/sh/cpu/u-boot.lds
@@ -72,6 +72,7 @@ SECTIONS
 
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	} >ram
 
 	PROVIDE (__init_end = .);
@@ -83,7 +84,7 @@ SECTIONS
 	.bss :
 	{
 		*(.bss)
-		. = ALIGN(4);
+		. = ALIGN(8);
 	} >ram
 	PROVIDE (bss_end = .);
 	PROVIDE (__bss_end = .);
-- 
2.51.0

