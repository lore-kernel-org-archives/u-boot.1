Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD32C982D1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACD4380FAA;
	Thu, 17 Sep 2026 12:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0eCTAVGjT-uY; Thu, 17 Sep 2026 12:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E636380FA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649452;
	b=F0k0VVlO/6hGfsTHu3gDNZvm3AgXNmRAz9ZDlp4pr0hLy2ARL/YoDErbjaNdYBQeVz2g
	 wS9ejVqkPdNfnwUu2SLwkkxcEHzKf9lozvZeKN6VktIx1sMMhT4OZIzO7b/tC5zA0bAX4
	 x5G1JY7/qRODvZ/f1JKtA3qtA3dHDQI8PgqsRRwarWWFYgb0hJwnB7q91LT6+19BJdAoQ
	 d8x5ANTayj9oUtaaOUW56JgQOdkqZ+e6ndXFtsm8JfIakmEcy6Ec7JuTzfeMLAwDfHyUE
	 f6P2qsUs/sYjksZ9CNFm1zBXVdpBGlBDD6EuuYrLphz8qKQ3rtJwpPBZHkrn7Cl/wuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649452;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=skirid6GpvToEG31fYBI9dNXv/UY1p1wVWxlrOIVhtU=;
	b=a5Sxlz6Lj6q9/+R7SHWT056Y/QnF8yoCUN+qrXYOf6qrNUbWUFZd/RNvZjUXbI5gzn/U
	 DkxNR6VBXLzGQWzGCCIJNfX59Kuq3LMZVZ0KtWj0WZ2UMekaEmSQIADOMV6K7LDA3E4OW
	 JdM/TIAJzMj0g49AhY/CQMaPSR1aLIt7ETUm+M+WrSIXLnXl8+pDbNgXjyFQ9dy3Cw4by
	 VLe2dPg/8icIp9A2+Es1TrFh5K1yugLd6FiMn7+1CnzhpHG9iiWcCy7pIrCUiHI7YtweN
	 3p9L8Czbw9PpwkOANU1U/J3t67yplOGtRnQJRYkF5pCQ6LgSQfhHxVEdP0EF7tmagtA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649452;
	bh=skirid6GpvToEG31fYBI9dNXv/UY1p1wVWxlrOIVhtU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v3Ys0RraF0RrL8PzVT6yUyx628QdhP3Rks4MaOZsOg5WJrJpGpvRzp6FXfw2K7Aah
	 2UCjDmBvnmZCahZ7zkOGuJ/fgeRbSlBHGfkFvEd7r2EbAyVTAF2t24b/slXqb4NxoO
	 EngE4ib1a+WXO3CnMvwVrfiVTLCpabSs2uhEgazk0ucbF1ibF8oDlzzpg//+g4fY7W
	 hbK7AW0G4U9feKtCZqY3oXShVHyaYMUQz36/EB9v7qsANhxyVqc4PFYVKAMRxcpb7X
	 L8MQ0mLtWNTl47Vtm+ozE2UVc8QSD0F3SQb0I734Odu0dnA8sTbOfXgeTjAqMt5q80
	 C15rgeEQymQ5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E636380FA6;
	Thu, 17 Sep 2026 12:50:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A2F053AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0AE840360
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hO2Lv9S7mOSL for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7121540346
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649450;
 b=kZKlvGVhHAPkcuJM5nRWEmM5vDPmo5b40Tp/IkSh/1jzJzOLnTvifIvNO/ngKE2haPSV
 TLztiPZU48TjCj+Z8IDX2CZCQTvCoK+O+tmct6j6xqrckg/4bgr4OKBII97mvD3Z2hwhD
 liblRVPCW7jaogLAjsnuJ6SSQVNdiWsnQ70xlEQFXCi5Boj2kFZABR8txoHvLTLavXwDD
 fI57OYLbjMxG2aqG99s26FLdOVf7o88k2m5VMN4b8xTqLiNdpy/khuRwB/hXbMr//Hjde
 gynp3FlR6kCM6hRetiwS3QhK0M5tlvkl0DGMJ4Bzyoppk5jRoiTfedZMUztQD5rpDyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649450;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=skirid6GpvToEG31fYBI9dNXv/UY1p1wVWxlrOIVhtU=;
 b=sCoz2dvF8ZbXgscyUQnqeJyVqgLRrSaZWuebrISBVJnFdDXLi1+s+iGnrHm6kei+UJgM
 jhhbZ4tzdqB0B6tCFZ+vwa3VdJ4RcqJmYfNdnfI6aVBbUSMrA89gePxgXuzM4z5lvE+1C
 iUy2BNYuLWmwC6JhDi07lrRlfjbhEQas1v3djxk0DnmJizDQFyb/a/smvuKFt4s7xgwEl
 cGMHaTMjHWl0miv2smhYJAbT+8FfM1j7gddgSgA+hTrL6NSiD40s16bHQaiBEgoLTrIYG
 /0247iZQOyI0LUI9ojY+j+U8sOWZR7cO+eCsSz42cc5NxHpLtsrzPmUoh1ko/mL1WNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=b2f29ve3; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=b2f29ve3
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7121540346
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:47 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso6864675e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649445; x=1790254245;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=skirid6GpvToEG31fYBI9dNXv/UY1p1wVWxlrOIVhtU=;
 b=b2f29ve3mFx7IxXwFcf33w7QY3WQqeS0hs2O9opmJ5UiFQXU8OVjL0fQqLuQ0AKlhI
 kyW6AnnJkz4m3Xr/Zn7xACQsC75FG6hN19J2BUHygv3rxgowAm5YmKyDdS/8MThnYknA
 LIbPdrxEdT3M9VqCcaHGssEyohnuTMcwLiLHpH3eZXiSfB+TUHnwgFJ4/65cOcqpLc/Q
 b1ziww0TpRN7qUFV7d81Yzsi0dUHXP9XNJxyyHqoH46eLtepkFnnLtS6OZzuWkX2A5Iy
 NeFRRT2la2u4LEDeGQ4n0CMkwy2rXwTiN6Wmaj77O806JOfTvv7P0PEwYEqaQDa8r5Hx
 5t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649445; x=1790254245;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=skirid6GpvToEG31fYBI9dNXv/UY1p1wVWxlrOIVhtU=;
 b=0Efe/e/7emcYEiC2lRYl2pIceE32/4mhcL3pJ6/rv0QXaPdZwhp0yGIH/3gp58Lojl
 qxDbuK/Ja2y7D+/xddlMLFqFdGsNm1scrj1R2se/quTBjwZIfWqgyQ/528g1FrLhGgI+
 e5vrbHjhX5zzXIV6qUmGMQmwK9EtQw4hwN2u1ZM3kG7/Uv50CccTYlMio0EMQ7mwnRFN
 voOjLqIDUDuFcXZUTQDjvQFLncK6X20oizMFiOaApwcT79VNe+1r7VE2/6doBk03R0zi
 0/nJgY3L3zWbdrshSrbQti1fRmpYk3v4/MoPlFlfd4mR5QiqhZcChEBudo5Aa65aqCUV
 mCfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzse1oyxaFiulWWkHa0LtAdl5TKcWh/EKrjTKg09xwJldZOwTkQJnrj/llvFCexiOdN7Dx9qQA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lzNbDmbKZGJrxJzcLCzIiqzIqmbz/HSjlXz5ZZ+xp8k7b0ZmRi
 WhhzDZNX6vughVAh8NmUOejqSzpvSkKKckqugqtTUi1hSBucvKLG4eJzgrSM7oIHtJo=
