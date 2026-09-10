Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2297C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75D89607F7;
	Thu, 10 Sep 2026 06:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hksrdNnxO_Tl; Thu, 10 Sep 2026 06:26:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 69499607B9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789021579;
	b=MCrX7o4RoiL3NBkb+6Y4EpGvi+TJu+0GvMAS60n1z1WKRjJ5x+o6bODHZl1pL0mDcsd4
	 0uKJ2CohNj67dnyzHkKFZRxVgR03q3p349OsgT580lDZQ+hqu2e6AfkNYTP07LQJEOMZl
	 Vy+6qYvuU6KH0/NhpALKxi+etbtsXPVOo4abtRtXLZk55UZ3cCofdFoETjjsUmpZKkQGz
	 bDeOmEI/II1Y3+AHNgwGH13/bZmkXEdAOlUBL6k7KOAKwUZrCnc8lkTcAUcPXLpOSpLEi
	 Jir5yv1Ep4l/RcLIRL/OjJE2JSDi9cj9X9S/9SDihdRB2wh87QC+S9i41z1vyrwGk7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789021579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oaKqC8Oy3gT3vGwyatiulFqNiBIznbUNPzp5sbc3ZDk=;
	b=G09aigfzOb3DI/DLI0bWZVTeNiBm1c0EA2B9mS0Jd3yimuEZJZH60bdM47wyQceR6Xim
	 hhF9bC4VW4AANumeNc4RYcbleIwQrtDsnoGP+ixcXphfDk3EZGdmIgre+MrOWLubYnueY
	 Vskaz/OJFcDS1WtywWNFiTKQOUaJBxN12BJKRQpFFmv/2Tsk1HCKNBUhsbIHjYcsda8Q+
	 0/HO5P9tJ8gv/3M6wBUmDUgDCxxXvE78in2wUtDopG4epHw7Hk1qO9TvzEjqpZVeP170B
	 lIGuQJdkOXo/vPMADYlQGALSU274UsYVJWPIE1NjNeyXvKui1UZ2ycNiG27aRbjxgGg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pppGy0Cm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789021579;
	bh=oaKqC8Oy3gT3vGwyatiulFqNiBIznbUNPzp5sbc3ZDk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lPJfVIaUmMkrEcpMflJoxkDXhPcvE3eZ2UKJYVIy3QOQ76hRRgn/GSl0RvihKaUV8
	 vuyZP1TI3DLBh/4YXqMT+XlynO3A+Hxzo5hIcb9AyxobUQIgLndwDjvdsZzqNscjVZ
	 zeI0rp8mBPWXLJMAELch2NlZ7NXe3BlL0y6d4iQGfFNMiXvwV3gdXTgjRn4WyP8dri
	 P3au3Qft/nPVnKjqQXqq3QPtJ4Y5WFxlSthF13HZ+5uKljO4co3PytmHtdDfwotkvQ
	 Y3jdObn5v7GZB4ypAG8PCNuW+QRYLTZrrhq6B236Y8FjVkdXs7BuYsqVKqTlHu7+pw
	 jLDp6Vd+WvV4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69499607B9;
	Thu, 10 Sep 2026 06:26:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 364711EA5
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27957607B9
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fy2vuOqUAy0o for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:26:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8C04D60736
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789021575;
 b=FPYpdC8Xak3UrZ7i1mNNj29pVlw1j9+WIPmmvj/8xsE4Lj7Zm59kI1ZTrOC/hb/jwAVT
 G5l7fqAaU68JATNvtJh6jJSMzThorvHCjvwQzlZ984u4JcUioHnc5V9DKT7zrl2FaV9eR
 tHLu4YcuE8m1XaJrXI13dgKgRlrJgjUIkpwi/mr5CxsexW6V79aqsH1tRtmw2rMEq9x8U
 5sR3lmr/YPdFSvzZ2jXnK6WiJaA+4Pk61PMnvy1ZuSCa5W6r8LSEoeZehJwaUgRoTVHAR
 2XwuEqjZQ/dmaFfg1x/IrK0LWoFO4efR6BnwNBw90RkGOvoAOnZSwAvnhqpZD9oLq9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789021575;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=oaKqC8Oy3gT3vGwyatiulFqNiBIznbUNPzp5sbc3ZDk=;
 b=Xuiu9DyLR2idu1hdk3iM7QXniPcCt2BIk4V/SePZ3ebiqO497J6a4OPgFC41wmhqC3LX
 jU8EeRI7LaJEhrfrq8W7yG+CzJvFuqzUp6TyxlEp8Qa1HRrKKHUcDb8Rl5ikCVNeuy5z1
 96x9l8JhKbfJmjEiUdabO6GRwx4+hzpF9sfpWsr3W0XH+97fnkYG60H8hmPjjOT6JiqQc
 yko5EJJmsCOI2RjpwY4SuJR8nAIHGz/BxEGrYlQf4/G/LYEHJfFAFhJmsobDkyDUq8pVg
 xdMrIOg8kCMuQSsw1OFPXERsfDvB5OLJbNRHiZ7XskfI0jTl2pvZtCpCYufy3HbUyrw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pppGy0Cm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pppGy0Cm
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C04D60736
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:12 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-485850cbac3so4234679f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 23:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789021570; x=1789626370;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oaKqC8Oy3gT3vGwyatiulFqNiBIznbUNPzp5sbc3ZDk=;
 b=pppGy0Cmh8+cSC52BSHKNdGUNPimbqxRfM9ml0V0I+45r306QAy2qb0efLGGFjfcWk
 XPPTrJ3EPM+hWCmRGKhxhJTR5V6eu3wXdHgN3AiyQb6C+nVJ9W1rmqdWwnhrCxcTjvdi
 dY0cvSXVCFL//tACLWBFHgtfOrEY/gftkLnYdXZwiUAK/Fr6ojVHNNCUWrkQqUyRbrDE
 DusJscGeEerQDUQ2Gvpm6grwblIc7VbZ1YoBeq7f5ktNA13iSKa2BGVALTs7XFgj/VSd
 2HhGGcA7HrxFe9Sou0AtfBbD4IQDEQ8GYPVu5zy1bHDx95AOU+1lD8yde68j3SP/Kn5P
 ULEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789021570; x=1789626370;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oaKqC8Oy3gT3vGwyatiulFqNiBIznbUNPzp5sbc3ZDk=;
 b=VZDslEzjExJBGHfSbjPzDvuYOKjY2CDeADHt9dmUkwqKTaYBK6IFv2FAh40U/vIACA
 SCtWpoekPSiW+5BtMAM7Zj+jqtU/2hzpHURc8nZseFtmwFREeeFXFY+ZUP+QOrWu3TBz
 z4jnptpYg3/GqPWaKSAVDBkON+3IKL4NxFv2OFB6pDkXC8TdETbU+GoIHqgrwT8rNyzi
 1bfB/le2iQjczD+rXNvq1Zp/OqlrCRmX0/8Iae/UczU5XcH7XIFg6AIXJfa7SWqLe3TR
 g1V+KS6Pkdhex3kI009Hhfb0ibGOXe3CoWZrRTcLT/ZAOMUBKUQEgOOX+PcFwuehKbuW
 oQZg==
