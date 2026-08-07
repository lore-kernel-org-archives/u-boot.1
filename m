Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB0CC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D8D0812E1;
	Fri,  7 Aug 2026 19:46:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I3HUtna96qP0; Fri,  7 Aug 2026 19:46:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 833E8811EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786131980;
	bh=6jvzYLWxHOd/WWpAeRnHILx/tmcuJ2Zobat1wF3dzg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ff1IbwhkrbCZH+lnac9JqOC9F1CGXF/RXNI6Iz00MTlPSpYnimP/5ErpTj/AYjU5Q
	 Eh0FVFPFLVAuWln4vVlAVDqVUCVaGgyg0ExHhGHz6yFdk1oDi+RxMrvjm6Efl0+DSh
	 JI7/obOm3wDGgU7nMrcVWN1H7j4MWnWjX+NxofhqE4bEybFzkEOEh/Q3EsgbNZxR6N
	 WNxjO8NQeaewcfMbmyml228buF0BmfzuHiRiyXMX152lkP0ByqZu/A9lfyH0oSueYW
	 SWqfKmPPGpEu0wdQjpep+TXnt6m6X24Sf+tEwO/u+Bx0h49f9gCr3Hg/WzgU0UZ4oX
	 uprhgR2jUuIyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 833E8811EE;
	Fri,  7 Aug 2026 19:46:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8770F1AF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 791A840933
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v9vjMyRhnAMq for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:46:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 56DA840738
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56DA840738
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56DA840738
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:46:18 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a17f91so5910647a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786131976; cv=none;
 d=google.com; s=arc-20260327;
 b=jpK5W5gP3iJyC1S81/vrDYr3Cx59yuC310Lnb2rCss2O5DqLSIdnG4E+hvWOB7osVY
 QnV3P+OcQygvcGioYv3UAtlOwzEoA6dV1y5TCxRvXKrnpoVVNkvosZKLc2EN04zY5S/r
 fL0PwWRQMGJqDVZZAFDUSdTTPEdMdqsNk5toxQK7RZl//9uVS37IuASdfgKHUO1r5sdS
 edA3CbyncNU5STLJGx7P2As0JmqiR9VgE5T3dQYEPsjEnuS71F5uffqpWT/tEbJY4CG6
 cT5xX2Hl47UlKu6CAsVk5TNgToypOEGqU8NYRqojCUurDbYE43frccbhKCBwivXpoIDj
 tECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6jvzYLWxHOd/WWpAeRnHILx/tmcuJ2Zobat1wF3dzg8=;
 fh=rXJc1Kgq0OIN/ViOgRBXampsHJIZFiegz3Erg8+xCuk=;
 b=GrV6o8kOquIFb98DPuQ6jtl4cHLbUwhjSU0/hRVqRqN3BK/ijaU5x8TZQoDq0yTmCs
 aBCS6mgJs9M9ELX5eaVVPomstOVyMSLc9uQ2V/bFqLQYFvBEfcGOFV89f0Dq1wOahg25
 gmu383oBB6d13ankWA2LBDmGdidHPJfcrUp+Qsg68Ep/pX1LYlq0/e1KsiSYc2W+lscG
 dpHhBrprtRIUX47kOJUsSja5p4sjaFXeGWTmu5EEXQivu7+NLi4MhHDokYJKua4bI0sn
 NktVYE2mfQFqVhg8Xl59dc1EVcbacYHo+eipLSlJBcX8i/tlp/e7tdrgaMrTopr8yvPp
 torA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786131976; x=1786736776;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6jvzYLWxHOd/WWpAeRnHILx/tmcuJ2Zobat1wF3dzg8=;
 b=aWKRJt/x+jdkJzeArQaACfuJNknnSXF3cVAQspBYihA9YuOpLcuop7u8rLZ2IaMluR
 50DZyfhIqS1Htl3TSoJSYxJQjLdRq3sxzhALcz1YYCtmGYi4AtwWbByG57Aqb9nDc1VP
 6UfIoMlEXVorBOpOSSS5I2q6Zr7vHxCeN/rQuH2A9js4a5ARe8QLXUgruD3aeFxarDkm
 a2cer38LsF3fD3xcgMP3guAzhV0+5s+XupcTL5UwE+bQ9Q4G5qgfn+ErEQdTFrPSRHLF
 v6zXyiEGrcLgRphsR57p65T/K5Ue4melgYbRkbIF9JFu/Qinm5zpaax1lpeuTra7DBZI
 iPIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlsPXWH29+sj+QeMhNJT7EKNB1Xu13V3QXlKpqpYOfjiDv85tJK33Jne193Yf/bZGJCjiy/Fg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwMWvT+5g37CRueWQphRhtUOIl0BbYw86AYfYoe7zNWAAGhrg3s
 0pJto0/VZY1jkm5na2btLsAkRo/tAppPyWM1g7XDT5iEJdqVyskL2lSnk4k2kWmvh3X7X1Eo97R
 14ZK1oEg3UXku4pwwULBaYZSS0+i1Tqctub4S/5DI
