Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D532E64018
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 10:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD7B8394E;
	Sun,  5 Apr 2026 12:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="grBo/zfz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E62884101; Sun,  5 Apr 2026 12:49:39 +0200 (CEST)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59656840AB
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 12:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775386176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgCxefpAADFmaBf7yKs9CrXigRVeVam7xmJB6EPnUk8=;
 b=grBo/zfz4FnLHKiksDdNKjFkfw3M/qYdMIAGmDQiwfwHTJkNPmq3z2HY1HjAGpZZha5IHg
 wmflY1al842diFHKmFCBKqwmPatWw4xjCVO8nFwHkA+qGRt242PQnfuwXHUxV/fTJ9u3j0
 HQydzlyQu0RGNAh8rlnZQcxo4SahX5d2cpNQhWizm53D7F+M9efkcUNvayLfhS4I4Z6eaj
 XI8MVClC86dp5WdnyLQwq2an4GZtASoG2zqelZunkvnw4vRI0kDxHkcgz8In+d5puERQMT
 jiSKq4iD8NC/mSE1VJCkesN+6Ho8Bel9h3/GiLfNMCYY6k/kuUD7yIkkKM7wEA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sun, 05 Apr 2026 10:49:05 +0000
Subject: [PATCH 2/2] cmd: bootmenu: ANSI_CLEAR_LINE before entry name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-ui-cosmetics-v1-2-bffec3cac741@postmarketos.org>
References: <20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org>
In-Reply-To: <20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=664;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=ZO2JsmAmqHbIkWnJKKXuw+gTS8UrXS09vWJIeC+Yg2M=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp0j45+4VHi02sUW1gxoPvxWix/p458LPM49hWP
 Vcr6cbTckGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCadI+OQAKCRCEr8vQ14ma
 A5O+D/9FdX1qKfOoc2qZ0EoMLNeu9KUva1RAL756BuxEmbnrFjgi+w0nw3G6KK4bKJsp4xGQE6d
 PrMIxPloBvjOtipM4WK6+VNrUdO7zGlvbFulligxZ2XTAD298DeuIxuDGyTt3G6I7/k0w+sZnjH
 Ay+JyqK2csA0jfxNnANSd9cec1zE00Wb0SJK5Cs+kd5BWI5dy0ICabvNCFMbf0N7uK+s39ZDdcH
 TAQbzJNFDosWDfuS+1J+JBb4ULxjioBn0DFTvMq/glS5klEVKgu7mZWXoO7LkGkR1HGdRL8h3JA
 BVzi8TSVHFc8A8MsuI5hT1FhmOe/WeNNdwecmP5V9mALaCMqfNritbDbZRRGfMltT/164Kc0SCG
 3PGbdSowMNPcKEe0ZhHZj7UmJwUEAULZx7eQ0DuwBCa7FAwqCiISoKcO0mY17WxQFgFjny1RLgD
 HJxoXO2OKCKqXRA3H9LmtLHudogXy846fsNO9rPJ8PL/1aRm27XP/xUu4K3+3+nYKTh7gl0Yg5o
 fPxGFkOoZZ75KqONQTyHPwC/vCHZqzxw+87QMYy2qNVabNyWHY4Y2YR+TU8Vtgc5BSyARzXcPZH
 y2Mm+BVgVh5ndqgF2jqqoFg8IwpDg5LNvTPGm6i7HRt0QXJJNk5r+2e48zqrhFd6gWF+nUO108Y
 rtkXPshLKfmtE0w==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

This has the effect of highlighting the whole entry when it is selected
(on vidconsole), which makes it consistent with eficonfig too.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 cmd/bootmenu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index d3108778c6f..a07fea49322 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -76,7 +76,7 @@ static void bootmenu_print_entry(void *data)
 	if (reverse)
 		puts(ANSI_COLOR_REVERSE);
 
-	printf("%s", entry->title);
+	printf(ANSI_CLEAR_LINE "%s", entry->title);
 
 	if (reverse)
 		puts(ANSI_COLOR_RESET);

-- 
2.53.0

