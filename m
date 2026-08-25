Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F230C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 14:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E46A280CC5;
	Tue, 25 Aug 2026 14:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKZGW1Gds0Oo; Tue, 25 Aug 2026 14:20:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787667617;
	bh=Lqr5ipTwi08WIYcrjYLeL/IIRhA1ZlCaWCooEhTqBtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cecRYv+/VhUjrq7SW6EJTtDLKgbrK5IYru/EHV8NQy6XE+syUvX0BnBtpLTSjeJHf
	 rw/zIKpJyi9NQwWZ1Dh74gTr59gMWIuPCleka/jMpQa3BMuKf65ymkC+Xey6VErifO
	 b5oElDgvG4bY2J5BZBveAGZVEGibqIPEK+GcSQEAhMfU7UzQEID+I3mA6Ybgb5ia3Y
	 ZGcIHM+UbZTLeiuQdJEG75dR+kwlpwoirw+DpW3+ZAeL8BvZc+GWNTXZyIyQsuNTwE
	 GswXW2xhwSUlUQBSiMzPRpbdMjnv1qUG56HNtyw4fCIM2uK7LdGkfFHz/OWLp7GYFu
	 9tvM9snBvKAlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DADC680C79;
	Tue, 25 Aug 2026 14:20:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF5922FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95C4A400F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2olLL4hHrCCx for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:20:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OOQwOsne
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C911240092
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:14 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7f3ece23165so5062391a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787667613; x=1788272413;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lqr5ipTwi08WIYcrjYLeL/IIRhA1ZlCaWCooEhTqBtE=;
 b=OOQwOsneODXO4HRTWMSH2hA6xLO9k35MDNOKmuN7DlQ6FtMBekyp1/SGqPASYhj0J0
 NKQfbdF4wBJ/62E40ccIYSkTYxXBcVc4mVFqvLOMrsHHiuDyRnOkc9+LcZmY1VuWzE/Y
 8GPaRrMiuCg5fhNn+LD+9iWqxVufU5TjSvoPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667613; x=1788272413;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lqr5ipTwi08WIYcrjYLeL/IIRhA1ZlCaWCooEhTqBtE=;
 b=GmtpO8EA5cyHDy4CmDYuHnszcbVQw14Ml+Soa78vqYDEJB/ZqfOp4uiHZwhf6OzEj2
 xXWpaV8cEA6QhDE+YZIMGVQkr4tj2oDHRuc01g1OhMCvMONrHdMVqtoV3A4GKJ/i3PNp
 LDc5HmXhWI6/vnW1NkdGrkpK/Whzc2qwhjjKcpMWENmeNPabZbHhNaSrza1uDnozzkAO
 aCP1f8nDfTmtqvmfiwgR4SdB1Y8j+U1GAePyvTVR73uR1GdnpO8qaEOU9YkvHkLsLxjw
 TcfV6BsL0k4wfapl3nIk8nNWKCYW7SVZWJBWmTYg8UOaOq+Zv4mjlUtr7z2GxItKTkUK
 pg+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZjIDLjhLwXnXvXVG9oQs/idkQieRpiYeU48nUInkaNjTOOgDEdLcSGZ4B4T0AwZ8+0i1z7Dg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++llOGWCK0zf285m8P+LMMkGiQSciFwk2KQtnqZJTO6mGesPLNGf
 8Sf5si3jSD+IQVlKv+EAR/BIcJvBGi6VJkfXmdlaVZJD6kILYevWaTvAaCQg+8xHR+0=
