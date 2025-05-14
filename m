Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7C9C3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 19:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B08082AAF;
	Wed, 14 May 2025 21:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kfB7UCsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7008B82AC1; Wed, 14 May 2025 21:39:46 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A1982AAF
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 21:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5fbed53b421so410243a12.0
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747251584; x=1747856384; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vf9DYAE4tLuD+OYEKnOxoKrVEcCFYi6ChCJIQDtI2lM=;
 b=kfB7UCsw+qKmtZsdke7DD2Gm0HzN4BQvkh59unurhGieDn2bxv8j0H4dQieKB1SNp9
 PceQJs+4vjd4DzmZJnCXlY0DN8aLOeOt+DRVtdp4s9SGSEzlQF3SjDpAzoALKIwABISx
 TneZWOUGvalqpgOGID7ayYSjXCAfYNU9LevuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747251584; x=1747856384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vf9DYAE4tLuD+OYEKnOxoKrVEcCFYi6ChCJIQDtI2lM=;
 b=s51tcgomCpFl1WVRQQz/th417imkcYExaVKyROlp4mdNEclxM2hR7DQU0vp27Xie1i
 rTPr3Csoi4KRhLatPRcrfYeCZ2cBQ6n84s0Q91lUEpuZOHAOcNT5Dbt9YIs1bZpl6TPe
 T9MctCwcYN69zcT8WTLZoQ6bVnrgkddm6B/EREt5A5Q0P68ddgUFCSIUKiVeIhnWwdNR
 cCMdampKAgrQv818CY2diUAZtHFRdRUfuoWqKytpihw4r4OeRK5PzoUteLQyQ0tTybm5
 pFbFad4MAIfpuA4/YErcu+HsDQPZPl1wsdjwWZUUNk71k0Tkhu/xjIGFIUmGVo9SqBOj
 6K8g==
X-Gm-Message-State: AOJu0YxAQ0GgLekTK0tbkWGicu8keVlfFgs0ZpIzePtn4eFRKvALubRD
 SYICvVuwchfsgckbqORfLJ8MWGD4S8m88nfv+hcgZiF4fdyebkoTjBMKMZZA2kOh1m9qKtROX0g
 1UXutRk5i+33Dnap86V7xugLuJ1/7RAZI0qru
X-Gm-Gg: ASbGncsgTsn85JLNru86AKVWKqkVgeiaVdfs9o9r97yvRIoNctvmMyPDrOtWrpkl/WN
 duLQQG4+CybL+//+8cf28h6Hag3u0cNlIbuaMacLwjZ0B8MdA7EBKbO6WrKFF+XEFQ6LGDkwDTf
 EcdAzGT1cinezLYeFH+9zAQnoZZc2mwGLp4A==
X-Google-Smtp-Source: AGHT+IGlLRJhsDGFkgnCpynTc4mFISCr23wXzrAHcfTc5CfcZ+Rk9J/cMv5TMBpM26YHDzPvxhBSrtA31zevWfEB+bI=
X-Received: by 2002:a05:6402:280d:b0:5fe:e393:808d with SMTP id
 4fb4d7f45d1cf-5ff988a53eemr3384111a12.9.1747251583745; Wed, 14 May 2025
 12:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250501131858.2160756-1-sjg@chromium.org>
 <20250505181421.GI5430@bill-the-cat>
 <CAFLszTgp0Y-yJVwE_ZBKKOXrqra6nRZqE-phPgQhA9Et99qcDg@mail.gmail.com>
 <20250506163229.GY5430@bill-the-cat>
 <CAFLszTg0YCntmLZ6EHXkWsJDhf0cCQyCHhCNzK31j+GHfBUz3A@mail.gmail.com>
 <20250512223058.GT603748@bill-the-cat>
