Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094EAD65553
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 20:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6514789760;
	Tue, 26 Nov 2024 21:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UazkghOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8095989723; Tue, 26 Nov 2024 21:20:13 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE4789760
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 21:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7252fba4de1so190459b3a.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1732652409; x=1733257209;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RO6ZQ8p+aGjLTdpIvDGVzX9mpJ+DnZKhIU1WIzFh4cE=;
 b=UazkghOMZTU37hNjr+jA6jvNYDjyhXnaC59nmiPIGhBNK1D4S5aMUN+SLJ9qU4qHon
 3/m8upQQux9QOlN0/b76xkzG5OdriEnlNyIYIZx2z+I23beFK6zoVaRxsn3/s5Cb0rqo
 VHkFYSN0YDtZuzokYbrr6fqkUx1I76vz7GYJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732652409; x=1733257209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RO6ZQ8p+aGjLTdpIvDGVzX9mpJ+DnZKhIU1WIzFh4cE=;
 b=CXfXmvvVLgXuGxsE2HDqNPbFv/TJtw2ZHz6+5YHd0fNhMrkLGUH77M8mRBWDtSu9hq
 xFp4cLKumqOaIhW+1jAzRvz4PaNlQHbrlJouDoXUtO0KtCntnGqZES8tJevmKod9Jmyy
 EDBhRg2BMG2NRIxdoiwQsyBdXldxl77g2HcwMGrzngR8tdcHXEvLPhkKnum4iDUva09o
 u04Tu48I4hcSi0DSWnt8Xvnw+SUpWtl+2efBQS9ceK9NbVdwv0uH1qCNCjak7KWKf8CM
 bUBfcqgH2ZStwNxolDhE/JHEprAwNpUPIOBhqKQlh2gZfpiDkf/8IIV3nF++7BgRoQUL
 4mrQ==
X-Gm-Message-State: AOJu0YxCiax8DlxJDT1UydEhixs/vdCUJib6x2OTbbSkZrdGK81V2fXG
 +IaU5gsu0YwYV4OBGmDgjW0Jnix1dKuJiI/cQak/zo3lbByNLjnaKxmx841aFjp1SZj33QB6eLZ
 cNpKtZU9XEVniHj0grYJUHFsVGEJnm9fMXNBxWsphRkrWvX97iec=
X-Gm-Gg: ASbGnctNtVVsfYMduxPEgxOPf86xRfwPDkdvPpUsXmktOMHm1RwqbrLOrbe0p7zR1XP
 1B1z/aw9Unyjboq+q5/2p8+DuuLfe
X-Google-Smtp-Source: AGHT+IHc0gJ9fO6ZQciOmQdck/IRPNfdJTsFFsT7elCPnlJ8H6y/pd8Bu2ubRD2+XupwILEN2t3HooSbMGPaXdKEQCg=
X-Received: by 2002:a17:90b:3947:b0:2ea:9309:75b3 with SMTP id
 98e67ed59e1d1-2ee08e9d29amr775514a91.2.1732652409162; Tue, 26 Nov 2024
 12:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20231128105611.488906-1-miquel.raynal@bootlin.com>
In-Reply-To: <20231128105611.488906-1-miquel.raynal@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 26 Nov 2024 21:19:58 +0100
Message-ID: <CAOf5uwnP4O1cop9_CcBYN0YauvQQ_A0cuhno+PDOQzr2=h=UaQ@mail.gmail.com>
Subject: Re: [PATCH] nand: Add a watch command
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

Hi Miquel

On Tue, Nov 28, 2023 at 11:56=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> This is a debug command to monitor the retention state of the data on
> the array. The command needs a duplication of the mtd_read_oob()
> function to actually return the maximum number of bitflips encountered
> while reading the page. We could write a specific implementation for the
> Sunxi driver but this is probably enough.
>
>     nand watch <off> <size> - check an area for bitflips
>     nand watch.part <part> - check a partition for bitflips
>     nand watch.chip - check the whole device for bitflips
>
> The output may be a bit verbose and could look like:
>

I have rebased and I will take a look on this patch tomorrow. I think havin=
g it
is ok.

Michael

>     =3D> nand watch.chip
>     device 0 whole chip
>     size adjusted to 0xff60000 (5 bad blocks)
>
>     NAND watch for bitflips in area 0x0-0xff60000:
>     Page       0 (0x00000000) -> error -74
>     Page       1 (0x00000800) -> error -74
>     Page       2 (0x00001000) -> error -74
>     Page       3 (0x00001800) -> error -74
>     Page       4 (0x00002000) -> error -74
>     Page       5 (0x00002800) -> error -74
>     Page       6 (0x00003000) -> error -74
>     Page       7 (0x00003800) -> error -74
>     Page       8 (0x00004000) -> error -74
>     Page       9 (0x00004800) -> error -74
>     Page      10 (0x00005000) -> error -74
>     Page      11 (0x00005800) -> error -74
>     Page      12 (0x00006000) -> error -74
>     Page      13 (0x00006800) -> error -74
>     Page      14 (0x00007000) -> error -74
>     Page      15 (0x00007800) -> error -74
>     Page      16 (0x00008000) -> error -74
>     Page      17 (0x00008800) -> error -74
>     Page      18 (0x00009000) -> error -74
>     Page      19 (0x00009800) -> error -74
>     Page      20 (0x0000a000) -> error -74
>     Page      21 (0x0000a800) -> error -74
>     Page      22 (0x0000b000) -> error -74
>     Page      23 (0x0000b800) -> error -74
>     Page    1110 (0x0022b000) -> up to  1 bf/chunk
>     Page    1122 (0x00231000) -> up to  1 bf/chunk
>     Page    1132 (0x00236000) -> up to  1 bf/chunk
>     Page    1362 (0x002a9000) -> up to  1 bf/chunk
>     Page    4990 (0x009bf000) -> up to  1 bf/chunk
>     Page    5728 (0x00b30000) -> up to  1 bf/chunk
>     Page    7116 (0x00de6000) -> up to  1 bf/chunk
>     Page    7160 (0x00dfc000) -> up to  1 bf/chunk
>     Page    7494 (0x00ea3000) -> up to  1 bf/chunk
>     Page   10842 (0x0152d000) -> up to  1 bf/chunk
>     Page   11614 (0x016af000) -> up to  1 bf/chunk
>     Page   11970 (0x01761000) -> up to  1 bf/chunk
>     Page   12536 (0x0187c000) -> up to  1 bf/chunk
>     Page   12687 (0x018c7800) -> up to  1 bf/chunk
>     Page   14298 (0x01bed000) -> up to  1 bf/chunk
>     Page   18268 (0x023ae000) -> up to  1 bf/chunk
>     Page   18760 (0x024a4000) -> up to  1 bf/chunk
>     Page   21440 (0x029e0000) -> up to  1 bf/chunk
>     Page   22336 (0x02ba0000) -> up to  1 bf/chunk
>     Page   22592 (0x02c20000) -> up to  1 bf/chunk
>     Page   23872 (0x02ea0000) -> up to  1 bf/chunk
>     Page   27584 (0x035e0000) -> up to  1 bf/chunk
>     Page   35008 (0x04460000) -> up to  1 bf/chunk
>     Page   37184 (0x048a0000) -> up to  1 bf/chunk
>     Page   41728 (0x05180000) -> up to  1 bf/chunk
>     Page   42176 (0x05260000) -> up to  1 bf/chunk
>     Page   43200 (0x05460000) -> up to  1 bf/chunk
>     Page   43328 (0x054a0000) -> up to  1 bf/chunk
>     Page   45376 (0x058a0000) -> up to  1 bf/chunk
>     Page   47040 (0x05be0000) -> up to  1 bf/chunk
>     Page   47552 (0x05ce0000) -> up to  1 bf/chunk
>     Page   49344 (0x06060000) -> up to  1 bf/chunk
>     Page   49856 (0x06160000) -> up to  1 bf/chunk
>     Page   62784 (0x07aa0000) -> up to  1 bf/chunk
>     Page   65153 (0x07f40800) -> up to  1 bf/chunk
>     Page   65228 (0x07f66000) -> up to  1 bf/chunk
>     Page   65382 (0x07fb3000) -> up to  1 bf/chunk
>     Page   98624 (0x0c0a0000) -> up to  1 bf/chunk
>     Page  101952 (0x0c720000) -> up to  1 bf/chunk
>     Page  107584 (0x0d220000) -> up to  1 bf/chunk
>     Page  118208 (0x0e6e0000) -> up to  1 bf/chunk
>     Page  126656 (0x0f760000) -> up to  1 bf/chunk
>     Page  127680 (0x0f960000) -> up to  1 bf/chunk
>     Page  129920 (0x0fdc0000) -> up to  1 bf/chunk
>     Maximum number of bitflips: 1
>     Pages with bitflips: 44/130752
>
> It is also possible to reduce the output with the .quiet suffix in order
> to just show the summary.
>
>     =3D> nand watch.chip
>     device 0 whole chip
>     size adjusted to 0xff60000 (5 bad blocks)
>
>     NAND watch for bitflips in area 0x0-0xff60000:
>     Maximum number of bitflips: 1
>     Pages with bitflips: 44/130752
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>
> Hello, I recently came across a batch of NANDs with a lot of "natural"
> bitflips so in order to easily and objectively characterize how
> unstable these parts were, I wrote this little tool which was pretty
> handy to have in U-Boot. I believe it can be useful for others as well,
> so here is the patch.
> Cheers, Miqu=C3=A8l
>
>  cmd/Kconfig             |   5 ++
>  cmd/nand.c              | 103 ++++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/mtdcore.c   |  22 +++++++++
>  include/linux/mtd/mtd.h |   1 +
>  4 files changed, 131 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 451baa3ecac..0524328d373 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1384,6 +1384,11 @@ config CMD_NAND_TORTURE
>         help
>           NAND torture support.
>
> +config CMD_NAND_WATCH
> +       bool "nand watch"
> +       help
> +         NAND watch bitflip support.
> +
>  endif # CMD_NAND
>
>  config CMD_NVME
> diff --git a/cmd/nand.c b/cmd/nand.c
> index 71b8f964429..3bf67f5b65e 100644
> --- a/cmd/nand.c
> +++ b/cmd/nand.c
> @@ -231,6 +231,54 @@ free_dat:
>         return ret;
>  }
>
> +#ifdef CONFIG_CMD_NAND_WATCH
> +static int nand_watch_bf(struct mtd_info *mtd, ulong off, ulong size, bo=
ol quiet)
> +{
> +       unsigned int max_bf =3D 0, pages_wbf =3D 0;
> +       unsigned int first_page, pages, i;
> +       struct mtd_oob_ops ops =3D {};
> +       u_char *buf;
> +       int ret;
> +
> +       buf =3D memalign(ARCH_DMA_MINALIGN, mtd->writesize);
> +       if (!buf) {
> +               puts("No memory for page buffer\n");
> +               return 1;
> +       }
> +
> +       first_page =3D off / mtd->writesize;
> +       pages =3D size / mtd->writesize;
> +
> +       ops.datbuf =3D buf;
> +       ops.len =3D mtd->writesize;
> +       for (i =3D first_page; i < first_page + pages; i++) {
> +               ulong addr =3D mtd->writesize * i;
> +               ret =3D mtd_read_oob_bf(mtd, addr, &ops);
> +               if (ret < 0) {
> +                       if (quiet)
> +                               continue;
> +
> +                       printf("Page %7d (0x%08lx) -> error %d\n",
> +                              i, addr, ret);
> +               } else if (ret) {
> +                       max_bf =3D max(max_bf, (unsigned int)ret);
> +                       pages_wbf++;
> +                       if (quiet)
> +                               continue;
> +                       printf("Page %7d (0x%08lx) -> up to %2d bf/chunk\=
n",
> +                              i, addr, ret);
> +               }
> +       }
> +
> +       printf("Maximum number of bitflips: %u\n", max_bf);
> +       printf("Pages with bitflips: %u/%u\n", pages_wbf, pages);
> +
> +       free(buf);
> +
> +       return 0;
> +}
> +#endif
> +
>  /* ---------------------------------------------------------------------=
---- */
>
>  static int set_dev(int dev)
> @@ -778,6 +826,55 @@ static int do_nand(struct cmd_tbl *cmdtp, int flag, =
int argc,
>                 return ret =3D=3D 0 ? 0 : 1;
>         }
>
> +#ifdef CONFIG_CMD_NAND_WATCH
> +       if (strncmp(cmd, "watch", 5) =3D=3D 0) {
> +               int args =3D 2;
> +
> +               if (cmd[5]) {
> +                       if (!strncmp(&cmd[5], ".part", 5)) {
> +                               args =3D 1;
> +                       } else if (!strncmp(&cmd[5], ".chip", 5)) {
> +                               args =3D 0;
> +                       } else {
> +                               goto usage;
> +                       }
> +               }
> +
> +               if (cmd[10])
> +                       if (!strncmp(&cmd[10], ".quiet", 6))
> +                               quiet =3D true;
> +
> +               if (argc !=3D 2 + args)
> +                       goto usage;
> +
> +               ret =3D mtd_arg_off_size(argc - 2, argv + 2, &dev, &off, =
&size,
> +                                      &maxsize, MTD_DEV_TYPE_NAND, mtd->=
size);
> +               if (ret)
> +                       return ret;
> +
> +               /* size is unspecified */
> +               if (argc < 4)
> +                       adjust_size_for_badblocks(&size, off, dev);
> +
> +               if ((off & (mtd->writesize - 1)) ||
> +                   (size & (mtd->writesize - 1))) {
> +                       printf("Attempt to read non page-aligned data\n")=
;
> +                       return -EINVAL;
> +               }
> +
> +               ret =3D set_dev(dev);
> +               if (ret)
> +                       return ret;
> +
> +               mtd =3D get_nand_dev_by_index(dev);
> +
> +               printf("\nNAND watch for bitflips in area 0x%llx-0x%llx:\=
n",
> +                      off, off + size);
> +
> +               return nand_watch_bf(mtd, off, size, quiet);
> +       }
> +#endif
> +
>  #ifdef CONFIG_CMD_NAND_TORTURE
>         if (strcmp(cmd, "torture") =3D=3D 0) {
>                 loff_t endoff;
> @@ -943,6 +1040,12 @@ U_BOOT_LONGHELP(nand,
>         "nand erase.chip [clean] - erase entire chip'\n"
>         "nand bad - show bad blocks\n"
>         "nand dump[.oob] off - dump page\n"
> +#ifdef CONFIG_CMD_NAND_WATCH
> +       "nand watch <off> <size> - check an area for bitflips\n"
> +       "nand watch.part <part> - check a partition for bitflips\n"
> +       "nand watch.chip - check the whole device for bitflips\n"
> +       "\t\t.quiet - Query only the summary, not the details\n"
> +#endif
>  #ifdef CONFIG_CMD_NAND_TORTURE
>         "nand torture off - torture one block at offset\n"
>         "nand torture off [size] - torture blocks from off to off+size\n"
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index aa78d41a55e..2baf92a9056 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1126,6 +1126,28 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from=
, struct mtd_oob_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(mtd_read_oob);
>
> +/* This is a bare copy of mtd_read_oob returning the actual number of bi=
tflips */
> +int mtd_read_oob_bf(struct mtd_info *mtd, loff_t from, struct mtd_oob_op=
s *ops)
> +{
> +       int ret_code;
> +       ops->retlen =3D ops->oobretlen =3D 0;
> +       if (!mtd->_read_oob)
> +               return -EOPNOTSUPP;
> +       /*
> +        * In cases where ops->datbuf !=3D NULL, mtd->_read_oob() has sem=
antics
> +        * similar to mtd->_read(), returning a non-negative integer
> +        * representing max bitflips. In other cases, mtd->_read_oob() ma=
y
> +        * return -EUCLEAN. In all cases, perform similar logic to mtd_re=
ad().
> +        */
> +       ret_code =3D mtd->_read_oob(mtd, from, ops);
> +       if (unlikely(ret_code < 0))
> +               return ret_code;
> +       if (mtd->ecc_strength =3D=3D 0)
> +               return 0;       /* device lacks ecc */
> +       return ret_code;
> +}
> +EXPORT_SYMBOL_GPL(mtd_read_oob_bf);
> +
>  int mtd_write_oob(struct mtd_info *mtd, loff_t to,
>                                 struct mtd_oob_ops *ops)
>  {
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 09f52698877..28afbb86ea9 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -413,6 +413,7 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, =
size_t len, size_t *retlen,
>                     const u_char *buf);
>
>  int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *=
ops);
> +int mtd_read_oob_bf(struct mtd_info *mtd, loff_t from, struct mtd_oob_op=
s *ops);
>  int mtd_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *o=
ps);
>
>  int mtd_get_fact_prot_info(struct mtd_info *mtd, size_t len, size_t *ret=
len,
> --
> 2.34.1
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
