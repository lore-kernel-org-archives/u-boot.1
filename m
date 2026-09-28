Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CFECA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC57480DEE;
	Mon, 28 Sep 2026 15:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXDH1vNM-qR9; Mon, 28 Sep 2026 15:07:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EF3F880DF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608049;
	b=AQfSiugaivAu/b9kfdVjuYNP6JdPIzQUq5hu4p9lpeNGhzTp5p4lZk9RFgaI+HZwVhmv
	 67BdH862X8gSN6uG8NhHccxytvy5DyLmEoBzTA/WcGEX96obLeMCCJUp4n8rJ1feSxAtV
	 KOU/Qv6g7d+BF2YKfdi3IUXU/wCckiKS3OKiE3r9amG/n1EUaW6eByebT25yiOLHO9jhZ
	 rEw7cVhZBzhpIa6NTnDVPbb7AJs7sj7fwYI7t035wZUPboTP0QUx21XbM/8KBWLxI9dXr
	 TarCGMFtBTGMkr9vvwTH0Lu1YN8Urf1t8uShQMtKBN1HFFXCsFbCdl1xsrW5MUgPjnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608049;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
	b=dwNDnArFVwcm1wgoHj+oglg8K8nwVhCJCbPq1k5ohck0NqwjTrbgaKOYrD7CeYP8cJCL
	 F+SeT18uQznAd5K8K4sVOag3lzwUh5nz0QYERLYhhdPim1YSVVnme+XzxkEm39pLJBtDC
	 ARadS3690dz6/AJVPD2QxaG+KCz4O3e8FDbPwR2Ir69KyUlN0xbIDyTO7JVq+4/xbVbHP
	 vbGfmfeT/m+hWXRUfSODf1ZZFW12zGDQ9YN4nWmqy00/ST2oDgMhbCEpX6YDBBJ7Z/RQN
	 OLlwKcgDwe8uGXpHLN11+p1fv/3SVX8rMWfR8j92Z8c79GsQc3ir41LWlsq+rRA36fw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=N1ta37iq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608049;
	bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XbligrYT3CAxgWhJpfp6SI0i0ZzhORt34vxONIIznmOnBl5uMmyXTNyuxuUxqNNDc
	 7B6gj07qvd+rx36feawwU5898VXIAQNn4AF3lHewHb6G9MBPtwtMHXLXdfUwTksZQU
	 zZ6PlbrDHISnPaYKAiJuNdKCeO9zUI+lu2poldNCR4ETFlrJ9c6Sbaj0LG28jG0Hmy
	 zEG3hiZ5zGVxSGVQI7dxW4qjY4e58PsZK/0oXcU2DbI+sBRp6DcdxAUMZnwjfWeqqH
	 yGyjpg4oQvGxYP3ebADJ4tUWTn2obQyfI9NHDK94t+d52OKmibeScddb+h/fT16xT7
	 L53NHwnGcRRQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF3F880DF4;
	Mon, 28 Sep 2026 15:07:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82617D1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7435780DF4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJjGuKqZAO23 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:07:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 664FF80DEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608046;
 b=oG/2WluMhtLcf+xCQFPFQdTtO64anMXgSPgbCQXgxZCI0WyQtK0EsO6sSmBrBtsSpIpj
 Ry3fJF8R0x0zZL55oQGcS2yG+ugDG4D/JhxxlR2N7MuzKoVhyhLmegbwSonK/3aiPmDi8
 phWT4MuU5pXOxOIcUYqAhdBtHnWYsEFpMAnIYSWz1JEAd7VhEwbcLWPd+e6EKhj3JwUgR
 YVPjG8pM7euEipJeRJYeqzjlFJARfvTm32GSLkJXMcNmQ1bQmvISnTaIXm5Sek6qvu/ft
 WFASNoL+zxIKFitqcm7iRQ4z7cFVEXzlGd7sGzAxcuzBIfs5syBpZM91gWw3uiwMQnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608046;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
 b=VKODjv0Qn5NHHSU/SAiol5x7qPJq81FyJDzr75NbblQlrpBV7hcOo5kZ4St5jf3nMJM1
 ox60/kPBpDLXc6Ww5oxhrJR29cbQpql0HQqS7hnGmW5KZA7gmExAt99N7AtUG16KR7gZN
 h47dmnrG9MSGKsiPOiGEmdj2AnRmPWVQOx2T54y3J0aJwuWXgoS3fEqUZzcpB+9cVUfZn
 /0MB6PGFZenhr9WAH0DZKWfK5hjGAbiqsJRg1g/Yyj32yIEc/2okuCdUFXeLX8o6K683+
 4TDmddRb5nqviAUkiNcoZWqfBL9W+KBvBy9coG44SJyEN8rmkCFUh8ScNb8O4N4TpZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N1ta37iq; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=N1ta37iq
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 664FF80DEE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:25 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso29999295e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608044; x=1791212844;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
 b=N1ta37iqe2Wj3dkH9i4U7GH2qLZTxaGHPZfzgEWnqcDOji8BSqOIx7w0qz4ycJnLQK
 mQegEFsZCTmJcZOiqlWXebvKb0w23Ynwix064D1RsVy/b9Wh8DtuLlkU3bmMjZrbn0ob
 3As/+bYoqsp4093srlIMbjBvohIPDK83wjHEvH0kS0BhAbyHc1ykvg8+k7K7hqfLk4Ff
 dPW30weCoi38LrcUqMy3qSUkMimw7D9tDEzBwnZdhOb8rpSj1Z9lVLlaKLVRkFeNdB5n
 ehu2cnDtSTn8rfQXpSMA6pCWtswBF73EIAJAkWMXIxsiyJt1DW2reNxJX/edVTzZ12MC
 /TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608044; x=1791212844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
 b=a9vCkntNckIkNhZ3UskVcjPH2XM/h0VOfrFZDkFNxewecApUXgDhuAz3NfajWmiUsG
 T1FtON2v8nQ/3KwPvF3BBWemnhgmtRHN2LoRPHjn5MdaJUw9RalFJNbb55CaK8gIgblr
 CSEcX51mLZxf2Qw6gL70yULpJ4kbKaBCMCKPoSg0OXZmO4J+eNuLF6/168Li7YAhc+9N
 g53eiioHiNw3evXa3YW+pBwdpT3OMJoeFoHrLxdwhbyWR2cqrB5zNOSMxfmgD4VHdZWi
 nVgULtOBlAo83jNz9k2eICYQhS6YOlswBKD8JXnBkvQjlC3aKzdbnlCouE8q/BdAHj9q
 w8qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNroaQyZ+xgHcpVfO/2NdEG8qg80nJMOS1PsAelz0OqJm000lZXMgVyGN9ru71iYt/VOJURoc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lZ/lddXUGjUeDVwkw5BbTdIM4Usef7ciw+NEkFnbAS92OzLbBS
 WMqjy1jHW5fi/xgMGDEDFvXR1LdR9s2N3QHkLRzC8mOgWZUDvmv/rNd7TXTayMA9W4U=
