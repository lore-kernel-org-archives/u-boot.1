Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF542D5E37A
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 18:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528A789293;
	Sat,  9 Nov 2024 19:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bh5OY+eV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 110058921A; Sat,  9 Nov 2024 19:01:23 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B76E8922D
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 19:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d55f0cf85so2134098f8f.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731175280; x=1731780080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XA68RAvqKHOo6s9eir7rUFmwOpSSbzu5sM3S9VXrzjU=;
 b=Bh5OY+eVzH/HaHlCj7HrEEmlf7PS/u/EJcfkbhynzbt44vCVfDN6xTk9D67RxbUkCp
 VbhDjlZwL6cdyvRaRMH6TUjitoQoOp0ETvRr9SO7HtRBiGPKIY1Vwnm8KUy+Q7XqnvIj
 RUvQX1hfClbP822XWvmOjYw7s1WMz2/jp5hWgQTMN8b9o5gbVaNKs33Jq7FISzN0lyjy
 EPIXEezZHcZjiP/hCOd48UdqWSlgGtkjlyE/iWhZO6HGD/pBClK6Rz1Uli4Rk2v+fQrA
 qRZdaWv5hs3MYKB9d+Y4Y5JirI0Ool3TGzjGSEc+TfHSybb3FPAS5pSzY7+ac7rHXKWx
 oQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731175280; x=1731780080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XA68RAvqKHOo6s9eir7rUFmwOpSSbzu5sM3S9VXrzjU=;
 b=ajUhfVnS5DI2hwqG2grftG+yTooKiCJrs6g9MgxqL6t7S8JQrOwTbN/NpU+koubViU
 kuHj4+wkb6TltuEcN86eSWu4JKnCqn6EVdySJaqvraXh7HbETRviB+Uc9wM7cb/uLQoj
 dROLdh4n1YvaAuHPdQzT56Zd1i9TCvwl5Dx9XI6qikjGYKa/AcOiEpqj3hLRcVWdwzhN
 HmpXHdH9adSC8VRKOoZ4o2/FW5zgzo11tIZ/IB3onwso8uasZaMmBMjHib5lWRZhNXBl
 ixyHyzjZ7N4gUDUjERuxUOtU1558gzfPyFcJbhmqL+3bbUZp/iXHa04sd/WJ0rqvlo1T
 tOng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGl71cKQdTtPNZwywjdkCtDs3nVrSEo3hd1ZGTaUGiQcpwE55wPiUnqCJkJGkzjYFGKbVlj5k=@lists.denx.de
X-Gm-Message-State: AOJu0YxZMI9XefqsnCVs6IzM0mlGnLcaLe0/yvPEQGrcD+LeMc/iGmtl
 oTPfWbun5e8TJp+mB7JI2e5GTehrTO/Lu+tCB5l7k6ScrCsXott1
X-Google-Smtp-Source: AGHT+IEsNwbHThxbAUrlZdtMgkft2OgaCppjSARiZQvYBiZ7TsDt+UyfbyOlWew+DUiXSSGh5/F8YQ==
X-Received: by 2002:a5d:5f4f:0:b0:37c:d1b6:a261 with SMTP id
 ffacd0b85a97d-381f18487f2mr6261391f8f.59.1731175280339; 
 Sat, 09 Nov 2024 10:01:20 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm146095025e9.41.2024.11.09.10.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 10:01:19 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH 7/8] led: update LED boot/activity to new property
 implementation
Date: Sat,  9 Nov 2024 19:00:32 +0100
Message-ID: <20241109180038.10344-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109180038.10344-1-ansuelsmth@gmail.com>
References: <20241109180038.10344-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update LED boot/activity to reference by phandle instead of label and
add to period property the "-ms" suffix.
This is a followup request by dt-schema maintainers that required LED
node to be referenced by a phandle to the node instead of indirectly by
the LED label and for timevalue to have a suffix.

While at it generalize the LED node label parsing since the logic is
common for generic LED bind and LED activity/boot.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/led-uclass.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 05e09909b7d..760750568c0 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -232,16 +232,24 @@ int led_activity_blink(void)
 #endif
 #endif
 
+static const char *led_get_label(ofnode node)
+{
+	const char *label;
+
+	label = ofnode_read_string(node, "label");
+	if (!label && !ofnode_read_string(node, "compatible"))
+		label = ofnode_get_name(node);
+
+	return label;
+}
+
 static int led_post_bind(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
 
 	if (!uc_plat->label)
-		uc_plat->label = dev_read_string(dev, "label");
-
-	if (!uc_plat->label && !dev_read_string(dev, "compatible"))
-		uc_plat->label = ofnode_get_name(dev_ofnode(dev));
+		uc_plat->label = led_get_label(dev_ofnode(dev));
 
 	uc_plat->default_state = LEDST_COUNT;
 
@@ -300,15 +308,21 @@ static int led_post_probe(struct udevice *dev)
 static int led_init(struct uclass *uc)
 {
 	struct led_uc_priv *priv = uclass_get_priv(uc);
+	ofnode led_node;
+	int ret;
 
 #ifdef CONFIG_LED_BOOT
-	priv->boot_led_label = ofnode_options_read_str("boot-led");
-	priv->boot_led_period = ofnode_options_read_int("boot-led-period", 250);
+	ret = ofnode_options_get_by_phandle("boot-led", &led_node);
+	if (!ret)
+		priv->boot_led_label = led_get_label(led_node);
+	priv->boot_led_period = ofnode_options_read_int("boot-led-period-ms", 250);
 #endif
 
 #ifdef CONFIG_LED_ACTIVITY
-	priv->activity_led_label = ofnode_options_read_str("activity-led");
-	priv->activity_led_period = ofnode_options_read_int("activity-led-period",
+	ret = ofnode_options_get_by_phandle("activity-led", &led_node);
+	if (!ret)
+		priv->activity_led_label = led_get_label(led_node);
+	priv->activity_led_period = ofnode_options_read_int("activity-led-period-ms",
 							    250);
 #endif
 
-- 
2.45.2

