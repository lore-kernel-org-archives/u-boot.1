Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0B7CD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A219E847C3;
	Sun, 10 May 2026 19:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="I/m9vrl7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uuH7MD2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4A9847C3; Sun, 10 May 2026 19:17:43 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14DE28470B
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gD8gT6kgLz9ts6;
 Sun, 10 May 2026 19:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTy6Y9Sm2ZqwepgvOYtV45LQTT5iyQ7DpraLDY2VDcI=;
 b=I/m9vrl7vVHwbiBiYssRrkIpmMLtHZjPPgNw1R/EsgcJZp0v0NFXzbMtJoNd54pTXlk+xA
 4N+46OkiLaVJTQvdshufVdpue0m90UHgPbNQCnjXXadvobcHIdiBIheGOPQet6jLA+YIOL
 D9PoifDS4ZRHXx+nefU1eDDNJeO+YfRrH77uqInEZag+CkYubLIu42OBonCd9VytoAbYOh
 +HM23wbm1n2VjeNz/QdLqVsoNsrINyZJaFyGIEyvMenLWikOM2vbW+lUE8KGUSZKuPG8fX
 jaqbCX89+CYrLVO2TnF7OTr3wbaEGH2Ase/9jHv86Uo8EIdapDLx0YN01i+S9g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTy6Y9Sm2ZqwepgvOYtV45LQTT5iyQ7DpraLDY2VDcI=;
 b=uuH7MD2tovRLEQnoM7p+JEdus1sgGeFRMFtxp7Kbmp8LLM8KMvoIXhxAOJ8+sIK3jzD2gV
 iye2wqVcYOfMSPlS9A+q/aBVGSREv3DiOZaBctVQA67YeQLXU6l7nNVTsFQVdKcxTw6Di8
 8DEqbe4ezRAc8AuNzCjbNT6/SHcH1jzXiFsejHF3jOoH89Ys30hHpTqnnnzHNRb0ylMfNq
 apSBD0pItc39iUw/8SeXAagJcu77kOZYYbe2qJYQb2zPvsZwzHlXn/pERmaLn3ggc4gUWW
 ayMdkLisvWOt5rCTRM5MovxquxHquN/87LdNWPCU16w3CDIHpSoYBUBFOZPg/Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/11] video: imx: ldb: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:17:03 +0200
Message-ID: <20260510171723.56866-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1xmsggk9mo59s9549k8whway1nce76wi
X-MBO-RS-ID: cd140d19e88b6b204fb
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
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/video/imx/ldb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/imx/ldb.c b/drivers/video/imx/ldb.c
index e918341c0a3..32a327647f8 100644
--- a/drivers/video/imx/ldb.c
+++ b/drivers/video/imx/ldb.c
@@ -230,7 +230,7 @@ dis_clk:
 	return ret;
 }
 
-struct video_bridge_ops imx_ldb_ops = {
+static const struct video_bridge_ops imx_ldb_ops = {
 	.attach = imx_ldb_attach,
 	.set_backlight	= imx_ldb_set_backlight,
 };
-- 
2.53.0

