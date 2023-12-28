Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36B6C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 19:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F3087AD2;
	Thu, 28 Dec 2023 20:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y17VUEdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B22B287AA9; Thu, 28 Dec 2023 20:48:19 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C3AE87A4E
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 20:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-781716c1291so66923185a.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703792896; x=1704397696; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXR5tSaLnEwOMFIOL0bmleYg6TyrZm/Udv2kA1UZikw=;
 b=Y17VUEdqDQcZLTWRnNzGAMj1nc3aps4oqG758SAJ1hCrGTGQEcMoQjnuJtxd0Mnadl
 WHH9D/I7UqRiouPUupszXNOn3Ip50V5G4N3u+61Ku1Eia1rHfYjv1gv1Oj6VaZ9yNdGF
 sLxRbO7chwHgLZqu3kzaVfSg3F/9QJBuNgHI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703792896; x=1704397696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXR5tSaLnEwOMFIOL0bmleYg6TyrZm/Udv2kA1UZikw=;
 b=UO2xLg9+fZmSeRVNtxNw+igua022GG10q7Z0sYpG4ZKBqjtb44OtEcojMS/1TBSGcn
 7Q4/ow5tWcO4I6Y5eTcUI1jiyabU27Rkw0jLsjOm0uvb2Zt+G6JrtrUgb/SUaT/GI4WB
 9he16NripqH+IlIqNjNz5/rm0mMMhddLq2BXUPDWokaiWgM43Rpj1igPOYlh4HPe4lhu
 /zIJw8ndu8T2TxgYxY7pxNXuxa5YO9yRGS7d0Go4rJcnDz+C72JfCP4ob64Aa1fwQ6zu
 0DejZPP9JWh7CX/D89pFKcSpmf0JWSMu4JC//UklvaeWVYiy27xeVjNnAFmtup0Dx9cn
 mI5A==
X-Gm-Message-State: AOJu0Yzx7bivu+PyBfHD+MFJSZE+F18SvvzYMfoAEQjitvpxiCyYtZqW
 fOXx1pKG3MdZlZViZvQRM5fCCNiZRMOtKt0b6ooX2zoTZ0Ln
X-Google-Smtp-Source: AGHT+IEW6NjsGOvVzOr6jRrK+QoyvfZbkh/O8ifcWEr3eXLrdMkzzAtIzLTp+czIPHKB3TuDr1gz2k6krnq51XPsqkA=
X-Received: by 2002:a05:6214:416:b0:67f:20b3:aeb with SMTP id
 z22-20020a056214041600b0067f20b30aebmr18508588qvx.60.1703792896047; Thu, 28
 Dec 2023 11:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-6-xypron.glpk@gmx.de>
 <CAFLszThrHODfu-ZhHEzRe5wT-nMpXAp=UCBJC3FipTi9owhajQ@mail.gmail.com>
 <f66c51bb-7dd8-432b-9579-598eb3619c04@gmx.de>
 <CAFLszTimwDXjbQrER+808pezWD_1UaMk+g56RzNmo9Bwc9Uuew@mail.gmail.com>
 <15E00D56-2FB7-4905-832E-447090CF9EE3@gmx.de>
In-Reply-To: <15E00D56-2FB7-4905-832E-447090CF9EE3@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 19:48:05 +0000
Message-ID: <CAFLszTihGp1pd=tv7rjC2viJj5-XvSWy_=-v8deJPC7CvhQ15w@mail.gmail.com>
Subject: Re: [PATCH 5/5] test: unit test for smbios command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, Dec 28, 2023 at 5:11=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
>
>
> Am 27. Dezember 2023 08:40:40 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Tue, Dec 26, 2023 at 10:11=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> >>
> >> On 12/26/23 10:47, Simon Glass wrote:
> >> > Hi Heinrich,
> >> >
> >> > On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron=
.glpk@gmx.de> wrote:
> >> >>
> >> >> Provide a unit test for the smbios command.
> >> >>
> >> >> Provide different test functions for QEMU, sandbox, and other syste=
ms.
> >> >>
> >> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> >> ---
> >> >>   test/py/tests/test_smbios.py | 47 +++++++++++++++++++++++++++++++=
+++++
> >> >>   1 file changed, 47 insertions(+)
> >> >>   create mode 100644 test/py/tests/test_smbios.py
> >> >
> >> > Can you please write this test in C?
> >> >
> >> > Regards,
> >> > Simon
> >>
> >> According to our documentation we can use either Python or C tests.
> >> We generally use Python tests for testing the CLI.
> >
> >Not really...there are lots of C tests for the CLI. It is actually
> >easier to code, in most cases.
> >
> >>
> >> I cannot see any benefit in trying to write this in C.
> >
> >I did go to some effort to document this:
> >
> >https://docs.u-boot.org/en/latest/develop/tests_writing.html#test-types
>
> As described in that document C is most adequate for testing on the sandb=
ox. I want to run this test on QEMU and real boards with release U-Boot fir=
mware, i.e. without deviating configuration.

Are you checking that the compiler works? Most such tests are a waste
of time, IMO. Anyway, any test is better than no test, as Tom says,
so:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
SImon
