Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D142C369AB
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 03:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 671598056A;
	Fri, 25 Apr 2025 05:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PquAk/PC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2195780194; Fri, 25 Apr 2025 05:00:15 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36A6F80194
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 05:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3014678689aso1538670a91.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745550011; x=1746154811; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooE2qrjeJwoouvfIoC2apSl/yg/qiqmR6yRIFip+HlQ=;
 b=PquAk/PC3oVupDMCaGgBlmFY9MVw8nFmUFCEPXbZfEyCmWjJMJXbo5a22eMYpZ2J0v
 CS2ZBvGxkTyze2S2qTN5JDNKCenViq0tnB++t9JSpx9jdxwIS7V0hm1+b1F60JGAUXvI
 v70S7+Aeh1QED212m1+3V5uj6shIJXHiWeNFDb93p2zN8+NAXKtd8gvxsVjx5RRinnY8
 c7ooZPsZhcfYlSpeE2NOGIRY84N24Izt76irR+KvWlDqe2ABaw3AhWeUgeWG7kIJhrI6
 cKaIkRyIMCR8A8E7I5Cnd6qR1eYMypPE9hG2Q/0OJDL5uFyPJiIuoqzTAk1+Pd/7dPng
 52Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745550011; x=1746154811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooE2qrjeJwoouvfIoC2apSl/yg/qiqmR6yRIFip+HlQ=;
 b=TUvK2IkMC8+m/FfrmsArKxG53N1y6n0i1OaBy27chq3SHhyjtZiEFQHxpckW42w7Ef
 uyG4cv1uW8XGj6zffr8+erUZolUtSk9ZjJRoWwBBEAE9YE35uo+YZt8byBN1+NHSrxpb
 yMA2FCQz432ztgjjtRWEF8RI5+Zogkpah5TTiZ4CBKnNeXPxdrdbS9wXDZyvZ9L5X6cX
 IKjRSJF2EKnxa0xrb6UFrpNdJyfK7h8SZRWWWpjDrgxfbtybtzzasYrGo4yGLcGFfMmf
 cZciRcYePWH+t9M7vXUHu3b1JPmnScYv4qU3BADLwQ2gdcpVoNQ4pWL858q5wHp/Gtue
 +Zpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE6zGMQGy/HxfYuPWCuXSHrF+1EpPSKL6yNlb+wVwSoEh+CZUNMXTfIVARSzIz6AzHNWgK9kM=@lists.denx.de
X-Gm-Message-State: AOJu0YxvkltdQ2zRk0v3jCyyeiwL6PZBjoiJOUPEw1MQdB47TbEFgIUp
 +KZ64vevMy/FzJTnwIJ8Pmwgo80XqE61Fc2HaAHYN2D8q1NHoZ518JhPPBv6PtayZxt9cSFdIcc
 tw8GZWIfb0L+wWLG8Wl9VvcM2fIE=
X-Gm-Gg: ASbGncsHsa5eXjG/QBTnTKgxL3RA0lY/OYF0pI4kHuNn+u6ImzMqkbr4OBpYqJ4OOui
 4Y/jmBzkb0HJY2Aub2oQEPrUN5CjAMWI05uzIsMKN6jdS7hOof0z0whTD5glvC1Ub/fpTGU3ikE
 7cnTLOxroZbW6iTuwcNsEVoA==
X-Google-Smtp-Source: AGHT+IF9RgGInkfVQon2V+qOEJTwN89er3KwCqMF3V4I/X8//ZzG/1CGK4BIKuinCbD4/iT1nA0BMD21QUWZZ43ZwWU=
X-Received: by 2002:a17:90b:57c8:b0:2f7:4cce:ae37 with SMTP id
 98e67ed59e1d1-309f7dfdd99mr1423707a91.18.1745550010585; Thu, 24 Apr 2025
 20:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
 <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
 <703a0297-24b2-42f3-9fa7-62a78e38f1a2@denx.de>
 <CAOMZO5BitKDL2QRAzBuKK9rdfPsob_jdsYx86CRXJq8RjC8xoA@mail.gmail.com>
 <CAHCN7xK_6QdG91dC_FnZbvnZTONYKKt2qSeLb4ruORw4epG+0A@mail.gmail.com>
In-Reply-To: <CAHCN7xK_6QdG91dC_FnZbvnZTONYKKt2qSeLb4ruORw4epG+0A@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 24 Apr 2025 21:59:59 -0500
X-Gm-Features: ATxdqUE-dIiCDkJ1zOuobkh4rkZ3xRGWNH2aSZ-5TEi9XNtKyiF5wpbrrctu_fk
Message-ID: <CAHCN7xKERpu1woTG_3RW7uAweegGe_xPFOCKc+jBCoPnAGcziQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Apr 24, 2025 at 9:37=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Thu, Apr 24, 2025 at 9:35=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
> >
> > On Thu, Apr 24, 2025 at 11:20=E2=80=AFPM Marek Vasut <marex@denx.de> wr=
ote:
> >
> > > Probably some timeout in the esdhc driver, maybe some clock are not
> > > enabled ? I don't see it on the MX8MP.
> >
> > Same here. I didn't see this error on an imx8mp-evk.
>
> If memory serves, I thought SPL used the Boot ROM on Plus and Nano to
> load U-Boot where the Mini has an older boot ROM and required more
> driver initialization.
>
> I could be wrong.  I'll try to test my Mini this weekend.

I pulled my mini out.  With Marek's clk.diff file applied on top of
U-Boot next, it boots quickly without delay, and I don't get a PMIC
error.  I don't have an EVK at my home lab to test.


U-Boot SPL 2025.04-rc5-00835-g61128a5b704d-dirty (Apr 24 2025 - 21:53:22 -0=
500)
WDT:   Not starting watchdog@30280000
Trying to boot from MMC1
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.10.14(release):lts-v2.10.14-380-gd7da75fef
NOTICE:  BL31: Built : 20:12:47, Apr  3 2025


U-Boot 2025.04-rc5-00835-g61128a5b704d-dirty (Apr 24 2025 - 21:53:22 -0500)

CPU:   NXP i.MX8MMQ Rev1.0 A53 at 1200 MHz
CPU:   Industrial temperature grade (-40C to 105C) at 30C
Model: Beacon EmbeddedWorks i.MX8M Mini Development Kit
DRAM:  2 GiB
Core:  225 devices, 26 uclasses, devicetree: separate
WDT:   Not starting watchdog@30280000
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from MMC(2)... OK
In:    serial@30890000
Out:   serial@30890000
Err:   serial@30890000
SEC0:  RNG instantiated
Net:   eth0: ethernet@30be0000
Hit any key to stop autoboot:  0
u-boot=3D>



>
> adam
> >
> > >
> > > Did you already apply
> > > Re: [PATCH] clk: imx: Finish converting clock-osc-24 back to osc_24
> >
> > Yes, I applied this one locally, but it didn't make a difference.
> >
> > I haven't had a chance to debug this issue yet.
