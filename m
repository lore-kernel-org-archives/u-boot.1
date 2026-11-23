Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dV8JdjXO;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jAotokbw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A5BA80E2D;
	Mon, 23 Nov 2026 10:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l9Ex8BBDSTUW; Mon, 23 Nov 2026 10:22:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 324D780E1C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429376;
	b=biJ7RR59q5DjwitAK4xXPlNuZm7vZnSclcCazFZmMvBTeZYoElvbsCIBZ25PUp8DDtVR
	 sn4p26l7PPQqf9qCegw7mtN2cVRMN8+a5PfCVNb4rTZIhlBZdXlyG2QSdj9Luvaw9xuue
	 QQaMw0VWCxhuyFLqLmbWFMOVhgk5kXjC4+o7vlH3PAYFTTO2NQ/v2zg5lkt8nDp0E/SeK
	 L5Qt4DbPEPNv+s99Ng3EGwcG61XWh9tgPGxq6suBRk4L7kah+iABuN1S1eerJehv9ckrK
	 J2JluEGUiq+t0ATaMk8mnYcmUv5AFKn/9e5riXksMHeetnxqaXSbZuRtFHIVQpxKouw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MlIhwQGaBgfZE7s3ZRrqT0SJOM4uI502FmyPsqPEvsg=;
	b=eZh75cX23yY/lonUfPoI27cymqM774xHWFcpxYGQvHp2b8pL25HIn3z2Tcj6bBcb5z0T
	 9tn+ecfA0e42eq1RxC4YYV7K1Y84Hu3ou+DyCnramtHOfGkjMErvFAtoashMcu9BvEE4S
	 467TJsLYFxfpWn7UFgRTLBm2MbBHV7JAdroL60ms8tBXS5WqzZunmJb/EA3n+MZMndXeI
	 M9PELgoENDT8EzzD8qeVyx22eq5DoiWn4amafHmPCaYdb5NbMH5uHuoo2SrmbsZrWTwiw
	 SAtLgtfKbyh4SEKlbJkzgtsqXGRgHJZU6adRPnxcXKLouEEdxiMzxlRQrPKeZ12Eftg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429376;
	bh=MlIhwQGaBgfZE7s3ZRrqT0SJOM4uI502FmyPsqPEvsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dV8JdjXOo42WQwUQtovwgMtlZiK/cMPezhX8JnkSCjqVEpkVPaRHkiBX9lO6Qn1VO
	 7iMDBK0IdEh1x84B0DuH/Hh+Zeu8ifE9Xydy/QPQfNzJMU5SM/QuPIZHkvg0BpD7f4
	 V2FxpYEbdmfrWws8BAFLC2s7hjPL7xgFqUuM1IS4CGfYHutRFIIZfIrh30O2zr3t/G
	 5R4cnVAb1GPR8q6SKt5A7FNxxpvB0C6acZMHOknniooWbsjlkYChcTwGYStVq5FGBq
	 AKMK0/CXNm0ao5HLfpTQHR0K8bx4H3qnVFHMU5iD3EGdvmL2TwOogbvdzh6ljIQHMs
	 bHHpXAGzjp+PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 324D780E1C;
	Mon, 23 Nov 2026 10:22:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC3B422B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92C0140098
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0s9s91GiRbe for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:22:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 97E46401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jAotokbw
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97E46401EC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:47 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so23420765e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795429365; x=1796034165;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MlIhwQGaBgfZE7s3ZRrqT0SJOM4uI502FmyPsqPEvsg=;
 b=jAotokbwVRulKULzWbnwuiI6yc3Xn0lFlqkhWX95RbuQlBYcwW09x0Hn5AeucSaCNb
 idEKcKKew+gQpjL4RNzGWnf+Gn7vTncnze9a1TG4zl88koK4VHzv/FpWNcCm3JsA7O/R
 S/py7QPCjTAFDqyjd7shG4aJ3uvK7lxTPZ/J+fyJGrdKWFZhgBy+Ce05P3MFe8VJ5Sw1
 PLU7UBNkUQ9WoqxPZMuPKuzse0FW4JIL+RlYmiOInZASC3QuCg+lHk3omBv3b9EMyoKL
 gxMrZpIFBYP8oT4GpZ6tDoIljilvkeZYF+4oJou1BwudkSafzNCg0R5i+1V015/MJ7D4
 koPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429365; x=1796034165;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MlIhwQGaBgfZE7s3ZRrqT0SJOM4uI502FmyPsqPEvsg=;
 b=r+Ijm0WC8/H64hKUQgclCArfwA0LCwN3Cjq4T0r12z7HOhuP3Rt6tz68VSIYbysmUr
 5DwONQ2ipzC2H7eV9LuHC2VM34AUHifcRDPSa0nL1sFo95yqOK7Hnf6MzpPWoLQDs0I7
 Bx3uliP+JUGkVF5BefGoYAYyJ8vn72nGmVS1Hme1iOzLsWMRjBPD/ur486emCbraa00t
 SO6sJBjkOBaMhGNcYs/btKuaUpM4qmhGiBeA2rt3FraDTs6zFZbx24WMTmn7UnJ3B58g
 AhNm9soi+6aAnXJpQnf90fHcWmdE4KutVGaWfrfNxBceBbYq70XAKmWSr2iZ1318x+vh
 0hvw==
