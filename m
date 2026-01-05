Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520D0C2A07A
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 09:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BADAB83AB7;
	Mon,  5 Jan 2026 10:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LAjFMK1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2854683CBD; Mon,  5 Jan 2026 10:46:57 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBEF783A9F
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 10:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-bc4b952cc9dso12010329a12.3
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 01:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767606413; x=1768211213; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lh91TB8ippQwS0FEUlJ2+Vs9dsb+v9VCC9J/FCIYk/E=;
 b=LAjFMK1Kqad9F2tWhnN5GjEdR0sAs7hV0OrS20F03Q1OPcvk04a10iSVwoWx5kCyQ3
 4u4iEI9HzbmqsczBsGf2MqatbG3sNRcFXWdvOf3G6cBXva8oFd+Suokl/nRaKTDpf+hT
 eKhWM1a3ZxW+W97TMzbQP+XVyzG018DRaH4/YA+mNcsR0SJrL5dy4DG2CJWro0Oa4cXU
 HuUzUfzsBrBWuCKLhAZH73mCOxuMIPdLC870EWRk7ZG5l8cDRmgAm7ofM809QJLmlmN4
 hGT/CXi9yJG30E9DYSeNlt+iw559Bjo5OgVDPTGlpdT3fDb5UuKGdHcFOHgLna6BhA3n
 7qRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767606413; x=1768211213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lh91TB8ippQwS0FEUlJ2+Vs9dsb+v9VCC9J/FCIYk/E=;
 b=ZplBdrOKpfAlZHDe0+ciTJVshc8vNoOtd5111hYLnwIm3rPcKbDIFikjwlQXiMyP18
 Ki23oUfdxo8jEdk+0fC7wlLOcTteHXY/NVmcoX/PtcWDpLwJDS2QK0wd4wscOXw5jNkr
 lRCw4cpkyt0Uh85YJBAU6UCJQfWEOdiZy/TLFD5qWnTanmNIze3Bg90M50GMyYypREtW
 SWNgHv11izSuWBz0hO7NC7LVLiQvPCKIuiExFlj7jhLchu8VB+Q1avjnZWgOyjgXPkdX
 9Ov2jG9evcTxQLYZ1QRDfblncYvC7upfvGyB6Gl9j15YGCjIHO9mbFKhmW5HKq7i6jtZ
 uJKQ==
X-Gm-Message-State: AOJu0YykaucA53ns/pEOgaPfwy2jICMaIDnXRfotd9RZTd329Htw+XiA
 50h76Pftj8PaaHoYixp+ydZg38Bbug+BnkDb8MN1QYHw96pgQU0C6ocy9j7a5UxJoy1HsaeXHhP
 nWV4z5T1DR88vEz7LCLfcwDz7z64qYfI=
X-Gm-Gg: AY/fxX5DcFDm6vTTvolu5ICmaAySCHGN2bbEUd5OJ/SzgM1Ck6dGWBJIwa1+Eu3vWPh
 8eIjp7RGdHJV1CDXH+YmiQEUqyJ4aIQAu2bZxbpoH12TtMSP0HbIAh+1o+lD1nlfA9sfuqJeJqO
 TaA15QaHYjiYmCuHU+cxezkK0zOtsEdA5JnW/p1RS539726hNrWE1uxFwGbgFhtpU42lb2t/8Cf
 qjfK3jnRwjUlB7l69SmjDt3k9I8fzA6mOEE3bvvzi/Oc++Uq0qjODrl540oewQ+oiVRyA==
X-Google-Smtp-Source: AGHT+IEqs8sahKX03fCqalQT+dvgxgG0QPW5XJPpSAbHJOsAyl7GoXmrbG6kBqb8uhMj+blA9YzaDdkg/ddqT0KEZl4=
X-Received: by 2002:a05:7300:7f23:b0:2b0:5c02:7516 with SMTP id
 5a478bee46e88-2b05ec06078mr35253381eec.15.1767606413140; Mon, 05 Jan 2026
 01:46:53 -0800 (PST)
