Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB03C88E70
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 13:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EB7B80D8B;
	Mon, 14 Sep 2026 13:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kja_edMBafCZ; Mon, 14 Sep 2026 13:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 55CB380DA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789392966;
	b=YMacUjnDG0ri9nKtgSZ75PcdGJBZHm3e39eDAEinDZBjT2nVXv9I4/aE35Z6XMQrNz+T
	 qWTg6jqgeEaMmIigqySlIyKnemC4VIExpYdY8nSFVGonh+wS/HrlxPcWD8wB6Slic8e9m
	 qPAmS2HhV0dvLXW9gYpuMWE0jhTBMJg6ZCVujkxTzfb9fMheu7E/QWO0Gwv/gIEVkjYM1
	 TDZDo9F50w0ZCeuZ6XoENRZ716RWtWtr/vyq0gcKjBXzl3BGv5SdwCvToFQR/z3bJZIiB
	 egnG9PfgNKfrvnUenYUy2FSI16r4Mrf3cqd3rmikmdhH2lU6xdyBlHaRrfXEmh/2pCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789392966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oA0+YUFtj2NTDin/TcsJQD/pj/92zsmiP6zuVHr7IBI=;
	b=D1MhIGobk4hjhInKkEyYJVZWFzYt17B+0Dfye+E3fx93QDTLg+NgZpF9voLrK0lVNjQS
	 GCCb8kJBDLpLL8L7T+7RsH2Aqjq02gSK3Q0RY2UIUid2IIxI/Rl1M28wg2G6mD/hiqf8i
	 JfLRn8dh5JvTS+nqebhB8svuAdf+0XsPVA2DL2aVEbjEBpNf2mLbmYys1SAdWc+mURldQ
	 lzfiXKq9M1699RCIHFdGUWXJqWAk2M5D4CdhuIi/Yn9Pkuvh4AwmhOmVZhTUzLrwTIPWp
	 pQtgWWU8ARC+O/qNBZBE0N6yTX2x9Cb7AM+hPNRoUFezkgoV2iF+AFwk0thCCDxhV6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FsGYRoVN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789392966;
	bh=oA0+YUFtj2NTDin/TcsJQD/pj/92zsmiP6zuVHr7IBI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EwCfCiWUrYIMsgdAqC2ypby3T+PS7ktMxiiDqdND0Zj7W4WRBPcf0c71U4abWlRet
	 8jfXIknQeA9IavogC1FP6IKvtODx8Fph84WRZaXzwknLGRr0pAAnaqDbei/xLQ5p5x
	 Exu3ZzZ130M2pJWjSkIh4+RSA8vwVYpKS9K/ZCoK6YH91GU/8L+AuLlCc05j6KDgsh
	 9tsrjW5jzDsc5btqhRs/TqgxRQMkO0e3pFLtLpNMkXkC5BSAEYPl4u9bSXmPabOVJ6
	 eB3wMeleIPFV0Vyf2FNbt8BH6pBxPKP8mvxeqN2Fd+68KS4YHyLwRmgZZ2ADeFzmc9
	 JhlTrwd+/hJAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55CB380DA6;
	Mon, 14 Sep 2026 13:36:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D88C4493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9E2A80CF0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4zlW93yA6VKx for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 13:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 04E9580C06
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789392964;
 b=mpvqLFeO1k/66RSLvQl5rKhb6Re4ZwCrrXtub2TPG6xwWe8rtaecyB090IhxebA+mr8u
 LLBBl+d6ofPjUhy1TrEAubaT+4VQZZqkLT8SuhfYFUBqBNzyvJy/7FZVAy+vrwqTGbJb/
 ExgDIzryzUQeRDo8keSd6EGajaq/AhMEW5axz2bBnkIlgvZALvvv4HmFqvjvmeOKfZrkR
 T2vEsdkkzMyU3cPr10ddyRHelydP9mL73F7e9tifDBpVWsmA2BClMJ1PH2qH94Vw7mfkk
 po4W87DkrjzfhvNEwdNKKn0+sAQI9r2GNa9wFoG+Rfcl0DyMJSki95sDzoHp+TxdJSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789392964;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=oA0+YUFtj2NTDin/TcsJQD/pj/92zsmiP6zuVHr7IBI=;
 b=Yv9IFhWGHPm+nKG4iaiYWFJIxnIn+jcdBjmZ2b4d3YJvlUUFh6GCkkMqnU8WzD/OwPsG
 jMzE7c7hJa1POZPS0TbOAsouzwzj3412c/ANOXKysjKcGD4bqcO+Jum8wnkkdbWaggEZE
 6Bz95koGMiySQDENfhO5DBfLeHTlh9dJdUiMyCeUKvYv0u3+Az6jGQXLOqToWi/eBKR0A
 VdQgeZOAuxidsDgxVh8O85tVFQtSI5xHxMujAmcQq6SXFJxcw8RQAqSahyZp0qu1Clkvt
 ooOFGiowc+S73ugTmWz19MRhVzcZGoGKXGKHIHCSsX2e23PHzNoBKJNoU0XOwY5j9lQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FsGYRoVN; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FsGYRoVN
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04E9580C06
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:01 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso19681675e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789392960; x=1789997760;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oA0+YUFtj2NTDin/TcsJQD/pj/92zsmiP6zuVHr7IBI=;
 b=FsGYRoVN5SYBdIcRAi1G2fuFiCmciQEj0CB1Q9042wOb7DFUnhbn7d6XHDf68ZHGB2
 9jLhEQ4cCZ5fWI6jdXkzC8zssS+j0nFAe8i6XVqixJLWZq/DncR4REwP9cTOuk0vFk44
 YA2dT6aDk1ZjEPqgWMslryMQSbU8ARNTtEfTRJKrR9GKr+oLE/TEazeKXxRwbd9iTIsw
 98Sx7SNDF+7fnti3Sp2BaBqcG7o4QAPvXOCXKQn98SgcjevmEGL64GGYiN8e1XHp3juf
 8ZSdu2/+EPbnAW1uYhs+j1m8WEapepgrLwXiU2dHOaK12y+NaLOMIlBq/D4+YFCN2vbu
 zBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392960; x=1789997760;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oA0+YUFtj2NTDin/TcsJQD/pj/92zsmiP6zuVHr7IBI=;
 b=ko1qYYzvZRq+buYm7YkzTh5uRHHqEPuBddPzWWYbIogtYpPAkirfN3x5qn0vIVrWUW
 hfqIWkeMvC2zw+57BTNquugn7dNgYvjnKBNCr6XSTWv8f0G8ToeY6pCEGXGby2FhcGug
 wzPtPofhSz7FKBiMsgE+vzHbMmg7m1MtkPxHvelXPXhz9ze0i4nrzgPhjYo01WyjOrUB
 2vtfdhaeN9vejnALpRsMwOXvoOZgHCjsXe7pVTK+DRHuxCfByUrTi1/1nHkmRLYA6u97
 QHvU5Ix+uqOEWFF0g0rTtPdyAJPzOD2t/TFljE2Xn8xETrJSwxyFHAqei5WEBRXJgd55
 ohaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwX/echnbDUldz4BYEcaeXUTsfplRjzCHNmriEFTmKxBSyb1STfTg9M0Xu/tqeR2AZwhBeX0Xo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n7IEqTlqqsDDNkTLdwh20vbmGOl+dIW/8eeF4FdsqQeyYiZKHq
 PMIfH1x5HlpwOWfio5rjmJ6kRxe2uuMD0brfcu286qCRtRuG6g/gc/EISWnIyxJPJhY=