X-Forwarded-Encrypted: i=1;
 AL+hErFIFICp4tTb2gd9cxN9HFzkKOVQgdylzvEhGbxV5vvRS8nQYKJP/Pg+eC+gsfjOesA99xVCH4M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z90DTH1nywKq5v/Qz4cJQ2Qclw4gp5ojqNRJ64TJ2plw04Qx12R
 8XidshZOO9f87gIpcFdqKlhQ/2DC9x1TYqWZbCNpCMfeg62NUPw0Sgqye2uKC+1ovek=
X-Gm-Gg: AZFdTZfNrvgQA2zeQRNuGa7yhECU38bEgp1ARBVSkYMEqZa2qyz/hoRlhsozvTSINcY
 lGyM40dASUSjJoMFtQLRoHr7t0S6hdhVY0y5Rv7mjt6/3Q+UIEOhn9NPKsTxvbFT15YP+wpX1SB
 1Z0UsV28A3laQn4ydGTlaO1o8TMmIiv/TmPs6Ln8AI8hp8ac0AB29xvwiDTtYMzw0GC12HMOZYB
 nyEpLcFyM1CYEUlpI9znrWOuOheW9TLoyVTf0MRpjsBT07kMJVyynf0ju6kgzY40eq7J4xkjf2V
 ZDLi7rYrqlLdcz5t9ioVV4amYmDIzJp9VK0S4RqEfgortkUKdfAuWBNULNBRZ8sKENhiAEANb/s
 z/WoQ7noxTk2PUStDtypcJRZrGjADvwuLT2At11ZM+BHrySMj0QDEM404clFhoGbSy9l2SJqaFm
 n6jxo2bhLhuIAJUUIfQJpd7kCIXq1D7oPm2BwfwC2iwoJaRCIjVvCfXQdFtjEfTJTZaC1/GaFjr
 muhjVPopFA5xCrzEe5RAm/74p80PV9ntJH/B/Yk1ZVtbtB/Yls8aNXKoA6rL0qo6FGfBGFfacKU
 3U/OEBw1BRIVGFDHpdowbdo+gYqDnpe+pLd76mZx8TO8wAJwDk6/UtKAD+5EkUh7FPBqeal0+zp
 B4ge5C5sudXIj34wYvHUWgYdFwdJjbkN6SkVuXydvo9GH8Q==
X-Received: by 2002:a05:600c:1548:b0:4bb:7347:d5df with SMTP id
 5b1f17b1804b1-4bb88814405mr242544785e9.13.1795429365454; 
 Mon, 23 Nov 2026 02:22:45 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm400342655e9.11.2026.11.23.02.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:22:45 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 11:22:20 +0100
