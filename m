Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7DEC55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC86180D1E;
	Tue,  4 Aug 2026 21:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACKbcQ8GOMHn; Tue,  4 Aug 2026 21:44:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1086C80A89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879898;
	bh=NNnvTC7ERVUaaUT2d+wqXB6C5AW4r4Kc7nuN6DGWEwM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rdi+BVeR+6GsQP5p7vFpsFFPXG+OMMIf+TD+aVQeI2TGM3/PfHPV1y2nBD/lzpr75
	 tU+8LqJIiO8fG++XsTuadxflOODFVPkagaex4EZfzib44jzivgcfJ5WeAXiufLyC3o
	 ZOyvSqUYe0W59A2T0Wp9kFGUAM6rZWt3AP97QrNF2qfivIslYXdD16RHTMtiA/n2jv
	 WqwqRlwLEHRRG5gAVdlMq7Jkp3fOQYnSAO2Rt2krxd46LND2eUKR0PMIz9Sxv2dbXQ
	 pyi4CIm5zdhxbSIH89+fWUtj216XJwb5KmHHnG35n31UjaZr6fBL6ztwXiy1MleZjW
	 8dc9VvbZTEgng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1086C80A89;
	Tue,  4 Aug 2026 21:44:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96DCB10E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D8C740571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P_gLLDQaDVJO for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:44:55 +0000 (UTC)
X-Greylist: delayed 6347 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 04 Aug 2026 21:44:54 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 251B44059E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 251B44059E
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 251B44059E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:54 +0000 (UTC)
X-Forward-Email-ID: 6a725d4f96269bde0830449a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/10] rockchip: Remove unused rockchip_get_clk() helpers for
 RK35xx
Date: Tue,  4 Aug 2026 21:44:29 +0000
Message-ID: <20260804214442.2592597-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1785879893;
 bh=NNnvTC7ERVUaaUT2d+wqXB6C5AW4r4Kc7nuN6DGWEwM=;
 b=IJ9hZN/M9Oeiggjxp11sNnLLUgKrnBO+reKc8UFOh+hXdRD/Aagodh4nAmLPKLNU864uQXMU3
 hKDU+wolL3zI9PkGeLIk9dz82W/Rh5LdrtsqwtHkrk6yweppLCV7Q4N/2lOgNJP4pJMM8ZXts5Z
 WRG9M5mBiMlS80+H1LTmDf+O/Q8QNSx3DRAtlpxrd/FAb1P2vsigffTprKIU25vD3iIYdjkf+wE
 eTGEMb6tthL1YeAYl0jYW4/VZwkh7Jcdc7u/i57UmjEe1yYpnd5quMnyebYDzvdMK3bOVAPzWn5
 cRlHctoTU7uuV1mGrQSZI0pArSl2nrjbDuUabpRfa2LQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=IJ9hZN/M
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

This series takes the initial steps to try and remove use of
rockchip_get_clk() to get the clock device or rockchip_get_cru() to get
the CRU base address at runtime for the Rockchip platform.

This series is similar to the "rockchip: Remove unneeded syscon driver
for RK35xx" [1] series, but focuses on CRU instead of GRF.

The CRU base addresses are fixed and known at compile time, yet drivers
keep trying to resolve them at runtime delaying some operations by
several ms.

In this initial part the RK3568 and RK3588 specific helpers are updated
to use CRU base address constants, similar to the other RK35xx SoCs, and
the rockchip_get_clk() helper is removed for all RK35xx SoCs.

The changes included in this series have no intended behavior change for
the affected RK35xx SoCs.

A follow-up series will introduce a rockchip_sysreset_bind() helper that
passes the CRU base address to the sysreset_rockchip driver, drops the
call to rockchip_get_cru() along with implementing the get_status() ops.

[1] https://patchwork.ozlabs.org/cover/2280781/

Jonas Karlman (10):
  rockchip: rk3588: Rename CRU_BASE to RK3588_CRU_BASE
  rockchip: rk3588: Use fixed CRU base address
  rockchip: rk3568: Use fixed CRU and PMU CRU base addresses
  clk: rockchip: rk3568: Use fixed PMU CRU base address for PLL access
  rockchip: rk3568: Remove unused rockchip_get_pmucru() helper
  rockchip: rk3568: Remove unused rockchip_get_clk() helper
  rockchip: rk3588: Remove unused rockchip_get_clk() helper
  rockchip: rk3576: Remove unused rockchip_get_clk() helper
  rockchip: rk3528: Remove unused rockchip_get_clk() helper
  rockchip: rk3506: Remove unused rockchip_get_clk() helper

 .../include/asm/arch-rockchip/cru_rk3568.h    |  5 ++-
 .../include/asm/arch-rockchip/cru_rk3588.h    |  2 +-
 arch/arm/mach-rockchip/rk3506/clk_rk3506.c    |  8 +---
 arch/arm/mach-rockchip/rk3528/clk_rk3528.c    |  8 +---
 arch/arm/mach-rockchip/rk3568/clk_rk3568.c    | 44 +------------------
 arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |  8 +---
 arch/arm/mach-rockchip/rk3588/clk_rk3588.c    | 23 +---------
 .../jaguar_rk3588/jaguar_rk3588.c             |  2 +-
 .../tiger_rk3588/tiger_rk3588.c               |  2 +-
 drivers/clk/rockchip/clk_rk3568.c             | 34 +++-----------
 10 files changed, 18 insertions(+), 118 deletions(-)

-- 
2.54.0

