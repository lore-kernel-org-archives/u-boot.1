Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63595CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB058467E;
	Thu,  4 Jun 2026 01:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+WInUAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1858D8467E; Thu,  4 Jun 2026 01:51:23 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418C280433
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68bd9bf02aeso14676a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530681; x=1781135481; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ieFu1kV3FfSWF1oaZIJF5KNK5PxpLEyVNJcPs9XZ+e8=;
 b=c+WInUAzpPSuHu9SE36utr2HB/stfekCGiU7WdJKTZsxTXA24GWD2MfNVMnspVeJjg
 540q0QWwnlK0fMjNfQNrOnQHdY9Jim7fEb4w1AauPD8nhTst9onCu9+skPJA9+/VmGAn
 1NDBBBawkjFftKXa8WHyJ9QyYdWpEpSTItzrjPh1JGZejMHHH1MXd3S8mlUEX7WRVK5E
 XPmZ4Ibt+vddsi1cydUYW8z8m5jn4ubIo0nvfcCxxX6a0hNMDyIdv7Kub2XdbbGb4iSe
 uSC+sTBFP5anxvBtj8uh/IQof/8vNdszbQko+CUzfJFF1tuxw94p7MxBh9M4jxbUOZnT
 2wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530681; x=1781135481;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ieFu1kV3FfSWF1oaZIJF5KNK5PxpLEyVNJcPs9XZ+e8=;
 b=hdtem4duGukfmF38oNKuUJTHlHCteus2/F1KNpIyqOVuwfhEgVbV9R8J+CnSBoyvO7
 CLdS1rRIgQpAaG7ZelFZ/I2Or0xkPu6yaQjzTGS+uM2lqwXQA5xJl9x52F3Idk2q6Ui2
 ISIPqohoSmOvll61g+sCsDu9mSoaliDdGsciGr1+eS7GyMGfUO9bKHXtTBaNNFfwNSIe
 CfLxox8YR/p5mkEYmrWZgP4YL8lGumpFEuszWxnoNNgupel5BSVvUenXzo3waQEpkJd6
 rHZz7FKhs+Gd/zL4BrAZvgg3QweHD+KUnwD3VfrWMV13FdkLoALxCJHCojIN/NvnUCtT
 V47w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pXS0B+6IvqOpuRCHyr3WlyQst4b8N29sbdzd9kHph3Y4s+0bO8i22K1YBPuE9TTJ3+CLIkzo=@lists.denx.de
X-Gm-Message-State: AOJu0YxONFVF/5gHMKB+bcMIbXV55LFDYUr4mQUcXSsvBvKJMzBV0UkE
 WucSFv5xXsjC90GR8XE15grJc7MMMVU76gkX+ZTFfBbgu2G+7jD3Ftzw
X-Gm-Gg: Acq92OG4Rt50WGVDW7jKJE8eB+OvUtUmfBt5zEL01+Fvo5N+AlVhL9eqbk6SWEAGlaT
 yfGNRlaJpgw8qEnMgoQgVhfy0gAM79zUxpvQ5rMY0MCafDrznp9s0xN7DTNTGJEN60BpkA09n4M
 2PPj0ElN+sYEZHf13Q9HXB/sOObMLLh0+Nk222Xp2NQni+90qHjKTOPWeD9KhwAsMNxibFs1iVM
 KEoD24GcxJ3a7qrkgZFRBSvzGf7HWA4dAo8QhoXpWvGE+/7L+XZ5vA8RCU4iQ6FV89ndb+15IU8
 KEKZaheFqQoV34C3olcnyFt+JLSWNKAL+t14L1mtjZffdEyLLLj2Q2ijUWuo2F/jRh82ov2wHBE
 Uv+yEvN0zF8zpFszmrVVRBt47OTu6XrryP/TWknJxoBNI9ilzrm3GDgMEpDVP+uvDuat6Y8V0AL
 k/moCElb/SvLP2L575D4CzIlNimbtoWsANg6QfynApwAuu9IxPLk3MsS2EZeRFsp2+z/Nno1Si
X-Received: by 2002:a17:907:c0f:b0:bcd:1afc:2603 with SMTP id
 a640c23a62f3a-bf2271871d6mr9352366b.6.1780530680516; 
 Wed, 03 Jun 2026 16:51:20 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0517707a9sm228338166b.10.2026.06.03.16.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:51:19 -0700 (PDT)
Message-ID: <539f0517-da60-4f02-844d-9022238fa479@gmail.com>
Date: Thu, 4 Jun 2026 01:51:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 09/10] arm: dts: rockchip: add USB required properties in
 SPL for mk808
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
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

