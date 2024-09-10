Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C894CEDE996
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 02:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B78E88EC1;
	Tue, 10 Sep 2024 04:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qsT4wVvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9CA988EEB; Tue, 10 Sep 2024 04:50:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C699188EBC
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 04:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1725936595; x=1726541395; i=xypron.glpk@gmx.de;
 bh=bCgSgeP61lcaxJTl4qS9/vU2YnbhJg9gK66bIi5CiRo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qsT4wVvvQ5/yWrFKBx+gIFdyV7mTS3sA6bJxgy1UZW6taBJs06wRkbw209IyxpKK
 8xPXM7+1z4QA88tctebOQaK3vk8jeMI+qNxWGnuwvvfd+ACtnEhit5XknuOuaK0Pa
 DxwQyywiVY21fJcB4oxIPItr4W7tivJphUvJFPCMB8WWCU9gf+qfgv8wkMYPfqSmJ
 aqWE0pPOgZ7ypViwbGhEBwokFEViaDcQ20pY7cVt3LPBFZiNMwMxEXDceM9hWIesG
 uf5UyFvVIYF4Ef7d6MybXnPzr9yiXyWgQS4oMKzvWd+Z9L12EGDjxYGnUvVRhzonZ
 tUNMtT9kuvgYfku3Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.160.200]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1sO4CK3aBy-00VsUD; Tue, 10
 Sep 2024 04:49:55 +0200
Message-ID: <31fa6144-236b-466c-ad19-4a00b24d7654@gmx.de>
Date: Tue, 10 Sep 2024 04:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 2/3] cmd: mtd: add torture command support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20240909222113.2562703-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222113.2562703-3-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240909222113.2562703-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eIgsQwAPa2PhJZQTf1i3RP1yij913s7TfFLz7z1ZEI+2GzxIxau
 AgcNSHRRn4VYwcBMB4E5iLFrlLZiUohtXRPvQz86YngjfNedV4W4X0gBeShXvXjAfsyoUKc
 0q/zr7ruROmOJ5GSZ0MLV8x8dnDy03gTkLcyRSYndpEwijl/fTJRGHaQKpFqxZeGb7eD2TI
 NQ3nAGKKTIV6YF0mOo91w==
UI-OutboundReport: notjunk:1;M01:P0:eo0/tJb9MZI=;50FShauTkvMdP1BquQI7pFTvx31
 PrF+qeQrtDsGXuqxvENIoiIOPxE0nEcNTc5dmt8Xlv8v+JIb8Ux7AgWk8gNs0SXxzLQSJxM15
 aCumz8lAyoG6h94skMVfzgvkfWcPJIPTyfCTHY8f3ESqdI/qm6HWrO47Dst3FarV6odMp/lFZ
 lem94qqM5dh5/N+auglR81XFyUFHnXoEu1HjwWFWyZiM2QSKbLwkc3XTgmChTdfRpX6AJRIT4
 hxmlPA0qzOy67/ZPvhb5mwfq0ZgJELnljdIZSKozDTIG7i+1msiPY8/jP+L/h7pygViYl4Rv1
 2odFQEdS4IGwwtoW1+tiYrJMa28KcwbuOYZWlNcnSpuB/hOFSLDGCUTSnEcTihe++v2zOjXcH
 Hgv9fDY+G+HGpAvZCb+Heddvi4TQrChvM3BfAChQja1jpMHhSHVjeYmAxYWguuvpXag8c//Sr
 CGCWtoEdr+Lt6elsTpZhbjZ3yxVxb/p1GMouIgWq67h3GdJjnwYmVZ9OkC2Uyv0lGIJbhfeuT
 gCCBla+hNjSDtos51Vm6Sr0agtUyvtx+A4SSELbYIQflMbTQ9OExh/8BMlvdfWQWgMA4rrqct
 6B2PtFPBDQtlW+ov7lM1q2Tm5BM0AgpnmVKOMLELjhW7aZUYr47hQiZLm9tkcaw4eEIAm4OUu
 79s69pql8/1RpgXB3ST1tm7cHvkVE9eZKWzKfh8+7V04B3XTNGYCVc8hqNG1HAgL/tH8wbbud
 AvTgz36bKv7Db3BLyLXFphjgeVKQ3cMWt+v76QChsTMbmk6GHRDno9uncU59mZP2C4aG+dsm7
 Ve1WugxI/533pGVxHiABnwJw==
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

