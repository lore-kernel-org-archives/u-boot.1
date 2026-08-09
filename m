Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E72C5AC67
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 00:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 666A540592;
	Sun,  9 Aug 2026 00:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJquNvwI0jP0; Sun,  9 Aug 2026 00:33:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BACB140582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786235622;
	bh=eco+zOxoIT7t/qisBiv8mtRnNxGcqJ/tLnT2x8LsCYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hHOiMDgBJm1cX34zvpcZwDHqIE4SzWcx0LYwwlFAictHxns4pm+1I5PmBGMPKy+vu
	 f986BzqmByAU/EVjAtZAhYU73ourUPpERC0zMw0vDgdgtl15HMmxrmJYCDsVNqba9L
	 NCMhl2zpP6yMG5Ok4LCA6h6KDG/XvZ98pfZPuIE8MXtaJmvcUHVBlr7mWgbLcAZc53
	 vtGF8nnS0lY6TMXjDWUmw9KrqaZVKqfLCaHwa9JU6pW20W2vw6NEYv3ImhGYRdougd
	 sdepWaub4nOMBLXkd/cxhoZqvfF2jYKuTytssFttUk6i8an+J2M9j26xvyqxjRDSOi
	 otDPlc8B+7GWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BACB140582;
	Sun,  9 Aug 2026 00:33:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 51E31282
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37E2E40582
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAG7xMxK18Xl for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 00:33:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 410F540581
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 410F540581
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 410F540581
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:33:40 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a10b20634fso1247665a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 17:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235618; cv=none;
 d=google.com; s=arc-20260327;
 b=dTbbl4T65fh5IreksdR2ygHBGkLj1YpvkZiOhXGlf4NLgDMTAQBJLVqptR7jA/B4AA
 R5ow1ydVpuN3sm13JRyRbvS9uE0SIXkxjHw26rdteCrJrGiKK3yAEipqic4YptN2Vs9N
 Cx2xkWuQ6D3dIfbZt9VkphiKpt4SEPYjR4UsgbP5Q6H12JfMvvlI/AVF1ca/aMRKoJjK
 jelz4GycQVGt4Uv3EI8nFXlAGUZJr+8BVle05kK8W+TYhzHPtCIn3dwLU42dPmPAb/65
 chLPaIa0wysVXmsQSgPZXCZA0hDEHlQ2kBjeOXFvFhhaGYI6nc+epNjj0xdpJWI4ykKs
 Xr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eco+zOxoIT7t/qisBiv8mtRnNxGcqJ/tLnT2x8LsCYM=;
 fh=Pq1Pw5YYST7g7ImiO3ZxAvYc9GIgdPTPBaa83TDUZzg=;
 b=npZI1nzxnazHxSt5iCSyuOslfpKOcwKAPrjK6/x7bOUP1r0cr2NUYlstjzxgYBxN/n
 j2F4xckJRv8KsLB8LvuyVR2HQeKcYMvU2k+oKf9RT1PQ9ZJeVDAdbylGL9M0WcOlfRpN
 KsnIPpwbf/KYgHQd+fj6gxGclNZx/HmNILgCuy+QvsfIjiZnmCSERUBuBDZZ8e5Y7bbD
 ycwqp0ihuDZ5cvahNXp1uBqS07KxLVPMQKM2woKReq4YSn7Q7tOyNr3gzkx51gC3JwoG
 e5sNAAF9dMR+J7osgAPc/x4DAAhUM6eWqnTmcgH2pBGemfgN3ID3XtKzHmcMJ4+7J+4q
 pcnw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235618; x=1786840418;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eco+zOxoIT7t/qisBiv8mtRnNxGcqJ/tLnT2x8LsCYM=;
 b=O8/JMJz4lB2ef+0Gw9VCfaqRwTb3ezZjvtMblcesptPUXPRpLctpf+ySJd9FhPxbe/
 9XNrBF/6RtySNcUIBEwSwdAGVFCnscE1NnAktNhuXRKspE/y0q6gklPTMvRWrahcuUd7
 XYE6xNKywpOBfxIR5FCXNA6LJO0YborXvKXYBCoYEl+cxEptVc0lbXN6r4nqhBty8dXV
 N+25CP68RfQcWBxdxekKQhHkBrBhUUJ66VCgdWctxIHQmPatGQ9yHLxFXIsMT3jDFWDy
 hn9KUlFXcoF51BvAygqXbdpTbfYmVEuykSnOXZ79h426iWAnjSMN3kUSyhr+N1gRdLpy
 ArKg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3RLl1nelCKO6A3+YgRZJEn9rl7VF+gLkDV3Ew7U0sfFpKlrGahTB9DNUcaf2ot5PTN4c6rF0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwScU3VpLQoTLaxvWj4Hsl7dm2W540T3/lpxvCI1EuZeluWNNjK
 /xSc6aI7E4L3hVBzmPgDCjXQ1fRAC7Q6D50eZCKcf1Xmrvio5zKGiyJeA9V90zxjhcJwijXPeP2
 FFnuDsctXR4SK+sgI3WBoGpURE1CdwUiPY9NhjNWp
