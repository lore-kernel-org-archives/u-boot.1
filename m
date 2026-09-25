Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F85CC9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34F7340CA2;
	Fri, 25 Sep 2026 13:40:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKaYBZHESm_4; Fri, 25 Sep 2026 13:40:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0AA3B40C90
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343646;
	b=Rkz99LQZ4xG7jUcCj2XW7O33wM8eugjNyTTRKUyRS7lwxqja97hRe9c6SVT/CUtZhETy
	 2rL7NSd3/0Frv/+W8H0/6HhtVJHpR1xOySSyfJ0jY6ObldFBc2k5YxXfqquiB7kL2hbJv
	 xEJJFu+ZMeIQkis9+j6ZSKdLE52Wt2WY5MscaY+je0nd3X7EbQfU0kLe/fqywFaMkULgq
	 kcISgz+8y9bew+2YsVJTy5lclB9hFOPTeOLCw2t+SOd5o/9UvMEsZ06yWbbTazvzoSeiO
	 S8pLdpdLYkdyUN3myz9L/rQSI3G39eat3yd2yNJLE3sYxisbH8VY4Hbcrqq68ILmSdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
	b=l8jcM2Ca2U3wzXuaNlpP5DsS2Opj9ezdlNGSsCo4WY9PMawO4DbhLAXMz6+zBfeGJkz6
	 XUoiWLWKc5y5/P3Wv/UFcdPqwafY17uysFo5aBXgCvu1uDVF7884Ob5nPmLf19mJ2ZAmF
	 mScPSDDwnJx8aBmWJ6ORHrbUTWQDZ8c9kGgV80lKRc8OM70Alt5UcfgathSv1IyJSPGC6
	 i7++0MDLk1H0kEr2WTU+Jc7B1oQjSCidMpVsW2pPTmwwJtYJaD6Z9KjELSQ28cFUter/X
	 5CSePGy9x0aXgShAzxUqqvNJSvuGtny3Jy+n37gmGI9EfPUl7N+/Uv7Gimxj5jJE/Ew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343646;
	bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OE6Mo3Hi4YLxOwJ94wNbt+pQ/WM7cTQsIvPovjORST0HO9xegOByerdQjrD7Ia1E6
	 fYZNfzRvdpeqKt5NRt1KDa9hPdMVsJCvPPbR70R6+WAv+R86QAdYWggWLDwHayEiaF
	 kpntwXg8WeUcI3oqE5MoKsuJhf8zjSujnj3LsPO48avv9MtT3fmmiWowH1l7+tFAeC
	 kJn+l6sJ5Sut/MSxBaLCJpinrkYNaIZa1lVURMgqecRdf/JTdqDhZTm/WZtugU6f/Y
	 nc5Zed64sTlqOiS9+JttEDV5BIL8HkwlDNmhXTVx66DxwkYXY27uy+8ukGvPIr3VpE
	 3xZVb9fO02l4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AA3B40C90;
	Fri, 25 Sep 2026 13:40:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 646DD332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B04540180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HI4QNdtUtBK6 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2669240042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343636;
 b=Z/lsKvDjkqklppB/nExi36jxOQH/pjuNcD1bOrEdDJXLzzB2ww/RLazTC1sibepnPS6g
 jmdgj4PFBrpRiVvZVPmd1BddxkU/FPbn/FZGGEXRLYEwJsNhG1jEFwQQDOex9mi6CEMXC
 NTF9pvTMrgXylHwftXdoVmOZeSWP1SsQuFK4cvYeDZI3n1CRcTbrOtlG40rDme0TsEGIl
 RZSB4TavDF33aCEC7WOKed5A9iKS3DHJFHj5MEiRKFtUFDqA2dYq03p+LDnleGn6FlSsT
 5QnK2w/lztwEpu0iGq7R+JzWO5j2dBY+/UPoF607Liwouz+/EjTuTuQxYo/RcB4mgRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343636;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
 b=Ta94anxM+1B7HfcUoWpuKs4ztRQ6qs7i2GgArJ3oYx8BLLHftFobM97IDsG/I5oy/BfM
 Bn/lOXXZ19uRFW2Gidqg56+DObONiZG6wTroFbash1bCwkTbeleXiC2h3+tZA0wCdrTPF
 kx+t3xsHH5bXbjgyeD8JDbajqzYz4LnOW8bWCKse/OBgABf7x+TenWMLzW3kR3fgllyFe
 yEz2hY3mDpb9azY6wLmddoGnbxJ29sLnK0hjgrKBhCJ+rPxR5337+LXpQAEY1ttmrhKu9
 +SwRGl/47IXh9Cy6o/E8sFQRgWHwxvLYJqL78Vn0U2ju0Gui+AmeRhDKvhDtUj+s0zw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=A9Vd5gX2; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::d;
 helo=mail-wr2-x0d.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=A9Vd5gX2
