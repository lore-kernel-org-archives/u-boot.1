Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538D2C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12E98606D3;
	Fri, 14 Aug 2026 18:29:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5p79JBqyG5N; Fri, 14 Aug 2026 18:29:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 286F760A39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732180;
	bh=2QD0kC/OgUkaV7H1I+kRh5Ie3GxRcLIe2qbXAc2YVCo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zPGMI5qAcXC+S93xEZDkkLFxQgE1aty/5zVLkmFx6Bsmpd9wYyT2qsf0TXZGTqPYK
	 P6CUcfcsGAh9UCzIDonTTFQ9O3G1ffmAInt64iJC4J1b3jhc0Jz6GFA4CCoCKEcwix
	 hZMPOSzEOsneqeW2AzR6UcnGX696AoAoqAACT6O9uJQoLe9Zf+W4WtF3nJUIacuDWa
	 0PDPXLlbLZJ15vuCPHimogwEnsWUgShsFNtSpvB0wTQkwN9j/npfDy1lM1ocb8FLva
	 xf0/D9lpIgF4xGI7niRwP/3wIQK6TY1lpMG37PNpu0PLScDYJNI9+YuP2x7p2cd/u2
	 fC+k4PNZdC4gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 286F760A39;
	Fri, 14 Aug 2026 18:29:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BA473DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2785580EC0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tn1IzMh9GtbE for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:29:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E39C780BE9
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E39C780BE9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=J/vNxSh4
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E39C780BE9
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:29:35 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-902fc790cd5so8490876d6.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732174; x=1787336974;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2QD0kC/OgUkaV7H1I+kRh5Ie3GxRcLIe2qbXAc2YVCo=;
 b=J/vNxSh4BCDh4p9Mb2ZIBQ9ANtbTuC/i2rqViDQlWv4JRG5Lm7STUkJ9HQwJkZXKAI
 kRHNvmxPrBMMEbYl4SVbZo8vf7JcKECOGCayURMRFwvJc1BsH9bHZbqpq/QsuLxz3j4L
 OcMBufWVu6OUAsK2gf+r2ff3tIH1p3jc/kPjMNg8rM3hd+53u47NbY0dWldjbBjGwjsa
 wfBU2FRQf4Pn61AA3Mw+rsIoCP3SH5WjkR6dxynAaIpf3JIF+bx5vl1KaOl8VhVCeZrr
 rzmWRU2cmtzQwLPVo0qLUN/x7nkG63NZsr9NVjkSd7446pQIERs+vlq+FLfDHmJS+Yfa
 tX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732174; x=1787336974;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2QD0kC/OgUkaV7H1I+kRh5Ie3GxRcLIe2qbXAc2YVCo=;
 b=jInv2hJsNwDQZGOnt8RAAue2N+YLiLGRBv6hxWAGcDjnPbKIwsSDS3CSOIAPLwZFRT
 Xflf/wHu756fE/3ozvu2Ra3GrqQtMNnlr4fOhp98h9ZL0H5MqqV3LDGZugjQsWrLd75+
 XverGixSuQpENpjZ3rFcJoCyv5WgL6tDXA/E0kxnflOsNiU+h8lk8Q+ROrNKGMxvVQrM
 wum2HzGN83Be9xLXIsJZZT1EnliFQQSq3pHjPw8RqTiiEqoROU+HGaTeaFZ0HRj9KftE
 nJK2olxLc625zuj+40i4JQ6HLa88/+0h1hNDHEqJE6X+wb7pJGaq9jegv3PMR+E+jvRL
 5rSw==
X-Gm-Message-State: AOJu0Yz7oLf+KHTEPWX/GsUswmVIvqFzPqKD2/T6XpsodPZJMzYDyiUG
 a749S6R698KS5m1C9IzFFETFgAg/vXJ93IjvGC38NTcH0UXwQ74e3l3nmI+saNLWUZc=
X-Gm-Gg: AR+sD1204zZ0LDIicnnlAVyX+O1WpGTI1lJENbEgCXy+rxJR9E2EB2C6kvJDPU+P1i/
 JHOO9MepSBBuVl0LVntlUVWicXKJmPjZcSigPX02br7QEGR3uEha/EzdPmiD9FlIjQKoGWJS80z
 mtitzLLDJOVNwJmXdtld0h8RoIWWux76jDNl7LgnLoQO8r7rmQz6/IemAJLoJMadhgeRboDkk36
 dKcjJ9HBigcKfgIodhCDaJbtnv6lvvHddeX/9Gil74AcesGBsGFAEhiZE13ziuGUghM69ywhdH8
 a20j3mfsXdUlq1QBVtI+s0d0GKcTBL+XbmEPHuEuN9RI3+RdbVv0hUy5k5S04MQq6GlU23bauW5
 FV7dVKrwcHAuYcYqh0G7ZqpZriCA0cnPAn0wGwl9bgO29moPI+8fNIjNHOij4AzuF0wwfs8Szr6
 z0QFUYviyt2C9vON5V71ArHuFYax4UgkXQtNWBH0JpZYOjTc2anpgpiapf/iiARllORyTpYvtJe
 oqQB7HUOg1sKKSgRvDoieLeuh/rVG7w8Io5gTJSHdX3o3kymIYE5vO1
