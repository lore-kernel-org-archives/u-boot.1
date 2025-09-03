Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D6BCA1009
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 11:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8389834E5;
	Wed,  3 Sep 2025 13:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="INzVc0zC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wdDqv1sT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0078A8350A; Wed,  3 Sep 2025 13:23:53 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E0DC833C6
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 13:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cH0c66XHYz9st3;
 Wed,  3 Sep 2025 13:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756898630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=veQqT1YkkaGdnVYrPrABIiYF45LtBV3LFhHS0TWjhlM=;
 b=INzVc0zCDvPTKxaYAo+GksnQ/W6XEspAhkOTw3HtJF6UhApqx/InjhcFCCDbcIYe1mE0pM
 gFsX+0gc4Dhk4OZKkP5gkSM3HN+Lhl6T1HFcNJp2GyldKT1fsKyGoS6MSsD7GrQ6r6EGcJ
 eobMLiwSxQNjA1xYLBKYgwsN3r39s+DhRILelgWDY5MJqjNqe1AglKfOK4ZpwKQeW0ahg6
 p7thG00o0PSVauZIwkV6RpTWxMmd6DKnijIXuG+Kyo3kT/sBubNhxyARQaHCFI/QIqCwoi
 mIYGOj+LaA6tpXRAyaRa5JSawBludRIxmpvK/gabBjJKQSkFuJWUevdsEEIlNA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wdDqv1sT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756898629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=veQqT1YkkaGdnVYrPrABIiYF45LtBV3LFhHS0TWjhlM=;
 b=wdDqv1sTGngF6Yzcax99zHU4bldvxbAxceEfwQ7KIIvFTbp0mR3eWK1fOWNJJ/aoH/2c8N
 qY95+FLFyBay0YWMtb1/fHZfuyVnqdI4jqLBFXRLwfBM9Vnz39OqRyZSYjDY1b5ZU5VWZE
 WYUJRy3zg+rMqZ91QHPJT4M9Qo39ap2N7ZS95RS5QtrsbCIm/GtiSPoNBouvY3IK30EhZ5
 0L79wgTOa544P5PmD3d8fEVH72DeSjfwCveVU6qqDPWkjZOjlBJgtS1sctFhnOaKFLknFV
 +1t3MwrtUaTpi1BTbrTq926VduNM1JCgQBaJb5PrEjqTJFS9dNp1QdWuIcbWYA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: r8a779g3: Use $loadaddr in bootcmd on
 Retronix R-Car V4H Sparrow Hawk board
Date: Wed,  3 Sep 2025 13:23:23 +0200
Message-ID: <20250903112338.48545-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fwg35kqgnriew3ahcjfwarimm7nxgfep
X-MBO-RS-ID: 4d6a7169d7956170f68
X-Rspamd-Queue-Id: 4cH0c66XHYz9st3
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

Avoid use of hard-coded address in boot command, instead use $loadaddr
which is the default load address. This improves consistency of the
environment on this board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/r8a779g3_sparrowhawk_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index 9cee4d287ef..2d1abf6f26d 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -18,7 +18,7 @@ CONFIG_SYS_BARGSIZE=2048
 CONFIG_SYS_CBSIZE=2048
 CONFIG_BAUDRATE=921600
 CONFIG_BINMAN=y
-CONFIG_BOOTCOMMAND="tftp 0x50000000 fitImage && bootm 0x50000000"
+CONFIG_BOOTCOMMAND="tftp ${loadaddr} fitImage && bootm ${loadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a779g3-sparrow-hawk.dtb"
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_GPIO_HOG=y
-- 
2.50.1

