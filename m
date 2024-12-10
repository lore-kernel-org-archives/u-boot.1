Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7A8E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 12:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A4C89411;
	Tue, 10 Dec 2024 13:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NEa8u6LH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA98897C2; Tue, 10 Dec 2024 07:37:19 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E186892D9
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 07:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso2883319a12.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 22:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733812635; x=1734417435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k583hgjfHDJ5tzWWWzosYA2x1b9nRiqn38S3j4kg96A=;
 b=NEa8u6LH10/sQdcdFIEoi57yPg68SXL2NirbZCBCYilxxdT0gNUzmZHvBK/Ui4WYtr
 4+y/K3MJeqgLoueYYi7Cp7jSBQ8IoehlGJsNA0Ky5fupldj0bwCZZHO68wvby3U1Yqsm
 OP+/eiC8EeaiEVEmdSqtFug14OqCiLvw928qgmp8zJLkGllYzqzP6hcapy+oOjuVzXR/
 xxKBTOZZ91vltnK5yFRFn+QMMjI/MdEyk0OdsJXDlD6ANjpAV2UOnL/a99pyO/smH8sQ
 Csyp72p1qRYAAjEi2/Nw1o/jbjyzQ+TIp2LkvHqwYYfNq6RaGRgsNZyHDdgTnr1RXpu6
 Kl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733812635; x=1734417435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k583hgjfHDJ5tzWWWzosYA2x1b9nRiqn38S3j4kg96A=;
 b=sV3rxjV6XvBrC1lb9E4rwteCylG/CHfVfrNli1Uo0/Ctzwg9peG9OsHE/kpgOxlrtu
 ug83NYFNpXuIYdvrQlrbZ9nACa2qwHXtWXV+3YdaANrVlk9CR85M4VHlfbHnO6KjQtiR
 50i+zxbq7CNf37GlJRTOAjVM78RDaG++ZLiqAGrzk0GdVWj379BbNXYs7DQkWrshFLYK
 PdWqK1c3Ol03Vft43uavyW7d+nrtnvCRL1WDjN+XYvIM0JMDpygrQKANQgLiASMAFWj4
 uRGuEJI8XnWUP8Im5jrjgUrNeV3SRjEyR7YzasaznAyWLs1yF99AqTS/Yilpf8/Jx3rS
 1CVw==
X-Gm-Message-State: AOJu0YzsIVZhauvyu8CseDBqYk6h7ZuiIbGj9GTaUic+Xg1kLgLzPOYy
 UZFhX3S97QAdGJG5c0GY/gf/6nSc/IO6XQNyaA2vknE5n1aq82UZ
X-Gm-Gg: ASbGncsu7epWIIl9uI/dHvxqlyU/J/NNXtQvVYWAjmR8efrCcX4l2ABtd1aohomhPTR
 H6g5JkU7ABnlimHTIZtKVMa8ic25cPrsPn6s0wg2k73I8NlQOPARu0Wf9pAFUfLSOTzInSVSTyj
 thRaR3SMBfeHPEqIYmeesattWMwzjiPQKQmIPFqI0pV+QM4tEsPWqfw7ERG24whbuYPJeaeyj9M
 g5K3gKRenMZMer9Yc7DLzs48vMscs1nmXI7zGIQFKkoyCN4B5YlVXL678qtOtU=
X-Google-Smtp-Source: AGHT+IG26X3IAb+Hujb42M5Vu4raJC9ggXzGJcTvejTioENcY2Yt0VWIh2oUjP53YhIzGQlaqjdhsA==
X-Received: by 2002:a05:6a20:8429:b0:1e0:c954:ea85 with SMTP id
 adf61e73a8af0-1e1870b9335mr26179257637.13.1733812635342; 
 Mon, 09 Dec 2024 22:37:15 -0800 (PST)
Received: from cs20-buildserver.. ([180.217.131.171])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd47f7b9b5sm3502388a12.12.2024.12.09.22.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 22:37:14 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] gpio: npcm: Add persist feature to sgpio module
Date: Tue, 10 Dec 2024 14:35:05 +0800
Message-Id: <20241210063505.147762-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Dec 2024 13:51:03 +0100
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

Base on GPIO hog to support sgpio persist enable feature.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v2:
   - rebase to current next and remove common.h
---
 drivers/gpio/npcm_sgpio.c | 151 +++++++++++++++++++++++++++++++++-----
 1 file changed, 134 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/npcm_sgpio.c b/drivers/gpio/npcm_sgpio.c
index 6d73287c0a2..fcc42087d57 100644
--- a/drivers/gpio/npcm_sgpio.c
+++ b/drivers/gpio/npcm_sgpio.c
@@ -4,31 +4,47 @@
  */
 
 #include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
 #include <asm/gpio.h>
