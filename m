Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CEFFCA191
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 22:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD62B83F6D;
	Mon,  9 Mar 2026 23:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Z8STbrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5EED839DF; Mon,  9 Mar 2026 23:51:42 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC3CB839DF
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 23:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45f053b7b90so7897295b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773096698; x=1773701498;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yxjJRgG8L2TINge/+5O/bWoX69cvZqp/4Th8oLJ8Tqk=;
 b=0Z8STbrTCJdQ8X1yxOfCJXunlccpWtFU8wrkHyC60zzNSMkh5vTnKUuAyrvkl5DOqL
 iXXh4FZsKb3BdnJF5iTxld3REJRtCsa9Wux1wACT4b9Vcao4kr0+lXVwlReACk8DS+nd
 dpjuDr6DN9AinTPBuHEX4BOKPcJ5JPwCvnCWgmihkoKk23dI0BxzAdeQsLgnn7Uz3gDs
 cVGebXq5Sdr1cPuGoxDjpWXBxOHUbP5tcYLGl1p8jHGgINaBoKv0Ey1Mp/e1n0shEEVo
 gcPoNk+UMAeAM1YFeLFTuU3pVlkMH4nGjAO5g4U014AE4Gpgi+hqjc0NLhQqETBjLOr6
 rRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773096698; x=1773701498;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxjJRgG8L2TINge/+5O/bWoX69cvZqp/4Th8oLJ8Tqk=;
 b=P6NYquV0CptE1JrhpQFGgmXlVY9ynjwx5tves8C8Iysf8+qhop3PLu4Pj6p1IAUQQT
 5IKtoTn0Mhk3iAAknK+C1dyWeRneSJcDPAcCCzDJBahQoQeYslOTGJ6RCiaSUWXhI6U+
 xGLDfXFddfIrTKBFLT/L3P9dAKaPktE2jn4fF1zjc9xtXaCP+WwbD9EJ38CC2/mQatlu
 cNvT3bZTMgPl4EvSVxGm7tnkA8lyHntwGLfMndd3ZDgJKd2qoQDwveJKhPpSoshepZCN
 JlG4k4H6wxrxAUULV9WhrOe0ubTS2nbvvOpjXUSv4US3HU3tA1BtZ/AihPhuQbgjFjL/
 wOTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuXW9qltot01vNsz28q0faPSYqYttXzdEFs/SJQftodwts+5nnsJOl1UzH4G3xmTU0iCVbkW0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+vNQGiEMGPE75pEpQotsjqaQDeKb8i3mQXiHk44ENYdDl5CqD
 WTPKSdy8xZ1CzE8GFslDbsAUgiBrSG5DMFXYJWhakjEkcLkHq/UzAWuaVkBX66vt5vM=
X-Gm-Gg: ATEYQzw+kLL935r456hmf6CtYQNc9wDu/0tLaONKXsxCDWlZt63l/LvJaGKcT2Ipa99
 Cflgvaw9/s+ONx26WYkMiJVLwH09bSTDZ6IXrJIk8SK905oQg5Iwu9sOw9+b3YDQ2NOOb089B9u
 AMVg4X2yPzY9mPQoXEUSnSqyp7cPDLP6AxPi5n0rh2jEhGhpPw7etvs9GtQPUV5onElIAp45EIX
 qXrSwr4xMi4mzkBvshU3Fapg3ZKY1hdLYivRQWbxKP5efCpSjPpeW0htk7JmaTwPpeG7ejP9gI1
 +mWVQGS/BbLKKYcc4Dbavtqrh0Gxfl3t0tUDdKkXn+IaFVWerJozvtJJNxFGfX+njiDn+qcbTRn
 MMyMdI34BHZPWMvuJhc6TeP1+fYzlKuNXv8aNFhXOKR6TA9fPAKV3Aai1ESIChyTtyASXwzrxc8
 gFEjh0k1PVRBNiwYwhHnBRqyHx1l5S
X-Received: by 2002:a05:6808:4fe0:b0:467:19fa:19ef with SMTP id
 5614622812f47-46719fa32e8mr1040688b6e.0.1773096698343; 
 Mon, 09 Mar 2026 15:51:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3adcsm6150626b6e.17.2026.03.09.15.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:51:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] clk: mediatek: avoid more "extra" topckgen clocks
Date: Mon, 09 Mar 2026 17:51:09 -0500
Message-Id: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Ry27DIBBFf8Vi3WkxNvFDUdX/qLIY8DhFMcYFY
 jmK8u8lSeNVFlmMxGVxztXMmQXyhgJrszPzNJtg3JhC/pYx/YPjnsB0KTPBxYYXvAA9HMDG69R
 5XUPn3QS0RI8Q00sPTh8CSKUkbpoCc92xhJo89Wa5ab539+zp95hs8f7JLIWAN1ubbVfZKmoe5
 LkEDkS17OuuEz3vvhSeBqM8vWtnP6+yZyi59k49Ht09JjvMAnLgmoSSIhdVJV8jblaiJ+tmukV
 1mjAEWCIO0A+4v8I5KCELVTZ9XinxGrxZ4cfR9CewxwUm9DTG8I/kdUlYlappnmxAYUh9nLUmt
 pnzZm/GjzEdie0ulz8jZmxt8gEAAA==
