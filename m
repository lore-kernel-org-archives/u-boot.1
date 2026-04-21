Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A600F5A8CA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4468B842E6;
	Tue, 21 Apr 2026 02:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="JyQGchvL";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="f7qsLrwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E97842C7; Tue, 21 Apr 2026 02:04:56 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3978E8412A
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 168911D0027D;
 Mon, 20 Apr 2026 20:04:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 20:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776729892; x=1776816292; bh=A/ZuL7L/tmANoKscO6vBm6eo3uMXI8ER
 xE/10cel69c=; b=JyQGchvLrqDhzzKbwxChw+wkwy+IRu3qxgdCePSK04XXiwIc
 Pe7ARVskQP5KbOkvrJTnmHvKbuZTlgWJZIEXJPRNsdy1yFjBJwxGYqHCNEsZ0BhI
 CyFiVwZ2jQ79GtjdeWiYCQXKx7mwFtmPO9ot27xJOIokBBufnkAMyU2PyElR/4cc
 sdvpI1LmDo9JQOq5mKGbn0LtillBJbXbaqq2PTM25e7iiokGD3wvLNNRocTTyb/u
 15jKa1pTkV8dnDxS30WzRh3Wayb9XAEohBBDVveI+3RUnIRSm3XQxjp5bVy25SVQ
 GqM17G99cBC3k7c9lS6+HmLF2ohzY0p4Hzkuug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776729892; x=
 1776816292; bh=A/ZuL7L/tmANoKscO6vBm6eo3uMXI8ERxE/10cel69c=; b=f
 7qsLrwWyklPVCAT0Ff3kEBMGUn9qhIbZZIwD4tktSuyEc6OyizCSvPmm1KDgtLNe
 BQ68PjIBKLl/+Jac8pFkWvjmpH4iTBAkYhvJQfeyZ0G5bnlwRKIvOU+CjsBJFybk
 RPpySk3F7bRWeC+ULOHdGrmv2hKoDIdwbXUPi5WVuMO/c6xb1CJErHVybLCBBuyy
 /ybcNAbBrd0630PKzzHkGR4DKOrmAFWaI9r1rUJYoz3HZI4vaHDJGJ3owTi/BkNM
 twOy6yhqeFtszo5mZ9Rng185+63zOzHnj6GS/Yp7I8j15ZAmYVVuOgu60DLZy2UK
 IqeWZeEsf5NMJB8/VaP3A==
X-ME-Sender: <xms:JL_maVwpvmNPrIqvVVIz6ecm_dGvtmY-6WeZAn_h2o2MHtiH4mXW3w>
 <xme:JL_maaP5fEfOcf90ULsf_S9m_67oVI--Jpjx9O6X-SA90ki053nezad9vgrWpolb3
 -CEBghHPJHVBnlOST39tArNyQKBFRjoqc6a_S2V-gfC2d2NN10rHA>
X-ME-Received: <xmr:JL_maTnsQrbNwMXlYulqXRpdAFy2VWYeH4XT3JaQ-AKZRdsDBfbfJm3fiY4ull3icRR6F2vta2OZaZ5ddbpZzIWX02wa0CVEVsfkSgo43eFHYIzH6agBKXUC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleeludcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepledp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrih
 esrghmugdrtghomhdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghr
 rhihrdguvgdprhgtphhtthhopehmihgthhgrlhdrshhimhgvkhesrghmugdrtghomhdprh
 gtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhgpdhrtghpthht
 ohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepphgvnhhgrd
 hfrghnsehngihprdgtohhmpdhrtghpthhtoheplhhukhgrshiirdgtiigvtghhohifshhk
 ihesthhhrghumhgrthgvtgdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulh
 hkohdrtghomhdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:JL_maXSA5_5FdNM1C4BsW3BwOgSQA7EXBkMm3F2mO8YEnEEiTOs4rg>
 <xmx:JL_maaXl8FEwLLKC1Sk_RP5Al_P2_iwq38uH3tAP5mFD-8cvIXhpyQ>
 <xmx:JL_maTLsy5P7EwewnfkSHr5--8e1Ou3a8W-71kS3p049aOOB9R2ZuA>
 <xmx:JL_maS22xrEAYhkwHGI1fcqR5sXPlfyx8Pup4ihQuA94rPsG721h-Q>
 <xmx:JL_mac3BECECDmDqTe4la4AaQtEHe17SuHPWAKomTrSXFTny5ing363k>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 20:04:50 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Tue, 21 Apr 2026 10:04:35 +1000
