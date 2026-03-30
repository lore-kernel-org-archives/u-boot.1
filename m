Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4330F1061B1F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8935583CE3;
	Mon, 30 Mar 2026 22:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qj6qS9x6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E0183EB3; Mon, 30 Mar 2026 22:43:09 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 244E180212
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d9e22176a7so2537338a34.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774903385; x=1775508185;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8y0jKvJc1z6RRKshi7r+1otQiBT4VBNjBLAxXi1QglM=;
 b=Qj6qS9x6+K8FkNEOl+esyve+VvYINDFvMnunlYLEKyo5+tlGMq3pniwHl6ItiUpC7j
 7Z+XX23hKW4he2c9x0vEJQFDoTzJIIJWhjBGnE0cz+S2b3EKhJ/K0nA54i5VxDiyZJM5
 sVd9Cx2H8OIjrf+AZtsWPNW9cdSL8KXQIjv1pDQD3/BgJbUVcTpMxWsEumhlZHCTVf6b
 AC4zH9hOsjhTzXhIi5B64tE34MwJiZm6q6Vf0mtD8sotQaAmgpeOv2Qzwuet1Ing80Pg
 3zUF9pbRB6xPedlUjSLyr5lSPGMSEc3cFMrbcDaM9p/fh+qQB1kc6BHxrGptdxn/u5FH
 uv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903385; x=1775508185;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8y0jKvJc1z6RRKshi7r+1otQiBT4VBNjBLAxXi1QglM=;
 b=q/pGj250fJ1Ai2Kw8NqfbUYY/k2KgVeytmOXhV2k3pzOQbvA38sRyTYiKah0MQMDPY
 +qhaAH28TasbS0JRi5qvPFw4d9E0LAs2qh3CjwszaIG1+RGrb8pcWlfZvAMlJasNdsJF
 v71u0YV1puL3iWPk7n5Yp//PGFn+905E2yQCWHYt74Hvkfliz7OZ1hhfGl3dAjLxKM8+
 GuHWMuy5VXTcAeoAXm2HXc9GrT4ix60CpjwSw8/yOalkRtVzC0ltJv37RzH/haNzGqvK
 caBJOhh5pHNGY054ea8XlCtDQDtiNQg3ks+L47pPgawzY+E7FxMkGQSClgBMzTWIetx+
 EfcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ozcTuhZLChW3+9Gg6bgNpR35aAT3MoRNNfPLD2imjo72QNdPxUtFfeSCX7L+b24Mp1UsS8U=@lists.denx.de
X-Gm-Message-State: AOJu0YyYUA8sdJ9s+XiK1sCVreBI+I0W5wQBxzmLdjkFHeGOLfqCxyvj
 woROvss9rQXbBfELKMVraoD5dc/OOd6V/Sif+zCoFbmCeA7+7nkUCpimgdfK75N9G2Q=
X-Gm-Gg: ATEYQzwzx6er8qTSu6IHD91FSIZo0detn+bAh3sIPu3koJz2fJySD2OasmvotFHuezk
 GVxA7vCzkN40UIaWc75RSM+j0marol3KY+J7lYvSgDI3AN1XkVA85GO3ON1ABpE41Qyvi2eMItJ
 70sEzd51ghk6f5r5SBsNSWf5jwlCXHi4gS3UyHzM38ghXbzou3TSWU4N6uApQ1Fil74CuuFU9RC
 LXQb80h68W5Tu7QcQgG9b/bEsqfAeBgLI+Ud+c+Ahx9imOF4F4GVvKyCx0Ho5sEYQQE8Mqem4A3
 +ie00IWTVbYLkYakhUOlsOl9kMonohvOaP7x8JfwOBywq5OiLtbdG8JNvRfkfaCdBR+iwrg/fdT
 +4UPqtVX6ZBfjhBfTysZy81xAyNLdkLcYc2wSGbk5Brb9cXSgC4rQZChBi4uvJsJXn+Wfzz5MBd
 QCM0Y8Kf8LySTZ9B529wtGTQ72mI7q
