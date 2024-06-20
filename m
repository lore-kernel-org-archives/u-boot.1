Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABABC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 09:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA75788524;
	Thu, 20 Jun 2024 11:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EhL+N5og";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384E188527; Thu, 20 Jun 2024 11:50:50 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A37388851E
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 11:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6f1da33826so82490766b.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718877047; x=1719481847;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkFmK+sdT31yY0o5mHrLgm4FTfzmfZwwgSAzMlYg8YA=;
 b=EhL+N5oggWPLgW1B+JXKpQhBbvgEtTiyWI5xgB64R+RKprulyB001Q/X4+KLWwHPPK
 JfqiGj8AEYTpVjhAr1B904kWfVkcRHK+5rHoIXWGxBNmUp+HsuO9yL+of2BswrKm/CoA
 mcZEKWqU5WTySaZmJ1UQjDftrTuLRztzEBVyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877047; x=1719481847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkFmK+sdT31yY0o5mHrLgm4FTfzmfZwwgSAzMlYg8YA=;
 b=Efclk8WNWQWpgYffb2vP6Mc00aYAnyWt/E6+c0AAsllOankJCaXBryM472JXFMdeGI
 zWU/TNKuzgzXvU6yhuG0L3TlXZPAvQWAwVmorc3sgexm5N/jlmfJaiIZ9BpdeTodIS+K
 NUiCPGW8jeemLBZhylOw2qpirL16XqvWvBu3+jfqDCcyaQ3Km5Xu+NwboDtoZKfbaqUO
 qlQC119VTI4+ZQtLAIPoStXL9zH73sJP9SKQ3xIhGk0FnZK8ACfi6jHi8NDuLFdq8lBQ
 vKCPvmp8EKvXIeov1ZwFw++0g6/zn8tdZ7vH6l1hvJYpQlnO+cGWbxJh2fgLyNDS0hje
 naTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY2buHrXaNeMNLSh0dy2s8irU6oHoo2DpLjVN1Yx9YlV2nKftHVRRbdeHDPN+0H50YOPSsdwfL31U8++S1TLESpTARuw==
X-Gm-Message-State: AOJu0YxkyD9LE/PgH8/3+J0/FsqLCk+IXcSbIWpaQRwbETXiCIxkdW3e
 Xmc7av3GJlTyC5nxtrjBe87bDzUDN4X40zDDYR6aR7h8BUIMkJXRwMQSeRkwq80UYrz6haprKni
 pxoh2Foc2xwrFjBWiGJBxRnM9CLgoHY9OoRs7gA==
X-Google-Smtp-Source: AGHT+IH/6xtc8msJkdwwamD/otwZzMP2rxw6gpvjZJ4BUmbtZqHw+xvenv8BUqmNStC1nRzagh3pYy3FFFJjHa5m+KY=
X-Received: by 2002:a17:906:ba8a:b0:a6f:b885:2042 with SMTP id
 a640c23a62f3a-a6fb885212bmr316625366b.18.1718877045710; Thu, 20 Jun 2024
 02:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240619125310.94867-1-sumit.garg@linaro.org>
 <CAHCN7xK_39QTqRqjvmmnPQyx2atxw7ThoQYu5MB9LbHdeELfBg@mail.gmail.com>
 <CAFA6WYMJi-nVCEE7QoptHVURKpF-QoSh5XqSN14LrFSS5FAKrw@mail.gmail.com>
 <CAOf5uwmy6WsOTCD+mWfjLTrCBO=i8MqGm+mOe6jr+RfyXssjrw@mail.gmail.com>
 <CAFA6WYNcCu0FdpEN6_z3TmDqHSRnozQuUEwxZ6mWTOgdfSPd1w@mail.gmail.com>
In-Reply-To: <CAFA6WYNcCu0FdpEN6_z3TmDqHSRnozQuUEwxZ6mWTOgdfSPd1w@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 20 Jun 2024 11:50:33 +0200
Message-ID: <CAOf5uw=GuVGBMQOSDjPTbkBxA-vpAm9iAJmKmoFJnZ_-Pr-1nA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: imx: Drop redundant imports with dts/upstream
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de, 
 patrick.barsanti@amarulasolutions.com, trini@konsulko.com, festevam@denx.de, 
 peng.fan@nxp.com, sebastien.szymanski@armadeus.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org, afd@ti.com, bb@ti.com
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

Hi Sumit

On Thu, Jun 20, 2024 at 6:55=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 19 Jun 2024 at 18:51, Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi
> >
> > On Wed, Jun 19, 2024 at 3:07=E2=80=AFPM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > On Wed, 19 Jun 2024 at 18:26, Adam Ford <aford173@gmail.com> wrote:
> > > >
> > > > On Wed, Jun 19, 2024 at 7:53=E2=80=AFAM Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > >
> > > > > Drop redundant header imports with dts/upstream already providing
> > > > > updated headers which have been checked to be backwards compatibi=
lity.
> > > > >
> > > > > The imx headers which aren't present in dts/upstream are as follo=
ws:
> > > > >
> > > > > - include/dt-bindings/clock/imxrt1020-clock.h
> > > > > - include/dt-bindings/clock/imx8qm-clock.h
> > > > > - include/dt-bindings/clock/imxrt1170-clock.h
> > > > > - include/dt-bindings/clock/imx8qxp-clock.h
> > > > > - include/dt-bindings/memory/imxrt-sdram.h
> > > > > - include/dt-bindings/pinctrl/pads-imx8qxp.h
> > > > > - include/dt-bindings/pinctrl/pads-imx8qm.h
> > > > > - include/dt-bindings/soc/imx8_pd.h
> > > > > - include/dt-bindings/soc/imx_rsrc.h
> > > > >
> > > > > hence these aren't dropped yet but there was an unused header:
> > > > >
> > > > > - include/dt-bindings/pinctrl/pins-imx8mq.h
> > > > >
> > > > > which has been dropped as well. There shouldn't be any funtional =
impact
> > > > > with this change but it rather allows iMX platforms to use upstre=
am
> > > > > dt-bindings headers in a backwards compatible manner.
> > > >
> > > > Will this have any impact on board with -u-boot.dtsi files that mig=
ht
> > > > reference these files or will they point to the upstream path?
> > > >
> > >
> > > No it won't have any impact on existing boards, the headers would
> > > rather just be included from dts/upstream/include/dt-bindings/
> > > instead. The DT files would just be including headers the same way as
> > > before: #include <dt-bindings/foo/bar.h>. The world build is ongoing
> > > here [1] which should be able to justify it.
> > >
> > > [1] https://github.com/u-boot/u-boot/pull/587
> > >
> >
> > They will point to the upstream part but the fact it's that you can
> > test only that they compile ;).
>
> Majority of the headers removed have been compared to be identical and
> the rest headers have been checked to be DT ABI compatible with
> upstream counterparts. IMHO, that should be enough to believe the
> correctness of this patch. If you would like to manually review them
> or give this patch a try on a real iMX device then please feel free to
> do that.
>
> -Sumit

I would like to move this on. I prefer two step approach and fix
broken things and then maybe drop
legacy

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>



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