X-Gm-Gg: AYBFou1b3KVoFI8WiuDNp6/S+mH9oTtj8s3bIZ4KFhmQEtr2AFk8NrC0V56QxPU6EYE
 R3q0zkJWtMwMoz99NL7Ejk64Rpa3pjg/Anbt+srr/1y0QGvGPLB5r2RVAHO/0Fr3LLm6K0HuRBw
 zYOYN0tgkflslkcHPM4CS8v5PkVZBF710ydF2Ss3H3T7pa/l6hNty85ZJc1togrDx14DVeWgNK3
 oewfmfotrPylzA7O/bnZn09cn2I+kJaf4YZRcEQWSyo8Z+fADj5dm0yh0JSsKJeM5eFWiIMB/As
 UyJU4PZ8MhD0vvrmtISbxxVUDRM5blmLHFiHGf2+hlBYYjOGymFjRvt+hLoErp4StvCbPUJhFBe
 qvNFKAkTqRibvom9abzhK4nK40MFdXBdSN0mr8QuQg9ifJ1TJTrZEpbevwUryW8qidX7/2OvD7W
 q8BaqePdJ1MCNaH3nPX0bj0ACC8CsC06Nqe7YaBpcMkJuG2uqRNKLU8QV/nO1dkKJXc979/iXAk
 gsoNMlXf3X14z8r6tQ5hMmkCQInoQGUcFTMJOjFToyqXl4qJmem56rFnfhCzIcxlmqBy9WujtaI
 zB2caAQs048w6JA=
