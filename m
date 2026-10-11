Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577ABCA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 223E380D09;
	Sun, 11 Oct 2026 22:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l7pWlXwchdXW; Sun, 11 Oct 2026 22:31:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20CAF80DFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757906;
	b=ktp9nglmTvxS3xxFZr7TWyu8a21H37li1oPMiQ0F4HlZ1Ebp/3tXuOOlJ66NQ9FPb4Ti
	 PrRXf2s/jHBnJBxR3OrgU4gWeKoZd0ZFekFZYBlFMlpIXcSigGQID2oOWpj/eTSwjpmT3
	 /XiiP5L9bM/FTGJ2tUVJclpCQZbv9QHFetkZEtjJQeMgBBEEhkiNNEW8JeBXf9zXuDXlf
	 ktqEfqH+olcESDJ175MkXOfNXyBrDn9ueplIMVqiJFSPSXUjmmlghhIWtlqEnT/N2+Odw
	 7zncuTyJmYit+P68e068W8GuFE7DW4MCWugMQrRUqPrYO6+mY1byn9aI3r5PWmwhpCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757906;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ghZoDL9Wje7AAhsmi42qNZHuJP5iaEMbFlZagD+WcsE=;
	b=dsFNmWk2CQ7rfMml+/SoYYt2ejKeXskgbdsd5/7k1eR0U2aEWhNz9YC+3XvhzpVQod/y
	 W4gsllrR6ohrL+g36RbBeLvhNXhxZM3aZr3jg0eEJjCS7xpgqPcgubyfN7OTUOIMDKQb0
	 akjEgTORe/LeE7s973PJZpTXr91F0Hhst69GPAC/BjIVyoq4IKj7Cs68iuaGeabMumvbj
	 8HQBz7eBOGnutjjx7i2kdmtCYkFwHUALcC4FNrOx1/syyIz4t1qYOkI3JNEnWexKofPLR
	 rhQe/hB28BmBdjSdrGKtAleCvirgceiCjZxkI5HxAMYoJjiixpmGvex388hSPExTEww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pef+PQU6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757906;
	bh=ghZoDL9Wje7AAhsmi42qNZHuJP5iaEMbFlZagD+WcsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cli0IpbPwFC4XDDc9HfWxj7lP5ow0+0gJ7pr7Zwqevb+dW9w/PZFjVZojzSgUQC+3
	 lq+UASIl7UdsxbCHZZRDgQHxSqIpdQnbtK4UyZdpu4hVDE8vkxzo71N3RsX0IKAepN
	 vjUCW5pgY4G6ytJ0pSHTvH358xLCa/1qlOPEqTboK0VWK6zuaXm4cwmendkIv9x69b
	 iSWzEB23q2qTN6Ry8CBIJFZ+piSCndQ5A94vfKounW2sE+518cfhCFUTVD/CZqJsvL
	 JXZ5MXJvqK9moOdMufDpvn3Dr4T/BCt1+9Qt4bLSZuDiO4AoFE6k2kV35pNGAGaHfq
	 PKRon61Q1fczg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20CAF80DFA;
	Sun, 11 Oct 2026 22:31:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D5A11DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F03980D21
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUP_FObxwnUF for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5230280D7F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757902;
 b=p2/KzcEfOXTc/vSU2B2GtonUd3JPB816BwAbMtj+FQnsTYPKyuiiq1HHTpDY7/HupWM1
 ffTz+tYVRsAFXrQsMiGoDNfgDj7Y6/Dw+IvHzjvYPipKXGmYoODNsnt6MC0DoBC9WAAGo
 +C0sZuy4+sCPTPwgYUypUGzFG4I65sndMats44EEYTqy6lgJiciBU16R/1g0XR48E7n3c
 YHaz1WYJbWPgFNcc9VpiZ+hCpePBEI8MedfKhlGXFDt6FqH/2+NDOExcwIjPSyWdJeYH9
 rrIy7gAN4Gn+QRgNgXXAB2s+vYDA2KKvnGQopYMwGLetisNPNACu0yNiWzP2vkGXpcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757902;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ghZoDL9Wje7AAhsmi42qNZHuJP5iaEMbFlZagD+WcsE=;
 b=gt+kazoTbS2evUK3s5aE1WimPnZEBWmCxxQvdqj6cLFABfkqU9iAXderetdqNVxZe6rz
 Fq2FUxBl/WKp1azBy0efaKCWyJ8/OxePFJYxS8uCGX4uwf27/Kwok23kj5RVSsDQ2dW7A
 WutPUlGf5m9WEj3j6w0h79RNQodc2zAmeYcu9HZ2r4Xu1Q1N4luAIuoIUZdn9+K1JxEJ+
 BEVQaB5j+axr/p/ATblX4eaSo+PllbGJOcfi5hzKGCwt0j4Cd06A9DSjCGubbH8yJu7N4
 D1bk6WLZGz3WZJCfcGXw+xUZ38C9Tq0QM3HJLV6pnIU3K0p3KJwB7ZcN1LvsXrOdEEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pef+PQU6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pef+PQU6
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5230280D7F
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:41 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6cfb1329979so923173eaf.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791757901; x=1792362701;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ghZoDL9Wje7AAhsmi42qNZHuJP5iaEMbFlZagD+WcsE=;
 b=pef+PQU67HygXFmYsJ/D2Com3q7bbTyoVzNp/w+Ipr5TeNYbPtj0ONuR3Yr0lk7hDo
 /jSSXlg0m5FhLEO/DjYjqHX7JKstR8+4A0vZMk28wY6HYyTvppdyIW6uVUCTQcgCsfuk
 RmiCEJbAZxXMs7lVlY4F1fNSzR5tkFtMkQyeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791757901; x=1792362701;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ghZoDL9Wje7AAhsmi42qNZHuJP5iaEMbFlZagD+WcsE=;
 b=RKzYjKQGQgkcBDVL1wSSh2S2ASq+7nWYxOC/Bh0WvFJrDY+VkdiNX6mlDdNtRtqMzX
 ERL5R6WkPv1cE/uPH9w9qRuGBAwKLm3X15HliOIwyig/Os7QKP2Q31FN85lTgHWXeWg1
 VKVUaPglwcCMFkN3Jf6RKXGJZm+Sc7HtVev5w+d4ictW1hukoq8kXnBqbtGr72Jn1XEP
 OqIoYximrb5d0R08HVHl5zC3wD8w8lGBLd3dmUQJDwZmyZnAkybnF0WIgzCv01Gjh0uQ
 PWw+Ri4OkN/qAggx4A3Kecgl6VN9rgwWnpyzU4Wc6zdFls8wlsBSil12vbhf+5flEr9o
 SC4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6Wy37mVLvlcZkNKaNpBpYHTIW1qrbPn2CRyddCuKoLdJW4io6vN22NLRVaj/KV2L/GIRyWrc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLt7YqO+YFAIBB9Vzk7KDO7kTL8dQnPOeCjG4uHjY/Hwsl1zXhP
 QdyXMFRK5c0JpINNrtGFGJDizsZiNjTQivwmmt0BqIZ+CQjJhUydry5VjuVwzwBShwLGNgALTON
 6nWqpUYRM5loe