X-Gm-Gg: AR+sD13AFFcp7zZySdZYTJykq2OqZUe9BnZe6tXj24cs9LpyJTFKunG0QKZBd82ZoHy
 9+pDCdNhFk9z/df1B/49bpF0Njt1/kn8EQJJt+6TQvxvsGvZUfsfK6347y7ayGl/UXYvGGAeGuL
 cl5YDccsghO11weN5reMrXa4vQwy0ihOGesiT432QcgpkprriUliccLrkAHGORHZQRdYERN4Owt
 r7dt5GzOoianWu/tbBN+yNcL5VCSk2lTdd8rdVHOKiuJSyEboWYHkbNKRM886xnVNjPpEKxAMT4
 XRUuAgbXKyn97oq45WkTm0Z0lOsrkLv8+qALfElSE+b4axiCGflnW1Q4DhStpzOQmYZSYk8hHZF
 AO3b5wh2tTm2733BmzOdK2YNZLkYe5nnJqqYsJ+d7qCTLiNF7EXvDhaZE/anHe09lUpbvVuEx7t
 cHSdO+FbAqFYOnssjNAHfVlb6nGTuNEHBcUK/XBappIOaGW/PHAqER9eMgQA2ZfUBy6YTtf9l8B
 R2bI/1hTufr+LFH3q0f1tTENREVaeVvOWjwy31Du1AaQD4QTgwp9k2HLjxQ1UX9Ck8i+dkOP6qp
 sZE/KX5S8Q==
X-Received: by 2002:a05:6830:448f:b0:7eb:3af8:8c1a with SMTP id
 46e09a7af769-7f4af99833dmr6062825a34.9.1787667613187; 
 Tue, 25 Aug 2026 07:20:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fae8df0sm7236329a34.5.2026.08.25.07.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:20:12 -0700 (PDT)
Date: Tue, 25 Aug 2026 08:20:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 5/6] common: kconfig: raise SYS_CBSIZE default to 1024
 for FSL_LSCH2/LSCH3
Message-ID: <20260825142010.GT523975@bill-the-cat>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
 <20260824122825.95712-6-vladimir.oltean@nxp.com>
 <ao1L1_1E_UAufqWa@nxa18884-linux-1.ap.freescale.net>
 <20260825081938.b74bey6zpuewig7l@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="scuNkhDrzbkhR0ZF"
Content-Disposition: inline
In-Reply-To: <20260825081938.b74bey6zpuewig7l@skbuf>
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


--scuNkhDrzbkhR0ZF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:19:38AM +0300, Vladimir Oltean wrote:
> On Tue, Aug 25, 2026 at 04:01:27PM +0800, Peng Fan wrote:
> > On Mon, Aug 24, 2026 at 03:28:24PM +0300, Vladimir Oltean wrote:
> > >The 512-byte console input buffer limit for Layerscape SoCs originates
> > >from copy-pasted boilerplate in the original LS2085A board support add=
ed
> > >in commit f749db3a75ec ("ARMv8/ls2085a_emu: Add LS2085A emulator and
> > >simulator board support"). No rationale was given for the 512-byte
> > >choice; every subsequent FSL_LSCH2 and FSL_LSCH3 common header
> > >(ls1043a, ls1046a, ls1088a, lx2160a, ...) inherited it by convention.
> > >
> > >When CONFIG_SYS_CBSIZE was moved to Kconfig in commit d31466b382dd
> > >("Convert CONFIG_SYS_CBSIZE to Kconfig"), the existing 512-byte values
> > >were transcribed mechanically into Kconfig defaults, cementing the
> > >limit without re-examining its validity.
> > >
> > >The practical consequence is that environment variables holding
> > >multi-step boot scripts are silently truncated at 510 usable characters
> > >on all Layerscape boards, making it impossible to store commands such
> > >as combined TFTP+flash sequences in a single variable.
> > >
> > >The same problem was already identified and fixed for i.MX6 and i.MX7
> > >in commit f7b237b81e5a ("MLK-24380 imx6: Enlarge the console I/O buffer
> > nit:
> >=20
> > This is a downstream commit.
> >=20
> > Regards
> > Peng
>=20
> Correct, I failed to update the commit message when rebasing.
>=20
> Would you prefer replacing the commit sha1sum reference with just
> "downstream", or just remove the justification altogether?

Adding in Fabio since that downstream commit is also applicable to
mainline too, for iMX6/7.

--=20
Tom

--scuNkhDrzbkhR0ZF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao2klgAKCRAr4qD1Cr/k
CoFwAQDe4frQy1/b1HBN+aqxk3PITpUEao5jpjYYgVF9gW7+1QD6Az+hdLA6RUnc
QkddDGheV/g5pyXTuAIMvVG4r69Whwc=
=rSxt
-----END PGP SIGNATURE-----

--scuNkhDrzbkhR0ZF--
