Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E299606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t+lFJNAj;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IewCAmbT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18FE66061D;
	Sat, 21 Nov 2026 10:38:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bAR_8kcBXf3p; Sat, 21 Nov 2026 10:38:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F2916066A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795257525;
	b=UqZCEeFFXi6LN344pNkhc2UVu97X3JcjZnC7LenEH8S1Xyk2c8sWM3gHrTRWpDzPrfZY
	 qjUcyJMQhzSuY8tctKwbFxz+P4N0aA2NtxL4EkaLjAvspm9n0SBSbc8OI/HfxQFg/H4I7
	 fYK5Rpc9lOB7jBYHubKLwUhHs2kWQMPZ2P92cex0FPkH/XyZVNLkJkhXAKt3FukjRmjzi
	 15AoqzyrqUZNASo9O8Qrxo70OMCHc+N/bfqW+aCpsPc90Mo1HMZ0IQpHZl8/zuBnOwe86
	 +bYA5kiQLryv135cd3/2OFFOi6gFnHbUjuVxhd/aexbQR4p79HVI2XJYYhNg06r3l5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795257525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lVo3E+jb05NevowAohE2J1ABK0Aff7UkMDiDiIbmBdc=;
	b=VFPDzGgrthAEvfnl6BAevkkG5Kf6r9IAPe79K1QzNpckoXlB+/5eGqDqqtnz6f6YpwGj
	 zksLXhNeKBI64bOgau6UvM7QbCPQRMPomdIlpXWxJm9Ag+T1Q3YdYmcx/XjTRfrp3y/op
	 kG0/wN1dOIpqHA72tKeOeBeM7LQJdikO1OP1uZR5791hLNnHEVfK0KdTvJcaCB1eFaVak
	 +MOHwMFPoltW4HYaqyH5RIuogadxQhimRcdoS2tknZ5AGVuPLpnzq8LrnSm+WeuG/iJlJ
	 9Kxkj0CoKt+XBB1RPg11GtF7wgqm6iuJOBods//jQWf3MwN/u+Waymu8+ESC/tI4/Uw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795257525;
	bh=lVo3E+jb05NevowAohE2J1ABK0Aff7UkMDiDiIbmBdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+lFJNAjKPSsLa9ZJ+ymN+oO51SJDSyeKwZrCu7SahTXvBbXA1e35ODMGdDBA/MMs
	 9IgdVGkZ7RkTBO2HP3uyE2e4aTgs61mZQmWEUhF1q64LU7oJRHF5ApV81m0EfVJBJs
	 9x8y25MZqtdC5U3Imd8zB2aKPMhRaveUMc+S+oN5WdAhMDHysZ5UBer5oNVmq6zck8
	 MEvr0N2FBWO7ZmB9+sZcap73JkxcikBhMcWOXGW0YT8IEoBHsrq7HjstpKqqZMZm5k
	 w/XQSDkLkG2HjKAc/7CYss8JCx6K9c9uFLPhYRE2a6D/HdIjBBleJv3YyHVX6Nav87
	 mGeOx6j+CuyRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F2916066A;
	Sat, 21 Nov 2026 10:38:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AE649C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 10:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 163444006F
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 10:38:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wycz39UnrdVE for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 10:38:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D2FF640012
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=IewCAmbT
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2FF640012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 10:38:42 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c50d3ac6b51so598262666b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 02:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795257520; x=1795862320;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lVo3E+jb05NevowAohE2J1ABK0Aff7UkMDiDiIbmBdc=;
 b=IewCAmbTHtT5UyxFN5qXr7gELgcaGQ0g576mtROaRm55rERqQx2I3vMFD7Y7CCjakZ
 cQccZPFWEjQudUhYn9seyPxJrgWt1IGxyadkf3oM4qoqd1+bv0VUuOb7/oU4RmSVqKUy
 gR4L14lnXZy7weoImqePnLOxyNfpb2A/X8MkPxcAzRfKut80oT7tYyd8f9chNZY93uwa
 AWcSEe62g8Rs6r+oFYGFM4piO/sCGQXnjXno1XydLTRmoz78cWO+RCC36h1PSAlgYgmd
 iwAUwi1wR2DUYD9KSADHZljRtlQLOhLyJqzoykz7nXXAz0/DLgDITpDzzyTf7SHoMkPx
 +vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795257520; x=1795862320;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lVo3E+jb05NevowAohE2J1ABK0Aff7UkMDiDiIbmBdc=;
 b=tr/wn+KQcMVtNuHz2U9N4ZvGc5FQD99UDJczbYe40OWNF+rFse35nRVpFztwsriqNI
 ePPeu4DdtRTam2WqRirNdgCdZo1VsKdEYG4pwhoOnv1AVxsDRGAsl9+Atzz0fphqQCGP
 qkU2RUqFGW56Pv0nOQVwTqJ7xl6h4tT9XxWQUv7cwCvZyN37JzIIPSwz3Q0kvm6UWOjV
 bHMbDXwdizIyxVrdYlcSso0/9/Qa9y36YGOEww6v/7KPm+nLeTZa65P/yIbHqSr2ydnZ
 1bMslBGpHPVcT/57Lz4k0zWEiDHE3kjDQnBJWBTfFdCw48rXOItgA4uOvMg53o+NShGU
 AuNg==