X-Received: by 2002:a05:600c:548b:b0:498:952:e276 with SMTP id
 5b1f17b1804b1-49e7a6625aamr30159385e9.8.1789392959724; 
 Mon, 14 Sep 2026 06:35:59 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6c0cb676sm236400905e9.14.2026.09.14.06.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:35:59 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH 0/3] Add Genio 510 and 700 BootROM download agents
Date: Mon, 14 Sep 2026 15:35:44 +0200
Message-Id: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOwW7DIBAE0F+xOJeKBYONT/2PKocFLy1VHLuAr
 UZR/j046aWqqh5HGr2ZC8uUImU2NBeWaIs5zqca4Klh/h1Pb8TjWDOTQhphQXDvsVaIr0suiXD
 iU+mVFXxEHmToWzDoJPasAkuiEL/u+OvhkfPqPsiXXfxuJPpc62p51JjDTNzP0xTL0GjZAWgKp
 uuVJ99a0gaE11J5kK1T1goAZWCnJsoZ73eH5t+zeTnyreOCC9Q+COt1Z+DF4fkYXaLnuv8HqX6
 TuxUwFzfPhW+mouOoHPaAHY3yJ3q4Xm84p7HUcgEAAA==
X-Change-ID: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Genio 510 and 700 need a way to provision blank eMMC and recover boards
with unusable boot firmware. Add RAM-based fastboot download agents that
can be loaded through the MediaTek BootROM download protocol without
relying on the installed bootloader.

The series provides both an SPL agent for provisioning without BL31 or
U-Boot proper, and a U-Boot agent for flows needing its command support.
Both require an external DDR loader.

This series depends on Genio SPL V7 [1] and generic SPL fastboot V6 [2],
applied in that order.

[1] https://lore.kernel.org/all/20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com/
[2] https://lore.kernel.org/all/20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com/

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Carlo Caione (2):
      arm: mediatek: enable U-Boot fastboot DAs on Genio 510 and 700
      doc: board: mediatek: document Genio download agents

Julien Masson (1):
      arm: mediatek: enable SPL fastboot DAs on Genio 510 and 700

 arch/arm/dts/mt8188-genio-da-u-boot.dtsi           | 58 ++++++++++++++++
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  8 +++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  8 +++
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       | 16 +++++
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi   | 62 +++++++++++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  6 ++
 arch/arm/mach-mediatek/Kconfig                     | 56 +++++++++++++++
 arch/arm/mach-mediatek/Makefile                    |  1 +
 arch/arm/mach-mediatek/spl.c                       |  3 +
 arch/arm/mach-mediatek/spl_fastboot.c              | 65 +++++++++++++++++
 board/mediatek/MAINTAINERS                         |  8 +++
 common/spl/Kconfig                                 |  2 +-
 configs/mt8188-genio-da-spl-fastboot.config        | 15 ++++
 configs/mt8188-genio-da-uboot-fastboot.config      | 20 ++++++
 configs/mt8188-genio-da.config                     | 19 +++++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 +
 configs/mt8370_genio_510_evk_da_uboot_defconfig    |  2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig    |  2 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 81 ++++++++++++++++++++++
 20 files changed, 435 insertions(+), 1 deletion(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
prerequisite-message-id: 20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com
prerequisite-patch-id: 2cf6c90272cb885eea020b339a7ae76fc13e96d3
prerequisite-patch-id: d125fe2e446f3662de925b608d4b6c6299f8759c
prerequisite-patch-id: 7b41f296adc7e1549b64c590134c3ec56d226b4c
prerequisite-patch-id: cfd62f5e9d74fad11e1a9525f5047f47ccc15763
prerequisite-patch-id: 20b9d94c25eebe6010672c3a075f1a7adddfebd2
prerequisite-patch-id: 9e9a4d81113ef179e2ae6599ee525a1a8e0fe248
prerequisite-message-id: 20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com
prerequisite-patch-id: ebe0842a87ef1a27c9882d7c45823b37ef84e5a8
prerequisite-patch-id: 7df6bdcd4e7a655d86db0447593b2bf36050b049
prerequisite-patch-id: e98c322def69bb8ecec30dd41c05aa62040b1008
prerequisite-patch-id: 553ddc59d4de9ff9f1949875939979cbeab2eaac
prerequisite-patch-id: 8d8c1917bfcee87fecf6077a117c8a11cc402cdd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

