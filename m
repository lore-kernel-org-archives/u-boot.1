Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA182E8FDC3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C2587259;
	Wed,  4 Oct 2023 04:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="kRvMEcrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E158747E; Wed,  4 Oct 2023 04:12:09 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC18887253
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59f6767a15dso4041587b3.0
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696385523; x=1696990323; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AY5/2VYMpCviT57FMX/AllewFderlfgLphYKC75ubdA=;
 b=kRvMEcrl098tjt5C24DyI+YoZpZeg3loD9ED6ibgaVVd1nwdL/4iZJ6TYM09b5e5I0
 G43T6WokPek/LFE/FOQ+UanzIXyN4UzuYbFNqTLjwi42oNINYCmzHDaFMa6U/QgGm3/p
 L46ht9iolEPLjhts6MM2SvTh7nRqyYoxFDSRGnKXS/yOZsu87VT621ZsP3qetaBztUW0
 WAVTLYEKBqTlIYFrp8VQhVWH2e8+WJ8n+MFMerAgVXa34F2Ef56Q3wqtHJ+qiq57sJRl
 RRxFWKgn4Gu5u/9Z8/LAUqlXqIaipQLT17DihWMUfxBsnINGLiVXI+3c+NlgDyLt9A4F
 8OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385523; x=1696990323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AY5/2VYMpCviT57FMX/AllewFderlfgLphYKC75ubdA=;
 b=sC9twWEmtDonIl4NNOTqhoVkopU5l5zm2RSbbFynjACK6NQCKLZNVG0euplqYfGApn
 d6KY0HmMVN35rZS1UuBFZY+vQMA3IUQOfHltRCMjNMm/wguGGbdkgmHSP6UszIsaq7ED
 gEz1nNXGGKAs0L5h93qCh1XTqGT0RRgJ88EVj+r/AfQe6IjD3NIOUJv5q+Q1MVejk7tw
 y9xdvdidP9hHS9twkCFZZaA64dy2SE/yVEpTC1HeZMgr4/palk44NeXadRuqmqJSEC6/
 stSegfBco57veW2SszgziR4MjQRCwO+hJjFxqIFSSWx917xhtr3yCgFw/DTFA0JNvpPq
 TeGA==
X-Gm-Message-State: AOJu0YwJqSNk6Ka7AxQnzK9Y8ImnnMtDwCRNwF22EksInQWlCUNf+6nQ
 sCT90maD4bVpjHk8O1Zx/5hD9L154XFe0HpH1uHV6Q==
X-Google-Smtp-Source: AGHT+IGB/Bp9RnEY1QFVSlYkv+IBkpbfUr5PNIn8t1onGro42si/GwuIV8eDg76q94egVho2dGOGfXzQUbsCQ/rmRrs=
X-Received: by 2002:a81:834c:0:b0:583:7545:2f2e with SMTP id
 t73-20020a81834c000000b0058375452f2emr3366528ywf.7.1696385523447; Tue, 03 Oct
 2023 19:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-15-maxim.uvarov@linaro.org>
 <77c30b7d-66ae-a7ff-0e7d-07be3098acbc@linux.microsoft.com>
In-Reply-To: <77c30b7d-66ae-a7ff-0e7d-07be3098acbc@linux.microsoft.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 3 Oct 2023 20:11:03 -0600
Message-ID: <CAPnjgZ3a5MVTKEzDwnYGiRW+cvz5H-v7ictRUTeUjWJUKV1D9g@mail.gmail.com>
Subject: Re: [PATCHv10 14/15] net/lwip: replace original net commands with lwip
To: Sean Edmond <seanedmond@linux.microsoft.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 trini@konsulko.com, goldsimon@gmx.de
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

Hi Sean,

