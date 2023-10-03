Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9F2E8FDBC
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 21:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5CB86E2C;
	Tue,  3 Oct 2023 23:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W7uVc5ed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0221A86E28; Tue,  3 Oct 2023 23:58:38 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C531C86E2C
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 23:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso2560994a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696370315; x=1696975115; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6wvvPKNBfyqa2KLz4/s5HOZvitSk88WCLdgda0Kjv8=;
 b=W7uVc5edyhu3ZlSzb2Hnrq3yZF0UP/1pXrefCbwK9rAwHppwthmJ0PmD4MJC93JArn
 A6RCpAJycDzKr/PjxpPkxGFqzRt3fog6o4HVyH1L2q6K69Lv8VmcthVnB7hihO+ZthKb
 wn3CDeBw9hin/PBfMuNvkQenTRMZMq3GtiDFqhpGSG4ziwS3tHfQez4+exBduYeU6IF1
 JOFvngDitj7NNQp1uSzJlnDFcEfBjr2EHXmDDh1609KY/U7kTAbEyfvDJaTAd6Xn6Bom
 de/t/ZyHz6JoOFeg/wohib2UfQUMsrKo7JpwWKQ3wR2rAObQoCjM9o98IQh3tLZycuvE
 utSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696370315; x=1696975115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6wvvPKNBfyqa2KLz4/s5HOZvitSk88WCLdgda0Kjv8=;
 b=UX03a+hp+76h2dpnfhd2fyFeNpy3yyKpjNNeCOwwLacn6PVv2cFXaqRJukDWMUCeAO
 8+YYXdCzKu7LIz/ODzf5hypGr+RNb4SM1cd4f7BwVV4e9Rh5RBWcJ7KNjvXyuu9rGosx
 QtKNnoYcySb3a8UHyU/KRPPBgpW1K0EA4MeCM8yVa4qiTxJdGnuDqxZXNgVGFgbrUOne
 +QxQSgEvoV/z4pWbezuUeFUG2RqPF4OWy/1BRrJTiiH0KEQ9X3uc2HsLaV44LZLEo5Y0
 TSeXYNurN0zDvYxk7Ab9mX7WUdqua5u9Vm/+WKJj32yHSpyi8/Ux3z/2cfOBetvkNLmB
 zjIQ==
X-Gm-Message-State: AOJu0YzOj9gzukbBQPlyRJgoWyimlqNVgUbhpFluWxatuLzZBapuJiX9
 iya+eOfR42Yw+GPvEh1tZrTikdVmsqQkp+KfpUA=
X-Google-Smtp-Source: AGHT+IHnjuIMGYwLQcDPINWL0+R8cccDC2SXs+CWidGlFh+oFo1Nm5Hf9p3pRYz3pvmB4PQS7mGAMlxX9NY95soRgpo=
X-Received: by 2002:a05:6402:74c:b0:532:c92f:3e1a with SMTP id
 p12-20020a056402074c00b00532c92f3e1amr375139edy.28.1696370314943; Tue, 03 Oct
 2023 14:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-15-maxim.uvarov@linaro.org>
 <77c30b7d-66ae-a7ff-0e7d-07be3098acbc@linux.microsoft.com>
In-Reply-To: <77c30b7d-66ae-a7ff-0e7d-07be3098acbc@linux.microsoft.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 3 Oct 2023 22:58:23 +0100
Message-ID: <CALeDE9NkvMbmwZP-7E4_mH3WfFAV==ZX_3PMhk7DKYj5OyFqmQ@mail.gmail.com>
Subject: Re: [PATCHv10 14/15] net/lwip: replace original net commands with lwip
To: Sean Edmond <seanedmond@linux.microsoft.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 trini@konsulko.com, goldsimon@gmx.de
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

