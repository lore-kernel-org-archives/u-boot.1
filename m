Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pwkE75Fa;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FdJw1Mvw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA11D406C7;
	Mon, 26 Oct 2026 14:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yeRbxyaBFIR2; Mon, 26 Oct 2026 14:29:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17DF140695
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793024997;
	b=e921uQvjKqycYPgFKgaTxlitP8s9U3zay2CUrgL4Te8dklQ4yhJ6O3OgR1SoQd4FtVeW
	 IZ55oB7xuCUCt4dO30mBTbtVeLakRqfG8/HyLbGScgUJNZkeITjK7crIPoFF5Mvrm5f4k
	 XDRiOdanboNVI1Ij9wNOcpWFcTOylwYWeCtIYdO5OIzMqQSf7WF1z23ZUd9by762cF9b4
	 9siFKpB18dI3zN65jubxLakii3IAtCfS/c3rX9rCrhuj7E0MYTWKcZHELH0CoiiNI7rAf
	 XbMnOj0n3QTbB8i11A6j9oE8mfF+h+TzYSoaSvV45rOUEndCqnnIrf3wa8txD/Khf0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793024997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zyVsJl+jrthCz0TYgklucRqLg9YGE60Y0SomORX3dl4=;
	b=o7LTdxDVmFk0/0ZGsIABpcfB6ol3NFqsuzlMvncjGKHxaSIZtumSYKQAl5W77cbWxrOz
	 rR9emeoBzMZFd3zm5lZjTQpwjfuD2dHH2LdjDQmFFmPUeN08dMkW9V/XGqfS1kuMuz040
	 u/BrrHi44tD8iq4W0J2iOF1y29gWmVzNGaai2yhPlu1AtRkjHPE0+T5eJlIQEl8rAkVva
	 usJWIcVUAdKtvPNGthJKbDHE/zdS7aNBLtfO7CvUECP8kFMSmtc26XDVcYVtVXbnw7S8Y
	 7+0Ok/LonPX5Xd9d/UsEVrm0Jm7IKobv4sGbORML798MBgbE9qtpY3ruTFIgSkXWgaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793024997;
	bh=zyVsJl+jrthCz0TYgklucRqLg9YGE60Y0SomORX3dl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pwkE75FaUxZ6FqKNZDfBlNAxVp+6dj3UmB2fFZ6pzrqhVVwPA/3IrAPn2YY2Bw2Eu
	 BGOmSZTKWmeWcHzark7T3gGQ8vfT63N78bjHQ6Y499VqURENhayd2sUCczEPMxmjU9
	 TGaaVBeiJ6LPTRoWMpem0yUCTUBmrOvK2htfqnuAqzJx3XDjfRCdnkPK754qZjdMB4
	 5rP8p97ipOqjlHvKGrxAfiXMMhoN6EEA1JWWcvjkvjuN+m6Fs5jhlwTcikoHrJe1mQ
	 I8ByTDCayRnfCqa1FJN9mviU5Vo7T4kI7rrSTi6zDhBjxRiBwPUiYQSIonK0KMIdZl
	 2Nqffqf41pEOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17DF140695;
	Mon, 26 Oct 2026 14:29:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AF9F235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6CB10400F6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0T647NjmOr6D for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:29:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A429A40062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793024994;
 b=ey13aY+vNr/6Zad3kJ686tm4yRJa5+DnO0UNjaEZsezUMSVfOkyXwX9sDM2uh2ZAxhkH
 6bBkuCNN4QWvuHP8+bilmVov6/NBcSUgAp1Y3UegtxOJKir2DSo3WQRLdHhjgWR/gplW8
 rtsaCStiKPuC04AAyGGprtmdHxOrsn8MvSryZMDYZNJmvaLw4zOQpuVZhSAsBzKUpIlS7
 ve8/f3ffPr3f7ZGb8FLrhEf7CEg9eY1J26s3MUwCpirLlw0WQPbKDV3NsvZwjb2knw0Tg
 FjAjEiNdtNlMQbgDZ+uZAacnHcgI45zR9uw5i3YZof+F6oxCgpySkQeaWk8Y7jRRjkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793024994;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=zyVsJl+jrthCz0TYgklucRqLg9YGE60Y0SomORX3dl4=;
 b=HzCto8XofbDa19ZDuHCmgoW1eLhJKf9C96vMjmwZ0PeO68wyaj1MmPLtJ/jlQBQWKZb+
 WZC530+Ywq798bAWVzObCNc1q70SyJlgd5/IPjZcklcYQlBnl6xWjnJ2zTIT34ZbbA1vS
 P9HaKZFhK3/nbcidv3yz09f7HUSyxJYtj98aEGpMdmRXI5oS6X+RNyvqgPqqwcMo5R2At
 iFivKfJqa6gpjVbMBgLriecBS+zL9t6o3zuy+fexWU2KaRW2/xD1Yd8fSAsgdCTh35msB
 aU384If2hDpMZ/AGePaWHXJcEmSIpgOoOw6VJb5NF7Q3Ebri09d3yvwp6TE4jWnTTdg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FdJw1Mvw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FdJw1Mvw
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A429A40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:29:54 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6d290b10a35so1336744eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793024993; x=1793629793;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zyVsJl+jrthCz0TYgklucRqLg9YGE60Y0SomORX3dl4=;
 b=FdJw1MvwEug7A7Se3+GVjcOoYqGef4UsAwIrnuwI+dqC8pYMmrhcHAjkrTHkOX5qcu
 T3/Dux6OCWbgTEKHCMdKEWTFm/RjslgjFrLP1lROdo9WWnhNn57K04gFq1nMaB9P2pCs
 M09U2JkLON4lCeBi7gJ1UElPQKpm5Qxkww2IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793024993; x=1793629793;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zyVsJl+jrthCz0TYgklucRqLg9YGE60Y0SomORX3dl4=;
 b=B0asVBVBvCb7CHcEHEfpu2Tdos/NywoQmzKyEgn+miu4BacwlndkaJOBr0IYa1gfHo
 KshiNtk6dfJBnYcXj7Zmcktvx4b9bxNZ3KaaKSEdhIj8crYvsKBWC8ANqjO7/YYYs2Q7
 HP0E6n2ojiHIgJAXLpb5xWwNNVw86ERhiJVSk5rFy4yelEH79Dt60cMmEUuUZIyNMJz8
 ZXE917YNOqpnA3Yn1uxHQ9YaK3ODMwE3tuwlwB27caal/nfUeHKeLb6KAWSppLPcgIs0
 FNWkvZxaKZNKgSyMO43n/2V0d3YHdMCPIP3gBiEyWnuoMfyBjCRSBEQgPPUIQbUYQgZ0
 EOXw==
