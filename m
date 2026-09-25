Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F99C98328
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F6F181328;
	Fri, 25 Sep 2026 13:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJAyJUmTEgN3; Fri, 25 Sep 2026 13:40:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F18418131C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343644;
	b=luE4kWXVjqz0C47XZv90GzNIi6+NJyejINBy+I6Jz+VrASly88LWoDYrj+xV1XPy9uB9
	 WjeMQ0tdN7kvRmDjduqbVMLb2lDM6A3ZPinltHMiNTwNMSTOJ2e/O4iFveRMpfGV72JzV
	 w+w+GytA6DGCO+Vnmqbe1nIFbE/dsZfI2kNWzewLEfavvYRftDE+hXQ5yp51YG2N656ik
	 OCgZbHhrDRVRr1T8JXLIitHCRc3a7CPpMezOvEGekLnLIPDj7laQjyfGbtccng7L8/N1L
	 fDhACXX0kLR4nnbZy5I6FAl5pIhnegsP8HKJxj3CSmpQKD3DmeNmRYCvqwKJxL8TPZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
	b=YTuleobfLj6Um9aeNtyyn83zR4DnyxGwB3D6mZcCKTU6TOPEFHS+8lrlyPsVBEiMpKCP
	 pblJejJj6ySm/LT7tnPrmQgpGEnM+wWJDy7JDwIOPXUbm23jyhpZwtJKZijPOG9gL0aFV
	 u621KGkYl9u1t08/XxcbGf1YCHPhdxkr3OA4FnBPUJNlEY6e4aWK8l1olf0XzHTY+NYZi
	 GUWvqGra42lAEv+iRJhRq+3b6pBM8BMLypkmSObtPe6A0lt6cQhSu+PdThbFOP38QBLnu
	 1WnKgDrgq6+AILm2oHjSNffNpCASZUMalptwX54ABC752ldlZoC7NBoaAaG4uQ4Njbg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343644;
	bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GqNTnhqxmRf3pXcCn1De8i4NLbXfcl5QVujshHbjcz/n5Ear2VtHcIcIOqSEe0Thc
	 iKKc86/6tMwPXAB242L39JizkSyNs/9iRiYtq/dAxmrmoGlbp/YhiyUwCtJLKg32QW
	 6/JCGoDGA4CuySsE/mUEifjqC45BEi5c8lBtQ2F9c1wWxMYw6cnvljWzRPWWCouu7r
	 1YV3VcC2YpTHQNbdTsf/GbmzlZt5qyK/98IcrBkeUwdk4YuOmdkjP6FstHrfx2+brT
	 7xbnC9TVobHB/8yYD9qjkrMnJAglengocPXPlTsBEHePlSh0MpJPkw3DRW9i7eCDWZ
	 nrfBvtQfN8Bmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F18418131C;
	Fri, 25 Sep 2026 13:40:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0133A355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBBBF60D5E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CWAUZZZCkZpI for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D42AB60B65
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343636;
 b=fcV30haC+Va1sU3r8kmp3xNz0nY8o5OMdJrUjlHcQeKlXpzOsGERRw/dTxSv742UW1MN
 kfxG1luElMXYsEHG3Ivv61K2kJqZs9DCg2g8DXf6qKvWE6k/9dIqfFb7ng9DVGJu8Z09k
 NpEdW3pHnAkAQVd7X7ELdl8hLF5YigTCKeycR5Uik9jCwLGn9tyynY3mgcMCcPbrNqAX2
 L/43ooWoXyUeOqZmX+/RoH8ekJx26GqkZy1REPyd1hWQHg/Eu5Miha2BNiDYOC8LErVHM
 HXAoLADkQVCjNjuCz+iTPl905F7slUh9E/ex4Fr7clYlnGZdFOf5KM092mi5+rRokiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343636;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
 b=OJzDL+CXf+F6coos4G+p7dpYjHAM/Vul+LX7XMocba4gQwk43+htwr5ArdvAHsQHAZ8R
 ttsDQI8uzCYylp0kgbjZcmxBBMBNB/PDHeds2kJWa4YXHBDyebg/ikYjhjvK57JgKMohw
 ol5Tl217ACaq9mVpVF+NkM3aLkVHLonIs3MwCwbW/imLv0mClLHXXP2GlHe+yZ9lPoE82
 0B+lOiC6rr5Yvqh5x+hWmGc4SZCj/QGTXa1vKy9Q0MGeLj0SBVfh9rpMEiH3GmpBphdng
 Sbh7sJ85yH6IGBpTId8Dsw7FzE8hH/pUD/5fer8ZjN9UPZFXqEofh5Zze5kiEjwVhsg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=J3Qftq6H; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=J3Qftq6H
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D42AB60B65
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:34 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so6954045e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343632; x=1790948432;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
 b=J3Qftq6HILPb05870MqnvGnYcD+H42ructO3f0HhmiRACUqy4GbKsezV94hjox2xB+
 eHgDwrNfD1+X7ngokI83Od/v5Z3S30zp5n5/gRIFF5F6wFLCXq5ET6IPya4g0btCmc8L
 l18dr/8Dx5zoRQ3DLtM7yzZe2LTvnJwg//87mqS+dzwAdbIUWPAEM8h09g2bHdOCH/Ff
 NPZ46218MnWZoxVg2gShcZ0xBNTQM4uC/LeyPGEwZtdICBrhz9tTe2czvLaiFE9phjer
 SOecKM4Tz23l6OUgOeQIZqyZ/MUL40r3epzq+0g25DBjWTZ+5wRHHGi26W+5/94BFnQr
 Bl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343632; x=1790948432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
 b=23qMtgjmJNhxHqDDxbzG3mKJJv2ftSNyMvKj6jqzhz0I1VG2KC3xS0c6R9izgZXHBF
 stgdyMfKGEsoa7IMMJl+35rZqL3TrvEDe/iQsPWUlIBPLeRve2Pq9khGiQ4wC9BEk15A
 rwkq9PkjEBTtxo0c9tkk9zGA2u7HwaiyPXxyEN43zAwQzEW1k4Qti20A0va+64XvwFkx
 U2yth3nVVcyB7rYFtVWxfU4PKoNrYwDP38HlL3AkzxaIHFA9/mb63aloHCcwYI9ByaUI
 hvdouU2AM6JNVTaJxkWckNwel43MQUsU1ckWtsxdo13LU2C/4Z5/yhoLgEyliXu3cm5w
 WLvw==
