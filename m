Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72217C98321
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7214A60BEB;
	Thu, 24 Sep 2026 19:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ppq_UO2Yq67W; Thu, 24 Sep 2026 19:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0976F60BC9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279038;
	b=iZWlNqIuk8R8uwiwerE8lmOgOiXnIE3dDpIG69zlyPnpR2dF5O4675FB/xUE694DBGjD
	 CnqwV/zsDJyxdeL9k5MSthqQwp3HXxObl926qFjp9xUgXNPQnrKTL5BvG/wlj9dKTmdkV
	 kqM02ARxf+e5KxuFRR/kshsdSAaC2WZ5Rte9JyaXxjWMaWAVYot9UiJP/pL8G3usSEzI8
	 JAHIUlCi/8o9hRrf/Yjgc1JjQnvN9lAqmqnQSIlMk9pJ+Lkp3/sONzOHgaxbSkMuD/+Cz
	 RnSgsd+sQ5/xM6Ek+lSp+RP7mNTck1toDQ0S28C2UCAdzSIFF7StOKOdKaG0NgbB4vA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FpX1+4NirkVXHigDFWedT8Xfxin3phuT6setDoH60Kc=;
	b=aco1cMM3bn3JGCX/GWTw1+zNIxN618WSvVvsLvQhpceoMQ59HGy9vvAHBRcJTBUbisVx
	 fOdFYHEq3JFYX0xBKPa1p+NdTOIxyHe792skNqZq+WmEa6obzv4AE1RwDgmXGoj4TH2i1
	 Wr8y7lPEuyS6Rn2oFkl88O0TwqtqFe8L+jU8CewqRV7k1F+BRgb+D4y6W33S2rmdEBtsm
	 ztNZRQ2pgdgft5rqe62F68VtHRq0kwQf24ZZEToLSBjjB18cvu9cBgWQX8U0nAaBaeHgi
	 k/YT/tXvbxqDvbqw4vThWXMz5VMT26SpSocQJojRoxYWomBm68ceBBdlKEIQPTcEzxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279038;
	bh=FpX1+4NirkVXHigDFWedT8Xfxin3phuT6setDoH60Kc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cOonHy0rDCJwDxii11ebp0KpdTarhMGjSSQ2tsaGIaxIJt02DZuIzWvglMPLpHGJr
	 9/lnuUSpjWiN0Q0WHpa6zopPHh2+wCmVICusBCQZm+99tswzMwtinurC/XyRg7nlfr
	 bi0CVMKjWzuZ2wXqRK9ZTUpuULBOFXujZb54+bg2BLtgxW6DRU4QbeV0Lwxwgm1deB
	 Wi9oJSZTNbjF8HQGCkNNlXkitEk+mNN3Cqj3O/C+a2L2DViexBK0E++/kEhUFESLRP
	 lkinA5lu4q/LY99SpUsl+esHeUm43Vo3zYi12WW6WYcD2zBoPq6c3FyIxEb+cCxanv
	 Sckjc6OMkw54w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0976F60BC9;
	Thu, 24 Sep 2026 19:43:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90F422F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8265A40BD3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pjPf8q0rKb7S for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 946E940E3B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279032;
 b=LM3U1KhxV2Jdo+Zw8LGmCzyd3vpoYiOvuHbpSeRE8icYy0e4SQRHpLH/eOxqgnx5siuO
 AytMspXbcmSf4zVewC7KSAOoK5io7MMo54H7fqyIVmoZYeOkEapPfyXocTERiY+2DmaDt
 X+3tEIZq5uRnHcyFOwIzB0LT1PIHbhgyV8K6PNBJEAHXMDe45MuU2CYZzqUxaV/uAsnB3
 UKyKu/OKt9zAWgQWN39De18zc+2OAPXr9piHSxoX2BMZ2pRW2zICmQGSFti+6dS5+pksz
 urDFsqvtLOGMivfFcH21niIaffvBC+M2ZkE+Ew5JWG+MoOA77waZiJUHOfoRlBApCjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279032;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=FpX1+4NirkVXHigDFWedT8Xfxin3phuT6setDoH60Kc=;
 b=mfhRb0673h4xRUWH9RmzTXTE+4dvhE5xI85v5W1WbqlpgI/gKC2rlz/6ujas9hZ/+1/o
 6PTneRB5Tt2mnmQsljSSVEqb1xhBT0cCHXzrciuF6t6KDIhOTXPEaZVYlRVc3e6hT2h3P
 J3e/h60O1ODQtl0nP/rRLZ6SR7rgdd22PpgrIX05OYy6eOp8/LwyjZ+UVicdEos287TeH
 7pcmIzUEMVRIRZpSUiD9ATrXkgGcRdzXNXk5iG4aZN+NIaYNbN9luYB5whZM2C/Tk/G4k
 5QaOV7WaLCP7ARTX3jIKVZ4Dzi6KBIEFJdzn8DzQyLPin1eCXLs5Sq6wFz3xGQRSPog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LnS2Iduu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LnS2Iduu
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 946E940E3B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:52 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 46e09a7af769-8177a7fc354so81286a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279031; x=1790883831;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FpX1+4NirkVXHigDFWedT8Xfxin3phuT6setDoH60Kc=;
 b=LnS2IduufUYrFBaO9L9KXrGXK7ooYb5Sp8QBtb9W08p5KTi7YHXkFVjPIwbtQYD7jI
 5H8WjM2vr1yqrn53iCwQmG3pZJyb1SS2b0ImlF7MFVfTMC7zGgZTcImBthabRhPyaNSu
 EAaO+6+XE1fsZQE/8GbfUxbVWubG7kvc03AJ3jSFHwWpGaIYPPxilHLl9JKl1eKnZAwk
 WYYGaM37ZeT4/vMB4L+lbd9VrubUg56DziDFa5TNnxoCxucWy7VTdLHGUu10n7X/bNN4
 vnSbPS0MwSAg6VkrrBHKfLDx0nthSV+U99rJV8S+mUZC+wgNAgD7darb1ey/tJmGrwBC
 yC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279031; x=1790883831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FpX1+4NirkVXHigDFWedT8Xfxin3phuT6setDoH60Kc=;
 b=EdkUEOM8nzr6DUd8DitYFW7tR/2/CYEzlEgQ7fy6Ma28s+d/z76onH0aeTBbuS8ORX
 OKBerdiw71QQ6ivDG+kXy8sJOWF1505LpoaCJJfxWvWVOYWLL25mQYPicydSvrBkKpCC
 MG4LdWY3jREM9HyajSqTunK80Yf0PpwDQwc+9uSxQsX9iW4xDugpQyw5sSzVfSdo0dTf
 bjtNA3mAKwg4QddpcVJ/7YA8hCRtb89ODEh8klZbtu0FD7+mBqOgieE4dTqPCspy/c0c
 VHsvbtz9SodLQOP0nlPk5cJc9D91knQ0Wb9uuK673/3n2uPTJDskM7S24beiuR7dbZmk
 R4VQ==
