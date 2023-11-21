Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87077C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E565987585;
	Tue, 21 Nov 2023 23:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V/gZz5uB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E1728269F; Tue, 21 Nov 2023 23:11:00 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3BD87563
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-548d60a4d60so3212637a12.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604657; x=1701209457; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oJMDh5oFlDbQfLOyve1qbfQYailgPcqSoPiHs8KXsVw=;
 b=V/gZz5uBwVVyEWD9br7nUi9kdeFBGms6JNzjqNrHqvyUiVKOVKzBWIva47yVwRV+JE
 0XujnPG9D2xFK5HDPLKtxKsaPdbQj/yDaWtdwaFzT4UiOHR1/0rZSnuvcOdxDrU38+sZ
 x/bYyTVIqdqBlAztwlsyW9QjuzDkNsrVhCgGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604657; x=1701209457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oJMDh5oFlDbQfLOyve1qbfQYailgPcqSoPiHs8KXsVw=;
 b=FvCGMPHmPFAIwamDHNxfUBC+YVY5RP6wXX5jYgs5emMrAyTQp3ZmNArooYYXESzAjx
 8v+IOmLRx/xUbYrPpS+yOdDqdoJ3GaW89pxrsOERBtuBAI8x2qfAQA/M8t6iQaTsHcui
 qfE6zb+RGCDuJWy4MgdpxTbYoKBLfA4adu2DCEibyCMtXX1nOvrNhwES/3pyvN+uN+Hq
 u8+F+o1vp5kDA5nI6sVK53QSISPWk978lRAXhv9lRYKwyPl7CzP8vcfVVpAo+DAHoer7
 tTR32KiALiq9QrWkWGaQjsaL3J7Ar06ohTyNDc6BM3j8hyHkqxU8AseRj95hMVEVJqQF
 m8ZQ==
X-Gm-Message-State: AOJu0YwB4aS1PUX2XobGy1dRavu9NQY5OtBDm4+d2sNy2YYl8GJjKczv
 3yf9mjPrMJn1r0e88EZYGKP969lxBgKq8EyZwfNIzQ==
X-Google-Smtp-Source: AGHT+IG8kEyQosGaifUO6rP4HisM8BNZB61jvIp7696VTMbwBkCB7Fozdl6k+ap4EQgdEedOfyF70AYLGV11Ieq858g=
X-Received: by 2002:a17:906:198c:b0:9d0:51d4:4d87 with SMTP id
 g12-20020a170906198c00b009d051d44d87mr171650ejd.62.1700604657576; Tue, 21 Nov
 2023 14:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-4-sjg@chromium.org>
 <539b4abc-be46-45c5-98d0-71f2b289540c@gmx.de>
In-Reply-To: <539b4abc-be46-45c5-98d0-71f2b289540c@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:10:45 -0700
Message-ID: <CAPnjgZ0SJFhEEHZBEBBcrgq-P_W7C6x810NENhOCh1ezevnnJQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] efi: test: Create a disk image with and EFI app in it
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 21 Nov 2023 at 10:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/21/23 12:35, Simon Glass wrote:
> > Create a new disk for use with test, which contains the sandbox
> > helloworld app. This will be used to test the EFI boot bootmeth.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   test/py/tests/test_ut.py | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> >
> > diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> > index 1d9149a3f683..f6220c05238a 100644
> > --- a/test/py/tests/test_ut.py
> > +++ b/test/py/tests/test_ut.py
> > @@ -468,6 +468,37 @@ def test_ut_dm_init(u_boot_console):
> >       with open(fn, 'wb') as fh:
> >           fh.write(data)
> >
> > +
> > +def setup_efi_image(cons):
> > +    """Create a 20MB disk image with an EFI app on it"""
> > +    mmc_dev = 7
> > +    fname, mnt = setup_image(cons, mmc_dev, 0xc, second_part=True)
>
> If you would set the partition type GUID to ESP, U-Boot would stop to
> complain about EFI variable that cannot be persisted.

Doesn't that need a GPT partition type?

We do use that for the ChromeOS bootmeth (in setup_cros_image) so we
could use it here too.

>
> There is a pending patch that wants to make the failure to persist EFI
> variable fatal.
>
> [RESEND,v2] efi_loader: Fix UEFI variable error handling
> https://patchwork.ozlabs.org/project/uboot/patch/20231113161031.138304-1-o451686892@gmail.com/

Regards,
Simon
