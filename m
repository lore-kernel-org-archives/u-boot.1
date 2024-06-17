Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB63C27C77
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D6D87D14;
	Mon, 17 Jun 2024 10:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QkO+iNoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3073588131; Mon, 17 Jun 2024 10:27:53 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A48F0878ED
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57c7681ccf3so4693038a12.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718612870; x=1719217670;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCS0UBeBTAks7eLkg0XuFCssJMgL5g05nDpW6ApYrEE=;
 b=QkO+iNoFurZzu1pYEhhqJSJUPn9pi22H0UP/LforNM1Vq6js7iHc9TcTPz/1HeJR2e
 HN6Hx2IsQS2v4Lb9mBaXaAauZhmJIm2n8qD5qaINR/7coh1Q84yD+lwIDpVcM57LisM6
 YIWNiAImsoY5g9MS/c4Tkx9Z/BYAnyspxxnM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718612870; x=1719217670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCS0UBeBTAks7eLkg0XuFCssJMgL5g05nDpW6ApYrEE=;
 b=BOXuQhbxZekLDUgg2q46tWriWNCQa92iM1n9ZnJGq72r1ecCVHPXzKrl9TMYQOw+pw
 vyz3G1K15OquSsrVqIjmeT41e3ibCP558/KyT37cgCfKeykVsb+Vv4mxbsp1zwatpZG5
 g47Vo0UnXOwamR51cnEZeSaxSLX8YAxjSfQt9OBeikftfzRUvf8HLfqn0JnVSdLWeLel
 YN6+dti4/fJONgjVM5rpxOD3bRbL7nQ4oeW9ZrD3CLet+8g1tnUvmoj74xaAyD/FpchA
 zPnnBaMSfGvrXmzUT8Bz/kb0bGDBit3kvqHmsRNP7lU6LBw40HrzvaGZk472Swm6BP6P
 60aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoNT/f+K3FoO1nlcnqQVBj3xhIZfiLu/ddXg7QP7g+gM8FHJObcPyT2qCWZg/YAtGp9fhlx0Uv7Xyc4KiSttZ2TW5uKA==
X-Gm-Message-State: AOJu0YwIFp7BQIeWoj6/5Rpr2UVV5t4YDPEJv7NZSKGxcVXFfmkpWNax
 IY6PIL6QfDYSPX7kPfJwvQWrW131dbnw5bxF+DL+tSkdBChQMjQLCQfNqfoLOuEbkCDCnCUbXKf
 3sMFb/XQ8543UJv5OEcAam/J3erW5jWTvwt8JzA==
X-Google-Smtp-Source: AGHT+IFbsYKldhMJetrwjKqbd3whfQsiaQZS2CrHwj8tm1nXFdck3nIY7JyeOvXVg+8FH1du74gNO0UmKt+fMpExha8=
X-Received: by 2002:a50:ccc5:0:b0:57c:dbf6:931f with SMTP id
 4fb4d7f45d1cf-57cdbf694e3mr2146401a12.5.1718612869928; Mon, 17 Jun 2024
 01:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
 <CAFA6WYPB17=YNabDyGTqo3p=uYD=Vy+Ec2P2VepXT6P+75f+VQ@mail.gmail.com>
 <CAOf5uwneUKJXJqgBMOQHs+d8-GQ6nr+vBAZ4ek2au1kngs8mXA@mail.gmail.com>
 <CAFA6WYNt0-KBpYjo0eQM20s-eD4gRvkgT7WxoxvHgd6URTXGrg@mail.gmail.com>
In-Reply-To: <CAFA6WYNt0-KBpYjo0eQM20s-eD4gRvkgT7WxoxvHgd6URTXGrg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 17 Jun 2024 10:27:38 +0200
Message-ID: <CAOf5uw=Uh6SRSo5LZ4xZxw5R+vh+8Cj3GjhMeuYmq20NgdFC7w@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 u-boot@lists.denx.de, 
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, 
 marek.vasut+renesas@mailbox.org, afd@ti.com, bb@ti.com, 
 mr.bossman075@gmail.com, leon@georgemail.eu
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

HI Sumit

On Mon, Jun 17, 2024 at 10:22=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Hi Michael,
>
> Sorry for the delayed response as I had some health issues last week.
>

We are not in a hurry and I think discussion has his own time. Glad that yo=
u are
getting better

