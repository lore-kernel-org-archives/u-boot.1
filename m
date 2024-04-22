Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C721AC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 14:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 905C088415;
	Mon, 22 Apr 2024 16:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LKektyDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A61A887E9; Mon, 22 Apr 2024 16:00:53 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6109888436
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 16:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713794449;
 bh=XLrQ3pNhxE+uww4g5+n9pZ4/rC/V+RMg/9AtPUO4IIU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LKektyDgDN17I6mGAT/al0HFZeLG3V1lJi+8HKCjoMK96gIhqEA4HBjQ9zpP6e/Iy
 U/faUOWeMasrHgrxEGyKjIU9rTN3LkEK5lbvpKuv2SNAZgkR4CqDzT00epCPcDBqOd
 LKQrND2ZXoLd8yKhbPVlCJiO0nXe1QOIQiOO2BNgZgr8gTkW9Bm8ZUaH6zQhPSSZ3h
 jQtpWXGFLsl+v+1/IRgBIbVz6V+3K5Eu/89NIHOUskkwtCgcmDuqnSCty8VHD1pytM
 nEv26E11FC4+1XsnsVhDPqIbi5OXC7HWtMKIUBQS6gSdIZJjGdcauvIvGXZXHIYy63
 KXDfp7pW5l6yQ==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id C7E543782123;
 Mon, 22 Apr 2024 14:00:46 +0000 (UTC)
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
Subject: [PATCH v2 1/3] net: eth-uclass: Introduce NET_PREFER_ROM_MAC_ADDR
Date: Mon, 22 Apr 2024 09:56:18 -0400
Message-ID: <20240422135927.23582-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135927.23582-1-detlev.casanova@collabora.com>
References: <20240422135927.23582-1-detlev.casanova@collabora.com>
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

To avoid that, this commit introduces NET_PREFER_ROM_MAC_ADDR that can
be set for boards that have such an interface.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 net/Kconfig      | 7 +++++++
 net/eth-uclass.c | 9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 5dff6336293..1797c2cea35 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -227,6 +227,13 @@ config SERVERIP
 	string "Value of the default 'serverip' value in the environment"
 	depends on USE_SERVERIP
 
+config NET_PREFER_ROM_MAC_ADDR
+	bool "Prefer using HW MAC address if environment address differs"
+	default n
+	help
+	  In case of a MAC address mismatch between the environment and the HW,
+	  prefer using the HW address.
+
 config PROT_TCP
 	bool "TCP stack"
 	help
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 3d0ec91dfa4..682de3ec7bd 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -584,8 +584,13 @@ static int eth_post_probe(struct udevice *dev)
 			       env_enetaddr);
 		}
 
-		/* Override the ROM MAC address */
-		memcpy(pdata->enetaddr, env_enetaddr, ARP_HLEN);
+		if (!IS_ENABLED(CONFIG_NET_PREFER_ROM_MAC_ADDR)) {
+			/* Override the ROM MAC address */
+			printf("Using address in environment\n");
+			memcpy(pdata->enetaddr, env_enetaddr, ARP_HLEN);
+		} else {
+			printf("Using address in %s\n", source);
+		}
 	} else if (is_valid_ethaddr(pdata->enetaddr)) {
 		eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
 					      pdata->enetaddr);
-- 
2.43.2

