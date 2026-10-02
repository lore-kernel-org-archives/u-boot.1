Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D031FCA5FE5
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 20:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7463881343;
	Fri,  2 Oct 2026 20:52:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8uLBL5HrXAe; Fri,  2 Oct 2026 20:52:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BC68081347
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790974325;
	b=C2MLVK9seBxcihKdvJy9tD1IOPE/fNRKqSvXvbzmYJ5QkGEJf/i2D+MnIBlvd25H01tZ
	 v+9zkQ4GSKKpbt1AxHSlERSrcazgvkN3b+YOtjP2WGDmwuky/MtamPxwAV0ZEr5OhqFrX
	 aFtRXy/FnuegUYTzSu2iBPkRccn3WlIoqMJjK5/C4AiEMZCD4G0KOyG/Oz14VCsVId155
	 Uh7XE2rblFmJSvkIh1mI9JXckJ9k8LIw+QmbrQse2luZv3VybpSX6c69supkw8UNpJPGi
	 0PdJWCjiPuTOLwVwF8POcSBY/8kIoH/4ScO6YqK+h1taejbtENPd7iEUPGM9ccODsfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790974325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BCbTbVXwpRuT8ZkppCyE5H2XwV249nVrhnwsNZSOCPA=;
	b=NtDxaGIIzD3Thn/071tq0V2iGbLngjKs9cn41QRG3auInF/dqAxsw2NGiLGyQWlUt7zL
	 6xwuKCHOIwkRW4sf3ofFGYf360FrBlhI/F9etO5+hDtVvwTf76Gjvt3oEAbPrwOEyfkPh
	 lTGyW6AuJXCEVDIvzEM2GnN124kvwErD/MhSTbXr/6L/N2mOVsGhPBN6KsT05rdDpyTi7
	 Gtq03iec/9zNOohnLfLg6Kh+F/yBfwJjb+am4U3T3bE30qzF5emXf9dyuB21xnc9fSZU4
	 Fyh86mVIfrJa44ZTvb5Oc21JITFk8+R2S42PieGaEYlEcoWpVoHBhgGgj7bZlSdzmPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790974325;
	bh=BCbTbVXwpRuT8ZkppCyE5H2XwV249nVrhnwsNZSOCPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xUEmXR+68QEFPgdMYA0/9zCGgGa63iTWu8AVd95uUT6FgbBmeKsjNu1XhP6j4PZZ8
	 BFa6pcuBh6eP6uHqb5MeevH09kA5GUY+uy+WJzIiyI/QhAdapqR5GMjrNflaSqg8Vq
	 l7cRCyyk1rFB143XuirCYG99XYYe3l+aeR4D7O1SHrZ9w5ZS+Xf5F8urdq4WDCNJBP
	 ktF49jCqS4ZSV2M+fYiuNGD2/6ixFTFsRjjS5s6ViKSbaaCdVtpFes189NN95OUGgh
	 cwfuLHki1YvU8LTgPISUPbfNbdunqnf1sz6N2qi3mskUJ8Gp6HROKsdpKN2uCGLx9p
	 Wv1LA7HDS47/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC68081347;
	Fri,  2 Oct 2026 20:52:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C41E1282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5BDA60D96
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DScskuShCxbF for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 20:52:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F162960D6B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790974323;
 b=T2Q+1sWVpJns9h4X93LVTCSftqRAxJGvBuTDIXZX8gkVaXZ+wrnouCAPjbIr6hjl9CuC
 gcfxk/8vpApsJ/aHfmpGUWM2T88UXXC53gVwnUztGst2RhN3OQh+80tak3Dtn36VVomNj
 0ZELKI2mxTWVwHOjSfpRsvpswU5EAfKcrh+6JJDd5H8MDyC4sfmjlv78NzId35GW6bzsD
 cyMhUdN22+3ck43yVNKx45VjHSk0MBtef4cCA3SLsM5mv+RsaLXLqPm7IWzAE3wzbiiul
 Wp2oexdydkBscJ4PeUM/sa89QH2nPZ99DFm9pqjL3S4il9LWPil0QOVHYf4rHyrGgag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790974323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=BCbTbVXwpRuT8ZkppCyE5H2XwV249nVrhnwsNZSOCPA=;
 b=cPm8wtnWc8V60l40yUrc1XMDnY/+2/HxetNdCCHds93T9HxUXtftL/O+pB19uS6ZAz2t
 hoJEIF6mCyD8talBrhC3KK+LfxO8lFQmTZhCqRO1TxfUnYqQkHTanwVsd48OrEj5FGzM9
 0M/4k2UQJLhGMcT543NFC1VRLoWIh7rf+4FAcLk4u6Pq9F+7bYXVQiqrQjjAqQAR5H1v7
 uj6SRjFZ1Le7oKsE2M39hjjNWPnzsmo6u7fNfohGVTrclJoOLug1PHChhyfs2iXfj8IHj
 6fldQAX15zsZg8Yh7gNeDqAzB1yjV7JCePZkemrtiaOvBH2r9tSBrmEh0hgjQ4+9Mlg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bmXabgvL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bmXabgvL
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F162960D6B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:52:02 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-82395ae2ea8so211766a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790974322; x=1791579122;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BCbTbVXwpRuT8ZkppCyE5H2XwV249nVrhnwsNZSOCPA=;
 b=bmXabgvLfMvgekcZH3F2ncmmyybOy5orGwasmy/4sZknWU9edx0QuSuuyLKga7bwDf
 PuGY2eJ49wdXlc8SwS+3ceGksPqlxYDhtihXlpbZ77HDaQKplaN9EEQpqyu3JiQpmBoG
 xe/nGvcA7h6gT7feAm3eRRhoPLgLugBsOexCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790974322; x=1791579122;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BCbTbVXwpRuT8ZkppCyE5H2XwV249nVrhnwsNZSOCPA=;
 b=Snx8qetkQbTx0zLAUYoKUZ2HT/2OStfCxTLJPz39SPtTX7WHVxkRUeDWLDu53tvcCK
 uiceLQGGpb4lCkFh3hkAs60o+EbY9RSp1NK9wbKJR3MXIceRqJoyS0BiuuCBWUx5paUv
 95wjQokQAYRsUFHEQX7fBmwLsZxefc0Zd/c2licUaqGyHdVz0856we1WQtnYOpi0gSSy
 3zeRRjH+KdrXH7QA2dffosbtZByOplbvpVkxbIKTdPXB4EIKOMYzh6ByVB+RvYnThlFL
 2z3TYDZOQKAhoyxENwcdmyIXchexAkMoYfBm3JtA+dho23jfoUGHg+nAjDxHy2SysPMZ
 /bjw==
