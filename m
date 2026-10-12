Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D61CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 201F9605F4;
	Mon, 12 Oct 2026 19:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sc30gJrt53X5; Mon, 12 Oct 2026 19:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6D5FA60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791832048;
	b=n4n2fghiUD5g6k+o4B2NIsSxkvHuRYHEzlQK+Ksc+pboyAwfy0+MBb2Kr14edFlRXFf9
	 owG9q15Htjg33wECzohofliEcwS2Q0XfoIZT9H5V7TmvX6jPx/Tltv7N5l2luYuo+LwIi
	 DEzF8oMV46K9xJOhCfwXx7DOFbMhDsolVzHyrZOJ1YrSKfLvXO8bx2CVkxe9v61HfbcnR
	 HapeyrlmFmWSPbWwdKG4zh+60NtJoPyjq/aYzohv7jyV57mJWJkbCVc3itKouTK/0Spb5
	 DFMPtXRXyju+QaxeuDEWaxrHUzp4ILTYQGhtnv/UqsNffsL17fLthqUWrNy5/vW00Iw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791832048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=C7RpKF2VNoLBhw76iQxaVAdKaKvn1FgEWWq82Sn0NFE=;
	b=ZDrspJIEU5qnGKaq8f4zka4RzS9tHmjAmWd/fXP3L1dGLnBt6ZuxksZX4ESqKWX1j3QQ
	 mwI4/QDz8AEW95Cy9TULE6BBozmrECW9Zj96x1VAdkA+7wPu+p3UqsLN3v0uL7e5zC8/k
	 FGI9bexmCvH61SjxG+egvFMvIH3ZAtKiQWPGtpRQMr5EDdZW2Nl4N9H7YODpUBN19RNbu
	 B3AmJ5vCIFlK1XMXd3RgAQDmvOAHKhcUIP3qob8nLEbsMMgM8EZTTPOsSqxb+PwfrN98r
	 1/MIafigStycy3dg203Evo1MErcu8zvoJRIF2kRxP+PmgMn3AWlTQe9w0GrjN/Suc9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791832048;
	bh=C7RpKF2VNoLBhw76iQxaVAdKaKvn1FgEWWq82Sn0NFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMT67ZQONajwGLsAi0eTbmnc/SewWSwQOEC0xW5qnGNIQ4xtiXW7aj51DlC0jXNFz
	 W0akGU+t/Ntz0ys5/+Y6z5GR1Hv3/CoQ8aFRn9uFjE04gF5TORJFjqkJxvad0k7eah
	 FTDg1LL0jI1UWbc7yBNeWt2rFNvgJGKacRR3s8TzZb3d/HL0wViPDYvRK8pamkkV5g
	 3Z39I/w8c5hgcUOmdk6v+fPp2PMk0lSxE0k+Ysr/NaI/jktCb0RR7G3sVAMfzZHnlK
	 mkyxb9CIJQupgAIfwKZVgqRRTNwCxWV9Obvx56vafsJcFdkIZEeV2Sg8jEm8LFBYKK
	 Is5ps9qRIs6+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D5FA60600;
	Mon, 12 Oct 2026 19:07:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C39B6362
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B57FE80897
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxLz4F_qSyQy for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:07:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0FED1807DC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791832046;
 b=JZwwTGwTxflGB20r6X2pEF5Z22q7U1pQfseXuwfF8SvwnlPG8F1fAU8CKrhdSiCf4Znh
 tWtejnjP4GsyWVaTPVtwHr21gb7StPJNJx0tWWDoxBVPOqnfYUEPXZvunFYj0xis/o/60
 dPnYtfLa8A2ah5UGMm/iK3mmYgC9tban8GBZM1+xndSVATpGTEFkzFUIVivm+Ongog1YX
 32X5iklHhAMRURY90DrWhBNRRVBMUHl2eWLj1p/O6KdB5k4wH4M7F3du9Na86PUHQ6Ks6
 Fpg64Es+xvdeJW5KSDQIqugPOkmg0MwacQdjP5qfPDl3bsPmh02p9ZfDAKXn7H1tqDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791832046;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=C7RpKF2VNoLBhw76iQxaVAdKaKvn1FgEWWq82Sn0NFE=;
 b=P3Mm/pymsb/U5tNS3BcEo9AaieOKp5dq0C8FyxDOAGYGltk5jq7NJN6Efl+5AzgXTn34
 STbVM7d4Q911k32JeNStZ47VFPUIceIcjglW2N8vnBmnZcWlbCqhhIp8MOh05l3PGnpYD
 JN7o5Gan4fiugzWgSj3zRgwN65LN440VEmPi25ihJhqK+mOH96gsI53BOLxdPjxf4zGRc
 EnDR7ZX8MAaHn0e9n6GjlSrtb4qmPSdoqN+NRDV6gotSphg7nv0NkVpIhwqJi7WHrE0QJ
 x9bWDbKnV+fW2VJWLgX2qUdMlfZLYTzOZTOEuRxxUrQK/Mf98Jvdzf6hiIIEuvy1+sw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XETdILbc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::7;
 helo=mail-oi2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=XETdILbc
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FED1807DC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:07:25 +0000 (UTC)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4f47feb5a15so291542b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791832044; x=1792436844;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C7RpKF2VNoLBhw76iQxaVAdKaKvn1FgEWWq82Sn0NFE=;
 b=XETdILbc5kQgg2p1FnHMQRd6WyVTJNRN2mWS5Vau3f+gnVjvGC88wdDD4XdtezeJ5s
 JfNz3QA+hoUdqJCjewFGLA/vlIou143vNy8hH7WHzGD43rhzMog4i05XoFCESXMSCBU/
 rx+g3l9IeUDo/6jVT1/EzCE8b0Nx1w0qZLe2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791832044; x=1792436844;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C7RpKF2VNoLBhw76iQxaVAdKaKvn1FgEWWq82Sn0NFE=;
 b=afmWuCbBUins8/4yK703TL+hYwPQ1pkQIf5UB/VKxoVe7dEIXw8iEhDGFKppaGHB3X
 ror2RcTMBW7MtRtcTTD7mobkLI5tfPu+TpsAOBv1vlktpNbnBL2/w6iRZ5NUGtLRXmfV
 BufIOBtiOHczEjqVwFOyb2CARoGps42r0ny9nWKK+iigRghLP0woainjVuLCkQ39kpHB
 RMc1ySskhS/A2zMNRd+/RVVQqPKnaDvGONAxts51tUhNFkRsLfM3PyZiO3e6wHyYMoZ9
 6qLugJURxHYNa6eamhaXDe4/Z0GNO4zh8WiPAzg4lyeorMyIUb44GHzuh7T/SUDKilU9
 fFjw==
