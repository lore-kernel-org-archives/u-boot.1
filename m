Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60259C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1144886A13;
	Tue, 15 Aug 2023 00:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="CCbFxmy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCC286A10; Tue, 15 Aug 2023 00:43:11 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AFB86A11
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5236b2b4cdbso6276399a12.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692052988; x=1692657788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIu6WbYbi2wAzy2VgN0we3ofzzQoEeSGVABJoOj9pHI=;
 b=CCbFxmy34mT2+1O2esn7v5G/lUXx4FT1nzY/nOY4B72n+pWDOjY8upJFzE0sZLx6mz
 ksBmX+egwnLeHMpwSNsgPEjpEE6iiIJ3o7RVJRH8fs1mVjDFxjuxaqXO0+kFF3nYnUDv
 3Ncqp9d6P2Kg5yMWzeOvDltDkQJYwcVBg2BU069p4Z2usowEywzDmJFPwXwbaQCwTfwY
 LlJvL8EdIqHNWkMEJm1ghXoXb2YVTmExqn7wS3ZV/srq2xTifyL9E1N+JuBN/7Pb23E3
 3hAob6PP8fpu0m68LIB7sX64vxwSn6mUK1nBxKUtz1eXKe4VTGoj2szHVVUNgR9KDVJF
 QI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052988; x=1692657788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIu6WbYbi2wAzy2VgN0we3ofzzQoEeSGVABJoOj9pHI=;
 b=NhlqOhm9Lu83GmlEPmJDvTkknlnY6DezPz5K0HtaasNkcmpEADhctMZshkQsczVF+6
 bRjkfSuG2RQsRenB7F3V7V92hK7RqmSzomCO/2JYkuZQHH2j3ypdPtQ3h6+g35gHaMo6
 O2SQqYGGJJln/v3Pp7n7Akfid4ylaTmLW9VHr0/MixB9rGQrnl68iQNrNQ3cEE1IceWa
 30nb2w5hnoOXzpW6QBsddEGwXO6usKi2cMbpQ3lK7k0gA3UycIMS/JnEQy2eWlvrXQOQ
 nHn/W9flMt8XmoBi9icQOFaSsHSW+fT0UOQjYJ4bl9r4yMo5sgQASGVbmyPGHj76YTWY
 tcLg==
X-Gm-Message-State: AOJu0YzZcigF3ZeVHLblD9CBu5B/8B8IA4ovCyXk6+6cbHsz9WIHokfk
 KVyMxO5v9LjNHagMpY/RWKA8LoxB10aqLE2L3s1VBQ==
X-Google-Smtp-Source: AGHT+IHHXQUCKx8HFw98ed76mdQocpstRxjweXSIaJhVXmE70EsuSYhecFWUEaJHILPAQwpLJjQlbPQuAXBdx5b08yE=
X-Received: by 2002:a17:907:60c6:b0:99b:ce19:ec1c with SMTP id
 hv6-20020a17090760c600b0099bce19ec1cmr8496985ejc.73.1692052987950; Mon, 14
 Aug 2023 15:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230812031846.3958-1-ssunkkan@gmail.com>
 <CAPnjgZ1Z6pKEif5HKFLcG0AQJL1qrqy9j78TjvuhpsOUzS7JGQ@mail.gmail.com>
 <CABjXDjHOpcM=JtCe2SGzwQ+GbQT7cg8xQxFbthPqW3KXaJ1P3Q@mail.gmail.com>
In-Reply-To: <CABjXDjHOpcM=JtCe2SGzwQ+GbQT7cg8xQxFbthPqW3KXaJ1P3Q@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 14 Aug 2023 16:42:49 -0600
Message-ID: <CAPnjgZ3BWbMck_EoC4AYhdZftb3vk9p=2dsM7SBAEi1W3FYfJw@mail.gmail.com>
Subject: Re: [PATCH] Add support for more XMC series
To: Clus Tom <ssunkkan@gmail.com>
Cc: chiawei_wang@aspeedtech.com, jagan@amarulasolutions.com, vigneshr@ti.com, 
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

Hi,

On Sun, 13 Aug 2023 at 21:19, Clus Tom <ssunkkan@gmail.com> wrote:
>
> Hi Simon,
> I'm not quite sure what you mean by v2, if it's the previous email, it on=
ly removes the XM25QH128C part of the commit message compared to the previo=
us one.
>

Right, so it is v2.

Your emails seem to have generated 3 patches:

https://patchwork.ozlabs.org/project/uboot/patch/20230811082000.4277-1-ssun=
kkan@gmail.com/

https://patchwork.ozlabs.org/project/uboot/patch/20230812031846.3958-1-ssun=
kkan@gmail.com/

https://patchwork.ozlabs.org/project/uboot/patch/20230812030731.3711-1-ssun=
kkan@gmail.com/

The version number helps the maintainer figure out which one to apply.

Regards,
Simon



- Simon


> Thanks,
> SSunk
>
> Simon Glass <sjg@google.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8813=E6=97=A5=
=E5=91=A8=E6=97=A5 21:36=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Fri, 11 Aug 2023 at 21:19, SSunk <ssunkkan@gmail.com> wrote:
>> >
>> > Add XMC XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
>> > site: https://www.xmcwh.com/site/product
>> >
>> > Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
>> > ---
>> >  configs/evb-ast2600_defconfig | 1 +
>> >  drivers/mtd/spi/spi-nor-ids.c | 4 ++++
>> >  2 files changed, 5 insertions(+)
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> I think this is v2 so it should have that as well as a change list.
>> You can use 'patman' to help with this.
>>
>> Regards,
>> Simon
>>
>>
>>
>> >
>> > diff --git a/configs/evb-ast2600_defconfig b/configs/evb-ast2600_defco=
nfig
>> > index 9244654c82..f06c0e1fe1 100644
>> > --- a/configs/evb-ast2600_defconfig
>> > +++ b/configs/evb-ast2600_defconfig
>> > @@ -100,6 +100,7 @@ CONFIG_SPI_FLASH_SPANSION=3Dy
>> >  CONFIG_SPI_FLASH_STMICRO=3Dy
>> >  CONFIG_SPI_FLASH_SST=3Dy
>> >  CONFIG_SPI_FLASH_WINBOND=3Dy
>> > +CONFIG_SPI_FLASH_XMC=3Dy
>> >  # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>> >  CONFIG_PHY_REALTEK=3Dy
>> >  CONFIG_PHY_NCSI=3Dy
>> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-i=
ds.c
>> > index 4587215984..80d7678293 100644
>> > --- a/drivers/mtd/spi/spi-nor-ids.c
>> > +++ b/drivers/mtd/spi/spi-nor-ids.c
>> > @@ -531,6 +531,10 @@ const struct flash_info spi_nor_ids[] =3D {
>> >         { INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI=
_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> >         { INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI=
_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> >         { INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SP=
I_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> > +       { INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SP=
I_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> > +       { INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SP=
I_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> > +       { INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | S=
PI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> > +       { INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | S=
PI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> >  #endif
>> >  #ifdef CONFIG_SPI_FLASH_XTX
>> >         /* XTX Technology Limited */
>> > --
>> > 2.34.1
>> >
