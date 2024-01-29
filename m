Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFB3C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F98E87DCB;
	Mon, 29 Jan 2024 13:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="QAZ48KVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F79687274; Mon, 29 Jan 2024 12:41:47 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D1387C9B
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 12:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ole.orhagen@northern.tech
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5102b00c2cdso1699359e87.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1706528503; x=1707133303; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/yIipmjYkhKjz17HqwJgcSrcEqt+hovb0MbFYMutNSU=;
 b=QAZ48KVidFc/AdR6WNCjZK+CjKMM6BKDZ6kNPSKCQLz7QTM8Soa1aG1wT517gTPGpG
 SuilQ99HbHYpMf9hXSt8qTujF8c+XW8+1AvJwa8avw2vpbsm9HXfFmFoCXiWnCRb3lLO
 dC82kJ5mRG5zY0KGtU4CcWI0wQtLekyCVq8AE145rC/Gl42TT+OpWeX7JD7nRAGnLslA
 TbE3yNp4g5VauHF+Cc2kUDrG/CXutqOrpwCr+Zb8X1Pcg4rAXQF2gi3v2w3IfoB96kSN
 gm7iNCRgsxJ2GBIJXGK2lFMmr9VVpyy1XZ90m5BEOHjXBWyWe5GgEGLSw/dBJdk/fvUa
 XGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706528503; x=1707133303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yIipmjYkhKjz17HqwJgcSrcEqt+hovb0MbFYMutNSU=;
 b=iEC94sDy1+fcY1Mvwn0EZMRzEPmxbQK32EPmOek4SxXaEqvDHRHFNEs03eppK0QFyq
 Rka+BQtKg7uZrN/R6W7A516EszsGIlI27NyuAHHHrr69wdTf8jblSNKzSSBKfvNRnUv3
 EIH9qyByP6FZXKjeRLBk40i1nMMC06JdMMo/Pv7QZqjWiiwYFSc8mvhA1Bk/dkHV7rma
 R39dPnm21vsxY/+aBHPUpfvjyE6tzZ5y2lGigKbxf8loQzAxsW4Na6Bvx4Z4djw3lQJn
 G3NIy06ll9XB07wBvH/L74giHsfxzlZ48joUFveacEjkjR8eC2kB+w0GbkM0bQflwBT0
 441g==
X-Gm-Message-State: AOJu0Ywod6W17KLdELky2/wyE6IBEphcQ19C8PeniO/Ul5aZvBwqrQZ/
 9DuZ6LxP3TZi9u3hHKTg6Rj8FdMMS20qbe/Yjxau8dLYt4PL/9vzC2DuTDXUONjCGSOmtLHzda0
 6Jh6mHuw3MJzxaEEaPaB/LFU3ZkbbFheXzkpxFf4kextUvejC1IkOgNkupI7tDooKqn+SiX8391
 bT57kCKeLpvJNT81Y=
X-Google-Smtp-Source: AGHT+IH19DFA2J2vmVDTmj9OB1MwJkKOXqc78RQpup/7oTUe32WYaAT0y0nvm2or4D+LZxj858PKnGbgh3HgN3ecY4Q=
X-Received: by 2002:a05:6512:234c:b0:510:f97:c478 with SMTP id
 p12-20020a056512234c00b005100f97c478mr4048353lfu.44.1706528503424; Mon, 29
 Jan 2024 03:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
 <CACRpkdYLizF9Duy3ZCfqRsY-NMoLZJO8+TCyBHbQDqSOWuzonQ@mail.gmail.com>
In-Reply-To: <CACRpkdYLizF9Duy3ZCfqRsY-NMoLZJO8+TCyBHbQDqSOWuzonQ@mail.gmail.com>
From: Ole Orhagen <ole.orhagen@northern.tech>
Date: Mon, 29 Jan 2024 12:41:31 +0100
Message-ID: <CAD5A3Cuba_EchhDWBfej5HGHsP-T6smgL-L+C6SV_bONf6EqYA@mail.gmail.com>
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
To: Linus Walleij <linus.walleij@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Kristian Amlie <kristian.amlie@northern.tech>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patryk Biel <pbiel7@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailman-Approved-At: Mon, 29 Jan 2024 13:53:59 +0100
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

On Fri, Jan 26, 2024 at 8:57=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org>
wrote:

> On Fri, Jan 26, 2024 at 1:48=E2=80=AFPM Ole P. Orhagen
> <ole.orhagen@northern.tech> wrote:
>
> > This commit enables support for DM_SERIAL in the vexpress_ca9x4 boards.
> >
> > When running the board with the DM_SERIAL driver, the board ran out of
> > memory in SPL when initialising the DM serial driver.
> >
> > Thus this required an increase in the pre-allocated SRAM memory. I did
> > increase it to 0x800, and it now works graciously.
> >
> > It could probably be set lower, but I do not see any reason not to use
> the
> > available SRAM at this point.
> >
> > Also adds stdout-path to the 'chosen' node in the device tree.
> >
> > Signed-off-by: Ole P. Orhagen <ole.orhagen@northern.tech>
>
> Nice!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Are you using the actual hardware, or QEMU?
>

I only have QEMU available, unfortunately.


>
> > -       chosen { };
> > +       chosen {
> > +               stdout-path =3D &v2m_serial0;
> > +       };
>
> Can you please send this patch also to the Linux codebase.
>

Sure can!


>
> Yours,
> Linus Walleij
>


--=20
*Ole P. Orhagen*
Software Engineer | Mender <https://mender.io>
Oslo, Norway
<https://www.linkedin.com/company/northern.tech>
<https://twitter.com/northerntechhq> <https://northern.tech> Northern.tech
<https://northern.tech> | Securing the world's connected devices