X-Gm-Message-State: AFq9FYK/tpmnlm9vUD3KrVS9mjhAUeozHV5TWBFRAZP9LVzKPtlxYC6Q
 b61ddFk+0n2RdAaAhNBNf3eMEltIGIcjwJ4C8NDcOIWWorh41wwEuA26KpiNcYpXzwA=
X-Gm-Gg: AYBFou2SCFYl7PnEbEt0tDBudzJmIbpl8bJxGoOkSjhqLkM58c9WxS3FVemWH1ROhD1
 zs0clqxSofjxw4+tl62pbhrRhfFlN+07LwNsnY2P5uq1qNza8W9Gjqwm9gDLopYTh8qKiPSZXnI
 LBEndazAAgNy4xB2ZhyPM08ZgN+dVpblAjAze2q01FkatLqaTU5BpbFpyHxq2KLP/FcJY5rgF+s
 Urxj5eVAEosSVvNIEmlsiGTtOiv150AEJ6rGgxH3lqETjpaP+RV2xmWcrhGpxJS3AHq+drDflkx
 5sSiRK5KLrGRpgOKxEnspxNEKeEu2Oba6Sj/5nsEtazlEMeLBFwaTXARPO2inF0tcGJIf2Vp99U
 hztAJ/WeIhCZFTD1Ar4CqrsD5TOf5pwqRZyVbCUGx+9ZMvj7bW18oAoX9lDRMUqCs/jKFvAgvXl
 MMvuyb0BfxEy3cgh5rqnFABIvlQUkTII/Yy0wxNZ/aUKxpaMIyCr/lMPsAV5jZZgmEvCVnFYwcj
 UZRlKpUABFPgG7ng/7ZZoX0rxgYSUljn4f9V7UHej3+nhG1qsgGZCzNgjnGWP9HcgkY2PhFeFVG
 eeAOZJ1GVRi7e0q2u7o=
X-Received: by 2002:a05:6809:291:10b0:524:884f:d89d with SMTP id
 5614622812f47-524884fd905mr590551b6e.21.1791832044628; 
 Mon, 12 Oct 2026 12:07:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1c0248fbsm12284765b6e.15.2026.10.12.12.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:07:23 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:07:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH next 02/13] Makefile: Link a toolchain libgcc outside
 --whole-archive with LTO
Message-ID: <20261012190720.GF3722450@bill-the-cat>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-3-pepe.schlehofer@gmail.com>
 <20260928194637.GO858934@bill-the-cat>
 <CABPHAJweVnVqpbfL=UUPNGjsoQ4dqZVYMJdFTPLszsL1Z8b5sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JO8bsAHFMWif36Ii"
Content-Disposition: inline
In-Reply-To: <CABPHAJweVnVqpbfL=UUPNGjsoQ4dqZVYMJdFTPLszsL1Z8b5sQ@mail.gmail.com>
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


--JO8bsAHFMWif36Ii
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 07:18:53AM +0200, Josef Schlehofer wrote:
> Hi
>=20
> po 28. 9. 2026 v 21:46 odes=EDlatel Tom Rini <trini@konsulko.com> napsal:
>=20
> > why isn't the solution to just replicate that logic
> > under arch/powerpc/config.mk ?
>=20
>=20
> PowerPC's private libgcc only has the three shift helpers, so with it the
> LTO builds I tried don't link (no _restgpr_*_x, and on the Turris no
> __udivdi3/__umoddi3). PowerPC needs the toolchain libgcc, and the
> --whole-archive in the generic LTO rule is what breaks it.

Can those just be imported from elsewhere? That's essentially what the
private libgcc is.

> > I also don't see a later patch that
> > guards and drops out -ffunction-sections -fdata-sections when LTO is
> > enabled.
>=20
> The ARM conditions for that have had no effect on U-Boot proper since
> a55014d09b2: LTO_ENABLE is only set after arch/$(ARCH)/config.mk is
> included. Should I send a fix for that, and add the same condition for
> PowerPC in v2?

Please fix the ARM issue in its own patch outside this series, and
handle PowerPC with that in mind for v2, yes, thanks.

--=20
Tom

--JO8bsAHFMWif36Ii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas0v5QAKCRAr4qD1Cr/k
Cn1LAQDvXqvHSlDXAyfvHhVjOU0hGJG0KVIYhrPt54V/oRXdoAEAnYOR5lu//Qbk
wFttR+m8+4P8Pi2x95YPrcpo2q5IdQE=
=hiLf
-----END PGP SIGNATURE-----

--JO8bsAHFMWif36Ii--
