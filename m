Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83FBC9832F
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 18:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 599F2409F9;
	Sat, 26 Sep 2026 18:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9B0jinMynQd; Sat, 26 Sep 2026 18:17:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 326F640842
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790446679;
	b=B3zaIcacwOuF7kAZvRmjgfayWb8K+duIMxqANOdFmUfJ9ZP3h7SrInl1IpXDXoK+iQko
	 +ShrF+Teyx9CHawwNfwW4x+S8beSj/oHlTRcikE9sbripEb6TAQMCgfLZe4Mti6mA6dBg
	 0NRaBkRlWgQZGlI+qY6LX7wyeYddIpJ9lnr33rvTRW4Mg3NE92GUSqIq4d0SGCrclX71o
	 Z2XSUyz3CqTZ1DuFPsD/KrlGfUYgfwwemQ7WG/h9E9+yQTtpCcBt3n6LL2C7oJC8dVGBm
	 jxkZ65JbwkpaF54ZSbejC9yip3hbVCOiuS0tzx35FrhAnlpzlKDBZVe4/Bn338c911g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790446679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=g0+YzcGwMNMkII5uvuldW3X1ft/CA4xtq39cMyTrzRQ=;
	b=qPf1cQhhykeebNpi+qLPmzFalOUSTKSgWtkMmyaYZX4GBAck7CM8X2YK+YmzD1aDZb7M
	 Aqb+393GH3qdYDaMjYmwkFFOPozMALWlZO1qzPhv08JuBCDwbfBVMl38lGox2+boKAdm+
	 oluOUH1ixil0Hy1rU/5XdzXPWQe8JiuAdZqi4E8LN6zI46zQm3WTGO1DACcISI/24d86w
	 GDVRv+PUwzl4Zfz3fiENNY+03pOCmqMXb6BdCx9y+PXwCVnofIEPrvRMCh/V3tdljI9l6
	 PjoAzVD+jXz+17AOytT5RQHr0DZlE3LMJDFgf64DKiYfwl4s8NUqgcK3offLS1QWQfg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790446679;
	bh=g0+YzcGwMNMkII5uvuldW3X1ft/CA4xtq39cMyTrzRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zrjXQ3EvG465MRzsLGgt6vH3k7qNasjHkgrrEiFowajlRqq0Jlxx/v6yvOSNy+dGd
	 vIXoqDSWxS69p5tuA9DLr9ma/BVAtU3OzZ0Cd5zpMdGt4L165JRSmjHjwJFy0N5mo6
	 2Z5rP1k1jAqmeMkNd9TEaEsokmQ8/EeJojhy1KX7VnfDed7EuYtFzIVcWZVuwmq9uw
	 HsdkehPO7IljmTnGgFzicaqTucNFXBFmrvjLhI4sn8w/hjcieQwwRAlaSGXgmSqBfu
	 5Ovq9dvViTAj7nv9EAdxFmdVn65WZa3biaJMpWQGUFzXqssg2TRisLIfe4oN+Gki4U
	 JQO/TYb172QOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 326F640842;
	Sat, 26 Sep 2026 18:17:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC091D1
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 18:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDD2B4007E
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 18:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vnXh5uUoqRdW for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 18:17:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5499040022
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790446676;
 b=ft46sO/E458E4KD4jTM4xn4/cz62W82oTd6NERkOnNAgPzhVzv4fmOadJpEmOMufnD0x
 5lFkuWvicNpwbW8bHVeMyelzg+8KgLCR1hFhcKCdW6BihxH9tD82KNiJ6vagrHUw6UNlS
 4qfNe9JImcLf2hwXn92T0rGT1+BGY1JawkrKxXrOVoVnHwpOGjSGP/N2ZSMTg9XQUwvg9
 bOGYEFGpFACQsKP7iTqCpQKn579562qCq464qXD2Jr79cVlRCdp4cmTUaCX+TcnEPizNa
 iy/hq7VOZh045N3WeIORjTDk2AA/AhPYuzFQi4v1aaNxW6DTky8VfobV0u31sC2S7Zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790446676;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=g0+YzcGwMNMkII5uvuldW3X1ft/CA4xtq39cMyTrzRQ=;
 b=Z6rh6hkN7UWsc++6L8ySC/RnLXH9b5Xt9gHssm/pxp7ERAnqPTayPhtJn5R9/D9NXkD/
 h0A8JIAf8W9WmDVzUASv9tL66587LYUyf3bpBxcY0tOzfN83m2cY6F8eyUrwv8c3t54e+
 ev0GkYrH/3X9qof0OaHPNnGtJHg1MiG/D8d2G7WDOWADs4N9kw00VVGAn/jRgWobn2X0x
 rcDtNxkhujm8Sd9/ZWdYySgrUDYXQD29tmtASyXzEFlwMisGNZe/rVR44Qm/yoU1SVB4c
 OV/y7Ng4aiQTpwTS6Cr8LCRnn4YRMSruBkmocJrFFyeCMviPpmyuuJDQBZ3HULBdL0w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GatkagEB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::e;
 helo=mail-ej2-x0e.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GatkagEB