X-Received: by 2002:a05:6830:6d50:b0:7d7:fb0f:3e56 with SMTP id
 46e09a7af769-7d9faf5a084mr8003792a34.26.1774903385516; 
 Mon, 30 Mar 2026 13:43:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a384631sm6595736a34.7.2026.03.30.13.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:43:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/6] arm: mediatek: add UFS support for Genio 520/720 EVKs
Date: Mon, 30 Mar 2026 15:42:12 -0500
Message-Id: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1IRmiLVykuYjLaqRhLRkUQ7
 96oy7f4fwflJKxQFzskXkVlihm2LMB/XOwZJWQDGXqYiioc5wF7jjLhkwwunSIHa5z1Lrxagtz
 9EneyXc93c1uX9st+PkdwHH+2rPhGdQAAAA==
X-Change-ID: 20260323-mtk-genio-720-ufs-ed10a1cad8b2
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=l3XN2cbooTdNpF6oV2LDY9hCaMTc2f1ClUlLMin6udM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyuAptpVVElgNJuWbwfyNv1NGPMyt3XBFjnFkk
 mlT8WaK7NWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrgKRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AkBIH/3H29+zdPYYSyKqqw8cIepra0DfPoga4WGq1VVb
 BYmK3eXTm9CzFU3h7Twyo4pET4dR3pX4A9893fVTFOcJXc6U7Nviji76NzkOPC+brd90YCYLvPD
 9ZhjhDKhNFm1PBo7Y2+6GaALe8fGK1WPIeg3B2XGDRlBTX9Z/Zpm9bD90pKsgwFIx+e4QzoxxQk
 Dsd52snWYbmY8s5pDZvqR+7v7zSDPnT+4ym84r5OftYDwb9nJFqKsHiebJs/oW3peLwROMvWNzF
 eMGLoI8PuJ4hJzZ5pvyU1e/935hZrKpD5PjzQj73sB/+vKjiM/Ieoxl6NRKHZmc3og7yFdYrpdO
 Trxo=
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

This series adds support for booting from UFS on the MediaTek Genio 520
and Genio 720 EVKs. The first few patches are adding missing runtime
dependencies. Then we add the required devicetrees and defconfigs.

To apply cleanly, the UFS patches depend on [1] and the devicetree
patches depend on [2].

[1]: https://lore.kernel.org/u-boot/20260318-mt8195-add-ufs-support-v2-8-f18eeeeb0e72@baylibre.com/
[2]: https://lore.kernel.org/u-boot/20260316-mtk-ext-mmc-boot-v1-1-1aae51a44705@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (6):
      ufs: ufs-mediatek: add mt8183-ufshci compatible
      ufs: mediatek: clean up zero terminator
      clk: mediatek: mt8189: add UFS clocks
      arm: dts: mt8189: add UFS nodes
      arm: dts: mediatek: add UFS variant of Genio 520/720 EVK
      config: mediatek: add UFS defconfigs for Genio 520/720 EVKs

 arch/arm/dts/Makefile                      |   5 ++
 arch/arm/dts/mt8189.dtsi                   | 115 +++++++++++++++++++++++++++++
 arch/arm/dts/mt8371-genio-common-ufs.dtso  |  18 +++++
 board/mediatek/MAINTAINERS                 |   4 +
 configs/mt8189-ufs.config                  |   8 ++
 configs/mt8371_genio_520_evk_ufs_defconfig |   4 +
 configs/mt8391_genio_720_evk_ufs_defconfig |   4 +
 drivers/clk/mediatek/clk-mt8189.c          |  44 +++++++++++
 drivers/ufs/ufs-mediatek.c                 |   4 +-
 9 files changed, 204 insertions(+), 2 deletions(-)
---
base-commit: d6c79fe27b2142ba25f2ff05262698bdcc8ad2c9
change-id: 20260323-mtk-genio-720-ufs-ed10a1cad8b2

Best regards,
--  
David Lechner <dlechner@baylibre.com>

