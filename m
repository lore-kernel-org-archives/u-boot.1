Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B34C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C8484A73;
	Fri, 10 Jul 2026 20:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="f2zaMhUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F3A84AA8; Fri, 10 Jul 2026 20:59:13 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96631849BA
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-44cc65b0a7fso2013370fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709949; x=1784314749; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lcZRodWh7+qJtlkKyQgU8rhfyxZHHX2m2oDLAmKOMmM=;
 b=f2zaMhUBnHbeauVslh2JEOuuOTWEMUZNk5lDJDRAxlpsqPy6legFE2MPvYA+eM9mw0
 gvGDPmK/1T/xckPpgWDFZTCl6IyDVlt6thjnD3UhFerzodXm3+rhwhGteiJQwb5tJnVC
 P/2G9viMX/KKUSlMOkVqX9L9pT13qFHsVNxHn8t+6odAbEI87GUY9xywFy1YltI6EL39
 ZxCVDBA7N7PCXCfX9JoTiUgfkatrs8ohZwSVSVEXxO7Hy39yLSjvQzfKmhgHWvRIBWGE
 J/c2dhpgkW8Zp1+E4TdmptP9I8qlUuVuc3yKGf3tkIDQ4MD9vMU6i82AZSVEEOKkQVoc
 +AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709949; x=1784314749;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lcZRodWh7+qJtlkKyQgU8rhfyxZHHX2m2oDLAmKOMmM=;
 b=JU2XQ2ogA0+ebnS9VEt3/t9UAor6+cnB3RrQTVgQOG33n4wQW3iXV6KvEbjk22eaDw
 5ByyMKe95qxr7j5q/C8Ug81KBR2TSV8xLjc2w24krjVlvFZppXuzIMLPlZQmtM9H8yZ8
 rsoklrL8z1ulqKwTUL/PvWgbT/ZFe3Dh75TRzHgVOkH4COrXXMzz9DvCOcQ2SDh8J11t
 g1R3yuTvuAtkhrY7OCoRSkBvGH4fl34a4f+ZcUbFl2/nORrmdhPfOQN+yt/trlxlzKnN
 edgSCY7TEwIBm8FpiiND9NXFna9aP/6Tqx3LtbTIIF0hETY8spwhua+OkaTZGddvugrR
 WPoQ==
X-Gm-Message-State: AOJu0YyhziuTD2lB3AE5gxihENQnF2GgPYAwWiHm+i/LBpk7Wt+hS8B7
 L6nfX/6XVjro1ynf7p7JkY9PzmV61MrsExjS7FHHJEBZFeOlPXxLI65U5lBiMHYRm+13M5kI5Lg
 ja36i
X-Gm-Gg: AfdE7cloq3SBqO5bHvcQQdFA6pZydohoztoJI8NA4HNuFetdl4QjDeMk8tn8pHNNPR5
 fLtZTrcCgJ/BEZlRrp4WZ1YbZ/Ieu7+2l+9IVmQ6Y4QII1IHrMP0Z80g4Svyu7PWQnW4XMGLDGS
 5DCz6iCh35GVTkkOZ1nP5Gm0x2UWtEZbybykd1froZw8oL6k1PNkfrIugpUwhQqmX3QR9/4ItT6
 6oUMUG9MYK2CKcCwzUnGu4cwGxvVkaD09TmIXavdXLE6QsucJdDXr1uAEtnmbPeapfJj7hQ8QHg
 XttAeaYJPuKey2cY9Ctwz2qL3SkWYANEJu7cl26kD4mrH9FcEahd2Kfmw6awZsMaVAty4fJbiqv
 dyWTzOjx5nv84SfWvu+xHq01zT6bcZS6PgfWfw3ikZU5ijvJMRMe2IMDMOblqxFs951lV14As9I
 nSldN7mkf2OdlLskaW
X-Received: by 2002:a05:6871:5210:b0:43b:6d2d:202a with SMTP id
 586e51a60fabf-451bac7cab8mr2402515fac.5.1783709949240; 
 Fri, 10 Jul 2026 11:59:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 00/24] clk: mediatek: more clock parent improvements
Date: Fri, 10 Jul 2026 13:56:16 -0500
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBREr0K69ptSoYgr72FYQPnIF0pJW4iEc
 HcLxr3LN5nMm5U5tISO3aKVWZzJkRkCiFPEVFsOTwSqAzPBheQZl6B9B6rvYCwtDh56Y7ppBNK
 jNTPqEDm4xnEieZlfUDUsDI0WG3ofkkfxZTdVL1R+X94bLTlv7HK8mOO99xNm/wjnGDjItBaJU
 rxOZX6vyqWnyuJZGc2Kbds+I6IMaekAAAA=
