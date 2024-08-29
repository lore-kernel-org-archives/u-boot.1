Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE4EC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4512488CB9;
	Thu, 29 Aug 2024 17:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hZq0IXMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2753788C9A; Thu, 29 Aug 2024 17:01:32 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC5D88CB9
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45654a915c3so4111361cf.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943689; x=1725548489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xUnXflwYOlFtaun5TJidrLNTNGit3AeamI36TBJ3yH0=;
 b=hZq0IXMc7TsbbjjxlcJYnKvVdaKiUqUv3oc8xMZ9dP+ATrnCN/P9iGMCkNX937rVNM
 CGGosehyd3USyCgTqL/03gA3Xn2I4Y7W3AnBp007wCpsyIfPk28SHmTCnDHhOZdT8/NV
 v1ITAC7BxH+sOEYJHbWfNUwLgG1SHp+QWafiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943689; x=1725548489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xUnXflwYOlFtaun5TJidrLNTNGit3AeamI36TBJ3yH0=;
 b=kb70Vbv7+Y30rocTghDOQDNZWbWnwQD9i4FPA9RMz/0cmOA75pYm12pZnrsMYxusnt
 C5YBFIrnPe4d3VbStFNjlEHzRwSRSRK1qTsw2+Ydp5AxPSUjJy5U5SCv98zUnnkiESAX
 Q/vem/54rjyA6myw+FeoQxb0jFHpNR7gJ304+kIADFb2M1BtiTfLvu0NNx1ziLzaxz/F
 zcLyQ6TElbwzlSSNPA78uYe6CbziDGCOQkXHhmpv1avWpN9KMfNzEQ4mX5mRofmu+Lre
 Egii4asNVhCsgK9b7AHtKp8AZP8CADh6G55Fni9zunypurd73rJ11SAn21JZnFhBTmES
 O2Ww==
X-Gm-Message-State: AOJu0YzFgnMxMnf/6vu8oSMzqOfgO1v5T4DFxo7Ov8gm8fD1SvBw7LW5
 ts7AkWamSlPLZuM9BH0ZgHwT+p06kb91ekOqinUE8W7WvvYuufFSGQuw6clH3TF1K9YSkZNO1rJ
 t30Z9W5PZvlVuvZ69xVMHmu/xm+1+Uw1iMWgc
X-Google-Smtp-Source: AGHT+IFvsNEo+7ucAf9HHgfHFn3gOAYem0EMoU/lCEA4qaFy3/2KlDPjXwTO1FyXf1OX0oJUxLjSZcVRyp140Fj9N1Q=
X-Received: by 2002:a05:6214:5d04:b0:6c1:6ecc:7e0f with SMTP id
 6a1803df08f44-6c33e6940a3mr36373256d6.39.1724943688745; Thu, 29 Aug 2024
 08:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-18-sjg@chromium.org>
 <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
In-Reply-To: <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:01:17 -0600
Message-ID: <CAFLszTjZOjXwY4PXGWkCu-7ehuA_XBCcnjLtmF4hKUC2K-NyNA@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
To: neil.armstrong@linaro.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Neil,

On Thu, 29 Aug 2024 at 08:26, <neil.armstrong@linaro.org> wrote:
>
> On 29/08/2024 00:08, Simon Glass wrote:
> > Send the Labgrid quit characters to ask it to exit gracefully. This
> > typically allows it to power off the board being used.
>
> Sending those characters every time could collide with other CI systems,
> I don't think it's a good idea.

What systems are you thinking about and what sort of collision would occur?

What do you suggest instead?

>
> >
> > If that doesn't work, try the less graceful approach.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   test/py/u_boot_spawn.py | 17 +++++++++++++++--
> >   1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
> > index c0ff0813554..ec1fa465047 100644
> > --- a/test/py/u_boot_spawn.py
> > +++ b/test/py/u_boot_spawn.py
> > @@ -16,6 +16,9 @@ import termios
> >   import time
> >   import traceback
> >
> > +# Character to send (twice) to exit the terminal
> > +EXIT_CHAR = 0x1d    # FS (Ctrl + ])
> > +
> >   class Timeout(Exception):
> >       """An exception sub-class that indicates that a timeout occurred."""
> >
> > @@ -304,15 +307,25 @@ class Spawn:
> >               None.
> >
> >           Returns:
> > -            Nothing.
> > +            str: Type of closure completed
> >           """
> > +        self.send(chr(EXIT_CHAR) * 2)
> >
> > +        # Wait about 10 seconds for Labgrid to close and power off the board
> > +        for _ in range(100):
> > +            if not self.isalive():
> > +                return 'normal'
> > +            time.sleep(0.1)
> > +
> > +        # That didn't work, so try closing the PTY
> >           os.close(self.fd)
> >           for _ in range(100):
> >               if not self.isalive():
> > -                break
> > +                return 'break'
> >               time.sleep(0.1)
> >
> > +        return 'timeout'
> > +
> >       def get_expect_output(self):
> >           """Return the output read by expect()
> >
>

Regards,
Simon
