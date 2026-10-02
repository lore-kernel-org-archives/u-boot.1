Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CE0CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67A8D40DA0;
	Fri,  2 Oct 2026 12:26:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z9-wKNvUI3St; Fri,  2 Oct 2026 12:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 13AF240DA8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790943989;
	b=TJy4O5D+MegjXvxGmTVjiaTfDVx63wbQ2htUAAyGAkhJawJa+ix9ncqz4W+yKsn9D7T5
	 xITZtcRC0yJGMH1PTBUSdDNEfSm82ssOB3XpydrlRtTQx9R4B4BAUZd1pIDus+b3pmP9E
	 qlSOsFyQo417uPFl0xNe55/JalFtrJ8JQNAoVVKlwx5hMPxjp3FA7Dpl/HHvGQ5GdX7m3
	 rltk1bLBW7nUJvvoOSZg7wk/kV6IjrhCVktNFG3XytbjJqcFgRhUnnYt8LEdqQm28R9h8
	 E0w0TzVMcWaAJpc9aeGY6hNu090uyna1ERuKkX+vNfpc7lq7fBVt1YXlpYJb9G4akgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790943989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y5mJ0FgB+0C9y3X7L1wIBK3k35S2ODYpZgz0rIBqE34=;
	b=emcViCPr8OkNfbUv4MTQuJpSkVivAkt1KVY34W3aL6eFR3NJeF2IG9Ka+KqhKba6zcci
	 0Nh1VwcrJ+xeAKE4J9sKZd4vNcbpIkGrHs3e1a/v9p/naxy2tkE3ujZwCthxNetSrT6is
	 XQ3lqJPb3UQn9T996QP5xHMRUtNU2ous73L2kfyz7ZV5qwvMSTLLkWLG9D97S355EeH4h
	 YbVc4syNmT11toVydUVhD20ozFNLNLXZI+T9Przz3qJYskMZNtuvnX32hTNvg8SVNt8H9
	 ZHfGHxOi+bXKuqA6/NJVDfsKRpL+rjNjI5Cj9I3Lwe53d0UEk54ebfCqSKXn5ylKIHw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790943989;
	bh=y5mJ0FgB+0C9y3X7L1wIBK3k35S2ODYpZgz0rIBqE34=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0GumNApgXn/gBcVnPf+lTASUqTQBafFYNHd5NOUWtK4VbGpNgXZjNk7S7cZVhGcTr
	 gGNhMoo3AlNLIWm75QorfA875F0OLCDG2yosVKtBPfXcFdMVEXQ/8qdfzeD3pO96At
	 SBaVTWCPejetMUW9UOICmB4vGcr3rfu6UFPx2U9H1tR22TcO6SW+u4jWKP/OGO4Us5
	 5D2NiIeUWGjWg7p99CheNU0KUF6ppYgAtevsyQQLWP1K+DR3VuUINiIhREzjKEu5Jc
	 KSXIkELWbbGqRCGP1Pv6OSWeD1ls0VD93rnG9978AHjTbu4W8aDkfNH1Z1qJzq8/kj
	 cSLih6uFOcUpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13AF240DA8;
	Fri,  2 Oct 2026 12:26:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B36032F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6090040382
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WdwITWrnq2s0 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:16:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DEC2B40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790925365;
 b=iTWCp6IuHFAU6oVT15bsHQNRBfu17Q68xi6KKD0tiinWcPkDtFsyb5eKs9dsDVRhidkX
 c+rqZeA6Cl8MKSVQSLfUF6gdvom77cawwOiHp1K+fTtF1QCyw6vXPIk7CgwCfVzmtzAJI
 RjRD8FR9g19yRDjKUfe1hleQnALzJFBnFFBpKcVSythi/hs2mTGWD93oezYbncsDDIa3S
 bo6mGKZ9FFZxWutBPEhzV+amTgo9hPzC0Rg331vmF5EIfo8Dvk9Akz+VZUVeaOarSOLdp
 RtYXscnWlWMgkueDRpi4AUaGCeHGCweP6ghwpf0sRM/1qHcj919/szePLs9Sa2+giAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790925365;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=y5mJ0FgB+0C9y3X7L1wIBK3k35S2ODYpZgz0rIBqE34=;
 b=rcg2lZtLY+lRmISPB17ts6M/yYO76kbaA0Yonq6A3AG93l4124XRSoNqEpvnptSmYjg8
 DEQJCvLeqCZe9auMeWYU3kQHhKnelQsqHJcWtqJSTS1b6C8OEIkoBFQ76A/a/RQwCiguA
 BYsqbVVuqa73N0Tcf63UMwhGCvqZ6vJM6+CAOtYSnQQFV++FGXpE16HzQJefLqiUKw7nA
 hXR21zFUMANGcPuxjzPmph+fZwc2Ezu26raPFd83bi5weHGCzCakEdqNYTTBI1UuA+0uh
 ggC3/gtIoq1Q5XVRMaptamdc1z0DDh34H0Y2ylc+MAqhZQMyuLwV4811oULiP6jMomQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=infineon.com; 
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=FsMLTbEy; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::6;
 helo=smtp14.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=FsMLTbEy
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEC2B40057
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1790925365; x=1822461365;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kxcDb2/62tyIBjTIv2vPM1JK7eL9hHsgWmN/j5gH0mU=;
 b=FsMLTbEyyztuLImbSRubJ4h0qBbjL6PlKYw7Gc94bJZnATKGbmtakd2J
 ENiKSd4LINru7X7PZqDatC+1Q09dyqT8q6Jb6Tpne+O8XBVg0XTZjrA02
 j1PqqL1QzdwNJ2XBXidYy4iORHOUxQJF1KjbQb986NexLH5asNnI9DoW+ M=;
