Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692A2C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01EB287933;
	Thu,  4 Jan 2024 13:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FYp/IDM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB15787954; Thu,  4 Jan 2024 13:29:13 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7FB687917
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a28ec136715so39856066b.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 04:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704371350; x=1704976150;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uEzRI5u6QmbUdynB46ufmXtXpKDXTTpdR7ji9wZQJM=;
 b=FYp/IDM0pizocC5DRXyzHjTM8v+GYOcJArS3aXd+4jQAhiG1bt+Kw4OvQWMSN+V0Go
 FBRDIqD0ulMMs/swC4XQbqHuZDWTNiWvFzw2vgNvOVNX97pve/XHfUda9JBqt/HZVc0O
 NCilpGNko0+4x9V61t1V2wWpYthto1ZsLVB3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704371350; x=1704976150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uEzRI5u6QmbUdynB46ufmXtXpKDXTTpdR7ji9wZQJM=;
 b=ZY1/wj0vm/phu3wGGkUqM5xEYGYQTBMDnAW+gphNOHDY9QiTrFCqWPzchl9gghnwSf
 24bfPA2v2NcvT7o/eW3IcF3/vsTCvWvFb1ciNYltIa63zzCv2mOMxZkM5Aj3uIYMpASS
 JDUdiUsvDO9VjjoyihC4/T+YlDz2pfq8j9oeXTMs3LZ1DizCyb4YOnG8z8BXG9wDs7aD
 0oyNhTOsQ/1/OXTZ0JQZPBAGgeF95fcg8xAzmeWJpy7XxZMjxx0lgKT5gCFKUJ/SIrmp
 Z53kTiLHYGPpybrICQrWSdQU5GFgcqjQ2zTGX17jjVv/ZTIRR1XPLZmih9ntQdbKVDOJ
 PTqw==
X-Gm-Message-State: AOJu0YxV+E5GXAxRsfy+30jU+axRQaguX1w5lH3wMySWKoetkyKDUa7U
 gbmaZjKsREZTlS/DAUSPAdPamhVd5RuNAWvDiGeWAFgzqxH4Gg==
X-Google-Smtp-Source: AGHT+IGRmlNV3xVYXJgRqFat5c9NwIvcsD6xAgXctG/jj1YomQw5V47JvJXu9sCvSKcs42tnSHNlohVDYJ9ifzuNm2s=
X-Received: by 2002:a17:907:20ec:b0:a27:7076:9d79 with SMTP id
 rh12-20020a17090720ec00b00a2770769d79mr238900ejb.96.1704371350281; Thu, 04
 Jan 2024 04:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20240104114619.280513-1-o451686892@gmail.com>
 <45cc3cf3-4120-460d-b275-fc019156ce20@amd.com>
 <CAHk0HosXQ8iU0G3tZcQUf44FPdSzGOh7X9mH85Ja6nCEe46drA@mail.gmail.com>
In-Reply-To: <CAHk0HosXQ8iU0G3tZcQUf44FPdSzGOh7X9mH85Ja6nCEe46drA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 4 Jan 2024 13:28:59 +0100
Message-ID: <CAOf5uwkvZxAH_qRdZKV5OMD0oTyohRZ3yYS5mWhCzZ+QGtx=GA@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
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

Hi

On Thu, Jan 4, 2024 at 1:16=E2=80=AFPM Weizhao Ouyang <o451686892@gmail.com=
> wrote:
>
> On Thu, Jan 4, 2024 at 8:00=E2=80=AFPM Michal Simek <michal.simek@amd.com=
> wrote:
> >
> >
> >
> > On 1/4/24 12:46, Weizhao Ouyang wrote:
> > > Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
> > > crashes.
> > >
> > > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > > ---
> > >   cmd/sf.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/cmd/sf.c b/cmd/sf.c
> > > index 730996c02b..e3866899f6 100644
> > > --- a/cmd/sf.c
> > > +++ b/cmd/sf.c
> > > @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *con=
st argv[])
> > >       }
> > >       flash =3D NULL;
> > >       if (use_dt) {
> > > -             spi_flash_probe_bus_cs(bus, cs, &new);
> > > -             flash =3D dev_get_uclass_priv(new);
> > > +             ret =3D spi_flash_probe_bus_cs(bus, cs, &new);
> >
> > if (ret)
> >         return ret;
> >
> > don't you want to rather propagate that error?
> >
>
> Well, since the spi_flash is empty, the following code will
> print the error message and return.
>

flash =3D NULL;

  if (!flash) {
                printf("Failed to initialize SPI flash at %u:%u (error %d)\=
n",
                       bus, cs, ret);
                return 1;
  }

This code does not change error handling that is already present here.

Michael

> BR,
> Weizhao



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
