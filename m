Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8986CD11194
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 01:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FD7689043;
	Mon,  4 Nov 2024 02:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZHoxtUIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D48890F8; Mon,  4 Nov 2024 02:41:41 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA5988ED9
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 02:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so2767918a91.0
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 17:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730684496; x=1731289296; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPjpV4xSo3ifFgz4DtkgE9oeMDsI38inIN6g+uoVkbw=;
 b=ZHoxtUINTW8O1nYDhxdWCQrxnh38RbOzR0fmJn6ou58+CUI8/JgKEgVe+iBDDVE/tC
 NU6cLa4ITAEVH6IqgEqTEM7RTDjz5/jcR6Z87yfjubWIf6Tr+zPuP7wR0iQ9wHjcEBu+
 TdOf8fC9uBhkcII0BqR596s8iGJqvnAbN/OQQlT4DjYuCzXnRjgL4jDPPbIIGADBiCto
 xeNF9dThw7wq6WfCH9KAPIRJchVBh8o88iDNAmN+8+dU2LMp14GVZcL9MAQ/wWZ6cjbI
 VFPiOIV3B4BM/4DPvGVc1PoohkNFaiK6ZOW7RdICEfrUk27dZAFd/IjHJNXgMCwUUVQP
 ZquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730684496; x=1731289296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPjpV4xSo3ifFgz4DtkgE9oeMDsI38inIN6g+uoVkbw=;
 b=st7E3z/XA3k/5uTwv9sa/SM+4TKkbOPd/gGyDAv55316zlYl8aLJ4QgF3Qi4yOWnuD
 90G6d/ZE20OuO5GqgR0vva1lKTcGn//kOmS0y7uXHZgi/PXWEG9BRLCbo47Rmo7RUmvP
 M3HFpbStxzv26gthSQS98OruFX3HadXTUYRSjjuI6Z4wheNUSdxt+H8y6DlRDpoRgyn6
 toil5ReioUt+1ROjV5QdrwrXhdhnq0Fs+hN6W/571DvMzDdfQ8UMm1SZYcr6fV0LYCTi
 Q56aEMQG7znZ7UMRgiQlofzuVEvT7pHt+9pKhSs8hTTU4kFC6/iFtJE+QciOqlzD7hxB
 lPvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjS8DIzgI/HP6OS0czr6loyyf8K7RiXTw/i9UEEmZMXQDVOFz5CMSDDnVNuCfB7qrV6DUqs+U=@lists.denx.de
X-Gm-Message-State: AOJu0YyzfhiCygATBgMjeIT/nl8vXCwMv8pWDw98GXMTNu52Tjkl3N8I
 Q7NHXZwG8oqpxXnOpz4am76iNsQlyFO1Ia15w34BcdLG59Ru63MMYrso7ihxzsBcJjMXO4OSJ7n
 h1enAEOYXdnWvamH+bfgN7RnfxJ8=
X-Google-Smtp-Source: AGHT+IFJATa4C9Nrz2Gh1/ad7haRghg8+Ox7zzd0pR6x5mjy/7mDX40PsbCAjEd394K845Mv1fFDqixNOBdoFJDEvqU=
X-Received: by 2002:a17:90b:390b:b0:2e2:d3e9:eb33 with SMTP id
 98e67ed59e1d1-2e94c2b374cmr15927400a91.11.1730684496004; Sun, 03 Nov 2024
 17:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
In-Reply-To: <20240905155402.486a7110@wsk>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 3 Nov 2024 19:41:24 -0600
Message-ID: <CAHCN7x+jLfzMGFUcbAfHr9u_2s3Z=LxN-TNCtbzUUop66p4Rpw@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Lukasz Majewski <lukma@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>
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

On Thu, Sep 5, 2024 at 8:54=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:
>
> Hi Adam,
>
> > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@denx.de>=
 wrote:
> > >
> > > Hi Simon,
> > >
> > > > Hi,
> > > >
> > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam <festevam@gmail.com>
> > > > wrote:
> > > > >
> > > > > Hi Lukasz,
> > > > >
> > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski <lukma@de=
nx.de>
> > > > > wrote:
> > > > > > Unfortunately not - this change is only for properly setting
> > > > > > start address of the u-boot.
> > > > > >
> > > > > > The _real_ problem here is the symbol placement generated by
> > > > > > binman when we try to define the image as a single one.
> > > > > >
> > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to be
> > > > > > specific.
> > > > > >
> > > > > > The "fix" (for which I'd been now probably opt) for this issue
> > > > > > would be to generate two images with binman - one for
> > > > > > u-boot-spl-ddr.bin and the final flash.bin with the former one
> > > > > > included (as it was before SHA1:
> > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc)
> > > > >
> > > > > Is QSPI boot broken on i.MX8MM?
> > > > >
> > > > > I am adding Adam and Mamta who have tested QSPI booting on
> > > > > imx8mm_beacon and imx8mm_evk, respectively.
> > > >
> > > > Note also that I sent a series[1] which allows the symbols-base
> > > > to be adjusted, if that helps.
> > >
> > > I've seen them - but not yet tested.
> > >
> > > Thanks Simon for the patch series.
> >
> > Is it still broken with this patch series?  I have been traveling and
> > haven't had much time to test.
>
> Yes, I can confirm that it is still broken.

Sorry for the delay.  I had to return my 8MM to Beacon, and I was
waiting for a replacement.

To not prolong it anymore, I decided to try it with an 8M Nano, and I
got a boot failure on master. I was able to successfully boot
2024.01-rc5, but I haven't had time to bisect it yet.  I'll try to do
that this week.  I think once we can bisect the error, it might become
more apparent.

adam

>
> I've applied:
> https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.426387-1-=
sjg@chromium.org/
>
> on top of mainline:
> SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
>
> Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help.
>
> >
> > adam
> > >
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > [1]
> > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D421010
> > >
> > >
> > >
> > >
> > > Best regards,
> > >
> > > Lukasz Majewski
> > >
> > > --
> > >
> > > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > > lukma@denx.de
>
>
>
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
