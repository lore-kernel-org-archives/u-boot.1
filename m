Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D63CCFA18
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 13:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D41383C63;
	Sat,  8 Nov 2025 14:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DdHI8dmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F59583E86; Sat,  8 Nov 2025 06:38:31 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BB883D52
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 06:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+dang.huynh.mainlining.org@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A3DF4601CF;
 Sat,  8 Nov 2025 05:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71271C116C6;
 Sat,  8 Nov 2025 05:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762580307;
 bh=VlTFq5jSF2d/7NiGR04IUzYYmecCAmxqjTffAl2jPG8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DdHI8dmSOzsfqsGZDYpGlbUdY0dPu5CQ0lBjT2aC3klEcezK1B3SZLrjdDS9i8S4V
 F3MlsMLpCQ2SivDuB17C1n/bY8MbSTVNlnwZh1bRA/4uARKiFULdZt07T1BcsSDoTF
 lJANESXOHW9ZK4kn2kZnCOzNOa58x57p8d084W1pvufiQJji1UtbRTeC/pAjoVXt3S
 3E1gOqF0PXJ8Ts0WjMy1dLqML2wC6Psp8Bxn4tRybZh4LTbwCIuEv4D6TpY5gW5mBw
 6rQxryLRVNK9QZ5hdN+IBGpKPhfocCUZd1UUfUPvT5i6uzr4Ft6EN6dPLYtWo32xar
 BrfSDVNMKFGTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 67C62CCFA19;
 Sat,  8 Nov 2025 05:38:27 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Sat, 08 Nov 2025 12:37:57 +0700
Subject: [PATCH v6 01/12] video: rockchip: dw-mipi-dsi: Depend on
 CONFIG_VIDEO_BRIDGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vop2-pt2-v6-1-d04c699262fb@mainlining.org>
References: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
In-Reply-To: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
 Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dragan Simic <dsimic@manjaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Piotr Zalewski <pZ010001011111@proton.me>, 
 Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762580305; l=809;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=dF+S2vGhhZ3xeqXcRD+CelND3VvzktGZx/+nq+lUz0A=;
 b=/U/Vk4XXAZB3NukDkAaQUl3HDv9AcJmQ8LMt48Rioi7CHiTzYhJVY6iincsq8r53Irs5uaR81
 K01XKESvYVyDrX+AlSqqwKon51tpCMwkoYjfTwnJGth8Adp/uSuRJdv
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
X-Mailman-Approved-At: Sat, 08 Nov 2025 14:06:07 +0100
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
Reply-To: dang.huynh@mainlining.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Dang Huynh <dang.huynh@mainlining.org>

The driver is in video bridge class, so we must depend on it or
the driver will fail to init.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 drivers/video/rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/rockchip/Kconfig b/drivers/video/rockchip/Kconfig
index 0f4550a29e3..dfd08f1e5d1 100644
--- a/drivers/video/rockchip/Kconfig
+++ b/drivers/video/rockchip/Kconfig
@@ -72,7 +72,7 @@ config DISPLAY_ROCKCHIP_MIPI
 
 config DISPLAY_ROCKCHIP_DW_MIPI
 	bool "Rockchip Designware MIPI"
-	depends on VIDEO_ROCKCHIP
+	depends on VIDEO_ROCKCHIP && VIDEO_BRIDGE
 	select VIDEO_DW_MIPI_DSI
 	help
 	  Select the Designware MIPI DSI controller in use on some Rockchip

-- 
2.51.2


