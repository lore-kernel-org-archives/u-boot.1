Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A549C5B549
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 03:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353FA81F0D;
	Tue,  3 Jun 2025 05:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GzYUvSET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8487D820EB; Tue,  3 Jun 2025 05:06:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CED681F0D
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 05:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+smelamud.redhat.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E878F5C55AB;
 Tue,  3 Jun 2025 03:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB6CC4CEF2;
 Tue,  3 Jun 2025 03:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748919980;
 bh=hnJD60pbiKuANBVVM2KSHq+2NxrQ89F9kQaZn8eeh7c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=GzYUvSETqfNnhs54doxvKodruY9PogLsYi3AlKXKzqo9KAZcIFRsTjXxLpS8vDIUt
 ocsKa/prTIZ1aqM+iEpK1+5ygg8dfHvvluH3SrXlihPnCyD0gI2zwDNes9Fa1Naavu
 fg6Lyj+h3ta0v/me1pGLEI4j+3L2ZYx91zRyLDJ5v6olQRELQJJ253AbBDEBf67TSS
 yP0G72gD5ebNKP+TUmN7TCks2MEA+LP6kSYNj9bEgS+FA1v+0KatF3ALwXtoN+xaww
 bTKroKp7I9o1oLuZ2f9XqCzzAJqVzVex7O3YvdxEgTOKonkQjwoPtaU6AR3ZNjOI4R
 hpjcTDGdqajmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5309EC5B549;
 Tue,  3 Jun 2025 03:06:20 +0000 (UTC)
From: Shmuel Leib Melamud via B4 Relay <devnull+smelamud.redhat.com@kernel.org>
Date: Tue, 03 Jun 2025 06:06:04 +0300
Subject: [PATCH v3 1/2] renesas: Handle CLK_TYPE_GEN4_MDSEL in
 gen3_clk_get_rate64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-us-renesas-watchdog-v3-1-af3a65afd03e@redhat.com>
References: <20250603-us-renesas-watchdog-v3-0-af3a65afd03e@redhat.com>
In-Reply-To: <20250603-us-renesas-watchdog-v3-0-af3a65afd03e@redhat.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Shmuel Leib Melamud <smelamud@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748919978; l=1352;
 i=smelamud@redhat.com; s=20250530; h=from:subject:message-id;
 bh=TxMVq0eIAmC8l9yovMVlzhsHwTLSzEIVpm0vVdAlpI4=;
 b=EStyr0On6O4zvvZ65JiHXqwvPrOdglzy2nOEFuIn330AFASFfYiPSrfzanD/zsTEZ3iZk3YsL
 LB/0WGZ4YsPCBJNnIWmZX9lZ4D3IYwMJdDbxpINNzX1rvQJUcPZi/MJ
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


