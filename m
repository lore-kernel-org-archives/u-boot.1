Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B96CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 00:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB5586E1C;
	Tue, 12 Sep 2023 02:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LrPq0BtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F428700D; Mon, 11 Sep 2023 22:26:17 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C436886284
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 22:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luis.adasilvaf@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-502153ae36cso7804530e87.3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694463974; x=1695068774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kyIcWf+7kw9YH4Mr5h2ON0fw96H4aBcQ/udlsd/Fg+Y=;
 b=LrPq0BtYH1Yoj8HFJe8D2fsaob2kLrsxHcnd8eUepvgKvCmO+W8skI9mU49p4CaKoV
 RQ8aHwG0gNJ9MhSqOGMW1AnPG3msiZxu7SgAFucZrOidgMVuXMyaBlCWM4fqDNrhU8Nm
 8Y4/iXY8/dKNGaZkHz/Mzh3HQvvxjb4Siw/2tLX2jzBoOfgBVwDAzXOnnI/S3WMo513p
 Dmpk/SzItTGojHRKhTIrhJWnbC6GOYb2E6k+NXBZfpSkqGSecJJUrw2oGkt/4wGuMOd7
 U/lkGELjUVHqube82vYfLiJ4tfhUkX32RIXQFlZaSyUHLonAdcy+ahxdapnWfxVabj+9
 bBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694463974; x=1695068774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kyIcWf+7kw9YH4Mr5h2ON0fw96H4aBcQ/udlsd/Fg+Y=;
 b=DWulqgtlAHmsBpgAgAfv25sGL2Dx/sUIxQ9gsVSCjn7CsfPbMCZnJi+OuvYYZmtG/s
 iLWGPXASXVx4ybhLQfUp0uXgO2ipIGonXu/M1RN5e1hJZ7YrCxx2jEej3rCZKy+369H5
 U0beq1Kwm8PSbLHnWZbcM+liIfPMCMKInnWYefpJ50osW+p76nohAVFQ/7NmhciZ3RNf
 I8LRUGR4ZacEnFlDxIS9aJ3d1fG3GbqZc1zLtFnEKkYJ5b5mDtFUiz1pe5hGnIzqMS3R
 GSubcXIJANQUOTH3AEz8rFqq1MgX700WseAcKSs3L6l59fYdjwp5+CwKLDtSVMFIM68p
 VnlA==
X-Gm-Message-State: AOJu0Yw+kM0WSl7WxE/NUY0yrSZcBEhJbL1j6BP104EInX8nPXhGjvKS
 sAvpBOdv5nV6h+Vf6LpL6NWMiHJ9Yb+gIbcraodfBu+QqfYOng==
X-Google-Smtp-Source: AGHT+IGU/irn/RhwQms+smYTPhTH6UJzMzYPAYyq73QwE/rffXF++I0/mL3bWfzeEiBRjd7cYCFniY7LcOIpGEW8NcI=
X-Received: by 2002:ac2:4f0a:0:b0:501:be89:bc95 with SMTP id
 k10-20020ac24f0a000000b00501be89bc95mr10064217lfr.0.1694463973709; Mon, 11
 Sep 2023 13:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9LrUHa5fZpRkgjYjDQft-L32Tzpa=FzOmMnLzM-q8RttqVeQ@mail.gmail.com>
 <CAPnjgZ33SiNPRdrMXmrwvRrKgi+mp+sJ+OBbu7=yDf19Gydd9Q@mail.gmail.com>
 <CA+9LrUEGqmsUL9xu0KzwgqhWptWOU1z4x3ncvXMYUJFomSv+ug@mail.gmail.com>
 <CAPnjgZ3458G_-+Nm-GzCbcVGV4uu7DNzYKd2cNQ=JFYZVS78dA@mail.gmail.com>
 <CA+9LrUF0ZjeXpG9UC3s0BLssN03wmVG3NRHG3xuXcZ=9vGnmzQ@mail.gmail.com>
 <CAPnjgZ3sgh-b-f3WVu9aWh82A4GA-L7nRuuApas=q4xMVhST9A@mail.gmail.com>
 <CA+9LrUFHH3gV29oDWW-oM0x-7Y5f1gYCMVvaEcHNJc9GHbfJ9Q@mail.gmail.com>
 <CAPnjgZ1UAui2cNZYFtdhyz_aTc+=JWN=KrGBAs866axh7_BdMA@mail.gmail.com>
In-Reply-To: <CAPnjgZ1UAui2cNZYFtdhyz_aTc+=JWN=KrGBAs866axh7_BdMA@mail.gmail.com>
From: Luis Alfredo da Silva <luis.adasilvaf@gmail.com>
Date: Mon, 11 Sep 2023 15:26:02 -0500
Message-ID: <CA+9LrUEy+qRwsv3MCSJdMGXep5tUSfStVQWyutPov88mMS45aw@mail.gmail.com>
Subject: Re: NVMe support on RPi CM4 board
To: Simon Glass <sjg@google.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
X-Mailman-Approved-At: Tue, 12 Sep 2023 02:50:20 +0200
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

Hi Simon, no problem, apologies for the quoting issue, and thank you for
all your prompt answers and some guidance to try to understand what is
happening.

Although I'm still having the same issue, I'll share more insights just in
case they might be useful for anyone having the same problem.

1. After I run nvme scan I'm noticing that the m.2 led starts flashing (it
was not flashing, before running the command it was always On).
2. I'm having the same issue on the Official IO Board and Waveshare
cm4-io-base-b,
using latest stable rpi-eeprom firmware and boot files (start4x.elf, etc),
latest u-boot version 2023.10-rc4 (I've also used previous versions, but
using the latest one because it has debug messages)

It does not appear that there is any GPIO related to NVMe. Unfortunately
I'll move forward and try other boards.

Thank you again for your help Simon.

El dom, 10 sept 2023 a las 17:37, Simon Glass (<sjg@google.com>) escribi=C3=
=B3:

> Hi Luis,
>
> On Tue, 5 Sept 2023 at 17:17, Luis Alfredo da Silva
> <luis.adasilvaf@gmail.com> wrote:
> >
> > Thanks for your answer Simon,
> >
> >> Can you check if the device has PCI bus master enabled?
> >
> >
> > I think this one will take me a bit more time, should this be in
> raspberry pi=E2=80=99s eeprom firmware?
> >
> > Will the disabled PCI bus master also be a problem for the Linux kernel=
?
> As this is working as expected
>
> (BTW the quoting seems broken in your email; also the text came out
> white so at first I thought you had sent an empty reply)
>
> Actually I can see that nvme_probe() turns on bus mastering.
>
> So no, I don't know what is wrong, sorry. Perhaps there are some
> quirks in the Linux driver which need to be added to U-Boot? Perhaps
> there is a power GPIO to set?
>
> Regards,
> Simon
>
