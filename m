Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E28CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50EF835B9;
	Tue, 30 Sep 2025 17:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RjwHfB2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9FCC80819; Tue, 30 Sep 2025 17:52:28 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC32834E1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so47030755e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759247546; x=1759852346; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EasvUKQeDRvQG/q1/o8375dZ2ql8KbvaT4Hxlt3pz90=;
 b=RjwHfB2yl0oWUtEZdrpUJxNLiIf+GPDhsZH053y7UJOGtIoUNWLNK1L5BCA5bip4Cf
 rMSlPVa0g8mtY8L0Gj12ifYsyqIk/s9v3buaaq6zaybtRko4RbEQlDxJjh1UjUERewUo
 rV7FzhtOoSVnWrkWDF98wpPquvfiKNuFy7S/QqXh3aEjMnfVrQojswWHoEo+rGxLfvYk
 21oceRzF7gSr9W9AjlaoNWtC9QMWcy9Gc+ReAV9EgKuVvAbV4/3Leqlwr/chzq2zqb8n
 RYMweaFCyxpDE9tA8a/hC6hqMuPcUvMSWiOoucVAKVkqC1aosnlXlIXygEWhZJi6WvdX
 SGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759247546; x=1759852346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EasvUKQeDRvQG/q1/o8375dZ2ql8KbvaT4Hxlt3pz90=;
 b=ZnIwybjEb0j0EeQP7OlrAT3lnjv2HvxA+GGGeTsbBgruvcJx548tSxFBTfpy9nWIGL
 riIz9epBLYzmkJWf57KehW80jTCuRR7rMie/87d+z4B70G8+oXMiUOHfyMVKhopUdw/r
 Q/z0Hp5CrAM9Y2hY+qVtwG/JxfwuOhLVhH+fM5ARhmH3aG69XSIJN7mp5RwoCtKaafua
 ukgNP7RV9rtbjcMDW8bo3qH+W+r/sD5A1t1lDR/NNZce+TiKxVB/GyppUvse/z2SwfWs
 wHkVvXFm2/LPNendZnuzRIX9TLQcUuoNe372DTjWXV7YclLjwqBp9VjuTDjugdzJ7x+z
 Xo+g==
X-Gm-Message-State: AOJu0YwFSIF0e1QdWyx/mr7lNzfcZOJa9knSg3mthDOYftGC+60enVM9
 RqHF6s+IrM/qF1ciFcK5zMKXNfL/J1XXg0bKx1ZXr/f9c5/FiHMsEcZWONMPOFyDRHRE2MZ9cv/
 27XP8
X-Gm-Gg: ASbGncuNCar80A1tPZ5seXrjBCj8u98DHW80BKXTsza1sEjdSb6rP5XjBvbj9IZbpkt
 w8nBG0pRcpc8K3IueNdD7MUjKh3JDHOoC0IaVEwYCLu8N50nYrnNHPiGnKeHZtRNossV2WA58zm
 54cZHrpTFU8EVryYyZ/csx3cYkCJ+ABwT+785D1B1vAyeoqt4HSFuM0b9BqGoaGWXCwecQkmYq+
 asm82HZpdAqRMrJpiWaw+4w1u4HYnZdZwspQkKCMokLLMaXQKSxkOS2hKfzkqeTo+KBOa0hklC5
 4ewA0g5cT0Vf+8LQZtkbjETgTBz3PWEgmuYB5jTJFENUfFXX3yRsoH41Mh/o5JN1TDUh5CIxNAm
 AgE2CYJdpg/K/cbS+f/sYzXgecVNZlxybUhp3zzDMGV7ZLb6HbMB7sVfbyIvNQo0zeL3r4S/e2G
 P9Ea3kg6y+
X-Google-Smtp-Source: AGHT+IFQW/vFm8nvqrzN53RK48yeDjUay6z9dKuajWtkKhnRKAhFiFa2vdCE+koVtrdRGTfFzE6F3A==
X-Received: by 2002:a05:600c:8119:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-46e6128617amr3228215e9.30.1759247545867; 
 Tue, 30 Sep 2025 08:52:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:aed:2018:ed42:d786])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dcacsm64747165e9.2.2025.09.30.08.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 08:52:25 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 30 Sep 2025 16:52:24 +0100
Subject: [PATCH 3/3] usb: musb-new: Cannot test unsigned member to be negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-usb_musb-new-v1-3-be0c9b79a8a0@linaro.org>
References: <20250930-usb_musb-new-v1-0-be0c9b79a8a0@linaro.org>
In-Reply-To: <20250930-usb_musb-new-v1-0-be0c9b79a8a0@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

You cannot test an unsigned member of a struct for being negative, the
test will always fail. Instead assign the return value of
fdtdec_get_int, which returns an int, to a temporary variable declared
as an int, so that it can be tested for being negative before being
assigned to the unsigned struct member.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/musb-new/omap2430.c | 34 +++++++++++++++++++++-------------
 drivers/usb/musb-new/ti-musb.c  | 28 +++++++++++++++++-----------
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/musb-new/omap2430.c b/drivers/usb/musb-new/omap2430.c
index ba600d0110239164ca7c287ba6347e20d9ae2931..7fd6639013a7fcdaaf9aee38bdaddaa82a66f3a5 100644
--- a/drivers/usb/musb-new/omap2430.c
+++ b/drivers/usb/musb-new/omap2430.c
@@ -142,41 +142,49 @@ static int omap2430_musb_of_to_plat(struct udevice *dev)
 	struct omap2430_musb_plat *plat = dev_get_plat(dev);
 	const void *fdt = gd->fdt_blob;
 	int node = dev_of_offset(dev);
