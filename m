Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828EF606A33A
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f+3nDJ/O;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ef5xqgMk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9ED081290;
	Wed,  4 Nov 2026 20:21:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dipvyUU7xpeX; Wed,  4 Nov 2026 20:21:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25C8A81265
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793823668;
	b=hDVzz8LyhpKqsL3BPt9gwS03NF3AgWMxPm1WGmTQP3EawsJsNFvptP5itTlMQxVSMtv7
	 PZhA+P4kLlEUEVU1M4UG3F8ecEqhHuGVUYdpKoT2eVbUglLOlPuSbYVRK/TJu1lsSlzHa
	 3yC60OTOIDr3IWNatPYaDY/7jx+v64GN3jbVnd3NgEhgdOYcFoeJ5WB/QkNs8UXqE1b88
	 LZ8OoWJqUo/L4CpHhqp82JUdj5JUe4Uj3eoxCgk3cedDn/T9AMr/5WMzO3xZjY4Zujy9k
	 Uz6sQtkC1JyYLnviy3V+4QJjSYhiMg26f5NVCjedymGaV/yaZaKPfGzYnO/qW9RRtJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793823668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vYlWbwq9t7m2/bjtzsqBXgAdi8AUQI+ODG6wa8HeTtY=;
	b=Mt9xfoIEmeBxfHZjx9E3IvyQRXn5EtCpp+wmfik4UdBKUAghFBqvQkXxrln9urLRprZo
	 il61+/pHGb59rW+tp/RB9mJhkogC+a1OvwZpl72mVB2XZejnGi/sX59BTckg59aDs1WvK
	 UiDbH0IYssVYecvqjld+b5CxuaxxW1p8Z59cdHakZlLSAjISHUi8ITdd7Gb43F/vMDpqp
	 s8o5pv1s5jmuNn0rbDWUckpu/Wj9XUg0Okb113OvCdmiZPzp2P4/mQ4MFqA61nSoGQqep
	 itT28G3jiWTpznbvf+EGdQXBCE6sSe5Co/mqe2umtN7MiZnpvE+GHhzlNZ7zMcKf+AA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793823668;
	bh=vYlWbwq9t7m2/bjtzsqBXgAdi8AUQI+ODG6wa8HeTtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f+3nDJ/OR5Mz4C/djMJ8HcZfJwfjCL32va6N73D/duWD+HLygvZFvI+ZamBzOjtMK
	 7TeFTyPS2oxCcWhqPmOV8RpNjbuy2yf1lpgocikLDKyNOp4MKKIUU1uO7I9v7gosDp
	 htF0x6dI8wjXKBk7EX+UVy+eUYFjFdFyZRjaq3Z8c2SgkDjbScVUKSGHqxoxFwhJI5
	 MdRPBcZQzaKUAZnCr8VrBW9ncfVns4buB4W8o3ib3Pz5se2BpD4ZXjSYZpjJ2T/IaP
	 4DWYq+AQ4TpmVaIMlCxckzj4614yUnHe/uhDBtJOcBiJ8GGgTQimef1eWseQS90leP
	 UeyoQCOERAVkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25C8A81265;
	Wed,  4 Nov 2026 20:21:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB2911789
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:21:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90B974013C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ENtDOeaPcYlC for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 20:21:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B0D8D400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ef5xqgMk
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0D8D400B3
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:21:04 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6b1afdf5196so487113eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 12:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793823664; x=1794428464;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vYlWbwq9t7m2/bjtzsqBXgAdi8AUQI+ODG6wa8HeTtY=;
 b=ef5xqgMkT15vjGjo4BGH5+o5RTQoJBV4IL12e+tx6w2i+kmtsoPKXQg2uonyb6eltb
 724EcVZg92CJHi7BuOEbLRwBw4ILyths8ef+ScZVXp3n6Xm6VldtlmbqVAvBwGOVFWCs
 FcbxIQb9WqP3oudOGwM9HkQZliRAhaAJ8aLLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793823664; x=1794428464;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vYlWbwq9t7m2/bjtzsqBXgAdi8AUQI+ODG6wa8HeTtY=;
 b=iWUlsorr31Xe6zrN4e+f82Pwf1u2DeO0dD+CnkJnuddFV96JTvkKbn2bjxZKq7q2NL
 ua9B+/6bRcl31PrW5+nYwEXLWIWickHHGEhB/N9no6y7DHFoSU7DV/QAvM5kYMFMiU9u
 tZ684N+yQXbK3J+aye5BWMiCAwDM1LVpNdrfBIr4RlOWHcFORfFlXD8n2XQqsp31Tmek
 jUP/ixYaN4iz5Mx5J+eoh2eZCRhdXJROTnlM6LqT1rqewlf37hXZHfsgzD/8IYtHnUWH
 bPNeVFuzXBDNoKHVvB9e5V1zbe94kC0OGvexcPN7P13js5XyZwT89zQoCKcDmigDLl4r
 AoUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7eDPppFoPC1BoxFwiWSghFfqs9FClEEj5I2+YCaQj2cFfyeIJRQjslxJCTm9ni2PCMUeEv6g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z++afKzBkSZ1zYF8mD08DxXIafTfJ+Q/zzbXbcM/kgDdqRQh5Sg
 Fxn6zSza5SiR7INwHIbdqbzIm6D3KTMaZ+gNw0pLA6d94Pu3CGGvPOIkZGcdbf8rvdI=
