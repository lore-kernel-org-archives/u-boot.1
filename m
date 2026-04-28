Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D307FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 09:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77B484668;
	Tue, 28 Apr 2026 11:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE5F18466F; Tue, 28 Apr 2026 11:59:09 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D23284658
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id CB9C727F;
 Tue, 28 Apr 2026 11:59:03 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 11:59:03 +0200
Message-Id: <DI4P7BNPXKYW.37JP7FIR13OW2@kernel.org>
Cc: "trini@konsulko.com" <trini@konsulko.com>, "chuanhua.han@nxp.com"
 <chuanhua.han@nxp.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tomas Alvarez Vanoli" <tomas.alvarez-vanoli@hitachienergy.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/1] spi: fsl_espi: fix din offset
X-Mailer: aerc 0.20.0
References: <20260324170212.481394-1-tomas.alvarez-vanoli@hitachienergy.com>
 <DI3XUWVXNGP3.2TI0N0LDP7ZJ4@kernel.org>
 <DB9PR06MB7849FF9D7AFDD1CD3C3304B7C2362@DB9PR06MB7849.eurprd06.prod.outlook.com>
In-Reply-To: <DB9PR06MB7849FF9D7AFDD1CD3C3304B7C2362@DB9PR06MB7849.eurprd06.prod.outlook.com>
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

Hi,

On Mon Apr 27, 2026 at 5:00 PM CEST, Tomas Alvarez Vanoli wrote:
>>What kind of issues do you see? And how does your patch resolves
>>this? I guess we can assume the code was working correctly once.
>
> The problem was that when calling spi_xfer like so:
>
> `spi_xfer(spi_slv, bitlen, &dout, &din, SPI_XFER_ONCE);`
>
> To read a read only part of chip with known values, I was getting garbage=
.
>
> Digging deeper into the driver and adding print statements I was able to
> determine that:
>
> - fsl_espi_rx was getting the expected data and putting it in the correct
> address (local din)
>
> - The memcpy later in the code was taking data from a different address
> (buffer + 2 * cmd_len) and putting it in the user pointer (the &din from =
my
> call)
>
>>Honestly, I don't understand that code either. ...
>
> The switch at the start of the function determines the buffer and offset =
setup.
> To be fair I only focused on my issue, SPI_XFER_ONCE which is the same as
> SPI_XFER_BEGIN | SPI_XFER_END, and in a small transaction.
>
> Inside the ONCE case, the driver allocates a buffer of double the transac=
tion,
> because it puts the tx data in the first half, and then will write the rx=
 data
> in the second half.

I mean:

Why is there an split between cmd and data (cmd_buf, cmd_len etc.)
although there is not such distinction in the SPI context. Why is
the first xfer (i.e. only SPI_XFER_BEGIN is set), delayed? What is
that mysterious "(*buffer =3D=3D 0x0b)".
Why is the max transfer length 0xfff0. Presumably, because there is
an assumption that the "command" is <=3D 16 bytes. Then that matches
the 16bit length field in the ESPI peripheral ("TRANLEN"). Although
there is no check that the "command" is really less than 16 bytes..

> The case of only "SPI_XFER_END" is a bit more "cryptic" to put it nicely,=
 and I
> did not properly debug it if I am being honest.

Yeah but that's the crux here, isn't it? Esp. because there the
buffer length isn't multiplied by two. Only the "cmd_len" is. Hmm.
Also, either data_in or data_out is handled. Ok. I *guess* that
driver supports only half duplex operations, that is probably also
the reason of that command/data split. Command is always output,
after that, there is either data in *or* data out. Doh. In your
case, i.e. SPI_XFER_ONCE, it's actually a full duplex operation, or
at least it can be, if data_in !=3D NULL and data_out !=3D NULL.

Funny enough, SPI_XFER_ONCE with data_out =3D=3D NULL is not handled.
Maybe that can't happen in u-boot. Dunno.

Also, the CS handling is probably wrong, as it will change on every
transfer, though that is what SPI_XFER_{BEGIN,END} is for.

