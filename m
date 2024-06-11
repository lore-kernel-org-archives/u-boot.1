Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11490C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C604885FE;
	Tue, 11 Jun 2024 11:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vX0aqQPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE273885FF; Tue, 11 Jun 2024 11:07:03 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92926880A3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35f0aeff7a8so674978f8f.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718096821; x=1718701621;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lFiHJmcXr5bRsAWtAg3LYC5szKnmHpm0MG8X8PMoYe8=;
 b=vX0aqQPNu20+JixPQgYN+kcdG/0+6DU2pBGk+tfy56LMp2tNi/AutFaqrsZzeiCxUe
 5D+8IHqe4OFYqGBEEKXFP5BOdx09Bk1Hi5hOQ6JwNLD7OTaPYuqhux/gy2wB9RfTQ8dM
 Sv1sjtSR3kEWSxmgQBtNEmW0bVaN2oGxZfH89EPZ6VLNcACWHhcuTeVlqMPUC30FpdZI
 LqUbjFjRIl5Te1piONF+g1B3ox/dsfVTc5gaNUUtIxb1A5f8TSRp5R5/As39f4adfqK5
 Wcg19+7x8s1L/Zp0lj8U+D9jWkz2Ly9PADLkoq/1MctL9J7Dy3g+/druqV9OgveQtUSu
 ViOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718096821; x=1718701621;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFiHJmcXr5bRsAWtAg3LYC5szKnmHpm0MG8X8PMoYe8=;
 b=cjHsSk/Mj/MGZdvSBZupLCx2tmFIcRdEMnJG9yrrgH5GYWK85gXPwx43G5TwO2iZJ3
 +cykTY6OpsHuiRdECNkgs2KocxNIf1m3yw6Tb4V2IqAG9xmlkplb1rgb4MoXBT2R7UEI
 wYip/PZ7KqgndAKI3TWXLpGE/YwCtBRGssXnXuPYR6R1z4Y4GBfSxSYjRbw822dcbGIp
 zX3YausZtTv8IR0EkKlXhe4qmpI0pR8XEuhSM5i/C/g1D5Xs9rXYwgCJ6cKSiTpj/vam
 gQ2apG72LEdVljqDZhLfJsqM/pxJhOiZxgoddUmM4ZRxOwx5Ks6uoCAQgPsRyJcHVZUR
 vbOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjxfCByNAopEu7HHXwbOfj2L5NK1nPy9GEDaR3mBG3KrYzkXNp2eNsxtgCI9klOZnGzpJNKUDz998yk5zeN+R36lnGVQ==
X-Gm-Message-State: AOJu0Yy5fEuN/1i61RhFFFFijRzL1pB5TXbbiOgkpg+zSXp4VxA0jh9B
 4WU7isx32cwD5rbSAUP/hPHIFmbLT5YbqzGGTjH/mzncJQxzW2MupTBQRJf6r5Y=
X-Google-Smtp-Source: AGHT+IEohbr3lPFs51E7xeQQWoM0UfiqELCJlLXdF093OG4bhn0TG1S1JHcnH31ss/4HJ+Tj4mo6CA==
X-Received: by 2002:a5d:64e7:0:b0:35f:2255:606e with SMTP id
 ffacd0b85a97d-35f225560a4mr6628916f8f.29.1718096820948; 
 Tue, 11 Jun 2024 02:07:00 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f0bdce051sm10182061f8f.75.2024.06.11.02.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:07:00 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Dmitrii Merkurev
 <dimorinny@google.com>, Roman Stratiienko <r.stratiienko@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 3/6] bootstd: Add bootflow_iter_check_mmc() helper
In-Reply-To: <CAByghJY9Vnp1fTT_1mXg8iCCaFBsMP0+MeYSr3by1xbVp-73qw@mail.gmail.com>
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
 <20240606-bootmeth-android-v1-3-0c69d4457cc5@baylibre.com>
 <CAByghJY9Vnp1fTT_1mXg8iCCaFBsMP0+MeYSr3by1xbVp-73qw@mail.gmail.com>
Date: Tue, 11 Jun 2024 11:06:57 +0200
Message-ID: <87plsnzw3y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Igor,

Thank you for the review.

On lun., juin 10, 2024 at 11:31, Igor Opaniuk <igor.opaniuk@gmail.com> wrot=
e:

> Hi Mattijs,
>
> On Thu, Jun 6, 2024 at 2:24=E2=80=AFPM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Some bootflows might be able to only boot from MMC devices.
>>
>> Add a helper function these bootflows can use.
>>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>>  boot/bootflow.c    | 12 ++++++++++++
>>  include/bootflow.h |  9 +++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/boot/bootflow.c b/boot/bootflow.c
>> index 9aa3179c3881..59d77d2385f4 100644
>> --- a/boot/bootflow.c
>> +++ b/boot/bootflow.c
>> @@ -575,6 +575,18 @@ int bootflow_iter_check_blk(const struct bootflow_i=
ter *iter)
>>         return -ENOTSUPP;
>>  }
>>
>> +int bootflow_iter_check_mmc(const struct bootflow_iter *iter)
>> +{
>> +       const struct udevice *media =3D dev_get_parent(iter->dev);
>> +       enum uclass_id id =3D device_get_uclass_id(media);
>> +
>> +       log_debug("uclass %d: %s\n", id, uclass_get_name(id));
>> +       if (id =3D=3D UCLASS_MMC)
>> +               return 0;
>> +
>> +       return -ENOTSUPP;
>> +}
>> +
>>  int bootflow_iter_check_sf(const struct bootflow_iter *iter)
>>  {
>>         const struct udevice *media =3D dev_get_parent(iter->dev);
>> diff --git a/include/bootflow.h b/include/bootflow.h
>> index 080ee8501225..6058ddd89b16 100644
>> --- a/include/bootflow.h
>> +++ b/include/bootflow.h
>> @@ -407,6 +407,15 @@ void bootflow_remove(struct bootflow *bflow);
>>   */
>>  int bootflow_iter_check_blk(const struct bootflow_iter *iter);
>>
>> +/**
>> + * bootflow_iter_check_mmc() - Check that a bootflow uses a MMC device
>> + *
>> + * This checks the bootdev in the bootflow to make sure it uses a mmc d=
evice
>> + *
>> + * Return: 0 if OK, -ENOTSUPP if some other device is used (e.g. ethern=
et)
>> + */
>> +int bootflow_iter_check_mmc(const struct bootflow_iter *iter);
>> +
>>  /**
>>   * bootflow_iter_check_sf() - Check that a bootflow uses SPI FLASH
>>   *
>>
>> --
>> 2.45.0
>>
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> A bit offtopic (just an idea for future refactoring), but I think all the=
se
> bootflow_iter_check_* helpers should be replaced by just one
> int bootflow_iter_check_id(const struct bootflow_iter *iter, enum uclass_=
id id)
> to avoid code duplication or at least keep all these
> bootmedia-specific functions as
> wrappers with one-line call to bootflow_iter_check_id(iter,
> UCLASS_SPI_*) inside.

I like this idea as well, I'll consider to implement this as a future refac=
toring.

>
> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk
