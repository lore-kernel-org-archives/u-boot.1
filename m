Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3C1CAC5AA
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 06:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE976835CB;
	Thu, 25 Sep 2025 08:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="LjVIVs3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40628362C; Thu, 25 Sep 2025 08:09:20 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941AF835C9
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 08:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-57ea78e0618so533550e87.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1758780558; x=1759385358; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8CuGI+fm+C/E4CQ2OSVMS5JULJZp/hO69jybs9un5I=;
 b=LjVIVs3Yzl5Lm32rdL5Ilo/LtGTlFdZ12SXNX5k2vO7vBYERkHzBVQqVfW4AAm0GT7
 bDw6ofBuoV6ReAI+n2hyAF79J6zRdg0PNU8t5H7IoIA/thRIHcOcKFukg2BNiYMM0xDq
 8F40AKcI0rsLi6XuQN3pSN8cJ9Z2/XamB1StU2xEaIGSmPwQf8x7bkjte9etDi5+Lyej
 rwjfrQmBDKP4oHZjaSZ3Y+9SqxntT8MgSL4q04M6mmM534bKAhQuUjgPBAwqUl4ecrXn
 V0G7QdUgCWTDNB/5+fHjpFcPrPbkVkL9hOvQmv4pnHe1MTAh9y3GCnw7TjibUWRtEIa8
 XLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758780558; x=1759385358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8CuGI+fm+C/E4CQ2OSVMS5JULJZp/hO69jybs9un5I=;
 b=JAbdJyDJyhdk1mGcmF/RAw0f4ZqA3ni/vo8W22qDMWo9oy7UHiZ1PKQz9+hQKH9D9I
 0CENFcejMREgnhSuT31hPMXF3HckSG2ttrNP3/LD5UdYaMiSB65NytSdMFKskBJi1k8H
 vlQK1nFiv9oHR13ShojEcWuILOAPjlgHNNQPSL4TGWFbQTAHCwmGf/z6GFhia8BFGCSc
 C9KtsA54QpFjkMrE+L3ChED3wdG/Gu/DY6HCGzZbz/ep0sZiGVUs3luek31eHNsRmC+P
 q8eDHZGKJp9p3Z5NyyoUgvRxTLDX1Y9fOJ6N8uRcU8vwoazOrjP98yZG1Uv6OPxu+Q5Y
 vyXg==
X-Gm-Message-State: AOJu0YwzSTh99tdFdxMbK5ay8lrT32CQsRhhWxq/GCkwyJhkBQqIU454
 8vFTGsTZ7oWeirCvL7yspquBL2Pc3On7czdF/DR7M1Q02aKEMS1G0RgsqVkRkdpo84Hufx4NQtR
 K7gPsWoyWG/seJWx5mQSY17nALvAoILk=
X-Gm-Gg: ASbGncuo7WUBoziGmoH6DcMapWIQt21mNNGF8B7cobxW7qd6cRv8n1ZNawHtl6qlcHE
 kqSDjvSy7YSNAi7qHEs/Ip3e+naO6Kpy5HnRQ28SG55A3NSBoq5PZJIBc9trRqin+aTAJPGzGlG
 zX9aRUGmGoMmYWelH+DEDBUINhb+AIlcAw9apF1DK61Dtjl+JctD4JaRZ54/j7GoR7xiv3T8g4t
 i/exE4M
X-Google-Smtp-Source: AGHT+IFdYFAJ2nupxD4VRKD/F4tlKGG6hiX7WLkksbpJ1iwzMcvv90fyRurZ5p9Fl7TIwm7MvYqPHhNBFV1opmJvazU=
X-Received: by 2002:a05:6512:3e06:b0:578:ed03:7b5f with SMTP id
 2adb3069b0e04-582d258405fmr563968e87.26.1758780557514; Wed, 24 Sep 2025
 23:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktPcqpCzy=B=_n1fZS5dZVCB208qt8CTgBJak=V0xfgEQ@mail.gmail.com>
 <20250924141428.GI197373@bill-the-cat>
In-Reply-To: <20250924141428.GI197373@bill-the-cat>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Thu, 25 Sep 2025 08:09:05 +0200
X-Gm-Features: AS18NWAgc1gz_b6syxsAO_Jjp9P_RMwzOHsWF6atMhbf9oEvDkWdZ7wOaZgoAc8
Message-ID: <CAGm1_kt1hu+yPoMshm1M1LMszpxeiVijUU1ZF5UThQtL85xmMA@mail.gmail.com>
Subject: Re: am335x: NAND boot problem using the legacy u-boot.img
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, seanga2@gmail.com,
 Simon Glass <sjg@chromium.org>
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

Hi Tom,

On Wed, Sep 24, 2025 at 4:14=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Sep 24, 2025 at 11:09:16AM +0200, Yegor Yefremov wrote:
>
> > HI all,
> >
> > trying to boot using the latest master, I get the following error:
> >
> > U-Boot SPL 2025.10-rc4 (Sep 23 2025 - 16:45:07 +0200)
> > Trying to boot from NAND
> > Error: -5
> > SPL: failed to boot from all boot devices (err=3D-5)
> > ### ERROR ### Please RESET the board ###
> >
> > It turns out that bl_len will be set to 0 in spl_nand_read():
> >
> > spl_set_bl_len(load, nand_page_size());
> >
> > This sets the aligned image size to 0 in _spl_load():
> >
> > size =3D ALIGN(spl_image->size + overhead, spl_get_bl_len(info));
> >
> > Looks like FIT images with full FIT support will be also affected:
> >
> >                        read =3D info->read(info, offset,
> >                                            ALIGN(size, spl_get_bl_len(i=
nfo)),
> >                                             buf);
> >
> > If I manually set bl_len to 1, I can boot without an issue. What am I m=
issing?
>
> I wonder if this has always been an underlying problem. Looking at
> drivers/mtd/nand/raw/am335x_spl_bch.c we've always had nand_page_size()
> return nand_to_mtd(&nand_chip)->writesize and I assume that should have
> been being set to CONFIG_SYS_NAND_PAGE_SIZE but I don't see that as the
> case. If you change nand_page_size to just return
> CONFIG_SYS_NAND_PAGE_SIZE or nand_init to set writesize to
> CONFIG_SYS_NAND_PAGE_SIZE does it then work again?

yes, the following change makes the system bootable again:

diff --git a/drivers/mtd/nand/raw/am335x_spl_bch.c
b/drivers/mtd/nand/raw/am335x_spl_bch.c
index 4b50f351d35..a77206d3815 100644
--- a/drivers/mtd/nand/raw/am335x_spl_bch.c
+++ b/drivers/mtd/nand/raw/am335x_spl_bch.c
@@ -212,6 +212,8 @@ void nand_init(void)
        if (nand_chip.select_chip)
                nand_chip.select_chip(mtd, 0);

+       mtd->writesize =3D CONFIG_SYS_NAND_PAGE_SIZE;
+
        /* NAND chip may require reset after power-on */
        nand_command(0, 0, 0, NAND_CMD_RESET);
 }

Yegor
