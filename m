Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB6DC27C43
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 15:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3924F886D4;
	Thu, 30 May 2024 17:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="YKBiUDbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A918871D; Thu, 30 May 2024 17:17:50 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3440882F1
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 17:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52b7c82e39eso1152614e87.1
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1717082267; x=1717687067; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkpoSAyUNIZBvdUCpgelGSKh9N4wHVwp9+4TvSoQBd4=;
 b=YKBiUDbw38vFXtT3YmhymJEGVOFBgb+CYsz3xVTLVAyEKPQeUFm8BpHryvmnEVCafo
 Fd28IrdwAaD2QUkjKv1e2VQDd6AKzjOlQVySqSa34vVXJe9smvpKuOdpId+jaL4SYwkY
 HbvV3YsBhZhuniDOZbTh7RSisk2QwH2bpCG28COVQmJgHj93w17/r2/GhXWYeefRhn7b
 vpsSECPU4dAxCT4Q2pi9Jr51ExieS3N+Mwln12e9W2rQqq5MAvqmTNQrM7b/co0LiUum
 zU11XnuCLUYzXka97zTv4WPOrwTd94H7nY3h0EQEPNR+wKS05lhKGyKso41xZ1+Ap6Dy
 d8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717082267; x=1717687067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkpoSAyUNIZBvdUCpgelGSKh9N4wHVwp9+4TvSoQBd4=;
 b=WIMx5opMC/EgskEFjZLfhJ6tYhIQMzl/TMW/MllMA6N1y4M6ZJFX8gpdQPdJv9Jq3f
 ZkTIjQAc2vYz3mUT3a7IUfn2RQdlwg1HIDFtupyXu5mvG/iCslxlbpelvo8Wib99yanU
 39E1wdbB9gqhNORX2qPs9gXeJM5Zl3p3ySJhzEbAEd07OB86r8Szgp+yvoNOH8gac2FN
 KkFWdDp1K/WAOxyNNFA0LntWzPbGdty2uDcAQdg63Jr42lSn4Yb43X3VjBX4Rbg6ET46
 olEaXrwfvVIwH/a62TO4yPkrgbp8hhXsShCzmZXOK1MPKrnEjy8CT+EnPEJjlcl6DSru
 PeKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLZbg6e0UTquGjB1NEzb93DLwpvIvFeVMV89KF1PB5dXkaF7om+4BDRjcOIrkHbBYy6/cDluTN7IH1dAZgtyPOJIj3hQ==
X-Gm-Message-State: AOJu0Yx25+NLOjDVTmWPd5FV0Qwl2LtTWLswHrAYJy+m5E0/4pqBKcX7
 GiPVdInQou4+A3GJGoB8NXN7F3bvEbWtQnJ8/fWRxyDV7jh4dGZiGxyBcUJ2LvCSQt3/wZVDDYF
 XVIiCGZuS0RIeE7oKn0fyDIcyGQUwtswWzqechI9qUOLrehFb6UQ=
X-Google-Smtp-Source: AGHT+IEs/eKoqnPFds/UlrNsOaDsjejBILOF5e1Wtx979bpmP7plGb1nBLdvern8ycCAKrhkByod91F4SGez4y3o8m0=
X-Received: by 2002:ac2:4ec6:0:b0:51f:53e0:1bc8 with SMTP id
 2adb3069b0e04-52b7d426a76mr2420431e87.25.1717082267147; Thu, 30 May 2024
 08:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240525200249.3904352-1-tharvey@gateworks.com>
 <CAFLszTifTgSGjAZ-t7-7q6FYRjQ1kfH6hn2dw-hb0PK-2Z3WRg@mail.gmail.com>
 <CAJ+vNU1yQaLgW5f1tSHiZtbWQ_7GPs87GV3FHNK3uvCiFpLvZw@mail.gmail.com>
 <CAFLszTjwuDeQ=xxF8cpMoHmpVPVDkeKKM1a8QRGmVLFzCU=ZSA@mail.gmail.com>
 <744a2f92-18d1-4830-98c0-c6c686cd11ef@denx.de>
In-Reply-To: <744a2f92-18d1-4830-98c0-c6c686cd11ef@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 30 May 2024 08:17:35 -0700
Message-ID: <CAJ+vNU1Cse7ym46kS-85cfKUKAL7noKFuGhXSaJssx1mvLD9Tw@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Marek Vasut <marex@denx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 29, 2024 at 6:39=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 5/29/24 7:05 PM, Simon Glass wrote:
>
> [...]
>
> >>>> that is not yet implemented as DM_RNG. We also skip this if
> >>>> MEASURED_BOOT is enabled as in that case any modifications to the
> >>>> dt will cause measured boot to fail (although there are many other
> >>>> places the dt is altered).
> >>>>
> >>>> As this fdt node is added elsewhere create a library function and
> >>>> use it to deduplicate code. We will provide a parameter to specify t=
he
> >>>> index of the rng device as well as a boolean to overwrite if present=
.
> >>>>
> >>>> For our automatic injection, we will use the first rng device and
> >>>> not overwrite if already present with a non-zero value (which may
> >>>> have been populated by an earlier boot stage). This way if a board
> >>>> specific ft_board_setup() function wants to customize this behavior
> >>>> it can call fdt_kaslrseed with a rng device index of its choosing an=
d
> >>>> set overwrite true.
> >>>
> >>> I suggest creating a sysinfo driver which can provide the RNG device.
> >>
> >> I'm not really clear what you mean but that seems out of scope for
> >> this patch. If/when someone needs to extend the functionality of
> >> specifying one of many RNG's perhaps they can follow that approach.
> >
> > The thing is, you are creating a way to specify the RNG which will
> > presumably lead to different vendors all doing it a different way.
> >
> > Specifically, fdt_kaslrseed() takes a device number (would be better
> > to take a struct udevice, BTW).
> >
> > Instead, I think you should define the standard way that the chosen
> > RNG should be specified by the board. The sysinfo driver can provide a
> > way to do this. Then boards can handle this themselves, using sysinfo,
> > rather than directly calling a function in the fixup. After all, we
> > want the fixup flow to be as generic as possible.
>
> I think this patch simply picks up the first RNG that is available,
> pulls a number out of it, and uses that as the KASLR seed in DT. That's
> what the implementation(s) seems to be doing so far, this patch is a
> deduplication only, so maybe we should retain the original behavior
> first, and do architectural changes in follow up patch(es) ?

Marek,

Thank you - I had a draft saying exactly the same thing that I hadn't
sent out yet.

This is an incremental improvement... for sure there are follow-on
improvements that can be made and should be made but the sysinfo and
policy creation are something I don't have time for at the moment and
may not be the right person to implement that. I'm happy to accept
something to add to my series though!

So the question is, if we can agree that improvements can continue to
be made later should I do one more revision that split this out into
three patches and fixes the typo in the commit?

Best Regards,

Tim
