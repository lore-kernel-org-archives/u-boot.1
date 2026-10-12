Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22D6CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7178680D1E;
	Mon, 12 Oct 2026 15:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ev_AJxGoKUD1; Mon, 12 Oct 2026 15:06:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4CE480D47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817560;
	b=EJXfaioAcM1ZYwcfiMB7dhYnEN8ozhy07RoO2xUAQ42naEnIMU9KfIq6vyNKeRUCb8o8
	 epwQYidzAoijeVZn+tATgrkMVpDWu5qv7jmMy3AKY7sjQ7tIHyWWfxDQbS1AwAtHzXzNU
	 RvISOGCqnjzyzqdGE2/ShItzzniLOTSSu9vWILgoC0Zw6QtXZO5Czy/MFk/iVTVppxOee
	 njtb+/ycIuaYRZxiAR6GLsI53NuHkiUJqCputJkISaOkuMxMVm+lTNm/HQPdi4zEFj2IC
	 pjaQ5Wq0VHCwkJ10+BOafUbnLT4UAbyAV3hXeKJwzJouK5A2hGcRtrbZfCd352ZddOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UZo41OklysJk1ah3twTgeD7Qkx3kML2zsBc8i+w9qWg=;
	b=YdFNDZ7AYAhX7e/SgGtBzZMMguuh6IDiaIdYVSK1YMbpplmanUA9eMMl8jK3yfADEOG2
	 uUQo1BUBEovBcGWBMezLKxWgjnAXX1SZ4A8EzHjgeWTStgJvr7/ZMi+EUFXxhsv4bYfXD
	 YiWDh75hBRg8ki33Hr7+6IYDjtu/F/LP/KOsEVD1O//SXGJto9sgfHVcyeiqFaRA6SZJn
	 wqzm8tlaNruV5xbLDb7YEM6qGgd/0CtY8FVFN1CgDTD+EgYUd3Kcs6D64t75qXXHFGk7D
	 k1Fy2tWS1JDduhpwbPPAB+vgyWOYDIWkmHNbJ0+26bJq0byEikX3hMz+GKHJ/OiSpfA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817560;
	bh=UZo41OklysJk1ah3twTgeD7Qkx3kML2zsBc8i+w9qWg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kRClt+HUWA8r71mr0k8smd7OWoY1DXZiz6bTpkuRNH1M3KznfQhfwg7vZYNM8yGp8
	 8HSYGeqnY//Rg4fQlEUSuWeK8qo+AV42QuQvu2B5c9gqiPOSNv68WTQ+mIlmqZDma2
	 7T95vTvvvjsfvEbeWCaZh3V8l4e36QhyRhWCOax6DUkYJVY7EM2PaDFKc1LbEIAtlv
	 6WRKAil0sV7BAkQI8HS5fSrP67AIQmMkUtk350HwnfE7SnRDRKQ7vBxXesJmxXYLEJ
	 gJejyNE1Sc704k1FBEaXnwmQkbLAMnoc4ttEvOpP/8xGvjFg6vTOAF6QYnDLxSOPQP
	 U0/obgExanEBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4CE480D47;
	Mon, 12 Oct 2026 15:06:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14F9CD5E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0349A6064C
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RfQgAn-V-_xM for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:05:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E28B4605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791817557;
 b=DKrQ++QNYcbtIYJ6Zod8hlB00tbi9gQ+4UrTZxIXE0IQaac+vUMhvYOvd5bI2gzWAXLL
 N6Ur/SJnUXJanMMYLamIuR0qHQgrrt6Lr0eaD0frR5WNyePMXJokAcbXa6zlLlto0bbcE
 ze9qDaQfWymmMoFGXnTyELwjnj7XPkhCuKLuetaqWI+zbav3ADt8/nYI1jg3S2DgHQdp1
 TzvmF8fnWLIgbrDJW8QdjaMn7gp8FBkcygNdWHbVNy7ZYvEj4hTdoTQbo6WJr0fGhfuqB
 uoS77RO1gDUsWkSdtIoUo8aoj0XncZcFgp/KkpkvP2vEZHCQ5+j0uc6qs2aTVHcQuNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791817557;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=UZo41OklysJk1ah3twTgeD7Qkx3kML2zsBc8i+w9qWg=;
 b=K/JGm9c7mSyVjBT8VppQBhwzzN7nmXGQPA/iQ1ucdNdlOg9yTpYk6e7zZweBeojzMpcU
 iv/Az5cYL/m2Oe1Y/YuBqNXafeuS3LvIPpb1lxmnung8gryPbrIB1lIOubrWkaUQa33bt
 20MwI0n4pGO1GMh6AZkRopQq1jOYh6e3ZhRPvSxua4bAp+F9oY7pf9MV/7kQNtMZ6PbfR
 nQgKHcbdE0jirVw6x0JCGNYeyrowV9MWJVMgEajGnOKFY2a5Oo7nkoNcvLKbZzMDXB7H8
 1Ze3GWjA9o5iNtGBGe1T9QR7FsC8pEl01m7MdABrPRs08lYroSB/lUN8lJ4nerVYuwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Img4Q0lc; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Img4Q0lc
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E28B4605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1791817553;
 bh=UZo41OklysJk1ah3twTgeD7Qkx3kML2zsBc8i+w9qWg=;
 b=Img4Q0lcNawjBBWVZUtX/xty8dnXqz+lbhfBRR0u1dA5NQOJbaQtimi8zjqHgeSYuQNIQdLQ2
 pRC+pLapjkCgcSXVF4DSAc+VZbB8nqa7lmRM90SpFAJBgoIwhMs7y0cTS9g5rl+Tc1z4pb9vXPS
 vQgx1FD9w57qK7oGeuYfO+cdLSMIgSaPk4qi54a3WhPL2w27e2QBoOcXdhSwOMblQ/qcPT5hBxl
 n+aHg1sREtJvFuofCGXw1xfpR26qbF+CIbVoxdEAvHh3JPVRbZZ4guPSuis+AzwMgl9LIjaYwHS
 /xdbwkmsxRpVBURP9ed1q4l7BciRZjldl+b+qsVee6Aw==
