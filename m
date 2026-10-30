Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AF606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j18bEhcf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E93440F0B;
	Fri, 30 Oct 2026 15:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBV06p28KdA2; Fri, 30 Oct 2026 15:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D116F40ED5
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793375024;
	b=pTj6h7ZC3B0KEwa5DH7wNUcpvhwADXiXNqZ5h+8cYkTPs7gupNblJVXJ2DKuAN3cbb8Y
	 XXrRY/KW9eD9n6GfzH4b18m6HUGi7gBS9kaQNQ3sJIUR4vS0EXWMZhgOxfwKtEreo8FTL
	 iDbmO4FhMVc6ZJ1ADCdg7j2qFvGp7M9UHVz5VtWkgXo9TjCIJtTAPIZX6v4tK5IluIizc
	 eqf4gh1ng204gttZm0otTT/x0YyXHeDzZEIJy9ggeRXwuI2GH3tCj/6o5WODn+/WVoitv
	 oI4shrs2bnOT+dV1UTl2QfGp3eGv6sgNCT/meydxL5/EWMMeZ7Uy4EAmeY5tDqzZt0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793375024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K7f/cQtkNUPTYUSwgl5HAgtl63crP2LKRsnz/L6mQZM=;
	b=YBeV6MEbnX2xuiJeGTZl5vxSiBz+sEig70xbcofQxCxZtmx7ofhebeeawUQg0VlT4Ru1
	 k/ahwHP5lVF8h2zrqnM6NuuZS0Skvx+1vyA196xyCFBcwDAR1EeFf3I6oWK1LWIXxV0is
	 +slNy3MIpyDqda3kWDAdnZb5BEV8nATDTfz1la0FYCHQrddNQLLcJ5NIlgRaZmNuhKKgl
	 stMZYAKX80ClzrfIGFfPnRFIGM5ml4FPQ03cUGt9LnQwMjAkHSPrkNFSYFfWFL+p9MvK0
	 qibdNPc+6Q2nuBz+7s7A1q8ju4Xft/lG7qyjhLm9HhR/8VI6nIjJsj+9Q25O+Yiakpw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793375024;
	bh=K7f/cQtkNUPTYUSwgl5HAgtl63crP2LKRsnz/L6mQZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j18bEhcf/URTgtLjfHIIqrp54x9ard/Ot0KjOEGE+7PbQsaWmRqkI4s5FQYvRs/7L
	 z+eBvhD5M6J1H87//99RUA+3sDxUaoIM4JeecIe8fNZFj9ZjFUFzsC1vzIwdYpAEBD
	 paSADHv9/an9G0bAPpGMPy6yxLrNB+wX5HdsXpEyDSTFSfahxV49Im7aFcedGhD1OU
	 9LN3kZkr0Gj70IBTDieoRFwOiuHcHdbpfm3P36y+MloWsp0sqX48uF89bQu4eBL3NO
	 iYJk5ULUkjosGXelmathwED8p05T/f9Qw3cZHDPsTVZkG3IJBlB7s6QhJIBeYBLOD5
	 QQscEPjsY7lZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D116F40ED5;
	Fri, 30 Oct 2026 15:43:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE861529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBA2360A88
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id si9OkIlJ6_lK for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 15:43:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2D236087F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.233.101.22
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793375021;
 b=Mv4IQZrd3dp166PhTFE9JQ3rij8sDnlhrd0UP3nUtF+JQ57ADjZFP5g+Vgj3h7ERW3tc
 WmG03sNGqWmrSNnhUtwB/Oop3mukHYq3CRu9R+/EC+NJ6eXv3VZTuwfqDLRQBpXDIc4r9
 95FOMGBfYxf3gT7xVAMNPkJgEcTti+t0X93UeBdc/XCNNK+Jbw6CNEmmZUES/dt4FD+io
 yLOET42jj2NgySVm0rgxRGT2UmfHrVITYXnvjlaCgNPHOHdU53+gUQDnp4TCdqfNrSkSE
 Kn+89R8/RoYN+yai7SeWqPeElJ5TMQjn8SmdEB1HgzDdLHy+V8cHEVCaytCOetrsmbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793375021;
 h=X-Greylist:Received-SPF:Received:Received:X-Spam-Checker-Version:
 X-Spam-Level:X-Spam-Status:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=K7f/cQtkNUPTYUSwgl5HAgtl63crP2LKRsnz/L6mQZM=;
 b=YWIl59wqaw6JGZOgxq3/G0eI6U32YIQMbLyB353NGravEibusNN3Ii0yQgaiCqnO+uav
 0cTHnmIuSvN7YQDZdNik7LcAKwkawYJmGqiYRSyM00AAWTuWYxwh1CxHbY6NWcxzUTub0
 Awf6+04z2jiWmsStle4xvHIaOgz6FTQCxSW9gX3eD8UjTNAdvjHXUjoCgUV7iV9dCZT4/
 Z58xPb7OcZFwqIiNd8WYuBMEytFlmn+zEJUMndtvHYqrm09Qxm9DtN3KHWJsKS5XVFMU3
 iB4+7YGGrKRxel28kugjzDxksYS7W0tZlt0FZdFm2nxQ6/Bj2MM0wscHX8LBij91inw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=sys-base.io;
 arc=none smtp.remote-ip=185.233.101.22