In-Reply-To: <20250512223058.GT603748@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 14 May 2025 21:39:31 +0200
X-Gm-Features: AX0GCFvWvUDR5TkRR1YobGuBYjDMwfSb46k0lbzNDx3uJdsw86iRiq1Ga9rnCrI
Message-ID: <CAFLszTiTVt9TYD9OJhLBOCfni+A6XBt9GOs+1J3ZQX=6yNqLWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 13 May 2025 at 00:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 10, 2025 at 01:25:57PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 6 May 2025 at 18:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, May 06, 2025 at 03:24:21PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 5 May 2025 at 20:14, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, May 01, 2025 at 07:18:32AM -0600, Simon Glass wrote:
> > > > >
> > > > > > This series restores the original behaviour of extlinux booting linux
> > > > > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
> > > > > > a limit of 10x the compressed size.
> > > > > >
> > > > > > It also adds RISC-V support, since it uses a similar format to ARM64.
> > > > > >
> > > > > > Future work should integrate the code in 'booti' into main 'bootm'
> > > > > > logic.
> > > > >
> > > > > I don't like "in the future we'll remove duplicated code".
> > > >
> > > > Small series, fixes a problem, can be made larger but then it isn't a bug-fix.
> > >
> > > Which is why yes, this should have been instead of the however-many-part
> > > "PXE" series, and then fixups on top, a series to address this problem.
> > > Then other series to address other problems.
> >
> > The whole effort is addressing problems, although it depends on your
> > definition of 'problem'.
> >
> > I'm quite happy with the approach I have taken here, incremental
> > improvement towards a long-term goal. It doesn't need to be constantly
> > rebased into out-of-tree code. People can only test what is in-tree.
> >
> > >
> > > > > I also don't
> > > > > like not seeing that what we really need to do, in all cases (not just
> > > > > booti) handle decompression like we do for FIT images, and ask LMB to
> > > > > give us a space to use.
> > > >
> > > > See bootm_load_os() which does already do this.
> > >
> > > Yes, that's what I was asking you to look at. I assume you're even
> > > specifically pointing to commit 69544c4fd8b1 ("bootm: Support
> > > kernel_noload with compression") which you and I did together.
> >
> > I seldom look at the commits that produced the code, but yes.
> >
> > >
> > > > > A problem is that CONFIG_SYS_BOOTM_LEN was never
> > > > > intended to be the limit on *decompression* as it's the limit on what
> > > > > we're loading to memory from disk. That's what getting me unhappy with
> > > > > this part of the series.
> > > >
> > > > From what I can tell, that was introduced 11 years ago by this commit:
> > > >
> > > > 081cc197472 (HEAD) bootm: Export bootm_decomp_image()
> > > >
> > > > I suppose the idea is that BOOTM is supposed to be a limit on the
> > > > image being loaded, so it is compressed, then the limit needs to apply
> > > > to the size of the uncompressed image, to maintain parity. Otherwise
> > > > there would be no limit at all, since it is pretty easy to devise an
> > > > 100-byte image which expands to fill all available memory.
> > > >
> > > > Using 10x the uncompressed size doesn't fill me with the joys of spring, TBH.
> > >
> > > Yes, it's a matter of heuristics, and also why we have things like lmb
> > > to check and make sure we don't overwrite ourselves. I do not recall if
> > > the 10x used there, or the 4x we used for kernel_noload FIT
> > > decompression, was based on checking what the compression factor the
> > > available algorithms get on typical kernel images or not. That would be
> > > another improvement area, sure.
> >
> > That commit you pointed to does not actually pass the lmb_alloced()'d
> > size to image_decomp(), so it isn't perfect.
> >
> > I would much rather use the BOOTM limit everywhere, including as the
> > maximum uncompressed size of images. That is what it is for, as I
> > understand it. Users would be quite surprised if the limit were
> > ignored in certain circumstances.
>
> Yes. I believe you misunderstand the limit, and the reports that we (and
> distributions, etc) get when users have a problem would re-enforce that
> too.

OK, perhaps a topic for a future call.

Regards,
Simon
