Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CE8107BCE8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49DD2843F3;
	Fri, 13 Mar 2026 22:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0WmzV2yW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC05B843F3; Fri, 13 Mar 2026 22:56:19 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA6C843D8
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso1858643a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773438975; x=1774043775;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tzAMkF30uJGYuuosoGgxPIhplry6eeRoA59zIXm5inE=;
 b=0WmzV2yWVZUjBughC1+f5Aiv6hJipHljK1w6giaRVW7uUgKXzHy4NBJfPo3CqsVAgS
 drqulsY6pL/jJRVsDOb6HfyrFprGNFmQfPMBxXdFS5s9acpE7VtgAZt9SYuZsRa2ISMU
 EkwACl51a+aIMB8phW1beU+JsMfR5OE/3AGI2XlPXIFcXzW3CQPRcOeKiosqQgDtlPSM
 DU8rGdO8DnoY3UBP4xAehYqZdG+vFaXxUhzO2XN3PGYTF4+hZfsTbnF4ZAB2hd+TRNlD
 skE57yeVMzIFvM73Xd9SvH2ZrZCQS5SKC0Q2Eb5+9LLWgE436lwWqQJTG9lDKAQmc62b
 nisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773438975; x=1774043775;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tzAMkF30uJGYuuosoGgxPIhplry6eeRoA59zIXm5inE=;
 b=n7kuVNe7PZmeacYS7yx/KuUQB844lqgL2qVr9RQh8Y1DBWojx4o19XQ5chlD9aZ6HN
 X7EDrHEbNPSa1SMFBjXumBIHXvC2/L2L7luRPCppYu/AlborguvmcrEiSweS/cLvtrye
 tcq30U5X7ulylUj4wTWXsQ2Qpt8/JEKVOCjL9vlvfP1QFPIeDojPFTzDuuSrQ9I0mEqI
 x69zxfe/wZGvugNZRbnojqt/TPiHf0IZwY49OMbDOFq90L+UFqrD8fmVPPjDthTcChn3
 YfyDKVDh/8jSiXADX17tsW915tRwOefgy2wg/TWaDeC+/lq97S0JjMkmR54JXd/b9Wvu
 py+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcfz+GdAdV/6564uho3U91gw7lgckY2gPtBYBuhtDJEp41oXxXu3dOwow13Ezh8LUvFAKk6H4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzft+Jy0EvJQlXuWQOu4bxlk8fObXiy5fifj7nsTVEDUqBcfEU3
 YBqVPIWMUW9f+EMLLQwemUnodUZTc8iGJXAp4xI46SWeQBOYyAJChUx4eCJB9TazwFk=
X-Gm-Gg: ATEYQzy3hAU8X4ViA3qNO9TXBEvvLniOGB3InotSyPvJpn7fTfUWNTJ8uuf/IDdiqCD
 SWkCZ5VUIQtR+KE4Tv5/7G8nBhxv/SWcidHaNx5ZV5UwJPlsliI/HXyz6wk3umUrrsS/PebBAvt
 wTW9Y7BjCnpQvS3yA+naFQ5f7rnVFTWvqbbooE+Nq63rLSUQgMgrsNrOCyL0Izyo3uZULs2ByCq
 aUZ1CZuDyg8dZzRlVWlkF6p2Sl5v/LF1oZWMufq8UWC6GGVz/ykPeCMFktsE9SNSTePU455ukrG
 ZQE/xL7N7en9LMzCNYso1fwQSYxraaPNsrHk5LjlaC38BXl7NOLoSSqFqdCF5iEIdcay5BssnFC
 BWH/dFKVJA9ApMgaO+no235ebbRfaFoy906Cl68esXfGFb/a8b9kdyOM9nlVNUqt/NvYtKj90ss
 6YaI8aZRl2QyRx4XFfHrkHiRnx
X-Received: by 2002:a05:6830:6489:b0:7d7:551b:aeeb with SMTP id
 46e09a7af769-7d7823345a7mr3588202a34.0.1773438975107; 
 Fri, 13 Mar 2026 14:56:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:bf:9982:ff59:466])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac8e5b4sm7432196a34.12.2026.03.13.14.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:56:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 13 Mar 2026 16:55:36 -0500
Subject: [PATCH 4/4] pinctrl: mediatek: mtk8189: set get_pinconf functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pinctrl-mtk-fix-mt8189-v1-4-607dd37fde37@baylibre.com>
References: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
In-Reply-To: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ah4k47BhomGWmb5lBZKpH8D3L1bXMYn6gtr2KDhqzx0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBptIfzGWrUFTYS2yR6N5Iwx/QueOEAXTZgKE30I
 zC4ZGmYA9eJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabSH8xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADHQIAJ+g8ImCUSQM/hkY5JjHMdBQFK47+yH2iuuFm/k
 vZa6fQsww65dgTaGPi2LKWk+zdsoHP1hg78qCgZaiP6zpi0/LZOwpg3N9lFhMch1vAWMy1uv9gV
 47IDqhGdhn8+etLqLfi0QGGqmLJiuX/IKvzyytRWPStrnIhYyygMar4SIFEX8/ulZ77+4P6uBwo
 KCapinaTxkI7qO0dhOgKjkugGEWAipQNS15CUrBex6f7SLYt5yuhoBVIrI7YqJ2+u0yvRMAlA73
 Ohagt7MxAkvSH2wJN5ZFezAJbEmQCLz3QdhXJ/Q0x1U+Wn6h/qh0ce8KN5+d9wyVC951bSprlUy
 blfU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Set the get_pinconf functions for the mt8189 pinctrl driver. This will
append pinconf bias info to the output of the pinmux status command.
This is useful for debugging pin configuration issues.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8189.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8189.c b/drivers/pinctrl/mediatek/pinctrl-mt8189.c
index 9bcabe03151..b01533ed80b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8189.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8189.c
@@ -1273,18 +1273,21 @@ static const struct mtk_io_type_desc mt8189_io_type_desc[] = {
 		.bias_set = mtk_pinconf_bias_set_pu_pd,
 		.drive_set = mtk_pinconf_drive_set_v1,
 		.input_enable = mtk_pinconf_input_enable_v1,
+		.get_pinconf = mtk_pinconf_get_pu_pd,
 	},
 	[IO_TYPE_GRP1] = {
 		.name = "MSDC",
 		.bias_set = mtk_pinconf_bias_set_pupd_r1_r0,
 		.drive_set = mtk_pinconf_drive_set_v1,
 		.input_enable = mtk_pinconf_input_enable_v1,
+		.get_pinconf = mtk_pinconf_get_pupd_r1_r0,
 	},
 	[IO_TYPE_GRP2] = {
 		.name = "I2C",
 		.bias_set = mtk_pinconf_bias_set_pu_pd_rsel,
 		.drive_set = mtk_pinconf_drive_set_v1,
 		.input_enable = mtk_pinconf_input_enable_v1,
+		.get_pinconf = mtk_pinconf_get_pu_pd_rsel,
 	},
 };
 

-- 
2.43.0