X-Gm-Message-State: AFq9FYJvo9GtjWcX6wmbwz9L+b0JwgpjItSkiAJt9iT4FF0KAtoC/0CO
 Z9a6Vr+ZbGLgcULlKuWfSmHs6YgAk4V7ik2dg4AeUOo+t4l0ebcuP5APq864So1YYNg=
X-Gm-Gg: AYBFou0pegj/k5p3TuNBuzsuUaW2Fcxse67jUZFK8BWBNhPahFw4PDmmu1VdvO5UjdR
 qZ9MNiEM+smjdlTCznaK4ESUpHJ3tUzh2g5PeX/TqkXAyy+mWaUKG76j9L1sMo/SnFOiTkfgbub
 gQdH4AgIEsncAcZg9TpIpskp0eNSdShpg+38ZZodnL9sEYmDQiqyjZq6SufI1cGGWNXmXXMfZNb
 6v50eSACM2Vh0VeTRpjnhhYXxAsailWRCH3R7p7qvOjzinHu6SUruLvXICMfO5bpGSZeBWMkoT8
 x+ijo4xg52brzsSeGgUF6e5Qh0q/XiHsC8aZXYagRG9hFwiPXJgbLeyP2qgZu8CijdLXm4mkHYb
 L00mPHOX20UiwZ/huAvyRzuoAADlNoqvJAGb1GMk+8qK1iZvFnsOy8lZoYzs7H02z041b39WaNd
 PeEVrPH+09T6WdmDHscWngMmA9tIDvYKDYRrgdveJDbGS5JPGNCBWyL8xtdET/jkQtGqbZOs2fr
 3rWZBr/1lMm7a2ZBkoKc4nEThnhtvQ8u8vxZs4pXCRz8/vfpUEWe9obnk9CZIS0Ngbpjx1wHof3
 EFKQU2LkdXR8YsDLgBGRp497hfy2IVI4BXhd0RlaZMsWKJLw+T4wb5Thbe/Py8hXrV3BgDaekaF
 hpxV38WCR3vcfCGU8/wPguKu3LDtwa6SpbpNo4+4LzNfOtrOmsTgVbF3ClQ==
