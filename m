Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4495C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C8E80EF4;
	Sun, 26 Jan 2025 00:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZvSSPz2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD8E80F10; Sun, 26 Jan 2025 00:00:12 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7062580ECD
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so5378080a12.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737846007; x=1738450807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hEWzaW8vaq7Fdlx9eniOAhnJJHDhpYP1ZlnUVHBZGnk=;
 b=ZvSSPz2GLJvx9cLOOR6OCfpzkPi+g+Boph9KIWtq8dnUqoPon4LnaMNyxRumRI9483
 2YbtkJucub6ihHhFMc/FkONebS1qtOMUr6r0CrrNXm1ia87u0ZHkI3BaMpHiK3x5t8SV
 7xsaE/7Uz1KB3ko+IvqeKB3f69jK+d10sDDlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737846007; x=1738450807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hEWzaW8vaq7Fdlx9eniOAhnJJHDhpYP1ZlnUVHBZGnk=;
 b=GLJn35pRqgJ4GbmdhILJDBLMpWmz5h/TX2ucoxsND5y+sFf4rcfdpqJz+blh+rBTmR
 ncKt1Sr3A+sOfHO+aUXIYXHsI5T5dQWuUBL4QqXqDCrsr6p1DKjbWLUTN3teHiu/5zKI
 nLDziiUdp2+ks6PRCnUCj8djL+5dzmwNUU9jO8PviU19Y/xnbCrf7sM0/O87ZyTN5333
 XC3r8iklo2+lxX9Yap5jodY8sqzy7uU4fmctGoZe2UvTID33McJ4pgGnP8AXrVMLG3ii
 qBkIuyezHHjJrMRUO4iKVyLG7SOxFv/a/F26Y9iCZXBSBQEIXytrqq3HMuLyLP0fBenl
 FI8A==
X-Gm-Message-State: AOJu0Yzcd/tSIsZGfcRNxbjrPeEYKE+rD/HgZkRa9TcYXyaggOq1crsf
 6KzK5RY8UjWb/36JElKm6AkgzFCLI6YQWHyj1mH7pqlg3V1Wa5e4CJRf0Mpxpfcy2slrbn67Ls6
 K/ksfNj8Gbg+y2A24XvULQ/v/aLXesT//sLKx
X-Gm-Gg: ASbGncsNxGO8PAvSgyxssmHHwXQQ9M+Cy6rFAHgz0ZKU+AB6KIgi35N6o3ru41w/gC0
 OyfXnCXorJanJaxxVrG6zwDfWkOp+haUPmZvQhijhVnzzs8Ikle4HZyTIwVZ0jGA=
X-Google-Smtp-Source: AGHT+IFTY5LAOYDC7c5sKEQpNozuUbgC7tPKaiCcDve314KH+gfBZ+5/LZNuAxOrppcxfR07X/FX6vD7514SkMf7j40=
X-Received: by 2002:a50:9ec6:0:b0:5da:105b:86dd with SMTP id
 4fb4d7f45d1cf-5db7db2bf8amr23350078a12.29.1737846006895; Sat, 25 Jan 2025
 15:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-3-sjg@chromium.org>
 <20250125214613.GE60249@bill-the-cat>
 <CAFLszTgYPNxmiO=agM+MUp0da_6q3BBro74bWEnNbqeM-tT=bw@mail.gmail.com>
 <20250125225756.GK60249@bill-the-cat>
In-Reply-To: <20250125225756.GK60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:59:54 -0700
X-Gm-Features: AWEUYZkRWYGIQJjFrJ46mhbd9r69d9oMrW2Tbgv_BM2Emm3AZeuvCpzyhlYp7hI
Message-ID: <CAFLszTj+w4opaXNj7B76eiXx4c0jZBoAGVkd-4amyEz2YaTjPw@mail.gmail.com>
Subject: Re: [PATCH 2/4] test: Drop u_boot_ prefix on test files
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Richard Weinberger <richard@nod.at>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
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

On Sat, 25 Jan 2025 at 15:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 03:41:43PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 14:46, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 02:31:37PM -0700, Simon Glass wrote:
> > >
> > > > We know this is U-Boot so the prefix serves no purpose other than to
> > > > make things longer and harder to read. Drop it and rename the files.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > This is a massive bit of churn and violating namespace best practices
> > > when it seems like we really need:
> > > [snip]
> > > > diff --git a/test/py/tests/fit_util.py b/test/py/tests/fit_util.py
> > > > index 16ff8c96c63..7aad4030be3 100644
> > > > --- a/test/py/tests/fit_util.py
> > > > +++ b/test/py/tests/fit_util.py
> > > > @@ -5,7 +5,7 @@
> > > >
> > > >  import os
> > > >
> > > > -import u_boot_utils as util
> > > > +import utils as util
> >
> > The real namespace is the one in site-packages, where you are supposed
> > to put things in their own modules. The Python tools operate in a
> > proper namespace, but so far the tests don't. They just use whatever
> > directory the file is in. So, for example, we have:
> >
> > from tests import fs_helper
> >
> > where 'tests' is the subdir in test/py
> >
> > One option would be to move the pytests up a directory, with test.py
> > in test/ and the other python files in test/u-boot and the tests in
> > test/pytests or something like that.
> >
> > Then we would have:
> >
> > from tests import some_file (*)
> >
> > like we do in tools
> >
> > Also, I wouldn't call this 'massive' churn. Most files just have a
> > line or two changed, with test.py and test_ut.py getting more.
> >
> > >
> > > A lot more of this type of namespace shortening which I believe is the
> > > normal Python-way of solving this issue.
> >
> > It doesn't really, since 'util' might conflict with something. When
> > you have a set of related Python files, as with do in test/py it is
> > better to use a namespace. But even then, I think we would want a
> > shorter name.
>
> Yes, I suppose I'd rather see (and without the ubpy rename, one thing at
> a time please!) moving files around such that we can then do more normal
> "from foo import bar", and also avoid the silly thing of "import utils
> at util" ;)

Yes, OK.

Regards,
Simon
