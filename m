Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49542C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A063987D46;
	Fri, 10 May 2024 21:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FZN/51x5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2597587D70; Fri, 10 May 2024 21:36:35 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C9687D43
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6c02=MO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1715369776;
 bh=PsbhjgG/agXRgkGpAyIl4+KXXppYg6p5fw3tIxbEL7Q=;
 b=FZN/51x5YqKquwVmqBvfPHNjgjjmImBT6nOShi96I0pHx6eGxqesJv4NHZ1a47lcydMnTv7oJ
 SMz5Cq6uAMiHj6iS+qmLL0p36t59CKfIg5iiEPmpywtTQ9yXinS0SaVEgi1TFJWoJd6Yl3gfsW0
 ky7zqsaH62d9YLFL7/YPa7G0qsM6jgKhkyYN9cMw96GKqixXkGw0uPYKgfJrprMR1//JrKeTw0e
 HR42rVRnNsh0XBDZ4B0jDlZg7OL8dkmVvqYYQ5K3kprP/4MFE7zwhTgT1CKel1D5ZTLf97gyKHs
 7MegSo1FBkjJmIA3ORiAjkm4Tq81VNoOm9CAcEb2UIHA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Quanyang Wang <quanyang.wang@windriver.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] pinctrl: Fix pinctrl_gpio_get_pinctrl_and_offset()
Date: Fri, 10 May 2024 19:35:51 +0000
Message-ID: <20240510193554.884344-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663e77202e8cb621f9625f01
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

Linux kernel Documentation/devicetree/bindings/gpio/gpio.txt define the
format of the gpio-ranges prop as:

  The format is: <[pin controller phandle], [GPIO controller offset],
                  [pin controller offset], [number of pins]>;

  Example:

      gpio-ranges = <&foo 0 20 10>, <&bar 10 50 20>;

  This means:
  - pins 20..29 on pin controller "foo" is mapped to GPIO line 0..9 and
  - pins 50..69 on pin controller "bar" is mapped to GPIO line 10..29

For this example, a call to pinctrl_gpio_get_pinctrl_and_offset() using
offset 10 incorrectly return pin controller "foo" instead of "bar".

Fix this by using an exclusive range check.

Fixes: d0bb00adccb8 ("pinctrl: fix pinctrl_gpio_get_pinctrl_and_offset for gpio-ranges array")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/pinctrl/pinctrl-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-uclass.c b/drivers/pinctrl/pinctrl-uclass.c
index 245510a96312..6f10150b2a42 100644
--- a/drivers/pinctrl/pinctrl-uclass.c
+++ b/drivers/pinctrl/pinctrl-uclass.c
@@ -210,7 +210,7 @@ pinctrl_gpio_get_pinctrl_and_offset(struct udevice *dev, unsigned offset,
 		pfc_base = args.args[1];
 		pfc_pins = args.args[2];
 
-		if (offset >= gpio_offset && offset <= gpio_offset + pfc_pins)
+		if (offset >= gpio_offset && offset < gpio_offset + pfc_pins)
 			break;
 	}
 
-- 
2.43.2

