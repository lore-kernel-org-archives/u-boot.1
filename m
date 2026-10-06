Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA2BCA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 16:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C7F9605AD;
	Tue,  6 Oct 2026 16:12:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SyWvE4N83QF; Tue,  6 Oct 2026 16:12:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 749A26076D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791303143;
	b=m7TyM1H8oO9PjyEEt3oDN2QBsotVz+nwl9a077NLMJ8/5trL3qrbRMPP0DRjhdwiOhZx
	 GaZdh+MlOxDb+LsTX8vecAavxB14G2lbXxdZ6I2jeQjZctFMLkpWNckAQFoHKW56H4NWO
	 JFKvTi/xFfDYeRJwcmvE4Cs080RgIKYDe0o08LPsJFqtbacRIOv7OjAyhrY8MQTDA3bOM
	 E+P3PfHow29bw1FI+V1m+5D1ILuQCwSZHSHH4pK9/FGtaqcQ4a21JRoxmcho84fB+isvr
	 2M6ujJ+MAf5o7JHaKGl9WwjTBtuCSe+f0FhWKH4DJ3lOGfA2MNwQD6iP/HKVia+R7NQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791303143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wFYV9ZnN64IsnyB8LfWNSpSCKRRtSW0d6VBqA+nwcGs=;
	b=m+RW1/sWpi2K8/zWkKisUK0FgT1qHZ3q57eHwfsanMLbLnrXXWwzg0jMidjuLwj7y4Fs
	 d3l1yJM8NWmNzlA4+gXoolxMpuIRnrE4i41uhbHA6zHAF89Q8KFvf3oC0abHmjRoS25aW
	 flmIxTfRS0WQQQKzFRHklPW5158GW/SHxak/Z13BPnSypaQtyTlGhp+xrsjFsCMkcEBip
	 yAT+U3ns9p3/5VNePW6n/ZbZTJETS3Xmdf1oSHvjQSDQzpEHnQ6yQukHEq4TepMkIqKBC
	 ClTxFG1nwY+cAX94DpDEuSLTyPSkhAtzqrhWOvxabOn0W/nCMnEddH2NhCRYJbubaeQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791303143;
	bh=wFYV9ZnN64IsnyB8LfWNSpSCKRRtSW0d6VBqA+nwcGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dD5KV0XNSB7ADU4vCMst3mPeV8a6c8nCi3Am5MWIC0IL+q8htzHnyk0KP2BHmdwTz
	 517Paaqap1cxwB9xVrvHt1HqWkjzOOsiPTbkipoFnswLK7Ruoqay1NNRoS/d7Yw3rw
	 GxZ/HNa5DjyS9mOd87UBfLR0k5jO0TlAKYnTYPA4DoTMxKXE/Pn2GQp8H1tW4XyhP9
	 F46lmbgq9/0xl9veK9RDNkvjqlDb2C13RLNA57pBimsP7V5hTqQIPIOJ7970bxILLd
	 r7nNJ4IBVWqXhOTCCaRcmiD6upcsT5SA888w42oevIy4yTPMsG+JzmgQ1hbAde3o1l
	 Zu42Kwf1FDvUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 749A26076D;
	Tue,  6 Oct 2026 16:12:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 660491D2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 16:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 574A980CA6
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 16:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUuYvDcV59F2 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 16:10:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C003380A6D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791303022;
 b=IdKZlTzqB6B/b6BZGi7d855bzm/+C2AAdVN7J4yX94vxrwn+zYlXVGVr0+z/tCC59xGk
 NFFS9IUhwSLL6pvzOcmtcMdgZDDiX0CROQoeHp+Ql3SjGfCcbbJhihExhOgLyW3XPvYNS
 urRn2bHTlTkiz7H2156/RdQqgxyFg9A8Zx9jOgDLoJ/4W2uRHDCLTzGIN8RMdd9QNu10V
 gbtbjb1Cj5RtVuKCQcd5JCZ1fXikd9rIrXs9xf0mPgyhM7cih++nkevqn6amWnYQBxFsc
 9AZIHVppm8p6Zr6Lu09BuN/q2p99gdyjKnpDZPSEzcQCfsNVSTH6tM47v4+Rq1Ds9cQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791303022;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=wFYV9ZnN64IsnyB8LfWNSpSCKRRtSW0d6VBqA+nwcGs=;
 b=I5M15F3YC5y0WN8p5QPBQw1KLQxoI+KuROQTsaBrOIq9Kvdcw+Bfhj+NQqWnGTaRm/SK
 ABjIAzf0PRNsCwNXVFfuHzzICJR6IjCM0e67glVGUFWO6SHZZt5pCd+Vm5yCFSCi8AFkj
 8tiuBV7/+XXRYhd7yvht6F/tO+J9kVfz9Y3eAeLxsSvSx0Mhkyy0VsVfCbXFSQL6rq97K
 8D9RfJyqoXS+jHnT2J8lUjnt5Fv98EGVnFJ1rhBpuLQSO9ya7Vn32PA41//PNtGIOKMEr
 7pgiSWrYTfq58Yit6/3in8+Ly6f7o37sq2808bEkPsU4dKTYGPW5QJRro0ezxQAABSw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=O8YOSDEz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=O8YOSDEz
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C003380A6D
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 16:10:19 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-825b40f8a26so402692a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791303018; x=1791907818;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wFYV9ZnN64IsnyB8LfWNSpSCKRRtSW0d6VBqA+nwcGs=;
 b=O8YOSDEz2jZqNLts0G6nXQJteHtrKJspLoT/QvCXQQZW8MMpN9SdFgZYpQh3DCKrUg
 BhXAA2MXwseCz8Yh/XQvE5v6x/4+FJ/rVIR5aeJgkFedvyNPpk63mlhln7yU7e7NE11I
 PdGbq5bApX3JA2lfYcAao3Z77ywR7Daqxc8Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791303018; x=1791907818;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wFYV9ZnN64IsnyB8LfWNSpSCKRRtSW0d6VBqA+nwcGs=;
 b=I9YAIaUGpc3l8e6nNqCTWTDDoZlManNaARYD7XtBe92jl0VrQ6GNoJRSGgavjbTzAX
 rPyde7lqIDIAeJxdyrhSGaXcT5nlBNwxHrGd7xzBzL1hfZx22+40af/VQ4AmEvZP4Ws6
 E3taooPh2R+S75uAYux27s0KLfgCkU3v4scIhI4/kWblEtv7efM/Sx1h2pZ+XYnRLiBI
 OLUEBziYKFro+0FQ2L33F5GHQJegX85G2D6VMN5ynsit4qCNvPmKKkwvInTURSYgMlJ9
 LLmFQxqqJIYatDHwW2Wh1TnFu6WAoFZRif7LLqC0u2FK9QDbTCeHJDP1E7JMW6SvT0j2
 ur0g==
