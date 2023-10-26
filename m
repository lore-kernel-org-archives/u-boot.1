Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4741BC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 15:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A599387AEB;
	Thu, 26 Oct 2023 17:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X3+GSZc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1016B87A49; Thu, 26 Oct 2023 17:43:36 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB2BE87B6D
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 48847B82E2A
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 15:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5592BC433C7
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 15:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698335011;
 bh=Hk06Aj6JBMC63stJsQlTtqBSdqRYckrvnAYkZsykl4w=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=X3+GSZc0HpN3GbG6Ea+/KrNVD4GaJkgte9zT0kRu7gA0kwYzU6P2IVAesE3j+sOYX
 LE1nf2HEhAraajS0jkJMbRTF5UQ0RI8qrYw0qMXQcX8wgPQXjZxQAlTkp08CpnF4Ws
 62yx/B9JuSzGxB/JznjhpihqfS7UkFT4mHTm7faliA0eZRvGOsfnM6WISIurTM6fmV
 wW2C9jkTlUaXAms918j4NzG+zw2fnUFGqLU1J4/ZV57raHNsMoJe7EHk+XzvzBR25h
 XjtpH0xZR9/pMsG8O2oDX6E9IDllYoRk0nNbyBGC0ArNrxPcO65cpo8mtE1SyVi/hm
 0lrqTAm97RAVw==
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-507bd644a96so1536620e87.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 08:43:31 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy4UvrTE2KCsw7fml16vupgA29LBvyHFf04T5hwml2riBkn+BxD
 APG+1KTUG1s47g4zLTa1K9yo0XhZu8iJwgU7KQ==
X-Google-Smtp-Source: AGHT+IHJNnx30p4ExgIV+paJsfbErgPi/9y5boGscu2uDDYVnvlAgNbwuy2E+CvtAfuhJdQ/7TX9o5K7/4keLNjqZ0w=
X-Received: by 2002:ac2:4315:0:b0:507:b90a:7a5d with SMTP id
 l21-20020ac24315000000b00507b90a7a5dmr13773064lfh.10.1698335009558; Thu, 26
 Oct 2023 08:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231022084733.113326-1-heinrich.schuchardt@canonical.com>
 <20231022155543.GC496310@bill-the-cat>
 <4c4fee5a-82ab-46e2-a450-f874b2a9ad5c@canonical.com>
 <20231022170812.GD496310@bill-the-cat>
 <36e1a60c-3aa9-4f06-9920-c7b0a1d12c19@canonical.com>
In-Reply-To: <36e1a60c-3aa9-4f06-9920-c7b0a1d12c19@canonical.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 26 Oct 2023 10:43:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKAjvArFM-EuBKGTgZrATH6kBBnn_Ly+-pVRmEo8MtnQA@mail.gmail.com>
Message-ID: <CAL_JsqKAjvArFM-EuBKGTgZrATH6kBBnn_Ly+-pVRmEo8MtnQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Sun, Oct 22, 2023 at 4:32=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/22/23 19:08, Tom Rini wrote:
> > On Sun, Oct 22, 2023 at 06:34:08PM +0200, Heinrich Schuchardt wrote:
> >> On 10/22/23 17:55, Tom Rini wrote:
> >>> On Sun, Oct 22, 2023 at 10:47:33AM +0200, Heinrich Schuchardt wrote:
> >>>
> >>>> Forward and backward compatibility of Linux kernel device-trees is
> >>>> sometimes missing. One solution approach is to load a kernel specifi=
c
> >>>> device-tree. This can either be done via a U-Boot scripts (like the =
one
> >>>> generated by Debian package flash-kernel or by a boot loader like GR=
UB.
> >>>> The boot loader approach currently requires to know the device-tree =
name
> >>>> before first boot which makes it unusable for generic images.
> >>>>
> >>>> Expose the device-tree file name as EFI variable FdtFile.
> >>>> This will allow bootloaders to load a kernel specific device-tree.
> >>>>
> >>>> The variable will not be exposed on ACPI based systems or if the
> >>>> environment variable fdtfile is not defined.
> >>>>
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.co=
m>
> >>>> ---
> >>>> v3:
> >>>>    Add documentation
> >>>> v2:
> >>>>    Use a unique GUID to enable future U-Boot independent
> >>>>    standardization.
> >>>>    Do not try to add the variable on ACPI based systems.
> >>>> ---
> >>>>    doc/develop/uefi/uefi.rst  | 17 +++++++++++++++++
> >>>>    include/efi_loader.h       |  5 +++++
> >>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> >>>>    3 files changed, 52 insertions(+)
> >>>>
> >>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> >>>> index fb16ac743a..a81d09ae81 100644
> >>>> --- a/doc/develop/uefi/uefi.rst
> >>>> +++ b/doc/develop/uefi/uefi.rst
> >>>> @@ -916,6 +916,23 @@ So our final format of the FilePathList[] is::
> >>>>        Loaded image - end node (0xff) - VenMedia - initrd_1 - [end n=
ode (0x01) - initrd_n ...] - end node (0xff)
> >>>> +EFI variable FdtFile
> >>>> +~~~~~~~~~~~~~~~~~~~~
> >>>> +
> >>>> +Ideally U-Boot would always expose a device-tree that can be used f=
or booting
> >>>> +any operating systems. Unfortunately operating systems like Linux s=
ometimes
> >>>> +break forward and backward compatibility. In this case there is a n=
eed to load
> >>>> +an operating system version specific device-tree.
> >>>> +
> >>>> +U-Boot has an environment variable fdtfile identifying the device-t=
ree file to
> >>>> +load. The content of this variable is exposed as EFI variable Fdtfi=
le, vendor
> >>>> +GUID d45dde69-3bd6-40e0-90d5-6b606aa57730. It contains the device-t=
ree path
> >>>> +name as a NUL terminated ASCII string.
> >>>> +
> >>>> +On 32bit ARM this is currently only a file name, e.g. 'imx6dl-wandb=
oard.dtb'.
> >>>> +On other architectures the file name is preceded by the vendor dire=
ctory, e.g.
> >>>> +'rockchip/rk3326-odroid-go2.dtb'.
> >>>
> >>> The Linux Kernel has split 32bit ARM up by directory now, too.
> >>
> >> Since Linux v6.5. That is why I wrote "currently". Once we migrate the
> >> values of $fdtfile in U-Boot we may want to change
> >> distro_efi_try_bootflow_files() to search both with and without vendor
> >> directory.
> >>
> >> Are there already plans for that migration?
> >
> > Right, v6.5 is out and has this change and v6.6 will be out soon enough=
,
> > so the documentation we're adding here and now should be worded such
> > that doesn't get stuck on these specifics.
>
> Should I add a sentence:
>
> Linux v6.5 has added vendor directories on 32bit ARM and U-Boot is
> expected to follow suit.

Note that while this is correct, the install (make dtbs_install) still
uses a flat directory. That was to not break existing users. It is
currently not a visible config option. Perhaps it should be if there's
a desire to move to having sub-directories for the install?

Rob
