Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF44C04A6A
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 02:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A190B8697B;
	Tue, 15 Aug 2023 04:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZVkMslPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C648697E; Tue, 15 Aug 2023 04:47:01 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E758696C
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 04:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5255ce77d70so2674633a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 19:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692067618; x=1692672418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L89oaxfcIpPERN43SP0zhUCzcVEg4EVgsX57kcSV66k=;
 b=ZVkMslPaMXc5rXW6l8MCBr68Tf0ZIaBb9pAyT0EAUoGCpdPmCfhwz8dQtzmb4BT4qT
 +5bFz4803OtxhLO41eHFs8B1P8+GER0jVXUTQ5aYX7MLTeqy/3Gy+oeqGdDmPTUCzx5Q
 r8gJhVZfHBZIQ/0SzsiUepZNdt7IivZ8ynMsbJP+BWtzZSqLMwZCevVzyaPzPUH+iv6d
 dUAfwNX3bP2iUQ8F4ssWzUAviNDYBCx1HgxlZ01GoZyGvlmCfWoBZGce6BbveOQQASy0
 qZCwV+sdQT8CER0bJtp+KrW735ucX1vNWXgMneDyHXovIm3Q3+hzJzCvpqMsYM77mTHB
 jDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692067618; x=1692672418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L89oaxfcIpPERN43SP0zhUCzcVEg4EVgsX57kcSV66k=;
 b=b94IdD+VkIHsc9dz8sGYfW14W2D+Mt9/CzDzYyTSAszeqUflzeViIfPUvupnrjhoEI
 EW3Hj2xVQNM0raZMAvC7IGCG9LtqTAR6JJGvV7yOZtpmwmCSXUajtMdhaoBLbVsIHwQ7
 avnhl/C8AqmFo3pVSFHEG0QRUeggXfVFC3WzpfcQpypfXi6mbwOHIDMN8pDL9GqVPA8C
 ejBfA5PBpWlUr1s41T7OwfiCQYdZrxbrVsIqeNaZnAFpZXdX3MoY9NwxpBKWVxukIZgD
 2wEjjVAOLiyJkWH+tJcJ38ZIvgMGRW6EMaQS0YSX5CODF7qQzrhUOwtVSo00r4O6lsIs
 D3AA==
X-Gm-Message-State: AOJu0Yx9XBg0f0x5u69G0xiM2RkC+Vr/w1nrJV2KwUepeKADh9kitXIK
 4elBC7i6w7ckjpq70aPJIOSmkBlWvcMYjHfsf30=
X-Google-Smtp-Source: AGHT+IFH0AhfSiKzSCIQsXn8RPYnNERvEv04sYE8ENx/Lb6/Vhl4g28TeL8zmAsaHl1zSxWiGe0IOeHrVNZx6dWfu3I=
X-Received: by 2002:a05:6402:1514:b0:521:7ab6:b95d with SMTP id
 f20-20020a056402151400b005217ab6b95dmr9156798edw.29.1692067618076; Mon, 14
 Aug 2023 19:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230812031846.3958-1-ssunkkan@gmail.com>
 <CAPnjgZ1Z6pKEif5HKFLcG0AQJL1qrqy9j78TjvuhpsOUzS7JGQ@mail.gmail.com>
 <CABjXDjHOpcM=JtCe2SGzwQ+GbQT7cg8xQxFbthPqW3KXaJ1P3Q@mail.gmail.com>
 <CAPnjgZ3BWbMck_EoC4AYhdZftb3vk9p=2dsM7SBAEi1W3FYfJw@mail.gmail.com>
In-Reply-To: <CAPnjgZ3BWbMck_EoC4AYhdZftb3vk9p=2dsM7SBAEi1W3FYfJw@mail.gmail.com>
From: Clus Tom <ssunkkan@gmail.com>
Date: Tue, 15 Aug 2023 10:46:46 +0800
Message-ID: <CABjXDjFvFp33phD2Kwog8oo8H1XsquU7UBGLVLKKaemeawrbrg@mail.gmail.com>
Subject: Re: [PATCH] Add support for more XMC series
To: Simon Glass <sjg@google.com>
Cc: chiawei_wang@aspeedtech.com, jagan@amarulasolutions.com, vigneshr@ti.com, 
 u-boot@lists.denx.de
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