On 9/10/24 00:21, Mikhail Kshevetskiy wrote:
> Some nand flashes (like spi-nand one) are registered with mtd
> subsystem only, thus nand command can't be used to work with
> such flashes. As result some functionality is missing.
>
> This patch implements 'nand torture' functionality for mtd command.

Can we call this 'nand writetest' and the test in patch 3/3 'nand readtest=
'?

When I read 'torture' I thought of a test running until the NAND flash
is worn out.

Please, provide a man-page for the command in doc/usage/cmd/nand.rst

Best regards

Heinrich

>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   cmd/Kconfig |   6 ++
>   cmd/mtd.c   | 196 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 202 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 53ebafcb610..698e0e697f2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1439,6 +1439,12 @@ config CMD_MTD_MARKBAD
>   	help
>   	  MTD markbad command support.
>
> +config CMD_MTD_TORTURE
> +	bool "mtd torture"
> +	depends on CMD_MTD
> +	help
> +	  MTD torture command support.
> +
>   config CMD_MUX
>   	bool "mux"
>   	depends on MULTIPLEXER
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 45084d39d3a..69ddfe1d9c6 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -18,6 +18,7 @@
>   #include <mtd.h>
>   #include <dm/devres.h>
>   #include <linux/err.h>
> +#include <memalign.h>
>
>   #include <linux/ctype.h>
>
> @@ -742,6 +743,194 @@ out_put_mtd:
>   }
>   #endif
>
> +#ifdef CONFIG_CMD_MTD_TORTURE
> +/**
> + * nand_check_pattern:
> + *
> + * Check if buffer contains only a certain byte pattern.
> + *
> + * @param buf buffer to check
> + * @param patt the pattern to check
> + * @param size buffer size in bytes
> + * Return: 1 if there are only patt bytes in buf
> + *         0 if something else was found
> + */
> +static int nand_check_pattern(const u_char *buf, u_char patt, int size)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < size; i++)
> +		if (buf[i] !=3D patt)
> +			return 0;
> +	return 1;
> +}
> +
> +/**
> + * nand_torture:
> + *
> + * Torture a block of NAND flash.
> + * This is useful to determine if a block that caused a write error is =
still
> + * good or should be marked as bad.
> + *
> + * @param mtd nand mtd instance
> + * @param offset offset in flash
> + * Return: 0 if the block is still good
> + */
> +static int nand_torture(struct mtd_info *mtd, loff_t offset)
> +{
> +	u_char patterns[] =3D {0xa5, 0x5a, 0x00};
> +	struct erase_info instr =3D {
> +		.mtd =3D mtd,
> +		.addr =3D offset,
> +		.len =3D mtd->erasesize,
> +	};
> +	size_t retlen;
> +	int err, ret =3D -1, i, patt_count;
> +	u_char *buf;
> +
> +	if ((offset & (mtd->erasesize - 1)) !=3D 0) {
> +		puts("Attempt to torture a block at a non block-aligned offset\n");
> +		return -EINVAL;
> +	}
> +
> +	if (offset + mtd->erasesize > mtd->size) {
> +		puts("Attempt to torture a block outside the flash area\n");
> +		return -EINVAL;
> +	}
> +
> +	patt_count =3D ARRAY_SIZE(patterns);
> +
> +	buf =3D malloc_cache_aligned(mtd->erasesize);
> +	if (buf =3D=3D NULL) {
> +		puts("Out of memory for erase block buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < patt_count; i++) {
> +		err =3D mtd_erase(mtd, &instr);
> +		if (err) {
> +			printf("%s: erase() failed for block at 0x%llx: %d\n",
> +			       mtd->name, instr.addr, err);
> +			goto out;
> +		}
> +
> +		/* Make sure the block contains only 0xff bytes */
> +		err =3D mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
> +		if ((err && err !=3D -EUCLEAN) || retlen !=3D mtd->erasesize) {
> +			printf("%s: read() failed for block at 0x%llx: %d\n",
> +			       mtd->name, instr.addr, err);
> +			goto out;
> +		}
> +
> +		err =3D nand_check_pattern(buf, 0xff, mtd->erasesize);
> +		if (!err) {
> +			printf("Erased block at 0x%llx, but a non-0xff byte was found\n",
> +			       offset);
> +			ret =3D -EIO;
> +			goto out;
> +		}
> +
> +		/* Write a pattern and check it */
> +		memset(buf, patterns[i], mtd->erasesize);
> +		err =3D mtd_write(mtd, offset, mtd->erasesize, &retlen, buf);
> +		if (err || retlen !=3D mtd->erasesize) {
> +			printf("%s: write() failed for block at 0x%llx: %d\n",
> +			       mtd->name, instr.addr, err);
> +			goto out;
> +		}
> +
> +		err =3D mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
> +		if ((err && err !=3D -EUCLEAN) || retlen !=3D mtd->erasesize) {
> +			printf("%s: read() failed for block at 0x%llx: %d\n",
> +			       mtd->name, instr.addr, err);
> +			goto out;
> +		}
> +
> +		err =3D nand_check_pattern(buf, patterns[i], mtd->erasesize);
> +		if (!err) {
> +			printf("Pattern 0x%.2x checking failed for block at "
> +			       "0x%llx\n", patterns[i], offset);
> +			ret =3D -EIO;
> +			goto out;
> +		}
> +	}
> +
> +	ret =3D 0;
> +
> +out:
> +	free(buf);
> +	return ret;
> +}
> +
> +static int do_mtd_torture(struct cmd_tbl *cmdtp, int flag, int argc,
> +			  char *const argv[])
> +{
> +	struct mtd_info *mtd;
> +	loff_t off, len;
> +	int ret =3D 0;
> +	unsigned int failed =3D 0, passed =3D 0;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	mtd =3D get_mtd_by_name(argv[1]);
> +	if (IS_ERR_OR_NULL(mtd))
> +		return CMD_RET_FAILURE;
> +
> +	if (!mtd_can_have_bb(mtd)) {
> +		printf("Only NAND-based devices can be tortured\n");
> +		goto out_put_mtd;
> +	}
> +
> +	argc -=3D 2;
> +	argv +=3D 2;
> +
> +	off =3D argc > 0 ? hextoul(argv[0], NULL) : 0;
> +	len =3D argc > 1 ? hextoul(argv[1], NULL) : mtd->size;
> +
> +	if (!mtd_is_aligned_with_block_size(mtd, off)) {
> +		printf("Offset not aligned with a block (0x%x)\n",
> +		       mtd->erasesize);
> +		ret =3D CMD_RET_FAILURE;
> +		goto out_put_mtd;
> +	}
> +
> +	if (!mtd_is_aligned_with_block_size(mtd, len)) {
> +		printf("Size not a multiple of a block (0x%x)\n",
> +		       mtd->erasesize);
> +		ret =3D CMD_RET_FAILURE;
> +		goto out_put_mtd;
> +	}
> +
> +	printf("\nNAND torture: device '%s' offset 0x%llx size 0x%llx (block s=
ize 0x%x)\n",
> +	       mtd->name, off, len, mtd->erasesize);
> +	while (len > 0) {
> +		printf("\r  block at %llx ", off);
> +		if (mtd_block_isbad(mtd, off)) {
> +			printf("marked bad, skipping\n");
> +		} else {
> +			ret =3D nand_torture(mtd, off);
> +			if (ret) {
> +				failed++;
> +				printf("failed\n");
> +			} else {
> +				passed++;
> +			}
> +		}
> +		off +=3D mtd->erasesize;
> +		len -=3D mtd->erasesize;
> +	}
> +	printf("\n Passed: %u, failed: %u\n", passed, failed);
> +	if (failed !=3D 0)
> +		ret =3D CMD_RET_FAILURE;
> +
> +out_put_mtd:
> +	put_mtd_device(mtd);
> +
> +	return ret;
> +}
> +#endif
> +
>   static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
>   		      char *const argv[])
>   {
> @@ -827,6 +1016,9 @@ U_BOOT_LONGHELP(mtd,
>   #endif
>   #ifdef CONFIG_CMD_MTD_MARKBAD
>   	"mtd markbad                           <name>         <off> [<off> ..=
.]\n"
> +#endif
> +#ifdef CONFIG_CMD_MTD_TORTURE
> +	"mtd torture                           <name>        [<off> [<size>]]\=
n"
>   #endif
>   	"\n"
>   	"With:\n"
> @@ -864,6 +1056,10 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help=
_text,
>   #ifdef CONFIG_CMD_MTD_MARKBAD
>   		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
>   					     mtd_name_complete),
> +#endif
> +#ifdef CONFIG_CMD_MTD_TORTURE
> +		U_BOOT_SUBCMD_MKENT_COMPLETE(torture, 4, 0, do_mtd_torture,
> +					     mtd_name_complete),
>   #endif
>   		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
>   					     mtd_name_complete));

