Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8174ECD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 11:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E178483FF5;
	Wed,  3 Jun 2026 13:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dEppO/T5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E898469D; Wed,  3 Jun 2026 13:02:56 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F4D83EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 13:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-beb2a97cc9aso815093466b.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 04:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780484574; cv=none;
 d=google.com; s=arc-20240605;
 b=khJ5PFlHFZXqCXwpOWBpo6ElLQSD3KQ8WktMzLeGMc55hKEVY4HmQOqDXhAR9o5Bhn
 QZ574TvsWOlDjQ/K7RRI86JPGrP+/1CsK243Mlcep73QEqNOL+V1iyKd2K3epW0s61kr
 bUkSI+iUkVCW3ZBxXih5KQyUM83I309O6QXzzZqMIw4Sk0Ta8PZZsejQ72PQos2XLB9+
 JQRPX1V/au38mgPOCFJW5runzJ1kSNP2nQNlsQ1srz/W/LjhjKZkHZUiMNOPI3lup1QT
 oUQQ8i1xrRD3m1/bJzqAP9jUIGY/2Hv2NUNIMYpL7f7VqEBhKHitUsk74vcBXJM3fFoE
 cVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QjnSJFiHc/3oVS8JJOjoQrqc4vehDaE+53rCY6MzxyI=;
 fh=joAhEEwbgVgYRptP/lZfvtT9M/FhYInuc7h7PE6FMuo=;
 b=Y21kJUVnexeNuVMWEkjNKjSNocsthKyRxARjy5dmWgVy/UL2mvYmHW2FZLr09TNRCP
 g+xkgVq1Tew+hmrvxqFXVNyjNhf3aBzltrAHFxYhuDGfBcb+pzQ+rk23e6k2t1mVdXnn
 LTatBQD/EZtZvVeDmSphLb4GFy4PxnHFjMHA1PvzRdAqa0ZUKqJiHqbVAvxB8jLAnyw2
 rDlRak63UGbGf98R/2Cljzttrb/Bh5wwFuRiFtTyp8As5RKZlnTslBGpcQ/NsiNfV4Ci
 Zo1sjeDIfuZz5CQBjdRGRZevO6VDqMM5D1dOkD2uS4/Oe7QocjlYwcswXmbCXZlQDcO2
 U/ng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780484574; x=1781089374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QjnSJFiHc/3oVS8JJOjoQrqc4vehDaE+53rCY6MzxyI=;
 b=dEppO/T5sC7HAaHi7grGKFbe0Cg6VY6c7F7N73OGtuWjkyMxgStCIeijNnaCz1y/EA
 1hXQI/sHaeSYHV/+C/nnUN/rgzHyLnoT4ZSSXyIqZ1OPiDTu1d58iC2AtMRo/0rHQU5V
 ibWuRoJLvKXbt6MLnTwTrhdNmLSQOltb9YhsYT9xWRUCnkgdSr4CkBSWAPgFlWLfyZm9
 S5rybzhZVH/59uxy5NW7VBD/kenC+3aycezYQuOjhGN8s2S37rz4iqVVWw3irB2DgYGd
 A77wEAZnkw47OR8khGFe88qZTnMSaR7ZDzZT2eQlAaAHokKosl/vuIUDD9HceEypwifq
 tR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780484574; x=1781089374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjnSJFiHc/3oVS8JJOjoQrqc4vehDaE+53rCY6MzxyI=;
 b=etV7DWm6dYucWMSuLAtznuG12VlZyrUqwLQT4agv9D6nYsO/uU+Qw/2J8sMP/OlXLP
 g78Y3P4H9TlE2H09MHfu7pqLtp6x+k7IKT4XHfcaJanGBpUWltRCZIr4VQs4JuKlLQL6
 +qGaxKkRC92uMwyi9LtxTxaG2cVVuevy9mjohnGHBkZyM8tD7Imv+XgrFzMPj6AffrJs
 dohta1Gchxd6yWAxR6ItDAEnDU9QHKfaZPLNj5ecAfGOnIkkAG/ZhuSppvVAzRj1+Jmy
 FPl2hatyVYr9f8DuDCus22UQvRz5klQdAWPd2hgLUdQ9U3BOnYAKvq72F3PORto9i+QK
 R4FA==
X-Gm-Message-State: AOJu0YyCCaQ/tTUou/TQaiGoMZ1eaOSZjxO+AD7UuZNYFF5CyJp84KS6
 zoDhfxaNdU3KrrmdQSGL/N+Me5qWZ315RxICuYNMPqYhZCMUFC//Z/jeP3MPKa4XsLO0JRtI5KO
 R43knRNM6U4s5YsQ3i9mReVTydS29eS8=
