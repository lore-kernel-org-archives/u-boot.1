Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6247AC531CC
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 09:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A63680D62;
	Sun, 26 Jul 2026 09:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bMOeEif7xzJ0; Sun, 26 Jul 2026 09:40:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D62280D50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785058835;
	bh=Uq78T0VGru5QGXlIJsMj9NrKmqrDar0wk1cP+vuGOdA=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dYlxFpK8VwOgwGhWZTofNL1zF3b33MHAzEfCeqKHIF8ZYu5xrLcCvc+6Uluwld7vy
	 IPI9GdcuR43cp2AR9YvLPKLM504MbTIs/48T3/zotwMkdvXsZ4pVW46CxNvYz5NCPJ
	 eGOE/kr7qHT5sASrBmACYmhLfwgU5moZ76TfYVT9BQf1o+yu/bSGr/G/RGsxwVLYno
	 yk6gece3iEO8o/89h3YAR3ZL45+ZFSy1Osv6/aHDx+mgiNh+yHILjICkuYYMfWybRw
	 UmJKvrLnE1sH0LCrZIfkX59fy1AA1c4chI1yFlvY42/3gm0vAmFhluusM7HcO8211y
	 q/2J3x8wA2K3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D62280D50;
	Sun, 26 Jul 2026 09:40:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D157490
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 09:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 039CC80D50
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 09:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOzkoElEvH9I for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 09:40:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DFD2480D5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DFD2480D5B
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFD2480D5B
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 09:40:32 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3997a448ecbso16776071fa.0
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 02:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785058830; cv=none;
 d=google.com; s=arc-20260327;
 b=Gx8rZblZ09viBO9WK8greKbiGzypYZzY28tdcgOhZtNE4pxjC8uKZ86df23Uw2papF
 OwvWRwbB7SsNYjAwtsERW4H+v7Hvr+at0fCOyaZ403UspE+1DVtULj57Eq87L1Ed+XZ4
 2IWqMDZk43eggJR0Kej1xCDNSKNUuFe5rL3UygwlMBryWtnafnyMHX6+hkezyHcrlIFj
 Vto1b1kDmN6f87/sRDiMWYGV01srKPFD+e9DlGQAPwJbZnwYfZAM/h7XsEGvXoMbTyNf
 psQwWgbJbcKOSii++/x98JwKkeFSe93VS9CgwVP5RHFF9GJ3Xmqfy67hm2voYl+o45Me
 WkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Uq78T0VGru5QGXlIJsMj9NrKmqrDar0wk1cP+vuGOdA=;
 fh=y+1+lbVY0sAGTTAMIIht49vWEHvrU5M06daWIkYv47s=;
 b=Lb4DkeTWkCFBnT8HJHLsFTY47kDUioDyN0ypzrdaSjzLmy+9RGAaOt9pYgxTkiq4/T
 Ow2y963sWjdUWI84wtQ775S82vtT1JhN4Oy44ZknNLfgPJJbwR2TSM/twxUQAAGts8cI
 KHXTbnp4hNVih2x8/fw5SaA2ZrEgtK0qgaY2pgQhGuhAh+8anPkXjDsMy4KAexD42bcu
 bDYjzBOVEoYEA/THb0DImg2U5sOWzrihmoPDqDbIzs8y9Lv+DVtMHMWQh+0bGh8U83TI
 5mwEin2+5wY/f9Jkbyj4PC1l6bPMFXU+zUWERz2VtV/XmSyC1BfSH4ZBRdFByNanOEwf
 X9Fw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785058830; x=1785663630;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uq78T0VGru5QGXlIJsMj9NrKmqrDar0wk1cP+vuGOdA=;
 b=cYB8w3QnLBFniFY7YTIkqfPCqIg+pT4Q/IbwZnr3Z9CHnQGSTgody05w+Ld6iTfHDN
 gQLzNHKIzPqmJJRRarEwMyDhRQUxQ48AfjjEsXirytPJOYvAr+kLzwICYjW2FVVO59sO
 zCFIPaTCDXSM+0OSUYwMiaZpBjkI/HCq0b6MHHQ2Tgvkv0gR5XS4+ObbSAnhxcWDzWP7
 OU9xvJSNjviv/uk79I5xFBO4FzOM+pr2CEuaiPI5ahCzI+fiCtQ0S+EADETLABmYXDtr
 kbJO4DYB2CDgdPSLzK5ulyGiJYau1JXOTySLVbm/bbAoDqUVZG9llZo1xeBxmrtPt0fb
 C+YQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLvF03aroKDNb6j9Cxuz1K9XGFy2GtsFpXu3y9KPVGwfykP+NDZCZqBayP8QNhXzzlunpIe8Y=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyaEgSOCfPq+iKhMyjF/cdazTz/RZBS5UKz+8bhhhTfVeMb5jVS
 6VAEmBEUmWi8Y1Nkm7Hzex0O8rj0C5d9/3nP1qR786TlZLXoMq5gYaELpyzDFK5TJzDybOBz63d
 VYpYAEqgYWBZmSR2ZJfd/57+F81wh0buN2kJ14mK3twr4pADTbFJngcN3hw==