X-Gm-Gg: AR+sD12PSX3O2DCh+O8rG96TxrQDei8IHO7sC9NKaOkCV9gsXea25xlLPk2ex5GX+Gi
 Jr6Cic+wrDlWg1fmwLLyQdnKIg2elxOjuBf19Ub1qrB3cYATbu51jqZ3Deq3rxbf/CPPPxOXrzH
 zDtaIy8FeOxBVevrBj+eC2UREgSsc05rdQNjc0d7UFDa09qIdR/V7RXa83vFZZn2V401P4BgdLN
 CUK6yw5SVyjjpK+zGPdItzZ0dplwgbt7NomQ/wUf+ENMURwWDfb+XbmyE/qVOLJOvfPFfOGcCJv
 64CteqKTL7tmpCNeRL17oEbX9JO6QytxStY1GRNtj3U=
X-Received: by 2002:a05:6402:a516:20b0:6a1:f8ad:6c0c with SMTP id
 4fb4d7f45d1cf-6a1f8ad6d3emr1850338a12.16.1786235617994; Sat, 08 Aug 2026
 17:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-2-jonas@kwiboo.se>
 <CAFLszTjXANOTC8r0FbXAL80Zs2m7EpbEPb5BnDF3kWf1QxHpiQ@mail.gmail.com>
 <d3912c4d-90d4-4e62-b9eb-9a53ba4a170e@kwiboo.se>
In-Reply-To: <d3912c4d-90d4-4e62-b9eb-9a53ba4a170e@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 18:33:25 -0600
X-Gm-Features: AUfX_mzxYyzik4tQicCakjyugaCsTRADxic09oof8mm8Lh9454rGxjTet5EX_gI
Message-ID: <CAFLszTjNZgQpUSEQs+o0en3yoNS0Ru7tTff7MU69SeOZff8JuA@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: rockchip: rk3568: Always init clocks in SPL build
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786235618; x=1786840418;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eco+zOxoIT7t/qisBiv8mtRnNxGcqJ/tLnT2x8LsCYM=;
 b=PEa55I/M99zGqlaIkO5/aaUOfKjwJJ2C9CIKuPem8HQLwzVPdu2sQlZX29bMGdiQCj
 2IQ31IdWn5kB1hHbwpjcozLHdbazIo3WzL4PIb9je96tuVXj43EJUlAYJRZ43QXJPg37
 KjJ3QiYVt8uJSAFJA+7Nzb8hNQ9aHaN9W6zMk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PEa55I/M
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

On Sat, 8 Aug 2026 at 13:33, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 8/8/2026 7:30 PM, Simon Glass wrote:
> > Hi Jonas,
> >
> > On 2026-08-04T00:26:39, Jonas Karlman <jonas@kwiboo.se> wrote:
> >> clk: rockchip: rk3568: Always init clocks in SPL build
> >>
> >> The ACLK_BUS clock is initialized to 150 MHz in SPL on RK3568.
> >
> >>
> >> Ensure clock driver is always probed after bind for SPL builds to
> >> initialize core PLLs and clocks in SPL phase on RK3568.
> >
> > Just to check: "is initialized to 150 MHz" reads as if this already
> > happens. My understanding is that probe() contains the ACLK_BUS setup,
> > but nothing forces the CRU to be probed in SPL, so it is silently
> > skipped. Please spell that out - something like "the clock driver is
> > currently only probed on demand, so the ACLK_BUS init in probe() is
> > skipped when no SPL consumer references it" - so the motivation
> > matches the speedup Alexey reported on the rk3576 patch.
>
> Correct, I will reword the commit message.
>
> Unless the clock driver is probed in SPL, the ACLK_BUS never gets
> initialized to 150 MHz.
>
> >
> >>
> >> Ensure clock driver is always probed after bind for SPL builds to
> >> initialize core PLLs and clocks in SPL phase on RK3568.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>
> >> drivers/clk/rockchip/clk_rk3568.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >
> >> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> >> @@ -2938,6 +2938,10 @@ static int rk3568_clk_bind(struct udevice *dev)
> >>       struct udevice *sys_child;
> >>       struct sysreset_reg *priv;
> >>
> >> +     /* Ensure clocks are initialized after bind in SPL build */
> >> +     if (IS_ENABLED(CONFIG_SPL_BUILD))
> >> +             dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> >> +
> >
> > Have you considered marking the CRU node bootph-all (or equivalent) in
> > the DT instead? That is the more usual DM way to force a device up
> > early, and it avoids sprinkling a phase check into every SoC driver.
> > If PROBE_AFTER_BIND is genuinely the right hammer here, please add a
> > note in the commit message explaining why.
>
> Use of bootph-all does not automatically triggers probe of the device.
>
> The main issue is the on demand driver probing, and depending on what
> boot source is used the clock driver may never be probed in SPL, e.g.
> when booting from RAM/USB.

Ah yes, good point. I had assumed that any boot device would request the clock.

>
> We should possible move out some of these one-time clock initialization
> into e.g. arch_cpu_init() or similar in future to avoid having to use
> probe after bind.

Also if you just need it to be done before booting, I suppose it could
be done later. But what you have sems fine.

So with the reword:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
