Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2D0FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFBE8437C;
	Sat, 25 Apr 2026 21:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yG4eVm3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1A08447F; Sat, 25 Apr 2026 21:54:53 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F6D684378
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8ac9ef74131so136630766d6.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777146889; cv=none;
 d=google.com; s=arc-20240605;
 b=eP50qmNMhhYTHxq8rFjK2OsMeUmbVHGS56YuZKGoTa5gqC1ML/ZWdahvtJtQpaUPHN
 1UinGjUhESbLbOub5Nwar/dTA2/i3Mv86Vq6S7tGC8TivOYV80s8ZxRYJ6Ga8w04/lDv
 ObqAIOq6Nn6p5miPd9SP2VlxgxUvZxKsZ+2Nykj5mKVA5Jwsem+sJ5RzPplBCZMLH8ki
 gq8x9dQYJW0jl95KCKu3/PPIGlIc62672XCBKEhmIl71rAbdfYKEcCZ7frYCNi5Q3otk
 dPSahUxn101Go4GUJeNiXe2KOwRKmT/Z5RFs5BDqS3sHnPs7v+fi1V13PwHqfctGhVvO
 DZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9Pk9YWTP2K/Sa/go/y9fY/sF8s1gySf09w7haiDjqoQ=;
 fh=2RTDJNBsX8WwaWeZE6hCtyaIZqa5MUGi+LdvoukKqR8=;
 b=jWk2Zw2yV5MoBnSzeKhofT1OV+Sz9YjQ70CPRyP6f52GmYfhJZlqwQkBvkr7vFPTbr
 bdAeRQPaXOgk794o24bgM/DDS3rBXG0OQFliTIBr75P1DZaOiGUwktPmXCnAQZloF4Cg
 YvD5URL8sLuDYtGNBBxWe8/OXPYcPAj4HGRCSo5K9T04Ngtn3Fh5HBNO28V+4wP7d8yU
 iY19y7CiDoKjhc7UJl4q1AXhzMMldE4fM4cDb7IqpXBYkPavulrbJbIl/lujv43O4E4t
 Obj/e+wHcFXpdA060bvvIsUbUw1lUbe7YBIlTTxayoZrSPgKWKgyLDjr9FFV4YLU1q7S
 zosA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777146889; x=1777751689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Pk9YWTP2K/Sa/go/y9fY/sF8s1gySf09w7haiDjqoQ=;
 b=yG4eVm3tzuZ2cqEBeMuJJ4JSOoxciX7KTGh/NVYhkWx5Uq/WqlXjg3WIz26kdI6/ay
 R1GNt5uzk35O4cYv+AbbPtUQ9GY9UIxRS5I6LhYnT6Vo3Vl2z8LfR0qFraK/faPAfER5
 xV9M/JVi5OmX3EbxjG9i6x+2HKKiOTcc8CbbBbYSBg2QgLZSTa6yz9QsNMNR4Pe7hIsu
 p1eLU91Jr/UZDCpmXQDfkF8qggj998LyomRVwnKfkSgWRhBlUOPit7FcvfD3H65RWWdx
 tTFgSDVDZ2MlIglvqdDj2iM70Mya2n3sqJLU1kTqNE6blg5/30oJ99mXu3uiufH+6uwC
 Qhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777146889; x=1777751689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Pk9YWTP2K/Sa/go/y9fY/sF8s1gySf09w7haiDjqoQ=;
 b=DBrI4536QUoVTpmS92o+ZE79qO8FSKad3JBA1ebR7tLIdqqHNU6AgCzqkU+4Tuve7O
 KMBy/mNFBxkAJTyxU3L1sRXvxIGw/u3l1rK9d0aiESep28+Kwa7sghOLaN4E6QudlyK2
 pSz9D0VUJYzwZMUlpp5djx7CEK/5JC02sRSAT6avfYO/GFKHz1QKOWlhH0YftIpDgfpM
 UnxACu+boSGF3tHsaXMFnqKbeL+6rn39xEjJpfHDFomlaF0bFE0JBA8YlFui555Xf8uS
 Y1jGclxSOAcOzYx//hPVJ7Z3SQNiSfBs7e/QRDaprw8hWg8sqYV1RyJ0QjNIDuKVmxb6
 0g3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+c0houw1v2xiDZAOG1au8FhmcNiY+sDasv3SE9BwCp5x6KyrREBLeQVu/WMCBhGef7VBROio8=@lists.denx.de
X-Gm-Message-State: AOJu0YxDQOLtHBqp4hG2emJ/HFd8DGAH6B+p/No+AynIoRIYwY8pPXHO
 zpDABHOtNLXm0HHXtM9RKsT0iAmp+lSK3cMPnfvjEGCHZTCztn1EbwWSu1FIC4lEWwXHugYkjbO
 K6GbivSd4HHJdWrR9QUG69eG1ZudX9UeTbr9Gd3L2plS5e3YdsdJWIT0=
X-Gm-Gg: AeBDietGoPtm6aVgjs6vDEgCkN1agG+SKwBWK/2ZbCjigAQ8D4cQpBzFkRwaj5/2G15
 QAbY6YV9bjSux8ruNE1GnSTYWes06MN1+rYPbXfAgczS/ffwwnSUqUvYpDHbLNbo8psmtrm+FSh
 xeyoz2DnHxcUdWmmmRpywN8gEQjGUspk5/7vqLBvyw7WghbFxk9WZhYSo2Pt6R5SxFgtTRF7CF1
 QhmZqAykftlB1DxbGo26un3dSN8XgwCJ3l1Hs43pdmjQkMXIHNozJf3DMs9f1dEP+nhdLah1HLN
 nJ9wYcVbx6WHPQ6Xm7u48VNkWec0iZYutRXQn7Vzf7b/d23YWYu2J50PIZvYRCbktIkb/Oa567P
 0EQgAXVbubJw6W+bo3XC7oxkOfNWQO2bhh15Yvs1s4mnowc3Lm8E5bM38VcSPLDcsHoVyBlhUhG
 HgRMohP/tivGaLGBrvyaB1ALp4wYequ1s4AetA1jvmK4c0Fi5gDN9GGqIxRU92xuPq5ZPVOeRGc
 0UIjmj2QtiSSxkx/IN2v0NwlvCISm80l6y4QjK6ZDPv98UueWKmEgLQI0GHsQt7pevgCe13hk0a
 jvr1EanYktFu8J4Rvk7NszcICSZPhDKlD29M1jtwR25D6NXrZcwCAQ==
X-Received: by 2002:a05:690e:144d:b0:653:1c2a:9499 with SMTP id
 956f58d0204a3-6531c2a977amr24228010d50.51.1776958173461; Thu, 23 Apr 2026
 08:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-7-ilias.apalodimas@linaro.org>
 <9511039f-3c92-4b4f-b6fd-c13d48867d24@amd.com>
In-Reply-To: <9511039f-3c92-4b4f-b6fd-c13d48867d24@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Apr 2026 18:28:56 +0300
X-Gm-Features: AQROBzDKP6Oi0ShEwpTrD1RMarwEoOs6y7U3I7HTM3KdCP2rNyxmkCnvKLFywzk
Message-ID: <CAC_iWjK-nrgc5k6G4PioWb=YoLi5vJojfPLC_=N8_68RAiJNXg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] common: Add an option to relocate on ram top
To: Michal Simek <michal.simek@amd.com>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Michal


> >   {
> >       debug("Monitor len: %08x\n", gd->mon_len);
> > -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> > +
> > +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> > +             int bank;
> > +             phys_size_t total_size = 0;
> > +
> > +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> > +                     if (gd->ram_top <= gd->bi_dram[bank].start)
> > +                             gd->ram_top = gd->bi_dram[bank].start +
> > +                                             gd->bi_dram[bank].size;
> > +                     total_size += gd->bi_dram[bank].size;
>
> Here you have one problem. If the latest bank is defined with size = 0
> then your code won't ignore it and just use it. I think you should check at
> least that size is not zero.

I don't think this checks belongs here. IIRC the only reason to do
that is have some previous stage bootloader, or earlier u-boot code
update the zero length with a valid region. We already do similar
checks in fdt_fixup_memory_banks(). We should add similar ones to the
dram_init_banksize() variants. Most of the board specific functions
call fdtdec_setup_memory_banksize() anyway, which I plan to fix as
well and get rid of board code that's not needed anymore.

>
> Obviously size needs to be big enough to fit u-boot itself.

Yea that makes sense, I can add a check for this.

>
> And as I said this is one configuration. Versal Gen 2 code has by default
> configuration that it stays in a bank where it runs.
> board/amd/versal2/board.c: dram_init()
>
> Added by commit 3aebac5a759b ("arm64: versal2: Populate DRAM banks before page
> table size calculation")
> Focus on text variable.
>
> That's why I can imagine that above code can be extended by one more
> configuration to stay inside bank where actually u-boot is now.

With having the dram bank in an array we can go an extra step in the
future and have a Kconfig option with an int, representing the array
position of the bank we want to relocate. That should cover what you
ask here?

Thanks
/Ilias
>
> Thanks,
> Michal
>
>
>
>
>
>
> Thanks,
> Michal
