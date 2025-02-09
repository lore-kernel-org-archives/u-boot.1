Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D053C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D9680934;
	Sun,  9 Feb 2025 13:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XpXao66B";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FF1uwieN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF6380819; Sun,  9 Feb 2025 13:05:31 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81123807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YrRHF26Msz9stK;
 Sun,  9 Feb 2025 13:05:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgNBWZdIaWLuFeTB1UozYmtPxagsSWi1Kx1mjUO+Ga8=;
 b=XpXao66BGhhHH4tZT7NkfpJgT9GM4eFIMzYj9Zo/yjaCosQYOAN+m95lnc91Rh30qKyRkO
 d/5Csu3HZELdCiLkMn08EWBrEmg04vVVDZ60qZZlcz3lCSIhep1gYQYAnaM1+9SYOFvvI7
 or5/25pzzpEHUPmvnegKo+/fes8MNlCvVcAisqwpVtChNj12rmB9Hsaiu3EVrkdgl2Euun
 zJfZr5YXSRxw58TpJN01dcdwxZfbHk5ckTSiTJ5eXJcOZRe5BxGEFAsTOqFajSf89xxcdb
 tt4eVznDgKyZLu4ShtWcDk+UBXUYhkUmfJSmLDvxYy96tiSmt9eKWq89mF+bfA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgNBWZdIaWLuFeTB1UozYmtPxagsSWi1Kx1mjUO+Ga8=;
 b=FF1uwieNC5mLWWiERl34t+G2zJ2DF3QTxLpy6fXkojUq0SQoxO8UbTKGtvHxTygegXUx/a
 Jr1K7U5Gbfi60/5k2oROmYz7twqfcZqIeR76JAtN2SpdrwA0CNLk4MLepDpXmXX3mHqxEf
 qB3zNNHBX+IxGfVZ7/zUFjmg/bPxBMVo0KSo1xDFwrTgisCld09TZQ73ilh1cYfAMp9wpy
 jIpjAv5FcRkUJV1HsM/YD620IZHlrUHlqLVhCf1dKUnHLTV2tOn7r0fh05chDzdOXsUG6z
 TdwqI/GIARS49mrt6MnykI2QAa78sGQ8IOo2aBVVK/CnshyyuqVQ5oPRInyPzw==
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
Subject: [PATCH v2 23/24] net: sh_eth: Drop use of miiphy_get_dev_by_name()
Date: Sun,  9 Feb 2025 13:01:49 +0100
Message-ID: <20250209120403.5321-23-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 572a6bcdc3420be951c
X-MBO-RS-META: aaf6pi8hs5qi5e5b6ynjigcisyzy3nz5
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

Instead of doing another lookup, trivially access the struct mii_dev
embedded in struct bb_miiphy_bus . No functional change.

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
V2: No change
---
 drivers/net/sh_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 49065ebe717..b1e35aaf291 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -753,7 +753,7 @@ static int sh_ether_probe(struct udevice *udev)
 	if (ret < 0)
 		goto err_mdio_register;
 
-	priv->bus = miiphy_get_dev_by_name(udev->name);
+	priv->bus = &bb_miiphy->mii;
 
 	eth->port = CFG_SH_ETHER_USE_PORT;
 	eth->port_info[eth->port].phy_addr = CFG_SH_ETHER_PHY_ADDR;
-- 
2.47.2