X-Gm-Message-State: AFuF++lwThWvqA7zUGL6iRj/e4hbtlPkv2PUWUEbhtgHogoc2TD6qhBP
 BeWVuBGvFx02eyGR2knOMnWqinEsTYD028l4gCwwcgR5x+DlzDGlUXt94jKz0ZcMLNM=
X-Gm-Gg: AYBFou3ijExGh4PrXpK8C62IMTjTP6nmoLoQpMBVLLybyFMVPqLEyhQqMOpkfBPLDFR
 5YFzbhDmHMpBUVfiSnRvykQC+ycKVP9iOT+SMrg4rGyldxWvTn8b5Xn0V0UuqNbbpE4cLB/BDsG
 6wGoAIP1Mn3j1tRvXy2ZD8bARouGV6GYuov/uWZlMEq/zaF+bOxT9aEg6K4UckQVL9lPtFHJusU
 hvk+DBJza/gOinfTj+n1KK5eYgwOB6gZvPEsrVpRKcDIGbNQAnigXV9a1zlMJWmptQVmLvSt8/t
 bM29ulRSCPGHR0Ojkp9DsmBE7g4/3en84RD5LupwWqNviIcmjbGPnjRuvK2oVOyzUFcZIYSIJe4
 0whVCX3zhDEui42lovkA+6ri70U2y2cEfv967wXklM0XJ8ckbNXHqmOG0fLbBaSjPibOPDN1WKk
 BJ0SFZ0M8jzlTdjNuhn87vOURIVB/W0ph3c6Npgh43kzcyKZD8RgT8srSJwZvQ/eT9aMsVAwJh4
 YB6rmVb/sVpaQ==
