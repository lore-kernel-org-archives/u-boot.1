Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09233C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 08:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FEA88178;
	Fri, 22 Mar 2024 09:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YhpqnzLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF94C8817C; Fri, 22 Mar 2024 09:12:40 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8F58816F
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 09:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a468004667aso258785866b.2
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1711095157; x=1711699957;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+D2xFs/MvxVzmcQOO2NbjgJvi5XzBC2Pq4P36oGfrQ=;
 b=YhpqnzLFhSwcgukPTn0TwNtUNiXcGODFOcWt1osVTb1reiwoKc5lQW8WrWLF8W9rTr
 BiCm5kUTmDvWxDu3yLR5mGgbQvh43lrhyfZYCe7SXuoiFaCf6mGcuxYTVpqiuyTeAgNC
 Z6V53SdSgMPHqBsz30qYS9h+AhUSZpzyMSYh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711095157; x=1711699957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+D2xFs/MvxVzmcQOO2NbjgJvi5XzBC2Pq4P36oGfrQ=;
 b=UeU23m6ZQ/BAZWpcgEO1w12g2BgSGUYnfU2WiBs/N7kefHmEk+OyPq1No21Z+Oss13
 AKalv6jn+XxRmL8LpKj50iQiW2eV9kKNIgfIfzkSPsdA/gEeIXP34/wh+NmAVmYDQdsB
 uPiCgh0U539PwfaBbDLG+EG98CbDb+K1ueFWQ6lPiMTetxCQy4TAg6nz7o2+eOvyj1gK
 xZ/Y+9qULENpctuTF8pSb/hKukerfqYzgCPNzR0DneLiYZsS2qCWSWJ3RM0rWQftaaXZ
 qrJuitRsJd98jXZ+ZdgfJ2+EmJevDn722c13Z92dABhQYWYgEhsqwHtNlfyyu9vRqKAA
 gz/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkDOWcwU+c5RlEGUmZv/r0EoZWM1puO8AZ06kgCkNKK52/SZ/Uj/BlqkOxr8oOvjUfqKvXi8Hf2sftbmp4ciJ8NglGVQ==
X-Gm-Message-State: AOJu0Yz5jbzGyXv4NgOoeRxl6kJXON0NLC0/MhiJ6aKZY5yru/ad0vrE
 QvfnhbfyMvkfqe8SIOo280Xo9vkOqfdljzelouwbCrJnXu/V9j0EmU6sEqTcszwRafWbq4cSL/t
 eljffjaK2rYLOcOoxs6pV+DQxAAaLbLR82Iu0Hw==
X-Google-Smtp-Source: AGHT+IEdK9OEOEwLOZvGcRHw0eUBHLS1sfXlx7emelX73IMJbM3ZkIk6NuAKny4hApky2m2XXERx8NxZx6lDGJvrfi4=
X-Received: by 2002:a17:906:f1ce:b0:a47:3469:d75a with SMTP id
 gx14-20020a170906f1ce00b00a473469d75amr343301ejb.67.1711095157297; Fri, 22
 Mar 2024 01:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240320190443.1483274-1-avkrasnov@salutedevices.com>
In-Reply-To: <20240320190443.1483274-1-avkrasnov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 22 Mar 2024 09:12:26 +0100
Message-ID: <CAOf5uwnF8VZoY5pQM6yaGOvT-e4NiBmS965+Re5xZ=X_pQmktw@mail.gmail.com>
Subject: Re: [PATCH v4] cmd: mtd: OTP access support
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Simon Glass <sjg@chromium.org>, Alexey Romanov <avromanov@sberdevices.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>, 
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sean Edmond <seanedmond@microsoft.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
 Michael Walle <michael@walle.cc>, Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de, 
 kernel@sberdevices.ru, oxffffaa@gmail.com
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

Hi Arseniy

On Wed, Mar 20, 2024 at 8:14=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Add access to OTP region. It supports info, dump, write and lock
> operations. Usage example:
>
> 'mtd otpread nand0 u 0 1024' - dump 1024 bytes of user area starting
>  from offset 0 of device 'nand0'.
>
> 'mtd otpwrite nand0 10 11223344' - write binary data 0x11, 0x22, 0x33,
>  0x44 to offset 10 to user area of device 'nand0'.
>
> 'mtd otplock nand0 0 1024' - lock 1024 bytes of user area starting
>  from offset 0 of device 'nand0'.
>
> 'mtd otpinfo nand0 f' - show info about factory area of device 'nand0'.
>
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  Changelog:
>  v1 -> v2:
>   * Remove warning that OTP can't be erased after write.
>  v2 -> v3:
>   * Commit message updated by adding usage.
>   * R-b added.
>  v3 -> v4:
>   * Fix build failure due to invalid format strings for 'printf()'.
>   * Rebase over latest version of cmd/mtd.c.
>
>  cmd/Kconfig |   1 +
>  cmd/mtd.c   | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 225 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 7292a150f5..f218dc6cf2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1363,6 +1363,7 @@ config CMD_MTD
>         bool "mtd"
>         depends on MTD
>         select MTD_PARTITIONS
> +       select HEXDUMP

