Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75447C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D079F87FB6;
	Mon,  4 Mar 2024 16:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ClaIvo8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221F087FBC; Mon,  4 Mar 2024 16:45:44 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D665387E92
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5656e5754ccso5969248a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1709567141; x=1710171941;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4ZxDPpyltRUQ0TAUPbnAKRDzB35Unf+A0BQVJEL+Sc=;
 b=ClaIvo8zD9va4g4k3LCDPZAomQiipeBjlGSAL9laDwFC29y9I25eLzzq0eEsFDCOwC
 y4x4bJsBOz4irSyolcAi7WFueXXag0T+PWykne7NglpBHEBslCCI0dAznDQMtoCW8kH/
 3hpqY62jXGeBSFPlWiudcstwQOk2krPo2+snI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709567141; x=1710171941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4ZxDPpyltRUQ0TAUPbnAKRDzB35Unf+A0BQVJEL+Sc=;
 b=g+OaC189tJ3iJoYP+8TdCLpplL4MPURCUK1Ys4skoCHH6kpexZlVdmWVkhhPd1FNmQ
 33s55uRCv5tp14s2+4y4YgDrMsSydt4g8dnPqjd2e7AW5AlQ6b2dcnv6G2sdYWKSKK5u
 K/Nk1QunBFKpK++0WUFPUJsb9x9B4s9d3dYoUCx7hG0u1Lr60uUQA/omGMIHrs4+wr+V
 SuQZLpUhMeF2WyTkb2bsBFouAo/zNC4KLuXnfZNo78GTmZWhzXKF1cgkTmsCfROXD+7M
 FLIBPMM9woK4J6RWp4H3cFEkxw8d+VEm+Y29gjUdCbIu9KjVC05TMl8EZr8LTjp6XE2u
 toSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyqeC7DIRuQmS87HSpo53HPJK+RSZeLBmjgwigxAnDGkm4AGypvG0YmGCVjyitXJsurOqf2HVCGvtrg/mDQEYZnrz+Hg==
X-Gm-Message-State: AOJu0YwOUL504tIxo7rNAVGv6fdEAaLxA1bh09bb4wAEp2OEtxkGnY7l
 VL6PcnCzJgwATFOXmVJxPNcGVw/mlv+3caFyRFKnssoZz3+0eXScb+tZNZ9MLLsWAzQi2aHG/xt
 o+LFEDrSEgh8sqBR6s1vkKkK7tE0FMiYekZQqlQ==
X-Google-Smtp-Source: AGHT+IECJryRmc676DwIdeOFMlb0YaTqTlXaXJxOuI9BzXipMhjaufa42NmufDo6CjTzu1JuLVv7qJX6nn0IDm9SDak=
X-Received: by 2002:a17:906:c30c:b0:a45:31f5:9de5 with SMTP id
 s12-20020a170906c30c00b00a4531f59de5mr2564672ejz.33.1709567141211; Mon, 04
 Mar 2024 07:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20240104114619.280513-1-o451686892@gmail.com>
 <CAHk0Hov+uwanmDK9wh9ke6c2JX7TRw9_qsF9Vq+Hrs6rqFqD6Q@mail.gmail.com>
 <2e36991a-2a3c-46d8-bcbf-1c2c7a3d3a63@gmx.de>
In-Reply-To: <2e36991a-2a3c-46d8-bcbf-1c2c7a3d3a63@gmx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 4 Mar 2024 16:45:29 +0100
Message-ID: <CAOf5uwnOca7uzTJe8MLZ0xgY9ifW6XvK6MqbSDj8DaHWfQ7XsQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Weizhao Ouyang <o451686892@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
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

On Mon, Mar 4, 2024 at 4:44=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gmx=
.de> wrote:
>
> On 04.03.24 15:47, Weizhao Ouyang wrote:
> > Gentle ping. Not merged yet.
> >
> > BR,
> > Weizhao
>
> Hello Dario,
>
> that patch is in your patchwork review queue. Could you, please, have a
> look.

He is with me, I will ping about all the patches that we need to queue

Michael

>
> Best regards
>
> Heinrich
>
> >
> > On Thu, Jan 4, 2024 at 7:46=E2=80=AFPM Weizhao Ouyang <o451686892@gmail=
.com> wrote:
> >>
> >> Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
> >> crashes.
> >>
> >> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> >> ---
> >>   cmd/sf.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/cmd/sf.c b/cmd/sf.c
> >> index 730996c02b..e3866899f6 100644
> >> --- a/cmd/sf.c
> >> +++ b/cmd/sf.c
> >> @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *cons=
t argv[])
> >>          }
> >>          flash =3D NULL;
> >>          if (use_dt) {
> >> -               spi_flash_probe_bus_cs(bus, cs, &new);
> >> -               flash =3D dev_get_uclass_priv(new);
> >> +               ret =3D spi_flash_probe_bus_cs(bus, cs, &new);
> >> +               if (!ret)
> >> +                       flash =3D dev_get_uclass_priv(new);
> >>          } else {
> >>                  flash =3D spi_flash_probe(bus, cs, speed, mode);
> >>          }
> >> --
> >> 2.39.2
> >>
>


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
