Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82B8C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE365885CF;
	Fri, 28 Jun 2024 19:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mb3g8MNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BEF788581; Fri, 28 Jun 2024 19:41:39 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CAC881EC
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52cdf4bc083so1213647e87.2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596496; x=1720201296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SknnilFIlbr1+c9Kk8k497XgsUslF2I8VOy0GTPZWY=;
 b=mb3g8MNh6mxIl5eWW5RnSWAsk2rpLNCQhO2hTA5hxWRJ09Pa4qojpj8aaWhSmtKZho
 60BMth+n6w0EYWInqUsbhK1mnamXE38crIPxHNZtqq2gNr/fVhVniJAfJyyVXuafoTUE
 gqX9/AMohV969QQ+sBi88eGh3VMEdc0LJVTXxfKCQzgXmg/9L3qPd9SU5urGi6Tml2/G
 f7Iza2cI3KD+Ox7RyrwZm5MuaxL5zZD812bprQws0REqpSXqjY2fsSFmX9B0fqgEZwAm
 eqT1tx/WrxvJb1geoYPJbNSRvHLqYRyEaocd85FLSyRPYDNcyLJWHIN7kYvJWOVhgo88
 nU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596497; x=1720201297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9SknnilFIlbr1+c9Kk8k497XgsUslF2I8VOy0GTPZWY=;
 b=tJILcmQMbOhhgVgEpy9JdgUa+7ACP8qsre5ck9CDywGGPsvVFeokHJNzcm9+ZQ+Jiq
 oAhAo71lXGoYsZOTbFLmrSKfSnjDAtojyomT/QYVVbXK38DtcafMpm+ZfA2783r7wCN2
 bWpzS5waeuSpsW4qgJX2igpNkbhWilrPaQPXSdu/87KNd+qSe60qo75KV1NQCjX6ll3X
 UoZaBeY2togCrb8cuhZLiO+nePzNNQhxYVGb6Zbv3kZ6MkZq0YQSLcfy8a2/NU6I38yG
 kieE46PA00VNek89kPIHRFS0Prz/sJguoqvXMKtWTPBvpDTUuvecShf+odTk9HTZbfsT
 d6Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS6RTmw9/B3ibcQReT0MAE7j8KaBdcqKsJ+wo8sgtwtnYcxxIlVrIoirZX8kbgL4I4ierlqKGV8/H27H66WhTZSNIWnQ==
X-Gm-Message-State: AOJu0YwiILFXzMefM7EZel+5gDPCEJqwPXaFNWk8TuenbeDOPLfKDJNr
 VKaYbSOFpTm091WzEhI1c8gRv9pilB7HY/jPWtP2MzdLPBVlilcb4oLRKg==
X-Google-Smtp-Source: AGHT+IFZeervVE3IMFGDWuHfgBRUlKES4lEYrnarw+w+uRZyc1advrp80axirlrTQljHZSAQaqeeWQ==
X-Received: by 2002:a05:6512:3089:b0:52e:7ef1:7c6e with SMTP id
 2adb3069b0e04-52e7ef17d05mr397920e87.51.1719596496299; 
 Fri, 28 Jun 2024 10:41:36 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 02/12] clk: mediatek: return XTAL rate for infrasys
 get_mux_rate
Date: Fri, 28 Jun 2024 19:40:47 +0200
Message-ID: <20240628174114.8675-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240628174114.8675-1-ansuelsmth@gmail.com>
References: <20240628174114.8675-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We currently return 0 if XTAL rate is requested in get_mux_rate. This
deviates from what is done in get_factor_rate and is totally wrong as it
can cause unwanted results (division by 0 crash)

For infrasys that makes use of CLK_XTAL, assume xtal_rate to be defined
in clk_tree and return the rate when BYPASS_XTAL is not enabled with
clk ID 0 index parents.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index e68beccc060..555e2220748 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -376,7 +376,7 @@ static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
 			break;
 		}
 	}
-	return 0;
+	return priv->tree->xtal_rate;
 }
 
 static ulong mtk_topckgen_get_rate(struct clk *clk)
-- 
2.45.1