X-Received: by 2002:a05:6830:2e04:b0:80a:e14d:825e with SMTP id
 46e09a7af769-81783b97024mr4719186a34.30.1790279031078; 
 Thu, 24 Sep 2026 12:43:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:43 -0500
Subject: [PATCH 05/15] clk: mediatek: merge the dump callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-5-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4954; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ummy+Z8Jt4bnfvISKh4AIudHTc7SXJUX/Gl6ObbdsTE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX0dwj3ZAxZHpeveeyY+kcviZAM6WKtHZm+v0
 ijA6Aqspn+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9HRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AY0sH/jXY7XlJtk2nvAvQY/DHm5JnroZdLPwFeaEIk8o
 +2EpwUC9tJ00ICS0ytr7dYlbn1elBWCPppfarV8GDQYJCklwwSwgVFhZbZ98t4qSCOgpeYonTqd
 BylHeOlBZSjsiQ3aaVksJZ086wwvnkxo9oy/xsBFuusce/FeytmW/5bWD5xoFpEGxGOwvzfqYPR
 th3LY3b3b6c8cIFAv91CsbJsYsUq2wEgFlrvzL4ILK0+Muho5Fxyx/DFyA1q3kJcKh2O9ARKtgR
 z4gw4nQmopmLsdLbeuC7cm5MY/LQPywDJwxaa1dMP859ipX9j872D6tgFmIjb1DXMDFurOb2hFO
 au4k=
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

Replace the apmixedsys, topckgen and infrasys dump callbacks with one
mtk_clk_dump() that prints every table the clock tree defines.

This changes the output in one way: devices using the infrasys ops now
print the rate of each fixed factor, mux and gate, as the other devices
already do. The infrasys dump left the rates out, but nothing prevents
reading them, as get_rate handles every ID these trees define.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 85 +++++++-----------------------------------
 1 file changed, 14 insertions(+), 71 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 6fb329ef7c6..a18512287c2 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -649,34 +649,6 @@ static int mtk_pll_disable(struct mtk_clk_priv *priv,
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(CMD_CLK)
-static void mtk_apmixedsys_dump(struct udevice *dev)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = priv->tree;
-	u32 i;
-
-	for (i = 0; i < tree->num_plls; i++) {
-		const struct mtk_pll_data *pll = &tree->plls[i];
-
-		printf("[PLL%u] DT: %u", i, pll->id);
-		mtk_clk_print_mapped_id(pll->id, i, tree->id_offs_map);
-		mtk_clk_print_rate(dev, i);
-		printf("\n");
-	}
-
-	for (i = 0; i < tree->num_gates; i++) {
-		const struct mtk_gate *gate = &tree->gates[i];
-
-		printf("[GATE%u] DT: %u", i, gate->id);
-		mtk_clk_print_mapped_id(gate->id, i + tree->gates_offs, tree->id_offs_map);
-		mtk_clk_print_rate(dev, i + tree->gates_offs);
-		mtk_clk_print_single_parent(gate->parent, gate->flags);
-		printf("\n");
-	}
-}
-#endif
-
 /* topckgen functions */
 
 static ulong mtk_factor_recalc_rate(const struct mtk_fixed_factor *fdiv,
@@ -840,12 +812,21 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 }
 
 #if CONFIG_IS_ENABLED(CMD_CLK)
