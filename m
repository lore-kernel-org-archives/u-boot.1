Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B04D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 270E189451;
	Tue, 12 Nov 2024 15:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xctI+A/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191518945F; Tue, 12 Nov 2024 15:27:48 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A79089440
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e59746062fso4561665a91.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731421664; x=1732026464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TY7x7p+ItAkQ9tD3r/m8FtNuy6/k202Tk3pmrfKVw/8=;
 b=xctI+A/1kJcwiDWkYeD+ibje7QGDkGN6Uo8FCZK2Mts3DFg51CFnzEJTRLThDR43bX
 hqEWbtcPgNWv0cN7Mro1l6R/+IK5x+PYjrYMVb2H6imn4JhkC2chpTIfxykq8HB6aWki
 phKx/lTEZn6WBS9LrhlwhyXcQPn4ErYWemTkTJcY3TyVFuuls7Xb0GyBwz2ogL9jmdFG
 cSuNKw6FPImlp3B6OSbwOEFIjpE/A7tSMGdAghv8CET3omOllINIQZBxNShd0YWuc9qZ
 xsxn6CvbzAXs7Y+p+/i6I+6itJ31GKpW0oS78mPikpZH3FNEI0TWJdO+GWrzapNoZ774
 nTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731421664; x=1732026464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TY7x7p+ItAkQ9tD3r/m8FtNuy6/k202Tk3pmrfKVw/8=;
 b=t2DAu6zB2eoKXdPPrOuyaILFQYT/PyILtopM/eHBBfVa++FyhG34IgmpT5eE+zi6il
 PT3UTqi/KnBakPpr+batPdNgubEooYI8pWluUwBuBQ2jCfnJ0MwuhSYd7VnTYSFdydOu
 kB9TFfo6c10hZBC/pBDSmdwgBy6O8pja3nveIUIYkI5kTq7guFs5PpOVEAcIVbYN6IGB
 T6jogNPyIaaYxDI6R4olLi/h0VuhoENtH5c3uoj83R+89ckclvh3jN7xGReMXk2ytzaH
 DcPej2aAPi9T7XgCdxI3pKloR41oSC/gCkuTEx6E0dHPfBcXAtLD8N5kS7UBsT3M1wo0
 +UkA==
X-Gm-Message-State: AOJu0YyMc1inTwUpZR0VfJLmcBik+QpRZ5m7MYOI9fQQOmrcRn68W8bO
 V6hbezgdyICXDyLQFOP/LrOJZkGBBLLGjEWOJI/czhL3Q+Wv9Vh47376Or640wl2dlDae0DxBLh
 uiygxoqmGiEdVgxpddq1b+Th3cRrVlgghxb8mMw==
X-Google-Smtp-Source: AGHT+IH0Jq3TbGooXrtI/zsp6csyLgRnLi3E5DDQPijubF0SPTO2VGGEKu7bt9UUszUXfHwc4e3zvtho1LSVaTg3eqk=
X-Received: by 2002:a17:90b:38ce:b0:2e2:d15c:1a24 with SMTP id
 98e67ed59e1d1-2e9b174113cmr20431446a91.23.1731421663949; Tue, 12 Nov 2024
 06:27:43 -0800 (PST)
MIME-Version: 1.0
References: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
 <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
 <ZzNkjdHYGXQy_kUa@mt.com>
In-Reply-To: <ZzNkjdHYGXQy_kUa@mt.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Nov 2024 16:27:07 +0200
Message-ID: <CAC_iWjJEiNj+tCj64TXs5i+oqOMnEvevs1YrwPGQJ_XVkWsgsA@mail.gmail.com>
Subject: Re: EFI File renaming
To: Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Venzin Daniel LCPF-CH <Daniel.Venzin@mt.com>, 
 Gujan Armin LCPF-CH <Armin.Gujan@mt.com>, Manuel Traut <manut@mecka.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Burak Gerz <burak@gerz.io>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 12 Nov 2024 at 16:22, Traut Manuel LCPF-CH <Manuel.Traut@mt.com> wrote:
>
> Hi Ilias,
>
> On Tue, Nov 12, 2024 at 03:46:48PM +0200, Ilias Apalodimas wrote:
> > Hello Manuel,
> >
> > On Tue, 12 Nov 2024 at 15:21, Traut Manuel LCPF-CH <Manuel.Traut@mt.com> wrote:
> > >
> > > Hi,
> > >
> > > systemd-boot counting logic requires [0] to be implemented.
> > >
> > > Is anybody already working on this?
> >
> > I am not aware of any patches
>
> thanks for the quick response.
>
> > > If not we plan to add the functionality in fs/fs.c and fs/fat - correct?
> >
> > We don't have plans for it, but explaining any use cases you have might help
>
> systemd-boot is able to do bootcounting by renaming the UKI image [0]
> the code that triggers the not implemented code section is here [1].
>
> With this it is possible to have watchdog based A/B switching on systems
> without a writeable u-boot environment. And therefore it is a nice
> method to implement measured boot.

The A/B is ok, but I cant understand how that realted to measured
boot. The TPM access, UKI infrastucture etc, will work fine without
A/B

Thanks
/Ilias
>
> Regards
> Manuel
>
> [0] https://uapi-group.org/specifications/specs/boot_loader_specification/#boot-counting
> [1] https://github.com/systemd/systemd/blob/3304a029b847e87da51f7a8ad8c118111508e009/src/boot/boot.c#L1407
>
> > Cheers
> > /Ilias
> > >
> > > Cheers
> > > Manuel
> > >
> > > [0] https://elixir.bootlin.com/u-boot/v2025.01-rc1/source/lib/efi_loader/efi_file.c#L971
