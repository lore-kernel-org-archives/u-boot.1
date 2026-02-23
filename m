Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A1DE98E13
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 10:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50EA83BC9;
	Mon, 23 Feb 2026 11:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FeoCU/lP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B27683C6E; Mon, 23 Feb 2026 11:34:14 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E23D83935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 11:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A5F591A116B;
 Mon, 23 Feb 2026 10:34:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 74D1A5FD43;
 Mon, 23 Feb 2026 10:34:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4AACC10368F35; Mon, 23 Feb 2026 11:34:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771842850; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=0Zg1nXuA38v3KPKWz8snQfu7La/j1YQtHCjjJEZOISs=;
 b=FeoCU/lPPtwiN7X4AAY7Xn/u2b3jvM0zhN4bRAfkL4ayvCjTS5egvEgSwSjZl7IIGFhGAt
 Ur9Gzg7VIKjJqaLxzjwVKfD8rIYlka1hlyNwMHa4jtIrRwUahek2UXh5pSrklnopXggWql
 hIG9XgwC7y5sXKbBlwE3ZGDrphBlbhu05s4XRWdgBqYeG9YZ7Xx+h7pz27wjXZo4fJ3E66
 KJtCglyR2MXTWFVztYgn8WbFTdrlIrN2aoYzer4nnNjs5ECzSQbjs2r6yGu9b+DEtTq2Q6
 5pnUw9AIKq24idvxZ+QWeRaTztbnXf55Mf3SegYQuNVpQbpIA4Oiqv30lKRQWg==
Date: Mon, 23 Feb 2026 11:34:04 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: <u-boot@lists.denx.de>, <michal.simek@amd.com>, <git@amd.com>, John
 Toomey <john.toomey@amd.com>, Tom Rini <trini@konsulko.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Quentin Schulz <quentin.schulz@cherry.de>, Mikhail
 Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Heiko Schocher
 <hs@nabladev.com>, "Andrew Goodbody" <andrew.goodbody@linaro.org>, Paul
 Barker <paul.barker.ct@bp.renesas.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [RFC PATCH v2] cmd: part: add dupcheck command to detect
 duplicate PARTUUIDs
Message-ID: <20260223113404.68807c64@kmaincent-XPS-13-7390>
In-Reply-To: <20260222070957.2756719-1-padmarao.begari@amd.com>
References: <20260222070957.2756719-1-padmarao.begari@amd.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Sun, 22 Feb 2026 12:37:39 +0530
Padmarao Begari <padmarao.begari@amd.com> wrote:

> Add a 'part dupcheck' subcommand that scans all block devices for
> duplicate partition UUIDs. This helps detect situations where the
> same disk image has been flashed to multiple boot devices (e.g.,
> USB stick and UFS), which can lead to unpredictable boot behavior
> when using PARTUUID-based root filesystem specifications. It
> iterates all block devices using blk_foreach_probe() and checks
> partition UUIDs via part_get_info().
>=20
> When duplicates are found, a warning is printed for each occurrence:
>=20
> Warning: duplicate PARTUUID 20c5fba5-0171-457f-b9cd-f5129cd07228
>   first seen on usb_mass_storage.lun0:3
>   also on ufs_scsi.id0lun0:3
>=20
> Add Kconfig option `CMD_PART_DUPCHECK` and update the `part` help
> text accordingly.

It would be nice to also check the partition label, which is also used some=
times
in the boot process.