X-Gm-Message-State: AFuF++n2Gmdmm6cJY1lVyxZkq1gaJ9xfUgN6vz17yb0NNOgE8IfqNRKL
 pYMKZYYz46OYJ2e7Psdm5piC4WxiKoba89It++qn/ax2ahwaOtXwlQMO49YUTNYCH34=
X-Gm-Gg: AYBFou0i1uW3nDdee/NVkVEMoyTEJlE+4kgMQ5thY5lL0FP27s79l4RMrzlrlctV3e8
 yMZ1FBNxWYW+PtlTjoLeLYtgnk6QBK2o1dHvdT8JgSDvuu0Iu+fAHO/sb177DuJhaRzoJ8hth+k
 dUfbv8VcFY+EuU/RKPbmNNdZwOdWZz9454kzPXYGQw7JUHBYh5CUYKlefj65l9YsCBHcaLW7OTO
 I5TS43fy5177Go1LfB73r7aaZLVT7wkcwx5vySjfB7QNyOF5HKv25eYPQcYQjOgtjT2e3QR/ZXG
 wHB4/yd9DC5ViNdl7/+HdVAL1wMGFBW3b2PlTNZMnKwp/KplsNDzYl/Zi+yP5gAiSbx6K1qQkRz
 K47qYWr26k2s1Leeudol1EBSeNMjAngy29uWQhHL9gE4SLhujD3Jn8tpMJ0WGq9+nFcIWL9LZw9
 bYTuAHsAQHxrriQe1x5qyR2QuHYG5lyA6iFI0yo3x5jos4pL+xbYT+zDsYtFHJNMBud5TfIiWLL
 7ldhkME7z4yVST7WY449FxoxmUEnOvNC4uDZGy9ji5XL3y6TvVFCfAGZ5eZBQjDRgjXDC1CR2Uw
 m9tfDQ6qQw/XQhPShLUgVKfquHQ12YxNImw/s248l2NxPi9XFprXeFw=
X-Received: by 2002:a05:600c:190f:b0:49f:e1c5:3861 with SMTP id
 5b1f17b1804b1-49fe66ca03dmr109045265e9.2.1790343632219; 
 Fri, 25 Sep 2026 06:40:32 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:31 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:02 +0200
Subject: [PATCH v6 04/12] video: mediatek: add ethdr component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-4-29e626b213e9@baylibre.com>
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

