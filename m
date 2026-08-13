Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D591BC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA92640A0E;
	Thu, 13 Aug 2026 16:56:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xlIAmI_3GCsM; Thu, 13 Aug 2026 16:56:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5C9540A11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786640163;
	bh=eqMXAZ3Xrr5y6Uq8mrXM+1cmg8kQywEQFznlrcSrhXA=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=V5H+WRBJvqgnncebf6Gfs7CWVZFDb8RPMg2nIU4WT8v/Mhh9VBD+CC5fbTmOO8fvE
	 NktIaAFnEyXkV5kKw16zybNjxZAO5MLLtnyyHvXzeBCWp3daqxjHaDG8U93bw49Tlq
	 oMcm79RFnyKnwYULiyLmVs7/Smd6bl2ETxVuPKmsQ+tU7BhcEm4SSccXEhnOhB5lp6
	 Osa3t9IDJCK7xpDc/YiBrlbb4HSHgEjL0k6jFWIHErfzVCMmRSx8WboWLxiYQvP3lg
	 MJrsN7p94FR0AhNZ4h7dH+3NRxiE7BZlK6B3idiGqkXICEWKziWm2DoGAQ2eIfWAgM
	 KQhiz1fo0CDog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5C9540A11;
	Thu, 13 Aug 2026 16:56:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6608E259
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6414B607E0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xnApSAl2XzZS for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:55:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::42af; helo=smtp-42af.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6F6EC60643
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F6EC60643
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::42af])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F6EC60643
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:58 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLWhT5fHWz4SZ;
 Thu, 13 Aug 2026 18:55:53 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hLWhS59rlzhvG; Thu, 13 Aug 2026 18:55:52 +0200 (CEST)
To: Elaine Zhang <zhangqing@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, 
 u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
Subject: Re: [PATCH v2 0/5] clk: rockchip: pll: fixes and simplification of
 maths in RK3588 frac PLL
Message-Id: <178664015269.342950.1712367507580834416.b4-ty@b4>
Date: Thu, 13 Aug 2026 18:55:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786640153;
 bh=eqMXAZ3Xrr5y6Uq8mrXM+1cmg8kQywEQFznlrcSrhXA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=NdFwv5qFNGHweeFTib2Kq3MIi179UwOPKK5BFKjhM017IH3ZikSDLfyJOlnQC3jix
 xO6Ttejpn1c81e3WKGd9E/Ol0K1Xl8zY7v0dkHq0ZOs7vqiMcgYV76DGzjiyvQw+qh
 hIEZWIMmpq8yYMp9sbC5f3ijgN0lLcUz7UKyvwycGS2bvlZj4+o5+NSYE96IYAzTwA
 VpeaT3+xn82m9/dNdHloOf9vKun/WaTUeMQOvzLg0SSaJUKOsgwEw6Flf8PXNTaQqM
 wUK7Co2i+4pWAGTOrlDVCxSLBoD0KUlR5TWEppq2A8erXSleJwU8WhUOb5ZKd1epqg
 slruEJID5W3EQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=NdFwv5qF
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 23 Jul 2026 19:04:22 +0400, Alexey Charkov wrote:
> Current fractional PLL code for RK3588 (also applies to RK3576) has two
> issues causing it to overshoot the requested frequency for some negative
> values of the fractional coefficient: one due to rounding, the other due
> to treating -32768 as an invalid value where it is actually valid. It
> also overflows the calculation of the fractional PLL rate when reading
> it back, causing the function to return wrong PLL frequencies for non-
> trivial values of the fractional coefficient.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/5] clk: rockchip: pll: drop misleading fout in rockchip_rk3588_pll_k_get()
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/e5b3e6fd45ceff28a3cb9834809acacad82aa585
[2/5] clk: rockchip: pll: fix rounding of negative k in RK3588 frac PLL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/7a3ef6c21fdb4912779132e0dd93fc59da7d6357
[3/5] clk: rockchip: pll: fix RK3588 frac PLL result for k=-32768
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/ffd377597b57bc83709a5d5200d0e15fdbbba5c6
[4/5] clk: rockchip: pll: let rockchip_rk3588_pll_k_get update m directly
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3bc88868c237b7b40d87d931474c5739f76b2d13
[5/5] clk: rockchip: pll: fix overflow and drop manual two's complement on RK3588/RK3576
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/f75a3d96e1f33c1b8737018843b7bd5fc207b9d4

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

