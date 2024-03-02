Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80636C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 14:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0030687E89;
	Sat,  2 Mar 2024 15:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qfnCJ7jI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7534C87DCA; Sat,  2 Mar 2024 15:51:19 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A43887DCA
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 15:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709391076;
 bh=yWwWjx3mKap+Gqbd4J6HBI9qe6TBOZwpXLe4uMI6S1g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qfnCJ7jIBnncg22xXCNPzq/NaNpqQw+ogtOvWnFcxUwdkSP6yKB9k63Il7xWdFdz/
 NC4AzPvlZiErVLp537je4Rx7HMz2rTzCcAMG7Rjp0H/HcNR1Je5OomR9Xx/N8bKuuq
 ghjjlE7alrjss2A98JCMWODkAZEn7wsqjFjnaMtFcLz994e4Z9fRYXevbwh600e8WP
 +IMc3D4abRrve0YpO9uTIMyA6mL20Q7WwwGijVYmu78sh0nmN1a8YINUojOYVLnRF7
 5uRUTnK0GEk01yg05ZFmS6zSA+fwFjrmuQrTwngmu2L9BT3Ti0dLCLRyN4G6O1xHCI
 3al09AVeIfnVw==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id AF717378209E;
 Sat,  2 Mar 2024 14:51:15 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] rockchip: spl-boot-order: Improve debugging message
 when device isn't found
Date: Sat,  2 Mar 2024 14:50:57 +0000
Message-ID: <20240302145107.168080-3-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302145107.168080-1-chris.obbard@collabora.com>
References: <20240302145107.168080-1-chris.obbard@collabora.com>
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
specific devicetree node. To aid debugging, print the node path as well as
the ID.

Original debug message:

    board_boot_order: could not map node @73c to a boot-device

With this patch applied this becomes e.g:

   board_boot_order: could not map node @73c (/spi@ff1d0000/flash@0) to a boot-device

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

 arch/arm/mach-rockchip/spl-boot-order.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index e548a7dc718..b23666fb017 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -151,8 +151,8 @@ void board_boot_order(u32 *spl_boot_list)
 		/* Try to map this back onto SPL boot devices */
 		boot_device = spl_node_to_boot_device(node);
 		if (boot_device < 0) {
-			debug("%s: could not map node @%x to a boot-device\n",
-			      __func__, node);
+			debug("%s: could not map node @%x (%s) to a boot-device\n",
+			      __func__, node, conf);
 			continue;
 		}
 
-- 
2.43.0

