Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89358C5518F
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C07740726;
	Tue,  4 Aug 2026 10:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PYjTU2Pnhbsv; Tue,  4 Aug 2026 10:57:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94B39406F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841067;
	bh=UQxd138GfDn3Cdx3+Ca9rfn1IO+vEq52tGXWUQ7L14Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PVXadhXF9Srr7+XnmK4i+eAXmaeKTFLBYZ5LBrWHFkB5Vx+NNPF2tJI3u1FaL//FM
	 uDM1Hm7qM1JXIc2r22fu7Ccc7/8aORVpFMsl686RZWelGRJHvsZXbZP/o6CBtKYbBJ
	 ExFSS4+MtirLOggo1h3vBG3SIeLuCoQjMhBWXbDQGuKK7qC7AYVHd05OcKVl8zhvRu
	 72ws89FD/tkD4NUZTifrZztn84HK/4YMrGT2yW2xKmzZFiPkHVrAjr9S56W94mEm6/
	 XhBsdx2FqEB+oOb9fj077EJWw44quWBF2FU8OHRU2Ihsu9YLxBoT6g7cuksO3CjX5A
	 dh1L6qLgabM0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94B39406F1;
	Tue,  4 Aug 2026 10:57:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B295296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CFB980C86
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Af7IrswKqxXI for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:57:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 54C1A80C88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54C1A80C88
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54C1A80C88
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:42 +0000 (UTC)
X-Forward-Email-ID: 6a71c59ee481fa9c5d58fa1d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
Date: Tue,  4 Aug 2026 10:57:09 +0000
Message-ID: <20260804105721.2402406-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1785841062;
 bh=UQxd138GfDn3Cdx3+Ca9rfn1IO+vEq52tGXWUQ7L14Q=;
 b=yncvg1jsHPgr1VBYb8r0RolZDqFPDSY/r6lKgS60sxG07tS9B8I38CT8/fGRlhgngMx87Q4Gl
 2n6KqG01KgSWVJL4HfuE5Mn2BJtbwGIN1eUTNKY66ba/xjG/+Oci/8qK27EWhDtL5G5gNi+04yo
 q4L+Cb1OfWWQyHBTxPVgl9xK7I56tCvMZTuB8q82I+naw4/bGD9JIrc1w61/KRzZI5sQnqq4NMc
 CisTr8BMjMdwAlUg6gpxZgWtYhbNYJB4HXsd8P3eOxlNue2nlgT5JhaarrFjopK9WsBWNn0GsLv
 WSLjWg0CHTGay56r/sXhQbAzccRTc9THdy2Wsu4yIMLg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=yncvg1js
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

This series takes the initial steps required to try and remove use of
syscon_get_first_range() or syscon_get_regmap_by_driver_data() to get
GRF base addresses at runtime for the Rockchip platform.

The GRF base addresses are fixed and known at compile time, yet drivers
keep trying to resolve them at runtime delaying some operations by
several ms.

In this initial part the three current uses of ROCKCHIP_SYSCON_x lookup
used on RK35xx SoCs is converted to use a constant value or using
phandle lookup, followed by removing the SoC specific syscon driver and
finally removing the RK35xx special ROCKCHIP_SYSCON_x enum values.

The changes included in this series have no intended behavior change for
the affected RK35xx SoCs.

Future series will continue to convert uses of ROCKCHIP_SYSCON_x for 
remaining older RK SoCs if this initial part is accepted.

Jonas Karlman (9):
  ram: rockchip: rk3568: Simplify get_info() ops
  ram: rockchip: rk3588: Simplify get_info() ops
  video: rockchip: dw_mipi_dsi: Get GRF base address from phandle
  rockchip: rk3568: Remove unneeded syscon driver
  rockchip: rk3588: Remove unneeded syscon driver
  rockchip: rk3576: Remove unneeded syscon driver
  rockchip: rk3528: Remove unneeded syscon driver
  rockchip: rk3506: Remove unneeded syscon driver
  rockchip: include: Remove unused ROCKCHIP_SYSCON_x enum values

 arch/arm/include/asm/arch-rockchip/clock.h    |  8 -----
 arch/arm/mach-rockchip/rk3506/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c | 19 ------------
 arch/arm/mach-rockchip/rk3528/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c | 19 ------------
 arch/arm/mach-rockchip/rk3568/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 23 --------------
 arch/arm/mach-rockchip/rk3576/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c | 22 -------------
 arch/arm/mach-rockchip/rk3588/Makefile        |  1 -
 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 31 -------------------
 drivers/ram/rockchip/sdram_rk3568.c           | 29 +++--------------
 drivers/ram/rockchip/sdram_rk3588.c           | 31 ++++---------------
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 16 ++++++----
 14 files changed, 21 insertions(+), 182 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
 delete mode 100644 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
 delete mode 100644 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
 delete mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
 delete mode 100644 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c

-- 
2.54.0

