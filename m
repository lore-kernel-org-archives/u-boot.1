Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDBAF8FA6A
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE568432A;
	Tue, 21 Apr 2026 14:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dor9wbhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1940C8436C; Tue, 21 Apr 2026 10:08:55 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8FB84378
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=happycpu@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35fb7c1a455so1583834a91.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776758931; x=1777363731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ty1AuVJ60rqNW9oDZzVrfMesTBg9B7KTK4geTZZvpik=;
 b=dor9wbhEJwJir4FsScn6Lld1Bz3j2k/j6Td/tjx1JXSFQnmHgVmgsRrVQGLC5gkm+r
 eJlv2JTiXihPJdHl411OB8dJXfzVmxhvpAgOZvVGL8ViOm5p9ag4SmjnKKTTpRzQQVR8
 GpRwWi0Xuxfrpb0CsOwvfGgCzfFs22Cp3fK0lTV2dCN3jp/DI5wd1F1OxQYxINiYz78b
 IkiR5z857O0IiJ5kyhVkH+JbnmkBgK9RxUHcfAPL/Nln+DLa1cBth5Is1Y/NDF0xy/n/
 fdLLomDXQVfcyLtj4E0FLLHWy6TXdIDc/TvEyf038bgQPxK5Wm6vtJ3t7hjdI1FR1y0s
 ibZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758931; x=1777363731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ty1AuVJ60rqNW9oDZzVrfMesTBg9B7KTK4geTZZvpik=;
 b=bf869PvA64dl1QonRW6OWoyxN2boAly8r+qrTprcq/M+85Y4zhrsz6w7BQmH9M8OCD
 l81USLpOcSuzh1Y49IDcQyNjsARUW6Zt7RZ/Yv65g1r7nm0MTJ+xkwHsd5TvaNYFusAF
 +LwmKnWzJKxMtFbzkv7zO+mK9xQxKtjB6vNUYlSMxOWsk18wQ2NBilep8Rxa+TjTOv6T
 NW0TZZZY9U1R0P41x1q7xMi03rSqNf6wH0n59a1LtvAS5fDUQGKksZwWuoL23S5H1dCE
 6Xdh1JJCKWGvhOvVsbHxjdATw7CxThM6SY8eeq8u6ZOUyLtdLiBKcu8SiFpLiY+giJCu
 W7sg==
X-Gm-Message-State: AOJu0Yy2Rr4Q4JTku920eRM+vTYinBomkjRpnAVRuBldjAoSu+/w5YeN
 28Hb+tu6bgUextJedvS19cAO+PHJ2ohYLrXdVVNRFI3v2NhG9rxI//4r6/jZag==
X-Gm-Gg: AeBDieu4FoPA98PPKPgGm8vqI+qU/muiL/PSoJGoZLmv5O8gxxkn797Qwm4NrVDLi8a
 uyWY4X8+X7cSy9bdAm6o/Z+xtQIXiBNW8KPZ9Gx3zGEl0k0pD/kzPu2TtXGk3OtohjlD22nmkqh
 gBVs0g47gYN1UqZSoy2F/Aqv6SKWsy+QVIb4KQO3ouVr02oPIEB7DIJc5jsRYphsCs3Qcdtw+ej
 9omVxsdMu5bKyAv9Qh8rc0v1PsreJu+dFfSjHfHZA1a4aGSTD4Jz43hCG0soz/1/lcRiC7hQfdE
 XM2dlnjxlnh8CVSf06B/exIfDj6Ktp8CqbpWXEavJdOQsTYfVX6vIS1EWSjYjsy3gpgS1C55FD9
 IpmUYC5Zhfn66VrCpw/NkmW+90oR/Od8/cnM2dVSk8HcODgmljIjReM4CWwWnk5RAfkj0afrzi3
 RbnAY+e1O44xOY4yPpCsUuTJnxJE/J7NEHPDF+C0+jCifBSWL0bqg4ZCUOhP6WTFEO
