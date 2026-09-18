Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2765CC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 15:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C687D40AF8;
	Fri, 18 Sep 2026 15:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjtE75rlW7aD; Fri, 18 Sep 2026 15:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 21D6B40A6D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789743850;
	b=ZSkg+6K1bfiRjv9P2qbYBMl2fmNnnTbtWUx7GQQpqgG6eceUVAKIPQ85kcMu5WYgZ9WF
	 LOBcqvhSb9WjJwpEqDP76uFV6eXhEL+18GGbwnqljdCaUfvOh/fivNFCgXH0KvsoloRTY
	 7CasbL2ENUtA3mF1Dh0C8XRpZ0uV8KZVU4XL6U4STMhH2A13VisMz/FiHtO9bzfhwit4/
	 zY9G+M5khW4I/meZZO2T4ZoYDkkyjtbR+9JCv/InHAp6No6kkBlnI6TCLCQFgKJuatI6J
	 Ba9nH5afjIoOyVcFfVVaX5kQDiH3dQ0jchLEopvAOV9ljpmmQs7tSccW6IWU9QxQrAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789743850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YAvweK5hBeTvbKt0rG2ZgY2QpQPQH9MrinjJ93aHpsw=;
	b=i0ILBN9H1BrdAG4OS5ctS5G0GxC3H9EZnAL5c7gy5sKTsVAmOuDz7bLm2YHT9D0gX1+j
	 wvzW/ssmK4AZFr5g/lsOwlWMqAy7I1FW2qWHppE3zWZro82ZeohxfsrHzg6dUvIuABEuv
	 id/uAcdGydCAJTzBcr/bd34l4ljhlubq/SA/fpBi9qOh3PlJCL9hJLLtiJee9IZjD6oYM
	 T6YD+vbGM0KHQ4au7dnt08oSVmJe5aWo4BHmjKqCY2H635idZ7Lk3el8763mFICRcis1z
	 ISTdcePZpL1ys7wA670hEMvVTrx+TIC3l3XaH8QZigM3+2jE2iCxtH2yQzTK+HsMKhw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789743850;
	bh=YAvweK5hBeTvbKt0rG2ZgY2QpQPQH9MrinjJ93aHpsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nG1rzGPJI6mm4+bxfahsjIMQ+Z7bmnBp7xywPBktYDrRIbY4+lWC2RWJnlgSf3iJg
	 v5+WDyVzWUSd0/ACFkVD1vaBQl4DbwMyp+swn5EGw0e0TmYjH0mgepgrDNDnuRwp/k
	 Vs5s+moiBLqRfugztzTI0R61aw3CkvXXElStYetYvLdSogJXjFYNctdO6J2ObxXrDy
	 Zq2wnU9pJpj/SYcD0ol1ic8LMloZByDbwTFEky3r6gJGCWWVyeYSfJ+xe8AkLsEgBT
	 NgZRQnEc766Mpn0E9FzD/m5L4cGWpeGjt0AXoZ8DpJiSUMUwvKQTZ2wt/4sXMj6ajx
	 Jl7NTGky1fQfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21D6B40A6D;
	Fri, 18 Sep 2026 15:04:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7549013D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66AA481223
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9cb8qRmWW6-k for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 15:04:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A3ED7811DB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789743847;
 b=oXGd/UqnrPaMA0Xd0QrasugSbyl+HFmbG7Q8tVV+c7DAuUzR3gGA8hd5wrCqgvHDCrv4
 thO1JtqW3LAHWVKosV2wZvTU3yf3P0dIC9zZWxwAOpK5DC8Bw9CxC3+2KmYcUySruLbFL
 nTaRrvFQurOEHVU871Q71bP7B92OCOXZkwblV/yi1dVE1fzrLzoBDLAVxEt7K4pZey3EG
 AwPm5JfgqyB9o0K7pF5LNPINjWcXbdcbOdpvKMYly1nPorXsvvcfZQeuekQFNSziheEeT
 pQV3ZAwu5MekJ/azznb6R7BS8hCDyJV7yZ6izEpF5CEo7NySdWZFYpiGXI4owNKNbgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789743847;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=YAvweK5hBeTvbKt0rG2ZgY2QpQPQH9MrinjJ93aHpsw=;
 b=MRSHtYi3pICx4fN7bLdTcUjouxwOacUTfS64p8zCyoWEe5dI0/nb/7wwIFEivLoo+snw
 Lsm9preWQQlA65QUytf/sAafjKa6Bb3FD5uJF9TqTJZsGuOpCtyOG20VzyAEieq2B1iHV
 K+Fv+bQMCg/MXFDj7ti45rjXkewWcX+Cts23XXpeXrLgvw8mbe0CNVVafA/SEMGXZRqTt
 2LXx9yqo+I+av08HxpCO2Q518tCtSkJdbEunzuxdmXDEjcqMTVhXyFwDa7reD1Kt/RRtf
 doI10zzvExZRp5rnnDhQb0AFDFjSuQSZfVuuG0ZLlLzbxcVtxzJTbiX0V1o02k1jDwQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pEGaT+Oy; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=pEGaT+Oy
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3ED7811DB
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:04:07 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f1354074so176008a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789743846; x=1790348646;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YAvweK5hBeTvbKt0rG2ZgY2QpQPQH9MrinjJ93aHpsw=;
 b=pEGaT+OyMcPWQWESiOVKqvH6cdXV1JxMbkAENcfxsxJr0Mcv8O4sRNaCAG/gN43wEZ
 WI3LUrXbzFKrSXS02O1taGnoN0FcUlGmDZ63K5IAK9engHF/HJ0ui7TcmeZnGvXFdL2h
 bBFgQ38p3/XBdWV8TPJAUPiwbCGwXrylC2Xpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789743846; x=1790348646;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YAvweK5hBeTvbKt0rG2ZgY2QpQPQH9MrinjJ93aHpsw=;
 b=KMdCUlQm6LDSz5zLyxTvRJXzCDbIW1JOFsqXagCVD3LBQ5k7AI4/mVhMG9K42Mbe2b
 jE+JQQC7J3/PFZl7DjhFLH6HmFwIw1j3BvTbW8vPUG+fHxtrIj1gP649EA3udANT1e8m
 MlYMMjei38zOCiC2h1P6l1YW1JRiH8xo1TWHWJVICgDODg2B21maJffjLXk5oamPQDJH
 DoybhHufBlshT1pfFGjyRICZ2YTGpmBwInaiFMRpaitdVwM/lNZ4Osxs1iN1ERXpqPab
 HbBZBN2uaJBP71gExCiEWPh7K0j9ylpim4P5Qe84leezge+azVGVolFL4HxdjIbkBEMt
 L9Cg==
