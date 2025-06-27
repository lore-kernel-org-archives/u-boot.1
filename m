Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC28C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 18:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320F882DA1;
	Fri, 27 Jun 2025 20:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UWFyTkNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042C181D5D; Fri, 27 Jun 2025 19:36:09 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5353806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 19:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b31c84b8052so3147574a12.1
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1751045759; x=1751650559;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOObANnivRPJe8TPuHJkdrV4YmVqRZZDc8ieXROKjNI=;
 b=UWFyTkNHZqPeDNUS8YrhPE3OsJ9vuXRh0YLs9UnBsNz0A/2he7I2bYPzI1fPxaMDUJ
 l7sn7RWLM0Pk39US3tfIaWfu7RzHCdfHEB1gCzm/EA3zZ2KLAdH9po/usx6UOZJzm8ES
 yq/cYl61m0uUp7XKFTV3uppkjRBkhcQYwVKOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751045759; x=1751650559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOObANnivRPJe8TPuHJkdrV4YmVqRZZDc8ieXROKjNI=;
 b=ZuNn1/O63pHkFxq9QuNZStdxZw4v6cBTU08zdsVOEud4ZLc+9jIxMGZaGDZEmFt0Qe
 XkFV7Gy5q7U49bJ/uFHF5IBnZ9L++MSlim0AUwqB48bISUwIUSO6Wfbc8uCeJ9dwH9za
 RIccwGDxdJjBKgdXans8wxktdUQ0bIHtd8JeOuYC0LQDYthwnh4lUYovyG//zZv5EKVP
 p6CwrfcKhYCbft/IQMTIWY8lMLcqgk+orXiBFjqWn1GmAeNs1cllu2Id5zLRZJQwKLkU
 8OjIaSreeXSnN5biu00hQ4HzWhKq8U/ABpso8A3Rzc57qalZFvFbc2KAGRg5YQ59TglI
 560A==
X-Gm-Message-State: AOJu0Yw5ATt9cM1WXy+8o0xLhr54Pcbq/CDDgy4cNSNkfXlOBmfVbYlS
 qkoPYIjTJySjZv7FzYqwVfs4SKLageU4y5fcaQMG17NZb/PvACr9Nnb95xNfIp319Scv/k+y8GE
 Et5ikkimbzLK+xY8HeYaVRIK6VB+RcQCSvSrp2Oi+xQ==
X-Gm-Gg: ASbGnctibUJsTra9znCiTviuSbSdcbWTNeu1NrCW3WJg7WGPepR5b7bF1hB5w0pdQrD
 9FY/CqoAv205Z0YYZh50hYXlxHfUkpzPDGlJsQJ/looZS4ubCDtPRxmZTN6dEN8fnBMZBaD/d0w
 8G9yCx9IC3JUP8ySFaqD1PKtVDZx94Wjxf7FBxLQXNRf8Utf8rmwn0Vg==
X-Google-Smtp-Source: AGHT+IH4rz/K8cUYPhYl/RzMvaaTuLdk4n9AG+AhvvHOAq+eGH5LHi8csgZMRPEye/iXhLupKDi/ujWk/Bch6vu9yNA=
X-Received: by 2002:a17:90b:3c03:b0:311:c970:c9ce with SMTP id
 98e67ed59e1d1-318c930ff71mr5711021a91.28.1751045758994; Fri, 27 Jun 2025
 10:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250526194811.1179530-1-michael@amarulasolutions.com>
 <20250526194811.1179530-3-michael@amarulasolutions.com>
 <CAOMZO5ARdWa2bZrg+0VnndR66yFbmAOMNaMtn6PFS1Y9b1xPOw@mail.gmail.com>
 <CAOf5uwm5mTn3ac65cZiZedpo3kLQH4H1PEWtYMR+Rp_f8tR9fQ@mail.gmail.com>
In-Reply-To: <CAOf5uwm5mTn3ac65cZiZedpo3kLQH4H1PEWtYMR+Rp_f8tR9fQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 27 Jun 2025 19:35:47 +0200
X-Gm-Features: Ac12FXwYJc36PAOPavcmMTWKn2x3fbwTidpySRug8lDS5U56Ce7ZahUNVcZKNDc
Message-ID: <CAOf5uwnjLjd2y_eBjiQkrqwgNMOR-0WjYAvwxP+TY=3cumDqOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 27 Jun 2025 20:04:23 +0200
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

Are you going to pick up my last series?

Michael

On Mon, May 26, 2025 at 10:01=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Fabio
>
> On Mon, May 26, 2025 at 9:58=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
> >
> > Hi Michael,
> >
> > On Mon, May 26, 2025 at 4:48=E2=80=AFPM Michael Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > The clock driver allows to boost the NAND performance
> > > controller. Make changes to let it use the new clock driver
> > >
> > > =3D> time nand read ${loadaddr} kernel
> > >
> > > NAND read: device 0 offset 0x500000, size 0x800000
> > >  8388608 bytes read: OK
> > >
> > > time: 0.488 seconds
> >
> > Out of curiosity: what was the original read time without the clock
> > driver being used?
>
> The downstream driver I made 2 years ago before this change was around
> 3/3.5mB/sec, if I remember correctly.
> One point all the IMX6 platforms can then be migrated but I don't have
> any board with me.
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
