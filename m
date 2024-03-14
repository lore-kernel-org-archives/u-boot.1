Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3266C54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 11:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA2387CEC;
	Thu, 14 Mar 2024 12:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Am0EeRdT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B65F87F4F; Thu, 14 Mar 2024 12:58:08 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD19875FA
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 12:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710417485;
 bh=FRFODIUTZjRcXJiMO8qYWh/Di/EQlbbyJLGTLMmL4uU=;
 h=From:To:Cc:Subject:Date:From;
 b=Am0EeRdTdn8R+U762o99lUVt8NyjZU9aBKwK3PI7nUm1i2r5tjzgqnyhAB9d5wwQn
 3KPGM7ct/56O4q82mL1/MHoT4DFYi+/JGLoXo2Tv8JrbDOfxBG3BeQJiEN3oKY/Zxy
 2UwS1kGDtqJCLOWcNcQXp6czeZZhOWef2L4oY7056mILt3naGuI/U0/L/007z6wvoF
 LQebpROPieSenVeziOTseS8f/wcx6PykvtO387g4UnNdeldYWfSzjqxH2tQvq7ub2k
 yvD3lU+3kvD/ISJWqaI9WOS70qgOM9fELy2uewWE2iloe804bujNgNWKTud/GeMg4v
 Ks4TaUZ7Ta1Lg==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 699233781F8E;
 Thu, 14 Mar 2024 11:58:04 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/2] Trivial fixes for Rockchip SPL boot order
Date: Thu, 14 Mar 2024 11:57:53 +0000
Message-ID: <20240314115801.241575-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series contains some trivial fixes for the Rockchip SPL boot order
driver.

The first patch fixes a typo in a comment.

The second patch prints the full devicetree node path (rather than just
the node ID) in the debug message when a boot device can't be found.

This series may be found at [0].

[0]: https://gitlab.collabora.com/obbardc/u-boot/-/tree/wip/obbardc/rockchip-spl-boot-order-fixes-v2

Changes in v2:
- Print node path instead of node ID (suggested by Quentin S).
- Improve patch subjects (suggested by Dragan S).
- Improve cover letter a little.
- Collect Reviewed-by tags.
- Rebase series on top of rockchip/for-next.
- v1: https://lists.denx.de/pipermail/u-boot/2024-March/547175.html

Christopher Obbard (2):
  rockchip: spl-boot-order: fix typo in comment succes→success
  rockchip: spl-boot-order: show DT path for missing device

 arch/arm/mach-rockchip/spl-boot-order.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.0

