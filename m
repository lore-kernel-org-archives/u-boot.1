Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9181606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J8gpbLxQ;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aghF30fo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1A40409B0;
	Wed, 18 Nov 2026 20:30:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0yQpIc3X2W6; Wed, 18 Nov 2026 20:30:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E02A54098B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795033818;
	b=kHwXj/VnLepjrTlgI4tBIdD48Z8VaFYaKzG4Z0nR7kBbXkUla5oUl7vLofunxAkTQ6mQ
	 m/2iZU0hGwdBsvXUgWXV/4jieIBpkk1Eu23SSqpLd4O9xG+K4MlI1XSvB7iomfvCW60HL
	 UQ2wcgYdlMOe20EsuOznHqCWe0DE1VHE7yofgwdf6EyDUXjvIpSfMX4acqVuulXlpg60c
	 6S0HFSlnt9RKdQiI0Oa2cId3pJD+UHFBq+FF6l1gBst18ObWcD9bZ1ycajNydiYTl2HMm
	 iIba3QgUWqqKZTYI0l8hXwp3MJVjm/Pz3o7iUZT25+ffG+Wzwlaz3y6Ek6zER16OClQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795033818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=raETXzENWO/fPrdcKRqOj2ZEJSC/fM6yeT6/oXYX5Bc=;
	b=kN9+vWBKzdZLcjL2G5Ly0ijF+Kh/DwSZGwnFiuml6S8Wviw6CNujnla91Kh501givgYJ
	 EPWYOOGhL4rLnZbpjv7AD6jjlCmpIwxCnIQDkxovjasUMHjLKKQjuUoEd0a2IfvAh6S3D
	 yWVvzvNFK1BT0yNXLyWV2g+RwXxKsaRuWQFMisPUBGGxXMxhStfsn64ConxNSNTffG4mf
	 FlMVGx9Ynsswt2X1/OwQ13hzZihKXJ+2bFl8t0mkSHrwhpaNXbQYkx7iwGr7U6YONRmNx
	 yigay1luChFiYeRqzsuCTlqJfRasmFLoMnveW1s8cxMqJRnWYj9jKNMqYcjLah2xVYg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aghF30fo;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795033818;
	bh=raETXzENWO/fPrdcKRqOj2ZEJSC/fM6yeT6/oXYX5Bc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J8gpbLxQQCl5ET6kmSEHWPuB5GPsZ5OZJbfUlD29tqT5E6x6QcLCEV3nFUl+vYff5
	 1XtV9hijaoSWqk5ZKgl2n3lQ+9YKZZSmJf8xfLLuXRSy1J4dCm8Vz6wXLMEEqzhg+y
	 VM9HgA2Adqqqrt4gAxEofP7Hhw8GpOF3hi82ioMA130L54bDtny4PXYZtGc1aBDkwh
	 2DDY+ZYFfNbIde5CCUVLTbp8h6sM2AMvEwRbbJMcaaVzFYYBEr4pePe0dwGR+EzQT1
	 vq01RxVICTPPyqWsMMSyu4yqwTHTSpX3Y2TpAL2hdmQr9SgVTBJnSjrmwTPUDp29iz
	 zyuiVs3j2iiSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E02A54098B;
	Wed, 18 Nov 2026 20:30:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 50F1A798
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34B5740667
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8kBmpcoVny2y for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 20:30:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E280406B7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aghF30fo
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E280406B7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:13 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso15652305e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795033812; x=1795638612;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=raETXzENWO/fPrdcKRqOj2ZEJSC/fM6yeT6/oXYX5Bc=;
 b=aghF30fovVW3+7s4CMWu4ziWcRDTKLg5HV2YS8RNLhK0Ihsr2BXWQeowq9B828kY2J
 1tMvFPXyaQm2dK/uknJCA3fgo6EnNqfzjdNm5Kc16Y2V8cNuFKIGjfJV/0fSxv4YPV0v
 jXPLZ1F9kTB+WrcW7P9GVAvGqFOo2F65F6nQ1ZwvNbDXAqAXi8ga7rkgFURj8hNt5gvC
 GAWxCHOLR10ZbN2pZ5DM7I7tW5AFeG0K5oA35uGohedQgo5mpJ1vmaPUEKYvcn5o4SFv
 T2jbYQ79chyMDIwyQLj/N49F+AKmNOqG9uiLc0NVV8/5gjORRZFEBdyVswauPj9654u0
 Skwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033812; x=1795638612;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=raETXzENWO/fPrdcKRqOj2ZEJSC/fM6yeT6/oXYX5Bc=;
 b=JdcjzXzu4AFrm63iVIMakn8WJaV0IEpuKODK9SyeBu8tMnrUrU/lGTbIZIWrpdpszr
 lSporwmP0yfcNwhKinCmBWVftw1nyCJFhlHnD4HT1d7w21wEuxH06GOeUF0X7RZ3GuGh
 GGvureeYxbMbAxXLywhMaghsAgnQJx4LdnzGV9VTOziniFB1mvZl11I9Q2SQVfkx0rkD
 dtqiDVlBNgXLvHgtt8SDFxhEF/E6QphTY5O3Ivqj2IVglwhLjeNFz97YtU35LqgRrmR6
 9uPHFV05GTMG5eZtGcy/f1TfFyqaS5PgIv/IoeVBLenSuXEI0rA50xvfv0KcZ4nOMSWb
 6+1g==
