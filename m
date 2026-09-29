Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C938CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 08:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FE796073E;
	Tue, 29 Sep 2026 08:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MsiPCp-SiRTj; Tue, 29 Sep 2026 08:50:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD5B460754
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790671844;
	b=j9DdutLDHts8k1i1RklxQyEN6/VHsnCFj8RKmk8kRkPotlsNrL88uvhx1cUcXQQj4L7f
	 FSOBSAhAuZZTm/zT0Aac4jL0N7ptQFq3Xk7JWLU46R4jsm4y2GoMMdsVzMtY/bfsLVPkZ
	 qT//lCJm/2wJDoCxD1eotlSaV4DDx4oMIP1HeNbzCcnFWROI3hrWB6HHlTdtcKWNzaMqi
	 qbN1jEiioNm7ENWbdxu2xZ49JYPt170/hEPST2F90c/bLQAzkqXIHXm5kjUz8eIrcyync
	 SaEGh7/TY2zgbhwWK5ot8X6ez8HA3T4KD/iuQtPMJwxotdj7EJbPtwHeKdFn+70eXhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790671844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wWvobzZ8H2bAG1a2b43C7GTkR9jMUQFibDL7cjTNvgM=;
	b=WQi1KXVwmwnvrRTBYsa/71HpEsrGa48buL4Z3+f/0NQfNe7MwZA4TlVMMuo7O1sSDrsc
	 GC0+lDlDCmnZy0ztcCCbnDgOAajTyLTDq+ysusbTZPxs4PRjG0zeBrOYkdcB2MEUOF57h
	 Jn86nQNmQCcscDgYDjIyfIR28GUIlP01IIZbgMKOX9o0E0dGtKiG1o6tv0DPeqaa20WwC
	 yLsK5XqnrpkcsGpKexR2L4V63go2hj6gwelXofdc8AMeW56pm1BkgPFrqZOz5sUQ2LT2d
	 gcQCwfSqSHfL1YB38Inws1YGsF7waZucu0X91HVj+KZ1vMkcB0MXMEqvM3rvKwItPxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790671844;
	bh=wWvobzZ8H2bAG1a2b43C7GTkR9jMUQFibDL7cjTNvgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UFcraSHmGtYT6NjHTbYmmtBFjOmTKuSJvYGR4RhE0UzM0hVsg3jnMRi+uIYEMAxAw
	 TYY6Tsbz3cfkFFL656m49LlAyJCvlN3FirUx8MwRd1oK/eohTKwOfLh7DpNfac/JOE
	 Frk0bzeSgI3unrI7HZnwUVTdZ5AO7RbRAPELTCtt/Uyl2n0ymzRAE398WXfnbACWzn
	 oKF5ernZJBLqlAF8XCefukHEV9viwp+s1XiWETnQN36Us0IYzhX/XdMNxDGCIGdzgT
	 z4metTBzIfMhEotRIx2XHyNJjM5HgoT0OrDE8q9yDK3heaew9hZaXovtqZ2H0D8/Fg
	 AlhlU3p6ckCyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD5B460754;
	Tue, 29 Sep 2026 08:50:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B483A32A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6656405A1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n5M9_k1o9v0O for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 08:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 54522405FB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790671836;
 b=eVeoXQ7uyOtSs7wEtnhTjSFzR41J2q6PkvKmQnqW5+X+/PRklTJjxiEbWjrDjyVmFsvP
 NqyY2Uojy3qev9OpjlyOtbL1EFPkrb+SbbWlFqZadmw3NxCXaaxbYt1zeMY/ipKF0qBZ1
 1S2a7xHTYHg9uziBD5mj5o1TeSwOCCt0wCQIHCr71rNoSANqV89mDQCyOxnTavB/yBmzw
 /m5qevediKDdHqqfuFfBsND/K0ernPV5J1mVdTB6yH6PDpJtaEQ2HDXv/aiba/J3l8zOf
 ckvbUxH9LsSu4uXuUtsKPxCHXwVIgXdkb49ACZxATZWzTDmwYsQl3SbDMBeUNCCZC6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790671836;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=wWvobzZ8H2bAG1a2b43C7GTkR9jMUQFibDL7cjTNvgM=;
 b=FSFQw480jSicBu18OIb/3YAmYETofKTdaOvXCyBlXhhyS0rtZjGJWJzfZ43mnIMVjVU2
 abJAYDcQVTfAZpKTnD5uE1hDcZEK3zJI+k1KUkUmDPtIr6HezOZFC4cWdNd8rJKikxiJN
 0ARnaIynqFa1T6wacPHeuZRMOHCIUTCGI3oDjk07rxUO6bQaA7Su8d2kz9JlpnizG0ZeF
 gUqDmIBekPoX1G7v9us8BKnl1TEiCnYbAdi5WMrqU+OrSrbbZN7XtTo4ddzSB4RrcVhtM
 yGbPJD6RZdrgnZf0uCW6iFmQdupPXzGRk2WCg6bfiw3acgCGSULXPgyUDG8u9KYgo8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IQJRdrir; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IQJRdrir
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54522405FB
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:36 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ff9642c57so3352665e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790671834; x=1791276634;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wWvobzZ8H2bAG1a2b43C7GTkR9jMUQFibDL7cjTNvgM=;
 b=IQJRdrirYYZUFjIsicN5f+c9Vq0cIix5jUyoecyXKNfkUvy33khBos1e2EOgcr8cV9
 VK2eTYliWEVnRP66JwSIi64j8bC+//H3eKV0Jt8kBuV/1VF6ZucjYUCVEj6CGD1x5Je8
 JlAEe6hd1wTMxwEnN4q/bf+zP7vclQDmaKVg31i4pzBkhFOP+B+c5fW/tdJsh56I50fV
 C8eFPP8ZODFExfBMq4g0uFYZuEM99f8z+uW7IxBxWX8mt57JRQzOXf89qMZ+uh4nod8F
 WYsOv/UlV5WRkY1xWRy00M29tcZI4JK2Yw7JwA50PIV0W/6H8RGzkUty80XsaqWjNIpo
 7CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671834; x=1791276634;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wWvobzZ8H2bAG1a2b43C7GTkR9jMUQFibDL7cjTNvgM=;
 b=rV+0FErBxHdcj19efQASxsvisruq7rW7Or9meopQQHB1yoQZM699cr6LKnyUNxRmO8
 Mk00aG1RRqfYKWEvZQ0mwKc7nVpZMnnQd7/+sqADjzKe1is9YhcMNlgKpYRMNtkWDfLk
 rqtCIyhNbs6+JqbNgoOgmyOMxvFKWrA4Q2bVviFBiDMcuJIZsn1W7h1l/KA+ogjcLprZ
 /TXFgxJAnLu+Ou72yqG30IhyH+MnrQ2693TpMGmRfs8u0DNPytbFtWzMlHH4k2Ad8WA7
 l8gxYnwNAHgc9Ve1vIJ3qaZgAfYwsT0WY13Hj1p/K1afy7zAKAUeBYXO25trViVDiUcw
 MWDw==
