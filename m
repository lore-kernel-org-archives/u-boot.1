Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744DBD5E374
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 21:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E4B8392C;
	Tue, 16 Dec 2025 22:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gv0gvAT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB0483979; Tue, 16 Dec 2025 22:00:33 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 729208334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 22:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c7613db390so3121152a34.2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 13:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765918830; x=1766523630; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJVIc6sA2K8tPDxDfJ0uIDpWl+P78f2kpQ6vGyeXb5k=;
 b=Gv0gvAT14jpDgdveJun9IrwSRS8vJJPPARRa7cZMl8HEg6sL7T4T1I1L4nzqtqr8Ax
 4LGzFSi99prAsjC93OJr/ZVMPXjiteqcHopqBLplW6yIYgBtzM8Um9RjDxGwjW3oB1CM
 Uc2BkTBO2HGbkU394mDWve1AHaWnPjvgYjixaAbk7xAM8qar/S9kqTKEr94FtKe4jwIU
 hw2E9eyqEVhyk76h1/OWniWOH5dKLzyDQl2s0KqKLOEYCrAFbiMwfG8mrbyn3rbU+JP2
 lBkzyTKwJhVBe9/GNreHXS9W/FTmZ+yV2EgtNWkJ2S64PlJvqPHZUOunyZjWyLiN1xTa
 /77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765918830; x=1766523630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SJVIc6sA2K8tPDxDfJ0uIDpWl+P78f2kpQ6vGyeXb5k=;
 b=LEuuWoKLmhIFshtlJ2FKt+ioJt26/K+9Kaak4ausT+aLsgKo7o0Ar3EFlLZECfVcTb
 JslgA4NDr/dIo1RJMVih+DkDM648V/vABL/Tx+sku1Pm4gHQGaNpsOZ7x9pBB5rTrkJU
 1iW4h6DyVqSFVtG0VvRs/4JbQI2P9YqOwE2non7PvMCEJvay4QtOJLbtLh4W+cz2q7DN
 aje3fzRBB6oh2xAT0hyc4m/7lGvGFxK0c+yoii+KOQvE2bi+CkC8qG0pEabxDAnuvspN
 4UO7q/eFeJaUIRr7kBKU8PG4ndCcWBSansthUbI82Gw28N/O/koeyzyDeCRO2qtTfWDp
 6z0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRJrQy8l1xJHB3X+arXanYi6oaXHvxVvBenuYTK0jDScFVpT6GTUas+TVxe5EJMPWvffP/pfY=@lists.denx.de
X-Gm-Message-State: AOJu0YzeRixXWYX5gHk7+FjINrR5G9O8s5sGc9sxxoVLoCFdUUpVtp83
 /45ncerMswMtD2i2llFV6fnxazwtBUJhm1OltMllFjNdth4D8GEBEHfgfpG8ttGWOolkLth2n/g
 FwuJsmPO6EM0rp479+FCVD6HutXoGdaU=
X-Gm-Gg: AY/fxX7on0iK64hq1jaQqiYjhmIpuZlv/kJDXe4DdDnaDEry6PUwG/nZ8CdgkzAv/Sm
 jwfzK6R36utbgdC8tkN+uto2DGu0frBU3B/DuMiVxkh62jv9mz5ZxZ7rRLYbDmF62dXfAsPWpMl
 xKw3v/D7rXeNyrKCApp9OoIwTjMM9O0yzsAUvwwx7H7eg8DWq9iRLZy78v01nU7/rctDCuB6Pmk
 RETYd9VuBpG1uMtOtW5j4woQBCdpZvyl0QUEmQJwmSD5p3C6DVFzog1Bw9A4tiLqEr2w1iU
