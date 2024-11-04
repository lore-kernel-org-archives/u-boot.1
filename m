Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1897ED132BF
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8373F88936;
	Mon,  4 Nov 2024 14:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DW23LtNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244C288970; Mon,  4 Nov 2024 14:03:10 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DFC1888BE
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a2cdc6f0cso631364466b.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730725387; x=1731330187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+FrKGz72Fbg+6pclyMd5QbdbTgJQLK170FT3oJmtZmw=;
 b=DW23LtNwGS14WlQkfReGvdD/dK/pudxeW+JorBXfBJZI1/ZZ3iE1XHwzBGalaBflmI
 Bx0xipkP7+8vgHgqEMst+SdEGIiUJbAj8I9IDwEh0+FvLh3vf3yD93ro+o9yzbUVzsmS
 yJnDbS9XvEM+XsALOyhMy0CZ+UX2FW27RtBKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730725387; x=1731330187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+FrKGz72Fbg+6pclyMd5QbdbTgJQLK170FT3oJmtZmw=;
 b=XZtYa7FmPx23F1o54yutcpcQ5zoQIChG5xxhuPyxS4TrmPHEq18H1R2suEshs5xK/5
 8+bbLS26ellQRJ2CIBO5g8ABXc8eGYEkxVlbA2QRew0JIZYALLRSUPCciUn2rl1udJGB
 M7hqq5t4zfDnduYAG+pf4tnpjxH16I3JdG8FFA/0ztqfGvCHAz7HqcnHdWTr81z2jL+V
 wERbF6VjaDgo6mgdj5iOZpd0hTwMhBFp4gyJRNnu7nSkl2Ygvolze6bI2bOtiZOPhsEJ
 jblUwqVbUminmnmlqWUnbotisE6gaVuVWiTBWggTdshu9++X/g1RV7Hi6CqsObZlKH/v
 YWgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVI2GGlztuN2OljlXdsKr6GsxM8sWURtvpL0PBbaPAFBIjS2p/dKoGlOmVl4NKzKdoG+EUit8=@lists.denx.de
X-Gm-Message-State: AOJu0YycHQIN8+nsd34Tar4dMrqPmVRCb58+aYditULeQffbTftX6VyV
 6ZjxOrXRyGW0UElLqJ0KBcogZFPkdU76i0G538s6fhUTjSantN6WwJhBXMCw8X7oKXRbOKSfV+J
 K4YsoflnC+poPLQBTnvPQ5Wp2fnO9GCt7sz67
X-Google-Smtp-Source: AGHT+IFeshpV6vU9Qh8C7r9k6xUyWuVinOjGWVRaI7TcDmOcwe0zfm3BZnhY5DBhWV5QE5rALrr4j+HDP/AvH+++R+0=
X-Received: by 2002:a17:907:9622:b0:a99:fbfc:5ff3 with SMTP id
 a640c23a62f3a-a9e508d3ecdmr1585222266b.18.1730725386731; Mon, 04 Nov 2024
 05:03:06 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTj16p8-H1J349FoLowzpO7SNfdwELEDyDmi=U9+gZiCbw@mail.gmail.com>
 <4acd02a1-3c37-42a4-a1d8-a1bcec07ac66@gmx.de>
In-Reply-To: <4acd02a1-3c37-42a4-a1d8-a1bcec07ac66@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Nov 2024 06:02:54 -0700
Message-ID: <CAFLszTgUoFJ8ab-E__aZhfiqprD+806g2F_urWzwsa2TMct5LQ@mail.gmail.com>
Subject: Re: Please pull u-boot-dm
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Heinrich,

On Mon, 4 Nov 2024 at 01:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/3/24 15:47, Simon Glass wrote:
> > Hi Tom,
> >
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/23152
> > https://dev.azure.com/simon0972/u-boot/_build/results?buildId=71&view=results
> >
> > The following changes since commit e61ea9f2e5d2967826c2c6e3edba961064fbbaa1:
> >
> >    mtd: spi-nor: Guard SPI_STACKED_PARALLEL with DM_SPI check
> > (2024-10-31 13:34:29 -0600)
> >
> > are available in the Git repository at:
> >
> >    git://git.denx.de/u-boot-dm.git tags/dm-pull-2nov24
> >
> > for you to fetch changes up to 572b7b0255f9f33002ce7d2a8b2bac30ab49a48e:
> >
> >    sandbox: Fix comment for nomap_sysmem() function (2024-11-02 16:14:55 -0600)
> >
> > ----------------------------------------------------------------
> > alist enhancements and fixes
> > minor test and sandbox fixes
> > some more x86/coreboot patches
> >
> > ----------------------------------------------------------------
> > Jonas Karlman (1):
> >        bootstage: Do not sort records
> >
> > Simon Glass (27):
> >        alist: Mention the error condition in alist_add_placeholder()
> >        alist: Add a comment for alist_init_struct()
> >        alist: Expand the comment for alist_get()
> >        alist: Add a way to get the next element
> >        alist: Add for-loop helpers
> >        alist: Add a function to empty the list
> >        alist: Add a way to efficiently filter an alist
> >        alist: Add maintainer
> >        dm: core: Add a function to see if a device exists
> >        test: boot: Use a consistent name for the script bootmeth
> >        test: Expand implementation of ut_list_has_dm_tests()
> >        test: Drop the duplicate line in setup_bootmenu_image()
> >        test: boot: Update bootflow_iter() for console checking
> >        bootstd: cros: Correct the x86-setup address
> >        bootstd: Avoid showing an invalid buffer address
> >        x86: coreboot: Add a test for cbsysinfo command
> >        x86: coreboot: Show the option table
> >        x86: coreboot: Enable support for the configuration editor
> >        x86: coreboot: Add a command to check and update CMOS RAM
> >        x86: coreboot: Allow building an expo for editing CMOS config
> >        log: Add a new category for tests
> >        test: Allow saving and restoring the bloblist
> >        bloblist: test: Mark tests with UTF_BLOBLIST
> >        sandbox: Convert sb command to use new macro
> >        doc: sandbox: Add docs for the sb command
>
> Hello Simon,
>
> as described in
> https://lore.kernel.org/u-boot/47ada0aa-97fe-4c0a-a662-4b184175a17f@gmx.de/T/#u
> sent after the pull request there are some issues with the documentation.
>
> Will you send a follow up patch?

Yes, I saw it, will do.

Regards,
SImon
