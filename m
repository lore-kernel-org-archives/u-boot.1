Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB306CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D40B60690;
	Mon,  5 Oct 2026 22:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9xWanD1ImbQ; Mon,  5 Oct 2026 22:50:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C0B5660760
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791240645;
	b=fWMAl9Lom22x/3yJWS8/JOskGvTlZewa3sLDisV/sCXz5OPTVFUO9sy34Ku2BmjfJHgf
	 v5//aHI6cSdZe8S0X4ZNgMygC92NjKTMZwnZqm1l+PN1y6C0GE5vNPrJpUwgduIzWWSn/
	 DkYQXWHru37WphYCQEYezieHoO0vg6lvWeCfdBx+VseS6XCgL1KSR+A+maRzR0BqA5EOh
	 rqhEHmsjGnLzUQn3LV8rhiqFF4xehX/iQCZIpuXL4mfFjqvGW/RKYyQCjSUwKv9CvTMHT
	 fM1fWR3bsIOpCsvyW+O8B9tI1RC32uoFjfVdAlpz1YoE8o1SRGJ5pZ6m7gq8P2GXqfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791240645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1XxuW/Rwt9La+qwih2vWFr3r08PFnNe6nMBjb9BfQXk=;
	b=gWbD6nlWlI47riApKJkUuR5keIBGdaOq4dEUpNr9b3e6L7Y6Qi+ekoeARpmdnCw85PjD
	 rAN/cv2s/waMFA4AzbYEzBg83uYdykeG0vSQwp4Cqnw3A8lplt4OpHMn4hc0EtaWpHwjp
	 5aw2sKrtz2CHdYsTptkguJipLvffolLVWEh2NqzdELXoVaglU6z8XgcEO8vGA+FmidwQQ
	 u7KqVDv6QlTwKPko9PaxA0thUEVYqq6ThQAKUk3/mLIu922Wkgaooi2R8cBv55tpboM2r
	 whG7PDQf0vmInbv+Ko2Tob6QThuXkQ+QCgabUOhKLGlFzj0iP1kKAj8FUJWnGxUtl8w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791240645;
	bh=1XxuW/Rwt9La+qwih2vWFr3r08PFnNe6nMBjb9BfQXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=APGgp023jcpd0UT+8wWyq8v+6XXdxIZeLQmjBXyaMVmbNl+9BLdoCIpdQSWU0zWLF
	 S+IBtsidAOl1ff9+nneOXw3UZoHRdf6OLLoxYa7S8fJfSIJ5rY9kqWVE4EvcpjBH1h
	 BnleKB8jrsj4zD7hVkxsvt2EtIWDnwyTt14MOA05906b+dtib0lGahYSEBXG/eQ9qu
	 qDJfEF+LM8v7tSVYl65bU5vXk+Wimx31c6Mw+mOCfAm5zP0yiT7dDKFlGqsXwrWk5F
	 GUnQitJGZ3E7/bIRBIeJmt6LBX9z7g0bLPb58/HIynQdWfhMaD2tB4fAVcWn0LU1GE
	 no2Qw95y2Gl1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0B5660760;
	Mon,  5 Oct 2026 22:50:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BB3E434E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD34540203
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j1zn-dcs9Cfp for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E028240042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::27"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791240217;
 b=N2SToDNOy9qH6DVWIHOHn0ItXvzPh3JhY3uWE7TKtCnAAPwvP0RZxTpNOhnzl2QYPN6T
 U/LttJLahh4EYcxPkcsBtiCZhiwmRnSV2vBFy6Lg8nzS4arbGWQsyqJpDwQq7NHjHaRET
 Mumld9G84xOxi4yTV8FP6s3ldjn1tm+IMdiAjSuDR6Iul91ndMvfT8azzBNYXtPwTxOeQ
 N8SL/vDHRQShdaCiuHd6sjFDjgcK89cm7v+9XpabnCCCrjr3atmbDDXmXjFRpNLVqTqto
 scKfcIgAetPmZ7Bh0TtBtv/s6EnAPwyJjI0cf1HUK2l9MwkThWbWf0TUF17fH/Jcztg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791240217;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=1XxuW/Rwt9La+qwih2vWFr3r08PFnNe6nMBjb9BfQXk=;
 b=P5ZaAsVpD9qdeZz5DUWLGX7ySlF/wsMdjcKb+ZxG4bdDMwdCtdf5ZbazMnZUXROQFGn6
 TkAemv5RIHQ1vd32Che8Uv3PUbsa5lTbp+ssxlRqCahAAFQancUfBb4fgKlDHN96fKquJ
 Aqudu682Zmkw8T6I59GeLnZLyUkA4wx9z62weMgwsPj35VFY54ePbhp6qVq+3x2/X1Hny
 Vel1xmBDE2UtY8W9JR9vU4jcYq9O1N9uLvZEIvPKNCeJbn5svHs+GgTy3B9VUAfSqBKTn
 Q9swOlXvf4sm13qqBSU8Zk48vizOQ2m5b1OP9F3hnJwP5OPc78S1FMhM9soykBPOJpA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=M85Tvbiu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::27; helo=mail-oo2-x27.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=M85Tvbiu
