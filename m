Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57EFEE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30AAA88D88;
	Thu, 12 Sep 2024 03:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GWZjmPpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B5088D88; Thu, 12 Sep 2024 03:12:04 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A719E88CA0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so299594a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726103520; x=1726708320; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FySthSbjDiP2UHo+9RbJqWTXH2mdOGRmH5WCGHXNI+A=;
 b=GWZjmPpgzTg+nH1wV6OF+yoRL21SDEyyF0RXdC6ML7raZhe5FlYx38ZkAVAwyuUjfI
 VZH4dCTgn3rJMEwH3AghGJplRe48RKFu/CpEA73ZEoP8yBfqF5HBF63YzOGMgj7WjFDl
 nIXUswatnJggnVH8LYflqRPMFIRxAsPiG6NzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726103520; x=1726708320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FySthSbjDiP2UHo+9RbJqWTXH2mdOGRmH5WCGHXNI+A=;
 b=cwsZl6fPYbDq/yYB8TAXT7eB28EzQvbXjEFd3F9E1SkXdHJiHWpaUXQ/48jkMReW+j
 pnWNXV/5feOBkQthqeECm1n8GLzBjKWuSfcDnW8rOo+K8W4zsgkmrLcx2pgNSyF8pmkn
 yokgtx3Jg4Ggo6mV7haReNmKj8+XBX0uvzQjcbbxf5c26d8EGdss7SkSro5lSGtvIosu
 F7W4jUe545n43kT3e7Mc1i3VscU4PcuXP9iqEZrxeNzE14I3m2nzvh4/RAYyTPNSodYg
 jQPQJBSyplGZiPxAURDXda2y7e1gS25A/3YgL+TVow+AdVMenAFIwsNnPAj3IIG3USTa
 jKkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg7VPlnHuuTg62thd7a7rrUmLOyqYorwm0ebceiO1PqjVzUT7stJB3wbuvef0CfqF/pq3eQ1Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/d0jOrrxtYe5XNb7Jq82aUOqdqpJCiX8yIMOLxsDs9fFafUc5
 nnuegR78Qw3CtqhU6LO9NICxmLC3VNViHT+Yjfq/TVO2leUCtMKmNtVzKTWUTbQEOoi3qFru3Ek
 vzzXA3ZKQz0+moTBpSDgqOxIhq+ja26K4A5aV3ktLQvl6Yek=
X-Google-Smtp-Source: AGHT+IEM47uEBSJmuVUBwrk+ay0Z7XZGXd8G3SVsZ4RyGNblvnROJpRFAcEjfIvq4dS5x+pI7srShL+YKLlTYYuc+Vc=
X-Received: by 2002:a05:6a21:7108:b0:1cf:2095:65e4 with SMTP id
 adf61e73a8af0-1cf761e5523mr1413824637.37.1726103519676; Wed, 11 Sep 2024
 18:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
 <CAFLszTh65OkyXnG3L7XTJFK69EYdj4DZwYGxizu4877n-mCw-w@mail.gmail.com>
 <20240906095459.5565fe29@wsk>
In-Reply-To: <20240906095459.5565fe29@wsk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:11:48 -0600
Message-ID: <CAFLszTi4pC9TrkB6hNcC1Vn493MkmC_PCn7m+Ajg=0Mrw_Ga9A@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Lukasz Majewski <lukma@denx.de>
Cc: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
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

Hi ,

On Fri, 6 Sept 2024 at 01:55, Lukasz Majewski <lukma@denx.de> wrote:
>
> Hi Simon,
>
> > Hi Lukasz,
> >
> > On Thu, 5 Sept 2024 at 07:54, Lukasz Majewski <lukma@denx.de> wrote:
> > >
> > > Hi Adam,
> > >
> > > > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@denx=
.de>
> > > > wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam
> > > > > > <festevam@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Lukasz,
> > > > > > >
> > > > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski
> > > > > > > <lukma@denx.de> wrote:
> > > > > > > > Unfortunately not - this change is only for properly
> > > > > > > > setting start address of the u-boot.
> > > > > > > >
> > > > > > > > The _real_ problem here is the symbol placement generated
> > > > > > > > by binman when we try to define the image as a single one.
> > > > > > > >
> > > > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to be
> > > > > > > > specific.
> > > > > > > >
> > > > > > > > The "fix" (for which I'd been now probably opt) for this
> > > > > > > > issue would be to generate two images with binman - one
> > > > > > > > for u-boot-spl-ddr.bin and the final flash.bin with the
> > > > > > > > former one included (as it was before SHA1:
> > > > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc)
> > > > > > >
> > > > > > > Is QSPI boot broken on i.MX8MM?
> > > > > > >
> > > > > > > I am adding Adam and Mamta who have tested QSPI booting on
> > > > > > > imx8mm_beacon and imx8mm_evk, respectively.
> > > > > >
> > > > > > Note also that I sent a series[1] which allows the
> > > > > > symbols-base to be adjusted, if that helps.
> > > > >
> > > > > I've seen them - but not yet tested.
> > > > >
> > > > > Thanks Simon for the patch series.
> > > >
> > > > Is it still broken with this patch series?  I have been traveling
> > > > and haven't had much time to test.
> > >
> > > Yes, I can confirm that it is still broken.
> > >
> > > I've applied:
> > > https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.42638=
7-1-sjg@chromium.org/
> > >
> > > on top of mainline:
> > > SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> > >
> > > Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help.
> >
> > Can you please point me to the tree?
>
> https://github.com/lmajewski/u-boot/commits/imx8mm-test-qspi-boot-binman-=
patches
>
> > I suspect that the symbols-base
> > is already 0, so setting it to 0 has no effect. I'm not sure though,
> >
>
> Ach... I see.
>
> Please correct me if I'm wrong, but isn't the "symbols-base" an
> absolute address?
>
> This is my impression from the descripion.
>
> However, in my case - I would need the "relative" modification - please
> see the required "hack":
> https://github.com/lmajewski/u-boot/commit/07c0057fcfd242fa791767aaf0ac75=
2d3d0545f7

From the mailing list it seems you found a solution?

>
>
> > Regards,
> > Simon
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

Regards,
Simon
