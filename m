Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354E1C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 06:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A56688300;
	Wed,  5 Jun 2024 08:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cCAPKEue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4371888191; Wed,  5 Jun 2024 08:39:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F798831D
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 08:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717569537; x=1718174337; i=xypron.glpk@gmx.de;
 bh=q6GSL1J+HcBAEYfQBLtW6RNgojMkcHJmaJiO2HYLodA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cCAPKEuevZgi0jBHchmYom341rIHYdoFoOTApJ7NNCrisyzGgXODD4G83yEkFJNb
 /x0ZygZ3y4sYRlQH15bpeVr4iBQtMtLaYWLgGoJDgIO4Y+EPWzTBBqT8T3cr16uAX
 A/gg1OB13oqXBVzFoEwlULHnCUl1UZ/rV8shJtHEcMusQVv68QBInJLWXs405o8cE
 uigDXz3Y2zmp7cOULjsT3pyTCH81qwwYgkPsNng0haC8Ht8asZhKpAmJlKAz4YwPL
 7hFdPY2aL11cTArSbJU/vVHaDplSjBw1YLpEkj8Xfi2TJAMdRmHx/j6VbZqG5/2uV
 LPCKpcoN6/eZPsy93g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1s1dIX1SC0-00PJJy; Wed, 05
 Jun 2024 08:38:57 +0200
Message-ID: <17bad18b-29fa-44b8-9827-bf497cf49703@gmx.de>
Date: Wed, 5 Jun 2024 08:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] tools: add genguid tool
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
 <eb3681f0-ecb9-4775-9093-5640aa408f50@gmx.de>
Content-Language: en-US
In-Reply-To: <eb3681f0-ecb9-4775-9093-5640aa408f50@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oVYs7G6dNWqpWZXVnIREp1ILxfnkC/BKmeqYBR4xmKXuDxeGJ/m
 2Kg7pk42lOy8gkjbKr1GMt3Wtrm39xFQXo7HzS2JEoADW1l2k77VZlYG9oQnVCIYkrwrEXq
 7P9F+a98HppwzjN9DK1hHfAitjLobkMyOo7d6iyKhnI22Lrk0ZLAUbkYoEn7iPQJixCCVnd
 vpvmtq5ArtDyhaXiJjUUQ==
UI-OutboundReport: notjunk:1;M01:P0:C+wNZJFmPiw=;w6/hoJlr4l3kUEdQbOb1Q3wCsRs
 E7GFYR1huPpENG0nFeH9ZB1C3T5RK/6dbFMpRiyFWUTLYIwIpPrvWvuW5uld4r3Qp7jbMblON
 k9hxiu3ZDKrs9cLI3Pt/XtQNuSsuDY87KPirDG4I7phNBBlg7lCwy6N2G1rg3HdtRdByscmxo
 ga8j9sHW4OB6edY8MZOdctM3y71q8Tq1UoAeRAzjOVlPqbFDqogyboNHfv0q554f0nGOAs5nV
 2nvw8cKk7P0RDBEEWK6WKzHprtk162dvqczTox5LV4JXaQKWy5lghx5zyqVDqLZrpruQlAWue
 oMY9cFjfhrKQ3oZ2lqFrGhnDcjgS13HMlTTW7DINiTKuVYKrbrVmH2/RhM5BF/Vv/8G7rHSBl
 0fKFYz8+zandLooBv0RWl62CltPpkMMXOHnl5N7bYbc50xwZ3o1BXe1kkgU9PHdYU7JBA+PzC
 y4rf8y9YQWf708LVA2qWqqv5FxjsO7j9vnlRtyOZDKBCnn/Vzcoifdl0ekXb8akVy9VJARQWV
 +1D+BPMjjGGTjC2WFNJ105R7NLPwRzMlk0jPcOuccyCySibqdU+s5DsXa2RSICWQXvxQX5RLN
 KEMh9YMzeGit7+MtORfFchHmUp60yVYqG0Qo/fYvIamOT9NXRDc05KCWWiIMnfSfC3tRC+NTl
 F79LUxded9t6MVquGBnXnB3jZwYu6eWwueMsVnfYD6pnl9dgmgcVfzXizoeB4bMEsKpPWovWj
 8iSPalrQIAhmdhXpiFlxWukxSq7L7qNiTXnNq8PMKM1Ydj0fPRKcv8ytYNTHKsXTmougFX1yd
 U+uMC4HtwdtqHmUB523t/7MDidW12kswZfZeAwcQuFIqA=
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

