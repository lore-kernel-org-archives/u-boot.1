Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E37CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5DD1848D1;
	Mon, 15 Jun 2026 23:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UI7uv3H1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B39848F0; Mon, 15 Jun 2026 23:09:02 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5291F84884
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bec423a2d26so38291366b.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557740; x=1782162540; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ieFu1kV3FfSWF1oaZIJF5KNK5PxpLEyVNJcPs9XZ+e8=;
 b=UI7uv3H1TpwUKoguQFzjNoPrfYj7bk5pW0D62lD4A1fwaP/5rWJl34clUs7TH++ewc
 krdRFr2TFr54TYpYJX65ziLkGIrkPYWjC2Bt6sH9mh6IZ2nfqbF3rAeWtdAl2N2N0g/g
 Cojy3ZxKXAvSi+P6D6u2NV0z2ZwJFl8EsGS9dMTGUD3gE6L7LmtVj76WYrZeN00za0Td
 bXTHRCClA+WukVBs+GPT54QarZs7X1hHmCxcgmO1AImi99x/n395kr0ar2Sgk93XiYPe
 T8t/Mum2nW+SNtSrBY90HuXwduloxoxcXd8hrr8jWmdfKyWpsA9krRX4wZiHnKJtfGbJ
 9mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557740; x=1782162540;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ieFu1kV3FfSWF1oaZIJF5KNK5PxpLEyVNJcPs9XZ+e8=;
 b=rVBUWKS2Zl1n30E/g/M+EUu+/wBxhF1hMcOpXytdVIwG23xvap+XhgrHsdMykSjSWr
 kx32MdoDRWlVO8j9HrMqgCQpKi9AJACqkNCCto72ntaybQ6fj6FnEsLqyTBm9CvsIWVW
 quHaItoMBohLaURnSknhqHG9eIiUeVXVAZ2cam5Cvu9NaNC1Z0u+GzSMUOrMlR1HVaXu
 YyJqePr/6DgsCr8TbxcYUWac24BM9bJUycqyQGs5m0r+SKlVbVSAo3A9YOeqw1I3hRj8
 ow8oUCoO1wLOqg5JB9mRjDCdBgyiZWjJoDlg9O8ivAyK0+QgjHTi+VK13L4N51SkUJzf
 Zb8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9j/7PP8c5hCxJ72mj/7RKtz8n13b5cQ1ZAH4VbuqpE13S10j/l9F/zhrwhVywsGix0y3K3CSg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2L/POm4XC34UEH09luGp27mw4bLO/Ec0xJeDCbxIvmk7c/fDA
 ZSF+jyQfFj7nVQcx2GILS5TCqfTaCATxpLvbyeqckLGKs3SlKnaDphYe
X-Gm-Gg: Acq92OGRE/byZNDXCdfxMXzTZg+AcUzPqZbywxqXo53DipANTE8lio1ezkgLjPGf9iD
 W5Wo0GFkghJt+S6+sYRR/MvrRInNsc+a/66lXHztVpfY6RYO+vGY8KMV0puUwv6aC380j03BeTs
 9BTN3UqO+U8ZE+1RKmCHw7IDIptBX6/xDipSQ1bHERsI8R6slqv6N5rxxdKHP2wM/J7l5xZNzPs
 5Va1KkNds8I0vLYZLVuXK4/y3xufq1xvjoY763W0UIXhHROHTWxNsVi7knVylk5ZABkr8PjMZPs
 lnKZ5D3fdBO7WXacDZkgvOeOsK7Owrc/4Y/jG9CaMATIHyGRgsTIdTWsQYarLLV6V/sWJeA0AJ6
 L/y00Qo0Q7cWpqlxvxnvzSN9yyh6s+cAeGLzEhHp+PPKxHDjjwvRSqco8R6hXTPu+J3RA2qeNKC
 z384rTPlBujd6UJa9uE+4fbLEagLtMNAxredvEjB6DOcwgu5pDK4v5EwtWrpt32w==
X-Received: by 2002:a17:907:7f94:b0:bed:19af:f8a3 with SMTP id
 a640c23a62f3a-bfe2b5ea6admr294293566b.4.1781557739630; 
 Mon, 15 Jun 2026 14:08:59 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb7b6df9bsm544302366b.35.2026.06.15.14.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:08:59 -0700 (PDT)
Message-ID: <31d01ee3-f272-4d81-bc73-321880a4b65a@gmail.com>
Date: Mon, 15 Jun 2026 23:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 09/10] arm: dts: rockchip: add USB required properties in
 SPL for mk808
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Add USB required properties in SPL for mk808.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/dts/rk3066a-mk808-u-boot.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/dts/rk3066a-mk808-u-boot.dtsi b/arch/arm/dts/rk3066a-mk808-u-boot.dtsi
index dd2eff529e99..ab920272407e 100644
--- a/arch/arm/dts/rk3066a-mk808-u-boot.dtsi
+++ b/arch/arm/dts/rk3066a-mk808-u-boot.dtsi
@@ -2,6 +2,12 @@

 #include "rk3066a-u-boot.dtsi"

+/ {
+	chosen {
+		u-boot,spl-boot-order = &mmc0, &usb_host;
+	};
+};
+
 &cru {
 	bootph-all;
 };
@@ -41,3 +47,15 @@
 &uart2 {
 	bootph-all;
 };
+
+&usb_host {
+	bootph-pre-ram;
+};
+
+&usbphy {
+	bootph-pre-ram;
+};
+
+&usbphy1 {
+	bootph-pre-ram;
+};
--
2.39.5

