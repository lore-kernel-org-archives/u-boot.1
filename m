Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF2AC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C5B68641A;
	Tue, 23 Jul 2024 16:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s0dpcTiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A65F38641C; Tue, 23 Jul 2024 16:30:30 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B0086419
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39641271f2aso20062395ab.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721745025; x=1722349825; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4pmetmBWaNzr1KFEIonQSQzKH66yU2z9Ws2dB+OBWNY=;
 b=s0dpcTiQr2YS/veI5IbP7dY9w2xJ1mhaoKY43kpPgMW80SCIyPlrEu5Sb3zkQu4+X5
 Ol8tVdTnl46KSLWskiFOmoZZyhBwJleXMHIg/OmLWt9A/LATzKqPuFoCd1Ip9SZRqXKJ
 IzbIg2DJ/sdn82ylvkUuP3r6DKUH5PS5rt3fzq1UXHFY8guR7zrduc6yXVla8SEVHcqE
 /3HXn+NKiI6I4Mrhqiu8boU0VuaPj/OAV/A6FjV/7TuaRmpSuj0dfpxDkWKaM0pFNmRs
 VVjF/ba5oIb4SyvOzs41XQrb6XIlYuDdHye0iQFqiERvT2/jib79NflyifMu0c4JsWZ4
 CW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721745025; x=1722349825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4pmetmBWaNzr1KFEIonQSQzKH66yU2z9Ws2dB+OBWNY=;
 b=SA8RSNkC7dTcX3ChhswEU0oTSoXOCjj6kaY3tFIC8Ml2xjrEE0epAuKASPxWk+gAAp
 ib9JC2GuQ3aXdfOWXWMTgn4qVRol8fhxGyctFsw40AZReQIS5obXutarP1LLxHfbXgGd
 h2vCGLKqeNVtx+oJNBDkq/hJ8o+k5lKQ693hDFCmdsSC7x88bi6/AaOES/JH+GZWF42l
 pmbGj7BQfg20yGlySwafbIggCmr9zPMsi8beF3aCHWyeOTuRz9BYoa5Q3ATM6xBtvPAq
 NrhUy579S+M29vCcNRp/0A2xqh1ObxjJdOw9zwtPzTk3/1Z4yG8cM8KLWSZHkzqYeQib
 Tb7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUelxie54n9/7VhCJkvlXr5s8fCW8F7j5uJd7oPfvUE+4/a0aOMgY0c04T0EaXeTTd30i6RMTZ7AOXIukL2s7+ZMlQdAQ==
X-Gm-Message-State: AOJu0YwnAxmUAjv3a8J0fqWR4ThebxyrkRYrYAUoAO+GnVoi6/MuQ80N
 T+gBJtByUM9Lhu5s/a6lw9jI0rmPNJp63GzmRER5CTZ/vOoqyAOZ4mmbPVnOQPbet0tMV5Mtq9e
 DhnHCYgVNjUM0izdrrM+pkLAfB57oILaP1BQqjw==
X-Google-Smtp-Source: AGHT+IGtBugeGt+RZ/FafrIbdI1TeT5y11S2mg8Yf8cq1K6iRKWSjG/F3tSq5q+/m9nLLAI7QVhYl2lQePe7keOm54c=
X-Received: by 2002:a05:6e02:154b:b0:398:f487:5a04 with SMTP id
 e9e14a558f8ab-39a16c35e26mr1222415ab.11.1721745021189; Tue, 23 Jul 2024
 07:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240723104634.116082-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKUpjQP_4kCPMAaotuQ4uRKb3bG=zVhdaU-Eb=85hbt2w@mail.gmail.com>
In-Reply-To: <CAC_iWjKUpjQP_4kCPMAaotuQ4uRKb3bG=zVhdaU-Eb=85hbt2w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jul 2024 17:29:44 +0300
Message-ID: <CAC_iWj+=O6FY9pWxQOGvZjLsKN-fhD8PJ_CxyYm92YEY4yMeqA@mail.gmail.com>
Subject: Re: [PATCH 1/1] smbios: add extended Extended BIOS ROM Size
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
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

On Tue, 23 Jul 2024 at 17:12, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich,
>
> On Tue, 23 Jul 2024 at 13:46, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > U-Boot claims to create SMBIOS 3.7 tables. The type 0 table has
> > a field Extended BIOS ROM Size since version 3.1.
> >
> > BIOS ROM sizes of 16 MiB or above must be written to this field.
> >
> > Add and fill the missing field.
> >
> > This patch does not cover the case of a ROM >= 8 GiB which cannot
> > be configured in U-Boot.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  include/smbios.h | 1 +
> >  lib/smbios.c     | 9 ++++++++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/smbios.h b/include/smbios.h
> > index a4fda9df7bd..00119d7a60c 100644
> > --- a/include/smbios.h
> > +++ b/include/smbios.h
> > @@ -105,6 +105,7 @@ struct __packed smbios_type0 {
> >         u8 bios_minor_release;
> >         u8 ec_major_release;
> >         u8 ec_minor_release;
> > +       u16 extended_bios_rom_size;
> >         char eos[SMBIOS_STRUCT_EOS_BYTES];
> >  };
> >
> > diff --git a/lib/smbios.c b/lib/smbios.c
> > index 4126466e34a..e2a2f873a94 100644
> > --- a/lib/smbios.c
> > +++ b/lib/smbios.c
> > @@ -348,7 +348,14 @@ static int smbios_write_type0(ulong *current, int handle,
> >  #endif
> >         t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
> >  #ifdef CONFIG_ROM_SIZE
> > -       t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
> > +       if (CONFIG_ROM_SIZE < 0x1000000) {
>
> nit, but can we use SZ_16M instead? Then the comment below goes away
>
> > +               /* CONFIG_ROM_SIZE < 16 MiB */
> > +               t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
> > +       } else {
> > +               /* CONFIG_ROM_SIZE < 8 GiB */
> > +               t->bios_rom_size = 0xff;
>
> If the size is above 1gb we should also change bits 15:14. I guess
> being above 1GB will never happen, but can we add a comment?

Ah scratch that, you only convert and report mbytes, so that's fine

With or without the nit above

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Thanks
> /IIlias
> > +               t->extended_bios_rom_size = CONFIG_ROM_SIZE >> 20;
> > +       }
> >  #endif
> >         t->bios_characteristics = BIOS_CHARACTERISTICS_PCI_SUPPORTED |
> >                                   BIOS_CHARACTERISTICS_SELECTABLE_BOOT |
> > --
> > 2.45.2
> >
