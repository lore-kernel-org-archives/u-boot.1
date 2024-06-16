Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15771C27C6E
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 07:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A0387FC2;
	Sun, 16 Jun 2024 09:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ag+BSqCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3919880AE; Sun, 16 Jun 2024 09:38:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F2B87E0D
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 09:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718523479; x=1719128279; i=xypron.glpk@gmx.de;
 bh=xU8cuic2zHfSfxQQZoUfnEeTwQzCthQ4Ed0lvx1AQC8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ag+BSqCItaZhtAOqnlZxvUHFU2hx9YnV/RHTucyry9802rrnuDLLCuAAts96XlUZ
 cWZ2k2TBe3dfrY8fdb8deqOQy50BXD9u8pqrHMKty1y2GuhrDhVu6I5NAUhLZOm5j
 bYR2JpjLKDCeU/+tSp7O0kJIKsKlL0PSNGWeT7+xx9ybO+ZxtANk0F1khfLk8docs
 IFlXfsMpTG3zqVhy9dHou4QZvyfW6XQ5i25hGMh2LL8O2OAzQc7rBT/nAIuvW08W6
 cdwhT16A4b/VjaOgNgsTKst8TsTHJP+Bbh1nTs/LhDO2IV+Ie+LiehCgZYCRtPoKi
 z3P2zQb0rbNbnELi2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1s2a5K0kqD-00PEBD; Sun, 16
 Jun 2024 09:37:59 +0200
Message-ID: <a7410171-c413-4815-8187-606d32b0c5b3@gmx.de>
Date: Sun, 16 Jun 2024 09:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bootstd: Replace bootmethod(s) -> bootmeth(s)
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Mario Six <mario.six@gdsys.cc>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
 <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XPDBOYx+LoGxE85chyzvDt+xdsDvo/jAKFRXdTsM3QDXHo82upK
 YLjjnf99PCeZRVbB39jW8ecEvqoXKDHT+B0FuDmaYOGR8fpyXuwFJsAHWTFH8k44SPx+iOc
 YYPan/kT4K77ca2TIrJ//3Ud33ztN0OwVrx5PmIIC3YYZ7JnwOO+R4KvuLdUTfXa0k6u1lT
 H2YrNS5HDaOoWV0jq/T8w==
UI-OutboundReport: notjunk:1;M01:P0:cm8pcvh5yTU=;FkAv+Qk56kA4TJ6xG/O0jh3xe9l
 mEjh+i4HH7iDLiySxzIuOGj/KgzcIA14yTeISHgU/k6fAi01sJ82ZFP4Du5AlPbW09wCj65Qa
 U+aUiJz+SuPfiqmCRPnTpg6xk0FcNX1e+YSTBzrv10nkbztUJzCD8F5WWyl1DQb+ZSfrmTOh3
 fLNdYpbVQWkjTAo4J9+UBgz5arj9ESnQD5WFVzbdSCMawOyXZ88K9ltem+MHXDHBo0GryO5SG
 wXOUnUz1MDnF4NNYlqOoXbinIYNZ+X8BfBWgCuJntQGCMFH8TyrAAIzcrEq/DbXYdsFI4r3gO
 mLqoDifuXSa6xnmP06veu0f6Nm0S3CYZN/Ya0E7k30tQTo+ItFTUvqLY1mVUbU7OSYyTC2fv3
 XFa7hBaIJxeD5aznTdxsdF6Kfhfk9fD33JBY9Uo/LTfiIIgM9M6gFkGmp7tLYFfenjYPbhl6x
 w0bK1zEhnXec/1vHhhhlXwTcugzUZ5/UGNrAOufz8aSzhxCFuFtivd6YKVktzjFtYgLHe2qQG
 iuJXIEFK99cKQBy5/rsv4+mnCdZ6nsY2UBAzKU/6pl7RaF3/LDisyBJ48wZI7ZpxlIYkBA+UZ
 I170799H7/1SnJJslkcPYQwLIZem1fPo1CH31TbyyuVI3KJqF+9hMG7oUn2iOI5jfqagGijH4
 AWJTSHIqmwKp4jO9h4eKyqkgOwJnsUZpyhGV30ewhxB5ORYt7j2Xg5TK6nV4CTIR2p4zVgmVS
 5kPMgc+1DWEhgt2nGE6PNpQgy19OMAQ/yttj3R177bG53sOVhnYDMFYapZHlv117tMn9JkBwC
 DGHn9bd37EvXfnZcwC6n6VlOXYvHgGSnI+/z0cI/gCawY=
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

