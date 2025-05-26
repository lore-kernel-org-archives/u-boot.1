Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67ECC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 23:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE15E82DB7;
	Tue, 27 May 2025 01:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ahNH73x0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B50D882DB7; Tue, 27 May 2025 01:18:45 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B115882D4A
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 01:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-acae7e7587dso346713066b.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748301523; x=1748906323; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E65pDG6HsNdsLB5NiOGpG6YTRUbRkF6Qo5TmyCfWSaA=;
 b=ahNH73x0FJriF5Cd4v1uc048ElFN3mYtPqRxpkrTtgHI5DUrH7PNClg5b2dAjVuvoa
 lvFEijjjCvTG/AxNfufNuRSdLCg+GIrNAvFn0MyChBReSdctJZD5+pVsaauDl5qMVBDn
 NBa9HIyq9g0hzurQ3Tzz1l/iq9ewh57ws/E+yr+MbYyqc7YVpt7Yyz+ssuuK5bMFxlS/
 MiRD0br+fpp9Hn9eOBm2bHDMSU/Jv/M9enLF2YbwRJkDKytr1t/w6UXTuPEgVsa0cRb6
 dfBtbXgNPYRmJILX6dhBoBw+pZby1SygmPAptOGAI+T32rfUq0Rgf746ZQoMLfdSpSS7
 FD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748301523; x=1748906323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E65pDG6HsNdsLB5NiOGpG6YTRUbRkF6Qo5TmyCfWSaA=;
 b=OGxV2ier6btpOFntoKHDdS4M0NadcQsf4cerAHxEQC/Exp01IUDt7zl8VAdXrnZ/n/
 jRBepB4xQOrW3iFSJkFzu7pR6rFjC9Hd56KTD8aqIA2rf1r7dW11AETHp8nXkYAzO4oj
 9NNqhotwwo+pXdKg4bzTWIEO7zDgi5Ik6P7lIB4KQV5ddG83RPhUlYAZLxLqJhtjg0OA
 fh/U3cFVETBvoxtIB7aAIZSXlCJqjJ7gQxHwkKNFA1fkNVXw4jQ9gssGqNB4qGeg5C4f
 +Ll8nKhOvRQvvZm+Xz1h/ROxUVuh/+fKdpwBaQyHW7QC6/Iysum5v37d1Ot8XFqDTEwn
 /HDw==
X-Gm-Message-State: AOJu0YyE8YLKtWuN9FbaSDvUPBT249z1TvWN4CIeuW/tuZwZVAjmbAms
 MD+94zjZwaOaq9+kRy6ZknT6XUjyhWnzGSVQThLiwfJ2fZ9HlxJ8QTKGhsbgbHEf1Zydt9hLTif
 0LucoPAy8p5KXQ35WCxN10Qp03toWMkw=
X-Gm-Gg: ASbGncu2kSEYa0L4p1jiOt4I+Bkk7bYIGT70kmlnTkVh41uqpABMets21vc9Ii/qBK4
 M18amEjbx9caOhAljh9BmR0ANPlSdQQf0gPj5uXpH6c9JFvTs1+SH62uY9OKsoVVPBJE69qRACr
 yWwZAkt8jwPgdV5GC2ESgbijfTgczHWmUiXA==
X-Google-Smtp-Source: AGHT+IE1LC8WV6Kaq+8qKyMX/UXwg/qCkIzxIges/PVUdG1swHgH7B8eN5judqRUg7xlA+LNb3hg9+nl3qWTmngtNJg=
X-Received: by 2002:a17:906:f595:b0:ad5:72d4:85f9 with SMTP id
 a640c23a62f3a-ad85b1de31dmr968696266b.40.1748301522988; Mon, 26 May 2025
 16:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250523050201.22442-1-mibodhi@gmail.com>
 <20250526222524.GA2774370@bill-the-cat>
In-Reply-To: <20250526222524.GA2774370@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 26 May 2025 16:18:31 -0700
X-Gm-Features: AX0GCFucSgHX5drEzX8E7ZczmpbPFFPHeOhIRxddtoneWgjZloDFqnk_8q3E-xo
Message-ID: <CAJaLiFz9pehw77zD87n5VrwJX09L7dBM=ZxFA1CNzmE_U5Ghjw@mail.gmail.com>
Subject: Re: [PATCH] ext4fs: Fix: Read outside partition error
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>
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

On Mon, May 26, 2025 at 3:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, May 22, 2025 at 10:02:01PM -0700, Tony Dinh wrote:
>
> > Use lbaint_t for blknr to avoid overflow in ext4fs_read_file().
> >
> > Background:
> >
> > blknr (block number) used in ext4fs_read_file() could be increased to a
> > very large value and causes a wrap around at 32 bit signed integer max,
> > thus becomes negative. This results in an out-of-normal range for secto=
r
> > number (during the assignment delayed_start =3D blknr) where delayed_st=
art
> > sector is typed uint64 lbaint_t. This causes the "Read outside partitio=
n"
> > error.
> >
> > This patch was tested on the Synology DS116 (Armada 385) board, and a
> > 4TB Seagate HDD.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  fs/ext4/ext4fs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
> > index 1727da2dc6d..f10c622e62c 100644
> > --- a/fs/ext4/ext4fs.c
> > +++ b/fs/ext4/ext4fs.c
> > @@ -101,7 +101,7 @@ int ext4fs_read_file(struct ext2fs_node *node, loff=
_t pos,
> >       blockcnt =3D lldiv(((len + pos) + blocksize - 1), blocksize);
> >
> >       for (i =3D lldiv(pos, blocksize); i < blockcnt; i++) {
> > -             long int blknr;
> > +             lbaint_t blknr;
> >               int blockoff =3D pos - (blocksize * i);
> >               int blockend =3D blocksize;
> >               int skipfirst =3D 0;
>
> Sorry, I should have reviewed this deeper before accepting it. This
> patch isn't right because it introduces a new problem, we ignore all
> failures from read_allocated_block() now because we can never return a
> negative value. This was reported by Coverity as CID 131183 and I need
> to revert this for now.

Thanks! Indeed that was bad. I'll take a look again.

All the best,
Tony


>
> --
> Tom
