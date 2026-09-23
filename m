Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567BCC9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 20:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E29C1832AA;
	Wed, 23 Sep 2026 20:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wGddIPANFJzS; Wed, 23 Sep 2026 20:22:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1181B83131
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790194968;
	b=oqJVtAq68bNzqHOsBm4/yMShJ125moaAhLA/mObeYBhkTU70vY2NDr94QIQcdPkUkBmI
	 +HEsB0mlbz59CT6Ud0yEO5xgin72j2XCO2O+HXQh2Qfo6Fgype7yLZ3vo1wvJiBjK+eUM
	 N2mlZJWzET+sNrGfMWel9HofwWuXGpYj6hxgBR9vSqD6t77+LjPKSQ0+Fa0T9Ej6nPJCU
	 IljkXZyV5h3J7QWERX/vy4xsNrvmelKfDg1ocLNqjTVvlab9EqqeCPgumlSSOPdWXIz6a
	 R0/i1C7fn7nAdofW6T9kpDtYdd1ONkz0Nvoff1O8hUjog7/vX7ld8en5hYjlCxVAqcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790194968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WLJyc5lEeXUYnx45PLe94S70/RYRSM0AgnXhUDDZpM0=;
	b=SiSCHa/bx4Y9Z2+p1jEMJ3JfcWxRxEXHRu2fU190FT9R0cH/xFR7l9KH8YT8XEg3ReGs
	 G1oIHhqq7CPdc4fAbL35ltYkhfCvhmYwHy+CLJNz6jtObNPejvbOalX+OXdyFnrSr64c3
	 1+R2gKI2Y9HqhyOHtKsoODo7WATgIWAp5zrezGwfZ4CxgC1xbKeXJ9Wd/OMf4SHxPqrEB
	 HBRAU/emm4iPQhmgUh706f5cRnlQd95Dos3eRydcZSPwKdabuGG9OX+gWHrM923KZFmF1
	 Q+wkNDW5t/xgunZLp8KR5U8dwPjbolhRdkdlTCoWVlgVjP4novkweMXw9iP03eit5Pg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790194968;
	bh=WLJyc5lEeXUYnx45PLe94S70/RYRSM0AgnXhUDDZpM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z3nf/T2/qK8V6feI8A4JEq+dsw99tR4nlPRnG6nY41bZp/wiMsecWq9uhXoNbgSWN
	 ZtcdIyvWoBHhkQdMDOy11uBVGA98VOekTY/9vTfzy4fsYwHCnIhTK09B+IOmr0NN8f
	 LUXQWk+GCgyno9UwSkNgMOlxaZL4XgIWyNVv7gig3a98J876n4LMIl04f5/aQKWm01
	 bFHbbkv11OdnlnoGgnRIU+j7wBj6dRyQ7zhM7E+Pilf8R1CK/SagyGc+De0WVDvDsZ
	 RrhkRrTxp0RrhSrsFDxBlBR8/VT+K8jlnOs1IZ54E0D06qih+u2woXr7okaT6T8cma
	 4CJmBOtSofOSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1181B83131;
	Wed, 23 Sep 2026 20:22:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C1C928C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19E4640390
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:22:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Htb1tLrz9jLV for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 20:22:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4C3BA4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790194964;
 b=G9Gl7rmSDfZQZHTMwnGh83U6UGAjJYJUd5tHy7U622w/u/k72xG6zfjJ+yzGJvZi+VP6
 lGxSGPTfi4a0917PEz4Rhp3TEbq0M6s+T8sCMTDsoH3+XBOSoMau5elLWVmq2Nu9DQu4T
 p6H8IUfwP3RkTwr9XFlrrO94QO+8PdMuxp+wuV3WORx8B/TuUzFhz7kTeYTy+VxE6HOdQ
 F3Z0nCmUm1I2GrvbkTeni5wCkhF1D8onp9PHLp+gsu+3NiSv/KgpcugDOlli4pz6KAROU
 p9lK+TWwDdT1+fAIVxqlIrk0Ki3dP4+hAWN59315aJPYkXIeRO0Z6/PH5BjY5gy3JiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790194964;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=WLJyc5lEeXUYnx45PLe94S70/RYRSM0AgnXhUDDZpM0=;
 b=W0XtASlQsw2sScFlb0KYAcv542ciA26oCfzehP84fa9m1paS634ldoIuZgewMwGHsIEP
 9tJbxBwROYU7otVOXysiqAcMOXlRO7ygFnJYEEVVt9YZZJTpMUKHz0lCVoiUiGNBULkFd
 eWoGK3+5ExrZZBPO8YxHJcvl55UY7Qw4j96sSTx0IxiAozNxGV+nO9bq/a/1HyH5IoTC7
 QFfaDzJLMCtdu9FOyay6j0Mtd8+jwXwbiUOjNL41aHrqp+F/oACylm2ctsb4QO+nhRmpo
 kJLB4gFkH7IFoNTk8j/8m9ZvVIg2xp6895L4WlddKDQM5hV3C/NQBGcOaLddH7JuQlQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aATFIi0D; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aATFIi0D
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C3BA4008A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:22:43 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-478cbd5b48aso962791fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790194963; x=1790799763;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WLJyc5lEeXUYnx45PLe94S70/RYRSM0AgnXhUDDZpM0=;
 b=aATFIi0DJUEWt9wt2v7CckMRuHzLD40ZCLeVJcX2eSANiiIwymQmvvTsM9+DyuzpSS
 Zt/pN8mJXeP99sccaUcCm+9ZToR4A+w67fjyMH7HPh3IPdYit3ISuVD/zspY0aHFpZwu
 1Zq1N1BLIJ0wKOChCyn80zbWij4+zYiPPMwCNWOhrzoYPnyHdpFUjqseLt1QDteP1cyc
 lrxpH49oWiG7IRfFuxLtV3idlEEbBhvOCpRtsGRqX+YXoch562P/s4JLHnrX8Ci7iUp9
 B7FfkJUMTliAXhAi0aBv4CLNXgERDJPvjoPe81fqmUnrAGzmqMwgDS3B8GMWokzmM7Cg
 xOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194963; x=1790799763;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WLJyc5lEeXUYnx45PLe94S70/RYRSM0AgnXhUDDZpM0=;
 b=smtBoNtokO34251bbucU0JmA8zPUSlifWtMDuQ43T/O1436GzujDFIWYyMS7Dyw0jA
 WlKj86gm/Js0DwEIhGMO1NrZVViG/6AUPQt0+/Had8P4SK5U4WtLgtOakL5vH/ulUomL
 27R51MNJ8sW8DdJ8mq1Ak6mmypTkTKaz1kQkZjXQS/gcR9vloWCAf0CHf9jnWENJ88Og
 PYRDc6X5ULsTT1LL48o4TvO4TEuGmTG7rsE/jQ3dxKQGVQQw/W8AhDTJifc9yrhOy0o+
 mW47HlVbHUFoG3GmTH1IJteZPslFKi8wg+uKusTXcDZe3ceukKYKk9SGIB6we/rq6HYb
 p+gg==