X-Gm-Gg: AYBFou0S6lqS1Zr48pKERYFBPCmoD79kBFqVG1sWovsU2JdKNB7+oOp+H33Vnf4/sHd
 tRp58j9wj8lqL1m3cF3nrcVFw4iCHBgfAZAaBr3im0byqoKrz9YQADAdhoDsbZz+PyNE5NUEXnK
 1XTCB7p/Oo1cnwDwd6dF1O4+awj85KiqVxVl6MlKQVz4586j5alacezxoIa6lS+AL+9gwBTtokS
 tUizg4MCyTTNuBuix2H+I+F8HIgAxCnzgWkSzwcunAGjV3DH6u0ehfpXOWz6zf+WwhAOgDpMfGE
 12odLHxES/CBOFEnZExQc19dkqgw+WqvGQ/lgzImuVQ/OhjaniafgPoH/+v30dy8Fix44dNgKUe
 tEuYMAOU/z8YtVYXk+Z/JqHQwfOOtw2KknTLURBbTsDbfl/85j/VVomRWuAHgBh1ubO0YacFwGd
 1mTYVqALc7H1MSrOosGZp0uJLUy/QGgKajdGvZLJQ4x3zR1xPmnNXqoBBlyksO1+zj1wVMX4bx5
 9Kk5RFcPnDjLljiT1xu58F4ENqMGfJuMN5NC0lsOdotfGnwtYLZKlX16HmWbR2Y0Z5HILyyoW71
 QPWz1+n9hIJSXE3lrW45yNIZBEfapVNpHRR/M/ewCyLT3IkY2IV/KJE=
