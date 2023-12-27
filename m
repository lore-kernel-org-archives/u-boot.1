Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D885C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 09:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA8C877CD;
	Wed, 27 Dec 2023 10:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kBLoGQGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E96FD877CD; Wed, 27 Dec 2023 10:32:48 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A46876C8
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 10:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e759ece35so2376980e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703669565; x=1704274365; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zk4lUEI6kWW9MMilP/6e1nt/8MQnmxevLaLAHUHjNQw=;
 b=kBLoGQGRGWDrJcjmu5aoXYdOK5aLGDNsEjtf8vTuad/SNXvFy7V+TbiNjYHWwZtYMH
 n8nL7KzL0iv9JwJbJ3OtmGGieTH950btENKTQ2zCF/rFzUo07AdlZPRDYuMUOndM5FkS
 NAc3Goqt9pFOm7fU0cfZKSi2v1WBpPuGut3fA9ZEFYbWacaBgOB5VTfTSsj063pel81W
 pvxkDqPhlMDAAyMWG+xJlGO7pN8uDnXDagvQpvvyaKOY/tbICgets+iKVIiXGxBZVVNM
 Vjr6bclobunVkBy5Umpah5zEkzecTzUdSy1PE9rznoodRFWhmbnS9C8BSws0ewbWOWdD
 6WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703669565; x=1704274365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zk4lUEI6kWW9MMilP/6e1nt/8MQnmxevLaLAHUHjNQw=;
 b=EmddQdx78AoREmmuoH9jexlWub/ikClD+53aybPquFuW/zibmN8lIYmiooIoWBWfcN
 iqKFpK9E1tlgCLBZq5m3GVoE6Tbs1+MDt0ngbT2OeEar+Ay7FPCtD2WZSkU5ALxx/vlu
 RmlivoVAyUq77E41GwclfOhgcbk39NvWbFUXBSf2xwi0KaUD7UZML+uJtvuroiZT1r2R
 7d4JCg9s15h4t9b6n47HWME0w8GKYSplHjAuNnDcbalt7N8jDjiomfc/wa4H9cO93Y73
 0sJf4XDJ/dQjXCHX09w4b3c8E5nK7HZocTA8Bbg8BGfbgiGEcCZ7aBZ0PdUsYWo/Lkb5
 pT5g==
X-Gm-Message-State: AOJu0YzlASd77KzaYytGtMrjSLbPCrsqlKM33SxMhgxVOisi6Oun1bOt
 CWqx4yFhdGHosVlG6WRssuAGxzWXUwmcw2HIsZgMLjc0IiLrKemj2ujndFS5c0g=
X-Google-Smtp-Source: AGHT+IFlJBtDJkJS+KzGtEDdq5DbrEcvM/pKxCjSPjFMVgN12ArUj8LI5QOEMl4RZM9CqrELSSxwi6fBEf1FwqwHmhk=
X-Received: by 2002:a19:7016:0:b0:50e:696e:14b0 with SMTP id
 h22-20020a197016000000b0050e696e14b0mr2655913lfc.93.1703669565543; Wed, 27
 Dec 2023 01:32:45 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-10-raymond.mao@linaro.org>
 <CAFLszTjGejJm4XdCachiy5C-2i2L2XyWUschx+bNy+1YpYoOcQ@mail.gmail.com>
In-Reply-To: <CAFLszTjGejJm4XdCachiy5C-2i2L2XyWUschx+bNy+1YpYoOcQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 11:32:09 +0200
Message-ID: <CAC_iWjJdtqT8dUszq6G=Ak_W4n5U9m1dkq2FryidBYg0unKAPA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] qemu-arm: get FDT from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>
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

On Tue, 26 Dec 2023 at 11:48, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg> wrote:
> >
> > Get devicetree from a bloblist if it exists.
> > If not, fallback to get FDT from the specified memory address.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Refactor of board_fdt_blob_setup().
> >
> >  board/emulation/qemu-arm/qemu-arm.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
>
> I believe this patch will not be needed, since we have fdtdec_setup()
> to do this.

Yep, it's not. The board-specific portion should be limited to what
happens if the bloblist is *not* detected by fdtdec_setup() (assuming
the user wants to allow a fallback)

>
> > diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu=
-arm/qemu-arm.c
> > index e225011bf0..d326668caf 100644
> > --- a/board/emulation/qemu-arm/qemu-arm.c
> > +++ b/board/emulation/qemu-arm/qemu-arm.c
> > @@ -149,9 +149,17 @@ int dram_init_banksize(void)
> >
> >  void *board_fdt_blob_setup(int *err)
> >  {
> > +       void *fdt =3D NULL;
> >         *err =3D 0;
> > -       /* QEMU loads a generated DTB for us at the start of RAM. */
> > -       return (void *)CFG_SYS_SDRAM_BASE;
> > +
> > +       /* Check if a DTB exists in bloblist */
> > +       if (IS_ENABLED(CONFIG_BLOBLIST) && !bloblist_maybe_init())
> > +               fdt =3D bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > +       if (!fdt)
> > +               /* QEMU loads a generated DTB for us at the start of RA=
M. */
> > +               return (void *)CFG_SYS_SDRAM_BASE;
> > +
> > +       return fdt;
> >  }
> >
> >  int board_bloblist_from_boot_arg(unsigned long addr, unsigned long siz=
e)
> > --
> > 2.25.1
> >
>
> Regards,
> Simon
