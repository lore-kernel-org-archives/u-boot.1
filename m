Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C16D7495E
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 07:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832BD891F5;
	Wed, 30 Oct 2024 08:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DjsYjS7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9282C891FC; Wed, 30 Oct 2024 08:44:44 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40508891F5
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 08:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso1034318766b.3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730274282; x=1730879082; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LfBHkwsdxA+KQImNSPJAer5K9Vja1yP5euiBw1iRUNw=;
 b=DjsYjS7iBHOJav2i90QezYWxEmgHi9/lxVMfc3ZfPE33dQn2l4nysbwLZI2goYOkgO
 z1/7d9BTKRdlMPF7jklt0cIOtKMS0GGt6dRdJd4ODW/mSXj+3BcOtkJcAmLXkt1uUBKK
 B0R4Itcigj90A46BQf9cOGJi6P1JcIGAqCuiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730274282; x=1730879082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LfBHkwsdxA+KQImNSPJAer5K9Vja1yP5euiBw1iRUNw=;
 b=P01XbT6zO5LNeJTN6yT93MwpMmLVvovqnXB2/mONsUdkdYSRTyI6Js30r6hNMfrIru
 90xc1uDAPZzbfRyj9Elh1WVKfPZjA46kazg4MI3ZP8w5/ZpYi3VAjxmuBcgfCS+zpOgf
 9WEnuZYpzNHyZU7eiaKS1vtqHr7GOc9ZLD+1k8m3fATxF/ofAfeJRljWpzkSsKsfopCU
 fZOHKa73thx78Pr3wiO0HxShVsinPK4Kl7PkTZp7y6ObA2p4B14G1h9YAtDiBFEe9J61
 ky2S47U98QJR/W0t217imxbqGTa1EXmfCtJUJ0v8+O10Hq9GpdePbx4KQVKtmT4q0CjZ
 rmuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi7JSS+YzFTGzyL1m3waohLV/eC2IudhvC89l+6KD2n6y9+XocrQSc9dQIkenSrHJQGKqSkbM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5LxTwj8hmqrsSYKAA+wJRw++YUcdteWsIiRZ8QEF3yp/pv8M5
 IqGyvSKUxLxSbuVbOXsFHyzgD9VO3PzlNkeWqYv5asbEZtjQn53L+/iVUzEDZ9tZbxTKlZlgMxS
 4oGQ8X14tjFNzdbwuCQJgePCucgYJE+vmWvtJ
X-Google-Smtp-Source: AGHT+IHjEeKm6G8+2Z/9F0ozyuE0fX419o6TvTOerpvfsGyMrQdLJ1xlOWEXBXVDdpI35mOdCZoGDarlRbumFPiEDlc=
X-Received: by 2002:a17:907:e88:b0:a9a:16b3:7dda with SMTP id
 a640c23a62f3a-a9e3a5a0e0dmr212314566b.19.1730274281667; Wed, 30 Oct 2024
 00:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-6-sjg@chromium.org>
 <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
 <ea85b8fc-fe7b-4a76-a3e1-bb92b45b027a@gmx.de>
 <CAFLszTj+jOut1_-E45A-f=smJejn+BTZ4XVuDr1YdJ20=zKQSQ@mail.gmail.com>
 <20241029164027.GE4959@bill-the-cat>
In-Reply-To: <20241029164027.GE4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Oct 2024 08:44:30 +0100
Message-ID: <CAFLszTh04Mw9PjdMUm5o_Hn7az9iM4B8+OBgP8a6Y69HbW46Xg@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] sandbox: Report host default-filename in native
 mode
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
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

Hi Tom,

