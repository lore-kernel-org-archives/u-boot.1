Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B60BC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 08:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 095B480E81;
	Fri, 24 Jul 2026 08:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oERaxIUvC0o2; Fri, 24 Jul 2026 08:36:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 135C8811A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784882190;
	bh=2WG8koE0V4X/dhVM4AY9BYU+8CDZBbsIsJwopzgfHSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IyOwTQhximBeHFmocT9njw+8hfRilHqUDXRaPTkqnlfo6MooR9/Q/DmKAHAMTG+3X
	 ja1GaxEaqO6SW9IA5biuIHqY5ARA4vMCNryfbAyemqtUPJ2E5gkM4PACMHN6taL6IR
	 N//if8i4LBpOqGbUrzvYGRRA1FhpkrfpxPsEm3T8YemPNUrmI1iiYltWMCWh1MVPfN
	 WTrTODJiP5qKxoKyPTGydxuiAYXif9wujDPYGERPCc60kw7pfKk/zpCwCPFpc7cAsv
	 3KxRoIHpTzF+sUPln2rFQ+SKFz8gXMOYJSyg1mrWIMNfoGZvkldojBP7WxQ9KMmDAJ
	 FfXyWLtIyofFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 135C8811A6;
	Fri, 24 Jul 2026 08:36:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 871CA707
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78EF260AB6
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tijQb9xU4tw6 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 08:36:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A73A860B3E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A73A860B3E
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A73A860B3E
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:36:21 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so6432955e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784882179; x=1785486979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2WG8koE0V4X/dhVM4AY9BYU+8CDZBbsIsJwopzgfHSc=;
 b=Pjyqlydycfh+s+CuGyqzKhG643N/qZqt6NFnaME/Iu6fB2h1xuSoCxvKalJHQMRoHC
 F8YjKNTG4YLl5uRnZDCDF3hdns50AJR1ZH/XQSrYogM2pfgzWqbzjs6/rlvfHsKKGEUX
 5ANN3R82tKqkhoDw5fJ98XqtirjhFYTaWKzSdY1LEJoHSR8AKRurHhrvMmEffOS0tYIr
 i/W4KmJHSxGBnJNMHUws7/8b+AyxL3HJMAqlgzZ1ggjKL6SjO51hzrck/0ukRfacYxem
 h1BBdrO4zzIvXaS7CiKSBLrxCDYxBwTFPgOMbwtTCncrhcn7UqHhXG1tYYk1stTqwt7G
 ce6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuZrHivGciwh3OdaZu9x+m792sHaA0Vx6MoK7+DbTsgfLwX4NYNY3mTO9nuIKy0pUXhNvASWs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzRmXbYe6XGXthpe3gtV+6mhqdbvesr/P3JGxU2UpqIHQY9iMqK
 p1Yq7qy7befUEEEgsMgpZVSMLygPMtn9lN5EktB6paVslW8bnRxZozlTaIOeUBygLwMgmfyUoRZ
 PrHjTd/IjKA==
X-Gm-Gg: AR+sD13lqow0MNUxK2kKFSsVoSZFmIOnhRqJ55FbZJF20HnjC9Y7ZoSFvuGt2JcnOKd
 jl40B2Q95URdVgxUDQxmnCwXkK0HO9Bi04pyieIBnQsV5NyLqEKyf4co9PiWebEvVBTq04z5M2B
 xX54Ny8oGgNAHKezy+5wY5AT02mbXf0FX/AvaHRcw7vzK/EAZyjxCp5wNWrryj3C7brirk9PSTV
 WR59dEqveTiosfrBKY+sm0SLn0h1ZukPY8B6ifbh/BmRBuo7gYzcEA5gCThbEJ3FdNphZwa4+aV
 9DfsCbrOekAFvf+yzQwdZnvKP1KW2pD1Dir6d+u8Qu6QVVQrRos6AvzQDjayuXofqS1DzSIGAK5
 VdpqYQUP1ZZJ33DwLmrsg1YvGD8rfL+JYwEgIn1QqQS1uaXLfUzkU038UZpNYaWMaQzBHXXT2Xr
 BSVnvm74uPCoHkTuvX+igvXmo3IV3GOEvWDcWBBKkJ+Onf+vI5+LeeHYpQh91N4ZX21I4e5ECvF
 HtkFmjuKyzbi2LXpuD3R+mTeg==
