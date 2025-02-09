Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A875C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC98F80A55;
	Sun,  9 Feb 2025 13:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yF38hhul";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vUOB6mYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A190480944; Sun,  9 Feb 2025 13:04:46 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5C780821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YrRGN2825z9t2j;
 Sun,  9 Feb 2025 13:04:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9MeVypjPTP+ETlIrnl47UIfyttvp2Xhgq5M1R6WGb0=;
 b=yF38hhul0vgSGKtNf7LDJ7u2MBvteySpbyWV6Kn7Yv1RAedSjwu5Ea/m8KEzU2gzpGEVnL
 gxcmE8ifcVVc+cekEigQOo8meO2Y2yZD6aZ/i03sZGsh7bR4wrkoGHunHMahp0mRCsb0+Y
 rhQ+mNU1DVojzgn+Okpq21Bg/3fMmOAhEnf1BQCAWkeGe0j04y71eCof2jS4WmKaCIABXu
 xdrPloekkdBMplOHrQF5iWuC4Kf7ZS3kn4cftNmV8Lbjb4wua41ckqjbud5/WosgcR9afC
 lk+fYFPoLPXsbuX+UeNICuOxk6BG91MVRsRvYF0oEwPnIlTgXxIt88rGtd+scw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9MeVypjPTP+ETlIrnl47UIfyttvp2Xhgq5M1R6WGb0=;
 b=vUOB6mYSwlQdRxUrh8rlzbBfobkRL9xweqdVfeC+j19EsX0wSTIeAwiH8jh91oR0w7EiKS
 cFBESD/VhF+EkP5UomXgrG08npKtu7dgmPx7ITk/vEfT/fZnKszbLYO0IAOSW+NyoQj89O
 epZI87h0pmpodn/prYtqBQ27KkRuW/uGHYudBeHXMXalbzrF/S4h/9D7Q64xWTzzVxp3Pt
 Y81SvVhsjrq/jX5G+0yre0eQWD5m3rNhFZSTpExJpKXyx4+3YCfMshzHyaGvBOX3r8LEhw
 BcUy1LQaZ7xpptrSDZbVRA77yd1iiT4W+rY6/TrJQQFnP2/z+8nnn+VvBbI/wQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/24] net: designware: Drop NULL priv assignment
Date: Sun,  9 Feb 2025 13:01:29 +0100
Message-ID: <20250209120403.5321-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 37aae5ba626c2dcf0b7
X-MBO-RS-META: e33ojgbonmjcmb37b9emsia5ihb74pny
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
---
 drivers/net/designware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 94d8f1b4c04..90ce3ebc80c 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -1001,7 +1001,6 @@ struct bb_miiphy_bus bb_miiphy_buses[] = {
 		.get_mdio	= dw_eth_bb_get_mdio,
 		.set_mdc	= dw_eth_bb_set_mdc,
 		.delay		= dw_eth_bb_delay,
-		.priv		= NULL,
 	}
 };
 
-- 
2.47.2

