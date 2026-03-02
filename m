Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3089BEB3622
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9859783F56;
	Mon,  2 Mar 2026 19:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PEyULNGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D102383F2A; Mon,  2 Mar 2026 19:04:42 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABA483A1B
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4648447e29bso2048214b6e.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772474678; x=1773079478;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FAzuGQeGaDsWKhnzKUfYi8z3OgGUWHqNYjgVYAEXRsM=;
 b=PEyULNGQ3fW/qm4u9cWvbCn6dE7fIF5C69iaKls3KuvsCKVqhr0gQ6viYV1rg12t/5
 S2dSIGmzps1jGY8BgZVb1egIbxwpgYpbrdQZftSNBHs6l6J8pScaGBTH1cVLWi72yuzr
 P586TkSOVh9aho5tzX8lsBpCqQUM4r9bgho5Xk/PI9T4139rB1L+zarmX7QZ+nu+pwXb
 eh9sNu04DTMXkSZ4iCmEJ/U1cK1yn4AVJbk0EvwUcFwqNe0fKk03S+B8OX35bsGnvYth
 RZr0FdTB/ldF6Hj4QIn5KuptcWkquS9dyE1hyiIaVXmS6ft8AbV29E3ZYHYjNBi+p0K7
 WT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474678; x=1773079478;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAzuGQeGaDsWKhnzKUfYi8z3OgGUWHqNYjgVYAEXRsM=;
 b=rVtbGrqG2KcycLuFRx0PoTYE78pYoWk7Arvt1N57iB/MBH6nFs/G+pp25jCweMEhKX
 13z375wEjhByXJGbwfBw/ni0BxLrBAKmrpa1RECtv9MXnLl23A4j6mbdnfFM/HBSt2lT
 JbdwiJ/i1s8foZWFWr17bjf7Tb4n46jYGuFDTRaUWFLxWLijabzS/tYREfWF3PNri0J4
 +4N00zipnRm3amUFLuIH8HdgZTIWcGumdpd3gSaarnPjvxiuBe7RIzFkhixxDX5KSK4y
 fcPUM2Jo86AwEAb1lRg6WmU4ekypc6CRtyG/VCCvZ+fXpb5rtvqPj7K18126B/2RqsvH
 3MRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIAM1awzxGUOtXO+Ud62v5rLISmiMljbXqeIPshmDpdK5Y8Wcyslou03gRcZP+fXdvGMpTjpE=@lists.denx.de
X-Gm-Message-State: AOJu0YzlKcDCwmswM1OLhMcuk3nta8FSTYF7cQbYxjZiibbJOhQWGJ1I
 oi4Bej0R496vfFfxIq0Fad63vt73zMjhOP18FyUU+hWMvL67SIK5MnQxA+9/Hb3TH6E=
X-Gm-Gg: ATEYQzyu8bOjRKbqlBw35n0dfZOwaFTZdOCMv+LHNGBeCz9bMXPCGLcyH1P6NH7fcm7
 sThbdMsZVnS9fn+m/4Jkad/xGTbjbIUG7I+T7Fx+pM4deFBh6SgshTkA7F7CrmvkEyesdVssO8b
 PAid1SoewS5VWg7dJ2PjBxUOuColxQE0OBBkSw7dYpvCv88gPIOuPIYuL+rvuAGpGECfUJDNda7
 TFQwGbiGG4W2IixZYOANBPxy7bOBD/G3y+j5lDCzbSoHF2sjAEoWyjY39jtk7s/Mn/2wSuA4/VG
 seJuH1aR3BnMkMMzSxqFwMr2vM2KErgqMefco9uMqD9P++nVkUH8Pppj+b1WenYP6LaH3+DqsJ6
 y1k+DbM28zgEPHI3GPRsZnUzCnYW2zyQTu+++4Jzw8WOp70sUP6PFG2vFaqvvvLJohsR57rIatx
 mXPQuvc6RGCAG1xyuHjNTIqlzLOD/BB5In35wZUpA=
