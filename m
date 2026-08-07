Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D461AC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E97F18136B;
	Fri,  7 Aug 2026 16:02:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8LDCAcUQ4ug; Fri,  7 Aug 2026 16:02:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 401FF8136D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786118547;
	bh=MwmFYz2Om1roNJdf2XtPZekJseHBWU3Lk3HBm33CONo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TstnmJ9YkOqVnMh2Xca8Qd+3DZUlJzduBREIe2YmopL9DaReBRDz26wp4cQ5JYbPP
	 C9eMo17QBufN+8aQ7prbvI1gD457Tird3pgMZXOXYkBzG3pW+GaS2wGzLqzBPOHkyg
	 xMnty/tzCjkoZ5+bxdGHf6Q6949MzD1neFpEpwo2WLg6xkXoMys7+gtV+QWlZnou/J
	 QuSEUMx505SuF4dA5TwvEaqI1TixzlHWLlH2Zj938jZBVk0AHDahNuy1nBfayjKRfc
	 uFA2XBaY1HGBidMlbROFnSRvLhP7DLG3ehb5BqzdSzSTSa+GUk/kx/1JFKzqip1jbe
	 aeZZce78Tz8lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 401FF8136D;
	Fri,  7 Aug 2026 16:02:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 223BE2F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 083118130B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KFRSr2_OAxbU for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:02:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 46A9F81301
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46A9F81301
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46A9F81301
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:22 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-44cb057311bso2052123fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118541; x=1786723341;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MwmFYz2Om1roNJdf2XtPZekJseHBWU3Lk3HBm33CONo=;
 b=gQuA2X33FNZDsaQqaXQN9hI8FgVunVTbHp8eZVsjwdGs6QM2TsFzOqbjZzmvpDTgoF
 XmHHh0MHc3CLWX43o0q51bCUsxYgT7zfxIwlVegz50PoD39jdpOcEnJ8pvaVu8uqAZvW
 /Fd92x94QoQjxKR10YDhd1ZqJ7S3hKyOFKiX08ca0NBVPSfWP8vuTbggiY912PVNDseG
 E/SGs4cy+X5n1qiJMu51blBDiV4IAytURqvLpSnGwUS+xs1O2P5aeKmIZ4O1/fKgMnnB
 9QsUSpO2Sj3vytWxc8BWyTRMTkj/37wDArxelmK/m03EFv3qFMnNu+CVG+yTWYdSmseL
 WM5A==
X-Gm-Message-State: AOJu0YzGsxJPedgN/v9qRwG3BIEKZz/lOoBCMvzZjzG5UTh8rprfsSRB
 76KC3X6jRx/zLJvyhSm1dLyC8JaZMPPusoZ76blNn2ewEJCgycbG1e12jtDal4FT/Ao=
X-Gm-Gg: AR+sD11q9f/hqvZTZ8D8lfh66Jh1YoYWIp3pS/8NPHLOaamwzqcKNM52z5Jt8LqETKU
 AhiutfehMVACnaN/lmRmg+VOjwdyWOZQPjF/td9MespWSHUIYL7Qweh2MlZQMFmEPECwwRSNSN2
 Lbxes6MstBubrhXIHAgEAeKpy+kUGf6xSh1OX+4iFynLKvYgAIpxlxTxBV5u3WrePlVM303GCB3
 ylAANEZ31qa0u9V+J/Tv3rcu4xdOD/Xx02rzM3T4KxEn588Nnz+jmSNdTNbL+SCFbQH+w3P+JVC
 ub6Ofpy1oBM5nK6zEzKu4y1yGw032SQj9YBCMekg+E8lfH0Euy4FLcTbIjwDDKPCCopMhr4RaOB
 iTwiEM5bKwY60RuMJPAxp5uECzUYo51d3nRUJquygurB/e933juyHncFkwRfLUNkyOiE2iOiUjf
 jJ1zk5zMgfHtA97vyvrbaCXng+4qsSHcGqy9kDKalnd7R79QzE7cBbdNEefJx7El6Q
X-Received: by 2002:a05:6820:199a:b0:6aa:f172:3094 with SMTP id
 006d021491bc7-6ae96cb428bmr12510436eaf.10.1786118541055; 
 Fri, 07 Aug 2026 09:02:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2679993eaf.5.2026.08.07.09.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:02:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 11:01:30 -0500
Subject: [PATCH v2 3/5] power: pmic: mtk-pwrap: use mt8195 fallback for
 mt8188/9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-pmic-mt6366-v2-3-d9fdef581fb1@baylibre.com>