X-Change-ID: 20260303-clk-mtk-mt8188-drop-extra-top-clocks-5bb5a693a1cd
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OKPvM6l4WBS82a+MJMeSETYm2lR4zUrcW5zfsj2VWRM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpr07iGA6SbtZqiATcwc6E74is720c3QtyTRMxJ
 D3pks3O1feJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa9O4hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AxjkH/RuS/zBs7IkbDsWD/H2vxyQ1pBVJUZCPc+fmNd7
 S4jm8enQH6bc1VGKYKHImTSbTB3mCLHZR5bqFbAFeeIsFUbYtzn2I+tt+RiNeYoIp+TLlUT9Cjr
 CxDKYXMQr7X+6DcW+Uf/iiDm26HLAzxrIUOMvoLlh9KnJL9NPO6WZ34s+6fGKJQc1RLY0Gr3Xn6
 cIJoPDYjWv0u7E8LMXvEqnyhC0c55Q2IFfeIi+pU9JpQoqKHASwqaSxC942Pqj2umOyXqTuStEm
 c3FepkNP5bxWo0v8VpD2mOEP48C/jIK4qsDULecJg9qqY31vecidH5E0l0xrVyxD+IqDicThimR
 lF/4=
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

This is similar to [1] in the goal to not add extra #defines for
topckgen clocks that aren't in the dt-bindings, but in these cases,
we are not able to fully stop using the ID map.

[1]: https://lore.kernel.org/all/20260303-mtk-clk-8365-drop-map-v1-1-17f81c375290@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      clk: mediatek: mt8188: use ext_clock_rates
      clk: mediatek: mt8195: use ext_clock_rates

 drivers/clk/mediatek/clk-mt8188.c | 741 ++++++++++++++++++----------------
 drivers/clk/mediatek/clk-mt8195.c | 820 +++++++++++++++++++-------------------
 2 files changed, 811 insertions(+), 750 deletions(-)
---
base-commit: 36add050eea439f0b2a15e4ea0d3a8e21216f159
change-id: 20260303-clk-mtk-mt8188-drop-extra-top-clocks-5bb5a693a1cd
prerequisite-message-id: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
prerequisite-patch-id: 81f2dd4fd7c1632736c08180d6b9f6aef5fe1e7f
prerequisite-patch-id: 60f0509a5f36c2828316fa3e27dfd8f4d218eb27
prerequisite-patch-id: 237c548edf19f9cf734b1ac3b9252a4f06d8cf29
prerequisite-patch-id: 22de64f70e8d1ba5e17f8b31f461118b35e54f30
prerequisite-patch-id: 3d5661f9e55292a30f57617848a7b10e67844402
prerequisite-patch-id: ccbc73b2bc1dc41beb295604088d63773cea15ef
prerequisite-patch-id: aa76b6b028374f20551955eafe56a1e0c1daa75d
prerequisite-message-id: <20260305-clk-mtk-fix-mt8188-rates-v2-1-0ce2b5212775@baylibre.com>
prerequisite-patch-id: 88e5a61d8ad8543f0fdf11f35bb6dba637d49550
prerequisite-message-id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
prerequisite-patch-id: 15ac11765ddddcf378e0e227a9fb5876636aa8e6
prerequisite-patch-id: 90b4781a99ea5eb40eb6c943dee86dd8a9fabe06
prerequisite-patch-id: 150153a03fa40f8f9d790526512f7341a7d95eba
prerequisite-patch-id: bdc28e831956d0a487c62e11d1442a51b9548c25
prerequisite-patch-id: 08b3b97b5870fa4c5eb435f5b19762481a94c058
prerequisite-patch-id: 291f87bf8033440b0c79a03055cec7e1317216e2
prerequisite-patch-id: d3ff487de22ca508a65613bebf8cbe0e61005a31
prerequisite-patch-id: f0e2edcbe17f6bea4bd4e6ceea49cbf73b7568d7
prerequisite-patch-id: 0700411359ab89ebd24c4c3d17a5864e41289547
prerequisite-message-id: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
prerequisite-patch-id: 8789067dee5193eac9889bdb35cbe53fd8ba3db7
prerequisite-patch-id: edb2b9a5644e0deb0b846cb6365957e8cdd9e9d8
prerequisite-patch-id: 14723a8815ed459c3995ba2682344f8c6813da74
prerequisite-patch-id: 5c528aa9c92e9d79fe406bca97192624f0267db9
prerequisite-patch-id: c5a12abe7b61f253d13966fc6b257995f085c7b0
prerequisite-patch-id: b4f5a8dafda57305a07cfc3783d7154558f515a6
prerequisite-patch-id: 9a33fdfe476f6dc0e9e314755073d308c6a61a1e
prerequisite-patch-id: 2daeb61c75b459c5c790266c329439a0fec5f50c
prerequisite-patch-id: 29f06542d7c519b8995bcebd04b800508cf32d1d
prerequisite-patch-id: 2d8a751c3012596e64b93e5361c7a50c8ac0a303
prerequisite-patch-id: 85f6c9b692293d482d04bb3661fb51dfb5533ef0
prerequisite-patch-id: 688b2021a1585ae037c15081cf43e62d95e7c286
prerequisite-patch-id: 10f08bad47e8a2e6953c59540264dfa9ba433c1f

Best regards,
--  
David Lechner <dlechner@baylibre.com>