On Tue, Oct 3, 2023 at 6:58=E2=80=AFPM Sean Edmond
<seanedmond@linux.microsoft.com> wrote:
>
>
> On 2023-09-26 2:41 a.m., Maxim Uvarov wrote:
>
> Replace original commands: ping, tftp, dhcp and wget.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  boot/bootmeth_efi.c | 18 +++++++---
>  boot/bootmeth_pxe.c | 21 ++++++-----
>  cmd/net.c           | 86 +++++----------------------------------------
>  cmd/pxe.c           | 19 +++++-----
>  include/net.h       |  8 +++--
>  include/net/ulwip.h | 64 +++++++++++++++++++++++++++++++++
>  6 files changed, 113 insertions(+), 103 deletions(-)
>  create mode 100644 include/net/ulwip.h
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index ae936c8daa..52399d627c 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -20,6 +20,8 @@
>  #include <mapmem.h>
>  #include <mmc.h>
>  #include <net.h>
> +#include <net/lwip.h>
> +#include <net/ulwip.h>
>  #include <pxe_utils.h>
>  #include <linux/sizes.h>
>
> @@ -319,9 +321,7 @@ static int distro_efi_try_bootflow_files(struct udevi=
ce *dev,
>
>  static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>  {
> - char file_addr[17], fname[256];
> - char *tftp_argv[] =3D {"tftp", file_addr, fname, NULL};
> - struct cmd_tbl cmdtp =3D {}; /* dummy */
> + char fname[256];
>   const char *addr_str, *fdt_addr_str;
>   int ret, arch, size;
>   ulong addr, fdt_addr;
> @@ -368,7 +368,6 @@ static int distro_efi_read_bootflow_net(struct bootfl=
ow *bflow)
>   if (!fdt_addr_str)
>   return log_msg_ret("fdt", -EINVAL);
>   fdt_addr =3D hextoul(fdt_addr_str, NULL);
> - sprintf(file_addr, "%lx", fdt_addr);
>
>   /* We only allow the first prefix with PXE */
>   ret =3D distro_efi_get_fdt_name(fname, sizeof(fname), 0);
> @@ -379,7 +378,16 @@ static int distro_efi_read_bootflow_net(struct bootf=
low *bflow)
>   if (!bflow->fdt_fname)
>   return log_msg_ret("fil", -ENOMEM);
>
> - if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
> + ret =3D ulwip_init();
> + if (ret)
> + return log_msg_ret("ulwip_init", ret);
> +
> + ret =3D ulwip_tftp(fdt_addr, fname);
> + if (ret)
> + return log_msg_ret("ulwip_tftp", ret);
> +
> + ret =3D ulwip_loop();
> + if (!ret) {
>   bflow->fdt_size =3D env_get_hex("filesize", 0);
>   bflow->fdt_addr =3D fdt_addr;
>   } else {
> diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
> index 8d489a11aa..fc6aabaa18 100644
> --- a/boot/bootmeth_pxe.c
> +++ b/boot/bootmeth_pxe.c
> @@ -21,6 +21,8 @@
>  #include <mapmem.h>
>  #include <mmc.h>
>  #include <net.h>
> +#include <net/ulwip.h>
> +#include <net/lwip.h>
>  #include <pxe_utils.h>
>
>  static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *fil=
e_path,
> @@ -116,18 +118,21 @@ static int extlinux_pxe_read_file(struct udevice *d=
ev, struct bootflow *bflow,
>    const char *file_path, ulong addr,
>    ulong *sizep)
>  {
> - char *tftp_argv[] =3D {"tftp", NULL, NULL, NULL};
> - struct pxe_context *ctx =3D dev_get_priv(dev);
> - char file_addr[17];
>   ulong size;
>   int ret;
>
> - sprintf(file_addr, "%lx", addr);
> - tftp_argv[1] =3D file_addr;
> - tftp_argv[2] =3D (void *)file_path;
> + ret =3D ulwip_init();
> + if (ret)
> + return log_msg_ret("ulwip_init", ret);
> +
> + ret =3D ulwip_tftp(addr, file_path);
> + if (ret)
> + return log_msg_ret("ulwip_tftp", ret);
> +
> + ret =3D ulwip_loop();
> + if (ret)
> + return log_msg_ret("ulwip_loop", ret);
>
> - if (do_tftpb(ctx->cmdtp, 0, 3, tftp_argv))
> - return -ENOENT;
>   ret =3D pxe_get_file_size(&size);
>   if (ret)
>   return log_msg_ret("tftp", ret);
> diff --git a/cmd/net.c b/cmd/net.c
> index d407d8320a..dc5a114309 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -22,6 +22,7 @@
>  #include <net/udp.h>
>  #include <net/sntp.h>
>  #include <net/ncsi.h>
> +#include <net/lwip.h>
>
>  static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * co=
nst []);
>
> @@ -40,19 +41,9 @@ U_BOOT_CMD(
>  #endif
>
>  #ifdef CONFIG_CMD_TFTPBOOT
> -int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[])
> -{
> - int ret;
> -
> - bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
> - ret =3D netboot_common(TFTPGET, cmdtp, argc, argv);
> - bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
> - return ret;
> -}
> -
>  #if IS_ENABLED(CONFIG_IPV6)
>  U_BOOT_CMD(
> - tftpboot, 4, 1, do_tftpb,
> + tftpboot, 4, 1, do_lwip_tftp,
>
> It looks like LWIP doesn't support TFTP with IPv6 addressing.  Perhaps we=
 need to fall back onto the existing TFTP implementation until LWIP support=
s it?

Is it that LWIP upstream doesn't support IPv6 with TFTP or it just
hasn't been dealt with in this patch set? If the former  might be
useful to reference details.

> Note, that currently, IPv6 TFTP is enabled using the "-ipv6" argument.  T=
he intention is that netboot_common() sees the argument and sets the "use_i=
p6" variable.  It looks like the new implementation in do_lwip_tftp() doesn=
't re-use the argument parsing in netboot_common() and that it doesn't hand=
le the addition of the "-ipv6" flag.

Is there a reason why there's a need of an explicit argument for IPv6?
I would have thought if there was a local IPv6 address assigned that
you would automatically try IPv6 and if it fails for back to v4, or
even better do a DNS lookup and use what ever gets returned. Having to
know what to use by manually specifying a parameter doesn't sound like
a great user experience, what's the use case?

> I support the addition of LWIP, but I'm concerned about how abrupt change=
s like this one will be for existing users.  The underlying stack will chan=
ge, with no easy way for the user to revert to the previous stack.  Has the=
re been any discussion about preserving the existing functionality, with an=
 option to enable/disable LWIP stack?  This would give the community time t=
o transition/validate LWIP before deprecating the old u-boot networking sta=
ck.

The problem is how long do we maintain dual stacks, do we default to
which one, when do we switch the defaults, how long do we wait to
remove the stack and the maintenance burden on the small amount of
maintainers?

>
>   "boot image via network using TFTP protocol\n"
>   "To use IPv6 add -ipv6 parameter or use IPv6 hostIPaddr framed "
>   "with [] brackets",
> @@ -60,7 +51,7 @@ U_BOOT_CMD(
>  );
>  #else
>  U_BOOT_CMD(
> - tftpboot, 3, 1, do_tftpb,
> + tftpboot, 3, 1,  do_lwip_tftp,
>   "load file via network using TFTP protocol",
>   "[loadAddress] [[hostIPaddr:]bootfilename]"
>  );
> @@ -139,7 +130,7 @@ U_BOOT_CMD(dhcp6, 3, 1, do_dhcp6,
>  static int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
>     char *const argv[])
>  {
> - return netboot_common(DHCP, cmdtp, argc, argv);
> + return do_lwip_dhcp();
>  }
>
>  U_BOOT_CMD(
> @@ -196,13 +187,11 @@ U_BOOT_CMD(
>  #endif
>
>  #if defined(CONFIG_CMD_WGET)
> -static int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * con=
st argv[])
> -{
> - return netboot_common(WGET, cmdtp, argc, argv);
> -}
> +int do_lwip_wget(struct cmd_tbl *cmdtp, int flag, int argc,
> + char *const argv[]);
>
>  U_BOOT_CMD(
> - wget,   3,      1,      do_wget,
> + wget,   3,      1, do_lwip_wget,
>   "boot image via network using HTTP protocol",
>   "[loadAddress] [[hostIPaddr:]path and image name]"
>  );
> @@ -456,28 +445,8 @@ static int netboot_common(enum proto_t proto, struct=
 cmd_tbl *cmdtp, int argc,
>  }
>
>  #if defined(CONFIG_CMD_PING)
> -static int do_ping(struct cmd_tbl *cmdtp, int flag, int argc,
> -   char *const argv[])
> -{
> - if (argc < 2)
> - return CMD_RET_USAGE;
> -
> - net_ping_ip =3D string_to_ip(argv[1]);
> - if (net_ping_ip.s_addr =3D=3D 0)
> - return CMD_RET_USAGE;
> -
> - if (net_loop(PING) < 0) {
> - printf("ping failed; host %s is not alive\n", argv[1]);
> - return CMD_RET_FAILURE;
> - }
> -
> - printf("host %s is alive\n", argv[1]);
> -
> - return CMD_RET_SUCCESS;
> -}
> -
>  U_BOOT_CMD(
> - ping, 2, 1, do_ping,
> + ping, 2, 1, do_lwip_ping,
>   "send ICMP ECHO_REQUEST to network host",
>   "pingAddress"
>  );
> @@ -601,45 +570,8 @@ U_BOOT_CMD(
>  #endif
>
>  #if defined(CONFIG_CMD_DNS)
> -int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]=
)
> -{
> - if (argc =3D=3D 1)
> - return CMD_RET_USAGE;
> -
> - /*
> - * We should check for a valid hostname:
> - * - Each label must be between 1 and 63 characters long
> - * - the entire hostname has a maximum of 255 characters
> - * - only the ASCII letters 'a' through 'z' (case-insensitive),
> - *   the digits '0' through '9', and the hyphen
> - * - cannot begin or end with a hyphen
> - * - no other symbols, punctuation characters, or blank spaces are
> - *   permitted
> - * but hey - this is a minimalist implmentation, so only check length
> - * and let the name server deal with things.
> - */
> - if (strlen(argv[1]) >=3D 255) {
> - printf("dns error: hostname too long\n");
> - return CMD_RET_FAILURE;
> - }
> -
> - net_dns_resolve =3D argv[1];
> -
> - if (argc =3D=3D 3)
> - net_dns_env_var =3D argv[2];
> - else
> - net_dns_env_var =3D NULL;
> -
> - if (net_loop(DNS) < 0) {
> - printf("dns lookup of %s failed, check setup\n", argv[1]);
> - return CMD_RET_FAILURE;
> - }
> -
> - return CMD_RET_SUCCESS;
> -}
> -
>  U_BOOT_CMD(
> - dns, 3, 1, do_dns,
> + dns, 3, 1, do_lwip_dns,
>   "lookup the IP of a hostname",
>   "hostname [envvar]"
>  );
> diff --git a/cmd/pxe.c b/cmd/pxe.c
> index 677142520b..d44df428d2 100644
> --- a/cmd/pxe.c
> +++ b/cmd/pxe.c
> @@ -8,6 +8,7 @@
>  #include <command.h>
>  #include <fs.h>
>  #include <net.h>
> +#include <net/lwip.h>
>  #include <net6.h>
>  #include <malloc.h>
>
> @@ -29,21 +30,19 @@ const char *pxe_default_paths[] =3D {
>  static int do_get_tftp(struct pxe_context *ctx, const char *file_path,
>         char *file_addr, ulong *sizep)
>  {
> - char *tftp_argv[] =3D {"tftp", NULL, NULL, NULL};
> + ulong addr;
> + char *end;
>   int ret;
> - int num_args;
>
> - tftp_argv[1] =3D file_addr;
> - tftp_argv[2] =3D (void *)file_path;
> + addr =3D hextoul(file_addr, &end);
> +
>   if (ctx->use_ipv6) {
> - tftp_argv[3] =3D USE_IP6_CMD_PARAM;
> - num_args =3D 4;
> - } else {
> - num_args =3D 3;
> + /* @todo: check and fix me, here */
>
> Again, looks like LWIP doesn't support IPv6 addressing, we may want to fa=
ll back on existing TFTP implementation here.
>
>   }
>
> - if (do_tftpb(ctx->cmdtp, 0, num_args, tftp_argv))
> - return -ENOENT;
> + ret =3D ulwip_tftp(addr, file_path);
> + if (ret)
> + return log_msg_ret("tftp", ret);
>
>   ret =3D pxe_get_file_size(sizep);
>   if (ret)
> diff --git a/include/net.h b/include/net.h
> index e254df7d7f..de7baeb121 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -54,8 +54,10 @@ struct in_addr {
>   __be32 s_addr;
>  };
>
> +int do_lwip_dhcp(void);
> +
>  /**
> - * do_tftpb - Run the tftpboot command
> + * do_lwip_tftp - Run the tftpboot command
>   *
>   * @cmdtp: Command information for tftpboot
>   * @flag: Command flags (CMD_FLAG_...)
> @@ -63,7 +65,7 @@ struct in_addr {
>   * @argv: List of arguments
>   * Return: result (see enum command_ret_t)
>   */
> -int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[]);
> +int do_lwip_tftp(struct cmd_tbl *cmdtp, int flag, int argc, char *const =
argv[]);
>
>  /**
>   * dhcp_run() - Run DHCP on the current ethernet device
> @@ -514,7 +516,7 @@ extern int net_restart_wrap; /* Tried all network dev=
ices */
>  enum proto_t {
>   BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
>   NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
> - WOL, UDP, NCSI, WGET, RS
> + WOL, UDP, NCSI, WGET, RS, LWIP
>  };
>
>  extern char net_boot_file_name[1024];/* Boot File name */
> diff --git a/include/net/ulwip.h b/include/net/ulwip.h
> new file mode 100644
> index 0000000000..8eac7aa130
> --- /dev/null
> +++ b/include/net/ulwip.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/**
> + * ulwip_init() - initialize lwIP network stack
> + *
> + * @return 0 if success, !0 if error
> + */
> +int ulwip_init(void);
> +
> +/**
> + * ulwip_enabled() - check if lwIP network stack was initialized
> + *
> + * @return 1 lwip initialized, 0 if not yet initialized
> + */
> +int ulwip_enabled(void);
> +
> +/**
> + * ulwip_in_loop() - lwIP controls packet net loop
> + *
> + * @return 1 lwIP owns packet loop, 0 lwip does not own packet loop
> + */
> +int ulwip_in_loop(void);
> +
> +/**
> + * ulwip_loop_set() - make loop to be used by lwIP
> + *
> + * Function is used to make lwIP control network pool.
> + *
> + * @loop: 1. Rx packets go to lwIP 2. Rx packets go to the original stac=
k.
> + */
> +void ulwip_loop_set(int loop);
> +
> +/**
> + * ulwip_exit() - exit from lwIP with a return code
> + *
> + * Exit from lwIP application back to the U-Boot with specific error cod=
e.
> + *
> + * @err: Error code to return
> + */
> +void ulwip_exit(int err);
> +
> +/**
> + * ulwip_poll() - polling function to feed lwIP with ethernet packet
> + *
> + * Function takes network packet and passes it to lwIP network stack
> + */
> +void ulwip_poll(void);
> +
> +/**
> + * ulwip_app_get_err() - return error code from lwIP application
> + *
> + * @return error code
> + */
> +int ulwip_app_get_err(void);
> +
> +/**
> + * ulwip_loop() - enter to packet polling loop
> + *
> + * When lwIP application did it's initialization stage, then it needs to=
 enter
> + * to packet polling loop to grab rx packets.
> + *
> + * Returns:  0 if success, !0 if error
> + */
> +int ulwip_loop(void);
