Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04B6C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87B388120;
	Fri, 12 Apr 2024 15:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IGcEsDZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB3287E82; Fri, 12 Apr 2024 12:34:28 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065BE87E9D
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 12:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=noname.nuno@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so1082962f8f.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712918066; x=1713522866; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1b5lvzCkdwZfsYhuffDcMKb7DaA9r0ouxBD08Th7wec=;
 b=IGcEsDZu/v1GT7umrpQt2ouieWOndyL3v+8QRV8i4x+9g6SYUMspUciCUxqysOfXCu
 tJ0KNHYrg9J08a56RuHg84sqlO17Re0CZQcz9sQGWb/bw4SxR2J0Hdv7Z9afuQICfKU7
 yvTs3lWOM33iM0DdBPjeOATjSTFYZ+Qlgg7k1HEB6L3305GR2Zzc4bqG2/2FDCf4g8og
 C9jZBkY8jUsJzj0U4ZKegqMVTT82Gmbr+6lt4lFMEJH/Wm1fV7KHEj8sHcnzh1tMHc+R
 49K06eSp6DP/RifdtPttHUzbGHmLz1gkM4mjZu3om9gLRHtDfWULQK6aJGGOPsxTFGU1
 lNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712918066; x=1713522866;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1b5lvzCkdwZfsYhuffDcMKb7DaA9r0ouxBD08Th7wec=;
 b=oqV9RNh6k1mT3nbM7vpP6v6Oom5wAG02mYF+2S2PaUsN1C9//BqLxb7jruVsYNPAmz
 KOm77UHhk9er8aHeSdsIDRxTCKQqyVNdtVW0Z3hnn4FuAJWp6O4BsaWDDu5EcMHC0xM8
 fJcUfY8aiEyJLrCLpuhll4fI46CtdCFXhriIImO5yDJ5zBjSrMBYe2ZBPRhAYCppN2I7
 QU1OR70DuNrmGkxQziGGlm9I52hqycY3o6FR5FBmkgYzrqUPRdyuiym/B69xobyFpV4D
 O45bXjwuRXZaVC1buoa2PJbty1H0MGka8JhMFTznIADTAGy7HdEy4sSR46GngfWgOCkf
 f5DA==
X-Gm-Message-State: AOJu0YziCzDIr3bERSTTQpn3iQ9OMTIdNDXaZMFqFxwX1ZbgsUgmhMIM
 Yl1ItE6k8YAmWJPqWEebh/NClMghmbRUsXus/UvqhZVM6jJAjKyx
X-Google-Smtp-Source: AGHT+IEuIcks7LHjb+znAfpj2HoGgedEKIKROPCwKLIDkzNby1oSL5xhMdkDNmmfP6DNaSakYmT+pA==
X-Received: by 2002:adf:ee49:0:b0:343:8097:213d with SMTP id
 w9-20020adfee49000000b003438097213dmr4471155wro.20.1712918066160; 
 Fri, 12 Apr 2024 03:34:26 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01?
 ([2001:a61:343e:8301:d737:22b0:7431:8d01])
 by smtp.gmail.com with ESMTPSA id
 d27-20020adfa41b000000b003471f8ea4e1sm595012wra.74.2024.04.12.03.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 03:34:25 -0700 (PDT)
Message-ID: <88357ffaf8a3625656cb3c22c744de5ea943de0d.camel@gmail.com>
Subject: Re: [PATCH 0/3] arm: Add Analog Devices SC5xx Machine Type
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Greg Malysa <greg.malysa@timesys.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Matthew McClintock
 <Matthew.Mcclintock@analog.com>,  AKASHI Takahiro
 <takahiro.akashi@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Alexey Brodkin
 <alexey.brodkin@synopsys.com>, Alison Wang <alison.wang@nxp.com>, Alper
 Nebi Yasak <alpernebiyasak@gmail.com>, Andre Przywara
 <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, Andy Fleming
 <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>, Arturs
 Artamonovs <arturs.artamonovs@analog.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Linus Walleij
 <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, Mario Six
 <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <monstr@monstr.eu>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peter Robinson
 <pbrobinson@gmail.com>, Priyanka Jain <priyanka.jain@nxp.com>, Rayagonda
 Kokatanur <rayagonda.kokatanur@broadcom.com>, Sam Protsenko
 <semen.protsenko@linaro.org>,  Samuel Holland <samuel@sholland.org>, Scott
 McNutt <smcnutt@psyent.com>, Sean Anderson <seanga2@gmail.com>,  Simon
 Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>, Sumit Garg
 <sumit.garg@linaro.org>, Thomas Chou <thomas@wytron.com.tw>, Utsav Agarwal
 <utsav.agarwal@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>,  Wolfgang Denk <wd@denx.de>, Yang Xiwen
 <forbidden405@outlook.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Date: Fri, 12 Apr 2024 12:34:23 +0200
In-Reply-To: <CAAjXUaoPoD_pN3QU=rxN6x3uOHex3TYgwkZDA_YZdj-Z_nmxfw@mail.gmail.com>
References: <20240411234021.14534-1-greg.malysa@timesys.com>
 <20240411235250.GK2493117@bill-the-cat>
 <CAAjXUaoPoD_pN3QU=rxN6x3uOHex3TYgwkZDA_YZdj-Z_nmxfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 12 Apr 2024 15:29:37 +0200
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

On Thu, 2024-04-11 at 20:18 -0400, Greg Malysa wrote:
> I'm afraid I have to admit I don't know. I'll work with our IT team to
> make sure we can run CI locally, and when v2 comes around the answer
> will be yes.
>=20

AFAIR, I think you the only exception to open a PR in the github fork is to=
 run CI.

- Nuno S=C3=A1


