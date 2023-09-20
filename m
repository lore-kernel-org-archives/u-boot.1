Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F023FCE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70B486BE8;
	Wed, 20 Sep 2023 04:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VIYskNjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D7B86BED; Wed, 20 Sep 2023 04:59:46 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5BC586BE8
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59ed7094255so12399397b3.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178783; x=1695783583; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qixgxkpBwlzBTubxThcNJuximYfCMOzi+YnFeiinutA=;
 b=VIYskNjVD9IcM2jpkAwa5vv7SsygKT2fvTuTd1um9YfC+fZvqfe0uSTQYjicX1kt41
 iI1YVdwFd+cESU3zT7r7fFQ6ulNwY1Bb8zcEdZN3OPgXzO2Kt2gvrQA7dGUErC9bmHpu
 WKCEw8n9ghWPcO29EAi2kOg3vcNW52/Mj+oLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178783; x=1695783583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qixgxkpBwlzBTubxThcNJuximYfCMOzi+YnFeiinutA=;
 b=uba0vSJlo0UbeYEIT/G3WGeawAMoKOVXeZC8HP3jEJJ0tqMy8U9pb+IZXTKm3iYNlT
 mJGrjs6v4psORY1yNkIsiLUz7o7PvBpLx/el9+SX3w0TUF5usZueaggPtNsih3R1brie
 zyUCeegTobdbBtpFSxhzKIsxpt++UOY6Y53vyf5+1xoU5CJDGlb5cdA7ORtyKQtSKRUN
 RXTyCyVRGkoRisRD+keYuJ9IkKwJ3d2/dWwZMjQQmGRSoXkB/f+Ssl2lWAu65nhc6WSp
 3EP+3d36Ze5RKbydHw2xYkoVIipFIyQtbr6lBeg0JZYKbkm5lpN38D2RmhmKWb+Wqv2O
 rX9Q==
X-Gm-Message-State: AOJu0YzRyZpFnPDAWkykefSewhLRaRttupnPo4VyLvGJuAz1VKcxmBzl
 SRt6yDhkFZYaka0KS6iDDEMzM7rXb2XXZtS8yCGUcQ==
X-Google-Smtp-Source: AGHT+IHXSm9iR1fqYex7sCd29NJA8tBUCfCSQq0AZCUmQvNbSvCbj8KfQYMW25gfRrKmkVv9p26KHw9/TlSRbH3sVEE=
X-Received: by 2002:a81:5247:0:b0:589:e586:6f0a with SMTP id
 g68-20020a815247000000b00589e5866f0amr1458015ywb.3.1695178783071; Tue, 19 Sep
 2023 19:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230910191304.191580-1-sjg@chromium.org>
 <20230910191304.191580-2-sjg@chromium.org>
 <CAEUhbmWnsbtdTaa6tktO_7cWBRXdzsftQAFk95qboVet6trYxA@mail.gmail.com>
In-Reply-To: <CAEUhbmWnsbtdTaa6tktO_7cWBRXdzsftQAFk95qboVet6trYxA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Sep 2023 20:59:02 -0600
Message-ID: <CAPnjgZ28fe4hJeBODiSqq=zqKuobmKc3kFgkVLYFB_3DgHHowA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86: Update cbmem driver
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Sadovsky <nable.maininbox@googlemail.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
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

Hi Bin,