X-CSE-ConnectionGUID: OJ9raYPKTgmyFY6j9+U5aA==
X-CSE-MsgGUID: NCM1T+g6Skium3lOB2GItQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="149559433"
X-IronPort-AV: E=Sophos;i="6.27,136,1787004000"; d="scan'208";a="149559433"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 09:16:02 +0200
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:16:01 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:16:00 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.049; Fri, 2 Oct 2026 09:16:00 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <marex@nabladev.com>, <u-boot@lists.u-boot-project.org>
CC: <jbx6244@gmail.com>, <js07.lee@samsung.com>, <trini@konsulko.com>,
 <tudor.ambarus@microchip.com>, <vigneshr@ti.com>
Subject: RE: [PATCH] cmd: sf: Add rdreg and wrreg subcommands for SPI NOR
 register access
Thread-Topic: [PATCH] cmd: sf: Add rdreg and wrreg subcommands for SPI NOR
 register access
Thread-Index: AQHdTGoXA0JikWI6fkCrim2OW6ePJrbp0gFw
Date: Fri, 2 Oct 2026 07:16:00 +0000
Message-ID: <1629bc58ddad414fb223ed7348c4cbbc@infineon.com>
References: <20260924211708.108526-1-marex@nabladev.com>
In-Reply-To: <20260924211708.108526-1-marex@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Marek,

> Add two subcommands, rdreg and wrreg, to read and write SPI NOR
> registers respectively. The registers are always accessed using
> register specific access opcode and arbitrary amount of data are
> read from SPI NOR register and stored to memory or loaded from
> memory and written to SPI NOR register. This is useful in case
> the SPI NOR non-volatile registers have to be configured in some
> non-standard way, or when debugging the SPI NOR configuration.
>=20
> Example usage:
>=20
> Read 6 Bytes of SPI NOR ID (Read ID opcode is 0x9e):
> "
> =3D> sf rdreg 0x9e $loadaddr 6
> =3D> md.b $loadaddr 6
> 00000000: 20 ba 20 10 44 00
> "
>=20
> Read Micron Nonvolatile Configuration Register (opcode 0xb5):
> "
> =3D> sf rdreg 0xb5 $loadaddr 2
> =3D> md.b $loadaddr 2
> 00000000: ff ff
> "
>=20
> Write 0xfffe (LSByte first) into Micron Nonvolatile Configuration
> Register (opcode 0xb1):
> "
> =3D> mw.b 0x00000000 0xfe
> =3D> mw.b 0x00000001 0xff
> =3D> sf wrreg 0xb1 $loadaddr 2
> "
>=20
> Signed-off-by: Marek Vasut <marex@nabladev.com>

I understand register access from CLI is useful for developing and debuggin=
g.
However, if we want to make this a generic debugging feature, we need to
consider many vendor/chip-specific variations. For example, non-volatile
register write require polling the status until completion (which is curren=
tly
missing from your implementation). Some registers require address cycles fo=
r
access. Some registers require latency cycles for reads, and so on.

Unless we can support these known variations, I think this feature should
remain a temporary local modification.

Thanks,
Takahiro

