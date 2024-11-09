Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7209D64076
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 01:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27FA488F3C;
	Sat,  9 Nov 2024 02:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qtx+dCJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F920892D5; Sat,  9 Nov 2024 02:04:16 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB6E88F12
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 02:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20cbca51687so28060935ad.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 17:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731114252; x=1731719052; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9wABPc/8SJmPSJeSemXP6ftMH12kTDUWfu7SaxnG5o=;
 b=Qtx+dCJIp/IfqMm9NVwHIgUTyxMYvCSRQveyQRnvqC9ucL4AYfcSB0hYTjT8rqZbra
 IpaNbGYPW2ZTJXyykfPW0rAvFTvvmOXmDT9CfZ733J50DZEZANbINH4MEVdACRtK5Gbp
 t+9YKp1XRzUrTe8PSeDRImxCO2mAD8QRy86FZxn943ahGqt1l9BSwGHLm3VmzfmIq52K
 4sWC8ERnY0hExcgMTKl7WCHlRgR34f0lmwXNw6e3TE1hjchFpbdiP13ynRO08TbgLf/a
 /UvCFlElBMDmQQG1HrE2l6BnfZuJhdD0QAEw3yNy8XNVnB02NcLfevzLyL6DW/Vq9NQJ
 7EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731114252; x=1731719052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9wABPc/8SJmPSJeSemXP6ftMH12kTDUWfu7SaxnG5o=;
 b=A+SAJf6fD3KFSI6a78QoJL6zOyEPFlv/4rxcIMyQqi+TK2Nr0F08C++UYQih8pP57/
 SphVq8xYlZ+bQ6EKs1IsqR1NMya8eXRaalZi91iUk2y72El/IpJpiKGH4jdLsbiHs0CQ
 TgYby4zjuq24wDD7oTt4htLdCtlKURupmUzYhCHeMiIizPK4arkXJaq1JRFEjfzi+C1A
 9Q+Ey4OANx/J33hHO4OtqIijc7FNU7Ntd/K1tS+MnK2R+d7VP1EQUYqmsgV/ZBdNmomi
 ozns+bbSqmrgC1/EIMsICJAdF6dbETAkARczFyUgIFro1ZNqINSOL8kZGRYpoSbE1PMh
 AN2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyI5weZ5tdjBmUtt+swjHIoShFj4/GOGI0lNN9F2c4s+sDM0ifWaotlyd7YEkmqWf7iQYHBfU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4TCYRzFIYkJr+WfAKXu/mxkCmNWkfatTqNnlTzULSi5kjP7Yf
 eWfDuFPwf4MyJWVa+Zv7PgzvZ/04Xxo4RuY18pglBPjvuwnJ6vQEAvcoDPNj2CNHISvzpFsEwLK
 dgskVIvuvPwO9DYA2bpoYhQfGXeo=
X-Google-Smtp-Source: AGHT+IHoVYSlLv3yp6HdD0e9JMfUMqcjpgq6Mzz4G67sOBLX6KvJ3QBvt1eHOB/tyw2nKAZ7y/zhNdssUT2Xa/SH6D8=
X-Received: by 2002:a17:902:db09:b0:20c:8331:cb6e with SMTP id
 d9443c01a7336-2118350cf44mr61167025ad.19.1731114252123; Fri, 08 Nov 2024
 17:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
 <CAHCN7x+jLfzMGFUcbAfHr9u_2s3Z=LxN-TNCtbzUUop66p4Rpw@mail.gmail.com>
 <CAHCN7xK3-iUUGf20-JxAWfK05-te=sskbdpU4kU8ahy8sfROFg@mail.gmail.com>
 <20241104091418.74acd1f1@wsk>
In-Reply-To: <20241104091418.74acd1f1@wsk>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 8 Nov 2024 19:04:00 -0600
Message-ID: <CAHCN7xKGW2+_8P0nnMM6gyJVPQOw15S2pFUhwwuv13JVqY3qNA@mail.gmail.com>
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

