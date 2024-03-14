Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9985C54E60
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 14:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4CA87FB7;
	Thu, 14 Mar 2024 15:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JOe6Hcdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9AC87FAD; Thu, 14 Mar 2024 15:44:09 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 268DF87FB7
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 15:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710427444;
 bh=CqyXmLYr3csRNQ21yNUfMVB7QGVSHQfVhevXg8I9Kxc=;
 h=From:To:Cc:Subject:Date:From;
 b=JOe6HcdnfhFS/i3Yj9BBfGs3l+5/t0KUZ022ovnE/qGAwqNEQC3TS38/as6QlErae
 J7iZ8rSYcKVsEqp6Cj3ln6h5qpcM/U1+IjGOjMzovbZ67mMunTGF4MHzv6/OsnNkGd
 vuJ4lt3g+nlDRm/LgEBWpb7HN57qwLa92qP014ebXQPALEam9F1Kc+HUQ69ZmWxivE
 V9sANiu1ngy0lwYyQ8Zm+LDzLZTmrvXY8rmBjCsNR/6KkorpLGGaANoOhkW6ihAqji
 ImNQ1yv/KZ6LXnhOz/xjWAw46m8+k9mkjgbkfjoqh6DuZdx13SEmMCfiR0JfUuiyQR
 ssjL+mGdoce7Q==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE46D37820E7;
 Thu, 14 Mar 2024 14:44:02 +0000 (UTC)
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
Subject: [PATCH 0/3] net: Add a CONFIG_NET_BOARD_ETHADDR
Date: Thu, 14 Mar 2024 10:43:45 -0400
Message-ID: <20240314144403.491850-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
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

Basically, the MAC address generation needs to use a board function in
its decision algorithm so that there is no MAC mismatch between ROM and
environment depending on the order of function calling.

See the first commit message for details.

Detlev Casanova (3):
  net: Add a CONFIG_NET_BOARD_ETHADDR
  rockchip: Add a board_gen_ethaddr() function
  net: eth-uclass: Add driver source possibility

 arch/arm/Kconfig                          |  1 +
 arch/arm/include/asm/arch-rockchip/misc.h |  1 +
 arch/arm/mach-rockchip/board.c            | 30 ++++++++++++++++++-----
 arch/arm/mach-rockchip/misc.c             | 22 ++++++++++++-----
 net/Kconfig                               |  7 ++++++
 net/eth-uclass.c                          | 25 ++++++++++++++++---
 6 files changed, 70 insertions(+), 16 deletions(-)

-- 
2.43.2

