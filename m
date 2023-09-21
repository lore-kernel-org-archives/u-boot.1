Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4040CD4934
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 05:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C535686C87;
	Thu, 21 Sep 2023 07:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dvcnsm13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD6186CBD; Thu, 21 Sep 2023 07:01:15 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F1A86C68
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 07:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50337b43ee6so994328e87.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 22:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695272472; x=1695877272; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBDt45cFrX3EvutqhAT1REFtOymtSZCxVDAfjyQSF50=;
 b=Dvcnsm13F+MO69OJ+8sL9bzLzLV6bjcIbHsGMcAT9XEGmWLE7Z/iOX5b3C0QN+8Tsf
 1aCtvsec0xgxmW9ehae4+jGxoQHoHqouUmn2qmgUh5iFLCPUc0K1e2f+77y/4/dkdZ/s
 IsajGbrW3GQTJWfRjhCN1SDQxmTtNU3kr78XnA81v/w4FlnuqiLy6sXzaRuFDJW8o10K
 JtKdqI3S0I8LKQ+iOju2qzNOCSCnIxXoQxtT+Am2U5TxtvcIkXicMxKubwN23pBBJldY
 aL/d+Jp8qffG9z/VgyZqKRt20m07/CLVtV9LVbYj7EZ2AkJIFiF8S9jhU1gCdBXMg+fE
 bC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695272472; x=1695877272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBDt45cFrX3EvutqhAT1REFtOymtSZCxVDAfjyQSF50=;
 b=m5807R729v1gzLnBkEOA8u2T94uOuX3H28dtivEDHw4mK5DLa8IzCcHaDrzccgY2B/
 heCYa1JdTqHCCyF0lxjeoqjSS7xoeYJ6+Ls50l3WRFmnO1m+b9H1XoU4pcHd+nBAru16
 f/RxrvmdeDyNcEaKhQ2AJK0baR1lMCJ8DnZWjRay0om5SoKHzhG0BYw3qa69eIXAjiUx
 Q/zE+wZercQm0Ch9V2ZxuJCslRBMRoZfp7p+q0d1ch8zVtb5E4LpmDL6tlMdkmANKP7E
 WaotrkBTl1IjETH1FFNe9LMsayKB+syHxfrDw4Yz9heQguMFAmwgfC88phxAvU1qGWsi
 zpGg==
X-Gm-Message-State: AOJu0YxLnpxl9iOXOk1subtpHhJVFweCHHghW9JPjmXt+dwoohdE/IcS
 wN1UttiaESnvjXMDoAzeZ2e+flCfSmCH0OkH6yQ=
X-Google-Smtp-Source: AGHT+IHxkxvrAJTl+GxCfBTu9QcGT4ps3Bty02YB7S/qf28fJwTOpjBPmDE333w721enaBLlQvnR95gmIDVwrDeD4vM=
X-Received: by 2002:a19:ca03:0:b0:500:b42f:1830 with SMTP id
 a3-20020a19ca03000000b00500b42f1830mr3252838lfg.63.1695272471994; Wed, 20 Sep
 2023 22:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230910191304.191580-1-sjg@chromium.org>
 <20230910191304.191580-2-sjg@chromium.org>
 <CAEUhbmWnsbtdTaa6tktO_7cWBRXdzsftQAFk95qboVet6trYxA@mail.gmail.com>
 <CAPnjgZ28fe4hJeBODiSqq=zqKuobmKc3kFgkVLYFB_3DgHHowA@mail.gmail.com>