X-Gm-Gg: Acq92OFpv7L5OmbJnow0AFKgHnfNmMgdOzHT+iaw2ZYJ2o6KhwO+G/pkaGFcbowvFM7
 R+EkJBenZiWlnIoPrUTZSwRrNeSfmF+zZSeflOQ9gXXyq/eiU5NqFELDZObsGg4fPUG5GIMrBn9
 a17B/cMCSB/t51ILch+dOMT1KsU08AmrHTuM8j5tOhJZ7F2Zo3oDtVbAPgB45JAFZoe8gI4iy+D
 xpmj0i+Lr2vvGSkhhx30X+omEXisPJ3uMF2iRCcPzLAo5xH/i05ZhHvFo1/BMGHjV3mZ4Ndoz5N
 JgZwCYXmqmB+NpwurOrqjLp+R/uGEjQ2ElA7Ez/+UuwIUugs1L1TpPg2mnnMvML7Dh3lgBJJVLE
 EnSD6SqdEhM/7EaE5xhEhNGArXC0V8NdBIZlTFepSosRgchRSOp7A0QMswLcx4h6GaSoAA5oObm
 BNuasQqV6h4J5c
X-Received: by 2002:a17:906:7952:b0:bed:1876:975 with SMTP id
 a640c23a62f3a-bf0b32b84fcmr149605066b.28.1780484573863; Wed, 03 Jun 2026
 04:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
 <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
In-Reply-To: <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 3 Jun 2026 12:02:42 +0100
X-Gm-Features: AVHnY4Kmks1YhapKcTgIgkt5eejLciOXSlDHjzdwl2rJylUIiWsFMiwJ6f5PmK0
Message-ID: <CALeDE9O4G21o2Onc=OpdwYO7o2PB7eS9u9JfE4nQjRFfRO4SrA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

On Sat, 30 May 2026 at 16:06, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 5/30/26 4:45 PM, Marek Vasut wrote:
> > Some architectures can not DMA above 4 GiB boundary,
> > limit available memory to memory below 4 GiB boundary.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Heiko Schocher <hs@nabladev.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.denx.de
> > ---
> >   lib/Kconfig |  8 ++++++++
> >   lib/lmb.c   | 20 +++++++++++++++++++-
> >   2 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 77ebc79e1db..29911068a69 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
> >         memory map. Enable this config in such scenarios which allow
> >         architectures and boards to define their own memory map.
> >
> > +config LMB_LIMIT_DMA_BELOW_4G
> > +     bool
> > +     depends on LMB
> > +     default y if ARCH_BCM283X
> > +     help
> > +       Some architectures can not DMA above 4 GiB boundary,
> > +       limit available memory to memory below 4 GiB boundary.
> > +
> >   config PHANDLE_CHECK_SEQ
> >       bool "Enable phandle check while getting sequence number"
> >       help
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 8f12c6ad8e5..a8a988eedc0 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -611,6 +611,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
> >   static void lmb_add_memory(void)
> >   {
> >       int i;
> > +     phys_addr_t bank_end;
> >       phys_size_t size;
> >       u64 ram_top = gd->ram_top;
> >       struct bd_info *bd = gd->bd;
> > @@ -625,8 +626,25 @@ static void lmb_add_memory(void)
> >       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> >               size = bd->bi_dram[i].size;
> >
> > -             if (size)
> > +             if (size) {
> >                       lmb_add(bd->bi_dram[i].start, size);
> > +                     if (IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))
>
> This conditional should be inverted.
>
> Peter Robinson , can you test this change on RPi ?

That doesn't fix the problem for me on a RPi4 4GB or a RPi5 8Gb.

> > +                             continue;
> > +
> > +                     bank_end = bd->bi_dram[i].start + size;
> > +
> > +                     /*
> > +                      * Reserve memory above ram_top as
> > +                      * no-overwrite so that it cannot be
> > +                      * allocated
> > +                      */
> > +                     if (bd->bi_dram[i].start >= ram_top)
> > +                             lmb_reserve(bd->bi_dram[i].start, size,
> > +                                         LMB_NOOVERWRITE);
> > +                     else if (bank_end > ram_top)
> > +                             lmb_reserve(ram_top, bank_end - ram_top,
> > +                                         LMB_NOOVERWRITE);
> > +             }
> >       }
> >   }
> >
>
> [...]