X-Gm-Gg: AYBFou3EvQg26pdZd5dmdv920hFV4SbonyPlYVPlRZuTw2SxjnyIQmw7Gz9SvtXXsYi
 oi1GcPhLwyfbhWeomCp0wsRvwN02NLU5oBpuHONMMbHu+YS5ewmVoAm3KOeZ9fsim1o2ew09DFQ
 YdL8LMnTgpmJ0nTxyT37qbduljI+lSAo239EbQmlLlJUNUMVDWM/fTE6u8KY1rT+Z9L6PevRWAO
 3JNq+hOnbGyYC46xIdN2BWNU+zlBZdR0qNFIsCCq16quJoyMsMRnGiVVdbhBwsojgZMaL5QqpKv
 uc+1D5abZA2IEFNCvVp5tf9p1nsFEeeNwkfY4dCwAT56eOaI8IeAeO+vNTcG4Wm4uH7WsfjeZwd
 BB8IE5haaSABmc/Kugsq7Feph/r3wrRjRmbGQraRD9Z8MINSdj2Bjk52p38guzU+jUVGtaCkEMG
 JuaPktWG6KnFL/6kE6y42/qt1XpLnXyq6Hwjb8K9rko26OgpOzwiXfU8vNLwotQ4JuUl/npJoek
 ABNxuWPQmRmgqtZdmvYo81NuXZE9fmlWhhK/ubKoqk7tLnCdVBFWizaPhkAyhdizxqwuLBr0vtS
 O25BdSAFkcFX2zOZ2sDTNY0PDJsZpxsitR1tbTQfFnYIUaATP4e7Q6Y=
X-Received: by 2002:a05:600c:198f:b0:49f:bd3c:bc23 with SMTP id
 5b1f17b1804b1-49fe6707f90mr240442775e9.30.1790608043887; 
 Mon, 28 Sep 2026 08:07:23 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:06:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:45 +0200
Subject: [PATCH 08/13] video: mediatek: add dither component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-8-212f51b1742b@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

The dither block is the last of the colour blocks of the video pipeline
on some MediaTek SoCs, such as the MT8365. It reduces the pixel depth of
the stream down to the bit depth of the panel and spreads the resulting
quantization error over the neighbouring pixels.

The pipeline carries 10 bits per component and U-Boot always drives the
panel with 8, so the driver programs the block as Linux does for an
8 bpc output: the frame size, then the DITHER_5/7/15/16 settings of
mtk_dither_set_common() before enabling the engine.