X-Forwarded-Encrypted: i=1;
 AKwUvByRiN7f27OIPUEG9cmxZw5SpIsP39kVqDFkz8ReZDEebVIdCZDBPm1Ho93DAelq0jOi7JYmujA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m6SANzdNi+g8Ny5g1lMFGmn1Nmj+SgS0mIhFi3hnQj/yBrIjUO
 C8DI1fUGGrPaZ6MmqXNB3HSRcvKogi7piySGtdQ3Njj7m7RI4gdcM4jquY+xSTb2JPA=
X-Gm-Gg: AYBFou2fiuQH9Kc3xk7Yd1TQd0iXVonrseEn09S5OQ94DZHeHPRJzpVFY2bPz205IWi
 yqbZ8P3XFak/nws6J4f8/19MSVF/ozRp8Hxxbpa1+PUAUJd+wBK4/c3gYHFPdRUSycjvIe8tk8o
 P6wrz4CAuiviIBKGtm7oaQjY+2wE4SLWgEFhCSHBCSSG5vjCoeKRKSnBNGE+mk8Lgzd0rtd4LoU
 n2KjOlvKt6L8X0WFpmb31JzXYIJBnIaePvyQp8yCSZFQreEkW/UERmNFctKIDKSVgZxiN5t85pQ
 8K5k/9mD236aFk2G4S5xvyBGuHCkJMahUlwWBemlbYx54ZETZLNOYke3J7Esb2HLW4vBziDF2Fo
 YPhLEuQbbTDBJ+SSWECopUpx7zdj3VKBDDtjBMpZ3PZKfrMVU+IJ4JUhtXgPzEP/d2zWvVGbvhG
 ISQKG+vkYU4JgzN/ywkrdhji476r1GaGha0NBN470imEXV78NSWXzorteJFEkJ5qvCdvNrsnqpR
 8Hw1RW8kMwPx0w7SkXxhFhlPCVCQJmgiWH4pQQP2eh/fiS/TtfJ7mDFYYuk3ChZ2X7dtCpYtsX+
 kX5zaxi3F72Ku+Y=
X-Received: by 2002:a05:600c:1d08:b0:49b:96a0:5c00 with SMTP id
 5b1f17b1804b1-49cf825168cmr414674555e9.13.1789021570421; 
 Wed, 09 Sep 2026 23:26:10 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c38e3asm52279585e9.9.2026.09.09.23.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 23:26:09 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v7 0/6] Add Genio 510 and Genio 700 SPL boot support
