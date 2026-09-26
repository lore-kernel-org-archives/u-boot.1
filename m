Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B737CC98328
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 10:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 309FA812FB;
	Sat, 26 Sep 2026 10:19:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v4J7zfJ2PA0C; Sat, 26 Sep 2026 10:19:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ED369811CD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790417978;
	b=Qy2yIEHvmSRJTYncF0x4W3yHoN1Itdh/Tl+bba1gtHi3TvYsYV0VITGp/sQf+4Y2ohPT
	 hT2Xt9+7zhFBX2TGgHFHjHFY6x27877YRz+Wvjh3cyl+/KwfJtVFiSItYveisLr9fjNrF
	 +4W/BVC3nG15ltAkQI9EIIm43QTcbjd7jWSHdpEAD6ec8SU6kWLjoHFrwchQmi3tsiJfp
	 Zo7WUIDTmshzE8HcIIyO6qbOQOcXB/Attko9jlzWk/MoIKRaGNlu/qYYWtMxPPV2+EQyP
	 ZqiiUjdsmzIAfhv/XdvZZ79FcrYc5zDstJGlYBP5pzeqm3aJeeXIV8FAXAz81XBrMrw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790417978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bgadCXe+CrS5oEjX1d0nQgCynHT79aIlFxBqATFxjlY=;
	b=nbZNyAZlnQba33oxKxqcw5rsuCusNLDkRhf7mBK4RxOyJ2gHKG+bj08zsW6ib/oJGECR
	 t+FmR81WqHY86V1WgaOLFv5pRhBg3t9p6uc5Hhsv4VFbua1xgUO7naCG7bYtdw6e2wwfl
	 QTB0XmgCGYZqgzUre/wiTCI3gKCBxMwrCAeebEuT22pJm2ASEVnkV0B9ILndztU6CLTNV
	 KPre3owlh/5ZrqT6OEijfEo+Pwp8Tc0cu/aNtJmYeZbKFDao309S9ISbOgodKXEfRJni3
	 nWoV0AvB4dGbK6svKnHhs5Qlmbz59JuWz8W+mOYgL14ryMZtClvKPI2Pz36x06WK92w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790417978;
	bh=bgadCXe+CrS5oEjX1d0nQgCynHT79aIlFxBqATFxjlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dC1rlAooaivcoRrsSMOsErsVy3bJbhKsLvKlbew5P69+/a4ex7A8dtDSPlCbBMATJ
	 Wj8EvEbKqUEaf6/I5Xri4hx1M/HxCes+2XLDr5FGnC9x4FZ1Nr4shoQbOGRLXuCHWr
	 VJMtikMlulqq6BhtqFkrFXsCnHB9xFIK51aqYslN4VsO5IUM15oiHdtop/gtc8JwBH
	 QQt+eExRUfRnWr3tcavHxuzuxsM+grvYdIcLL2rjzxxNGF5cYC/eMQzoL8p9Sm0EnN
	 5N5EYoAKL+qqnPFlrTZnaLauNYTv0tNPwfK6DhNmbR5qS0oCEH6FvDssX57sSmmqaE
	 2FR1g3kLea5PA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED369811CD;
	Sat, 26 Sep 2026 10:19:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 19E14335
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 10:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B8B340AC2
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 10:19:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzlxtJ2-ZxxF for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 10:19:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B3C4240ABE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790417975;
 b=k29CHOiJkgcrGE87NLZIE0GBlpHR1zwSIaugBZ1Tmen6dO6BRQumL2Va8CW9wbebHkZr
 bAqCuLL47U8IUctRR89Z5qUvJBQXMjkipBDX2lENi4RwUHPKrXfd9eyUFIn6N9IcIu6th
 mRUlouWsrbDwfaIqbmrJOwkNC9ub7lJ53fKg3VBNlq1+jGZu5KB7CNjIt/L+H4tTrHh6J
 oJjFN526cQmkB/8Vr1LP48JjlUSrooc6maK8qmvEh2+Na4XeqZNtWjNVVvVI9aksELG7j
 JsCmgomTNdn3H6yYY4TfaKmlHbi10n2r6d599uCqXHmjVNOYAMl+NQyUaeEuhfr5FNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790417975;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=bgadCXe+CrS5oEjX1d0nQgCynHT79aIlFxBqATFxjlY=;
 b=NARVqu0Ij0K6lMtn5AdY3d2qCzhq9etdQZwkgd4VfTtDj1CdfmHZoTme15V9VVWViZX+
 RtLzigw918yXGmYs/oi2pBxiS55b3FGbMI3/fl3nfTvgeslBZqF8qRWNsS4Sg6/nJBI0N
 VwZT/PL9482Md9R/Jt/ecAHISe7L50LjhVUnVlAmLapU1Hzy4qqWZpbC6rfSYUMx8hFal
 0VHBeIvXAi13sDSqZHvFUz6UtGpg+xznefm0Y+Bc7DvFMdpbx/2571cgq8hq4nAAWlNKS
 fnUsDi54zYru3R/hulrwhH6nnoqTLNFkVoC//Ear05PEHxSos5PWPDdSd6ohJdoNP5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CEwW7HBo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CEwW7HBo
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3C4240ABE
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 10:19:34 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2a4fbc5586so245878266b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 03:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790417972; cv=none;
 d=google.com; s=arc-20260327;
 b=k4DTom6WCnt6syzo5Bi+GltoeoYtNUhztrFw3rTwBSPIEKhK2vyv4Gs9gqEldWLVtb
 VDBvFVE9Jj/1UAjwyK6ugK4TdQa+aIT7GZRnSZBYAp7BlgJczMyyROaCL3paVazurgZR
 AsFPKxKZs8cp61+eWfr7kYgsgwtMXpyuQg9uDRl0SlZEj7BylTfGfLjvPQduoWVNCUi6
 j2MHtO49wXGHpl4+W9JvKSTwAXp5XUFL5KxeoaZsH0QEorFvqkjBdtE02etUdwmZNFCT
 kPZZmKgAlQkZtGuBSKhtHaqDIfvAi+juoqdR0um/HwrBppkGOvlPL2j0KJnEApPueZzq
 NUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bgadCXe+CrS5oEjX1d0nQgCynHT79aIlFxBqATFxjlY=;
 fh=6+YGwzFFpdXiGrqdl1KRU9olLY1iK7n2nwHCPpwBWoA=;
 b=Pkr0mNjCLk45GNzjuzkhm4oiA/IObgHi6KHFyw1EXz2D//W1czGGwAWc4vMSTEy05Y
 oodlrA2/3RSiooIrJUutcaH5YLOB6PGKVWwqAs6jt3rHQNzuuC2QiOK6pTJN+foVi2bR
 coU5uomkv7Jn6SUCco9j+1Y5GbnUqNeLgnIoePOCnyDF1cEvwdIz1aF+UdIIXU4c4MNB
 YlA2WBDRGgwRDdk6TKbCGarRq5rTQmVgzEDF2QDeRMt5mwrnDIjTqjJ89FYHQan8/254
 7jgw13h9sDcv3C7Jpar1A8hiMthZTmBZ6AwZX8B7CRwB8n14sfvRtv3Go8dplhzumXSh
 fqlQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790417972; x=1791022772;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bgadCXe+CrS5oEjX1d0nQgCynHT79aIlFxBqATFxjlY=;
 b=CEwW7HBoWFa1glr3xgm82aBFDC0F7MJfOGTJuM8HCggH9JhrlzUWG4wdS55ptt3AVZ
 TH2NBw1a2Qs7etJdUQwN9jBW0MuhVPs+gJ5m5rYpX/Z4HmnchnDqYpo31zGZ40PbiZlQ
 ULCqoSUNB3hNBiuhHVP1+6+/J4IceI0MsHhjb3tLxwL97aEGYrReE+GHd5n8gaRskSkr
 6F7GpNJ5SsprQSRsmVwKcjHCyaDCTM6Kp2Ed76ZXqWDJSuBMtg1W8f7kYSgxD704P2xz
 wRpRPKPpa1gg9SKiI/rg63v2mY51JEHn97T7pkBsgantztVuRIiNkBv7Noi0D8TdYNnX
 rfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790417972; x=1791022772;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bgadCXe+CrS5oEjX1d0nQgCynHT79aIlFxBqATFxjlY=;
 b=mzVM22TJYqTUk5xNh7/vNpUtmc75vTUSNsCLUZZu7pvPh22gqEZTB1MUiV1tHJvBVS
 E2ELGZy1bm51AWDinxKWIY+3oNkJKeq8XeEuWomgXv4aaFVhlgRmCc6ABdDDqMIIIWfR
 g530JAbtRv8XPmG6HkjlAffpci2oywFZCZL9WK951DpYwNIZR2j9z4Ted+kwVMsZ6+fJ
 7lmbbPO9kLegMIAgNaUFManwiy6w/5GX78Gs0zsE/me1b51SWHSFNyGiJI3c9r0nNMkO
 Cxrrj5c+BdbLbw6uory4bLBvGuy1yZlsGKgGYq/Y+PNglkiXaQbT7cxhwbUDGQ7RN2tB
 /vFQ==