X-Gm-Gg: AYBFou1XIV0yNQKO+aEAWPKqmLNCkM9SgtlIGGDfP0g2MSkLWZLNUkbgmvGCJEZdEPG
 KmzqLqWi6/Kez43B20rfNWenI7pdPqaZztR3HSv1tW2+EcOPA6x5VEIow1qrUTa6Qn3TJBFqdO5
 7JyT55DaFVMptObyHQGC2nstAvHsCuk1xXIaoAvUTY1v9s390M9aM31+JGTsCwWJJT1QKwZGCiT
 a4w+L4SBGwpX8krGZmXYn5qdDBNHZ63EpvXTC/jSN8OxEq3gROf+jLHPij4yhCmxPEoYz9kM3oG
 zLvpH5l9Qi3ReP2vdL3Rmz+KFBWw+Dr1juc+kbPAN9v4BmKT79N7/7darbVHBMmHvjqVCYGvJ3g
 zDFNM+dSpaYWSuWISnJKJFDXku7P74kVoK9JBcTST9/P4lRRVn37f1ZBVYVLrp8ObEQypYvgygj
 a4QEUXAcCORbFZZqJQM3w3GD6wJJjjrLhWYo2l81RynQ2jNREJygJeOU4wafzIsQZMS0Qbq17mP
 YlSx4fhN1NllnB748aNLuXLGxBzW8L68b+9vscU343cFveE1HazLxnxshLA/WCe7jAzw1CjJ/ro
 l3ySsFAlNmd6Cbouu5UR
X-Received: by 2002:a05:6820:1507:b0:6d8:8626:be96 with SMTP id
 006d021491bc7-6ef08c7c9c2mr5954409eaf.1.1791757900943; 
 Sun, 11 Oct 2026 15:31:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a84a20aasm8053581fac.5.2026.10.11.15.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 15:31:40 -0700 (PDT)
Date: Sun, 11 Oct 2026 16:31:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@nabladev.com>
Cc: khaliforce <kforce@gmail.com>, Romain Beauxis <romain.beauxis@gmail.com>,
 u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
Message-ID: <20261011223137.GK769217@bill-the-cat>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
 <20261011220316.GJ769217@bill-the-cat>
 <489e6811-cb25-4085-8077-427100154182@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="32OR3FZ7MouiiHIg"
Content-Disposition: inline
In-Reply-To: <489e6811-cb25-4085-8077-427100154182@nabladev.com>
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


