Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77119C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98F9A6065E;
	Mon, 24 Aug 2026 08:14:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OzNSBX70Spls; Mon, 24 Aug 2026 08:14:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787559262;
	bh=/zbOCwavplXSuZRnoFEai6HKF64dxbRsSOnb2k5fbCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iraVkuXQ9LgdLCIk/hOteTXShhNCG4giV9dmOZfD6hrAsdT4x3iMPptLigi/MhKiL
	 FBOK7nu4x5HzLEPF5ZHp+Ls/YGAXkZ++3ghUvOf4r/v0CXY/Bu1xtycklK12QMahs1
	 PH1kTS53rklsmxCW6pyZHDzuZcu6UaICh1/PdeKnD9uD7W+DhnEnfxWi9lzaLuiqR2
	 XZmA+0mZb0OWoFzPbwYoUG+JKGpH9wLepNALhJCGkPvFyPkC87UfHj/r7C07DE6h+s
	 WCG2PYFj9Fggo1nHFB46etpA36xJxV5sOXtuHryAg4uPh3f1actDlZMovrA9rq/aGB
	 xPNrm0ALNhEwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65DE860617;
	Mon, 24 Aug 2026 08:14:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20998396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1314380C8A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0A1VPH5m--kS for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:14:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=wlI77s/0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6121080C85
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:14:18 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so3799338a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787559258; x=1788164058;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/zbOCwavplXSuZRnoFEai6HKF64dxbRsSOnb2k5fbCc=;
 b=wlI77s/0kHNLN6Jd9fJdoSijEJ2zOMcgGz53HmaUeGYgauZskp+FoxeAGD/VjpWh64
 ErEkfp0A6EzHd5IY2da5McsoNq/7+A7HNOFfZ0sSI/FzzV6tvYR8/ns1RSTjXCW0vDyY
 J+nKVBgcr5qGNWtuKujKxdoMAgEulqiSDObQaggvQ1giGs5nk5atBUxvagbKGO5LBTLb
 dXtOFQ/3XMhjBdwRp2MOKsrMMd+XJiRYXsfr7N3n4vV6yRUkNn/djlCVS/OgkMs76UuC
 LtY2bYI/exC7kGN7eWugwxdHDycngHXJ56L4bAVewrZxrDMaYNaeXgeXo3HrFibnoet+
 c+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787559258; x=1788164058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/zbOCwavplXSuZRnoFEai6HKF64dxbRsSOnb2k5fbCc=;
 b=EcnuFFDAioMNexxF9G9pSdX/gXH3HkNOthJiEtan5x/uSDMCr3c4W5fKDBbBzdYth+
 DA+K2UBF8og4l0mgpXpQfjLf9VzC8cjQ6NnwNQEy1fhx7je+nMhXOFFCT1u0sc8AdZx8
 yExI8SRkTAev/+w9U0QuQ1wApqpzDgC/MgNZfiHYAxqz5ksSsaDpuaIF+TVmS6f0UVEr
 wJKnd+ovqyXi34vxDINj0LWrvPy28InrakIjCYrRjfq+7By8uhy6RsYTikcrQkQf/veX
 EF2l9fh/+GCRGlIXR5DX9lh3UDlbZxaoDUSeu5HHXraos37w8jNLrnLMOkHeEKmqQEDe
 Ac0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjpmLimL6J8AFecV0Nj6FIxOaJho3w6gIqT6As9E3RvwsZyWJqtOlTquniKkA+Hw9rmqw++Lo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mR/+1blYAlCGVIcvVUq+FanIO/TAD5A/K0BWxe91eBH9DagSJk
 jiIa2NndTa9o/KMVrWrHSQzSE7K2v3uI7Du0ESxNwlAXbnd/OUeZxXhL11Zl5IuuVRo=
