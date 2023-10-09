Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A33E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 13:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A379863C3;
	Mon,  9 Oct 2023 15:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W9lL9jPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B07F5863C9; Mon,  9 Oct 2023 15:56:31 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473C48638B
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 15:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=monakov.y@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-65b0383f618so30216676d6.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696859788; x=1697464588; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mA0mPAGYZJbdK71ABMA6KGZ0BFQrKdwZ20iB4Qjl8ak=;
 b=W9lL9jPMr4+ohzua15lDOYaiExf3xWZAZgwj5RPTzyIi/m6DjvoAJFNryV6SN8jlht
 9jeTE9eQ4KBHwn7CkZ97ZGBD+EzV+/vbjqUyFYC8DHa4eK2lbPahLpuTmCCZaSwW+XOi
 YQ8oNXVMd9n8dZHxfw4KlklNFCKcgSRVAV9tafya5wwf0tAEe0gcfdw3j6PcOdZagW+T
 8CMMyL7DLcX9x5rsQtcMzixhuCkG5vAQDLLRLwNu+14F2UKvYydWglA4L+75NNlveFJN
 OBU4sVu6uJawEVhMKaG9vxKo5+821m9yJgI0d+l5jNWhQMAHBGZdIxioS7vLpZ3JB3oe
 OkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696859788; x=1697464588;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mA0mPAGYZJbdK71ABMA6KGZ0BFQrKdwZ20iB4Qjl8ak=;
 b=mA2oU4xTmL4aJc7p6AwgJaurOCVwaQpp5WnYPCHnup7QbC1iClhhSA+rfP0Vl6gCFw
 kea3zUCca8m8qtKE60VwD7/zSYRQCuQAAbfbOL0pgSINdJ0KZ3onn+QnqJBGy48I+/cX
 CptfIZ/gydqW5lMRVJe9vUZE2CqklMeBqPCujRYJay3zUnWCyq2xnWrz9Y/NOr1+t+OF
 fZ62TTjBKn39ljfTvvV9lMDPVdNt1G81sy7VRZKLCagFhJkZXuTaMKtfUCgUq/o4+B5I
 CeMQTXqwusjuojidYvnZ2+kpdlRLYX7GsIqyeb42A996Qk/bb0GyVsXxvoZ5bzTpy0jf
 XAHg==
X-Gm-Message-State: AOJu0Yx9HmOum2TNx0Ey0L34/oIewD71iZyoDRZnHlf5GniGpds0lTiO
 EBgAu+OY2vL/7h0tuEgg6VNRlw3E7TJg5qCUgzD+33o7WNE=
X-Google-Smtp-Source: AGHT+IEUVyuzGpwSkUvh8J8JaQZxdPLXwD90CNdZkPvOqhmpp9B8voybPinF1tPkYu6CTXz1xTTaFwy0CFN31rc414I=
X-Received: by 2002:ad4:5004:0:b0:65b:2e81:e507 with SMTP id
 s4-20020ad45004000000b0065b2e81e507mr15260481qvo.4.1696859787681; Mon, 09 Oct
 2023 06:56:27 -0700 (PDT)
MIME-Version: 1.0
From: Yurii Monakov <monakov.y@gmail.com>
Date: Mon, 9 Oct 2023 16:56:16 +0300
Message-ID: <CAM-z4v6dqvpG5ir=5Wa1pfWu33WHNm5h4Hya-MvV84qEP20BNg@mail.gmail.com>
Subject: [PATCH] cli: Consume invalid escape sequences early
To: u-boot@lists.denx.de
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

Hi Simon,

On Sun, Oct 8, 2023 at 2:10=E2=80=AFAM Simon Glass <sjg@google.com> wrote:
>
> Hi Yurii,
>
> On Fri, 6 Oct 2023 at 15:32, Yurii Monakov <monakov.y@gmail.com> wrote:
> >
> > This commit fixes some issues with extra 'Esc' keys entered by user:
> >
> > 1. Sequence <Esc><Esc><Enter> right after autoboot stop gives:
> > =3D>
> > nknown command 'ry 'help'
> > =3D>
> > 2. Sequence <Esc><p><r><i><Enter> gives:
> > =3D> ri
> > Unknown command 'ri' - try 'help'
> > =3D>
> > 3. Extra 'Esc' key presses break backspace functionality.
> >
> > Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
> > ---
> >  common/cli_getch.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/common/cli_getch.c b/common/cli_getch.c
> > index 61d4cb261b..0ee7908777 100644
> > --- a/common/cli_getch.c
> > +++ b/common/cli_getch.c
> > @@ -46,6 +46,8 @@ static int cli_ch_esc(struct cli_ch_state *cch, int i=
char,
> >         case 1:
> >                 if (ichar =3D=3D '[' || ichar =3D=3D 'O')
> >                         act =3D ESC_SAVE;
> > +               else
> > +                       act =3D ESC_CONVERTED;
> >                 break;
> >         case 2:
> >                 switch (ichar) {
> > --
> > 2.34.1
> >
>
> This is a bit unfortunate. Basically the problem (as I understand it)
> is that characters are built up for processing so the expected ichar
> =3D=3D 0 is never passed in.
>
> I think the fix is reasonable. Does it work as well if use:
>
>                else if (ichar =3D=3D '\e')
>                        act =3D ESC_CONVERTED;
>
> ?
>
> Also please can you add a test case o test/common/cread.c
>
> https://u-boot.readthedocs.io/en/latest/develop/tests_sandbox.html
>
> Regards,
> Simon

> This is a bit unfortunate. Basically the problem (as I understand it)
The main problem is that extra Esc key presses are accumulated internally,
even if it is already clear that the current escape sequence is invalid.
This results in weird behaviour. For example, the next character after 'Esc=
' key
simply disappears from input and 'Unknown command' printed after 'Enter'.
Googling "u-boot 'nknown' ry help" gives plenty of such examples. This ofte=
n
happens when user stops autoboot pressing 'Esc' key.

> expected ichar =3D=3D 0 is never passed in
IIUYC, this is already checked in the calling function (cli_ch_process).

> Does it work as well if use:
It was my first fix attempt. But unfortunately it does not work, because if
the next character is not valid for the escape sequence it gets swallowed.

> Also please can you add a test case o test/common/cread.c
It will be quite easy. I've tested this in the sandbox (and with qemu) and
was not able to break something with outstanding 'Esc' key presses.

Should I resend this patch?

Best Regards,
Yurii