X-Gm-Gg: AYBFou3Mlc5IwUj9zkUpW65wBKKbLxBA6/T5CtY2xkwIHQB59Ckj9kyhq6mPRe7mvdj
 WAxueoounm2fcKYsmZN5ccfFNESdvhMnVfthITyWVbKYOmcovLXZBeyAPpt90UPsoi0miBCKD+O
 6ITPEEwro9Hh2lG9uK5s9vLBw4p2t6qdWHZGkOQMvNKHbkdc93Ez/28PCh/DNxPiKo5tGvfy/Gf
 ebLJPFl7BZEhDEoyP+UNSm8EAo1AVeRj94CY3LYzDlX3z2dx8a6I9Yf1pFxvN/0aQaae9zTZOa3
 S9fj4IxnFVVt/FXv1YxaOPrMsp4186pt+6yBKZSC5Ybt354YZWUkxAXCA3zo2XMBNxF2EGatJxT
 dj7lw1HpHquW5VLyPEqs+r6DNn/I45MW7zaQaEe+yUT6nTtuSkk7LWUNuuLOmJ+GB83qx+DI0WN
 I5/j8fHsA7RNrd4ZqnK4A+aW+KFHJN6pjY6MKFfFaiiubsIlPHNDSf0yoddgmluVIOR4CPKEju4
 ou7aw+9Erz8pDrIEaKwV/ClqUITVgjjSfMZmSzevF+xy0wDLOOuIw279g0J+czLkNBzt5E1bYFq
 D2UZToh8HZcFmW021bqjF4ul/tw23ijBaoqbBsRgVO8M9flqHmlg844V1nGgj1fIrg3NEhjrz/V
 LHhOyhLHN/ro7mrgqKSC7qzokwGjs75Zk0jdAHMKDLgHSk7F7p2Ylkblr9UW3/u/vClG7DStbVX
 DhRiTnUV1yDRoTqxezG2/UG8eRl6e2x/H5l5nosRwEJstwof/SWCk=
X-Received: by 2002:a05:6820:820:b0:6b3:bb82:2736 with SMTP id
 006d021491bc7-716be91ea43mr2451946eaf.17.1793823663819; 
 Wed, 04 Nov 2026 12:21:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad58d37b40sm1774145fac.11.2026.11.04.12.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 12:21:02 -0800 (PST)
Date: Wed, 4 Nov 2026 14:21:00 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from
 the bloblist
Message-ID: <20261104202100.GH1164024@bill-the-cat>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <20261026154340.GA646438@bill-the-cat>
 <9af0101e-e133-41a4-b0dc-b1d215bd7c83@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7syVz7A93fYjnpyr"
