Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C732BC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD99875FC;
	Sun, 31 Dec 2023 13:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RGXtpM1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E63387831; Sun, 31 Dec 2023 13:49:29 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C41887852
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67f95d69115so65608096d6.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026961; x=1704631761; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eq9c8FncSLgM0p2hR9L/zlgeYYcpLpDMJYnKYUZ1OO8=;
 b=RGXtpM1XNdm0l7conR4cHlfy0ApGcEpgkUa7VXaAwj8EIl9OqWA9lJu4GaUQdtc4la
 Xmzn1GEpuGA+eGOScGfp06iITHWbtP+fLGg2LrDIwjVx/AP5S2dtgkyN7Yk3o8Fb0oDa
 XeKpL6l/4/PZb3Ztrnx76AXfEDYL87UbHbU1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026961; x=1704631761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eq9c8FncSLgM0p2hR9L/zlgeYYcpLpDMJYnKYUZ1OO8=;
 b=d9aQLp+i/MYep5MgMio6isi/a3KBC4+u+RfkYh6KFUgTxkbfVfo2faB0vebRZnuSUO
 VulUtT9acCcKA7WdsOh0YlhB5atDxctMq1m9mD015YKamu+3hp0l22A4RbedYA5F1BpV
 aDk1y8JHTbXpEfuxJzJdUPBHF7hv05SSd6/kLQxgSAvUP8i5I5jy0UIZCdRYcoYcczap
 ezpHQYdc2tZ+Mz7MX29yplSQsNPsXi3is8MGlfEh2aQEYCz22oPzfrmnZJZb+zWCOIPB
 2xmj2wrCuAG3w2xJbCLuKo/KD5lJKGVWMsqj2GhY4LIM3tx/CxjP+I3MrwyY3HnC+hKY
 3SKw==
X-Gm-Message-State: AOJu0Yx8GnVcX7OWK6EC0eIaAVqdpLcAzYnn6SyaGbk3OW2or6IDZ2Zo
 lOQEtXp2SkOqmLRyYOGY1d2lEc8cep7Uvp6oUN2XP2e+IX9d
X-Google-Smtp-Source: AGHT+IGOqJL9OLGUNgvXmdUN7TF/OBvXUqf2/1xXnPX9XvluwRq+Dq92o3mesxJ1HxJy3jKkTjPFsd9yPCabcYQuClQ=
X-Received: by 2002:ad4:5946:0:b0:680:a620:2673 with SMTP id
 eo6-20020ad45946000000b00680a6202673mr3814135qvb.38.1704026961255; Sun, 31
 Dec 2023 04:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-5-sjg@chromium.org>
 <CAC_iWj+yGhUVFh+vJ14C2htibdd289SrPjz0Y_r3GL4uF4Zdog@mail.gmail.com>
 <CAFLszTgXZ3fMZkuYRJUzSBv-VT659Q5bYLyVkEh4=-36TM3+Bw@mail.gmail.com>
 <87edf6mlla.fsf@bloch.sibelius.xs4all.nl>
 <20231228175751.GN2652760@bill-the-cat>
In-Reply-To: <20231228175751.GN2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:49:10 -0700
Message-ID: <CAFLszTjMuLLw8_j6a5v8dcjG5bVajUgc0wND2caL0zXeF5miSw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] smbios: Use SMBIOS 3.0 to support an address above
 4GB
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de, xypron.glpk@gmx.de, pbrobinson@gmail.com
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

On Thu, Dec 28, 2023 at 10:57=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Dec 28, 2023 at 03:46:09PM +0100, Mark Kettenis wrote:
> > > From: Simon Glass <sjg@chromium.org>
> > > Date: Thu, 28 Dec 2023 13:37:03 +0000
> > >
> > > Hi Ilias,
> > >
> > > On Wed, Dec 27, 2023 at 11:05=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > When the SMBIOS table is written to an address above 4GB a 32-bit=
 table
> > > > > address is not large enough.
> > > > >
> > > > > Use an SMBIOS3 table in that case.
> > > >
> > > > Maybe I missed this on the previous revisions, but is there a reaso=
n
> > > > we don't always use SMBIOS3 now?
> > >
> > > I am not sure...there was some comment about it not being supported i=
n
> > > some cases, so I have tried to accommodate that.
> > >
> > > >  And perhaps try to install SMBIOS2 if
> > > > 1. we fail
> > >
> > > due to?
> > >
> > > > 2. and the address is < 4GB
> > >
> > > We could, I suppose. Effectively we would drop generation of SMBIOS2.
> > >
> > > I really don't mind. This whole SMBIOS thing is a bit ridiculous, if
> > > you ask me.
> >
> > Linux added support for the SMBIOS 3.0 64-bit entry point in 2014.  I
> > doubt anyone who cares about SMBIOS cares about kernels that old.
> >
> > So if it simplifies things, I'd drop support for the 32-bit SMBIOS
> > entry point.
>
> I agree, lets just provide SMBIOS3 tables.

OK...I would like to do this as a followup patch, so we still have the
SMBIOS2 in the git history. I will take a look.

Regards,
Simon
