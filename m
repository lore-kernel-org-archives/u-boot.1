Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7228AC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 13:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F392080EBB;
	Sat, 15 Feb 2025 14:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LQrqsDXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D10480C98; Sat, 15 Feb 2025 14:38:44 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6F480EBB
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 14:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ab7ee6f54faso345175566b.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 05:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739626721; x=1740231521; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HudiRrb36p/NiZ9FTEo2xvS6eno0NJe9PaBb9QC88kw=;
 b=LQrqsDXdEwnFIa+2FjTn3osI5r5qSo/gHEvvXy3bbu/EtIzO0ecIE+bLjqPRA7gbRI
 QuCfC5kwQAwpJkD2VLGOreI3f/0rMW5x40PXP7B++AVq9N8W+hJXIyPvsB8PHllFah6P
 ZYF6pUMsrHS4CO5Cvy0SMLIqto/d3fLP51Xzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739626721; x=1740231521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HudiRrb36p/NiZ9FTEo2xvS6eno0NJe9PaBb9QC88kw=;
 b=ik9Xp5bW4XpVHCL4LAQNfkUldgYDgEYQ9gsOIi2fV6cD/hQA672WCpwbcQlUt19GsD
 CMKmwVhG4DTtCirZWgrLqa7Jgdv2oBczgbUINiDXOdP0AY6/utV35a9aF+gRErBFoAhk
 GVe9OkkjHHYDR5PLOc50sw/tlXO5sgIpjyzG1xlh4H3eUuhzL6xY+o+2slmP/VaAxw5y
 WyFOi0kSONelGv30ntTSmG6dCVn75VdxjFbTHOGYzCwPWWupbarW3E2OZNzFTRT7cM93
 jK45He4b1U+SD0EjmvVul3UvVQ2lnnCIIsMjvJH2LADz2wSgvWYSr3T6jQAghONgxW5D
 5izA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIsd3mX1nI4qeQ/oAS0MrNRJEfGEkAa30C8TzJ3xEr5W4Fq9wRhBtxa7VEMph9np5sTKrDeLo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw77ffj8D7lsbL0qCQcKrIniwsc0QNH5S/8+7BwGcFb/cw2LdSC
 I8EvNoKN0ZEMejBi7mciZsAZ/+NSe16clCaJnxvLjxRLa4IOz+TEv3MzQ1WRhKt3Trz9U7zDsSE
 bg7Qe/xzSLQaLGjcHwYff1dNcnEppfMp/OJny
X-Gm-Gg: ASbGncucHWPSpTweORycnztVn6r1iPbnyaX4Kp/s4m3g7eHFLns/Tpk+KkEMawMv+8D
 YVl1OTO8OKfEwpAZxXE4h1yXW1/6tm1Y8n+ph7XP5TLGx7l0V3EXk4Y3g9H9Do4oyLI3c3IWKIQ
 ==
X-Google-Smtp-Source: AGHT+IGsiM9bspIPMvZvQqZ1QBkBKtN9CjeGO10/5ih/pP/NOpOtCYWMxJqRh7tgkdj/bUITkWhg29luZGG3WIB4osE=
X-Received: by 2002:a05:6402:35cb:b0:5dc:caab:9447 with SMTP id
 4fb4d7f45d1cf-5e036063e6amr7653179a12.18.1739626721534; Sat, 15 Feb 2025
 05:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-20-adriano.cordova@canonical.com>
 <CAFLszThCwGRxjXRSeNKXQkL_g4uBioD1bsyquiP+tZxvn58Jxg@mail.gmail.com>
 <20250123144205.GJ60249@bill-the-cat>
 <CAFLszTgCXvxMY0MAyhsvuNFResmDtbahuk_2_QfYE5sUxNTTjQ@mail.gmail.com>
 <20250124191744.GR60249@bill-the-cat>
 <CAFLszThUU+Vut_vaaYQkEq_X9o3SRnZC7N1Fo11fMxSyzHioqg@mail.gmail.com>
 <20250124203416.GX60249@bill-the-cat>
In-Reply-To: <20250124203416.GX60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 06:38:27 -0700
X-Gm-Features: AWEUYZm6U8-IObXFN4gda46qDxgiaye5XkPX-qWDbl9ZfALlKdOrs8Ut54x6l98
Message-ID: <CAFLszTjH+-5vCDAZqL+386JSS5nJdHtNUQfJ6hQ9GKFsjN53_w@mail.gmail.com>
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

