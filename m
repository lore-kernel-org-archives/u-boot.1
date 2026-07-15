Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25F4C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE9A84ADD;
	Wed, 15 Jul 2026 16:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="adQUY+dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6473A84AFF; Wed, 15 Jul 2026 16:28:23 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E403184A6B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so9198775e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125700; x=1784730500; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XX4MRah/iW38K4+2wGA84I7bqkXoZOXXZAqrS+TjuiM=;
 b=adQUY+dgOT70GjcfMx3DbgSvbbIyspa6kgoVRoHqWbzlBB0dZW+YANb1NTTTh7iuEc
 b5R9HScyL5mUN7KhaJ1FvgEQNBlyAfODsuzbEAflbw+BnxZmwhezJ5DK4c5AA9avFtFI
 XIIwAn38Q7q4MnBp81nxTwOo7lJV3mEO7MRJ1Kv4E4B0+6ARkvyLssbPN2lZcxLjHPSd
 P5wUZj/0YcYyKQChl6j45KPbJz77uvvIf0NiHyH+e5T1YaM/DEUATv06r5jTatESabZN
 bL6umeUKDQS4eiq+Z0SVlHuQhtzYcqNf5iEjqEUDSGhQ03d6088gX9edpepCkTW/HhCR
 xIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125700; x=1784730500;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XX4MRah/iW38K4+2wGA84I7bqkXoZOXXZAqrS+TjuiM=;
 b=QKlhUUc+fbuRfTjGTbq8P/nc4ANuADOYIkU1dt12KhKRl/8KvuC64UCZfpVoTWo4ri
 sbisQ6Hmwxnw01dDO7SQkLySGpnUuiwiDwskdeF849nfCYX0AovKk1HC6eQ2xK0W075N
 k8BM2C6BkcJE4K3gy1pfIZTVLlrbs8WLxjQ/HdJL+TBHwIIol35OLtOcHu1pUKr2kbh6
 PCSEWOj5VPbQBzQ9S+4GpaOdQif16D3+JBB++nhneZfaBK/wUE7yEBqbdEo+zb8NfaJT
 P+sSFVb8jhRGstv+26336xi0WQpZch6I4TjcQIkaXbuLWIQbJK1qWgox/4o4sK5WsTox
 pm6Q==
X-Gm-Message-State: AOJu0YxVseB8/J0oKnIe2QGQf30C67Qgrm8tOSqkembmOGliVAfRPmjV
 fFb6ZSPjhlci2MrrHAK5jYedvVpaoQzagO5XcxCDBw4UIM3JoOGSnyFpq3D8wvliUxg=
X-Gm-Gg: AfdE7cn1IBpG+pIOhay0j1oucWZ43c14o5opP5UO9CR9/1c19p+731wb1BWS7/liWoQ
 StJaiohJebOnO4yqN75GsNUrN10gK9CS7UG7PmLWfC2B7g+FENCpp66dc7f+gd5BrF7ty3HWGEM
 m/Kpq5TrVpj7y79eh+nU5N9fMVY0SDw4Xpdk/7xCvfjdCwOXy0qT2evxJIXhE8t7/Sw8cSrbgNE
 xPgNaAWLuR/YXH0AOCSIbgoMA0UTsX9UuE3PyLsD8/3qfPL/l2ARWFHpKjMM5Ozlgk+fi7k1HXE
 ZNZsjnD1/90t59vuSuhCcWcZd7/dKskQWbL5yOIf2Tl4GXvn0DDbLM6+4uHxzsRjjsfLSIPcjEe
 X82vzyLbsNNwM0Fq0tyKajfNPK88CbVzM5+ZcG1cRSGRZSamEB6PTMkperv2gEju1JGPUUzBnNi
 DXDbrI9LsnZPqBZ6CIQsI7z9wq2H6UUl/UcyvWYOvekiSymFZVN4/f49CxC83Wy6MQ9v7vRx1nG
 0obEDVuitDQc7kCPm6w+NROSFrZPhXDyXEKn9kzM4NKpf/mBnKrmNNNTnORS3mQ7BFW2zoSU6B3
 twMYHb4=
