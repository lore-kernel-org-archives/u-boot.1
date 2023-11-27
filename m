Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59E2C07D5A
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32EB78778B;
	Mon, 27 Nov 2023 19:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BxJQjGIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4CAF8779E; Mon, 27 Nov 2023 19:33:24 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5D787772
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a877e0f0d8so41950777b3.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701110001; x=1701714801; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4PbCR8Jf/4hfHDK4ub4wPHr0Cd/JmK/gb09UXTkIuQg=;
 b=BxJQjGIzVBiRNE8lvWHowHgYdgR7Hh32WRaVAHkGgyMqf9zIrce3HCJPb51wD/bib1
 5jx5qnDWXWHyS686XWjoZhqrBkSw8++O8rwOSm8B26x7XKmUafnJpaYg+WQAANtaY4D1
 hUzqSHDjhNDnpVifu/cp3GTFa0UYrYfdCYO2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701110001; x=1701714801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PbCR8Jf/4hfHDK4ub4wPHr0Cd/JmK/gb09UXTkIuQg=;
 b=XfRF2UN8xyVPX7VNT73AQHfR2acT4UW8CXVgKc/FyHyNEa0bRT2IA9J1aBJFeIrSQw
 x4wW+Z8j48pGEUlW3C7Vt5eYAdK5fLSNHsfHcYne/2HGYktc/2gfMUpA7VpzjtnbtSiD
 cASVNbbvMb+8Kzh1IozL9SNhIA2B5sATQ+uTHxdSFY+jSFWe2n1hiRZ+5t/vBW9uWRmw
 +YemjrOvG5MQBOTJPIqmqB+SqAIwhanBxRtE+WzMUD2yF9MN2gGNKnYALxlXckIW5Z37
 EgxmvcpNyBdVYPid7EwUPyzkplF1bg2x+fCY+Z2H0iLYr8qdeymEeZGls4Ev+RAVhRw8
 n2kQ==
X-Gm-Message-State: AOJu0Yxfo5Gt+ARytO001R3aJv9M4O585EzODDCv3+sJz0/4vgIRsnGW
 KAmZAjRjivy4i7U1Uy7+BPpOfg==
X-Google-Smtp-Source: AGHT+IGl/YIiA/XIXzBG5nNV2Qv35St/pTa/2PrY4t91S22hycb/3SJq92/ClHV/oqxTBTd/UrAazQ==
X-Received: by 2002:a0d:e804:0:b0:5c9:bce2:57d1 with SMTP id
 r4-20020a0de804000000b005c9bce257d1mr13550315ywe.23.1701110001503; 
 Mon, 27 Nov 2023 10:33:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a0de605000000b005ccc70e7dc1sm3442428ywe.87.2023.11.27.10.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:33:21 -0800 (PST)
Date: Mon, 27 Nov 2023 13:33:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 20/43] driver/net/rtl8139: remove debug print
Message-ID: <20231127183319.GS2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-21-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OEy2xLgrKrnAxkCn"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-21-maxim.uvarov@linaro.org>
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


--OEy2xLgrKrnAxkCn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:57:03PM +0600, Maxim Uvarov wrote:

> debug print delays reset of the driver. Finally I see
> bunch of "rx error FFFF" errors in the screen. CI can
> not handle many prints. While network works fine there
>=20
> Reproduced with:
> make CROSS_COMPILE=3Dsh2-linux- r2dplus_defconfig all
> qemu-system-sh4 -M r2d -nographic -serial null \
> -serial mon:stdio -net user,tftp=3D`pwd` \
> -net nic,model=3Drtl8139 -kernel ./u-boot.bin
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  drivers/net/rtl8139.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
> index 106bc1c7ae..6003b88274 100644
> --- a/drivers/net/rtl8139.c
> +++ b/drivers/net/rtl8139.c
> @@ -453,7 +453,6 @@ static int rtl8139_recv_common(struct rtl8139_priv *p=
riv, unsigned char *rxdata,
>  			  RTL_STS_RXBADALIGN)) ||
>  	    (rx_size < ETH_ZLEN) ||
>  	    (rx_size > ETH_FRAME_LEN + 4)) {
> -		printf("rx error %hX\n", rx_status);
>  		/* this clears all interrupts still pending */
>  		rtl8139_reset(priv);
>  		return 0;

Make this a debug() please so it's available to interactive developers
with a problem here.

--=20
Tom

--OEy2xLgrKrnAxkCn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk4O8ACgkQFHw5/5Y0
tywnuwv/b6h1pixIiX/ly9QeTC4882RS/y17EpF4rJOoqyCJ4HOceCGELYNah0CM
k1m3mqaAQK4byHipa9rr5aNTVh1hF8VZrjdbyvgrasuQP2BHBFx561AEQfJ9h0Vu
1pHd/Tpce4/PbI05NsTPyYT69W0x91kG0FwPomTIH1vvVFHmosi0Sdc95PbVW4Bx
LPskN2suqzIJn9uzf7rRprYfbSqgStxp8nM1NKX23F3QQzWUqkI4zfERbIBxHp2X
VockzMFjhSBmzs8GhVpLyCEKhGGrMwnSi3gtZk4+qEeoqAHoqkuaAER6a1IAQ03l
V/cq/euXKpv3YJtP+TWAYDZ8TSPAZTUrjl9dLfKN5n+eG6JB2XfK7Z6Gd6YCPYi5
68FJPv+g1+fAhlSWbpn/SVKpMuDMZQx4Qupu6hhv14sqog8VdSTcwwsBUf/aYA68
A4wgVqoE4N8JdK1REb7smegDfPllx64SQllc06W/lngnrALzn4jVEqi74LWlwlKN
YBAC6dYD
=EAT3
-----END PGP SIGNATURE-----

--OEy2xLgrKrnAxkCn--