Hi Simon,
I just want to apply:
https://patchwork.ozlabs.org/project/uboot/patch/20230812031846.3958-1-ssun=
kkan@gmail.com

Thanks,
SSunk

Simon Glass <sjg@google.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8815=E6=97=A5=E5=
=91=A8=E4=BA=8C 06:43=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> On Sun, 13 Aug 2023 at 21:19, Clus Tom <ssunkkan@gmail.com> wrote:
> >
> > Hi Simon,
> > I'm not quite sure what you mean by v2, if it's the previous email, it
> only removes the XM25QH128C part of the commit message compared to the
> previous one.
> >
>
> Right, so it is v2.
>
> Your emails seem to have generated 3 patches:
>
>
> https://patchwork.ozlabs.org/project/uboot/patch/20230811082000.4277-1-ss=
unkkan@gmail.com/
>
>
> https://patchwork.ozlabs.org/project/uboot/patch/20230812031846.3958-1-ss=
unkkan@gmail.com/
>
>
> https://patchwork.ozlabs.org/project/uboot/patch/20230812030731.3711-1-ss=
unkkan@gmail.com/
>
> The version number helps the maintainer figure out which one to apply.
>
> Regards,
> Simon
>
>
>
> - Simon
>
>
> > Thanks,
> > SSunk
> >
> > Simon Glass <sjg@google.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8813=E6=97=
=A5=E5=91=A8=E6=97=A5 21:36=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Fri, 11 Aug 2023 at 21:19, SSunk <ssunkkan@gmail.com> wrote:
> >> >
> >> > Add XMC XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
> >> > site: https://www.xmcwh.com/site/product
> >> >
> >> > Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
> >> > ---
> >> >  configs/evb-ast2600_defconfig | 1 +
> >> >  drivers/mtd/spi/spi-nor-ids.c | 4 ++++
> >> >  2 files changed, 5 insertions(+)
> >>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>
> >> I think this is v2 so it should have that as well as a change list.
> >> You can use 'patman' to help with this.
> >>
> >> Regards,
> >> Simon
> >>
> >>
> >>
> >> >
> >> > diff --git a/configs/evb-ast2600_defconfig
> b/configs/evb-ast2600_defconfig
> >> > index 9244654c82..f06c0e1fe1 100644
> >> > --- a/configs/evb-ast2600_defconfig
> >> > +++ b/configs/evb-ast2600_defconfig
> >> > @@ -100,6 +100,7 @@ CONFIG_SPI_FLASH_SPANSION=3Dy
> >> >  CONFIG_SPI_FLASH_STMICRO=3Dy
> >> >  CONFIG_SPI_FLASH_SST=3Dy
> >> >  CONFIG_SPI_FLASH_WINBOND=3Dy
> >> > +CONFIG_SPI_FLASH_XMC=3Dy
> >> >  # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> >> >  CONFIG_PHY_REALTEK=3Dy
> >> >  CONFIG_PHY_NCSI=3Dy
> >> > diff --git a/drivers/mtd/spi/spi-nor-ids.c
> b/drivers/mtd/spi/spi-nor-ids.c
> >> > index 4587215984..80d7678293 100644
> >> > --- a/drivers/mtd/spi/spi-nor-ids.c
> >> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> >> > @@ -531,6 +531,10 @@ const struct flash_info spi_nor_ids[] =3D {
> >> >         { INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >> >         { INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >> >         { INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >> > +       { INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> >> > +       { INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> >> > +       { INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> >> > +       { INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> >> >  #endif
> >> >  #ifdef CONFIG_SPI_FLASH_XTX
> >> >         /* XTX Technology Limited */
> >> > --
> >> > 2.34.1
> >> >
>
