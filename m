Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569C3C79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 11:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F123380A66;
	Tue,  8 Sep 2026 11:44:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gs-43hhPfigm; Tue,  8 Sep 2026 11:44:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AEA0D809F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788867872;
	b=hgMgswZA4ehXptLNwmfMqR2MsLoddHGcnCa9HLgCs5H4z1q6Xk2fVvYPWMt4+CyRQEG+
	 Bf4eQNyyvjw4QIhGn+BuBjGswxS6oPD/QmfyyuYZdDb+nsSF6MXTNerqFPV7TR09DgU3b
	 YpaMK0TsX6eigwUzGAw0VnD/0JRD3MzpIbWWv45cnd7Ez8WfysYzxvCyalV+21+4noEI3
	 mRzuiYqAszniPYlvTJuWRQN/PktwyBkPF2pEmLIxt6j3kWeD/kqoBydysZ1ZlRLw4gswg
	 4RjUgK0mdTDh2pTh+8Lsa/EpWMj3ENuGz3TAAi/6sWmSouyBp6QvdU0VotTHCNVJh7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788867872;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kNSZi31p5NtdMpWY7xpReadMlrhmkZ/RjCCgrcS3Okk=;
	b=BpgV7mS3sAuIprD3h3qglaMFk4CCkEEncN2syDVQrRGlYaeACs7Ikapwrhv//RT1s+zZ
	 QfaIsheLSQDolCSA2asmugGl5EGj5CzXSNsrOoG0p04uTXdSawv3W5jRVsxC1jfenXVL2
	 AOoF/RuLPCrruE2eINKSCZlCDFWlborLuQ59HgBM+ydIjVe19PgPGmOody3TOvIPr1Dsi
	 I8qSi6ZMgcticWXUHPs9cRttwzzipsHqbbXDaT+EtaA9JD/DvgNh+Dy8W72ARzRo3NdnY
	 dRYd8sb4uPwjlNzYuFpTEuKObEBpC+NdBS8s5ct8JXz+E2Frky2UcJMpTBfbR2a25Qg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788867872;
	bh=kNSZi31p5NtdMpWY7xpReadMlrhmkZ/RjCCgrcS3Okk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HdsSc0T55S0X5Wc4aRAOOQjxE7Xj6cfibudMDqxs+B7WQJGt55O2FQaM4G4UHCo97
	 kQWIaHYxgQN370i7ccPs8WlteakZWGXQCVVRQC9O7lspj2x2+DPROlM9eaP5ZR6h/7
	 /otK0Tb6/jYQhNScuR4SEdQZW5QlvnTOg56dctGmM0vGnlE8vzelmhTpBF0p05CPVc
	 M3RDbtVEHZkD7jMCfCj3SIC4UmJDsaotUQhuzyDeDxIqChD6yRX87zk6IDJypuRkjE
	 KSZQI9oMox9LajBD827g4mt2MRrPbEC5usKnlmNJ6pIx8Bqenl9MTCmEXz4Av9nbTS
	 mO5CJbBw1lIiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEA0D809F6;
	Tue,  8 Sep 2026 11:44:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAEC172C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC736400CD
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9P81OJmcBrB for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 11:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5694E4005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788867869;
 b=VMgfW0375Pu12RQHo/D1oLdAPTB8wxBnq15sHrsOhpBPS9S8BcsRZyLH2mdLej0ib6lF
 zpZAwzDpCoPSnKpBh0W/h7HKCQ80xfE5LZ7DGr4gMpGwt95d/w9DTNdp4H43lo9K5qgqb
 3BBwaKlE7hS9HWAqBvta/FcgneCU3rpwMufbwnJcN+3+DHlN4H0MVF0ecxfJtivZ3Wrl6
 igkU1pX4MBvnNtV8vgTvrJImkUuAnTyWpcrlHJMZEqS/xaE4b+fTrsJEnKQZuVNb24Ue7
 6+KT3DH4eMU+TTdYMPJ9H0qLIXPwNwEdDnzmsCIkII8UdXPo2LNCH0y2qfEzl/eMKOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788867869;
 h=Received-SPF:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 Content-Type;
 bh=kNSZi31p5NtdMpWY7xpReadMlrhmkZ/RjCCgrcS3Okk=;
 b=ZGsAHsZMnC5cuWby5k8mHEtu1f6KYqH0zpsindPZgXOJriSDp1KnNDtWb53Kvw5goYW3
 h2gUEINaFnDmq1kC/ERazFzVvaDO9DZvat6V32psIQsNsjghSAgxyYhVhsdXxtxZce71o
 UZG8qzjqk4/khhvIqLCj/+2A5uf7/VFzmdP2ctpLqnlIMp+QcVMmFFA44PcEQoYzNYoJt
 xpndZ9OxVzk9KcTrqXyKCcmDQuvTb+UIB7BvXNic1CympDJLq2B+ubS92PvjNZG9necwl
 wy6pYugwdu+SmufBDORgBmAuYF4DRXA/rIFBEf07z7uyupqXbMKRcKwI8+lBeYnbPmA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=sntech.de; 
 dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256
 header.s=gloria202408 header.b=U08qsGpH; 
 arc=none smtp.remote-ip=185.11.138.130
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.11.138.130;
 helo=gloria.sntech.de; envelope-from=heiko@sntech.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256
 header.s=gloria202408 header.b=U08qsGpH
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5694E4005E
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=kNSZi31p5NtdMpWY7xpReadMlrhmkZ/RjCCgrcS3Okk=; b=U08qsGpHVYN8aCXJGeBD3YTry/
 Uh6h3y4CmNvmyiwA4yBZFy1JxG4/hBdHt/Kkziy8wvV9Gr7Dyi5UQgu9cuamdrq0haRER1qC8smLM
 71u12+F0GQaCuTCjvprksPcADBau/5w5SvDb2rNufelb40DQ0dKgItnOJ+ljQWJhwpZ/rZta0Lgqf
 1+nMMTAqaRTGFLS8of3llHBN2lXwMhF4ohOuH6fRpFVFi2hgjh9IdeLE739J7cSZm7f7Oqg2UYnN3
 TZnSFpKMTX8QD3iHEwpQcsW8qiuHgMhFGxQLqAy7IPdq91Lhilp6GKfjDTC+HZjtBkMD9+SleaAuB
 qsyaayjw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 00/15] rockchip: Miscellaneous RK35xx clock fixes