References: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
In-Reply-To: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=M+WA2nb0gPp2mEsUVMzPNzVMtPQGCBYBffEBUR0mAc0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgF0bJkCvywGEaTp9xzfU3w7b1p3TUHkZ6pyB
 VcBEHUwKy6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYBdBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A13sH/1gfjlcP67PyeYijzJwNtYZAGDOf3UolnQXUHb/
 7A2HqFHcYvbgpYiNC/mE+KijtCH1OMWI9hGJoO2940x4gNQ2sAEQd5HYWl6JqY3jb0M3S7BUAw6
 5TQEh5RgQ2Ewo46pDaCb+PSyG67hoYAbRvkPsVqvSi6IqqoNc+rLIf5BMmRR1RHYU20slGpnMLF
 qtwAy/s77a1WyKVPvg0SnXcuGmwqbJEVwai4MmDfM5J8pxcprnwJ1IVRHhoBDjmPzWdL6chcWrQ
 NN/azK2TNdQw0CHsG59zEc73VpEMIjFfidDZisT+G6xuUoCFkuRj9+g4OrqeIgASV7WZyoqytKD
 4uI4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786118541; x=1786723341;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MwmFYz2Om1roNJdf2XtPZekJseHBWU3Lk3HBm33CONo=;
 b=DgUmIgkDmPXsJN/WZxGbl27arETAw3tWZKL17vosSJrIj0MaTUvNWXg1J/LYByerZA
 EOgWUuNDXFGlAKAjBhqHmmsK0D+kYa3dRnUnfhOr4LO8VkS0FdPrqjXsGmFDyBy0dgFW
 yjb3yAM3eQkTFtAloUZHDnTnUWcohs0+XpznBO4rukkRHG3attCMsZpIb1HpPCq0YIgO
 zgcZR7clLxoU10xwjPcpaNhooKmNUxdlczRXHdFxqiGKJn8q1I36L13NJgjFxb4Zcpl6
 olArk6YFLjoN1XETAusoEk6lNWILNestI6NLyemrC/t9i05aJWibSJym76Hu0bbUAv39
 FRrQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DgUmIgkD
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

Remove the duplicated info for mt8188 and mt8189 platforms in the
MediaTek PMIC wrapper driver. These both have a devicetree fallback
to mt8195. There are no differences relevant to U-Boot, so we can
avoid the duplication.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 46 ------------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index f648a784019..3320e3cfdc0 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -250,34 +250,6 @@ enum pwrap_regs {
 	PWRAP_WDT_SRC_EN_1,
 };
 
-static int mt8188_regs[] = {
-	[PWRAP_INIT_DONE2] =		0x0,
-	[PWRAP_STAUPD_CTRL] =		0x4C,
-	[PWRAP_TIMER_EN] =		0x3E4,
-	[PWRAP_INT_EN] =		0x420,
-	[PWRAP_INT_FLG] =		0x428,
-	[PWRAP_INT_CLR] =		0x42C,
-	[PWRAP_INT1_EN] =		0x450,
-	[PWRAP_INT1_FLG] =		0x458,
-	[PWRAP_INT1_CLR] =		0x45C,
-	[PWRAP_WACS2_CMD] =		0x880,
-	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
-	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
-	[PWRAP_WACS2_VLDCLR] =		0x8A4,
-	[PWRAP_WACS2_RDATA] =		0x8A8,
-};
-
-static int mt8189_regs[] = {
-	[PWRAP_INIT_DONE2] =		0x0,
-	[PWRAP_TIMER_EN] =		0x3E4,
-	[PWRAP_INT_EN] =		0x450,
-	[PWRAP_WACS2_CMD] =		0x880,
-	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
-	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
-	[PWRAP_WACS2_VLDCLR] =		0x8A4,
-	[PWRAP_WACS2_RDATA] =		0x8A8,
-};
-
 static int mt8195_regs[] = {
 	[PWRAP_INIT_DONE2] =		0x0,
 	[PWRAP_STAUPD_CTRL] =		0x4C,
@@ -849,22 +821,6 @@ static struct dm_pmic_ops mtk_pwrap_ops = {
 	.write = mtk_pwrap_write,
 };
 
-static struct pmic_wrapper_type pwrap_mt8188 = {
-	.regs = mt8188_regs,
-	.arb_en_all = 0x777f,
-	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
-	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.caps = PWRAP_CAP_ARB,
-};
-
-static struct pmic_wrapper_type pwrap_mt8189 = {
-	.regs = mt8189_regs,
-	.arb_en_all = 0x777f,
-	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
-	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.caps = PWRAP_CAP_ARB,
-};
-
 static const struct pmic_wrapper_type pwrap_mt8195 = {
 	.regs = mt8195_regs,
 	.arb_en_all = 0x777f, /* NEED CONFIRM */
@@ -882,8 +838,6 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 };
 
 static const struct udevice_id mtk_pwrap_ids[] = {
-	{ .compatible = "mediatek,mt8188-pwrap", .data = (ulong)&pwrap_mt8188 },
-	{ .compatible = "mediatek,mt8189-pwrap", .data = (ulong)&pwrap_mt8189 },
 	{ .compatible = "mediatek,mt8195-pwrap", .data = (ulong)&pwrap_mt8195 },
 	{ .compatible = "mediatek,mt8365-pwrap", .data = (ulong)&pwrap_mt8365 },
 	{ }

-- 
2.43.0

