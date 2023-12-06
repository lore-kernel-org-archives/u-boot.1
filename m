Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24AFC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B53E87655;
	Wed,  6 Dec 2023 04:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hGJj4tIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDFB58753E; Wed,  6 Dec 2023 04:55:09 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70E687655
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5d7a47d06eeso41289877b3.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834904; x=1702439704; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5G5oJrLiUqBhboTDvAbTLkmQU4oosIjQG2XbaLByluA=;
 b=hGJj4tIZiY0ur7EFvm7qVf/r0D9olJnl9wFTD1TwV4druPxH/1WkYfOBNQq5d2E5oT
 DR5QNucO5sJnzdKiUApnpNpbCZcJD+r/sKcOE8teuZF/DvQT3E4wsJRM+btA6R4SadaD
 Uq0aGghC9me7KWZfXs/6Ht0AbBDtlcxwDmiVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834904; x=1702439704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5G5oJrLiUqBhboTDvAbTLkmQU4oosIjQG2XbaLByluA=;
 b=pWVmDBH+YULG9/2uvRjyRqUNZ1X9FGC4GaTmIMjCKeID2IZMVEHfm3gAfr6NeggbaP
 Iq+jf+rtiVr6jzL1Km/wp0LZPDYwobd8CskLgR6PhGtuCvxCBp8vT3CGoh7EmM6yIdd7
 C9uz98BY8ol9fyzo+EqP/iN5GjRCTBQNpWX1BxZGjjgv5Nt7DNAUoR2Xq3Et1m0uX3Cc
 GIIuOZe35kSCnlCrO2RJU8T1qzTukycP8ZDPVyA+vqP1+uOKcDenEdRj3tkRooAaqlBa
 ZFebKQBAEsdJlowXumH9bPg8gy0TV9mrvSt2W+gMM+CnTERZ2a/ga1xZq4MxFXAoMDfR
 3b6Q==
X-Gm-Message-State: AOJu0Yxr2pWoGRj2v9D4eW14mqe7JMCokTWA+ZZge2Zx4Vmf0eHMYg46
 RKXDnEm0/r3Qv3di6OypZwWkKlLdFfiaTXuomdvc3Q==
X-Google-Smtp-Source: AGHT+IGDFTVWTdhu8e80C2iJ6AetKBzcblMaYc6XPnLiTb7ITJ0OzCZNFsHQL3LDDE8EavIkez1NNQ/jjeeT/opZPB4=
X-Received: by 2002:a05:690c:d08:b0:5d7:1940:f3f8 with SMTP id
 cn8-20020a05690c0d0800b005d71940f3f8mr161834ywb.96.1701834904382; Tue, 05 Dec
 2023 19:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20231119165501.1305136-1-i@shantur.com>
 <CAHc5_t3MwUvFdQQaZGeONxS-JNuB4mYXyU9YSexN8bCbQUTRYQ@mail.gmail.com>
 <CAPnjgZ3umb6g3O7r+bNtCpGihFHoq9Yp3Fnq9Hd-VkQvewX0oQ@mail.gmail.com>
 <CAHc5_t0+o5FvgpLUDAWLq6932fapzVDy=+47LQUcsAPT-3arWQ@mail.gmail.com>
In-Reply-To: <CAHc5_t0+o5FvgpLUDAWLq6932fapzVDy=+47LQUcsAPT-3arWQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:54:51 -0700
Message-ID: <CAPnjgZ0g2wgL=baD=LUmw2tK-E0tmUpoRaDE2oYNDLw0tum99Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] bootflow: bootmeth_efi: Fix network efi boot.
To: Shantur Rathore <i@shantur.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Shantur,

On Tue, 5 Dec 2023 at 04:13, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> On Tue, Dec 5, 2023 at 12:52=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Shantur,
> >
> > On Mon, 4 Dec 2023 at 05:38, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Sun, Nov 19, 2023 at 4:56=E2=80=AFPM Shantur Rathore <i@shantur.co=
m> wrote:
> > > >
> > > >
> > > > Currently bootmeth_efi crashes while doing a network (dhcp) boot.
> > > > This patch series fixes issues and both network and disk boot works=
.
> > > >
> > > How can I help to get this patch series merged in?
> >
> > You can check patchwork [1] to see who it is assigned to. I don't see
> > it in my queue though.
> >
> It's with Tom Rini I believe but with status Needs Review / ACK.
>
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D382855

OK, well it has a review so that tag may be out-of-date.

+Tom Rini

Regards,
SImon
