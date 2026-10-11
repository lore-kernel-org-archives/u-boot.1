Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97199CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 542FA80C33;
	Sun, 11 Oct 2026 22:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbUfBiiB_q3Q; Sun, 11 Oct 2026 22:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CB6280C06
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791756202;
	b=F1IkTWKe3mKR/n0jBWl9pawM6NSboFWU6wyxUAY12WvQOP76bL5CYcPji9pgrjDec8qR
	 EsercSKBGpYk2QmUtbj4eCUsx3yycVGV3QBdBJp3G+846bp4nDsptjyGKr7iDdykWIF/y
	 vd7MH4J9Fh5REyhAYsAvpCa6nnuMIJd2AyvA77cHX1fz+qLV1slbxYw2ZAnedeOSbVK27
	 jy+9CehQnkb5jdVVF3N52qia8eMMIZj9l8rOXhDI0l9CWBCJMCZZJmiMJrkzZ7fqr1a/w
	 OopR4XkoTnsxy17m+shi3xWOaxs8u2fhxO+jABDS0+1mdJ0d3/r2jWWShAbVa0yfOnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791756202;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YD2wWwK2ZoNVeC0w/6P/eu59mzxCicevJmD6GfgZun8=;
	b=pQyrnMccl+Cv7ZOmdfOgAojhgmfBFU8WrkkV0W3fayZB6RExGv8T/C83c4kbscc/Z3rK
	 c+ZrCmxu8mWhhrwNj1Grc0HBIH5ih0CSTII0byVY9b0OtYLE0nI1f8LvR6Jy7OHvUzLQ8
	 JxtyD7ZNQr2ExUoze+YK8S3Vu2RwaFKKZB7ruVJAJAHsIocyZ0wFLr5hG9v1eqXzTqE+8
	 XEaIDm/0rtSbCHLqLewITfMIuAAfuwLV4BRu/NfFMSlr9UyK92/7oHKISRgz6kDVlmkub
	 R8LxyFg5SBHumO+jctxXSphmbYk5e2vDUAewKlsjUlI8Pt6/UafAArMCkM+j77BhzAw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="OOB0IM/u";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791756202;
	bh=YD2wWwK2ZoNVeC0w/6P/eu59mzxCicevJmD6GfgZun8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=px561+p6GISl0zlZZeALv7src+UIj5imi3iOp0pZCx753brhQ+GcnN8OE4aVoBfW5
	 qlHr6XQZ/90LKioa272rTshGMqqAnCdOBwmB4SraRGCYak/l2usDTxcgwdpdLtmLOg
	 JORHatwynPvWdMKmsqzqcv7Vav3X5Weam1R9HMvj4lskKcqI6bMsPtYd6OIcL3JN3N
	 vcNyQuiNJD4gQcmBmjAKF1h6PpnFOJ2bG0MXri0oHr1ssgFrgs5oj8UyQ0ydY9Q+HD
	 N5vBE1tQX5zMcAk2ZxnMRtCZp/9xUh+CV/PaacH68R/Hh9jlQyCB/sge4+gLHyZBQM
	 HtbfXTouSUp8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CB6280C06;
	Sun, 11 Oct 2026 22:03:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C86C575
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE48A80C06
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJHSJLY86_93 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4C4780BBC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791756201;
 b=iCC96R3K0FtOd7TfCH97CVtwgOUF32fTrRoj/9J6jT435hCZYmOuZzO59AUhwEH6ERMb
 owB4GCJ4WPzwO2E1aZ4Pi23tcVTmfyA1UdjwrUOEWF6MJdiorl1XiZBgVrnXukXXozz4S
 TVQ0SuW7E5Xdst5PohXyV2G7DzVWQnMoUH9m4x5jN7iW1Ge/3nm7y504gD1xN/i3cnxHZ
 zFOs/c4woCwSlujZEGHKz8TtHfznv96k8TfaE0fQ+3tC6VMu5vLj6e/crKmv2ZItnJMh0
 1v0PEbJx0Hccwxx6tDGtkGQ7SkRa3Gb8RkGE88oxXEitUJT219+pgLv3RzrRsOmwPaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791756201;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=YD2wWwK2ZoNVeC0w/6P/eu59mzxCicevJmD6GfgZun8=;
 b=gPPJVlqZhPgvO7xKUdvycswpmq2orOQQGp1Antl4OSRa/hsaKEyYsoaZ2fOGrO1wEnAY
 k7/8JOjbtx4SJEefAL5Xf9l0xb3RP88a4Exc8kG/xqJEtBQXEVa/i6OAMzbS1nLK6lSLq
 fXJkayrjD/kR9o6YAeaKsiwC6QueR0b+4Ul02y2NEl2brbHAnJxQAphU/yucfV1TciOZJ
 BCcOAcI7FSncE9ANAF0Lvzn0LxpmvgrlzCjAdJQkHS8HJRvMkIFKxtbM3PvMXGHwPlQ9Y
 iMQj/V8lTFTnmCF7h1keyaaCvQ9WqERCAruaglLWW+eNKdCwP+g3YHwePmTHpzLf7xA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="OOB0IM/u"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OOB0IM/u
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4C4780BBC
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:03:20 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6d00d120b28so910567eaf.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791756199; x=1792360999;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YD2wWwK2ZoNVeC0w/6P/eu59mzxCicevJmD6GfgZun8=;
 b=OOB0IM/uau5hRfHF5G8mqfx3PzJ4WnfRK8EBqX+xZwM8pbtUh+ugyZN8pcJ4XS31qd
 4LwOCpv+Us11REFYdBks+X2HfWJIlbYrtnxrYdNvzBeijqc0L2CcDko2vYmi4gt/x/+y
 e7ORBSe5RweIuH7mBxdG24O+T96OGjFJuwEN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791756199; x=1792360999;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YD2wWwK2ZoNVeC0w/6P/eu59mzxCicevJmD6GfgZun8=;
 b=F2TTbHTAuWXvdfJLmPIZwvweDz7SdV91cY/Ku87RrTpfcNm2WlcAh3h/aWQLKEnORu
 VqZ7IQ5YU4Nz617w+MZgfQouP/C9Yli9iVBMAF8HoqexS98srHNKynBqgyfnmfuAJPKO
 rrKJtTKUstgkviKypmnVbrRusJKqfu15gmpf0s0LDje4TwxS1D3u1vQOLPOp/WkIk81Q
 aTzJHQFMDWDn0DyGf1L1cwTOpnCvsZhFCl4KTUsMtW4oCb0VUZhBv3G9h0w6x02/1TAq
 n95wjN61EFr9KB+yXxx3F2vfVkNUwi1jweSIIRE1SYQWUbHNkflEqaTqiKsrmyrT9ogQ
 PGwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6JDTJi2Kzu1Jr+yM/Pxu0dfaTibvOpVgP+vzeq5LK4FUqFPtyyqDqHwstGZq0A25kc8E++1k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIHU9ZaCp0jqoIcZyBAln1c+vIb6r7og6SHlCPSXRrmmK7LoioX
 zdaRLSGnMSzjrrL+9kRCBB7jkC/gf4bmB7ssqqLHt+ajtstALiyVAgUXR4WVjiKUQ4E=
