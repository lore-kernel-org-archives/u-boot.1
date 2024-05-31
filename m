Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0A4C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66E8887F5;
	Fri, 31 May 2024 17:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Ry8Xkj0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E224188076; Fri, 31 May 2024 16:34:15 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4831C887C2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.schramm@manjaro.org
From: Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717166051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RBIJv5imOpm3x8NQBGeqpk3MySQOt3FCPlkpue2fAM=;
 b=Ry8Xkj0bJrnUA8hkMwm1VsHcUID4BEY/oqZbmW/ApilAXSmqDHqOYk9qclwUzOasQzVHoZ
 B9C+jWVf61fRPYf9WIGHHWqDVaS/U8JDJ4ns4VpinZH6tVTt+bG2ujcdkk5nDxnKdPjN25
 7DWqHrLuTm9HKeQi88r3rDUXBlKpTx3l0I7XwXVuf7Vqk+mEoAI0G7k+V0bmN7Ai+MzlRl
 Pyyeom3Di8W2ocCZl+WK9vsBoIlMLabEOAW86UUBGQWXJpjuWxCbBeR31mPTqB3q61rP1V
 b1umOd3L0a4BN240ntOuNbL8WqRnkgkAvH7n6D91Jl/csPxbourcB9IPi+nicw==
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 2/2] net: sun8i_emac: add support for EMAC on V3s-based SoCs
Date: Fri, 31 May 2024 16:33:50 +0200
Message-ID: <20240531143350.14855-3-t.schramm@manjaro.org>
In-Reply-To: <20240531143350.14855-1-t.schramm@manjaro.org>
References: <20240531143350.14855-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
X-Mailman-Approved-At: Fri, 31 May 2024 17:13:20 +0200
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

The Allwinner V3s SoC and related SoCs have a fast Ethernet MAC with
internal Ethernet phy. The internal phy is connected via MII and the MII
is not exposed externally on SoC pins.
Add support for this MAC and phy combo to the sun8i EMAC driver.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/net/sun8i_emac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 8bff4fe9a9..d9d1825b69 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -903,6 +903,11 @@ static const struct emac_variant emac_variant_h6 = {
 	.support_rmii		= true,
 };
 
+static const struct emac_variant emac_variant_v3s = {
+	.syscon_offset		= 0x30,
+	.soc_has_internal_phy	= true,
+};
+
 static const struct udevice_id sun8i_emac_eth_ids[] = {
 	{ .compatible = "allwinner,sun8i-a83t-emac",
 	  .data = (ulong)&emac_variant_a83t },
@@ -914,6 +919,8 @@ static const struct udevice_id sun8i_emac_eth_ids[] = {
 	  .data = (ulong)&emac_variant_a64 },
 	{ .compatible = "allwinner,sun50i-h6-emac",
 	  .data = (ulong)&emac_variant_h6 },
+	{ .compatible = "allwinner,sun8i-v3s-emac",
+	  .data = (ulong)&emac_variant_v3s },
 	{ }
 };
 
-- 
2.30.2