Make those change forced in increase the size of uboot and break this build

https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/jobs/802378

I think that those command could be optional and not forced to be
included by default

Michael


>         help
>           MTD commands support.
>
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index e63c011e79..2b03a85ef0 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -11,6 +11,7 @@
>  #include <command.h>
>  #include <common.h>
>  #include <console.h>
> +#include <hexdump.h>
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <mtd.h>
> @@ -202,6 +203,219 @@ static bool mtd_oob_write_is_empty(struct mtd_oob_o=
ps *op)
>         return true;
>  }
>
> +static int do_mtd_otp_read(struct cmd_tbl *cmdtp, int flag, int argc,
> +                          char *const argv[])
> +{
> +       struct mtd_info *mtd;
> +       size_t retlen;
> +       off_t from;
> +       size_t len;
> +       bool user;
> +       int ret;
> +       u8 *buf;
> +
> +       if (argc !=3D 5)
> +               return CMD_RET_USAGE;
> +
> +       if (!strcmp(argv[2], "u"))
> +               user =3D true;
> +       else if (!strcmp(argv[2], "f"))
> +               user =3D false;
> +       else
> +               return CMD_RET_USAGE;
> +
> +       mtd =3D get_mtd_by_name(argv[1]);
> +       if (IS_ERR_OR_NULL(mtd))
> +               return CMD_RET_FAILURE;
> +
> +       from =3D simple_strtoul(argv[3], NULL, 0);
> +       len =3D simple_strtoul(argv[4], NULL, 0);
> +
> +       ret =3D CMD_RET_FAILURE;
> +
> +       buf =3D malloc(len);
> +       if (!buf)
> +               goto put_mtd;
> +
> +       printf("Reading %s OTP from 0x%lx, %zu bytes\n",
> +              user ? "user" : "factory", from, len);
> +
> +       if (user)
> +               ret =3D mtd_read_user_prot_reg(mtd, from, len, &retlen, b=
uf);
> +       else
> +               ret =3D mtd_read_fact_prot_reg(mtd, from, len, &retlen, b=
uf);
> +       if (ret) {
> +               free(buf);
> +               pr_err("OTP read failed: %d\n", ret);
> +               ret =3D CMD_RET_FAILURE;
> +               goto put_mtd;
> +       }
> +
> +       if (retlen !=3D len)
> +               pr_err("OTP read returns %zu, but %zu expected\n",
> +                      retlen, len);
> +
> +       print_hex_dump("", 0, 16, 1, buf, retlen, true);
> +
> +       free(buf);
> +
> +       ret =3D CMD_RET_SUCCESS;
> +
> +put_mtd:
> +       put_mtd_device(mtd);
> +
> +       return ret;
> +}
> +
> +static int do_mtd_otp_lock(struct cmd_tbl *cmdtp, int flag, int argc,
> +                          char *const argv[])
> +{
> +       struct mtd_info *mtd;
> +       off_t from;
> +       size_t len;
> +       int ret;
> +
> +       if (argc !=3D 4)
> +               return CMD_RET_USAGE;
> +
> +       mtd =3D get_mtd_by_name(argv[1]);
> +       if (IS_ERR_OR_NULL(mtd))
> +               return CMD_RET_FAILURE;
> +
> +       from =3D simple_strtoul(argv[2], NULL, 0);
> +       len =3D simple_strtoul(argv[3], NULL, 0);
> +
> +       ret =3D mtd_lock_user_prot_reg(mtd, from, len);
> +       if (ret) {
> +               pr_err("OTP lock failed: %d\n", ret);
> +               ret =3D CMD_RET_FAILURE;
> +               goto put_mtd;
> +       }
> +
> +       ret =3D CMD_RET_SUCCESS;
> +
> +put_mtd:
> +       put_mtd_device(mtd);
> +
> +       return ret;
> +}
> +
> +static int do_mtd_otp_write(struct cmd_tbl *cmdtp, int flag, int argc,
> +                           char *const argv[])
> +{
> +       struct mtd_info *mtd;
> +       size_t retlen;
> +       size_t binlen;
> +       u8 *binbuf;
> +       off_t from;
> +       int ret;
> +
> +       if (argc !=3D 4)
> +               return CMD_RET_USAGE;
> +
> +       mtd =3D get_mtd_by_name(argv[1]);
> +       if (IS_ERR_OR_NULL(mtd))
> +               return CMD_RET_FAILURE;
> +
> +       from =3D simple_strtoul(argv[2], NULL, 0);
> +       binlen =3D strlen(argv[3]) / 2;
> +
> +       ret =3D CMD_RET_FAILURE;
> +       binbuf =3D malloc(binlen);
> +       if (!binbuf)
> +               goto put_mtd;
> +
> +       hex2bin(binbuf, argv[3], binlen);
> +
> +       printf("Will write:\n");
> +
> +       print_hex_dump("", 0, 16, 1, binbuf, binlen, true);
> +
> +       printf("to 0x%lx\n", from);
> +
> +       printf("Continue (y/n)?\n");
> +
> +       if (confirm_yesno() !=3D 1) {
> +               pr_err("OTP write canceled\n");
> +               ret =3D CMD_RET_SUCCESS;
> +               goto put_mtd;
> +       }
> +
> +       ret =3D mtd_write_user_prot_reg(mtd, from, binlen, &retlen, binbu=
f);
> +       if (ret) {
> +               pr_err("OTP write failed: %d\n", ret);
> +               ret =3D CMD_RET_FAILURE;
> +               goto put_mtd;
> +       }
> +
> +       if (retlen !=3D binlen)
> +               pr_err("OTP write returns %zu, but %zu expected\n",
> +                      retlen, binlen);
> +
> +       ret =3D CMD_RET_SUCCESS;
> +
> +put_mtd:
> +       free(binbuf);
> +       put_mtd_device(mtd);
> +
> +       return ret;
> +}
> +
> +static int do_mtd_otp_info(struct cmd_tbl *cmdtp, int flag, int argc,
> +                          char *const argv[])
> +{
> +       struct otp_info otp_info;
> +       struct mtd_info *mtd;
> +       size_t retlen;
> +       bool user;
> +       int ret;
> +
> +       if (argc !=3D 3)
> +               return CMD_RET_USAGE;
> +
> +       if (!strcmp(argv[2], "u"))
> +               user =3D true;
> +       else if (!strcmp(argv[2], "f"))
> +               user =3D false;
> +       else
> +               return CMD_RET_USAGE;
> +
> +       mtd =3D get_mtd_by_name(argv[1]);
> +       if (IS_ERR_OR_NULL(mtd))
> +               return CMD_RET_FAILURE;
> +
> +       if (user)
> +               ret =3D mtd_get_user_prot_info(mtd, sizeof(otp_info), &re=
tlen,
> +                                            &otp_info);
> +       else
> +               ret =3D mtd_get_fact_prot_info(mtd, sizeof(otp_info), &re=
tlen,
> +                                            &otp_info);
> +       if (ret) {
> +               pr_err("OTP info failed: %d\n", ret);
> +               ret =3D CMD_RET_FAILURE;
> +               goto put_mtd;
> +       }
> +
> +       if (retlen !=3D sizeof(otp_info)) {
> +               pr_err("OTP info returns %zu, but %zu expected\n",
> +                      retlen, sizeof(otp_info));
> +               ret =3D CMD_RET_FAILURE;
> +               goto put_mtd;
> +       }
> +
> +       printf("%s OTP region info:\n", user ? "User" : "Factory");
> +       printf("\tstart: %u\n", otp_info.start);
> +       printf("\tlength: %u\n", otp_info.length);
> +       printf("\tlocked: %u\n", otp_info.locked);
> +
> +       ret =3D CMD_RET_SUCCESS;
> +
> +put_mtd:
> +       put_mtd_device(mtd);
> +
> +       return ret;
> +}
> +
>  static int do_mtd_list(struct cmd_tbl *cmdtp, int flag, int argc,
>                        char *const argv[])
>  {
> @@ -551,6 +765,10 @@ U_BOOT_LONGHELP(mtd,
>         "\n"
>         "Specific functions:\n"
>         "mtd bad                               <name>\n"
> +       "mtd otpread                           <name> [u|f] <off> <size>\=
n"
> +       "mtd otpwrite                          <name> <off> <hex string>\=
n"
> +       "mtd otplock                           <name> <off> <size>\n"
> +       "mtd otpinfo                           <name> [u|f]\n"
>         "\n"
>         "With:\n"
>         "\t<name>: NAND partition/chip name (or corresponding DM device n=
ame or OF path)\n"
> @@ -561,10 +779,16 @@ U_BOOT_LONGHELP(mtd,
>         "\t<size>: length of the operation in bytes (default: the entire =
device)\n"
>         "\t\t* must be a multiple of a block for erase\n"
>         "\t\t* must be a multiple of a page otherwise (special case: defa=
ult is a page with dump)\n"
> +       "\t<hex string>: hex string without '0x' and spaces. Example: ABC=
D1234\n"
> +       "\t[u|f]: user or factory OTP region\n"
>         "\n"
>         "The .dontskipff option forces writing empty pages, don't use it =
if unsure.\n");
>
>  U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
> +               U_BOOT_SUBCMD_MKENT(otpread, 5, 1, do_mtd_otp_read),
> +               U_BOOT_SUBCMD_MKENT(otpwrite, 4, 1, do_mtd_otp_write),
> +               U_BOOT_SUBCMD_MKENT(otplock, 4, 1, do_mtd_otp_lock),
> +               U_BOOT_SUBCMD_MKENT(otpinfo, 3, 1, do_mtd_otp_info),
>                 U_BOOT_SUBCMD_MKENT(list, 1, 1, do_mtd_list),
>                 U_BOOT_SUBCMD_MKENT_COMPLETE(read, 5, 0, do_mtd_io,
>                                              mtd_name_complete),
> --
> 2.35.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
