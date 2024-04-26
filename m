Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA932C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4BE8884D0;
	Fri, 26 Apr 2024 17:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="ZA261UvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E4188F35; Fri, 26 Apr 2024 17:56:44 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A5D9884D0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a556d22fa93so274315066b.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714147001; x=1714751801; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EM/KCg85UIEAd2LnjAKOep8nt6nG1sLIjHlOYVYy0sE=;
 b=ZA261UvKB1iHQWDchISg1Z/g6FQhWR9N1e4oTdELFHBogBfjuBC5ysSr2g8pCWl0r9
 fn+FE944i3h9mk5wVGZqPifje/Uv2xkFGjLXI2/zxVZ/tpbveOCrh2GJXOqTbRbLJJQc
 Q/2JA/jd/OK3NXy3AoKB87pv+v8tR8d9tJ16XMAcjL0x6IP/tJUqGgyZLL9PAUBb/mAh
 pSdFXaJ0WwDRTNegNW81fKdzvSaXZY2SnLjYLvuXlIxzuJt4Rx76kTXKwbrIjDYxjoZw
 c/iyCMxzaxB8X2pfY52+ANMJG4u7MhGgKBQnQ8N1J1ONcr7jKEYwuJd+GCmPMiEpQZe9
 ycYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714147001; x=1714751801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EM/KCg85UIEAd2LnjAKOep8nt6nG1sLIjHlOYVYy0sE=;
 b=YOmd3iEaNgP9FDa18PE+L20l7NBUMvm0E5ix4xFPW6cE6ebndtL4trEpdSxcHSUBn1
 zX24ItVV8WfLSqv/2RfOwgyKMU5oj7PsYq+1Pw88Gv2bkvgidof/ggH5s/zhCjnljJZO
 C1GxqgXvDfLjVsJaZBKaC1c++m8pmN87RgDMpDMmb/iAo32zsq9vLoMUuvlsdTcl9XTF
 pDY/DEQipydqUZ79G3jsMaCTXuyPItdN7mBt6n8pCzrY2eVF2QOvUB0TN+EMgmO4XPVL
 /1AE2tKu9zKd1X57NivgiBxdU7hY2vJrj4GIh0zYqeuH/Xr4OEec1t94JA5fwDLFfAmZ
 C+kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK0QOq04a1hQ7UXNRWx26jf9/98rM0dqX9l8Z/uwIsKB+h+F0bFxR0KJP3BfpMZVbHc5H/jnHgKBGfHwQwFgfiUzQ4pg==
X-Gm-Message-State: AOJu0YxcBWrlpyr/Z0FITrHe8hFOWThQKlOIcM+fkIoNkPFgizi3JjGH
 szHRAWqhN45OrLOI1JYJDhhWwDHuwjl9cHR4NGASOGtW9zmnV+VCTwDxcTvo64FXZrCOnoZ1Bbp
 GRg7sVJowAmY7e7j/l0ue4MON8acaE/rWpmOQrA==
X-Google-Smtp-Source: AGHT+IEbyzENzy+u59eRTqed/K4/UPEsRgY7j27Rrr2lEc+nJuY/aGmXrIohcDQlLCbWQ5v8zgF5t849Ip8n/5SoGqk=
X-Received: by 2002:a17:907:31c2:b0:a58:a721:3a61 with SMTP id
 xf2-20020a17090731c200b00a58a7213a61mr2540743ejb.3.1714147001538; Fri, 26 Apr
 2024 08:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240425230721.497441-1-marex@denx.de>
 <20240425230721.497441-2-marex@denx.de>
 <CAJ+vNU34Zrn8znALzZqsDnkWifhVbz3D4D_hyNurKzH0cn30Lw@mail.gmail.com>
 <20240426155113.GH1054907@bill-the-cat>
In-Reply-To: <20240426155113.GH1054907@bill-the-cat>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 26 Apr 2024 08:56:29 -0700
Message-ID: <CAJ+vNU3QHGxwLsYbNouV0x9G0qLnufDSHEUC5OLzT-zxE7dCiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx: hab: Use nxp_imx8mcst etype for i.MX8M flash.bin
 signing
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, kernel@puri.sm, u-boot@dh-electronics.com
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

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Apr 26, 2024 at 08:30:23AM -0700, Tim Harvey wrote:
> > On Thu, Apr 25, 2024 at 4:07=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> > >
> > > Update documentation and use nxp_imx8mcst binman etype for signing
> > > of flash.bin instead of previous horrible shell scripting.
> >
> > Hi Marek,
> >
> > To be completely fair we are just replacing a shell script and
> > template file with a python script
> > (tools/binman/etype/nxp_imx8mcst.py) which also creates the template
> > file.
> >
> > I could care less about shell vs python but do put huge value in the
> > idea of making signing easier and doing so without modification of
> > U-Boot code. The current implementation requires a couple of things to
> > be enabled in defconfig which can be done with a seperate
> > 'out-of-tree' defconfig but this new proposed implementation requires
> > changing a u-boot.dtsi which is a tracked file.
>
> A counter-point is that with using binman for signing we start
> eliminating differences between different semiconductors on how to get
> something signed.

Hi Tom,

I agree... I'm a huge fan of binman. I just don't want to replace
current constructs that use env and/or config items on a clean code
directory with replacements that require code diffs to do the same.

I'm simply wanting to wrap binman sections with Kconfig items. Is
there a way to use environment variables within binman sections (ie to
wrap sections or override filenames)?

Best Regards,

Tim
