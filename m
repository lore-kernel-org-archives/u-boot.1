Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24A7CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D65683642;
	Thu, 30 Oct 2025 17:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p2Rpuo8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A8683849; Thu, 30 Oct 2025 17:39:56 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BED88334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7a4176547bfso1287787b3a.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1761842392; x=1762447192;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+StmTRc3qO8VtQNPh/8nsGERe9dne2HIx6mpzzNwn8=;
 b=p2Rpuo8u60BJJ1/t23DD7drUZN9e2kSzvhApB916VW9/MrHgEItOl9VRTlDUCH3sz4
 Fca1N1FAyO9GUh3xE1F8uP9/sZTMwnDofpfgSX6c620ZddvrLu6dpUAYCg/Qao+3gShY
 DeeUC8dy3TJUCoUYmgt9nnJtvC0X/ZLVGhz10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842392; x=1762447192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+StmTRc3qO8VtQNPh/8nsGERe9dne2HIx6mpzzNwn8=;
 b=W3l60UURjMeDaO3mG/yeIT/r3TFA+jx+HQiLXtOl5iP08pivYpVYP2pTbdTfIja0aw
 GQeJdXDSaQuqxk1/cq32jHaXuCca1L1qB7CtPSWXnJC7xTPxP4WoGOrhj73Zs7WcuVT4
 gYTpF4vy/8UadQiyGW9xbwpcgjgd5SWJHMzM/6hhyUJqZJBiQ2UlZMmu9Tz4KiB2O1e8
 l2V/m/XO8A9/enCX1ian8KnbjC6vVuF8OUbjvBnZ9xx0IMPo88xfN5Uvsv6DxG7Sz9LO
 qGlIpkIQC1dj5t8PpwpjQ7u5rpcoL8TbwyxJ8w+nVfFdXZC1WZ2l1FGnoTQoJxbaVu0W
 g72Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW28wZV7p2DdI5Srjxw9BmubOhTZsD1wmXGkfoS5fwe8c7oQ9cLoU0mOEqpJHpVogxO+j4+ntk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4q864WrOAzZKrSJ1DerTAiNlc1JExH1iNpNvlc7OszT1YDE4e
 JP6SvNIFd5KzX3fdX7j03RYqz3SX9cKgM1Lp3MFoTiX5EXLWM20V3jjyfb+JOu7eIcCrXYRAjME
 Fw0+1pzKYDpqH7OJBUlD46H/qATOYyEMgS/3E5AwGNg==
X-Gm-Gg: ASbGncuEcKYaQ2TgigR0RQmVb3s6DA6D69bPP083Re4vCoSuLg/8umWN2kt7pdrM3nJ
 p2EHRhR0b7yKP7uhjWE4x+Ln/jtKkptXTilt+XlrvQwT2N43tZTM5YR01kOvlNTyr5oo0BlrHDT
 TGdtvBLBO77aE2Qap6ZCJmoWWhXo0RwCJ3npb4vcBpUjY7zuCJ7h4ThWL27VOSNo/vH/NV5QgID
 CFo46aHMVGYyyFB/QTyiCHR1L+ffcLRtQRKKONJ2iOLRsvSS+eXGKs7u053Q5Xmc/iAqW3R5PRb
 U7R5w5xDleoC/6kq4ouerXLe3g==
X-Google-Smtp-Source: AGHT+IFftv55ysxd9VTarVTnNAswZR587BZ2ddC5nwEoyVBJgbfElobTV8bvkZH1lT0jIFG1h8ipH4PoxMnP+uZJCDs=
X-Received: by 2002:a17:902:e890:b0:294:f310:5224 with SMTP id
 d9443c01a7336-2951a4d8357mr4831195ad.29.1761842392523; Thu, 30 Oct 2025
 09:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Any4akaDeRNwxqhcdy_gjxQVHC3aao6sDDxqALxNsp9Q@mail.gmail.com>
 <CAOMZO5ANeCogTO+dyq9GSu7XGeW+H3OZ2CXCEsguhcrQLJwNrg@mail.gmail.com>
In-Reply-To: <CAOMZO5ANeCogTO+dyq9GSu7XGeW+H3OZ2CXCEsguhcrQLJwNrg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 30 Oct 2025 17:39:39 +0100
X-Gm-Features: AWmQ_blCDSfisK6Ej59lRYEYNlyrOCh-eweTPZV71ub9lTgU-aLWZkA_12_raNo
Message-ID: <CAOf5uw=rMZZs7m2mUMV-DCw=C1d_R7uWAqzpWfYOM4TXY9Sm6A@mail.gmail.com>
Subject: Re: vexpress_fvp test.py CI errors
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>
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

Hi Fabio

On Thu, Oct 30, 2025 at 5:36=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Thu, Oct 30, 2025 at 1:35=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
> >
> > Hi Tom,
> >
> > I'm getting the following vexpress_fvp test.py CI error, which seems
>
> Here is the error log:
>
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1279968
>
> > unrelated to the master-next tree I'm building:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-imx/-/commits/master-ne=
xt?ref_type=3Dheads
> >
> > Please take a look.
> >
> > Regards,
> >
> > Fabio Estevam

! _pytest.outcomes.Exit: Lab failure: Marking connection bad - no
other tests will run !

Did you try to rerun from that stage?

Michael
