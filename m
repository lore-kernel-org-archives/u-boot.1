Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD6110F995A
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C2383F98;
	Wed,  8 Apr 2026 18:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="kDPtwICd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B303384142; Wed,  8 Apr 2026 18:35:31 +0200 (CEST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F3F83D8A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775666129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgCxefpAADFmaBf7yKs9CrXigRVeVam7xmJB6EPnUk8=;
 b=kDPtwICdIR6Cqfs6wnnCq4hgw6r0cYcZMKfH/Pfp4IVhYY+xJNGALaELBMRE12AdjOpE2G
 UOOlYKgb/8b3U4gP39FLKbnFOlOhkoOM1vM1ZflH8wlDNlJZ4A4WcHZNteB+ZXCiLWf/GA
 nIwKhsm4hFLbvOFdZ+NmcdxPFQbqWSzCXwSKPFj4grkMyvWNuFCrE8putGmc87opVK3N67
 vPnvAuLfgYv3bC6ohnEJHrH1L09j1EnAeAcYucLFm1J+17UEbntKwNgV4+NSUTYsR11/MP
 S4NaX7B+KaMM5dwVsaLkphx8i0BZ6sJAfN8oX8KSs4LCx2+wnmfMrB5i6MtG5Q==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Apr 2026 16:34:57 +0000
Subject: [PATCH v2 2/2] cmd: bootmenu: ANSI_CLEAR_LINE before entry name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-ui-cosmetics-v2-2-721dc6d2116a@postmarketos.org>
References: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
In-Reply-To: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
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
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1oPMenyXqQT31OM3eAK/0vhsrS/AwcmwQH2nc
 w6QRJJV6J+JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCadaDzAAKCRCEr8vQ14ma
 A57LD/9qjzSHkEAb4everDev3yToMxOGkZtigkaJsSQ62W4dKoITLE8qrFkJbi8NpTrIww8Wz0o
 gsoUGzhdHgd/pH8EqUiCfgUTiH4EqQCS+z5lSlHNSLnsh2xOy5tFSWtZC8tZ3w7m3SlqmVhUdyO
 c/WQel7aiIuF0LOJ+O3zlY0460zVw7bNKS9N9kyx8wx8EmaDP5v9oKW9hJ6HWJLKD/mLBHYIJk9
 U3OLHZDkOqcbno+YhAz6BZJ93IQBgQATwSiIxKSnV36Y3iCYc8Mgzo3tRdtQBRzMjnX8X9eZDgB
 aMyHru9StEw2kz+rXdLVhEAvQjLZ7Oe8NdarKxZnCEfAj5vQZWa7tbaIzeIdQ2hMKfQaGb5+2E0
 ah4McpOj1e3RP6cpasp5RqdbQha3xUSgh/PqP2xHyUV4VVrd4cUNubSjK9yECkjJJ79IGqeIv3n
 8E+01q9Yz/rCXvOFZcmSdsdYb5xp/AKik1QFBxT5mLkECRQtI5h+FJmZfT3t64qO7xrxUpzsgeR
 aQSQMYpGoPNv6ChM6k0QlQFTlfx92fQ0IbRhPHLzMOm01bR7aGoEgn7BpGOQBYCOfbksscuh+RC
 xgj0z0SxYWiz/ECKd2KYWDBbJsSMfM4Ye72nVSxKyLho0JUUsIDeAN5DLyNQst2x7WvccCzq02j
 Bp/PqEdT4GXAxNw==
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