X-Gm-Message-State: AFuF++nejn82+O8i8L+MifRnB+FoiHrIj/r97m8HY60ejNmO4DIhGSqP
 ORRoYspWqt59n+w2EL6ouzl0P/JVQB+il0ucwNBDLmg417i+Xi9u+eUT08hbUM0o/yg=
X-Gm-Gg: AYBFou1kJ+qm/A/U3UVwdOdli0Fo0Tku4poledGk+Uywye62gMFkDkXsAP4Sx1l23+n
 KSNE+bAZff13+gyeFpTaFRSJqlPyfFwhkT7B5wg9YlmPrUzHikeQV6KXG4O3gt0O+j6gH9588NZ
 3RSJZb+j1ALtdqwzEv3eCGnXq6tsdR/Y5mBJMd1I2T0u6kmiDiX/+Tr8+jhch5ZIJE8qZLmFZoM
 8NA7wK9ZjgV8wM9QWDwROGDGLG6ooTqF5s9DY3EmkQEzNZC3FoMKK8UBg6ys4UxQK4Z4e8wlBf1
 hgNUonIoUeEMbrfdMO2xyOwEBWTWRe/BQt3uha1qWdZbQ9X/e8Fnk4Vi7Fs9EuobNtca19nELPy
 kJVYfHIlyojfemsbWdLkpJShJ/w+1TkwlemK8jUqt5RcJjVbuK6B5dbTalCwumNUEQf6VM7p03x
 cL4uWddwMXNnMHvGM0Pmcd8srmcdcpXohzOmRXONCwEZSyd3rhdVOIy/UxAaOXkxZ9+x+Z1T/nO
 g2wJVqrRqgZ1oblAPsvQbzs7sqj5MHz65uOF/cMfDYz/tAGJSgDPD7oJtTMPT4O1VPslEtZnj9A
 SxDF5CEyUia2nMpkv13RKtb20h4UuQ==
X-Received: by 2002:a05:6830:4429:b0:81c:b7d6:e6eb with SMTP id
 46e09a7af769-823fc440597mr635770a34.7.1790974321620; 
 Fri, 02 Oct 2026 13:52:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-82279b7dbd9sm3934378a34.12.2026.10.02.13.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:52:01 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:51:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>,
 Cole Munz <Munzzyy1@proton.me>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2 1/2] lib: Let the decompressors use unaligned loads if
 platform allows
Message-ID: <20261002205158.GC2658242@bill-the-cat>
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
 <20261002-unaligned-decomp-v2-1-675466ced78a@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fwSGflvHTX+gZxuR"
Content-Disposition: inline
In-Reply-To: <20261002-unaligned-decomp-v2-1-675466ced78a@flipper.net>
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


--fwSGflvHTX+gZxuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 02:04:48PM +0400, Alexey Charkov wrote:

> ARM passes -mstrict-align (-mno-unaligned-access on ARMv7) to everything,
> because when the MMU is off any unaligned access there faults. The
> compiler then has to assemble every wide unaligned load out of single
> bytes: one ldr becomes eight ldrb and seven orr/lsl.
>=20
> This is especially painful for decompressors which refill their buffer
> in 64-bit words. On a Rockchip RK3576 SPL, zstd unpacks a 30MiB Falcon
> mode Linux kernel in 1947ms built this way and 596ms without the flag,
> and the SPL gets 2.3KiB smaller by cutting down on the byte-wise loads and
> ORs. gzip, whose inflate walks its input a byte at a time anyway, gains
> 6%.
>=20
> Add ASSUME_UNALIGNED_ACCESS_OK for a platform to state that the MMU is on
> by the time it unpacks an image, and let the decompression libraries drop
> the flag when it is set. The arch exports the flag it added rather than
> lib/ naming it, so this stays correct for anything else which adds one.
>=20
> No functional change anywhere until the symbol is selected.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

I think there is future room here to build on, I don't hate the idea of
someone looking at how to invert the logic if and only if there's a
clean way to say "here is the pre-MMU-enabled world". I don't know that
such a line easily exists. It might also not really be a win for
anything other than decompression and a few other operations anyhow.
With that note for future work:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--fwSGflvHTX+gZxuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasAZagAKCRAr4qD1Cr/k
ChsYAP9N0eOF7yTmL3nRA2Ti3eQAn8wTV1vu12FfKRHmsoIz1QEAodRHBUUiDZ3p
ivsin0p43jO6YtmkfFkbCwuSZ/wmvQA=
=lMoq
-----END PGP SIGNATURE-----

--fwSGflvHTX+gZxuR--