X-Received: by 2002:a05:600c:3b20:b0:49d:17d8:abec with SMTP id
 5b1f17b1804b1-49eb7325335mr78245115e9.21.1789649445490; 
 Thu, 17 Sep 2026 05:50:45 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:44 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 00/11] clk: mediatek: code cleanup
Date: Thu, 17 Sep 2026 14:51:55 +0200
Message-Id: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWdsEGoLBqxAW7fRXB6SSDhATw
 t2tuPwW7+2kSAKlW7FTwiYq75hRXQrip4sPGAnZZEvblG11NfwazYQgbsGYARfXWQ188JYd13X
 jKbdzwl0+57fr/9bVD+DlN6Pj+ALyVtnHeQAAAA==
X-Change-ID: 20260917-clk-mediatek-cleanups-ebdb2cac446b
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

This series adds more code cleanup in the MediaTek clocks drivers.

- add missing static identifier to MT8188 clock tree before refactoring
  them using GATE_CLK_TREE (see below)

- MT8189 already defines GATE_CLK_TREE to factor the boilerplate
  needed to define a mtk_clk_tree. Move the macro to clk-mtk.h so it
  can be shared by other drivers, turning 150 lines of open-coded
  clock trees into 26.

- As a leftover from the previous cleanup, some drivers still register
  separate drivers for clk_topckgen and the other clock gates. Merge
  these into a single driver where applicable.

The series deliberately only touches the MT8xxx drivers: they are the
ones the Genio boards are based on, so they are the ones we can
actually test. The MT76xx/MT79xx drivers show the same patterns
(open-coded clock trees, separate topckgen and clock gate drivers),
but as we have no way to test them here, they are left for a
follow-up.

Build tested with the command:

❯ ./tools/buildman/buildman -o /tmp/b -b b4/clk-mediatek-cleanups -CveW --boards mt8183_pumpkin,mt8370_genio_510_evk,mt8390_genio_700_evk,mt8371_genio_520_evk,mt8391_genio_720_evk,mt8395_genio_1200_evk,mt8365_evk,mt8366_genio_360_evk,mt8512_bm1_emmc,mt8516_pumpkin,mt8518_ap1_emmc
Building 13 commits for 11 boards (11 threads, 2 jobs per thread)
  143    0    0 /143
Completed: 143 total built

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (11):
      clk: mediatek: mt8188: make the clock trees static
      clk: mediatek: add a helper to declare gate-only clock trees
      clk: mediatek: use MTK_GATE_CLK_TREE() for the gate-only clock trees
      clk: mediatek: mt8183: merge the clock drivers into a single driver
      clk: mediatek: mt8188: merge the clock drivers into a single driver
      clk: mediatek: mt8189: merge the clock drivers into a single driver
      clk: mediatek: mt8195: merge the clock drivers into a single driver
      clk: mediatek: mt8365: merge the clock drivers into a single driver
      clk: mediatek: mt8512: merge the clock drivers into a single driver
      clk: mediatek: mt8516: merge the clock drivers into a single driver
      clk: mediatek: mt8518: merge the clock drivers into a single driver

 drivers/clk/mediatek/clk-mt8183.c | 29 +++-----------
 drivers/clk/mediatek/clk-mt8188.c | 81 ++++++--------------------------------
 drivers/clk/mediatek/clk-mt8189.c | 82 +++++++++++++++++++--------------------
 drivers/clk/mediatek/clk-mt8195.c | 29 +++-----------
 drivers/clk/mediatek/clk-mt8365.c | 29 +++-----------
 drivers/clk/mediatek/clk-mt8366.c | 64 +++++-------------------------
 drivers/clk/mediatek/clk-mt8512.c | 38 ++++--------------
 drivers/clk/mediatek/clk-mt8516.c | 31 +++------------
 drivers/clk/mediatek/clk-mt8518.c | 31 +++------------
 drivers/clk/mediatek/clk-mtk.h    | 22 +++++++++++
 10 files changed, 117 insertions(+), 319 deletions(-)
---
base-commit: 58badc5b2d377ded320c24f8d000ea3423405ace
change-id: 20260917-clk-mediatek-cleanups-ebdb2cac446b

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