X-Change-ID: 20260706-mtk-clk-parent-lookup-improvements-811460a93ecf
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4245; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TBjVgd4haGeD/NhKQVLEov3ZQxdlIQFtDUPmj/Hdy7A=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUBVwe4ZyAhvuVbfT0UR94QAPUObXpZtSXuz2
 T4iOTyYBm6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAVRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aa2gH/3x7vqmt1l37yNM1fIHWweOeo9jpOP+MGFUE/9A
 P9tesQQme192fpyyE/FN7ZoWfDoUOVzNT+bZhlkJ5ljzHX0H31kHr0pSNzSVtAsOgNQfCAg/x3Q
 z/5+PmXwKhzNo14v06PlMFf7KnuXrDSIc4r/LAlula5D2CIJS7KeDF2Mwm8YtmrxNxVXBz29/H5
 33Btp3aeb837Nk+iMndhHfO+Pa9cQCk/7Ehyf5deTuo7sxiTHaeuKDvFcUj5S9tB6dfK6JbgidA
 qNHEil80XczTLLHPrlnCy5pYroQfT4pYyvwa5nRQsk5ZTKlLeAgsPdL8J94/LfmUMg3daRwhP3i
 YtTE=
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

This is the start of another wave of Mediatek clock driver improvements
with the aim to simplify things.

This series replaces complex rules about clock tree ancestor relations
used to look up parent clocks with a simple table to register clock
trees that provide a certain parent type.

Now, clock trees that contain parent clocks just need to populate the
type field with the appropriate type and they will be registered during
driver init. Then we can just look up the clock tree that contains a
parent clock from this table at runtime without having to walk ancestors
in the clock tree.

This is done in phases to break things down into logical components:
* First patch is something that was missed in earlier cleanups where
  all clocks now have a parent flag set rather than relying on implicit
  parent relationships from the clock tree structure itself.
* The next patch adds the infrastructure to register clock trees with
  a specific parent type.
* Then there is a group of patches to add the required info to each
  chip-specific clock trees so that they actually get registered.
* The next patch then replaces all of the lookups for parent clocks to
  use the new table-based mechanism.
* Then the rest of the patches are removing code that is no longer used
  after the previous changes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Make the clock parent providers bind on probe.
- Moved removing unused `int ret;` to the correct patch.
- Link to v1: https://patch.msgid.link/20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com

---
David Lechner (24):
      clk: mediatek: mt7622: set parent flag for GATE_APMIXED()
      clk: mediatek: add registration function for clock tree types
      clk: mediaTek: mt7622: add clock tree type flags
      clk: mediaTek: mt7623: add clock tree type flags
      clk: mediaTek: mt7629: add clock tree type flags
      clk: mediaTek: mt7981: add clock tree type flags
      clk: mediaTek: mt7986: add clock tree type flags
      clk: mediaTek: mt7987: add clock tree type flags
      clk: mediaTek: mt7988: add clock tree type flags
      clk: mediaTek: mt8183: add clock tree type flags
      clk: mediaTek: mt8188: add clock tree type flags
      clk: mediaTek: mt8189: add clock tree type flags
      clk: mediaTek: mt8195: add clock tree type flags
      clk: mediaTek: mt8365: add clock tree type flags
      clk: mediaTek: mt8512: add clock tree type flags
      clk: mediaTek: mt8516: add clock tree type flags
      clk: mediaTek: mt8518: add clock tree type flags
      clk: mediatek: use registered provider for parent lookup
      clk: mediatek: drop parent udevice field
      clk: mediatek: remove mtk_common_clk_infrasys_init()
      arm: dts: mt7981: remove clock-parent properties
      arm: dts: mt7986: remove clock-parent properties
      arm: dts: mt7988: remove clock-parent properties
      clk: mediatek: mt7629: remove mt7629_peri_clk_tree

 arch/arm/dts/mt7981.dtsi          |   3 -
 arch/arm/dts/mt7986.dtsi          |   3 -
 arch/arm/dts/mt7988.dtsi          |  12 ---
 drivers/clk/mediatek/clk-mt7622.c |  33 ++++---
 drivers/clk/mediatek/clk-mt7623.c |   6 +-
 drivers/clk/mediatek/clk-mt7629.c |  30 +++----
 drivers/clk/mediatek/clk-mt7981.c |  19 +++-
 drivers/clk/mediatek/clk-mt7986.c |  15 +++-
 drivers/clk/mediatek/clk-mt7987.c |  15 +++-
 drivers/clk/mediatek/clk-mt7988.c |  22 +++--
 drivers/clk/mediatek/clk-mt8183.c |  24 +++--
 drivers/clk/mediatek/clk-mt8188.c |   4 +
 drivers/clk/mediatek/clk-mt8189.c |  16 +++-
 drivers/clk/mediatek/clk-mt8195.c |   4 +
 drivers/clk/mediatek/clk-mt8365.c |   4 +
 drivers/clk/mediatek/clk-mt8512.c |  24 +++--
 drivers/clk/mediatek/clk-mt8516.c |  24 +++--
 drivers/clk/mediatek/clk-mt8518.c |  24 +++--
 drivers/clk/mediatek/clk-mtk.c    | 184 ++++++++++++++++----------------------
 drivers/clk/mediatek/clk-mtk.h    |  21 ++++-
 20 files changed, 292 insertions(+), 195 deletions(-)
---
base-commit: f1d4a6f0c80ee17081131b706f48d00a5c8586ea
change-id: 20260706-mtk-clk-parent-lookup-improvements-811460a93ecf

Best regards,
--  
David Lechner <dlechner@baylibre.com>

