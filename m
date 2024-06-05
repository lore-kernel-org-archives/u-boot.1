Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2E6C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 06:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC64C88252;
	Wed,  5 Jun 2024 08:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eSCKXwbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D92985B66; Wed,  5 Jun 2024 08:36:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCFFA8831C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 08:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717569375; x=1718174175; i=xypron.glpk@gmx.de;
 bh=sdNflqCz+hMiGZqwe04kIHmLW9iHXPD+1PubUAeKhOY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eSCKXwbVDJxeMTjMspSFMxsRh+tzQOJk6uqyf+XLc4To+/HAPKqElKOr/DUAA0rt
 R1uMfjHBQh+cL/6sJZ8KAuoqX6fg3vUXqFWm+3nGf/raI5O9ISEf1EjGjC2dpnZ3G
 8LpUXkIGFuXp/LKgHRTlZH5TZmOz1kd24nHyidKUKEPR7jblrZt66fYcAZBu+QHZ+
 +L6kaz+Cs7/AksVfl5uY7yMpRQQisG3as55n/lW3Vh9Aw79QZkFqDFsdGOqKz+plX
 7hXqUp3Ro3PIev/cpcetR9W6G7ekx+Xqv50Vj56pbX/hbM4y53A0Tlqy+s5VJrBwv
 L9wqI+yIxc6bV7Ovfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1s8jiP20wk-00AZdT; Wed, 05
 Jun 2024 08:36:15 +0200
Message-ID: <eb3681f0-ecb9-4775-9093-5640aa408f50@gmx.de>
Date: Wed, 5 Jun 2024 08:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] tools: add genguid tool
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3/mJrFJgu7oMZTl1U6uWDFvAIPsCUf0VM0IeIUuN2YhP4JOShBD
 nteENiucyGlO+lZtcFOVe8miCm5oRuTBOL+N06eJYnxrpwTAPOqC8wg+G9Cii1mY4MXl/dJ
 DyT2y3wG/Mt4vKif2/LBVLeT8JBrdT+oqclW1NYGKHOpJlJFrfUobJsak0RcQP5peLiZqFf
 pEPfNNwTgL+olfFiFVw9A==
UI-OutboundReport: notjunk:1;M01:P0:Gi70sijb6sM=;raN6JNonQdrwjScRUMthGTerBGK
 FAnX798aG8IhoQFRSPaQaREcmQTQsOsMm+qQ9SyBpvpuvXgDEq8LGbHan4cSgMKd0tgcx18Im
 IwAW3WNTgiPNLrCqzLZNAcHk322gN3smkDfoOB4P5szsJlPxTuDPWE8EUA56Gh3lIbTVRg6ti
 pq6l1MO9LhV3CCLcoOks6WeB1PrxnyFGxfJ3rou67VLRBH9A/OuYW+fCcRUbE3eKc2aqCvpZa
 5ACtP3UWYjsovmVPigsicA7mKnpA86w20Dd90eZwcbI3YeoCm1/3yf+7aGOWARZP6GsbOd7Mg
 PoZZYMX5MxrShO4o+4yG6cEjHaHvTdGxTj0VYhIAUtURtFSi3rRLqxKmA4Bvjh6+3QGuhrOy+
 GuqrF/waAh9gFEqi5uGLuGsrEN8SGKfY1T9VyYw159m4YZy4Od3Sk9c8//eXyGczl1pIsFAre
 saMNOrm0Ew8Ap2gwaItVEzPgTtTKZm8Q5mzVrob773dlC74O2Vj4s4iXHzrOXhewcD3I8Rz11
 oLlQI+mao9p0Z3MURDG4rseh6Z0210UDpb4W0rppGHFsEkGKj2OshPrW7oxzKoIZubyQPUVcU
 Vh4HiJrRoefdgqa+498LO46xuZPu8Bqxq/TeKBlj8KOcQXEO8IMRspYErXTz8YKwigiFo4k58
 f1MtMGgA+eyWhm+ZG3+tw6aBoGeh/augP8+KQrc3cfpyJGqfmbIvhTGhUNBuEFZQfrGg1H3Xq
 WdbIqrpWc7dbNib0oUUhs2fwOFjSdRTDTEMpqViEz7bbFvR/hASzV+Ju6MjlVAdanPHxJh/lp
 3XjtIJeA85zFwL3gDq0y60ABmtMmzvsnomL4tijy1zpDk=
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

On 5/31/24 15:50, Caleb Connolly wrote:
> Add a tool that can generate GUIDs that match those generated internally
> by U-Boot for capsule update fw_images.
>
> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
> with the board model, compatible, and fw_image name.
>
> This tool accepts the same inputs and will produce the same GUID as
> U-Boot would at runtime.

This functionality should be integrated into the mkeficapsule.

Just pass the device-tree into mkeficapsule and generate the GUIDs
whereever they are needed.

Best regards