On Tue, 3 Oct 2023 at 11:58, Sean Edmond <seanedmond@linux.microsoft.com> wrote:
>
>
> On 2023-09-26 2:41 a.m., Maxim Uvarov wrote:
> > Replace original commands: ping, tftp, dhcp and wget.
> >
> > Signed-off-by: Maxim Uvarov<maxim.uvarov@linaro.org>
> > ---
> >   boot/bootmeth_efi.c | 18 +++++++---
> >   boot/bootmeth_pxe.c | 21 ++++++-----
> >   cmd/net.c           | 86 +++++----------------------------------------
> >   cmd/pxe.c           | 19 +++++-----
> >   include/net.h       |  8 +++--
> >   include/net/ulwip.h | 64 +++++++++++++++++++++++++++++++++
> >   6 files changed, 113 insertions(+), 103 deletions(-)
> >   create mode 100644 include/net/ulwip.h
> >
> > diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > index ae936c8daa..52399d627c 100644
> > --- a/boot/bootmeth_efi.c
> > +++ b/boot/bootmeth_efi.c
> > @@ -20,6 +20,8 @@
> >   #include <mapmem.h>
> >   #include <mmc.h>
> >   #include <net.h>
> > +#include <net/lwip.h>
> > +#include <net/ulwip.h>
> >   #include <pxe_utils.h>
> >   #include <linux/sizes.h>
> >
> > @@ -319,9 +321,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
> >
> >   static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> >   {
> > -     char file_addr[17], fname[256];
> > -     char *tftp_argv[] = {"tftp", file_addr, fname, NULL};
> > -     struct cmd_tbl cmdtp = {};      /* dummy */
> > +     char fname[256];
> >       const char *addr_str, *fdt_addr_str;
> >       int ret, arch, size;
> >       ulong addr, fdt_addr;
> > @@ -368,7 +368,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> >       if (!fdt_addr_str)
> >               return log_msg_ret("fdt", -EINVAL);
> >       fdt_addr = hextoul(fdt_addr_str, NULL);
> > -     sprintf(file_addr, "%lx", fdt_addr);
> >
> >       /* We only allow the first prefix with PXE */
> >       ret = distro_efi_get_fdt_name(fname, sizeof(fname), 0);
> > @@ -379,7 +378,16 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> >       if (!bflow->fdt_fname)
> >               return log_msg_ret("fil", -ENOMEM);
> >
> > -     if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
> > +     ret = ulwip_init();
> > +     if (ret)
> > +             return log_msg_ret("ulwip_init", ret);
> > +
> > +     ret = ulwip_tftp(fdt_addr, fname);
> > +     if (ret)
> > +             return log_msg_ret("ulwip_tftp", ret);
> > +
> > +     ret = ulwip_loop();
> > +     if (!ret) {
> >               bflow->fdt_size = env_get_hex("filesize", 0);
> >               bflow->fdt_addr = fdt_addr;
> >       } else {
> > diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
> > index 8d489a11aa..fc6aabaa18 100644
> > --- a/boot/bootmeth_pxe.c
> > +++ b/boot/bootmeth_pxe.c
> > @@ -21,6 +21,8 @@
> >   #include <mapmem.h>
> >   #include <mmc.h>
> >   #include <net.h>
> > +#include <net/ulwip.h>
> > +#include <net/lwip.h>
> >   #include <pxe_utils.h>
> >
> >   static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
> > @@ -116,18 +118,21 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
> >                                 const char *file_path, ulong addr,
> >                                 ulong *sizep)
> >   {
> > -     char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
> > -     struct pxe_context *ctx = dev_get_priv(dev);
> > -     char file_addr[17];
> >       ulong size;
> >       int ret;
> >
> > -     sprintf(file_addr, "%lx", addr);
> > -     tftp_argv[1] = file_addr;
> > -     tftp_argv[2] = (void *)file_path;
> > +     ret = ulwip_init();
> > +     if (ret)
> > +             return log_msg_ret("ulwip_init", ret);
> > +
> > +     ret = ulwip_tftp(addr, file_path);
> > +     if (ret)
> > +             return log_msg_ret("ulwip_tftp", ret);
> > +
> > +     ret = ulwip_loop();
> > +     if (ret)
> > +             return log_msg_ret("ulwip_loop", ret);
> >
> > -     if (do_tftpb(ctx->cmdtp, 0, 3, tftp_argv))
> > -             return -ENOENT;
> >       ret = pxe_get_file_size(&size);
> >       if (ret)
> >               return log_msg_ret("tftp", ret);
> > diff --git a/cmd/net.c b/cmd/net.c
> > index d407d8320a..dc5a114309 100644
> > --- a/cmd/net.c
> > +++ b/cmd/net.c
> > @@ -22,6 +22,7 @@
> >   #include <net/udp.h>
> >   #include <net/sntp.h>
> >   #include <net/ncsi.h>
> > +#include <net/lwip.h>
> >
> >   static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
> >
> > @@ -40,19 +41,9 @@ U_BOOT_CMD(
> >   #endif
> >
> >   #ifdef CONFIG_CMD_TFTPBOOT
> > -int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> > -{
> > -     int ret;
> > -
> > -     bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
> > -     ret = netboot_common(TFTPGET, cmdtp, argc, argv);
> > -     bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
> > -     return ret;
> > -}
> > -
> >   #if IS_ENABLED(CONFIG_IPV6)
> >   U_BOOT_CMD(
> > -     tftpboot,       4,      1,      do_tftpb,
> > +     tftpboot,       4,      1, do_lwip_tftp,
>
> It looks like LWIP doesn't support TFTP with IPv6 addressing.  Perhaps
> we need to fall back onto the existing TFTP implementation until LWIP
> supports it?
>
> Note, that currently, IPv6 TFTP is enabled using the "-ipv6" argument.
> The intention is that netboot_common() sees the argument and sets the
> "use_ip6" variable.  It looks like the new implementation in
> do_lwip_tftp() doesn't re-use the argument parsing in netboot_common()
> and that it doesn't handle the addition of the "-ipv6" flag.
>
> I support the addition of LWIP, but I'm concerned about how abrupt
> changes like this one will be for existing users.  The underlying stack
> will change, with no easy way for the user to revert to the previous
> stack. Has there been any discussion about preserving the existing
> functionality, with an option to enable/disable LWIP stack?This would
> give the community time to transition/validate LWIP before deprecating
> the old u-boot networking stack.

IPv6 is news to me...and surprising.

Regards,
Simon
