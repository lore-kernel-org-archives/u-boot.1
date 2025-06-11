Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8D8C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 00:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5A0282B97;
	Wed, 11 Jun 2025 02:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L9fEvspG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299428070C; Wed, 11 Jun 2025 02:26:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 598CC82B18
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 02:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+smelamud.redhat.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A89F84A5C1;
 Wed, 11 Jun 2025 00:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 788B1C4CEF0;
 Wed, 11 Jun 2025 00:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749601575;
 bh=TgmXheonjlsNvBz8Lhq7aVNanu+p9eWn9PO7WNtByVQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=L9fEvspGlWubagFIRNToL1TIpiqCHOBuI2gkCz4pERznH4dErpSjXaJ5fqFFWSpMG
 cRCcUI6/8oK0qquv6NDHerAh3Pl5u942fYpR1wP5o+dG6qGnGSPVSkjIuKyx+2Yf4r
 gyrwElvNrejqA/7ABXV/II6U/bIRyYvJlAu0ZBy0TL9FjIH06SkVK19l5dpT1QNAkf
 X2xc2CCYlovWtn1WEGiSDSelA/DgX2Ptap0QP6VGitplUOmhF/9MO9WL1J1M1LrKyd
 Zm5AhC46GHg7NER1307DryA2Kpfd5XuY7fEzHJcYb5+6VsK25C9G0hWXTFzNJET5l3
 PZB0hD30iCb0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6799CC71133;
 Wed, 11 Jun 2025 00:26:15 +0000 (UTC)
From: Shmuel Leib Melamud via B4 Relay <devnull+smelamud.redhat.com@kernel.org>
Date: Wed, 11 Jun 2025 03:25:51 +0300
Subject: [PATCH v4 1/2] clk: renesas: Handle CLK_TYPE_GEN4_MDSEL in
 gen3_clk_get_rate64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-us-renesas-watchdog-v4-1-24f1da3e0dc9@redhat.com>
References: <20250611-us-renesas-watchdog-v4-0-24f1da3e0dc9@redhat.com>
In-Reply-To: <20250611-us-renesas-watchdog-v4-0-24f1da3e0dc9@redhat.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Shmuel Leib Melamud <smelamud@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749601573; l=1472;
 i=smelamud@redhat.com; s=20250530; h=from:subject:message-id;
 bh=4oFxvFp4W6ljnPsK+XQfAQZ4LOcEGyVg+i/xjN5S4EQ=;
 b=YIzcOcoDXFWluWdAPFiXwxHRCaXC7CJBHqNrGAvZnyckKCby1mEgPOfLBh5xBYvuWNU2nUahi
 qEb35DdIuKKCrDGyTu9lGsTiCrYPJhjdU/GrPnXktv0VIB6846BvjGf
X-Developer-Key: i=smelamud@redhat.com; a=ed25519;
 pk=B1DFtpdxDPQudtnqMHSFRRSJziu3zB49J6oZUBo0qI8=
X-Endpoint-Received: by B4 Relay for smelamud@redhat.com/20250530 with
 auth_id=418
X-Original-From: Shmuel Leib Melamud <smelamud@redhat.com>
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
Reply-To: smelamud@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Shmuel Leib Melamud <smelamud@redhat.com>

Add support of CLK_TYPE_GEN4_MDSEL clock type to gen3_clk_get_rate64()
function. In particular, this type of clock is used by Renesas R-Car
Gen4 watchdog. It operates similarly to CLK_TYPE_GEN3_MDSEL clock.

Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/clk-rcar-gen3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
index 375cc4a4930873ad0d5509c19ad04a0ea5545aa0..5745acf4023c9114f6fa13b5e4baa306c5b57d33 100644
--- a/drivers/clk/renesas/clk-rcar-gen3.c
+++ b/drivers/clk/renesas/clk-rcar-gen3.c
@@ -68,7 +68,7 @@ static int gen3_clk_get_parent(struct gen3_clk_priv *priv, struct clk *clk,
 		if (ret)
 			return ret;
 
-		if (core->type == CLK_TYPE_GEN3_MDSEL) {
+		if (core->type == CLK_TYPE_GEN3_MDSEL || core->type == CLK_TYPE_GEN4_MDSEL) {
 			shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
 			parent->dev = clk->dev;
 			parent->id = core->parent >> shift;
@@ -318,6 +318,8 @@ static u64 gen3_clk_get_rate64(struct clk *clk)
 						"FIXED");
 
 	case CLK_TYPE_GEN3_MDSEL:
+		fallthrough;
+	case CLK_TYPE_GEN4_MDSEL:
 		shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
 		div = (core->div >> shift) & 0xffff;
 		rate = gen3_clk_get_rate64(&parent) / div;

-- 
2.49.0


