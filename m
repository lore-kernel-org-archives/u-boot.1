Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09631C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55ECA88315;
	Mon, 17 Jun 2024 16:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qb5OH7ek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88AAC88315; Mon, 17 Jun 2024 16:44:40 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F8088283
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b2c6291038so13842266d6.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718635477; x=1719240277; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RO2ACAJ5P/tRU1JxhInJhKUXvFhGKWnQi/zX/3S8RyE=;
 b=Qb5OH7ekTVzf0CnSC0EFdwvE5wYN26a+sTVilJmARpf33CsB0VUtlpz2rKDcZQW4Cl
 Y/9N70D1aUoeZhL9Cz2XgNsO0C8i0efpLYOfrtTx4Rhr41kGkBKfJ3ewGSsLF85nTLYp
 PSKcv+AlCIPNxuxDItsvVTFDg7i8V6yICAqp+LssBnN8NAG2sBM/LBRZCzxHdwZSyTIk
 DL1BipgzUwCA0MQnTK5YNSpRo0gNiKOzgTiheZbP8GDBIsIjqmUZ2hVVyPYjCINZGdTG
 RccQ1JdInRK40GH4o0bZwuvtU1A7EtMlAtMQfHjebiwK7WiYBU458GXnHZtJ3lWRbNrV
 jPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718635477; x=1719240277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RO2ACAJ5P/tRU1JxhInJhKUXvFhGKWnQi/zX/3S8RyE=;
 b=Wgvbfx5qj1UM7GvlgB+ZwyWM4N2cczEc/SrAsDSqiYgDsVxpbkDvfUYjL8BrlFHyOR
 /gv9nlp5M62N77rdKNV1rmIOCzi+aeHBjcGfH2A7f0XD/8X9KHAQtPMDIPWqMvNUrMBt
 r5E5/Zu9FlABQu8AMYCs8xJsN1Qv0E9yfxKJXxM3BRaeao6oCl+zZevslcDsMEKMqf/w
 mgeTJKibFydQtOpCm6j9GygWu+Dfl/J66HxOZ0iEcjkQ9u7sXBW0W69a9G3n7yfjOBvy
 k3pagzOBqrMLK9iwtugPn2mDfMerL4Q3IFqq42ZcaX3f6pU8e/on/xDZoY9hBB4fddWu
 gUEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhCcMfgcn8KTBHFwJIzrkEfHPgwqQcGWr8EGnH4YS8L4kR6wZKD2hPizDatdY8Lu/Benx/C2ZCQfFyybCsODtFyrk+9Q==
X-Gm-Message-State: AOJu0YxntQ9VgGVlsetKeLIk61qNww2sURK7isILSvmrmasUsvXnyPnm
 37j0OCG9/d9ZNO7tcIkJz14+N8qQWInr+BMHBTqtrRWzRmcFfjU1DdCz87JzjzOnVXOL3o2cs2U
 mcnwthueYb2WkzefzqQYa3xPpS0Y=
X-Google-Smtp-Source: AGHT+IEDyyuo1F57o1N96L79Ckw8Zn7qhAhrumjq1d9CYF1n1fHpx6KoJd3FKWFWeoS1BOVlfIejzBoW4LpWoNlaMtI=
X-Received: by 2002:a05:6214:8c5:b0:6b0:6ad8:ebc0 with SMTP id
 6a1803df08f44-6b2af2ff4dcmr168762986d6.29.1718635476915; Mon, 17 Jun 2024
 07:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240613080604.3828083-1-d-gole@ti.com>
 <CAFLszTji3HoiGk46hRsAka=PT-zf5suC9iCei5SEsC8QJdE5Jg@mail.gmail.com>
In-Reply-To: <CAFLszTji3HoiGk46hRsAka=PT-zf5suC9iCei5SEsC8QJdE5Jg@mail.gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Mon, 17 Jun 2024 09:44:09 -0500
Message-ID: <CAOCHtYhve9HNpB5kbdKrqQyHy5hVYLc1fWq_jHSeHQD7iCPPCA@mail.gmail.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
To: Simon Glass <sjg@chromium.org>
Cc: Dhruva Gole <d-gole@ti.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Vibhore Vardhan <vibhore@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nishant Menon <nm@ti.com>, c-shilwant@ti.com, 
 m-chawdhry@ti.com, vigneshr@ti.com, Judith Mendez <jm@ti.com>
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

On Mon, Jun 17, 2024 at 8:53=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Dhruva,
>
> On Thu, 13 Jun 2024 at 02:06, Dhruva Gole <d-gole@ti.com> wrote:
> >
> > The Kernel Image and DTB files are supposed to be picked from the rootf=
s
> > of the SD Card, this fails in legacy boot flow because bootpart is set
> > to 1:1. Fix it.
> >
> > Fixes: a200f428b5b21 ("board: ti: am62x: Add am62x_beagleplay_* defconf=
igs and env file")
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >  board/beagle/beagleplay/beagleplay.env | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> What is the legacy boot flow?

Here's the fun part.  From BeagleBoard.org, all BeaglePlay's
manufactured by Seeed has the eMMC booting via extlinux.conf.  All
BeagleBoard.org images use extlinux.conf by default for this hardware.

Dhruva's just looking to make sure it works with TI's currently
released sdk's. (So last year, and this quarter's releases..)

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
