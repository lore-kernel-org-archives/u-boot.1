Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DFCC46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 08:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EBBC87835;
	Fri, 29 Dec 2023 09:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g2Fmgyip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5845687A8B; Fri, 29 Dec 2023 09:26:33 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E83687732
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e3338663b2so45944997b3.2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 00:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703838390; x=1704443190; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fT7C9yG5yqNI5T5G+r30KEZ1rW40l8Bubq1Gs+Qu4sE=;
 b=g2FmgyipRGd8LcFCTN9Nwkf1d/hb6KFM0ZsiH95zptYDnwLRd8MEXpkjg3RIPEDWbv
 IPusGrwBilI3aCZfaLqikU9co+35Yqbs/S+mSlRr3rUd1ClfdQVXYrQctn99tc/Z1Rh3
 mz7qHVYs59EUjy9FVSm1PSVU2x2Z4YR865VOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703838390; x=1704443190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fT7C9yG5yqNI5T5G+r30KEZ1rW40l8Bubq1Gs+Qu4sE=;
 b=ucQ0ODyPyZsnk0oCWxv45N48hW6oPGYRsQVE7bpCe/5vK28LnUCgLHFQ1HzXUsJIrA
 9L12NjsZy5Oo1qwhU8/AtHYmBHF8dfnKW1aTcQnr4nKqbZFYW52lPzKdbXXDgw2gN3HT
 sEI/KN0r+oOuCkwaeU+Z+D9WtUtTKgH5BjwU8bdswQiJ7iMZrZxKzemnsorPPnO42kEH
 3IWb0QHu+K8cNtkU1GNYZ2/Nl5SstjvleiRTJtueUkfqLOTx/3lwL+M04Zk97xKozR/G
 GZfIXLEXCQV6HOoN9XZY7U/oddLOGzpu5Ld5DOSfPgDXWOCaObGWV574VTLQCapnQXtL
 i7dw==
X-Gm-Message-State: AOJu0Yx0+/QpcGaa/DZIZ39gMTJ2UQ+ciX51vu0aHuePBE3kzNqThfCH
 a4mZuXFHhNMiGmssr0XWbL0fB8nLSK7OGi/2Jd7LKqUdvqW+/q8n/IE5bp4L0g==
X-Google-Smtp-Source: AGHT+IEsQtTnPKq3EVotuDYbA2mRNRYe3uU0BKfQVoaM7ws5/HW96EyOEean3IiadAM9kExxNdq6i1y73+BukvqV2Fs=
X-Received: by 2002:a05:690c:3144:b0:5f0:6b75:68dd with SMTP id
 fc4-20020a05690c314400b005f06b7568ddmr55016ywb.21.1703838389999; Fri, 29 Dec
 2023 00:26:29 -0800 (PST)
MIME-Version: 1.0
References: <9f681497-d13c-4ccc-9209-7a8b33e3195c@gmx.de>
 <CAFLszThsThxhWCgP+UHmA5BxRUUBfDP7SDahtAm5WOrHoT0xhQ@mail.gmail.com>
 <e9a835ea-ea99-4db2-b5ad-ba7742397d46@gmx.de>
In-Reply-To: <e9a835ea-ea99-4db2-b5ad-ba7742397d46@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 Dec 2023 08:26:19 +0000
Message-ID: <CAFLszTg17_xPGWMDG=1X+q2UTdJ_kO2pUshmDLt+cv9uPPcgJg@mail.gmail.com>
Subject: Re: ACPI: usage of sandbox virtual addresses
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Tue, Dec 26, 2023 at 10:03=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> On 12/26/23 10:50, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, Dec 26, 2023 at 8:56=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> >>
> >> Hello Simon,
> >>
> >> currently we use sandbox virtual addresses in all ACPI tables. This
> >> means that an application started by the U-Boot sandbox consuming thes=
e
> >> tables will crash due to accessing invalid addresses.
> >>
> >> Shouldn't the ACPI tables be migrated to use valid pointers?
> >
> > The confusion arises due to the difference between addresses and
> > pointers. If we store addresses in the ACPI tables, then things should
> > work.
> >
> > My approach has been to avoid using casts, but instead use
> > map_sysmem() and mem_to_sysmem().
> >
> > Which particular piece of code is wrong in this case?
>
> Tables DSDT, XSDT, RSDP, FADT in the sandbox contain sandbox virtual
> addresses instead of pointers to real host memory.
>
> All code referring to these tables should be changed.

I'm still not quite clear on this...can you point to functions or
lines of code? When I look at acpi_add_table() it does use memmap, but
perhaps some parts are wrong?

Regards,
Simon