Received: from mail-oo2-x27.google.com (mail-oo2-x27.google.com
 [IPv6:2607:f8b0:4864:31::27])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E028240042
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:36 +0000 (UTC)
Received: by mail-oo2-x27.google.com with SMTP id
 006d021491bc7-6dd4abbdd97so649941eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791240216; x=1791845016;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XxuW/Rwt9La+qwih2vWFr3r08PFnNe6nMBjb9BfQXk=;
 b=M85Tvbiu9xRrt+6vBs8ahqchNwl9n9VEzWQ9jYQ1ggsY0r6gahh2Ev3hyVpZt1SDMV
 Njv2LUwQjV90KpWeCJOqng0egVuiiMUqGB9ypBCWjbPYtfqq2hDcHXkPRwxEn3cETM2S
 jw9XAMRGAbP4R3UrD6q1f6KWFXhjRBR3vR0Eu+jhP75qvHTcj/V8CAQe8I7/YPsphw3P
 t8/AoxfYtwHbTG99AMwvsC5+/dN5VqyMzahS7xubNCS0R7zhqPx2PMEBoiV80S4JJCgi
 Mhh0zJJUtnCamGjcO5ZY9AOISvAPsHIytHREAa8mKUZ9VOJZ2ieAq1PuH8a7Cl2cmEi+
 Ja+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791240216; x=1791845016;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1XxuW/Rwt9La+qwih2vWFr3r08PFnNe6nMBjb9BfQXk=;
 b=TDJg/DBWLgFVyeRvsN0gaTtV5L3+ZMeByXnJz/jPUknwurCkDW/rrWIzRFA+/QrzDh
 zX6n46G1guHb3RBrsoEQ0mzAlfkpIyuEYyzNX6Dy6pA1sUImATYx6WWZ//2AWHV3uFuY
 BjYwqMOFRg6Ky2+rg5vVCB/6WEeJ3at+Wvoagq7sdjW1yndVg99I95sZXhnl7kgEw/Xc
 q5tOVDF9g9KnD6zTY0RlneResXj6ciUaySzYEqrOTBD0oEniLjGFBLHIsTOlPd8VDJvK
 09z1M+3H0MOxZ/MlmxAcuDiViZ/1GM30osk1LJ4fuKS/SCd4zgpaOdQ/BJZu0FUBSqi5
 d3EA==
X-Gm-Message-State: AFuF++lCaA4ys+wLp+1rXmmd1rhnfOou4T1HszUpAInvfIsrQi20c5Cb
 w4UHrfS6OnE0n6yx+ymi2OuuV3hARGbeCiuuU5q4SVt0VpEJxMes9EqjLcYDfT9/ZR4=
X-Gm-Gg: AYBFou32EVG7KcOw4QWbjYDhTf2iQBsUGnddVLGY/BOPgNyMlGMsiG1WY/eeIH5Rlqb
 8mzAzSgAWDrOht/IHv3UOscvpD/y1ekYqNhGt3bI/QX3knYzWRd2q7BzIrnz+h42Qd0cj/VXDdz
 qaWwuUXSsTAcvaUnv8hiX0u1MwSPsS6Nqz71+hxhTKUwS274+F7ZK545OgGgPkLkVTHZpc4hTUS
 s2iRUvIUHwH/nw/AXFwXUzgx47hvXJbUOpZuTUBUQOiEYRt8ljEsvNENt83xEunax4cMVMvtGtq
 M+BvuwB9l7BFkDJEpw5N48j94NqQ8HtcNogwmXO4LjrKYmNDNO9c4Wppoic6RLAnFcJ1IwQseRW
 3iLsvA6jc4wBms8xkZjbD4jU/INWdO8udoEJSVN3Ki4ma/jjsRQ1s17gIAN0U2c9ZtJVJ8XiycW
 WYaFcVZh6WJGdJm3Vaszq7LAStW+/YYcG1+6yaCrvZEqecRoltRKqyWAHl9rFt0TJ0QNPhiuNtn
 gM=
