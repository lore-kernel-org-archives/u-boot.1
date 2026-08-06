Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CCBC56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC255406C9;
	Thu,  6 Aug 2026 16:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aMBw951-kPEP; Thu,  6 Aug 2026 16:15:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D2B14074A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032935;
	bh=YUEzkUUju/SRNy4U321QhDBLklfjBjw+9tlcVZ/m4SQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lKB1Kpvd01/NZiUbKg7atl7r4/4N3nMhsFRSwDrFEd/8tqzeg5lXn8DUtzzGrf20Y
	 v2lLkH/45MqAEW3IWXDkXecHhF8oke6TeUx+cbKBSzWkWi51xgJoeoaA7TRDyM562b
	 6AZGS+RihmVgLuzZDH+MzXOxLYc9CFuzmE7Rkm5rhva8yIOTVmvwvQ4xf8lKmP9rSM
	 F5kZ71wppEioxwY0FN6j0srHXA8fqXIhXPJcSWiqwCUIySmXbNA/fiMf/LlsiSrO+u
	 06jsgE+wP2S4J8+VAcF12DC++Qxko983U4ZEK8F1ALJjaoale3q1vmf1i5sk61c7Z1
	 ygWB5CJgIFXgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D2B14074A;
	Thu,  6 Aug 2026 16:15:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E9D1B397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFFA280E7D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8xFEKZc5Eic for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:15:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ED44480AF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED44480AF5
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED44480AF5
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:30 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb4d532e65so1183275a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032930; x=1786637730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YUEzkUUju/SRNy4U321QhDBLklfjBjw+9tlcVZ/m4SQ=;
 b=MR0gbiVRQ5SSMe9rf+ViZzLahE2KqFDm3/bkhWQnbo8G/14GuVCzLa01UinkakB6DF
 uXlecq1ZZjC88lkyvoBY7ouP3P7lUxfY9A9EnCzZKqBKWRggDZzJ88K/GDJVKR80pKKg
 IddaTsjGsFXoyPf/MLF/EZnt79F6P/4XIdBPB7D0FYMDAfOaFYsCew11AC+A31alwnKp
 haiJs2MGc/pQfH+uUXPy5Rc64PpJLAxZhAPwYs7L0vDmq9JECu+c3Lw4I3hWXWwpeAu0
 Hi0T3PC7vyEXqDcfV9cVpVAXeDzjQUifHDeuUsufciDUU3QcnRjm3hzzjhkS7Uadgs8k
 ppJQ==
X-Gm-Message-State: AOJu0YxXbTVTv5KhocqhI/XgQQvUC4Js+lTUoVKjFtD3WG0Xab8Kc9V0
 9Uip3mE5X7KlllwpI0lOt4yZv9KBwNDxuU8m3xbUN/RZW6TAi55Ha0wvntQ6Anw44nbrieLXB+/
 zUvSNLFM=
X-Gm-Gg: AR+sD11ALBu5Y4WtXGBkTcTYo+hA38G7/dsSfczfMCctOqBu2Wakir4xzs/Zt3UIL+l
 xg5RDsaCXHI0Ox4GPwJhpM8KATgMIfEG70gGFrgvPS2Fpd9u+OgnxVlLd10ryWwYgVw+U92eTgz
 xRXQ7Jz/+i1ToWvW4VfpUHkx+R6j7l/uVzOmWdyysOhaON7dLsAZnzlFs7Z8Aci3gZXvUMUOhsb
 ClzamNhEm/7mXCMRwIjkyhXOHnEiH2bWDTMwmxlI241N9kgjAx3OxlV9nt/I4CU+zXjKyCJVJw8
 cCwkkLGW709fWw9IJyA+CCZhC1RiTpcPzMMCowIDJT3uFaWEileqdzjeY5INpsCjQ32I6sXjLCn
 4xSAfhSGWQTlSejiUhCt0eqBVunsCOtiiMyCf6f+3XS9TWnMto+m+uwZsyvhaDzUjDiwzCIh7xt
 woU0KiR0XHnVS+8Fiu6HplZKVUoJnO20/FVQAiO1+22Fn2ig0JXKAKmypAaK+XMSU52Kk=
