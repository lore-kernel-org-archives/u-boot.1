Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35578C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 19:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 757F680B9B;
	Tue,  1 Jul 2025 21:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="fK3shdaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C37281E13; Tue,  1 Jul 2025 21:49:57 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828CC8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 21:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-611a7c617b4so1808233eaf.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1751399393; x=1752004193; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DOihLeSohQ8NTQ0a4uZ6LAX3WG4qdtZJv+xBZVNNh4=;
 b=fK3shdaLqS/wl/1q3q2TqdvlADzYyOnxooAlHpoUgvXzfgQCecvRSdXZFi76dcUKEX
 MU29BYEjHzRIfxSBAj0QLDj3MnBc1h04lCoH+fXx2jHVCKSlHGYq5S56Ulcw0pvvixyu
 DMNQQ39qVyHz5S0AKUlIlRBOLhSQGksO1rKJpjekRajWYBE12m2v/Cs8yX/VA4OQwtb2
 N4F3N4K8bOPmIlTRN1tWeDGtMQsSpiVaN7bHFbcH0CjcqeLSmdCe8FGcak2XBrwwkkW7
 o1w+4P8cRczWcWAO1esCNOhJicrj7vMnVqHErJafGNm/hXcggti5M9hvLzDg1mj7txQk
 WdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751399393; x=1752004193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DOihLeSohQ8NTQ0a4uZ6LAX3WG4qdtZJv+xBZVNNh4=;
 b=nLfRr3AuNn9xPkheNaNQNiGeA3Zxutrz4yln8WBRAKOWZBbGcNgEirSRJXiPUzE33K
 TT54rhznrNwgnqJQ8cPM08SHAHyvPWfDGL10NT0olD1JokSzVtqKXWWUHSwWeU82o7Cz
 +1jeWdf4yhV40fRmSG9BHWJQjT/xgI4zT3ZYUF3YEbav2mOor4R/4B20ROizW8j9HiYc
 40sit3U7AeXfzsnHALYfJm73QIjC1QO0XtteMEI3+x4fY1f7rBjgukFpEzhgHUaAfFEn
 mYCUyi1yP+bkC4afq9czQrCglJJwl1K1Xfy/T49iLWMY8rOVj1jQ5xedPSyJVWaR7tOJ
 ci7g==
X-Gm-Message-State: AOJu0YxUVc12P5yzHE4Koj1iOQrFnJNJUouH0cz2yvIsyW2KAx9Mev9r
 cbHz6rL9sYOPIYrl84shjFnZOkmz9MDJ7r9Hy/jPMJOufXYbdEaylfFd2lMyupCPyPdvPicAMNN
 V2GnW69Zk3Q3XirOe4DGERt+1HCoVsHlztZR+TqwUig==
X-Gm-Gg: ASbGncv9rLrv/d0R/GRlJqaTg4CnsfBbl7aPwp0hhC0qFHE+FdF8QQ3Qx8Q/smjM1rE
 1ZQc1T60TbPrnTPCSGOexQjgxNlJdJ6UKcBqHCKpNo66m3r9sDZbjG2vHiTy+eMOlfqMayu3qdF
 MG9NNpYMb6Ho7kspMqJtA4OS/8Tqoj2YjmGfoyL1QrGsw=
X-Google-Smtp-Source: AGHT+IF1kwA0SXsoOKdwcnXoL9VsrlbxDGBxe1RDeqK5uYjsaeW4jfsExJ1ZDW+qNPfYjoOTcL5sHkuD7H3n9iwHAI4=
X-Received: by 2002:a05:6820:2d05:b0:611:ab60:3003 with SMTP id
 006d021491bc7-612012b713bmr19053eaf.8.1751399393154; Tue, 01 Jul 2025
 12:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU0p4BZX-853gmcgEMzXn+es5SV5aTUcU-kzTjPZLFtLOQ@mail.gmail.com>
 <PAXPR04MB9644C2E63CE6649A1818ED82E241A@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9644C2E63CE6649A1818ED82E241A@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 1 Jul 2025 12:49:41 -0700
X-Gm-Features: Ac12FXwUiOOzHMX6lbduA5MFCf1b1ILxY2yeqmqFCApPl9P7-wrREH_0a6VUQf4
Message-ID: <CAJ+vNU0-wUW=j0N3RYVMsjhdpjxoU-GA8uVD_MAawYdj=X2N9Q@mail.gmail.com>
Subject: Re: imx95 SDP support?
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
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

On Tue, Jul 1, 2025 at 6:07=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:
>
> Hi Tim,
>
> i.MX95 needs to enable USB gadget in SPL to load the U-Boot proper. It ca=
nnot use boot ROM API.
>

Hi Alice,

This is unfortunate - is the ROM API not going to be usable for the
imx95 or is support code simply not written yet? I don't really
understand the difference for example between the imx8mm BOOTROM and
the imx8mp/mn BOOTROMv2 where BOOTROMv2 can use the for SDP which
greatly reduces the SPL footprint.

Have you been able to configure U-Boot SPL for imx95 SDP? I am
overflowing .sram codespace when I try to add 'either' support for the
USB2.0 controller or the USB3.0 controller.

Best Regards,

Tim


> Best Regards,
> Alice Guo
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tim Harvey <tharvey@gateworks.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B47=E6=9C=881=E6=97=A5=
 8:07
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: u-boot <u-boot@lists.denx.de>; Alice Guo (=
OSS)
> > <alice.guo@oss.nxp.com>; Fabio Estevam <festevam@gmail.com>
> > =E4=B8=BB=E9=A2=98: imx95 SDP support?
> >
> > Hi Alice,
> >
> > I'm wondering if you have any notes regarding U-Boot SPL SDP support fo=
r the
> > imx95?
> >
> > The SPL boots over SDP just fine but I'm interested in getting to the n=
ext step
> > where the SPL provides SDP support to load U-Boot propper.
> > I'm not clear if the imx95 uses a similar bootrom to as the imx8 and
> > imx93 or if this is done over scmi.
> >
> > Best Regards,
> >
> > Tim