X-Gm-Gg: AR+sD13+WV3D3AIDXbUnsu57mBIR6M/L7l/OpoRt7x8ZtT2gpi5GvZXPFNBZglLiL+V
 5/uHlbyLH+Gicd9gkgrfiSoTzoxsT7WBnDT8vTBmq3MsJTHEwCaU60Jik1K0IyREMYivD+23raR
 RdB3EnUCzwWqLUvnxodOt38QTOatm4WFlplD88jFyrV4Gu0rVfTplZWBHAyER87I95kxxVCO1TN
 yv9gFvDNj7FmoTrMUHdDBWimewqC6doxBiOIES14Uq7ss1cTsBLkDfva9mv/HIcdT5eC4AieYxj
 wec1cUBXgunDRvZ+0yfuu2guRbTbm8q96ynJp/H37KAOSwvFtH15SQDvEP7qeS5yqA12HFIOuiz
 LYLTcnCjdm85M4P8eCpbIyD25A3lLS8R16KRoLzvS9cP1nPLVkEwd9iwWW+mR4B/tXxqQNaFVyy
 tLy24Sh3T7rO1JbQokeuf3k7DCAp9UYE9/FpgJjciTBbj8XDIj4lCV3K+8gO7mXa+z7w61NERGN
 9YBY6eC8gu7rHQmUK/B0mXpttCbfLWuimE4NhYU9kqLczSmZetpIOkjIM8HB+E2jqReVKMdqQjK
 mOVoVAQ3hCcVckr9+WKv7IX8hEkjtsnQB704
X-Received: by 2002:a17:90b:2808:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-395df289c4bmr31110214a91.9.1787559258106; 
 Mon, 24 Aug 2026 01:14:18 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141860df25csm21408153c88.5.2026.08.24.01.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:14:17 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:13:59 +0800
Subject: [PATCH 1/2] pinctrl: k1: fix drive strength configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pinctrl-v1-1-e02ed7e9309f@riscstar.com>
References: <20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com>
In-Reply-To: <20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Yao Zi <me@ziyao.cc>, Huan Zhou <pericycle.cc@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kenrel.org>
X-Mailer: b4 0.15.2
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

Fix drive strength configuration by:
- Using FIELD_PREP() to properly set the PAD_DRIVE mask bits
- Not overriding io_type with IO_TYPE_EXTERNAL for external pins
- Returning the pin number instead of 0 from pinmux_property_set
- Removing redundant zero-initialization of the mask variable

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index a6a22eacac7b..6ed511879daf 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
 #include <dm/read.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -386,10 +387,12 @@ static int spacemit_pinmux_set(struct udevice *dev, unsigned int pin,
 static int spacemit_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
 {
 	u32 pin, mux;
+	int ret;
 
 	pin = spacemit_dt_get_pin(pinmux_group);
 	mux = spacemit_dt_get_pin_mux(pinmux_group);
-	return spacemit_pinmux_set(dev, pin, mux);
+	ret = spacemit_pinmux_set(dev, pin, mux);
+	return ret ? ret : pin;
 }
 
 static const struct pinconf_param spacemit_pinconf_params[] = {
@@ -406,7 +409,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
 	void __iomem *addr;
-	u32 mask = 0;
+	u32 mask;
 	unsigned int io_type;
 	u8 ds;
 	bool found;
@@ -433,7 +436,8 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		for (i = 0; i < priv->nr_io_pins; i++) {
 			if (priv->io_pins[i].pin != pin_selector)
 				continue;
-			io_type = priv->io_pins[i].io_type;
+			if (priv->io_pins[i].io_type != IO_TYPE_EXTERNAL)
+				io_type = priv->io_pins[i].io_type;
 			break;
 		}
 		if (io_type != IO_TYPE_3V3 && io_type != IO_TYPE_1V8) {
@@ -441,7 +445,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			return -EINVAL;
 		}
 		ds = spacemit_get_drive_strength(io_type, argument);
-		clrsetbits_le32(addr, PAD_DRIVE, ds);
+		clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		for (i = 0, found = false; i < priv->nr_io_pins; i++) {

-- 
2.51.0