On Fri, 24 Jan 2025 at 13:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jan 24, 2025 at 12:43:29PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 24 Jan 2025 at 12:17, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Jan 24, 2025 at 11:57:28AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 23 Jan 2025 at 07:42, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jan 23, 2025 at 07:37:26AM -0700, Simon Glass wrote:
> > > > > > Hi Adriano,
> > > > > >
> > > > > > On Wed, 22 Jan 2025 at 10:10, Adriano Cordova <adrianox@gmail.com> wrote:
> > > > > > >
> > > > > > > check that the number of ethernet udevices matches the number of simple
> > > > > > > network protocols
> > > > > > >
> > > > > > > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > > > > > > ---
> > > > > > >  test/py/tests/test_efi_selftest.py | 21 +++++++++++++++++++++
> > > > > > >  1 file changed, 21 insertions(+)
> > > > > > >
> > > > > > > diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
> > > > > > > index 310d8ed294..af9992a6f7 100644
> > > > > > > --- a/test/py/tests/test_efi_selftest.py
> > > > > > > +++ b/test/py/tests/test_efi_selftest.py
> > > > > > > @@ -195,3 +195,24 @@ def test_efi_selftest_tcg2(u_boot_console):
> > > > > > >      if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):
> > > > > > >          raise Exception('Failures occurred during the EFI selftest')
> > > > > > >      u_boot_console.restart_uboot()
> > > > > > > +
> > > > > > > +@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
> > > > > > > +@pytest.mark.buildconfigspec('cmd_dm')
> > > > > > > +def test_efi_selftest_count_netdevices(u_boot_console):
> > > > > > > +    """Test the EFI net device driver
> > > > > > > +
> > > > > > > +    u_boot_console -- U-Boot console
> > > > > > > +
> > > > > > > +    This function counts the number of ETH_UCLASS probed udevices
> > > > > > > +    calls the EFI net device selftest to check that the EFI driver
> > > > > > > +    sees the same.
> > > > > > > +    """
> > > > > > > +    u_boot_console.restart_uboot()
> > > > > >
> > > > > > We should avoid restarting U-Boot in a test unless there is a strong
> > > > > > need. It makes things a lot slower!
> > > > >
> > > > > Yes, if we can not reboot here that would be good.
> > > > >
> > > > > > > +    response = u_boot_console.run_command('dm tree')
> > > > > > > +    lines = response.splitlines()[2:]
> > > > > > > +    ethernet_count = sum(1 for line in lines if line.strip().startswith('ethernet') and '[ + ]' in line)
> > > > > >
> > > > > > This test should be written in C, e.g:
> > > > > >
> > > > > > struct udevice *dev;
> > > > > > int count;
> > > > > > uclass_foreach_dev(dev, UCLASS_ETH)
> > > > > >     if (device_active(dev))
> > > > > >          count++;
> > > > > >
> > > > > > > +
> > > > > > > +    u_boot_console.run_command(cmd='setenv efi_selftest netdevices')
> > > > > > > +    u_boot_console.run_command('bootefi selftest', wait_for_prompt=False)
> > > > > > > +    if u_boot_console.p.expect([f'Detected {ethernet_count} active EFI net devices']):
> > > > > > > +        raise Exception('Failures occurred during the EFI selftest')
> > > > > >
> > > > > > Again, this should be written in C and use run_command().
> > > > >
> > > > > No, if these are written in python already, we can leave them in python.
> > > >
> > > > This is a new test. We should not be making things any worse.
> > > >
> > > > > C is bad for strings.
> > > >
> > > > ut_assert_skip_to_line("Detected %d active EFI net devices", count);
> > > >
> > > > For C tests we don't even need 'dm tree'.
> > > >
> > > > This matters. The C test is easier to understand and runs in a tiny
> > > > fraction of the time. Our CI tests have been getting slower and slower
> > > > and it is due to this kind of test. I went to the effort of writing
> > > > this up carefully [1].
> > > >
> > > > So, NAK from me. Please use C tests where possible.
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > [1] https://docs.u-boot.org/en/latest/develop/tests_writing.html
> > >
> > > I suppose re-doing these in C would be a good test to see if writing
> > > tests in C rather than Python is easier or not.
> >
> > In this case it should be easy enough. Other tests are much easier to
> > write in Python. Some are easier to write in C, if they need to check
> > internal information.
> >
> > > But given that our C
> > > tests are also randomly failing (the hash md5 thing) that's not the
> > > strongest endorsement of them either.
> >
> > Indeed. Hopefully this is just a problem with the test system in
> > U-Boot, rather than a bug in the 'real' part of U-Boot.
> >
> > Is it possible to bisect this problem?
>
> No, bisect'ing finds that the commit which added the test is the failing
> commit.

I suppose I missed this problem or have forgotten about it. Is it
still happening? Can you point me to the failure?

Regards,
SImon