+#include <linux/err.h>
 #include <linux/io.h>
+#include <asm/arch/rst.h>
 
 #define MAX_NR_HW_SGPIO		64
-#define	NPCM_CLK_MHZ		8000000
+#define NPCM_SIOX1			24
+#define NPCM_SIOX2			25
 
-#define  NPCM_IOXCFG1		0x2A
-
-#define	NPCM_IOXCTS			0x28
-#define	NPCM_IOXCTS_IOXIF_EN		BIT(7)
-#define	NPCM_IOXCTS_RD_MODE			GENMASK(2, 1)
+#define	NPCM_IOXCTS						0x28
+#define	NPCM_IOXCTS_IOXIF_EN			BIT(7)
+#define	NPCM_IOXCTS_RD_MODE				GENMASK(2, 1)
 #define	NPCM_IOXCTS_RD_MODE_PERIODIC	BIT(2)
 
+#define NPCM_IOXCFG1		0x2A
 #define	NPCM_IOXCFG2		0x2B
 #define	NPCM_IOXCFG2_PORT	GENMASK(3, 0)
 
 #define GPIO_BANK(x)    ((x) / 8)
 #define GPIO_BIT(x)     ((x) % 8)
 
+#define WD0RCR          0x38
+#define WD1RCR          0x3c
+#define WD2RCR          0x40
+#define SWRSTC1         0x44
+#define SWRSTC2         0x48
+#define SWRSTC3         0x4c
+#define TIPRSTC         0x50
+#define CORSTC          0x5c
+
 struct npcm_sgpio_priv {
 	void __iomem *base;
+	struct regmap *rst_regmap;
 	u32 nin_sgpio;
 	u32 nout_sgpio;
 	u32 in_port;
 	u32 out_port;
+	u8 persist[8];
+	u8 siox_num;
 };
 
 struct npcm_sgpio_bank {
@@ -185,7 +201,13 @@ static int npcm_sgpio_get_value(struct udevice *dev, unsigned int offset)
 static int npcm_sgpio_set_value(struct udevice *dev, unsigned int offset,
 				int value)
 {
-	return npcm_sgpio_direction_output(dev, offset, value);
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+	u8 check = priv->persist[GPIO_BANK(offset)];
+
+	if (!!(check & BIT(GPIO_BIT(offset))) == 0)
+		return npcm_sgpio_direction_output(dev, offset, value);
+	else
+		return -EINVAL;
 }
 
 static int npcm_sgpio_get_function(struct udevice *dev, unsigned int offset)
@@ -213,12 +235,10 @@ static void npcm_sgpio_setup_enable(struct npcm_sgpio_priv *gpio, bool enable)
 	iowrite8(reg, gpio->base + NPCM_IOXCTS);
 }
 
-static int npcm_sgpio_init_port(struct udevice *dev)
+static void npcm_sgpio_set_port(struct udevice *dev)
 {
 	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
-	u8 in_port, out_port, set_port, reg, set_clk;
-
-	npcm_sgpio_setup_enable(priv, false);
+	u8 in_port, out_port;
 
 	in_port = GPIO_BANK(priv->nin_sgpio);
 	if (GPIO_BIT(priv->nin_sgpio) > 0)
@@ -230,8 +250,16 @@ static int npcm_sgpio_init_port(struct udevice *dev)
 
 	priv->in_port = in_port;
 	priv->out_port = out_port;
+}
 
-	set_port = (out_port & NPCM_IOXCFG2_PORT) << 4 | (in_port & NPCM_IOXCFG2_PORT);
+static int npcm_sgpio_init_port(struct udevice *dev)
+{
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+	u8 set_port, reg, set_clk;
+
+	npcm_sgpio_setup_enable(priv, false);
+
+	set_port = (priv->out_port & NPCM_IOXCFG2_PORT) << 4 | (priv->in_port & NPCM_IOXCFG2_PORT);
 	set_clk = 0x07;
 
 	iowrite8(set_port, priv->base + NPCM_IOXCFG2);
@@ -242,6 +270,61 @@ static int npcm_sgpio_init_port(struct udevice *dev)
 	return reg == set_port ? 0 : -EINVAL;
 }
 