X-Received: by 2002:a05:6214:5702:b0:907:5516:3d61 with SMTP id
 6a1803df08f44-90a91dc0bd3mr108107346d6.21.1786732174571; 
 Fri, 14 Aug 2026 11:29:34 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a921e4f43sm25226426d6.9.2026.08.14.11.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:29:34 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:29:33 -0400
Subject: [PATCH v2] gpio: dwapb_gpio: Enable all clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-gpio-v2-1-7490cc61b337@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIxef2oC/yXMQQ7CIBBA0auQWTsJQ1raeBXjwuJQxwUloMaUc
 HehLt/i/wKZk3CGsyqQ+CNZttBgTgrc4xZWRrk3g9HG6pkI0x4Iu5A0rlE2HN1iifw82WmA1sX
 EXr7H83L9O7+XJ7tXH0GtP65f2PF1AAAA
X-Change-ID: 20260811-rzn1-2026-10-gpio-5cb611f87674
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732173; l=2649;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=iPZ40BE2NeecPLWGZkDPHMve5YnJB2JnqqkqU64lQhA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF5l+CwW5k1OfMNhytttuWYtd+7Nk3Vdk3ss7ZjHl/WdkX4qX80FBMKKQP9vIZaWYLno/3ITOTk
 yLxoARM9znAg=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On some SoC (such as RZ/N1) it is necessary to enable clocks prior to
using the register interface.

Note that the "clocks" property is not required per devicetree binding.
Furthermore there are several devicetrees that lack "clocks" property.

Therefore ignore ENOENT from clk_get_bulk(), but report any other errors.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- split out of the series "Renesas RZ/N1 additional drivers"
  https://lore.kernel.org/u-boot/20260731-rzn1-2026-07-v1-4-af2ce80db9d8@linaro.org/
- add error checking for clk_get_bulk() and clk_enable_bulk().
  Use a helper function to contain this logic.
---
 drivers/gpio/dwapb_gpio.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/dwapb_gpio.c b/drivers/gpio/dwapb_gpio.c
index 7ab48780332..cdb26ff1ffa 100644
--- a/drivers/gpio/dwapb_gpio.c
+++ b/drivers/gpio/dwapb_gpio.c
@@ -7,6 +7,7 @@
 
 #include <asm/gpio.h>
 #include <asm/io.h>
+#include <clk.h>
 #include <dm/device.h>
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
@@ -28,6 +29,7 @@
 
 struct gpio_dwapb_priv {
 	struct reset_ctl_bulk	resets;
+	struct clk_bulk		clks;
 };
 
 struct gpio_dwapb_plat {
@@ -132,12 +134,34 @@ static int gpio_dwapb_reset(struct udevice *dev)
 	return 0;
 }
 
+static int gpio_dwapb_enable_optional_clocks(struct udevice *dev)
+{
+	struct gpio_dwapb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_bulk(dev, &priv->clks);
+	if (ret) {
+		/* Clocks are optional */
+		if (ret != -ENOENT)
+			dev_err(dev, "Failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret)
+		dev_err(dev, "Failed to enable clocks: %d\n", ret);
+
+	return ret;
+}
+
 static int gpio_dwapb_probe(struct udevice *dev)
 {
 	struct gpio_dev_priv *priv = dev_get_uclass_priv(dev);
 	struct gpio_dwapb_plat *plat = dev_get_plat(dev);
 
 	if (!plat) {
+		gpio_dwapb_enable_optional_clocks(dev);
+
 		/* Reset on parent device only */
 		return gpio_dwapb_reset(dev);
 	}
@@ -214,8 +238,10 @@ static int gpio_dwapb_remove(struct udevice *dev)
 	struct gpio_dwapb_plat *plat = dev_get_plat(dev);
 	struct gpio_dwapb_priv *priv = dev_get_priv(dev);
 
-	if (!plat && priv)
+	if (!plat && priv) {
+		clk_release_bulk(&priv->clks);
 		return reset_release_bulk(&priv->resets);
+	}
 
 	return 0;
 }

---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-rzn1-2026-10-gpio-5cb611f87674

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

