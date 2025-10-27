Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD085CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B4D8839A5;
	Mon, 27 Oct 2025 17:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IfLsgXTh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hfPtwWu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F185C839A5; Mon, 27 Oct 2025 17:55:19 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B106836B4
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwKPc5QTcz9tk7;
 Mon, 27 Oct 2025 17:55:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=by7sHy/JZf29ZnmphSBKNzk8tZuyuJIRkC82GObLsYY=;
 b=IfLsgXThwfOeA1w1Gv3IRscKpmO4hLHJuWHF+0320i7Kgp7JSjQqEcd3xR6XQE9jVBZl+L
 dTd5YUoG73CuXk7BlIJUH03UT0W9/Gejl+19X92VpPKADoTv2dDvKDPW1TkCD1JgVF9eIY
 P+HWAAyRBiXbJVurObZO9vAiynXUn9nNtgsgrpxFk/x1wYb83XBylf5OSITOJbSIgVl8+x
 jcolApFKiaVtOFODT7NIzSR2ARFRjlYNV/3JFRzeBrsbXztW5D3wG/SClfeWRRvaEyAtMt
 KRZMZ+/l5wnXxPLzc0BFE9P3MOjYSBR0RAtp/7b28pzfqjUOttDoYhppTDqeeg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=by7sHy/JZf29ZnmphSBKNzk8tZuyuJIRkC82GObLsYY=;
 b=hfPtwWu5AG9gGAA4gjhpy8dzlBg/JDmtvBqIS9PkbtXpvpZGISJuQU7+qb7KQo3fGkefQO
 f2gniO0jaOeABUzohmslaHHNHnJ5e5iJXvnMTz6SxcNUqAgrGhg0GeUSe0+61NJvrx4x03
 l/dUyG5/c81S0aRXN9Cdi0Bd8HrD1kvHoBNOv/NzJSw+mgl4O7sxqlS6E9evTq86YyVzvM
 dFhmn6q0hPTdNzeq/j56m/+8PgaU/sdsbxcYLYXjed4ma6xiD54Rs45VvzQyfPEK8Eev7t
 hh1dFz0KgbbbhDngx415+e8QTerRyx4xlXrSs2ZFXORlRvyCZpPmLCL1Xmk9Vw==
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Huy Bui <huy.bui.wm@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] pinctrl: renesas: Move drive strength configuration into
 sh_pfc_soc_operations
Date: Mon, 27 Oct 2025 17:53:53 +0100
Message-ID: <20251027165505.20579-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027165505.20579-1-marek.vasut+renesas@mailbox.org>
References: <20251027165505.20579-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7d607d7f851a12faedd
X-MBO-RS-META: exoc47jmkkcozihn5o6z1xk8sbj8h4ud
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

From: Hai Pham <hai.pham.ud@renesas.com>

The upcoming Renesas R-Car Gen5 uses different mapping of bits in DRV
control register, which is incompatible with existing DRV register bit
mapping. Add .set_drive_strength callback into sh_pfc_soc_operations
and call it from sh_pfc_pinconf_set(), to allow each SoC specific PFC
driver to implement replacement .set_drive_strength. Make the current
sh_pfc_pinconf_set_drive_strength() non-static, rename it with rcar_
prefix, and pass it as .set_drive_strength for existing PFC drivers.
This is a preparatory patch for R-Car Gen5, no functional change.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[Marek: Consistently use .set_drive_strength() and pass exisiting
        sh_pfc_pinconf_set_drive_strength() as its parameter for
	all PFC drivers. Rewrite commit message.]
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tam Nguyen <tam.nguyen.xa@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc-r8a7790.c  | 1 +
 drivers/pinctrl/renesas/pfc-r8a7791.c  | 1 +
 drivers/pinctrl/renesas/pfc-r8a7792.c  | 1 +
 drivers/pinctrl/renesas/pfc-r8a7794.c  | 1 +
 drivers/pinctrl/renesas/pfc-r8a77951.c | 1 +
 drivers/pinctrl/renesas/pfc-r8a7796.c  | 1 +
 drivers/pinctrl/renesas/pfc-r8a77965.c | 1 +
 drivers/pinctrl/renesas/pfc-r8a77970.c | 1 +
 drivers/pinctrl/renesas/pfc-r8a77980.c | 1 +
 drivers/pinctrl/renesas/pfc-r8a77990.c | 1 +
 drivers/pinctrl/renesas/pfc-r8a77995.c | 1 +
 drivers/pinctrl/renesas/pfc-r8a779a0.c | 1 +
 drivers/pinctrl/renesas/pfc-r8a779f0.c | 1 +
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 1 +
 drivers/pinctrl/renesas/pfc-r8a779h0.c | 1 +
 drivers/pinctrl/renesas/pfc.c          | 9 ++++++---
 drivers/pinctrl/renesas/sh_pfc.h       | 4 ++++
 17 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7790.c b/drivers/pinctrl/renesas/pfc-r8a7790.c
