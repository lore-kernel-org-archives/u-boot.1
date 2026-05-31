Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA23CD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE3A84701;
	Sun, 31 May 2026 23:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iZmcJwrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4B684825; Sun, 31 May 2026 23:04:33 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02FED840ED
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68bd9bf02aeso479323a12.1
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261471; x=1780866271; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ieFu1kV3FfSWF1oaZIJF5KNK5PxpLEyVNJcPs9XZ+e8=;
 b=iZmcJwrJAWivt8rpN3NX8eeIwNZYzd0YeXU+zy2JAe6pMtxGZL1Wvui1VoTf99sI5J
 +gnHRZQ3QgzUPRU0HXJ5zu5GwKjsJZiyBKyeHBDJKmAfUCcA4wxSSUwD6aLnijKwZCFc
 C8DBM9HeXjFiYYheapPS+QwaMBnwcPrt7bM7+4GRBCI5tGGNI0faYoidvrM+h73dL67e
 MOKb7WKzHXUSpDflcK54f17fmsvxMBmYVsJYo1a6oHcZwpZaFQal2LxHEBjLR/skXhOu
 L2Knv/ZA7usz8iALmSdAwjv4Ft/XQxYmYjxJ7ye/ttUnSfeEtSqQyLb3Za6kBSGmlNQz
 gKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261471; x=1780866271;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ieFu1kV3FfSWF1oaZIJF5KNK5PxpLEyVNJcPs9XZ+e8=;
 b=GUNBD4RzjWRnBpVtPJGXrrXSxgFCNimI+L9a6pJVXY/kjgdvXBP8tF9bbGmkPV3Mhr
 dBpYxxsdFy+qYUIkYksYcwr9yXs+4lul+SrO2HPkEH0LPQ9ReSlre3AQE6J+Lo46qaWl
 3f3ceOv9u3FBmyyRwqrUDfQq4e9aSd5xDm8Z/SadnSq+kbS47tUxUzu7+JeCkqHAnQOv
 paCTy/sN/9LSyWlly+zdQFgS9eb1XC3YRkX+zGGjAi/+2GLLghlRt4RsWMG3iDE94uTc
 3g7nXfjlbbyzk6dPKqenHQbfQdIAgjrD6ELpdS3BcQjbsrWv4sNSXp6qYuCIuajo1l+4
 doYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XHNBMJILBTF3nV2G13XtezD5MR0rN3notkVwwD1W9nXUeS1cp/To66fGBuB6bxNawu9wI0TQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1PWKCY308VF9hrTHehL0q6Vq/LEMS+1DNvtquEYhVdHQwFBNY
 d4HGAnFN5zZlH0pq4H70UuJCAIgpRpbteawn/AcGHAzOKL2HqM4cvKB+
X-Gm-Gg: Acq92OHRmoJRu2pzQfZNC2seAKs6FQyiPL/g3oLI9iaDblnibCFBEhtV+cLs+QRwfUQ
 PqSgJQPM1pCQEz4cUxXGSgGQnSOB02sKktahNpUJ6XujE9ZcH28x1lNzNV8iymUk5aRFMLr1o8N
 qlGhdpSJC83YrDBFckLF2qNUATnVJpQpGH1gTgGecw38dXuPMS6Ln2IGmWEth0UCTW2wUNK4P09
 BmB+BVDN3wAQza7H2/g2XWkcig8yXTh0S6Z6M4FTyVLIezoYpOuJ2fZAz2PaqCAkNPfXS1yxtyu
 O42zmX+rTBSLli/GKb52SMPrajjnN5TlGr9YlkZJjc7QSFKOxZKxieR4uQYc2+KD2HpucwoAPuE
 kUgzIPBjPkzDEkdOlUwYhmWTqJM9BFtcdv7dorak2goNI4tgfNEs7hxs6b2Vs2v5T2M5Pz9IOzy
 NCqQoBDZxKPT7kCECXGfDdRFcFX+FPAhk04ThbTx/IfA1ZsASY0fN3rpSHEqiwqqTcsy5Db52WC
 0+giNOTkFQ=
X-Received: by 2002:a17:906:8452:b0:b9b:1963:2ff2 with SMTP id
 a640c23a62f3a-beaafdebe35mr116889566b.0.1780261471446; 
 Sun, 31 May 2026 14:04:31 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-be9d62cc3b1sm260197266b.42.2026.05.31.14.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:04:31 -0700 (PDT)
Message-ID: <94b81530-0957-4203-a183-7fadd79f0637@gmail.com>
Date: Sun, 31 May 2026 23:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 11/12] arm: dts: rockchip: add USB required properties in
 SPL for mk808
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
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