+static void npcm_sgpio_reset_persist(struct udevice *dev, uint enable)
+{
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+	u8 num;
+
+	if (priv->siox_num == 1)
+		num = NPCM_SIOX2;
+	else
+		num = NPCM_SIOX1;
+
+	if (enable) {
+		regmap_update_bits(priv->rst_regmap, WD0RCR, BIT(num), 0);
+		regmap_update_bits(priv->rst_regmap, WD1RCR, BIT(num), 0);
+		regmap_update_bits(priv->rst_regmap, WD2RCR, BIT(num), 0);
+		regmap_update_bits(priv->rst_regmap, CORSTC, BIT(num), 0);
+		regmap_update_bits(priv->rst_regmap, SWRSTC1, BIT(num), 0);
+		regmap_update_bits(priv->rst_regmap, SWRSTC2, BIT(num), 0);
+		regmap_update_bits(priv->rst_regmap, SWRSTC3, BIT(num), 0);
+		regmap_update_bits(priv->rst_regmap, TIPRSTC, BIT(num), 0);
+	}
+}
+
+static bool is_gpio_persist(struct udevice *dev)
+{
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+	u32 val;
+	int status;
+
+	status = npcm_get_reset_status();
+
+	if (status & PORST)
+		return false;
+	if (status & CORST)
+		regmap_read(priv->rst_regmap, CORSTC, &val);
+	else if (status & WD0RST)
+		regmap_read(priv->rst_regmap, WD0RCR, &val);
+	else if (status & WD1RST)
+		regmap_read(priv->rst_regmap, WD1RCR, &val);
+	else if (status & WD2RST)
+		regmap_read(priv->rst_regmap, WD2RCR, &val);
+	else if (status & SW1RST)
+		regmap_read(priv->rst_regmap, SWRSTC1, &val);
+	else if (status & SW2RST)
+		regmap_read(priv->rst_regmap, SWRSTC2, &val);
+	else if (status & SW3RST)
+		regmap_read(priv->rst_regmap, SWRSTC3, &val);
+	else if (status & TIPRST)
+		regmap_read(priv->rst_regmap, TIPRSTC, &val);
+
+	if (priv->siox_num == 1)
+		return (val && BIT(NPCM_SIOX2));
+	else
+		return (val && BIT(NPCM_SIOX1));
+}
+
 static const struct dm_gpio_ops npcm_sgpio_ops = {
 	.direction_input	= npcm_sgpio_direction_input,
 	.direction_output	= npcm_sgpio_direction_output,
@@ -254,23 +337,57 @@ static int npcm_sgpio_probe(struct udevice *dev)
 {
 	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-	int rc;
+	int rc, i;
+	ofnode node;
+	u32 val[2];
 
 	priv->base = dev_read_addr_ptr(dev);
+	priv->rst_regmap = syscon_regmap_lookup_by_phandle(dev, "syscon-rst");
+	if (IS_ERR(priv->rst_regmap))
+		return -EINVAL;
+
 	ofnode_read_u32(dev_ofnode(dev), "nuvoton,input-ngpios", &priv->nin_sgpio);
 	ofnode_read_u32(dev_ofnode(dev), "nuvoton,output-ngpios", &priv->nout_sgpio);
 
 	if (priv->nin_sgpio > MAX_NR_HW_SGPIO || priv->nout_sgpio > MAX_NR_HW_SGPIO)
 		return -EINVAL;
 
-	rc = npcm_sgpio_init_port(dev);
-	if (rc < 0)
-		return rc;
+	if (!strcmp(ofnode_get_name(dev_ofnode(dev)), "sgpio2@102000"))
+		priv->siox_num = 1;
+	else if (!strcmp(ofnode_get_name(dev_ofnode(dev)), "sgpio1@101000"))
+		priv->siox_num = 0;
+	else
+		return -EINVAL;
 
+	npcm_sgpio_set_port(dev);
 	uc_priv->gpio_count = priv->nin_sgpio + priv->nout_sgpio;
 	uc_priv->bank_name = dev->name;
 
-	npcm_sgpio_setup_enable(priv, true);
+	if (is_gpio_persist(dev)) {
+		ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+			if (ofnode_read_bool(node, "persist-enable")) {
+				rc = ofnode_read_u32_array(node, "gpios", val, 2);
+				if (rc == 0)
+					priv->persist[GPIO_BANK(val[0])] = priv->persist[GPIO_BANK(val[0])] | BIT(GPIO_BIT(val[0]));
+			}
+		}
+		for (i = 0; i < priv->nout_sgpio; i++)
+			npcm_sgpio_set_value(dev, i, 0);
+	} else {
+		rc = npcm_sgpio_init_port(dev);
+		if (rc < 0)
+			return rc;
+
+		ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+			if (ofnode_read_bool(node, "persist-enable"))
+				npcm_sgpio_reset_persist(dev, 1);
+		}
+
+		for (i = 0; i < priv->nout_sgpio; i++)
+			npcm_sgpio_set_value(dev, i, 0);
+
+		npcm_sgpio_setup_enable(priv, true);
+	}
 
 	return 0;
 }
-- 
2.34.1

