Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E616C98321
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C2CA60BC2;
	Thu, 24 Sep 2026 19:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RsQlmDTgncg4; Thu, 24 Sep 2026 19:43:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2A83C60BAF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279029;
	b=C3UvXVB8IDhFWP+hddsf2359FFST8B5UK1eoFjH+B7TUY+LZvxrnAFqqygVfs0mvexbZ
	 JfNO/vjRG1Rpdede4ppJWVuIXxRy2cS5UvVjG2L599UmONb8J4Cv6Co8mTgqB0j8K/LWH
	 3TvgbmvPW9arUKJRYQzS557HUjFzCfsx/REWG6Mt69mUcStyZxm/yccCOBVRsdQDVnKFZ
	 IJ0xffwAk4NuQ/E3AxJQehJzTu+inKnOfqRhk/fH9r0aWrRU7pIZTzbGToZ2mVw18N45y
	 axzBda7dnfWdG2P8IdXD+bwskEqpR9Gq4vZy9Heny3R4RRJ7R/YpF5VrzqpQgFxRjEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=werTKmGuIGmrrntOpJno2wAY7rUgesdnmxlYoltoW4E=;
	b=ReVmktyrgZP53MaQ6YsF+lpEGgETW/MTzct6toxp6TxLYbJf9GTpdgHOOqzPaD5z3tzl
	 nH7oHV+W3n4HfWLBXUchDnfXvIvjEFbj8FrgYwDJikDSkw53xuhMAwlmoYqSKYTq+Ja2J
	 igJTw8d6NYi6pxY9LWgzUHc7/S46h0AO68/94F/RsDxT0zgFVO88M3zJv9MNgdS0ZDcpu
	 o0dZ3xZfYoZCGv6w39HUHyrwd5BvYtuRFueEG6aOHB+m4boO5TxfS+j/rmCVdE0OwHHmQ
	 Z0+GhMm3YIy0jTTVGen/k+OFdMuPW2HTElLutfo/xeCtUxd7Eu2DuZFCkYvGy4+1dLA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279029;
	bh=werTKmGuIGmrrntOpJno2wAY7rUgesdnmxlYoltoW4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gderXggwLfthxqUMmkkO05XG+Rex4s0NxMuzExRKa1I3xoSt995BKg/8xDV3E0cQ8
	 JIQQROn3Ga8pB9jXsJzM2dyKog+rqWLnuWIBNRGYZIxymt+LeAmojc1q80TEildU12
	 luoGfJND7z5fUhrXD1C8shU/f2B0dh8xCz83ykWU152qAeBCacA37HfvCUUmkqAMGd
	 +zE14Ow2D0C5fBG9alsE2gHxSFbvWhhl95Agwk4mvDSn+TtA8DoJ+o9Z7h0QfF/f9H
	 wpoM4Of3fqDd4UTLTnfuY/zDEj2jaRgOK99NiZCy6Vf6rhd9ZiVSosyIiQiou+bz7d
	 vEHWkllysMcsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A83C60BAF;
	Thu, 24 Sep 2026 19:43:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 026D6332
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC99E4017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aRFIaNdLyvuY for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DF448400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279025;
 b=a0FxbtfPb/SVt1T3+gKxc/wcBzUmMa5I8fHnWNe8ig8Y/wTEXkErjSNZreuoJvuD1xiQ
 OeY9N0sPl0CoBGKZxU+EqPioT0dGu/5tfvFoMWq8WJBHXd9UIPHLpYuO6RMkm8RFOPXdk
 j4NBI2vz2ulDS5W21kM0cu/ekXKUgHpENqCx6FEEaBYCa0P7mp3g8UarJOhFs2Mqr82Yt
 untFHe9TlSaWDmiSVvM+p8tVMzSk2d4MocriTopjfRTo5huDjLUPecqbrBLjGI65RE0KB
 pjiXiNDXpCWs8hvpQcUrvksgkYPE/bD7YQAiQ/p6CcXtk+Qu6CaxQ/6HEutfhqGT87w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279025;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=werTKmGuIGmrrntOpJno2wAY7rUgesdnmxlYoltoW4E=;
 b=Uoq61zU9EtPifJk31U/2mUpAotmUYrD58X1TaCPDqgKcJ5WWmCSGrSZKBq1vvuu8ozm2
 NY/Kz2xi+svH64Ec3K2+JR3uDcNG1xAdhuZVpv99QCoAlQnGhIEYQUJA5wP5joRDuMIsN
 y+GcXf4Pq+R5TkIF4mFLzJUNy3yzXRpBymK7WLZQEsUuROte9dhsyoTen2XPi1D362AkC
 xmJNOD+UaCFGwznBL8Kwd/gYIfe/Mse8rTQfz2KizphVt70Sf8cfRUieTQ1eqDyeC4WOc
 3U16IooCefWYT9ky5rupqvA6n7BKYHSP+QuJR01h4S/4BJpo7xM5UkLG5SMOuEM51cw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BKRcwyDW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BKRcwyDW
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF448400B5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:43 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 46e09a7af769-8177a7fc354so81207a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279022; x=1790883822;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=werTKmGuIGmrrntOpJno2wAY7rUgesdnmxlYoltoW4E=;
 b=BKRcwyDWTizQmKUUBVVuR8/FpjTmNIcn5H8oRTqlJt/K1cFS9e9MauzdeOHKpcCcZX
 Dsu8XEODeiP8gEYkbjj3f+TvT1NLftmM+WSPO9etLBvjypahG4ubT0RzAgz3Tj/CK7Xq
 Erj85aeKZoZUFbGrYaL2+bWxFvXGeHGgGWyEHFW/zYq1jLlExaT8uNuM8f1nFgk5iaHP
 14jsLGvoOar6LZE6Qbts6F9mJaw8lWzuTX7v59PPriJSKNWPmPctlXwZ6V7n9e5+jUt5
 HNeSyt9Lo3fU/Pgu/xPxu25S/OKXyUBbWUMBfSJmktM/XQ5AHnaVZAhFPmrV1KH2sJHa
 ObCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279022; x=1790883822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=werTKmGuIGmrrntOpJno2wAY7rUgesdnmxlYoltoW4E=;
 b=PjBml9azz+9hNzcfS+PMo/4yYpondSJ5bnHLvxsmxVqGzu4ragqwLs/d2ligHSW9L8
 gB+cdquEyNNBAEDEQayLppB8khuCZs0ky30Y30L1C9QLrDztaH44hB542UhbrQZwojax
 bdU12ARU5zmjKB16yxABK472BsUjDWtI+t+UUvmhZI6ga3JcNEeiowYKO1YfbkEWuPZE
 2H0cbAwMIIXIzsWQg/3IP/cX0vOXGwd/ZnKje8Lo5qryNnqBQE0F0U5ei6CLG7JMiSwC
 3ps0CgjoTsvWkryO+Yr6oUPEkO33vCAQAAjO5gHzWCM1AcjIcr2HJ/2F8WeF5zesViN3
 V9bA==