X-Gm-Message-State: AFuF++kKqfJHlkrZCRRSswRegIZzpdutrJkBhztFhndf+fGXaI/+zodD
 lImEAMXASU7ojCT2VMTnFPmXZ++pp8BaS3XVQJ3OFPBV4nYH9BiPgWGSALOVcPm3rmOtLUKcbUd
 5zJ94fC0S1m/tRGio6wyWa+1xuTwEYCHaxjAc
X-Gm-Gg: AYBFou1qZnJIrk3O7I/0tdAg+yvz0OdaZI+WujqoyN4vW8M6L0mO60uJKo46mzNOwHZ
 26+G3wsORivCobaMemf2x5maoiYirsiYPE/+aiAWVcAs3526ybBMZ3zBbvGP2Si+tECGSN7Fy2/
 fECB0c25IQxQRmOhfpiBIOvoUwcabwlm+6J8NFmolBS9AQm4gnVt1P9uOGka2crYnpeBfosRv/M
 MirVvk7OF1tT6zrJI2PNfdHF/ZuT7eCFul+lQ7hfd7OqikDPAsr6xdywxhZ8N8hYzo/CvjpDORY
 NNT0GDYSIX1RKFAJ0I/jmxe0Ywiexl9j4xMLw2ZVVyIqFalP+kmsYmGA