> Signed-off-by: John Toomey <john.toomey@amd.com>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
> Changes in v2:
> -Add own kconfig symbol for dupcheck subcommand and guard it.
> ---
>  cmd/Kconfig |   7 ++++
>  cmd/part.c  | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 110 insertions(+), 1 deletion(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 322ebe600c5..73d27fe2e28 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1663,6 +1663,13 @@ config CMD_PART
>  	  Read and display information about the partition table on
>  	  various media.
> =20
> +config CMD_PART_DUPCHECK
> +	bool "part dupcheck"
> +	depends on CMD_PART
> +	help
> +	  Enable the 'part dupcheck' sub-command under 'part' to scan the
> +	  current partition table and report any duplicate partition UUIDs.
> +
>  config CMD_PCI
>  	bool "pci - Access PCI devices"
>  	help
> diff --git a/cmd/part.c b/cmd/part.c
> index 975a0a08a99..c4df5053936 100644
> --- a/cmd/part.c
> +++ b/cmd/part.c
> @@ -15,9 +15,12 @@
>   * Pavel Bartusek <pba@sysgo.com>
>   */
> =20
> +#include <blk.h>
>  #include <config.h>
>  #include <command.h>
> +#include <dm.h>
>  #include <env.h>
> +#include <malloc.h>
>  #include <part.h>
>  #include <stdio.h>
>  #include <vsprintf.h>
> @@ -246,6 +249,97 @@ static int do_part_type(int argc, char *const argv[])
>  }
>  #endif
> =20
> +#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
> +struct part_seen {
> +	char uuid[UUID_STR_LEN + 1];
> +	struct udevice *dev;
> +	int part;
> +};
> +
> +static int do_part_dupcheck(int argc, char *const argv[])
> +{
> +	struct part_seen *seen;
> +	int count =3D 0;
> +	int duplicates =3D 0;
> +	int max_entries;
> +	int dev_count;
> +	struct udevice *dev;
> +
> +	if (argc)
> +		return CMD_RET_USAGE;
> +
> +	dev_count =3D blk_count_devices(BLKF_BOTH);
> +	if (!dev_count) {
> +		printf("No block devices found\n");
> +		return CMD_RET_SUCCESS;
> +	}
> +
> +	max_entries =3D dev_count * MAX_SEARCH_PARTITIONS;
> +	seen =3D calloc(max_entries, sizeof(*seen));
> +	if (!seen) {
> +		printf("Unable to allocate dupcheck table (%d entries)\n",
> +		       max_entries);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	blk_foreach_probe(BLKF_BOTH, dev) {
> +		struct blk_desc *desc =3D dev_get_uclass_plat(dev);
> +
> +		for (int part =3D 1; part <=3D MAX_SEARCH_PARTITIONS; part++) {
> +			struct disk_partition info;
> +			int first_match =3D -1;
> +
> +			if (part_get_info(desc, part, &info))
> +				continue;
> +			if (!info.uuid[0])
> +				continue;
> +
> +			for (int i =3D 0; i < count; i++) {
> +				if (strcmp(seen[i].uuid, info.uuid))
> +					continue;
> +				if (first_match =3D=3D -1) {
> +					printf("Warning: duplicate PARTUUID
> %s\n",
> +					       info.uuid);
> +					printf("  first seen on %s:%d\n",
> +					       seen[i].dev->name,
> +					       seen[i].part);
> +					printf("  also on %s:%d\n",
> +					       dev->name, part);
> +					duplicates++;
> +					first_match =3D i;
> +				} else {
> +					printf("  also on %s:%d\n",
> +					       seen[i].dev->name,
> +					       seen[i].part);
> +				}
> +			}

If you have 3 partitions (A,B,C) with the same uuid you will report the
information twice:
When processing B: "Warning ... first seen on A:x / also on B:x"
When processing C: "Warning ... first seen on A:x / also on C:x / also on B=
:x"

Also this means the duplicates variable will be incremented to 2 which is
confusing for the print in my last comment:

> +
> +			if (count >=3D max_entries) {
> +				printf("Error: dupcheck capacity %d
> entries\n",
> +				       max_entries);
> +				printf("       exceeded\n");

Weird print here:
Maybe something like that: "Error: dupcheck capacity exceeded (%d entries)"

> +				free(seen);
> +				return CMD_RET_FAILURE;
> +			}
> +
> +			strlcpy(seen[count].uuid, info.uuid,
> +				sizeof(seen[0].uuid));
> +			seen[count].dev =3D dev;
> +			seen[count].part =3D part;
> +			count++;
> +		}
> +	}
> +
> +	if (duplicates)
> +		printf("Found %d duplicate(s) among %d partitions checked\n",
> +		       duplicates, count);

So with 3 partitions using the same uuid, it will report
"Found 2 duplicate(s) ..."

Which can be confusing. We should report either "1 UUID duplication" or "3
copies of the same UUID"=20

> +
> +	free(seen);
> +
> +	return duplicates ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
> +}
> +#endif
> +
>  static int do_part_types(int argc, char * const argv[])
>  {
>  	struct part_driver *drv =3D ll_entry_start(struct part_driver,
> @@ -291,6 +385,10 @@ static int do_part(struct cmd_tbl *cmdtp, int flag, =
int
> argc, #ifdef CONFIG_PARTITION_TYPE_GUID
>  	else if (!strcmp(argv[1], "type"))
>  		return do_part_type(argc - 2, argv + 2);
> +#endif
> +#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
> +	else if (!strcmp(argv[1], "dupcheck"))
> +		return do_part_dupcheck(argc - 2, argv + 2);
>  #endif
>  	return CMD_RET_USAGE;
>  }
> @@ -328,5 +426,9 @@ U_BOOT_CMD(
>  	"part set <interface> <dev> type\n"
>  	"    - set partition type for a device\n"
>  	"part types\n"
> -	"    - list supported partition table types"
> +	"    - list supported partition table types\n"
> +#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
> +	"part dupcheck\n"
> +	"    - scan all block devices for duplicate partition UUIDs"
> +#endif
>  );



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
