Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058C7C36013
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D4D81EDD;
	Fri, 28 Mar 2025 09:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GA7l3psQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39DE681E13; Fri, 28 Mar 2025 09:53:30 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E6E81E5A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso20651345e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743152007; x=1743756807; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cCOh43Wn2/SswNrB4F3kZAstEVfhFUmmW7JLpm5/blY=;
 b=GA7l3psQeBH0wPMMX5+ulwKVjKRMk6+E/DRbCPAhAB6h+HTYfNyEMUgwU5FJKwRL6V
 Up4ueq/GDOfVWUV9STLHQONgDKUZIx38ZHRnAwnOA2GfbfLeLdmec8+18we35s/HVQmg
 f0ZJ8kW62esNfry9kuZbiYSmwe2vEshmGZNG37xpVITr5MRTEPaZUAIA/MM4VQ+MrZGG
 aoe03bXLTxfzD7s2NRrKmGaD7k0PaRrSVHLmXTjgSRbxOYyROLUOHf+PLriAxVYr/yVZ
 qAiI7rajvwuXF0YzUaI/LYx3ItZKUUfWS/qpABfLrbot4l6ZZvF6mwli9Yv1Zyk+je8u
 /c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743152007; x=1743756807;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCOh43Wn2/SswNrB4F3kZAstEVfhFUmmW7JLpm5/blY=;
 b=KLzs8Q3EMSi0L+gqYKXzpuwfieLP/DH7Zmh3WbR28CNaYTR7oBv48fi+I6nNU8KsjZ
 9c6sfS1LYqmpCchu302bEGNVcfVLsPn0Gfy6qfhh7m+MZJs1Ew0vcLj+/61HIMsybV+W
 ov19ohA/jslHygq7h4PX+mc9shoY6Txg6uJly1WoeksV8Vd6ro3uuJrng5t9Ctq8sFam
 4Vrg9LUGbj+lmSB1D/6oY4B4Cm69y2MDi18gZAk3jtsR1gjYbLS4hiRSZPSp53dv/T0I
 hPV5Vz8VBVtqsl+yqZgeaKNE1uAeeNYJWpSx4gYrX5EmFAb5s2mUAUvTdboQ2zpnBYaz
 0xtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB8LwJODAZRh1GTrE677z2Ap7abWlZJz1g6kfToLknGLtVeMYSTyal7e9PY7ISdMEzfncA4lY=@lists.denx.de
X-Gm-Message-State: AOJu0YwPXxNQz6WOaL4tvu/10/p48tdr/mFpJMYDrWZlH46Auiq91Fg9
 ygJViSt0Wok78WLZWCBxdMxolh1zUsN6TbHWlUkx2Qh3BueVwkBDCuzGNrR9T3g=
X-Gm-Gg: ASbGncvDN9IdS8NF4XQic2hr1+CET8CySkop0L41fTYHtXA30yjbXke0kiKQVYbPTf0
 2VNA/XgrhWc8KzgDc/CVZGKQsM/CBPJyz8TWNg9OhxAQqIrS9EOQhEkjeWuXbjysG8eFR3ntm1g
 W8veKLJ0JVz0NGGbt15enfHhaJp5rDn1j87DospXLWMAcVlm0TxUPZhows5+jpXY9QoSwM/7ExX
 FYlraan85ju2dxfj/ES/VSBzG3/hqYbTmWOl4XQtj601SeO17FXy2Cq6l1PhYyOTQo2qBBQ7NwD
 wmZEypa9mqFaMik4jcigMEjC0yEGlgo4OF++YgTQqw1HODwQr8qcHyCvHu5J9sl0xg==
X-Google-Smtp-Source: AGHT+IFEGuCe8kQULNc3/aM0HXmrpDj9T0ZoaWkEpO5ckIqsJUn0h0RDPzEDy8cNqpd2gk+PdP7Y7A==
X-Received: by 2002:a5d:59a7:0:b0:38d:eb33:79c2 with SMTP id
 ffacd0b85a97d-39ad174e4famr5797098f8f.32.1743152007044; 
 Fri, 28 Mar 2025 01:53:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0basm1969794f8f.63.2025.03.28.01.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:53:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 28 Mar 2025 09:53:23 +0100
