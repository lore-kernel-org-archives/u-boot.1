Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68318E7315A
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 12:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC5B683E57;
	Mon,  2 Feb 2026 13:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HMmAIpDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC63883E1E; Mon,  2 Feb 2026 13:08:17 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5773183E23
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 13:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f2599980so14873935e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 04:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770034095; x=1770638895;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HbQUp5NP75Jrvs87lAvzapo0edtkB97/282NbI+TYYk=;
 b=HMmAIpDH+HnOGTP8t1GNxisWxtlD79c0ySbCaDopirO5HZKbwiK8Kc45Uuol00D9lk
 VpTuxJ+ygUtUEjcUzGKwgw+NhBfsfHLEbskCN2BgL7SGjOPYXq808jQspfsoh3hxcwql
 RyFNNjw3K6lsEP9Qfk/VNAHqi2VEKZ6cwK4AO70eyKol8jJiSfwpJC4jfmuVll0wb5RJ
 WQTW/FLYSEpA4IVCeYIQV3Fd/lFQg2d2lpUd0ZtZfXjql9JCfaEflXe4ZnbRyNI5xBch
 1zUaoiDE7b2NlY7fQHINXQ7kjvRL+Vco560dJJ1FW4H58S0NywTcjZ8iHldTn1fEgNGa
 9zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770034095; x=1770638895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HbQUp5NP75Jrvs87lAvzapo0edtkB97/282NbI+TYYk=;
 b=tj0HExp2rd/01mIm9px6me3lGuVa3nBZmOOr0TsrClHzFbNBTDqKPJ0Mp3hSf8B2q8
 QjmnRq9aQOM1dC7YkWEyIWEJqYmiZ3/bOqoSCfnSbb6UqpOSyyMsh/SsSmesI49ySK90
 AvG3dgh4vvRTgUDBZXt83MBV+cq4hJK36tQPGMWwvlK1s+z1AwF9HmLw/zIJirCNAT2c
 x9JHEeDt6qnWcXlFpNhwiWziyhoV38wlXcZ8denSjK+2yqm2CtrBrF0zIYfg+w6ghZXU
 2ExcQuQW3E+C8aUhUSE90IkAH66nGVozCw0pC2UeSPvrp9+5mgCNHnP4cW0Feg9Mda8h
 PDQQ==
X-Gm-Message-State: AOJu0Yy+M+hXjQrCkibCRG8bekwN28wZQeEJg7gkNinpp+THhepXVX85
 5t6D9fQpQbF66g9Ikn4sQYs/pqYw6wgISvTVupfkqMloMgWnh9jO01lAHyclbi0PHKw=
X-Gm-Gg: AZuq6aKkrL6/EO79dLR22gU+mw8ZadPmPfqEuSPEfhp/ogJTetQziDmYeaRGsZGzG0N
 NMxRSVKpuCDXTkh3HZnkivSG5gU1vdOc2jPnbtLCOT5FJf6PoOrGd9uECHm1bwsVZNj/XLYMa2F
 LXroxM5gdkVYsiq3uLdKLCDk7E2Nl4Q/DoeVkH1krE4bTiTaePUbwAOnugwnuGF998ihiHlNda2
 LQlN4DsqbbatHCZtmInldY7rSwZ3IdYiwuRJGOFzWa7jEjWBfulq34NBPy69gA/JDq5K20vI56a
 G4Slo8twzgJ5shS9PHREfJjVnh47t7Ab2G+QEuxaNBEJeKQEKiD/+e4iff7FH0itCjEr2O0+5Pu
 A3ANYjix/swfjGrhXDqS3K02/DhDu2ERO7BTernv5HTj3Mz1H5rtUO31J1QWq1B02p9NeKUfXib
 /fixPhpohAPu9+0sm6ba4Y/K+7KAeQEOZVavLDqK0fF6PPUJqsMqjT4Kd5xQJiMyL6ONRRghNSL
 DKBu0vixA==
X-Received: by 2002:a05:600c:3b1d:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-482db46014dmr145136545e9.9.1770034094614; 
 Mon, 02 Feb 2026 04:08:14 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e267b699sm89784635e9.16.2026.02.02.04.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:08:14 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 02 Feb 2026 13:08:12 +0100
Subject: [PATCH 2/3] clk: mediatek: implement GATE_FLAGS macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-add-mt8195-clock-support-v1-2-5d03495246b9@baylibre.com>
References: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
In-Reply-To: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Add helper macro for mtk_gate, the same way, there are macros for
FIXED_CLK, MUX and FACTOR.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index e618e982e8b..f3d2377aee4 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -243,6 +243,14 @@ struct mtk_gate {
 	u32 flags;
 };
 
+#define GATE_FLAGS(_id, _parent, _regs, _shift, _flags) {	\
+		.id = _id,					\
+		.parent = _parent,				\
+		.regs = _regs,					\
+		.shift = _shift,				\
+		.flags = _flags,				\
+	}
+
 /* struct mtk_clk_tree - clock tree */
 struct mtk_clk_tree {
 	unsigned long xtal_rate;

-- 
2.52.0

