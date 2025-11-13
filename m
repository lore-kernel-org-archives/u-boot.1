Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2D4CD6E43
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 12:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03E683E5D;
	Thu, 13 Nov 2025 13:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DlkF98rU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h8nTo2Av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99D183E40; Thu, 13 Nov 2025 13:22:10 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D782283E48
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 13:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d6fXZ4Jftz9v6q;
 Thu, 13 Nov 2025 13:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763036526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbRIIlzFGxZBlneAtqgLQsQCsUs0uIZVqBF8IfjFmq0=;
 b=DlkF98rUyI2ccWC9EqQsCnT05GkUJsgCZycXFRxWd11/KXQCwYN08wI9ckxU4pcoBZsQFG
 eqRPqdAWPm0/s19uh+WEDB4IbRn906zUCNdkpA5KBgctg5vG1ho+oWWwfKOVMNABOexV7n
 39IYMBpRYLiDuv1iBMt+ZURAsYdueYzWJazMeu8UlIfK0UDn/Du5/MFtN2ETR1wVRJLAZb
 ydYbFaeWk7TlfO8sSeSP091MVfVAvzIMuwnZ1T6xVhnlFi2lHk4a+TIAI7hE/xY9teXYNE
 wSKsw5OlZ8SZSrY3copFw4FyKCklC2RS0XQRiYPEaQJoRDCiJhI5sJ5Fp09byg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=h8nTo2Av;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763036524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbRIIlzFGxZBlneAtqgLQsQCsUs0uIZVqBF8IfjFmq0=;
 b=h8nTo2AvyJk88pfrQYg/XhGMatzCsKRBca6jTR7b9+YqdumOSEkqexFWA6quqTUkVdESRj
 2Ai6NqzHbKWm9EvAkhrLXbOBFvIkO40xza8IBfIS2Q+VtVi14BFhlJCSO44c44P+1C3F8F
 NGI58Bp0RFFkujjKAuxNOET7LxFOF7nskUhCgvqw/3XZGkAATito5iCYJjimigkenshJEY
 Xzl38EeIiIVsk4WKgRg0s47NBY6QUAVriySwtmj5zrsSR+T+yDTZ1K12EWPKjGiWLX5mzI
 V70oiDZEBvny334ZQrX797itPzEr7n48YJru18pbnuOfOAupb8MRq9iDoWwKdA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] libfdt: Check fdt_offset_ptr() return value
 unconditionally
Date: Thu, 13 Nov 2025 13:21:10 +0100
Message-ID: <20251113122145.949112-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ecff9cdca45c56e34bb
X-MBO-RS-META: o1h1xjjin1fo57hnu9kis8ogjxfao3a5
X-Rspamd-Queue-Id: 4d6fXZ4Jftz9v6q
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

The fdt_offset_ptr() may return NULL pointer, check the return
value from fdt_offset_ptr() for NULL unconditionally to prevent
sandbox crashes.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 scripts/dtc/libfdt/fdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
index 95f644c31f9..d16cc3d4730 100644
--- a/scripts/dtc/libfdt/fdt.c
+++ b/scripts/dtc/libfdt/fdt.c
@@ -168,7 +168,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 
 	*nextoffset = -FDT_ERR_TRUNCATED;
 	tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
-	if (!can_assume(VALID_DTB) && !tagp)
+	if (!tagp)
 		return FDT_END; /* premature end */
 	tag = fdt32_to_cpu(*tagp);
 	offset += FDT_TAGSIZE;
@@ -186,7 +186,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 
 	case FDT_PROP:
 		lenp = fdt_offset_ptr(fdt, offset, sizeof(*lenp));
-		if (!can_assume(VALID_DTB) && !lenp)
+		if (!lenp)
 			return FDT_END; /* premature end */
 
 		len = fdt32_to_cpu(*lenp);
-- 
2.51.0

