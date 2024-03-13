Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1676DC54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 06:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A8AA87BA8;
	Wed, 13 Mar 2024 07:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M8/SLzRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC18887DE3; Wed, 13 Mar 2024 07:48:16 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F1087653
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 07:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d2fad80eacso60031071fa.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 23:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1710312494; x=1710917294;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nLAkBUrExGqFDY+LWAzj1zX40mU6SWBISfBSH/U9mE=;
 b=M8/SLzRUAXdqVdIru9zUGtcvhL3MZzaSZXrHR79PTIHgGsvklucqvip/XSB0u/y9VM
 6jAlanpBz6/WeP5O50D9OuAOOB3mgPBKD+cCtu+pyTeUN0TbnxV02f/XV84le4OBLlir
 glbZhojE++XEcqfzoetjNb53rae7LTDf6hEc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710312494; x=1710917294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nLAkBUrExGqFDY+LWAzj1zX40mU6SWBISfBSH/U9mE=;
 b=gDfFjyU/++mB7FxzNVhLUZGcq+WgQ2Goiw+OO8MIJU6hVTSQNM9X+X7XnG3Oy2RNa6
 akJh+HXBSh8KiavvaxvSpDZtSTgj59VZnSsmkPO5GN+WsMm4Dn272hC/EFuLsR+QX189
 n4Vs0qP6zD8J1CRVVyS4I3VTz7qmRiec/V/x87hhZ8UOoyzUbXXjAJaVVHAht5l2XX7r
 1JZMh+ZdGLrCsOH386cssdUrDdkDj3vVKJ0Bc7u81Z1NyXz3fR+3j7Ny/KlpgBLTo3Ex
 sS4v4sWeWAr9F8+9h/NQW9ItLE3ZMaZzWOXhhgLvgNJfE7QxmzTWnePUpO9X/nIbbSGK
 z0zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHIR68l0ovWYAkMlfOhq8HHAOtbyzDFlH+7VJpWxqBY1SJuMLs12TgDC8SAf/vyVO7nLfclhqPtf+LrOqwsBJfX31ULg==
X-Gm-Message-State: AOJu0YzshCUsoslOMES3qu65Uo5K8OGeALw23OwD0AeK3Ee60ht30LFl
 f5V4xZCRPudKbNuGH0agXrdij/l6Dj7/YHZ3awxZq8/D5jNdDRl22dZQTzWJU3RYy9A4L6KnRTf
 rcEoBQthflol+yxJU1/OoXaz+Av3jm44tyBobRA==
X-Google-Smtp-Source: AGHT+IHMeYeEr9ZquhgKDdC+2tW4eD5YMRKk8aXTukEvF0lURsNv99JBst/7D0aALAcjO1tEnsfLZC8z06/VOBdHzTI=
X-Received: by 2002:a05:651c:542:b0:2d4:515f:2998 with SMTP id
 q2-20020a05651c054200b002d4515f2998mr3662746ljp.0.1710312493688; Tue, 12 Mar
 2024 23:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231220193649.3154346-1-avkrasnov@salutedevices.com>
 <31e95a3f-822a-d3cd-4725-220c44d7ef14@salutedevices.com>
 <70f00033-2380-33f1-dc6e-30bc9f22f5d5@salutedevices.com>
 <2ae521f9-5139-0cf0-bfa8-879228826d6b@salutedevices.com>
In-Reply-To: <2ae521f9-5139-0cf0-bfa8-879228826d6b@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 13 Mar 2024 07:48:02 +0100
Message-ID: <CAOf5uw=fj8kHBn8N2iB2tXbQj4Fp8tj5qF4y7dB8AU6CEXnPxg@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: mtd: OTP access support
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

On Wed, Mar 13, 2024 at 7:43=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Sorry, please ping
>
> Thanks, Arseniy
>
>
> On 11.02.2024 02:16, Arseniy Krasnov wrote:
> > Sorry, pls ping
> >
> > Thanks, Arseniy
> >
> > On 08.01.2024 21:33, Arseniy Krasnov wrote:
> >> Sorry, pls ping
> >>
> >> Thanks, Arseniy
> >>
> >> On 20.12.2023 22:36, Arseniy Krasnov wrote:
> >>> Add access to OTP region. It supports info, dump, write and lock
> >>> operations.
> >>>
> >>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >>> ---

