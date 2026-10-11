Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73D6CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10DB080BDB;
	Sun, 11 Oct 2026 22:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHz2yUh8SDFF; Sun, 11 Oct 2026 22:29:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D70280C66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757792;
	b=F0aTB7azqMpndvZWXrFHq8dLKcDgsi/wJC+ccdsLWM8+bHxA81dNzNbBYi1gMBSE4Tkw
	 XU4DTprIMGZ3RzR3LRtMECt2vbAJJY9aPDSM9u5VEN2BHPpz/D1QqMJoZmeFKko4L/zY1
	 nRkGzxXCtgOrseKcGGb93XpJWEl2NDABrmajx00uellM78LsGquRGTnFFn8GXJJeAODgo
	 KpWlo+Wx9Pt9rMp5ZSisRcMfPHR+hjQVeSqtet7HGaJuBQ4hFUUlErxwEuIrNBnGVH5Gu
	 9xNW/xakiv4GXaA1Epv3EzEBrYaJrdrT/+iF0Zd/HThdpazYlq5f7e7ubJLbyh9qHog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=37JCQ1hGPpWaR6zL/gdrXn5RcbtfQlDq6KNlHmM8+i0=;
	b=Qsv/2wYKEpA6OuAFesq8dUPfZskBVbv61gk1LiGIbtkmiu9oX0zVTis9FVZ6ICd42C9z
	 2SYmgiFqBZ6WDKWSUOwNDuCvx843aeXyPCsrVn5OchE57tPiN23yU6L6rrCbfa2cJs/1Y
	 VYVEiTs3BCifKNS2SnT3fMXWLiA87TMjmXlCY1an9PfZDRril5mBksGx0N1nhuH9DBAXg
	 is71xBT7JNIC3QdMKM1DSbKBqxLK5g4/JMMtSPheu3PngoL5JCLWV4y74rcUEK/TfHK1a
	 0qwhkhwOsHycQ9tbcKW8MMMHS458atxdP2cNZiOaAt4z6Zk4YvNsIhNK4uce0MxKqpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=dOTd0n6k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757792;
	bh=37JCQ1hGPpWaR6zL/gdrXn5RcbtfQlDq6KNlHmM8+i0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P85j35/v+Qr/PSK0a5wKYyQHBluye2cPv8WrLRHp+s5CUWWtcLGJHMhPQyQxFV/1a
	 s0/5ar0UYafryjvBTv9b94hlgiOUu6X4+cIRzONgc5s+CQglw14ZZopfObo7wTNdKY
	 rauOr393oHrGHcvSwwPtPW1V8DskOLy/7vKCuDpVaFsBfTDRLUVj0x0APqp20U+k8N
	 gWSkgNfO2jsJDxiPIj4DHE9UrVKBN7UWqob0IgX01kBy/D+9I5Rbqys2ueQRW8uado
	 NZqXssLbFN3SaRVISdT5gyviUSm0sxdA9MDfEfhC8YGCuboRusEENsL0nSzEsd61lY
	 VFthVPBCpuW+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D70280C66;
	Sun, 11 Oct 2026 22:29:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A786194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 508B780C67
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYUOVybXeP3w for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:29:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B7D780BDB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757789;
 b=GovQ5KkcUSokgknLogiS3AsYS2/2pp5m2Bx+HJbO83cwddCadfHPC9azwd+D1XoR8MQt
 NrK4zRFEyTBoyXxvzpnBjmY45+qTgIh4dUo8bYjHBo5eTuza236luOJ0TgqCPPLXelhrf
 jo0Fxe1wJRI7+uzBIgWdbMXQ6EcKsFoiHOtxnQJLWwEg5qcYbtzIluimtRjKlAnJ+D2kx
 PBWn4Yczikh+eorsWs/a/OCXg/3V8D0juLj8qfe5h9mhIFG7+Kn5kPI6fL7QPlDeihx9o
 478LOVPi0KGNAFgXvvSsm7cc4bNZJx5M4O5riuCOFol0IIJurKMxwlGhKwGXsMHB/pA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757789;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=37JCQ1hGPpWaR6zL/gdrXn5RcbtfQlDq6KNlHmM8+i0=;
 b=sI9oq0NbQPMX9CNzSkmEE9dRcAWlVe8Ap0NT8mxFm1KMZzul5zYWKry3KWKFAaynTVBx
 7CZaCTLQcwIE0xx5V5LErxvHye9ePbm/NfReMPjO0YMXEQFxkOPVemmZd6+CYkqFYZwfB
 Uq032Z5YKU2AKErGfy6oICrgr3gIjAV1FQ4D7DEbmTlXF8tC4Q5w2SIc4sJCnLlnWGp9b
 JvPBoXCMzA+OE+8CYWVAnVyCnB+pYIdeguma9unHSyRe5JY8WqgDKUXHclPErhD07KUgY
 hUZh5DyqtVlg5OvZTgxgZMRqLnVGWFhQVut9f6v6vAGvnbJhOE5RtqqLjYW/hta2iyQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=dOTd0n6k; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=dOTd0n6k
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B7D780BDB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1791757787;
 bh=37JCQ1hGPpWaR6zL/gdrXn5RcbtfQlDq6KNlHmM8+i0=;
 b=dOTd0n6kl7HU+pN83nBP3X1ap14TkuISWbqtTh1Rp51p+C5q0VRHRhXy4XgioZmOhF8rj76bc
 Ne52FSCqEDwJVSTa2y8ERUKbGhHERPYV5a0hUckGgjkT8rWwwv5AdiPI7ASGuh1Pq7SxT9awDc6
 lmedukcbfD9lYwmCMtUigQaqxaRWhLlzyFNUGI6VF5Av9rNQYJ621w6UtkDYMtnWxjKO8Y6CSSu
 qsiI2RkukXTysQKiBgYW4SvgY9jtwCYkHdDm5DUQjqvZWnX2pRbe9LO+k31UO4v0I0IPNEwj84F
 6WcwsUyEz2oAWa/3a9gI0pgMKoXj/nJ7HDyYWlaYtB/A==
