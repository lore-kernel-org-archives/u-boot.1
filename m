Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A42DEEC2AB
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 23:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1478883BC9;
	Tue, 24 Feb 2026 00:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cLrA57Lh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 363C083E62; Tue, 24 Feb 2026 00:22:57 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D1483D3D
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 00:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4c4cacf78so1774419a34.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771888973; x=1772493773;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YIldhoCp3brkfUy95LqFvPX46zXh6LJt2PCTNw8hPWA=;
 b=cLrA57LhyrNeLn5ya4jKpxVGqjHxSRgjWfzbx69+ar1lxYBvUypfth9P85lnDvQeJj
 7GLScl33UXFLXV+8svESgkm/JFuOEgfOilqFzcRq4LV3wjJLgtP8Irg+x1JyJcZz3tGg
 secD0zsKpAlzLqXoaXlVEoHZOfXfcODF5pvFST2fnV/nVOP1BedaKQ7tzJuSTpcDYOi8
 kJFwexNYBTL26dkGszIfqzFzd0NefsdaDa3Y3XjxggC9cOk/UTMZzhe74HGKjXeMx084
 fUKStkvG2rDpIcq0hVdfVyIUybj/lhkBWFau0tCpzH0UcZXJPR0j6IKv5Win3NHTYKEd
 w2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771888973; x=1772493773;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YIldhoCp3brkfUy95LqFvPX46zXh6LJt2PCTNw8hPWA=;
 b=QIoe8lt4vmTcCsf8jx0lTB7cwGrY7tPDrefSLtWMZ8HxMlURMfrftriPTZ56K93aIm
 FJ/ijJOw7Xo9CS9YEdVWfoLx2sG9v5JqZFm3up1l+jM6qkDRdGjgNzdc8C+Jc8RX2f7N
 lbJUH+bpibGnF4sJWcObuD6Uyi9s6TsdZq+GPH12YVXGGjkSXTyjrjalGA3KExXSW9j3
 ovgcgeAzkvLZN6ZO7Z6uabk4svoWQq4S5VyLdmv4b6napGE8Xce+M8oo2AFJ254rgA31
 9EcNYAuTSxWHtyK2vNLv8tF0qvltTUFYHzZrt4TXVwqFT9w7qSwzglA1l8IP5yZY24Df
 qwjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaDN9PvXJj51QPFjROj+91VULohFBWEujwaFEcZainjRPN6TNv0yacNtdtjpWuNbrQNy+tAoQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzlawN84xPUnqoBXpywxX4jhbZoPKomq8eNfDEhHqGoT0vojkpA
 w6nSq894OzSGZHgeM2Rw8sp9IXW0axaZmgaT0HJuav7AoLra5U4nqUO6q7zHSeDdxeA=
X-Gm-Gg: AZuq6aKcO+h8p5kBUVQNf+QFjjDZMaouB+EyTtJGrZe3S1K+pXegBE/V8+qiRq3qmbm
 ELx13mSuwXBNf0M/FgStBt4oSO99Kd1lz7LuuGrjIdDo9K9jocZTs+lk5MfZ2Osj/N2n70aD+iQ
 EGX2D53QGbM7DGk7LB23MxYN3tRnYGOINQ3QMzfo3oRcVPtNNqiGsVNWLxV0Z058vm3nH35szJq
 DmZ9/AsFNrbBccQY2yZhyPs9AKi95jtrfIR1gC5/yTaVhG6egby10wx1lfKC9jycik2oGyYwHQO
 40VI8DSfyMhJnr3zYmjWpFFwjZmAWGd80rkfZtJgap/k8e/e5wEgs4nlPQW+r0D/srKJwiYvuNB
 cExdnvF527m0a3KvfSY4vnQPvMQ6nlBK6o0+B7/vvvM36jZ2s7IhCkCTA8oB6KOXOzJ+wtS5uED
 cU4DLFHTasQexwgmM5nNNGqjQMC6c2
X-Received: by 2002:a05:6830:81ec:b0:7c7:6063:8e0f with SMTP id
 46e09a7af769-7d52beb8817mr6717162a34.15.1771888972856; 
 Mon, 23 Feb 2026 15:22:52 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cb87:475c:5c04:ac92])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm8911230a34.5.2026.02.23.15.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:22:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Feb 2026 17:21:55 -0600
Subject: [PATCH 3/7] clk: mediatek: add MUX_GATE_MIXED macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-3-a7dc97bc2660@baylibre.com>
References: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
In-Reply-To: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ipkG15h3VF+VsATAUpcJx7Kd2UDYgtjERtkvsiYli2s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpnOEnb0sZxTP6OiREOvhfQh5Y5/oB8Vq8+Acng
 jHBCzm7lIaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZzhJxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ARtUH/jnvz7yNaCS876z3XospWrRArevqXos35mr9Jg7
 R/OVNZ3YIsu5xvJEuuU5uCwbm4xa9vRwo2LeiNvjmZkz2upuvesLtgGH48cHjs16ZmqJjCPv4wb
 OQci7FjeFWV4SnfKNNkt2NEmOWTEBSHCucQwLkcVL/wWY4bbjWCBMjfdn9KBHAEJKToq2ReTDiY
 c4dvHo+7nOyPlYtsS5nXEVD4E+1Q1XA3M1trl80FG4uDvnLCXLRpAAqsOF2IVmcNe6webb1jOCe
 fo62pFZ215f9zSiNTZ5VfC/4SONBBIT8Foppgb4y2yugf6pqo+3wc53WgIpDVOwb96eRlLvp0xZ
 NqEQ=
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

Add new MUX_GATE_MIXED and MUX_GATE_MIXED_FLAGS macros for mixed parent
muxes that have a gate. These will be used in a few drivers where we
already have this type of mux clocks.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index d33e5cd2480..386f531514f 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -178,6 +178,12 @@ struct mtk_composite {
 #define MUX_GATE(_id, _parents, _reg, _shift, _width, _gate)		\
 	MUX_GATE_FLAGS(_id, _parents, _reg, _shift, _width, _gate, 0)
 
+#define MUX_GATE_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, _gate, _flags) \
+	MUX_GATE_FLAGS(_id, _parents, _reg, _shift, _width, _gate, (_flags) | CLK_PARENT_MIXED)
+
+#define MUX_GATE_MIXED(_id, _parents, _reg, _shift, _width, _gate)	\
+	MUX_GATE_FLAGS(_id, _parents, _reg, _shift, _width, _gate, CLK_PARENT_MIXED)
+
 #define MUX_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, _flags) {	\
 		.id = _id,						\
 		.mux_reg = _reg,					\

-- 
2.43.0

