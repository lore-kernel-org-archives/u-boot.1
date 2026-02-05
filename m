Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F38ECD9AA
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 23:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9068341A;
	Fri,  6 Feb 2026 00:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rMOQ6jsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DF28838FA; Fri,  6 Feb 2026 00:52:15 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03EE2800AE
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 00:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d189e5b05eso79392a34.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 15:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770335532; x=1770940332;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sMv1KU8gZf18He7Ijqr2jy2hvcBXgDkiJqohHjrZgl4=;
 b=rMOQ6jsWQdFTnORrUxha5S+NNvgGylAKCpD2jL9lrwNX0UKhwqF684OC06/qlCXWDo
 Qmt+SqYomFHBFf2inXvxIBbjTFxBVWhX47Ce8PfT+DjJOvLqrnEN/bmLhVA4jBlsrN74
 EDcy2U7vDFaFkSp8zqleQe1b9+XaqFgUpXmCY1eI1fRUGnhsUcP4Asjg6UKmQmzNp/fN
 HHDELBpGE5Jh6yTJ3PhJ+MgZNdk1pSFKKfb7s7Bt4lkzCKPXQ5hOP2FbSRwd2SGCpS4X
 WIxm4feHU2g63xt1DdjlUxb/d6RMxz3nVnOpWYG1siYzxuZII+Soc3IddRUl/MZ5XK6W
 5NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770335532; x=1770940332;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMv1KU8gZf18He7Ijqr2jy2hvcBXgDkiJqohHjrZgl4=;
 b=jZsFN5A0QiYtqcBByzLOMDpf3j9yLJDqPO9rkY7XlNWYjHPYdBviYGcNgX320CRJf3
 VfuyrExO3jG+mF85rhaN3AzpVgxTf75NwgL664BFocqQMpvIzhJzQGZ1MmgQAlPayebG
 NBVkxDtXFgJ2AsGiVe71zsHeKRYD+yYTd5OkdKBmW9Ft/thfUE3DGxUvqNqVDG1gSzLE
 uYCtifqsDHo/TP2/PrhKLN4qcSSFBbiuC2xeq5szK6n1SD/G/r2vvlSfRBC4GM3AeNTk
 72dZYP2X3qz/n3dO1KxlUgntNmnSomug3MHUX7wsPDNh+wBIsgQHGgprSdykNSsOR3wX
 wSdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ZWWT3rjZwvznfadL4qAC3eFnIfpNed7RIToybaL9lcER/RhFVlyeV8KXG9F0Qqk1i7z5RKY=@lists.denx.de
X-Gm-Message-State: AOJu0YwDXLNla22VE9lxUO/2S7gp6RmZpWnjzfAu4AWMbMMgKMhBGViA
 kOIHTDzHUeeXYpsAGQo4R1tI6v9xCSe9PF4z9WVB+6urtSk3mKremXXvmYWdUudF3ys=
X-Gm-Gg: AZuq6aK0pVR5cZf90U7vy1wYn+YxH+ZJGS9ShzYyMpDrzD33xOOofe0RlHAfzO8hlrQ
 UM88maN7EES7Uxspu+DCuIx48nBZUPiUxyudHbdKCw7zBQJ1VoZXXRlJZfEABsTHcC9R3QZ5viA
 wudolI43/hMvECSobdPl16uwMcP10HAudaDAOYUuDQoQTcPtgqd2A0iUPaE0AAhXz87q3+DVpo5
 aRgvA/brdrnEz9qe7pMAYJTbhIlmvyFi60R508TuyzE7Vl2AZQHsSP9TyvkqBdN0Xo7JpXob5Yf
 nb0mcvX4k9m0U3RFlmFab450O99PcTttgGtPIsTXe7yzAHSEcc97EQj+a8s5NfMeGkAhKlqbGog
 mtS7QWoh9mlZdReuw+HMxAgSHoY4oaHvofy4y8nFO46NhjnjuDrTLYHFO5+9lTHjdSU9WzcoPMw
 lQ/Vv//t5odjpUH8U=
X-Received: by 2002:a05:6820:450e:b0:662:ecc4:2964 with SMTP id
 006d021491bc7-66d0bea5853mr436507eaf.53.1770335531688; 
 Thu, 05 Feb 2026 15:52:11 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3adcae3csm312165eaf.9.2026.02.05.15.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 15:52:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/5] arm: mediatek: clean up some redundant board init
