Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E322DE668B3
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 14:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF188954E;
	Sun, 24 Nov 2024 15:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WL1hEeC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC9589558; Sun, 24 Nov 2024 15:58:33 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E1FD89547
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 15:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732460303; x=1733065103; i=xypron.glpk@gmx.de;
 bh=4+TFhqwzWbCCUpl+6S/ZEsjD+mMXgFE/0pRD6hrSHjA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WL1hEeC+XqM+VZfCXEUPWLBYtntZA/n+qJc7LNa9z+QpWtNmcUmkMHgYSUskLeBC
 g3Koq79hxIK86Apv/px9y79riLwDRy4sA7cclqaD1o6RIkRkKD7+EbaJUM/kaJkDe
 EogmzT9RcXYF9HfCTZOpVuJWgMlUtN1bei5hoTmwevODBmJAXaENgW7Tz8tXm614X
 b48O6HfXs4f9TEmB7YXahi3uecv4QCeYYoR62V1P5VLBhf4ZGGPg6Ci9Fif+1GgBj
 uSLcf6GL3mH3b+owe+gp55OiKTyFIOZlUZh4+li3EKflfnpn5wH4OJLo4tvAogcE2
 3yr96V4YnfqNKYdafg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1thzKY3m5A-00sknB; Sun, 24
 Nov 2024 15:58:23 +0100
Message-ID: <b79cd88a-4346-444d-979c-8eb2ed913d5e@gmx.de>
Date: Sun, 24 Nov 2024 15:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] Add command to set an environment variable to an
 EFI variable
To: Matthew Garrett <mjg59@srcf.ucam.org>, u-boot@lists.denx.de
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-11-mjg59@srcf.ucam.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241123195616.305687-11-mjg59@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hAjBzop3Lbch4IL9ZXBpw3RzXT6LlUeitfqM5k1gnp7Js0BEY4Z
 8iSwZX7YI4xV5IVLzBpivbD869fcqgd1ZN3BWn3ZMMdDVBXHuzueMr5rEP1WLODMmEq1paf
 opYIf1mF8EogObWu9etP/y8v08MdfiU+RxdnORweHe1SpjIpT+s/Gbf9+kQO2nfrES1WA3g
 lE8p5UtbHUJlCfYpCGkfQ==
UI-OutboundReport: notjunk:1;M01:P0:N6JuFkFu+jo=;7T8NXv8chHUMNoakUyBcs3Oa3LQ
 0UDmk+XvMffBQ7a8IOysCF/9XbADINsPXpK/wMSCg5GMEFInS98AT7WQB1mk1EKGEthWDJ0Kb
 O3X+IgOa+vPHTJlK/PKNMQQY3+RUlXmh4hNB+4eJhmFLR2pwCTmlS12jqWZ3MdQy2xy084/bI
 jZsVqcl9ZWtBqgQpIWG8sIt3J69mwdCoXANzBIIhFsgUV7AAVXSnMfhFj5+s5Bm+QnKmX6Js9
 +GYS6QxvpjwAsNOKzZ5cwqx/ERI0SpHrJepSznGgzW90/WXYkAt/LFDccK53lkGRCHbi2+Gxc
 PuSAEHaAMawJ/unM3uRoMVXHTXDte+VppMYNH3Vdy9Hwg4u7LdHIl513Gtzhv9jQHUU2czFjO
 ELSiaVrOZDsP/K7tfSxc/iAtHDOShClSCZYS/5e3aRlJhpdLVSzWT1Q1NU/DJCTsCjhWG3Z5I
 kihbmNIuDDW9rB8irZzo9wf0K66M7pi2CbuTi6X8f7JclRnf2zRVx8g3E9xoSzz37DXfivUIr
 1+P6ufyGuxMQgcLQq6M1GHVHsYwL2Ah/iSRfsWtTK5Wul50Ix2/DA0unFDVmjB/tmrtNlnKUU
 bB8kv0sgx9dF9xcjMMCLuD9dU1bE1JJL0/3xRP2I8SZJr9YjK5yXGgDxM7KbJqA+gaKgdTrIo
 tZZnE/R5ywsMLzlho9Tags/QAdJFGTzIa9iOWBA54RX0wgK4XmPUEksdLbmBs/3y8ytpOnwvY
 wGdio8uiVCkST4RJ4hKvgESaxwynqOoEvG+ODq53xMa4hMv9XIWZsY3QIGko+JWAVQ9uMlXbh
 KzGytD99BP0GtlRAJtbp3eIdOxaQwm9HmdIHTEsYiGdQNVEyMXxlt4ZZecolJ7S7S16M/Z5Vg
 FotmA9aHq+N5kIJWNpcIFuTPmW5sTgLjq+xr/fc910aswBRvYkkfe/UjIa+hPepoqwPRn64nl
 PYfCGM0+/6EVovGw951oukJtGvdqBcWSZhdYYPL44wfqa7eDLkR73VIu9LgcEI77W73vH6ihF
 /X5JKZTwnG8BZW/+AJTC41z4gfXibS+J4btDEWtpNRe+iiNI8oyXkqedvITfYgi3VafID9j93
 EO+9Iv7Ko=
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