In-Reply-To: <CAPnjgZ28fe4hJeBODiSqq=zqKuobmKc3kFgkVLYFB_3DgHHowA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 21 Sep 2023 13:00:59 +0800
Message-ID: <CAEUhbmVhEV24QTkktC5=yu0=gP5BbocrycA4BLJ_mq1v=UEHgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86: Update cbmem driver
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Wed, Sep 20, 2023 at 10:59=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Bin,
>
> On Tue, 19 Sept 2023 at 02:47, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Mon, Sep 11, 2023 at 3:13=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > This driver is not actually built since a Kconfig was never created f=
or
> > > it.
> > >
> > > Add a Kconfig (which is already implied by COREBOOT) and update the
> > > implementation to avoid using unnecessary memory. Drop the #ifdef at =
the
> > > top since we can rely on Kconfig to get that right.
> > >
> > > To enable it (in addition to serial and video), use:
> > >
> > >    setenv stdout serial,vidconsole,cbmem
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v4:
> > > - Add some comments to help understand the overflow mechanism
> > >
> > > Changes in v2:
> > > - Update to support the new overflow mechanism
> > >
> > >  drivers/misc/Kconfig         |  8 +++++++
> > >  drivers/misc/cbmem_console.c | 43 ++++++++++++++++++++++------------=
--
> > >  2 files changed, 34 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index a6e3f62ecb09..c930e4a361bf 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -122,6 +122,14 @@ config VEXPRESS_CONFIG
> > >           configuration bus on the Arm Versatile Express boards via
> > >           a sysreg driver.
> > >
> > > +config CBMEM_CONSOLE
> > > +       bool "Write console output to coreboot cbmem"
> > > +       depends on X86
> > > +       help
> > > +         Enables console output to the cbmem console, which is a mem=
ory
> > > +         region set up by coreboot to hold a record of all console o=
utput.
> > > +         Enable this only if booting from coreboot.
> > > +
> > >  config CMD_CROS_EC
> > >         bool "Enable crosec command"
> > >         depends on CROS_EC
> > > diff --git a/drivers/misc/cbmem_console.c b/drivers/misc/cbmem_consol=
e.c
> > > index 8bbe33d414da..3cbe9fb1a46a 100644
> > > --- a/drivers/misc/cbmem_console.c
> > > +++ b/drivers/misc/cbmem_console.c
> > > @@ -5,27 +5,37 @@
> > >
> > >  #include <common.h>
> > >  #include <console.h>
> > > -#ifndef CONFIG_SYS_COREBOOT
> > > -#error This driver requires coreboot
> > > -#endif
> > > -
> > >  #include <asm/cb_sysinfo.h>
> > >
> > > -struct cbmem_console {
> > > -       u32 buffer_size;
> > > -       u32 buffer_cursor;
> > > -       u8  buffer_body[0];
> > > -}  __attribute__ ((__packed__));
> > > -
> > > -static struct cbmem_console *cbmem_console_p;
> > > -
> > >  void cbmemc_putc(struct stdio_dev *dev, char data)
> > >  {
> > > -       int cursor;
> > > +       const struct sysinfo_t *sysinfo =3D cb_get_sysinfo();
> > > +       struct cbmem_console *cons;
> > > +       uint pos, flags;
> > > +
> > > +       if (!sysinfo)
> > > +               return;
> > > +       cons =3D sysinfo->cbmem_cons;
> > > +       if (!cons)
> > > +               return;
> > > +
> > > +       pos =3D cons->cursor & CBMC_CURSOR_MASK;
> > > +
> > > +       /* preserve the overflow flag if present */
> > > +       flags =3D cons->cursor & ~CBMC_CURSOR_MASK;
> > > +
> > > +       cons->body[pos++] =3D data;
> > > +
> > > +       /*
> > > +        * Deal with overflow - the flag may be cleared by another pr=
ogram which
> > > +        * reads the buffer out, e.g. Linux
> > > +        */
> >
> > U-Boot is not memory resident, so this does not sound like a correct
> > overflow mechanism to me.
>
> I am not sure what you mean. This logic is used in coreboot and some
> payloads, so I want to do the same in U-Boot. It basically let's
> U-Boot handle an overflow properly by setting the overflow flag. A
> later program (e.g. Linux) can then tell that that an overflow
> occurred.
>

Okay, I modified the comment to

       /*
       * Deal with overflow - the flag may be cleared by another program wh=
ich
       * reads the buffer out later, e.g. Linux
       */

which makes more sense.

applied to u-boot-x86/next, thanks!

Regards,
Bin
