Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002F9CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 840358466E;
	Thu, 11 Jun 2026 16:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kvZXx3wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA85846A7; Thu, 11 Jun 2026 16:20:30 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96C7C841C2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e71b2d527dso2468494a34.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781187626; x=1781792426; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X8MoMvdkp6FYXAk0/vjcYJUtorMrAKfKPJWhLAeHIsc=;
 b=kvZXx3wkxt+IEkIgcaPbIWzXVQ4PMJHzkpIB5AWApwxgipPWsscVoNXst0czjkLZ2E
 Kw4Btcpx23s6htsnhsCDmGQRkkefb9yLUFywFpm3tRgfj6CR6yKXVFKrxmeBezy4nN3M
 666DpYiKRoUoSdLCzVq0MOMZe0Rq+vaaVdSfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187626; x=1781792426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X8MoMvdkp6FYXAk0/vjcYJUtorMrAKfKPJWhLAeHIsc=;
 b=s4X/mNdZypWU5A2AAU8zgeZ7GzJ9h04P116N4n7H22rdyhedfXcangMVwE/PpRbqTh
 BteATHIDJJD77SS2eANzqtLJYNX9r9/DDNJ3dvPZin31rY1uKzQ603X7Q1zPF20cpXC4
 WGAveDcl1Swbj6Ysz83LVvgn0Hp5ASJEYbTbjUVglrGmXDvXflf+xYwGiTjIpKyepMuk
 YNRVvOUkrmUQaW2BgkF4oLeWT0V2HhlybB+qNXuUZKx2QD7lpRiuVIlJ7epJI/iwkLz7
 dkkWKxbShWappD3/gD1/e7UCUalaLs4FaNpB9DAxXNlRje5hL3/D3+bitEciDqCkuIym
 jHSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ80UZpnpH7G3vWoO1iDUDWGnxunelUBtbm5974hvl4xY5Yn5rPou1xMpMzqw7QkjlrfEmdzbxg=@lists.denx.de
X-Gm-Message-State: AOJu0YyUPOP9qu6Kc8BEPoK3BHq3BvDVolZ6rcNpxdldHhz/3dDV676I
 qC310wbL8ntbY+GhTx4VvmLfrxmuup2eKhY+bhgC27fpQ/bdTgg8c+nbShpxlb0BPaA=
X-Gm-Gg: Acq92OHkV2tHKpxtXcGLL1ABzaxZFcXLazDIWjwcJsoTDB63I/KRb2CuopWUgOjHh2v
 IGQ7ImWjs5hKOOnxvIeD/KRTL7qk0bthb36R0D9iSDXdrFFl/HmVlbRpT1yScRnyQfNIqzM5QO8
 9LVnS3hUoC2h66Nab4le0e2gRe9na1aw4x45YpJRdchtC4zdieTDCNr0Rh4UqyJHXjvYf6HkVra
 iqWswstOg7cCKh722SHH49ho9386gvTSmxYDv8/hhXh//FeGHZLDEIzbcpslZW3FNBqlFXBWUt9
 D90jxl7xBXibbxM68ZuO8ENX9luqaM1APMc5pVBY+DAYqzbS66SzBshN4v8dNl69utij0uvNk2P
 8unJerRfvezXI4hMC25cJKkYqyZ5xRNC8dlJlNSVE9GFE9dXj+tFvg2wq63nm1GqGszS/9eG/R8
 eKhTr+ksKBLuIbJlvFp5BuyAfCs75yPsUSgDej4o6Uy2oa3iagB2ahc4LSc8B73es9mQuz4WpPh
 aQlEMKAc44IFjpYfZQON7tw7PfxzO01sP+4dlB0rZ400PqFB7lHPYtdB+8=
X-Received: by 2002:a05:6830:4908:b0:7e6:f7fb:968b with SMTP id
 46e09a7af769-7e773359ed3mr2543409a34.2.1781187626300; 
 Thu, 11 Jun 2026 07:20:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e774989174sm1458296a34.4.2026.06.11.07.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:20:25 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:20:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de,
 Daniele Briguglio <hello@superkali.me>, Lukasz Majewski <lukma@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] clk: enhance clk-gpio to also handle gated-fixed-clock
Message-ID: <20260611142023.GK382693@bill-the-cat>
References: <20260528132206.2fe9f474@lst.de>
 <178118570728.472730.15075222884813417231.b4-ty@konsulko.com>
 <f706f118-b698-4ab4-8b19-9f3de0d10c31@kwiboo.se>
 <20260611140105.GI382693@bill-the-cat>
 <20260611161755.447cabc8@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zVBD/AnvuFgYAO30"
Content-Disposition: inline
In-Reply-To: <20260611161755.447cabc8@lst.de>
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


--zVBD/AnvuFgYAO30
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 04:17:55PM +0200, Torsten Duwe wrote:
> On Thu, 11 Jun 2026 08:01:05 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, Jun 11, 2026 at 03:58:04PM +0200, Jonas Karlman wrote:
> > > Hi Tom,
> > >=20
> > > On 6/11/2026 3:48 PM, Tom Rini wrote:
> > > > On Thu, 28 May 2026 13:22:06 +0200, Torsten Duwe wrote:
> > > >=20
> > > >> Devicetree commit a198185b9b5 introduced a new type of clock,
> > > >> "gated-fixed-clock", for which Das U-Boot does not have
> > > >> a driver yet. The required code is similar to gpio-gate-clock,
> > > >> and can be added using little extra text space.
> > > >>
> > > >> Use this code e.g. to boot a Rock5 ITX from NVMe
> > > >>
> > > >> [...]
> > > >=20
> > > > Applied to u-boot/next, thanks!
> > >=20
> > > Any reason this was applied without my review concerns being
> > > addressed?
> > >=20
> > > Please revert, or address the issues this patch have :-)
> >=20
> > Yes, I missed them, sorry about that. I'll go push a revert along
> > shortly.
> >=20
>=20
> IIRC it was not a big thing, I can also follow up with the change
> suggested by Jonas, if that's easier for you.

I've already got the revert made, thanks tho. And again, sorry for the
confusion all.

--=20
Tom

--zVBD/AnvuFgYAO30
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCairEJAAKCRAr4qD1Cr/k
CjluAP9chAGodHIY2bAVmMb84zODKkB74uhXnNMRcqtro9MJrgD/aZEgPPtDXdJG
EvZ8z4wRa3r+bUD9+8WdvsKgVOBkhQM=
=/SNL
-----END PGP SIGNATURE-----

--zVBD/AnvuFgYAO30--
