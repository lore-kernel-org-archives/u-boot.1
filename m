Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D8DC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 05:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02D787F78;
	Mon,  8 Apr 2024 07:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gt9qC/y+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF3487F8D; Mon,  8 Apr 2024 07:50:44 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F09C98799C
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 07:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d895e2c6efso3123051fa.0
 for <u-boot@lists.denx.de>; Sun, 07 Apr 2024 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712555441; x=1713160241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HfXbK8ZGC5GUQOXWXozswdgEtTmX2SMT2R0WbMS15XI=;
 b=gt9qC/y+6yDfuNnw7ukl9fSvelzyKYxr581d3B4ORQ0j84kNyUD0tRQkXjxcnFLL3h
 79Pr97mPj//TAPCwjwhjfY3LJ/IjQEcRHHXVN5nsckVoHmm9/Y4zzcgfK55tAiLYs5Kv
 UPu5PmosVx05XpGaLNq7PznyyY4KVNxIlqF19I2kUNdwXSJi4Fs56m46JXdo8XG4Rsgf
 t2gm2C4VY9MXxnjHoCspEAewW3zj+ie2q0nJuzWll9W2EOcYP3qwOXazL4vWykKnc1/S
 ysaTT39cCU0CNzZj0aQoKbNDs2AINX3wKWgt3e2EJGyua+ks5vihnREesfgbq66NhpVd
 iHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712555441; x=1713160241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HfXbK8ZGC5GUQOXWXozswdgEtTmX2SMT2R0WbMS15XI=;
 b=IObInOmtOJloCFIsdynAVG2y7URx/dipHRSTaGdbQp5zmEAN6zsvhCHaEXq+aX3Hiw
 7gHbObEoZXFJr3UVb9sf1ZPieUs6VvyK4YLv0XdKZBr+Mm+7H5xLwVQBAf4ejLzNn6EI
 tfTwAZiVpkiOsbUbS49J2lkywkj9W2uzwvWhvJ0pql1uY0fYayCVMwrvbqmXqe9fNV1h
 dICBX4B6uITCW78qyfh31AO2fBHGKB2u7pQH4AiApwbaDqdakykxus9SvhkWkAmMsh4W
 lftHRpgLqD1v/9pEl7dQ0FuLK+zHx/dGAQ9y+cgGnlxN0jjrCdNSRBQc3uK5rs2Gij2o
 hWZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSc3+lvRa5WLfTq6OaO3mWIm5ShOh+Ekw5NDpmu2Uy/kjJHNwrdNyYh+o/571dCBGyWdceqDn3malS8dBqDAyBtuqCiw==
X-Gm-Message-State: AOJu0YyubcWksDnD15qPVSBHE4a+FGa3PoMO/1CgLjrX1mOXzMvIieBk
 kdPY2Hn9YXRktKc9IMoxhKYNt27wlZ2GcICUwvjolLN3lS/Isw0kI+WzUmVJ/z/UxJtcNDyLLyU
 hEMMBIYn6n1/L/ziZOfhAAC5P9USZWsL9czQHOA==
X-Google-Smtp-Source: AGHT+IGlPn7TYjpr5k/GEtWbxhJTVZcTd4cxlAUihK7KwtAfWyTzr/rt8GQXIPkEiNeHvFlEpwCbjXTQdVvUgt4eai8=
X-Received: by 2002:a2e:854c:0:b0:2d6:b11a:3a49 with SMTP id
 u12-20020a2e854c000000b002d6b11a3a49mr4966138ljj.9.1712555441018; Sun, 07 Apr
 2024 22:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <87bk6kj0uo.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87bk6kj0uo.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Apr 2024 08:50:04 +0300
Message-ID: <CAC_iWj+0pdhK2G-g3wxSPOS_tmTByCBvxe3R+zkSzAc-LQuR_Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Enable SetvariableRT
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: xypron.glpk@gmx.de, kettenis@openbsd.org, caleb.connolly@linaro.org, 
 sumit.garg@linaro.org, quic_llindhol@quicinc.com, ardb@kernel.org, 
 pbrobinson@gmail.com, pjones@redhat.com, trini@konsulko.com, 
 kojima.masahisa@socionext.com, takahiro.akashi@linaro.org, bmeng@tinylab.org, 
 raymond.mao@linaro.org, sjg@chromium.org, abdellatif.elkhlifi@arm.com, 
 eajames@linux.ibm.com, alpernebiyasak@gmail.com, sughosh.ganu@linaro.org, 
 o451686892@gmail.com, u-boot@lists.denx.de
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

