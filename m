Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3FDEB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8E88405F;
	Tue, 10 Mar 2026 16:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d5z8V4ne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A078409A; Tue, 10 Mar 2026 16:34:17 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524FC83FBC
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-46701f2077cso9188b6e.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156854; x=1773761654;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0zCS5vKfBWgr7bmlhO8zH587grxscgNznciHBuIgdKM=;
 b=d5z8V4ne5giwfZIu1pIvwVdRarkX1ro0sntdAOIyAgojLtSa0ipweJohGzj9vDlBGR
 Tp3Rgx/iftks5ecm1Pa50QcPDKtB4tEpB0BVxknPlAQZK7jpZY6+BlcrJ2Q0YW6NLt/Y
 M+6XgfOlHdnfMQTOxWEJfj1ZbLWdLC8nOqaV9EGUCvdvuwaqpDMPHkl7/M+MhvizNPFS
 sqwaLsety8TD0iTURoxiVrIEZOcuI3dbJI3HzC3g0Tzx3Kdye3YW0wulEBK8fuJvQnBe
 FjhFPP0zeEYuejVNQR4gc4/GHI6wfXkoY7cjiayOaTQx9qWb7FZzHEhU4/ca913/XTdZ
 i56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156854; x=1773761654;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zCS5vKfBWgr7bmlhO8zH587grxscgNznciHBuIgdKM=;
 b=Ne84gkpxbXEDrMmPKUIySjpXWROPupugCexS3IlwV5iiU62zWSIKWnW6P0w8J1dv4I
 LyLWsqpUvgjyR7z6Ulk/VxUd++TBiUm+XBu+8vnmjODAgQMKN2y1Hb2XIfmGStH+nUFp
 bd0YuGVY826otd1VOLmGZfLe327Xjkjej5a9uiHVwLGuv2Jd1wXwTneUXCB+/Y8MxOLN
 FKry3luYWG7ONmNsEj+1QKDaDPkii+8KUO3rNqe7fBndFbgPWpzfkrQUmtCJW0IE5MqL
 8IphzdQ4s04D38eoNDi4jirnyG9aRW/QLnRyvmuxZY4pVTUihH4WZa3PSE0/wuNwyM3G
 gZfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvezIN2zZ9NC7PIdqQjFdzELFh6kK754JUi6JkIuxF172TIgQho7nPrP8F/UTmoZsxqdIvBjA=@lists.denx.de
X-Gm-Message-State: AOJu0YywpDtNcpeH+XsQadsaiwRfuj8z5O2BcjFN6T8kuFKTjSwEyYYf
 4gJhvyzwMiZ/nC7rsIZF3S0C8E4dmlh/ePeeu4aCKm+geQagCRGp9ZhiIBSZcarHWO4=
X-Gm-Gg: ATEYQzw2smawzlCwSzpP0Q+bUzrtSSTInVaS8dhBd2AI//s369Z9+FpH/UfSl7eSeks
 zNpCHuoQbNWp6c9ies5GN/TKUqT0pWncGjs5kRgD/KEknm4QvgI/C5K+QeRi/O8MLNQJnmFVicP
 B53GXkLwN4II2aBi2xUzKhNk16PXmcRnCEu2/XfGHjKph/9nZs6Sqrkrbhw6dT2i3vwUEk5NYS0
 Uo6Ldj5kW78X04HbSXzIun9GVL3BshnsU3Re8k2cyohtr210qwESnlMv4HaU/K/oCy6TufEFWof
 RwznLrm3gDjaqBhSa8F5P/zwrdIzjstFA/ckz0/LQoKk143m42ye8mfZ6oA4EnCE78JwghiRlmL
 SFo0sLcpwo2E2b16euzmKsQo29MNxWizIxAaVxxXdcHxWX6nkadDVu8/MpMBb/C+iuCd88oRpXI
 7TqZl6PB5wELgV5wCuUBKZLXsacXWG
X-Received: by 2002:a05:6808:179e:b0:467:10f0:737c with SMTP id
 5614622812f47-4671bda2d3dmr2216467b6e.3.1773156853976; 
 Tue, 10 Mar 2026 08:34:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/16] clk: mediatek: remove CLK_XTAL/CLK_PARENT_XTAL
Date: Tue, 10 Mar 2026 10:32:13 -0500
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XR0W6DIBQG4FcxXO9sgKjYLMveY+kF6KEjFXWgx
 qbpuw+186oX3R0/CR+HnysJ6C0GckiuxONkg+3aGNhLQqpv1Z4QbB0z4ZTnNKUpVM0Z3HCGXnl
 shxhRtWMPpqyNEVUuaZ6SeLj3aOy8wl/HLXv8GaM/bJvEYQhq9Q/J+84vtBskk2Wku+ocYBJAA
 VFmRtY1N7T+1OrSWO3xtercx3LZIyrbJ41zbKQEr+LtMHFgQCvkOuOMF0X2nJjvokfXTbhGfel
 VCDAPqgHTqNOCU9A8S7UoDSs0fw4vd3xsrbmAG+d7xeFOUilQFUKX5ZMNbGUurEzzDGrf9eBUD
 xOLz2eFkaxKi4yX9L8T3stcQZwHr2CIq7/vitVCjigKkSop8gflahVieZ1zdjgknbcn2761ESL
 H2+0XmVFr9ZECAAA=