X-Received: by 2002:a05:600c:1d8c:b0:494:1f7:8057 with SMTP id
 5b1f17b1804b1-49401f780a8mr117531445e9.1.1784125700299; 
 Wed, 15 Jul 2026 07:28:20 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:19 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 00/32] clk: mediatek: remove the dedicated clock gate driver
Date: Wed, 15 Jul 2026 16:28:28 +0200
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOSwqDMBiEryJZ9y9J0Fa76j2Kizx+NfURSWKoi
 HdvtCfoYhg+GGZmIx6dQU8e2UYcRuONnRLwS0ZUJ6YWwejEhFN+o3dGQeYwhh7UcAjFtMzJreq
 hFQFBOxPReaCSM1YWXOiSkdQ1O2zM59x51T/2i3yjCkf5keiMD9at55HIjty/m5EBBZHLQuUV0
 5VsnlKsg5EOr8qOpN73/Qs38ylk7wAAAA==
X-Change-ID: 20260710-b4-mtk-clk-cleanup-clock-gate-drivers-0b211852ad81
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>, Sam Shih <sam.shih@mediatek.com>
X-Mailer: b4 0.15.2
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

Several MediaTek SoCs expose multiple clock gate controller instances.
In U-Boot, each instance currently requires its own U_BOOT_DRIVER,
mtk_clk_tree, probe() function and compatible table, even though they all
share the same implementation. On top of that, the framework carries a
whole dedicated code path for clock gate controllers (mtk_clk_gate_ops,
struct mtk_cg_priv, mtk_common_clk_gate_init()), which duplicates logic
that the topckgen path already provides through struct mtk_clk_tree.

This series removes that duplication entirely:

 - The gates of each controller are described directly in a struct
   mtk_clk_tree (.gates/.num_gates/.gates_offs), exactly like topckgen
   already does. Clock gate controllers are then handled by the generic
   topckgen ops and mtk_common_clk_init(), so all controllers of a given
   SoC that share the same DM flags and bind() callback collapse into a
   single data-driven U_BOOT_DRIVER, the SoC-specific trees being passed
   through driver data.

 - Once no SoC uses it anymore, the dedicated clock gate code path
   (mtk_clk_gate_ops, struct mtk_cg_priv, mtk_common_clk_gate_init()) is
   removed from clk-mtk.

 - Finally, mtk_common_clk_init() is reworked to take the tree from the
   driver data, so it can be used directly as the .probe callback and the
   per-SoC probe wrappers go away.

Each SoC is converted in two patches (first deduplicate the clock gate
drivers, then move the remaining clock drivers to driver data). The
mtk_common_clk_init() rework touches all SoCs in a single patch to
preserve bisectability.

Drivers are only merged when they share the same DM flags and bind()
callback, so the device lifecycle (pre-relocation binding/probing, reset
controller binding) is preserved. Controllers that bind a reset controller
keep a dedicated U_BOOT_DRIVER but share the generic probe(); topckgen
keeps its own driver and its DM_FLAG_PROBE_AFTER_BIND bind() callback.

All conversions are intended to be non-functional changes, with one
exception for MT7629: the conversion fixes an off-by-one in the infracfg
gate lookup, whose clock IDs start at 1 while the driver used a gate
offset of 0.

Build-tested with buildman across all affected MediaTek defconfigs using:

  ./tools/buildman/buildman -b b4/b4-mtk-clk-cleanup-clock-gate-drivers -c 10 -x mips ^mt.\*

Tested on genio-700: clk dump before and after is equivalent (other than the
driver name).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Rather than only deduplicating the multiple clock gate U_BOOT_DRIVERs,
  get rid of the dedicated clock gate code path altogether: describe the
  gates directly in struct mtk_clk_tree and reuse the generic topckgen ops
  and mtk_common_clk_init() as suggested by David
- Drop the intermediate struct mtk_gate_clk_data / MTK_GATE_CLK_DATA()
  helper introduced in v1; the gate tables now live in struct mtk_clk_tree.
- Remove mtk_clk_gate_ops, struct mtk_cg_priv and mtk_common_clk_gate_init()
  from clk-mtk once no SoC uses them.
- Rework mtk_common_clk_init() to read the tree from the driver data and
  drop the per-SoC probe wrappers.
