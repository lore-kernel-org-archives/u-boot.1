Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408B9C5AC82
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6E878130B;
	Fri,  7 Aug 2026 16:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jx0uE4oXHxCa; Fri,  7 Aug 2026 16:02:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C4378133E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786118544;
	bh=5jDgrI5qPhQqnPLGW/rWq2trrQ+tmIXRU6U2CKq8arA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rOjHgoPckYTFWF37MLu8Fk7N5QO33zLEHaTsbhJPn36ujE48QOFaYohUyvZ/mmJLc
	 KG/kejjWqF92+jWkBSykJODCSU73MYJYNrizRzgChVhBvtdrGlJAP9MBzhWh6y0yxH
	 2PAjCwulgFk4u0Z24dBzz5GCpkJi016OOdt+O7DKE8wCyeVU4EPxb8P/l/QXoQ2hly
	 ePmHekhq0PkxUTaYKosrqn9r6s5TcFEQAVxVxK8XQFhf9JH5hmgwwxpPnnEuUM9EBE
	 qP4MCuj7VEafwd5qI7j5l/RKKnFsNOkvWNgBuLOCNBVI//DhJTf7KzUKnmLsl0nTwj
	 PArwkn52kZ9Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C4378133E;
	Fri,  7 Aug 2026 16:02:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1823B218
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A35F40A3B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EfY6yUp_s5D6 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:02:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4842040A2D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4842040A2D
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4842040A2D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:21 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6b01abe5cdbso1060195eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118540; x=1786723340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5jDgrI5qPhQqnPLGW/rWq2trrQ+tmIXRU6U2CKq8arA=;
 b=douCTebCe47UDng/hlX4NTULUj1WJ0PdjHwVWAKRKTjhuQTL/os4bWUP7WaZUpXSOH
 +w8K380wm8IwhKf42xi37PEQ3Z5LmNWC3wpxhdf6ylhRUAESfBOev38/e8C21qhPIAnl
 e5tW8kcTnmuIHt+C16SEt/fbJSM3IeDC+71X1LqpgU9UvktQXt9D9q4zF1u7wa6/5PL6
 AZnTu6OsQ9z/4ooB+4m8mbHNiJvvw7F6mKTuvqsMg8/hbYPdJU7AAPku0sLBlsRtzj1p
 lYdnJc1ACSZtYKRXNjRWgHlDwGq+VRNz/AXQ1vz2q9b+8nq3fceEPx0gmaZWNowJzaqs
 U8Nw==
X-Gm-Message-State: AOJu0YyolJ5MREf3h7fLENQjdr2zA9fWbHbCNtNFnGTSmCf+nvyBbTql
 8PAjvczB7w4qGu1AYKmi7v2e+zER/UFi8TsKryDwaeFnZsdW0tK+VptyN13NUN18l5M=
X-Gm-Gg: AR+sD11fezGmB42RQJghPy3iFGX6P4a6G5csHMlZWD0kiuORbVTB3Y9jm8olNo6rwui
 g56j/21kilf/71JZe73+mw86fgRkxqu11taZF1flAN4wZLqSjFzH7intcKALPwUNI8KxamrhYC2
 sPKWL+uRRrpsM1NFm+pcukBGfg5j3j2uwu+A7RzjVaZxs9Ber7j72YB/iel0xIsqbbUMrVx5JM7
 RLUAXHvHBKmbPYrDuK/+437cCXQB3ws2C7YuYMUDVgbtp7YVUVjq/xJt2C+98UPoiWwvwzl6bpA
 97/H6ZngyRRwplOrOIWRX8mUQ0KpjWhwFBnOfge2KLwXctQy5pp+UjitwYdecoe1Jcxv0aiVGO8
 uw9RAiVe6FRKcYulwJzk0v0VJoLJ9mt25xV+By3PFPxJ+WR5l+7gvS7PcERbuVyz2atVUFInO02
 Sx5o7LI33I8CNeovbuGzRCYrG3URz0E0jz+D2gC4qbqm+v4tdUTmK/RL7v0zSNP6CZ
X-Received: by 2002:a05:6820:1c8a:b0:6ae:5250:dd1c with SMTP id
 006d021491bc7-6b035366c4bmr2126658eaf.29.1786118539993; 
 Fri, 07 Aug 2026 09:02:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2679993eaf.5.2026.08.07.09.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:02:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 11:01:29 -0500
Subject: [PATCH v2 2/5] power: pmic: mtk-pwrap: fix clock names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-pmic-mt6366-v2-2-d9fdef581fb1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Q4z3Qc+/tBxzMApPd12PCeSBH197GF48PQcr3D/bdMc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgFuqaehoYJpIyC5FXJw+KZSc0KY9FFrq0Ads
 WnbIv7vF+aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYBbhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7cAH/24KqB2E92LhqfJty5xoUstpRmV0wp0Xj2lZwcH
 JGaemg7Ezb+6r6FwaSDcldHL7VMpJ5kiWmSXBJDUPuRsO0i76wI8fiMHteNz4BIhbwua0EAnkVT
 z/6R1q2Zl0Niw/+TYH2IkWmk2Mngs1T9h87Syq1UFBVUx4Rev/yd0Xw8nZOxIxTAlSvj+Mm/j01
 1VhqKNT3wKmJ0ajx9NCskR7e/Wdt0jEk04k0JO23GsoUlfbdBbeWxCAbtQT3cDnSzsxqgIA27Wf
 RMxB8QCy4FSRgqii8yu8gCMAPex+FwDryBb8CcVdztOSi3pmUf/1Fgprps1uRGVAiZB1wiV4ttO
 U9lo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786118540; x=1786723340;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5jDgrI5qPhQqnPLGW/rWq2trrQ+tmIXRU6U2CKq8arA=;
 b=Mr0H20BGPmkWe8u1UIghzQTmQZgQqtz4q5RFGy4DOWb4RQgM9hOqMznVZvVaP/6h7l
 i8Xb2wHmaD/BV56GDwDxpGJvhF7TsWNC/klHXsrZAYrPZFhp46xOnmJe0FpZ5noD9jOS
 D6hcwsFcgsMxJbP2yoq73QIcDRf972HTj8iey7fQLwe5LEKQDitDEE2b/8eBaXbTsp4X
 9vp4TtmojkM4bDlzc8UuqrJk9rG6XYC+6Tl3BepKfUkqqPHxymzbgsESK3IH69YyJh1X
 sXFSz4VrhfshlgRJrGsF8Tx8Sv5lPBTfVHb9I0r7O656jP+BIm7vDOLC3tpmYsZt8CEP
 nwCQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Mr0H20BG
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

Change clock names to match the upstream devicetree bindings. There
are no known devicetrees using these wrong names.

Fixes: 219c05f3f68e ("power: pmic: mtk-pwrap: add MediaTek PMIC Wrapper driver")
Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 47347785519..f648a784019 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -720,8 +720,8 @@ static int mtk_pwrap_probe(struct udevice *dev)
 	if (IS_ERR(wrp->clk_wrap))
 		return PTR_ERR(wrp->clk_wrap);
 
-	wrp->clk_wrap_sys = devm_clk_get_optional(dev, "wrap_sys");
-	wrp->clk_wrap_tmr = devm_clk_get_optional(dev, "wrap_tmr");
+	wrp->clk_wrap_sys = devm_clk_get_optional(dev, "sys");
+	wrp->clk_wrap_tmr = devm_clk_get_optional(dev, "tmr");
 
 	ret = clk_enable(wrp->clk_spi);
 	if (ret)

-- 
2.43.0