X-Forwarded-Encrypted: i=1;
 AL+hErEzjyCSkCvyugJUXS9R9gO9kNR9qwKvYE9ZQ5oAxTo2Rt5K9i7TrX6LV1G97kHhAUSNmZh1ZsQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8KLVu6J5iUBq1RSeNcnCgWytNtV4FUr7rTaYhLcxUpLGnud2dA
 x7mFCK269sDqE03/9Z/Am3cp0OmBx70Kpf2yhEWeWKBsBau9iTGTzStAXuRwUVSjXTU=
X-Gm-Gg: AYBFou2311ngC13qEy0qHBtk611DxY/28NUe4kgrHQVz+0uqSWV0fTOnElhVsQyhrZw
 hxSD3Ej+qbMwQMSuyu9D9M0iT0Zb0JNPdzgMjo+541gJuUFOGhtNvKQknTrj0J0w8yaC3vg7yML
 bsf9xwwfUlSb4qNlBBebA97E9BQwu7WtuJqHVVpTPQktpczZqbOaucVJshAACsK3bbr1PejXnC+
 MMEQmvBrMVswsRvwfA5DSGkomMzOeGzgnwDvUSHV260pDIb0sgWHHaFLu1M/OTE2GwXFGnsn74C
 fadnNOj4Giazvs4MzpJ6oUJQdN8JabUIGwtf0ZWJ4TLBffPJD26FkbSuVoSzMOQx8ygRcZfqevo
 0BVDK/qvDpvJmZteXrgXtlK2lMdvRlqXoYFrnumNUOI1dsXu6jCJnfDj8OPavaFFzjCQgf/VX3B
 fEDK/4Bbl9y3oUahymQSNpw4EIKYrrxtELkNTOZ+v18gn1E6BhN2/AzsGQuYur5iWbeMf1s5m2Q
 4PrJaG+7FcVmeL2Qvahwbt7hmKkNT8P0BtY5S2W5mVLopywStjEqm1mMrACNtAw1nqgGevHbUK6
 YWdLpwc0YoDhISuNDTrDty+QuQtQUO6svVj9nblId7bUqwR4OzIVhMNRVeu+uBJ7JJ5b0GSIZVp
 sHvHS0QjCgYMXoVCl739fGHe9m8O0XnVExOgjhA0=
X-Received: by 2002:a05:600c:1553:b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4bb7da12847mr67657685e9.9.1795033812096; 
 Wed, 18 Nov 2026 12:30:12 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8326c332sm13066705e9.15.2026.11.18.12.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:30:11 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 18 Nov 2026 21:29:50 +0100
Subject: [PATCH 4/7] clk: mediatek: mt8189: index I2C gates by wrapper-local ID
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ccaione-upstream-mtk-g720-i2c-v1-4-916dd6cc8d1a@baylibre.com>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Each wrapper numbers its gates from zero. GATE_IMP() sets .id but
leaves the array index implicit. With all four wrappers in one array,
a request for I2C5 (south ID 2) reads entry 2 and enables I2C3 instead.

Use one entry per local ID, using that ID as the index and gate bit.

Fixes: 4cce6acace72 ("clk: mediatek: add clock driver for MT8189")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index e29915d4c0..46a29397b6 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1534,20 +1534,16 @@ static const struct mtk_gate_regs imp_cg_regs = {
 	.sta_ofs = 0xE00,
 };
 
-#define GATE_IMP(_id, _parent, _shift) \
-	GATE_FLAGS(_id, _parent, &imp_cg_regs, _shift, \
-		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+/* All I2C wrappers use their local clock ID as the gate bit. */
+#define GATE_IMP_I2C(_id) \
+	[_id] = GATE_FLAGS(_id, CLK_TOP_I2C_SEL, &imp_cg_regs, _id, \
+			   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
 
 static const struct mtk_gate imp_clks[] = {
-	GATE_IMP(CLK_IMPE_I2C0, CLK_TOP_I2C_SEL, 0),
-	GATE_IMP(CLK_IMPE_I2C1, CLK_TOP_I2C_SEL, 1),
-	GATE_IMP(CLK_IMPWS_I2C2, CLK_TOP_I2C_SEL, 0),
-	GATE_IMP(CLK_IMPS_I2C3, CLK_TOP_I2C_SEL, 0),
-	GATE_IMP(CLK_IMPS_I2C4, CLK_TOP_I2C_SEL, 1),
-	GATE_IMP(CLK_IMPS_I2C5, CLK_TOP_I2C_SEL, 2),
-	GATE_IMP(CLK_IMPS_I2C6, CLK_TOP_I2C_SEL, 3),
-	GATE_IMP(CLK_IMPEN_I2C7, CLK_TOP_I2C_SEL, 0),
-	GATE_IMP(CLK_IMPEN_I2C8, CLK_TOP_I2C_SEL, 1),
+	GATE_IMP_I2C(0),
+	GATE_IMP_I2C(1),
+	GATE_IMP_I2C(2),
+	GATE_IMP_I2C(3),
 };
 
 static const struct mtk_gate_regs mm0_cg_regs = {

-- 
2.56.1