On Mon, Nov 4, 2024 at 2:14=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:
>
> Hi Adam,
>
> > On Sun, Nov 3, 2024 at 7:41=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> > >
> > > On Thu, Sep 5, 2024 at 8:54=E2=80=AFAM Lukasz Majewski <lukma@denx.de=
>
> > > wrote:
> > > >
> > > > Hi Adam,
> > > >
> > > > > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@de=
nx.de>
> > > > > wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam
> > > > > > > <festevam@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Lukasz,
> > > > > > > >
> > > > > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski
> > > > > > > > <lukma@denx.de> wrote:
> > > > > > > > > Unfortunately not - this change is only for properly
> > > > > > > > > setting start address of the u-boot.
> > > > > > > > >
> > > > > > > > > The _real_ problem here is the symbol placement
> > > > > > > > > generated by binman when we try to define the image as
> > > > > > > > > a single one.
> > > > > > > > >
> > > > > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to be
> > > > > > > > > specific.
> > > > > > > > >
> > > > > > > > > The "fix" (for which I'd been now probably opt) for
> > > > > > > > > this issue would be to generate two images with binman
> > > > > > > > > - one for u-boot-spl-ddr.bin and the final flash.bin
> > > > > > > > > with the former one included (as it was before SHA1:
> > > > > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc)
> > > > > > > >
> > > > > > > > Is QSPI boot broken on i.MX8MM?
> > > > > > > >
> > > > > > > > I am adding Adam and Mamta who have tested QSPI booting on
> > > > > > > > imx8mm_beacon and imx8mm_evk, respectively.
> > > > > > >
> > > > > > > Note also that I sent a series[1] which allows the
> > > > > > > symbols-base to be adjusted, if that helps.
> > > > > >
> > > > > > I've seen them - but not yet tested.
> > > > > >
> > > > > > Thanks Simon for the patch series.
> > > > >
> > > > > Is it still broken with this patch series?  I have been
> > > > > traveling and haven't had much time to test.
> > > >
> > > > Yes, I can confirm that it is still broken.
> > >
> > > Sorry for the delay.  I had to return my 8MM to Beacon, and I was
> > > waiting for a replacement.
> > >
> > > To not prolong it anymore, I decided to try it with an 8M Nano, and
> > > I got a boot failure on master. I was able to successfully boot
> > > 2024.01-rc5, but I haven't had time to bisect it yet.  I'll try to
> > > do that this week.  I think once we can bisect the error, it might
> > > become more apparent.
> >
> > Git bisect narrowed down the git which broke the build:
> >
> > commit 37e50627efacd8dae18b564e9d8886a033e181bc (HEAD)
> > Author: Marek Vasut <marex@denx.de>
> > Date:   Fri Apr 26 01:00:37 2024 +0200
> >
> >     ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman
> >
> > I am guessing the binman isn't prepending the header stuff.  I'll try
> > to investigate it this week.
>
> This is the problem with adjustments.
>
> I've prepared following fixes for it (but are not upstreamable):
> https://github.com/lmajewski/u-boot/commits/phycore-imx8mm-qspi-nvme
>
> (problem is with wrong offsets assigned -> 0x1000 switch)
>
> Unfortunately, I don't have the HW any more at hand.

I think we should try to generate two binaries.  The original
flash.bin file with the references to the FSPI stuff removed and the
offsets left as if FSPI booting doesn't exist, then a second binary
which adds the FSPI header at 0x400 and append the original flash.bin
file (build for sd booting) moved to offset 0x1000.

I manually created a binary like this using DD and it worked, but
building the image with the various offsets in the device tree appears
to break both SPL and U-Boot phases.

I tried to create a second file node to do this, but I don't
understand the binman stuff enough to have been successful.  I have
only tried the Nano, but I will test a Mini as soon as I can get my
hands on one again.


adam
>
> >
> > adam
> >
> > >
> > > adam
> > >
> > > >
> > > > I've applied:
> > > > https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.426=
387-1-sjg@chromium.org/
> > > >
> > > > on top of mainline:
> > > > SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> > > >
> > > > Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help.
> > > >
> > > > >
> > > > > adam
> > > > > >
> > > > > > >
> > > > > > > Regards,
> > > > > > > Simon
> > > > > > >
> > > > > > > [1]
> > > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D421=
010
> > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > Best regards,
> > > > > >
> > > > > > Lukasz Majewski
> > > > > >
> > > > > > --
> > > > > >
> > > > > > DENX Software Engineering GmbH,      Managing Director: Erika
> > > > > > Unter HRB 165235 Munich, Office: Kirchenstr.5, D-82194
> > > > > > Groebenzell, Germany Phone: (+49)-8142-66989-59 Fax:
> > > > > > (+49)-8142-66989-80 Email: lukma@denx.de
> > > >
> > > >
> > > >
> > > >
> > > > Best regards,
> > > >
> > > > Lukasz Majewski
> > > >
> > > > --
> > > >
> > > > DENX Software Engineering GmbH,      Managing Director: Erika
> > > > Unter HRB 165235 Munich, Office: Kirchenstr.5, D-82194
> > > > Groebenzell, Germany Phone: (+49)-8142-66989-59 Fax:
> > > > (+49)-8142-66989-80 Email: lukma@denx.de
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
