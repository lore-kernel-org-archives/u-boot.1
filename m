Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AF6CD54A7
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE9986AEA;
	Tue, 19 Sep 2023 10:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PypZM3H0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C67B186AFB; Tue, 19 Sep 2023 10:17:08 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FAAF8669C
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9ad8bf9bfabso705605066b.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 01:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695111426; x=1695716226; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkNfjxFeUoYybVzrMXE6wmoqWG1pUbOsw4CAQRC0t+I=;
 b=PypZM3H05CzS95ZxeLrjrEFTZhINd2bLxWfOA5ya/eMOfjh3xd/egUfhwCPyy4kh90
 qoB4nYeWA7/Icp7/LahGhW1KgIFDk06DMvICWLuxrBDl+jzfrNjOpD/g2h1QclgcW4h0
 E3yG7q/dQdazcrb9ufEdSEKtCnQ0wMMpoErNDtG+EUw2u2NEgK+SA139Y+dQIX1KUjEK
 t+LURYJaTzOx6iSH4Rk6S1RJcJSbCJHw34/vVW1PmCcHVrcEpiZ2xbU6vE6OkWhxGcoB
 XAvWGZV0fhzNupmqGfThXekTsAyhysM/rNY9R6cB5QTM1CzMtV46XpoJpRfoEoEviPRn
 L0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695111426; x=1695716226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkNfjxFeUoYybVzrMXE6wmoqWG1pUbOsw4CAQRC0t+I=;
 b=BF31ov7iFwbLjmPsYNlTOJuiFYeHghVGMOXERfxwfVfzaMCdq8Oz642S2PMtZ9Lktv
 L+mCbU+UXAGbLLVlLsMjbCe+oACSo5JL9+vtLJ178JSOmHzUlldbGz4hfHUv6STqz8jv
 e2SP7lkO6AT2CL3Yy+oS3TnO/p/caA0YwAT9oCvw2W19KalanVgIzaxJJa/V3flmEHyS
 Ph6yo7o9DFGBQpchDnlHqDF4yia5bfFFB408CVo209SzMVgY8bF5+jhox6brkJAe7q1v
 KgNM74VCfYudlxkrUHAbwLs8sd2UziPm4cl/T5qlztUXM/X8a9Zu9SQaoa1fOzsRPzlR
 sF4w==
X-Gm-Message-State: AOJu0YwATA1jPx2KQo5fIPuSdGjDXcq8QZh48vdjZjA2mprYcC7IIiuc
 9xk3EAlAwsMYy+YvcGFW5KiXl1fJyYlO5AN5idc=
X-Google-Smtp-Source: AGHT+IElpib3PSvsWwkh+UW0Nt3pvEr1kEOW2TO64CaowHoM5UG/smjkCuaXnMlkRydOJjIohqL8J+rGTVCJ2dfiXtE=
X-Received: by 2002:a17:906:10ce:b0:9a1:ec69:23ec with SMTP id
 v14-20020a17090610ce00b009a1ec6923ecmr10734485ejv.17.1695111426074; Tue, 19
 Sep 2023 01:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230901112707.v3.1.I61008e563b1209243a9a7f2b66073b4737ff82d1@changeid>
In-Reply-To: <20230901112707.v3.1.I61008e563b1209243a9a7f2b66073b4737ff82d1@changeid>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 16:16:54 +0800
Message-ID: <CAEUhbmUZGEvcoyXL=2rCXS1z=zmD3omJMnOg_rDGXDstLSSFgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Reland "x86: Move FACP table into separate
 functions""
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

On Sat, Sep 2, 2023 at 1:27=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Each board has its own way of creating this table. Rather than calling th=
e
> acpi_create_fadt() function for each one from a common acpi_write_fadt()
> function, just move the writer into the board-specific code.
>
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> (Now fixed - thank you Andy!)
>
> Make another attempt to land this. It apparently breaks Edison but I
> cannot test that board, nor can I work out what is wrong with the code.
>
> Previous test report is here:
>
>    https://lore.kernel.org/all/Yga9Z7sBFAeV64FV@smile.fi.intel.com/
>
> Looking at the image, the method is definitely present:
>
>    $ nm /tmp/b/edison/u-boot |grep acpi_writer
>    0115fde0 D _u_boot_list_2_acpi_writer_2_0base
>    0115fdf0 D _u_boot_list_2_acpi_writer_2_1facs
>    0115fe00 D _u_boot_list_2_acpi_writer_2_3dsdt
>    0115fe10 D _u_boot_list_2_acpi_writer_2_4gnvs
>    0115fe20 D _u_boot_list_2_acpi_writer_2_5csrt
>    0115fe30 D _u_boot_list_2_acpi_writer_2_5fadt
>    0115fe40 D _u_boot_list_2_acpi_writer_2_5mcfg
>    0115fe50 D _u_boot_list_2_acpi_writer_2_5spcr
>    0115fe60 D _u_boot_list_2_acpi_writer_2_5tcpa
>    0115fe70 D _u_boot_list_2_acpi_writer_2_5tpm2
>    0115fe80 D _u_boot_list_2_acpi_writer_2_5x86
>    0115fe90 D _u_boot_list_2_acpi_writer_2_6ssdt
>    0115fea0 D _u_boot_list_2_acpi_writer_2_8dev
>
> I wonder if the code in quark_write_fadt() is not being called?
>
> 'acpi list' shows what tables are installed. On minnowmax there is no
> difference with or without this patch. Perhaps someone with sharper eyes
> than me can figure this out?
>
> The mechanism is that the functions to be called are put in a linker list=
,
> each element being declared using ACPI_WRITER(function_name).
>
> Then acpi_write_all() is called to write each one. Debugging could be
> added to that function, perhaps?
>
> Changes in v3:
> - None (just added the tags since patchwork doesn't do Co-developed-by)
>
> Changes in v2:
> - Squash in the fix from Andy Shevchenko
>
>  arch/x86/cpu/apollolake/acpi.c    | 17 +++++++++++++----
>  arch/x86/cpu/baytrail/acpi.c      | 27 +++++++++++++++++++--------
>  arch/x86/cpu/quark/acpi.c         | 27 +++++++++++++++++++--------
>  arch/x86/cpu/tangier/acpi.c       | 27 +++++++++++++++++++--------
>  arch/x86/include/asm/acpi_table.h |  2 --
>  arch/x86/lib/acpi_table.c         | 15 ---------------
>  6 files changed, 70 insertions(+), 45 deletions(-)
>

series applied to u-boot-x86/next, thanks!
