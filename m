Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C5EE0206
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 16:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B11892D4;
	Wed, 11 Sep 2024 18:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qvUAyPeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00E6892D5; Wed, 11 Sep 2024 18:45:24 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85EA688F6F
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8a7b1c2f2bso6711366b.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726073122; x=1726677922;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAZ1aWT1fYKEwoNxPlQB8IN3mV4Hw3tYpacjXoBW5mk=;
 b=qvUAyPeCLwHDjQYb798RF+VQCPq/f2pFLWU/W2IqB+JdBlIzxQOx37KKFcmQVqRSib
 rWsDMAbgWEl7UzH3v4WV3P8Uj1q12zueKb4Zc8SmHC5yQFZd3SYQlkfwinK/p0EcLqz2
 BYdmAsJg12DFQnw5a87A+cVuavgi5BxB4UKF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073122; x=1726677922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WAZ1aWT1fYKEwoNxPlQB8IN3mV4Hw3tYpacjXoBW5mk=;
 b=psvQjLoA5Mv/hkqmyIioPHimAMCoJ8JPwK8qnlW0RRrrE44E7QWbzR2mqKJlAjn8yP
 a4sAee0i0nDoBq4Jfw53dQMdpJLqONfiOIbDijvAmv5DQ91b9vTxp9JQkaFcynJaQ1rc
 PAS4dpIEe2UTqlQMjQm7KUyfG4iNac+ogfWz/fQVMpFyidxMVkHTx2aDBLPnO6bzhkWY
 /rHGq/++zAEe4Ly1oz20goyYkrqtwGeTsoVV4vBerm1+5blCht3l9rg1rZo+AapTknP+
 x+nyMt2t1a/ekFHG68S4d1mKzWesO2tuwTTJbfdzyU6OGTZg05xzdMy7QdT4tSGoIdCH
 zmag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfd9cs1RrdqFNKNRF7S4BmfSf+YBy0dR/H5f/XUdE53z6aT+DkiKXVOQRSvVNRHgs+hyEB4WY=@lists.denx.de
X-Gm-Message-State: AOJu0YyxVMgNkBh0+OsP4Kao80TT2Tn5J6FtjOKxK/yulsv35NtDA0z+
 7DMlhBfyy/RhO59HjaAVc5sL3LFILKwm2tqCAm7DSK8/b3ZgVmvgE5qZSAaCZKjl83ZBrnKqTtI
 pNcKoZDVu9uDHhMBFHPsG7jeE4W1DizzDRpnnCQ==
X-Google-Smtp-Source: AGHT+IHqomZwciDvJqFr8np/nyHDyrcAuzFOkMlKM4iiTNXoOjGVYM51AfSasWRgiFP7TKtm8l87s3hQ+54uq+gTA+U=
X-Received: by 2002:a17:907:f1dd:b0:a8d:286f:7b46 with SMTP id
 a640c23a62f3a-a90295a213fmr8611766b.29.1726073121385; Wed, 11 Sep 2024
 09:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <CAOf5uwmzm=9=Vsu5cTbziyPG=KAqDGTcmrW0A36a2ix_+2WjNA@mail.gmail.com>
 <20240910145634.2ada70ad@xps-13>
In-Reply-To: <20240910145634.2ada70ad@xps-13>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 11 Sep 2024 18:45:08 +0200
Message-ID: <CAOf5uwm-CAbYCqFtx43Ynp23kVTvWM02qchuuwDHXE4=8NY48Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

Hi Miquel

On Tue, Sep 10, 2024 at 2:56=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Michael,
>
> michael@amarulasolutions.com wrote on Tue, 10 Sep 2024 12:30:42 +0200:
>
> > Hi Miquel
> >
> > On Tue, Sep 10, 2024 at 12:13=E2=80=AFPM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > In order to display a boot picture or an error message, the i.MX8MP
> > > display pipeline must be enabled. The SoC has support for various
> > > interfaces (LVDS, HDMI, DSI). The one supported in this series is the
> > > standard 4-lane LVDS output. The minimal setup is thus composed of:
> > > * An LCD InterFace (LCDIF) with an AXI/APB interface, generating a pi=
xel
> > >   stream
> > > * One LVDS Display Bridge (LDB), also named pixel mapper, which recei=
ves
> > >   the pixel stream and route it to one or two (possibly combined) LVD=
S
> > >   displays.
> > > * All necessary clocks and power controls coming from the MEDIAMIX
> > >   control block.
> > >
> > > Patch 1 adds a very useful helper to the core in order to grab device=
s
> > > through endpoints instead of being limited to phandles. Video pipelin=
es
> > > being often described using graphs endpoints, the introduced helper i=
s
> > > used several times in the serires (there are 3 LCDIF, one of them bei=
ng
> > > connected to the LDB, itself having 2 ports).
> > >
> > > Patch 2 is a fix which is necessary for this series to work properly,
> > > but is way broader than just this use case. In practice, when assigne=
d
> > > clocks are defined in the device tree, the clock uclass tries to assi=
gn
> > > the parents first and then sets them to the correct frequency. This o=
nly
> > > works if the parents have been enabled themselves. Otherwise we end-u=
p
> > > with a non-clocked parent. I believe this is not the intended behavio=
r
> > > in general, but more importantly on the i.MX8MP, there are "clock
> > > slices" which have pre-requisites in order to be modified and selecti=
ng
> > > an ungated parent is one of them.
> > >
> > > All the other patches progressively build support for the whole video
> > > pipeline. Regarding the LCDIF driver, there is already a similar driv=
er
> > > for older i.MX SoCs but I didn't manage to get it to work. It was
> > > written more than a decade ago while device-model, clocks and others
> > > were not yet generically supported. Thus, numerous ad-hoc solutions
> > > were implemented, which no longer fit today's requirements. I preferr=
ed
> > > to add a new "clean" driver instead of modifying the existing one
> > > because of the too high risk of breaking these platforms. Once proper
> > > clocks/power-domain descriptions will be added to them they might be
> > > converted (and tested) to work with the "new" implementation, but goi=
ng
> > > the opposite way felt drawback.
> > >
> >
> > Thank you for adding those patches. We are working on mipi support
> > here and some of the clock patches
> > are there too. I will try to look and rebase our patchset
> >
> > https://patchwork.amarulasolutions.com/patch/3401/
>
> Thanks for letting me know. Indeed there are a couple of conflicts.
> - My patch 2 can easily be replaced by your approach.
> - Regarding the power domain we had two different approaches, I
>   didn't look in details, but again one or the other seems fine, I
>   guess.
> - The LDB driver in my series is new.
> - Finally regarding the LCDIF changes, the approach taken on your
>   side follows the somewhat too ad-hoc logic and would probably benefit
>   from being migrated to the driver I propose, which does make use of
>   the (DM) clock, power domain and DT API. I am really happy with the
>   core helper I've added retrieving a device in front of a graph
>   endpoint, which makes the whole "get panel/bridge" approach much more
>   flexible and adapted to today's needs.
>

My idea is to work on top of your patches and try to migrate them and
cover conflicts.
What be helpful is to get some of our clock patches and include in
your series and then I will try
to move our work on it

Michael

> What is the status of your patchset? How shall we handle the conflicts?
>
> Thanks,
> Miqu=C3=A8l



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
