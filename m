Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4363C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9B188532;
	Thu, 20 Jun 2024 16:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06378852D; Thu, 20 Jun 2024 16:58:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 96F9D882AD
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DC6DDA7;
 Thu, 20 Jun 2024 07:58:39 -0700 (PDT)
Received: from debian (X72Y076X74.nice.arm.com [10.34.129.22])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E53FA3F73B;
 Thu, 20 Jun 2024 07:58:12 -0700 (PDT)
Date: Thu, 20 Jun 2024 16:58:09 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 6/7] tools: add genguid tool
Message-ID: <ZnRDgSowZHzf7cJm@debian>
Mail-Followup-To: Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
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

On Fri, May 31, 2024 at 03:50:40PM +0200, Caleb Connolly wrote:
> Add a tool that can generate GUIDs that match those generated internally
> by U-Boot for capsule update fw_images.

Hi Caleb,

Thanks for working on this.
I think there is a leftover "dtb" option; see below.

Best regards,
Vincent.

> 
> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
> with the board model, compatible, and fw_image name.
> 
> This tool accepts the same inputs and will produce the same GUID as
> U-Boot would at runtime.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/genguid.1   |  52 +++++++++++++++++++
>  tools/Kconfig   |   7 +++
>  tools/Makefile  |   3 ++
>  tools/genguid.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 216 insertions(+)

(...)

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
> +static struct option options[] = {
> +	{"dtb", required_argument, NULL, 'd'},

I think this is unused.

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
> +		"Generate a v5 GUID for one of more U-Boot fw_images the same way U-Boot does at runtime.\n");
> +	fprintf(stderr,
> +		"\nOptions:\n"
> +		"  GUID                     namespace/salt GUID in 8-4-4-4-12 format\n"
> +		"  -h, --help               display this help and exit\n"
> +		"  -c, --compat=COMPAT      first compatible property in the board devicetree\n"
> +		"  -v, --verbose            print debug messages\n"
> +		"  -j, --json               output in JSON format\n"
> +		"  NAME...                  one or more names of fw_images to generate GUIDs for\n"
> +	);
> +	fprintf(stderr, "\nExample:\n");
> +	fprintf(stderr, "  %s 2a5aa852-b856-4d97-baa9-5c5f4421551f \\\n"
> +			"\t-c \"qcom,qrb4210-rb2\" \\\n"
> +			"\tQUALCOMM-UBOOT\n", progname);
> +}
> +
> +static size_t u16_strsize(const uint16_t *in)
> +{
> +	size_t i = 0, count = UINT16_MAX;
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
> +	char *compatible = NULL;
> +	uint16_t **images_u16;
> +	char **images;
> +	int c, n_images;
> +	bool debug = false, json = false;
> +
> +	if (argc < 2) {
> +		usage(argv[0]);
> +		return 1;
> +	}
> +
> +	namespace_str = argv[1];
> +
> +	/* The first arg is the GUID so skip it */
> +	while ((c = getopt_long(argc, argv, "c:hvj", options, NULL)) != -1) {
> +		switch (c) {
> +		case 'c':
> +			compatible = strdup(optarg);
> +			break;
> +		case 'h':
> +			usage(argv[0]);
> +			return 0;
> +		case 'v':
> +			debug = true;
> +			break;
> +		case 'j':
> +			json = true;
> +			break;
> +		default:
> +			usage(argv[0]);
> +			return 1;
> +		}
> +	}
> +
> +	if (!compatible) {
> +		fprintf(stderr, "ERROR: Please specify the compatible property.\n\n");
> +		usage(argv[0]);
> +		return 1;
> +	}
> +
> +	if (uuid_str_to_bin(namespace_str, (unsigned char *)&namespace, UUID_STR_FORMAT_GUID)) {
> +		fprintf(stderr, "ERROR: Check that your UUID is formatted correctly.\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* This is probably not the best way to convert a string to a "u16" string */
> +	n_images = argc - optind - 1;
> +	images = argv + optind + 1;
> +	images_u16 = calloc(n_images, sizeof(char *));
> +	for (int i = 0; i < n_images; i++) {
> +		images_u16[i] = calloc(1, strlen(images[i]) * 2 + 2);
> +		for (int j = 0; j < strlen(images[i]); j++)
> +			images_u16[i][j] = (uint16_t)images[i][j];
> +	}
> +
> +	if (debug) {
> +		fprintf(stderr, "GUID:         ");
> +		uuid_bin_to_str((uint8_t *)&namespace, uuid_str, UUID_STR_FORMAT_GUID);
> +		fprintf(stderr, "%s\n", uuid_str);
> +		fprintf(stderr, "Compatible:  \"%s\"\n", compatible);
> +		fprintf(stderr, "Images:      ");
> +		for (int i = 0; i < n_images; i++)
> +			fprintf(stderr, "\"%s\"%s", argv[optind + i + 1],
> +				i == n_images - 1 ? "\n" : ", ");
> +	}
> +
> +	image_uuids = calloc(n_images, sizeof(char *));
> +	for (int i = 0; i < n_images; i++) {
> +		struct uuid image_type_id;
> +
> +		gen_uuid_v5(&namespace, &image_type_id,
> +			    compatible, strlen(compatible),
> +			    images_u16[i], u16_strsize(images_u16[i]) - sizeof(uint16_t),
> +			    NULL);
> +
> +		uuid_bin_to_str((uint8_t *)&image_type_id, uuid_str, UUID_STR_FORMAT_GUID);
> +		image_uuids[i] = strdup(uuid_str);
> +	}
> +
> +	if (json) {
> +		printf("[\n");
> +		for (int i = 0; i < n_images; i++)
> +			printf("\t{\"name\": \"%s\", \"uuid\": \"%s\"}%s\n", images[i], image_uuids[i],
> +			       i == n_images - 1 ? "" : ",");
> +		printf("]\n");
> +	} else {
> +		for (int i = 0; i < n_images; i++)
> +			printf("%-24s| %s\n", images[i], image_uuids[i]);
> +	}
> +
> +	return 0;
> +}
> +
> 
> -- 
> 2.45.0
> 