X-Gm-Message-State: AFuF++nelDz2W54AfI1eLD7Anm3xJTAKa6eZeiggQ9mvKWWO2cKgSinM
 sKsTzsa9qVYQm1phXZZFh/fdb4njp6I2InHQsdV/80uq07lwuFrIdS124fDSVBL+Oeo=
X-Gm-Gg: AYBFou0k25V0VoTtTLd2ZSOcJ7RdKhVW8J3fziCnLweVclAxDn61ESpT5LR0kgoDKMs
 hnZgIjrnnKsPkNTGSgjEUHX6EQRkfd96nJmSSQSGuDlCnZqyz1uxFt2nEjYNjuVve/V0BUdltbb
 eBVOFFPdyn6iq8lw9t16J+gqqxBJ0NS/3o8/OeEo4KAGPOb0HR3ObVUbwyWJzEWw+Ut7S80eUGy
 ltrjwKZJUOIXO9zSeGt4L8BEGRrQqzb1kp0vGtB/Z+k53ewzD3qp2O2zP15KE19d/shEMcfcsoA
 FtSzoqDc0XMhE3GGomI4ii4iS2zLvOhMqGCrtmXnxJaW/2jgy5vOQSKl1salEaWmOs9sRye5e4M
 FyksDLX2DorGW/B9DNGoGKMoyJo3aEVRBf7CV7Ikm6rw6dTwxhMSFp3E7yVBlMRs1WNukeG3ctK
 lYTXErsbaM9TFpC+g1TSWGavrUu/dAxLZwiHkeEoJFDzqHF+kqKT91IMWriIKuU8sw0rN59sQFJ
 1dqaK5GWvNGDPSTr84VP7Ie3akMcazgr5amk+pW+4czcEyImU3S5euht1MAwGUB2Rujs92Rsy1d
 DNl4U8blxWzT6H6WhXNH
X-Received: by 2002:a05:6830:681c:b0:803:4e5:177 with SMTP id
 46e09a7af769-80ddb5ea3eemr2595563a34.0.1789743846231; 
 Fri, 18 Sep 2026 08:04:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e42815ffdsm1697270a34.1.2026.09.18.08.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:04:05 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:04:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 04/11] lib: Track whether a phase has a decompressor
Message-ID: <20260918150402.GQ858934@bill-the-cat>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-4-28e946f57357@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8OxDGGUkavFToHuC"
Content-Disposition: inline
In-Reply-To: <20260918-spl-fit-compression-v2-4-28e946f57357@flipper.net>
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


--8OxDGGUkavFToHuC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 02:52:31PM +0400, Alexey Charkov wrote:

> spl_decompression_enabled() names the two algorithms SPL happened to
> support, so every algorithm added to image_decomp() requires editing the
> header. It also asks about CONFIG_SPL_* from a header included in every
> phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about the
> wrong phase.
>=20
> Add a hidden per-phase symbol selected by any of the compression
> algorithms and ask about that instead, which also matches how
> image_decomp() gates its own cases.
>=20
> SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8OxDGGUkavFToHuC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq1S4gAKCRAr4qD1Cr/k
CrdMAP0azJvMgwApEQk76wncL58e9u1cbTqxEw7wqIq9zFs2FAEAjd85C88ZADzr
DPcpE0V9pnAGwAwhdSHRfFDZ6QN5Ig8=
=PKhT
-----END PGP SIGNATURE-----

--8OxDGGUkavFToHuC--
