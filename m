Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7F2C44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F256684BF2;
	Fri, 10 Jul 2026 20:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="V2MKoP4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B0A84BE5; Fri, 10 Jul 2026 20:59:49 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 463BC84BEF
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-44cb057311bso632443fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709985; x=1784314785; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5vfLrg8njnX3Rg2e2tuqs5iSyhe590bwu+eoEa/mPmc=;
 b=V2MKoP4c0tpzKNnEfHJ4MXObs6ywoM39Q9BsrmKPmeZSkgapTWU7G+7JL6sQzOsLfX
 pHIaogYmA5xWWIyN3Pj9NekuBJANkRcUpMOc0TF/BOq/jB8QAyzzdE5l5s9BmOppaSZH
 DEUEJKdxKehCqCQtK92WOZTVdNa3jiqIP0MiE3JsU1rKWSaD5QsLvNkbElut0ar8WOLw
 eqwT0+mLqFtkLJuzo0sTfQp+rKyvS3s2VcTkYPS0GqK5lsiS9F6RJqpvjI5KYjVXWoM1
 zs4LIONsMhn8hfvpbHgNQldv3qUyLq2L5vMxJHQuRF1KdQgIBvPz+QrY5VyL66LGt7sL
 r8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709985; x=1784314785;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5vfLrg8njnX3Rg2e2tuqs5iSyhe590bwu+eoEa/mPmc=;
 b=mj79j2w6hM+xazu+xwBE04XsJjoCr2nRzklx3mg8VLDoNXb/eSx2NM5JwAmM6asfuZ
 +9eZOPFYeMa591TTEH5DHbPynlPzKvWYM7AfZjFRbxPPHPc3dHEATxspqQgoKdokkPZZ
 aATFWSosFIrPlxHVmb+2QuLm5AiGxJDETLp+CJE+G3YDDYWivEqYjQcSE9qYJxBHw2fD
 Y0FJk/veiMkRLGnSk0YzQZCQ0AJQNoITOzH/YuhTAsionIw0/ta+RPIlDfz1HGJBBlyB
 5mjgT5TlJ3ILVlxnJIpUpzl8GMrhx6gD5NkDkbdifBzmOr5PjkRlYYbRMB/N/i1xwQ/b
 x4Yg==
X-Gm-Message-State: AOJu0YyJ/CkdilpuGEBb/U4vQMNg3g8LwDO3Tv/DBda3BzMYNp0Iumbg
 H/qkjEzeE6v62UVx/p+nqAUrt89U2qzFT/KmIvIkdAXcOAtS4o0kXyxb+N2+74LiaQrasQmRkBT
 gfvzU
X-Gm-Gg: AfdE7cklXaFF0CNMoVqJuC8vZGSYLdTnoUmGX5ErYI62UHVnM8bHxT5RfeIjwsPjLWM
 tH0UH8Snha/n2uHOi+s9c9ddB7GQ8sB7v62JuQt4/TQaM+sHTykqCvVZitU3TOEYoyLJm0xRbNj
 yyQ/ljVxjlQfru/0dTtUppGcpjLZaQUBi16fDfvlL22s0sg3INyuTcgm6osQdPHdU2T4p3Ri/84
 2yoDg5nkw6cZJglfae9hS4dML+zUYEtALuqhUXPKDEdR1X5Hz2/dbExKzZwomaJUchTOZHcPpCe
 U0zKmSSQ28Vop7Kbkt4WFeBU7jEJ2+gjDDWoM7bxsf3RJMx2ZuG4EXxE9ivSUBfRuonQNxqBRJ/
 5T7QObyxu9Z90LRGx5FnU/+1NFOfPknV4v0MHuVjAly9fvYQhHHxtLKQWmXUVF6/R1mT1w5JHKT
 cRE/ns7Nj4TKFefzpE
X-Received: by 2002:a05:6871:806:b0:447:1ceb:52d3 with SMTP id
 586e51a60fabf-451f13f6db5mr87442fac.31.1783709985059; 
 Fri, 10 Jul 2026 11:59:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:40 -0500
Subject: [PATCH v2 24/24] clk: mediatek: mt7629: remove
 mt7629_peri_clk_tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-24-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=e4Wnjde7QmqvdQko9FGA/7HqafiGmiJePi0App1xd/s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUD1iBmX4ttH4uLZg7O2k2S8Z/pcSo4mW6p/z
 1Gy1jNJAT6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFA9RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AdeoIAJ9CQnQFepXhvuBrs9Y0GVyASca87tzod3etT2a
 lr+Fefs8U454VskPyk8HqqhOXD8F5Z/sfx8I7v1vYS0CauvqKFDPC19bP+Pa0hEnoaPdffMHCnc
 oiCzSP3SFg4CRvTqRU82yY923JZdY9uIxc6/FK3fqfZJGbO7JUL+TenEsrXpc233aijgxXslNXi
 CY9fwwWXJHO7aTornlezg0XtP228caR9EodRSaHAS80FQfG1pqr7CrVG1gZPhVOPVcmCnLGpf3M
 oz5XeJAAy4/+B7FNNv3730OSt6ToB2zsXMlomaUglH9Ec6sj5MMFaM5225faUXAkiiq24S8oCO0
 3Nc0=
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

Remove the mt7629_peri_clk_tree struct. Most of the fields are unused
and we can just use mt7629_clk_tree instead as it has the required
fields.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 903e9d8ec81..b65d3ef2203 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -603,22 +603,6 @@ static const struct mtk_clk_tree mt7629_clk_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
-static const struct mtk_clk_tree mt7629_peri_clk_tree = {
-	.pll_parent = EXT_PARENT(CLK_PAD_CLK20M),
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
-	.muxes_offs = CLK_TOP_AXI_SEL,
-	.plls = apmixed_plls,
-	.fclks = top_fixed_clks,
-	.fdivs = top_fixed_divs,
-	.muxes = top_muxes,
-	.num_plls = ARRAY_SIZE(apmixed_plls),
-	.num_fclks = ARRAY_SIZE(top_fixed_clks),
-	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
-	.num_muxes = ARRAY_SIZE(top_muxes),
-};
-
 static int mt7629_mcucfg_probe(struct udevice *dev)
 {
 	void __iomem *base;
@@ -665,7 +649,7 @@ static int mt7629_infracfg_probe(struct udevice *dev)
 
 static int mt7629_pericfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_peri_clk_tree, peri_cgs,
+	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, peri_cgs,
 					ARRAY_SIZE(peri_cgs), CLK_PERI_PWM1_PD);
 }
 

-- 
2.43.0