X-Received: by 2002:a05:6830:2b1e:b0:7e9:e313:4fdb with SMTP id
 46e09a7af769-7f1e5c29681mr10035183a34.2.1786032929898; 
 Thu, 06 Aug 2026 09:15:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:beb1:8dd1:72b8:350d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f1df568d7csm4563367a34.18.2026.08.06.09.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:15:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Aug 2026 11:15:00 -0500
Subject: [PATCH 2/3] net: dwc_eth_qos_mtk: add mt8366 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mtk-net-mt8366-support-v1-2-5eb259ff69dd@baylibre.com>
References: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
In-Reply-To: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=iEas8ecn8/DLjmH8XMT21PhVLllybsegk/XBV8bdULc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdLMRn982SaPuzxNAgsJ0W/BjZLShgfXt0os2g
 GnU4gAlNRqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanSzERYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ab3oH/0aomMc64mz/1x07Wb4kApxdPSwnRD90xuALdHg
 SrLGBzeBq7dnn6w+3G2SixPpzmdYz2VTX3c48Nd8PfmdG34OOgr/aplr+VK8+6pcW6KDZ7grx/+
 StZ6jIqMeV+CElaDcAE6ZFQHPxK6jKzlJqb7K2JiqPLsB00Eam+UsS8UcXxyFxulV0ys78PkDpW
 pIYwPIlxlJOVil0Bh3kXAE89G77PDFHRg/dzYf8QZaXxTbGo91Z2SG3mZB9K9w8EuQC+IokdsTa
 6AFXPpqV9uprX//Gt7Bwkq0zh2pMub7KJnEIBq9M0w8ZZ8aZOu9OZaCSgAWvx/qgrg0JRz0CPMl
 Ksgg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786032930; x=1786637730;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YUEzkUUju/SRNy4U321QhDBLklfjBjw+9tlcVZ/m4SQ=;
 b=KG1ScxuOKNEM3ZObqDFfzao+aDmTENKkZ7QHQ0vD2CRKslB4j24j+YxW0OanB2AOkM
 2G55kiO1ygLs5tDhIQl8E2YiTfojNDe/wGvgI+Uac1CGmg2r6FM5Y+RLCks0nkcTzayO
 ZbmqP0mK6/82NyvN+e9OAvtc5dJ+6N/crz701p9KdoZiydZPFE7OAjcbVEAkJOnBe0tW
 uAFylFV/xcmgIPRSpaxp+ijrJ163iZfJaJVYJhNorznl11Rnz83y631WViaTNOIhOZuj
 6zibDp6L0HIfubvkfFhFsPtYZW7DCINBnGXT/1eo7Ow/WheKTkvqRFk/owEL8/BXuXM3
 j+Sg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KG1ScxuO
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

Add a compatible string match and new PERI_ETH_BASE address for MT8366
targets.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/dwc_eth_qos_mtk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dwc_eth_qos_mtk.c b/drivers/net/dwc_eth_qos_mtk.c
index a113870dc8a..b4ee9c12404 100644
--- a/drivers/net/dwc_eth_qos_mtk.c
+++ b/drivers/net/dwc_eth_qos_mtk.c
@@ -19,6 +19,7 @@
  * so add a SoC specific prefix.
  */
 #define MT8189_PERI_ETH_BASE		0x270
+#define MT8366_PERI_ETH_BASE		0x60
 
 #define MTK_PERI_ETH_CTRL0(base)	((base) + 0x0)
 #define MTK_PERI_ETH_CTRL1(base)	((base) + 0x4)
@@ -76,6 +77,10 @@ static const struct eqos_mtk_soc_data eqos_mtk_soc_data[] = {
 		.compatible = "mediatek,mt8189-gmac",
 		.peri_eth_base = MT8189_PERI_ETH_BASE,
 	},
+	{
+		.compatible = "mediatek,mt8366-gmac",
+		.peri_eth_base = MT8366_PERI_ETH_BASE,
+	},
 	{ }
 };
 

-- 
2.43.0