X-Gm-Gg: AR+sD12+Y4U2myqCcgOrh9cUB/89StOWSvGRLeyOkpdO5wwFXD4tXqniXAbS4VRVwvE
 hBGm49KeRNq7I57IQEJI/SWMSF9Vsax4AP/oYdiibisqUzuUVMvut3W1oLHD//Zg6BWK5WImwt9
 0psX4wz8gyBLMs4xttN/mpwuw103gI4b7A0nTyNAgkACFjG8XhCet7kIR6wyREO+V4sSmMm2eD1
 RCxL08trtP0zoIxxlguFTwiFoFj9+7wm092oTL4rY4mncIah9Tl0tAUNvelQXTZ
X-Received: by 2002:a05:6512:3d0d:b0:5b1:53e9:439e with SMTP id
 2adb3069b0e04-5b2c1b26e4dmr830517e87.36.1785058829390; Sun, 26 Jul 2026
 02:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260622194308.70639-1-charles.perry@microchip.com>
 <amSS9gMuX1EThezO@lliang-1876.localdomain>
 <87se57s3z5.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87se57s3z5.fsf@bloch.sibelius.xs4all.nl>
Date: Sun, 26 Jul 2026 17:40:15 +0800
X-Gm-Features: AUfX_mwEUO0JJKQCqLAX3YoZGILnDRyaJCBFIkaa7YbFqWQdHkmVdOJsuGMM-mU
Message-ID: <CAC7DN2BJR3bKPpQcfWu-wh3rM3D2TotkeLPOSHbmYEyOQwqXkg@mail.gmail.com>
Subject: Re: [PATCH] riscv: remove log_debug() in enable_caches()
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: charles.perry@microchip.com, u-boot@lists.denx.de, rick@andestech.com, 
 ycliang@andestech.com, trini@konsulko.com, mchitale@ventanamicro.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785058830; x=1785663630;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uq78T0VGru5QGXlIJsMj9NrKmqrDar0wk1cP+vuGOdA=;
 b=Yyqi12Lhn8Y6g4/zI9H/cW3RUSgB3UaYmY4J2cSoSzvhc68MOMnwgFWemaIvVOn6be
 sJO5hgeRNY/iIYqs1p0/v3tVijVifedZXgyURDA+ieJ6jVReUYLxWoBrnkn5N4+yLpB5
 W3nuERsokX3m5qqYDlKM9b6RfPTzH4U9tQw9VIo/xNcZHU0B3SxGisg9Mopi124beD9E
 1mZcg9v1dskpnGNi/INIXibvE2bxxQMgXoPThjyV7AZ1XIv3cK8axQImNYG02seloDNU
 WAGlFI5I8v1s+NXp9oW/xFRGnPnOC9b+m9+qbCvvzo2/Mk1bYdKmUlY04zvvGOZkKyY/
 bA6g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=Yyqi12Lh
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Mark,

On Sat, Jul 25, 2026 at 7:28=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4all=
.nl> wrote:
>
> > Date: Sat, 25 Jul 2026 18:41:58 +0800
> > From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
>
> Sorry I didn't spot it before but...
>
> > On Mon, Jun 22, 2026 at 12:43:07PM -0700, Charles Perry wrote:
> > > log_debug() cannot be used before log_init() has been called. Remove =
the
> > > log_debug() statement in enable_caches() since it is called after
> > > log_init() in initcall_run_r().
>
> This part of the commit message contradicts itself.  Should "after" in
> the second sentence be "before"?
>

Thanks for the catch!
It should be
'log_debug() statement in enable_caches() since it is called
**before** log_init() in initcall_run_r().'
I will correct it when merging the patch.

Best regards,
Leo

> > >
> > > This fixes a bug where a RISC-V system which does not have the "zicbo=
m"
> > > extension (such as PIC64-HPSC/HX) would get lost in an infinite loop =
in
> > > log_dispatch().
> > >
> > > Fixes: 9e859849e2ca ("riscv: cache: Add CBO instructions")
> > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > ---
> > >  arch/riscv/lib/cache.c | 2 --
> > >  1 file changed, 2 deletions(-)
> >
> > Applied to u-boot-riscv/main, thanks.
> >
> > Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
> >
> > Best regards,
> > Leo
> >