X-Gm-Message-State: AFuF++nskwPyYv+0IC7WX7yIveekPdE1Rk02NBI0DNsnnPv14/Raimfj
 JG96M9f4szpSaVPk8qBez+8k6x10nb373lB2o9Jtu1WUWALVphk3RMaEGkXLyVEP21ywDExmv6Q
 VgAfS
X-Gm-Gg: AYBFou0tv5l/tCE2zOJ+k9oGEoiqnM2EojRU7IplrWzWMsKpz14n+SBriCqTI5uJYff
 BohtxH35LAYWSV/UMaReYYSzd4GqXplD5jG2vWniXgopHMoPgpZMdGJI1d2usLq+05eFjaTq6CU
 WQEhbN41tD1IwWG8JWxYmrrn7ugtvAv3slK0xNddms/DskNnbIK327W2W+3X9pxzokVPD3nJkXD
 QiB2VGBWwrD7Du4APAUYPldYUMmo1LMRHJziVsdG6H4o0EdTbSuWtXVDJ2B9A23CzKJCzR/sDrY
 vvz5fj3/afLEMamO086Sh4S9NDHhmAE68C+77moOjBr95g9BSlhYt/G+LwF8ePo6DpLPg9ixZkv
 TfzZn3iz13oxUZfPis61QRHwzKToMA/JNIM/sUwFIeUECy47PfCQVDtzZIrYjKyB73p+koWAeHL
 4FpF3qx2a/dpoWBCIJ4ZIE5e60w8QqfSBJKlcNRx/rPd35qiJsv5KmuGAPUfNk921TIRwo+TKDV
 VPs
