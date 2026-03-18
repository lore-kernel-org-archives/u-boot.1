Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6313E10854C9
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 01:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9EF841CD;
	Wed, 18 Mar 2026 02:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n6iySwKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133A1841D5; Wed, 18 Mar 2026 02:26:55 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF113841B8
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 02:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso3941843a34.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773797211; x=1774402011; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=va37l/FMcOHEtEM2LR3Wnee3oQl0Li33W7FyKchgPak=;
 b=n6iySwKO1ZH1BdZOcHSlR2OLN4w9Pa4Db3lBgyyNkq/OnB7mjguPn3WNX0Dk9NjTV+
 mRxP/NRn/MOe3rgWw24Mk5KXzijVd07jI5xpChjM9uXMLw2KWmcTE16onyObXNErIKPd
 Ac22IY6N3rXTIRtV0VP5qCDwA5njm5PUYMI9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773797211; x=1774402011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=va37l/FMcOHEtEM2LR3Wnee3oQl0Li33W7FyKchgPak=;
 b=p7J3GZg2hDzxxDnu2Zgjp3o7+/Esq8CARDwkqB/K1dbZ07T6TiTYtaTdnwdR36qvBQ
 vDB85TOfAMtcp2a+xgrCjmId/yHy7AsdLiYt2QJLJ1kWnv7ex2AGiwrv5bjfJvQL5AYK
 +dDYqT9wqHR8Nb414u9G2smqC/KToQSR5O0TLrhwOoZyXB2ZGXe3v7VMv1ERH6VC+x1T
 CVZqaTsQDX/NjStGevM3E0pznhSWvtGQ0+AgVPDqzY4KnMPP+c3UfRj0N1cEV1Lrwls/
 T5Nki2VffQTCnfr21Bd7kgQqtknHfIYj/ISwXmc/5cPdStxDuWhl3o40fVnIk5y8C3kQ
 3m+Q==
X-Gm-Message-State: AOJu0YwPaqoLjnUVJBEr4qKbEPbkCCYLsdS/svj9Fg6dTOxMVa0wDeQR
 rK8Ku07xzPCBjjRckMLJKTF3KuY2OiIrQRJhfA775EoU0KlBxjV0i5wsnq3d7+ta4Fc=
X-Gm-Gg: ATEYQzxyMHhF/wlJcjK6PAcc8Vz7N+t0YaJ+M1j3PCh3YC8c8vJltYSQ01+xAlbmPzX
 9Qrxa1PYOjSBl2kF1JSB/+tWeSmt6h6+7RkO58gixL5MERiFRiT83e8ublXqSBWGCKd/n4+Ofy2
 Llh3bvyDiNW/G2yEi6x8Fo6+HG+gz8luTyK67a6WHVY2ObHKdPAZw05wM6nE9H/8tNKR+Da6y7O
 dzU0nevf+/xkyApfOvJ4Ez8f2M+G/JwNBhzHNyzlUlUTS7dHKrBMGMXKPIOigdJ9cD7TDKMVkMI
 BEFA969TXSKYmHhjyIy3l0TmITHYK5SrA6JIj+aNPLcT6B4x5PuVppWoEW0pUwLEATuB6Yefp6F
 zwHBreMPaQwSQ8XTClwEJHyNWQ1RjORSh4kodux/6NeH6HHXF6WuewCbNMJs469Y+xoC0mF4qaC
 5r49t9DNfcqRC79cPdvKr+u4Ph6bIJ9wYLqdHMqQNtTxwdN1bLOk667W26jNEKbVFRzAV95WIgq
 gHTDpf/GMUQsFWWljUH7+PqBlsItbZEYvP6/SOq5JSVgGJW
X-Received: by 2002:a05:6830:6b05:b0:7d7:5818:66bc with SMTP id
 46e09a7af769-7d7ca5c82b0mr1120690a34.10.1773797211620; 
 Tue, 17 Mar 2026 18:26:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c97ef88fsm1197974a34.0.2026.03.17.18.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 18:26:51 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:26:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
Message-ID: <20260318012649.GG502704@bill-the-cat>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
 <20260317134107.GR502704@bill-the-cat>
 <bbdd71c7-3276-402e-a9f8-98afffd10538@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QQTKC0rO9i3OGjr9"
Content-Disposition: inline
In-Reply-To: <bbdd71c7-3276-402e-a9f8-98afffd10538@mailbox.org>
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


--QQTKC0rO9i3OGjr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 08:42:06PM +0100, Marek Vasut wrote:
> On 3/17/26 2:41 PM, Tom Rini wrote:
> > On Tue, Mar 17, 2026 at 03:34:36AM +0100, Marek Vasut wrote:
> > > On 3/17/26 2:24 AM, Tom Rini wrote:
> > > > As exposed by "make randconfig", we have an issue around
> > > > USB_GADGET_DUALSPEED. It is possible to select this symbol (via
> > > > SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency. =
As
> > > > this is a hidden symbol, move it up within the menu.
> > > What is the issue this is fixing ?
> >=20
> > Valid configs causing the kconfig part of the build system to note
> > unmet dependencies.
> Lemme rephrase, is this actually a fix, or is this some readability/order=
ing
> improvement patch ?

Yes, it's a fix because randconfig finds problems that users may stumble
on to while trying to make a valid config for a platform.

--=20
Tom

--QQTKC0rO9i3OGjr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabn/WAAKCRAr4qD1Cr/k
CjFuAP0Qh7Pd4jWxcapZgaFFY0NwLANrFFyGoDkcu0cHanc4vwEAs13oZk9sAvd2
sh540K0lcO6kZVK3Idvj8Flv9rmu4Ao=
=YG8v
-----END PGP SIGNATURE-----

--QQTKC0rO9i3OGjr9--