X-Gm-Gg: AYBFou0G2IDNY0Amko+sAhaNibkUnyLSODd9xVvdBqKhAe6G1rJR8UIHZjNeXhBsDPR
 Mzb26xMaxTTh/fJ5Qd2dAWyQRmP96klCAgRT3AKJZjJkYMGd62t0LV5VzCw+G+jnCKVtqT4yrtd
 FIRp8VprKPrDq1mvfxtgH5+zoBgSa2qwbtuehzvnEnnppX8INSiYmzq3TkmYsjpsngaPZHoOOOG
 rQrN6xYUa7HuqgNszFQdHTdE0qLzhivrm5g0dZn8FEOG1kQx7rPyPoDCI9v3KlMe/caB6D3qe7I
 bfqtA77UvovXHWNP8zjo8bKkqBcSMgKWuyX+3TNrxxNaFCzU5gd+zdLU4AWgdypXc22fbEkMB2a
 iYIXpeWIa4cUDZJ1gLKD4EcxZkVJBrkNYt6Twjoj5S0nz+ShP+4Y6xLBMDxd4AEk/B28/G8F295
 spGwdKJi7/5IumoZaLpQZOU2g2aVJ4P/WkEtgYM9K0f/l1CR2vUYMa1pW9HIvY+zKXObGfJiPFk
 vJsoenRwHJxa/ZVzguQaTaCrbNdFP7jS86j6jLuvwHjMsC271FJcgnZ7ncP6xm1y1KOLt1niJyd
 yEZ4rFhhZnAO8lWi0xc=
X-Received: by 2002:a4a:edc6:0:b0:6c9:80d8:a1ef with SMTP id
 006d021491bc7-6ef0eebcb97mr5748657eaf.44.1791756199562; 
 Sun, 11 Oct 2026 15:03:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm7611595fac.11.2026.10.11.15.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 15:03:18 -0700 (PDT)