X-Received: by 2002:a05:6820:55d7:10b0:6dc:99b3:2efc with SMTP id
 006d021491bc7-70ba0e59092mr2329911eaf.43.1793024993308; 
 Mon, 26 Oct 2026 07:29:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8431c2061sm4927834fac.14.2026.10.26.07.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:29:52 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:29:50 -0600
From: Tom Rini <trini@konsulko.com>
To: "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>
Cc: u-boot@lists.u-boot-project.org, jerome.forissier@arm.com
Subject: Re: [PATCH] net: preserve the driver error in eth_init()
Message-ID: <20261026142950.GB624796@bill-the-cat>
References: <CAMPWMbrVO9-ZVYQu6Y0GSA37OXzTrg+nyZObyxQJKtJvBErmQw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XeVcSyPu2PzTY5pU"
Content-Disposition: inline
In-Reply-To: <CAMPWMbrVO9-ZVYQu6Y0GSA37OXzTrg+nyZObyxQJKtJvBErmQw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--XeVcSyPu2PzTY5pU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:11:37AM +0100, Terry Zhou (Synaptics) wrote:

> eth_init() overwrites the error from eth_start_udev() with eth_errno,
> which may still be zero after a successful device probe. This can
> report success even when no Ethernet device could be started, causing
> DHCP to enter the BOOTP retry loop instead of failing immediately.
>=20
> Preserve the return value from eth_start_udev() so that callers can
> detect the initialization failure.
>=20
> Signed-off-by: Terry Zhou (Synaptics) <terryzhou05@gmail.com>
> ---
> Validated using downstream SDK U-Boot on Synaptics VS640 and SL2610
> Without the fix, driver startup errors are followed by BOOTP retries.
> With the fix, DHCP fails without entering the BOOTP retry loop.
> DHCP succeeds with the cable connected.
>=20
>  net/eth-uclass.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index 07ec59b97f0..18efbfeda71 100644
> --- a/net/eth-uclass.c
> +++ b/net/eth-uclass.c
> @@ -349,9 +349,7 @@ int eth_init(void)
>  			debug("Trying %s\n", current->name);
>=20
>  			ret =3D eth_start_udev(current);
> -			if (ret < 0)
> -				ret =3D eth_errno;
> -			else
> +			if (!ret)
>  				break;
>=20
>  			debug("FAIL\n");
>=20
> base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27

Did you re-validate this on your base-commit? The base-commit is after=20
ff448fa9a1b8 ("u-boot: fix error check in eth init") which I believe
evolved from a patch that looked like the above at first. Thanks.

--=20
Tom

--XeVcSyPu2PzTY5pU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat9j3gAKCRAr4qD1Cr/k
Cg5RAQDdvihgBZssZjoTZVGBD6Xqq0/ye3J9bRUvZwT/ssBCPwEAsOcJ9drJFMmY
Dg+YeXMVZ4Je8v+GQ7uIKMC2xrnrUAg=
=2jsD
-----END PGP SIGNATURE-----

--XeVcSyPu2PzTY5pU--
