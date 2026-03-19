Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAAD1090220
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 13:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A4283DC9;
	Thu, 19 Mar 2026 14:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XoexI4M7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A494183EEF; Thu, 19 Mar 2026 14:41:35 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C9383D71
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4138136f02eso735376fac.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773927692; x=1774532492; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/sH5gR3ZgQDv8X0PpzS6jPkM0Cp4bt8czdZLpKJ4qHo=;
 b=XoexI4M7fcRtWDPEAfyLYc9axzy68adUEFttybrvJYIP/AnPYg7+sVe1S2TXhJg7nv
 LS/YxNUiB9FouBYHVG7mN1Ru63yOUKGT8L1LYqV3wafwEI6DYaNQJHzg1bnMbcYaMukY
 3CpmpEutoPPP7hJlpaJCdW9yDHTHbwOk19tfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773927692; x=1774532492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sH5gR3ZgQDv8X0PpzS6jPkM0Cp4bt8czdZLpKJ4qHo=;
 b=Zjr42vAqBg2yBpKWra5cYSDDoukDlheGC9Mlgu+jse9tM48swTyzW758a8FoPwQVmR
 BCtyaJ5tK+cP4rgXnmXcpOZYCAv4i77NfEZF2Tzx4LT44an29vK+X2t5rvttBT9NrqJz
 Gsdl7z2Gr4NpDPVhIGBeCUFd0lH8x28zoXq24Ny2aegPfjwh7owcSp+2Y7cdqjkeTvIP
 2vSngr22nM0aLnt/07ngNDIrpOng5NA3kJ9lLxlIV5WgSy8mZsZfzFTbPJQxT9NOEl83
 nIHq2JodpbANbX80HSxm3zRXQvBOTNNE3XpBIX56VZ9z1U0DH7PBagCi10Bmq8jIWa6B
 Ew7Q==
X-Gm-Message-State: AOJu0YytYZW/XxoRG6eCjC0JR8GRS1dvYviCpATozeVJi9K2ujhJiGi1
 WJ2eZecJGy5OUDB0LOk9R/qRvKU/NVnWy67VUdJ9k4aU5r1yYwCks8OZY6WzasAt+lM=
X-Gm-Gg: ATEYQzyMkmMFd1RW99V5n8s5v/zro+nQZnhLy2XalKuRR340Vb11pUtKQdXtwldoFqA
 idrUltwK26QjzrDKsK20CtEgiUiX0T48uSHX1jfPPcoDt6s2E6o8tyrPaiBl7qpHhe5KlUzeoJ1
 nABuggJgbz/L118OlFfwfgjkDrbR+uWpyuaBQ1plVUIYnuqqymiTPLWkOCmMJBLvkbpRXJ4Y/DJ
 siYD6W1lJrHy/LUzRgN1mwb2xQlFILBqZEunf9pu5sbBcYJKpkVuVX6052O0RL4TuPFUhL/EpZ8
 ufn0mrGLuWbv4sVVerFZwYIrcTX7zTaFDpp2VKWuLTix1hvMii8AHzD1z3lH/sN2bOC2T7P+1BS
 aX46Yy51Ba2N23XsENhHGAdjDQqrLgJYI6ypZ69aCPTjvID5Bdq0wMssk2QM9UO3GiJkgys3D+x
 RPXzALLNJSSI9jsVFnoqpvLnbnQ4Yus3zgT9Xonyn8JHTBGpegqFldXgnR9NskTPyWeo6kLk7El
 yjG4vWSFe7VgpojheoNUQmaM88ax3krM0VQrrLofOO6kQ5O
X-Received: by 2002:a05:6870:4191:b0:3ec:4a8d:420b with SMTP id
 586e51a60fabf-41bd3fe8becmr5250479fac.42.1773927691789; 
 Thu, 19 Mar 2026 06:41:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd288c5e3sm5949325fac.8.2026.03.19.06.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:41:30 -0700 (PDT)
Date: Thu, 19 Mar 2026 07:41:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
Message-ID: <20260319134128.GP502704@bill-the-cat>
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
 <20260317134008.GQ502704@bill-the-cat>
 <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
 <20260318012557.GF502704@bill-the-cat>
 <34a0c151-f8ff-4b91-92b3-d6f63097440e@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9MMKKT9+laijWOMJ"
