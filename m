Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F399CC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 13:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803DE88052;
	Sun, 14 Apr 2024 15:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LWeMfkOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F07E8808B; Sun, 14 Apr 2024 15:46:59 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDE687F84
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 15:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6181d032bf9so23333267b3.3
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713102415; x=1713707215;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsUfGN8cphEt7l21q6D4CppNvDAfBS+Lk9EDopObIFw=;
 b=LWeMfkOPRLkfmuNd424d8oRlvKjBlKti8IEFiCJNY3YvJ5Wp9njG0Z4+DQ+1vlPzA0
 gBjG+LnIQlLtvIo8VtkY1A0jRnQzdf19nBgHUG53Wzu9CCDB4LimV30QsI5bRHJO5csU
 jBxfeqK/jkV3tEh+W8uQmFa1jnJ+CL8ksjEms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713102415; x=1713707215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsUfGN8cphEt7l21q6D4CppNvDAfBS+Lk9EDopObIFw=;
 b=djtz4FJ1l/txV16pHMri4agyoYciLck18WGOU7DOog5Sz0LzjeVP+UCaCRzBmB0vk0
 /fvFO37cXJT38Y6TckFqLLugkvs/z5omOnSXbtOOwLMspKKYovV9PUAeZIgJKsygI5yX
 rde3WJXdwTicKJgKyKzvtxU7PybgaQJ8N1j3VdStfXW/tbtLHOFnPorTzlfb6XYisjso
 22IghXewWAdwQBTJhsTTStCb55YmjwRoCibES/wCp6HMv7U+gSFmD72QG7sqCg45H4ZQ
 wAIptso4owaWYvk8kxyeNdano4GUdAyRR4Z+IPDSilF4GOQYC/XUrlqqmZtoHxqXwYj+
 yfyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6a0JFU9U9TCeoXziOy4VUStn67dTvfhLKCDkupZcbSR7cWw2wlcC9AcCfVRf+Sx9CfC9V7npx9e2wVn5CkNrjhkQIjg==
X-Gm-Message-State: AOJu0YxC8ONXFj1v4fBZgMcG61R/u6Ba8uQ5x5ejA2jxXmqfID86LBVf
 WYviVqZhGdjgP/68TMcRm2Hza6E7+AY+emXOPDO9olfzjtesXki9aFt+CLy93PYcpSSuGHjrH7D
 tvV+o0CPhq2rVk573g+sfcyhqLdcXd3ZZsLaAXg==
X-Google-Smtp-Source: AGHT+IHYhUBljZOSXqPEwe41mk7zgX0Ed0UdtRezxlnOCTZzrX3tZagNDzw6O/xgMcIJ+RXMRLErTPC/Yglwh8ApjLk=
X-Received: by 2002:a05:690c:983:b0:618:8a27:6150 with SMTP id
 ce3-20020a05690c098300b006188a276150mr4922837ywb.24.1713102415389; Sun, 14
 Apr 2024 06:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240326223919.3781-1-avkrasnov@salutedevices.com>
In-Reply-To: <20240326223919.3781-1-avkrasnov@salutedevices.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 14 Apr 2024 15:46:42 +0200
Message-ID: <CABGWkvo4yxWtcJ8D2_jEO0Or=HaVZK5A_uEv4MwBzQ_AB-sZyw@mail.gmail.com>
Subject: Re: [PATCH v5] cmd: mtd: OTP access support
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
 Michael Trimarchi <michael@amarulasolutions.com>, u-boot@lists.denx.de,
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

Hi Arseniy,

On Tue, Mar 26, 2024 at 11:49=E2=80=AFPM Arseniy Krasnov
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
>  v4 -> v5:
>   * Implement commands from this patch as config option due to too big
>     final size of the uboot image.
>   * R-b removed because of patch update.
>
>  cmd/Kconfig |   7 ++
>  cmd/mtd.c   | 234 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 241 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 7292a150f5..832098e66e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1366,6 +1366,13 @@ config CMD_MTD
>         help
>           MTD commands support.
>
> +config CMD_MTD_OTP
> +       bool "mtd otp"
> +       depends on CMD_MTD
> +       select HEXDUMP
> +       help
> +         MTD commands for OTP access.
> +
>  config CMD_MUX
>         bool "mux"
>         depends on MULTIPLEXER
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index e63c011e79..c66105e373 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -11,6 +11,9 @@
>  #include <command.h>
>  #include <common.h>
>  #include <console.h>
> +#if CONFIG_IS_ENABLED(CMD_MTD_OTP)
> +#include <hexdump.h>
> +#endif
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <mtd.h>
> @@ -202,6 +205,221 @@ static bool mtd_oob_write_is_empty(struct mtd_oob_o=
ps *op)
>         return true;
>  }
>
> +#if CONFIG_IS_ENABLED(CMD_MTD_OTP)
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
> +#endif
> +
>  static int do_mtd_list(struct cmd_tbl *cmdtp, int flag, int argc,
>                        char *const argv[])
>  {
> @@ -551,6 +769,12 @@ U_BOOT_LONGHELP(mtd,
>         "\n"
>         "Specific functions:\n"
>         "mtd bad                               <name>\n"
> +#if CONFIG_IS_ENABLED(CMD_MTD_OTP)
> +       "mtd otpread                           <name> [u|f] <off> <size>\=
n"
> +       "mtd otpwrite                          <name> <off> <hex string>\=
n"
> +       "mtd otplock                           <name> <off> <size>\n"
> +       "mtd otpinfo                           <name> [u|f]\n"
> +#endif
>         "\n"
>         "With:\n"
>         "\t<name>: NAND partition/chip name (or corresponding DM device n=
ame or OF path)\n"
> @@ -561,10 +785,20 @@ U_BOOT_LONGHELP(mtd,
>         "\t<size>: length of the operation in bytes (default: the entire =
device)\n"
>         "\t\t* must be a multiple of a block for erase\n"
>         "\t\t* must be a multiple of a page otherwise (special case: defa=
ult is a page with dump)\n"
> +#if CONFIG_IS_ENABLED(CMD_MTD_OTP)
> +       "\t<hex string>: hex string without '0x' and spaces. Example: ABC=
D1234\n"
> +       "\t[u|f]: user or factory OTP region\n"
> +#endif
>         "\n"
>         "The .dontskipff option forces writing empty pages, don't use it =
if unsure.\n");
>
>  U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
> +#if CONFIG_IS_ENABLED(CMD_MTD_OTP)
> +               U_BOOT_SUBCMD_MKENT(otpread, 5, 1, do_mtd_otp_read),
> +               U_BOOT_SUBCMD_MKENT(otpwrite, 4, 1, do_mtd_otp_write),
> +               U_BOOT_SUBCMD_MKENT(otplock, 4, 1, do_mtd_otp_lock),
> +               U_BOOT_SUBCMD_MKENT(otpinfo, 3, 1, do_mtd_otp_info),
> +#endif
>                 U_BOOT_SUBCMD_MKENT(list, 1, 1, do_mtd_list),
>                 U_BOOT_SUBCMD_MKENT_COMPLETE(read, 5, 0, do_mtd_io,
>                                              mtd_name_complete),
> --
> 2.35.0
>

Applied to nand-next

Thanks and regards
Dario

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