X-Forward-Email-ID: 6acc0dd14548822a24c17295
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 00/37] rockchip: Miscellaneous RK35xx clock fixes
Date: Sun, 11 Oct 2026 22:28:35 +0000
Message-ID: <20261011222930.1085075-1-jonas@kwiboo.se>
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

This series fixes a few trivial copy-paste mistakes and other misc clock
issues for RK35xx SoCs.

Some of these fixes have only been compile tested as it involves clocks
or rates that are rarely used in U-Boot.

The 'special pll handling' should ideally be moved into clk_rk3588
driver, something that can be done in a future follow-up series.

Similarly, any refactoring has been held back for a future follow-up
series.

Changes in v2:
- Add patch to fix automatic PLL fractional calculation
- Add patch to request a working rate for saradc on RK3528
- Split "Fix trivial clock configuration errors"
- Update commit messages
- Add fixes tag
- Collect r-b tags

Jonas Karlman (37):
  clk: rockchip: pll: Fix fractional PLL rate calculation
  clk: rockchip: pll: Fix automatic PLL fractional parameter calculation
  clk: rockchip: pll: Always write the dsmpd flag
  clk: rockchip: pll: Always write the k parameter
  clk: rockchip: pll: Use PLL_FIXED_MODE flag on RK3588/RK3576 PPLL
  clk: rockchip: pll: Limit special rk3588_pll handling to RK3588
  clk: rockchip: rk3568: Use correct clock id for GPLL
  clk: rockchip: rk3568: Fix PWM0 parent selection mask
  clk: rockchip: rk3568: Use PWM0 divider shift
  clk: rockchip: rk3568: Use correct PLL rate for CLK_MAC0_2TOP
  clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
  clk: rockchip: rk3588: Use correct PLL rate for SCLK_UARTx divider
  clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider encoding
  clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375 MHz
  clk: rockchip: rk3588: Remove redundant PLL register macros
  clk: rockchip: rk3588: Rename PPLL register macro
  clk: rockchip: rk3588: Align BxPLL entries in PLL table
  clk: rockchip: rk3588: Use SPLL_HZ constant
  clk: rockchip: rk3576: Use correct mode register for VPLL
  clk: rockchip: rk3576: Fix ACLK_TOP_MID parent selection
  clk: rockchip: rk3576: Fix I2C rate selection
  clk: rockchip: rk3576: Fix CLK_I2C8 rate change
  clk: rockchip: rk3576: Use correct clock register for CLK_SARADC
  clk: rockchip: rk3576: Use correct TSADC clock register
  clk: rockchip: rk3576: Use correct PLL rate for UART fractional clocks
  clk: rockchip: rk3576: Use correct PLL rate for UART divisor
  clk: rockchip: rk3576: Rename PPLL register macro
  clk: rockchip: rk3576: Remove unused BPLL register macro
  clk: rockchip: rk3576: Group LPLL register macro with CCI macros
  clk: rockchip: rk3576: Align BPLL entry in PLL table
  clk: rockchip: rk3528: Return correct rate for CLK_PWMx
  clk: rockchip: rk3528: Fix VOP clock configuration
  clk: rockchip: rk3528: Align PPLL entry in PLL table
  clk: rockchip: rk3506: Return correct rate for CLK_I2C0 and CLK_I2C1
  clk: rockchip: rk3568: Drop unused GRF syscon lookup
  clk: rockchip: rk3588: Drop unused GRF syscon lookup
  adc: rockchip-saradc: Use 3 MHz clock rate for RK3528

 arch/arm/include/asm/arch-rockchip/clock.h    |  2 +-
 .../include/asm/arch-rockchip/cru_rk3568.h    |  1 -
 .../include/asm/arch-rockchip/cru_rk3576.h    |  5 +-
 .../include/asm/arch-rockchip/cru_rk3588.h    |  6 +-
 drivers/adc/rockchip-saradc.c                 |  2 +-
 drivers/clk/rockchip/clk_pll.c                | 75 ++++++++++---------
 drivers/clk/rockchip/clk_rk3506.c             |  2 +
 drivers/clk/rockchip/clk_rk3528.c             |  7 +-
 drivers/clk/rockchip/clk_rk3568.c             | 12 +--
 drivers/clk/rockchip/clk_rk3576.c             | 26 +++----
 drivers/clk/rockchip/clk_rk3588.c             | 35 ++++-----
 11 files changed, 82 insertions(+), 91 deletions(-)

-- 
2.55.0

