Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF14C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 12:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE79087EC9;
	Mon, 12 Feb 2024 13:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZxrXdlGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C211587ECA; Mon, 12 Feb 2024 13:46:07 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF2287CC2
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 13:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilles.talis@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a2f79e79f0cso488119566b.2
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 04:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707741965; x=1708346765; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cmbSd57Sj1RDUKOKSgw2ItWwGB8e72r6xayliz7OaI=;
 b=ZxrXdlGmfYQqepmYv8ssEpt8ME9es9AVlIjCVxIurtt5B0eRPdSJBtESpHAYVxl1yV
 nqWc7u05aMyF3c6qL94B5SGYS7FjeMHSNlOxkvgadnn+r9E+YWtjEkGRClClv3oyx6wO
 HbIzDn0UBwnudqdcw1kNAx8zboJxs4u0pivxnqYVm13M9tXACRMZkvVFK3j0SPN5501T
 I/WB0QR59A2qAc92m1L6OtqQ+OBItPn6A+wvygmcxvIFP8MiYbHXxKTtsrXFJQU1ROik
 G1CImN63bjt+UY/2ctAGFiQlfv7NnYAGrc+pi+SrYR4jtGqclDtkfvgKRCytB+sVNSSz
 7loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707741965; x=1708346765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cmbSd57Sj1RDUKOKSgw2ItWwGB8e72r6xayliz7OaI=;
 b=iKnbWb0qtrdAyAIdxAMJvCqWHPiABeQoTgccb2p7RsZRKzWPR94YJF4lKAjbCdB1Xg
 R9QalXr4OKGkNACPy2aJnnXHdD1nO1/E8p782eJj3de7QNPyioMLAJwWnsUD3Slbk1ry
 r3IoS7fRdzyEjMVErJpZvVZETWk83s2SGnFCIVtiB2E0JCMfDV7Aq9M4hDrBgBiUrF5G
 xUBv2ca3WkFP/Z4BTuvAgyubwTvPWVndQ8ZGPwfpPmJNrbawzmOmmFu4JtHmCjbqRZac
 cHcdog6PUbc39CoV0Mj6Mu9VlgnjXZ2AS55LAqbcPA6tX/ClEWe3KKdLWhNsCWNIW5eH
 zhdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsZPumWMfeu8liX3QWcKZ5+rqojWs3t5CGGeInZxlJk9FmodKSvRC+FPhPKl3neJ1Efc3O4U/ifm+jJWTeNpnWosrqkw==
X-Gm-Message-State: AOJu0Yzb9yk5ve1zlDyIJdbfzI1FDUtx3gVtOY8e723ClhFHAa1Y/ErJ
 kCy2b1/c7QfiolOJ1J8WESaKl34Xqj+QX4XP9VbAOsY6BzJJFsgNR08mZz8Chh/iZrbiPgZ6Edq
 qIrvvC7OZSlt6ejeuGxIR1wRYlS4=
X-Google-Smtp-Source: AGHT+IGMgdHRyV6EI4yKpRWveBqNJVnPBRx6FQaupWR4NrHwYXqtEfC8Et/PSLh1LmAV+PUFn1C5WMtKubVCMTwH9+o=
X-Received: by 2002:a17:906:1b1b:b0:a3c:83d4:6869 with SMTP id
 o27-20020a1709061b1b00b00a3c83d46869mr3096335ejg.54.1707741965051; Mon, 12
 Feb 2024 04:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com> <877clq6odx.fsf@redhat.com>
 <CAKcgs2x1FdvW0afXN=GGRc5nb8rhZtm70xzkURFeworcmTHPpg@mail.gmail.com>
 <87bkavbo6c.fsf@redhat.com> <877cjrss43.fsf@redhat.com>
 <CAOMZO5A2W4ZZBdUjNkA9fqB+kBgASM7esfcLL3RvdwmCi9qakw@mail.gmail.com>
 <87r0hy38am.fsf@redhat.com>
In-Reply-To: <87r0hy38am.fsf@redhat.com>
From: Gilles Talis <gilles.talis@gmail.com>
Date: Mon, 12 Feb 2024 08:45:53 -0400
Message-ID: <CAKcgs2wmZPQEnV0xtr=L-BdX_Qt=Qbd2XwEZPDqSG_xHLUd9uA@mail.gmail.com>
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
To: Milan Zamazal <mzamazal@redhat.com>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de
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

Hi Milan,


Le mar. 30 janv. 2024 =C3=A0 15:55, Milan Zamazal <mzamazal@redhat.com> a =
=C3=A9crit :
>
> Fabio Estevam <festevam@gmail.com> writes:
>
> > Hi Milan,
> >
> > On Tue, Jan 30, 2024 at 9:22=E2=80=AFAM Milan Zamazal <mzamazal@redhat.=
com> wrote:
> >
> >> Well, after trying both the SD cards again with fresh reinstallations,=
 it works
> >> with a 32 GB card and I get the error above with a 64 GB card.  Is it =
possible
> >> that there is something wrong with SDXC cards?
> >
> > Does the change below help?
> >
> > --- a/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
> > @@ -128,6 +128,9 @@
> >         bootph-pre-ram;
> >         sd-uhs-sdr104;
> >         sd-uhs-ddr50;
> > +       assigned-clocks =3D <&clk IMX8MP_CLK_USDHC2>;
> > +       assigned-clock-rates =3D <400000000>;
> > +       assigned-clock-parents =3D <&clk IMX8MP_SYS_PLL1_400M>;
> >  };
> >
> >  &usdhc3 {
>
> No, the same error. :-(
>
> Regards,
> Milan
>
I tried with a  32GB Sandisk high endurance SD and a 64GB Sandisk
Ultra SDXC UHS-I and both worked.
Can you tell me which 64GB sd cards you tried booting with? And also,
which steps you followed to get the errors (which image to download,
etc...)?

thanks
Gilles.