X-Google-Smtp-Source: AGHT+IFgg0OT2AJYmjyPKOdCfxqW0RiLaiQ4CfrRTs4GrlVsOjSspVl4cRVsgW7DCQj6yw/i38tQmhRPNpV4EUQ9vN4=
X-Received: by 2002:a05:6830:6d95:b0:7c7:5dd3:ee7e with SMTP id
 46e09a7af769-7cae839e804mr8028649a34.32.1765918830038; Tue, 16 Dec 2025
 13:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
 <CANp-EDZa0Y4NFOD2sco1xvONeLeixFQOrGLZ+hC275wMCHuF6g@mail.gmail.com>
 <CAN7C2SBop5h9WtF2GLRkWeNmLpBcDC5dHUmmR=WzRXTpr6-7VQ@mail.gmail.com>
 <CAN7C2SC7nfpDmQXjfJyZDw5m6HnfbSed+w_JNsS7+x2s190Huw@mail.gmail.com>
 <CANp-EDb+Txnrb15KuXBof6PMZp02WZ1MOy-LkrGoW-OLE8mWCA@mail.gmail.com>
 <CAN7C2SDj5yL4=tpEiG2ftjFQvrWvHSavXkz2JMJQGEgN_i4Dtw@mail.gmail.com>
 <CANp-EDZpbdkKNzvqBS_RzGbJhJ8YP7-8BK9XZe6HuPiPqgQgYQ@mail.gmail.com>
In-Reply-To: <CANp-EDZpbdkKNzvqBS_RzGbJhJ8YP7-8BK9XZe6HuPiPqgQgYQ@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 17 Dec 2025 05:00:14 +0800
X-Gm-Features: AQt7F2q4dwF9rTSNDiFI3zIIDkG4W6r2vwCqpAk-jk83KQDAn7zsv68V2wCAgR8
Message-ID: <CAN7C2SCbvD5OjkJiDpYQZGi+VLKo9JfUotwLtkaXzceyPn=Pyw@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 "Chee, Tien Fong" <tienfong.chee@altera.com>
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

Hi Ralph

On Wed, Dec 17, 2025 at 4:22=E2=80=AFAM Ralph Siemsen <ralph.siemsen@linaro=
.org> wrote:
>
> On Thu, Dec 11, 2025 at 2:51=E2=80=AFPM Sune Brian <briansune@gmail.com> =
wrote:
> > Hi Ralph,
> >
> > Thanks again. Quick test on your proposed method.
> >
> > diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram=
_gen5.c
> > index 3c79bb11802..904f9bc6d03 100644
> > --- a/drivers/ddr/altera/sdram_gen5.c
> > +++ b/drivers/ddr/altera/sdram_gen5.c
> > @@ -589,6 +589,9 @@ static int altera_gen5_sdram_probe(struct udevice *=
dev)
> >         }
> >         reset_deassert_bulk(&resets);
> >
> > +       socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> > +       socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> > +
> >         if (sdram_mmr_init_full(sdr_ctrl, 0xffffffff) !=3D 0) {
> >                 puts("SDRAM init failed.\n");
> >                 goto failed;
> >
> > Works and all debug_log and max level=3D2.
>
> Okay, great.
>
> > However the same behavior can be repeated when CYCLIC / WDT off.
> > It will fail and once CYCLIC is turned on it will pass again.
>
> So there would seem to be another issue related to CYCLIC, hmm...
>
> > So simply speaking the sequence.c somehow is so touchy on timing.
> > I do test the most common timing bin of the DDR3 die.
> > I guess there is no easy fix on this issue unless Altera do change a bi=
t the
> > sequence.c syntax.
>
> One other complaint about sequencer.c is its size... the compile code
> takes up a major portion of the 60kB size limit for SPL.

The major concern here as I didn't fully read that file nor understand yet.
If the write is possibly ruined the data via wrong address during delay
taps trials.

Then the system is sure to stall somehow. So if the SPL phase is not
100% reliant on OCRAM only then the chance is very high to stall.
For example it uses total memory of the SDRAM lowest part i.e.
0x0 to 0x10000 etc. even this could be corrupted during the test.
However before the sequence.c could possibly reach a good delay taps,
it had been stalled by other issues and never completed.

And the most concerns from the beginning of C5 devices are they
don't even have leveling aka official don't allow fly-by yet T-branch only.

So many DDR3 standards are cropped from the beginning and even the
timing training. (I might be wrong on software level but not hardware level=
).

>
> Ralph

Brian