index 4d6ce06cf16..e986c9fd6c1 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7790.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7790.c
@@ -6186,6 +6186,7 @@ static const struct sh_pfc_soc_operations r8a7790_pfc_ops = {
 	.pin_to_pocctrl = r8a7790_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 #ifdef CONFIG_PINCTRL_PFC_R8A7742
diff --git a/drivers/pinctrl/renesas/pfc-r8a7791.c b/drivers/pinctrl/renesas/pfc-r8a7791.c
index c6d761bb378..90dedd02b69 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7791.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7791.c
@@ -6936,6 +6936,7 @@ static const struct sh_pfc_soc_operations r8a7791_pfc_ops = {
 	.pin_to_pocctrl = r8a7791_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 #ifdef CONFIG_PINCTRL_PFC_R8A7743
diff --git a/drivers/pinctrl/renesas/pfc-r8a7792.c b/drivers/pinctrl/renesas/pfc-r8a7792.c
index d2ff1d9d1a6..fa44028724b 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7792.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7792.c
@@ -3145,6 +3145,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 static const struct sh_pfc_soc_operations r8a7792_pfc_ops = {
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 const struct sh_pfc_soc_info r8a7792_pinmux_info = {
diff --git a/drivers/pinctrl/renesas/pfc-r8a7794.c b/drivers/pinctrl/renesas/pfc-r8a7794.c
index a1fa1776bae..1ee932f9c2e 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7794.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7794.c
@@ -5887,6 +5887,7 @@ static const struct sh_pfc_soc_operations r8a7794_pfc_ops = {
 	.pin_to_pocctrl = r8a7794_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 #ifdef CONFIG_PINCTRL_PFC_R8A7745
diff --git a/drivers/pinctrl/renesas/pfc-r8a77951.c b/drivers/pinctrl/renesas/pfc-r8a77951.c
index 8ddcbfbbd64..99b90e6df0d 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77951.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77951.c
@@ -6184,6 +6184,7 @@ static const struct sh_pfc_soc_operations r8a77951_pfc_ops = {
 	.pin_to_pocctrl = r8a77951_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 #ifdef CONFIG_PINCTRL_PFC_R8A774E1
diff --git a/drivers/pinctrl/renesas/pfc-r8a7796.c b/drivers/pinctrl/renesas/pfc-r8a7796.c
index 7bc9fb709ea..a587dfb89d4 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7796.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7796.c
@@ -6137,6 +6137,7 @@ static const struct sh_pfc_soc_operations r8a7796_pfc_ops = {
 	.pin_to_pocctrl = r8a7796_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 #ifdef CONFIG_PINCTRL_PFC_R8A774A1
diff --git a/drivers/pinctrl/renesas/pfc-r8a77965.c b/drivers/pinctrl/renesas/pfc-r8a77965.c
index 97fde005de6..9049d762a59 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77965.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77965.c
@@ -6378,6 +6378,7 @@ static const struct sh_pfc_soc_operations r8a77965_pfc_ops = {
 	.pin_to_pocctrl = r8a77965_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 #ifdef CONFIG_PINCTRL_PFC_R8A774B1
diff --git a/drivers/pinctrl/renesas/pfc-r8a77970.c b/drivers/pinctrl/renesas/pfc-r8a77970.c
index 3a0a310c5fe..c4fc6c8e09c 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77970.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77970.c
@@ -2567,6 +2567,7 @@ static const struct sh_pfc_soc_operations r8a77970_pfc_ops = {
 	.pin_to_pocctrl = r8a77970_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 const struct sh_pfc_soc_info r8a77970_pinmux_info = {
diff --git a/drivers/pinctrl/renesas/pfc-r8a77980.c b/drivers/pinctrl/renesas/pfc-r8a77980.c
index 59f4bdde202..8fd7e165bbe 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77980.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77980.c
@@ -3084,6 +3084,7 @@ static const struct sh_pfc_soc_operations r8a77980_pfc_ops = {
 	.pin_to_pocctrl = r8a77980_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 const struct sh_pfc_soc_info r8a77980_pinmux_info = {
diff --git a/drivers/pinctrl/renesas/pfc-r8a77990.c b/drivers/pinctrl/renesas/pfc-r8a77990.c
index 75b7429bc0d..3607a559c6d 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77990.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77990.c
@@ -5336,6 +5336,7 @@ static const struct sh_pfc_soc_operations r8a77990_pfc_ops = {
 	.pin_to_pocctrl = r8a77990_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 #ifdef CONFIG_PINCTRL_PFC_R8A774C0
diff --git a/drivers/pinctrl/renesas/pfc-r8a77995.c b/drivers/pinctrl/renesas/pfc-r8a77995.c
index 6fe2d743418..8f2bda5d6d3 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77995.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77995.c
@@ -3210,6 +3210,7 @@ static const struct sh_pfc_soc_operations r8a77995_pfc_ops = {
 	.pin_to_pocctrl = r8a77995_pin_to_pocctrl,
 	.get_bias = r8a77995_pinmux_get_bias,
 	.set_bias = r8a77995_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 const struct sh_pfc_soc_info r8a77995_pinmux_info = {
diff --git a/drivers/pinctrl/renesas/pfc-r8a779a0.c b/drivers/pinctrl/renesas/pfc-r8a779a0.c
index 39690bd5d07..82d39a3b366 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779a0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779a0.c
@@ -4382,6 +4382,7 @@ static const struct sh_pfc_soc_operations r8a779a0_pfc_ops = {
 	.pin_to_pocctrl = r8a779a0_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 const struct sh_pfc_soc_info r8a779a0_pinmux_info = {
diff --git a/drivers/pinctrl/renesas/pfc-r8a779f0.c b/drivers/pinctrl/renesas/pfc-r8a779f0.c
index 2b629135f69..78659eaa187 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779f0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779f0.c
@@ -2094,6 +2094,7 @@ static const struct sh_pfc_soc_operations r8a779f0_pfc_ops = {
 	.pin_to_pocctrl = r8a779f0_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 const struct sh_pfc_soc_info r8a779f0_pinmux_info = {
diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index f411be8b879..ad113cd3e5d 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -4490,6 +4490,7 @@ static const struct sh_pfc_soc_operations r8a779g0_pin_ops = {
 	.pin_to_pocctrl = r8a779g0_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 const struct sh_pfc_soc_info r8a779g0_pinmux_info = {
diff --git a/drivers/pinctrl/renesas/pfc-r8a779h0.c b/drivers/pinctrl/renesas/pfc-r8a779h0.c
index 87af037a8d3..d6c2fbcf854 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779h0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779h0.c
@@ -4143,6 +4143,7 @@ static const struct sh_pfc_soc_operations r8a779h0_pin_ops = {
 	.pin_to_pocctrl = r8a779h0_pin_to_pocctrl,
 	.get_bias = rcar_pinmux_get_bias,
 	.set_bias = rcar_pinmux_set_bias,
+	.set_drive_strength = rcar_pinconf_set_drive_strength,
 };
 
 const struct sh_pfc_soc_info r8a779h0_pinmux_info = {
diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pfc.c
index dfbb8457bbd..a7fd37a2177 100644
--- a/drivers/pinctrl/renesas/pfc.c
+++ b/drivers/pinctrl/renesas/pfc.c
@@ -743,8 +743,8 @@ sh_pfc_pinconf_find_drive_strength_reg(struct sh_pfc *pfc, unsigned int pin,
 	return NULL;
 }
 
-static int sh_pfc_pinconf_set_drive_strength(struct sh_pfc *pfc,
-					     unsigned int pin, u16 strength)
+int rcar_pinconf_set_drive_strength(struct sh_pfc *pfc,
+				    unsigned int pin, u16 strength)
 {
 	unsigned int offset;
 	unsigned int size;
@@ -831,7 +831,10 @@ static int sh_pfc_pinconf_set(struct sh_pfc_pinctrl *pmx, unsigned _pin,
 		break;
 
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		ret = sh_pfc_pinconf_set_drive_strength(pfc, _pin, arg);
+		if (!pfc->info->ops || !pfc->info->ops->set_drive_strength)
+			return -ENOTSUPP;
+
+		ret = pfc->info->ops->set_drive_strength(pfc, _pin, arg);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/pinctrl/renesas/sh_pfc.h b/drivers/pinctrl/renesas/sh_pfc.h
index 79c6125a0d7..505bc90983f 100644
--- a/drivers/pinctrl/renesas/sh_pfc.h
+++ b/drivers/pinctrl/renesas/sh_pfc.h
@@ -245,6 +245,8 @@ struct sh_pfc_soc_operations {
 			 unsigned int bias);
 	int (*pin_to_pocctrl)(unsigned int pin, u32 *pocctrl);
 	int (*pin_to_portcr)(unsigned int pin);
+	int (*set_drive_strength)(struct sh_pfc *pfc, unsigned int pin,
+				  u16 strength);
 };
 
 struct sh_pfc_soc_info {
@@ -741,5 +743,7 @@ rcar_pin_to_bias_reg(const struct sh_pfc_soc_info *info, unsigned int pin,
 unsigned int rcar_pinmux_get_bias(struct sh_pfc *pfc, unsigned int pin);
 void rcar_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 			  unsigned int bias);
+int rcar_pinconf_set_drive_strength(struct sh_pfc *pfc,
+				    unsigned int pin, u16 strength);
 
 #endif /* __SH_PFC_H */
-- 
2.51.0

