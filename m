Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793D9D711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB81835B3;
	Fri, 19 Dec 2025 00:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NMc5du5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0538D8309A; Fri, 19 Dec 2025 00:24:37 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A9B183106
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c730af8d69so808071a34.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100273; x=1766705073;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8IyDUlmXoCKHa8U5JNuV0xKkT/AGwhd2jT8amyDSPH8=;
 b=NMc5du5xpujr53FAzpR7wGK/KgJ8wiB3L8oPggB0sRbOlMEu7lWXywm8JKjcBm0biY
 dFpGoFHFM5K/HcyvhzSts/1mJA9y6amI2RMUogfLmI4MIccoicaWdWcHcX66gBAiR2V1
 nDImCdSlkde30hdCqcWsB1rdiMzBxUaeSqeLxW3WAOJORjDhykZVJ5Ue4/EVZkKKHUp7
 yQgjkdI+E7pp4ofioSh5YIt69woUPOP/bOcIRQRKtSKaZJz578ZKPp90S43PiBncagf3
 Fns1T3miLc/PcF8dBqW3VNyqqFAQYwgZe6iGYkqSVRVkhKyxDpCLRd+5f9SN6i8znxz+
 P48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100273; x=1766705073;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IyDUlmXoCKHa8U5JNuV0xKkT/AGwhd2jT8amyDSPH8=;
 b=fhKhXtvNQ7p6PJniYzI04+RngDiE3g2jmJ/kUHF96tAdXsvXyNutkibZV4nlwZWl4n
 mwDRf+uSVI2tniMuNwXBT5a5CXYVvobKub9SBnACtrQquomNOwP86o1jpYrJ/RCv5qM+
 lg9E2BEmS0jGkB06QR9JCxT+Hh0A4fav43lC/ECCRuue7eaCNInLZb8KNMgoLjrkF7Ng
 XrU8yLC46FvBu9U5LQqd0cra0/aY99IM7layoq50wH2ycOKzynFQqQ2RSnPQvwueXbH3
 jzOVV2m9+SuVXuUsVKiCm3oaDzYPDs7A5r13BWXgE3kjYKldvwGFDKHOr9hb8381uaFr
 AUnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmC+1jJZJwPokxfb1Vk7gjO5oHn5MSvWAOIKpaS8GCVUmOWrSiRVJSQw3BdCwZn2sY1RbvoyQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywxj9P/JYnMbh52u9UVzmgXIhUGJQun70LxKIpCMI9ej+/OqCfS
 7k4tcjhLE8/2t+YVrP4qpkm23FJuGZ9/QKGzpJwslBKk48Ia6ZGkU3KYugbDdj0DCW4=
X-Gm-Gg: AY/fxX40XPyPab9BaaF3PPVEfe1PEVCN9ifMgpXEABrWvRheRokiUaSv/H2hROjnik4
 7q2zlQpwY/oMhibb7VtQqkXJVoTtIJvAP5x4RtZ8jbGm2K0QxbHsruUajUMLFZ8JkiUZtrzMm9K
 1g1uP65bNnuceS5zS4DwbuIkZXzVU4xdr1VNIH9QnZ923lJSyszDd/1qdBvYB+wtcfRZQ0W9myQ
 klLHIyph96wnVD26r+Sw+jwyxnjqVpcAbi4/N71Kx/dliJpIY6VLx2E4cZhQRq0B/7I1IlkXlYi
 Qvt1j6kAEOEpNdQoENYEXMDQ/Bw7XYMB6CSlCYNpW3/Lh0ai0h+r3Ou7ipGPeEb2z1hkMSAaagb
 ILaHSjiuTJQLEV+XQrxCNr0X5faiUhayUc4lZ5xxZp5jZYzz+5uyuCFGQqwXyZPuQ2BG7od1e1A
 S5Tz+VyZNjKEfjzW8=
X-Google-Smtp-Source: AGHT+IEuj567Y/8goyzkBR7rKbLCeUKkDdtZTJ9SozQX3WtPqSYGXDgT+K2OQnaKmuyxkZ/0gU0K5w==
X-Received: by 2002:a05:6808:191b:b0:450:d471:dce5 with SMTP id
 5614622812f47-457b2102193mr584536b6e.6.1766100272975; 
 Thu, 18 Dec 2025 15:24:32 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:32 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/9] clk: mediatek: mt8365: fix clocks
Date: Thu, 18 Dec 2025 17:23:20 -0600
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02PzU7DMBCEXyXymYWs09DUQoj3QBVy4k27am0Hr
 xuKqr477g+Iwx5mR/ON5qSEEpMoU51UopmFYygCHyo1bG3YELArWulat6ixg2G/A58v1zXPLYx
 8JIEObYOaOjvqTpXolOhqlOT7+qYTfR4KPd+eypOIvdJN9XKH12CTB5cFPDm2mXYgX5yH7W9Zj
 hDHj8MkOZH1MCMgLLHBJbW1W+Dirbffe+4TPQ7Rv6r/G0x1L2n/FrCfUpzJUyiNrq/7lUPXIDZ
 mxku2t0JQQJ6zqWLiDYenQMes1ufzD2/b28s4AQAA
