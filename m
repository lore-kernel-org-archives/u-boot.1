Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84001C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC19780FDE;
	Sat, 22 Feb 2025 21:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="P56k7YJa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iR4nkLDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798AC80F3F; Sat, 22 Feb 2025 21:36:28 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E6A80F3F
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0f0p0tT3z9sp8;
 Sat, 22 Feb 2025 21:36:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pkCjDY5i3n09AoctWagKEoDVUdVgbKPHXmJmgRt4oyM=;
 b=P56k7YJarfGIITpXVsaNzqLmWn3cwqBjttt7gf3azDarhsrG7+cl61lKmAlV/n83tpsKp8
 7yP7BJ/SQdz/yyzjBVzZCxEod49Bi2aX2fUhyFMT7UOoirgGS2cx3sCCn98no/CgNeft12
 RRnwEwSe8KwyBIIgzya/NKMGPU4lUhs6mj1h7kLfut9tqxQIg58RxHzteLS5ZzLvKI8m6u
 5uIgz2TTOzDeGjaOyvrTFtU2U0VE642y0sZB5/2omNe6pItvTnO2ZZu7Aj08CiyXk05QHQ
 NP9yGb3kwKFAOg3tnlX2zERLra+IfWJRiFKX2GgMQWKmVujYIlMqusv6YKY47g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pkCjDY5i3n09AoctWagKEoDVUdVgbKPHXmJmgRt4oyM=;
 b=iR4nkLDm+PR6950lzAXKQ0/MgrNSNMDqorZc4z0DRbEL7q0soURvaT60VYn7uKuoBYoHFm
 Uztf+2CtuETV0YDFJJRKpQCsc5MprUjXtRYEEsTNzxbz38l46/4VF54+82NOLEYefemZ31
 ADIiPHvPLbHwORlqpS5dNd/eq4gqiWeaVmft5YEOm4XSiJY3+3LseP4B3P3Dmp9mvNxcra
 aUAVaOpITYtmsxTs+qMOSefrahumEREU6d0kFDq53+0uPW0dh7q25ib0yJO3Pvt5A6W8om
 B5PrhYPO6Kc1oTplaCGQ6eNBOZ1FqaPXXzSAECgXqf3J7d7pMDx1lJ2xkCjXqg==
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
Subject: [PATCH v3 14/23] arm: mvebu: a38x: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
Date: Sat, 22 Feb 2025 21:33:24 +0100
Message-ID: <20250222203511.195437-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 52d894625a154487bfc
X-MBO-RS-META: pifnn4suaszayt6q84fs7xekg8o6ain6
X-Rspamd-Queue-Id: 4Z0f0p0tT3z9sp8
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

Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
currently listed in bb_miiphy_buses[] array. This is a temporary
duplication of assignment to avoid breakage, which will be removed
in follow up patches. At this point, the bb_miiphy callbacks can
reach these accessors by doing container_of() on struct mii_dev.

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
V3: No change
---
 board/gdsys/a38x/ihs_phys.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 86708ee6715..a121898be52 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -221,22 +221,35 @@ static int mii_delay(struct bb_miiphy_bus *bus)
 
 int register_miiphy_bus(uint k, struct mii_dev **bus)
 {
-	int retval;
-	struct mii_dev *mdiodev = mdio_alloc();
+	struct bb_miiphy_bus *bb_miiphy = bb_miiphy_alloc();
+	struct mii_dev *mdiodev;
 	char *name = bb_miiphy_buses[k].name;
+	int retval;
 
-	if (!mdiodev)
+	if (!bb_miiphy)
 		return -ENOMEM;
+
+	mdiodev = &bb_miiphy->mii;
 	strlcpy(mdiodev->name, name, MDIO_NAME_LEN);
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
 
+	/* Copy the bus accessors, name and private data */
+	bb_miiphy->mdio_active = mii_mdio_active;
+	bb_miiphy->mdio_tristate = mii_mdio_tristate;
+	bb_miiphy->set_mdio = mii_set_mdio;
+	bb_miiphy->get_mdio = mii_get_mdio;
+	bb_miiphy->set_mdc = mii_set_mdc;
+	bb_miiphy->delay = mii_delay;
+	strlcpy(bb_miiphy->name, name, MDIO_NAME_LEN);
+	bb_miiphy->priv = &gpio_mii_set[k];
+
 	retval = mdio_register(mdiodev);
 	if (retval < 0)
 		return retval;
 	*bus = miiphy_get_dev_by_name(name);
 
-	return mii_mdio_init(&bb_miiphy_buses[k]);
+	return mii_mdio_init(bb_miiphy);
 }
 
 struct porttype *get_porttype(uint octo_phy_mask, uint k)
-- 
2.47.2

