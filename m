Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219CDD3A661
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87FFA88EE1;
	Tue, 29 Oct 2024 16:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wf71QHL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DAF588D29; Tue, 29 Oct 2024 16:46:10 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B0D891A9
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a99f629a7aaso894074866b.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730216767; x=1730821567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h1CWcvY2Q4l5qwd7IzSCBgVkeh2zw1FIxUdX2Jraa8g=;
 b=Wf71QHL7nl8AanVhzMIQygvyTGVzVimMAc/kaFpcVxaaSwquX2OJMrm1/OdER2mnm5
 +f4n4tb2rLb3YA8Oodb9PDahc3iZw6tzCwBIkmPmsn/xlhiEAKavu/INc301qVZehe8C
 lo6lsZi6zTVY558Rv6UjkJimpMWRjXEfczE8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216767; x=1730821567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h1CWcvY2Q4l5qwd7IzSCBgVkeh2zw1FIxUdX2Jraa8g=;
 b=L6tBw/rfOpm16tA3ehSRqmi3d+U4OLnKII3iyT50hwiaPA6R333w/Hj7xXNEfo+V+Y
 /rD70OI797WlzFQowPwBz2IzKUHhPYJ+q5tG/qxhEZW92BiRRehtbKM+9BZKg9cUWcE6
 D7DcqUVjggtwjMBS9B5E83Xrqjizuvs+oTH6xB5UbtFFl0C6dKeBJObnd/XI6dOSGU2n
 KWnp8JAJDfXiB5Ow0cRA53eKMd94gz2caaXT5HnczvVXEZnn2fbUhrxJlwR2kG1MFuB9
 eAow0BGqNrAXv9qO13Q4L8Z/dMWjq+opcOHuDdZyBIY+3jw0tYufiMm1UXIqRO73PAfK
 mQhw==
X-Gm-Message-State: AOJu0YwRi+YRYPOvTuVjiraJc/i3N7o6PM0RG0hKrRm8RaIlbPuLdqNz
 LzzLtpm1zE8/9pyPNRbSAQVZgUCvABodwRUNcgvxrnfDjhgl/iNnUcviOpmzmP6ARNmhMGVO3fS
 f4cMjsCoJVA5tmyhWlDSQTDTyYx+/IGQr1iI0
X-Google-Smtp-Source: AGHT+IGv0qtOpEkromDZrFoLJZQiyqlpFby4hMhFT2BIdyrJTfkefpI+dXsKwOMIF55EJHqTdetc4HXQ5CGh1rtG700=
X-Received: by 2002:a17:906:6a23:b0:a99:f209:cea3 with SMTP id
 a640c23a62f3a-a9e2b392891mr270392566b.11.1730216766870; Tue, 29 Oct 2024
 08:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-6-sjg@chromium.org>
 <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
 <ea85b8fc-fe7b-4a76-a3e1-bb92b45b027a@gmx.de>
