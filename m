Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2693CF3181
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B8E8397A;
	Wed, 19 Nov 2025 10:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="o7zmQnvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9FFD8397D; Wed, 19 Nov 2025 10:06:59 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C5683979
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 10:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-63f9beb2730so5186878d50.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 01:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1763543216; x=1764148016;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbY3oFFp3s5fQQ+kMyJD2Fj9DCVC/fJhOxfX/kx+jSQ=;
 b=o7zmQnvRAK6Ae2DE4mvRAkPyoqkD3eEdJri/jy6F2a/MeWdaB9c+je4swaj6Gu/aHT
 9uuqtv/3Cl4SwQgZKXvWqJLkzsXjwXtx33RU7CILXiEavmWFQoOxtnpixCMxQbumR889
 HabvKJ0cs4zambKyGiVPJc5eFcw6g6TmWZPgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763543216; x=1764148016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbY3oFFp3s5fQQ+kMyJD2Fj9DCVC/fJhOxfX/kx+jSQ=;
 b=g3r8FKstQuwGNFHAQzVHQxlrNQ+/aS3kOfr0JYtfbqPCY92YFlPOzOcEZ7Cg1j0dcq
 EDAYSU/L5G868TI26cLyJVgRV8EFj2LWwBw/JhAwYA2iZzaS2yiZkn5HCUMHV1NQnXUq
 YPkARFlYt7rH2dy1ZNb6l16N6yjbdB7TNl3utw6to/RQoCCrv8PM0D0Roqvq9vVrHkBr
 RCOd9ALpUFx0fXWDcueUQ1+y/WN1a3FW98SSE/3co3KAtwmh4euDY5O2xhN6qQRwsiCF
 mgM+Y2Lwp6hAu+FRf6iPprJ/6Z09zwn/U3PJLxTKhTkyiDW/tDBuZH9dDMYv0sXI/IPu
 I8YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhnaoD/Pxhk6/m0+pP2RtbuWl1py86b2m7GkGK3ybdP9c32LLzcCbmwaqhBGV5empfTn/Ug0w=@lists.denx.de
X-Gm-Message-State: AOJu0YzPGJUkiYfuTpvfzjtwg44Kb4UKSoSUtUkuzPU75qsPeCBnnz3f
 hBbAp23wu+bRMIdmIfpmvy/StOH/De4Crrk/XC1uB1HYpH7eXdYxA9HsynHoSnmfFsjgpExmdVB
 6udvRc1UVJoTFnNld7xytGbh19rZpNKEVHNsdbzQvRQ==
X-Gm-Gg: ASbGncso7U+N4bAirZ9MYu3PXVOiJhkoLbhPhhKSo4NbCWmFoiZKl8yIlPZ5ZJeIXwf
 WG2Eo90GT3ZCjevHqSh9mtXVj11jWEHaLC8CpdNYzYOPvrbc8KhfWjVR/B4kwleaOcxWC8C6a9S
 t7xrA2KdZSr5v2HaS92Sd1aOb2ZXNEwUQUcKiQ6FyYTRLi+lx+JXqeTVWmUdLnP4+NgMLQm3Ekk
 YDoWkm/WD/emHqlYXWMlpDYeHYDpEzYxb+QbgqcQL8lcYT6StLAc+CF8foxmJcLJFkqbJ/Yz+nC
 +vRyLM/5FQPx9qWoZ6QnQfcgWhC6LY3uPnAd
X-Google-Smtp-Source: AGHT+IFB2exgc+0sgQIuK9d73noULGWcUbuJOk2NxEBTmWjGHRzsiWi2G1YpcMHi3N5mRUNzp8uU7WZdW6a8rPoDwpE=
X-Received: by 2002:a05:690e:d5c:b0:63f:a856:5f90 with SMTP id
 956f58d0204a3-641e74ab596mr15695109d50.4.1763543215955; Wed, 19 Nov 2025
 01:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
 <87frcwexyt.fsf@bootlin.com> <875xbegt1x.fsf@bootlin.com>
 <20251113142745.GI6688@bill-the-cat>
 <CAOf5uwn_ggFp-KW6qDcKYn1kKA6+FabyQLCT1ecVoBdv9s3UqQ@mail.gmail.com>
 <20251118143405.GA527619@bill-the-cat>
 <CAOf5uw=jx7jTgkeZytjU0t7VFHSVrXfntxrpapUSWrYh5z8exg@mail.gmail.com>
In-Reply-To: <CAOf5uw=jx7jTgkeZytjU0t7VFHSVrXfntxrpapUSWrYh5z8exg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Nov 2025 10:06:42 +0100
X-Gm-Features: AWmQ_bk6O1fHRCZcNieA2ZXoRtrAnMNDyVu7JkarkCbqNszH7UMO3IgohLTsQwo
Message-ID: <CAOf5uwmygi5z3ae_wgJxu4LSKWfEHfAzPTWzN3TUCk22pHqikQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Steam Lin <stlin2@winbond.com>
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

Hi Tom, and Miguel

I pick a large part of the patches now, and check them and rebase all
of them. I will prepare one pull request today and another later this
week

All trivial patches are included and part of spi-nor patcheset

Michael

On Tue, Nov 18, 2025 at 3:43=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Tom
>
> On Tue, Nov 18, 2025 at 3:34=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Nov 13, 2025 at 03:36:00PM +0100, Michael Nazzareno Trimarchi w=
rote:
> >
> > > Hi
> > >
> > > Conference. I will pick him up this weekend together with others. Sor=
ry for
> > > it
> >
> > Hey, so it's Tuesday now and I haven't seen a PR and it doesn't look
> > like you made it to pushing anything to the custodian trees either.
> > Again I ask, do you need help here? I can go and pick up things that ar=
e
> > either clear or reviewed and start pushing it through. Thanks.
> >
> > --
> > Tom
>
> Let me sync with Dario.
>
> Sorry for the delay
>
> Michael
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
