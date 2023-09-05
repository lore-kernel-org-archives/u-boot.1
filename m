Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11408EB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEA3E8669C;
	Wed,  6 Sep 2023 04:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hUUtq+4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7DFD864DD; Wed,  6 Sep 2023 01:17:27 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20251865A6
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 01:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luis.adasilvaf@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ba1e9b1fa9so50654551fa.3
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 16:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693955844; x=1694560644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5oTi+nm4hOd48oDLn1fPI7r1tRwXXlaZopUxnDl0C+c=;
 b=hUUtq+4JYLD9nC0QzH1FdTol8/XZFU6hgD4SOvcE7WldvrI4HWTG2d7HfOg4464yxK
 O1cpSl1gF6bnUuGUOV4bgowaMK0L7vdZB5u0Yvl2E0L+Iy7jBZB1nPm4BjJ839PV7eEE
 q8bjUvqxUernGwl/8DLaG0kC20uhSly4szZAsUFRUoXMn2YblrZfvJZETlmWfBTr17lS
 LJ7oPl5NnS6ru96OsXCPEQSDudJ/uFPdyx1n0xa7wbdvWQs+6aNOc+uRjbORFiOgnyOB
 Z3P4ieDyZKiafKA9yl8mieZHRmAuWjvmvPPgQITm+8KRe1RwzE27K5V37QI7UPaQsxwp
 RaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693955844; x=1694560644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5oTi+nm4hOd48oDLn1fPI7r1tRwXXlaZopUxnDl0C+c=;
 b=OKEcN9W4pTqfK2fS7z+0zctpDhTi+cqnacxAT+HRUkx9NpEUs6V8Beu001QM/GhQCt
 a4TiBC7cHbp5wxDDBUVqkDDeXVmYxD2DyIJDFADRWzuVKJ7x4ttp6/gMHztwMsXV+x4+
 i2urB9kRIKHnMOZVv3zqDzFD7JNBahxuv1wgyy0zFfux2kQWIgWk+OFig7eL9VqL9npX
 WHT1pUY8h09bRYEIHhux68ehdjakxegVvXZpwzTDnIt5wnunN64vRAgeJccghfWydsEq
 l+lo9zqXuxcw+py96cZZwxvHTOrvOl5WuG3pg7nKzcdb23zyAX+MrYUaUVqEcBUF6vjd
 Ugew==
X-Gm-Message-State: AOJu0YxZOAW7vzhPLE8X4FblWdZVy0x25cFMiXxeX8Q+/zH2yCK5urzL
 PipAAhN2mTRvZ96F3puZVq088TYqi4FrmX5YEqLY6qXN
X-Google-Smtp-Source: AGHT+IHF9VhkOy0p5k5pGy01pApGZQf9xl23jiNtzykzCVtCTef02SJxI0H62X/vl6TCo6Ko4xtHR/dvwX2Jps8mdug=
X-Received: by 2002:a2e:8054:0:b0:2bc:cdcf:d888 with SMTP id
 p20-20020a2e8054000000b002bccdcfd888mr805936ljg.46.1693955844037; Tue, 05 Sep
 2023 16:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9LrUHa5fZpRkgjYjDQft-L32Tzpa=FzOmMnLzM-q8RttqVeQ@mail.gmail.com>
 <CAPnjgZ33SiNPRdrMXmrwvRrKgi+mp+sJ+OBbu7=yDf19Gydd9Q@mail.gmail.com>
 <CA+9LrUEGqmsUL9xu0KzwgqhWptWOU1z4x3ncvXMYUJFomSv+ug@mail.gmail.com>
 <CAPnjgZ3458G_-+Nm-GzCbcVGV4uu7DNzYKd2cNQ=JFYZVS78dA@mail.gmail.com>
 <CA+9LrUF0ZjeXpG9UC3s0BLssN03wmVG3NRHG3xuXcZ=9vGnmzQ@mail.gmail.com>
 <CAPnjgZ3sgh-b-f3WVu9aWh82A4GA-L7nRuuApas=q4xMVhST9A@mail.gmail.com>
In-Reply-To: <CAPnjgZ3sgh-b-f3WVu9aWh82A4GA-L7nRuuApas=q4xMVhST9A@mail.gmail.com>
From: Luis Alfredo da Silva <luis.adasilvaf@gmail.com>
Date: Tue, 5 Sep 2023 18:17:13 -0500
Message-ID: <CA+9LrUFHH3gV29oDWW-oM0x-7Y5f1gYCMVvaEcHNJc9GHbfJ9Q@mail.gmail.com>
Subject: Re: NVMe support on RPi CM4 board
To: Simon Glass <sjg@google.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
X-Mailman-Approved-At: Wed, 06 Sep 2023 04:56:11 +0200
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

Thanks for your answer Simon,

Can you check if the device has PCI bus master enabled?
>

I think this one will take me a bit more time, should this be in raspberry
pi=E2=80=99s eeprom firmware?

Will the disabled PCI bus master also be a problem for the Linux kernel? As
this is working as expected

Regards
Luis