Subject: [PATCH 3/4] spmi: msm: introduce SPMI_CHANNEL_VALID flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-topic-sm8x50-spmi-fix-v1-3-a7548d3aef0d@linaro.org>
References: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
In-Reply-To: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WO1pfOUJ1dEJ3V3V2lUFZT0TwpTL1J0zFDO7OiyMAgI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn5mODMjqK/6QJPUJkCCapl5QIEeU/9yyaXKccOmg5
 XtHRihyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+ZjgwAKCRB33NvayMhJ0UMkD/
 4/xVKTBKJ73m1MRurbZOPjhdIBQEZR1BYzFBfOEIS6iBPJAEsAnX0UmUpdz6wS9J+hOIj3yT3wyHOM
 Ex4aeaJ+P/RcYNdFMrJRAEuX1Ba2HlHhB3YxS9RPaUjZ1Uf5LCF5sgufKcYXUVMXW3ixQNzBC5XDDP
 DtdHqeyN+GZHr+trsbBEgxWPFsEdgyAL9DtUaw1WTFNBTrrMfmzt1TWqR3vCzb7MqaFSVuKVvaYFIx
 JPgDNNrZFU0/Cbtab4ByMuWy7kv6NFzZnBr76xSyTdCq/iAaBzYd0hA4/VdvkS4Yzp6WidlAkpKPSc
 reYI9ypGm6Smgmdjnm8SlJM9wzmClacW5geb7R5ukweaQZb+dw9TzWf1KoyBjBF7BTLAhlFM+Cp68M
 fXMlnEQ+q5TBpwsWMuQsssvdk6RBckWrnZhn9X0hhL8d7PVVUPB9xQJ87zaFk3DB9LXSujpeo3qzjA
 uoj0jHggR+Yl9v0auCB+Xa8AVNl2L64e6JOzBT5pqomJDi1T/yDVosSU5qeOBnJDvweHcGKC2KFrTy
 iosC8eTzJDzZgjCILbBR3N9yL2MX/xUtDpzabm6vp5Ih+p4FX/HkL6ydQ6gztouRgq+l1JdlopUA1W
 8aYO+dlt6sou19iK3p75NKtNDvsSuM+RJbySpR0cDtBwIbZYz2ctNon3cyjA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Introduce the SPMI_CHANNEL_VALID flag so we can check if
a mapping exists for a SPMI command.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/spmi/spmi-msm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 9b2be1c1b9e381985b621297774500dd97844963..ee3feaf8b5049d51665330a63110ed4949e59bd6 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -63,6 +63,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define SPMI_MAX_PERIPH 256
 
 #define SPMI_CHANNEL_READ_ONLY	BIT(31)
+#define SPMI_CHANNEL_VALID	BIT(30)
 #define SPMI_CHANNEL_MASK	0xffff
 
 enum arb_ver {
@@ -117,6 +118,8 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 		return -EIO;
 	if (pid >= SPMI_MAX_PERIPH)
 		return -EIO;
+	if (!(priv->channel_map[usid][pid] & SPMI_CHANNEL_VALID))
+		return -EINVAL;
 	if (priv->channel_map[usid][pid] & SPMI_CHANNEL_READ_ONLY)
 		return -EPERM;
 
@@ -186,6 +189,8 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
 		return -EIO;
 	if (pid >= SPMI_MAX_PERIPH)
 		return -EIO;
+	if (!(priv->channel_map[usid][pid] & SPMI_CHANNEL_VALID))
+		return -EINVAL;
 
 	channel = priv->channel_map[usid][pid] & SPMI_CHANNEL_MASK;
 
@@ -256,7 +261,7 @@ static void msm_spmi_channel_map_v5(struct msm_spmi_priv *priv, unsigned int i,
 	uint32_t cnfg = readl(priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i));
 	uint8_t owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
 
-	priv->channel_map[slave_id][pid] = i;
+	priv->channel_map[slave_id][pid] = i | SPMI_CHANNEL_VALID;
 	if (owner != priv->owner)
 		priv->channel_map[slave_id][pid] |= SPMI_CHANNEL_READ_ONLY;
 }
@@ -319,7 +324,7 @@ static int msm_spmi_probe(struct udevice *dev)
 		switch (priv->arb_ver) {
 		case V2:
 		case V3:
-			priv->channel_map[slave_id][pid] = i;
+			priv->channel_map[slave_id][pid] = i | SPMI_CHANNEL_VALID;
 			break;
 
 		case V5:

-- 
2.34.1