X-Change-ID: 20260303-clk-mtk-parent-cleanup-f9dff4c68063
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5628; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=iW8Ipfn5x5jbvtVZpg6Fyz3M0m/O8vGf8f3NX8c5wuQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDmFbXo71YvK5XQF/Oet0gIb21vBEJoEApDHi
 KeQ+wIY6zKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5hRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALpIH/2oWTaNhCwAjPS3mK5Gm6e6k9ChcrR0BO9riq/i
 fKDoK6QGRnW5zY1LMpo1VpZtu3PwvDjULhb3gBuwBgWiN5hwwziUK2XSvL9CeR4qbzXt9UvPrR7
 OXDNrKoE3ZzXLLavoWM/e0B8XcOVJHqZgLy5uswq76sg+Nr1qSnMJyTvGGsuN9JN9q9Vc+jwWfo
 gWT/LX8hfnXNDXvC/Vq5jTXMWssyhOMSaIdNZwtUVC3W9kJZJ6eLnxj6OTD9hqehcKFNYPOSNyF
 vNbvO4aRWstKMVLIMkaNKT9pHB6qIJpml/8W45fT1RFrqWD0tucBvsGNDy4RXT0SNC555GvsqcJ
 pwN8=
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

Since many MediaTek SoCs have more than one fixed-rate external clock,
CLK_XTAL/CLK_PARENT_XTAL is not sufficient to represent them, being
limited to a single clock. We have since introduced CLK_PARENT_EXT that
allows an arbitrary number of external clocks to be represented.

This series removes the remaining references to CLK_XTAL and
CLK_PARENT_XTAL in the MediaTek clock drivers, replacing them with
CLK_PARENT_EXT.

There was also a special field (xtal2_rate) for the PLL parent clock.
In most cases, this was the same as the main xtal clock, leading to
duplication. This is also converted to use CLK_PARENT_EXT to avoid the
duplication.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (16):
      clk: mediatek: replace xtal2_rate with struct mtk_parent
      clk: mediatek: mt7622: convert CLK_XTAL to CLK_PAD_CLK25M
      clk: mediatek: mt7623: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt7629: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt7981: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt7986: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt7987: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt7988: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt8183: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8188: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8195: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8365: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8512: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8516: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8518: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: remove CLK_PARENT_XTAL

 drivers/clk/mediatek/clk-mt7622.c | 121 +++++++++++++++++--------------
 drivers/clk/mediatek/clk-mt7623.c | 147 +++++++++++++++++++++-----------------
 drivers/clk/mediatek/clk-mt7629.c | 108 +++++++++++++++-------------
 drivers/clk/mediatek/clk-mt7981.c |  17 ++++-
 drivers/clk/mediatek/clk-mt7986.c |  17 ++++-
 drivers/clk/mediatek/clk-mt7987.c |  46 +++++++-----
 drivers/clk/mediatek/clk-mt7988.c |  62 +++++++++-------
 drivers/clk/mediatek/clk-mt8183.c |  15 +++-
 drivers/clk/mediatek/clk-mt8188.c |  11 +--
 drivers/clk/mediatek/clk-mt8189.c |   4 +-
 drivers/clk/mediatek/clk-mt8195.c |   7 +-
 drivers/clk/mediatek/clk-mt8365.c |  13 ++--
 drivers/clk/mediatek/clk-mt8512.c |  21 ++++--
 drivers/clk/mediatek/clk-mt8516.c |  21 ++++--
 drivers/clk/mediatek/clk-mt8518.c |  29 +++++---
 drivers/clk/mediatek/clk-mtk.c    |  44 +++++++-----
 drivers/clk/mediatek/clk-mtk.h    |  11 ++-
 17 files changed, 400 insertions(+), 294 deletions(-)
---
base-commit: 1e240f7206fccde4ec73ea432ab8360d321c5fe5
change-id: 20260303-clk-mtk-parent-cleanup-f9dff4c68063
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
prerequisite-message-id: <20260303-mtk-clk-8365-drop-map-v1-1-17f81c375290@baylibre.com>
prerequisite-patch-id: 625ea8b616208d1c8a412ae514d8e94a3c13a6ff
prerequisite-message-id: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
prerequisite-patch-id: 63670888fcc3abb762a182a7354216e2700a201a
prerequisite-patch-id: d8e4fd450697687889673ea835578739387d612a

Best regards,
--  
David Lechner <dlechner@baylibre.com>