X-Received: by 2002:a05:6820:80c5:b0:6d7:6062:ccb7 with SMTP id
 006d021491bc7-6e4a4aee038mr767940eaf.29.1791240215755; 
 Mon, 05 Oct 2026 15:43:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e4c04d915bsm694448eaf.2.2026.10.05.15.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:43:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 17:42:49 -0500
Subject: [PATCH v2 3/4] clk: mediatek: pass the input rate to
 mtk_pll_calc_values()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-clk-mtk-propagate-rate-v2-3-b823df57e4c8@baylibre.com>
References: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
In-Reply-To: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=aTJnC2n3msKD5Dlq/QiCCb+rtZjtblfpQknRpmZk2u0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxCf+pSqOX0UBipBQctBZekybJSlprdOMHU8fH
 Dh7qSW5dxKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQn/hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A0DsH/1IPCdzVi/b/iJcelSblMgsah+kzMu4d3TECC7V
 YzDZvNJMqBHs9DA8Qu5ijGiQ4QbjFfl8fBOlvJc83RwfVKk/8351eiIePpNGeHjPQRbZ+EGrs6U
 evNinS3a0mYCaaN1T79WODr70Hn+bufMMxpz0LXbChahYSi26xL0FZmd5dnnbiM4nSHhIRFhG6v
 FVXy+9axovHd8gW8OZFpVjE/kdKe259pJ3shfRLwm/Zg46X/6q6D1TDIh/xOAdapdL6+Y29oh1F
 dVACyAIu/2lJuLf5t6cKtqFkA7o2k1mQcdMWIs7tCJinHx7cZZsGxGmtWhGR+2+1q10CodQV6Lc
 TT0Y=
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

Have the callers look up the PLL input rate and pass it to
mtk_pll_calc_values() together with the PLL data, instead of the
function looking it up itself. This makes it a pure calculation that
cannot fail, and lets a caller that also needs the input rate look it
up only once.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index dd2d7e4e755..1d7a65904a1 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -505,27 +505,21 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_priv *priv, u32 id,
 
 /**
  * mtk_pll_calc_values - calculate good values for a given input frequency.
- * @priv:	The mtk priv struct
- * @id:		The clk id
+ * @pll:	The PLL data
+ * @xtal_rate:	The PLL input (reference) frequency
  * @pcw:	The pcw value (output)
  * @postdiv:	The post divider (output)
  * @freq:	The desired target frequency
  */
-static int mtk_pll_calc_values(struct mtk_clk_priv *priv, struct clk *clk,
-			       u32 *pcw, u32 *postdiv, ulong freq)
+static void mtk_pll_calc_values(const struct mtk_pll_data *pll,
+				ulong xtal_rate, u32 *pcw, u32 *postdiv,
+				ulong freq)
 {
-	const struct mtk_pll_data *pll;
-	const struct mtk_parent *parent = &priv->tree->pll_parent;
-	unsigned long xtal_rate, fmin;
+	unsigned long fmin;
 	u64 _pcw;
 	int ibits;
 	u32 val;
 
-	xtal_rate = mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
-	if (IS_ERR_VALUE(xtal_rate))
-		return xtal_rate;
-
-	pll = &priv->tree->plls[clk->id];
 	fmin = pll->fmin ? pll->fmin : 1000 * MHZ;
 
 	if (freq > pll->fmax)
@@ -543,8 +537,6 @@ static int mtk_pll_calc_values(struct mtk_clk_priv *priv, struct clk *clk,
 	do_div(_pcw, xtal_rate);
 
 	*pcw = (u32)_pcw;
-
-	return 0;
 }
 
 static ulong mtk_pll_get_rate(struct clk *clk)
@@ -576,17 +568,20 @@ static ulong mtk_pll_get_rate(struct clk *clk)
 static ulong mtk_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_parent *parent = &priv->tree->pll_parent;
+	ulong xtal_rate;
 	u32 pcw = 0;
 	u32 postdiv;
-	int ret;
 
 	if (!mtk_clk_id_is_pll(priv->tree, clk->id))
 		return -EINVAL;
 
-	ret = mtk_pll_calc_values(priv, clk, &pcw, &postdiv, rate);
-	if (ret)
-		return ret;
+	xtal_rate = mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
+	if (IS_ERR_VALUE(xtal_rate))
+		return xtal_rate;
 
+	mtk_pll_calc_values(&priv->tree->plls[clk->id], xtal_rate, &pcw,
+			    &postdiv, rate);
 	mtk_pll_set_rate_regs(priv, clk->id, pcw, postdiv);
 
 	return mtk_pll_get_rate(clk);

-- 
2.53.0