On 11/23/24 20:55, Matthew Garrett wrote:
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> We may want to make things conditional on EFI variable state
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>   cmd/Kconfig     |   4 ++
>   cmd/Makefile    |   1 +
>   cmd/efigetenv.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 138 insertions(+)
>   create mode 100644 cmd/efigetenv.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 33bf3d1ad39..118fb721081 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -752,6 +752,10 @@ config CMD_NVEDIT_SELECT
>   	help
>   	  Select the compiled-in persistent storage of environment variables.
>
> +config CMD_EFI_GET_ENV
> +	bool "efi get env"
> +	help
> +	  Set an environment variable to the contents of an EFI variable
>   endmenu
>
>   menu "Memory commands"
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 38cb7a4aea5..0507c204c0e 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_CMD_EEPROM) +=3D eeprom.o
>   obj-$(CONFIG_EFI) +=3D efi.o efi_common.o
>   obj-$(CONFIG_CMD_EFIDEBUG) +=3D efidebug.o efi_common.o
>   obj-$(CONFIG_CMD_EFICONFIG) +=3D eficonfig.o
> +obj-$(CONFIG_CMD_EFI_GET_ENV) +=3D efigetenv.o
>   ifdef CONFIG_CMD_EFICONFIG
>   ifdef CONFIG_EFI_MM_COMM_TEE
>   obj-$(CONFIG_EFI_SECURE_BOOT) +=3D eficonfig_sbkey.o
> diff --git a/cmd/efigetenv.c b/cmd/efigetenv.c
> new file mode 100644
> index 00000000000..5284ee92d6c
> --- /dev/null
> +++ b/cmd/efigetenv.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <charset.h>
> +#include <command.h>
> +#include <efi_loader.h>
> +#include <efi_variable.h>
> +#include <env.h>
> +#include <hexdump.h>
> +#include <malloc.h>
> +#include <uuid.h>
> +
> +/* Set a U-Boot environment variable to the contents of a UEFI variable=
 */
