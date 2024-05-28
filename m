Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8745C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 07:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14795883FB;
	Tue, 28 May 2024 09:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nfFNEL09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0479388402; Tue, 28 May 2024 09:22:46 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4324883FA
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35507a3a038so296960f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 00:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716880963; x=1717485763;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M1HElasoNknCnfiSjDOPfykLzqxoGBx0O1MB8fLGkrk=;
 b=nfFNEL09iZkyRHWWtvjva/BzrzDzIxQIgQAA3HkJTcdc7Vd8LV8/jxX3G9hgc0FL60
 eO5xieewVK9Tw5j1rgSKge3Wjxh8K81sLl2UFDWYUJh72mkAxsJ6+PcKACRatbkeSx5K
 FpzD6ibU4fcKIY9lM0nYC1bYjV0/RQlwdp3NAkyGT8H6PZG8Y3gt1ndcdFi9xNPqjOAj
 tXVPxKatoCvWwExmmftPC+paLqt/QRYKSRMRcEW7I/JMlGiPbxW/0M6Qo0isdwsVoKUU
 96gfmQPhjTdArnkM4lkg+w2DvfD2IDvkWo9EWYazAMu+5zC+0zn8y/PhFKUV3NPnVppW
 GOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716880963; x=1717485763;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=M1HElasoNknCnfiSjDOPfykLzqxoGBx0O1MB8fLGkrk=;
 b=CQcXkVrc4NnzLAPGNGkvivepye8PKXLODOQAc/qxqhWeHFNA4oQ3U8R9wyAf1dshHk
 GWAamAD3c7FDfAmCU+1Xtx7x01gE8JGUp9kt56QG7aAgokX9FN5PTcWEoUJu7VCyizPY
 kamBgF0Kvb3u937e5sgpcAbte1TlwuRDVpMX3t1Z+Y8MP84Y0e3Gc2pfdjhRLVAIdFJP
 51jU6YVzGftDiM3bZGK0qZ6pu7V4AdyuRV9YKB/yvnQ8ZUn4ilEHFaTwBNN5JfP03cqd
 N9e1A3ZSm0whIUtZgklai4h0hKD78Pj0j+CqQAYuMXp7WZfT5zYY5D67Grn8okjgkYZF
 lHuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWApDsDIqWziKJ9RtIJuUoT0SHk57o8P+nQulm28Oi4H2dmJ5VQX0VvIzB3YlYkmoAgqfipCmqCiAtTDv1z2elYjtRmQA==
X-Gm-Message-State: AOJu0YzyKyDDEu+8e8UC8xPVwmKZmEiVyKp0S3KjRGhblWNIc6EcZ6uA
 cdKdX7wDqAgoutHNtatzGSXwZvoweP3Zzp+lEOu+xY/cpLRKkriwUDm+h89VDMU=
X-Google-Smtp-Source: AGHT+IHCQ1niXL7hytALYwJELSYdkCIUvoU2wsNCD/LfTt0yBWvk4oej6z4JmW0QjPmygVImKipGsQ==
X-Received: by 2002:adf:a45b:0:b0:354:de3f:b7cd with SMTP id
 ffacd0b85a97d-35526c272a9mr10698111f8f.24.1716880963152; 
 Tue, 28 May 2024 00:22:43 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c93a5sm10915161f8f.70.2024.05.28.00.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 00:22:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Roman Stratiienko <r.stratiienko@gmail.com>, r.stratiienko@gmail.com,
 igor.opaniuk@gmail.com, dsimic@manjaro.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, eajames@linux.ibm.com,
 marek.vasut+renesas@mailbox.org, paulerwan.rio@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] abootcmd: Add load subcommand
In-Reply-To: <20240519191856.2582174-2-r.stratiienko@gmail.com>
References: <20240519191856.2582174-1-r.stratiienko@gmail.com>
 <20240519191856.2582174-2-r.stratiienko@gmail.com>
Date: Tue, 28 May 2024 09:22:37 +0200
Message-ID: <87wmneh03m.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Roman,

Thank you for the patch.

On dim., mai 19, 2024 at 19:18, Roman Stratiienko <r.stratiienko@gmail.com>=
 wrote:

> What it does:
> 1. Allocates the memory in HEAP to fit the partition
> 2. Loads partition into memory. In the following patch of this series,
>    loading will be optimized to avoid loading an empty space.
> 3. Sets buffer start and buffer size value into environment variables
>    abootimg_<partition>_ptr and abootimg_<partition>_size, respectively.
>     and duplicate them as
>    abootimg_<partition>_<slot>_ptr and abootimg_<partition>_<slot>_size.
>    The latter two are needed to access by the AVB get_preloaded_partition.
>    (see the next patch).
>
> Before this command, the boot script developer was responsible for
> allocating the memory manually by choosing the start and the end,
> which is far from good.
>
> Usage example:
>
>     abootcmd load mmc 0 boot a

Should this be: abootimg load mmc 0 boot a ?

