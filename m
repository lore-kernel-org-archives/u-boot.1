Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8E4CD494E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 05:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F2C86D22;
	Thu, 21 Sep 2023 07:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xa3ce3yN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F39286D1D; Thu, 21 Sep 2023 07:27:25 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8641A86D01
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 07:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-532c3b4b55eso532562a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 22:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695274043; x=1695878843; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24ZclSgEwhZoCysES3xieFjQ2rLfgKDJWpQq7EgY/5k=;
 b=Xa3ce3yNSuvR/v/70obgnRHZTf7DUSEGcYvk/ZEiyyovIVbM/hqkXnKzrcFI1Bmds9
 URTO+SDDiO4u43KpY/arDbexaJe3rm+WFsu6gy2ZWJsgqqMCe5JZxvC6RyyfbZS/3POY
 0VMEBzT5kc/5G84nqillOuqUXe5WoPJNyRvihpASdt8YB+ya4xAjfEr5lmTvFXq0RkF2
 S3qBuQVEFVPPvT8uIUXED6IFlz/VXUyo8zvIQ9VYFtY3Q0wsltIGFoL7TLgoaNAgaFbI
 I4LDQ/zRqtfm6JT3Q0RQfDIKJ2aaIGJj1vaRIUka3H7DHHP/ctkEt0RGuz3pnWZ9wqU7
 90oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695274043; x=1695878843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24ZclSgEwhZoCysES3xieFjQ2rLfgKDJWpQq7EgY/5k=;
 b=SqhFXc0rWsleIIPHiC8yQoCvrn4oUs+6wvR4Fn4CYwaKYbVlEv/InsFrfJ4nBsw1Le
 aq1OUYf92plfOMe6etmuo4vcs7xLcTI3QDfqG2Xm4vhLtBe/i/KBvPF0VwIJYX0VtZ91
 DINlnXcQ/VPJRU34PKzmBBgeRNJq+moK0FVw/c150d4eHYDdzZ2Ikk7CLJjuIn01YmCh
 n+Cda9uZO745qHgsNrrqLs36GRravKo0Exy8Abr11NJUdysASZ2+wiiHL7JQWD8r8G5j
 sFu/dfTsnmwhxC57KuTMUR28lytePpVs3Jp4FKawvHw8lvohXqTuV384hz9R4OyMURUp
 JGKw==
X-Gm-Message-State: AOJu0YwIa+aRfM618kGRMpS0f+d8OSjD0xSz6M9uS2VqTc10j/njmA3Y
 SWFeF4IseR9hDuYIYVWvMPDWfLfJC5CGFswUrYY=
X-Google-Smtp-Source: AGHT+IFn/eFVvFD0gxq1Uti6TpOXw7zHyFFNTjmQjZLz7WTmTeuiPTPwaDIvd0DEd8J3W762yLXVYIJOuc8CpTy7WEY=
X-Received: by 2002:a05:6402:3204:b0:533:2449:7a59 with SMTP id
 g4-20020a056402320400b0053324497a59mr2450388eda.11.1695274042949; Wed, 20 Sep
 2023 22:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230920030027.1385833-1-sjg@chromium.org>
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 21 Sep 2023 13:27:10 +0800
Message-ID: <CAEUhbmWc9us8HnNAVTsbdAQ_ykkOQxDnB1LwLFCzFR1-2opHHg@mail.gmail.com>
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

On Wed, Sep 20, 2023 at 11:00=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> This little series fixes various bugs and annoyances in coreboot and
> coreboot64.
>
> With this both coreboot and coreboot64 start up and work reasonably well
> on Brya (x86 Chromebook) and U-Boot can boot common Linux distros.
>
> - Make coreboot64 debug UART start reliably
> - Avoid the long USB-init delay on startup
> - Correct the timer speed on coreboo64
> - Fix a bootstd cros bug (will likely be squashed into another patch)
> - Fix the terribly slow console scrolling
>
> With v2 I have also brought in some lost x86 patches so they are all in
> one series.
>
> Changes in v5:
> - Use 'lzma' instead of 'LZMA'
> - Drop unwanted space
> - Correct 'teechnique' typo in commit message
> - Make use of the uSE_PREBOOT mechanism
>
> Changes in v4:
> - Fix arm and riscv
> - Rewrite this to use events instead
>
> Changes in v3:
> - Allow SMBIOS if EFI_LOADER is enabled
> - Reword the help
> - Use log_debug() to show the message
> - Squash in the next patch
>
> Changes in v2:
> - Update the malloc size too
> - Add new patch
> - Add new patch
> - Add new patch
> - Add new patch
> - Add new patch
> - Add new patch
> - Add new patch
> - Add new patch
> - Add new patch
>
> Simon Glass (20):
>   x86: coreboot: Add IDE and SATA
>   x86: coreboot: Enable standard boot
>   x86: coreboot: Rearrange arch_cpu_init()
>   x86: Set the CPU vendor in SPL
>   x86: Allow APCI in SPL
>   x86: coreboot: Look for DBG2 UART in SPL too
>   x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
>   x86: coreboot: Drop USB init on startup
>   x86: coreboot: Align options between coreboot and coreboot64
>   x86: coreboot: Enable VIDEO_COPY
>   efi: x86: Correct the condition for installing ACPI tables
>   x86: smbios: Add a Kconfig indicating SMBIOS-table presence
>   bootstd: Keep track of use of usb stop
>   Record the position of the SMBIOS tables
>   efi: Use the installed SMBIOS tables
>   x86: coreboot: Record the position of the SMBIOS tables
>   x86: doc: Move into its own directory
>   x86: doc: Update summaries and add links
>   x86: doc: Split out manual booting into its own file
>   x86: doc: coreboot: Mention 64-bit Linux distros
>

Patch #8 needs to respin to address PREBOOT comment
Path#18 does not apply.

Patch#13, 15 v6 version are applied.

Reset patches in this series are applied to u-boot-x86/next, thanks!

The reset

Regards,
Bin