> However, for my case of the ONCE transfer, if you look at the start of th=
e while
> loop:
>
> ```
> 	while (num_chunks--) {
> 		if (data_in)
> 			din =3D buffer + rx_offset;
> ```
>
> This means that if the user passed a pointer to get the read data back, t=
hen
> we set a local "din" to the buffer we allocated at the start plus rx_offs=
et.
> In the "ONCE" case, this is the second half of the buffer. In the END cas=
e, this
> "cmd_len".
>
> This din pointer is what is passed to "fsl_espi_rx", where I had corrobor=
ated
> that the chip data read was the expected.
>
> When we get to later in the while loop, there's this:
>
> ```
> 		if (data_in) {
> 			memcpy(data_in, buffer + 2 * cmd_len, tran_len);
> 			if (*buffer =3D=3D 0x0b) {
> 				data_in +=3D tran_len;
> 				data_len -=3D tran_len;
> 				*(int *)buffer +=3D tran_len;
> 			}
> 		}
> ```
>
> where I made my change, in the memcpy source pointer. This is the code in=
 charge
> of copying the data back to the caller/user.

Yeah but why was there the "2 * cmd_len" in the first place. I mean
you've probably fixed the ONCE case, but broke the usual case (as
MTD/spi-mem is using it). rx_offset "1*cmd_len" and the actual
data is at 2*cmd_len because the second cmd spot is where the data
is received that you'll get when sending the "cmd".

Also, isn't the tx path sending garbage in the non-ONCE case, when
reading data? It seems it will send the data it was receiving
beforehand because dout is always pointing to the allocated buffer.
Thus after cmd_len, it will send the data fsl_espi_rx() was
receiving before.

> As you can see, for the ONCE case, cmd_len is 0, so it is taking the data=
 at the
> start of buffer (my tx data, not the rx data). Hopefully the bug I was
> experiencing is clearer with this explanation.
>
> As I mentally traced this code I realized of a better fix, hopefully you =
can
> review this and/or test in on your board too.
>
> Given that for the ONCE transfer cmd_len is 0, what could be changed is a=
lso:
>
> diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c
> index b1586d12912..ef2ebd5840b 100644
> --- a/drivers/spi/fsl_espi.c
> +++ b/drivers/spi/fsl_espi.c
> @@ -287,13 +287,13 @@ int spi_xfer(struct spi_slave *slave, unsigned int =
bitlen, const void *data_out,
>                 break;
>         case SPI_XFER_BEGIN | SPI_XFER_END:
>                 len =3D data_len;
> -               buffer =3D (unsigned char *)malloc(len * 2);
> +               buffer =3D (unsigned char *)malloc(len);
>                 if (!buffer) {
>                         debug("SF: Failed to malloc memory.\n");
>                         return 1;
>                 }
>                 memcpy(buffer, data_out, len);
> -               rx_offset =3D len;
> +               rx_offset =3D 0;
>                 cmd_len =3D 0;
>                 break;
>         }
>
> This theoretically should work and should also not affect the "END" case.
>
> The two things that support this are that:
>
> - The loop always writes out first, so the rx data can safely overwrite t=
he tx
> - cmd_len is set to 0 for the ONCE case, so data_in memcpy would take the=
 rx
> data from the right rx_offset (0)

Yeah, I get to the same conclusion. Another possible solution would
be to check for cmd_len =3D=3D 0 and use rx_offset, otherwise cmd_len *
2.

Will you prepare a patch or should I include one in my larger "fix
NXP PPC boards" series I'm about to send today or tomorrow?

> Hopefully this explanation and my proposed alternative fix are helpful, I=
'm glad
> someone else was able to test this, I had cc'ed someone from nxp hoping t=
hey
> could shine some light on the code but their email does not exist anymore=
.
>
> It would be good to know what flags the flash probe is passing to the dri=
ver,
> to know if the problem actualyl arises from the switch statement at the s=
tart
> or handling multiple chunks/blks. I can say for certain that for a single
> chunk and signle block, the ONCE transfer was not working correctly for m=
e.

I don't have the board at hand right now. But I'm pretty sure, it's
split between SPI_XFER_BEGIN and SPI_XFER_END, see
https://elixir.bootlin.com/u-boot/v2026.04/source/drivers/spi/spi-mem.c#L41=
8

-michael