Subject: [PATCH v2 5/8] clk: mediatek: mt8189: index I2C gates by
 wrapper-local ID
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-mtk-g720-i2c-v2-5-7d3f843db7ef@baylibre.com>
References: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
In-Reply-To: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
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

Give each wrapper its own gate table, selected by its DT compatible,
so that each local ID indexes the right gate. Make the register offsets
relative to the gate window described by the binding.

Fixes: 4cce6acace72 ("clk: mediatek: add clock driver for MT8189")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index e29915d4c0..f333b12ba4 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1529,23 +1529,32 @@ static const struct mtk_gate perao_clks[] = {
 };
 
 static const struct mtk_gate_regs imp_cg_regs = {
-	.set_ofs = 0xE08,
-	.clr_ofs = 0xE04,
-	.sta_ofs = 0xE00,
+	.set_ofs = 0x8,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
 };
 
 #define GATE_IMP(_id, _parent, _shift) \
 	GATE_FLAGS(_id, _parent, &imp_cg_regs, _shift, \
 		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
 
-static const struct mtk_gate imp_clks[] = {
+static const struct mtk_gate impe_clks[] = {
 	GATE_IMP(CLK_IMPE_I2C0, CLK_TOP_I2C_SEL, 0),
 	GATE_IMP(CLK_IMPE_I2C1, CLK_TOP_I2C_SEL, 1),
+};
+
+static const struct mtk_gate impws_clks[] = {
 	GATE_IMP(CLK_IMPWS_I2C2, CLK_TOP_I2C_SEL, 0),
+};
+
+static const struct mtk_gate imps_clks[] = {
 	GATE_IMP(CLK_IMPS_I2C3, CLK_TOP_I2C_SEL, 0),
 	GATE_IMP(CLK_IMPS_I2C4, CLK_TOP_I2C_SEL, 1),
 	GATE_IMP(CLK_IMPS_I2C5, CLK_TOP_I2C_SEL, 2),
 	GATE_IMP(CLK_IMPS_I2C6, CLK_TOP_I2C_SEL, 3),
+};
+
+static const struct mtk_gate impen_clks[] = {
 	GATE_IMP(CLK_IMPEN_I2C7, CLK_TOP_I2C_SEL, 0),
 	GATE_IMP(CLK_IMPEN_I2C8, CLK_TOP_I2C_SEL, 1),
 };
@@ -1971,7 +1980,10 @@ static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
 };
 
 MTK_GATE_CLK_TREE(ext_clock_rates, perao_clks_tree, perao_clks);
-MTK_GATE_CLK_TREE(ext_clock_rates, imp_clks_tree, imp_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, impe_clks_tree, impe_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, impws_clks_tree, impws_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, imps_clks_tree, imps_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, impen_clks_tree, impen_clks);
 MTK_GATE_CLK_TREE(ext_clock_rates, mm_clks_tree, mm_clks);
 MTK_GATE_CLK_TREE(ext_clock_rates, mminfra_config_clks_tree, mminfra_config_clks);
 MTK_GATE_CLK_TREE(ext_clock_rates, ufs_config_ao_clks_tree, ufs_config_ao_clks);
@@ -1996,8 +2008,20 @@ static const struct udevice_id mt8189_clk_compat[] = {
 		.data = (ulong)&perao_clks_tree,
 	},
 	{
-		.compatible = "mediatek,mt8189-iic-wrap",
-		.data = (ulong)&imp_clks_tree,
+		.compatible = "mediatek,mt8189-iic-wrap-e",
+		.data = (ulong)&impe_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-iic-wrap-ws",
+		.data = (ulong)&impws_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-iic-wrap-s",
+		.data = (ulong)&imps_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-iic-wrap-en",
+		.data = (ulong)&impen_clks_tree,
 	},
 	{
 		.compatible = "mediatek,mt8189-mmsys",

-- 
2.56.1

