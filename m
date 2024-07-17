Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4512DC3DA49
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 02:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D35E88A06;
	Wed, 17 Jul 2024 04:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ffec+CmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3458880F; Wed, 17 Jul 2024 04:24:05 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C148863C
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 04:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-70847d0cb1fso3456132a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721183041; x=1721787841; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mNLCspIeqKsg9N9q9Z34kOcaw8kzX7+fzpunTwlgusU=;
 b=Ffec+CmC1WU6Bv8nxhAJ8h8pWLok3WaQvNU6vBXysSRlPjv++W7EL3v+ZjXZpiD685
 i3dgPY/34kmF+AIHUEVqRmIP30TBD0c5SigEJWhOo/7AamZyqMILdh99iKRmQWAyqg3K
 saPKEBc+SyvJNllpzZNMDtTLmpaOFMbGu6GTtswMfDyN/UFNlCNe/o5vEE0EgLkRdja0
 i6EJE1WQySCvu+Q6Wfc/oaiPXtRhM3AMqmhleeZvC7E0uNBrJO3MUqS9QGl3Q5Xwdrvl
 N0tcskVS+tp7odTqcwHMnf+o5Fl4C0YmyvgeN7f63plF1FCSZ7qYmWubWf0dI12L6kdi
 QDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721183041; x=1721787841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNLCspIeqKsg9N9q9Z34kOcaw8kzX7+fzpunTwlgusU=;
 b=eApxAJPoB6OzKJre9tSTvqpTm3gwU3kAY8K7dqd8HqaNL63/R94Smj74y/K5ZuZL5e
 5vh+UzC4jMVhgeon+DCL8ilMc7N6qBxRfhi1MTiFP9diApT3KnJujg4Q+DwEbU64NcDm
 mygoK/PMsLNq1Bj3dUN11qvbx7Ak1eNDQYv0EOV/4mBnzbYKRdNOzPjKDx+MbZnKkVYc
 XOdLV2zUaDUaG/644MdhMSoGfTqRoMR+i7QbVAqCie3jVDuG9LtIxKBgYU/VZmDSn4qN
 bilame+jQmFFvtPUCJNqDlYNlmbWH2q0EWRUIq9+RRXf5DYzmEl1iSgPHSAHFGuVORw9
 VIaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+sGmIk6rID0YilKVguDKhvazGpZgcZJnkGUm9R/eu42a75kSVRAJyooffc9kSZMvVW2G3/L/e3jn7ibjhsfuVfTtL8A==
X-Gm-Message-State: AOJu0YxUicmWGwTHmD7baDW3G9bZnOvfslcwh/UqNX8+eZZUU9sQaUEv
 0q3hvqwdrlHbEH6YJ/U0c439G3U4vckeYl34HLkNPGdIIDSZqQHifRToesVUOzgw/i64zlov1a9
 jRBjtfmdjA3Pdse01R4py3jCASCk=
X-Google-Smtp-Source: AGHT+IGNA+5Nz/+Q/kJTXBp5CmeER7/vAruBSTvPIEUOmZURt0uIqT4a0lNcLNlGeHYD4CA58oVAl31qnjbZe3r4vJE=
X-Received: by 2002:a05:6870:3d96:b0:25d:fab0:b6f4 with SMTP id
 586e51a60fabf-260d917e4aamr306388fac.1.1721183041036; Tue, 16 Jul 2024
 19:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240626151522.83561-1-linux.amoon@gmail.com>
 <CAPLW+4kqcLVFxxdGL8V66TquKEtPz0VX7NyejAYS=reJmjJWEQ@mail.gmail.com>
 <CANAwSgT3nEwKytX-6D3YSWvEu8G=PxAk-SCp8YBaNf+SFjCywA@mail.gmail.com>
In-Reply-To: <CANAwSgT3nEwKytX-6D3YSWvEu8G=PxAk-SCp8YBaNf+SFjCywA@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 17 Jul 2024 11:23:49 +0900
Message-ID: <CALrBrZ2Dp4D97VBxzn0GuWeCkz26-g9Z4p0+wXkxxx7T11JR0w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dm: exynos: Correct CONFIG_SYS_BOARD setting for
 Odroid XU3 boards
To: Anand Moon <linux.amoon@gmail.com>
Cc: --Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2024=EB=85=84 7=EC=9B=94 13=EC=9D=BC (=ED=86=A0) 16:51, Anand Moon <linux.a=
moon@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi All,
>
> On Wed, 26 Jun 2024 at 21:07, Sam Protsenko <semen.protsenko@linaro.org>
> wrote:
> >
> > On Wed, Jun 26, 2024 at 10:15=E2=80=AFAM Anand Moon <linux.amoon@gmail.=
com>
> wrote:
> > >
> > > Fix the issue where CONFIG_SYS_BOARD was incorrectly set on
> > > Odroid XU3 boards, causing boot failure. This was resolved by
> > > correcting the SYS_BOARD entry in Kconfig to load the correct
> > > device tree source (dts) for the Odroid Exynos5422 Platforms.
> > >
> > > Fixes: f76750d11133 ("Convert CONFIG_CONS_INDEX et al to Kconfig")
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > U-Boot 2024.07-rc5-00042-g80a111f426 (Jun 26 2024 - 15:03:09 +0530)
> for ODROID-XU3/XU4/HC1/HC2
> > >
> > > CPU:   Exynos5422 @ 800 MHz
> > > DRAM:  2 GiB
> > > Core:  74 devices, 12 uclasses, devicetree: separate
> > > MMC:   mmc@12200000: 0, mmc@12220000: 2
> > > Loading Environment from MMC... Reading from MMC(2)... *** Warning -
> bad CRC, using default environment
> > >
> > > In:    serial
> > > Out:   serial
> > > Err:   serial
> > > Model: Odroid XU3/XU4/HC1/HC2 based on Exynos5422
> > > Type:  xu4
> > > Boot device: MMC(2)
> > > Net:   No ethernet found.
> > > Hit any key to stop autoboot:  0
> > > switch to partitions #0, OK
> > > mmc2 is current device
> > > Scanning mmc 2:1...
> > > Found U-Boot script /boot/boot.scr
> > > 2046 bytes read in 22 ms (90.8 KiB/s)
> > > 8104280 bytes read in 519 ms (14.9 MiB/s)
> > > Failed to load '/boot/dtbs/exynos5422-smdk5420xu4.dtb'
> > > SCRIPT FAILED: continuing...
> > > No EFI system partition
> > > No EFI system partition
> > > Failed to persist EFI variables
> > > No EFI system partition
> > > Failed to persist EFI variables
> > > No EFI system partition
> > > Failed to persist EFI variables
> > > Loading Boot0000 'mmc 2' failed
> > > EFI boot manager: Cannot load any image
> > > MMC Device 1 not found
> > > no mmc device at slot 1
> > > ---
> >
> > Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> >
> Thanks
>
> Gentle ping?
>
> Thanks
> -Anand


applied to u-boot-samsung.

Thanks.
Minkyu Kang.
