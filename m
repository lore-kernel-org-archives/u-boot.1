Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8EBCFC29B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8725E83AAE;
	Fri, 21 Nov 2025 18:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="SDkIV+bG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31DBF83A5A; Fri, 21 Nov 2025 18:37:42 +0100 (CET)
Received: from mx-relay149-hz1.antispameurope.com
 (mx-relay149-hz1.antispameurope.com [94.100.133.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E82D839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413a1ceba=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate149-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=BTm7wVu989MVwPx+uLZGTNIafBEVOIMtkTZzNk39bCw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763746659;
 b=ASNzfCUa2kkqjc7nDyM3E9XqgL+6Q0KBR8lhv6jysXETg5/OqBUd87xdxedGgMrfv0UtWB9/
 nnnfbcfFTim7candE0nWU8P1e+91hScjE0fllLhxIUahNJ5csnAGWqiOltFv6EUk5VTH+l6UgOM
 LBSrOqtCi4w+ebA7nF5exl6thorWbpUEA2yIGwmFZY9o4C87qHo7N1vnJkTKzt94JVisFXrRV6i
 FeePOXuLGwrsorBYHes61jAxtkIhGxvar+CuxZRV/fmcBbtAolV+rZlF7ErlC7gf3H1ZTdQxAk3
 Q7f3kuRDEZHsxfCOjvTGGbOyrIPu5lAposFPpH/iYA7eg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763746659;
 b=CgtosVD2Mu/9VG/xEXERZxurEbWkajLQywUu9bh6Uclu0TaLR3p0XrwrioYjXxNQBWFtP6PA
 K20toabhDrogXQbg+TVuoAUZW9iFD0LQPe5jx1EGSlw/IdJhoPJLhiusC9Gz+G4EbRasJVuPYqz
 iAlEJ2L+qhIIi1RvxGknhHi6tPpKC4I/6XbEfFewgb1vyoCnA6nA6/7frXlVOUl5HAI/PgSEstw
 8V215h+RDyCsA79MuS4o3oPGf4xJOxeJDvB4XcXu0cJNB8/tN1xWKuS6aZFDYXYkoBNhj0kmVRw
 H4xR4/4FEjeI8h3isiLp8WmxHt5vWV2su8Hzw+T9eejAA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay149-hz1.antispameurope.com; Fri, 21 Nov 2025 18:37:39 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id D9915A4075A;
 Fri, 21 Nov 2025 18:37:20 +0100 (CET)
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Markus Niebel <Markus.Niebel@tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 5/8] net: fec_mxc: rewrite fallback MDIO Bus allocation
Date: Fri, 21 Nov 2025 18:34:45 +0100
Message-Id: <20251121173505.6235-6-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251121173505.6235-2-Alexander.Feilke@ew.tq-group.com>
References: <20251121173505.6235-2-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay149-hz1.antispameurope.com with 4dCj8d3j78z18PWj
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 05bbf495a03f5542f1634dcdfb3e2b09
X-cloud-security: scantime:2.093
DKIM-Signature: a=rsa-sha256;
 bh=BTm7wVu989MVwPx+uLZGTNIafBEVOIMtkTZzNk39bCw=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763746659; v=1;
 b=SDkIV+bGJViRnUDMwE9pKa33idsR1M22l6V5dOoX+rgIhCYcyjlmzE0zo9/oRu4WFTgavAQ+
 isCgPmE91dGUVIotZU1/FTLaoVQ9TgP1QnT7maeZz0JnXUVl7uMt0rqJ838AWNLem3uS4v51TOb
 9uB/+PEdVUSh376IurVqCbFZopYatH1zw8FTn7oOn/TjMpAAu78XrPalPZ6gHcqByxvrkeCn0cf
 LqaM5tN8SE0JyEjdY6RrGfXG82VfRH0HycJKM51h6Co3/5bZuwYBY8gX4JlUhwtvsgopr5T7itN
 MaIC0aKTqa+j5xPvIj5U+jjX1/ZS9yw91Nl3juivPSwLQ==
X-Mailman-Approved-At: Fri, 21 Nov 2025 18:48:51 +0100
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The code should only be executed if MDIO bus is not assigned.
Otherwise the already assigned / allocated bus will be overwritten.
Add condition check and simplify the code to make it more readable.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/net/fec_mxc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 69a76e879b1..7d1567fd88d 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1373,14 +1373,18 @@ static int fecmxc_probe(struct udevice *dev)
 	if (!bus)
 		bus = fec_get_miibus(dev, (ulong)priv->eth, dev_seq(dev));
 #else
+	if (!bus) {
+		ulong regs = (ulong)priv->eth;
 
-	dm_mii_bus = false;
-#ifdef CONFIG_FEC_MXC_MDIO_BASE
-	bus = fec_get_miibus(dev, (ulong)CONFIG_FEC_MXC_MDIO_BASE, dev_seq(dev));
-#else
-	bus = fec_get_miibus(dev, (ulong)priv->eth, dev_seq(dev));
+		dm_mii_bus = false;
+
+#if defined(CONFIG_FEC_MXC_MDIO_BASE)
+		regs = CONFIG_FEC_MXC_MDIO_BASE
 #endif
 
+		bus = fec_get_miibus(dev, regs, dev_seq(dev));
+	}
+
 #endif /* CONFIG_DM_ETH_PHY */
 	if (!bus) {
 		ret = -ENOMEM;
-- 
2.34.1

