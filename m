Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC570C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FBDE87650;
	Mon, 18 Dec 2023 22:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1by1WnE8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e64lBvSE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1by1WnE8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e64lBvSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D01C876A4; Mon, 18 Dec 2023 22:03:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C279687509
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5507C1F6E6;
 Mon, 18 Dec 2023 21:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvUCimMaJ6xrQSSzUxalPI2wxDMnSXJwzMxo+y9/IFo=;
 b=1by1WnE818KeyiiUhS0PLD7P0c+SSwVEcIdSwLVDSj6t8vZK9vpPNROZRCB9WlZtgGyGUU
 JlRP9h5PowjYnh5OWRH6KbjZ19MG+Fu3rWcMQ+gET5ljKGaRAtFv2t0gDAtmZGheOkf5pW
 KEDUZYxYceI7JKlWcX6QlIjexymId9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvUCimMaJ6xrQSSzUxalPI2wxDMnSXJwzMxo+y9/IFo=;
 b=e64lBvSEDRhrUCpOd2eVMasuXC6PFNm5B1yOGeNNS+E2HREmMMam1YM4RObadB2tdux/T3
 Galw853x9Gm0wpDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvUCimMaJ6xrQSSzUxalPI2wxDMnSXJwzMxo+y9/IFo=;
 b=1by1WnE818KeyiiUhS0PLD7P0c+SSwVEcIdSwLVDSj6t8vZK9vpPNROZRCB9WlZtgGyGUU
 JlRP9h5PowjYnh5OWRH6KbjZ19MG+Fu3rWcMQ+gET5ljKGaRAtFv2t0gDAtmZGheOkf5pW
 KEDUZYxYceI7JKlWcX6QlIjexymId9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvUCimMaJ6xrQSSzUxalPI2wxDMnSXJwzMxo+y9/IFo=;
 b=e64lBvSEDRhrUCpOd2eVMasuXC6PFNm5B1yOGeNNS+E2HREmMMam1YM4RObadB2tdux/T3
 Galw853x9Gm0wpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB17413C92;
 Mon, 18 Dec 2023 21:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0JQfK7izgGUtZAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Mon, 18 Dec 2023 21:03:52 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v3 7/7] pci: pcie-brcmstb: Add bcm2712 PCIe controller support
Date: Mon, 18 Dec 2023 23:03:41 +0200
Message-ID: <20231218210341.30073-8-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218210341.30073-1-iivanov@suse.de>
References: <20231218210341.30073-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.31 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RLccgikja4sxqnupiwsfdm9q1r)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[11];
 FREEMAIL_TO(0.00)[suse.com,gmail.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.00)[27.73%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1by1WnE8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e64lBvSE
X-Rspamd-Queue-Id: 5507C1F6E6
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

PCIe controller have minor register map difference compared
to bcm2711 variant. Handle this using device specific register
offset.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/pci/pcie_brcmstb.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index cd45f0bee9..d63e715b2e 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -90,7 +90,6 @@
 #define PCIE_MEM_WIN0_LIMIT_HI(win)	\
 	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
 
-#define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
 #define  PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
 
 #define PCIE_MSI_INTR2_CLR				0x4508
@@ -131,6 +130,10 @@
 #define SSC_STATUS_PLL_LOCK_MASK			0x800
 #define SSC_STATUS_PLL_LOCK_SHIFT			11
 
+struct pcie_cfg_data {
+	unsigned long hard_debug_offs;
+};
+
 /**
  * struct brcm_pcie - the PCIe controller state
  * @base: Base address of memory mapped IO registers of the controller
@@ -141,6 +144,7 @@
 struct brcm_pcie {
 	void __iomem		*base;
 
+	struct pcie_cfg_data	*cfg;
 	int			gen;
 	bool			ssc;
 };
@@ -458,7 +462,7 @@ static int brcm_pcie_probe(struct udevice *dev)
 	/* Take the bridge out of reset */
 	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_INIT_MASK);
 
-	clrbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
+	clrbits_le32(base + pcie->cfg->hard_debug_offs,
 		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 
 	/* Wait for SerDes to be stable */
@@ -599,7 +603,7 @@ static int brcm_pcie_remove(struct udevice *dev)
 	setbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_PERST_MASK);
 
 	/* Turn off SerDes */
-	setbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
+	setbits_le32(base + pcie->cfg->hard_debug_offs,
 		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 
 	/* Shutdown bridge */
@@ -620,6 +624,8 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
 	if (!pcie->base)
 		return -EINVAL;
 
+	pcie->cfg = (struct pcie_cfg_data *)dev_get_driver_data(dev);
+
 	pcie->ssc = ofnode_read_bool(dn, "brcm,enable-ssc");
 
 	ret = ofnode_read_u32(dn, "max-link-speed", &max_link_speed);
@@ -636,8 +642,17 @@ static const struct dm_pci_ops brcm_pcie_ops = {
 	.write_config	= brcm_pcie_write_config,
 };
 
+static const struct pcie_cfg_data bcm2711_cfg = {
+	.hard_debug_offs	= 0x4204
+};
+
+static const struct pcie_cfg_data bcm2712_cfg = {
+	.hard_debug_offs	= 0x4304
+};
+
 static const struct udevice_id brcm_pcie_ids[] = {
-	{ .compatible = "brcm,bcm2711-pcie" },
+	{ .compatible = "brcm,bcm2711-pcie", .data = (ulong)&bcm2711_cfg },
+	{ .compatible = "brcm,bcm2712-pcie", .data = (ulong)&bcm2712_cfg },
 	{ }
 };
 
-- 
2.35.3