X-Received: by 2002:a05:600c:4fc2:b0:495:6193:c6c0 with SMTP id
 5b1f17b1804b1-495745b238amr69159885e9.18.1784882179526; 
 Fri, 24 Jul 2026 01:36:19 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-87-0-90-136.retail.telecomitalia.it. [87.0.90.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f5665f0sm15324465e9.0.2026.07.24.01.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:36:19 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 24 Jul 2026 10:36:05 +0200
Subject: [PATCH v2 1/2] clk: mediatek: probe parent providers on demand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ccaione-upstream-fix-clk-probe-v2-1-ebcef2e94e9d@baylibre.com>
References: <20260724-ccaione-upstream-fix-clk-probe-v2-0-ebcef2e94e9d@baylibre.com>
In-Reply-To: <20260724-ccaione-upstream-fix-clk-probe-v2-0-ebcef2e94e9d@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Sam Shih <sam.shih@mediatek.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784882179; x=1785486979;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2WG8koE0V4X/dhVM4AY9BYU+8CDZBbsIsJwopzgfHSc=;
 b=ds1Rj4q6SvbnvVSB09jWkfPs0WylAqohNxJRqUltkJEA+Rw8TpReDGI5mPxmmcQb8X
 RExsNEkMZGv19DmRAPY1TjDPA/WIN9XeAbKJgDVBXAFeeRahWZ0rTC0gYZnyTiIV1HZ4
 gUgoDMZqBQoVB42DbleehV6vnxD1xndnzmrydbnVoSI9kAmFrx5ii7LH+D6PIrjS5knu
 HOHyNJuMof5uk1AU3nxJhlwzg+copTrbx4SZqIYlh4uza4zB9FcX3FNH2FZ8wS8smPYe
 OfI0DhIaFwwH2JF65gqTib4ACwx+ePv8LoIZCZY3yBpAK+yQMlE3j1QHf5MI18gIDg+O
 a5lA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ds1Rj4q6
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

MediaTek clock trees can reference parents provided by a different clock
controller. The provider registry is populated when each controller
probes, so an early consumer can request a parent before its provider has
been registered.

When lookup misses, find the MediaTek clock device whose operations and
clock-tree type match the requested provider, then probe that device.
This removes the probe-order dependency without probing unrelated clock
controllers or treating a driver's bind callback as a type marker.

Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 1da89b3cc48..9d2f2414b27 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -9,6 +9,7 @@
 #include <clk-uclass.h>
 #include <div64.h>
 #include <dm.h>
+#include <dm/device-internal.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -60,6 +61,40 @@ static struct udevice *mtk_clk_tree_get_provider(enum mtk_clk_tree_type type)
 	if (!mtk_clk_tree_type_is_provider(type))
 		return NULL;
 
+	if (!mtk_clk_providers[type]) {
+		struct udevice *dev;
+		struct uclass *uc;
+		int ret;
+
+		/* Lazily probe and register the requested provider. */
+		ret = uclass_get(UCLASS_CLK, &uc);
+		if (ret)
+			return ERR_PTR(ret);
+
+		uclass_foreach_dev(dev, uc) {
+			const struct mtk_clk_tree *tree;
+			const void *ops;
+
+			ops = dev_get_driver_ops(dev);
+			if (ops != &mtk_clk_apmixedsys_ops &&
+			    ops != &mtk_clk_fixed_pll_ops &&
+			    ops != &mtk_clk_topckgen_ops &&
+			    ops != &mtk_clk_infrasys_ops)
+				continue;
+
+			tree = (const void *)dev_get_driver_data(dev);
+			if (tree->type != type)
+				continue;
+
+			/* Probe will add it to mtk_clk_providers[type]. */
+			ret = device_probe(dev);
+			if (ret)
+				return ERR_PTR(ret);
+
+			break;
+		}
+	}
+
 	return mtk_clk_providers[type] ?: ERR_PTR(-ENOENT);
 }
 

-- 
2.55.0

