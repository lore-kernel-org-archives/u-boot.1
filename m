Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFB1C27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C51A8887B;
	Wed, 12 Jun 2024 22:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zbco427A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C0888863; Wed, 12 Jun 2024 22:24:42 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E4EF88868
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2bfdae7997aso161774a91.2
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223877; x=1718828677; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYS2lga+5EbbNUUbrAy3zj0yJ0HnLtoMaj+zW1vm16s=;
 b=Zbco427AOHDzGRMT7oHjdhByCjL1v4bTbckwLeA61/pJZb/FMV+ut0iq0NZa1bISEy
 GLXdkilJBSuvmDRFhnQP331nxXp7rcHxEG7V0oSG8LBdTG0wOEowoDiNdK66WsCLbrTp
 UmudOp1mUHsa8V8hb6zX4VrHtcKBXUvxqy+Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223877; x=1718828677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYS2lga+5EbbNUUbrAy3zj0yJ0HnLtoMaj+zW1vm16s=;
 b=G3B6UKx2sgazVfmJcpbbKpynYfL593UEyGOH7RsIjXdCYNPSaAEcHwbJd6Zd068Enz
 QpPNChrvyH0sBvirywYWgA0xAZn34tBWf6eqUUIGDXM6LdW/at6IlICPoe5qeTWg8UKs
 MlyFdyvisQv+cO13bRvgvoP4vaW+tNwCDSZOVMQ6sqHOhpnR9R32QSCMT7UJegUhk0zu
 jaXW0j62K1qOuQ/EJTIy4HF0QTfkGxSpEGhhjoBoxzTZgOHL4bMfZw47tXJBnmGEz8oO
 azue8bh6Yks6ZvZk8NKAK9xoo1BbmFUHF+ooSA67wsadohIi5iVBqXNkhGFDDF9Z+mzD
 apYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp/zxCvqFozmgJzlpbGq3+IZh/EZJ/f9lqu8ilC0NpGuA5/N4GZTAnumEsdn1CCiNyo9tC5SED663Wk2DKJctCyWE3+A==
X-Gm-Message-State: AOJu0YzTpcaLmz8lb2wfuLvs6Rp0me+sjon/4WzIs1xHWSHFEGR87XNu
 F/RNWaBPUmoBg8gcDmI8cbYMqW0ShQYkSRSNqBSGnPocfgkjItCVqASJYCCShoI/uPYaiCZyxy3
 CF1CchMQ8Nstp1+R16jIoQJG0aswSj/tK0mwT
X-Google-Smtp-Source: AGHT+IENHaAAF2l+SBFHOwYlK9E3n79X/DWw/hoSsaZMxMU2WGin3kCA4AORcH4XDHmugN9L0lvm9ayuW9dodDaN6+U=
X-Received: by 2002:a17:90a:c095:b0:2c2:e45b:ecd with SMTP id
 98e67ed59e1d1-2c4a762e320mr2805389a91.12.1718223876953; Wed, 12 Jun 2024
 13:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-14-51472eb70357@flygoat.com>
 <20240612160104.GU68077@bill-the-cat>
 <894fd87b-ece7-48b6-bf20-2c6621e7224e@app.fastmail.com>
 <20240612170742.GE68077@bill-the-cat>
In-Reply-To: <20240612170742.GE68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:24 -0600
Message-ID: <CAFLszTjLL6Tc2o8sY9Ki-ZthHcxc2SyNe8fNN+mnU86b_n7=Kg@mail.gmail.com>
Subject: Re: [PATCH 14/20] CI: GitLab: Split build_world tasks
To: Tom Rini <trini@konsulko.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
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

Hi Tom,

On Wed, 12 Jun 2024 at 11:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 12, 2024 at 05:14:46PM +0100, Jiaxun Yang wrote:
> >
> >
> > =E5=9C=A82024=E5=B9=B46=E6=9C=8812=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=885:01=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> > > On Tue, Jun 11, 2024 at 10:04:13PM +0100, Jiaxun Yang wrote:
> > >
> > >> Current build_world task runs for too long on public gitlab
> > >> runner.
> > >>
> > >> Split the job as what we've done to azure pipeline.
> > >>
> > >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >> ---
> > >>  .gitlab-ci.yml | 103 +++++++++++++++++++++++++++++++++-------------=
-----------
> > >>  1 file changed, 59 insertions(+), 44 deletions(-)
> > >
> > > I don't like this. The list in Azure is because of the time limits th=
ere
> > > and in turn we:
> > > a) Have to tweak it periodically to keep things from running too long
> > > b) Have to tweak it to ensure that we don't miss some new SoC/etc
> >
> > Then it will render running CI test on gitlab.com impossible again :-(
>
> Yeah, it's not something I'm the happiest with. Looking around a bit, I
> see a blog post that talks about dealing with dynamic variables, in
> Azure. So we could, I think, figure out some logic to have each build
> stage say what platforms it covers. And then have a final step that
> compares all of the platforms built vs the global list (just
> tools/buildman/buildman --dry-run -v) to make sure nothing was missed.
> With something like that, and assuming GitLab can do it too (it probably
> can), I'm OK with having the world build be broken down to 10 groups
> (maximum number of parallel jobs in Azure CI for free) since we'll know
> if we miss something too.
>
> So lets set this patch (and the doc update) aside for now, unless you
> want to look at the above. I'll look at the above soon.

Could we hook up one of our machines as a public runner somehow?

Regards,
Simon