Date: Thu, 10 Sep 2026 08:25:49 +0200
Message-Id: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Ry2rDMBAF0F8JWldFb8lZ9T9KF6NXoxLHRnJMQ
 /C/V04pMcVoeeFy7sDcUQk5hYKOhzvKYU4lDZca9MsBuRNcPgNOvmbECFNEU42dg1oJ+DqWKQf
 ocT8Z3hFcxjPWUQkHlPloParCmENM3w/9/eM3l6v9Cm5aybVxSmUa8u0xP9O197dkmkszxQRTJ
 pVVPnrg8c3C7ZxsDq9u6NE6NrMNx1ibY5XTAIRILqSmdIfjG46TNscrZ1i03DpgGsQOJ56coaL
 NicpFETvWaQO6Czuc3HCs/aVZrtdRT0TgYLWRO5x6ch1RbU5VTngBlHqpBfX/uGVZfgAmJoZTZ
 gIAAA==
X-Change-ID: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
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

The Genio 510 and Genio 700 boot chains use a platform DDR loader built
separately from U-Boot to initialize DRAM before entering U-Boot SPL. Add
the shared SPL devicetree and configuration needed to initialize the debug
UART, watchdog, pinctrl and eMMC, then load a conventional FIT from the
bootloaders GPT partition.

Add an opt-in binman description that generates the images consumed by
the MediaTek flashing flow:

  mtk-boot.bin
    MediaTek BootROM wrapper containing the platform DDR loader and SPL

  mtk-boot-payload.bin
    Raw DDR-loader and SPL payload for external MediaTek signing tools

  bootloaders.img
    FIT containing BL31, OP-TEE, U-Boot proper, and its control DT

The memory-node change was boot-tested on the Genio 700 EVK through
SPL and BL31 to U-Boot, reporting 8 GiB of RAM.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v7:
- Drop the unused pre-RAM annotation from the memory node.
- Explain the pinctrl full-printf requirement and shared contract consumer.
- Sort the MediaTek maintainer file patterns.
- Clarify the independent DDR-loader/SPL sizes and fix documentation wording.
- Collect Macpaul Lin's Reviewed-by tags for patches 2 and 6.
- Link to v6: https://patch.msgid.link/20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com

Changes in v6:
- Bound BSS below the initial stack and use a measured normal-SPL heap.
- Generate the complete OP-TEE loadables list with binman.
- Explain image-layout choices, AArch64 entry and firmware prerequisites.
- Update SPDX identifiers and simplify the signed-build instructions.
- Link to v5: https://patch.msgid.link/20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com

Changes in v5:
- Explain the SPL BSS placement and guard area.
- Use the OP-TEE v1 header for its load and entry addresses.
- Use MTK_BROM_HEADER_INFO for the BootROM image properties.
- Rename the binman includes with the U-Boot devicetree suffix.
- Scope the SPL binman-symbol default to Genio image packaging.
- Link to v4: https://patch.msgid.link/20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com

Changes in v4:
- Express the DDR-loader/SPL handoff and firmware load addresses through a
  reusable Kconfig image contract.
- Split the binman layout into shared includes and rename the packaging option
  to CONFIG_MTK_GENIO_BOOT_IMAGES.
- Require bootloaders.img to be a directly parseable FIT.
- Link to v3: https://patch.msgid.link/20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com

Changes in v3:
- Add Genio 510 support using the shared MT8188-family SPL configuration,
  pre-RAM devicetree annotations and binman layout.
- Make complete image packaging opt-in through CONFIG_MTK_BOOT_IMAGES.
- Keep the binman image description in a separate optional include.
- Leave SPL binman symbols disabled by default on MT8188.
- Add optional RSA-3072 signing for the bootloader FIT.
- Emit the raw BootROM payload required by external MediaTek signing tools.
- Document component-only, unsigned, and signed build procedures.
- Link to v2: https://patch.msgid.link/20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com

Changes in v2:
- Clarify that the platform DDR loader is built separately from U-Boot.
- Fix the SPL copy-window wording in patch 2.
- Keep the SPL annotations board-scoped and drop the unused pericfg_ao tag.
- Normalize the firmware-stage names in the board documentation.
- Simplify the documented build commands.
- Remove the redundant MediaTek documentation maintainer pattern.
- Add links to Genio Tools and prebuilt images.
- Link to v1: https://patch.msgid.link/20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com

---
Carlo Caione (6):
      arm: dts: mediatek: prepare Genio 510 and 700 devices for SPL
      configs: mt8188: enable eMMC FIT boot from SPL
      arm: mediatek: build Genio 510 and 700 boot images with binman
      arm: dts: mediatek: support signed Genio 510 and 700 bootloader FIT
      arm: dts: mediatek: emit the Genio 510 and 700 BootROM payload
      doc: board: mediatek: document Genio 510 and 700 SPL boot

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  15 +-
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  15 +-
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi       |  89 +++++++
 arch/arm/dts/mtk-genio-binman-u-boot.dtsi          |  12 +
 .../dts/mtk-genio-bootloaders-binman-u-boot.dtsi   | 109 ++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  33 +++
 arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi |  27 ++
 arch/arm/mach-mediatek/Kconfig                     |  41 ++-
 board/mediatek/MAINTAINERS                         |   4 +
 common/spl/Kconfig                                 |   1 +
 configs/mt8188.config                              |  33 +++
 doc/board/mediatek/index.rst                       |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 281 +++++++++++++++++++++
 13 files changed, 654 insertions(+), 7 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