Date: Thu, 05 Feb 2026 17:51:24 -0600
Message-Id: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqDMBAA0KvIrDsQ4yfUqxQXYzLqUI0hiaUg3
 r2hy7d5FySOwgmG6oLIH0ly+IL6UYFdyS+M4opBK90rrTrc8xt3sivajcnjGdCdYRNLmRNS78x
 k2q6pzRNKESLP8v33r/G+f84bGW5uAAAA
X-Change-ID: 20260205-mtk-mach-clean-up-duplicates-a6d7b7453179
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xUVfZA2Kzxu0acOPjL8YE75mXHrHDw5Xlj3PtYFkWGY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphS0CUZ3Wu2mBX8e+9AGAXW2TSHKedNt1C6qMR
 mxBTRomW0qJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUtAhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AFkgH/3tLiNuBk6wLRiNFahTEE+G3aYSqz3cJvyE1gy9
 exyoACUpBtMCM6Ov9FB7nFeEsxPSqivBR2xyRQ08YqRk+5rh2lqQoCnOaRA3LiKO09J6Z8jHucf
 sMFwiX+icazMGzD0yYCmUgL/6KKebhFPbwwQB9o0i/LmOTyYcuYVyV4QDQneHw2et767GY9AQO0
 a9PyvHdVvAi7dqSu7/5kc8yscEiW72fK3MYDggMaDlCQ+Y0zsamOXmWOaHHvC+vVySVmKqLyR16
 kVJgikzo97LFr36u578Kb9kjJrLaWHoGFil4apFrMBClpzCYb4/Y+LO+8cts72jrmLYVn3qxChK
 un8w=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 06 Feb 2026 00:52:32 +0100
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

Before adding more targets, we take a moment to clean up some some
redundant code in existing Mediatek SoC support.

The first three patches are removing no-op functions. The last patch
generalizes the mem_map code so that it can be shared between all
Mediatek ARMv8 SoCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (5):
      arm: mediatek: use default weak mtk_soc_early_init()
      board: mediatek: mt8390_evk: remove empty board_init()
      arm: mediatek: mt8183: remove unused function
      arm: mediatek: make mtk_pll_early_init() static
      arm: mediatek: consolidate ARMv8 memory maps

 arch/arm/mach-mediatek/Kconfig                     | 21 +++++++++++++
 arch/arm/mach-mediatek/Makefile                    |  1 +
 .../arm/mach-mediatek/armv8-mem-map.c              | 14 ++++-----
 arch/arm/mach-mediatek/mt7622/init.c               | 20 -------------
 arch/arm/mach-mediatek/mt7623/init.c               |  5 ----
 arch/arm/mach-mediatek/mt7629/init.c               |  2 +-
 arch/arm/mach-mediatek/mt7981/init.c               | 21 -------------
 arch/arm/mach-mediatek/mt7986/init.c               | 21 -------------
 arch/arm/mach-mediatek/mt7987/init.c               | 21 -------------
 arch/arm/mach-mediatek/mt7988/init.c               | 21 -------------
 arch/arm/mach-mediatek/mt8183/init.c               | 30 -------------------
 arch/arm/mach-mediatek/mt8188/init.c               |  5 ----
 arch/arm/mach-mediatek/mt8365/init.c               |  5 ----
 arch/arm/mach-mediatek/mt8512/init.c               | 21 -------------
 arch/arm/mach-mediatek/mt8516/init.c               | 22 +-------------
 arch/arm/mach-mediatek/mt8518/init.c               | 21 -------------
 arch/arm/mach-mediatek/spl.c                       |  5 ++++
 board/mediatek/mt8365_evk/MAINTAINERS              |  5 ----
 board/mediatek/mt8365_evk/Makefile                 |  3 --
 board/mediatek/mt8390_evk/MAINTAINERS              |  6 ----
 board/mediatek/mt8390_evk/Makefile                 |  3 --
 board/mediatek/mt8390_evk/mt8390_evk.c             | 34 ----------------------
 configs/mt8390_evk_defconfig                       |  1 +
 23 files changed, 35 insertions(+), 273 deletions(-)
---
base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
change-id: 20260205-mtk-mach-clean-up-duplicates-a6d7b7453179

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

