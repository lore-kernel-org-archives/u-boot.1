Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44B5CEE350
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 21:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7378488CAE;
	Wed,  9 Oct 2024 23:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JJ5Vi51+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E969988DCF; Wed,  9 Oct 2024 23:14:17 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7F2788CBF
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 23:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbcd8ce5f9so1971286d6.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728508455; x=1729113255; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKS6VhWts9l+FTVCauYx2Tj7mNnBJe5rq+CiWsyeZbM=;
 b=JJ5Vi51+OhDyyTuAsgQ9xtGJcgcywSyg3fp8dRfqacPw+ASI/vhg/dtbsxOOJfULWH
 ZGx5EAv2wf4t+omjGj//kzLauUVnnx4z5AIpbE+dyaCGxypicf9XteED17qv4dBtnBMd
 AeT3yMFyeLzPYMngy4bzfnSg/o/GS2PHZ9nHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728508455; x=1729113255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKS6VhWts9l+FTVCauYx2Tj7mNnBJe5rq+CiWsyeZbM=;
 b=huC3ry22YVeGWUbWPa7ElYX4hmTShagjCauyzSsgD3acxSTA4qjLan3eP2X3PSoJbX
 UmltCG7L+xyWiyZy1wV02G2GOI3liYJJU1eiwXOOOgT53Ny8HtrCatsZQGJa7O2hp0/m
 VP9NKCkvvBdQYmkJaAkRF97EqAz0p4Q+OP6Ni/nQzPnXfXv+CURV0tbT4G5Qbs1u/3NW
 wvvEM8BB1JpRieuh44SIZ6ZlYcYuGOknDFFA5Er96IA3WHSA1Zz/5bSReK3RIH24TVsH
 LQhirNSrTdJCPbOzSJhcqmIewbchqSPKdkX8fESTsETxTze//zcZ+xjz8VmAx/H0ZhnG
 jWmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbT1IgVABbrBXK3qGgrm/QTmP4pPxRq6goNkgMd2FpomLBr9WNhhokY0SxO27XXAKJ9Z05fw4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2zAsvUR+50LilJ5sMLmjWV4VRKRflibSnK6aCMha64TGYme3Z
 JO25b2EcJ6A/TIkX73V8IRO85ytA9rGMVUf8Tip21pIG7FIkchKPD/veXaPBqtHXqDxwzm9ly7W
 xmyPIUVIRqpl61czVgboGe9yWOY02Vy2dkxDb
X-Google-Smtp-Source: AGHT+IFAEeXyQ4dAvaRF4qqw2VRoNzykZyo/bafdAnL4QkZ1wMZjSxZpK/OwHitntJ5gePC2oUcgryPFqds0VDA87Xc=
X-Received: by 2002:a05:6214:4982:b0:6cb:5592:9559 with SMTP id
 6a1803df08f44-6cbc931e9camr82656076d6.16.1728508454875; Wed, 09 Oct 2024
 14:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-4-andriy.shevchenko@linux.intel.com>
 <CAFLszTjff52keqouqR3WK=cM=PX+EiTJQqz+YWBbDe3dSTYY8g@mail.gmail.com>
 <ZwaOPy9NTV4PmY5E@black.fi.intel.com>
In-Reply-To: <ZwaOPy9NTV4PmY5E@black.fi.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Oct 2024 15:14:04 -0600
Message-ID: <CAFLszThN1GbLJerc_4GST7iLORCK1E+jLR9kBRhpXGak_f-q2Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] x86: cpu: Add a few prototypes to the header file
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
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

Hi Andy,

On Wed, 9 Oct 2024 at 08:08, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 08, 2024 at 07:55:33PM -0600, Simon Glass wrote:
> > On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The compiler is not happy to have no prototypes for the functions tha=
t
> > > are not defined static. Add them. This helps avoiding the compiler wa=
rnings:
> > >
> > >   arch/x86/cpu/cpu.c:197:13: warning: no previous prototype for =E2=
=80=98board_final_init=E2=80=99 [-Wmissing-prototypes]
> > >   arch/x86/cpu/cpu.c:205:13: warning: no previous prototype for =E2=
=80=98board_final_cleanup=E2=80=99 [-Wmissing-prototypes]
> > >   arch/x86/cpu/cpu.c:307:5: warning: no previous prototype for =E2=80=
=98reserve_arch=E2=80=99 [-Wmissing-prototypes]
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Thanks!
>
> > OK, but could you add proper comments for these?
>
> Any proposed texts for them? The comments were out of scope of my patch,
> but I may add anything that is provided as a template.

I found some comments in one of the files, so you could use these as a
base. Whenever you change code, you should make sure it has function
comments, follows style, etc. That way things slowly get better.

/*
 * Implement a weak default function for boards that need to do some final =
init
 * before the system is ready.
 */
__weak void board_final_init(void)
{
}

/*
 * Implement a weak default function for boards that need to do some final
 * processing before booting the OS.
 */
__weak void board_final_cleanup(void)
{
}

Regards,
Simon