X-Received: by 2002:a17:906:2082:b0:c29:f5d8:9c6a with SMTP id
 a640c23a62f3a-c2ac223aa48mr549784166b.25.1790417972107; Sat, 26 Sep 2026
 03:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-2-jonas@kwiboo.se>
 <cdb6ebf1-6d92-45ce-ac93-18135c23d3ca@0leil.net>
 <811ccc5b-d7bf-4c4d-930d-d66bd388919e@kwiboo.se>
 <0881ae1c-1d92-4c3f-abc1-77608abd9850@0leil.net>
In-Reply-To: <0881ae1c-1d92-4c3f-abc1-77608abd9850@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 26 Sep 2026 12:19:20 +0200
X-Gm-Features: AclHuK-810pk8nIMBq65n6HLDOidomjf2erP_Fbo9kk0w4ZTd--V_G--UjgidgY
Message-ID: <CAC928HbAxyTFh4mu3bAyzN73G8PTUsZMWqB08sMPHB3m2Zoy-A@mail.gmail.com>
Subject: Re: [PATCH 01/15] clk: rockchip: pll: Fix double use of postdiv1
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On 8/7/2026 6:36 AM, Quentin Schulz wrote:
> Hi Jonas,
>
> On 8/7/26 12:38 PM, Jonas Karlman wrote:
> > Hi Quentin,
> >
> > On 8/7/2026 11:36 AM, Quentin Schulz wrote:
> >> Hi Jonas,
> >>
> >> On 7/30/26 4:12 PM, Jonas Karlman wrote:
> >>> The possible frac_rate part of rk3036_pll plls is divided two times by
> >>> postdiv1 instead of both postdiv1 and postdiv2 as the integer part. Fix
> >>> this by using postdiv2 in the second do_div() call.
> >>>
> >>
> >> I... cannot find which SoC(s) actually makes use of that function. It's
> >> only called when pll->type = rk3036 (which is 0, so anything that
> >> doesn't explicitly set ->type will have its type be rk3036), but all the
> >> drivers declaring a rockchip_pll_clock array specify something that
> >> isn't rk3036. So... is this dead code or what did I miss :)?
> >
> > It is also called for the pll_rk3328 type, i.e. rk3308, rk3506, rk3528,
> > rk3588 and rv1126, strangely not for rk3328 (in U-Boot).
> >
>
> s/rk3588/rk3568/ above.
>
> Thanks for the pointer, I missed the second call to
> rk3036_pll_[gs]et_rate() when pll->type = pll_rk3328.
>
> As for rk3328, it isn't using the common PLL core from
> drivers/clk/rockchip/clk-pll.c but it is indeed weird to have it named
> following the name of an SoC that doesn't actually make use of it.

IMO it's not just weird, it's bad coding. What's the meaning of writing
cross-SOCs functions and then naming them with a specific SoC name? The enum
rockchip_pll_type is another case; moreover, of the 6 items in the enum just
two are used in the code: pll_rk3328 and pll_rk3588. On the other hand, the
only difference in the code between pll_rk3036 and pll_rk3328 handling is the
mode_mask, which however is a constant bijective function of pll_type, and used
only in function scope by rk3xxx_pll_[g|s]et_rate() functions. Thus, why not to
define a single pll_type and init the mode_mask within the PLL() initialization
macro? Or, as alternative, keep the two types and remove mode_mask from struct
rockchip_pll_clock and add it as an argument of rk3xxx_pll_[g|s]et_rate()?

Would patches addressing these aspects of the code be welcome and taken into
account in U-Boot, or is there any diktat by Rockchip on changing this code?

>
> > I do think there is a very low chance we actually use the fractal pll
> > rates in U-Boot but the double use of postdiv1 seems (and should be)
> > wrong.
> >
>
> Alexey started to look into supporting them for RK3576 and found a few
> issues, so I'm guessing we are going to start seeing more users.
>
> >>
> >> Where did you get the formula also, I couldn't quickly find a publicly
> >> leaked TRM for RK3036 (and since I couldn't figure out which SoC(s) use
> >> the same formula...).
> >
> > I think they are very similar as most fractional plls used by RK.
> >
> > Following is a snippet from Rockchip RK3036 TRM V1.0 20150907-Part1
> > (that used to exist in a GitHub repo at Poco-Ye/rk-datasheet)
> >
> >    The Fractional PLL output frequency can be calculated using some
> >    simple formulas.
> >
> >    If DSMPD = 1 (DSM is disabled, "integer mode")
> >     FOUTVCO = FREF / REFDIV * FBDIV
> >     FOUTPOSTDIV = FOUTVCO / POSTDIV1 / POSTDIV2
> >
> >    If DSMPD = 0 (DSM is enabled, "fractional mode")
> >     FOUTVCO = FREF / REFDIV * (FBDIV + FRAC / 224)
>
> This one's funny because I think it's supposed to be 2^24 and not 224.
> They made the same mistake in the RK3308 TRM. It's fine in other TRMs.
>
> >     FOUTPOSTDIV = FOUTVCO / POSTDIV1 / POSTDIV2
> >
> >    Where:
> >     FOUTVCO = Fractional PLL non-divided output frequency
> >     FOUTPOSTDIV = Fractional PLL divided output frequency (output of
> >                   second post divider)
> >     FREF = Fractional PLL input reference frequency
> >     REFDIV = Fractional PLL input reference clock divider
> >     FVCO = Frequency of internal VCO
> >     FBDIV = Integer value programmed into feedback divide
> >     FRAC = Fractional value programmed into DSM
> >
> > And Linux use following in rockchip_rk3036_pll_recalc_rate():
> >
> >       rate64 *= cur.fbdiv;
> >       do_div(rate64, cur.refdiv);
> >
> >       if (cur.dsmpd == 0) {
> >               /* fractional mode */
> >               u64 frac_rate64 = prate * cur.frac;
> >
> >               do_div(frac_rate64, cur.refdiv);
> >               rate64 += frac_rate64 >> 24;
> >       }
> >
> >       do_div(rate64, cur.postdiv1);
> >       do_div(rate64, cur.postdiv2);
> >
> > In U-Boot the postdiv part seem to be handled for the integer and
> > fractal parts separately. Maybe we should just try to adopt something
> > similar/closer to Linux?
> >
>
> Casey has posted a series[1] porting some parts of the Linux's CCF to
> U-Boot which should allow us to import the Linux kernel driver(s) with
> minimal adaptation[2]. We would still need a minimal clock driver for
> xPL (and currently also proper pre-relocation) if I understood
> correctly, but we hopefully would need so little that it wouldn't cost
> us much to effectively have two separate clock drivers depending on the
> boot stage. I believe she's looking into making it work in proper pre-reloc.
>
> I'm honestly not sure if I'll have the time to give this a try any time
> soon but maybe someone else would like to see if this can work out for
> us. I would also feel much better if we had CI with Rockchip boards so
> it feels less like a coin toss to do such big changes.
>
> [1]
> https://lore.kernel.org/u-boot/20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org/
> [2]
> https://lore.kernel.org/u-boot/20260720-casey-ccf-upstream-july-v1-33-8fece1b0333d@linaro.org/
>
> Cheers,
> Quentin
