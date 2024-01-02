Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F95C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 23:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F46878E1;
	Wed,  3 Jan 2024 00:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VaaPyn0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D27878F9; Wed,  3 Jan 2024 00:47:02 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39BD878B0
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 00:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-781600ab3d8so493071285a.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 15:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704239218; x=1704844018; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcnI3bjOE/JR4QqtkUBLMh58U0r2t5wK4lAWbaHcRMU=;
 b=VaaPyn0Gkm6kjx5+tOnYF2ll96u+ErekuXJEHJoddjdj4eWUGWXTX+kedIZFqhEyU+
 XX2/6JOfRuEy1+FGAAU9Xer09zt7o26HlU4zGor2Yfg/A0VjF7u/GgT0TYGY6zAIO+uE
 gp3ejxzsB0nWlesEwT2YjhnD/JlGdlpfyvuCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704239218; x=1704844018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcnI3bjOE/JR4QqtkUBLMh58U0r2t5wK4lAWbaHcRMU=;
 b=XO7V2ONV4h1y0x3d8m/Ch37D9oWtYpEznMUV43I5F3Rxb8HPFD4wTCEBsT00S5eP69
 bbV+Nwt8jbNzbwWDZBMkZOM+KkTDxIzeZTMx1DHRIagmfxQOvmX1JD+fM9lGtbOILGU4
 WJBp77T7opKWbBqM8cNvmMnVwSrXhUu4ExK33tr2T/phtHXrym5Q7Nzsf1l3wDZ1LFWl
 b/wjhemJIcEVDu/VGyuH501kGv/0aJcFC3ylieOlkuF4Ft+APD5SyXkrl+Bk/2kiv7vo
 zwxjj+mZHKT9H2Vuyn4E9ChlxntK0FGisouInsxRrRYxK0Sr+wafha+bQ6Oahk+CbaTL
 EH2A==
X-Gm-Message-State: AOJu0YynrkkH0blZCg11S/IMin0D75gdknUDcEdIJF1EyWLFdJYATDJo
 jDSUujjm6e+zAUiqKaUfP1+9SYgFaTeS57qFXydPXHqZpvdv
X-Google-Smtp-Source: AGHT+IH0M0pBrGr+Sx5B7gKAHkWbx7yYmjWLkviFsxrNY5/tFuUA7GBmbX67T4+ylA4I/2XnnEJd068mD1x3ToVE8wM=
X-Received: by 2002:a05:6214:e8f:b0:67f:6348:ef8e with SMTP id
 hf15-20020a0562140e8f00b0067f6348ef8emr30015254qvb.17.1704239218454; Tue, 02
 Jan 2024 15:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231213121353.GA31326@willie-the-truck>
In-Reply-To: <20231213121353.GA31326@willie-the-truck>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jan 2024 16:46:47 -0700
Message-ID: <CAFLszTjfmSx1YMqzb2TsQf7sP4KrcQB=X7DY_HxRQp0J5HAppQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>,
 Tom Rini <trini@konsulko.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 workflows@vger.kernel.org
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

Hi Masahiro,

On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > Add a script which produces a Flat Image Tree (FIT), a single file
> > containing the built kernel and associated devicetree files.
> > Compression defaults to gzip which gives a good balance of size and
> > performance.
> >
> > The files compress from about 86MB to 24MB using this approach.
> >
> > The FIT can be used by bootloaders which support it, such as U-Boot
> > and Linuxboot. It permits automatic selection of the correct
> > devicetree, matching the compatible string of the running board with
> > the closest compatible string in the FIT. There is no need for
> > filenames or other workarounds.
> >
> > Add a 'make image.fit' build target for arm64, as well. Use
> > FIT_COMPRESSION to select a different algorithm.
> >
> > The FIT can be examined using 'dumpimage -l'.
> >
> > This features requires pylibfdt (use 'pip install libfdt'). It also
> > requires compression utilities for the algorithm being used. Supported
> > compression options are the same as the Image.xxx files. For now there
> > is no way to change the compression other than by editing the rule for
> > $(obj)/image.fit
> >
> > While FIT supports a ramdisk / initrd, no attempt is made to support
> > this here, since it must be built separately from the Linux build.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v9:
> > - Move the compression control into Makefile.lib
> >
> > Changes in v8:
> > - Drop compatible string in FDT node
> > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > - Turn compress part of the make_fit.py comment in to a sentence
> > - Add two blank lines before parse_args() and setup_fit()
> > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > - Add 'mkimage' details Documentation/process/changes.rst
> > - Allow changing the compression used
> > - Tweak cover letter since there is only one clean-up patch
> >
> > Changes in v7:
> > - Add Image as a dependency of image.fit
> > - Drop kbuild tag
> > - Add dependency on dtbs
> > - Drop unnecessary path separator for dtbs
> > - Rebase to -next
> >
> > Changes in v5:
> > - Drop patch previously applied
> > - Correct compression rule which was broken in v4
> >
> > Changes in v4:
> > - Use single quotes for UIMAGE_NAME
> >
> > Changes in v3:
> > - Drop temporary file image.itk
> > - Drop patch 'Use double quotes for image name'
> > - Drop double quotes in use of UIMAGE_NAME
> > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > - Avoid hard-coding "arm64" for the DT architecture
> >
> > Changes in v2:
> > - Drop patch previously applied
> > - Add .gitignore file
> > - Move fit rule to Makefile.lib using an intermediate file
> > - Drop dependency on CONFIG_EFI_ZBOOT
> > - Pick up .dtb files separately from the kernel
> > - Correct pylint too-many-args warning for write_kernel()
> > - Include the kernel image in the file count
> > - Add a pointer to the FIT spec and mention of its wide industry usage
> > - Mention the kernel version in the FIT description
> >
> >  Documentation/process/changes.rst |   9 +
> >  MAINTAINERS                       |   7 +
> >  arch/arm64/Makefile               |   7 +-
> >  arch/arm64/boot/.gitignore        |   1 +
> >  arch/arm64/boot/Makefile          |   6 +-
> >  scripts/Makefile.lib              |  16 ++
> >  scripts/make_fit.py               | 291 ++++++++++++++++++++++++++++++
> >  7 files changed, 334 insertions(+), 3 deletions(-)
> >  create mode 100755 scripts/make_fit.py
>
> I'll need Masahiro's Ack on the scripts/ changes before I can take this
> one.

Any thoughts on this request, please?

Regards,
Simon
