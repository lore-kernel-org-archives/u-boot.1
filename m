Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04ABC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC82871CE;
	Tue, 14 Nov 2023 13:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d/S8DQXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1356C8715B; Tue, 14 Nov 2023 13:49:06 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15CD2871CE
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5440f25dcc7so8516455a12.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699966143; x=1700570943; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFt/FyiJwWG3L80Ye5C9/ZdZ1jeDaUY4ULt0aI1A9Rk=;
 b=d/S8DQXKT+Zfw11uCGj0HvhhNNCU2jLCPE9G8W9ZHHCICnqCfzHdgqrjcRnVi0LP6y
 AZHjxwbE4PrG++nK759w3eauKKZQIUkohXukLZ5lY5xsyrLEEF+UYZ2DrNz2xCL0RqOf
 zvA4lHUmS5fIPSRdCIwj7wMz4xTJV9rYJt8qFzxR9S9PqpXUWiV42TRGgGLAkcqB6DYY
 FY5oNSktJxT5O0SKcPBpMDOZDas6nGfFhtb+xTsBWH9+oeEr1LSPqkcz9OMHXQIjt20n
 MhclUyk0fh+s9OiJvBYXwfq44lL0qy0MIFIsUhrlgO1IugMJoizgo6wumDB2YM6mBrBn
 F6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699966143; x=1700570943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFt/FyiJwWG3L80Ye5C9/ZdZ1jeDaUY4ULt0aI1A9Rk=;
 b=KZngvZ58IMLnwTVYnHAiNWf/WVsuy57mw0OFKHyqF1i2KOTLXdAkmuHDJjTUrLNpJA
 cNT25RXYUQawgkGUnD+6mXBBc45dDgSPSA9K7Jt2tSVD2HwaGmF22XbXPsk+S5lEtfUO
 FS/4QiqHsH9PV7Uod+TjAo011HxjAYY7OxjJDZSIFckFEvDzuLgEFk2/1XVZQPmyFlC8
 pkQHlbnEqRcxLB301Pb6fKBU82Y9pH7YaGWdBCqbhzj7XB1anO8ZwUETqt0Xn2xkiCIa
 /GdwUsBWmbwwAMVGcrtVRY4ISF2ALrrLpV4F4TZUipLnVqci9wg0+vIP7SMrt+cZn7cZ
 xsLg==
X-Gm-Message-State: AOJu0YyS8i6mgZsU/IJuUshaOxJawomb1ks35a5zr9Tia8T74ZGxjCtv
 JOhouFMrxiCxg1MdYNrVMnr2tKrd71EIsMHFl6BPbQ==
X-Google-Smtp-Source: AGHT+IG3O3e6mV+OFocU+Mcijnrf+WzGNqC6BDBdZ7P/GlqMTjQHLL+qsNljZOdPEFnXBDjezVfYxQwQ8FjX1zP3+B8=
X-Received: by 2002:aa7:cd91:0:b0:547:bb6:5830 with SMTP id
 x17-20020aa7cd91000000b005470bb65830mr6786945edv.34.1699966143490; Tue, 14
 Nov 2023 04:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
 <20231110042542.3797301-10-masahisa.kojima@linaro.org>
 <CAOMZO5CoduEgwgdQiybmoKh6qQZOezUtRRQO4ecaGdZBBz5dDw@mail.gmail.com>
In-Reply-To: <CAOMZO5CoduEgwgdQiybmoKh6qQZOezUtRRQO4ecaGdZBBz5dDw@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 14 Nov 2023 21:48:52 +0900
Message-ID: <CADQ0-X_cj1ECn67U3sefcZ-Jm4OBSYmZkA+JaZRCa3ekq84RaA@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] doc: uefi: add HTTP Boot support
To: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

Hi Fabio,

On Tue, 14 Nov 2023 at 18:05, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Masahisa,
>
> On Fri, Nov 10, 2023 at 1:29=E2=80=AFAM Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
>
> > +Set up the load option specifying the target URI::
> > +
> > +    efidebug boot add -u 1 netinst http://foo/bar
> > +
> > +When this load option is selected as boot selection, resolve the
> > +host ip address by dns, then download the file with wget.
>
> Just curious: what is the typical size of the file that is downloaded via=
 wget?
>
> We are observing some inconsistent behavior with wget as discussed in
> this thread:
>
> https://lore.kernel.org/u-boot/CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOp=
df1CNaZBw@mail.gmail.com/
>
> Do you see the same problem?

I use a 657MB file for my test.
I have not focused on the downloading test before, but I also encountered
the file size inconsistent behavior on my board(Socionext Developerbox).
At the 15 trials of downloading the same file, unexpected file
transfer behavior occurred.

Packets received 475093, Transfer Successful
Bytes transferred =3D 687929344 (2900f800 hex)

Packets received 475105, Transfer Successful
Bytes transferred =3D 687929344 (2900f800 hex)

Packets received 475116, Transfer Successful
Bytes transferred =3D 687929344 (2900f800 hex)

Packets received 475096, Transfer Successful
Bytes transferred =3D 55088883 (34896f3 hex)       <-- size is wrong

Thanks,
Masahisa Kojima

>
> Thanks,
>
> Fabio Estevam
