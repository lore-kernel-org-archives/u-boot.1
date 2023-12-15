Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85482C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 19:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE0987C45;
	Fri, 15 Dec 2023 20:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hkejJP3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1F487C51; Fri, 15 Dec 2023 20:06:31 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCB787C43
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 20:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5c664652339so687323a12.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702667188; x=1703271988; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdS/Aohjqh7Rn8HxlTxDSvWJJg/MqvJ2Z8PfQcPXNso=;
 b=hkejJP3p6oklCb7WPC2rlFVx3u3L/CspmpRYdb2kd0V8y63uNw6+RNXcYcxSLgUffm
 IqbQyjuqMne05iO6epxDb75PJXaU6vx3VdPklGd7uklgoHnpvhVVAVPnGjp361vJCpvI
 GDemxYokUzQhFofbVTk89MDIcW9JhU0LB7KUoS3eSmGWM6QZBjqu5SMWvC5nmyQg0aij
 W35sGwV7EKcT3EgBYtmp6tMlwtpALJNLBDA9rVLuPJagqP/fQhvoKGsi3WczuCC9Be1R
 7yE8xoqDqt7TdhiFEAKb08xZCnECrmlDApY18IPzBMM6u8mNk1s9ZRZ3pt7ZMCT7ejua
 xFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702667188; x=1703271988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WdS/Aohjqh7Rn8HxlTxDSvWJJg/MqvJ2Z8PfQcPXNso=;
 b=XA4xaWp1BrdedvCGk7My+vdGVjWKXRDZlSoDdLOa3TslGk/4239KVf9Na1IR/x/X9H
 YUVTj2bXkKA4GtcUFl4vgZY06LdpGnFJ/E6SK9Mk/bxg8+xHnMjVB6cP3W1o9qOZl2L6
 RgR2jZFiLhbY1o/C2y8E+EgKvGBc2eJjuIkG5XeEvmxRbwrSnMKlzNE0pdkDzFiWVO77
 WG0Bxd5N7U+EjjLAcZsTQhWCZyM4Fg9cRoEBJiBSMIYlHGQl4f2MtbwO2zdwBJWrllcq
 NeeY9Q2FSR4EDNxkksAzNyquwn5SzV/9U8Kxx7bdNeF+SZJV6Tu26JH8dYBa60xUJT5g
 kqew==
X-Gm-Message-State: AOJu0Yw49scNLFDY1v5J+QFwWK1egfR/NgXZHuw7LfiWdyIlcfxKLEfc
 heH74ovKnEENJwJTSesCSICkZCj6YVztGipyMdw=
X-Google-Smtp-Source: AGHT+IGLugbhL2NIMhx+PITzFq9QSTlj5uQ3wXQBdGmU6t02zMY+iFKhfy5Yl3Z/v0Cx0RNN6iGe7GDKF6JDePHb8XY=
X-Received: by 2002:a17:90a:af98:b0:28a:7a68:d08f with SMTP id
 w24-20020a17090aaf9800b0028a7a68d08fmr5149351pjq.97.1702667187635; Fri, 15
 Dec 2023 11:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20231214162543.1200276-1-tharvey@gateworks.com>
 <20231214162543.1200276-2-tharvey@gateworks.com>
 <CAOMZO5DuRnmNpT-GZxkjL4UmwNW-NyQWf+VNy4Q+N1=aitUptA@mail.gmail.com>
 <CAJ+vNU0XbwbQoYDHm59LrFaK_hv29RkeZvbK=QCUMkoLYNM-hw@mail.gmail.com>
 <CAOMZO5BBDM2rzhxqe_kw8ADexUtsNxYfnueFtASkNxp561nquw@mail.gmail.com>
In-Reply-To: <CAOMZO5BBDM2rzhxqe_kw8ADexUtsNxYfnueFtASkNxp561nquw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 15 Dec 2023 13:06:16 -0600
Message-ID: <CAHCN7xJAzVY2FuELr17pqkkJtRdPo-sO-asLzYGF2cNwYrVPNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx8mm-venice: prepare for dek blob
 encapsulation
To: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Fri, Dec 15, 2023 at 12:41=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Tim,
>
> On Fri, Dec 15, 2023 at 3:34=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
>
> > Fabio,
> >
> > The commit log details are not valid for upstream. I was basing this
> > off of 8d060e4a66d6884341fbb3d8ab1d837a3f173d47 which made it upstream
> > with the same message.
> >
> > I can submit a v2 if necessary.
>
> Yes, please submit a v2 and I will queue this series and the TPM one
> to u-boot-imx next.

This node appears to already be in the imx8mm-u-boot.dtsi encapsulated
by an #ifdef looking for optee.  Can this ifdef be expanded to include
CONFIG_SECURE_BOOT?

adam

> Regards,
>
> Fabio Estevam