X-Forwarded-Encrypted: i=1;
 AL+hErEwFc4Z3FZuvth3hmfaXjDMODHyP+1dal60KKgyXFl04LtycLCxdUNDnxrOAET41LgEP7vOAkU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Z4rgL5FHV0fZtLa1NgvUk1Q1lG3KvdofM47QEEzQmOOd4hMjN
 iiEKFcOQWzrzBReqKwH4egma78TkfidaTRtOsY/wlDIr/jLseAzMy6BcVp1LKFyeyq3sH7bayqz
 Yi3jUM5u0rFcNXlL8Da0C56FMCYIltYo=
X-Gm-Gg: AZFdTZcP63Apcb4hf6R6bv+vZNUVIGi7HZ5Qo+VxCJK7ecV8J1+ZMv42C0m3VmGm7w6
 IA0vQ4yFWPUUgDhZMAMnNAK5ME1AmK0iwU77S7QzHQTNO1ppRVw0vdFrLubvw5cqMp+T2/LvRtI
 4m4GXUwRoDt3rRyCBqd20AUv4jZEmlpI1USoxjPNpXhZ7GJ6nYOrzDv32y+Y4+2Wh2aqDbe1G3z
 UxOEg6E2plViC1lGB0duy4eaCxGDm9e5/Svh3Tqum/Pw2JN6R7wbzv9Zne5uTeHS/Bykp2elVOW
 TgJGAuUuqJi8sHVKoqvhg3juQ+bIhSqUUDsvUkmj9L6ISrIvBfhhWEUM6uxervC+R3ZRd3jlXxS
 rOSVrVbG84oRAX3pad5KWIlobVuuj1BflTL1XCw==
X-Received: by 2002:a17:907:3d4e:b0:c4c:e91f:e1db with SMTP id
 a640c23a62f3a-c51319a7850mr666096066b.25.1795257519953; Sat, 21 Nov 2026
 02:38:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
 <20261117-rk-clk-better-con-names-v1-3-25521d4e37c3@cherry.de>
 <94e836e4-fe65-4891-839b-1998c02c2b77@kwiboo.se>
 <d4467ddf-13e3-405e-9c89-93bdeb02a5e1@cherry.de>
 <c336839f-36fd-42ec-9db0-322d5c13eebe@kwiboo.se>
 <01cf9193-94e5-43ef-a566-a428b2ffea8e@cherry.de>
