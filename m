Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28C5CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3700C842BC;
	Fri, 10 Oct 2025 14:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="O0D95B7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA6A584214; Fri, 10 Oct 2025 14:18:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7692D842B6
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760098711; x=1760703511; i=xypron.glpk@gmx.de;
 bh=4W4LmaXaC07/E2WFHkNjH+524qS6JBKuA3QyqFtLczk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=O0D95B7hjMLVgyvIUesCq5Fv6O1bjiY50NT3RMf16dC3RZml14q91gtuUcEIEQde
 PiQtTIuVxbh2SNrGGO4w6SB1rtHnuYrnWJ30MhW6tqvfJNRWalpAPgZaMPFE782dD
 aGjxOkeMFTlOniKWRmmgOBOA5x3o2UTRH35JzyjHnAax3jfWpi1xmqJZk/y2+zIVJ
 sxei9GHJQD7jLvs4kkQNeclM0ZM4436hJk7R0bUf1fsil1fXoNldFWzWSlDsno7Pz
 s6A6EXWvIAoGNpydX+qwC5BsdFtO+a7SEZALmdSdATrfxVAtVfhypJLonOaaG7Ckf
 5VU0Mnaml5iCPEPBTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1uVvJu1w6r-00gSSN; Fri, 10
 Oct 2025 14:18:31 +0200
Message-ID: <ef29354f-7d9d-4d28-b3f4-b31291e11dcb@gmx.de>
Date: Fri, 10 Oct 2025 14:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] cmd: mtd: fix speed measurement in the speed
 benchmark
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
References: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
 <20251010120429.1532370-5-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251010120429.1532370-5-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xv0UuABBb3bUECu6IoCv7uQR7PIhBIQXyirMEhlQXBG1aExpeb3
 HbonRQPQn/7kdV1LzTcO8Uw/4eoUEIGxvba0z0PKRaEA/19lPevFZiN2p1mXU1lPZCeVWwp
 h3Zrcf2PvCTY39XGkdEtmxz2kzmcaF0VZcJc8BFAmVrNm1oL0XdkPfCxuAQedofpZ1CwIAY
 9I/BB4Y82kOeETh6qqj3Q==
UI-OutboundReport: notjunk:1;M01:P0:FwGpwHzu3VY=;F0jUGdJsts98zzjaGwM4dmP7GSv
 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
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

On 10/10/25 14:04, Mikhail Kshevetskiy wrote:
> The shown speed is inversely proportional to the data size.
> See the output:
>=20
>    spi-nand: spi_nand nand@0: Micron SPI NAND was found.
>    spi-nand: spi_nand nand@0: 256 MiB, block size: 128 KiB, page size: 2=
048, OOB size: 128
>    ...
>    =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x40000
>    Reading 262144 byte(s) (128 page(s)) at offset 0x00000000
>    Read speed: 63kiB/s
>    =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x20000
>    Reading 131072 byte(s) (64 page(s)) at offset 0x00000000
>    Read speed: 127kiB/s
>    =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x10000
>    Reading 65536 byte(s) (32 page(s)) at offset 0x00000000
>    Read speed: 254kiB/s
>=20
> In the spi-nand case 'io_op.len' is not always the same as 'len', thus
> we are using the wrong amount of data to derive the speed.
>=20
> Also make sure we are using 64-bit calculation to get a more precise
> results.
>=20
> Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   cmd/mtd.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 689d8d11655..e415a2d7f02 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -469,7 +469,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>   		     char *const argv[])
>   {
>   	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages =
=3D false;
> -	u64 start_off, off, len, remaining, default_len;
> +	u64 start_off, off, len, remaining, default_len, speed;
>   	unsigned long bench_start, bench_end;
>   	struct mtd_oob_ops io_op =3D {};
>   	uint user_addr =3D 0, npages;
> @@ -595,9 +595,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int fla=
g, int argc,
>  =20
>   	if (benchmark && bench_start) {
>   		bench_end =3D timer_get_us();
> +		speed =3D (len * 1000000) / (bench_end - bench_start);
>   		printf("%s speed: %lukiB/s\n",
>   		       read ? "Read" : "Write",
> -		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
> +		       (unsigned long)(speed / 1024));

Some SoCs may not support 64bit divisions.
u64 lldiv(u64 dividend, u32 divisor) might be applicable here.
Please, have a look at include/div64.h.

Best regards

Heinrich


>   	}
>  =20
>   	led_activity_off();

