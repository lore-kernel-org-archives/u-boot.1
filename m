Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1DAC5DF7F
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26B5581195;
	Mon, 17 Aug 2026 18:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dy0N7uu434dv; Mon, 17 Aug 2026 18:17:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A8FC8115B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990665;
	bh=eBptooIT71p8XPgjRHWsM8DUnJuwyX8ZHKSSQYgHXAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xah5qOJrCTvQl1bPTkfHk4WfRvjs1ka0d2OXpvyucjE4/f1U4hmdGHRFWc8DtCZuv
	 qKdBFR6zrn4OWlQSrjNqtWGCyCcKTGtT+9DnlPy1MylftwPpPlvK4Ogi5tezWNMxjX
	 LdTk9mSePPmHkUH+RazMYCsc3Je3NbB70UlnaR6gYVBIVO8y/MLxCS2mgfzQDbYKDT
	 abFZCsTu12//7qENfvieoLLbH6tmStT1HlL6lPPlHHZn7uBXfQxRgWIWYDyQzyKh7K
	 vrl4Aj2lc1kN6pu2McezDseFrO2P58vQvRXVkTkffXJJVtZV2jaQbqF5TLRJ57WTxb
	 Usx7aJhdue9Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A8FC8115B;
	Mon, 17 Aug 2026 18:17:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C376282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8DA6C80FB7
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VoFfWeUqtB_f for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:16:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CDEA880FF2
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDEA880FF2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=LlELpu3c
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDEA880FF2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:32 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-51c0ecfaee7so23829571cf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786986991; x=1787591791;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eBptooIT71p8XPgjRHWsM8DUnJuwyX8ZHKSSQYgHXAc=;
 b=LlELpu3c0bjHnupLkbIVdAHAcWB81JVsbThFKW7v4KzTj9zouaZNOf1cex+xOmD9O1
 chLyWp9X5UVD6hYY6g7uQOEQHPb6wpgIRNny1jl530iVQqgoYJEw77VcIXV7FCDCKaYY
 tKYzjT6hj7CxJQfZD6KRJY9L85HiTUUuZsNRSYNkCqOxm2D775dDg3V2QSm2MHip23sN
 iyZl7j0Br9BtzaE6r6da/sAYeEi/xIIvppTZdqq9rxTvgljfJcXD8XfxQqy3dmrlT6iA
 eP9rXzg1GaKLCB467mdhB7ZuNIPUq/P+Dy3ijdUSsqcE8+rgXSm7GI/4r5vj2Q4QjiHO
 CaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786986991; x=1787591791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eBptooIT71p8XPgjRHWsM8DUnJuwyX8ZHKSSQYgHXAc=;
 b=X0u8GIrF7iaILr1oWy9Gk2ujk1k3FENzjWs1JsAqeHJeKTlMyPWiS+U7zbrFJiHnNx
 ADp2DkVgRjk6W8Fb0P3oqkErjGXGFEs+aRSpMQpCCplozggPmcGqe54AJ5tBkXE0dLQ2
 sYkLn71ZLQu4jAQT3WSWtUOlgBE+76LwR2w4fYujiCUfgnw6wVF5p0P8o9OmEvk6t30w
 mYJbIcxZG5KBy4AIaQVMzdhGmgHW95sVjOYd3QvvlPXTTPiF1P1mjVJww3Lqli2e03G/
 A2tlyh9exnl5sCYqOteQBI1Efa8fu2Y7dK6b7Mjh3gwRvnDMVOt5u/3tmUzGPrn8F/ic
 w9Ow==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlRaXvqxTIVFLlEi0eNSPx3W+BBINuVi3fWj+6tC9IrJkyVA0KbR/yycb6BPfyeSQE3A5elUk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxaMGPY/jSk2n/RDLboulZJr9mRPOKPJs21tzjfqLDJ3pk1scQK
 RQrcYUtnYbLGwx4Swt1BbWWCykj2SSm2kbjuLoiN38B/MPWsCNvJdLg4RI6Fz/syxfASjfvedEf
 WTCYugNSlfPhjoZzEhJeYSQMyZ5HIt4EzHcy0OKo+O5KCKXTMmOEwyDuEPU1wfDo=
X-Gm-Gg: AR+sD13gDZF9WLqg8Kn/+Tg5xauDuwqmoNBLYhsaP1j8FkhiO6j0ItyPbryjNOaTPM/
 qUbwErj7SmuCxct/80uMc3DLycgFE5nhZsgCAjPmQ5kQvw12asEmM3EMVcLL3VtBlqmIW44nRdz
 xEtDqOE091zWQG8dpCHlbeegxv20VsyqBHKAnTuDQ+3tq0kMOqg7NMjQY59s5FQIGQFdgIT+L0U
 +fY523ZWDCLdpVK9oy6MWqAV6eXtyoFBnfs0D5jUAS9V1BQLr1be7ot8PfC2HL0LR6JtIEvsere
 1H2Lm4I8D3OpklOaT3YeFKGy9jTKayc+aCTVIwXRRfLw5SNM/Tm3RSOFWC8lGSUr16SvHeDIuEF
 KeKUN0LTOQZRv7+Lw/StOlutEgq2DwVnSy8eeN/Q6q6Qj193xMIAa544zFeTKqeHuFLgDhjcmC5
 HNCVrnudGGuDBxuArNBHJ+Vt66Dt1zNnHH55smHlnfCW7N3UmgpnISD5j9gPiZHLcB0LNeSp4/V
 bN1zxZFO9/6sw0X3QGz3Y3owlE=
X-Received: by 2002:a05:622a:550e:b0:51c:857f:9c12 with SMTP id
 d75a77b69052e-52d8530dca8mr305010891cf.4.1786986991245; 
 Mon, 17 Aug 2026 10:16:31 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:16:31 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 7/9] clk: meson: Support power-of-two dividers