Received: from mail-wr2-x0d.google.com (mail-wr2-x0d.google.com
 [IPv6:2a00:1450:4864:30::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2669240042
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:35 +0000 (UTC)
Received: by mail-wr2-x0d.google.com with SMTP id
 ffacd0b85a97d-482f6351831so498095f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343633; x=1790948433;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
 b=A9Vd5gX2aI8QThxBU7hLIb6Q7NcNfstj7L2TnQIGZ51KuJTPWthePiGbDHEur45voa
 t7zSEBqc2Mcczr0aEV4gmpd5aILU3Fof95gt9E9llnWrgVfQHQX6vdyr9Fy73Xv7obwM
 d4iXbvXm5O9yYRtziT2pc9rw4WTbIlw5jrG9deJfeDwwdPzC8ssdeMeBctUVxDpw7dp4
 GgyXpR8Jypn/yLk/rsuflmP1KwSdgHTmltFiBL4glMcQG1yYx2TnXRofY4a+S0/+rR/S
 ZoTFHkPht/CZzmJiT19fIdw/dPIXPZeVJbNmVnqiT38y5GMbivVV+SFLv/mKvm7fZGHw
 VcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343633; x=1790948433;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
 b=Rw40n1J4BO9P9MLzRAwNrmMd/9hH/AlZ+tq+twxyY8THCHv4eyKhQtr6x0YICTWhBn
 n7eMkBejrGaXUlA18As1fML/dkPgOoluD9ksYARQtUcAx/llOD5j8MmTfj5VL+ibqWOq
 qXL7F9NHIMynBn6SljOueE/OgdlgVGHJ/vRFw0mS9MJGhBGBBneIIXznnPeoB4XNXJXK
 Qb8+LnPbZH80f6TWs82fY6Y71e8AKIXMiDrb4jcaf81KZ/72DbJ8n2U8jrOL9BDNS0IP
 CRBNwoL6GOSf88DZDf5+sc2/O2pS/jqLqDZCBr8dd3DdE7zNbvK3C1Fh668Sc+Gw/BmV
 3taA==
X-Gm-Message-State: AFuF++n7K/5YcbYG0/mDffBr5ve3hb27QQNIAcgVavjj6wh7xRJQ+Y/2
 TSUPYf1eTXcVjlhGjEHVZCDYApM5+Kf7Uqi0W/hb7JZ3RZknBajR9tDx4kRUV8I4uQs=
X-Gm-Gg: AYBFou2NEfQqbFjbjQC3uhIrS+QQXGyNYBY+WGprPog78LnHRW/OJmnmLgOILm0bIBn
 tirK3vCtbiVZsZu/jjL/LWLyoRdAMqsUKZkO+yPRdT2rdnYhlyjMjfFlbh0EjRI1p24DFmQxgbw
 r/UppKyei6Ypj/RqFXde8Y/uFhG7dQxmjrpnHjXPYqU9G1nGnw8TCGIjunlMOwrbDIgLg72gYpY
 byt5jvyvSK9VR8+q9l386bjdYCP5sp86UbQm0oXsh9rUFqWDu7YLW5Lsiux8Waq20GaonAQBMEX
 Wv3nTPY92G3n7FI0rgd3enTGL/ueeUioCinK9RJpT7M5G+K13WD3KIteebanPOsx7riHSvSa4qE
 MLnFjXyMtn/7squGM9eYvM9iyBIFK/nLPsN44SsvWtJtgE7eVeQP0VnGCNvgbxDmr2I2hRNoYS4
 UiPrbZcmLoiQSZwhUIf8DQOpKL96jWaPmgke6aYnSlIaMSVPG18i4GLOdj7WJUE9VzXrr4UjLf2
 sRo25FA1/QNYCZqyKzqZvYGqefpwqsx/3LC0WWCZ9cLNLa8rA2ReWslZd3nopajBjKLyP9GaHIO
 sTLRYQ3OWAHq6NLXE3ARHrkAoLjJWc7QEI+ILcRVsg3o6OCh6TLWO38=
X-Received: by 2002:a05:6000:2586:b0:486:e901:e59 with SMTP id
 ffacd0b85a97d-4887174c00amr11344100f8f.31.1790343633418; 
 Fri, 25 Sep 2026 06:40:33 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:33 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:03 +0200
Subject: [PATCH v6 05/12] video: mediatek: add merge component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-5-29e626b213e9@baylibre.com>
References: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
In-Reply-To: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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

The merge block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. With two inputs it combines
them side by side into one output; with a single input it only buffers
that input through its SRAMs.

A merge declaring "mediatek,merge-fifo-en" additionally uses both SRAMs
as a FIFO, which needs the DRAM latency thresholds to be programmed so
that the block does not underrun.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_merge.c | 154 ++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_merge.h |  44 +++++++++
 2 files changed, 198 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_merge.c b/drivers/video/mediatek/mtk_disp_merge.c
new file mode 100644
index 00000000000..8898bdbd7fb
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_merge.h"
+
+#define DISP_REG_MERGE_CTRL		0x000
+#define MERGE_EN				1
+#define DISP_REG_MERGE_CFG_0		0x010
+#define DISP_REG_MERGE_CFG_1		0x014
+#define DISP_REG_MERGE_CFG_4		0x020
+#define DISP_REG_MERGE_CFG_10		0x038
+#define SWAP_MODE				0
+#define FLD_SWAP_MODE				GENMASK(4, 0)
+#define DISP_REG_MERGE_CFG_12		0x040
+#define CFG_10_10_1PI_2PO_BUF_MODE		6
+#define CFG_10_10_2PI_2PO_BUF_MODE		8
+#define CFG_11_10_1PI_2PO_MERGE			18
+#define FLD_CFG_MERGE_MODE			GENMASK(4, 0)
+#define DISP_REG_MERGE_CFG_24		0x070
+#define DISP_REG_MERGE_CFG_25		0x074
+#define DISP_REG_MERGE_CFG_26		0x078
+#define DISP_REG_MERGE_CFG_27		0x07c
+#define DISP_REG_MERGE_CFG_36		0x0a0
+#define ULTRA_EN				BIT(0)
+#define PREULTRA_EN				BIT(4)
+#define DISP_REG_MERGE_CFG_37		0x0a4
+/* BUFFER_MODE: 0 - no fifo, 1 - SRAM0, 2 - SRAM1, 3 - SRAM0 and SRAM1 */
+#define BUFFER_MODE				3
+#define FLD_BUFFER_MODE				GENMASK(1, 0)
+/*
+ * ultra threshold in units of pixels, the recommended values are
+ * 6 us and 8 us worth of pixels at 594 Mpixel/s.
+ */
+#define ULTRA_TH_LOW				(6 * 594)
+#define ULTRA_TH_HIGH				(8 * 594)
+#define DISP_REG_MERGE_CFG_40		0x0b0
+#define FLD_ULTRA_TH_LOW			GENMASK(15, 0)
+#define FLD_ULTRA_TH_HIGH			GENMASK(31, 16)
+#define PREULTRA_TH_LOW				(8 * 594)
+#define PREULTRA_TH_HIGH			(9 * 594)
+#define DISP_REG_MERGE_CFG_41		0x0b4
+#define FLD_PREULTRA_TH_LOW			GENMASK(15, 0)
+#define FLD_PREULTRA_TH_HIGH			GENMASK(31, 16)
+#define DISP_REG_MERGE_MUTE_0		0xf00
+
+/* CFG_30 (0x088, "12 bit lsb off") is not present in the upstream driver */
+#define DISP_REG_MERGE_CFG_30		0x088
+
+/*
+ * The DRAM latency thresholds that keep the merge from underrunning while it
+ * buffers a line through its SRAMs.
+ */
+static void mtk_disp_merge_fifo_setting(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_36,
+			    ULTRA_EN | PREULTRA_EN);
+	mtk_disp_comp_update(dev, DISP_REG_MERGE_CFG_37,
+			     FIELD_PREP(FLD_BUFFER_MODE, BUFFER_MODE),
+			     FLD_BUFFER_MODE);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_40,
+			    FIELD_PREP(FLD_ULTRA_TH_LOW, ULTRA_TH_LOW) |
+			    FIELD_PREP(FLD_ULTRA_TH_HIGH, ULTRA_TH_HIGH));
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_41,
+			    FIELD_PREP(FLD_PREULTRA_TH_LOW, PREULTRA_TH_LOW) |
+			    FIELD_PREP(FLD_PREULTRA_TH_HIGH,
+				       PREULTRA_TH_HIGH));
+}
+
+void mtk_disp_merge_config(struct udevice *dev, u16 l_w, u16 r_w, u16 h)
+{
+	struct mtk_disp_merge_priv *priv = dev_get_priv(dev);
+	u32 mode = CFG_10_10_1PI_2PO_BUF_MODE;
+
+	if (priv->fifo_en) {
+		mtk_disp_merge_fifo_setting(dev);
+		mode = CFG_10_10_2PI_2PO_BUF_MODE;
+	}
+
+	if (r_w)
+		mode = CFG_11_10_1PI_2PO_MERGE;
+
+	/* input 1 and input 2 sizes */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_0, h << 16 | l_w);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_1, h << 16 | r_w);
+
+	/* output size */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_4, h << 16 | (l_w + r_w));
+
+	/* no pixel/channel swap */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_10,
+			    FIELD_PREP(FLD_SWAP_MODE, SWAP_MODE));
+
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_12,
+			    FIELD_PREP(FLD_CFG_MERGE_MODE, mode));
+
+	/*
+	 * CFG_24 is the merge SRAM0 size and CFG_25 the SRAM1 size. In merge
+	 * mode input 1 goes to SRAM0 and input 2 to SRAM1; in buffer mode the
+	 * single input goes through SRAM0 and then SRAM1, so both hold it.
+	 */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_24, h << 16 | l_w);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_25,
+			    h << 16 | (r_w ? r_w : l_w));
+
+	/* merged sizes of inputs 1 and 2, only used in merge mode */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_26, h << 16 | l_w);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_27, h << 16 | r_w);
+
+	/* 12 bit lsb off */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_30, 0x0);
+
+	/* unmute */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_MUTE_0, 0x0);
+
+	/* enable */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CTRL, MERGE_EN);
+}
+
+static int mtk_disp_merge_probe(struct udevice *dev)
+{
+	struct mtk_disp_merge_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	priv->fifo_en = dev_read_bool(dev, "mediatek,merge-fifo-en");
+
+	return 0;
+}
+
+static const struct udevice_id mtk_disp_merge_ids[] = {
+	{ .compatible = "mediatek,mt8195-disp-merge" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_merge) = {
+	.name	   = "mtk_disp_merge",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_merge_ids,
+	.probe	   = mtk_disp_merge_probe,
+	.priv_auto = sizeof(struct mtk_disp_merge_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_merge.h b/drivers/video/mediatek/mtk_disp_merge.h
new file mode 100644
index 00000000000..679d4c4c59c
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MERGE_H
+#define _MTK_DISP_MERGE_H
+
+#include "mtk_disp_comp.h"
+
+/**
+ * struct mtk_disp_merge_priv - private data of a merge component
+ * @comp: common component state, must be the first member: the shared
+ *	  component helpers cast the private data of every pipeline component
+ *	  to struct mtk_disp_comp_priv
+ * @fifo_en: buffer the input through the merge SRAMs, from the
+ *	     "mediatek,merge-fifo-en" property
+ */
+struct mtk_disp_merge_priv {
+	struct mtk_disp_comp_priv comp;
+	bool fifo_en;
+};
+
+/**
+ * mtk_disp_merge_config() - configure a merge component
+ * @dev: merge device
+ * @l_w: width of the left input
+ * @r_w: width of the right input, or 0 when there is none
+ * @h: height of both inputs
+ *
+ * With a right input the two inputs are merged side by side, otherwise the
+ * single input is only buffered through the merge SRAMs.
+ *
+ * A single input with no fifo just goes straight through, one pixel in and
+ * two out. The HDMI pipeline never takes that path (merge3 has a right input
+ * and merge5 declares mediatek,merge-fifo-en), so it is untested and only
+ * here for a future single-pixel user.
+ */
+void mtk_disp_merge_config(struct udevice *dev, u16 l_w, u16 r_w, u16 h);
+
+#endif /* _MTK_DISP_MERGE_H */

-- 
2.55.0

