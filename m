Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A80C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5FD80F32;
	Sat, 15 Feb 2025 18:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PlVp5NyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F04B180F18; Sat, 15 Feb 2025 18:21:37 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13A6F80EAF
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso619059866b.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739640094; x=1740244894; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VboZhrlCN7A4DAqTrWTsDO49z9IJLTJj43tnQeHobuQ=;
 b=PlVp5NyS0WZ7c4Obbs9XUdHsEc89w+fuWbADEcPmqp+xXo/TX4pNivblnrfmJXL9+Q
 D4b3Om2da8tDaE+msf0goOep8qg+tkv+d+1O8OoW1nLSo466eKqj/BGFk1YMQj3hfCi0
 gP3TMjyFBGv8scceCteCle1YWjxzotIlPyu8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739640094; x=1740244894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VboZhrlCN7A4DAqTrWTsDO49z9IJLTJj43tnQeHobuQ=;
 b=gjMXPlb5T9UVewctjafjC0zFgmxDs5w1r8ibxDjkPY0tIROeexZetPoH7nGHZelkOb
 LtIr+viYnE0d3KKTuew/it+Zp54NB6y7OyiGbX6OhmKB2TIw8gssAhH7fjZAqcVRtaBI
 9y6FR+mrjeatrtu2aO4yOc78aoKa0da2letdrBtnYX54X4NBQ2nN+NiPXkYHoEFGfTA/
 GuVUC8ghZiDhuQ6cTYX75C2DRXOKHx/ZsKL3MZOpfUefGiWl5zZLPtXWPIKJK9gFitg7
 cIN9bNZjFpaqBsf87+mf1uq+IZ4W0SQwX5pPCrrARCeXrh1Ihq+ifqij7cx1yaQmih41
 MvmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWG/ddG7EODRx7BsV44RCpaNf8XA8sxACYPX+172/WeCAr4rPkSRZFIXHtt9zWVmk4iz89Ob4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyhg4MVDURYa3IS03gTGdkmompe07yWQlodas0HxRs/MkEJFOOU
 ayx3k6Q4riNFOVsbORbXiW5AwDtdemJ2c6VwEY60Quxw28VSx99YwTWbdquDizIt6/8HTzSmkJq
 6xQ6lPtGkq9NnglNIUzsOYz7Nwa2Ekg0JWniS
X-Gm-Gg: ASbGncsfFpMnSv07tiGcZPY8erqXZBAcoQYeyjQGvYXE92hgI1hEqyjt0alJikBAi/R
 llRrerpQiTVAxQn++QME32sRdh/a22GBBc0jH/VVRt7Q7xqQT4oAp6wfvMBQLMhCTudelJKsX4A
 ==
X-Google-Smtp-Source: AGHT+IHxjQF7dP7ZTYWguPAlno2paOBLpV1Juq+ibdb1Z7KggdADdpOgN9v2AGsPShkbrnGYFxfL3OtJ2jkwqQVt/h0=
X-Received: by 2002:a17:907:7244:b0:ab7:d6c:5781 with SMTP id
 a640c23a62f3a-abb70b35452mr326988866b.24.1739640094497; Sat, 15 Feb 2025
 09:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-20-adriano.cordova@canonical.com>
 <CAFLszThCwGRxjXRSeNKXQkL_g4uBioD1bsyquiP+tZxvn58Jxg@mail.gmail.com>
 <20250123144205.GJ60249@bill-the-cat>
 <CAFLszTgCXvxMY0MAyhsvuNFResmDtbahuk_2_QfYE5sUxNTTjQ@mail.gmail.com>
 <20250124191744.GR60249@bill-the-cat>
 <CAFLszThUU+Vut_vaaYQkEq_X9o3SRnZC7N1Fo11fMxSyzHioqg@mail.gmail.com>
 <20250124203416.GX60249@bill-the-cat>
 <CAFLszTjH+-5vCDAZqL+386JSS5nJdHtNUQfJ6hQ9GKFsjN53_w@mail.gmail.com>
 <20250215145203.GQ1233568@bill-the-cat>
In-Reply-To: <20250215145203.GQ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 10:21:23 -0700
X-Gm-Features: AWEUYZmM0ELVnb9m5xktiosbXK8P9fcKia-6lmE1ZusvvXxzceHV37m3jnd8XDM
Message-ID: <CAFLszTi6dzBJCdZ9saka5WSLhvD_sdDFjbkF2kOZYJoDx+NxfA@mail.gmail.com>
Subject: Re: [PATCH 19/21] py/tests: test_efi_selftest: Add test for counting
 EFI netdevices
To: Tom Rini <trini@konsulko.com>
Cc: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 joe.hershberger@ni.com, 
 rfried.dev@gmail.com, jerome.forissier@linaro.org, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, Adriano Cordova <adriano.cordova@canonical.com>
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

