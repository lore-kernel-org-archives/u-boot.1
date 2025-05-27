Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE6AC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 07:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BAF382FBE;
	Tue, 27 May 2025 09:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g/lyChWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1247182FC5; Tue, 27 May 2025 09:30:06 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE11282FB8
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 09:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60461fc88d7so4133378a12.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748331003; x=1748935803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nO6RdrO4JMiiGzihBVGseB5Y0Errp9mJZIzq+F6dA1c=;
 b=g/lyChWx+ELzRGG/aoFceHdFAFxDd5bDzHX7+Y1FEjgX0Wzyy4NGL1wg8Xkmu054E2
 9YBy0auf6s7WB1bEoOXVkMuD/z1EttXopDmDb82dlmyzMqKWn8Hx6ead+hxZx85JfBN0
 lPB6jnk7t8koOI8lH45JMvhfXGXElzJBILuwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748331003; x=1748935803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nO6RdrO4JMiiGzihBVGseB5Y0Errp9mJZIzq+F6dA1c=;
 b=R7O2gEVfJ803jRZ57rWAU2M9A577Sx3/sW2vSDCTbfTWtKjErkbT6eyzWq//O7dYGG
 ZFzdA4XiE81pgzOMf84K0AdtEyOvRbXVZz7MNjlOaOC9TYE1EPqZZ3q7o3RCZJrggeEd
 4DjOt8oHBbglo/gOy34oBNbRqsGLrJB/BtaMlTxwMdaqxA+bn4lxean5RsHjMLqD8xWh
 WgU08/zA6odqdhUaoCuw+fNJ/y9zS6gZqL9t2tpl6DISLZCGPLwn+PA3GuwPK78ENt/m
 l8EWDTHMFUkvRJZYQRznXXcquOVT9RQrDOiDbzpPCoJkxv4jDUip73Nc+LVr28p6TZYh
 zqFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqasGma7AG2l2RiTYbFj/u/b1iPm53wCnPclwSime01eKhhZU666kb9PpODRNigFrND6F64kM=@lists.denx.de
X-Gm-Message-State: AOJu0YyMpk6dw3dOu7RmTxKtXJhvKwqSMeUVMFI8jnGtCcEjuRwT+6Es
 r01pclZPmX0RqqAUw9jl7ezwMkc/vTex5szqc1Stcz9TJzC8s4RuIbk7UYuJ+TiShewFwrsUH+0
 imG0vfQUz6Z/4F/18oOpfmsojG0DcRbXyugcg6ajTe8ARGho+NzlQTg==
X-Gm-Gg: ASbGncusUZy2v7PGUCwYPtheZiiNc2MEw/Hz/+kZVBHK6dMckKm61bGDG68OfQSa2s+
 OP7n4FSgdfA7cA3W0xaab4OUygIHGO2/hUpZC4MJHeMiVuWGGPoaYHzgljXys80PgTLCNJNNf8F
 pniJoEUR7V3obWG9GkXlsGMzeT22xBNoo=
X-Google-Smtp-Source: AGHT+IF5Q0yfkqXT8pD1iIesg+eD20D5y7YwOdqEoFwRm0RcGFNIt80Yq/H7hTPNffgxsbO9tM2qdXhaiT1mlTAZoyg=
X-Received: by 2002:a17:907:da0:b0:ad8:8c09:a51a with SMTP id
 a640c23a62f3a-ad88c09a678mr163261866b.4.1748331003087; Tue, 27 May 2025
 00:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThbRhKF1Xwqk+hLu8Y-VXB6+fHVXYfphfVjWMN=dVC1dg@mail.gmail.com>
 <20250525135553.GQ100073@bill-the-cat>
 <CAFLszTgPK_TWjoaJPMa6RAH-pugpO_uhkm-VafQLzaNuFZRDLw@mail.gmail.com>
 <d041c823-a258-4d73-902d-350a2aae0066@kwiboo.se>
In-Reply-To: <d041c823-a258-4d73-902d-350a2aae0066@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 May 2025 08:29:51 +0100
X-Gm-Features: AX0GCFts6Gr7CPZrMIfkq4-JSo5bnth-mOXO7UiOoYgbF0qgDevHibkUyLONjF8
Message-ID: <CAFLszThT_kqtDtGW5Tij9gz9zDVJ3FMwnKRQ7JAUMQamfmEs2w@mail.gmail.com>
Subject: Re: Broken boards?
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonas,

On Sun, 25 May 2025 at 20:51, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-05-25 20:05, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 25 May 2025 at 14:55, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Sun, May 25, 2025 at 09:46:03AM +0100, Simon Glass wrote:
> >>
> >>> Hi Tom,
> >>>
> >>> It seems that some of the boards in my lab are broken in your tree.
> >>> Have you noticed that?
> >>
> >> Your lab has never fully functioned in mainline, so no I've not paid
> >> attention to it and don't use it. I figure it's part of the lab
> >> maintainers duties to figure out false failures and
> >> more-or-less-expected failures.
> >
> > Oh, that's a shame. I didn't know you had stopped using it.
> >
> > I use it on nearly every PR. I did once send a patch to disable the
> > boards that were broken, then another to re-enable them, but I don't
> > think you took either of them...
> >
> > Here's a recent run showing a few problems:
> >
> > https://sjg.u-boot.org/u-boot/u-boot/-/pipelines/794
> >
> > But x86, RISC-V and some rockchip seem to be broken in your tree.
>
> At least for bob, jerry and kevin you will need to change your lab
> configuration/scripts to use u-boot-rockchip-spi.bin as the old
> u-boot.rom finally has been removed from mainline [1].

Ah yes, I forgot about that, thanks. I've added it as a fallback if
u-boot.rom doesn't exist, so bisecting still works.

>
> [1] http://lore.kernel.org/r/20250505-has_rom-u-boot-rockchip-spi-bin-v3-0-75f23b3bd8d3@cherry.de/
>
> Regards,
> Jonas

Regards,
Simon