X-Change-ID: 20251218-clk-mtk-mt8365-fixes-81a312e8af28
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=e3Hs6OXfBwpZ8jlyh4EIys1tvd3byqHX/rQlnoE8E9M=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDJdet790jKvefTAW13YtjFccX/6QvGDO7Zw9PcZKbyt3
 LAlTlK8k9GLhYGRi8FETJHljcTNeUl8zdfm3MiYATOIlQlkiphMSk5qckZeapFDUmJlTmZSUape
 cn4uAxenAExh7wL2f1qauzVWL8rbUbejNUcorGr7MY9e2XKLgk5ZhTbdHPF7wge/ltXkF8/YYvj
 YKM3SbY5DgcLmhom1cz8X9m5P7Nu5o8XTobKqPWt92PxHj01isx+J5s69JJgWnPs/UU83xf3n12
 iOWpOGzxMWpQav/J3Huueo3qOCWQVu4Y3r85YFP7SeVRAQaaA/781C022zu1kPRL/Z6rCgTSXhY
 aHk3X/7+E/oyct9chO8fCbBVbuVb79livqPnr1f9ufzfL90yK6i/OGig7ayPxfmKam+aO/kfK7q
 /iytwN+97WD8I7eGmYyX+N9vuO0VEh34686EWbOWZ1iIf1cvcxG4Zxcvca3W9NzeDDW2jH16f0M A
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 19 Dec 2025 00:28:35 +0100
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

There were a number of bugs in the clock definitions for the mt8365
clock drivers. This series aims to fix the obvious issues.

This builds on [1] that implements the clk dump command to inspect the
clock trees at runtime. Using that revealed quite a few mistakes in
the clock definitions.

Additionally, the topckgen-cg hack is removed for mt8365 since it would
require an extra devicetree node using the same address space as the
topckgen node. This would not be accepted upstream in Linux, so we
shouldn't do it in U-Boot either. mt85{12,16,18} also have this hack.
I didn't attempt to remove it from those platforms since I don't have
hardware to test on.

[1]: https://lore.kernel.org/u-boot/20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (9):
      mt8365_evk_defconfig: enable clk command
      clk: mediatek: mt8365: fix missing and out of order clocks
      clk: mediatek: add separate gates_offs for cg gates
      clk: mediatek: fix fixed clock parents
      clk: mediatek: mt8365: fix some clock parents
      clk: mediatek: mt8365: split struct mtk_clk_tree
      clk: mediatek: allow gates in topckgen drivers
      clk: mediatek: mt8365: remove separate topckgen-cg driver
      clk: mediatek: mt8365: fix missing topckgen IDs

 configs/mt8365_evk_defconfig      |   1 +
 drivers/clk/mediatek/clk-mt7622.c |  31 ++--
 drivers/clk/mediatek/clk-mt7623.c |  41 +++---
 drivers/clk/mediatek/clk-mt7629.c |  34 +++--
 drivers/clk/mediatek/clk-mt7981.c |  27 ++--
 drivers/clk/mediatek/clk-mt7986.c |  23 +--
 drivers/clk/mediatek/clk-mt7987.c |  21 +--
 drivers/clk/mediatek/clk-mt7988.c |  37 ++---
 drivers/clk/mediatek/clk-mt8183.c |  14 +-
 drivers/clk/mediatek/clk-mt8365.c | 297 ++++++++++++++++++++++++++++----------
 drivers/clk/mediatek/clk-mt8512.c |  11 +-
 drivers/clk/mediatek/clk-mt8516.c |  14 +-
 drivers/clk/mediatek/clk-mt8518.c |  16 +-
 drivers/clk/mediatek/clk-mtk.c    |  88 ++++++++---
 drivers/clk/mediatek/clk-mtk.h    |   8 +-
 15 files changed, 454 insertions(+), 209 deletions(-)
---
base-commit: 930eff5416ea98ebd09cec73f5d06a7033b4d52e
change-id: 20251218-clk-mtk-mt8365-fixes-81a312e8af28
prerequisite-message-id: <20251210-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-71317e50d414@baylibre.com>
prerequisite-patch-id: 3520ac6a30d21a4efac14c4d2cae0d72912f9f13
prerequisite-change-id: 20251215-clk-mtk-improvements-db0b9d1d3113:v1
prerequisite-patch-id: 2ae6231f7dcfd6fb770d0633c3feb5ee2a3dab1a
prerequisite-patch-id: 3520ac6a30d21a4efac14c4d2cae0d72912f9f13
prerequisite-patch-id: b7eb936e644b8123b484e53d0f3ecae2bdad642a
prerequisite-patch-id: 98d2cd7251129d2e91759a5f18aa10946e465e25
prerequisite-patch-id: 8214f8af75d20b73a605ad78255b21cedffe68b1
prerequisite-patch-id: 539af724f889b136a758a6833dbe4d3eaa986a8b
prerequisite-patch-id: 3330313a7c4178da97b50159ca627aafadfb0049
prerequisite-patch-id: 96f170f2b16aeacc404270b8444dfe5a928f8a93
prerequisite-patch-id: 7379668c38c251dbcd81c4d5b72ba5fdaad91a0d
prerequisite-patch-id: fbe17c1c0d5f18e2a33a8208e63e73292a6b4a5c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