On Sat, 15 Feb 2025 at 07:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 06:38:27AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 24 Jan 2025 at 13:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Jan 24, 2025 at 12:43:29PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 24 Jan 2025 at 12:17, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Jan 24, 2025 at 11:57:28AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 23 Jan 2025 at 07:42, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 23, 2025 at 07:37:26AM -0700, Simon Glass wrote:
> > > > > > > > Hi Adriano,
> > > > > > > >
> > > > > > > > On Wed, 22 Jan 2025 at 10:10, Adriano Cordova <adrianox@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > check that the number of ethernet udevices matches the number of simple
> > > > > > > > > network protocols
> > > > > > > > >
> > > > > > > > > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > > > > > > > > ---
> > > > > > > > >  test/py/tests/test_efi_selftest.py | 21 +++++++++++++++++++++
> > > > > > > > >  1 file changed, 21 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
> > > > > > > > > index 310d8ed294..af9992a6f7 100644
> > > > > > > > > --- a/test/py/tests/test_efi_selftest.py
> > > > > > > > > +++ b/test/py/tests/test_efi_selftest.py
> > > > > > > > > @@ -195,3 +195,24 @@ def test_efi_selftest_tcg2(u_boot_console):
> > > > > > > > >      if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):
> > > > > > > > >          raise Exception('Failures occurred during the EFI selftest')
> > > > > > > > >      u_boot_console.restart_uboot()
> > > > > > > > > +
> > > > > > > > > +@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
> > > > > > > > > +@pytest.mark.buildconfigspec('cmd_dm')
> > > > > > > > > +def test_efi_selftest_count_netdevices(u_boot_console):
> > > > > > > > > +    """Test the EFI net device driver
> > > > > > > > > +
> > > > > > > > > +    u_boot_console -- U-Boot console
> > > > > > > > > +
> > > > > > > > > +    This function counts the number of ETH_UCLASS probed udevices
> > > > > > > > > +    calls the EFI net device selftest to check that the EFI driver
> > > > > > > > > +    sees the same.
> > > > > > > > > +    """
> > > > > > > > > +    u_boot_console.restart_uboot()
> > > > > > > >
> > > > > > > > We should avoid restarting U-Boot in a test unless there is a strong
> > > > > > > > need. It makes things a lot slower!
> > > > > > >
> > > > > > > Yes, if we can not reboot here that would be good.
> > > > > > >
> > > > > > > > > +    response = u_boot_console.run_command('dm tree')
> > > > > > > > > +    lines = response.splitlines()[2:]
> > > > > > > > > +    ethernet_count = sum(1 for line in lines if line.strip().startswith('ethernet') and '[ + ]' in line)
> > > > > > > >
> > > > > > > > This test should be written in C, e.g:
> > > > > > > >
> > > > > > > > struct udevice *dev;
> > > > > > > > int count;
> > > > > > > > uclass_foreach_dev(dev, UCLASS_ETH)
> > > > > > > >     if (device_active(dev))
> > > > > > > >          count++;
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +    u_boot_console.run_command(cmd='setenv efi_selftest netdevices')
> > > > > > > > > +    u_boot_console.run_command('bootefi selftest', wait_for_prompt=False)
> > > > > > > > > +    if u_boot_console.p.expect([f'Detected {ethernet_count} active EFI net devices']):
> > > > > > > > > +        raise Exception('Failures occurred during the EFI selftest')
> > > > > > > >
> > > > > > > > Again, this should be written in C and use run_command().
> > > > > > >
> > > > > > > No, if these are written in python already, we can leave them in python.
> > > > > >
> > > > > > This is a new test. We should not be making things any worse.
> > > > > >
> > > > > > > C is bad for strings.
> > > > > >
> > > > > > ut_assert_skip_to_line("Detected %d active EFI net devices", count);
> > > > > >
> > > > > > For C tests we don't even need 'dm tree'.
> > > > > >
> > > > > > This matters. The C test is easier to understand and runs in a tiny
> > > > > > fraction of the time. Our CI tests have been getting slower and slower
> > > > > > and it is due to this kind of test. I went to the effort of writing
> > > > > > this up carefully [1].
> > > > > >
> > > > > > So, NAK from me. Please use C tests where possible.
> > > > > >
> > > > > > Regards,
> > > > > > Simon
> > > > > >
> > > > > > [1] https://docs.u-boot.org/en/latest/develop/tests_writing.html
> > > > >
> > > > > I suppose re-doing these in C would be a good test to see if writing
> > > > > tests in C rather than Python is easier or not.
> > > >
> > > > In this case it should be easy enough. Other tests are much easier to
> > > > write in Python. Some are easier to write in C, if they need to check
> > > > internal information.
> > > >
> > > > > But given that our C
> > > > > tests are also randomly failing (the hash md5 thing) that's not the
> > > > > strongest endorsement of them either.
> > > >
> > > > Indeed. Hopefully this is just a problem with the test system in
> > > > U-Boot, rather than a bug in the 'real' part of U-Boot.
> > > >
> > > > Is it possible to bisect this problem?
> > >
> > > No, bisect'ing finds that the commit which added the test is the failing
> > > commit.
> >
> > I suppose I missed this problem or have forgotten about it. Is it
> > still happening? Can you point me to the failure?
>
> Yes, Marek fixed it. See:
> commit 082b41df8abd8b2d0f2dccce8ed74fe7f5c6509e
> Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Date:   Mon Jan 27 00:57:03 2025 +0100
>
>     test/cmd/wget.c: Fix loadaddr rewrite
>
>     The $loadaddr variable is a hexadecimal value, not a string, it must be
>     assigned using env_set_hex(). This may break follow up tests, like the
>     dm_test_cmd_hash_md5 in CI. To avoid any interference with other tests,
>     set $wgetaddr variable which is specific to this test and use it in the
>     test.
>
>     Fixes: 20f641987f83 ("test/cmd/wget.c: move net_test_wget() to the cmd test suite")
>     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>     Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
>     Reviewed-by: Fabio Estevam <festevam@gmail.com>
>

OK, good.

Regards,
Simon