> +int do_efi_get_env(struct cmd_tbl *cmdtb, int flat, int argc, char *con=
st argv[])
> +{
> +	u16 *var_name =3D NULL;
> +	char *strdata =3D NULL;
> +	efi_uintn_t size =3D 0;
> +	bool var_content_is_utf16_string =3D false;
> +	efi_status_t ret;
> +	efi_guid_t guid;
> +	u8 *data =3D NULL;
> +	u32 attributes;
> +	size_t len;
> +	u64 time;
> +	u16 *p;
> +
> +	ret =3D efi_init_obj_list();
> +	if (ret !=3D EFI_SUCCESS) {
> +		printf("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> +		       ret & ~EFI_ERROR_MASK);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	argv++;
> +	argc--;
> +
> +	if (argc !=3D 3 && argc !=3D 4)
> +		return CMD_RET_USAGE;
> +
> +	if (argc =3D=3D 4) {
> +		if (strcmp(argv[0], "-s"))
> +			return CMD_RET_USAGE;
> +		var_content_is_utf16_string =3D true;
> +		argv++;
> +		argc--;
> +	}
> +
> +	len =3D utf8_utf16_strnlen(argv[0], strlen(argv[0]));
> +	var_name =3D malloc((len + 1) * 2);
> +	if (!var_name) {
> +		printf("## Out of memory\n");
> +		return CMD_RET_FAILURE;
> +	}
> +	p =3D var_name;
> +	utf8_utf16_strncpy(&p, argv[0], len + 1);
> +
> +	if (uuid_str_to_bin(argv[1], guid.b, UUID_STR_FORMAT_GUID)) {
> +		ret =3D CMD_RET_USAGE;
> +		goto out;
> +	}
> +
> +	ret =3D efi_get_variable_int(var_name, &guid, &attributes, &size, data=
,
> +				   &time);
> +	if (ret =3D=3D EFI_BUFFER_TOO_SMALL) {
> +		data =3D malloc(size);
> +		if (!data) {
> +			printf("## Out of memory\n");
> +			ret =3D CMD_RET_FAILURE;
> +			goto out;
> +		}
> +		ret =3D efi_get_variable_int(var_name, &guid, &attributes,
> +					   &size, data, &time);

This duplicates code in efi_dump_single_var(), do_efi_capsule_res(),
get_dp_device() and others.

We should carve out a function.

Best regards

Heinrich

> +	}
> +
> +	if (ret =3D=3D EFI_NOT_FOUND) {
> +		printf("Error: \"%ls\" not defined\n", var_name);
> +		ret =3D CMD_RET_FAILURE;
> +		goto out;
> +	}
> +
> +	if (ret !=3D EFI_SUCCESS) {
> +		printf("Error: Cannot read variable, r =3D %lu\n",
> +		       ret & ~EFI_ERROR_MASK);
> +		ret =3D CMD_RET_FAILURE;
> +		goto out;
> +	}
> +
> +	if (var_content_is_utf16_string) {
> +		char *p;
> +
> +		len =3D utf16_utf8_strnlen((u16 *)data, size / 2);
> +		strdata =3D malloc(len + 1);
> +		if (!strdata) {
> +			printf("## Out of memory\n");
> +			ret =3D CMD_RET_FAILURE;
> +			goto out;
> +		}
> +		p =3D strdata;
> +		utf16_utf8_strncpy(&p, (u16 *)data, size / 2);
> +	} else {
> +		len =3D size * 2;
> +		strdata =3D malloc(len + 1);
> +		if (!strdata) {
> +			printf("## Out of memory\n");
> +			ret =3D CMD_RET_FAILURE;
> +			goto out;
> +		}
> +		bin2hex(strdata, data, size);
> +	}
> +
> +	strdata[len] =3D '\0';
> +
> +	ret =3D env_set(argv[2], strdata);
> +	if (ret) {
> +		ret =3D CMD_RET_FAILURE;
> +		goto out;
> +	}
> +
> +	ret =3D CMD_RET_SUCCESS;
> +out:
> +	free(strdata);
> +	free(data);
> +	free(var_name);
> +
> +	return ret;
> +}
> +
> +U_BOOT_CMD(
> +	efigetenv, 5, 4, do_efi_get_env,
> +	"set environment variable to content of EFI variable",
> +	"[-s] name guid envvar\n"
> +	"    - set environment variable 'envvar' to the EFI variable 'name'-'g=
uid'\n"
> +	"      \"-s\": Interpret the EFI variable value as a UTF-16 string\n"
> +);

