Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114361061B12
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 16:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14C984073;
	Mon, 30 Mar 2026 18:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hq65l263";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC8483D17; Mon, 30 Mar 2026 18:01:37 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401148405B
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 18:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40429b1d8baso1776233fac.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774886494; x=1775491294;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tzAMkF30uJGYuuosoGgxPIhplry6eeRoA59zIXm5inE=;
 b=Hq65l263RzArrY3/xDC/IZf1pYrIq9ceM/m+rBqhNFYCexMPkjJki0Ys82I9OlooV4
 ayWctFQTpJEaG33TNdi2qc0HeLhujSXU1gQRIorwzIsHgqamm/kN5WFR8qXSWaC5yNT9
 vO6bHvXoQdPXTjtqr6Ooiqht6AOnizH7GJ2T+mrIObkqxwb0vd1XYr/ok71vc6jehs5C
 gfYjeQngs2uY/CpMUEz7cxz3p6xbtwnaIZQrQ9D+2hDccgERLMg38GTMbCx6eMi9wQPB
 YOgXdCmFsXmbNrILdjYLIgSW2NLdcxcyPU9rYdrK8BU+Dmu77MGvW5g9Sr2sMndGDp2I
 Nx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886494; x=1775491294;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tzAMkF30uJGYuuosoGgxPIhplry6eeRoA59zIXm5inE=;
 b=pHjDuFNdejdRMOocCLr2IiWIE9V1L6MFU8oaYd6EzSXy66IDSrlk+fFbWwt6/yk2BI
 NhMSZNEjCWgZtBk1L9dxqqDTjwPMHfNPhaXAlYyM1WPv3Iho1K8bt5r8Q592pCxN/E3K
 yActQD8Xj881xFSRpVLSnUdiGiarb1XGwKKVZuu9OGe9FVvR7p7g1LHkbob5uMxo9/4r
 t0ztiL7EKIR/POehjueIxc3VvVx8PEB0P+LvrBfCQL5xze11LXQU9yUfoF42GWvUOK4M
 VG4ywkqhsFzvfThWmVsxWTpLDjO3Uwea7I35NI957Zw8YXHPLntntFs+0Eo+nUAoCULv
 D7HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQbEy2gdq2VOx2vSzeet0EjT+6kwJkYi6sc1QA4hcZ5evgom2JpazvW1jord9lBHLrMDbGrwc=@lists.denx.de
X-Gm-Message-State: AOJu0YypBDETi97dRjlE9EsibqSIL1nhEXp5B+XuG3xCJulUToesm9qk
 zAwdXpPgZ451t4yVyEe7U6g0yUkMVF0Y+Hge8tnlvqz6lil6kC1M9D9JbJ0E6LzX7+4=
X-Gm-Gg: ATEYQzz2Xol3xP8qum9IM6xXR/Ut34IV4wIJMPwalmuHMNbCsEET7vPqJlzjZ/7HGdp
 jh/I/jpLAg3muEP1BHeYnw0z+Cd78+mqUklbWNxDQjyqSIC1OMUYUaHDDvZtty96REGRC9LVkbZ
 z+/U1gSUvMAUOrJMeWtvVkT2leecZ9y+o8Hx8WyU6iDEqe7Ik1J+o6H37SdfW2l5oGwVvGC6Qpo
 6fnpycYQym8kKxjM2pxL5DmnzfZ4dGNUcnukmzb0dFsxbmAX8ShiO9bORN2+qnqAhtbN8nWUPny
 BzbWmTglML2A5gmbUzxHTwUCt6x0ftVaeTOHEd7PJ6BmccF2oG49D64g4PnXIIjVWlG3fq6TAwf
 +PRmqgpl0pJum4KZ5ew/t0Ef689EKLETrwtLcf5xz/yVvRgAmnA0VRwP7r4oHy+Pxh5qT31dReg
 hzwJU8pHThNFnvlCeFvBx4kltpJOll
X-Received: by 2002:a05:6870:b12:b0:41c:3225:f98e with SMTP id
 586e51a60fabf-41cec091e9bmr6929830fac.2.1774886493476; 
 Mon, 30 Mar 2026 09:01:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d048e1984sm5432952fac.4.2026.03.30.09.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 09:01:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 11:00:36 -0500
Subject: [PATCH v2 4/4] pinctrl: mediatek: mtk8189: set get_pinconf functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pinctrl-mtk-fix-mt8189-v2-4-05a737ec623d@baylibre.com>
References: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
In-Reply-To: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ah4k47BhomGWmb5lBZKpH8D3L1bXMYn6gtr2KDhqzx0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyp5QSrWQTforgHRbmvZUi/dfabMtQz/4ONKid
 7rE8uUZwYyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacqeUBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5dEH/2wpG/R1m9yMnfPvtYk90HYI16n6DtUHkx3b5L1
 eAEcCIErvPjBpAoNSQnvD99DtYsDeHiFzG+EZXbNTTtbNfOBI7DCcu08TCjEIe8zwK63WbOUKRJ
 J122J0LV35X/V/FC9bqWa84nO6WUzyUoMI6AhtfJq7YVosy1Wt7ekhSpgfxTE7ixTLffdhd0j+Q
 VC3xU1VynuFxBYZdhIcMzMrIOoe0VUaW7NLbtUZ8P5dnQIZ64JPAgHHFLBDRuI6cBSnj+XWig53
 wJggEoVi89IE43OyZJ/CCFPfEHgeHIP99IM7NEd7uIfSPZxxVgeal/yLfjkMTUQ1RAvZCsAsqJP
 r0bg=
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

