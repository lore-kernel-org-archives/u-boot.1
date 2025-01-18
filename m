Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E16EC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8D080818;
	Sat, 18 Jan 2025 07:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OXcx4zmA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xy/e9Xwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92D1180818; Sat, 18 Jan 2025 07:55:03 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B54E80780
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZnR92Mszz9sbl;
 Sat, 18 Jan 2025 07:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8To3iPJ95/xt92SH0mM9T/IJCHtiaHFauZdZBYdoZAg=;
 b=OXcx4zmAKFNjUkRlPuf5EOAvIuXVD1hoXwmZrC50+CYw5nYt0JQ5Wk6ikKzD7AD0xpmWGj
 sQlHwLJNW5Fp+lVypL2MSh34PjcW80tgZag/hurikNmJuC6ZqD3xdZZtMBWQI+uyZblzfW
 sopyTPv4FzYUhKuSPRht6U7JyIn08Va/5GWzjmX87v+y+PRBnb6lSHq4+fKan88miTvvpH
 MBgC58WEhA9LuORLH+I/384/eEucuzG4b4w3s9s9DgrGf6nqUDwJqagaMtuzx6QANo40lT
 qYYuT3SXPc6yRI8E7H925wXVhMatRuvU8KoVMs/i0ULMCpArVnBu9tCfW8ib5A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8To3iPJ95/xt92SH0mM9T/IJCHtiaHFauZdZBYdoZAg=;
 b=Xy/e9Xwn0FRQ/81ulRBQnEjWQ8cIZwcVitDmiKRNQ4/HvrGrJ2JbYVfxYSao96WmumgQxx
 okwrrPAZ1gCz4nKqAWMksw1VmoE2GbsNkKzifiIdVe+wW2eKNmYtnnTe+YdicOqr/ss+Ne
 4bRZ7GkZnmEiyRCSw+nLnsSWeuNFuuY1ef43U9t6pqQxs81Qf5xanDnthQRlrC31Kok84z
 0nnrLquyKyUNoANhAwAPih0XDwDo1pFFk35mit2/mKgks98MzCiNI19hzz/9GwqQx8K8eU
 fxVhRNxfMp943KKlmmThzQAqzJKO1uEHVVIREFGpZDeiMtvSowFYNde1VxJEKw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/17] net: miiphybb: Drop .init callback
Date: Sat, 18 Jan 2025 07:53:21 +0100
Message-ID: <20250118065402.172253-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0b30a57db7d41e2a7f3
X-MBO-RS-META: 68b7obxjnz4szih8o66erwqrixes9kbe
X-Rspamd-Queue-Id: 4YZnR92Mszz9sbl
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

The .init callback is not called by any function, drop it.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
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
 board/gdsys/a38x/ihs_phys.c | 1 -
 drivers/net/ravb.c          | 1 -
 drivers/net/sh_eth.c        | 1 -
 include/miiphy.h            | 1 -
 4 files changed, 4 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 2477a2ea48e..05db266ffd3 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -234,7 +234,6 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	mdiodev->write = bb_miiphy_write;
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->init = NULL;
 	bb_miiphy->mdio_active = mii_mdio_active;
 	bb_miiphy->mdio_tristate = mii_mdio_tristate;
 	bb_miiphy->set_mdio = mii_set_mdio;
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 084fe8f9777..cb727ae9bc1 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -578,7 +578,6 @@ static int ravb_probe(struct udevice *dev)
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->init = NULL;
 	bb_miiphy->mdio_active = ravb_bb_mdio_active;
 	bb_miiphy->mdio_tristate = ravb_bb_mdio_tristate;
 	bb_miiphy->set_mdio = ravb_bb_set_mdio;
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 699121a6880..83e48609224 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -740,7 +740,6 @@ static int sh_ether_probe(struct udevice *udev)
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->init = NULL;
 	bb_miiphy->mdio_active = sh_eth_bb_mdio_active;
 	bb_miiphy->mdio_tristate = sh_eth_bb_mdio_tristate;
 	bb_miiphy->set_mdio = sh_eth_bb_set_mdio;
diff --git a/include/miiphy.h b/include/miiphy.h
index 6e8e4ee57bc..b879fd16ae3 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -65,7 +65,6 @@ void mdio_list_devices(void);
 #define BB_MII_DEVNAME	"bb_miiphy"
 
 struct bb_miiphy_bus {
-	int (*init)(struct bb_miiphy_bus *bus);
 	int (*mdio_active)(struct bb_miiphy_bus *bus);
 	int (*mdio_tristate)(struct bb_miiphy_bus *bus);
 	int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
-- 
2.45.2

