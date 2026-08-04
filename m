Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F0CC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9E85606CE;
	Tue,  4 Aug 2026 00:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pTZe1DRDb8xd; Tue,  4 Aug 2026 00:27:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4999606D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785803220;
	bh=y6JE+bmvZKVEGd/damFXZqDMFu2Ulfz1WJKUcX8S68c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bCRwojDHmpgX+5sT1A86etW6g7rR5gdB6ihOt5hjR1z8+T3pg5pFIQ8Qg4vDfPmIf
	 59PgKZ/0JijcyhMCPUrMJoDg4ol5I8uGIG1Wm8saY6kqxIOHFehALMRZof6jEvYI9C
	 EnXsRvK8tKQoQkFg3fbcjDk6p35+1Cka8+JMKBONatk6gFFFNpD/gxP/t6xHqSME3L
	 uEaTWznfkHY00PrTHQFIru39YtBLP+FhdrClEJ5aoyrqy74D7iD1JZYp9SHbUOC5aL
	 w1ZigOWGihWFcX0PksBwiSH2LINx6Prvx/tunr2wyqk3ANa/oslzqKkCqTKSb1zRbp
	 ZrTQN2Rt8P2AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4999606D3;
	Tue,  4 Aug 2026 00:27:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AEDD282
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D75A400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YRfmZlVIUp1K for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:26:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7607F400B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7607F400B4
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7607F400B4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:56 +0000 (UTC)
X-Forward-Email-ID: 6a7131c73f1ab8deaeb03d83
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] rockchip: Always init clocks in SPL build for RK35xx
Date: Tue,  4 Aug 2026 00:26:38 +0000
Message-ID: <20260804002643.2308515-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1785803215;
 bh=y6JE+bmvZKVEGd/damFXZqDMFu2Ulfz1WJKUcX8S68c=;
 b=kfafi1S+VdWSLjegNYBza+BktVLFiERkkWWcpqoFYcmHE8avt+N1F9L2yhzrUe5pLaJGcpJ/z
 lyfCn65kee3tdYSnOE8LDbSsAXRFEG7Uhy/uQDMggm3dQIakoEmOuFqGoVHiYj0KsFb+K1I8LyB
 Skzx9umx0oZrBla8pfGcxicYzXIRyma46ZXBh0fNzLqQj2EdTRSTEJdtkXufkhO1r2Qvj7wMtbe
 yrYrjL5NHxA72pOCsX4dSOrNnxHHurkXETsTvgbEE/8JgexY/NceFuqfCLLl/GWNaAXW2mqho7u
 4o6WXniKQ1DVaBYlvbbLwk7I0DDdL3L9gv/H6O5HDeaA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kfafi1S+
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

This series flag clock drivers for probe after bind in SPL builds for
a few RK35xx SoCs that require core PLLs and clocks to be initialized at
an early phase.

This should help e.g. ensure SPLL is initialized correctly on RK3588 and
CPU core rate is initialized on RK3576 when booting from RAM/USB.

The series may possible depend on the series "rockchip: Miscellaneous
RK35xx clock fixes" [1] for a clean apply.

[1] https://patchwork.ozlabs.org/cover/2278934/

Jonas Karlman (4):
  clk: rockchip: rk3568: Always init clocks in SPL build
  clk: rockchip: rk3588: Always init clocks in SPL build
  clk: rockchip: rk3576: Always init clocks in SPL build
  clk: rockchip: rk3528: Always init clocks in SPL build

 drivers/clk/rockchip/clk_rk3528.c |  4 ++++
 drivers/clk/rockchip/clk_rk3568.c |  4 ++++
 drivers/clk/rockchip/clk_rk3576.c |  4 ++++
 drivers/clk/rockchip/clk_rk3588.c | 14 ++++++++++++++
 4 files changed, 26 insertions(+)

-- 
2.54.0

