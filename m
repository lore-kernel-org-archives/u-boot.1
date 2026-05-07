Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57167CD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9207084C24;
	Fri,  8 May 2026 00:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r1kxM/7X";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vPTl2ecL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9BF84B86; Fri,  8 May 2026 00:07:06 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B53984C18
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBRDj52bXz9vZp;
 Fri,  8 May 2026 00:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyC9jaH1RKRJ5Fag1AneLfL24PrmgPihchTuRHFZDxs=;
 b=r1kxM/7XzTYkCWVfJJp+cDWfRzsn9tumjCuPOHDaqLlxiizQSrwruG5YDYojKHOgB9ILNT
 q6bd/G9Pvc67euvJ/glywoqUWI+Vx35htX7jAK5FlitvJz+4R8a2Z0KfbKs4SybH4LhY7n
 9LloN2EzeUB7FJSBVfa8aM3PPnTCn/qPZh/BNBnmEUXQwTbOP1gbuoCmYAU1qa4ksLG76R
 O1Sn6H0un0wUVJKNLJUP3GD6ggOtC5IFgRQfefu/xMZ+udyBBmV/fQC61t0WxEQV7nouC/
 csd+jG2qIvaS/KkAbM64/c7RUi378KmuNMcSomYlF2GaPpQvSnM90r+zBMo3Pw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vPTl2ecL;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyC9jaH1RKRJ5Fag1AneLfL24PrmgPihchTuRHFZDxs=;
 b=vPTl2ecLgzZGubugT8iv873+3E7DDF94J7IkyqT1azsZCiregsk09Y3WefxzGRBAs65lXp
 c3G16AiDThu37Ou9c1hyD1carpsDKWj9Ltiogqaqm9Jxh4SDd0+vIHLEzz5r1xdOFJpSNn
 UwHcHRQU0o4aJUCelGlXTNakQ/KrmbTWqxIiY+v3Q4KBC8yQKEp+dnLZrP4/Cvv+R+OMwo
 RDYK9BftRZQNR+zb4w5fzLk/9GDrki/EN6Cdb0A60A/6M/tRZsBGPwCjIc5T7oxtYE9PSI
 +K4bhN4+w4NffCOVCXdivYO5KJxps1HdzGDy9SbfgKEqubUNF2ZS6lKyx7SX9w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] mailbox: sandbox: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:06:32 +0200
Message-ID: <20260507220651.209168-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
References: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: aae2207e858be610b77
X-MBO-RS-META: xbgbmqnpgghfqrep9j43kjfspn8rh4hw
X-Rspamd-Queue-Id: 4gBRDj52bXz9vZp
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/mailbox/sandbox-mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/sandbox-mbox.c b/drivers/mailbox/sandbox-mbox.c
index 87e06e492fe..d6ac758c4d8 100644
--- a/drivers/mailbox/sandbox-mbox.c
+++ b/drivers/mailbox/sandbox-mbox.c
@@ -86,7 +86,7 @@ static const struct udevice_id sandbox_mbox_ids[] = {
 	{ }
 };
 
-struct mbox_ops sandbox_mbox_mbox_ops = {
+static const struct mbox_ops sandbox_mbox_mbox_ops = {
 	.request = sandbox_mbox_request,
 	.rfree = sandbox_mbox_free,
 	.send = sandbox_mbox_send,
-- 
2.53.0

