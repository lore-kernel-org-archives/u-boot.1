Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C73C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 14:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38581883F5;
	Mon, 22 Apr 2024 16:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="C6pK2JNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE557887E0; Mon, 22 Apr 2024 16:00:50 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D40883EC
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 16:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713794446;
 bh=FykyuRCPPRvi7iqxSVB+deHkHqV4IE/aecQAJKM1uTI=;
 h=From:To:Cc:Subject:Date:From;
 b=C6pK2JNwcQ7eafmNRlYe5QNnKY0IapAdfhzwjzTv56CE3S+ti0tw/vUMSOWW/8O8S
 fgvjfqPq4V2dXTfwfB8ZM32FXvIR/JIUoRw0G+KmrK/Xf6NchLbVp/hV0pv3wEvQ3H
 pge59rO3FYwmtd0bSpBNEEwBXVKAYXH3mTMU9jDrwMx1ljaskjyMIGcKNTaILmZOQN
 YEpFJu9F+vFqNIVeH9yHI8k/Gp5aEvlhwGH6KSMGpetp0O0JBkl3Ng77dQbeIUF4Vz
 oc8w6WgSsQ6FPGQbKtI68UiqAX2je3eAZ4VRqIQOPRML0ozWS8L1jbjlpqAwEOS6bv
 pVL9EjhQSRCyQ==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9826E378001E;
 Mon, 22 Apr 2024 14:00:44 +0000 (UTC)
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
Subject: [PATCH v2 0/3] Introduce NET_PREFER_ROM_MAC_ADDR config
Date: Mon, 22 Apr 2024 09:56:17 -0400
Message-ID: <20240422135927.23582-1-detlev.casanova@collabora.com>
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

When there is a MAC address mismatch between ROM and environment, u-boot
chooses the one from the environment. This config allows to prefer the
MAC address from the ROM instead of the environment.

See the first commit message for details.

Changes since v1:
 - Simplify implementation with a NET_PREFER_ROM_MAC_ADDR config

Detlev Casanova (3):
  net: eth-uclass: Introduce NET_PREFER_ROM_MAC_ADDR
  configs/rock5b: Set NET_PREFER_ROM_MAC_ADDR to y
  net: eth-uclass: Add driver source possibility

 configs/rock5b-rk3588_defconfig |  1 +
 net/Kconfig                     |  7 +++++++
 net/eth-uclass.c                | 17 +++++++++++++----
 3 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.43.2