X-Gm-Gg: AR+sD10LNgrBe6JhzW+ymdqiCknV2m4XVER+MIXhDn67bPVseWq0N2RuZ4F+zCC8gTb
 u2427c9ldGuEOTBxE9YIzsnA/1/L5elCpunVlFcRuGr11SPhzt3Wh+oOTyeDQGuoDdYdZo50hfd
 Yu/i2axl6iiQjMnuKRu4fxTLCy7rYRj1c2XJ/m0UCNu5iuBM2kvBGeBAHGdGff/B7KuC94TiPiT
 LvbIPFvpMvA/PbJcjudJMvF+KU4Goo3QpP9KpGlvgYwhQ4IAnkn2V+QA/1pJVE5OUgVxtZX23kP
 SsUkfxxzmHRzdpP5mPcUxe/nC/D9IqM07mBW3fkXeo0=
X-Received: by 2002:a05:6402:5416:b0:6a0:8885:e6f0 with SMTP id
 4fb4d7f45d1cf-6a14f07cfd1mr12833073a12.3.1786131976297; Fri, 07 Aug 2026
 12:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
 <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
In-Reply-To: <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 13:46:03 -0600
X-Gm-Features: AUfX_mxyUFZPCuvHCjqlm7tO1t0ato_NOiG5gPPc-rYz2yUPsq5Dp-aevYbXe8U
Message-ID: <CAFLszTjKMRjF7hmEt6_bbnsRpi9Q=NHidRQC8zv4ToUEpqBarA@mail.gmail.com>
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786131976; x=1786736776;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6jvzYLWxHOd/WWpAeRnHILx/tmcuJ2Zobat1wF3dzg8=;
 b=PqhkWcUYjlnuBzd/smXAUzIztVwGLO7d42NyxqyryztuOAD2l+UWOZ30y4OwpeBZct
 T27trFUi4bvjpZClcN37/eOjW8UhTLGk+8+ZmiW3W8itRGNfghRXVYmt7F+AsKAUq1Kc
 4TjpQqJNh+hR3Bt4yZgbG9wXpNJpPM1Ct1Gd0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PqhkWcUY
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

Hi Jonas,

On Tue, 4 Aug 2026 at 13:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 8/4/2026 9:19 PM, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Tue, 4 Aug 2026 at 04:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> This series takes the initial steps required to try and remove use of
> >> syscon_get_first_range() or syscon_get_regmap_by_driver_data() to get
> >> GRF base addresses at runtime for the Rockchip platform.
> >>
> >> The GRF base addresses are fixed and known at compile time, yet drivers
> >> keep trying to resolve them at runtime delaying some operations by
> >> several ms.
> >
> > I suppose all addresses are known at compile-time, if you have a
> > single device tree. I have always hoped that we might end up with a
> > generic U-Boot for rockchip.
>
> I do not understand how removing these unneeded syscon drivers and
> helpers would stop such goals or make that any harder. From my point of
> view, they are currently making such things harder and only adds extra
> code, runtime and energy waste. E.g. around 227 ms was wasted resolving
> fixed known base addresses for RK3399 last time I measured it, see [1].
>
> Most drivers or any SoC specific code is already identified using a
> compatible that is SoC specific, i.e. the RAM or CLK drivers are matched
> using a SoC specific compatible and seeing how all GRF variants are
> unique there will always need to be SoC specific code to handle the GRFs
> base address and reg offsets.
>
> And for drivers that are more dynamic in nature the DT typically have a
> phandle to the GRF syscon node anyway, so getting it from the phandle
> will be a better option and closer matches how Linux handles similar
> references.
>
> The biggest current blocker for a more generic U-Boot proper on Rockchip
> platform is rockchip_get_cru() and how it currently makes it impossible
> to support multiple SoCs in one build due to how it is used in the
> sysreset driver. Fortunately, I have a pending series that also cleans
> up the unneeded rockchip_get_cru/clk() related helpers.
>
> >
> > I wonder if there is another way to do this, perhaps reading the
> > address once and caching it?
>
> I really do not see the need for that; it would only make things more
> complex than it really needs to be. We should use constants where
> appropriate, e.g. soc specific drivers/code and use generic phandle
> lookups elsewhere.
>
> At least that is my end goal with this and pending follow-up series.

Long delay while I took some time to look at this area in detail.

Pre-relocation is an area which I sort-of glossed over with the driver
model implementation. There was talk about keeping the pre-relocation
devices around rather than recreating them. We also looked at
providing post-relocation devices access to the pre-relocation info.
Over the years we have had discussions about having 'simple' versions
of drivers (that don't go through driver model and perhaps don't use
device tree) but no one has made the effort to implement this.

Anyway, after a few days of hacking I've come up with some
improvements to the existing code, at the cost of about 500 bytes of
size increase. It works by using slightly better algorithms for four
key functions - fdt_parent_offset(), __of_translate_address(),
ofnode_pre_reloc() and lists_bind_fdt(). The result is saving on
firefly-rk3399 of 230ms, about what you are getting. Note that I have
made no attempt to enable the relevant options in TPL/SPL (it only
saves another 13ms), so your work is mostly complimentary.

The key difference is that this should help all boards, not just
Rockchip, plus it still uses DT for everything. Tom doesn't want me to
send patches at present but I did write up a post about it as a way of
providing the comparison. [2]

Regards,
Simon

>
> [1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/cfb736dea37f834e849e54d39fb086c91697fc24
[2] https://www-concept.deinde.dev/blog/speeding-up-devicetree-access-before-relocation