Hi Mark


On Mon, 8 Apr 2024 at 00:53, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > Hi all,
> >
> > This is an updated version of [0].
> >
> > When EFI variables are stored on file we don't allow SetVariableRT,
> > since the OS doesn't know how to access or write that file.  At the same
> > time keeping the U-Boot drivers alive in runtime sections and performing
> > writes from the firmware is dangerous -- if at all possible.
> >
> > For GetVariableRT  we copy runtime variables in RAM and expose them to
> > the OS. Add a Kconfig option and provide SetVariableRT using the same
> > memory back end. The OS will be responsible for syncing the RAM contents
> > to the file, otherwise any changes made during runtime won't persist
> > reboots.
> >
> > It's worth noting that the variable store format is defined in EBBR [1]
> > and authenticated variables are explicitly prohibited, since they have
> > to be stored on a medium that's tamper and rollback protected.
> >
> > The original RFC was just enabling the memory back end. This is a more
> > complete version and we should be able, with small adjustments of
> > userspace tools, fix SetVariableRT. If enabled the firmware will add two
> > new RO EFI variables after ExitBootServices.
> >
> > RTStorageVolatile -- contains the filename, relative to the ESP
> > VarToFile -- an EFI variable that holds all the BS,RT, NV variables and can
> > be copied to the file defined by RTStorageVolatile.
> >
> > If any errors occur during the variable init, the firmware will delete them
> > and adjust the RT_PROP table accordingly, disabling SetvarRT.
> >
> > - pre-patch
> > $~ mount | grep efiva
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)
> >
> > $~ efibootmgr -n 0001
> > Could not set BootNext: Read-only file system
> >
> > - post-patch
> > $~ mount | grep efiva
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
> > , disabling SetvarRT.
> > $~ efibootmgr -n 0001
> > BootNext: 0001
> > BootCurrent: 0000
> > BootOrder: 0000,0001
> > Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0x800,0x100000)/File(EFI\debian\grubaa64.efi)
> > Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_boot_option}
> >
> > $~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
> > GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
> > Name: "BootNext"
> > Attributes:
> >         Non-Volatile
> >         Boot Service Access
> >         Runtime Service Access
> > Value:
> > 00000000  01 00
> >
> > [0] https://lore.kernel.org/u-boot/20240329071929.2461441-1-ilias.apalodimas@linaro.org/
> > [1] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
> >
> > Changes since the RFC:
> > - Return EFI_INVALID_PARAM if attributes are not volatile
> > - Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
> > - Add 2 EFI variables and allow userspace to write the file
> > - Add selftests
> >
> > Ilias Apalodimas (4):
> >   efi_loader: conditionally enable SetvariableRT
> >   efi_loader: Add OS notifications for SetVariableRT in RAM
> >   efi_loader: add an EFI variable with the variable file contents
> >   efi_selftest: add tests for setvariableRT
> >
> >  include/efi_loader.h                          |   4 +
> >  include/efi_variable.h                        |  15 +-
> >  lib/efi_loader/Kconfig                        |  16 ++
> >  lib/efi_loader/efi_boottime.c                 |   2 +
> >  lib/efi_loader/efi_runtime.c                  |   1 +
> >  lib/efi_loader/efi_var_common.c               |  43 ++--
> >  lib/efi_loader/efi_var_file.c                 |   1 -
> >  lib/efi_loader/efi_var_mem.c                  |  90 +++-----
> >  lib/efi_loader/efi_variable.c                 | 210 +++++++++++++++++-
> >  lib/efi_loader/efi_variable_tee.c             |   1 -
> >  .../efi_selftest_variables_runtime.c          | 116 +++++++++-
> >  11 files changed, 401 insertions(+), 98 deletions(-)
>
> I can't get patch 0003 from this series to apply on master or next.


Yes, my bad I forgot to mention you also need (before applying this series)
https://lore.kernel.org/u-boot/20240403153335.96971-1-heinrich.schuchardt@canonical.com/
https://lore.kernel.org/u-boot/20240402090950.3819705-1-kojima.masahisa@socionext.com/
https://lore.kernel.org/u-boot/20240405065058.591452-1-ilias.apalodimas@linaro.org/

Alternatively, you can clone directly
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/setvar_rt1

Thanks
/Ilias





>
