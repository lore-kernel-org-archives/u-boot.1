Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B36C25B48
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 02:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F14B879E5;
	Wed, 25 Oct 2023 04:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JfbLf5HX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C4F879FE; Wed, 25 Oct 2023 04:47:59 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D828B879B3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 04:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so7664689a12.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 19:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698202076; x=1698806876; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ifvmx+WkF6qjSsdzeKrTja0hGDLkmILqCuY/Ottjbo=;
 b=JfbLf5HXuA2eT5LJsQfazRh3rDet8rwELBK7wyfPALmTulvv87eIOrgcKTShU2C5wx
 MPPNLYe/at78zGL0IE0KMBdQT2i+efg30BeQVtaFHNO+VP9IQtcw5emNbn6QSNHYjXPf
 l3gFkefADt/K7RobJcuQzCBqltw6Px1ZHjvDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698202076; x=1698806876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Ifvmx+WkF6qjSsdzeKrTja0hGDLkmILqCuY/Ottjbo=;
 b=DFmawcnI36nU0p45X/a7iUE021jTQ3tuKkIpozS8v982fP8S9WxxDWSsgoqbTVOp4Y
 cutUlmP5HQ40ORQXnLIXUCGjJQrCLbZkfVeqFc/tYPbyNyuGxv4+K6StFJPYt0mS8uDO
 hcEEE4zK0MvrmiGYZu8/VtAY5ME8q+0dYGZb/kIBfg8MSbB8OLZOiPg18ifsagHeAmXq
 RdsD1RYSa296IIB4661lOz3q6h4NipQlmKPOI2DdcdQ5Ddowpx8H+koni8AkDw9xOKQI
 WI0ZZihXUXx2xG+t17u6+Grkbdi49lf6nlENz9iT43SlT+xOX94Q1n7JxnoRqAb0hz89
 mUvQ==
X-Gm-Message-State: AOJu0YzRmHgC4O6j38XWB+BD2SfWQGSZnwOd5jlC+6kEHAJY4EqLSlHv
 pXrBeYk07G2BSSGlbErNXq3ClASBbKf7BjyIbbrvRQ==
X-Google-Smtp-Source: AGHT+IETdcSyJRsiULDVmk/631tJw+dnhCyN9nXC7Q1rqgPdeCjmYX2Du8u6K2pBJWq5vDGqYxJ/EzO+HXzuVSMIauw=
X-Received: by 2002:a50:d795:0:b0:53e:467c:33f1 with SMTP id
 w21-20020a50d795000000b0053e467c33f1mr10697704edi.8.1698202076210; Tue, 24
 Oct 2023 19:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <CAPnjgZ1h2GUWKupVJcNEQmQd1JJf1h9X+xkc3P=+qxmfCwAcOA@mail.gmail.com>
 <5F047C34-685E-41E9-A726-6003B8FCFB56@gmx.de>
 <20231025004415.GJ496310@bill-the-cat>
In-Reply-To: <20231025004415.GJ496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 19:47:44 -0700
Message-ID: <CAPnjgZ3Pbwt+Sq5rVky5JOYpgGQngteZ3Z_zL2oX-_2PQFi_Gw@mail.gmail.com>
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 caleb.connolly@linaro.org, u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 bmeng.cn@gmail.com, brandon.maier@collins.com, kconsul@ventanamicro.com, 
 oleksandr.suvorov@foundries.io, patrick.delaunay@foss.st.com, 
 sughosh.ganu@linaro.org
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

On Tue, 24 Oct 2023 at 17:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 25, 2023 at 02:19:59AM +0200, Heinrich Schuchardt wrote:
> >
> >
> > Am 25. Oktober 2023 01:28:10 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > >Hi Tom,
> > >
> > >On Tue, 24 Oct 2023 at 15:34, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
> > >> > > From: Simon Glass <sjg@chromium.org>
> > >> > > Date: Mon, 23 Oct 2023 00:04:14 -0700
> > >> > >
> > >> > > Hi Caleb,
> > >> > >
> > >> > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > >> > > >
> > >> > > > Hi Simon,
> > >> > > >
> > >> > > > On 21/10/2023 01:45, Simon Glass wrote:
> > >> > > > > U-Boot typically sets up its malloc() pool near the top of memory. On
> > >> > > > > ARM64 systems this can result in an SMBIOS table above 4GB which is
> > >> > > > > not supported by SMBIOSv2.
> > >> [snip]
> > >> > There is absolutely no guarantee that arm64 machines have memory below
> > >> > 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Opteron
> > >> > A1100 SoC and all the recent Apple SoCs.
> > >>
> > >> So one thing to resolve here is where does that requirement about the
> > >> SMBIOS table needing to be below 4GB come from (standards wise), and in
> > >> turn is that obeyed by consumers like say Linux or OpenBSD? Answering my
> > >> own question, maybe in part, https://www.dmtf.org/standards/smbios reads
> > >> to me like there's a v3 and maybe we should be doing what we need to
> > >> support / identify as that, if it doesn't have that restriction?
> > >
> > >Yes that was my previous patch. However 1) we apparently don't want to
> > >use SMBIOS3 and 2) my patch had some sort of bug so that it wasn't
> > >read correctly.
> > >
> > >So my next version is going to be along the lines of what was discussed here.
> > >
> > >Of course, we cannot solve Mark's problem with SMBIOS2, but I suppose
> > >that is obvious. Anyway, those platforms probably don't need SMBIOS.
> >
> > You are heading in the wrong direction. We need SMBIOS 3. SMBIOS 2 is
> > only a fallback for outdated tools.
> >
> > Upcoming mainline RISC-V platforms will also have memory starting above 4GiB.
>
> I want to echo this because yes, SMBIOS if I'm recalling things right is
> one of those tools used to provide user friendly information about the
> system, so "everyone" wants it, or at least platforms like ones Mark is
> concerned about that have more human users than embedded system users,
> would like to show the information.  Maybe part of the answer moving
> forward is to allow being specific about SMBIOS2 or SMBIOS3 (or none) so
> that the issue you had to fix can also be addressed minimally?

OK, so perhaps fixing up this patch would work? [1]

I got the impression that we wanted to continue to use SMBIOS2 unless
we couldn't. So this patch provides for that. It is conceptually
similar to the way things worked before, so provides the smallest
possible change. The move to SMBIOS3 is really a separate issue, isn't
it?

In fact, how can writing SMBIOS2 have ever worked on machines without
memory below 4GB? That seems like a 'feature request' rather than a
bug fix...and the merge window is closed.

So...?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20231015024511.3995580-4-sjg@chromium.org/