Content-Disposition: inline
In-Reply-To: <9af0101e-e133-41a4-b0dc-b1d215bd7c83@baylibre.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--7syVz7A93fYjnpyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 08:01:16AM -0600, David Lechner wrote:
> On 10/26/26 10:43 AM, Tom Rini wrote:
> > On Fri, Oct 23, 2026 at 05:32:42PM -0500, David Lechner wrote:
> >=20
> >> On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
> >> reserved for the DRAM controller depend on the DRAM fitted to the boar=
d.
> >> The devicetree built into U-Boot can't describe them, but the boot sta=
ge
> >> which initializes the DRAM has this information.
> >>
> >> That boot stage can describe them with a devicetree overlay in a
> >> Firmware Handoff transfer list: a memory node with the DRAM size and a
> >> no-map reserved-memory node for each reserved region. U-Boot already
> >> applies such overlays, but only when the transfer list also contains
> >> the devicetree of U-Boot itself.
> >>
> >> The first patch makes U-Boot apply the overlays to the devicetree it
> >> found by other means as well, so that the earlier boot stage only has =
to
> >> pass the DRAM information. The second patch enables bloblist support f=
or
> >> MT8189.
> >>
> >> The first patch only changes behavior when a transfer list contains
> >> overlays but no devicetree. As far as I can tell, no board does that
> >> today.
> >>
> >> Tested with TF-A BL2 passing the overlay on a Genio 720 EVK (8 GiB).
> >> U-Boot reports the DRAM size from the overlay and its devicetree
> >> contains the reserved regions. Without a transfer list, U-Boot uses its
> >> devicetree as before.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >=20
> > I'm wondering what the status of uptreaming the TF-A parts of this is,
> > and why we're in this situation rather than how the other bloblist
> > platforms work (as I understand it anyhow) of either providing or being
> > provided with the device tree, updating it, and passing it along?
> > Conceptually, I'm OK with this but the support of just passing an
> > overlay from TF-A needs to be accepted in TF-A too. Thanks.
> >=20
>=20
> We weren't planning on upstreaming this to TF-A. Vendor firmware currently
> uses vendor TF-A for BL2, but our planned "upstream" solution for BL2 is
> only DDR loader + U-Boot SPL rather than trying to support both upstream.
>=20
> So the most important case we are looking at here is:
>=20
> - DDR loader passes bloblist with (only) overlay to U-Boot SPL

Is this valid to the spec? That's what I was driving at with my upstream
question.

> - SPL could go a few ways:
>   - pass bloblist unmodified to U-Boot proper (what this series proposes)
>   - add U-Boot proper control DT to the bloblist and pass it
>   - have SPL apply the overlay to U-Boot proper control DT and pass it
>     without using bloblist
>=20
> I think the second option sounds like the best.

Now that we have the series for passing a bloblist from SPL to U-Boot
via documented register convention (and again, thanks!), it's an
interesting question to figure out what to do here. I assume option 3 is
really listed for completeness and yes I agree we should not do that.
Which of option 1 or 2 is better maybe depends on more of the hardware
constraints itself and if we're using SPL_MULTI_DTB_FIT/MULTI_DTB_FIT at
some point. We have code for resizing a bloblist and so we should be
able to handle being given a small one with the overlay and then
allocate a new one that includes the dtb (and if needed, not bother with
keeping the overlay?). Either 1 or 2 is fine, it's a decision best left
to the MediaTek custodian so I'm deferring back to you :)

--=20
Tom

--7syVz7A93fYjnpyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauuTqAAKCRAr4qD1Cr/k
CrhlAQDklmdiRUtZy3Z4mZ9SGLzbunvOc/9zQRkm3/5JYNPpvwEAlkyF8AWgGIsX
EY4/TwnusbNMtP/ORhgodgGHwlGafw0=
=kUR4
-----END PGP SIGNATURE-----

--7syVz7A93fYjnpyr--
