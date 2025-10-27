Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9162CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C1983927;
	Mon, 27 Oct 2025 17:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HpHQyWz9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FyT1NvY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7437183923; Mon, 27 Oct 2025 17:40:22 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BDD38392C
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cwK4M0LQnz9tDX;
 Mon, 27 Oct 2025 17:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cziaZIlILSyJ7sEnb/UkshW4LlNx5vgGblsQGvX+0Zo=;
 b=HpHQyWz9ZtarUP6L/J4YTGWnJRefs4c/NJeF7cIZwFDpmHoHy0KHuX3+G1zmN9kJdA7Hgx
 kH/zZJVdYF6b7+z+OKewJzvoAKlOBk7BNbFRTRTYMyT+4rEb/OSRM75uaJNGqooTWMHT0q
 qYmczTVxHdRSdqeGScZZAeb74ho7mdTaUP+g3VjU6OZuI/Ft5aPQRrgTz6sKL87G6qqspz
 wmZls31QDG8GZ8bDELf4TyNLV2fBpZbQbV46Knw68hUQXl5Mh5yQ7f7O4icotE+ocQbffj
 q+Sa9s80rUl5Ve9Y1V7eCaotQ/6dY9xmycyu0YmTctcSsd1VSajPakFz2/YFQg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cziaZIlILSyJ7sEnb/UkshW4LlNx5vgGblsQGvX+0Zo=;
 b=FyT1NvY3h8X8CC1nL9S7rHEqyq14VJdcYu2wrDXyNVGnDdCZXEWRY6C94vTOQ5lbBx+WaR
 i2H+U1e5h+SUFWukeCkWsEwqR6pBkcsMHYCe+2v8l4/zQeVhEr6HLNWTMX7ljEEM3sbYDC
 xabiH/W0rWHbGyhTlFW9u/5WYBPWpq+d9JRxMPmMyx2ceBXIpX9u+9SzjcJCDuy0m4PA4c
 RIDwMNHR9zpSvI9Id+i5Tg2uLPxeijFUCxTXCXiO5VG4nPdDR+y0cHQQK2q9duJcHYTH6e
 Ek9DIjxzqsGbz3Be8d9kTmGHLR7U76JOXsaj3gntFsGU8T2eD+wSfeQKyikMeA==
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: renesas-sdhi: Add R-Car Gen5 support
Date: Mon, 27 Oct 2025 17:40:01 +0100
Message-ID: <20251027164010.11884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 366cd36fefa7d7e753a
X-MBO-RS-META: 153ftj3tg97jweaozx5pitggcmx7u4qm
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

From: Hai Pham <hai.pham.ud@renesas.com>

Add support for R-Car Gen5 SoCs into the driver.
The default quirk is identical to previous generation.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Tweak commit message
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/mmc/renesas-sdhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 556f07eaf8f..14976a8d30d 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -864,6 +864,7 @@ static const struct udevice_id renesas_sdhi_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77990", .data = RENESAS_GEN3_QUIRKS },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = RENESAS_GEN3_QUIRKS },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = RENESAS_GEN3_QUIRKS },
+	{ .compatible = "renesas,rcar-gen5-sdhi", .data = RENESAS_GEN3_QUIRKS },
 	{ .compatible = "renesas,rzg2l-sdhi", .data = RENESAS_GEN3_QUIRKS },
 	{ /* sentinel */ }
 };
-- 
2.51.0

