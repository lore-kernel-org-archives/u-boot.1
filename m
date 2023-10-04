Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BA4E8FDDA
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 08:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76F686D27;
	Wed,  4 Oct 2023 10:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b0R0Xid1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E745186BEC; Wed,  4 Oct 2023 10:30:08 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A88CD86BB4
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 10:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-991c786369cso305720066b.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696408206; x=1697013006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NtXSCTo9mXQO8tz+07C3plHXh71oBgp4+FnDwgAJFsg=;
 b=b0R0Xid1s9TvEMzRnG1NVdH0K0+mW9q+DZaZHki0rbGGjVUfM6nEoaR0u/u8zYjrHX
 SzE3fgO22xF2sstm37w/kRcbASECcQQR2bpWXkb202otnfWHlg4WiBbAk6w5gsWkBbmT
 lciDTNxPk5R1pSaI25gXF7LmNMUY64cxVFNIIlPEGscodoroS/m3u94j5vzWWGHdfHCM
 0PhZNbPP7Rik9DKEiq/swOZyA30L3HniaGfHP+g4nDOVXV6sTxXLzTXOmS5HCNCRGtIr
 Das2xYO++afqLI9AHCDaCQ1S+y4X7camuVFEr1yUqzaTEvCmafx63c3p1ORW2MZ58Ba+
 VJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696408206; x=1697013006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NtXSCTo9mXQO8tz+07C3plHXh71oBgp4+FnDwgAJFsg=;
 b=P7/pWiH4jDj2cwEk7+YUAqZayguikKP6siTGhr5q89o7HW1HL1de9TRWSd+nfeVsM3
 qmo3y29rVdYvi3XQ71FnmASFJxnNgovqUBbVR+N95CtubWGSZ2QAlyJsHJXPoh7QeBei
 UbqYnZnb8AY1CVZqRgI8uI7U+5K34FwXTd5Bm9ozwXWoF/nD1zsbgFSdSnZedrdMd/3o
 DConoT9BsomTYaBZykppEmQTN3E8k1tZrmd+/jGtb0ojCkoIAztmx3I9WbC3QCzbv8vH
 nwiEMHYrGOOcWU7FMH+ESLml/BSN3b1rdLM73D4QSZesrtEAL1uY8wo6Wk8HpRESLo0h
 w1Og==
X-Gm-Message-State: AOJu0YwwmaSlidzm26EGREVw9wBRhi1akq6wA7232fSlhQMLBbZslqF2
 8/9pSL53EHtkR7UH42lh40zEGFZ9z1jVXk08Ih8SHw==
X-Google-Smtp-Source: AGHT+IGguMrqUB9pmnDBugV3MmlrV7pWftpRprDYBKPxuzxrDGGQ6v8VJ5g0ppyLg5x+EId9umeAwiXBU2SjNz5Vb1E=
X-Received: by 2002:a17:906:32cb:b0:9b2:abda:2543 with SMTP id
 k11-20020a17090632cb00b009b2abda2543mr1390387ejk.65.1696408206060; Wed, 04
 Oct 2023 01:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-15-maxim.uvarov@linaro.org>
 <77c30b7d-66ae-a7ff-0e7d-07be3098acbc@linux.microsoft.com>
 <CAPnjgZ3a5MVTKEzDwnYGiRW+cvz5H-v7ictRUTeUjWJUKV1D9g@mail.gmail.com>
In-Reply-To: <CAPnjgZ3a5MVTKEzDwnYGiRW+cvz5H-v7ictRUTeUjWJUKV1D9g@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 4 Oct 2023 14:29:54 +0600
Message-ID: <CAD8XO3Yj0vCnTx81UwvpWsQiSyyJkMBQG4qn8qSWq2cnS1Ugfw@mail.gmail.com>
Subject: Re: [PATCHv10 14/15] net/lwip: replace original net commands with lwip
To: Simon Glass <sjg@google.com>
Cc: Sean Edmond <seanedmond@linux.microsoft.com>, u-boot@lists.denx.de, 
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 4 Oct 2023 at 08:12, Simon Glass <sjg@google.com> wrote:

> Hi Sean,
>
> On Tue, 3 Oct 2023 at 11:58, Sean Edmond <seanedmond@linux.microsoft.com>
> wrote:
> >
> >
> > On 2023-09-26 2:41 a.m., Maxim Uvarov wrote:
> > > Replace original commands: ping, tftp, dhcp and wget.
> > >
> > > Signed-off-by: Maxim Uvarov<maxim.uvarov@linaro.org>
> > > ---
> > >   boot/bootmeth_efi.c | 18 +++++++---
> > >   boot/bootmeth_pxe.c | 21 ++++++-----
> > >   cmd/net.c           | 86
> +++++----------------------------------------
> > >   cmd/pxe.c           | 19 +++++-----
> > >   include/net.h       |  8 +++--
> > >   include/net/ulwip.h | 64 +++++++++++++++++++++++++++++++++
> > >   6 files changed, 113 insertions(+), 103 deletions(-)
> > >   create mode 100644 include/net/ulwip.h
> > >
> > > diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > > index ae936c8daa..52399d627c 100644
> > > --- a/boot/bootmeth_efi.c
> > > +++ b/boot/bootmeth_efi.c
> > > @@ -20,6 +20,8 @@
> > >   #include <mapmem.h>
> > >   #include <mmc.h>
> > >   #include <net.h>
> > > +#include <net/lwip.h>
> > > +#include <net/ulwip.h>
> > >   #include <pxe_utils.h>
> > >   #include <linux/sizes.h>
> > >
> > > @@ -319,9 +321,7 @@ static int distro_efi_try_bootflow_files(struct
> udevice *dev,
> > >
> > >   static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> > >   {
> > > -     char file_addr[17], fname[256];
> > > -     char *tftp_argv[] = {"tftp", file_addr, fname, NULL};
> > > -     struct cmd_tbl cmdtp = {};      /* dummy */
> > > +     char fname[256];
> > >       const char *addr_str, *fdt_addr_str;
> > >       int ret, arch, size;
> > >       ulong addr, fdt_addr;
> > > @@ -368,7 +368,6 @@ static int distro_efi_read_bootflow_net(struct
> bootflow *bflow)
> > >       if (!fdt_addr_str)
> > >               return log_msg_ret("fdt", -EINVAL);
> > >       fdt_addr = hextoul(fdt_addr_str, NULL);
> > > -     sprintf(file_addr, "%lx", fdt_addr);
> > >
> > >       /* We only allow the first prefix with PXE */
> > >       ret = distro_efi_get_fdt_name(fname, sizeof(fname), 0);
> > > @@ -379,7 +378,16 @@ static int distro_efi_read_bootflow_net(struct
> bootflow *bflow)
> > >       if (!bflow->fdt_fname)
> > >               return log_msg_ret("fil", -ENOMEM);
> > >
> > > -     if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
> > > +     ret = ulwip_init();
> > > +     if (ret)
> > > +             return log_msg_ret("ulwip_init", ret);
> > > +
> > > +     ret = ulwip_tftp(fdt_addr, fname);
> > > +     if (ret)
> > > +             return log_msg_ret("ulwip_tftp", ret);
> > > +
> > > +     ret = ulwip_loop();
> > > +     if (!ret) {
> > >               bflow->fdt_size = env_get_hex("filesize", 0);
> > >               bflow->fdt_addr = fdt_addr;
> > >       } else {
> > > diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
> > > index 8d489a11aa..fc6aabaa18 100644
> > > --- a/boot/bootmeth_pxe.c
> > > +++ b/boot/bootmeth_pxe.c
> > > @@ -21,6 +21,8 @@
> > >   #include <mapmem.h>
> > >   #include <mmc.h>
> > >   #include <net.h>
> > > +#include <net/ulwip.h>
> > > +#include <net/lwip.h>
> > >   #include <pxe_utils.h>
> > >
> > >   static int extlinux_pxe_getfile(struct pxe_context *ctx, const char
> *file_path,
> > > @@ -116,18 +118,21 @@ static int extlinux_pxe_read_file(struct udevice
> *dev, struct bootflow *bflow,
> > >                                 const char *file_path, ulong addr,
> > >                                 ulong *sizep)
> > >   {
> > > -     char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
> > > -     struct pxe_context *ctx = dev_get_priv(dev);
> > > -     char file_addr[17];
> > >       ulong size;
> > >       int ret;
> > >
> > > -     sprintf(file_addr, "%lx", addr);
> > > -     tftp_argv[1] = file_addr;
> > > -     tftp_argv[2] = (void *)file_path;
> > > +     ret = ulwip_init();
> > > +     if (ret)
> > > +             return log_msg_ret("ulwip_init", ret);
> > > +
> > > +     ret = ulwip_tftp(addr, file_path);
> > > +     if (ret)
> > > +             return log_msg_ret("ulwip_tftp", ret);
> > > +
> > > +     ret = ulwip_loop();
> > > +     if (ret)
> > > +             return log_msg_ret("ulwip_loop", ret);
> > >
> > > -     if (do_tftpb(ctx->cmdtp, 0, 3, tftp_argv))
> > > -             return -ENOENT;
> > >       ret = pxe_get_file_size(&size);
> > >       if (ret)
> > >               return log_msg_ret("tftp", ret);
> > > diff --git a/cmd/net.c b/cmd/net.c
> > > index d407d8320a..dc5a114309 100644
> > > --- a/cmd/net.c
> > > +++ b/cmd/net.c
> > > @@ -22,6 +22,7 @@
> > >   #include <net/udp.h>
> > >   #include <net/sntp.h>
> > >   #include <net/ncsi.h>
> > > +#include <net/lwip.h>
> > >
> > >   static int netboot_common(enum proto_t, struct cmd_tbl *, int, char
> * const []);
> > >
> > > @@ -40,19 +41,9 @@ U_BOOT_CMD(
> > >   #endif
> > >
> > >   #ifdef CONFIG_CMD_TFTPBOOT
> > > -int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> argv[])
> > > -{
> > > -     int ret;
> > > -
> > > -     bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
> > > -     ret = netboot_common(TFTPGET, cmdtp, argc, argv);
> > > -     bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
> > > -     return ret;
> > > -}
> > > -
> > >   #if IS_ENABLED(CONFIG_IPV6)
> > >   U_BOOT_CMD(
> > > -     tftpboot,       4,      1,      do_tftpb,
> > > +     tftpboot,       4,      1, do_lwip_tftp,
> >
> > It looks like LWIP doesn't support TFTP with IPv6 addressing.  Perhaps
> > we need to fall back onto the existing TFTP implementation until LWIP
> > supports it?
> >
> > Note, that currently, IPv6 TFTP is enabled using the "-ipv6" argument.
> > The intention is that netboot_common() sees the argument and sets the
> > "use_ip6" variable.  It looks like the new implementation in
> > do_lwip_tftp() doesn't re-use the argument parsing in netboot_common()
> > and that it doesn't handle the addition of the "-ipv6" flag.
> >
> > I support the addition of LWIP, but I'm concerned about how abrupt
> > changes like this one will be for existing users.  The underlying stack
> > will change, with no easy way for the user to revert to the previous
> > stack. Has there been any discussion about preserving the existing
> > functionality, with an option to enable/disable LWIP stack?This would
> > give the community time to transition/validate LWIP before deprecating
> > the old u-boot networking stack.
>
> IPv6 is news to me...and surprising.
>
> Regards,
> Simon
>

For this time I enabled only ipv4 in lwip U-boot implementation and planned
to keep the original ping6 dhcp6 tftp6 on first submission. After the first
ipv4 lwip patches can be merged I planned to work on ipv6 support.  I think
it will require more time for the test environment to be set up, then
actually enabling ipv6 in the configuration header. lwIP can work in dual
stack mode. But I'm not sure that example applications support ipv6 at this
time.

BR,
Maxim.
