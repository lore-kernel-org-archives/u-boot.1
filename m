Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576F4C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A21D3814DD;
	Fri, 14 Aug 2026 14:57:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZBdDYayFGHc; Fri, 14 Aug 2026 14:57:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F3F08148A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786719423;
	bh=2oU7+0ICyNHddbRfNJ5YXgrS9aOGDwKLC0muF+I69UI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uqZl4STO+1YmGJmP/ts7TBAJh/FmaE6CThbYWkkHrz7IRqKC5WeidW2fGMcQ/HJxL
	 ZXUCrHtk1tTjqnUltGcM1IV+v6pAcCDukE1DBCYMoRMLldu4il6EAddtePCAB1zin+
	 J6hJq8IB9SjjKljf6b3qxL6MGLa1qH6JDaV2zX4TMglkRVfoKVh6Exub48AQ2lFAZg
	 NPm7LcHiUXUzWSOBb8e9Fj0NpbCaoUJoLskf86h+bxjtJmLGR/kxVQwpm3CcWyy/Gv
	 EtI+6iMZkoa3KYrBCiC7SxYClmE382jfYMK2RpVySLaOLshwzAGpSbIJf7RALgJ7cK
	 tgaOtbv2UlWVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F3F08148A;
	Fri, 14 Aug 2026 14:57:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E4C53194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6D8540DE8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jmeQOGLm_Crd for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:57:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CF89D40CFB
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF89D40CFB
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=p2vl8ITb
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF89D40CFB
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:00 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7eb64371a2aso779958a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786719420; x=1787324220;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2oU7+0ICyNHddbRfNJ5YXgrS9aOGDwKLC0muF+I69UI=;
 b=p2vl8ITbEMdDVpG1IZRRw4E1Dn/Va37m/TSyATthVIOmnZYmvcupcKY88w8LbS/kc5
 6j962oIRYKJ1cysRhIgbhctftZK/DBAR+3CPLpE+kWGg8fmKsZJT5ir/S1IMofZFoLf8
 V/X7GDCu7RyV0yWQwZyhZ933Vj7V1e8pS8+PMQVJ4+KotHLQPgo7SJMvaRMdkllYOtmJ
 yFpenvP+u5e5WcXhOkrrdaG/QR4hmR9KkMHJ11hOcjF3cyi4RFKNUEK1iZ1ZlBeuB+WW
 o5i/+sw3/qqxFtpgHrOdZAoZ6KzHVq/e9tv3pZqX7699UX9X41uPYs2WoYEie5Bwc1yr
 13JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786719420; x=1787324220;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2oU7+0ICyNHddbRfNJ5YXgrS9aOGDwKLC0muF+I69UI=;
 b=Jvei6iQZobSsVJVgoZtvHKta35kMB/5XSkADDgQrQA9qHpCpxs/vMM3ewpMQ3dmYqh
 wA8/zHRwzXaaaG32jXgnmhBJ0szpsSjsmVkS6JQNfD0rrncifMKMXFxjQtlOnRZwBNia
 s6ixWHBj+IVY1r9+bntl25GIyFkrgioTi0sPuQ/H4OUP7Okh1+D0YA1R2TRXMxNhQvWR
 K7NDCOymmBGEQPmOXV7AF49k0iVu4SaGHOx3lD3mWoMBoISwvhKI9bVkh1ArhJlVBSV9
 KjMnoTC5LgAAlTHVvX6NYmdwudCGEI0eLK5bZg3LQTdaRxavFkRJ53cYUKs2e/PTy02w
 /0wQ==
X-Gm-Message-State: AOJu0YyKsrfT4Z0mC6mpOk5/oFctKFLR/3GLtxLFjJwGSv9aI0IDBD3o
 xAYCBXQ3XdQclWjv1XREgAM66ISVlzrgOg4DjJezix4YDcSOxGhortX/TfIBamhR+Fg=