-static void mtk_topckgen_dump(struct udevice *dev)
+static void mtk_clk_dump(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
 	const struct mtk_clk_tree *tree = priv->tree;
 	u32 i;
 
+	for (i = 0; i < tree->num_plls; i++) {
+		const struct mtk_pll_data *pll = &tree->plls[i];
+
+		printf("[PLL%u] DT: %u", i, pll->id);
+		mtk_clk_print_mapped_id(pll->id, i, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i);
+		printf("\n");
+	}
+
 	for (i = 0; i < tree->num_fclks; i++) {
 		const struct mtk_fixed_clk *fclk = &tree->fclks[i];
 
@@ -888,44 +869,6 @@ static void mtk_topckgen_dump(struct udevice *dev)
 }
 #endif
 
-/* infrasys functions */
-
-#if CONFIG_IS_ENABLED(CMD_CLK)
-static void mtk_infrasys_dump(struct udevice *dev)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = priv->tree;
-	u32 i;
-
-	for (i = 0; i < tree->num_fdivs; i++) {
-		const struct mtk_fixed_factor *fdiv = &tree->fdivs[i];
-
-		printf("[FDIV%u] DT: %u", i, fdiv->id);
-		mtk_clk_print_mapped_id(fdiv->id, i + tree->fdivs_offs, tree->id_offs_map);
-		mtk_clk_print_single_parent(fdiv->parent, fdiv->flags);
-		printf(", Mult: %u, Div: %u\n", fdiv->mult, fdiv->div);
-	}
-
-	for (i = 0; i < tree->num_muxes; i++) {
-		const struct mtk_composite *mux = &tree->muxes[i];
-
-		printf("[MUX%u] DT: %u", i, mux->id);
-		mtk_clk_print_mapped_id(mux->id, i + tree->muxes_offs, tree->id_offs_map);
-		mtk_clk_print_mux_parents(priv, mux);
-		printf("\n");
-	}
-
-	for (i = 0; i < tree->num_gates; i++) {
-		const struct mtk_gate *gate = &tree->gates[i];
-
-		printf("[GATE%u] DT: %u", i, gate->id);
-		mtk_clk_print_mapped_id(gate->id, i + tree->gates_offs, tree->id_offs_map);
-		mtk_clk_print_single_parent(gate->parent, gate->flags);
-		printf("\n");
-	}
-}
-#endif
-
 const struct clk_ops mtk_clk_apmixedsys_ops = {
 	.of_xlate = mtk_clk_of_xlate,
 	.enable = mtk_clk_enable,
@@ -933,7 +876,7 @@ const struct clk_ops mtk_clk_apmixedsys_ops = {
 	.set_rate = mtk_apmixedsys_set_rate,
 	.get_rate = mtk_clk_get_rate,
 #if CONFIG_IS_ENABLED(CMD_CLK)
-	.dump = mtk_apmixedsys_dump,
+	.dump = mtk_clk_dump,
 #endif
 };
 
@@ -943,7 +886,7 @@ const struct clk_ops mtk_clk_fixed_pll_ops = {
 	.disable = mtk_clk_disable,
 	.get_rate = mtk_clk_get_rate,
 #if CONFIG_IS_ENABLED(CMD_CLK)
-	.dump = mtk_topckgen_dump,
+	.dump = mtk_clk_dump,
 #endif
 };
 
@@ -954,7 +897,7 @@ const struct clk_ops mtk_clk_topckgen_ops = {
 	.get_rate = mtk_clk_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)
-	.dump = mtk_topckgen_dump,
+	.dump = mtk_clk_dump,
 #endif
 };
 
@@ -965,7 +908,7 @@ const struct clk_ops mtk_clk_infrasys_ops = {
 	.get_rate = mtk_clk_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)
-	.dump = mtk_infrasys_dump,
+	.dump = mtk_clk_dump,
 #endif
 };
 

-- 
2.43.0