Subject: [PATCH v2 2/8] board: ten64: add fdt fixup to hide usb hub
 topology
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-ten64-add-usb5744-v2-2-eaa81288e393@traverse.com.au>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776729881; l=2517;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=TYf5uMXoikjlmNdpwCRzD5Q2pkqjCgNW6FtGX4XoytU=;
 b=GWk08k2a/5bBxQDGlrsO/IVwy/4149A5mRNYoSF50L0aIO8pvtJ43GtWXJG+sXvLtSn7Hp2Zl
 4Tcke9So8W9A3uqS/CKnnW4lQJZBkBMKWbeVm9uvcRNZXJXhXWRLmDf
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

The USB Hub (microchip,usb5744) can enter a dis-/reconnect loop
if a driver tries to re-initialise the hub over I2C.

On the Ten64 board, this process only needs to be run once
per system reset cycle, which is carried out by U-Boot.

As there are distributions shipping with the affected
driver by default, the best solution is to remove
the USB hub toplogy information from the FDT passed
to the operating system, so the OS won't attempt
to re-initialise the USB hub under any circumstance.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 board/traverse/ten64/ten64.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index d41bd2e9dee..1f531d34fc8 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -186,6 +186,50 @@ void fdt_fixup_board_enet(void *fdt)
 		fdt_status_fail(fdt, offset);
 }
 
+/* The onboard USB hub driver (microchip,usb5744)
+ * can cause a disconnect-reconnect loop if the operating system
+ * attempts to re-initalise the hub after U-Boot has already done it.
+ * (This process only needs to be done once per system RESET cycle)
+ *
+ * To avoid this condition, make the hub topology invisible
+ * to the operating system.
+ * It is also required to remove the hub on boards
+ * without it (RevD).
+ */
+int fdt_fixup_usb_hub(void *fdt)
+{
+	int usb1_hub2744_offset, usb1_hub5744_offset;
+	int i2c_usb5744_offset;
+	int err;
+
+	usb1_hub2744_offset = fdt_path_offset(fdt, "/soc/usb@3110000/hub@1");
+
+	if (usb1_hub2744_offset < 0)
+		return usb1_hub2744_offset;
+
+	err = fdt_del_node(fdt, usb1_hub2744_offset);
+	if (err)
+		return err;
+
+	usb1_hub5744_offset = fdt_path_offset(fdt, "/soc/usb@3110000/hub@2");
+	if (usb1_hub5744_offset < 0)
+		return usb1_hub5744_offset;
+
+	err = fdt_del_node(fdt, usb1_hub5744_offset);
+	if (err)
+		return err;
+
+	i2c_usb5744_offset = fdt_path_offset(fdt, "/soc/i2c@2000000/usb-hub@2d");
+	if (i2c_usb5744_offset < 0)
+		return i2c_usb5744_offset;
+
+	err = fdt_setprop_string(fdt, i2c_usb5744_offset, "status", "disabled");
+	if (err)
+		return err;
+
+	return 0;
+}
+
 /* Called after SoC board_late_init in fsl-layerscape/soc.c */
 int fsl_board_late_init(void)
 {
@@ -251,6 +295,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	fdt_fixup_icid(blob);
 
+	fdt_fixup_usb_hub(blob);
 	return 0;
 }
 

-- 
2.52.0