X-Forward-Email-ID: 6accf74b8ac7302d53a2c8af
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/8] rockchip: Remove unnecessary clk_set_defaults() calls
Date: Mon, 12 Oct 2026 15:05:30 +0000
Message-ID: <20261012150542.1182209-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The driver model core and clock-uclass will call clk_set_defaults() to
automatically apply assigned clocks for devices during normal udevice
lifecycle.

This series remove unnecessary clk_set_defaults() calls for Rockchip
drivers. These clk_set_defaults() calls likely originates from vendor
U-Boot where driver model core calls to clk_set_defaults() was removed
and moved to just a few drivers with claims to improve boot speed.

After these changes any CRU assigned clocks is typically still applied
two times, once for the clock driver and once more for the reset driver.
A separate series to introduce a driver flag to skip clk_set_defaults()
is planned to address the unnecessary apply of assigned clocks for the
reset-uclass driver bound to the same DT node.

Jonas Karlman (8):
  net: gmac_rockchip: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3506: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3528: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3568: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3576: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3588: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rv1126: Remove unnecessary clk_set_defaults() call
  clk: rockchip: rk3308: Remove unnecessary clk_set_defaults() call

 arch/arm/include/asm/arch-rockchip/cru_rk3528.h |  1 -
 arch/arm/include/asm/arch-rockchip/cru_rk3568.h |  1 -
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h |  1 -
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h |  1 -
 arch/arm/include/asm/arch-rockchip/cru_rv1126.h |  1 -
 drivers/clk/rockchip/clk_rk3308.c               |  9 +--------
 drivers/clk/rockchip/clk_rk3506.c               |  6 ------
 drivers/clk/rockchip/clk_rk3528.c               | 16 +---------------
 drivers/clk/rockchip/clk_rk3568.c               |  9 ---------
 drivers/clk/rockchip/clk_rk3576.c               | 11 +----------
 drivers/clk/rockchip/clk_rk3588.c               | 11 +----------
 drivers/clk/rockchip/clk_rv1126.c               |  9 ---------
 drivers/net/gmac_rockchip.c                     |  4 ----
 13 files changed, 4 insertions(+), 76 deletions(-)

-- 
2.55.0

