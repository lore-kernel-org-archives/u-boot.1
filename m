Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E91BC35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702A281EC9;
	Fri, 14 Mar 2025 17:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W0Fw9NX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D0CC81D0B; Fri, 14 Mar 2025 17:10:16 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2317281E60
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso15568485e9.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741968613; x=1742573413; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m7gY1WwR6KH3cYQj8zYD1g5PogSocjblNij8cGVotGU=;
 b=W0Fw9NX8EJcMG7amR8T6swfcgMEsWUOl+8NC5bVnFOzCl8oSDHJqh74DxGwu+ZQgCz
 RIK+DDmLey2aImAVZWwKkLwCoYKrSLKktfM+CftJCy1ID0M9Hjrxp0SBvqAsRmL9uxBl
 19ZfYqcFGD/PILQzwnOb3DtyWp8zna/CLJORMr6bZw9yAd82kUm1L9k8lefFFjhw+Fw/
 azLn15+4eKDkKxZ575HWipV3dgcnKFYXy5cRanp/0ESxlG0RpHLXNG3hPlrKj2ZjoY0q
 QjIxBq1pZ4B5wmBLhm+t7DXWf3+PPm133AVNgAKxh/smWiTf11ER0sdM9odv70QSiZyh
 xhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968613; x=1742573413;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7gY1WwR6KH3cYQj8zYD1g5PogSocjblNij8cGVotGU=;
 b=NHIiBVX6k6hxHxjs//KgdgRd2pzNsLwpjzv6Wy/fMAWea/d+K/ZxVTt+4ABfJOlnnH
 FnfrwvIRJj/zFy10I0CSoG+bQm4QpZH261AqS9DIHOxthFpQaQsGExvD6ZmnQQRYFeiw
 /LgaTKwFdeigDqxnNSC4QFZM1rz1qZFoqpO3IvDHbmQVQ3FK2S1XBNXygacw088dhZkS
 Ju+DgWWex8u+omq61brdUZ6tlkvdy4g/Mh++S0QD5YNABo1VjPFVIbwQb7pTNaosLi4u
 54Ayf4HhkawqD2r6H9n9Hewo8QS2Zn1ajmueqftBnui7PzFkE3fH3cFt/ltI27IGza04
 dbXw==
X-Gm-Message-State: AOJu0Yx5/SIAxNlB41aXShV8iyff8amnmZMEdAkl2wVsI5t0bGtn1nKS
 lnirOPJPPJLP3o8qD857OT6eYz8x01J37dEQAyxoXxBvHITFUshKd5L2iTrJ40A=
X-Gm-Gg: ASbGncv+A1T3RdoTcdpCgO53GPBHBRpMir/IgxOPq5rlC4XbibBSSRWh0lAhkwZSLNb
 XeLKCbDhbUXDmu36MrZZcGsPquPjf3N65uaLoCeNYFgOzuriewZpim+IXbgyTRx7jGky0xmdTQn
 rSq6YT6JtyreoXKK4BCsjEIKjlLGfJfKattY1L96eLmpyjt+aRafzd/0irLycLW403rTUTDavJf
 LiAuUjdVQsMnXT0P4wi2ifGWyiHRT1hv5yywBtCoDN9ztMQSstLfyDb6QXd0PgoBlLaikoKz+Y+
 k4IssLjn4nkZUWpYs2hM49U80YHG3fk/YBZFioTJ997j5KrhGhBNGWmuAmTT
X-Google-Smtp-Source: AGHT+IE+ud0i2/3FrRkPbPytPHbcw6rqb4hV8s+QmY7TP2ZYrZ8RbDS0R92zqcfOhguu1vy+DJYfkA==
X-Received: by 2002:a05:600c:4fcc:b0:43c:fab3:4fad with SMTP id
 5b1f17b1804b1-43d1ec80ebcmr46109425e9.16.1741968613441; 
 Fri, 14 Mar 2025 09:10:13 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:2b81:563b:c694:c380])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda29esm22035015e9.7.2025.03.14.09.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:10:12 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 14 Mar 2025 16:09:46 +0000
Subject: [PATCH 3/3] i2c: geni: load firmware if required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-geni-load-fw-v1-3-587f25f2812f@linaro.org>
References: <20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org>
In-Reply-To: <20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=O4h31HcZZFiO4Leu/igtmoWvKycGGWqyK/wV8F/7Gck=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn1FTfWq8w+ZqlwIAwpIzdYy394g/QHRHvlAEkW
 rlM+ihk2T6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9RU3wAKCRAFgzErGV9k
 tuXcD/oCnyxd7y6zdfPWccX1efcO62y1Ousv6zO3KFy25ENzHJbd2OrU5AQCXLsspqiggavpKKa
 6/gGLo5THgRbAdSBckXHcmaI1CoAqgpW+c+An3P9oYXzbmZu4f0/JjeDmOgmf0Kzi9kZMXJssGy
 9jB4e2UQtSSGfCK7tYZmt375g4cT/OZ3N2ZiLjTs/mAmTabdgPP6kEteoAzfkbgbyyRWcMmJaea
 hzXHJiy8G1piHIRHLJbg+ZDmqTGyBS9dBEaqWsXz7cKIEZUkNantEKAUM1tn26JVZjNgRwYIFEo
 LcwEn5f3u0tGvDOi5eAhHIEFro9Oym9rpk25CZuEPZ7e56U3usD0wVsODQm45xGI8/gGns7ucTJ
 s+tq87HyzlidHKicZP6z1qZfDWulHhPW//WMh16gISC7Cs7P+DZb7kEWlUfq8eA79XHaIGHf3n0
 lMFZRrntNdSxtEtBb+zhiYvF2eWp5ndBH0pSKt6DhzGlSMVnolAJHWsMa2ybl3H3RaC+AKI2j6p
 VZyuLE9UHA5k6IFjD45vG9dxGpH3k17D5qdL6Uzfm/R+9TOhpn3uesQPpS3MSy+Ik6lWn0bvGdN
 7mQ9UAc/825sVY4P5A6T0F4qQo/byW9jSDqfS0EzbGUPbYAqegZRmyAjdNrC8cfljgtOzmcUmDS
 EtJ47QomcuLFMCA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Load firmware for the peripheral if necessary.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/i2c/geni_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index 4eb41ba852f7790ca646c8ba38f29fdb727fa804..fca0fab7201a2f86ff4a8c12d053297e660c4621 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -21,8 +21,9 @@
 #include <clk.h>
 #include <reset.h>
 #include <time.h>
 #include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
 
 #define SE_I2C_TX_TRANS_LEN		0x26c
 #define SE_I2C_RX_TRANS_LEN		0x270
 #define SE_I2C_SCL_COUNTERS		0x278
@@ -498,8 +499,15 @@ static int geni_i2c_probe(struct udevice *dev)
 	proto = readl(geni->base + GENI_FW_REVISION_RO);
 	proto &= FW_REV_PROTOCOL_MSK;
 	proto >>= FW_REV_PROTOCOL_SHFT;
 
+	if (proto == 0xff) {
+		qcom_geni_load_firmware(geni->base, dev);
+		proto = readl(geni->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+	}
+
 	if (proto != GENI_SE_I2C) {
 		dev_err(dev, "Invalid proto %d\n", proto);
 		geni_i2c_disable_clocks(dev, geni);
 		return -ENXIO;

-- 
2.48.1