In-Reply-To: <ea85b8fc-fe7b-4a76-a3e1-bb92b45b027a@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Oct 2024 16:45:54 +0100
Message-ID: <CAFLszTj+jOut1_-E45A-f=smJejn+BTZ4XVuDr1YdJ20=zKQSQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] sandbox: Report host default-filename in native
 mode
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Mon, 28 Oct 2024 at 20:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/25/24 11:56, Ilias Apalodimas wrote:
> > Hi Simon,
> >
> >
> > On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> When the --native flag is given, pretend to be running the host
> >> architecture rather than sandbox.
> >>
> >> Add an 'efidebug filename' command to report it.
> >
> > Heinrich does this allow you to continue your testing in native archs?
> >
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >> Changes in v8:
> >> - Add new patch to report host default-filename in native mode
> >>
> >>   boot/bootmeth_efi.c | 25 ++------------------
> >>   boot/efi_fname.c    | 57 +++++++++++++++++++++++++++++++++------------
> >>   cmd/efidebug.c      | 25 ++++++++++++++++++++
> >>   include/efi.h       | 25 ++++++++++++++++++++
> >>   4 files changed, 94 insertions(+), 38 deletions(-)
> >>
> >> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> >> index 371b36d550b..f836aa655f5 100644
> >> --- a/boot/bootmeth_efi.c
> >> +++ b/boot/bootmeth_efi.c
> >> @@ -25,32 +25,11 @@
> >>
> >>   #define EFI_DIRNAME    "/EFI/BOOT/"
> >>
> >> -static int get_efi_pxe_arch(void)
> >> -{
> >> -       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
> >> -       if (IS_ENABLED(CONFIG_ARM64))
> >> -               return 0xb;
> >> -       else if (IS_ENABLED(CONFIG_ARM))
> >> -               return 0xa;
> >> -       else if (IS_ENABLED(CONFIG_X86_64))
> >> -               return 0x6;
> >> -       else if (IS_ENABLED(CONFIG_X86))
> >> -               return 0x7;
> >> -       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> >> -               return 0x19;
> >> -       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> >> -               return 0x1b;
> >> -       else if (IS_ENABLED(CONFIG_SANDBOX))
> >> -               return 0;       /* not used */
> >> -
> >> -       return -EINVAL;
> >> -}
> >> -
> >>   static int get_efi_pxe_vci(char *str, int max_len)
> >>   {
> >>          int ret;
> >>
> >> -       ret = get_efi_pxe_arch();
> >> +       ret = efi_get_pxe_arch();
> >>          if (ret < 0)
> >>                  return ret;
> >>
> >> @@ -239,7 +218,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> >>          ret = get_efi_pxe_vci(str, sizeof(str));
> >>          if (ret)
> >>                  return log_msg_ret("vci", ret);
> >> -       ret = get_efi_pxe_arch();
> >> +       ret = efi_get_pxe_arch();
> >>          if (ret < 0)
> >>                  return log_msg_ret("arc", ret);
> >>          arch = ret;
> >> diff --git a/boot/efi_fname.c b/boot/efi_fname.c
> >> index a6b11383bba..790f9e2fa36 100644
> >> --- a/boot/efi_fname.c
> >> +++ b/boot/efi_fname.c
> >> @@ -9,29 +9,34 @@
> >>    */
> >>
> >>   #include <efi.h>
> >> +#include <errno.h>
> >>   #include <host_arch.h>
> >>
> >> -#ifdef CONFIG_SANDBOX
> >> -
> >>   #if HOST_ARCH == HOST_ARCH_X86_64
> >> -#define BOOTEFI_NAME "BOOTX64.EFI"
> >> +#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
> >> +#define HOST_PXE_ARCH 0x6
> >>   #elif HOST_ARCH == HOST_ARCH_X86
> >> -#define BOOTEFI_NAME "BOOTIA32.EFI"
> >> +#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
> >> +#define HOST_PXE_ARCH 0x7
> >>   #elif HOST_ARCH == HOST_ARCH_AARCH64
> >> -#define BOOTEFI_NAME "BOOTAA64.EFI"
> >> +#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
> >> +#define HOST_PXE_ARCH 0xb
> >>   #elif HOST_ARCH == HOST_ARCH_ARM
> >> -#define BOOTEFI_NAME "BOOTARM.EFI"
> >> +#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
> >> +#define HOST_PXE_ARCH 0xa
> >>   #elif HOST_ARCH == HOST_ARCH_RISCV32
> >> -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
> >> +#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
> >> +#define HOST_PXE_ARCH 0x19
> >>   #elif HOST_ARCH == HOST_ARCH_RISCV64
> >> -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
> >> +#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
> >> +#define HOST_PXE_ARCH 0x1b
> >>   #else
> >> -#error Unsupported UEFI architecture
> >> +#error Unsupported Host architecture
> >>   #endif
> >>
> >> -#else
> >> -
> >> -#if defined(CONFIG_ARM64)
> >> +#if defined(CONFIG_SANDBOX)
> >> +#define BOOTEFI_NAME "BOOTSBOX.EFI"
> >> +#elif defined(CONFIG_ARM64)
> >>   #define BOOTEFI_NAME "BOOTAA64.EFI"
> >>   #elif defined(CONFIG_ARM)
> >>   #define BOOTEFI_NAME "BOOTARM.EFI"
> >> @@ -47,9 +52,31 @@
> >>   #error Unsupported UEFI architecture
>  >>   #endif>>
> >> -#endif
> >> -
> >>   const char *efi_get_basename(void)
> >>   {
> >> -       return BOOTEFI_NAME;
> >> +       return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI_NAME;
> >> +}
> >> +
> >> +int efi_get_pxe_arch(void)
> >> +{
> >> +       if (efi_use_host_arch())
> >> +               return HOST_PXE_ARCH;
> >> +
> >> +       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
> >> +       if (IS_ENABLED(CONFIG_ARM64))
> >> +               return 0xb;
> >> +       else if (IS_ENABLED(CONFIG_ARM))
> >> +               return 0xa;
> >> +       else if (IS_ENABLED(CONFIG_X86_64))
> >> +               return 0x6;
> >> +       else if (IS_ENABLED(CONFIG_X86))
> >> +               return 0x7;
> >> +       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> >> +               return 0x19;
> >> +       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> >> +               return 0x1b;
> >> +       else if (IS_ENABLED(CONFIG_SANDBOX))
>
> Please, add a warning here:
>
>       log_warn("You are using the sandbox in non-compliant mode\n");
>
> The riscv64 sandbox can only run riscv64 binaries
> The arm64 sandbox can only run arm64 binary.
>
> We cannot expect a DHCP server to do the expected with the value 0.
>
> So why should we introduce this?
>
> >> +               return 0;       /* not used */
>
> The following comment would fit better:
>
>      /* This breaks PXE booting on the sandbox.*/

This line is already in the code. I am just moving it to a new file.
PXE booting is not supported on sandbox. Neither is EFI booting, until
this series is applied.

If you can see your way to drop your other objections on this series,
I don't mind removing this line and just returning the error code.

Regards,
Simon