X-Received: by 2002:a05:6808:5145:b0:45c:9b88:d368 with SMTP id
 5614622812f47-464beeaa51cmr6143026b6e.39.1772474678303; 
 Mon, 02 Mar 2026 10:04:38 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab302sm7986125b6e.7.2026.03.02.10.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:04:37 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/7] clk: mediatek: new mt8189 driver
Date: Mon, 02 Mar 2026 12:02:07 -0600
Message-Id: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Oyw6CMBBFf4V0bbUdQIGV/2Fc9DHqRKHaVqIh/
 LsVXBjjYhZ3cuecGVhATxhYkw3MY0+BXJdCvsiYOanuiJxsygwErAWIgrfxnKaSVc3NxZlz4Er
 WFgUUqqgsS3dXjwd6TMzdfs4eb/eEjvOSaRWQG9e2FJvMeTpSt+rwEdm7fqIQnX9OH/Vy6n/k5
 R95L7ngWitTiDoHA2qr1fNC2uMyCSZgD18QufkHgQQxNq+ksaKEUv5AxnF8ARojlr8pAQAA
X-Change-ID: 20260204-mtk-mt8189-clocks-a19de024a48d
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=F+70vBiRr2IKdObvOPBAAhpVhu3m8o4+6HAasVFn4NU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppdClrp2phhikNM5fcXiR/zqxk5gq6XzJtkbka
 omcxsljVCKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaXQpRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AYAwH/0SUr1lUsCsCtKd0nt6DEpo5VwumA+RRVdDXhln
 xhOEfHDO/Pqs/8dMJFl3kLYA7LBssTTLqAslTljyf0GQZpKWdVX0Sl4LVCnuRq4jb/585fJLm/L
 mGFl2e8id6SoCg//GaqN1wjAOiw1ymmIfm8SKcP7aIko+Txr+yigspq+KnEg4xI8bHFPz0vUtEh
 5OXBgLzuw80kW2JJVN+IF56ycr2pcaS4yIjQ6upBV2IjHiKM0p2Tu26jYlqxaIKT7ADkypPLCyJ
 +tq8D/uulM9vJMLjXni8H4gilU5+0xTWqjgzk77Wv8OguoxCUsAfBMJ0mCUi/3A9pfISL/I9g3F
 9SwI=
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

This series adds a new clock driver for MediaTek MT8189 and similar
SoCs. This one has some unique characteristics compared to other
MediaTek clock drivers, so there are a number of preparatory changes
first in the series. And, as mentioned in a note on the dt-bindings
patch, this is simultaneously being upstreamed to the Linux kernel so
it will be a while before we can use the upstream devicetree sources.
In the meantime, we add a copy of the dt-bindings header file for the
clock IDs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v3:
- Add more macros in last patch to avoid repeating CLK_PARENT_* so much.
- Dropped dependency since it has been merged in the next branch.
- Link to v2: https://lore.kernel.org/r/20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com

Changes in v2:
- Fixed CONFIG_TARGET_MT8189 in the last patch.
- Link to v1: https://lore.kernel.org/r/20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com

---
Chris Chen (1):
      clk: mediatek: add clock driver for MT8189

David Lechner (5):
      clk: mediatek: use correct struct type for infrasys clocks
      clk: mediatek: refactor parent rate lookup functions
      clk: mediatek: add mtk_clk_id_is_* helper functions
      clk: mediatek: add CLK_PARENT_EXT
      clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS() macro

Irving-CH Lin (1):
      dt-bindings: clock: Add MediaTek MT8189 clock

 drivers/clk/mediatek/Makefile                   |    1 +
 drivers/clk/mediatek/clk-mt8189.c               | 1748 +++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                  |  260 ++--
 drivers/clk/mediatek/clk-mtk.h                  |   26 +-
 include/dt-bindings/clock/mediatek,mt8189-clk.h |  580 ++++++++
 5 files changed, 2487 insertions(+), 128 deletions(-)
---
base-commit: f6963fc232603007c661411fb31c57f1a9678a87
change-id: 20260204-mtk-mt8189-clocks-a19de024a48d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