On Tue, 19 Sept 2023 at 02:47, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Mon, Sep 11, 2023 at 3:13=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > This driver is not actually built since a Kconfig was never created for
> > it.
> >
> > Add a Kconfig (which is already implied by COREBOOT) and update the
> > implementation to avoid using unnecessary memory. Drop the #ifdef at th=
e
> > top since we can rely on Kconfig to get that right.
> >
> > To enable it (in addition to serial and video), use:
> >
> >    setenv stdout serial,vidconsole,cbmem
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Add some comments to help understand the overflow mechanism
> >
> > Changes in v2:
> > - Update to support the new overflow mechanism
> >
> >  drivers/misc/Kconfig         |  8 +++++++
> >  drivers/misc/cbmem_console.c | 43 ++++++++++++++++++++++--------------
> >  2 files changed, 34 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index a6e3f62ecb09..c930e4a361bf 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -122,6 +122,14 @@ config VEXPRESS_CONFIG
> >           configuration bus on the Arm Versatile Express boards via
> >           a sysreg driver.
> >
> > +config CBMEM_CONSOLE
> > +       bool "Write console output to coreboot cbmem"
> > +       depends on X86
> > +       help
> > +         Enables console output to the cbmem console, which is a memor=
y
> > +         region set up by coreboot to hold a record of all console out=
put.
> > +         Enable this only if booting from coreboot.
> > +
> >  config CMD_CROS_EC
> >         bool "Enable crosec command"
> >         depends on CROS_EC
> > diff --git a/drivers/misc/cbmem_console.c b/drivers/misc/cbmem_console.=
c
> > index 8bbe33d414da..3cbe9fb1a46a 100644
> > --- a/drivers/misc/cbmem_console.c
> > +++ b/drivers/misc/cbmem_console.c
> > @@ -5,27 +5,37 @@
> >
> >  #include <common.h>
> >  #include <console.h>
> > -#ifndef CONFIG_SYS_COREBOOT
> > -#error This driver requires coreboot
> > -#endif
> > -
> >  #include <asm/cb_sysinfo.h>
> >
> > -struct cbmem_console {
> > -       u32 buffer_size;
> > -       u32 buffer_cursor;
> > -       u8  buffer_body[0];
> > -}  __attribute__ ((__packed__));
> > -
> > -static struct cbmem_console *cbmem_console_p;
> > -
> >  void cbmemc_putc(struct stdio_dev *dev, char data)
> >  {
> > -       int cursor;
> > +       const struct sysinfo_t *sysinfo =3D cb_get_sysinfo();
> > +       struct cbmem_console *cons;
> > +       uint pos, flags;
> > +
> > +       if (!sysinfo)
> > +               return;
> > +       cons =3D sysinfo->cbmem_cons;
> > +       if (!cons)
> > +               return;
> > +
> > +       pos =3D cons->cursor & CBMC_CURSOR_MASK;
> > +
> > +       /* preserve the overflow flag if present */
> > +       flags =3D cons->cursor & ~CBMC_CURSOR_MASK;
> > +
> > +       cons->body[pos++] =3D data;
> > +
> > +       /*
> > +        * Deal with overflow - the flag may be cleared by another prog=
ram which
> > +        * reads the buffer out, e.g. Linux
> > +        */
>
> U-Boot is not memory resident, so this does not sound like a correct
> overflow mechanism to me.

I am not sure what you mean. This logic is used in coreboot and some
payloads, so I want to do the same in U-Boot. It basically let's
U-Boot handle an overflow properly by setting the overflow flag. A
later program (e.g. Linux) can then tell that that an overflow
occurred.


>
> > +       if (pos >=3D cons->size) {
> > +               pos =3D 0;
> > +               flags |=3D CBMC_OVERFLOW;
> > +       }
> >
> > -       cursor =3D cbmem_console_p->buffer_cursor++;
> > -       if (cursor < cbmem_console_p->buffer_size)
> > -               cbmem_console_p->buffer_body[cursor] =3D data;
> > +       cons->cursor =3D flags | pos;
> >  }
> >
> >  void cbmemc_puts(struct stdio_dev *dev, const char *str)
> > @@ -40,7 +50,6 @@ int cbmemc_init(void)
> >  {
> >         int rc;
> >         struct stdio_dev cons_dev;
> > -       cbmem_console_p =3D lib_sysinfo.cbmem_cons;
> >
> >         memset(&cons_dev, 0, sizeof(cons_dev));
> >
>

Regards,
Simon
