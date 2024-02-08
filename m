Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ACBC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 11:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9F187CF7;
	Thu,  8 Feb 2024 12:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZmcEU76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0226D87E36; Thu,  8 Feb 2024 12:46:08 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C023387BBA
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 12:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33b3585518eso374681f8f.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 03:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707392765; x=1707997565; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwGqhtlGIFEas98KFaeuDuA+yU0BhKaKbzoQiG1hFEc=;
 b=PZmcEU76BEG0P/gD/wuxylMuq7eDvxYrAGloyACaRxJphb3QGBVSEvODfpGbZaRuAg
 jpuZO22zhhxLox4/QA5BnM64+rfaUSh/LW41vVS0DvqnkKuIYl/BlYxZhvuCLaVRRqur
 6L4BJs6+pKOmSIpEna1tJFt3CCkigaKdDbtJ3Tx+y9ZSaAwbqJ6rNO79BD1YmO4nFF5u
 ZAg0SOBbwz69uBlz/tP3KSWyL3ZGesArTcBF8e6ofMg7vdyL8bzOTgqXJbJvts1icq05
 yFxk2U+nXw7CH0mlxBjrxlR4AWRcugcpZSNH50ZRatCWPLdSlPGNEslKIJ7nq0ZP2FJF
 bmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707392765; x=1707997565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwGqhtlGIFEas98KFaeuDuA+yU0BhKaKbzoQiG1hFEc=;
 b=ScAP9zcIk9swA4/FAHo8iIHB7O1xma6a6YECtKK/KtmyZPWUkH9P6pTjHfNbRP/Pu7
 lR19ap6cPepbDXqnSxvhphYKXFvJvom6tfJwAu23fmHVg1bnxp9A2WpmUplIRXQ75vyX
 H2mF6P4P6fEJGkbc5b40Dl3TNHwluJ8NGrnWKjYw14tXZyaBpnwf7W39IXyXRaaNA9Rv
 ZqAylki+XQUohL8HNJxxkysBaIEz3c56CmYcaZ9xJ8Zag2k5QYQg4XmmspAIXZ9D6XLU
 PLd1ZEVRSARdVPivJpMPDH3zi2ywQyGdK1gEIVZcEytLswHEKkIqDxvSqh9s6B4d+kAY
 qqag==
X-Gm-Message-State: AOJu0YykCm7xOf7Qq6WHHb6wnLytLaPWHLKXpTGaDp+MadItrMwjRvw7
 8UUpSTyH9zo2h0M9/8gpp1y9lfB4OADRx+f65qsc11DBQ/PvMAR0y7etMwzMPcIYCo+FXZGSCyR
 7NpfI/nhmeU5Kial1w7xg2sVmAw8=
X-Google-Smtp-Source: AGHT+IEQn3S9WE9HoG6X3kuxIUUJK2JkgFKzPoo9tnq0+czt5El7f90DSbmqHzMZEni2MNGkULAYRW4zDMB2hbBH44A=
X-Received: by 2002:a05:6000:1f04:b0:33b:535c:a502 with SMTP id
 bv4-20020a0560001f0400b0033b535ca502mr2348625wrb.2.1707392764772; Thu, 08 Feb
 2024 03:46:04 -0800 (PST)
MIME-Version: 1.0
References: <CAByghJZqOnV8w4nJKDOjiPVUGkq2KqYS=qxps09744==oXwtZQ@mail.gmail.com>
 <20240207134813.GV1152441@bill-the-cat>
 <CALeDE9MDJZjtMDhbg-vfis1E5uVfYn4WwD1hoPgYWxRiPfjwGQ@mail.gmail.com>
In-Reply-To: <CALeDE9MDJZjtMDhbg-vfis1E5uVfYn4WwD1hoPgYWxRiPfjwGQ@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 8 Feb 2024 12:45:52 +0100
Message-ID: <CAByghJb3TDSQtVY2di-bSrDm2iiwkX8FkcZv85vrnBBHi0eGrw@mail.gmail.com>
Subject: Re: [RFC] Drop md5sum, crc32 and sha1 cmds in favor of hash cmd
To: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hello Tom, Peter,

On Wed, Feb 7, 2024 at 3:16=E2=80=AFPM Peter Robinson <pbrobinson@gmail.com=
> wrote:
>
> On Wed, 7 Feb 2024 at 13:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 07, 2024 at 02:00:16PM +0100, Igor Opaniuk wrote:
> > > Hello,
> > >
> > > I was playing a bit with different hash functions recently, and
> > > it turned out that md5sum, crc32, sha1 cmds just duplicate
> > > what is already covered by generic `hash` cmd.
> > >
> > > =3D> sha1 0x60000000 0x200
> > > sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e2=
483d0e1437
> > > =3D> hash sha1 0x60000000 0x200
> > > sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e2=
483d0e1437
> > >
> > > =3D> crc32 0x60000000 0x200
> > > crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8
> > > =3D> hash crc32 0x60000000 0x200
> > > crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8
> > >
> > > =3D> md5sum 0x60000000 0x200
> > > md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd405=
0
> > > =3D> hash md5 0x60000000 0x200
> > > md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd405=
0
> > >
> > > Considering that most of them (besides md5sum) are using the same
> > > int hash_command() function under the hood, but have a lot of duplica=
ted
> > > code for handling params, does it make sense to do some cleanup and
> > > drop all them in favour  `hash`?
> > >
> > > I also plan to extend usage info for `hash` by adding a list
> > > compiled-in algos based on hash related compiled flags
> > > (CONFIG_SHA1, CONFIG_CRC32 etc), so it's clear what algos
> > > are available for hash calculation.
> > >
> > > Comments/objections are welcome!
> >
> > It would be good, implementation wise, if each of those commands was
> > just a redirect to hash ..., similar to how "load ...." will call the
> > right filesystem calls. Does that make sense? Thanks.
>
> Yes, I actually have that one my todo list to basically alias the
> individual commands to the hash command to remove those commands. My
> intention there was a first step to allow us to eventually minimise or
> even remove the use of obsolete hashes etc.

Thank you for your comments. I'll re-factor as discussed and send a patch
series when it's ready (plan to do that before the next merge window opens)=
.

Regards,
Igor

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
