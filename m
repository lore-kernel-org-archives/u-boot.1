Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB0BC54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 11:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E5987F4E;
	Thu, 14 Mar 2024 12:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="uVDIrNTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF27C87F71; Thu, 14 Mar 2024 12:58:09 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E15F87F04
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 12:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710417486;
 bh=97GHybiinm1shrsqVFQgLu/DugRd/ZKaTGWg9Zt8jjk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uVDIrNTYnYGfXJQZec4uh78JmHljcuJSab2pSCl8Oa9XnP/IsVp5G1Xy/s2+7eYUN
 PAU6alfAUnKhFkvq3NVkevKBYzhtVPOrJydkZar/UOvhnZXvgXbPDpItzQTN8a/WHR
 zPqqK1YblDEliz1LzIQ1sm7FYMsgL2jyicgcmf7Izt0s5XU0tRmi4v6nFGNM3acyBn
 cjP5TOnmmoqU+oEcbygm6+QZ6dd0fXIs3i+SDX+hsrqAcFswSbfnxpTozle+4+f1kI
 +QuMLXgZ9xHF4Qr/IBzplmKk+dDH+nnqMtveCeOtnfHEecqWBDab3kz3EjWF3VLdgM
 aEdIaiwtlwj/g==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4BD9937820F7;
 Thu, 14 Mar 2024 11:58:06 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] rockchip: spl-boot-order: show DT path for missing
 device
Date: Thu, 14 Mar 2024 11:57:55 +0000
Message-ID: <20240314115801.241575-3-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240314115801.241575-1-chris.obbard@collabora.com>
References: <20240314115801.241575-1-chris.obbard@collabora.com>
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

When debugging the SPL boot order, the node ID of a device which hasn't
been found is printed but it can be quite hard to relate that to the
specific devicetree node. To aid debugging, print the node path instead of
the cryptic node ID.

Original debug message:

    board_boot_order: could not map node @73c to a boot-device

With this patch applied this becomes e.g:

   board_boot_order: could not map node /spi@ff1d0000/flash@0 to a boot-device

Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

Changes in v2:
- Improve patch subject (suggested by Dragan S).
- Print node path instead of node ID (suggested by Quentin S).
- Collect Reviewed-by tag from Dragan S.

 arch/arm/mach-rockchip/spl-boot-order.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 8f479ac0ec0..3543267aa57 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -148,8 +148,8 @@ void board_boot_order(u32 *spl_boot_list)
 		/* Try to map this back onto SPL boot devices */
 		boot_device = spl_node_to_boot_device(node);
 		if (boot_device < 0) {
-			debug("%s: could not map node @%x to a boot-device\n",
-			      __func__, node);
+			debug("%s: could not map node %s to a boot-device\n",
+			      __func__, conf);
 			continue;
 		}
 
-- 
2.43.0

