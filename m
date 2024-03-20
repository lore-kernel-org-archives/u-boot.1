Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180E9C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 18:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71ACA8809B;
	Wed, 20 Mar 2024 19:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mtDIWbe9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172738806E; Wed, 20 Mar 2024 19:02:12 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A6708802B
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 19:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a468226e135so15406666b.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1710957729; x=1711562529;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I42CB3pAcgLe8QkgIobkrJlMVQ6YaNL41Szyhlhc74k=;
 b=mtDIWbe9v0OeVf3CZPq2CoYTH0uo7Yt9+BUpuyUtaavJPz3eG2mrsO0imrGpMOz26F
 t175NEbN0QxpQauwGY6wTgpai51rU7VLiqjmV+l/fqE+q1DnCnzn91X8MjMgrO84wkea
 M5enXflXGua34w4gbUf2Oa6xK9YcEuCAQ43is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710957729; x=1711562529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I42CB3pAcgLe8QkgIobkrJlMVQ6YaNL41Szyhlhc74k=;
 b=dll1Pb0diEU0fRQBWZpiypZFONvBiD1jDlT8L0JEGiVdqdWYPfp/53iUb/oXqEvlGr
 7+Rj2kXlUmhdQRWK9XlqX9vR7RO/BtTg92iTnt2pJ9/G3iwxSuBdJUEA7Vn3IHYuNjVF
 gCg99Oq/8ousLiqeq+gLc3yW/Sjqb9yYHty+1oPv11Ji42hF2Dn9aPyOGLRE1F7gA8ag
 vBSS2kyhNUIur46ZRWhvCLFHze1TxfLups3GlcE8BvoPItZbqb5OoTY5R/KS6xM6JppN
 KGDmqaEAIwJ7Di0SfquBQo3/om910v5DfPNSUTc71hzgUJu6A/fjHdZJNE/ZzReEQEGf
 5trQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr4KK+kmt+e1p8paXmXzYQy4OLgK63Q3Y3Ex6G9eM0y7GxngkduLgy1j1T2gNad9lSW25cHxIyshFpQGlbrC/SjVf4hQ==
X-Gm-Message-State: AOJu0YyPmtsfDTr6kd1EMpAXjTE1hejIiiu4EubAW4Py2DnU0s1X3B/V
 k6Vwinh/GZXZEVA/7GFZs14Ei6/zdoA14bAGD7LYZS84XiQoeIANXiVzuzlhSnXACwhjMkQpO4n
 1wBczXNbXVtKXma70ItyUq4gTiv6gs/xOZlc23Q==
X-Google-Smtp-Source: AGHT+IF4KDpUG/GK9hw1p72VIRpOmnTJ/E2xAMMiHqG3vyHhkzevKAahgEBAws3EAML+uh1CieoeNBW9q0vglkJASk4=
X-Received: by 2002:a17:906:682:b0:a46:6fe4:af27 with SMTP id
 u2-20020a170906068200b00a466fe4af27mr13020178ejb.24.1710957728887; Wed, 20
 Mar 2024 11:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240313071715.94887-1-avkrasnov@salutedevices.com>
In-Reply-To: <20240313071715.94887-1-avkrasnov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 20 Mar 2024 19:01:56 +0100
Message-ID: <CAOf5uw=s4n7JxobkEVm34=SSpVFABWqv5J8ORmv_v4BjVaboOw@mail.gmail.com>
Subject: Re: [PATCH v3] cmd: mtd: OTP access support
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

Hi

On Wed, Mar 13, 2024 at 8:27=E2=80=AFAM Arseniy Krasnov
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
>

Your patch build fail

https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/jobs/801919

Michael

>  cmd/Kconfig |   1 +
>  cmd/mtd.c   | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 225 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 90e4ef93e0..c47523a03b 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1354,6 +1354,7 @@ config CMD_MTD
>         bool "mtd"
>         depends on MTD
>         select MTD_PARTITIONS
> +       select HEXDUMP
>         help
>           MTD commands support.
>
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index eb6e2d6892..1ab69b108b 100644
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
> +       printf("Reading %s OTP from 0x%lx, %lu bytes\n",
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
> +       printf("to 0x%zx\n", from);
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
> @@ -552,6 +766,10 @@ static char mtd_help_text[] =3D
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
> @@ -562,11 +780,17 @@ static char mtd_help_text[] =3D
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
if unsure.\n";
>  #endif
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