Date: Sun, 11 Oct 2026 16:03:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@nabladev.com>
Cc: khaliforce <kforce@gmail.com>, Romain Beauxis <romain.beauxis@gmail.com>,
 u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
Message-ID: <20261011220316.GJ769217@bill-the-cat>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BdlOZ9cHqdEtbn8V"
Content-Disposition: inline
In-Reply-To: <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
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


--BdlOZ9cHqdEtbn8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 05:16:41PM +0200, Marek Vasut wrote:
> On 10/6/26 6:10 PM, Tom Rini wrote:
> > On Wed, Oct 07, 2026 at 12:58:33AM +0900, khaliforce wrote:
> >=20
> > > The generic OHCI and EHCI drivers provide remove callbacks, but do
> > > not set DM_FLAG_ACTIVE_DMA. Their controllers can remain active
> > > when U-Boot hands control to the operating system.
> > >=20
> > > An active controller may continue DMA after the operating system
> > > starts reusing U-Boot memory. In particular, OHCI may continue
> > > accessing its HCCA.
> > >=20
> > > Set DM_FLAG_ACTIVE_DMA on both drivers so their existing remove
> > > callbacks stop the controllers during OS preparation.
> > >=20
> > > Signed-off-by: khaliforce <kforce@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Use DM_FLAG_ACTIVE_DMA as suggested by Neil Armstrong.
> > >=20
> > > Retested on MangoPi MQ Pro with the downstream D1 port based on
> > > U-Boot v2026.10 and Linux 6.1:
> > > - Read a 64 GB FAT32 USB device in U-Boot.
> > > - Verified a 4096-byte read against Linux using CRC32.
> > > - Booted Linux without running "usb stop".
> > > - Confirmed USB reads, Wi-Fi and SSH after the handoff.
> > > - Observed no panic, Bad page or failed services.
> > >=20
> > > Standalone builds pass for RISC-V64, ARM64 and ARM32 on upstream
> > > main. RISC-V64 QEMU boots. Checkpatch reports no errors or warnings.
> > >=20
> > >   drivers/usb/host/ehci-generic.c | 2 +-
> > >   drivers/usb/host/ohci-generic.c | 3 ++-
> > >   2 files changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-=
generic.c
> > > index 1ae3619ce25..57f1bcbd9c0 100644
> > > --- a/drivers/usb/host/ehci-generic.c
> > > +++ b/drivers/usb/host/ehci-generic.c
> > > @@ -167,5 +167,5 @@ U_BOOT_DRIVER(ehci_generic) =3D {
> > >   	.remove =3D ehci_usb_remove,
> > >   	.ops	=3D &ehci_usb_ops,
> > >   	.priv_auto	=3D sizeof(struct generic_ehci),
> > > -	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA,
> > > +	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
> > >   };
> > > diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-=
generic.c
> > > index cc44226f5e0..7493750f8d1 100644
> > > --- a/drivers/usb/host/ohci-generic.c
> > > +++ b/drivers/usb/host/ohci-generic.c
> > > @@ -110,5 +110,6 @@ U_BOOT_DRIVER(ohci_generic) =3D {
> > >   	.remove =3D ohci_usb_remove,
> > >   	.ops	=3D &ohci_usb_ops,
> > >   	.priv_auto	=3D sizeof(struct generic_ohci),
> > > -	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA,
> > > +	/* Stop HCCA DMA before Linux reuses the controller memory. */
>=20
> HCCA is communication area ?
>=20
> > > +	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
> > >   };
> >=20
> > Ah. Perhaps this is also what Romain needs for fixing the problem they
> > see on an Apple platform, and would be more palatable to Marek to apply
> > generally to USB host drivers (and switch the ones that use
> > DM_FLAG_OS_PREPARE today?) ?
> This works, but maybe we should instead unconditionally call usb_stop()
> before booting ?

I believe the answer there is that we have flags to handle this problem
generically rather than hard-coding a call in every arch's
boot_prep_linux or similar like we had to with the old USB gadget stack.

--=20
Tom

--BdlOZ9cHqdEtbn8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaswHoAAKCRAr4qD1Cr/k
ChFzAPwKXgb/PsJT89W+1fb6temC4TzE4aSsOD89v8lIrGLRfQD8DFoCv8w8Sb4J
gkjECktFGjJzJuOoJia4UpHd9uU0gAw=
=dugF
-----END PGP SIGNATURE-----

--BdlOZ9cHqdEtbn8V--