In-Reply-To: <01cf9193-94e5-43ef-a566-a428b2ffea8e@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 21 Nov 2026 11:38:28 +0100
X-Gm-Features: Aa3M54rhPmYSBtgs53WYSJ-cWCvm0X7hG95v4pue85Vt_HpxG3IrrpuIVMm9HyY
Message-ID: <CAC928HbeN5Qibkie1_scStvvxKZb-5PxKPe578DQhLE2WpC8_w@mail.gmail.com>
Subject: Re: [PATCH next 3/8] clk: rockchip: rk3506: improve PLL_CON() user
 friendliness
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Il giorno gio 19 nov 2026 alle ore 14:15 Quentin Schulz
<quentin.schulz@cherry.de> ha scritto:
>
> Hi Jonas,
>
> On 11/17/26 7:49 PM, Jonas Karlman wrote:
> > Hi Quentin,
> >
> > On 11/17/2026 7:06 PM, Quentin Schulz wrote:
> >> Hi Jonas,
> >>
> >> On 11/17/26 6:59 PM, Jonas Karlman wrote:
> >>> Hi Quentin,
> >>>
> >>> On 11/17/2026 12:37 PM, Quentin Schulz wrote:
> >>>> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>>>
> >>>> There's no PLL_CON8/16/24 in the TRM so one needs to do an additional
> >>>> lookup the header file to know what exactly this refers to.
> >>>>
> >>>> Use new macros that reflect the names used in the TRM.
> >>>>
> >>>> No intended change in behavior.
> >>>>
> >>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>>> ---
> >>>>    arch/arm/include/asm/arch-rockchip/cru_rk3506.h | 4 +++-
> >>>>    drivers/clk/rockchip/clk_rk3506.c               | 6 +++---
> >>>>    2 files changed, 6 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
> >>>> index 9ddd6215fc53..331b100ced54 100644
> >>>> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
> >>>> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
> >>>> @@ -48,7 +48,9 @@ struct pll_rate_table {
> >>>>    #define RK3506_SOFTRST_CON0             0x0a00
> >>>>    #define RK3506_GLB_SRST_FST             0x0c08
> >>>>    #define RK3506_GLB_SRST_SND             0x0c0c
> >>>> -#define RK3506_PLL_CON(x)         (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
> >>>> +#define RK3506_PMU_GPLL_CON(x)            (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
> >>>> +#define RK3506_PMU_VPLL0_CON(x)           (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0020 + (x) * 0x4)
> >>>> +#define RK3506_PMU_VPLL1_CON(x)           (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0040 + (x) * 0x4)
> >>>
> >>> Please consider something like following:
> >>>
> >>>     #define RK3506_PMU_CRU_OFFSET           (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE)
> >>>     #define RK3506_PMU_GPLL_CON(x)  (RK3506_PMU_CRU_OFFSET + (x) * 0x4)

I agree and would also suggest to keep drivers aligned not omitting 0x0000:

          #define RK3506_PMU_GPLL_CON(x)  (RK3506_PMU_CRU_OFFSET +
0x0000 + (x) * 0x4)

Regards,
Massimo

> >>>     #define RK3506_PMU_VPLL0_CON(x) (RK3506_PMU_CRU_OFFSET + 0x0020 + (x) * 0x4)
> >>>     #define RK3506_PMU_VPLL1_CON(x) (RK3506_PMU_CRU_OFFSET + 0x0040 + (x) * 0x4)
> >>>
> >>> That would closer match what I had prepared for existing and have
> >>> prepared for new SoCs, i.e. RK3562 [1] or RV1126B [2] ;-)
> >>>
> >>
> >> Yeah, I wasn't too happy with what I came up with.
> >>
> >> So, I'm actually wondering if this is just wrong? Shouldn't we rather
> >> have a pmucru driver, separate from the cru one? Then we don't need an
> >> offset relative to CRU_BASE, only from PMUCRU_BASE (so the hardcoded
> >> RK3506_PMU_CRU_BASE - RK3506_CRU_BASE, or currently 0x10000, can be
> >> entirely removed).
> >
> > The upstream dt-bindings header and clock driver for RK3506 already
> > include PMU clock ids, so not sure that would be possible (or easy).
> >
>
> OK, I had missed that. Thanks for the heads up.
>
> >> I briefly looked on linux-rockchip ML for an RK3506
> >> base DTSI but didn't find any (but maybe I'm bad at searching :) ).
> >
> > I have prepared and was hoping to send out missing GRF dt-bindings and
> > base DTSI based on [3], excluding USB nodes (missing dt-bindings), very
> > soon.
> >
> > However, CI failed for my latest rk3506 branch so may take some extra
> > time to sort out final touches before posting, as I would like to cross
> > reference any RK3506 related Linux and U-Boot postings.
> >
>
> No problem, wasn't meant to be a stab at you.
>
> >> I
> >> think this would align better with other SoCs like PX30, RK3399, RK3568,
> >> RK3588 and RV1126? What do you think?
> >
> > For most newer Rockchip SoCs we seem to treat any consecutive CRU
> > related reg-blocks as a single CRU, i.e. RK3588, RK3576, RK3528, RK3562,
> > RV1126B and RV1103B. If the two CRU reg-blocks would have been separated
> > by something else I would likely have agreed, not sure it is worth
> > trying to change something this late for RK3506.
> >
>
> Agreed.
>
> There's no hurry for this series, so I'll let this simmer a little bit
> and wait for reviews. I'll implement your offset suggestion for v2 (only
> for the change I'm doing here, I'll let you handle the driver-wide
> fixing in a future series since you seem to have more patches ready
> already).
>
> Cheers,
> Quentin