Content-Disposition: inline
In-Reply-To: <34a0c151-f8ff-4b91-92b3-d6f63097440e@mailbox.org>
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


--9MMKKT9+laijWOMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 01:52:15AM +0100, Marek Vasut wrote:
> On 3/18/26 2:25 AM, Tom Rini wrote:
> > On Tue, Mar 17, 2026 at 08:41:26PM +0100, Marek Vasut wrote:
> > > On 3/17/26 2:40 PM, Tom Rini wrote:
> > > > On Tue, Mar 17, 2026 at 03:33:57AM +0100, Marek Vasut wrote:
> > > > > On 3/17/26 2:24 AM, Tom Rini wrote:
> > > > > > As exposed by "make randconfig", we have an issue with the depe=
ndencies
> > > > > > for RESET_RZG2L_USBPHY_CTRL. As REGULATOR_RZG2L_USBPHY depends =
on
> > > > > > DM_REGULATOR this symbol must also depend on it as well.
> > > > > >=20
> > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > ---
> > > > > > Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > > ---
> > > > > >     drivers/reset/Kconfig | 2 +-
> > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > > > > > index 66911199c8ba..3f0ec50510c0 100644
> > > > > > --- a/drivers/reset/Kconfig
> > > > > > +++ b/drivers/reset/Kconfig
> > > > > > @@ -239,7 +239,7 @@ config RESET_AT91
> > > > > >     config RESET_RZG2L_USBPHY_CTRL
> > > > > >     	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY contro=
l"
> > > > > > -	depends on DM_RESET
> > > > > > +	depends on DM_RESET && DM_REGULATOR
> > > > > >     	select REGULATOR_RZG2L_USBPHY
> > > > > But this already selects REGULATOR_RZG2L_USBPHY , which according=
 to
> > > > > drivers/power/regulator/Kconfig contains:
> > > > >=20
> > > > > 508 config REGULATOR_RZG2L_USBPHY
> > > > > 509         bool "Enable driver for RZ/G2L USB PHY VBUS supply"
> > > > > 510         depends on DM_REGULATOR
> > > > >=20
> > > > > which does depend on DM_REGULATOR transitively ?
> > > >=20
> > > > That's why Kconfig complains about the unmet dependency. "randconfi=
g"
> > > > does some fun and apparently valid things.
> > > That's the thing -- if RESET_RZG2L_USBPHY_CTRL depends on
> > > REGULATOR_RZG2L_USBPHY which depends on DM_REGULATOR, how can DM_REGU=
LATOR
> > > be unset, while RESET_RZG2L_USBPHY_CTRL is set ?
> >=20
> > Using "randconfig" will find some odd problems, yes, because it makes a
> > (based on what all of the Kconfig files say) possible config and then
> > forces it to be validated against the expressed logic.
> >=20
> > So I think the answer is if you fire up menuconfig, and turn off
> > RESET_RZG2L_USBPHY_CTRL and REGULATOR_RZG2L_USBPHY and DM_REGULATOR and
> > then enable RESET_RZG2L_USBPHY_CTRL things will become mad because
> > RESET_RZG2L_USBPHY_CTRL has select'd REGULATOR_RZG2L_USBPHY but we don't
> > have DM_REGULATOR.
> How is it possible to enable RESET_RZG2L_USBPHY_CTRL without enabling its
> dependencies ? This is what I do not understand.

The way I said in the part you quoted? If you don't like the way I'm
solving the problem with the dependency graph here please propose an
alternate. But it is possible to encounter this problem, or randconfig
wouldn't expose it.

--=20
Tom

--9MMKKT9+laijWOMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabv9CAAKCRAr4qD1Cr/k
Cio/AQDDd1qU6cbdqdFeqkgQeMLZnwi39hO5e7eFiYqlPjvr7wEA6XQbUwaW1rK7
b8U4s1cPnmQgyuWND1oW0csfsWDWNwY=
=kVWu
-----END PGP SIGNATURE-----

--9MMKKT9+laijWOMJ--
