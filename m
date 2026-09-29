Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2812CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A446C40400;
	Tue, 29 Sep 2026 20:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f68IRLcPl05v; Tue, 29 Sep 2026 20:33:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C3253407A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713983;
	b=W71dNwzVjipWKKZF8/uWfW3UPOynorQ5shvKYpUa0WcaKNg1qvzNVFekO4D6XvuiuBpe
	 TFbfbVSWHftgUq0KDEnTE4HI1GkGFn1mcoYw0t7DgkrBVAtCa7YMLh6M7US9i3WYtuqKa
	 FZatMos6EZARgwNj1QNHoPCbd6it0xOsp4jvOg5rOJQaypixfTKBHc+M2ww3BqSpGTOst
	 vjECojWxByJv0+PDDu4So4GUK65cV+VVjgztcB3tWugxf3b39Tqy9lIzpJ+/64YDV2s3i
	 5/C4shUgIugO0GLW18uqSyZdbd+hXp4D3godG2gAqAtXuwUcgrghyL6IHjamoFPcclg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713983;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oGonT6puGsHevu+WwQyWxkFstkTKf/kDVp9AMZCoCAQ=;
	b=iENUm9Sh2YHAEYzqQHeHQ21OREJHqCMk7CDzB0pWEPFmiU1EG4vxYHyWLrf3NrSFA8NF
	 zeIVFui/oG/imskJxjvU4VNUg1mh5+pFhj5mXqVC5jN3EEB5CsbuEsg8brH4+L1zwyNuQ
	 RA+VuYz9v0NiO6e7s0QQMeYrwmmTb1xq98Kb4XgiDH6jq+3j1C6QxwhwKp6hipc5ryleX
	 4+CLvBtMz4tMud78aGywJUbaRf9LrfizcIAfNx2g8Zm+sow8reFleeSPeIgSDq9dEl4ob
	 IrpYxoBhj5Bym+odIEbdDO7Zr1BXUqBTTU+olw4NprHfOObc2bQQE3JtpJYqI7IiD1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713983;
	bh=oGonT6puGsHevu+WwQyWxkFstkTKf/kDVp9AMZCoCAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxELnxQb9dIbrqN1zvN2CEpfncR1nyZV2mMOqKcYgINMXvpoFQ9HQ2SQEa/+Nhg3s
	 Jye7ck9UnRuxO7kaQNyQm2wOr3ckQQaLACrl6QyjElqm1riUke8nH7ee/GuQVrdo6o
	 o7FbeXhvYDG7W6g1QImnLWm0liNuexdyLTaQuqAo+fI2U3+IamJN2nmbmo5XX59g2G
	 ZkdZtBRoGbLaHDrStJp2sg2cNrFACymJaMGNwkZ/iCWqLm5H0dWLPpI3/AusYjTi7t
	 pWx+d6BrX968kJldxthB4fCWz/dLyBQHGmnLIQk1kddInPZ+J1sgjb+hbAhlt+s+t3
	 cgDRpw9602wOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3253407A4;
	Tue, 29 Sep 2026 20:33:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 01E4514C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E85C26061C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W2zyHgait4Nq for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F3DBF605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705252;
 b=e0vcp5Dw+P+WFSOtRTcFXRlANqfis5pQ6PhPiulsDKS5xe2pBruEq1LHVH+nOLH0H532
 c37+rkmaNHrh0ZpxM1Xly8AWENWplzBcyXrGK7SLhwlpKqf+yeJ/BldzPxuRJ/2wQvwz7
 x5/kzF1UNxnx2kBv2Vv3ok3GdYpFe0NNIuUOMuQzucC7gD2ARtFQDry6lzIGKeHMW3hvH
 R77OUcE73qEscJ0ZOncxe+JgRtZ/oRcMnGesxeu5U72tg/eEpVVVkw+zcCmU0oQdFwl+R
 /qWr1TUhMINsM+hjoQHGLDPYjP2PAGgC//JcJiLviu8vTxJ2qfr9zz+vgs1ewQ9AODg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705252;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=oGonT6puGsHevu+WwQyWxkFstkTKf/kDVp9AMZCoCAQ=;
 b=J52LSi5eSyAaBNXlx3biSuKhOggj0gQEOlXowjtZ/XqLC3aABhhzEl0Fl1SSxrWmuoad
 awiLB33138oos9OsNuPMeq9RF/QtMWVdPqIVDRzDhjKKzN97WVoQMjctrMQNVdG1esp+J
 oDQluoCx85y5SMUiUbl8WnHUI3BWmD7UyP6xE1jUPyMg3vBcPoJlMJ89FH0f/980wIimA
 RddFQDfRw4nuqCKP5NBWOzmv6ZO17rWXZFJ735Dpc+jDd952H+CE1lEeC6CNgORn5E2JX
 Y+2+eGuBhxM9cdGL2q52GZyOJLJ8Sc43Uaa/wXDyT3NurMsVr3v5XsatXvJcmJVhb5A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=d4a39GIJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::2b; helo=mail-qk2-x2b.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=d4a39GIJ
