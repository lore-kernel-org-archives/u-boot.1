Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011D1C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1FA080BCC;
	Mon,  3 Aug 2026 19:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCoD_k8s4l3P; Mon,  3 Aug 2026 19:09:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD7CC80B40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784196;
	bh=hiXO2exgTHBuB90XAfpQ+deEGTdKQ9fQRe0fpPJht3Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NNuZa++gmMPO2PA2TiE4PBvKru/fN3KmZSxowazjP6QWadx0bo+DOscIZJByZQYjz
	 ViXd2sPXTgWxAze5JT5xWh4Uib3RbBglbKZOQVQyD5+rwxsA2QFhWYk3c4TuLNHC4c
	 gJ+4aKIfrafZjE/Q1a+y7221m0WtpaJgvI812dPrWnWgWjSsuYwjtGJwkd06s8kHbY
	 xIAzsB7ibUkfyx7MP3ghJyWnqaaLwW/2zr3LH4aCQ3MO4MkFGCIwUZp1DtQ/GmxRM/
	 R7ZY+f1cB85MA/gUbGKMUVgOWPqFkEOw0CCh0Wm99mUAjdB4cvz5vz2OjRbyw54h2S
	 +fH3F/JrfZPSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD7CC80B40;
	Mon,  3 Aug 2026 19:09:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D28E42AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C493F80B40
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tM8ejW7Mf7Oc for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:09:55 +0000 (UTC)
X-Greylist: delayed 1503 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 03 Aug 2026 19:09:54 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E0D2280B23
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0D2280B23
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a02:6ea0:d71e::9;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net
 [IPv6:2a02:6ea0:d71e::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0D2280B23
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:54 +0000 (UTC)
X-Forward-Email-ID: 6a70e77eae1ce3dd2fb7e53c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/6] rockchip: Miscellaneous updates for RK3506
Date: Mon,  3 Aug 2026 19:09:38 +0000
Message-ID: <20260803190946.2259514-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1785784194;
 bh=hiXO2exgTHBuB90XAfpQ+deEGTdKQ9fQRe0fpPJht3Y=;
 b=DZ3K4AcqtMDAmTGnAonfznkSHt0++aWWVIBASbFeIe2R6NgsjNoY1s4+Xy8amvu5++8t3PqC+
 GO4Q2i87WXa9otBK9lHndJAFBLY6L+PsuBbOtZ1G+9TKfa2UR17tjP1BWLqNMltxByB4FZ+5pId
 9/zf66Iv6AmRDlf3H88DhXtr/b9EBWulx8UZXqaCjXvfgufkIofT3WUTt52CKO3gb4/ebGhVYm5
 ItV6KS5CUmg6kb1lSS+M+c61EmKIPMU+8eVAmW1AUtLgd+TQBMLHz2HBMYE03O9SoszYKn2JRja
 oUFv0WSa2RIJztd4QNvdzB0xYTIRmehznRHuNlGVGXSg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=DZ3K4Acq
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

This series includes miscellaneous updates for RK3506, such as:
- updated default load addresses to support small memory SoC variants
- request use of 1.5 GHz saradc clk rate to avoid field truncation
- changes to use FIELD_PREP_WM16 macro where appropriate

The series depends on following patches for a clean apply:
- clk: rockchip: rk3506: Fix trivial clock configuration errors [1]
- include: linux: Import hw_bitfield.h from Linux v6.18 [2]
And a branch with all depends and board configs can be found at [3]

[1] https://patchwork.ozlabs.org/patch/2278946/
[2] https://patchwork.ozlabs.org/patch/2280368/
[3] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506

Jonas Karlman (6):
  rockchip: rk3506: Imply OF_UPSTREAM
  rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
  adc: rockchip-saradc: Add driver data for RK3506
  clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
  clk: rockchip: rk3506: Use FIELD_PREP_WM16 macro
  rockchip: rk3506: Use FIELD_PREP_WM16 macro

 arch/arm/mach-rockchip/Kconfig         |   1 +
 arch/arm/mach-rockchip/rk3506/rk3506.c |   7 +-
 drivers/adc/rockchip-saradc.c          |  10 ++
 drivers/clk/rockchip/clk_rk3506.c      | 208 +++++++++++--------------
 include/configs/rk3506_common.h        |  14 +-
 5 files changed, 117 insertions(+), 123 deletions(-)

-- 
2.54.0