X-Received: by 2002:a05:6871:3a06:b0:483:b498:9dc1 with SMTP id
 586e51a60fabf-491e973f3c0mr317692fac.2.1790194962725; 
 Wed, 23 Sep 2026 13:22:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-491ed71e8easm233729fac.7.2026.09.23.13.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:22:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Sep 2026 15:22:13 -0500
Subject: [PATCH 1/2] clk: mediatek: mt8183: fix infracfg gate lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-clk-mediatek-gate-order-v1-1-085391165c36@baylibre.com>
References: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
In-Reply-To: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Fabien Parent <fparent@baylibre.com>, 
 mingming lee <mingming.lee@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3929; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/iitEDrFJY8TmVuBy3akFWmEd5Qw9t9TWo4qkaBnR8M=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtDT+krvatRCA8qIHw/c4SfmOlOSNdh7JsLI5H
 awcEtHP/2eJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarQ0/hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AEtoH/01l9Z3Wf4XL4eX1Uh4tXtZkb943mFk4jbR97pw
 CVMTaHdqH87O2DJgWw6I6vY8WVXDI0Hpyp6ZbXFcPHhmyts7e/+E6C1/ZLWoqDVuOe5wCZ+/dRu
 T68spELJTN+EqJ7gqd3uNeS11QcoB3Vd/1TyIf4teTRPWE3//Q0JUix1HoiL4iODJ5QR683TKcU
 YK/uXDXGMzV/nVHqEPqJ+ts3KWlw7ELLbxqwkmjB7Ylu7ElPkGLYJQJLqSsnH0U/sWYoZl+ozgA
 9MJjRcLDl+RrcBl+ge/O83lECv0Z6AonwP+3xAGYYdArDPApabz97vSg4xsGwVTsUbGwvbVlWuR
 Ge4c=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add the missing CLK_INFRA_SSPM, CLK_INFRA_SSPM_BUS_HCLK,
CLK_INFRA_SSPM_26M_SELF and CLK_INFRA_SSPM_32K_SELF gates, based on the
Linux driver, along with the 32 kHz external clock that is the parent of
the last one. Move CLK_INFRA_USB and CLK_INFRA_DEVMPU_BCLK to their
places in ID order.

The common MediaTek clock code looks a gate up by using the clock ID as
an index into the gate array, so the array must be sorted by ID and have
no holes. infra_clks[] followed the register layout instead and was
missing the four SSPM gates, so every ID from 51 up selected the wrong
gate.

Fixes: c9d7e79f02ef ("clk: mediatek: Add MT8183 clock driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 08e06c60f68..aff5d629c30 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -18,10 +18,12 @@
 #define MT8183_PLL_FMIN		(1500UL * MHZ)
 
 enum {
+	CLK_PAD_CLK32K,
 	CLK_PAD_CLK26M,
 };
 
 static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK32K] = 32000,
 	[CLK_PAD_CLK26M] = 26 * MHZ,
 };
 
@@ -683,6 +685,14 @@ static const struct mtk_gate_regs infra3_cg_regs = {
 		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,		\
 	}
 