Received: from mail-qk2-x2b.google.com (mail-qk2-x2b.google.com
 [IPv6:2607:f8b0:4864:34::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3DBF605ED
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:31 +0000 (UTC)
Received: by mail-qk2-x2b.google.com with SMTP id
 af79cd13be357-93c65bc4616so286732585a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705250; x=1791310050;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oGonT6puGsHevu+WwQyWxkFstkTKf/kDVp9AMZCoCAQ=;
 b=d4a39GIJg2L7pbRghWmVDHHDkdX0r5uWNkio0+7FxMgVzkFi0G/bSsqu6/2LRMpKyQ
 1INRUUvtTHh4AWB4w4qUG3Iydb4Lqb6WXx9XAgdptMKrw8slIFFVvTF9tTuWb23Xg8Rt
 o5z0r1HqfiQ2IdCvwJ9uks+6aYihZZmL5lbWgHLqSdxBETczQ289YBf7+4zfvW2y+FF5
 3a/q7A882LjihgvNJJESkNjEC5TeBRUBdnK126prc1NZbdwJlUJY3LtJTUjxoZHI0L56
 66YkvxUPxZ1UlHboVOIMNAHhMSyzDk8vlty1j+ElKpyIhY4tsYHcWpxIEyBMNkHSk9d0
 L5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705250; x=1791310050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oGonT6puGsHevu+WwQyWxkFstkTKf/kDVp9AMZCoCAQ=;
 b=rZTd1IPg+ifeHCWZXE1TEjAbveQ3hjBkNxTN5zDJwenKB1kTfuNj1TDV6+Hs40vZdF
 q4isM7yAOV6AFdFYpmQgO/Z6PTMRz1VDpHsRCXprrA8wF8vnvRVwucpOVUmgO11VIKTA
 jOG0VVlkzwxMcWfOKq30NOdeO54Oi/TOq1yJZq7bS8QDr6pNtfssUqFqzIq+uWP3BUoC
 Zqxqbyhow62OftMxuuZUkoUfJ3fahCfbd2gzQ3Flovqxb2XXaI9UsQdZwYtbGTAc6Sa9
 fV4En9640t+5c0xLpvoFx51Gs2EQntyo0zp/Ss/+4ipoOC/oY1XB8GTiJBsx5DMM5g05
 GHqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzf579we0w5j1ZkVmmIDFOzB3x6RsQ+/xMgHIOCvOUOgiS6TdiCm6fINKAfOoZWKZ9gfYKw+FA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mBFq57aMsK91CxIA9lYvs4o779LcGx1AzhnSBlPElbo+aYmEuC
 n3ysMto1pFhRA31JqVdSD27vs4T305GRmgdf0wV/cn7+QMq7bsKSw622RLUHqL1Mm2RFelXaIib
 E1rNpR5DBwARPmen9g+ACT3wqatOQucrsJ5rb+wxzb+/Q6/mHABYqD9vXxXocHTk=
X-Gm-Gg: AYBFou37mXDsAttjAFpt91Fv8mGIbULe4MsDmwqFsg8AMBOVvrRUfwd2m0+GDdYKatC
 9jYhgDkCIAQVMyDTL/sQ2idLSgvwsdWemymH9driesA/Gvi7hJO0BF+0LCQS1uT8EHomZ2CAfti
 s/VFqw2+PC/e5t1mtye8g4dC8iOfe0RjbxSFqYSp4qeOBCadLqh/lhsFFgZZLvHFxj95AajfcuN
 ogH/9hLnm/rapLXvBE4tRJmGHNEp+SZxWwOpXhobGKNKQqKMicZO9sY2meF8Sx3b6duVLVYCNR1
 c1peoDMygh05pylK+UPQqF+vwyrq182pXxQTSKBTOtZAnoX/aWKUGvGFOs7VRC2EqOJaRduc+yP
 ZlFX9Y5JjfxCwOXI/47L8a7L05y1BKHOXVzFtFN3yo2WUyRenwviTVYMzIBmCL8nfSY9+ozA3wm
 briOCJFymDfWg0KhL16iWJFiyuY+TvZdJr+72I7zo4puNI3fkpIY1hzblvZ8YioY2I
X-Received: by 2002:a05:620a:a487:b0:93a:1e5d:9aa3 with SMTP id
 af79cd13be357-93c9f937d1dmr54777085a.6.1790705250255; 
 Tue, 29 Sep 2026 11:07:30 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:30 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 7/9] clk: meson: Support power-of-two dividers
Date: Tue, 29 Sep 2026 14:06:29 -0400
Message-ID: <20260929180721.3440839-8-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

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