On 6/4/24 17:15, Mattijs Korpershoek wrote:
> According to [1], we should use bootmeth when describing the
> struct bootmeth:
>
> """
> For version 2, a new naming scheme is used as above:
>
>      - bootdev is used instead of bootdevice, because 'device' is overus=
ed,
>          is everywhere in U-Boot, can be confused with udevice

Boot devices are udevices though they don't relate to hardware but to an
abstract concept.

bootdev is just an abbreviation. This does not make the meaning any cleare=
r.

>      - bootmeth - because 'method' is too vanilla, appears 1300 times in
>          U-Boot
> """

Avoiding abbreviations like bootdev and bootmeth improved readability.

Best regards

Heinrich

>
> Replace all occurences in various comments for consistency.
>
> [1] https://lore.kernel.org/u-boot/20211023232635.9195-1-sjg@chromium.or=
g/
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   board/sandbox/sandbox.env |  2 +-
>   boot/bootmeth-uclass.c    |  2 +-
>   include/bootmeth.h        | 30 +++++++++++++++---------------
>   include/extlinux.h        |  2 +-
>   test/boot/bootflow.c      |  2 +-
>   test/boot/bootmeth.c      |  6 +++---
>   6 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/board/sandbox/sandbox.env b/board/sandbox/sandbox.env
> index a2c19702d64d..564dce78a898 100644
> --- a/board/sandbox/sandbox.env
> +++ b/board/sandbox/sandbox.env
> @@ -10,7 +10,7 @@ eth6addr=3D02:00:11:22:33:47
>   ipaddr=3D192.0.2.1
>
>   /*
> - * These are used for distro boot which is not supported. But once boot=
method
> + * These are used for distro boot which is not supported. But once boot=
meth
>    * is provided these will be used again.
>    */
>   bootm_size=3D0x10000000
> diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> index 1d157d54dbdd..e3475f46b34c 100644
> --- a/boot/bootmeth-uclass.c
> +++ b/boot/bootmeth-uclass.c
> @@ -167,7 +167,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *=
iter, bool include_global)
>   			if (pass)
>   				iter->first_glob_method =3D upto;
>   			/*
> -			 * Get a list of bootmethods, in seq order (i.e. using
> +			 * Get a list of bootmeths, in seq order (i.e. using
>   			 * aliases). There may be gaps so try to count up high
>   			 * enough to find them all.
>   			 */
> diff --git a/include/bootmeth.h b/include/bootmeth.h
> index 529c4d813d82..2570d9593d49 100644
> --- a/include/bootmeth.h
> +++ b/include/bootmeth.h
> @@ -47,7 +47,7 @@ struct bootmeth_ops {
>   	 * This may involve reading state from the system, e.g. some data in
>   	 * the firmware area.
>   	 *
> -	 * @dev:	Bootmethod device to check
> +	 * @dev:	Bootmeth device to check
>   	 * @buf:	Buffer to place the info in (terminator must fit)
>   	 * @maxsize:	Size of buffer
>   	 * Returns: 0 if OK, -ENOSPC is buffer is too small, other -ve error =
if
> @@ -74,7 +74,7 @@ struct bootmeth_ops {
>   	 *
>   	 * It may update only the flags in @iter
>   	 *
> -	 * @dev:	Bootmethod device to check against
> +	 * @dev:	Bootmeth device to check against
>   	 * @iter:	On entry, provides bootdev, hwpart, part
>   	 * Return: 0 if OK, -ENOTSUPP if this bootdev is not supported
>   	 */
> @@ -83,7 +83,7 @@ struct bootmeth_ops {
>   	/**
>   	 * read_bootflow() - read a bootflow for a device
>   	 *
> -	 * @dev:	Bootmethod device to use
> +	 * @dev:	Bootmeth device to use
>   	 * @bflow:	On entry, provides dev, hwpart, part and method.
>   	 *	Returns updated bootflow if found
>   	 * Return: 0 if OK, -ve on error
> @@ -96,7 +96,7 @@ struct bootmeth_ops {
>   	 * This provides a bootflow file to the bootmeth, to see if it is val=
id.
>   	 * If it is, the bootflow is set up accordingly.
>   	 *
> -	 * @dev:	Bootmethod device to use
> +	 * @dev:	Bootmeth device to use
>   	 * @bflow:	On entry, provides bootdev.
>   	 *	Returns updated bootflow if found
>   	 * @buf:	Buffer containing the possible bootflow file
> @@ -111,7 +111,7 @@ struct bootmeth_ops {
>   	 *
>   	 * Read a file from the same place as the bootflow came from
>   	 *
> -	 * @dev:	Bootmethod device to use
> +	 * @dev:	Bootmeth device to use
>   	 * @bflow:	Bootflow providing info on where to read from
>   	 * @file_path:	Path to file (may be absolute or relative)
>   	 * @addr:	Address to load file
> @@ -126,7 +126,7 @@ struct bootmeth_ops {
>   	/**
>   	 * readall() - read all files for a bootflow
>   	 *
> -	 * @dev:	Bootmethod device to boot
> +	 * @dev:	Bootmeth device to boot
>   	 * @bflow:	Bootflow to read
>   	 * Return: 0 if OK, -EIO on I/O error, other -ve on other error
>   	 */
> @@ -135,7 +135,7 @@ struct bootmeth_ops {
>   	/**
>   	 * boot() - boot a bootflow
>   	 *
> -	 * @dev:	Bootmethod device to boot
> +	 * @dev:	Bootmeth device to boot
>   	 * @bflow:	Bootflow to boot
>   	 * Return: does not return on success, since it should boot the
>   	 *	Operating System. Returns -EFAULT if that fails, -ENOTSUPP if
> @@ -158,7 +158,7 @@ struct bootmeth_ops {
>    * This may involve reading state from the system, e.g. some data in
>    * the firmware area.
>    *
> - * @dev:	Bootmethod device to check
> + * @dev:	Bootmeth device to check
>    * @buf:	Buffer to place the info in (terminator must fit)
>    * @maxsize:	Size of buffer
>    * Returns: 0 if OK, -ENOSPC is buffer is too small, other -ve error i=
f
> @@ -185,7 +185,7 @@ int bootmeth_get_state_desc(struct udevice *dev, cha=
r *buf, int maxsize);
>    *
>    * It may update only the flags in @iter
>    *
> - * @dev:	Bootmethod device to check against
> + * @dev:	Bootmeth device to check against
>    * @iter:	On entry, provides bootdev, hwpart, part
>    * Return: 0 if OK, -ENOTSUPP if this bootdev is not supported
>    */
> @@ -194,7 +194,7 @@ int bootmeth_check(struct udevice *dev, struct bootf=
low_iter *iter);
>   /**
>    * bootmeth_read_bootflow() - set up a bootflow for a device
>    *
> - * @dev:	Bootmethod device to check
> + * @dev:	Bootmeth device to check
>    * @bflow:	On entry, provides dev, hwpart, part and method.
>    *	Returns updated bootflow if found
>    * Return: 0 if OK, -ve on error
> @@ -207,7 +207,7 @@ int bootmeth_read_bootflow(struct udevice *dev, stru=
ct bootflow *bflow);
>    * This provides a bootflow file to the bootmeth, to see if it is vali=
d.
>    * If it is, the bootflow is set up accordingly.
>    *
> - * @dev:	Bootmethod device to use
> + * @dev:	Bootmeth device to use
>    * @bflow:	On entry, provides bootdev.
>    *	Returns updated bootflow if found
>    * @buf:	Buffer containing the possible bootflow file (must be allocat=
ed
> @@ -223,7 +223,7 @@ int bootmeth_set_bootflow(struct udevice *dev, struc=
t bootflow *bflow,
>    *
>    * Read a file from the same place as the bootflow came from
>    *
> - * @dev:	Bootmethod device to use
> + * @dev:	Bootmeth device to use
>    * @bflow:	Bootflow providing info on where to read from
>    * @file_path:	Path to file (may be absolute or relative)
>    * @addr:	Address to load file
> @@ -241,7 +241,7 @@ int bootmeth_read_file(struct udevice *dev, struct b=
ootflow *bflow,
>    * Some bootmeths delay reading of large files until booting is reques=
ted. This
>    * causes those files to be read.
>    *
> - * @dev:	Bootmethod device to use
> + * @dev:	Bootmeth device to use
>    * @bflow:	Bootflow to read
>    * Return: does not return on success, since it should boot the
>    *	Operating System. Returns -EFAULT if that fails, other -ve on
> @@ -252,7 +252,7 @@ int bootmeth_read_all(struct udevice *dev, struct bo=
otflow *bflow);
>   /**
>    * bootmeth_boot() - boot a bootflow
>    *
> - * @dev:	Bootmethod device to boot
> + * @dev:	Bootmeth device to boot
>    * @bflow:	Bootflow to boot
>    * Return: does not return on success, since it should boot the
>    *	Operating System. Returns -EFAULT if that fails, other -ve on
> @@ -265,7 +265,7 @@ int bootmeth_boot(struct udevice *dev, struct bootfl=
ow *bflow);
>    *
>    * This sets up the ordering information in @iter, based on the select=
ed
>    * ordering of the bootmeths in bootstd_priv->bootmeth_order. If there=
 is no
> - * ordering there, then all bootmethods are added
> + * ordering there, then all bootmeths are added
>    *
>    * @iter: Iterator to update with the order
>    * @include_global: true to add the global bootmeths, in which case th=
ey appear
> diff --git a/include/extlinux.h b/include/extlinux.h
> index 721ba46371cc..4d26a0a8ab74 100644
> --- a/include/extlinux.h
> +++ b/include/extlinux.h
> @@ -12,7 +12,7 @@
>   /**
>    * struct extlinux_info - useful information for extlinux_getfile()
>    *
> - * @dev: bootmethod device being used to boot
> + * @dev: bootmeth device being used to boot
>    * @bflow: bootflow being booted
>    */
>   struct extlinux_info {
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 674d4c05f83f..24f3b5fbe109 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -400,7 +400,7 @@ BOOTSTD_TEST(bootflow_system, UT_TESTF_DM | UT_TESTF=
_SCAN_PDATA |
>   	     UT_TESTF_SCAN_FDT);
>   #endif
>
> -/* Check disabling a bootmethod if it requests it */
> +/* Check disabling a bootmeth if it requests it */
>   static int bootflow_iter_disable(struct unit_test_state *uts)
>   {
>   	struct udevice *bootstd, *dev;
> diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
> index e498eee036eb..b9a3f48a95ef 100644
> --- a/test/boot/bootmeth.c
> +++ b/test/boot/bootmeth.c
> @@ -37,7 +37,7 @@ BOOTSTD_TEST(bootmeth_cmd_list, UT_TESTF_DM | UT_TESTF=
_SCAN_FDT);
>   /* Check 'bootmeth order' command */
>   static int bootmeth_cmd_order(struct unit_test_state *uts)
>   {
> -	/* Select just one bootmethod */
> +	/* Select just one bootmeth */
>   	console_record_reset_enable();
>   	ut_assertok(run_command("bootmeth order extlinux", 0));
>   	ut_assert_console_end();
> @@ -138,12 +138,12 @@ static int bootmeth_env(struct unit_test_state *ut=
s)
>
>   	ut_assertok(bootstd_get_priv(&std));
>
> -	/* Select just one bootmethod */
> +	/* Select just one bootmeth */
>   	console_record_reset_enable();
>   	ut_assertok(env_set("bootmeths", "extlinux"));
>   	ut_asserteq(1, std->bootmeth_count);
>
> -	/* Select an invalid bootmethod */
> +	/* Select an invalid bootmeth */
>   	ut_asserteq(1, run_command("setenv bootmeths fred", 0));
>   	ut_assert_nextline("Unknown bootmeth 'fred'");
>   	ut_assert_nextlinen("## Error inserting");
>

