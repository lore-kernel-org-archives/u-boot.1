Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D0606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YyGq9Xz5;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=H+4QotVt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C717840742;
	Tue, 17 Nov 2026 11:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxD0Z-KIrfDF; Tue, 17 Nov 2026 11:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D98C7404FF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794915455;
	b=OMyGOWDnmcuj5AhRh1U1HkFCReKU8m3hliNtayevK2IfWs1Dpi3kTdTz788+2hmTFIrQ
	 2daD3+uvYrHyDVRen7UmJmT3at0+nu+eCT3HnqLhxLXzl49DeXzJlyiftFdvuqOV6BttL
	 aILQzmsipfrEilS/iLjs65YLo9J65kjkCJYLQoiDv9l9lvdD4E1hyJ/pukrVZCExl2Un+
	 zmWmsm8+SS8xjmRs6vX+tal62Syiu6e4hR0NdSL+TjeF/XApaFoK731LmXIZcNGkZkSpH
	 AWiLpzOzZl0eO3yJypIA7cMAuhkmQneZj8lw14KYTRLpQlyXRF0Y2f99HRiy38ztIow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794915455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0mV+heWfw1ZjzmhUmzUnKFlZYHARs6lkfc/NYXbGzi8=;
	b=p1VIN0NG7jBcR01ihQ/39Hy8C12MuTdkxZzmDB8lf1VPZUJfAg609dmW4ujDhTzZDO+d
	 IArQ108kf7t0NiKV+Y+luAEqhyUBUcfEJKRROHeS296Zmn9J2X9T+IrIf/1OEmskykOkY
	 GKIkOxlphjFHRUVTLxXf49X54Hjqt9R/OstsOElQ3D69xyGxoJvApyVrM1F1C6oKzTJ/N
	 cjqoBh/s9gSYAP/yk6zTZ9C/ma4FPlzzuRsNAu3Ehzwbb/uRJ4QshNSX/neG1Uvd2YIT9
	 4hv1k0OuD42Sf/riC1R9kmjkzAKl2kJ29kHX08nkMRBf8A3orxevqvcrwsvSgU5tzgg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=H+4QotVt;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794915455;
	bh=0mV+heWfw1ZjzmhUmzUnKFlZYHARs6lkfc/NYXbGzi8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YyGq9Xz54MSl8rVTlyqNs1EAs70nFnGYnsVSscxmIyNZwEb1pmWMmHtYgC92Xpm6L
	 Yc2oBl7VqP1JJ/fYiYJiTfzpytM7IM2PuAhqnxa6RgK1GXcYiCjxxRliDE/QoAdez4
	 L09QHFMO04qggbNBUXmG+uUEfhLlKkvnJxamNxx/6xcwynDjeETuDUlo8wUHevVvng
	 /ZihvNbjaeDnSPHaUMHov00vDFTEhdiAPz1ikgsOnuayIOOmEOyMTotXxM4paOaTk8
	 6gXW2vLUtMnLc41tfoZjRiUs7MqI6k2yNV2cn1Yh5TIyUCjJ54L+Kvdyh8FejQ0omi
	 mAUaVV6n+T9EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D98C7404FF;
	Tue, 17 Nov 2026 11:37:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF88570B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5C6A4050D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zTOl-b68AhY2 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78313404FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:d548::190d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::190d; helo=smtp-190d.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=H+4QotVt
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::190d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78313404FF
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:28 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTN4j29czzncf;
 Tue, 17 Nov 2026 12:37:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794915444;
 bh=0mV+heWfw1ZjzmhUmzUnKFlZYHARs6lkfc/NYXbGzi8=;
 h=From:Subject:Date:To:Cc:From;
 b=H+4QotVt7psNNgaTFod6ur8x3t0BlOGvKrEVYhVlbqRo/OPuSXrDQ4KsSB8Zf1gLb
 jI9WCHonKpjCY1R2CWwlVt68GHSnGI99bta09yu1idrfON3ZDlf/pu0KPy91wuiowm
 z2Ex2bhX8oMUNa9S2Zn/vEX2EQ1H/6kcKFloJeqRfM1d3qBs3U3v/39m11kBCTr/0I
 Fbjijzdf0f/u6Zvlk9RktVCWNH4xQwe5DZZPh3/WyQUASDZcvDJsyXKN722f9DgK8/
 WuXtlbM2WXAfZFHmXDChauSRaY0DlIlVoHUSUpj446rWxH2XLF0U8NADXQxu/YAyLx
 lD8TEeG93JAgQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTN4g26mqz7dF; Tue, 17 Nov 2026 12:37:23 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 0/8] clk: rockchip: improve
 readability/maintainability by using names from TRM
Date: Tue, 17 Nov 2026 12:37:09 +0100
Message-Id: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCMBAF0KuEv+6ACWIwVxEXafqrsZrKJEqh9
 O6ibt/irajUzIpgVijfuea5IBjbGaRrLBdKHhAM3M4drLVedJJ0n6Rna1RJc5ESH6yyH+h8dOP
 R+ojO4Kkc8/KbTyhcGs5/ra/+xtS+KbbtA+93hJmBAAAA
X-Change-ID: 20261117-rk-clk-better-con-names-4de27a2f917a
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Rockchip clock drivers use macros to access configuration registers,
but they use names that don't exist in TRMs and it gets cumbersome to
make sure we're not making mistakes by having to do maths all the time
to figure out which register we're intending to modify.

Add and rename macros to better match the names used in the TRM.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (8):
      clk: rockchip: rk3308: improve PLL_CON() user friendliness
      clk: rockchip: use simple formula instead of hardcoded offset for PLL_CON()
      clk: rockchip: rk3506: improve PLL_CON() user friendliness
      clk: rockchip: rk3568: improve PLL_CON() user friendliness
      clk: rockchip: rk3576: use proper base address for SCRU
      clk: rockchip: rk3576: improve PLL_CON() user friendliness
      clk: rockchip: rk3588: improve PLL_CON() user friendliness
      clk: rockchip: rv1126: improve PLL_CON() user friendliness

 arch/arm/include/asm/arch-rockchip/cru_rk3308.h |  5 ++++-
 arch/arm/include/asm/arch-rockchip/cru_rk3506.h |  4 +++-
 arch/arm/include/asm/arch-rockchip/cru_rk3568.h | 10 ++++++++--
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 15 +++++++++++----
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 12 ++++++++----
 arch/arm/include/asm/arch-rockchip/cru_rv1126.h |  9 ++++++---
 drivers/clk/rockchip/clk_rk3308.c               |  8 ++++----
 drivers/clk/rockchip/clk_rk3506.c               |  6 +++---
 drivers/clk/rockchip/clk_rk3568.c               | 16 ++++++++--------
 drivers/clk/rockchip/clk_rk3576.c               | 24 ++++++++++++------------
 drivers/clk/rockchip/clk_rk3588.c               | 16 ++++++++--------
 drivers/clk/rockchip/clk_rv1126.c               | 12 ++++++------
 12 files changed, 81 insertions(+), 56 deletions(-)
---
base-commit: 6201222134cd704b5717211fc917e2ca6263577a
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261117-rk-clk-better-con-names-4de27a2f917a

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