X-Gm-Message-State: AFuF++kceEG7XJxisdjS93WROxwV3Lr3hCfl/UJPol2DUtaTr+jkJ5SF
 U6nMBMs2agWkkwm7jZfNHyszCEMXaR22jt6YbvWi0e0jxxZQV/UaMMub10duUfj1bwU=
X-Gm-Gg: AYBFou1y3c3PIcSZcoYdQhkEUHiB8qVsvlXkDYU1SqMA2P1e1FHPD0NV8VXv++G57s2
 kefnF5xb/E7CpJFgI2cHkVtG+zXdu/mArHUWeSVNql/evXF7cjlP/UcoIWi1lUdpBGyXY3R4BF8
 GHIOevOJexa7S+uMw7Dsl7rkMRS0f80LTPQv3zKzmmeBjiuQgUe4HreIPQOBkNINhhK5vzbDb22
 mM31mezwHQY7+b3LxFKhgQUOBkf76nohXccpihLDg75hxUeWwfCul7sW3GqbIWX2sYi/Y2Vr/2Y
 9JshxatjwSnufZvQp9ergrMdeuUjHDTOvTwTpyXbnPDa1EMma8DNuFLFK4YhWMx14Y9MeJfZftX
 9cv1+2fmFi7DxoM6etdeZ/Hdwb45uS0aswClJs5u8OmJMe/LlaVhEd0B2FCx5Eh1FjPgQjkAzop
 JZ16AgyWovy6OKrZ7AAzoYSqqShIGb+YHJGjqNNRsQ8qBPsetp4d6Riif7V9PvkkLwmFLHHVaZf
 kg=
X-Received: by 2002:a05:6830:6d50:b0:7eb:9464:ac2e with SMTP id
 46e09a7af769-8178118b9a1mr3873068a34.11.1790279022399; 
 Thu, 24 Sep 2026 12:43:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:39 -0500
