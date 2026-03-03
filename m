Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71109EB3644
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796AA83F7D;
	Tue,  3 Mar 2026 01:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lk84YCpq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4997883F63; Tue,  3 Mar 2026 01:05:08 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D7280517
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4163a7c7ca5so234791fac.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496301; x=1773101101;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UvpnwV1rkALhOoONp6hhjnwJTJ9ZdqvnLz+XDbGZl3w=;
 b=lk84YCpqHDVVnCQnfocphTgb85Ptke5leBYkG1bT4aJ96DfKL9zoA6xPa2lXBtzUju
 q0GYotPLo1O+g7T1f1uF3FXInddZwNvybHGc9bJbwq4JOVNnhsSt8CDCJUu5kStCnDyN
 JQt1eyYYBXo5aIu06EYBpkEdvUybcS0VrP01C2Yg2Rsv4eTP6jhQ/wmLJRhQQuQRvqiZ
 Iqw1FEzspJryxmP3j8+U6ZZqoynrAh8i0M1Nl5hotBMnURZFQZVLDpAj0yuGIroCTe8y
 GW279CdbU0sEa8QyvARm1PWCo7jjjmNqtA7HVD3Ewbw9QDzItfiT/iEzI4K5iQyrse2b
 oVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496301; x=1773101101;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvpnwV1rkALhOoONp6hhjnwJTJ9ZdqvnLz+XDbGZl3w=;
 b=W3OEhar14owVtBPmQxojru33TfGd81ssxQKPGIyzYLc1wLQmo4j1yUXGp8yWRDsKr3
 hkbsgufVpvYOWU7YqCm0Agr2Ha07KcwvHYVcApl5+qcT6MnX5hvo5lusLK7yvCXFYRA9
 67ZDrlnshP6eaxFhcFjx/ncIC3eKGF6CuLoYt57ExPdHeP4Pi8mfOK3kN5LryCriNEwy
 xy03axLh7uawBPV8L7BHByBjg60xFzpJnwIeK5WgHo3h84PzfYoQU5SpJF4Ng6EILEyu
 DGezevudPy+5+lYJ8znYDNJonSgnbTOKRIT2Jp1MdtqcCJtvsuR5j7d31PQd4c5eujiF
 ahbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKHjWoArReQd3Xe2il5sMEPi+JBmeUWqyztIIbOdZ4Udhl2Wac+NeBOx601J0YtHrfT8mQ9hs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2aKyYRK1/FpL5d1YD8BsoWfaokqv59VlN7l5k1eitJ/UDMze+
 LlmygQYCvEKNPhYJT+Wce3ZkN/hxVVmDiNrXu5pzHdF8HL19aw5zjY7h90gL1ZIwknI=
X-Gm-Gg: ATEYQzx/4Xw+pCgBLU9XTbQvbbWIlzMcxIUPwCiz1UEYiCAKUVfdGTVn8j6bfHJb6aY
 7MM2Vtfmmjz8zt8d/G7444CiUDT2uzmf93PJ6F0Iy6j4Uzez9sxSwULv/I01zuexn2fwXM7UKzP
 lHj59ga0O1K7JVjwub2FYZZAmY5o+vIPlbjBBTGZcwfHNHvtkcLXCt5Eh/hydnjPzDw7CtESIMd
 +IP43MJNirPzP6dY6dxL5STLsAARB2TkJ3Tw7c5GR6xx7BWSD4UkLcZCtgqe24kx+8OoTP6WoPC
 Cu7oYWoWcB7GVWmkCBV2ix0pZOo2L5R6pPcAOSbyxBmDw9/HXSSyURjnaQya3uh8gvewwAVFPCX
 ssQoaL5WPyPMs8ZOGDhvCf8TeR/VaPec6OBBdKtNQGpkX1Ps3C8WLL/xPsONkSC96EZXTVWb41a
 vCd1fCyRMCluZs3zduLJU/e1q2uFdS
X-Received: by 2002:a05:6870:b1c2:b0:3e8:98e4:56d with SMTP id
 586e51a60fabf-4162704275amr8164598fac.41.1772496301317; 
 Mon, 02 Mar 2026 16:05:01 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/14] clk: mediatek: unify mux clocks
Date: Mon, 02 Mar 2026 18:03:09 -0600
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOwW6DMAxAfwXlPG8hMNqiatp/TD04wWERJGFJQ
 KCq/76USr30+Cz7PV9ZpGAosra4skCLica7DOVbwdQvup7AdJmZ4KLhFRegxgFsGmB2Rm9g5xU
 mDORShFLq6hMJpeac5fspkDbr7v65PDjQ35wT6TFklmLEPdEW52fhbrfpWB5POebVEGGpgIOqj
 6TyRl3r7lviNhoZ6F15+3WPvaqEqJ7PBrJ+oR3lNmGMsCYcQY/Yw1JmOR46dTpIJZqGv8olxnz
 srTWpLXwwvXEfjtbELrfbPyZ38P5CAQAA