Date: Mon, 17 Aug 2026 13:15:18 -0400
Message-ID: <20260817171623.1943847-8-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

Several s4 clocks use power-of-two dividers. Add support for them.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/clk_meson.c | 49 ++++++++++++++++++++++++++---------
 drivers/clk/meson/clk_meson.h | 44 +++++++++++++++----------------
 2 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
index 29615fdae77..50c72276457 100644
--- a/drivers/clk/meson/clk_meson.c
+++ b/drivers/clk/meson/clk_meson.c
@@ -55,26 +55,49 @@ int meson_clk_disable(struct clk *clk)
 	return meson_set_gate(clk, false);
 }
 
+static ulong meson_div_get_rate_common(struct clk *clk,
+				       enum meson_clk_type type, u16 *n,
+				       ulong *rate)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+	struct clk parent;
+
+	info = meson_clk_get_info(clk, type);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	*n = GET_PARM_VALUE(priv, info->parm);
+
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	*rate = meson_clk_get_rate(&parent);
+	return 0;
+}
+
 static ulong meson_div_get_rate(struct clk *clk)
 {
-	struct meson_clk *priv = dev_get_priv(clk->dev);
+	ulong rate, err;
 	u16 n;
-	ulong rate;
-	const struct meson_clk_info *info;
-	struct clk parent;
 
-	info = meson_clk_get_info(clk, MESON_CLK_DIV);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
+	err = meson_div_get_rate_common(clk, MESON_CLK_DIV, &n, &rate);
+	if (err)
+		return err;
 
 	/* Actual divider value is (field value + 1), hence the increment */
-	n = GET_PARM_VALUE(priv, info->parm) + 1;
+	return rate / (n + 1);
+}
 
-	parent.dev = clk->dev;
-	parent.id = info->parents[0];
-	rate = meson_clk_get_rate(&parent);
+static ulong meson_div2_get_rate(struct clk *clk)
+{
+	ulong rate, err;
+	u16 n;
 
-	return rate / n;
+	err = meson_div_get_rate_common(clk, MESON_CLK_DIV2, &n, &rate);
+	if (err)
+		return err;
+
+	return rate >> n;
 }
 
 int meson_clk_get_parent(struct clk *clk)
@@ -150,6 +173,8 @@ ulong meson_clk_get_rate(struct clk *clk)
 		return meson_clk_get_rate(&parent);
 	case MESON_CLK_DIV:
 		return meson_div_get_rate(clk);
+	case MESON_CLK_DIV2:
+		return meson_div2_get_rate(clk);
 	case MESON_CLK_FIXED_DIV:
 		parent.dev = clk->dev;
 		parent.id = meson_clk_get_parent(clk);
diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
index 86b272985ab..46ee5519410 100644
--- a/drivers/clk/meson/clk_meson.h
+++ b/drivers/clk/meson/clk_meson.h
@@ -61,6 +61,7 @@ struct meson_clk {
  * @MESON_CLK_GATE: This clock is a gate
  * @MESON_CLK_MUX: This clock is a multiplexer
  * @MESON_CLK_DIV: This clock is a configurable divider
+ * @MESON_CLK_DIV2: This clock is a configurable power-of-two divider
  * @MESON_CLK_FIXED_DIV: This clock is a (fractional) fixed-factor clock
  * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
  * @MESON_CLK_PLL: This is a PLL
@@ -70,6 +71,7 @@ enum meson_clk_type {
 	MESON_CLK_GATE,
 	MESON_CLK_MUX,
 	MESON_CLK_DIV,
+	MESON_CLK_DIV2,
 	MESON_CLK_FIXED_DIV,
 	MESON_CLK_EXTERNAL,
 	MESON_CLK_PLL,
@@ -122,18 +124,25 @@ struct meson_clk_data {
 		.type = MESON_CLK_MUX,					\
 	})
 
+#define _CLK_REG(_type, _name, _reg, _shift, _width, _parent)		\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = (_width),				\
+		},							\
+		.name = (_name),					\
+		.type = _type,						\
+	})
+
 /* A divider with an integral divisor */
-#define CLK_DIV(_name, _reg, _shift, _width, _parent)			\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.parm = &(struct parm) {				\
-			.reg_off = (_reg),				\
-			.shift = (_shift),				\
-			.width = (_width),				\
-		},							\
-		.name = (_name),					\
-		.type = MESON_CLK_DIV,					\
-	})
+#define CLK_DIV(name, reg, shift, width, parent)			\
+	_CLK_REG(MESON_CLK_DIV, name, reg, shift, width, parent)
+
+/* A divider with a power-of-two divisor */
+#define CLK_DIV2(name, reg, shift, width, parent)			\
+	_CLK_REG(MESON_CLK_DIV2, name, reg, shift, width, parent)
 
 /* A fixed divider */
 #define CLK_DIV_FIXED_FULL(_name, _mult, _div, _parent)			\
@@ -156,17 +165,8 @@ struct meson_clk_data {
 	})
 
 /* A clock gate */
-#define CLK_GATE(_name, _reg, _shift, _parent)				\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.parm = &(struct parm) {				\
-			.reg_off = (_reg),				\
-			.shift = (_shift),				\
-			.width = 1,					\
-		},							\
-		.name = (_name),					\
-		.type = MESON_CLK_GATE,					\
-	})
+#define CLK_GATE(name, reg, shift, parent)				\
+	_CLK_REG(MESON_CLK_GATE, name, reg, shift, 1, parent)
 
 /* A PLL clock */
 #define CLK_PLL(_name, _parent, ...)					\
-- 
2.53.0