Subject: [PATCH 01/15] clk: mediatek: add fclks_offs to struct mtk_clk_tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-1-1c3b5d8744ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3641; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=WFYi/cV+m+csRrgzYZnW5ykcaJrFcm0IrOENFZYt+dc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX0Dwi79Qm2zPnCKewRtpjqjvS5EiOp87/8gx
 P+DFYmb0mWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9AxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvHoH/2112IOYQUXEOKMQY8grUody3Mm7yAoe+qZyhBl
 bCsKYfFetHCwbqQ1TNdO93ZnlTTiLOWdDGsZn73yZLpM7NDCAfveSrgIyd+feYQP60ZJBaElbl8
 x3R0wS5JI1Qi+b945+A4rNfUCTSsohOQ6uVYuHOksXz9Au6XVWbBHN3YhGhDKCG5SbQky9tEj8V
 9rahUWha43RFTpL8r9/w/BknX1Ncbeh0CcPEzajiuhxSApN4DmAnMWeFLOcGQbpsSPIJYFDcaFf
 sSrvoRRh7EZs/EORaMgUXNw38BV+LYjwJ6Y/D0ELrlhCOOkes9c3W9T4dRqrmN9OVw9kylPN9SA
 aKs0=
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

Add a fclks_offs field so that fixed clock IDs occupy a declared range,
like the fixed factors, muxes and gates already do, and document how
the ID ranges of a tree are laid out.

mtk_clk_id_is_fclk() and mtk_clk_id_is_pll() both treat any ID below
their table size as theirs, so a tree defining both PLLs and fixed
clocks would be ambiguous. Today only the choice of clk_ops tells them
apart. Giving fixed clocks an offset removes that dependency, which is
needed to share one set of clk_ops between all clock trees.

No tree defines fixed clocks at a non-zero ID, so the new field is 0
everywhere and this is no functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 11 ++++++-----
 drivers/clk/mediatek/clk-mtk.h |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 70cc7624a14..78ce206197d 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -155,7 +155,8 @@ static bool mtk_clk_id_is_pll(const struct mtk_clk_tree *tree, int mapped_id)
 
 static bool mtk_clk_id_is_fclk(const struct mtk_clk_tree *tree, int mapped_id)
 {
-	return tree->fclks && mapped_id < tree->num_fclks;
+	return tree->fclks && mapped_id >= tree->fclks_offs &&
+	       mapped_id < tree->fclks_offs + tree->num_fclks;
 }
 
 static bool mtk_clk_id_is_fdiv(const struct mtk_clk_tree *tree, int mapped_id)
@@ -758,7 +759,7 @@ static ulong mtk_topckgen_get_rate(struct clk *clk)
 	const struct mtk_clk_tree *tree = priv->tree;
 
 	if (mtk_clk_id_is_fclk(tree, clk->id))
-		return tree->fclks[clk->id].rate;
+		return tree->fclks[clk->id - tree->fclks_offs].rate;
 
 	if (mtk_clk_id_is_fdiv(tree, clk->id))
 		return mtk_topckgen_get_factor_rate(clk, clk->id - tree->fdivs_offs);
@@ -895,8 +896,8 @@ static void mtk_topckgen_dump(struct udevice *dev)
 		const struct mtk_fixed_clk *fclk = &tree->fclks[i];
 
 		printf("[FCLK%u] DT: %u", i, fclk->id);
-		mtk_clk_print_mapped_id(fclk->id, i, tree->id_offs_map);
-		mtk_clk_print_rate(dev, i);
+		mtk_clk_print_mapped_id(fclk->id, i + tree->fclks_offs, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i + tree->fclks_offs);
 		mtk_clk_print_single_parent(fclk->parent, fclk->flags);
 		printf("\n");
 	}
@@ -999,7 +1000,7 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 	ulong rate;
 
 	if (mtk_clk_id_is_fclk(priv->tree, clk->id)) {
-		rate = priv->tree->fclks[clk->id].rate;
+		rate = priv->tree->fclks[clk->id - priv->tree->fclks_offs].rate;
 	} else if (mtk_clk_id_is_fdiv(priv->tree, clk->id)) {
 		rate = mtk_infrasys_get_factor_rate(clk, clk->id -
 						    priv->tree->fdivs_offs);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index e3a7ff75734..1c840d9f6d3 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -254,9 +254,14 @@ struct mtk_clk_tree {
 	 * is the index in the various arrays in this struct. The .id and
 	 * .parent fields in the various mtk_* structs will contain the
 	 * unmapped IDs as defined in the upstream Linux kernel <soc>-clk.h.
+	 *
+	 * PLL IDs always start at 0. The other clock types start at their
+	 * *_offs field, so fixed clocks occupy [fclks_offs, fclks_offs +
+	 * num_fclks) and so on. The ranges of a tree must not overlap.
 	 */
 	const int *id_offs_map; /* optional, maps clk.h ID to array index */
 	const int id_offs_map_size;
+	const int fclks_offs;
 	const int fdivs_offs;
 	const int muxes_offs;
 	const int gates_offs;

-- 
2.43.0