Date: Tue, 08 Sep 2026 13:25:04 +0200
Message-ID: <3779575.Y6S9NjorxK@diego>
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Donnerstag, 30. Juli 2026, 16:12:49 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Jonas Karlman:
> This series fixes a few trivial copy-paste mistakes and other misc clock
> issues for RK35xx SoCs.
>=20
> Patch 1-3 fixes minor and very unlikely issues for plls
> Patch 4 fixes PPLL mode handling on RK3588/RK3576
> Patch 5 disable 'special pll handling' for RK3576 plls
> Patch 6-7,11-13 fixes trivial clock configuration errors
> Patch 8-9 fixes less trivial clock configuration errors
> Patch 14-15 remove unused GRF syscon lookups
>=20
> Some of these fixes has only been compile tested as it involves clocks
> or rates that is rarely used in U-Boot.
>=20
> The 'special pll handling' should ideally be moved into clk_rk3588
> driver, something that can be done in a future follow-up series.
>=20
> Jonas Karlman (15):
>   clk: rockchip: pll: Fix double use of postdiv1
>   clk: rockchip: pll: Always write the dsmpd flag
>   clk: rockchip: pll: Always write the k param
>   clk: rockchip: pll: Use PLL_FIXED_MODE flag on rk3588/rk3576 plls
>   clk: rockchip: pll: Limit special rk3588_pll handling to RK3588
>   clk: rockchip: rk3568: Fix trivial clock configuration errors
>   clk: rockchip: rk3588: Fix trivial clock configuration errors
>   clk: rockchip: rk3588: Fix possible divide by zero
>   clk: rockchip: rk3588: Fix ACLK_BUS_ROOT rate set during probe
>   clk: rockchip: rk3588: Use SPLL_HZ constant
>   clk: rockchip: rk3576: Fix trivial clock configuration errors
>   clk: rockchip: rk3528: Fix trivial clock configuration errors
>   clk: rockchip: rk3506: Fix trivial clock configuration errors
>   clk: rockchip: rk3568: Drop unused GRF syscon lookup
>   clk: rockchip: rk3588: Drop unused GRF syscon lookup

Tested-by: Heiko Stuebner <heiko@sntech.de>

on a rk3588-tiger


