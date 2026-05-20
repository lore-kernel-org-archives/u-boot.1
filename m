Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9C3CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 00:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE548487C;
	Wed, 20 May 2026 02:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hKRfqF83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35278487F; Wed, 20 May 2026 02:06:38 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5381884874
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso3579491a34.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779235595; x=1779840395; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EuwlXv7s7THTxqgNaZjFb5dAJ20lVu+VLODVKLl9wrI=;
 b=hKRfqF83Ksu/i+hKxkKK8RShjj6kkS4freK+uIfMjudRHcIgi1YoMdZb6PlEOFogQV
 wu6WQvW8GPpSkIEIP/KAVSm/TPLMuG4+XDghsV7tbzOOPcEsp9LxCRiXSzST9qWBZond
 /E5h0v1O2QPHug88PVWgcJNUX6Y7DHB4fWvHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779235595; x=1779840395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EuwlXv7s7THTxqgNaZjFb5dAJ20lVu+VLODVKLl9wrI=;
 b=bqfGzMftJ1XS5VrUH1qdiajZsIFstqAfzJEFTkXSLiX5tVxtsDL6yJNCZlktTc7GcC
 QEUJyXxECvsqbYb5OgVUP0WAo5gxpFX2R5LOXeSm8HXm6ykuBXQYz0Qgf9bfPHy74fmx
 FFUF5Rc/tDOkWsy5YQFLt2DqwEBPJNwxHc1NDHW/UxdXkYwmWxYqIJyp6etGArj5h17u
 qjvYwCrrbPdgRnNgP2YqWVN4KrNpdj0Ahng2xD5IOu/sxsi8j3IQQerXAhFIBebJEUTk
 qBbHsgOi3zxY/zfjws2jS3be7kOcYvHQM33l88q6K9Rshqgv3W0XA5/h7Sd8EK2a81v2
 rc2w==
X-Gm-Message-State: AOJu0Yz85mc9LRsJBzKyqORsowA/EHphtkCPbq5MSaMBjt8CuxbMExGy
 yFpYx3sXVryuGVu74yJ/J8kLmgXtwd/YF1PQs8I2IR2akw5meWKSJ3HMRI+CAYtyfcg=
X-Gm-Gg: Acq92OEpKoXoEwh2I0eJnX8V8b+cWJ4LGqzmpUSZq+9zsfJbhwvfTfz3NGAE2RB+yV1
 40/QjdNwyXkeGVOL81qhFI5vdz7q8frCcnAJI948xHxUg0P2CxP0maAC5hc/1Ppv59Ii2XkZOOC
 +BY4TeuQEIclulEfdN6ezJqtBGPyLB06M8f+xZ2TmRlj+sSMDYfdaCHeTJzVBzbY5SUmCUsdiIP
 twJdXBLD2nrGNJbsa1N3TsF8qvRkB9oS0LEQP3YwTNKsjxCz2Xh6wDPgaPkvFk5qIu3iYImqX+h
 W9nyawwmK4aOtYnrS3b50XsMX3Qy/hDYDXgVrgBfba0ke7ROyNRHnj7DU1i3g1zj+UpKbi6vkM6
 7jgNWlW+7qp+znM+mZdMQy2SwZS4tgQGh2xjM1Ny80lG27ckMTt+1tjqRsPoHucf8vAdPzT8HaV
 x/J+yzcpmuObhg5RXWnghUFT9DScc7yccHbOtF2R8GPcH5v6UHtCTEjiKwVn13bsmSndjyLUT/u
 0ev9a9Si/WX10xCkyPsnSdAK1HuIz8/14jDGvlzH41D07W6dtc=
X-Received: by 2002:a05:6830:6515:b0:7dc:d2ad:fb29 with SMTP id
 46e09a7af769-7e4fa057c32mr14761037a34.24.1779235594996; 
 Tue, 19 May 2026 17:06:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b43sm10920832a34.5.2026.05.19.17.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 17:06:34 -0700 (PDT)
Date: Tue, 19 May 2026 18:06:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Daniel Palmer <daniel@thingy.jp>, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [RFC PATCH v2 00/17] Tidy command option parsing and use it a bit
Message-ID: <20260520000630.GJ1858239@bill-the-cat>
References: <20260519233207.2765755-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="954Q16KIW6uBxpLj"
Content-Disposition: inline
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
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


--954Q16KIW6uBxpLj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 05:31:26PM -0600, Simon Glass wrote:

> We have had getopt() for over five years but it is not much used. It is
> much easier to understand arg-parsing using getopt() and it avoids
> common errors. As the named maintainer I decided to look at how to make
> more use of it.
>=20
> So this series explores the impact of converting a few commands to use
> getopt() instead of ad-hoc parsing. It updates getopt() to handle flags
> anywhere in the cmdline and provides a few helpers to reduce
> boilerplate.
>=20
> The chosen commands are:
>=20
> - echo: very simple with one flag and fixed ordering (worst case?)
> - hash: fairly simple with just one flag
> - env grep/export/import - fuller examples
>=20
> The series also adds a recommendation to use getopt() for new commands.
>=20
> To try to reduce the code-size increase, a lower-case function is added
> and called from a few places. The difference is fairly marginal.
>=20
> v2 includes further attempts to reduce code size, by making reordering
> a Kconfig option, dropping some printing and some intensive optimisation
> of the env commands.

Let us return to the comments from v1 again:
https://lore.kernel.org/u-boot/20260515203311.2555651-1-sjg@chromium.org/

Sean was saying that nvedit should be a best case for the conversion. In
v1, grep was no change and "export and import" was 164 bytes on "qcom",
which I chose because it already enabled GETOPT. Let us now look at v2.
Here, grep, export and import are three commits:
10: cmd: nvedit: Use getopt() in env grep
11: cmd: nvedit: Use getopt() in env export
   aarch64:  w+   qcom
+(qcom)   636 |         char    buf[32];
+(qcom)       |                 ^~~
w+(qcom) cmd/nvedit.c: In function 'do_env_export':
w+(qcom) cmd/nvedit.c:636:17: warning: unused variable 'buf' [-Wunused-vari=
able]
   aarch64: (for 1/1 boards) all +4.0 data +16.0 rodata -12.0
            qcom           : all +4 data +16 rodata -12
               u-boot: add: 0/0, grow: 0/-1 bytes: 0/-32 (-32)
                 function                                   old     new   d=
elta
                 do_env_export                              608     576    =
 -32
12: cmd: nvedit: Use getopt() in env import
   aarch64: (for 1/1 boards) all +1.0 data +56.0 rodata -55.0
            qcom           : all +1 data +56 rodata -55
               u-boot: add: 0/0, grow: 1/0 bytes: 100/0 (100)
                 function                                   old     new   d=
elta
                 do_env_import                              692     792    =
+100

So grep is unchanged, export is a small reduction but import is growing,
but less.

My feedback is this. If you are going to bother with RFC v3, please just
limit it to converting nvedit and showcasing that it's an improvement to
convert. And if it's not, as Sean said in v1 we might need to revisit
the interface.

--=20
Tom

--954Q16KIW6uBxpLj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagz7AwAKCRAr4qD1Cr/k
Cu0GAQDMz5+7HiVSShxr7E9yE1tV6HZFkGwLVIlRxQ15QB3ZQQEAmCDARVuZ5Wi8
oCH1uVjUOwtIHIiR+n65bZR8NSB+MAo=
=S/2z
-----END PGP SIGNATURE-----

--954Q16KIW6uBxpLj--