On Tue, 29 Oct 2024 at 17:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 29, 2024 at 04:45:54PM +0100, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 28 Oct 2024 at 20:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 10/25/24 11:56, Ilias Apalodimas wrote:
> > > > Hi Simon,
> > > >
> > > >
> > > > On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrote:
> > > >>
> > > >> When the --native flag is given, pretend to be running the host
> > > >> architecture rather than sandbox.
> > > >>
> > > >> Add an 'efidebug filename' command to report it.
> > > >
> > > > Heinrich does this allow you to continue your testing in native archs?
> > > >
> > > >>
> > > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >> ---
> > > >>
> > > >> Changes in v8:
> > > >> - Add new patch to report host default-filename in native mode
> > > >>
> > > >>   boot/bootmeth_efi.c | 25 ++------------------
> > > >>   boot/efi_fname.c    | 57 +++++++++++++++++++++++++++++++++------------
> > > >>   cmd/efidebug.c      | 25 ++++++++++++++++++++
> > > >>   include/efi.h       | 25 ++++++++++++++++++++
> > > >>   4 files changed, 94 insertions(+), 38 deletions(-)
> > > >>
> > > >> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > > >> index 371b36d550b..f836aa655f5 100644
> > > >> --- a/boot/bootmeth_efi.c
> > > >> +++ b/boot/bootmeth_efi.c
> > > >> @@ -25,32 +25,11 @@
> > > >>
> > > >>   #define EFI_DIRNAME    "/EFI/BOOT/"
> > > >>
> > > >> -static int get_efi_pxe_arch(void)
> > > >> -{
> > > >> -       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
> > > >> -       if (IS_ENABLED(CONFIG_ARM64))
> > > >> -               return 0xb;
> > > >> -       else if (IS_ENABLED(CONFIG_ARM))
> > > >> -               return 0xa;
> > > >> -       else if (IS_ENABLED(CONFIG_X86_64))
> > > >> -               return 0x6;
> > > >> -       else if (IS_ENABLED(CONFIG_X86))
> > > >> -               return 0x7;
> > > >> -       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> > > >> -               return 0x19;
> > > >> -       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> > > >> -               return 0x1b;
> > > >> -       else if (IS_ENABLED(CONFIG_SANDBOX))
> > > >> -               return 0;       /* not used */
> > > >> -
> > > >> -       return -EINVAL;
> > > >> -}
> > > >> -
> > > >>   static int get_efi_pxe_vci(char *str, int max_len)
> > > >>   {
> > > >>          int ret;
> > > >>
> > > >> -       ret = get_efi_pxe_arch();
> > > >> +       ret = efi_get_pxe_arch();
> > > >>          if (ret < 0)
> > > >>                  return ret;
> > > >>
> > > >> @@ -239,7 +218,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> > > >>          ret = get_efi_pxe_vci(str, sizeof(str));
> > > >>          if (ret)
> > > >>                  return log_msg_ret("vci", ret);
> > > >> -       ret = get_efi_pxe_arch();
> > > >> +       ret = efi_get_pxe_arch();
> > > >>          if (ret < 0)
> > > >>                  return log_msg_ret("arc", ret);
> > > >>          arch = ret;
> > > >> diff --git a/boot/efi_fname.c b/boot/efi_fname.c
> > > >> index a6b11383bba..790f9e2fa36 100644
> > > >> --- a/boot/efi_fname.c
> > > >> +++ b/boot/efi_fname.c
> > > >> @@ -9,29 +9,34 @@
> > > >>    */
> > > >>
> > > >>   #include <efi.h>
> > > >> +#include <errno.h>
> > > >>   #include <host_arch.h>
> > > >>
> > > >> -#ifdef CONFIG_SANDBOX
> > > >> -
> > > >>   #if HOST_ARCH == HOST_ARCH_X86_64
> > > >> -#define BOOTEFI_NAME "BOOTX64.EFI"
> > > >> +#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
> > > >> +#define HOST_PXE_ARCH 0x6
> > > >>   #elif HOST_ARCH == HOST_ARCH_X86
> > > >> -#define BOOTEFI_NAME "BOOTIA32.EFI"
> > > >> +#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
> > > >> +#define HOST_PXE_ARCH 0x7
> > > >>   #elif HOST_ARCH == HOST_ARCH_AARCH64
> > > >> -#define BOOTEFI_NAME "BOOTAA64.EFI"
> > > >> +#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
> > > >> +#define HOST_PXE_ARCH 0xb
> > > >>   #elif HOST_ARCH == HOST_ARCH_ARM
> > > >> -#define BOOTEFI_NAME "BOOTARM.EFI"
> > > >> +#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
> > > >> +#define HOST_PXE_ARCH 0xa
> > > >>   #elif HOST_ARCH == HOST_ARCH_RISCV32
> > > >> -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
> > > >> +#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
> > > >> +#define HOST_PXE_ARCH 0x19
> > > >>   #elif HOST_ARCH == HOST_ARCH_RISCV64
> > > >> -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
> > > >> +#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
> > > >> +#define HOST_PXE_ARCH 0x1b
> > > >>   #else
> > > >> -#error Unsupported UEFI architecture
> > > >> +#error Unsupported Host architecture
> > > >>   #endif
> > > >>
> > > >> -#else
> > > >> -
> > > >> -#if defined(CONFIG_ARM64)
> > > >> +#if defined(CONFIG_SANDBOX)
> > > >> +#define BOOTEFI_NAME "BOOTSBOX.EFI"
> > > >> +#elif defined(CONFIG_ARM64)
> > > >>   #define BOOTEFI_NAME "BOOTAA64.EFI"
> > > >>   #elif defined(CONFIG_ARM)
> > > >>   #define BOOTEFI_NAME "BOOTARM.EFI"
> > > >> @@ -47,9 +52,31 @@
> > > >>   #error Unsupported UEFI architecture
> > >  >>   #endif>>
> > > >> -#endif
> > > >> -
> > > >>   const char *efi_get_basename(void)
> > > >>   {
> > > >> -       return BOOTEFI_NAME;
> > > >> +       return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI_NAME;
> > > >> +}
> > > >> +
> > > >> +int efi_get_pxe_arch(void)
> > > >> +{
> > > >> +       if (efi_use_host_arch())
> > > >> +               return HOST_PXE_ARCH;
> > > >> +
> > > >> +       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
> > > >> +       if (IS_ENABLED(CONFIG_ARM64))
> > > >> +               return 0xb;
> > > >> +       else if (IS_ENABLED(CONFIG_ARM))
> > > >> +               return 0xa;
> > > >> +       else if (IS_ENABLED(CONFIG_X86_64))
> > > >> +               return 0x6;
> > > >> +       else if (IS_ENABLED(CONFIG_X86))
> > > >> +               return 0x7;
> > > >> +       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> > > >> +               return 0x19;
> > > >> +       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> > > >> +               return 0x1b;
> > > >> +       else if (IS_ENABLED(CONFIG_SANDBOX))
> > >
> > > Please, add a warning here:
> > >
> > >       log_warn("You are using the sandbox in non-compliant mode\n");
> > >
> > > The riscv64 sandbox can only run riscv64 binaries
> > > The arm64 sandbox can only run arm64 binary.
> > >
> > > We cannot expect a DHCP server to do the expected with the value 0.
> > >
> > > So why should we introduce this?
> > >
> > > >> +               return 0;       /* not used */
> > >
> > > The following comment would fit better:
> > >
> > >      /* This breaks PXE booting on the sandbox.*/
> >
> > This line is already in the code. I am just moving it to a new file.
> > PXE booting is not supported on sandbox. Neither is EFI booting, until
> > this series is applied.
>
> It sounds like EFI booting in sandbox is working and being tested and
> used (as a testing mechanism) right now. And the work and questions
> being raised here are around having your changes not break that existing
> use.

Well it would be, although at present that flow does not work, due to
a problem either with EDK2 or QEMU. It may be fixed at some point.

With this patch, the -N flag is needed to use this 'native' flow. The
flag is not needed for CI, which is what I consider to be the normal
'sandbox' case.

Regards,
Simon
