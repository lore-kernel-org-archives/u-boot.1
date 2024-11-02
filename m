Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9B9E67807
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 16:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE538890F2;
	Sat,  2 Nov 2024 17:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nem2/NaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 960E6892DE; Sat,  2 Nov 2024 17:33:21 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30D678919F
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 17:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99ebb390a5so721987666b.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730565196; x=1731169996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IQn0eY1RQvWzLL5Q1dexEcQ39SkRyv9vPf15g/5Wgok=;
 b=nem2/NaO+ljNGICRHJZghxpwO042quLeZNxUtiOfXL6oKc/y18veE92tO7UNDO+UOa
 X8HscTOMsdOSX6bUCR06fs/eryDv8RmutEaIBk8mhwMXh8qugWO3yiNtbozZKF13mZEW
 P0ejwRgO/DmjEssl1rVrBUkRMyWDKei/uF3bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730565196; x=1731169996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IQn0eY1RQvWzLL5Q1dexEcQ39SkRyv9vPf15g/5Wgok=;
 b=m9KgsUNJqjziwLwucsPGJQzMfnXAITkQlk+Iw6jG+3n7acbbKvuS6GWUj/PrkauwQv
 tlS96kbAn/2cbQX/qOE/2gZ41sorOIcIjwIFR41nwsZR6oDXHy1Y6m+NF5OA6xAOmUmy
 UymX52LdaUvekcz6i/jXFjkragE1XreQC/x1bPfEQfyztNvIJcWAH+Vxpui0nYPqFsWx
 cfbK1Fz1p+CQ3SL2FrcugoAI3+QoYfWZABsV+BZLaBRNdmQc+S8hsEn/E1c48V0qJ4+d
 Juj1BAY5JsZqrYngjmg2EykxIBwsDPiHBdkN35om+G1m4QiqA20FJtrgsT607CuIx6j2
 doRQ==
X-Gm-Message-State: AOJu0YxSxxxfCXRk/Sz7kC2e1ZOgEofrXfNaFVwjo4r63EFr7qibmMWn
 WZEET3d+N0x7jX+fiVZthBY1GcD6YRM47wQyHc9i1cJg+iDifWZTvi6xjssbAkd9Djg82/bwhL3
 VRTu18mBTfYuf1zl8ZU+EWajxfN33s52p9K3z
X-Google-Smtp-Source: AGHT+IHEfgy01Pr8090WH1VvMOlvf6SbMAz0bY50DVwG6lfc5wIk8C66u0qoqawP4XbiYtLDuv86m+/JYH/DEnj6z18=
X-Received: by 2002:a17:907:9444:b0:a99:f722:2dde with SMTP id
 a640c23a62f3a-a9e652a3f1amr682212966b.1.1730565196602; Sat, 02 Nov 2024
 09:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241026120252.865215-1-sjg@chromium.org>
 <20241026223346.GI4959@bill-the-cat>
 <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
 <20241027145625.GJ4959@bill-the-cat>
 <CAFLszTikk2GmY0PNc=JZUAsb-SiYSbheAKaOa_msTBVLpBMueA@mail.gmail.com>
 <20241101162644.GP3600562@bill-the-cat>
In-Reply-To: <20241101162644.GP3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 10:33:04 -0600
Message-ID: <CAFLszTh57pYQYW9KbfG+XkYC6VP07dn68R90MekMFKgBorWsEw@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox: Add a build without CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

Hi Tom,

On Fri, 1 Nov 2024 at 17:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 01, 2024 at 04:38:26PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 27 Oct 2024 at 15:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Oct 27, 2024 at 03:52:02PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 27 Oct 2024 at 00:33, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Oct 26, 2024 at 02:02:49PM +0200, Simon Glass wrote:
> > > > >
> > > > > > Something this breaks, so add a build to keep it working. Since sandbox
> > > > > > enables a lot of options, it is a good board to use. The new config is
> > > > > > created simply by copying the existing sandbox and turning off CMDLINE
> > > > > >
> > > > > > Once we have tests for non-CMDLINE operation, this can be adjusted to
> > > > > > run those tests.
> > > > > >
> > > > > > Create a new build which will be picked up by CI. Update the maintainer
> > > > > > entry as well.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Create a new build instead of messing with CI
> > > > > >
> > > > > >  MAINTAINERS                         |   1 +
> > > > > >  configs/sandbox_nocmdline_defconfig | 365 ++++++++++++++++++++++++++++
> > > > > >  2 files changed, 366 insertions(+)
> > > > > >  create mode 100644 configs/sandbox_nocmdline_defconfig
> > > > >
> > > > > Please use the #include mechanism instead of a full config that will
> > > > > also now have to be kept in sync.
> > > >
> > > > Hmmm we still haven't come up with a way to deal with the #include
> > > > mechanism in buildman. I've forgotten where it got to, or even what
> > > > the problem was?
> > >
> > > I assume this is related to the issue I filed? Among the problems are
> > > that buildman doesn't "know" about the architecture for example in time
> > > and so thinks everything is sandbox (since that's the default). That
> > > won't be an issue for your use case here (we have a number of defconfigs
> > > today that work around this issue by setting CONFIG_ARM=y and then a few
> > > other options too, so that the resulting build ends up correct).
> >
> > Yes...OK so I think I understand. If we are happy with the '#include'
> > scheme then I believe it would be easy enough to implement in
> > buildman. As Caleb mentions, it could likely run the pre-processor
> > first, or just process the #includes (which I prefer).
> >
> > Is the '#include' in defconfigs documented somewhere in Linux or
> > U-Boot? I really had no idea about this until you mentioned it.
>
> It should be documented somewhere too, yes. But you did review the
> original in 2027e99e61aa :)

Yes, although my question was never addressed [1]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230829221457.101469-2-afd@ti.com/
