Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63248C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 23:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF4687BDD;
	Sat, 16 Dec 2023 00:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dRT1Shce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D81C87BF3; Sat, 16 Dec 2023 00:08:38 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820B087B72
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 00:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilles.talis@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c236624edso12547885e9.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702681716; x=1703286516; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L6v1cZsqJb7F/E28b7c44QZ7jsMedfMyluCl6HvdZiY=;
 b=dRT1ShceZgAdiH7IZW4qZDk6LaL74rxppKpyoKWduTQBRiN2Kmk6shzyquArS1Nxhl
 coELr20Y0oDMNsdgbZL//ZE9FhcEA/mYUWcwfp7XU8z/Q5P820ItzK3HUw9MM0R5V0YU
 c7EGWuTOUpEkY7o9m9RzZwafhp+9qK4U/T8awJe7kMLNeHj9BzU6tNg++PgnhhTsAHZv
 NKHGC9/7p43/SwbvXDQkg8FbKrNnaJJpGr4QYDz4KMWQo3MDpSiXHd/lydoImiAyoExn
 Sgi2u/NV/zBOxAV1z/A1NB6TEPmZSOvtIUEsMc/Dp81AbHBBF5ZrkMoBEWmn3tPLfwWz
 YkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702681716; x=1703286516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L6v1cZsqJb7F/E28b7c44QZ7jsMedfMyluCl6HvdZiY=;
 b=rdGPnjIQQ0etisBxQBe60PK2ExY1AMOLjsUeD/wjXeSDwYEle/I8aqJFAaNic/SSI4
 PpCZ0HbM3Af9iwlHKxcBHoNPoxIoiPS2ry72OYVbWoESHkXIr65DUg2mqFk44K+7354Y
 ijzk/BoOjiX/IYSqeUubHZRHLei4jI7TGGZrgTNVqOfImc9NHuWkmvVHELGTqtf7IEBo
 lgI2LRihOC78XmDCAV/WWrer1o4ihiVl3EdZ+Ts8tF0k3zhXbm9nd12WQKBlE4yOUIOA
 qVNQ3wLU9icneeDlYohfZId8IbP4zbNIwJftS1/X+e2z+1RhRlGa7yhbhcDPfORTwk2p
 RrMw==
X-Gm-Message-State: AOJu0YxuSOCc69XXkQSmzf2plFXs/6IIYJTkHtDOPeibRnprrc7lMjGO
 8DgMagnNWYvSFA8yyo3YiCI0SwUnNwmjbLuFKfQ=
X-Google-Smtp-Source: AGHT+IEYtG5W0wC7qcYTtiKpsgwop1AXdCz9Tmsulp4uQDe7fdfyFeGkmavJFUjJEho2kJuC/o9VGBEF2OcefMF8ni0=
X-Received: by 2002:a05:600c:4710:b0:40c:6b6c:6867 with SMTP id
 v16-20020a05600c471000b0040c6b6c6867mr810770wmo.178.1702681715542; Fri, 15
 Dec 2023 15:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com> <877clq6odx.fsf@redhat.com>
 <CAOMZO5C=N408U+dY+C-czBSGYMexmDeiUdyzwLkLjZcy7DtS1A@mail.gmail.com>
In-Reply-To: <CAOMZO5C=N408U+dY+C-czBSGYMexmDeiUdyzwLkLjZcy7DtS1A@mail.gmail.com>
From: Gilles Talis <gilles.talis@gmail.com>
Date: Fri, 15 Dec 2023 19:08:24 -0400
Message-ID: <CAKcgs2zM82tTucKSkxdLGDz5SmGFnMYuKGbw8V1ciOE4_GwMCg@mail.gmail.com>
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
To: Fabio Estevam <festevam@gmail.com>
Cc: Milan Zamazal <mzamazal@redhat.com>, Peng Fan <peng.fan@oss.nxp.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Milan,
Thanks for testing the patch! Glad that you could get it to work!

Hi Fabio,
Le mer. 13 d=C3=A9c. 2023 =C3=A0 12:22, Fabio Estevam <festevam@gmail.com> =
a =C3=A9crit :

> On Thu, Dec 7, 2023 at 2:15=E2=80=AFPM Milan Zamazal <mzamazal@redhat.com=
> wrote:
> >
> > Peng Fan <peng.fan@oss.nxp.com> writes:
> >
> > > On 5/24/2023 3:21 AM, Gilles Talis wrote:
> > >> Add support for the Polyhex Debix Model A SBC board.
> > >> It is an industrial grade single board computer based on
> > >> NXP's i.MX 8M Plus.
> > >> Currently supported interfaces are:
> > >> - Serial console
> > >> - Micro SD
> > >> - eQOS and FEC Ethernet
> > >> imx8mp-debix-model-a.dts is taken from Linux 6.3.
> > >> Signed-off-by: Gilles Talis<gilles.talis@gmail.com>
> > >
> > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >
> > Do you know why the patch has been left (as far as I can see) without
> > further action?
>
> Applied to u-boot-imx next, thanks.
>
Thanks for applying it !
Gilles.
