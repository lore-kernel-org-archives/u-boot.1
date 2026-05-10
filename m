Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE72ACD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 21:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45788846D1;
	Sun, 10 May 2026 23:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="PkfNt9IC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CE4846D2; Sun, 10 May 2026 23:29:11 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5902B846CB
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 23:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 777A1B00535;
 Sun, 10 May 2026 23:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778448549;
 bh=sHUKo7qGo9DdJ2/JiXTu/z4jAyu1MHmhF8rc3TwhVKI=;
 h=From:To:Cc:Subject:Date:From;
 b=PkfNt9IC5dvg1ETI6qnkghCdV4huUsAPIORiZLSr47W2gi81pLhKgwoIA463OiMD7
 +B1FqgskuM7Jv7K5l8qgD70GyWiNt6sxXGQqR9ISs4eST91vUYctYGqNAj6MbaS5RK
 68/M01zKII2BXGKtu8pVjMjIbOvFiuRiMaSCfeJw6MOLOnUpmyKAPTezoDEGlYA6mw
 P4OBoo9AoqOF8em7hRT3O5alITyv5Vns7mqBnvRXwZZPZS32Bu/S7VUkFjh6H6O/O4
 1gbNsQSaTPIbV3mrt46XrwLjHQEdo7WOvGMfCj+FQNoKkRP+BSiig+lf5hNij/2ueV
 c/4r4dqLKPkpg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Heiko Schocher <hs@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v1] gpio: uclass: show DT gpio-line-names
Date: Sun, 10 May 2026 23:28:18 +0200
Message-ID: <20260510212838.543179-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

gpio status -a does not have labels: the existing path walks
the per-bank requested label table.
Issue: The boards that populate the standard gpio-line-names
property in their device tree end up with anonymous entries,
which is not logic with the purpose of having those names in the DT.

No impact with boards that does not set gpio-line-names.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/gpio/gpio-uclass.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 7651d5360d6..4d40738e5aa 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -877,8 +877,19 @@ static int get_function(struct udevice *dev, int offset, bool skip_unused,
 		return -ENODEV;
 	if (offset < 0 || offset >= uc_priv->gpio_count)
 		return -EINVAL;
-	if (namep)
+	if (namep) {
 		*namep = uc_priv->name[offset];
+		/* Fall back to DT "gpio-line-names" for unrequested pins. */
+		if (CONFIG_IS_ENABLED(DM_GPIO_LOOKUP_LINE_NAME) &&
+		    (!*namep || !**namep)) {
+			const char *dt_name = NULL;
+
+			if (!dev_read_string_index(dev, "gpio-line-names",
+						   offset, &dt_name) &&
+			    dt_name && *dt_name)
+				*namep = dt_name;
+		}
+	}
 	if (skip_unused && !gpio_is_claimed(uc_priv, offset))
 		return GPIOF_UNUSED;
 	if (ops->get_function) {
-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/gpio-show-line-names
