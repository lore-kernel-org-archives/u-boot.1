Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126E2C3ABDD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 19:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0DA82A39;
	Mon, 19 May 2025 21:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkH8uPd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4DFA82B4A; Mon, 19 May 2025 21:26:26 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9262982952
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 21:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7080dd5fe92so38556667b3.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747682783; x=1748287583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vL9Gd9+30jIQmc4Yo3e25iWUGjYwNAKgShMquJN4ZAM=;
 b=gkH8uPd8OL+TulvnWNsr9McbIlUNLbnZkiBT9GV0IVVt3pEm/7itpN12KVWGWQGM+7
 FyrKOnD5fRxXyJUTbSYBFGA7qJ0sk2p+39uYJ5uRc5Nvqj562QS+A0ePtz37lS2QEZ0G
 Y21hRE5WmJMTMVIgcfOu7OcPdXg06z8Na02PkPWpcLGHccym6/j8AdIcE5OvfnPqLppx
 W+DhJzS5zFQyJvvdnAVR1zZhA5dKB8GB5KPlwFn4ieH2BtLuJ6ZH6KCR/B3FtR/tGJUT
 M/CsXeimwBZxzjNZRPS0l1UdEYoTUDzs6H8RiA6LiOv3/eBbnaWOWs/hG7cXaAEeAS+s
 IjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747682783; x=1748287583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vL9Gd9+30jIQmc4Yo3e25iWUGjYwNAKgShMquJN4ZAM=;
 b=MlhXRZKhaOwTexbnycXtq63XRdXllqOYF+smYNShEbJhUrR2vfIU1zJP6CFdNYMfzM
 +i3cR+xcfbDMmXiFN9ad7KbLG3MNNwYTcLLOp/b2qWTCJlt7FSeoUcBqcMiIl5vm/EBi
 GZfh75c/F+LxmKPKrrhi8EgaK86JPYlttfPpdSTjYhPYBGrogxfTXp+u973wSni0hBMc
 DIB7Dy1rsocVEGbJgIrmU7xkj1ftrci2zfDdV1lHHZOPLu6fFw+AM3MbKTfL9RCwX/ir
 KHegJi+0qV7n0dVtSeskJ016B1rIkwZIf7EIBruqrD+ojvFbsRzcTSgEYS6w2okgzD8n
 fzpg==
X-Gm-Message-State: AOJu0YzioKBrEui9/xrT6b52/b/blUfWoISjC0bdT629KHoauSKqYWyc
 VmuGw6tQ1qcbT8Qc99TQ9VoOQtpEHSZS35Kx0LhSoRsZb3wpcXU5F9NCNxe4lc2sN6SBZyRl5jQ
 0LhML3s8naLHFSpj1xuB6KS6iAfSX4tvRGQ==
X-Gm-Gg: ASbGncuySyfPOI3zKtFTlEkfd8QJbhD/tKh1KxWpuPH7P1Oumll9mCKNRzPJvN7LUsD
 pG2O4s5aEkfZtFh3gFWo0X1sxQEJGszxgiX4e+TmeNuCICiEOKwKVwB58Ek37PKO2iC4rVZ51hx
 2dTDZmcKYMYZ1kjbN5YhNSvkhBSV7EAZGgPPop/TCIevk=
X-Google-Smtp-Source: AGHT+IHjJtxG8JD5HMiZKH05dQPr9pMioWgIeeM9qnWs7Gstq3mazKedT6he0WPzsBViUn7i7WO7DMa/yC8omqvTyVE=
X-Received: by 2002:a05:690c:6f03:b0:70b:7931:f12f with SMTP id
 00721157ae682-70ca79cf6a8mr205149157b3.12.1747682783283; Mon, 19 May 2025
 12:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250516185447.141540-1-ant.v.moryakov@gmail.com>
 <20250519191116.GT100073@bill-the-cat>
In-Reply-To: <20250519191116.GT100073@bill-the-cat>
From: Anton Moryakov <ant.v.moryakov@gmail.com>
Date: Mon, 19 May 2025 22:26:10 +0300
X-Gm-Features: AX0GCFsVEBLMz0SsTqb9dFVq3oP-grCu9CTrLpq31VQWCef5AW525Vzae21Qwxw
Message-ID: <CAHb2+K40Ys-omFx-aqHMT-ttkfgOrLUe_7fpD7XEu-EV8A2H8Q@mail.gmail.com>
Subject: Re: [PATCH] lib: add NULL pointer check for %s format
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thank you for your feedback.

You're absolutely right =E2=80=94 the subject and commit message were too g=
eneric
and wordy. I've revised the patch accordingly and sent a v2 with the
subject:

    [PATCH v2] tiny-printf: handle NULL pointer for %s format string

The v2 includes:
- Updated subject prefix to reflect the correct subsystem (tiny-printf),
- Simplified and clarified the commit message as per your suggestions,
- No code changes =E2=80=94 just improved presentation.

Thanks again for the helpful review!

Best regards,
Anton Moryakov

=D0=BF=D0=BD, 19 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 22:11, Tom =
Rini <trini@konsulko.com>:

> On Fri, May 16, 2025 at 09:54:47PM +0300, ant.v.moryakov@gmail.com wrote:
>
> > From: Anton Moryakov <ant.v.moryakov@gmail.com>
> >
> > Handle NULL pointer case in string formatting (%s) by printing '(null)'
> > instead of dereferencing NULL pointer. Makes behavior consistent with
> > standard printf implementations and prevents potential crashes.
> >
> > Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>"
>
> First, this is tiny-printf so the subject should be changed to be
> clearer about the impact. This is only used in very constrained
> environments.
>
> > ---
> >  lib/tiny-printf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
> > index faf55d7f327..da596d72050 100644
> > --- a/lib/tiny-printf.c
> > +++ b/lib/tiny-printf.c
> > @@ -306,6 +306,8 @@ static int _vprintf(struct printf_info *info, const
> char *fmt, va_list va)
> >                               break;
> >                       case 's':
> >                               p =3D va_arg(va, char*);
> > +                             if (!p)
> > +                                     p =3D "(null)";
> >                               break;
> >                       case '%':
> >                               out(info, '%');
>
> It's so constrained that I'd rather not include "(null)". We should end
> up printing nothing in this case, as this is handled in commit
> f0dab28915b7 ("tiny-printf: Handle NULL pointer argument to %s") and
> having a print where we just omit something, in this constrained
> environment, is acceptable (and should be the debug hint needed).
>
> --
> Tom
>
