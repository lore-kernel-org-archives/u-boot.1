Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F57CD4958
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 06:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54CB686A6D;
	Thu, 21 Sep 2023 08:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i7IyamMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A6686A82; Thu, 21 Sep 2023 08:31:33 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7DA86A24
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-530c9980556so560144a12.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 23:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695277891; x=1695882691; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLCt1XpYEZpWIqRBikf4dTiG3IsFNfOyMtWPBoji2EY=;
 b=i7IyamMf11ikDjJiT9i+mETQyikwtcf+9uRbCpMEfBseKF0pKGpRlTfsuInrys6A9W
 pBlPRHSVz/BAsxfjhDhSz8tZt0kVbCdvnmISEoPDUBcZD8usDPXHhmWmr9zL8RHfnu5l
 EYkpbkR/sxoq9xECYiogQGhKrMQPeNAY0yY1D+8KPw6hcXH9m9XaPyonsZsX5OEL0xNn
 6F/mV8oIYWE6M8uQ/OeFdE+hvifRVyVT0xvO+C1NBQSnYzVRLBn4cMyB2e+ggT11KM+b
 qUdfZySKqqHUSKvkGGp1Tv6JJ5U4+g6XGYrMlke8cEizG7iMWnbffl14wQP7wDWsdfgM
 uf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695277891; x=1695882691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLCt1XpYEZpWIqRBikf4dTiG3IsFNfOyMtWPBoji2EY=;
 b=wQ3JU64agahi70UnmHU0WblIMl3sEWyYOZ3O7vPoEVY31DrZUxWWjz20zctalFaaDt
 5LqTyOUAOmJq0iBUnEtugYj1YYd/hrsn9nnF2/1s2jAiaEP5T6YEMEZg3vfKBmRazmqY
 5UM+DoKoQ8W/aIwwpZwcbGpuVFl5UhHV/NfGI3CmdL8OA5qjG1zG2RRaJWYqv7y3eFEm
 8drJAArWPkLKhCsT/LMGWc0wCqY2ZhiO6hT5TjcsMXcRAPbWfsgr4wkUV2Qmhoga+7Gv
 wH6SYbXsTIB0d7Fl4sJiKDwVTTwpfdFGLPljE4xPzfxPOSQ2acsEgd15REGhuAQRCQBv
 EH0w==
X-Gm-Message-State: AOJu0YwiwD40Rm/6QfhoHrXNX0erulrYdokUgcz8LSYGvNoquPBaMA6Y
 7r2Qgpwa+sbT5w/E8FFPbb9uzDKXRkWbBRXEJF9Uu2dohLk=
X-Google-Smtp-Source: AGHT+IEs4TbVvuTVPHn8M6LI3+9SOIrkTTWID7qo0lEdpWo1M+FNoMapfp3EyQDcdsYjyI22HtI7ondgMBYRmHzK/V0=
X-Received: by 2002:a05:6402:295:b0:522:30cc:a1f4 with SMTP id
 l21-20020a056402029500b0052230cca1f4mr4597528edv.0.1695277891079; Wed, 20 Sep
 2023 23:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230920030027.1385833-1-sjg@chromium.org>
 <CAEUhbmWc9us8HnNAVTsbdAQ_ykkOQxDnB1LwLFCzFR1-2opHHg@mail.gmail.com>
In-Reply-To: <CAEUhbmWc9us8HnNAVTsbdAQ_ykkOQxDnB1LwLFCzFR1-2opHHg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 21 Sep 2023 14:31:19 +0800
Message-ID: <CAEUhbmVHNoV8J2CuOa05AqVyECQfuMp=8=xpSQsJbfhR653rnQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] x86: efi: Fixes and improvements for coreboot
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Sep 21, 2023 at 1:27=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>
> Hi Simon,
>
> On Wed, Sep 20, 2023 at 11:00=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > This little series fixes various bugs and annoyances in coreboot and
> > coreboot64.
> >
> > With this both coreboot and coreboot64 start up and work reasonably wel=
l
> > on Brya (x86 Chromebook) and U-Boot can boot common Linux distros.
> >
> > - Make coreboot64 debug UART start reliably
> > - Avoid the long USB-init delay on startup
> > - Correct the timer speed on coreboo64
> > - Fix a bootstd cros bug (will likely be squashed into another patch)
> > - Fix the terribly slow console scrolling
> >
> > With v2 I have also brought in some lost x86 patches so they are all in
> > one series.
> >
> > Changes in v5:
> > - Use 'lzma' instead of 'LZMA'
> > - Drop unwanted space
> > - Correct 'teechnique' typo in commit message
> > - Make use of the uSE_PREBOOT mechanism
> >
> > Changes in v4:
> > - Fix arm and riscv
> > - Rewrite this to use events instead
> >
> > Changes in v3:
> > - Allow SMBIOS if EFI_LOADER is enabled
> > - Reword the help
> > - Use log_debug() to show the message
> > - Squash in the next patch
> >
> > Changes in v2:
> > - Update the malloc size too
> > - Add new patch
> > - Add new patch
> > - Add new patch
> > - Add new patch
> > - Add new patch
> > - Add new patch
> > - Add new patch
> > - Add new patch
> > - Add new patch
> >
> > Simon Glass (20):
> >   x86: coreboot: Add IDE and SATA
> >   x86: coreboot: Enable standard boot
> >   x86: coreboot: Rearrange arch_cpu_init()
> >   x86: Set the CPU vendor in SPL
> >   x86: Allow APCI in SPL
> >   x86: coreboot: Look for DBG2 UART in SPL too
> >   x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
> >   x86: coreboot: Drop USB init on startup
> >   x86: coreboot: Align options between coreboot and coreboot64
> >   x86: coreboot: Enable VIDEO_COPY
> >   efi: x86: Correct the condition for installing ACPI tables
> >   x86: smbios: Add a Kconfig indicating SMBIOS-table presence
> >   bootstd: Keep track of use of usb stop
> >   Record the position of the SMBIOS tables
> >   efi: Use the installed SMBIOS tables
> >   x86: coreboot: Record the position of the SMBIOS tables
> >   x86: doc: Move into its own directory
> >   x86: doc: Update summaries and add links
> >   x86: doc: Split out manual booting into its own file
> >   x86: doc: coreboot: Mention 64-bit Linux distros
> >
>
> Patch #8 needs to respin to address PREBOOT comment
> Path#18 does not apply.
>
> Patch#13, 15 v6 version are applied.
>
> Reset patches in this series are applied to u-boot-x86/next, thanks!

The CI still fails on u-boot-x86/next which is already rebased on origin/ne=
xt.
https://source.denx.de/u-boot/custodians/u-boot-x86/-/pipelines/17784

Regards,
Bin