The ETHDR is one of the components of the video pipeline on some
MediaTek SoCs, such as the MT8188. Two of its sub-blocks are used: the
mixer, which is the block's first register window and does the
compositing, and the HDR video back-end, which sits on the same data
path and is put in bypass since this pipeline does no tone mapping.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_ethdr.c | 106 +++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_ethdr.h |  37 +++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/video/mediatek/mtk_ethdr.c b/drivers/video/mediatek/mtk_ethdr.c
new file mode 100644
index 00000000000..6b480ad8319
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <errno.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_ethdr.h"
+
+#define MIX_EN				0xc
+#define MIX_ROI_SIZE			0x18
+#define MIX_DATAPATH_CON		0x1c
+#define OUTPUT_NO_RND				BIT(3)
+#define SOURCE_RGB_SEL				BIT(7)
+#define BACKGROUND_RELAY			(4 << 9)
+#define MIX_ROI_BGCLR			0x20
+#define BGCLR_BLACK				0xff000000
+#define MIX_SRC_CON			0x24
+#define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
+#define NON_PREMULTI_SOURCE			(2 << 12)
+#define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
+#define MIX_L_SRC_OFFSET(n)		(0x34 + 0x18 * (n))
+#define MIX_FUNC_DCM0			0x120
+#define MIX_FUNC_DCM1			0x124
+#define MIX_FUNC_DCM_ENABLE			0xffffffff
+
+/* HDR video back-end registers, in the "vdo_be" register window */
+#define HDR_VDO_BE_0204_VDO_DM_BE	0x204
+#define HDR_VDO_BE_0204_BYPASS_ALL		0x7e
+
+/* Fields used by this driver but not present in the upstream driver */
+#define MIX_SRC_L2_EN				BIT(2)
+#define L2_SRC_SEL				(2 << 20)
+#define L2_OUT_SEL				(2 << 22)
+
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height)
+{
+	struct mtk_ethdr_priv *priv = dev_get_priv(dev);
+
+	/*
+	 * The HDR video back-end sits between the mixer output and the final
+	 * merge, so put it in bypass: this pipeline does no tone mapping.
+	 */
+	writel(HDR_VDO_BE_0204_BYPASS_ALL,
+	       priv->vdo_be + HDR_VDO_BE_0204_VDO_DM_BE);
+
+	/* enable internal clocks */
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM0, MIX_FUNC_DCM_ENABLE);
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM1, MIX_FUNC_DCM_ENABLE);
+
+	mtk_disp_comp_write(dev, MIX_ROI_SIZE, (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_DATAPATH_CON,
+			    OUTPUT_NO_RND | SOURCE_RGB_SEL | BACKGROUND_RELAY);
+	mtk_disp_comp_write(dev, MIX_L_SRC_SIZE(2), (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_L_SRC_OFFSET(2), 0);
+	mtk_disp_comp_write(dev, MIX_ROI_BGCLR, BGCLR_BLACK);
+
+	/* only configure L2 since only rdma4 and rdma5 are used */
+	mtk_disp_comp_write(dev, MIX_L_SRC_CON(2), NON_PREMULTI_SOURCE);
+	mtk_disp_comp_write(dev, MIX_SRC_CON,
+			    MIX_SRC_L2_EN | L2_SRC_SEL | L2_OUT_SEL);
+
+	/* enable the mixer once its geometry is set, as Linux does */
+	mtk_disp_comp_write(dev, MIX_EN, 0x1);
+}
+
+static int mtk_ethdr_probe(struct udevice *dev)
+{
+	struct mtk_ethdr_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	priv->vdo_be = dev_remap_addr_name(dev, "vdo_be");
+	if (!priv->vdo_be)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id mtk_ethdr_ids[] = {
+	{ .compatible = "mediatek,mt8195-disp-ethdr" },
+	{ }
+};
+
+/*
+ * The mixer is the first register window ("mixer" in reg-names) of the
+ * ethdr block, so binding the ethdr node with default register index 0
+ * gives the mixer registers.
+ */
+U_BOOT_DRIVER(mtk_ethdr) = {
+	.name	   = "mtk_ethdr",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_ethdr_ids,
+	.probe	   = mtk_ethdr_probe,
+	.priv_auto = sizeof(struct mtk_ethdr_priv),
+};
diff --git a/drivers/video/mediatek/mtk_ethdr.h b/drivers/video/mediatek/mtk_ethdr.h
new file mode 100644
index 00000000000..28a6d3f270e
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_ETHDR_H
+#define _MTK_ETHDR_H
+
+#include "mtk_disp_comp.h"
+
+/**
+ * struct mtk_ethdr_priv - private data of the ethdr component
+ * @comp: common component state, holding the "mixer" register window. It
+ *	  must be the first member: the shared component helpers cast the
+ *	  private data of every pipeline component to struct mtk_disp_comp_priv
+ * @vdo_be: HDR video back-end ("vdo_be") register window
+ */
+struct mtk_ethdr_priv {
+	struct mtk_disp_comp_priv comp;
+	void __iomem *vdo_be;
+};
+
+/**
+ * mtk_ethdr_config() - configure the ethdr mixer
+ * @dev: ethdr device
+ * @width: width of the frame
+ * @height: height of the frame
+ *
+ * Put the HDR video back-end in bypass and set up the mixer to output its
+ * layer 2 alone, over a black background.
+ */
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height);
+
+#endif /* _MTK_ETHDR_H */

-- 
2.55.0