> ---
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Jungseung Lee <js07.lee@samsung.com>
> Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  cmd/Kconfig                    |  7 ++++
>  cmd/sf.c                       | 63 ++++++++++++++++++++++++++++++++++
>  drivers/mtd/spi/spi-nor-core.c |  8 ++---
>  drivers/mtd/spi/spi-nor-tiny.c |  8 ++---
>  include/spi_flash.h            |  5 +++
>  5 files changed, 83 insertions(+), 8 deletions(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ff90a87024c..562f85bead0 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1783,6 +1783,13 @@ config CMD_SF
>         help
>           SPI Flash support
>=20
> +config CMD_SF_REG
> +       bool "sf reg - SPI NOR register access"
> +       depends on CMD_SF
> +       help
> +         Provides a way to access SPI flash registers using register acc=
ess
> +         specific opcodes.
> +
>  config CMD_SF_TEST
>         bool "sf test - Allow testing of SPI flash"
>         depends on CMD_SF
> diff --git a/cmd/sf.c b/cmd/sf.c
> index b5b7f671fb9..4426440045d 100644
> --- a/cmd/sf.c
> +++ b/cmd/sf.c
> @@ -541,6 +541,59 @@ static int spi_flash_test(struct spi_flash *flash, u=
int8_t *buf, ulong len,
>         return 0;
>  }
>=20
> +static int do_spi_flash_reg(int argc, char *const argv[], bool rdreg)
> +{
> +       unsigned long opcode, addr, len;
> +       struct spi_nor *nor =3D flash;
> +       uint8_t *buf;
> +       char *endp;
> +       int ret;
> +
> +       if (argc < 4)
> +               return -1;
> +       opcode =3D hextoul(argv[1], &endp);
> +       if (*argv[1] =3D=3D 0 || *endp !=3D 0)
> +               return -1;
> +       addr =3D hextoul(argv[2], &endp);
> +       if (*argv[2] =3D=3D 0 || *endp !=3D 0)
> +               return -1;
> +       len =3D hextoul(argv[3], &endp);
> +       if (*argv[3] =3D=3D 0 || *endp !=3D 0)
> +               return -1;
> +
> +       buf =3D map_sysmem(addr, 0);
> +       if (rdreg) {
> +               ret =3D spi_nor_read_reg(nor, opcode, buf, len);
> +               if (ret) {
> +                       printf("Read command 0x%02lx failed (%d)\n", opco=
de, ret);
> +                       goto exit;
> +               }
> +       } else {
> +               ret =3D write_enable(nor);
> +               if (ret) {
> +                       printf("Write enable for command 0x%02lx failed (=
%d)\n", opcode, ret);
> +                       goto exit;
> +               }
> +
> +               ret =3D spi_nor_write_reg(nor, opcode, buf, len);
> +               if (ret) {
> +                       printf("Write command 0x%02lx failed (%d)\n", opc=
ode, ret);
> +                       goto exit;
> +               }
> +
> +               ret =3D write_disable(nor);
> +               if (ret) {
> +                       printf("Write disable for command 0x%02lx failed =
(%d)\n", opcode, ret);
> +                       goto exit;
> +               }
> +       }
> +
> +exit:
> +       unmap_sysmem(buf);
> +
> +       return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
> +}
> +
>  static int do_spi_flash_test(int argc, char *const argv[])
>  {
>         unsigned long offset;
> @@ -614,6 +667,10 @@ static int do_spi_flash(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>                 ret =3D do_spi_flash_erase(argc, argv);
>         else if (IS_ENABLED(CONFIG_SPI_FLASH_LOCK) && strcmp(cmd, "protec=
t") =3D=3D 0)
>                 ret =3D do_spi_protect(argc, argv);
> +       else if (IS_ENABLED(CONFIG_CMD_SF_REG) && !strcmp(cmd, "rdreg"))
> +               ret =3D do_spi_flash_reg(argc, argv, true);
> +       else if (IS_ENABLED(CONFIG_CMD_SF_REG) && !strcmp(cmd, "wrreg"))
> +               ret =3D do_spi_flash_reg(argc, argv, false);
>         else if (IS_ENABLED(CONFIG_CMD_SF_TEST) && !strcmp(cmd, "test"))
>                 ret =3D do_spi_flash_test(argc, argv);
>         else
> @@ -641,6 +698,12 @@ U_BOOT_LONGHELP(sf,
>         "sf protect lock/unlock sector len      - protect/unprotect 'len'=
 bytes starting\n"
>         "                                         at address 'sector'"
>  #endif
> +#ifdef CONFIG_CMD_SF_REG
> +       "\nsf rdreg cmd addr len                        - read SPI NOR re=
gister using 'cmd' opcode\n"
> +       "                                                 and store 'len'=
 read data at 'addr'\n"
> +       "sf wrreg cmd addr len                  - write SPI NOR register =
using 'cmd' opcode\n"
> +       "                                                 and load 'len' =
write data from 'addr'"
> +#endif
>  #ifdef CONFIG_CMD_SF_TEST
>         "\nsf test offset len           - run a very basic destructive te=
st"
>  #endif
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-cor=
e.c
> index c73f2c7c3f8..eb022e577a2 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -298,7 +298,7 @@ static int spi_nor_read_write_reg(struct spi_nor *nor=
, struct spi_mem_op
>         return spi_mem_exec_op(nor->spi, op);
>  }
>=20
> -static int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int l=
en)
> +int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
>  {
>         struct spi_mem_op op =3D SPI_MEM_OP(SPI_MEM_OP_CMD(code, 0),
>                                           SPI_MEM_OP_NO_ADDR,
> @@ -315,7 +315,7 @@ static int spi_nor_read_reg(struct spi_nor *nor, u8 c=
ode, u8 *val, int len)
>         return ret;
>  }
>=20
> -static int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, in=
t len)
> +int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
>  {
>         struct spi_mem_op op =3D SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),
>                                           SPI_MEM_OP_NO_ADDR,
> @@ -637,7 +637,7 @@ static int write_sr3(struct spi_nor *nor, u8 val)
>   * Set write enable latch with Write Enable command.
>   * Returns negative if error occurred.
>   */
> -static int write_enable(struct spi_nor *nor)
> +int write_enable(struct spi_nor *nor)
>  {
>         return nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
>  }
> @@ -645,7 +645,7 @@ static int write_enable(struct spi_nor *nor)
>  /*
>   * Send write disable instruction to the chip.
>   */
> -static int write_disable(struct spi_nor *nor)
> +int write_disable(struct spi_nor *nor)
>  {
>         return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
>  }
> diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tin=
y.c
> index cf00473ee83..7b6b7432af8 100644
> --- a/drivers/mtd/spi/spi-nor-tiny.c
> +++ b/drivers/mtd/spi/spi-nor-tiny.c
> @@ -46,7 +46,7 @@ static int spi_nor_read_write_reg(struct spi_nor *nor, =
struct spi_mem_op
>         return spi_mem_exec_op(nor->spi, op);
>  }
>=20
> -static int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int l=
en)
> +int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
>  {
>         struct spi_mem_op op =3D SPI_MEM_OP(SPI_MEM_OP_CMD(code, 1),
>                                           SPI_MEM_OP_NO_ADDR,
> @@ -72,7 +72,7 @@ static int spi_nor_read_reg(struct spi_nor *nor, u8 cod=
e, u8 *val, int len)
>         return ret;
>  }
>=20
> -static int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, in=
t len)
> +int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
>  {
>         struct spi_mem_op op =3D SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 1),
>                                           SPI_MEM_OP_NO_ADDR,
> @@ -155,7 +155,7 @@ static inline int write_sr(struct spi_nor *nor, u8 va=
l)
>   * Set write enable latch with Write Enable command.
>   * Returns negative if error occurred.
>   */
> -static inline int write_enable(struct spi_nor *nor)
> +int write_enable(struct spi_nor *nor)
>  {
>         return spi_nor_write_reg(nor, SPINOR_OP_WREN, NULL, 0);
>  }
> @@ -163,7 +163,7 @@ static inline int write_enable(struct spi_nor *nor)
>  /*
>   * Send write disable instruction to the chip.
>   */
> -static inline int write_disable(struct spi_nor *nor)
> +int write_disable(struct spi_nor *nor)
>  {
>         return spi_nor_write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
>  }
> diff --git a/include/spi_flash.h b/include/spi_flash.h
> index 2e703e85250..b7622bce48c 100644
> --- a/include/spi_flash.h
> +++ b/include/spi_flash.h
> @@ -236,4 +236,9 @@ static inline int spi_flash_protect(struct spi_flash =
*flash, u32 ofs, u32 len,
>                 return flash->flash_unlock(flash, ofs, len);
>  }
>=20
> +int write_enable(struct spi_nor *nor);
> +int write_disable(struct spi_nor *nor);
> +int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len);
> +int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
> +
>  #endif /* _SPI_FLASH_H_ */
> --
> 2.53.0

