Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512FBC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 18:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1ED80ADB;
	Fri, 24 Jan 2025 19:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UMGu/9QN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D36F180ADC; Fri, 24 Jan 2025 19:57:42 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 753F880A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 19:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaec111762bso490505266b.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737745060; x=1738349860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yGw+XiiUl4I1wRi8K3fA5LN/EAnC5t2jrKA8qvVWMKk=;
 b=UMGu/9QNuZdnmUIXIFruh75WZpNff+4PT5qdVegH36es9hE8fv6iSk65qgXNcZVrpv
 E6E1nhX3EEirElwdgfyXTZacrSbKJ3c/TZPeRQG+E/+5+nNHQOzLte9kO06vgHeVJFf5
 3/TjDSH/4Nb49Ma6nanW3nGfzrBnGj8i15Dg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737745060; x=1738349860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yGw+XiiUl4I1wRi8K3fA5LN/EAnC5t2jrKA8qvVWMKk=;
 b=V1CNVFIT1ACy/xZG7OyUv9WwoLDJbB4VO7OaCKeb18ja0KisbHwqymbqjeYUSPSYDM
 6d4X3VMI3LRI+SEEOIpFHemUurusYavZut0GlOjQnbUmJ30HQ0/PyGErNNAlQD4omUKt
 iRxc6XgyLFuxqK4q+b/OJxJV+T+XJfwk36kYygLnV3NGMtZcXAxnd0jLFJ5ZQAomkX3n
 ieYpm3W//JZE2LzkpUvIUdfYeEwEe4hR20NUJbxmsx3TLGqHKXrp6NbD0NPZIQqp8f2/
 KEdtzHIAiUE2RWOsijtXN21v7lLGrrhgCUR7sVKCOlrZwNQm9172Ttq+xUKd/chssDII
 lEcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtCQE7wvnl0EP7K9o3KzWKP2LYxEL1WmEvMR1/mzAmHeg5CQRDxf6HMeX7MYLmiMifX04HFqY=@lists.denx.de
X-Gm-Message-State: AOJu0YxKAwjdWQQsZC/KqvXg/RWcOo+iMNX8CkVRejs6Dgv7RTHQ9wi5
 729SuAZ+kQa3kTy/5AtID9CwG4c5taXQOFXwh1UR0TwlDAe9t5t+UitI9C0d5lDwr9ofhMVGFoe
 J9jFAVkmZdQlho9CmNMFZD2Ngm3r9RHAeX8q1
X-Gm-Gg: ASbGncvUC45+/+UR2N39wplorr+T5hMZxvtnl+znAfimf1f3pI/TLPyayOqDe9IbPmy
 0W9TO1DwTDNm42mNeZERdvTVMpHX6gNtXVKaAZJThWlPaiPWpav+8aK9r1phl0IA=
X-Google-Smtp-Source: AGHT+IGaEDtt6HpT16u9XODqzikdpUKrm64cTdo/aFLcSxbogoi50o0CSmMSayq9v4coMekcI/4seio0v6sx0XFBJpI=
X-Received: by 2002:a17:907:7f0d:b0:ab2:b5f1:568c with SMTP id
 a640c23a62f3a-ab38b165e7dmr2901033966b.28.1737745059908; Fri, 24 Jan 2025
 10:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-20-adriano.cordova@canonical.com>
 <CAFLszThCwGRxjXRSeNKXQkL_g4uBioD1bsyquiP+tZxvn58Jxg@mail.gmail.com>
 <20250123144205.GJ60249@bill-the-cat>
In-Reply-To: <20250123144205.GJ60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 24 Jan 2025 11:57:28 -0700
X-Gm-Features: AWEUYZntMHgFd0Wasef35swvhLicO7SNDwicsdA33OHFK_ITt9HwmMUGB1_dMPo
Message-ID: <CAFLszTgCXvxMY0MAyhsvuNFResmDtbahuk_2_QfYE5sUxNTTjQ@mail.gmail.com>
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

On Thu, 23 Jan 2025 at 07:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 23, 2025 at 07:37:26AM -0700, Simon Glass wrote:
> > Hi Adriano,
> >
> > On Wed, 22 Jan 2025 at 10:10, Adriano Cordova <adrianox@gmail.com> wrote:
> > >
> > > check that the number of ethernet udevices matches the number of simple
> > > network protocols
> > >
> > > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > > ---
> > >  test/py/tests/test_efi_selftest.py | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
> > > index 310d8ed294..af9992a6f7 100644
> > > --- a/test/py/tests/test_efi_selftest.py
> > > +++ b/test/py/tests/test_efi_selftest.py
> > > @@ -195,3 +195,24 @@ def test_efi_selftest_tcg2(u_boot_console):
> > >      if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):
> > >          raise Exception('Failures occurred during the EFI selftest')
> > >      u_boot_console.restart_uboot()
> > > +
> > > +@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
> > > +@pytest.mark.buildconfigspec('cmd_dm')
> > > +def test_efi_selftest_count_netdevices(u_boot_console):
> > > +    """Test the EFI net device driver
> > > +
> > > +    u_boot_console -- U-Boot console
> > > +
> > > +    This function counts the number of ETH_UCLASS probed udevices
> > > +    calls the EFI net device selftest to check that the EFI driver
> > > +    sees the same.
> > > +    """
> > > +    u_boot_console.restart_uboot()
> >
> > We should avoid restarting U-Boot in a test unless there is a strong
> > need. It makes things a lot slower!
>
> Yes, if we can not reboot here that would be good.
>
> > > +    response = u_boot_console.run_command('dm tree')
> > > +    lines = response.splitlines()[2:]
> > > +    ethernet_count = sum(1 for line in lines if line.strip().startswith('ethernet') and '[ + ]' in line)
> >
> > This test should be written in C, e.g:
> >
> > struct udevice *dev;
> > int count;
> > uclass_foreach_dev(dev, UCLASS_ETH)
> >     if (device_active(dev))
> >          count++;
> >
> > > +
> > > +    u_boot_console.run_command(cmd='setenv efi_selftest netdevices')
> > > +    u_boot_console.run_command('bootefi selftest', wait_for_prompt=False)
> > > +    if u_boot_console.p.expect([f'Detected {ethernet_count} active EFI net devices']):
> > > +        raise Exception('Failures occurred during the EFI selftest')
> >
> > Again, this should be written in C and use run_command().
>
> No, if these are written in python already, we can leave them in python.

This is a new test. We should not be making things any worse.

> C is bad for strings.

ut_assert_skip_to_line("Detected %d active EFI net devices", count);

For C tests we don't even need 'dm tree'.

This matters. The C test is easier to understand and runs in a tiny
fraction of the time. Our CI tests have been getting slower and slower
and it is due to this kind of test. I went to the effort of writing
this up carefully [1].

So, NAK from me. Please use C tests where possible.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/tests_writing.html