X-Gm-Message-State: AFuF++n04Jg7unUs66U4kxWxaz5ZV9SlW5N/xqXONzvojNVQKfbsPJL6
 GTGBQ8PRJEfGzBW5uIUbYAny5np+CTIb8cHZKsSMvG2ZjXBUVPZLtBrQspg2w6Ol3uo=
X-Gm-Gg: AYBFou05KLHR0bFSfQrl9QURHIjs3BzswZKIkPSfoRVa1w2ctO42SJi2x1KBtZM2kDV
 OFG8j3z09CNMD5QTmXaNMYf0zQc/lh67TCKskJQn+IZfXzGKmpG0oVIjgBF/0VG88KvbwxINwqk
 HJCwVEx5Ar/O8Il4SO10Tml+ejdgwQifapnZkNhuFZafU57VbZ9Hri2uk/zyYn5TLq8hBvQPSsH
 PkkSP2Y4Of7XEFX2fMLexG44VmLIn8prswGzSvC2pedhbgUDGCUHs/sg7udX6gj0uLLrswjgEQW
 DqirCsZb8YnZeJz0yAiwgPfrGC66x+ipvvfHzehcCDcNNbr+soA9qBfxWWDp7yV837gtH3J+cfh
 r/Ttvg+6GEsVurASAwg4X/2t99KBdV5dFluxMiShCWT3M2cVC5sE5/DfoYiCgHRlNZgNsZxEcOw
 ARQEnUuWRk0K0iEExv5x0pWMX5TVToL0AGA7lZevTePwuDTwAufvX7ISn2yOHr5VlwaKuS+SqWx
 9eTZeJbSslyJBZNO23V0HkHj9iUY9HuP/AJfmGSMt0FRMOCSGK+dy4+r5ZoB0Tv3+VY2Vg2ptHc
 Z3OU6x9LmV+p/9krFmY=
