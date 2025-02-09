Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE0AC0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A37580BAE;
	Sun,  9 Feb 2025 13:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IfoQOcmp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SEAyyZKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8124809A4; Sun,  9 Feb 2025 13:05:03 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E9E680A29
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YrRGj1C1Sz9spj;
 Sun,  9 Feb 2025 13:05:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SH3kjThx39ibaS1l2mJfuY1GmW5pFtNAsRWvrwN1Kk=;
 b=IfoQOcmpIIsDXN/+2XrpX4xz0IbDxDjo7rFGMm4EoLt+1yQMv8Ru11RCkhJNX6QmzQ26n8
 xJjZiHs04iyhM4hZjQB2l3EIanoz+lo8xjblwEE0lnMo1yq6fz4rpWodWt9fxyGfK2lBiH
 cGaAlMocOZfONd2Tkdzpm/mAdlxmvDM+73NbaaSEm5ijfqSa15ot4yuy5aLutUmgXZ3QwM
 fCIba+I9si2HccVxY7JAQn11F2bAZL2qAyQ3r7VNe2cStpTuXJYJbHv3bhAzAChdopVlqM
 es5cyRcKBn4RzpUiraHpewMe6zb9dd9CtYtfJda5tzPY6vH20P71f8Gq8+fzfQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SH3kjThx39ibaS1l2mJfuY1GmW5pFtNAsRWvrwN1Kk=;
 b=SEAyyZKltClPUoHBCho/j0r4i42Zib26FtVUDlnYpe16IBqL97aXRpq47ZUnyNb081fvrI
 rOuN9yD6jsKtI7MEgVi3q7Xb+Uoz5hvfVL2zIL4HJet6Z+tHZeZGWUeQeCtOsoC/zw21IT
 KpoXGBVjS6FFnm75kvU8htSROx5lAi7AR4jAC5eh9bxHeBAGeh6ZPftjY/tUEAt8a0E5Nd
 dVbC/w/qdDkGxJFy1m+QkS9ydOnwVHsaYFFfYn/l0AyjnHgM7AUTJxBrbcE2xvO8/dnj24
 FR6Fx3YHoTpXxKFx7CG8oqfTKa1vJbW2IpJ8LYn0BFFqYXsFBe3rYhTRgbt/kQ==
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
Subject: [PATCH v2 11/24] net: designware: Drop bus index
Date: Sun,  9 Feb 2025 13:01:37 +0100
Message-ID: <20250209120403.5321-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2a0ad45393506250ed7
X-MBO-RS-META: aspmqertjmnnp55shajsr3nu4w8au5x7
X-Rspamd-Queue-Id: 4YrRGj1C1Sz9spj
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

There is literally one single bbmiiphy bus in this driver,
remove the bus index handling.

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
 drivers/net/designware.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index d6a5f5cc71c..1bfc098817e 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -865,8 +865,6 @@ int designware_eth_probe(struct udevice *dev)
 
 #if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
 	if (dev_read_bool(dev, "snps,bitbang-mii")) {
-		int bus_idx;
-
 		debug("\n%s: use bitbang mii..\n", dev->name);
 		ret = gpio_request_by_name(dev, "snps,mdc-gpio", 0,
 					   &priv->mdc_gpio, GPIOD_IS_OUT
@@ -884,16 +882,11 @@ int designware_eth_probe(struct udevice *dev)
 		}
 		priv->bb_delay = dev_read_u32_default(dev, "snps,bitbang-delay", 1);
 
-		for (bus_idx = 0; bus_idx < bb_miiphy_buses_num; bus_idx++) {
-			if (!bb_miiphy_buses[bus_idx].priv) {
-				bb_miiphy_buses[bus_idx].priv = priv;
-				strlcpy(bb_miiphy_buses[bus_idx].name, priv->bus->name,
-					MDIO_NAME_LEN);
-				priv->bus->read = bb_miiphy_read;
-				priv->bus->write = bb_miiphy_write;
-				break;
-			}
-		}
+		bb_miiphy_buses[0].priv = priv;
+		strlcpy(bb_miiphy_buses[0].name, priv->bus->name,
+			MDIO_NAME_LEN);
+		priv->bus->read = bb_miiphy_read;
+		priv->bus->write = bb_miiphy_write;
 	}
 #endif
 	ret = dw_phy_init(priv, dev);
-- 
2.47.2