--32OR3FZ7MouiiHIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 12:24:38AM +0200, Marek Vasut wrote:
> On 10/12/26 12:03 AM, Tom Rini wrote:
> > On Sun, Oct 11, 2026 at 05:16:41PM +0200, Marek Vasut wrote:
> > > On 10/6/26 6:10 PM, Tom Rini wrote:
> > > > On Wed, Oct 07, 2026 at 12:58:33AM +0900, khaliforce wrote:
> > > >=20
> > > > > The generic OHCI and EHCI drivers provide remove callbacks, but do
> > > > > not set DM_FLAG_ACTIVE_DMA. Their controllers can remain active
> > > > > when U-Boot hands control to the operating system.
> > > > >=20
> > > > > An active controller may continue DMA after the operating system
> > > > > starts reusing U-Boot memory. In particular, OHCI may continue
> > > > > accessing its HCCA.
> > > > >=20
> > > > > Set DM_FLAG_ACTIVE_DMA on both drivers so their existing remove
> > > > > callbacks stop the controllers during OS preparation.
> > > > >=20
> > > > > Signed-off-by: khaliforce <kforce@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Use DM_FLAG_ACTIVE_DMA as suggested by Neil Armstrong.
> > > > >=20
> > > > > Retested on MangoPi MQ Pro with the downstream D1 port based on
> > > > > U-Boot v2026.10 and Linux 6.1:
> > > > > - Read a 64 GB FAT32 USB device in U-Boot.
> > > > > - Verified a 4096-byte read against Linux using CRC32.
> > > > > - Booted Linux without running "usb stop".
> > > > > - Confirmed USB reads, Wi-Fi and SSH after the handoff.
> > > > > - Observed no panic, Bad page or failed services.
> > > > >=20
> > > > > Standalone builds pass for RISC-V64, ARM64 and ARM32 on upstream
> > > > > main. RISC-V64 QEMU boots. Checkpatch reports no errors or warnin=
gs.
> > > > >=20
> > > > >    drivers/usb/host/ehci-generic.c | 2 +-
> > > > >    drivers/usb/host/ohci-generic.c | 3 ++-
> > > > >    2 files changed, 3 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/e=
hci-generic.c
> > > > > index 1ae3619ce25..57f1bcbd9c0 100644
> > > > > --- a/drivers/usb/host/ehci-generic.c
> > > > > +++ b/drivers/usb/host/ehci-generic.c
> > > > > @@ -167,5 +167,5 @@ U_BOOT_DRIVER(ehci_generic) =3D {
> > > > >    	.remove =3D ehci_usb_remove,
> > > > >    	.ops	=3D &ehci_usb_ops,
> > > > >    	.priv_auto	=3D sizeof(struct generic_ehci),
> > > > > -	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA,
> > > > > +	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
> > > > >    };
> > > > > diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/o=
hci-generic.c
> > > > > index cc44226f5e0..7493750f8d1 100644
> > > > > --- a/drivers/usb/host/ohci-generic.c
> > > > > +++ b/drivers/usb/host/ohci-generic.c
> > > > > @@ -110,5 +110,6 @@ U_BOOT_DRIVER(ohci_generic) =3D {
> > > > >    	.remove =3D ohci_usb_remove,
> > > > >    	.ops	=3D &ohci_usb_ops,
> > > > >    	.priv_auto	=3D sizeof(struct generic_ohci),
> > > > > -	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA,
> > > > > +	/* Stop HCCA DMA before Linux reuses the controller memory. */
> > >=20
> > > HCCA is communication area ?
> > >=20
> > > > > +	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
> > > > >    };
> > > >=20
> > > > Ah. Perhaps this is also what Romain needs for fixing the problem t=
hey
> > > > see on an Apple platform, and would be more palatable to Marek to a=
pply
> > > > generally to USB host drivers (and switch the ones that use
> > > > DM_FLAG_OS_PREPARE today?) ?
> > > This works, but maybe we should instead unconditionally call usb_stop=
()
> > > before booting ?
> >=20
> > I believe the answer there is that we have flags to handle this problem
> > generically rather than hard-coding a call in every arch's
> > boot_prep_linux or similar like we had to with the old USB gadget stack.
> This is shutting down host, not gadget. And I believe usb_stop() is
> necessary to correctly shut down the devices on the USB bus, while the
> DM_FLAG_ACTIVE_DMA flag is necessary to shut down the controller, so both
> are needed.

Host or gadget isn't the point here, it's that we used to hard-code the
stop function call for the non-DM driver and now we have driver model
and flags. Everything should be able to properly unwind with flags being
set.

--=20
Tom

--32OR3FZ7MouiiHIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaswOQQAKCRAr4qD1Cr/k
CpFeAP0Rg8cjvcCsqwp0WnMTGqhkHk42KRoM+it8mGVjJuHvQgEAm8n/YkCVFrHs
zEzWiZ995ge8+Ikwm+0RURhDUvxcUww=
=DZF/
-----END PGP SIGNATURE-----

--32OR3FZ7MouiiHIg--