The driver matches "mediatek,mt8183-disp-dither", the generic fallback
the MT8365 dither0 node carries behind "mediatek,mt8365-disp-dither", so
a single entry covers every SoC reusing that block.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_dither.c | 89 ++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_dither.h | 32 ++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_dither.c b/drivers/video/mediatek/mtk_disp_dither.c
new file mode 100644
index 00000000000..51ed69df011
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_dither.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Dither support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm/device.h>
+#include <fdtdec.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_dither.h"
+
+#define DISP_REG_DITHER_EN	0x00
+#define DITHER_EN			BIT(0)
+
+#define DISP_REG_DITHER_CFG	0x20
+#define DITHER_RELAY_MODE		BIT(0)
+#define DITHER_ENGINE_EN		BIT(1)
+
+#define DISP_REG_DITHER_SIZE	0x30
+#define DISP_REG_DITHER_SIZE_HSIZE	GENMASK(28, 16)
+#define DISP_REG_DITHER_SIZE_VSIZE	GENMASK(12, 0)
+
+#define DISP_REG_DITHER_5	0x114
+#define DISP_REG_DITHER_7	0x11c
+
+#define DISP_REG_DITHER_15	0x13c
+#define DITHER_LSB_ERR_SHIFT_R		GENMASK(30, 28)
+#define DITHER_ADD_LSHIFT_R		GENMASK(22, 20)
+#define DITHER_NEW_BIT_MODE		BIT(0)
+
+#define DISP_REG_DITHER_16	0x140
+#define DITHER_LSB_ERR_SHIFT_B		GENMASK(30, 28)
+#define DITHER_ADD_LSHIFT_B		GENMASK(22, 20)
+#define DITHER_LSB_ERR_SHIFT_G		GENMASK(14, 12)
+#define DITHER_ADD_LSHIFT_G		GENMASK(6, 4)
+
+/* the pipeline carries 10 bits per component, the panel takes 8 */
+#define MTK_MAX_BPC			10
+#define MTK_DITHER_BPC			8
+#define MTK_DITHER_SHIFT		(MTK_MAX_BPC - MTK_DITHER_BPC)
+
+void mtk_dither_config(struct udevice *dev, const struct display_timing *timing)
+{
+	u32 sz;
+
+	sz = FIELD_PREP(DISP_REG_DITHER_SIZE_HSIZE, timing->hactive.typ) |
+	     FIELD_PREP(DISP_REG_DITHER_SIZE_VSIZE, timing->vactive.typ);
+
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_SIZE, sz);
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_CFG, DITHER_RELAY_MODE);
+
+	/* as mtk_dither_set_common() in Linux */
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_5, 0);
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_7, 0);
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_15,
+			    FIELD_PREP(DITHER_LSB_ERR_SHIFT_R, MTK_DITHER_SHIFT) |
+			    FIELD_PREP(DITHER_ADD_LSHIFT_R, MTK_DITHER_SHIFT) |
+			    DITHER_NEW_BIT_MODE);
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_16,
+			    FIELD_PREP(DITHER_LSB_ERR_SHIFT_B, MTK_DITHER_SHIFT) |
+			    FIELD_PREP(DITHER_ADD_LSHIFT_B, MTK_DITHER_SHIFT) |
+			    FIELD_PREP(DITHER_LSB_ERR_SHIFT_G, MTK_DITHER_SHIFT) |
+			    FIELD_PREP(DITHER_ADD_LSHIFT_G, MTK_DITHER_SHIFT));
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_CFG, DITHER_ENGINE_EN);
+}
+
+void mtk_dither_start(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_EN, DITHER_EN);
+}
+
+static const struct udevice_id mtk_disp_dither_ids[] = {
+	{ .compatible = "mediatek,mt8183-disp-dither" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_dither) = {
+	.name	   = "mtk_disp_dither",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_dither_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_dither.h b/drivers/video/mediatek/mtk_disp_dither.h
new file mode 100644
index 00000000000..019e6c954bb
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_dither.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_DITHER_H
+#define _MTK_DISP_DITHER_H
+
+struct display_timing;
+struct udevice;
+
+/**
+ * mtk_dither_config() - configure the dither block
+ * @dev: dither device
+ * @timing: display timing, giving the frame size
+ *
+ * Set the frame size of the dither block, and dither its 10-bit input down
+ * to 8 bits per component.
+ */
+void mtk_dither_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_dither_start() - start the dither block
+ * @dev: dither device
+ *
+ * Start the dither block.
+ */
+void mtk_dither_start(struct udevice *dev);
+
+#endif /* _MTK_DISP_DITHER_H */

-- 
2.55.0

