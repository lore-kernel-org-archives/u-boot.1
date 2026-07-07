Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54098C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66BDB84994;
	Tue,  7 Jul 2026 17:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="jh50yC7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367238497A; Tue,  7 Jul 2026 17:10:28 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7EA84942
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-44865cf3010so2500399fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437024; x=1784041824; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U7K5Dbz0nL2jDbXBhSohpDiKk7eMFxRFJvYZuCdxSt8=;
 b=jh50yC7wDHAKH98IzDCdU4vv7m7D2PYbuX894s4YyMEO5ypJJJqdejjVhZ4TCELnIN
 uBwzRpeW38asemS8xJAXp/b8cuU+QclBoIzp3cN2IFr3F+m3oO2AXxLhbHjoWHBEA8lW
 jYa2H0ZezpTIRWjYwYeqjUufDCmKP+wAgBhicq9yl6rvUwaOmMt7S97AsKRerDMuBYVK
 yoHUlsq0M+9ivEV2u6XEcyUTBisnzzUPbtnfP3PvRyussf5dFMsGbJ3hUQaq44a+YLn7
 RY3BtGpC7+hmcNwps56OkbFZCjtN7XeTTa5v6ACYPjfvPK/pEVBTOU6Qux1QpCQSz3gG
 7WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437024; x=1784041824;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7K5Dbz0nL2jDbXBhSohpDiKk7eMFxRFJvYZuCdxSt8=;
 b=jeicae32FdsGAhp/xGt1GRcp8Y9OZWF1EJcivYYZ80rolDCHKb6JKX7fum7O9VAg5p
 YU4K8PGDGb7MzsSIKYo/2cJtPc7uaDpHZqENqsuG0M50zkFKxvGO8DHjdOsNFU4z4B6Z
 XkHdjauKOtKm/JwTTpwIQumGO0BBGb/pZFNhdpTDzzIue0HTJ+MS9bVwnM4XYIisOq7Z
 ulbexNYER2/YJScDbIPaI1HRO49cE5COi+c/5q0Oz6b6NzYeOIiOlYuM0bvOM25wkJs8
 97Mp51WBe5EWkORiIC6Pc4ZzcAU1bWRwa3b/RxbF8CHVzNfAnh1vm3bQ3mGmdpJvd/HA
 jNvA==
X-Gm-Message-State: AOJu0Yyto8mg4r66TFN3R+hI1NK3vS3EIATFjiqMGh5HPZHXpNrmKTtZ
 v/b1o8AhfW/r3ZNWEKYuH3HdvJq6ijRX7Ioz2l85j7ErSdiIOX2WVAedBC39uimo/jk=
X-Gm-Gg: AfdE7ckioSPwrrJvUa2E7tIqg298sQUG/WDE26JFk420JK+m5cCnUju6kwGIsTB+uoF
 02inN1L6DV4avudA/XQLF3l7lVUx4ENoKVguEUs20qZ7C7kCKbMaS26vZ1moBz40krBy8U+cIDc
 EeGMgrbFBXTVKZY46IBHKHIrVr3CkPcq3xmrZplCtH6QKQAMm0osKx9vG0md2cfi5L9SpJWtmmC
 UDmlFCtTq5izA+3+SSEzKrvlJprRSUJr91ek76/ZPp1si8m0rzOxg34ujctYvXCJ83m+zOvf05f
 bq/zCLja9+r4xO9dhhLZIVdUzZ8oppQgfl27kzC9ivCc2/SCW3r5oChsi4HPHkHEMAPytvWhvCE
 zAe+9NxfAuXSY5W32zTs6Hi5uOUXG4BoQwhuI7vjkK1XMxw0PAmPiItRAhUbHolTQ3LD5vZwFUr
 ctHILdDY4Bo8rw4JK/YA==
X-Received: by 2002:a05:6870:2186:b0:448:558c:d830 with SMTP id
 586e51a60fabf-45105e0215bmr3560156fac.41.1783437024519; 
 Tue, 07 Jul 2026 08:10:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/24] clk: mediatek: more clock parent improvements
Date: Tue, 07 Jul 2026 10:07:20 -0500
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNSw7CMAxF0a1UHmMpKSh8toI6CMEFk+YjJ62Qq
 u6dAMPzBvetUEiYCly6FYQWLpxig9514J42Pgj53gy96o06KoOhenSTx2yFYsUpJT9n5JAlLRT
 aVPCk9cEoe96TG6GFstDI79/Jdfi7zLcXufotw7Z9AI4t/FaGAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3994; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=aJs9e0rqbHnDFEKlRhTKER9DDk3o78lg4l017IJ4pzk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRYvVB00/CdslNZkleZG0DVdrPVfbLUzvNOdQ
 6x/vFs3tI6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WLxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqXIH/j05s23d7CH/G56Koto2qECyL4xsQqoiNi2et+3
 6wrVonhHo7E9zfcW2rOHBcs1MmfXaUAoxEWo5yISeGwkpE+CyFdNxw0V1rA12GO+nOjyN7os7ML
 aaLgbScR2cx3U/M5PAdy0NBDo7Urby65+dIUhZshLDS2G+g+crAWUsrHRsTjgrsZtnXvDUjXAOo
 U8CRs+t3xHihQMSRZfHKYivS5Sx4+gc0+7aCTrEO7ZdlZONuja5/p4xbxjZGl3wtT66G9UWZjR+
 CdUclo8djxnk0rRkJUtUz6eIpAoTtn66JE3HAU3WNMX329RbYtWhT133eq6w49D0Q+7geED6+67
 7IoA=
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
 drivers/clk/mediatek/clk-mt7622.c |  31 ++++---
 drivers/clk/mediatek/clk-mt7623.c |   4 +-
 drivers/clk/mediatek/clk-mt7629.c |  28 +++---
 drivers/clk/mediatek/clk-mt7981.c |  16 +++-
 drivers/clk/mediatek/clk-mt7986.c |  12 ++-
 drivers/clk/mediatek/clk-mt7987.c |  12 ++-
 drivers/clk/mediatek/clk-mt7988.c |  19 +++--
 drivers/clk/mediatek/clk-mt8183.c |  22 +++--
 drivers/clk/mediatek/clk-mt8188.c |   2 +
 drivers/clk/mediatek/clk-mt8189.c |  13 ++-
 drivers/clk/mediatek/clk-mt8195.c |   2 +
 drivers/clk/mediatek/clk-mt8365.c |   2 +
 drivers/clk/mediatek/clk-mt8512.c |  22 +++--
 drivers/clk/mediatek/clk-mt8516.c |  22 +++--
 drivers/clk/mediatek/clk-mt8518.c |  22 +++--
 drivers/clk/mediatek/clk-mtk.c    | 173 ++++++++++++++------------------------
 drivers/clk/mediatek/clk-mtk.h    |  15 +++-
 20 files changed, 240 insertions(+), 195 deletions(-)
---
base-commit: 6a320da6ed11817859c5fa5267094907653405b7
change-id: 20260706-mtk-clk-parent-lookup-improvements-811460a93ecf

Best regards,
--  
David Lechner <dlechner@baylibre.com>

