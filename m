Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2014EC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 22:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1825988CE4;
	Tue, 20 Aug 2024 00:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pxrBniu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5360188CE8; Tue, 20 Aug 2024 00:08:52 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B405988881
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 00:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5cbe88f70so2957500eaf.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724105328; x=1724710128; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+EioAtGtKcBYjXKu8T6mT98wPvBa/iOGOvcmX1a20Hs=;
 b=pxrBniu48iUAgONZeAz9D8BbHGLkS7vBdsHlag//XfW3WyVbQUXZp/Fg1kObqB1vtl
 6ozfJJcoApaP5kZtAWPWPo30K7OE7OrMwGfK5yCUy4YFf95v7ZSbCPVF0/MPHSD9FssY
 9LLMUOrFCzgh2enUA5A3XNm8VDcwgRYwWty3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724105328; x=1724710128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EioAtGtKcBYjXKu8T6mT98wPvBa/iOGOvcmX1a20Hs=;
 b=Hub5wlrSfE8hCTzZ96PuMsGKbbKGrnLSoJ2F22JV2WkPr1VOSDjuiKZFTIxhVg8pCU
 RzD5WWrfEdNwdXGw10oy3X5XjtVt31cpqTw7/jdxFt9uNHPD9q2diBARcxL/aYTGeMXp
 cgE6/uKR5M1CcXn6m6rkjA+O8B4Y0DaXYGOJFFEQQdQADZkiGWAsgLZGePWdvzHv1sYE
 S9PQVvoaJnXS+BBHSUcqur5HDNSRB8mc1tRBrv/3wi3Gq6sYdIqRuUBQ9Bp/z4JGhanQ
 EI3CMhoctVbkGSGrpDTYpLc3mmBrdr7ddfVQjpof4WIFUNnW5QgrOOKWZRcJ1y4lpN9T
 fVXg==
X-Gm-Message-State: AOJu0YyyJk+Kl70AD9oqGSqxpvznoCkatNhV23V136I0md4hrvAMZgr3
 oe1Bz55ks0joGslCYXZrUjOGEx8zOYWmNvCs/+UP8PnlgMc+cafaxLyC+/Ntt9U=
X-Google-Smtp-Source: AGHT+IE6T/IFa6MNbgPDHl6LV2+Bgv6zvn/dBbmco3Tl3wQhI2hvCKQKtzo3IcBYL9+zVUPVNp+DVQ==
X-Received: by 2002:a05:6820:513:b0:5da:a317:91fd with SMTP id
 006d021491bc7-5daa31792dcmr11794551eaf.5.1724105328311; 
 Mon, 19 Aug 2024 15:08:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5dc93a5bcd0sm35517eaf.1.2024.08.19.15.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 15:08:47 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:08:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v8 00/23] Introduce the lwIP network stack
Message-ID: <20240819220844.GI1626301@bill-the-cat>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <20240807204400.GJ1626301@bill-the-cat>
 <d9fe273b-ab60-44eb-bef8-cbde3af8ab1b@linaro.org>
 <20240816184019.GD1626301@bill-the-cat>
 <7bf0ed1a-96f8-4970-a06d-7a572774b263@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lWygAKtMi5l3aCxK"