X-Received: by 2002:a05:6830:83ae:b0:81c:ab45:3040 with SMTP id
 46e09a7af769-8289f1256f7mr1737307a34.4.1791303018346; 
 Tue, 06 Oct 2026 09:10:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8281fcce238sm2967730a34.6.2026.10.06.09.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 09:10:17 -0700 (PDT)
Date: Tue, 6 Oct 2026 10:10:15 -0600
From: Tom Rini <trini@konsulko.com>
To: khaliforce <kforce@gmail.com>,
	Romain Beauxis <romain.beauxis@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
Message-ID: <20261006161015.GB1356209@bill-the-cat>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="682OyRB4WOtOuJZu"
Content-Disposition: inline
In-Reply-To: <20261006155833.68374-1-kforce@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--682OyRB4WOtOuJZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026 at 12:58:33AM +0900, khaliforce wrote:

> The generic OHCI and EHCI drivers provide remove callbacks, but do
> not set DM_FLAG_ACTIVE_DMA. Their controllers can remain active
> when U-Boot hands control to the operating system.
>=20
> An active controller may continue DMA after the operating system
> starts reusing U-Boot memory. In particular, OHCI may continue
> accessing its HCCA.
>=20
> Set DM_FLAG_ACTIVE_DMA on both drivers so their existing remove
> callbacks stop the controllers during OS preparation.
>=20
> Signed-off-by: khaliforce <kforce@gmail.com>
> ---
> Changes in v2:
> - Use DM_FLAG_ACTIVE_DMA as suggested by Neil Armstrong.
>=20
> Retested on MangoPi MQ Pro with the downstream D1 port based on
> U-Boot v2026.10 and Linux 6.1:
> - Read a 64 GB FAT32 USB device in U-Boot.
> - Verified a 4096-byte read against Linux using CRC32.
> - Booted Linux without running "usb stop".
> - Confirmed USB reads, Wi-Fi and SSH after the handoff.
> - Observed no panic, Bad page or failed services.
>=20
> Standalone builds pass for RISC-V64, ARM64 and ARM32 on upstream
> main. RISC-V64 QEMU boots. Checkpatch reports no errors or warnings.
>=20
>  drivers/usb/host/ehci-generic.c | 2 +-
>  drivers/usb/host/ohci-generic.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-gene=
ric.c
> index 1ae3619ce25..57f1bcbd9c0 100644
> --- a/drivers/usb/host/ehci-generic.c
> +++ b/drivers/usb/host/ehci-generic.c
> @@ -167,5 +167,5 @@ U_BOOT_DRIVER(ehci_generic) =3D {
>  	.remove =3D ehci_usb_remove,
>  	.ops	=3D &ehci_usb_ops,
>  	.priv_auto	=3D sizeof(struct generic_ehci),
> -	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>  };
> diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-gene=
ric.c
> index cc44226f5e0..7493750f8d1 100644
> --- a/drivers/usb/host/ohci-generic.c
> +++ b/drivers/usb/host/ohci-generic.c
> @@ -110,5 +110,6 @@ U_BOOT_DRIVER(ohci_generic) =3D {
>  	.remove =3D ohci_usb_remove,
>  	.ops	=3D &ohci_usb_ops,
>  	.priv_auto	=3D sizeof(struct generic_ohci),
> -	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA,
> +	/* Stop HCCA DMA before Linux reuses the controller memory. */
> +	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>  };

Ah. Perhaps this is also what Romain needs for fixing the problem they
see on an Apple platform, and would be more palatable to Marek to apply
generally to USB host drivers (and switch the ones that use
DM_FLAG_OS_PREPARE today?) ?

--=20
Tom

--682OyRB4WOtOuJZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasUdZAAKCRAr4qD1Cr/k
Cig0AP4tb4PE3meTTj6LV0IILIkWgykfwRD+iP2FTFtEJAJ5SAD/fSKdM1YlhlDj
Rrl/mefR3cPJZoMeYcJL9kgCCDvHzQ0=
=pQMt
-----END PGP SIGNATURE-----

--682OyRB4WOtOuJZu--
