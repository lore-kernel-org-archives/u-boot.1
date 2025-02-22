Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BD3C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D39A80F56;
	Sat, 22 Feb 2025 21:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mUgI7Ao6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Louhvtam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0422380F3F; Sat, 22 Feb 2025 21:36:05 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5F9806FE
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0f0K5VSWz9sp8;
 Sat, 22 Feb 2025 21:36:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MoRxObs1icMw8ExslECOyDeKLrI3Vx4EkHXHCqPoao=;
 b=mUgI7Ao6USeExQiWEu3Qckqn/VC+dx9L3Gp69rmJdPxTkqZLmw0CCiB9AANR2diMR5g3Q8
 +9ZXcCSXp/rcubelJjGcWxaRKk8GS8fgeXqW1s89bWNxTtF+vMPBCxAEUcPucsoT5ar6uD
 6ftCnlOXFv6On7eZ6s6CQFKPNbI67o1/NwOaK9J5CXeyUygjSmU0VdXE6pJvbcRtds/fzF
 9g7zI99+1SZPl1ygTaqM5wrAyAt0FgOVOEMEgiXmwFy+X7ZaTqwG+OkuGX4GGp3q2dvt/C
 MZwpqqPHb0HM9VZ2mugu5XWC+2RXY/AgDKluvTVBKiMioP3KV8DHVhMI8wkP3Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MoRxObs1icMw8ExslECOyDeKLrI3Vx4EkHXHCqPoao=;
 b=LouhvtamWUZ2oQ8RS9qES0kY3xm+pFDvpac2IZ6JZf7Gl+xnN/bVtX8cB5oE18N3UIyG1L
 V+xqH2EOErgoQH8eXKxg6jgm296aysdlLmzcTtVn8GtF3lLpfv/13cp86YYcksjhS7RwV0
 YVNfyx76+OeHhk7S1vMTWC1P7/Y18/EBw7o60ERrAskbrIUvMx5OFeIvxx/HOOv6TIHMvU
 Tm3Ta7l49tY0yyCljBYi4O6wt5oQx6UR93rTmoGVR3u7oPMWAcAFQRs4W4S0OLVcCSGR8+
 v48SMctha45rZqUaIqoHYIXiTy0msqJl+VBhurOt+uE7hLzxUqcLyXuq1AcVaQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 03/23] net: designware: Drop NULL priv assignment
Date: Sat, 22 Feb 2025 21:33:13 +0100
Message-ID: <20250222203511.195437-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 76800439ba03e9eeef7
X-MBO-RS-META: 4au5wnoy1s8qrxjp4kjerpyq6ikjesb7
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

This is unnecessary, the unset structure member is initialized to
NULL by default, drop the assignment.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: New patch
V3: Add RB from Paul
---
 drivers/net/designware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 2ab03015ffa..c17b4078d5a 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -1041,7 +1041,6 @@ struct bb_miiphy_bus bb_miiphy_buses[] = {
 		.get_mdio	= dw_eth_bb_get_mdio,
 		.set_mdc	= dw_eth_bb_set_mdc,
 		.delay		= dw_eth_bb_delay,
-		.priv		= NULL,
 	}
 };
 
-- 
2.47.2

