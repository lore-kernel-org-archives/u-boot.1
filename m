Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A15FC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77E684A3E;
	Tue,  7 Jul 2026 17:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="BZl/ghQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2662784A63; Tue,  7 Jul 2026 17:10:41 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113688494B
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-44aeefa1c00so750186fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437038; x=1784041838; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2J6DtV+rvZHUhjWtRL/IvUnCVSM/QU32WBK0vmhrlZ0=;
 b=BZl/ghQ9yhYdu792uwImO95jY8agsIPArC8vVzHm/8FIoX1gpW2PbnRCAuRVKCQNeJ
 4zoZkaXFLwnlG7BCSsdmXl847s41YBNvDWL7NaCq6whsactJIumySd6oSlBru/KTX4dq
 3KDwCYhBC1I11ORvprgsKaIAU4KsU9hTk49p4wRPiHFl4CuDIeqt/ja6jTaycmuqNIQW
 5RN+43dXOQZNpNm+jOfZZVZCksYCY1fkmPa+cQaes0KNx9p0aGeMSkHpJ3u7IOZkYVIC
 2dEq0/4ivuq9jDO+kvwsyBcRQzoEWHUlg4lI1f+pWgo2nkwhL6AN9W1iLz+nTMIvQGWt
 lfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437038; x=1784041838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2J6DtV+rvZHUhjWtRL/IvUnCVSM/QU32WBK0vmhrlZ0=;
 b=YjLrPxfHayCzb5IxrIbFU8MoHj6HpnAZ21q/GsIcmQo2KyI3Nhlgc9DR07pblPZg0Y
 a8yBitSbJwVDhR+QxyEoWU2fjE9zfU8AC1j7XdL8pHv6UUMoHAzOcxZ+8AZ+3lQL/H5Y
 uN8bphsNxrWis9Qx97VjYrw4+xx4wg8HVjZ5hQc5a7kpkx5ZXQKY+zSl1o6PEA5htLjC
 L3uqno3ObhPSTGadRKQ6T9ca8UevZTFjXmZXM7wGOd2LnoAuZv52i29W3hJT2Ayhhzvd
 dPUPNkxOZjotU9u71vXmPP0/MkEV8mSZvTUsE0cWypPg8vVez8+h72zfqmO9bWS4gb3N
 +5jg==
X-Gm-Message-State: AOJu0Yx722QUtiwL6gTuGmK/HMPP/bEix3bc0OaJVS5OOqpHh6Rx+oW+
 xpUdhsTK0tgTWuzNmYaBy5nzu6/IJ1ZMZxbbx0LOdokFavtJyT/wQNyVXrBkXUt68WE=
X-Gm-Gg: AfdE7cl3zGVEXMRDP017UHLU32csuH1ho7+R5EFc0icrbX2MFm9co69tSbXqRnniBlB
 cgq0bdtx0qhUeg+88eRNOm4fBaJpa4gLtj54lKbY9xs91GNOyTFlTXg6NbxzM+cHBtWLF39WpCz
 xptoye76hohOpqaPCKlPxCtnOCEzw6FUxvFFhayVe+VMQw1PZd76SovPXrqZCI4lvbnhGt5C69C
 2nBxsuHOyQIJWEZtMaIu/PjF5+kuvf1iujh+fxBKisiQSDd7ENsTge9ykkxtlpw6LLPAridoUO2
 UtGjusyYRYobE+DUVciuKbZpaI21F1vtWPIcGAZ+fUKDSUMKBIv1FkYZw4swimiLUDPAwPkbGQJ
 lFwlbPok88PnzA4z+v/axHEpo5gXiXVeZy4QrwVkBXi1abfEnzZdtGK8x16MULiwBMwSjOs63xp
 U8hoGg75pBt2lRMfbNELIP8bqWq27T
X-Received: by 2002:a05:6870:e091:b0:3e8:9b72:5cda with SMTP id
 586e51a60fabf-4511895b780mr1909969fac.11.1783437037812; 
 Tue, 07 Jul 2026 08:10:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:31 -0500
Subject: [PATCH 11/24] clk: mediaTek: mt8188: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-11-65d24cc0d569@baylibre.com>
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=WwkaLeC1ACkk0ndUd3z+BTdx3doblEcTWUcxIV+kQmw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRZ63WRZ+1f37gnthkOYjkX3ij8YZ/nGZDgL5
 YzJ3NJeKFeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WehYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATy8IAIpnbF2F9TbDqK4R+UAMzInpRidYfYE9VqvNnio
 7gkK++dW+dUFYv8KcVUkVX2piKKzdlxraq/07o95KP6cUeVPSjJE5al/jIACMCVcm9iX9fz4NnR
 Y3ZXorg+9md7ZMKtteO0mvPKupVVOOHfut9EJb5alTQ8dDhweEkwUE8QCASGJRn4a4GlHzN2f8R
 92MY/rWmCtNcFJWH9angZA+SnMwwcDNXTTHvCjatFNlrkX0oxlL8ggszjWyG+B8lt+jRSyo+EF9
 odSHFXPNLlbzTTRqSxxipgjDTr6x5mbJOCXMYVSRcaDbVv8/D6YmwjmuHr8C8aXchy9NKVGim7N
 ymnE=
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

Add clock tree type flags to the mt8188 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index b82a6ab5452..aef60b324b6 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -89,6 +89,7 @@ static const struct mtk_clk_tree mt8188_apmixedsys_clk_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 #define FIXED_CLK0(_id, _rate)			\
@@ -1422,6 +1423,7 @@ static const struct mtk_clk_tree mt8188_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.num_gates = ARRAY_SIZE(topckgen_cg_clks),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_gate_regs infra_ao0_cg_regs = {

-- 
2.43.0