> On Thu, 13 Jun 2024 at 12:44, Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi Sumit
> >
> > On Thu, Jun 13, 2024 at 9:02=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > On Mon, 3 Jun 2024 at 20:38, Patrick Barsanti
> > > <patrick.barsanti@amarulasolutions.com> wrote:
> > > >
> > > > Always prioritizing u-boot includes causes problems when trying to =
migrate
> > > > boards to OF_UPSTREAM that have different local devicetree files wi=
th
> > > > respect to the upstream ones, if local DT headers are not dropped.
> > > > At the same time if local and upstream files are the same, migratio=
ns
> > > > can be, and have been, introduced without dropping local DT headers=
.
> > > > This also causes problems whenever upstream DTS and DT headers are =
patched.
> > > >
> > > > For example, now migrating a board based on `imx6ul.dtsi` to OF_UPS=
TREAM
> > > > breaks it, as there are some missing defines in a local DT header f=
ile
> > > > (`imx6ul-clock.h`); the solution would be to drop it, which has not=
 always
> > > > been done in previous OF_UPSTREAM migration patches for other board=
s
> > > > because most of the time the two are the same. This solution is als=
o
> > > > vulnerable to ABI breakage, although this has not yet happened sinc=
e the
> > > > introduction of OF_UPSTREAM support and is unlikely.
> > > >
> > > > Maintainers assure backwards compatibility for DT headers when sync=
ing the
> > > > upstream folder with the kernel.
> > > > The problem is that, at the current state, all boards that have not=
 dropped
> > > > their local headers when migrating to OF_UPSTREAM will break once t=
he
> > > > upstream devicetrees are patched, for example, to use any newly add=
ed
> > > > define which is not present in the local DT header file, even if th=
ose
> > > > changes are backwards compatible.
> > > >
> > > > This patch fixes these problems by prioritizing upstream includes w=
hen
> > > > `CONFIG_OF_UPSTREAM=3Dy`, while keeping current prioritization when=
 it is
> > > > not.
> > > >
> > > > Also in case of ABI breakage in the kernel, keeping redundant heade=
r files
> > > > (only until strictly necessary, e.g. until all boards including the=
m have
> > > > been migrated to OF_UPSTREAM) together with this selective prioriti=
zation
> > > > of the include folder is a solution for keeping not-yet-migrated bo=
ards
> > > > from breaking.
> > >
> > > Let's just not try to make assumptions about DT ABI breakage due to
> > > using upstream headers for not-yet-migrated boards but rather talk
> > > about some real world examples. Have you come across any DT ABI
> > > breakage with usage of upstream headers? The breakage you have
> > > reported is due to usage of an old local copy of DT header.
> > >
> >
> > The include priority is broken, and this a Makefile problem anyway.
> > This patch fix
> > anyway includes priorities.
>
> The include priority only becomes an issue if you want to keep
> redundant local copies of DT headers. And I have been advocating to
> drop local copies from U-Boot as much as possible. Once we only have
> upstream DT headers being used (Qcom platforms can be a good example
> here), we don't need to care about trickier priorities.

Yes but this is the case. All we build now can include the local
redundant copy and we can
not guarantee that already board builds are built using the latest
version of the include.

>
> > The imx6 board migration for us does not work
>
> Patrick did mention here [1] that dropping
> include/dt-bindings/clock/imx6ul-clock.h fixes the problem...
>

Yes but suppose that the include was ok in the sense of compilation
but not consistent
in term of functionality. When you build using upstream headers you
must use them
to be consistent and it's not as it is for now. Anyway we can not drop
for one board upstream
that file, unless we force everyone to have broken board or all upstream no=
w

> >
> > > However, if this patch is only needed to address fear of DT ABI
> > > breakage (which hasn't happened in the past) then I can live with it
> > > such that it can help convince more people for OF_UPSTREAM migration.
> > > We can drop local DT headers as and when people feel comfortable with
> > > upstream.
> >
> > It's not abi breakage only but path inclusion order.
>
> ...however it's the ABI breakage part that worries Patrick. So if this
> patch only solves that worry then I can live with it in the hope that
> people will start to gain confidence in DT ABI stability.
>
> [1] https://lore.kernel.org/u-boot/CABxfhNfWdD0NjPNskaxZxDTg9pDoDx5vBHrN9=
chvMh5Xo_7Kzg@mail.gmail.com/
>
> -Sumit

Michael