Content-Disposition: inline
In-Reply-To: <7bf0ed1a-96f8-4970-a06d-7a572774b263@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--lWygAKtMi5l3aCxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 04:53:51PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/16/24 20:40, Tom Rini wrote:
> > On Fri, Aug 16, 2024 at 06:21:24PM +0200, Jerome Forissier wrote:
> >>
> >>
> >> On 8/7/24 22:44, Tom Rini wrote:
> >>> On Wed, Aug 07, 2024 at 07:11:44PM +0200, Jerome Forissier wrote:
> >>>
> >>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add l=
wip
> >>>> library for the network stack" [1]. The goal is to introduce the lwI=
P TCP/IP
> >>>> stack [2] [3] as an alternative to the current implementation in net=
/,
> >>>> selectable with Kconfig, and ultimately keep only lwIP if possible. =
Some
> >>>> reasons for doing so are:
> >>>> - Make the support of HTTPS in the wget command easier. Javier T. and
> >>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to =
do
> >>>> so. With that it becomes possible to fetch and launch a distro insta=
ller
> >>>> such as Debian etc. using a secure, authenticated connection directly
> >>>> from the U-Boot shell. Several use cases:
> >>>>   * Authentication: prevent MITM attack (third party replacing the
> >>>> binary with a different one)
> >>>>   * Confidentiality: prevent third parties from grabbing a copy of t=
he
> >>>> image as it is being downloaded
> >>>>   * Allow connection to servers that do not support plain HTTP anymo=
re
> >>>> (this is becoming more and more common on the Internet these days)
> >>>> - Possibly benefit from additional features implemented in lwIP
> >>>> - Less code to maintain in U-Boot
> >>>>
> >>>> Prior to applying this series, the lwIP stack needs to be added as a
> >>>> Git subtree with the following command:
> >>>>
> >>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.sava=
nnah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >>>
> >>> For v9, I think it would be good to do a CI run with NET_LWIP default
> >>> and seeing what fails from that too. There's a few problems still
> >>> leading to a lot of failures, in that case. Thanks.
> >>>
> >>
> >> See here: https://github.com/u-boot/u-boot/pull/635
> >>
> >> I fixed a number of issues, see the commit descriptions. As for the
> >> remaining ones:
> >> - There is no http server in the CI so the wget test I added fails
> >=20
> > Ah yes. So the test needs some enable-me type flag, like other tests
> > that require external configuration.
>=20
> Can you please suggest how to do that?

Well test/py/tests/test_net_boot.py for example.

> >> - tftp is super slow in QEMU (~145 KiB/s) which causes timeouts. This =
is
> >> for two reasons: (1) the tftp windowsize option is not supported in lw=
IP
> >> (while the legacy NET does support it) so the sender waits for an ACK
> >> before sending a new packet; and (2) the latency is very high due to
> >> memcpy() being incredibly slow in QEMU (I am mainly referring to the
> >> memcpy() call in tftp_write() in net/lwip/tftp.c). I measured ~20-60 ms
> >> to copy a few hundred bytes (!) and if CONFIG_USE_ARCH_MEMCPY is enabl=
ed
> >> it is slightly better but not much (~15 ms). Also it seems the QEMU
> >> networking emulation is fragmenting the UDP packets because with
> >> CONFIG_TFTP_BLOCKSIZE=3D1468 the tftp_write() function never receives
> >> 1468 bytes but only a few hundreds at a time (max 544 bytes).
> >=20
> > I thought you fixed that? Or was that only for on real hardware?
>=20
> It works OK on real hardware...

It should be fast enough here too.

