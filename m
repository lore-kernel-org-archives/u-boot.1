Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40F8C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 699B640BBA;
	Wed, 29 Jul 2026 12:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WElLZsLbg9FV; Wed, 29 Jul 2026 12:03:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D2D240BA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785326606;
	bh=h/UTetTZpz6YiTICAmWcXkBGzTlWKpJ6zSTfyZ/LJKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NFqIYVcO8OYiW8reJIlpOSPSB45eFXfdrKOjhgV1ismrJM+1uG5gsGkrdtR+Ra0B8
	 bJucCdhKIYgbuKCRRew9qy3m74Nv5neBFEXPusDjnIIJmkL+fvfV/R3csM+x8s6ILN
	 pQucl6/8hm5Lux445/CPwdmU/NC82JGH126GO026wbbheb6KUSjVOMqWuzUaCzu78C
	 BtnhrW2XMraxKH2b3fhMi0VqsgQDTMvHRxkroe083n3g04TyGMobwBTKMmyN6bWNR1
	 LzeyC7Vl7ETBW6vwXQCOpwyGRZ0jL9RTmjt5KbEnCN1qZGyBUomc893udM85hIog06
	 c69jar1cpl6/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D2D240BA8;
	Wed, 29 Jul 2026 12:03:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E0A93B1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73DB981185
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBNn2yO0Dk5w for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 12:03:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BED4381167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BED4381167
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BED4381167
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:03:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498588493F; Wed, 29 Jul 2026 14:03:20 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2118382991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 14:03:18 +0200 (CEST)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66899c7b57bso1097311d50.1
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 05:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785326597; cv=none;
 d=google.com; s=arc-20260327;
 b=OqGBKjxTACo0h/7BCOXFcBktEbugsL04geybsIqsjGhMee0k7yFzF9XK90B57NH2NO
 2I5HokhLulvM8R35Y4tpOZkk3b+dR2MYYCHLrK9xDDagMJe3SfhQQyjA0SepCs7eYcOv
 xAHDw15vSIWdLTqllH1ukA+kclHLEbvIPDomOX+8zQ0UimtJa8ojUvMEXK7BiYXZ06M5
 XV/NdaNUTYZCYp0kqWDnLNxa/NeopZc42A6klRifHERmzh+06CsWruElCFKatt5A1ifA
 My2W50Tqjp+PrVW3YNOPKde90vQNRtnWIayLANoGDjKuVz4FVdCpMAoIKAVIV67yYdjJ
 BtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h/UTetTZpz6YiTICAmWcXkBGzTlWKpJ6zSTfyZ/LJKs=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=WhC/ZKHzkA7hhg5jTYVhLB/Wm0F0rUkYb1KPYGPQsefFIXdM0mQk28fxPHMpLCjoNy
 7L78A/bZZNipbdd3+n42FoYa+LMsDakA9wNzrlc/qmwa7wwE3cQFwtTQfieVI2hheTyN
 RUtff7jlbMnG6LKEpPcmaNz7GZQaddWD1tLG0kNx+zq4I7voUtRdfXPHPcOZf2hHDxim
 8caNUrHIR8t+nQm93iWP/+KB1IFMDGGmk9RdD08HGHsAi1lCDP/l/0fuvglGG03fwZQ8
 kBlbgFB1PQvJNCIcRh+bruMVaeE/Ue1+v9a7AZb4GxwsEsEPRxNygJQ5ovo6sOwEQCh/
 l0Vw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785326597; x=1785931397;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h/UTetTZpz6YiTICAmWcXkBGzTlWKpJ6zSTfyZ/LJKs=;
 b=INB4Wrk5EV9vN/IG34FSbB9Ys86iFEcL1evMCIGquIZTYlmPvF5AXOphQp40Kp8xwK
 qbhiMjw9QvpGtpvG/heWR5w8OvJDp/vbd5OwjNQkGdRToz9fMMHQYTg+MF8ZQtbinVR4
 G1MBvPnevLwwv5HJJ2rkRfhlx7vC7A+SuXWCzL/beMPh0t/NYKfyvZtSK/ikoZuNMmhF
 6TY0FqyATFxuA7BJOk2YLANJ3ks6JPQYEbABwdT1e0hv4cu+cM5DE49x3a2xVe721lAA
 TQcTcX2Rfp1+lZqR1YcVn3DcC8UJA4FmO0z/5PmAh4JurSblKSPhXaCSpGBzxtyrZ618
 M53g==
X-Gm-Message-State: AOJu0Ywy8is862kTvXAwjTp8IbsTcjqtNKdtFkb7CnTjIe+8xjYA4CIq
 iA3tGlovuK/jbeKQCWNyRyh3iDHjQtidwyfd64zIrw9/hsGCd42QOd6k8wp5Zarim8XQ2xJq3uZ
 Pb4oVepQPwJW0tUCLYu0i+QcNFykju7v/KhfpFwAVRw==