On 6/5/24 08:36, Heinrich Schuchardt wrote:
> On 5/31/24 15:50, Caleb Connolly wrote:
>> Add a tool that can generate GUIDs that match those generated internall=
y
>> by U-Boot for capsule update fw_images.
>>
>> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
>> with the board model, compatible, and fw_image name.
>>
>> This tool accepts the same inputs and will produce the same GUID as
>> U-Boot would at runtime.
>
> This functionality should be integrated into the mkeficapsule.
>
> Just pass the device-tree into mkeficapsule and generate the GUIDs
> whereever they are needed.
>
> Best regards
>
> Heinrich
>
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> =C2=A0 doc/genguid.1=C2=A0=C2=A0 |=C2=A0 52 +++++++++++++++++++
>> =C2=A0 tools/Kconfig=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +++
>> =C2=A0 tools/Makefile=C2=A0 |=C2=A0=C2=A0 3 ++
>> =C2=A0 tools/genguid.c | 154

A change to MAINTAINERS is missing.

Best regards

Heinrich

>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 4 files changed, 216 insertions(+)
>>
>> diff --git a/doc/genguid.1 b/doc/genguid.1
>> new file mode 100644
>> index 000000000000..4128055b3a9a
>> --- /dev/null
>> +++ b/doc/genguid.1
>> @@ -0,0 +1,52 @@
>> +.\" SPDX-License-Identifier: GPL-2.0+
>> +.\" Copyright (c) 2024, Linaro Limited
>> +.TH GENGUID 1 "May 2024"
>> +
>> +.SH NAME
>> +genguid \- Generate deterministic EFI capsule image GUIDs for a board
>> +
>> +.SH SYNOPSIS
>> +.B genguid
>> +.RI GUID " " [ -vj ] " " -c " " COMPAT " " NAME...
>> +
>> +.SH "DESCRIPTION"
>> +The
>> +.B genguid
>> +command is used to determine the update image GUIDs for a board using
>> +dynamic UUIDs. The command takes a namespace GUID (defined in the boar=
ds
>> +defconfig), the boards first compatible string, and the names of the
>> +firmware images. The command will output the GUIDs for each image.
>> +
>> +As the dynamic UUID mechanism generates GUIDs at runtime, it would be
>> +necessary to actually boot U-Boot on the board and enable debug logs
>> +to retrieve the generated GUIDs. This tools just simplifies that
>> process.
>> +
>> +.SH "OPTIONS"
>> +
>> +.TP
>> +.BI GUID
>> +The namespace/salt GUID, same as CONFIG_EFI_CAPSULE_NAMESPACE_UUID.
>> +The format is:
>> +=C2=A0=C2=A0=C2=A0 xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
>> +
>> +.TP
>> +.BI "-v\fR,\fB --verbose "
>> +Print additional information to stderr.
>> +
>> +.TP
>> +.BI "-j\fR,\fB --json "
>> +Output the results in JSON format (array of object with name/uuid
>> properties).
>> +
>> +.TP
>> +.BI "-c\fR,\fB --compat " COMPAT
>> +The first entry in the boards root compatible property.
>> +
>> +.TP
>> +.BI NAME...
>> +The names of the firmware images to generate GUIDs for (e.g.
>> "SANDBOX-UBOOT-ENV").
>> +
>> +.SH AUTHORS
>> +Written by Caleb Connolly <caleb.connolly@linaro.org>
>> +
>> +.SH HOMEPAGE
>> +https://u-boot.org
>> diff --git a/tools/Kconfig b/tools/Kconfig
>> index 667807b33173..13201ff61fd4 100644
>> --- a/tools/Kconfig
>> +++ b/tools/Kconfig
>> @@ -103,8 +103,15 @@ config TOOLS_MKEFICAPSULE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This command allows users to=
 create a UEFI capsule file and,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optionally sign that file. I=