Heinrich

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   doc/genguid.1   |  52 +++++++++++++++++++
>   tools/Kconfig   |   7 +++
>   tools/Makefile  |   3 ++
>   tools/genguid.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>   4 files changed, 216 insertions(+)
>
> diff --git a/doc/genguid.1 b/doc/genguid.1
> new file mode 100644
> index 000000000000..4128055b3a9a
> --- /dev/null
> +++ b/doc/genguid.1
> @@ -0,0 +1,52 @@
> +.\" SPDX-License-Identifier: GPL-2.0+
> +.\" Copyright (c) 2024, Linaro Limited
> +.TH GENGUID 1 "May 2024"
> +
> +.SH NAME
> +genguid \- Generate deterministic EFI capsule image GUIDs for a board
> +
> +.SH SYNOPSIS
> +.B genguid
> +.RI GUID " " [ -vj ] " " -c " " COMPAT " " NAME...
> +
> +.SH "DESCRIPTION"
> +The
> +.B genguid
> +command is used to determine the update image GUIDs for a board using
> +dynamic UUIDs. The command takes a namespace GUID (defined in the board=
s
> +defconfig), the boards first compatible string, and the names of the
> +firmware images. The command will output the GUIDs for each image.
> +
> +As the dynamic UUID mechanism generates GUIDs at runtime, it would be
> +necessary to actually boot U-Boot on the board and enable debug logs
> +to retrieve the generated GUIDs. This tools just simplifies that proces=
s.
> +
> +.SH "OPTIONS"
> +
> +.TP
> +.BI GUID
> +The namespace/salt GUID, same as CONFIG_EFI_CAPSULE_NAMESPACE_UUID.
> +The format is:
> +    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
> +
> +.TP
> +.BI "-v\fR,\fB --verbose "
> +Print additional information to stderr.
> +
> +.TP
> +.BI "-j\fR,\fB --json "
> +Output the results in JSON format (array of object with name/uuid prope=
rties).
> +
> +.TP
> +.BI "-c\fR,\fB --compat " COMPAT
> +The first entry in the boards root compatible property.
> +
> +.TP
> +.BI NAME...
> +The names of the firmware images to generate GUIDs for (e.g. "SANDBOX-U=
BOOT-ENV").
> +
> +.SH AUTHORS
> +Written by Caleb Connolly <caleb.connolly@linaro.org>
> +
> +.SH HOMEPAGE
> +https://u-boot.org
> diff --git a/tools/Kconfig b/tools/Kconfig
> index 667807b33173..13201ff61fd4 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -103,8 +103,15 @@ config TOOLS_MKEFICAPSULE
>   	  This command allows users to create a UEFI capsule file and,
>   	  optionally sign that file. If you want to enable UEFI capsule
>   	  update feature on your target, you certainly need this.
>
> +config TOOLS_GENGUID
> +	bool "Build genguid command"
> +	default y if EFI_CAPSULE_DYNAMIC_UUIDS

Distros have a package u-boot-tools. You want this package to contain
all tools.

Please, ensure that the new tool is built by tools-only_defconfig.

> +	help
> +	  This command allows users to generate the GUIDs that a given
> +	  board would use for UEFI capsule update feature.
> +
>   menuconfig FSPI_CONF_HEADER
>   	bool "FlexSPI Header Configuration"
>   	help
>   	  FSPI Header Configuration
> diff --git a/tools/Makefile b/tools/Makefile
> index 6a4280e3668f..29e9a93b0f24 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -253,8 +253,11 @@ HOSTLDLIBS_mkeficapsule +=3D \
>   HOSTLDLIBS_mkeficapsule +=3D \
>   	$(shell pkg-config --libs uuid 2> /dev/null || echo "-luuid")
>   hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) +=3D mkeficapsule
>
> +genguid-objs :=3D generated/lib/uuid.o generated/lib/sha1.o genguid.o
> +hostprogs-$(CONFIG_TOOLS_GENGUID) +=3D genguid
> +
>   mkfwumdata-objs :=3D mkfwumdata.o generated/lib/crc32.o
>   HOSTLDLIBS_mkfwumdata +=3D -luuid
>   hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) +=3D mkfwumdata
>
> diff --git a/tools/genguid.c b/tools/genguid.c
> new file mode 100644
> index 000000000000..e71bc1d48f95
> --- /dev/null
> +++ b/tools/genguid.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2024 Linaro Ltd.
> + *   Author: Caleb Connolly
> + */
> +
> +#include <getopt.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/types.h>
> +
> +#include <uuid.h>
> +
> +static struct option options[] =3D {
> +	{"dtb", required_argument, NULL, 'd'},
> +	{"compat", required_argument, NULL, 'c'},
> +	{"help", no_argument, NULL, 'h'},
> +	{"verbose", no_argument, NULL, 'v'},
> +	{"json", no_argument, NULL, 'j'},
> +	{NULL, 0, NULL, 0},
> +};
> +
> +static void usage(const char *progname)
> +{
> +	fprintf(stderr, "Usage: %s GUID [-v] -c COMPAT NAME...\n", progname);
> +	fprintf(stderr,
> +		"Generate a v5 GUID for one of more U-Boot fw_images the same way U-B=
oot does at runtime.\n");
> +	fprintf(stderr,
> +		"\nOptions:\n"
> +		"  GUID                     namespace/salt GUID in 8-4-4-4-12 format\=
n"
> +		"  -h, --help               display this help and exit\n"
> +		"  -c, --compat=3DCOMPAT      first compatible property in the board =
devicetree\n"

We don't need the first compatible string but the one in the root node.

> +		"  -v, --verbose            print debug messages\n"
> +		"  -j, --json               output in JSON format\n"
> +		"  NAME...                  one or more names of fw_images to generat=
e GUIDs for\n"
> +	);
> +	fprintf(stderr, "\nExample:\n");
> +	fprintf(stderr, "  %s 2a5aa852-b856-4d97-baa9-5c5f4421551f \\\n"
> +			"\t-c \"qcom,qrb4210-rb2\" \\\n"
> +			"\tQUALCOMM-UBOOT\n", progname);
> +}
> +
> +static size_t u16_strsize(const uint16_t *in)
> +{
> +	size_t i =3D 0, count =3D UINT16_MAX;
> +
> +	while (count-- && in[i])
> +		i++;
> +
> +	return (i + 1) * sizeof(uint16_t);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct uuid namespace;
> +	char *namespace_str;
> +	char uuid_str[37];
> +	char **image_uuids;
> +	char *compatible =3D NULL;
> +	uint16_t **images_u16;
> +	char **images;
> +	int c, n_images;
> +	bool debug =3D false, json =3D false;
> +
> +	if (argc < 2) {
> +		usage(argv[0]);
> +		return 1;
> +	}
> +
> +	namespace_str =3D argv[1];
> +
> +	/* The first arg is the GUID so skip it */
> +	while ((c =3D getopt_long(argc, argv, "c:hvj", options, NULL)) !=3D -1=
) {
> +		switch (c) {
> +		case 'c':
> +			compatible =3D strdup(optarg);
> +			break;
> +		case 'h':
> +			usage(argv[0]);
> +			return 0;
> +		case 'v':
> +			debug =3D true;
> +			break;
> +		case 'j':
> +			json =3D true;
> +			break;
> +		default:
> +			usage(argv[0]);
> +			return 1;
> +		}
> +	}
> +
> +	if (!compatible) {
> +		fprintf(stderr, "ERROR: Please specify the compatible property.\n\n")=
;
> +		usage(argv[0]);
> +		return 1;
> +	}
> +
> +	if (uuid_str_to_bin(namespace_str, (unsigned char *)&namespace, UUID_S=
TR_FORMAT_GUID)) {
> +		fprintf(stderr, "ERROR: Check that your UUID is formatted correctly.\=
n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* This is probably not the best way to convert a string to a "u16" st=
ring */

Do you mean UTF-16?

Instead of writing "not the best way", please, describe the restrictions.

> +	n_images =3D argc - optind - 1;
> +	images =3D argv + optind + 1;
> +	images_u16 =3D calloc(n_images, sizeof(char *));

Please, check that the result in not NULL.

> +	for (int i =3D 0; i < n_images; i++) {
> +		images_u16[i] =3D calloc(1, strlen(images[i]) * 2 + 2);

ditto

> +		for (int j =3D 0; j < strlen(images[i]); j++)
> +			images_u16[i][j] =3D (uint16_t)images[i][j];

This is definitively not working for non-ASCII characters. You should
throw an error for non-ASCII or provide a conversion routine.

Best regards

Heinrich

> +	}
> +
> +	if (debug) {
> +		fprintf(stderr, "GUID:         ");
> +		uuid_bin_to_str((uint8_t *)&namespace, uuid_str, UUID_STR_FORMAT_GUID=
);
> +		fprintf(stderr, "%s\n", uuid_str);
> +		fprintf(stderr, "Compatible:  \"%s\"\n", compatible);
> +		fprintf(stderr, "Images:      ");
> +		for (int i =3D 0; i < n_images; i++)
> +			fprintf(stderr, "\"%s\"%s", argv[optind + i + 1],
> +				i =3D=3D n_images - 1 ? "\n" : ", ");
> +	}
> +
> +	image_uuids =3D calloc(n_images, sizeof(char *));
> +	for (int i =3D 0; i < n_images; i++) {
> +		struct uuid image_type_id;
> +
> +		gen_uuid_v5(&namespace, &image_type_id,
> +			    compatible, strlen(compatible),
> +			    images_u16[i], u16_strsize(images_u16[i]) - sizeof(uint16_t),
> +			    NULL);
> +
> +		uuid_bin_to_str((uint8_t *)&image_type_id, uuid_str, UUID_STR_FORMAT_=
GUID);
> +		image_uuids[i] =3D strdup(uuid_str);
> +	}
> +
> +	if (json) {
> +		printf("[\n");
> +		for (int i =3D 0; i < n_images; i++)
> +			printf("\t{\"name\": \"%s\", \"uuid\": \"%s\"}%s\n", images[i], imag=
e_uuids[i],
> +			       i =3D=3D n_images - 1 ? "" : ",");
> +		printf("]\n");
> +	} else {
> +		for (int i =3D 0; i < n_images; i++)
> +			printf("%-24s| %s\n", images[i], image_uuids[i]);
> +	}
> +
> +	return 0;
> +}
> +
>