>
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  cmd/abootimg.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index a5321bab6a..808c9c4941 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -8,7 +8,9 @@
>  #include <common.h>
>  #include <command.h>
>  #include <image.h>
> +#include <malloc.h>
>  #include <mapmem.h>
> +#include <part.h>
>=20=20
>  #define abootimg_addr() \
>  	(_abootimg_addr =3D=3D -1 ? image_load_addr : _abootimg_addr)
> @@ -259,10 +261,81 @@ static int do_abootimg_dump(struct cmd_tbl *cmdtp, =
int flag, int argc,
>  	return CMD_RET_SUCCESS;
>  }
>=20=20
> +static int do_abootimg_load(struct cmd_tbl *cmdtp, int flag, int argc,
> +			    char *const argv[])
> +{
> +	int time_start =3D get_timer(0);

On -next branch (where the patch will be applied), I see the following
build error:

cmd/abootimg.c: In function =E2=80=98do_abootimg_load=E2=80=99:
cmd/abootimg.c:279:26: error: implicit declaration of function =E2=80=98get=
_timer=E2=80=99 [-Wimplicit-function-declaration]
  279 |         int time_start =3D get_timer(0);
      |                          ^~~~~~~~~

Please add the missing include: #include <time.h>

Base: 7e52d6ccfb76 ("Merge patch series "FWU: Add support for FWU metadata =
version 2"")

> +	struct blk_desc *desc;
> +	struct disk_partition info;
> +	char buf[512] =3D { 0 };
> +	void *addr;
> +	int ret;
> +
> +	if (argc < 4)
> +		return CMD_RET_USAGE;
> +	if (argc > 5)
> +		return CMD_RET_USAGE;

Can we please do this in a single line, like done in other commands such
as do_abootimg_addr()?

> +
> +	ret =3D blk_get_device_by_str(argv[1], argv[2], &desc);
> +	if (ret < 0) {
> +		printf("Error: Failed to get device %s %s\n", argv[1], argv[2]);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (argc =3D=3D 5)
> +		sprintf(buf, "%s_%s", argv[3], argv[4]);
> +	else
> +		sprintf(buf, "%s", argv[3]);
> +
> +	ret =3D part_get_info_by_name(desc, buf, &info);
> +	if (ret < 0) {
> +		printf("Error: Failed to get partition %s\n", buf);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	addr =3D (void *)memalign(4096, info.size * info.blksz);

Why 4096? If this is a known number, can we use a define for it please?

> +	if (!addr) {
> +		printf("Error: Failed to allocate memory\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret =3D blk_dread(desc, info.start, info.size, addr);
> +	if (ret < 0) {
> +		printf("Error: Failed to read partition %s\n", buf);
> +		goto fail;
> +	}
> +
> +	sprintf(buf, "abootimg_%s_ptr", argv[3]);
> +	env_set_hex(buf, (ulong)addr);
> +
> +	sprintf(buf, "abootimg_%s_size", argv[3]);
> +	env_set_hex(buf, info.size * info.blksz);
> +
> +	if (argc =3D=3D 5) {
> +		sprintf(buf, "abootimg_%s_%s_ptr", argv[3], argv[4]);
> +		env_set_hex(buf, (ulong)addr);
> +
> +		sprintf(buf, "abootimg_%s_%s_size", argv[3], argv[4]);
> +		env_set_hex(buf, info.size * info.blksz);
> +	}
> +
> +	int time_end =3D get_timer(0);
> +
> +	printf("Loaded '%s' partition to address 0x%p (size: 0x%x) in %lu ms\n",
> +	       argv[3], addr, info.size * info.blksz, time_end - time_start);

This causes warnings on -next when building sandbox:
$ make sandbox_defconfig
$ make

cmd/abootimg.c:339:65: warning: format =E2=80=98%x=E2=80=99 expects argumen=
t of type =E2=80=98unsigned int=E2=80=99, but argument 4 has type =E2=80=98=
long unsigned int=E2=80=99 [-Wformat=3D]
  339 |         printf("Loaded '%s' partition to address 0x%p (size: 0x%x) =
in %lu ms\n",
      |                                                                ~^
      |                                                                 |
      |                                                                 uns=
igned int
      |                                                                %lx
  340 |                argv[3], addr, info.size * info.blksz, time_end - ti=
me_start);
      |                               ~~~~~~~~~~~~~~~~~~~~~~
      |                                         |


> +
> +	return CMD_RET_SUCCESS;
> +
> +fail:
> +	free(addr);
> +	return CMD_RET_FAILURE;
> +}
> +
>  static struct cmd_tbl cmd_abootimg_sub[] =3D {
>  	U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
>  	U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
>  	U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
> +	U_BOOT_CMD_MKENT(load, 5, 1, do_abootimg_load, "", ""),
>  };
>=20=20
>  static int do_abootimg(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -305,5 +378,14 @@ U_BOOT_CMD(
>  	"    - get address and size (hex) of DT blob in the image by index\n"
>  	"      <num>: index number of desired DT blob in DTB area\n"
>  	"      [addr_var]: variable name to contain DT blob address\n"
> -	"      [size_var]: variable name to contain DT blob size"
> +	"      [size_var]: variable name to contain DT blob size\n"
> +	"abootimg load interface dev partition [slot_name]\n"
> +	"    - load boot image from device partition\n"
> +	"      memory is allocated in heap\n"
> +	"      address is stored in $abootimg_<partition>_ptr\n"
> +	"      size is stored in $abootimg_<partition>_size\n"
> +	"      interface: interface type (e.g. mmc, usb)\n"
> +	"      dev: device number (e.g. 0, 1)\n"
> +	"      partition: partition number (e.g. boot, dtb)\n"

"partition name" instead of "partition number"?

> +	"      slot_suffix: slot name (e.g. a, b)"
>  );
> --=20
> 2.40.1