X-Gm-Gg: AR+sD13pPJBQSn+E83QNpwy0g3e3IzdnoPzmtAh5y2V9+zdWt1AVDATruT0zK4Uf1cP
 gi9p3dXUIvMffSdNAsy0dwbwfhxahJ487BEwGXNBiybtZrxX65025aKIQ4WB4RxgbypZJJYB3og
 ghwKgSIteUJitp/QInHko/5RGXoplVdqdPorAt3qKAoE6HlozXwCAtqR0OGP3APvo0PrGPBBSRn
 kG4NjR/9c8k3tp8T3nIoFDzFBupjcrpb3Z9HteAgRI3HG2as4/OsV/0v++45pdkRwxQRjXbuJlA
 /beG9tcrdB8lpGa6yaU6CqOCJFkpRNboZC0YQob8M7hBvc7sbwEN+5Jmu9PwtWG8SlMfohHmPgb
 99zsmK/wPaneOU3BleaZ5Kkwf5kLJ6GjwXVQ3eWSHTYx6RsisRt7KoufXILeDjMH+idSY8iq48w
 IGANzAMpmJHZ4VFk3kuOTYS5rYUW2OM9guDkz2NeW5XruvNOAO3sf8gXQxW9Wq+vNk9A==
X-Received: by 2002:a05:6830:439e:b0:7e9:e808:e9c1 with SMTP id
 46e09a7af769-7f3de424d64mr5681909a34.8.1786719419699; 
 Fri, 14 Aug 2026 07:56:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e8668831sm1065949a34.22.2026.08.14.07.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:56:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] power: domain: mtk: add mt8366 power domain
Date: Fri, 14 Aug 2026 09:56:20 -0500
Message-Id: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDtgTAy2Vyku1Iw6LSaSqC0E7
 27U5ffg/RECeaYAryyCp40DO5sgHhl0Y2MHQjbJUOSFziuhcFq+OLsfeTRuatimoZJa41MpqXt
 ZCtGWkN6zp57/V/ld3w5r+6FuOXOw7wctRGCGewAAAA==
X-Change-ID: 20260814-mtk-power-domain-mt8366-94436f3511b5
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Irving-ch Lin <irving-ch.lin@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=CRJ4vvI/MqIPan/MqowK34T8aLVTuDt1AwtD2gHgKms=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfyyZ1l7iXNwxByF98Ww6c0Pi6lgwlpKZAwt8H
 YZIA0c6GZWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan8smRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A0bMIAIi9M0EyqfuVrsRm2vn4jMNR4veGK5eoMW/KEDt
 c64/jepJSpn4NOxhKrS2vQcBrnWBD2tMqtkHIWWLChpAvkjxdte4BaDguClhq6Dkd1R1LoMJt6O
 YxmXWBEwt07pPzEpDPJ2kwyl0iKrUVVrBJtcGyzKdDcaH33OglVL0+VVbWLUxxUO5L+HMOMBgfw
 7XRKumlbMvOXXNBxbJ2Dan83Gq3K4W8+JIH0n3wfeAm5hU6Z5qZK7kUYK8+81GIHjI9+Ot6nOcA
 qabtOL10TQXJNkJ2KhmADeu3lrIOm6Nsr4sCFEA3DkUGBGwRsbcC7jmGgoLQfOvyI/mHJhKIBYW
 bpZo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a new power domain driver for the Mediatek MT8366 SoC. This driver
is based on the downstream Linux driver and has been adapted to U-Boot.
This is part of the ongoing effort to bring up the Genio 360 EVK.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      power: domain: mtk: add bus_prot_sta_mask field
      power: domain: mtk: add BUS_PROT_WR_IGN() macros

Irving-ch Lin (2):
      dt-bindings: power: add mediatek,mt8366-power.h
      power: domain: mtk: add mt8366 power domain

 drivers/power/domain/Kconfig                      |  10 +
 drivers/power/domain/Makefile                     |   1 +
 drivers/power/domain/mt8366-power-domain.c        | 299 ++++++++++++++++++++++
 drivers/power/domain/mtk-power-domain.c           |   8 +-
 drivers/power/domain/mtk-power-domain.h           |  15 +-
 include/dt-bindings/power/mediatek,mt8366-power.h |  33 +++
 6 files changed, 362 insertions(+), 4 deletions(-)
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260814-mtk-power-domain-mt8366-94436f3511b5

Best regards,
--  
David Lechner <dlechner@baylibre.com>