Received: from mail-ej2-x0e.google.com (mail-ej2-x0e.google.com
 [IPv6:2a00:1450:4864:34::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5499040022
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 18:17:55 +0000 (UTC)
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2db9cc3b45so59878966b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790446674; cv=none;
 d=google.com; s=arc-20260327;
 b=EFNB0Sggz6M4xfY8WwGE2Kk8N7lNjVm7eyxxT4ugw9tQHuZphNFzbwronHx+wgXsUA
 LJOlhGEKKbLYYlBewfMjuEi2pPp+QxKVmcFODwGIOBiBb225bGCFeSh1Kn1/X7z2KiSc
 Xz1EWzg6ynrQGOBrz7uEzahbP5Hvktvm0QC+Zkth8eD6DKnBcsA1BL0ZEKe7uMf0tPPQ
 vReZ8FukUWecV7uWJAkPSbpAv7b0CGEZSmoPY7Xo5jr7bUdAIyO/sD4dnC7maAaaUWW3
 sqo3otzQpEGYtr2SU+AQByIe3MWTQqAd/IEFWWmiIyELtDgslGTikzZ+RVYfHOmMCEWi
 z5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g0+YzcGwMNMkII5uvuldW3X1ft/CA4xtq39cMyTrzRQ=;
 fh=7EQRVNxuUCqdvvTTCE8tuVjO3dhitH3cJKatX73z3fc=;
 b=bg6UZF0Dd/cQeH3HuQk0ccmOWNW+Ea/1LPtMZPfVo9QmsWTANwi197hsGzETW8L9aY
 kPJebu3GJFcrRt81BqamE9WZmGriWzUFUCgsoFR1N3ZHEaeeoGIxBoRtWPhEP3YLJqzb
 yx0H+Vydj7VKksMsts2WhMQ71wNVLWP28inoWp4hHN5KYJjcj2/s7VJl5IULCXqFDBxy
 63eWX+mJ2nXg9d8t6dntl/gjknE48S8C4KUfSKod8BE3RyU3vCLpzul1OEAA0BSYAay5
 i36neLZgvMBSHg/VTObT1tNqgLX4fUczkmJl2MgnfxgK2CeXaMzjfd8sOVZLpPnlK4x3
 QDbQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790446674; x=1791051474;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g0+YzcGwMNMkII5uvuldW3X1ft/CA4xtq39cMyTrzRQ=;
 b=GatkagEB1BjXbfPxhvnW0goqNQUByUdx98Oq6gpnxthAAVHwhypXY9MGD4PO28lDwa
 VKDvsrlq1oRtBFHYn1vyhtq6ZE97ZjApTYaYw4YZmIs/jj3nb4Uz8q4VY5PFm9fAcQn1
 TN1Pq4SV0JVzlz2yrjEXfoyv2nN5k8i/S0PqDtl0Nxx9D1bUSJ1Rzcutfb8jk5Le+7Oa
 0gDxJjS4bEbH4HUMOp0i1ShXCxCFHyH+xhQj2zvBh5VQ1SQf9wcDCaKJVVEMwa2YM8Dm
 5sTuUCNquHa/FVXmk3vPP6+LDaaPs2S2ONBHYJnAjHTYxtobyrAeK1CkIR3PEe5gmdzc
 zveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790446674; x=1791051474;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g0+YzcGwMNMkII5uvuldW3X1ft/CA4xtq39cMyTrzRQ=;
 b=qU5G/FRFZsKOHLAtYDpPij3PxTsf8p9kxjaZ+KIfxZ+NyID5B3rApeeUA62qAskGBi
 Wzigq0DKMPJm0eJVr7Wjn/gYaAFuu+APKA4yHOFcFpPg01GM5+/oXooi9A0SEmdRXDzL
 zNKLwHUfiesZz5g2xma/Bd4+D5Qtlw1IYI9GV1CEsL7sei5dGLT2XiBZL5VbstEAbQkP
 b1BgwRuRXNc2KZgCFNOd1rmLyh1zzgrnJdPduU8TCmb2A3U3wlS561KivHU5snswUUDF
 FGUAWFFOOXcbqTLOgfLR90jiaLljG592wxk8WWdzmb5yivLyi/kBoHrT0iM7Nw/eaCqA
 ZH1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzife0NO8OHp/DpIWnPvVdeaj/Z7BK6yQXyQ0lHMWVY9tOnqRF2SyHe0DTr3b9vgomg8NUoRoI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nTNp0zQGMBSlZSNVxP4W3+VC7nfkpQo1xwTKly1qCg8mSP/w2m
 zakbaJ/Vr1p0YKL5Zx/mhETIUE0zsPuReTOTyyVUqD+FUrjuqSFOlgfhcQwmoASAUjrhZFOUZlR
 sH8THi3CpNeZfX4rX9+2c9UnUwTmX/ZM=
X-Gm-Gg: AYBFou0fON9ft1axGz9SWBg1/be7yCmUJCZZwVG7tAFSy1Qg6s+WidIrrsXF+EgrjFX
 Goil/7yU84cFctYpyUhPdguHLTwXdNMAuiAkljLUL0nN31LZTTrFZdKO5ZxdfzVDpDU8MLkC1/o
 lzFBHx8FSrPt7ip1t/POsSKm3cEC4l93nZwX7bRSHsufUJOtoiaWH9/s0cJ6ISGs76Ja4ZdmHqu
 v8VJ+S9Dt8uyfWNh7hbsZSP6BIzLK3282EfVKjSd5OOepB5CWqTTi8+Rmn2GkYtwsy8WThdDTz+
 g071/nfAjYFxYjTDNUxsXLBPiQgCk9Ze4u6JGvRzen1KLPgAMls5Uns9
X-Received: by 2002:a17:907:d409:b0:c26:306f:289b with SMTP id
 a640c23a62f3a-c2ac2474565mr776365666b.13.1790446673766; Sat, 26 Sep 2026
 11:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
 <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
In-Reply-To: <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 26 Sep 2026 20:17:42 +0200
X-Gm-Features: AclHuK8YOKXIiV-fLdUGGpLa8r1tX2i303p9qtg4CR2hBq5ZjjvVrQQ8oQPBZvI
Message-ID: <CAC928Ha1qR66Cryg9VXwuTTBSgmPPDnbpiahUB8toRt=scfd=g@mail.gmail.com>
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
To: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On 8/4/2026 9:57 PM, Jonas Karlman wrote:
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

I agree on using SoC-specific constants in SoC-specific drivers and in SoC
specific code in general. I also agree on removing unused or unneeded drivers:
if anything requires them in the future, they will be added as needed.

Anyway, I would prefer constants not to be spread around in the source files
that need them, but a single definition in a SoC-specific header. Therefore,
no PMUGRF_BASE define in sdram_rk35xx.c; instead, a definition in grf_rk35xx.h
that is more SoC-specific, something like RK35XX_PMUGRF_BASE.

From a theoretical standpoint I would prefer a single source for each piece of
information, therefore having registers addresses in the Device Tree or in the
sources, and not the same information repeated in both. However, this is not
always possible (code not relying on DT such as TPL one) or convenient (for
complexity and/or performance trade-offs).

Regards,
Massimo

>
> At least that is my end goal with this and pending follow-up series.
>
> [1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/cfb736dea37f834e849e54d39fb086c91697fc24
>
> Regards,
> Jonas
>
> >
> >>
> >> In this initial part the three current uses of ROCKCHIP_SYSCON_x lookup
> >> used on RK35xx SoCs is converted to use a constant value or using
> >> phandle lookup, followed by removing the SoC specific syscon driver and
> >> finally removing the RK35xx special ROCKCHIP_SYSCON_x enum values.
> >>
> >> The changes included in this series have no intended behavior change for
> >> the affected RK35xx SoCs.
> >>
> >> Future series will continue to convert uses of ROCKCHIP_SYSCON_x for
> >> remaining older RK SoCs if this initial part is accepted.
> >>
> >> Jonas Karlman (9):
> >>   ram: rockchip: rk3568: Simplify get_info() ops
> >>   ram: rockchip: rk3588: Simplify get_info() ops
> >>   video: rockchip: dw_mipi_dsi: Get GRF base address from phandle
> >>   rockchip: rk3568: Remove unneeded syscon driver
> >>   rockchip: rk3588: Remove unneeded syscon driver
> >>   rockchip: rk3576: Remove unneeded syscon driver
> >>   rockchip: rk3528: Remove unneeded syscon driver
> >>   rockchip: rk3506: Remove unneeded syscon driver
> >>   rockchip: include: Remove unused ROCKCHIP_SYSCON_x enum values
> >>
> >>  arch/arm/include/asm/arch-rockchip/clock.h    |  8 -----
> >>  arch/arm/mach-rockchip/rk3506/Makefile        |  1 -
> >>  arch/arm/mach-rockchip/rk3506/syscon_rk3506.c | 19 ------------
> >>  arch/arm/mach-rockchip/rk3528/Makefile        |  1 -
> >>  arch/arm/mach-rockchip/rk3528/syscon_rk3528.c | 19 ------------
> >>  arch/arm/mach-rockchip/rk3568/Makefile        |  1 -
> >>  arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 23 --------------
> >>  arch/arm/mach-rockchip/rk3576/Makefile        |  1 -
> >>  arch/arm/mach-rockchip/rk3576/syscon_rk3576.c | 22 -------------
> >>  arch/arm/mach-rockchip/rk3588/Makefile        |  1 -
> >>  arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 31 -------------------
> >>  drivers/ram/rockchip/sdram_rk3568.c           | 29 +++--------------
> >>  drivers/ram/rockchip/sdram_rk3588.c           | 31 ++++---------------
> >>  drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 16 ++++++----
> >>  14 files changed, 21 insertions(+), 182 deletions(-)
> >>  delete mode 100644 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
> >>  delete mode 100644 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
> >>  delete mode 100644 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
> >>  delete mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
> >>  delete mode 100644 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
> >>
> >> --
> >> 2.54.0
> >>
> >
> > Regards,
> > Simon
