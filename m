Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F08C54E60
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 14:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 922AD87FDE;
	Thu, 14 Mar 2024 15:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="l7Hebe1M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61AC87FB7; Thu, 14 Mar 2024 15:44:09 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356B987FC6
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 15:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710427446;
 bh=PL7iC9og1qti68zR3G0mMzJL1RBqoSMeZqjKxTQBTTU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l7Hebe1ML1qEUUeTbegP594emW0+h3raiVQbJHwwe62TYkXdOKzcy1Jn/cryGjBhm
 WjwllTJBfx8ZH6uszuTzQ/ZueJasU5Gtey9byCdFBN4hlOJUcCSvh6a4a466cBXDgG
 O0Fo8FuH2xHAcQH2E9M83povwRgdMz3DrCRI0u29o5IWW2RESLT5lyEh2LHZs5HRvs
 oEcZPA+anWm4H3KmbqVF+Gzzh6h6WjrV7LHxJmdFwGgYOZLWSsa+t3xfslQbaTZUi3
 FZoFT4NApRd8TLOAU3yjWM5OUO5YU4rOMfzhsz+DH42WqrrJEdu70EaOnCBxBi5SzG
 Ucul8WePVU6+Q==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E185637820F5;
 Thu, 14 Mar 2024 14:44:04 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 1/3] net: Add a CONFIG_NET_BOARD_ETHADDR
Date: Thu, 14 Mar 2024 10:43:46 -0400
Message-ID: <20240314144403.491850-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240314144403.491850-1-detlev.casanova@collabora.com>
References: <20240314144403.491850-1-detlev.casanova@collabora.com>
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

On some boards, a MAC address is set based on the CPU ID or other
information. This is usually done in the misc_init_r() function.

This becomes a problem for net devices that are probed after the call to
misc_init_r(), for example, when the ethernet is on a PCI port, which
needs to be enumerated.

In this case, misc_init_r() will set the ethaddr variable, then, when
the ethernet device is probed, if it has a ROM address, u-boot will warn
about a MAC address mismatch and use the misc_init_r() address instead
of the one in ROM.

The operating system later will most likely use the ROM MAC address,
which can be confusing.

To avoid that, this commit introduces a CONFIG_NET_BOARD_ETHADDR that
allows board files to implement a function to set an ethaddr in the
environment, that will only be called when necessary. The logic is now:

- If there is there an ethaddr env var, use it.
- If not, if there is a DT MAC address, use it.
- If not, if there is a ROM MAC address, use it.
- If not, if CONFIG_NET_BOARD_ETHADDR, call board_gen_ethaddr() and use
  it.
- If not, if CONFIG_NET_RANDOM_ETHADDR, generate random MAC
- If not, fail with No valid MAC address found

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 net/Kconfig      |  7 +++++++
 net/eth-uclass.c | 17 +++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 5dff6336293..6dd333ddb9e 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -54,6 +54,13 @@ config NET_RANDOM_ETHADDR
 	  generated. It will be saved to the appropriate environment variable,
 	  too.
 
+config NET_BOARD_ETHADDR
+	bool "Board specific ethaddr if unset"
+	help
+	  Allow a board function to set a specific Ethernet address that can
+	  be, e.g., based on the CPU ID. If set, this will be tried before
+	  setting a random address (if set).
+
 config NETCONSOLE
 	bool "NetConsole support"
 	help
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 3d0ec91dfa4..f194df8512a 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -56,6 +56,12 @@ __weak int board_interface_eth_init(struct udevice *dev,
 	return 0;
 }
 
+/* board-specific MAC Address generation. */
+__weak int board_gen_ethaddr(int dev_num, u8 *mac_addr)
+{
+	return 0;
+}
+
 static struct eth_uclass_priv *eth_get_uclass_priv(void)
 {
 	struct uclass *uc;
@@ -563,13 +569,20 @@ static int eth_post_probe(struct udevice *dev)
 	if (!eth_dev_get_mac_address(dev, pdata->enetaddr) ||
 	    !is_valid_ethaddr(pdata->enetaddr)) {
 		/* Check if the device has a MAC address in ROM */
+		int ret = -1;
 		if (eth_get_ops(dev)->read_rom_hwaddr) {
-			int ret;
-
 			ret = eth_get_ops(dev)->read_rom_hwaddr(dev);
 			if (!ret)
 				source = "ROM";
 		}
+		if (IS_ENABLED(CONFIG_NET_BOARD_ETHADDR) && ret) {
+			board_gen_ethaddr(dev_seq(dev), pdata->enetaddr);
+
+			if (!is_zero_ethaddr(pdata->enetaddr) &&
+			    is_valid_ethaddr(pdata->enetaddr)) {
+				source = "board";
+			}
+		}
 	}
 
 	eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
-- 
2.43.2