MIME-Version: 1.0
References: <CA+DkFDbQr40f2V8eKD5cSECVTM6aZyeZNxbZMqT4SeQJjMu3fQ@mail.gmail.com>
 <20251216-left-mournful-0bdb19f7c060@thorsis.com>
 <CA+DkFDZAgjL3amMoLqSTQbbKngeBk0EMBTciBDDKrxV-UsP=fg@mail.gmail.com>
 <CAFLszThCnj+35+C1s3nFR0Rcofz7jTyymKyP9ofMTZMt2t4uWA@mail.gmail.com>
In-Reply-To: <CAFLszThCnj+35+C1s3nFR0Rcofz7jTyymKyP9ofMTZMt2t4uWA@mail.gmail.com>
From: Patryk <pbiel7@gmail.com>
Date: Mon, 5 Jan 2026 10:46:41 +0100
X-Gm-Features: AQt7F2puV4xPgh1n9Qp1bIWZtqdACOa7Y6c-ruBo8DinErXLHqtaAaXvJmMTsCY
Message-ID: <CA+DkFDZxC=i-wQqY6OV2rLO5CPFeXLWCKUYRNcDJz_AMt8eZVw@mail.gmail.com>
Subject: Re: Standard Boot integration - script validation before execution
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
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

Hi Simon,

=C5=9Br., 31 gru 2025 o 16:08 Simon Glass <sjg@chromium.org> napisa=C5=82(a=
):
> I'm not sure if this will help or not, but there is VBE (Verified Boot
> for Embedded) which uses a new phase (VPL) to verify things before
> SPL, TF-A, etc. are loaded. It has an A/B/recovery bootmeth. Various
> things have been written about it (e.g. [1]) and the docs landing page
> is [2]. There is also a conference talk at [3].
>
> While bootstd[4] was about 5 years late, VBE is a little ahead of its
> time, but I believe something like it (everything in FIT, a VPL phase)
> is where we will land eventually. As you say, you want to update
> everything possible - I would add that you cannot update something
> which might allow the device to be bricked.

I have already seen this and it looks interesting but I need to dig
into it more to have a better understanding but I'm just afraid that
I'll not make it until my current deadline, so if we decide to use it,
it will most probably be in gen 2.
Just out of curiosity - does vbe support the boot process where the
second stage bootloader (the one that gets loaded usually by boot ROM)
is TF-A not the U-BOOT? On our SoC TF-A BL2 is loaded by BootROM and
then BL2 loads the u-boot (contained in FIP).

> For security I would advise to eventually move away from using scripts
> (perhaps in a second generation as it is challenging today). Yes they
> can be signed, but there is a lot of code involved in running
> them...turning off CMDLINE almost halves the size of U-Boot and
> therefore the attack surface.

Regarding my question: the more I think about it, the more I am
inclined to implement my own boot method, although I am still not
entirely convinced this is the right approach. If I were to rely on a
boot script, I would most likely need to introduce bootscript-a and
bootscript-b, along with a mechanism to select the appropriate one.
This is clearly not supported out of the box by bootmeth_script, so I
would end up implementing custom logic anyway.
I looked at bootmeth_android as a reference, and it appears to provide
the following features:
- slot selection based on the BCB (in my case, the boot index is
passed to U-Boot from TF-A),
- support for booting in an unlocked mode (I will also need a way to
unlock the device to allow booting a customer-provided image, should
that be required).

In addition, my use case requires:
- decrypting the image containing the kernel (a FIT image, decrypted
using the SoC vendor-specific mechanism),
- image verification (handled out of the box via Verified Boot),
- rollback protection (validating the image against a minimum allowed versi=
on).

Of course, I do not intend to use this method to boot my distro, but
my reasoning is as follows: if someone decided to implement a custom
boot method for Android, why wouldn=E2=80=99t I implement my own boot metho=
d
for my distro when none of the existing solutions fully meet my
requirements? As mentioned earlier, I could move most of this logic
into a boot script; however, first I would still need a way to decide
which boot script to use (bootscr-a vs. bootscr-b), and second, as you
pointed out, this would increase the attack surface.

That said, I still have a question: does this align with the
recommended U-Boot design approach, or is there a more idiomatic way
to implement this?

Would be grateful for some guidance.
Best regards,
Patryk
