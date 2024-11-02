Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB19E67807
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 16:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB75890B1;
	Sat,  2 Nov 2024 17:33:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cV9Pbxjh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E3588F70; Sat,  2 Nov 2024 17:33:05 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CEF5890B1
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 17:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cebcf96fabso1723642a12.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730565183; x=1731169983; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2WVOeEpoi31wq/o+g671NdkqOfE4is3tKg/p7+C+lY=;
 b=cV9PbxjhBhyZPFcs7cmkNr9CziAXi1V7nPqjYDk8u0RdLFpHYkZNLISFYpXxCcZhD5
 Mfn/ZhAPYv0FFf287X4Js76NvHjmZPtMZMrUxatBtvJvSz62QvX0rCTjVkhGbA4gHX+x
 7T8IpWD+cosu7xM9LPd3xQ6gBrZ/GVLB241uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730565183; x=1731169983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2WVOeEpoi31wq/o+g671NdkqOfE4is3tKg/p7+C+lY=;
 b=bixS/Grz7rrqRKKZvjENi9NVgnRf3pxXqlolb9SeieERz8177NC9RhxQm5TZfbLeMd
 8Fx8rCyMt1YGEk5XoAoBlherq5N33OoK+UZKPpprA8O8jnKdTopdOWFyj0KSD+AN1NfJ
 WARgcdb2vaEAp87PGCAEZNkdyhNEon/h2C8xsuaoTEqwFgF56/1DJFCcCOLiu5AY3gtj
 dWdcGLAsUZ0y/+VhhgRFgE3QNJYtM/tDw3bsXUlhASj+B6K+74XFjtkxLKnapHyH3Wqp
 KG94qZc8Z5aedyPPTtAkIlZCpEHM3lYG2yiNPk/NdA3cRo7aQ419JxciuBjgDHa2xRmz
 1EDQ==
X-Gm-Message-State: AOJu0YzLivXpJz1eDHJcEgviwBPl4xjNFrz+yUjFdpRq+VKFt0KBKHeK
 GY0EcMw0QfuY2KP/iEGkrofyiGwLzrNRHA3cjt3gW7jkM1ok0ks6Ct3dptl/PhGxGybQdXWSoSA
 wInIW/5Xgj0VvZSAJLz2U4IOTH+fvzLx61HgZ
X-Google-Smtp-Source: AGHT+IE5r6W/5Ul2725WDflx9THQsAuOzf2UE/S+/QtvZbcfCJtK41ozvgFeNn1V9xEAG7TxyTWO+sEojYeu/OQvQjs=
X-Received: by 2002:a05:6402:40c1:b0:5ce:b08c:d828 with SMTP id
 4fb4d7f45d1cf-5ceb08cd9acmr6559012a12.3.1730565182907; Sat, 02 Nov 2024
 09:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124130.32072-1-sjg@chromium.org>
 <20241028124130.32072-2-sjg@chromium.org>
 <20241101214605.GA3767858@bill-the-cat>
In-Reply-To: <20241101214605.GA3767858@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 10:32:51 -0600
Message-ID: <CAFLszTiz=rM=_rGK_tpjtjT+Lej4ies+r1hmgyTqGWzArqyVcg@mail.gmail.com>
Subject: Re: [PATCH 01/21] bloblist: test: Move test into common
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>
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

Hi Tom,

On Fri, 1 Nov 2024 at 22:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 28, 2024 at 01:41:06PM +0100, Simon Glass wrote:
>
> > This test doesn't belong at the top level. Move it into the common/
> > directory, to match its implementation.
> >
> > This also fixes the build rule for the bootm test, which was depending
> > on bloblist by mistake.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  test/Makefile                | 3 ---
> >  test/common/Makefile         | 3 +++
> >  test/{ =3D> common}/bloblist.c | 0
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >  rename test/{ =3D> common}/bloblist.c (100%)
>
> On rpi_3_32b (and presumably others):
> test/py/tests/test_ut.py ss....F
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> _______________________ test_ut[ut_bootm_bootm_test_nop] ________________=
_______
> test/py/tests/test_ut.py:592: in test_ut
>     assert output.endswith('Failures: 0')
> E   AssertionError: assert False
> E    +  where False =3D <built-in method endswith of str object at 0x2bfc=
b00>('Failures: 0')
> E    +    where <built-in method endswith of str object at 0x2bfcb00> =3D=
 'ut - unit tests\r\n\r\nUsage:\r\nut [-r] [-f] [<suite>] - run unit tests\=
r\n   -r<runs>   Number of times to run each...elated commands\r\nprint  - =
printing things to the console\r\nsetexpr - setexpr command\r\nunicode - Un=
icode functions'.endswith
> ----------------------------- Captured stdout call ----------------------=
-------
> U-Boot> ut bootm bootm_test_nop
> ut - unit tests
>
> Usage:
> ut [-r] [-f] [<suite>] - run unit tests
>    -r<runs>   Number of times to run each test
>    -f         Force 'manual' tests to run as well
>    <suite>    Test suite to run, or all
>
>
> Options for <suite>:
> all - execute all enabled tests
> info - show info about tests
> bdinfo - bdinfo command
> bootstd - standard boot implementation
> cmd - test various commands
> env - environment
> fdt - fdt command
> hush - Test hush behavior
> lib - library functions
> log - logging functions
> mem - memory-related commands
> print  - printing things to the console
> setexpr - setexpr command
> unicode - Unicode functions
> U-Boot>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Oh, that explains why the test depended on bloblist. I thought it was
a mistake but it was just a way to make it only run on sandbox. I will
resend the series, leaving the bloblist suite in place.

I'm looking forward to getting my lab running...

Regards,
Simon