X-Received: by 2002:a17:90a:e7ca:b0:35d:8fdb:4f36 with SMTP id
 98e67ed59e1d1-3614048a21bmr17510273a91.18.1776758930864; 
 Tue, 21 Apr 2026 01:08:50 -0700 (PDT)
Received: from happycpu-p1.. ([121.160.151.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141973c57sm12547393a91.14.2026.04.21.01.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 01:08:50 -0700 (PDT)
From: Chanhong Jung <happycpu@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	peng.fan@nxp.com
Subject: [PATCH] gpio: 74x164: use dev_read_* APIs for live-tree compatibility
Date: Tue, 21 Apr 2026 17:08:47 +0900
Message-Id: <20260421080847.235789-1-happycpu@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

With CONFIG_OF_LIVE=y, dev_of_offset(dev) does not return a valid
flat-FDT offset, so fdtdec_get_int(gd->fdt_blob, offset, ...) inside
gen_74x164_probe() fails to locate the "registers-number" property and
always falls back to the default value of 1. This results in a 4-chip
74HC595 daisy chain being exposed as only 8 GPIOs instead of 32, and
any consumer referencing offsets >= 8 fails to bind with -ENOENT
("GPIO ... not found" / Error -22).

The "registers-default" property is ignored for the same reason, so
any configured power-on output pattern is silently discarded.

Replace the flat-FDT helpers with dev_read_u32_default() and
dev_read_u8_array_ptr(), which correctly walk both live and flat
trees. This matches how other DM GPIO drivers (e.g. pca953x_gpio.c)
read their per-device properties.

Tested on stm32mp153d-ssonic (CONFIG_OF_LIVE=y) with a 4-chip 74HC595
chain: all 32 GPIOs are now exposed, and 16 consumer LED nodes at
offsets 0..31 bind successfully.

Fixes: 9300f711baac ("dm: gpio: introduce 74x164 driver")
Signed-off-by: Chanhong Jung <happycpu@gmail.com>
---
 drivers/gpio/74x164_gpio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/74x164_gpio.c b/drivers/gpio/74x164_gpio.c
index 331428ccdb9..e394d1ce379 100644
--- a/drivers/gpio/74x164_gpio.c
+++ b/drivers/gpio/74x164_gpio.c
@@ -10,7 +10,6 @@
 
 #include <errno.h>
 #include <dm.h>
-#include <fdtdec.h>
 #include <malloc.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
@@ -127,10 +126,9 @@ static int gen_74x164_probe(struct udevice *dev)
 {
 	struct gen_74x164_priv *priv = dev_get_priv(dev);
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	const u8 *defaults;
 	char *str, name[32];
 	int ret;
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
 
 	snprintf(name, sizeof(name), "%s_", dev->name);
 	str = strdup(name);
@@ -141,16 +139,17 @@ static int gen_74x164_probe(struct udevice *dev)
 	 * See Linux kernel:
 	 * Documentation/devicetree/bindings/gpio/gpio-74x164.txt
 	 */
-	priv->nregs = fdtdec_get_int(fdt, node, "registers-number", 1);
+	priv->nregs = dev_read_u32_default(dev, "registers-number", 1);
 	priv->buffer = calloc(priv->nregs, sizeof(u8));
 	if (!priv->buffer) {
 		ret = -ENOMEM;
 		goto free_str;
 	}
 
-	ret = fdtdec_get_byte_array(fdt, node, "registers-default",
-				    priv->buffer, priv->nregs);
-	if (ret)
+	defaults = dev_read_u8_array_ptr(dev, "registers-default", priv->nregs);
+	if (defaults)
+		memcpy(priv->buffer, defaults, priv->nregs);
+	else
 		dev_dbg(dev, "No registers-default property\n");
 
 	ret = gpio_request_by_name(dev, "oe-gpios", 0, &priv->oe,
-- 
2.34.1

