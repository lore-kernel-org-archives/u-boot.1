Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F5ACA0FE7
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 18:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40DF88309D;
	Tue, 26 Aug 2025 20:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PYyXyqC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503C6830B3; Tue, 26 Aug 2025 16:23:45 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22BB828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 16:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 39E8D4E40C4A;
 Tue, 26 Aug 2025 14:23:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F0D4F606A7;
 Tue, 26 Aug 2025 14:23:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E03AE1C22DABA; 
 Tue, 26 Aug 2025 16:23:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1756218221; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=axWDNG0CAItg4q5+sBPGFEf7vDR/pEVQKXWhs9XoQa8=;
 b=PYyXyqC4ZgB6lWJYlYwfJoO1edaDNb4m87WNz/S6qB1d/ijVJFa0jB8aHupvlVrDZ6j/Fy
 SfIZaw0R1sel7hHlDhj0Vu1aD6OLhHuR1aagyyEWvjRH0mEU1PmC689s9D8GL5pxCNo5s2
 8CF9ierlT24AVhezAMPnKg2B9UuFxo0NoMlJ9xNygU20qE1ylcCM9avq6p9PYd364N1xse
 nBABglGkQa5AGqMquNdFRX/ESx0/nsdX0a+/le8dYjwNHH+dPfhw5Mxk8inu6MRL7mFvo7
 Aqych1XYnVW4owvJR1PwB8Rma0WuTXBr4agSOg7a4F+FUt7AeigVZOLoDIzV6Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,  u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: mtd: fix speed measurement in the speed benchmark
In-Reply-To: <20250825234829.155483-1-mikhail.kshevetskiy@iopsys.eu> (Mikhail
 Kshevetskiy's message of "Tue, 26 Aug 2025 02:48:29 +0300")
References: <20250825234829.155483-1-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 26 Aug 2025 16:23:27 +0200
Message-ID: <87h5xu2mcg.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 26 Aug 2025 20:17:12 +0200
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

Hello Mikhail,

On 26/08/2025 at 02:48:29 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> The shown speed inverse linearly depends on size of data.
> See the output:
>
>   spi-nand: spi_nand nand@0: Micron SPI NAND was found.
>   spi-nand: spi_nand nand@0: 256 MiB, block size: 128 KiB, page size: 204=
8, OOB size: 128
>   ...
>   =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x40000
>   Reading 262144 byte(s) (128 page(s)) at offset 0x00000000
>   Read speed: 63kiB/s
>   =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x20000
>   Reading 131072 byte(s) (64 page(s)) at offset 0x00000000
>   Read speed: 127kiB/s
>   =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x10000
>   Reading 65536 byte(s) (32 page(s)) at offset 0x00000000
>   Read speed: 254kiB/s
>
> In the spi-nand case 'io_op.len' is not the same as 'len',
> thus we divide a size of the single block on total time.
> This is wrong, we should divide on the time for a single
> block.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Happy to see this is useful :-) But you're totally right, it didn't use
the correct length. Maybe I would rephrase a bit the last two sentences
to make the commit clearer:

"In the spi-nand case 'io_op.len' is not always the same as 'len', thus
we are using the wrong amount of data to derive the speed."

However, regarding the diff,

> @@ -594,9 +594,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>=20=20
>  	if (benchmark && bench_start) {
>  		bench_end =3D timer_get_us();
> +		block_time =3D (bench_end - bench_start) / (len / io_op.len);
>  		printf("%s speed: %lukiB/s\n",
>  		       read ? "Read" : "Write",
> -		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
> +		       ((io_op.len * 1000000) / block_time) / 1024);

Why not just dividing the length by the benchmark time instead of
reducing and rounding the denominator in the first place, which I
believe makes the final result less precise?

Thanks,
Miqu=C3=A8l