Please extend the commit message with some example of the usage otherwise

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

> >>>  Changelog:
> >>>  v1 -> v2:
> >>>   * Remove warning that OTP can't be erased after write.
> >>>
> >>>  cmd/Kconfig |   1 +
> >>>  cmd/mtd.c   | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> >>>  2 files changed, 225 insertions(+)
> >>>
> >>> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >>> index 90e4ef93e0..c47523a03b 100644
> >>> --- a/cmd/Kconfig
> >>> +++ b/cmd/Kconfig
> >>> @@ -1354,6 +1354,7 @@ config CMD_MTD
> >>>     bool "mtd"
> >>>     depends on MTD
> >>>     select MTD_PARTITIONS
> >>> +   select HEXDUMP
> >>>     help
> >>>       MTD commands support.
> >>>
> >>> diff --git a/cmd/mtd.c b/cmd/mtd.c
> >>> index eb6e2d6892..1ab69b108b 100644
> >>> --- a/cmd/mtd.c
> >>> +++ b/cmd/mtd.c
> >>> @@ -11,6 +11,7 @@
> >>>  #include <command.h>
> >>>  #include <common.h>
> >>>  #include <console.h>
> >>> +#include <hexdump.h>
> >>>  #include <malloc.h>
> >>>  #include <mapmem.h>
> >>>  #include <mtd.h>
> >>> @@ -202,6 +203,219 @@ static bool mtd_oob_write_is_empty(struct mtd_o=
ob_ops *op)
> >>>     return true;
> >>>  }
> >>>
> >>> +static int do_mtd_otp_read(struct cmd_tbl *cmdtp, int flag, int argc=
,
> >>> +                      char *const argv[])
> >>> +{
> >>> +   struct mtd_info *mtd;
> >>> +   size_t retlen;
> >>> +   off_t from;
> >>> +   size_t len;
> >>> +   bool user;
> >>> +   int ret;
> >>> +   u8 *buf;
> >>> +
> >>> +   if (argc !=3D 5)
> >>> +           return CMD_RET_USAGE;
> >>> +
> >>> +   if (!strcmp(argv[2], "u"))
> >>> +           user =3D true;
> >>> +   else if (!strcmp(argv[2], "f"))
> >>> +           user =3D false;
> >>> +   else
> >>> +           return CMD_RET_USAGE;
> >>> +
> >>> +   mtd =3D get_mtd_by_name(argv[1]);
> >>> +   if (IS_ERR_OR_NULL(mtd))
> >>> +           return CMD_RET_FAILURE;
> >>> +
> >>> +   from =3D simple_strtoul(argv[3], NULL, 0);
> >>> +   len =3D simple_strtoul(argv[4], NULL, 0);
> >>> +
> >>> +   ret =3D CMD_RET_FAILURE;
> >>> +
> >>> +   buf =3D malloc(len);
> >>> +   if (!buf)
> >>> +           goto put_mtd;
> >>> +
> >>> +   printf("Reading %s OTP from 0x%lx, %lu bytes\n",
> >>> +          user ? "user" : "factory", from, len);
> >>> +
> >>> +   if (user)
> >>> +           ret =3D mtd_read_user_prot_reg(mtd, from, len, &retlen, b=
uf);
> >>> +   else
> >>> +           ret =3D mtd_read_fact_prot_reg(mtd, from, len, &retlen, b=
uf);
> >>> +   if (ret) {
> >>> +           free(buf);
> >>> +           pr_err("OTP read failed: %d\n", ret);
> >>> +           ret =3D CMD_RET_FAILURE;
> >>> +           goto put_mtd;
> >>> +   }
> >>> +
> >>> +   if (retlen !=3D len)
> >>> +           pr_err("OTP read returns %zu, but %zu expected\n",
> >>> +                  retlen, len);
> >>> +
> >>> +   print_hex_dump("", 0, 16, 1, buf, retlen, true);
> >>> +
> >>> +   free(buf);
> >>> +
> >>> +   ret =3D CMD_RET_SUCCESS;
> >>> +
> >>> +put_mtd:
> >>> +   put_mtd_device(mtd);
> >>> +
> >>> +   return ret;
> >>> +}
> >>> +
> >>> +static int do_mtd_otp_lock(struct cmd_tbl *cmdtp, int flag, int argc=
,
> >>> +                      char *const argv[])
> >>> +{
> >>> +   struct mtd_info *mtd;
> >>> +   off_t from;
> >>> +   size_t len;
> >>> +   int ret;
> >>> +
> >>> +   if (argc !=3D 4)
> >>> +           return CMD_RET_USAGE;
> >>> +
> >>> +   mtd =3D get_mtd_by_name(argv[1]);
> >>> +   if (IS_ERR_OR_NULL(mtd))
> >>> +           return CMD_RET_FAILURE;
> >>> +
> >>> +   from =3D simple_strtoul(argv[2], NULL, 0);
> >>> +   len =3D simple_strtoul(argv[3], NULL, 0);
> >>> +
> >>> +   ret =3D mtd_lock_user_prot_reg(mtd, from, len);
> >>> +   if (ret) {
> >>> +           pr_err("OTP lock failed: %d\n", ret);
> >>> +           ret =3D CMD_RET_FAILURE;
> >>> +           goto put_mtd;
> >>> +   }
> >>> +
> >>> +   ret =3D CMD_RET_SUCCESS;
> >>> +
> >>> +put_mtd:
> >>> +   put_mtd_device(mtd);
> >>> +
> >>> +   return ret;
> >>> +}
> >>> +
> >>> +static int do_mtd_otp_write(struct cmd_tbl *cmdtp, int flag, int arg=
c,
> >>> +                       char *const argv[])
> >>> +{
> >>> +   struct mtd_info *mtd;
> >>> +   size_t retlen;
> >>> +   size_t binlen;
> >>> +   u8 *binbuf;
> >>> +   off_t from;
> >>> +   int ret;
> >>> +
> >>> +   if (argc !=3D 4)
> >>> +           return CMD_RET_USAGE;
> >>> +
> >>> +   mtd =3D get_mtd_by_name(argv[1]);
> >>> +   if (IS_ERR_OR_NULL(mtd))
> >>> +           return CMD_RET_FAILURE;
> >>> +
> >>> +   from =3D simple_strtoul(argv[2], NULL, 0);
> >>> +   binlen =3D strlen(argv[3]) / 2;
> >>> +
> >>> +   ret =3D CMD_RET_FAILURE;
> >>> +   binbuf =3D malloc(binlen);
> >>> +   if (!binbuf)
> >>> +           goto put_mtd;
> >>> +
> >>> +   hex2bin(binbuf, argv[3], binlen);
> >>> +
> >>> +   printf("Will write:\n");
> >>> +
> >>> +   print_hex_dump("", 0, 16, 1, binbuf, binlen, true);
> >>> +
> >>> +   printf("to 0x%zx\n", from);
> >>> +
> >>> +   printf("Continue (y/n)?\n");
> >>> +
> >>> +   if (confirm_yesno() !=3D 1) {
> >>> +           pr_err("OTP write canceled\n");
> >>> +           ret =3D CMD_RET_SUCCESS;
> >>> +           goto put_mtd;
> >>> +   }
> >>> +
> >>> +   ret =3D mtd_write_user_prot_reg(mtd, from, binlen, &retlen, binbu=
f);
> >>> +   if (ret) {
> >>> +           pr_err("OTP write failed: %d\n", ret);
> >>> +           ret =3D CMD_RET_FAILURE;
> >>> +           goto put_mtd;
> >>> +   }
> >>> +
> >>> +   if (retlen !=3D binlen)
> >>> +           pr_err("OTP write returns %zu, but %zu expected\n",
> >>> +                  retlen, binlen);
> >>> +
> >>> +   ret =3D CMD_RET_SUCCESS;
> >>> +
> >>> +put_mtd:
> >>> +   free(binbuf);
> >>> +   put_mtd_device(mtd);
> >>> +
> >>> +   return ret;
> >>> +}
> >>> +
> >>> +static int do_mtd_otp_info(struct cmd_tbl *cmdtp, int flag, int argc=
,
> >>> +                      char *const argv[])
> >>> +{
> >>> +   struct otp_info otp_info;
> >>> +   struct mtd_info *mtd;
> >>> +   size_t retlen;
> >>> +   bool user;
> >>> +   int ret;
> >>> +
> >>> +   if (argc !=3D 3)
> >>> +           return CMD_RET_USAGE;
> >>> +
> >>> +   if (!strcmp(argv[2], "u"))
> >>> +           user =3D true;
> >>> +   else if (!strcmp(argv[2], "f"))
> >>> +           user =3D false;
> >>> +   else
> >>> +           return CMD_RET_USAGE;
> >>> +
> >>> +   mtd =3D get_mtd_by_name(argv[1]);
> >>> +   if (IS_ERR_OR_NULL(mtd))
> >>> +           return CMD_RET_FAILURE;
> >>> +
> >>> +   if (user)
> >>> +           ret =3D mtd_get_user_prot_info(mtd, sizeof(otp_info), &re=
tlen,
> >>> +                                        &otp_info);
> >>> +   else
> >>> +           ret =3D mtd_get_fact_prot_info(mtd, sizeof(otp_info), &re=
tlen,
> >>> +                                        &otp_info);
> >>> +   if (ret) {
> >>> +           pr_err("OTP info failed: %d\n", ret);
> >>> +           ret =3D CMD_RET_FAILURE;
> >>> +           goto put_mtd;
> >>> +   }
> >>> +
> >>> +   if (retlen !=3D sizeof(otp_info)) {
> >>> +           pr_err("OTP info returns %zu, but %zu expected\n",
> >>> +                  retlen, sizeof(otp_info));
> >>> +           ret =3D CMD_RET_FAILURE;
> >>> +           goto put_mtd;
> >>> +   }
> >>> +
> >>> +   printf("%s OTP region info:\n", user ? "User" : "Factory");
> >>> +   printf("\tstart: %u\n", otp_info.start);
> >>> +   printf("\tlength: %u\n", otp_info.length);
> >>> +   printf("\tlocked: %u\n", otp_info.locked);
> >>> +
> >>> +   ret =3D CMD_RET_SUCCESS;
> >>> +
> >>> +put_mtd:
> >>> +   put_mtd_device(mtd);
> >>> +
> >>> +   return ret;
> >>> +}
> >>> +
> >>>  static int do_mtd_list(struct cmd_tbl *cmdtp, int flag, int argc,
> >>>                    char *const argv[])
> >>>  {
> >>> @@ -552,6 +766,10 @@ static char mtd_help_text[] =3D
> >>>     "\n"
> >>>     "Specific functions:\n"
> >>>     "mtd bad                               <name>\n"
> >>> +   "mtd otpread                           <name> [u|f] <off> <size>\=
n"
> >>> +   "mtd otpwrite                          <name> <off> <hex string>\=
n"
> >>> +   "mtd otplock                           <name> <off> <size>\n"
> >>> +   "mtd otpinfo                           <name> [u|f]\n"
> >>>     "\n"
> >>>     "With:\n"
> >>>     "\t<name>: NAND partition/chip name (or corresponding DM device n=
ame or OF path)\n"
> >>> @@ -562,11 +780,17 @@ static char mtd_help_text[] =3D
> >>>     "\t<size>: length of the operation in bytes (default: the entire =
device)\n"
> >>>     "\t\t* must be a multiple of a block for erase\n"
> >>>     "\t\t* must be a multiple of a page otherwise (special case: defa=
ult is a page with dump)\n"
> >>> +   "\t<hex string>: hex string without '0x' and spaces. Example: ABC=
D1234\n"
> >>> +   "\t[u|f]: user or factory OTP region\n"
> >>>     "\n"
> >>>     "The .dontskipff option forces writing empty pages, don't use it =
if unsure.\n";
> >>>  #endif
> >>>
> >>>  U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
> >>> +           U_BOOT_SUBCMD_MKENT(otpread, 5, 1, do_mtd_otp_read),
> >>> +           U_BOOT_SUBCMD_MKENT(otpwrite, 4, 1, do_mtd_otp_write),
> >>> +           U_BOOT_SUBCMD_MKENT(otplock, 4, 1, do_mtd_otp_lock),
> >>> +           U_BOOT_SUBCMD_MKENT(otpinfo, 3, 1, do_mtd_otp_info),
> >>>             U_BOOT_SUBCMD_MKENT(list, 1, 1, do_mtd_list),
> >>>             U_BOOT_SUBCMD_MKENT_COMPLETE(read, 5, 0, do_mtd_io,
> >>>                                          mtd_name_complete),



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