X-Gm-Message-State: AFuF++kuhn6O3Ots/hDQAs985FHg5pR2t+UA/PL304qDSBCEAN9D/cXA
 7zYTv1o4mUSfmDYR9aNjQ+rc5bBEw+GQdOcDTZ6QwjWi7TOcNkumSbVY9EnZGrZ9Az0=
X-Gm-Gg: AYBFou3tiQztYPXhjOFUeGS+dqu1nrtDUlBCDR0ZEN+TLrWnLaQrlP724/ykxjxroan
 CfrWc60no04E28zQyex1QJDwyZ/0xdWQGX2lB/zM92oeOar7Qm2ZbYOLExDThOrKb1HqGty8VQI
 5RzfzybNKxOtX5ri+gxRxkIEZ9LL8jzWavqiPirfr4+CHTt/Zo8qlUMCNHdDiXpOyt7LhBkSmlj
 66OoRxj5uYXNgp4Z10P22ul+hLeXyV6WNx9SanEX9Gq5/6yQ5geZ7d03fsF7+ys7i0BRLv4XzXG
 7pG15GDRD1uRIKl+cQIpW00n38RwweBJT+DUXaV/na+Hf/qZrepRqBnnsd0CPQla+KQUt8w5abO
 M+N2GwsCaoeRyg7VvBZhWV2w9DF7jQX0BbxbnHwgrv/vsK3ev36jUJUucb1uqJy9x9P7JFKZkP3
 AJ3NHiW5INkliU45Ul/Sfu5+XxFN45DsrOPZNfNoJd4B86HvnonedmjlEyhZ/VRVEVWVzhxNN7i
 byr5WfeVyEuk/kID/7Vn/VgWSt8FbElWGBxA7uFYVeERYFE8kRckZJvfyyw5iBGxy/8a38j8B8L
 FdBLdQLB7LEgFnGot0HS0VH1fpCFIh65cdaclkWzn1YzTnihV+HOkXE=