X-Greylist: delayed 597 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 30 Oct 2026 15:43:40 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.233.101.22;
 helo=leonov.paulk.fr; envelope-from=paulk@sys-base.io; receiver=<UNKNOWN> 
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2D236087F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:43:40 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 44E823700F60
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:33:38 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 032F3B72BBB; Fri, 30 Oct 2026 15:33:37 +0000 (UTC)
Received: from shepard (82-65-240-19.subs.proxad.net [82.65.240.19])
 by laika.paulk.fr (Postfix) with ESMTPSA id 48E1DB72BB5;
 Fri, 30 Oct 2026 15:33:37 +0000 (UTC)
Date: Fri, 30 Oct 2026 16:33:35 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [PATCH] sunxi: a133: adjust TF-A load address
Message-ID: <auS4xwW6QuXaptlc@shepard>
References: <20261029233720.8411-1-andre.przywara@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2L2QjHgHXD7tLOQY"
Content-Disposition: inline
In-Reply-To: <20261029233720.8411-1-andre.przywara@arm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--2L2QjHgHXD7tLOQY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On Fri 30 Oct 26, 00:37, Andre Przywara wrote:
> When development of the Allwinner A133 TF-A port started, BL31 was put
> in SRAM, like on the similar H6 SoC. Consequently we used the same SRAM
> address as the H6 in the Kconfig stanza of the A133 U-Boot port.
>=20
> Later we realised that the SRAM space will become too tight, in fact it
> was already spilling over into SRAM C, which we cannot use any more at
> runtime, once the display engine is used. So the mainline TF-A port
> eventually put BL31 in DRAM, which of course requires a different load
> address.
>=20
> Adjust the BL31 load address to use the same DRAM location as the (almost
> SRAM-less) H616, by just adjusting the match pattern, to not let the A133
> fall through to the SUN50I_GEN_H6 symbol.
> This allows U-Boot to use the now merged mainline TF-A port for the A133.
>=20
> This is unfortunately a breaking change, but there is not much we can do
> about it, and since U-Boot packages TF-A in our booting scheme, we have
> that under control.

Thanks for submitting this! I agree this is the right thing to do.

Also note that I've been using the 0x104000 SRAM address as base for the
crust SCP firmware, which will be submitted once crust support is there.

Another aspect is that I'm not sure we actually lock down the address in
the TZC, so it's likely that Linux could still overwrite the TF-A code.
But that's a TF-A problem, not a U-Boot problem.

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

All the best,

Paul

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/mach-sunxi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index b0c5d3cd903..b7ee14c6678 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -267,7 +267,7 @@ config SUNXI_RVBAR_ALTERNATIVE
>  config SUNXI_BL31_BASE
>  	hex
>  	default 0x00044000 if MACH_SUN50I || MACH_SUN50I_H5
> -	default 0x40000000 if MACH_SUN50I_H616
> +	default 0x40000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133
>  	default 0x00104000 if SUN50I_GEN_H6
>  	default 0x00054000 if MACH_SUN55I_A523
>  	default 0x0
> --=20
> 2.46.4
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--2L2QjHgHXD7tLOQY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmrkuM4ACgkQhP3B6o/u
lQx+XhAAjSX3tkOfKMe2iiGawjl6f2PKlDL7jRbI2Ns9m/meBrLo2rm0xciPREIm
d/wUfmMtbDoqMaEqJRlpchytC0JxyLKHc1GfN+IskUAXJces9YQbIUB8xNrfYBA5
pR52CIpKRYtIzsZjsj3fVtWUZb/BEhloviLLEcieI9bUF2bz7/nl0sYhTh7/Wcqu
MlZsvLBSl0mrc+xSzhLocOa+eZ7ftiQIjuV5BZPXt8p5u4Eb7Fr7GRTnBOiEPXlb
+sVKT5wKbkCwtKXkS6WKu/LTkf2t0tyfhfMlvhYHSMTB7vi/WLBc/w1Zl4+69JDF
AVpZie4W8h5PLhZ+CBIQjbES2KFmEz+8ave1NqApNJSnpRTcjgn9640Ep5YGibWY
fxgy+Joh/UoOUfejGZRT1/K5XQSL9qL2LEsKFosplivybK8JU0VZ9P4tcavpURUi
HhIOruiMjzmHepglBtznekPprqYgH0cERhtBwFXnDicdu/TqEZR0u9/dRZC8rGa5
fqt54vbwX1+0GLwg/M7upfTvhvdFhUL1xUX3pC+Qx9hVPD2JTJY7RDtZkgDBdH5m
ZJbCJ6eN62fvWcguQn0l5xKvVXslAS6xowHhg5HNv0JV90+oC3h5hbrtNe5/40sV
6mo4fJKpiu81gx/GprjOzkrxDETeiCw92QrD8EKApJMg2LmgRYs=
=Ygfx
-----END PGP SIGNATURE-----

--2L2QjHgHXD7tLOQY--
