Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A0AC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 19:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F347B8899A;
	Wed, 24 Jul 2024 21:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BG4irEO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F345B8899B; Wed, 24 Jul 2024 21:38:38 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87E2488996
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 21:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.belisko@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ef2fccca2cso2081591fa.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721849916; x=1722454716; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pAhM2TXnnDNh9KRiWdw+XkyLx/gj0j0v4f8mDWjY60c=;
 b=BG4irEO6PSAu7942daeXiLu6fLr/xqpZnsgz6XJFhl0ESDqHw4eEOFbtUNLSCYrEb/
 KcdFJmT2vcfmRyUH0Bl7M9e7d/JGSUBROA467xosiQArXv+yn28Av3zWmdpRrhJIFZcJ
 zzQDff1SHsQLvEswJYBaeogAPr4M6hWn+v9auOaTW2ovJWuQUZKzUYMSPFvjoZ+Y+I1a
 UUx37vBV408Ad7rtciWhYdviLGLSD+gslyNJOukb3fyI8joRA1GmnaId222wSaIBF/uN
 7IxPPLx27hShwA5rTBL4iWsEZepEBpbCbqFDqEiuhITiwGhE7btkFeOs6whtLjEQN5I2
 MiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721849916; x=1722454716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pAhM2TXnnDNh9KRiWdw+XkyLx/gj0j0v4f8mDWjY60c=;
 b=Hug41pblb1thQKcpxZaOzy/6cHSFuCcFiQGooIK2V8czEhxkb96kVSlXUFFOdNwGu5
 JLe/8nOjRklLhP9U1sbeeZy89/GTvLburX465p6f+q1H+6szY53WFaC+ps2UP/SzNkfN
 oJeOjpp44/G1KSKz+Wbajh92zI1x2aIyuY3fxQeE2hUU2uwRKdB3ccVpfrVnQvtvEGSc
 9lMcqAy8yIvL62P5xvTdclmd4i0tv3wBST5SFG5F3mdGyBufSwiUsV1Q8XczVQtWozK9
 J+h16FXS67QdNr0Ff0q+2e54j2efWLq1oYXNtLXHPCG2L7K3YntevUIKxLi8D+9mL/Mk
 6DvQ==
X-Gm-Message-State: AOJu0YyaIhqG/4nCEkK+x1rOeSsMMYlObCsuY6hbsGqNFl1+D7gfV4bY
 6E3a3MMsJ+ZHeYJiNLyRGYDl8rr7Xy/4U+WHKQOBzd0OH88l17HvDeQKQob03s2rkP6Q5s9f4GL
 UzHw98VAQ6MiH6sjZ4Op37xb3uVfwYw==
X-Google-Smtp-Source: AGHT+IEaE3aqdzJJOQ6tAjkCPcxI23Y//Z+XZdBpuZmXy1HKDBx5cYuB12TLUO/r0+0jnO6xnABBiB/xbC5qRfjO8e4=
X-Received: by 2002:a2e:a202:0:b0:2ef:23ec:9363 with SMTP id
 38308e7fff4ca-2f039df3c05mr5349851fa.45.1721849915344; Wed, 24 Jul 2024
 12:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37co294aQKffpt0ce=ajYutBrcnU23P=pi=s6YN5gT3Fg@mail.gmail.com>
 <7e901715-35bb-43b9-9471-d8f4573cbf61@kwiboo.se>
In-Reply-To: <7e901715-35bb-43b9-9471-d8f4573cbf61@kwiboo.se>
From: Belisko Marek <marek.belisko@gmail.com>
Date: Wed, 24 Jul 2024 21:38:24 +0200
Message-ID: <CAAfyv36fkumDdFkh_vBrYnc-YKjT5Q18hAcje8+2FHtw7Vw7tA@mail.gmail.com>
Subject: Re: radxa cm3 2024.01 mmc write error
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonas,

On Thu, Jul 11, 2024 at 10:33=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wr=
ote:

> Hi Marek,
>
> On 2024-07-10 21:26, Belisko Marek wrote:
> > Hi,
> >
> > I'm playing with radxa cme and mainline u-boot 2024.01 (present in
> > scarthgap yocto).
> > I realized that mmc write fails all the time like:
> > =3D> md.l $loadaddr
> > 00c00800: ff7ff7eb fffdffff fffffff5 ffff9fff  ................
> > =3D> mmc write $loadaddr 1fc0 10
> >
> > MMC write: dev # 0, block # 8128, count 16 ... mmc write failed
> > 0 blocks written: ERROR
> >
> > 1fc0 =3D 8128 is according to rockchip gpt table u-boot env partition.
> >
> > Is there something I'm doing wrong or its regression?
>
> Please try with latest U-Boot v2024.07, following fix has been part of
> U-Boot since v2024.04-rc2.
>
> rockchip: rk35xx: Remove use of eMMC DDR52 mode
>
> https://source.denx.de/u-boot/u-boot/-/commit/ebe293bae79d8c64d9cd4284044=
e25ddadd074b5

Thanks for the tip, it resolved an issue.

>
>
> Regards,
> Jonas
>
> >
> > Thanks and regards,
> >
> > marek
>
>
BR,

marek
--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
