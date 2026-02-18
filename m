Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16ACE9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 19:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64D183D0F;
	Wed, 18 Feb 2026 20:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="caCu/Jey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B8A283CE3; Wed, 18 Feb 2026 20:26:47 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2272683AC5
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 20:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40f095f1036so89494fac.1
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771442804; x=1772047604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4kovkU7v/vgvuib7I7HdA+3I1KxuA+osBUerzNULxk=;
 b=caCu/JeyJHVK8TkHZvCeUft/BN3k/IR5YCHcm3f4GpqQjLxg5uZC2jkaxCXEj+vMrb
 g6uM0VvGO+vffdasxKy7rZtHc/DHrJHDh/lJsrk1O6hIYVTcvJUXVu7kUUzXJTW3OqGl
 k1T240sReb/GnE7wKA0gddmyd07l0INt/J6UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771442804; x=1772047604;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A4kovkU7v/vgvuib7I7HdA+3I1KxuA+osBUerzNULxk=;
 b=FBg+ZYXI2+sRd3I1y6vUCH46Nj5giqo4fgBcQWA8BAGztbrgE2uqrKPcjF/O/MTQXO
 /jb+SphzZIfN+reZ4216rXe4tR1lEqxvzSvIic9qkxQ2PguPaKd9Z0xe47OE+TZ0HV8i
 PnCJh+OOdQfFKugP1+NbzZHg1PQlZvaqBlwwYGdMoj7Nh4FAVviFTIrKaGcSJ+3ljq1a
 02jHhBBUpfYeuh5uz6ao383WsCnIEXoZ5nDQxWYeDSlRfwAHOtG0avLAFur9ox0/9+WB
 6mPlkw3tAbSZHA+ZKJ3OJ0cjQGE90leX6xGDxhEPsCpfFX2tCPztESMMmfsIRfgzom8g
 FnMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm1+TlgmhkgwWMGv5aS13b3ezmgdTozSTLFHPqRcMx8WWW+REB/uBrQTeoDqztPJaB5/u4k4g=@lists.denx.de
X-Gm-Message-State: AOJu0YzPvdO9+wDGNQrhvJQxX8APdNdjRd5kOInfxW4jRMEbc41ZPyoc
 HyPwDDI60VGjx5Xkk9qZpgee7m0MPvJHev77LX5r4/d0vmyR9WCFCaRKh18vzDZuRWU=
X-Gm-Gg: AZuq6aJP0X8qNxvlbKJXmNuLAdv8FaJclsbOKGeAkcMAysVAA8VQyMxSMP4sXliTVCq
 /VVXXG63poLW1NSv1N3HGPVy5GEtt4nx9gD42AmyYEfOi3WS9jH5bSt+s1L0/dhpUCUcaJ5Ge54
 bkO7zGHNdTjj2ZFUuYlL7AKov7JoqBbPeBU2lj83a6D70kjGeyPev0Xxp22yw9/AwYEaJ9sQPjt
 2Qu6Pv+c6I+MD+IU1AsOj0kBGt9h2okwZBtJoUB3jnSTytRaYDk1M4yDjBXqgwk+Fou1phkYtRz
 3tiZI2KGk3zLs1b4Kh20PSdrxbv+sOCwatULfmjy8O0nEXssewzJ1L3bc4dnmDlGcmj3WqqgInX
 z4tDhoqJcjd2IfllwUvX20FA7ZYFoKnZg+acMLcXGMoBa0xfZ/vR5yRINifbv8zy1WwFtN70xUp
 ev2HExyg/tdnXA/4rZWL2txq80U82K/0gMR5ooE8eSmhX98EuGB9n0hUTvGq95Z7XYsSr8Xp67j
 tjlslSqlOV1f3Tr0+o4YOWNfXF/SUcCVBFhRIZNOfZYJMWxYQ==
X-Received: by 2002:a05:6870:b14d:b0:40b:66d:1118 with SMTP id
 586e51a60fabf-40eeed74765mr11552770fac.55.1771442803713; 
 Wed, 18 Feb 2026 11:26:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf1e858bsm21568269fac.19.2026.02.18.11.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 11:26:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, u-boot@lists.denx.de
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
Subject: Re: [PATCH v2 0/7] arm: mediatek: clean up some redundant board init
Message-Id: <177144280276.3629982.2554283802784525746.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 13:26:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 09 Feb 2026 10:39:25 -0600, David Lechner wrote:

> Before adding more targets, we take a moment to clean up some some
> redundant code in existing Mediatek SoC support.
> 
> The first three patches are removing no-op functions. The last patch
> generalizes the mem_map code so that it can be shared between all
> Mediatek ARMv8 SoCs.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] arm: mediatek: use default weak mtk_soc_early_init()
      commit: 1af249f511af6d88fb365bfc335f6b84e860b77b
[2/7] board: mediatek: mt8390_evk: remove empty board_init()
      commit: d8c550fb7a348ce2496adc22730157416938baab
[3/7] arm: mediatek: mt8183: remove unused function
      commit: 35d5cd54153d4ca06547712c33810e8095967745
[4/7] arm: mediatek: make mtk_pll_early_init() static
      commit: 9260339c0ed0cb6989f1fc1959d7619fcff7ed7c
[5/7] board/mediatek: move EVK MAINTAINERS to common file
      commit: 8b621407386eae25dc299823185ecdb5bb7822ef
[6/7] arm: mediatek: consolidate ARMv8 memory maps
      commit: 24ffbb2aa17e287578aa359e773f075b9c96ebc0
[7/7] arm: mediatek: add CONFIG_MTK_MEM_MAP_DDR_BASE_PHY
      commit: f1c0e637cd67ffddee154f8c5282c4e910a7179e
-- 
Tom


