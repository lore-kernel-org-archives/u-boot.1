Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843B3C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 485B784AED;
	Fri, 10 Jul 2026 16:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="G3nTTRJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186C684B04; Fri, 10 Jul 2026 16:12:55 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2662F84B04
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493e497643fso6073995e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692772; x=1784297572; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lqPqVIDk7myjOHDdypRPHc0NzCS56g2I88ekVislEN0=;
 b=G3nTTRJYPP7/Tv2cJs2JCMHAPigYyz3cT/OqfnJdD81kNZVe7nPZ8VhZE3xjBOA3vs
 WRXj1i63+ESYx9B7vYX/wckrya8wISPMMPjetVuD0I0iCva3ABElCYgOMQkrfr3zeU+l
 DCHFhVlKGUGd4j4sr7Tpo0tv+xVWoEx/dFOFLPJ+9e7l4QKktTMXRsJgSaxz1rwHB/3w
 tQyqKg7av8jrYrAC0XfudjvioyUtM/NgE022xgHvMEIIgCPvc+i25OcLImnO46NhGnPv
 C4RrU0Y/ekcrUH3Sq/7P98vDRz7d6NPesorFCeUqqswb/FweTO/q0Sfd9ISOAOWXIn50
 wSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692772; x=1784297572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lqPqVIDk7myjOHDdypRPHc0NzCS56g2I88ekVislEN0=;
 b=Uw5KuD7WJuqPu2C+b6T+ppYJM6uWKxjtI0RkjZQmKkn+2wDCHaUiMXCqaJda72VtI9
 oTtbTIsGEpA635Z6WtPM1hXzvgkwkmzmwYSz1RK9Fedu5eXVDrWiT4GfdubExFQ4ms5y
 aRL3T0MhXIeNL35Ex3S90OkB9rDCPUaLcMg+Qj/OQ0AYxIYxy4sWBPqDA7gJjyM5FXjb
 8JO788ImhPrLxoDnyZxDDiXmYAVRq9Cuu/d7BDITFI9x6hKj/r3WvHJtRmQVqV+yUTYS
 7vwKn5LABNkTsyeaCFtvC79kdL2iYxvFFI4z+1bUQERN004l2gXz0Dde5oB9LX1yd06o
 +TSw==
X-Gm-Message-State: AOJu0Ywt9LLRt2FvqaYCZ5QePqvNszUGOPqlPi4qgNEKPaZl7c+wL5PP
 is6wM6247YJpc5KmJQJ5ejTZ2IFCmsUg8Ac5kp/653uOUG3K3mfbUsTcROrI/SZWKIE=
X-Gm-Gg: AfdE7cnwIzU5B4GCmh5Dn98GuwymJ9yBlZHCapCgngZ3RYC3iPYUyAJiQ+GjKUMDiTe
 xCu4jT7hLncr9YiDAAa38pE6N92bEJVgPDPxtJwCewiL3f2NWbFzRORgDQRucbzxujWHs4P3hRX
 EK5aAoZ9GR7GMoiqOHo8CNaDHSLvu5zNz3VKBy9B5c3F0tw2Io2Ie8MspDoh1yrJiD9lNbqtSDY
 g8L+G6DrHbcGSzbr6VPzMVLxsLDXHOpNUXsm/h8/tR2HHp3vnrYr1zzQV+aVsWgZI0Yosve4ESO
 AUdSdMuNGIZVt45UoMWol51WKBFaqZFFqb+/Ox4mec0xjDXUHibi173+zaJpqaHE88j1rz8NjOT
 NoxnD9bC/AKKSVNhQ/vUogOJDEL9oi7NX5gFUSRA3Gj37gsu4V/GloOOCf7K4TbQDtwhsy5hsD5
 Qw1BoPhnLMb/+FvwWw1ub39pTaJEfvqhvRGAvbREYbLQsLIXfvUyD/0V6M4HCsHO15nu8YWn+DQ
 xaObe+b2aDjK3jzJO0ORfe6yuIyeoqsMhCmtCfTMo2806+/Kw8XB9gFOqNjl6YB+zZrrRQ=
X-Received: by 2002:a05:600c:3496:b0:493:bc4a:c6b4 with SMTP id
 5b1f17b1804b1-493f7499191mr8858795e9.38.1783692772569; 
 Fri, 10 Jul 2026 07:12:52 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:12:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:12:52 +0200
Subject: [PATCH 1/9] clk: mediatek: introduce mtk_gate_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-1-a4b5c491d9bf@baylibre.com>
References: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
In-Reply-To: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

Several MediaTek SoCs expose multiple clock gate controller instances.
Each instance currently requires its own U_BOOT_DRIVER, mtk_clk_tree,
probe() function and struct udevice_id table, even though they all
share the same implementation.

For example, MT8188 defines five nearly identical clock gate drivers,
resulting in a significant amount of duplicated code. As additional clock
gate controllers are introduced, such as those required for HDMI support,
this duplication will continue to grow.

MT8189 already avoids this by using a single generic U_BOOT_DRIVER
shared across all clock gate controller compatibles, with the
SoC-specific information provided through driver data.

Generalize this approach by introducing struct mtk_gate_clk_data,
allowing MediaTek clock gate drivers to share a common driver,
probe() function and clock tree definition while keeping the
SoC-specific data separate. This removes duplicated code and provides a
reusable framework for existing and future MediaTek SoCs.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index e363a375093..545a493572c 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -230,6 +230,17 @@ struct mtk_gate {
 	u32 flags;
 };
 
+struct mtk_gate_clk_data {
+	const struct mtk_gate *gates;
+	int num_gates;
+};
+
+#define MTK_GATE_CLK_DATA(name) \
+static const struct mtk_gate_clk_data name##_data = { \
+	.gates = name,			\
+	.num_gates = ARRAY_SIZE(name)	\
+}
+
 #define GATE_FLAGS(_id, _parent, _regs, _shift, _flags) {	\
 		.id = _id,					\
 		.parent = _parent,				\

-- 
2.54.0