+#define GATE_INFRA3_EXT(_id, _parent, _shift) {		\
+		.id = _id,						\
+		.parent = _parent,					\
+		.regs = &infra3_cg_regs,				\
+		.shift = _shift,					\
+		.flags = CLK_GATE_SETCLR | CLK_PARENT_EXT,		\
+	}
+
 static const struct mtk_gate infra_clks[] = {
 	/* INFRA0 */
 	GATE_INFRA0(CLK_INFRA_PMIC_TMR, CLK_TOP_MUX_AXI, 0),
@@ -737,11 +747,9 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA1(CLK_INFRA_CCIF_MD, CLK_TOP_MUX_AXI, 26),
 	GATE_INFRA1(CLK_INFRA_DXCC_SEC_CORE, CLK_TOP_MUX_DXCC, 27),
 	GATE_INFRA1(CLK_INFRA_DXCC_AO, CLK_TOP_MUX_DXCC, 28),
-	GATE_INFRA1(CLK_INFRA_DEVMPU_BCLK, CLK_TOP_MUX_AXI, 30),
 	GATE_INFRA1(CLK_INFRA_DRAMC_F26M, CLK_TOP_CLK26M, 31),
 	/* INFRA2 */
 	GATE_INFRA2(CLK_INFRA_IRTX, CLK_TOP_CLK26M, 0),
-	GATE_INFRA2(CLK_INFRA_USB, CLK_TOP_MUX_USB_TOP, 1),
 	GATE_INFRA2(CLK_INFRA_DISP_PWM, CLK_TOP_MUX_AXI, 2),
 	GATE_INFRA2(CLK_INFRA_CLDMA_BCLK, CLK_TOP_MUX_AXI, 3),
 	GATE_INFRA2(CLK_INFRA_AUDIO_26M_BCLK, CLK_TOP_CLK26M, 4),
@@ -754,7 +762,9 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA2(CLK_INFRA_UNIPRO_TICK, CLK_TOP_MUX_FUFS, 12),
 	GATE_INFRA2(CLK_INFRA_UFS_MP_SAP_BCLK, CLK_TOP_MUX_FUFS, 13),
 	GATE_INFRA2(CLK_INFRA_MD32_BCLK, CLK_TOP_MUX_AXI, 14),
+	GATE_INFRA2(CLK_INFRA_SSPM, CLK_TOP_MUX_SSPM, 15),
 	GATE_INFRA2(CLK_INFRA_UNIPRO_MBIST, CLK_TOP_MUX_AXI, 16),
+	GATE_INFRA2(CLK_INFRA_SSPM_BUS_HCLK, CLK_TOP_MUX_AXI, 17),
 	GATE_INFRA2(CLK_INFRA_I2C5, CLK_TOP_MUX_I2C, 18),
 	GATE_INFRA2(CLK_INFRA_I2C5_ARBITER, CLK_TOP_MUX_I2C, 19),
 	GATE_INFRA2(CLK_INFRA_I2C5_IMM, CLK_TOP_MUX_I2C, 20),
@@ -772,10 +782,14 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA3(CLK_INFRA_MSDC0_SELF, CLK_TOP_MUX_MSDC50_0, 0),
 	GATE_INFRA3(CLK_INFRA_MSDC1_SELF, CLK_TOP_MUX_MSDC50_0, 1),
 	GATE_INFRA3(CLK_INFRA_MSDC2_SELF, CLK_TOP_MUX_MSDC50_0, 2),
+	GATE_INFRA3(CLK_INFRA_SSPM_26M_SELF, CLK_TOP_CLK26M, 3),
+	GATE_INFRA3_EXT(CLK_INFRA_SSPM_32K_SELF, CLK_PAD_CLK32K, 4),
 	GATE_INFRA3(CLK_INFRA_UFS_AXI, CLK_TOP_MUX_AXI, 5),
 	GATE_INFRA3(CLK_INFRA_I2C6, CLK_TOP_MUX_I2C, 6),
 	GATE_INFRA3(CLK_INFRA_AP_MSDC0, CLK_TOP_MUX_MSDC50_0_HCLK, 7),
 	GATE_INFRA3(CLK_INFRA_MD_MSDC0, CLK_TOP_MUX_MSDC50_0_HCLK, 8),
+	GATE_INFRA2(CLK_INFRA_USB, CLK_TOP_MUX_USB_TOP, 1),
+	GATE_INFRA1(CLK_INFRA_DEVMPU_BCLK, CLK_TOP_MUX_AXI, 30),
 	GATE_INFRA3(CLK_INFRA_CCIF2_AP, CLK_TOP_MUX_AXI, 16),
 	GATE_INFRA3(CLK_INFRA_CCIF2_MD, CLK_TOP_MUX_AXI, 17),
 	GATE_INFRA3(CLK_INFRA_CCIF3_AP, CLK_TOP_MUX_AXI, 18),

-- 
2.43.0

