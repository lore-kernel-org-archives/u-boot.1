Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E807E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 19:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4329800D7;
	Mon, 16 Dec 2024 20:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S+BAK+Vf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0F6800D7; Mon, 16 Dec 2024 20:07:52 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1DD5800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8e52so7162735a12.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734376069; x=1734980869; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGVWCsRoNsOtjbgMB1sa7S24HrKvfamxeLfXbjCARZU=;
 b=S+BAK+VfAoUjW2pU4kSraN6mV45yne8DubPPy5c8F6CB65xhE1GZjVUFvi3st402Lx
 F33ZXbXnVhVx2q74i/F9lneLrluFcv1yOQYL2Fl0Zf87UZ5QjQhOlWpiN3DIbFNmMlWz
 PyPDy6W5f+J+D3DCRibmDM29y0QU2BZ0fwJFTmFIuizggtnXXk9iDl7hIR/PSv0UkXlM
 P9ZzN8paoVrBmPw5AH97MkLjYLkurEcMHaKVrVarcYNGTKBfIpj2pdodBebUwOj+Vo/l
 KOj5aEThfyY+plsHmxfZCpsn9dbGVDVN+GdEklFZzG91mPTQ2GRzbCrLjXUI83hDI9o4
 q/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734376069; x=1734980869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pGVWCsRoNsOtjbgMB1sa7S24HrKvfamxeLfXbjCARZU=;
 b=OCldJ+i9LYl/eq20LpSZF030pI1+ZcwNMXqu9iLOejF/IVlORD4kKfdNx3TOPqt4h2
 8HMMlPfIrZf1FKGsPeY79+0o0AH6QVm41FAz0SPfZU/J8mKCUPYLpDQw/PMJqhvxecWa
 zOHgxZkNGBWoH+FfgnNnynOqbMyVI9NY8idI3RUf9QNQS+A23FNm7hVyKLXAFw+EVv1N
 ubLC/IQqF2EblFueIIR1EOilOW9vzdVosH1rcGxnJH3yb3m1gmhR2iWxviYxXFhE7RzX
 rMXlx+sOGzLHVMOC1xNfDsapiECUJeK6XJfezH0lw5/ViO+w+/mn/4mbzGtdPRF/u9H1
 aKEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbtpqnAguwHnOL/gT9Fg3wWbG6CQ2Zn2XuTO8R5Gm9pGNIUtzepJeV4sCrwybH7U4AabuucvI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyrh7JBLyXxWsyu/gxPp2BXnq1aaybCRCL+Iu4hbd9rk+kgurfo
 L6ru19dXwf4xBzotgjtSniRP+r5B87a3HkDa4JiPIJOobOn/eng6BPhSvQ7RfZSgR7VhfVXjYvL
 Gc+qjrSKBBP4jQaF/VD/+C9s1xNeFK1WJKfRk3A==
X-Gm-Gg: ASbGncu4IZRY3mAgbwokLkx6XIY3rIENfLzQc2yXroz2GXRPX3jWU6ar6VlvA0ouP8h
 56v1l9782QP7ikJh8O6MnZvvH7FaCHYuRsbc5gg==
X-Google-Smtp-Source: AGHT+IENRwZeb0QYROkBjzjuvu4ZdSJZE99t1MwjvuNNLrfpnYJSJ0jSe+//QKCXWaoNR80LkZKnBq95DTryfonUPro=
X-Received: by 2002:a05:6402:4492:b0:5d0:f81d:f555 with SMTP id
 4fb4d7f45d1cf-5d63c2e5389mr10661346a12.5.1734376069164; Mon, 16 Dec 2024
 11:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
 <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
In-Reply-To: <20241216190255.GA55577@francesco-nb>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Dec 2024 00:37:38 +0530
Message-ID: <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 u-boot@lists.denx.de
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

On Tue, 17 Dec 2024 at 00:33, Francesco Dolcini <francesco@dolcini.it> wrot=
e:
>
> Hello,
>
> On Mon, Dec 16, 2024 at 11:28:42AM -0300, Jo=C3=A3o Paulo Gon=C3=A7alves =
wrote:
> > Hi Sughosh,
> >
> > > Can you show the output of bdinfo. And also print the value of ram_to=
p
> > > while booting the board.
> > >
> >
> > Below are ram_top and bdinfo:
>
> We briefly discussed this off list, what is likely happen is that our
> heap is after 0xFFFFFFFF, or said in a simpler way in the 64-bit address
> space, while ram top is at the 4GB boundary.
>
> The solution seems to either move the heap down or move ram top up.

I am not sure I understand. Isn't the heap memory part of the U-Boot
image, meaning it will always be below the ram_top? How do you have
this configuration where the heap is above ram_top? Can you point me
to the code where the heap is getting set above ram_top.

-sughosh

>
>
> >
> > U-Boot 2025.01-rc4-00025-g4ff8ecd9b14e-dirty (Dec 16 2024 - 11:21:18 -0=
300)
> >
> > CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
> > CPU:   Industrial temperature grade (-40C to 105C) at 51C
> > Reset cause: POR
> > DRAM:  Ram top: FFFFFFFF
> > 8 GiB
> > ...
> > Verdin iMX8MP # bdinfo
> > boot_params =3D 0x0000000000000000
> > DRAM bank   =3D 0x0000000000000000
> > -> start    =3D 0x0000000040000000
> > -> size     =3D 0x00000000c0000000
> > DRAM bank   =3D 0x0000000000000001
> > -> start    =3D 0x0000000100000000
> > -> size     =3D 0x0000000140000000
> > flashstart  =3D 0x0000000000000000
> > flashsize   =3D 0x0000000000000000
> > flashoffset =3D 0x0000000000000000
> > baudrate    =3D 115200 bps
> > relocaddr   =3D 0x00000000ffece000
> > reloc off   =3D 0x00000000bfcce000
> > Build       =3D 64-bit
> > current eth =3D ethernet@30bf0000
> > ethaddr     =3D 6e:79:12:b6:72:24
> > IP addr     =3D <NULL>
> > fdt_blob    =3D 0x00000000ffab8450
> > lmb_dump_all:
> >  memory.count =3D 0x1
> >  memory[0]      [0x40000000-0x23fffffff], 0x200000000 bytes, flags: non=
e
> >  reserved.count =3D 0x1
> >  reserved[0]    [0xffffffff-0x23fffffff], 0x140000001 bytes, flags: no-=
overwrite
> > devicetree  =3D separate
> > arch_number =3D 0x0000000000000000
> > TLB addr    =3D 0x00000000fffd0000
> > irq_sp      =3D 0x00000000ffab8440
> > sp start    =3D 0x00000000ffab8440
> > Early malloc usage: d620 / 10000
> >
> >
> > Best Regards,
> > Jo=C3=A3o Paulo Gon=C3=A7alves