X-Gm-Gg: AR+sD139MIPH8HM+d3t5W9PtWn2bZKI5sGgrW4hp0c6vlcXHUZBZ9bjHfjdDZm/Ei/4
 3DDNbXZJLGbIEw8Xv8X4Xek2K+icJIf35B+yBxdEfLjF+pkTvciGJeiONVCSvs/w+/6OOlZ0Teg
 rbarKwUYygy6S2K3UVFn3Ovu6cdtDn7dBJvH25MKeUe8Du3f6ua5z3cv837rtCPgR07TTvfuH5x
 vGBS1QSGHNsG+OrhzwbvYGNA5AXj67qWaS/8b3leCyd1Pls6BemK6y7Snpv4o83zvQtFcrv9S2t
 02XOohLaNs7qqxROeWuoIg/oOs8byOIil5DhqpRU09xFNIrzY5Ml8m//GKhzJeInFEHgozBb+L+
 YcjMhbBnl3p8Epvm34pzVIa82eP0YhVYbU1PMguzGDa2SGXPj3RJ1B0zsUAZ8F6EXRuP/txZ7zp
 Ms0KjHKLUzOB1g18GvxijoSOS1YWvJAWfP7D0XmQLjs8j1q6qBZMIrPluS9GIe8HevMsGJ/+V0H
 QlMdhV8Z/Iw4jXPQad/qpxBx8JXrG35dDLyPIzaaNU5p8dOC8MRU008cwBBKDatbceUI85mNZwg
 i+nM+ZK6cUm6OM1H5F8GAjGHo1LfVqfC3HXlSADn5y8ZB7njV6XPOAOYLLG4yXz0N4m+sTVYy5o
 Jnr8eOfBvn1gwNBjlDYXom7zFy5fuDC6v3c2pbZYjNY6W+g==
X-Received: by 2002:a05:690e:e8a:b0:667:b84f:e40c with SMTP id
 956f58d0204a3-669054a5e65mr2644987d50.11.1785326596597; Wed, 29 Jul 2026
 05:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <fb1ccca20dc7ad495fcfad16c7e146500b120981.1783426581.git.michal.simek@amd.com>
 <e00432e5-a700-41be-9aa3-6e544236b8e6@amd.com>
 <CAC_iWjKtQoMDcyBxPgtYiesheXTJ-rngeqWZMyA2RacOc2mwDQ@mail.gmail.com>
 <CAC_iWjK_1_k_MWvYOAWAS6pe=-waZs0Ht=71Zigt1vEbsE6rJg@mail.gmail.com>
In-Reply-To: <CAC_iWjK_1_k_MWvYOAWAS6pe=-waZs0Ht=71Zigt1vEbsE6rJg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Jul 2026 15:02:40 +0300
X-Gm-Features: AUfX_mzsYJSVVYoarSY4XsOQGVFBPDy56kybxe-vh4LYr1hXzENeSM95tWT0j7A
Message-ID: <CAC_iWj+LzhR8xJu54gxQ6BaSwko5W0r+k3Z7yXND3+9GjQCK2Q@mail.gmail.com>
Subject: Re: [PATCH v2] fwu: Make boottime check failures visible
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785326597; x=1785931397; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h/UTetTZpz6YiTICAmWcXkBGzTlWKpJ6zSTfyZ/LJKs=;
 b=mW2Py5zXTHFruGInLvF9C/gbVEfSPHBBt8c4FT2fso77cg3Hns/Nmp/FuTKpN2bfgv
 GTiMUv+zZCMlJR53kjRxI8RN3yqzvwE1iufVcOku6usS0wn5O6Cup5wEvoTl8uJXshQW
 L3/jqlQi4he2vV3b3JQiDGLXqAJ8+8IbO5XWC2ydhXpeLaVAXnwg/+NUxzEizpEWlF3Q
 dkZ6cKjI7qEfSPdzL5zoI9cmJTa4TDVeQY4MqoxES7rLmiuMcb2yxoYl4670kBq19MPE
 x9Xsyi75Czqw7drhnlsPGGLNdmhMFVJHLuAkpG/2+ZlnAjWBKOSsABq/cen002KAlPbf
 r/Ww==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mW2Py5zX
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ilias.apalodimas@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="mW2Py5zX"; 
 dkim-atps=neutral
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

nvm, it applies fine

Cheers
/Ilias

On Wed, 29 Jul 2026 at 14:53, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Does this apply for you on -main?
>
> Cheers
> /Ilias
>
> On Tue, 28 Jul 2026 at 15:48, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Michal,
> >
> > Yea, I'll send a PR tomorrow
> >
> > Cheers
> > /Ilias
> >
> > On Tue, 28 Jul 2026 at 08:19, Michal Simek <michal.simek@amd.com> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On 7/7/26 14:16, Michal Simek wrote:
> > > > On systems with FWU enabled but without the required DT changes the
> > > > boottime checks fail. The failures are only reported via log_debug()
> > > > which is compiled out by default, so the user has no idea what is going
> > > > on.
> > > >
> > > > Use log_err() to make these failures visible.
> > > >
> > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - drop fwu: Gracefully handle missing FWU metadata device
> > > >
> > > >   lib/fwu_updates/fwu.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> > > > index 2b11e5da061d..e9bb1b4fc656 100644
> > > > --- a/lib/fwu_updates/fwu.c
> > > > +++ b/lib/fwu_updates/fwu.c
> > > > @@ -759,7 +759,7 @@ static int fwu_boottime_checks(void)
> > > >
> > > >       ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
> > > >       if (ret) {
> > > > -             log_debug("Cannot find fwu device\n");
> > > > +             log_err("Cannot find fwu device\n");
> > > >               return ret;
> > > >       }
> > > >
> > > > @@ -771,7 +771,7 @@ static int fwu_boottime_checks(void)
> > > >
> > > >       ret = fwu_init();
> > > >       if (ret) {
> > > > -             log_debug("fwu_init() failed\n");
> > > > +             log_err("fwu_init() failed\n");
> > > >               return ret;
> > > >       }
> > > >
> > > > ---
> > > > base-commit: 313a1a7bb065319dd3d57e9ab6559422771aebae
> > > > branch: debian-sent3
> > > >
> > >
> > > Can you please pick up this patch?
> > >
> > > Thanks,
> > > Michal