+	int ret;
 
 	plat->base = (void *)dev_read_addr_ptr(dev);
 
-	plat->musb_config.multipoint = fdtdec_get_int(fdt, node, "multipoint",
-						      -1);
-	if (plat->musb_config.multipoint < 0) {
+	ret = fdtdec_get_int(fdt, node, "multipoint", -1);
+	if (ret < 0) {
 		pr_err("MUSB multipoint DT entry missing\n");
 		return -ENOENT;
+	} else {
+		plat->musb_config.multipoint = ret;
 	}
 
 	plat->musb_config.dyn_fifo = 1;
-	plat->musb_config.num_eps = fdtdec_get_int(fdt, node, "num-eps", -1);
-	if (plat->musb_config.num_eps < 0) {
+	ret = fdtdec_get_int(fdt, node, "num-eps", -1);
+	if (ret < 0) {
 		pr_err("MUSB num-eps DT entry missing\n");
 		return -ENOENT;
+	} else {
+		plat->musb_config.num_eps = ret;
 	}
 
-	plat->musb_config.ram_bits = fdtdec_get_int(fdt, node, "ram-bits", -1);
-	if (plat->musb_config.ram_bits < 0) {
+	ret = fdtdec_get_int(fdt, node, "ram-bits", -1);
+	if (ret < 0) {
 		pr_err("MUSB ram-bits DT entry missing\n");
 		return -ENOENT;
+	} else {
+		plat->musb_config.ram_bits = ret;
 	}
 
-	plat->plat.power = fdtdec_get_int(fdt, node, "power", -1);
-	if (plat->plat.power < 0) {
+	ret = fdtdec_get_int(fdt, node, "power", -1);
+	if (ret < 0) {
 		pr_err("MUSB power DT entry missing\n");
 		return -ENOENT;
+	} else {
+		plat->plat.power = ret;
 	}
 
-	plat->otg_board_data.interface_type = fdtdec_get_int(fdt, node,
-							     "interface-type",
-							     -1);
-	if (plat->otg_board_data.interface_type < 0) {
+	ret = fdtdec_get_int(fdt, node, "interface-type", -1);
+	if (ret < 0) {
 		pr_err("MUSB interface-type DT entry missing\n");
 		return -ENOENT;
+	} else {
+		plat->otg_board_data.interface_type = ret;
 	}
 
 #if 0 /* In a perfect world, mode would be set to OTG, mode 3 from DT */
diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index 967d0953875f734ceeb4bd4be610f9cc562ce430..bcd31adba522fc55190fc43fd2dbd2dec93a2731 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -86,6 +86,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 	int phys;
 	int ctrl_mod;
 	int usb_index;
+	int ret;
 	struct musb_hdrc_config *musb_config;
 
 	plat->base = devfdt_get_addr_index_ptr(dev, 1);
@@ -108,35 +109,40 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 	musb_config = malloc(sizeof(struct musb_hdrc_config));
 	memset(musb_config, 0, sizeof(struct musb_hdrc_config));
 
-	musb_config->multipoint = fdtdec_get_int(fdt, node,
-						 "mentor,multipoint", -1);
-	if (musb_config->multipoint < 0) {
+	ret = fdtdec_get_int(fdt, node, "mentor,multipoint", -1);
+	if (ret < 0) {
 		pr_err("MUSB multipoint DT entry missing\n");
 		return -ENOENT;
+	} else {
+		musb_config->multipoint = ret;
 	}
 
 	musb_config->dyn_fifo = 1;
 
-	musb_config->num_eps = fdtdec_get_int(fdt, node, "mentor,num-eps",
-					      -1);
-	if (musb_config->num_eps < 0) {
+	ret = fdtdec_get_int(fdt, node, "mentor,num-eps", -1);
+	if (ret < 0) {
 		pr_err("MUSB num-eps DT entry missing\n");
 		return -ENOENT;
+	} else {
+		musb_config->num_eps = ret;
 	}
 
-	musb_config->ram_bits = fdtdec_get_int(fdt, node, "mentor,ram-bits",
-					       -1);
-	if (musb_config->ram_bits < 0) {
+	ret = fdtdec_get_int(fdt, node, "mentor,ram-bits", -1);
+	if (ret < 0) {
 		pr_err("MUSB ram-bits DT entry missing\n");
 		return -ENOENT;
+	} else {
+		musb_config->ram_bits = ret;
 	}
 
 	plat->plat.config = musb_config;
 
-	plat->plat.power = fdtdec_get_int(fdt, node, "mentor,power", -1);
-	if (plat->plat.power < 0) {
+	ret = fdtdec_get_int(fdt, node, "mentor,power", -1);
+	if (ret < 0) {
 		pr_err("MUSB mentor,power DT entry missing\n");
 		return -ENOENT;
+	} else {
+		plat->plat.power = ret;
 	}
 
 	plat->plat.platform_ops = &musb_dsps_ops;

-- 
2.47.3