X-Received: by 2002:a05:600c:1daa:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a00ec54708mr20204705e9.0.1790671834118; 
 Tue, 29 Sep 2026 01:50:34 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe16a2sm60967475e9.4.2026.09.29.01.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:50:33 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 10:52:43 +0200
Subject: [PATCH v2 3/3] phy: phy-mtk-mipi-dsi: add new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-3-7a1bd29d0e6d@baylibre.com>
References: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-0-7a1bd29d0e6d@baylibre.com>
In-Reply-To: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-0-7a1bd29d0e6d@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Stephan <jstephan@baylibre.com>, Siu Ming Tong <smtong@axiado.com>
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

Add a new driver for the MIPI DSI PHY. The driver supports MT8183
compatible SoCs. The driver is based on the corresponding kernel driver
commit 2ec9c210c1f9 ("phy: mediatek: Add support for MT8196 MIPI DSI PHY")

A few notes about the port from kernel:
- tested on Genio-350 which does not have nvmem-cells, so keep rt_code[]
  zeroed and fallback to 0x210 as the kernel does when no cell available.
  Can be implemented later.
- PLL is not registered as a clock provider:
    - configure() = determine_rate+set_rate
    - power_on() = clk_prepare_enable
  configure() takes a struct phy_configure_opts_mipi_dphy and uses its
  hs_clk_rate member, which carries the per-lane data rate the kernel
  would have set on the "hs" clock.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/mediatek/Kconfig                   |  11 ++
 drivers/phy/mediatek/Makefile                  |   1 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c | 175 +++++++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c        | 143 ++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h        |  45 +++++++
 5 files changed, 375 insertions(+)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index ce7279daa75..26d0de54a23 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -11,6 +11,17 @@ config PHY_MTK_HDMI
 	  MT8188 and MT8195. The PHY provides the TMDS links and the pixel
 	  clock PLL to the HDMI TX controller.
 
+config PHY_MTK_MIPI_DSI
+	bool "MediaTek MIPI-DSI PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK
+	depends on ARM64
+	depends on CLK
+	help
+	  Support for the MIPI TX D-PHY found on MediaTek SoCs such as the
+	  MT8183 and MT8365. The PHY provides the D-PHY lanes and the byte
+	  clock PLL to the DSI host controller.
+
 config PHY_MTK_TPHY
 	bool "MediaTek T-PHY Driver"
 	depends on PHY
diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index 00ab10a238e..6dedec70edc 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 obj-$(CONFIG_PHY_MTK_HDMI) += phy-mtk-hdmi.o phy-mtk-hdmi-mt8195.o
+obj-$(CONFIG_PHY_MTK_MIPI_DSI) += phy-mtk-mipi-dsi.o phy-mtk-mipi-dsi-mt8183.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
 obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
 obj-$(CONFIG_PHY_MTK_XSPHY) += phy-mtk-xsphy.o
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
new file mode 100644
index 00000000000..fd2da6acff9
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ * Author: Jitao Shi <jitao.shi@mediatek.com>
+ */
+
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+
+#include "phy-mtk-io.h"
+#include "phy-mtk-mipi-dsi.h"
+
+#define MIPITX_LANE_CON		0x000c
+#define RG_DSI_BG_LPF_EN		BIT(6)
+#define RG_DSI_BG_CORE_EN		BIT(7)
+#define RG_DSI_PAD_TIEL_SEL		BIT(8)
+
+#define MIPITX_VOLTAGE_SEL	0x0010
+#define RG_DSI_HSTX_LDO_REF_SEL		GENMASK(9, 6)
+
+#define MIPITX_PLL_PWR		0x0028
+#define AD_DSI_PLL_SDM_PWR_ON		BIT(0)
+#define AD_DSI_PLL_SDM_ISO_EN		BIT(1)
+
+#define MIPITX_PLL_CON0		0x002c
+
+#define MIPITX_PLL_CON1		0x0030
+#define RG_DSI_PLL_EN			BIT(4)
+#define RG_DSI_PLL_POSDIV		GENMASK(10, 8)
+
+#define MIPITX_PLL_CON4		0x003c
+#define RG_DSI_PLL_IBIAS		GENMASK(11, 10)
+
+#define MIPITX_D2P_RTCODE	0x0100
+#define MIPITX_D2_SW_CTL_EN	0x0144
+#define MIPITX_D0_SW_CTL_EN	0x0244
+
+#define MIPITX_CK_CKMODE_EN	0x0328
+#define DSI_CK_CKMODE_EN		BIT(0)
+
+#define MIPITX_CK_SW_CTL_EN	0x0344
+#define MIPITX_D1_SW_CTL_EN	0x0444
+#define MIPITX_D3_SW_CTL_EN	0x0544
+#define DSI_SW_CTL_EN			BIT(0)
+
+/* Reference clock feeding the PLL, fixed at 26MHz on all supported SoCs. */
+#define MIPITX_PLL_REF_RATE	26000000
+
+#define MIPITX_DATA_RATE_MIN	125000000ULL
+#define MIPITX_DATA_RATE_MAX	1600000000ULL
+
+static u64 mtk_mipi_tx_pll_determine_rate(struct mtk_mipi_tx *mipi_tx, u64 rate)
+{
+	return clamp_val(rate, MIPITX_DATA_RATE_MIN, MIPITX_DATA_RATE_MAX);
+}
+
+static int mtk_mipi_tx_pll_enable(struct mtk_mipi_tx *mipi_tx)
+{
+	void __iomem *base = mipi_tx->regs;
+	unsigned int txdiv, txdiv0;
+	u64 pcw;
+
+	dev_dbg(mipi_tx->dev, "enable: %llu bps\n", mipi_tx->data_rate);
+
+	if (mipi_tx->data_rate >= 2000000000) {
+		txdiv = 1;
+		txdiv0 = 0;
+	} else if (mipi_tx->data_rate >= 1000000000) {
+		txdiv = 2;
+		txdiv0 = 1;
+	} else if (mipi_tx->data_rate >= 500000000) {
+		txdiv = 4;
+		txdiv0 = 2;
+	} else if (mipi_tx->data_rate > 250000000) {
+		txdiv = 8;
+		txdiv0 = 3;
+	} else if (mipi_tx->data_rate >= 125000000) {
+		txdiv = 16;
+		txdiv0 = 4;
+	} else {
+		return -EINVAL;
+	}
+
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
+
+	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+	udelay(1);
+	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	pcw = div_u64((mipi_tx->data_rate * txdiv) << 24, MIPITX_PLL_REF_RATE);
+	writel(pcw, base + MIPITX_PLL_CON0);
+	mtk_phy_update_field(base + MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV, txdiv0);
+	mtk_phy_set_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+
+	return 0;
+}
+
+static void mtk_mipi_tx_pll_disable(struct mtk_mipi_tx *mipi_tx)
+{
+	void __iomem *base = mipi_tx->regs;
+
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+
+	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+}
+
+static void mtk_mipi_tx_config_calibration_data(struct mtk_mipi_tx *mipi_tx)
+{
+	int i, j;
+
+	for (i = 0; i < 5; i++) {
+		if ((mipi_tx->rt_code[i] & 0x1f) == 0)
+			mipi_tx->rt_code[i] |= 0x10;
+
+		if ((mipi_tx->rt_code[i] >> 5 & 0x1f) == 0)
+			mipi_tx->rt_code[i] |= 0x10 << 5;
+
+		for (j = 0; j < 10; j++)
+			mtk_phy_update_bits(mipi_tx->regs +
+				MIPITX_D2P_RTCODE * (i + 1) + j * 4,
+				1, mipi_tx->rt_code[i] >> j & 1);
+	}
+}
+
+static void mtk_mipi_tx_power_on_signal(struct mtk_mipi_tx *mipi_tx)
+{
+	void __iomem *base = mipi_tx->regs;
+
+	/* BG_LPF_EN / BG_CORE_EN */
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LANE_CON);
+	udelay(30);
+	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN, base + MIPITX_LANE_CON);
+
+	/* Switch OFF each Lane */
+	mtk_phy_clear_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	mtk_phy_update_field(base + MIPITX_VOLTAGE_SEL, RG_DSI_HSTX_LDO_REF_SEL,
+			     (mipi_tx->mipitx_drive - 3000) / 200);
+
+	mtk_mipi_tx_config_calibration_data(mipi_tx);
+
+	mtk_phy_set_bits(base + MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
+}
+
+static void mtk_mipi_tx_power_off_signal(struct mtk_mipi_tx *mipi_tx)
+{
+	void __iomem *base = mipi_tx->regs;
+
+	/* Switch ON each Lane */
+	mtk_phy_set_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LANE_CON);
+	writel(RG_DSI_PAD_TIEL_SEL, base + MIPITX_LANE_CON);
+}
+
+const struct mtk_mipitx_data mt8183_mipitx_data = {
+	.pll_determine_rate = mtk_mipi_tx_pll_determine_rate,
+	.pll_enable = mtk_mipi_tx_pll_enable,
+	.pll_disable = mtk_mipi_tx_pll_disable,
+	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
+	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
+};
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
new file mode 100644
index 00000000000..f294b8bd797
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <linux/kernel.h>
+#include <phy-mipi-dphy.h>
+
+#include "phy-mtk-mipi-dsi.h"
+
+#define MIPITX_DRIVE_DEFAULT_UA		4600
+#define MIPITX_DRIVE_MIN_UA		3000
+#define MIPITX_DRIVE_MAX_UA		6000
+
+static int mtk_mipi_tx_power_on(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = dev_get_priv(phy->dev);
+	int ret;
+
+	if (!mipi_tx->data_rate) {
+		dev_err(phy->dev, "No data rate set, configure the PHY first\n");
+		return -EINVAL;
+	}
+
+	/* Power up core and enable PLL */
+	ret = mipi_tx->driver_data->pll_enable(mipi_tx);
+	if (ret)
+		return ret;
+
+	/* Enable DSI Lane LDO outputs, disable pad tie low */
+	mipi_tx->driver_data->mipi_tx_enable_signal(mipi_tx);
+
+	return 0;
+}
+
+static int mtk_mipi_tx_power_off(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = dev_get_priv(phy->dev);
+
+	/* Enable pad tie low, disable DSI Lane LDO outputs */
+	mipi_tx->driver_data->mipi_tx_disable_signal(mipi_tx);
+
+	/* Disable PLL and power down core */
+	mipi_tx->driver_data->pll_disable(mipi_tx);
+
+	return 0;
+}
+
+/*
+ * Equivalent of the kernel PLL clock's determine_rate and set_rate ops: clamp
+ * the requested data rate to what the PLL can lock to and latch it, the
+ * hardware is programmed when the PHY is powered on.
+ */
+static int mtk_mipi_tx_configure(struct phy *phy, void *params)
+{
+	struct mtk_mipi_tx *mipi_tx = dev_get_priv(phy->dev);
+	struct phy_configure_opts_mipi_dphy *opts = params;
+
+	if (!opts)
+		return -EINVAL;
+
+	mipi_tx->data_rate =
+		mipi_tx->driver_data->pll_determine_rate(mipi_tx,
+							 opts->hs_clk_rate);
+
+	return 0;
+}
+
+static int mtk_mipi_tx_probe(struct udevice *dev)
+{
+	struct mtk_mipi_tx *mipi_tx = dev_get_priv(dev);
+	int ret;
+
+	mipi_tx->dev = dev;
+	mipi_tx->driver_data =
+		(const struct mtk_mipitx_data *)dev_get_driver_data(dev);
+	if (!mipi_tx->driver_data)
+		return -ENODEV;
+
+	mipi_tx->regs = dev_remap_addr(dev);
+	if (!mipi_tx->regs)
+		return -EINVAL;
+
+	ret = clk_get_by_index(dev, 0, &mipi_tx->ref_clk);
+	if (ret) {
+		dev_err(dev, "Failed to get reference clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&mipi_tx->ref_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable reference clock: %d\n", ret);
+		return ret;
+	}
+
+	mipi_tx->mipitx_drive = dev_read_u32_default(dev, "drive-strength-microamp",
+						     MIPITX_DRIVE_DEFAULT_UA);
+	if (mipi_tx->mipitx_drive > MIPITX_DRIVE_MAX_UA ||
+	    mipi_tx->mipitx_drive < MIPITX_DRIVE_MIN_UA) {
+		dev_warn(dev, "drive-strength-microamp is invalid %u, not in %u ~ %u\n",
+			 mipi_tx->mipitx_drive, MIPITX_DRIVE_MIN_UA,
+			 MIPITX_DRIVE_MAX_UA);
+		mipi_tx->mipitx_drive = clamp_val(mipi_tx->mipitx_drive,
+						  MIPITX_DRIVE_MIN_UA,
+						  MIPITX_DRIVE_MAX_UA);
+	}
+
+	/*
+	 * The kernel reads the per-lane impedance trim codes from the
+	 * "calibration-data" nvmem cell,falling back to a mid-scale default
+	 * when unavailable. U-Boot driver does not support this yet, so
+	 * rt_code[] is left zeroed and the SoC layer applies the same default.
+	 */
+
+	return 0;
+}
+
+static const struct phy_ops mtk_mipi_tx_phy_ops = {
+	.power_on	= mtk_mipi_tx_power_on,
+	.power_off	= mtk_mipi_tx_power_off,
+	.configure	= mtk_mipi_tx_configure,
+};
+
+static const struct udevice_id mtk_mipi_tx_ids[] = {
+	{ .compatible = "mediatek,mt8183-mipi-tx",
+	  .data = (ulong)&mt8183_mipitx_data,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(mtk_mipi_tx) = {
+	.name		= "mtk-mipi-tx",
+	.id		= UCLASS_PHY,
+	.of_match	= mtk_mipi_tx_ids,
+	.ops		= &mtk_mipi_tx_phy_ops,
+	.probe		= mtk_mipi_tx_probe,
+	.priv_auto	= sizeof(struct mtk_mipi_tx),
+};
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
new file mode 100644
index 00000000000..96a93e5ba5f
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ * Author: Jitao Shi <jitao.shi@mediatek.com>
+ */
+
+#ifndef _PHY_MTK_MIPI_DSI_H
+#define _PHY_MTK_MIPI_DSI_H
+
+#include <clk.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+struct mtk_mipi_tx;
+struct udevice;
+
+/*
+ * The Linux driver models the MIPI TX PLL as a clock provider (struct clk_hw /
+ * struct clk_ops) fed to the DSI host as its "hs" clock. U-Boot has no consumer
+ * for that clock, so the PLL clk_ops are folded into the callbacks below
+ * (keeping the kernel determine_rate/enable/disable naming) and are driven
+ * directly from the PHY ops.
+ */
+struct mtk_mipitx_data {
+	u64 (*pll_determine_rate)(struct mtk_mipi_tx *mipi_tx, u64 rate);
+	int (*pll_enable)(struct mtk_mipi_tx *mipi_tx);
+	void (*pll_disable)(struct mtk_mipi_tx *mipi_tx);
+	void (*mipi_tx_enable_signal)(struct mtk_mipi_tx *mipi_tx);
+	void (*mipi_tx_disable_signal)(struct mtk_mipi_tx *mipi_tx);
+};
+
+struct mtk_mipi_tx {
+	struct udevice *dev;
+	void __iomem *regs;
+	struct clk ref_clk;
+	u64 data_rate;
+	u32 mipitx_drive;
+	u32 rt_code[5];
+	const struct mtk_mipitx_data *driver_data;
+};
+
+extern const struct mtk_mipitx_data mt8183_mipitx_data;
+
+#endif /* _PHY_MTK_MIPI_DSI_H */

-- 
2.55.0