f you want to enable UEFI capsule
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update feature on your targe=
t, you certainly need this.
>>
>> +config TOOLS_GENGUID
>> +=C2=A0=C2=A0=C2=A0 bool "Build genguid command"
>> +=C2=A0=C2=A0=C2=A0 default y if EFI_CAPSULE_DYNAMIC_UUIDS
>
> Distros have a package u-boot-tools. You want this package to contain
> all tools.
>
> Please, ensure that the new tool is built by tools-only_defconfig.
>
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This command allows users to generate t=
he GUIDs that a given
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 board would use for UEFI capsule update=
 feature.
>> +
>> =C2=A0 menuconfig FSPI_CONF_HEADER
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "FlexSPI Header Configuration"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FSPI Header Configuration
>> diff --git a/tools/Makefile b/tools/Makefile
>> index 6a4280e3668f..29e9a93b0f24 100644
>> --- a/tools/Makefile
>> +++ b/tools/Makefile
>> @@ -253,8 +253,11 @@ HOSTLDLIBS_mkeficapsule +=3D \
>> =C2=A0 HOSTLDLIBS_mkeficapsule +=3D \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(shell pkg-config --libs uuid 2> /dev/n=
ull || echo "-luuid")
>> =C2=A0 hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) +=3D mkeficapsule
>>
>> +genguid-objs :=3D generated/lib/uuid.o generated/lib/sha1.o genguid.o
>> +hostprogs-$(CONFIG_TOOLS_GENGUID) +=3D genguid
>> +
>> =C2=A0 mkfwumdata-objs :=3D mkfwumdata.o generated/lib/crc32.o
>> =C2=A0 HOSTLDLIBS_mkfwumdata +=3D -luuid
>> =C2=A0 hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) +=3D mkfwumdata
>>
>> diff --git a/tools/genguid.c b/tools/genguid.c
>> new file mode 100644
>> index 000000000000..e71bc1d48f95
>> --- /dev/null
>> +++ b/tools/genguid.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2024 Linaro Ltd.
>> + *=C2=A0=C2=A0 Author: Caleb Connolly
>> + */
>> +
>> +#include <getopt.h>
>> +#include <stdbool.h>
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <linux/types.h>
>> +
>> +#include <uuid.h>
>> +
>> +static struct option options[] =3D {
>> +=C2=A0=C2=A0=C2=A0 {"dtb", required_argument, NULL, 'd'},
>> +=C2=A0=C2=A0=C2=A0 {"compat", required_argument, NULL, 'c'},
>> +=C2=A0=C2=A0=C2=A0 {"help", no_argument, NULL, 'h'},
>> +=C2=A0=C2=A0=C2=A0 {"verbose", no_argument, NULL, 'v'},
>> +=C2=A0=C2=A0=C2=A0 {"json", no_argument, NULL, 'j'},
>> +=C2=A0=C2=A0=C2=A0 {NULL, 0, NULL, 0},
>> +};
>> +
>> +static void usage(const char *progname)
>> +{
>> +=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Usage: %s GUID [-v] -c COMPAT NAME=
...\n",
>> progname);
>> +=C2=A0=C2=A0=C2=A0 fprintf(stderr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Generate a v5 GUID for one=
 of more U-Boot fw_images the same
>> way U-Boot does at runtime.\n");
>> +=C2=A0=C2=A0=C2=A0 fprintf(stderr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\nOptions:\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 GUID=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 namespace/salt GUID in 8-4-4-4-12
>> format\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 -h, --help=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 display this help and exit\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 -c, --compat=3DCOMP=
AT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first compatible property in the
>> board devicetree\n"
>
> We don't need the first compatible string but the one in the root node.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 -v, --verbose=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print debug m=
essages\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 -j, --json=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 output in JSON format\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 NAME...=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 one or more names of fw_images to
>> generate GUIDs for\n"
>> +=C2=A0=C2=A0=C2=A0 );
>> +=C2=A0=C2=A0=C2=A0 fprintf(stderr, "\nExample:\n");
>> +=C2=A0=C2=A0=C2=A0 fprintf(stderr, "=C2=A0 %s 2a5aa852-b856-4d97-baa9-=
5c5f4421551f \\\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\t=
-c \"qcom,qrb4210-rb2\" \\\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\t=
QUALCOMM-UBOOT\n", progname);
>> +}
>> +
>> +static size_t u16_strsize(const uint16_t *in)
>> +{
>> +=C2=A0=C2=A0=C2=A0 size_t i =3D 0, count =3D UINT16_MAX;
>> +
>> +=C2=A0=C2=A0=C2=A0 while (count-- && in[i])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++;
>> +
>> +=C2=A0=C2=A0=C2=A0 return (i + 1) * sizeof(uint16_t);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct uuid namespace;
>> +=C2=A0=C2=A0=C2=A0 char *namespace_str;
>> +=C2=A0=C2=A0=C2=A0 char uuid_str[37];
>> +=C2=A0=C2=A0=C2=A0 char **image_uuids;
>> +=C2=A0=C2=A0=C2=A0 char *compatible =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 uint16_t **images_u16;
>> +=C2=A0=C2=A0=C2=A0 char **images;
>> +=C2=A0=C2=A0=C2=A0 int c, n_images;
>> +=C2=A0=C2=A0=C2=A0 bool debug =3D false, json =3D false;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (argc < 2) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usage(argv[0]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 namespace_str =3D argv[1];
>> +
>> +=C2=A0=C2=A0=C2=A0 /* The first arg is the GUID so skip it */
>> +=C2=A0=C2=A0=C2=A0 while ((c =3D getopt_long(argc, argv, "c:hvj", opti=
ons, NULL)) !=3D
>> -1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (c) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'c':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D strdup(optarg);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'h':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usa=
ge(argv[0]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'v':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb=
ug =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'j':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jso=
n =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usa=
ge(argv[0]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!compatible) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "ERROR: Ple=
ase specify the compatible
>> property.\n\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usage(argv[0]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (uuid_str_to_bin(namespace_str, (unsigned char *=
)&namespace,
>> UUID_STR_FORMAT_GUID)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "ERROR: Che=
ck that your UUID is formatted
>> correctly.\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* This is probably not the best way to convert a s=
tring to a
>> "u16" string */
>
> Do you mean UTF-16?
>
> Instead of writing "not the best way", please, describe the restrictions=
.
>
>> +=C2=A0=C2=A0=C2=A0 n_images =3D argc - optind - 1;
>> +=C2=A0=C2=A0=C2=A0 images =3D argv + optind + 1;
>> +=C2=A0=C2=A0=C2=A0 images_u16 =3D calloc(n_images, sizeof(char *));
>
> Please, check that the result in not NULL.
>
>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < n_images; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 images_u16[i] =3D calloc(1,=
 strlen(images[i]) * 2 + 2);
>
> ditto
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int j =3D 0; j < strle=
n(images[i]); j++)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ima=
ges_u16[i][j] =3D (uint16_t)images[i][j];
>
> This is definitively not working for non-ASCII characters. You should
> throw an error for non-ASCII or provide a conversion routine.
>
> Best regards
>
> Heinrich
>
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (debug) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "GUID:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid_bin_to_str((uint8_t *)=
&namespace, uuid_str,
>> UUID_STR_FORMAT_GUID);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "%s\n", uui=
d_str);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Compatible=
:=C2=A0 \"%s\"\n", compatible);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Images:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < n_ima=
ges; i++)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpr=
intf(stderr, "\"%s\"%s", argv[optind + i + 1],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 i =3D=3D n_images - 1 ? "\n" : ", ");
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 image_uuids =3D calloc(n_images, sizeof(char *));
>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < n_images; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uuid image_type_id;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_uuid_v5(&namespace, &im=
age_type_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 compatible, strlen(compatible),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 images_u16[i], u16_strsize(images_u16[i]) -
>> sizeof(uint16_t),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid_bin_to_str((uint8_t *)=
&image_type_id, uuid_str,
>> UUID_STR_FORMAT_GUID);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image_uuids[i] =3D strdup(u=
uid_str);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (json) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("[\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < n_ima=
ges; i++)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pri=
ntf("\t{\"name\": \"%s\", \"uuid\": \"%s\"}%s\n",
>> images[i], image_uuids[i],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i =3D=3D n_images - 1 ? "" : ",");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("]\n");
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < n_ima=
ges; i++)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pri=
ntf("%-24s| %s\n", images[i], image_uuids[i]);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>>
>