X-Change-ID: 20260302-clk-mtk-unify-mux-parents-1bf35aeabf00
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3678; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=6iab5LkIYu6QqRsZJyF3OHb+cIcN9XcvHsQ1rEelhlU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiVJ5/N18lI5rrOPFnxcYUGhc8qR/+nTGd29R
 +Cmsbr7ucCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlSRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1HEH/RZd3JHGLuRs1lg8RC9lOWyrBYpkgkIbBJ+ehLv
 8/6jRQRzqAeipuZCFOFBI/OUVfffginqTOtZtbS1vL5wnpp/s9ONks0wx1F6H5xpRMEYTc9tkXA
 +U6RnqBX4/Pqv8Em/iPjI+RKYQvNDsfMgYy4yzYqgKo/CUuwvVN4VpdqgN/8xaavRVU8Yr76MQP
 cPHh3clu3hHQGDK2bfHi4T3yR9p5mPyU8/HoIzL6YsKjIMrNU8wHVjpbW+5EFbjL54NhlLe4jYU
 oxTIb6jguJFfoQ39SHiEBNTLdzdWr0Srq9VFMc6FqaarQYXDXscMF3xlUki6tqxVPEU65Z7LgWy
 LbVg=
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

The MediaTek clock driver currently have two ways to indicate the parent
tree that contains the parent clock. This adds to code complexity and
makes it more difficult to know the "right thing" to do in new drivers.

The plan here is to convert all mux clocks to use the more robust option
of using struct mtk_parent to specify parent clocks. Then we can remove
dead and duplicate code and macros.

The conversion to the static const struct mtk_parent arrays was done
by script to minimize the chance of error (and save time).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (14):
      clk: mediatek: move common PARENT macros to header
      clk: mediatek: mt7622: convert to struct mtk_parent
      clk: mediatek: mt7981: convert to struct mtk_parent
      clk: mediatek: mt7987: convert to struct mtk_parent
      clk: mediatek: mt7988: convert to struct mtk_parent
      clk: mediatek: mt8183: convert to struct mtk_parent
      clk: mediatek: mt8188: convert to struct mtk_parent
      clk: mediatek: mt8195: convert to struct mtk_parent
      clk: mediatek: mt8365: convert to struct mtk_parent
      clk: mediatek: mt8512: convert to struct mtk_parent
      clk: mediatek: mt8516: convert to struct mtk_parent
      clk: mediatek: mt8518: convert to struct mtk_parent
      clk: mediatek: remove CLK_PARENT_MIXED flag
      clk: mediatek: refactor duplicate *_mux_get_rate()

 drivers/clk/mediatek/clk-mt7622.c |   96 +-
 drivers/clk/mediatek/clk-mt7623.c |  153 ++-
 drivers/clk/mediatek/clk-mt7629.c |   75 +-
 drivers/clk/mediatek/clk-mt7981.c |  236 +++--
 drivers/clk/mediatek/clk-mt7986.c |   15 +-
 drivers/clk/mediatek/clk-mt7987.c |   79 +-
 drivers/clk/mediatek/clk-mt7988.c |   83 +-
 drivers/clk/mediatek/clk-mt8183.c |  584 +++++------
 drivers/clk/mediatek/clk-mt8188.c | 1522 +++++++++++++--------------
 drivers/clk/mediatek/clk-mt8189.c |   16 +-
 drivers/clk/mediatek/clk-mt8195.c | 1364 ++++++++++++------------
 drivers/clk/mediatek/clk-mt8365.c |  450 ++++----
 drivers/clk/mediatek/clk-mt8512.c |  620 +++++------
 drivers/clk/mediatek/clk-mt8516.c |  704 ++++++-------
 drivers/clk/mediatek/clk-mt8518.c | 2088 ++++++++++++++++++-------------------
 drivers/clk/mediatek/clk-mtk.c    |  104 +-
 drivers/clk/mediatek/clk-mtk.h    |   59 +-
 17 files changed, 4121 insertions(+), 4127 deletions(-)
---
base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
change-id: 20260302-clk-mtk-unify-mux-parents-1bf35aeabf00
prerequisite-message-id: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
prerequisite-patch-id: 81f2dd4fd7c1632736c08180d6b9f6aef5fe1e7f
prerequisite-patch-id: 0414664c8d24f8303d238aa1c4389072ba9f8613
prerequisite-patch-id: b63492590bec532b0347be3b495cd1779b0ad3ce
prerequisite-patch-id: 9e03fea677d2d9b5ae6860e700f62b27db270e64
prerequisite-patch-id: 3d5661f9e55292a30f57617848a7b10e67844402
prerequisite-patch-id: ccbc73b2bc1dc41beb295604088d63773cea15ef
prerequisite-patch-id: aa76b6b028374f20551955eafe56a1e0c1daa75d
prerequisite-message-id: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
prerequisite-patch-id: 15ac11765ddddcf378e0e227a9fb5876636aa8e6
prerequisite-patch-id: 90b4781a99ea5eb40eb6c943dee86dd8a9fabe06
prerequisite-patch-id: 80d270c12e6eb32a3ba7898566022bb2be3f584c
prerequisite-patch-id: 7c5b9d822900b1a91e772e55561fcb093a9387e2
prerequisite-patch-id: 5a520115a1494b9d6ff6190b7209816f7c3aa4e0
prerequisite-patch-id: 7e30fd6d0049029a97e21473932bfde6abfc584b
prerequisite-patch-id: 0700411359ab89ebd24c4c3d17a5864e41289547

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