> > But also, some of those numbers sound unusually terrible to me. We can
> > get some bad luck with the free instances, but, still.  Are you sure
> > there's nothing else going on?
>=20
> ...and yes that's absolutely terrible. In fact I found something curious.
> With the following patch applied to provide a memcpy() speed test:
>=20
> diff --git a/cmd/test.c b/cmd/test.c
> index b4c3eabf9f6..35b8d62af61 100644
> --- a/cmd/test.c
> +++ b/cmd/test.c
> @@ -7,6 +7,8 @@
>  #include <command.h>
>  #include <fs.h>
>  #include <log.h>
> +#include <stdlib.h>
> +#include <time.h>
>  #include <vsprintf.h>
> =20
>  #define OP_INVALID	0
> @@ -215,3 +217,49 @@ U_BOOT_CMD(
>  	"do nothing, successfully",
>  	NULL
>  );
> +
> +static int do_mtest(struct cmd_tbl *cmdtp, int flag, int argc,
> +		    char *const argv[])
> +{
> +	ulong t0, delta;
> +	void *src, *dst;
> +	long sz;
> +
> +	if (argc < 2) {
> +		printf("Usage: %s <size_in_bytes> [dst [src]]\n", argv[0]);
> +		return 1;
> +	}
> +	sz =3D simple_strtol(argv[1], NULL, 10);
> +	if (sz < 0) {
> +		printf("%s: %s: invalid argument\n", argv[0], argv[1]);
> +		return 1;
> +	}
> +	if (argc > 2) {
> +		dst =3D (void *)hextoul(argv[2], NULL);
> +		if (argc > 3) {
> +			src =3D (void *)hextoul(argv[3], NULL);
> +		} else {
> +			src =3D malloc(sz);
> +		}
> +	} else {
> +		dst =3D malloc(sz);
> +		src =3D malloc(sz);
> +	}
> +	if (!src || !dst) {
> +		printf("%s: out of memory or NULL address\n", argv[0]);
> +		return 1;
> +	}
> +	printf("%ld bytes from 0x%p to 0x%p: ", sz, src, dst);
> +	t0 =3D get_timer(0);
> +	memcpy(dst, src, sz);
> +	delta =3D get_timer(t0);
> +	printf("%ld ms\n", delta);
> +
> +	return 0;
> +}
> +
> +U_BOOT_CMD(
> +	mtest,	CONFIG_SYS_MAXARGS,	0,	do_mtest,
> +	"memcpy() speed test",
> +	NULL
> +);
>=20
> I can see that there are ranges of memory that are very slow to *write*
> to (and the loadaddr used by the tftp test happens to fall in that
> range):
>=20
> $ make qemu_arm64_defconfig
> $ make -j$(nproc) CROSS_COMPILE=3D"ccache aarch64-linux-gnu-"
> $ qemu-system-aarch64 -M virt -nographic -cpu cortex-a57 -bios u-boot.bin
>=20
> U-Boot 2024.10-rc1-00195-g35ce7016c9cb-dirty (Aug 19 2024 - 16:42:15 +020=
0)
> [...]
> =3D> mtest
> Usage: mtest <size_in_bytes> [dst [src]]
> =3D> mtest 1000
> 1000 bytes from 0x00000000466baed0 to 0x00000000466baae0: 0 ms
> =3D> mtest 1000 0x2000000 0x00000000466baed0
> 1000 bytes from 0x00000000466baed0 to 0x0000000002000000: 22 ms
> =3D> mtest 1000 0x00000000466baed0 0x2000000
> 1000 bytes from 0x0000000002000000 to 0x00000000466baed0: 0 ms
> =3D>=20

This is all very strange. Can you investigate a bit please?

--=20
Tom

--lWygAKtMi5l3aCxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbDwmUACgkQFHw5/5Y0
tyyW2Qv6A1Rn9a7SzKPCt64jSolDWSGiksKSIrN6fasLMcTxmUwINl9NsVL0oZs4
9DlesYx0cLquIplS/kWBnWzRjAoMxbC9HpVOCZGy7yXKAEXFA2PSSnJeibsgawOn
u+GsuQpj7sdB6tTahBMfekuGmq4OZl93RQATbwzwGy1qav+TsUjzTUfem9BZ4IPQ
VAPYhMPy2WBybBL3RYUXC5F6XuDSmZ4P1NYRZ/IlumeseRx4z/XlFT/TNudPRpIg
g9n8GQXBKo7qC4o+D7GvKtSfzx+z07Li5QcPDefZF5WkBbPIehkmHLdFcZqOf77r
p8gar9tpJjm4sbwpCB/g8Y5B0bArnrej4ys57NHN+pBgy6Ai9TzXfWr0mIzfOrXm
8tCdhfmHnpqSWZv8n7XbPbnevHzzDfYl6o7ROINwEAGuRzBF0XxV43jFxBNc6D3m
mgJA5pnxXtE8txBkCkKeotxhC9vG0ie2zGKGWrSnfSoT9052VF3MoDBI2NusH1J2
bRVmheg3
=sgvf
-----END PGP SIGNATURE-----

--lWygAKtMi5l3aCxK--