- Convert every SoC, including the single clock gate controller ones, since
  the dedicated code path is now gone.
- Keep topckgen as its own data-driven driver so that it retains its
  DM_FLAG_PROBE_AFTER_BIND bind() callback.
- Link to v1: https://patch.msgid.link/20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com

To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: Sam Shih <sam.shih@mediatek.com>

---
Julien Stephan (32):
      clk: mediatek: mt8188: deduplicate clock gate drivers
      clk: mediatek: mt8188: use driver data to store the clock tree
      clk: mediatek: mt7622: deduplicate clock gate drivers
      clk: mediatek: mt7622: use driver data to store the clock tree
      clk: mediatek: mt7623: deduplicate clock gate drivers
      clk: mediatek: mt7623: use driver data to store the clock tree
      clk: mediatek: mt7629: deduplicate clock gate drivers
      clk: mediatek: mt7629: use driver data to store the clock tree
      clk: mediatek: mt7981: deduplicate clock gate drivers
      clk: mediatek: mt7981: use driver data to store the clock tree
      clk: mediatek: mt7986: deduplicate clock gate drivers
      clk: mediatek: mt7986: use driver data to store the clock tree
      clk: mediatek: mt7987: deduplicate clock gate drivers
      clk: mediatek: mt7987: use driver data to store the clock tree
      clk: mediatek: mt7988: deduplicate clock gate drivers
      clk: mediatek: mt7988: use driver data to store the clock tree
      clk: mediatek: mt8183: deduplicate clock gate drivers
      clk: mediatek: mt8183: use driver data to store the clock tree
      clk: mediatek: mt8516: deduplicate clock gate drivers
      clk: mediatek: mt8516: use driver data to store the clock tree
      clk: mediatek: mt8518: deduplicate clock gate drivers
      clk: mediatek: mt8518: use driver data to store the clock tree
      clk: mediatek: mt8195: deduplicate clock gate drivers
      clk: mediatek: mt8195: use driver data to store the clock tree
      clk: mediatek: mt8365: deduplicate clock gate drivers
      clk: mediatek: mt8365: use driver data to store the clock tree
      clk: mediatek: mt8512: deduplicate clock gate drivers
      clk: mediatek: mt8512: use driver data to store the clock tree
      clk: mediatek: mt8189: deduplicate clock gate drivers
      clk: mediatek: mt8189: use driver data to store the clock tree
      clk: mediatek: remove the dedicated clock gate code path
      clk: mediatek: get the clock tree from the driver data in mtk_common_clk_init

 drivers/clk/mediatek/clk-mt7622.c | 206 +++++++++++++++-----------------------
 drivers/clk/mediatek/clk-mt7623.c | 115 ++++++++++-----------
 drivers/clk/mediatek/clk-mt7629.c | 165 +++++++++++++++---------------
 drivers/clk/mediatek/clk-mt7981.c | 122 +++++++++++-----------
 drivers/clk/mediatek/clk-mt7986.c |  63 ++++++------
 drivers/clk/mediatek/clk-mt7987.c |  64 ++++++------
 drivers/clk/mediatek/clk-mt7988.c | 135 ++++++++++++-------------
 drivers/clk/mediatek/clk-mt8183.c |  49 ++++-----
 drivers/clk/mediatek/clk-mt8188.c | 163 +++++++++---------------------
 drivers/clk/mediatek/clk-mt8189.c | 101 ++++++++-----------
 drivers/clk/mediatek/clk-mt8195.c |  44 ++++----
 drivers/clk/mediatek/clk-mt8365.c |  43 ++++----
 drivers/clk/mediatek/clk-mt8512.c |  83 +++++++--------
 drivers/clk/mediatek/clk-mt8516.c |  43 ++++----
 drivers/clk/mediatek/clk-mt8518.c |  43 ++++----
 drivers/clk/mediatek/clk-mtk.c    | 116 +--------------------
 drivers/clk/mediatek/clk-mtk.h    |  16 +--
 17 files changed, 620 insertions(+), 951 deletions(-)
---
base-commit: 8713cdfd35c802b4e1849280c84172745604628b
change-id: 20260710-b4-mtk-clk-cleanup-clock-gate-drivers-0b211852ad81

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

