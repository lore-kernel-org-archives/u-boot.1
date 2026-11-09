Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2E606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kZaanYhU;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IZP3lnCt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7F7980F1B;
	Mon,  9 Nov 2026 18:21:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2vWMJtkt8iE; Mon,  9 Nov 2026 18:21:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4CD7980D77
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794248474;
	b=e8T1D9hG3reUMpgjSSzeubTiedCawqtvyu+ngiF2O/HlF5i3cApBjjZhzxejElg1tfM6
	 s5hZSLctasq4rdim2hWaNX9lFgu1xlHsidssqGveWz64xKpDiEpZ+QiRYyvWICcA+OdC/
	 oDJ0UWKoVpcZfoEP6kINKboUzcZDVEiHWjMCFr+Bfweq6aP3X7xAJYDHFT6IyQQJ5qS9G
	 LtMIlBba0Nrz4GMN2CAR53c4MBNFosqZBtvhyLZk7HvCeDk8WGFjGxzN4D74gFAG6e/80
	 lDqr8sjhYkt6KPfciTPfVvqX3KMsJbAndDWJEKh1TY7ZMkymmgcl5KwmjM9idLkpSxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794248474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HlT9E1LUmpeEECxriVUVZ/QNzK4A34aMGkWs2R8wkAE=;
	b=iZ9ayzRMbyPaKkPcgDf71UhSQbAeWdTjtA9S8Ly22AOs2iTvnofl5/IRNtZ91Bsa4CNW
	 IHdq58s5M37On0ui4xZXIhXNibog5X2EREPU028OZgwQ342+xBhSqc7Dq1Yu5ebmDkYcg
	 6jU2R+4b1HdnClIMrFHYTcbawQE+6eLS8H6WmmiQw8A7k5anx+q80sXQODKoIfa20s+fu
	 CZHZC72saABm/wFw6Tc9T0ETB59wPwdzQclJaV32RPyP4LLSuhz7xFcVV21IIwDoXn3j1
	 uF8t+TivcaEn7+nRthbMU2A25jTFT6HaSQBjV2RUWlKbMF900lvhKNdyARieHi548WQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794248474;
	bh=HlT9E1LUmpeEECxriVUVZ/QNzK4A34aMGkWs2R8wkAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kZaanYhUuWr/Okt/H8phOPLI8srNxM3oeA479zbYhsYIflAxZ+YQUsv6IqA4a1EGq
	 KdcUjO9MtAJvzzV6H76ASDDMz64CsoeP5MEnQgP+FqXpRBSMYl9F9xYFEXNa/udBjM
	 1ZTLbh379vRjhX5hXgsrXeMpHn7VbsfOeY01GPgT/4XbXVQsvKi3J05XV561XFxhUu
	 mzZkQdx0hADcZhaExw/XU3DGy1TpxNUicxzfO5E7wONxR7NmFk2EvKkw7Qsd0+wJGg
	 ir4LEF80sp2+p+sBKfyoGKKJ6uemAEVR6NH3Sz0j9iVIj7Ac5qUJ+MlGv4fxsGOpyY
	 Dauq7nEHKFCWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CD7980D77;
	Mon,  9 Nov 2026 18:21:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C54528C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 524D3402CF
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:21:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sIOqJskLNbdG for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 18:21:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 93D3C402B7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IZP3lnCt
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93D3C402B7
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:21:12 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4ed6d69bdfaso667463b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794248471; x=1794853271;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HlT9E1LUmpeEECxriVUVZ/QNzK4A34aMGkWs2R8wkAE=;
 b=IZP3lnCt3EgzeKjTCAZQB+kt8V+VUpEN8sxDoTPGhWks62nQ0lidKurzKLkHn1rF6a
 3c59t/suCD+mv6u0fcAoclK9NuxEAyTiCZUG7O148YQENZ0EjhFcMWg24uvfUdNLZu/p
 1+uH0cVAWVOpq6b4Tw9lIFbxOPuAol6bJlpws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794248471; x=1794853271;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HlT9E1LUmpeEECxriVUVZ/QNzK4A34aMGkWs2R8wkAE=;
 b=rq2XaKefgIloabjN10kEPqhcz8YfwORP2pq/pHdeOs9nFNGS4TsoScwdD36RAJWxGc
 V2Ou6sexfBCTsX5fuRKe1Sv/emUWd91h5pTXjsQLvCjueu/9grx5ZkyociZKJgMKAPvq
 a+36XCFoTNsfxqVJLrpLIpX+PtRrA1/d/xmEEjH0MWEsQfKvfgE55xP+zB68w343gfES
 OvVE5XD0EGzcM9s/cLvO4QK1vYKnE0GSNs/foTxmOK6p0ixeDWle3cUJxMQH8CCw4t3n
 +TXUAfJ7WAr9VHUgljIkJ8W+JUV5yvURV3BfMBFDKgQ9XU4nLPt5TuS1PdImTf43XXle
 TntQ==
X-Gm-Message-State: APuU4Z8mtLLih0Yv/xfXvxuYGZOcjyJrOviIl6rmOwEHTvQbfkwxjXcQ
 LxqCcv1pIcpuCguMCwvdCNQDTT1SMTZQyDBA937U1UHiGE43q6qhyEG+PTwQRCSZ0tg=
X-Gm-Gg: AYBFou00pf118ilhoV2zc2vnbvEIURV/pok0xRZCE16aXnxPy5h70O8+nRkxME/5+hO
 Et4fI4w1cfy5vbc04EGzsopaYHrn8V4Ifx0gQCarycEkgxgjMp5nig1RnPkdOKmZrujoQd/skgY
 UQYWC2UDtb+ymFfM0agP/SCwMUuuw2Png9u3PokLfAHi3oAy8dtKiZ5Utdw3qeT85pTFeJH3f5n
 x6Aax3VxDDFY5b434ZbIwgZX7e44oeBdqswI+y3ajjWMBC06Qm3x9o3gdgdZopNAnu7T1i5C+h1
 PN8GIvJJ7BGZVD7+yKJQ7vRzmFO0+i4v7cRJ8ZvGuQ8UL1pFLi0aYZwxYApz+vfCvHdyutXHJCi
 PbX0tmWaqkaq+VjwaFQkObOJY46g7bbj/WtB5bKABEx7y7WVKh8IpO0/i9T7TSBoyDWft1Uztm0
 MHxYgLcCUBZkL8hepXeO7x3QwdWBN+KrOIjdY6WGJoL9a0l0BdDZcJACSppMv/SSdALICD6ob9l
 yN2WppBcoFqE+0nr9Nz6/pSwhKqvmDp7FuVpSIVaovAUoG4plSPq+yOjAkwe0zrYnZBWYa466If
 ymSZg1EJzdSz46aFxhBIJ/Zlmc04ePFZbGkY6y3qJ9ZyY206H2rcFkm3d+qq4qf6BIFYUFwSwhi
 UkMyW8jZh/972z7oxhtNwSYy2KEvhjv74iwnppODxndo6VGzOB/PgHs3SxCqtRIHGuLoMRbWScV
 GFeFTNMGvgJLJxK9J6F2CR9HQ1rEijgw==
X-Received: by 2002:a05:6808:179b:b0:4d5:295c:a831 with SMTP id
 5614622812f47-5683ce01e77mr347705b6e.62.1794248471256; 
 Mon, 09 Nov 2026 10:21:11 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56813ac6352sm5035234b6e.1.2026.11.09.10.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:21:10 -0800 (PST)
Date: Mon, 9 Nov 2026 12:21:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>
Subject: Re: [PATCH 06/11] video: sunxi: de2: Tell the display the frame
 buffer size
Message-ID: <20261109182108.GS3741582@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <5e2ceb08-8dbd-48e7-acf6-ec30f5ccef0c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pP8cdX9i54/h0/yp"
Content-Disposition: inline
In-Reply-To: <5e2ceb08-8dbd-48e7-acf6-ec30f5ccef0c@gmail.com>
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


--pP8cdX9i54/h0/yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 05:29:35PM +0000, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> The DE2 driver reserves a frame buffer for LCD_MAX_WIDTH x
> LCD_MAX_HEIGHT at 32bpp, but takes whatever mode the HDMI encoder reads
> from the display's EDID, while sunxi_dw_hdmi_mode_valid() only checks
> the pixel clock. A display announcing a larger mode makes the frame
> buffer run past the reserved memory.
>=20
> Pass the reserved size and depth to the display before reading the
> timing, so that only modes which fit are used.
>=20
> Fixes: 56009451d843 ("sunxi: video: Add A64/H3/H5 HDMI driver")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>

Here and elsewhere, fixes isn't appropriate for populating newly added
fields.

--=20
Tom

--pP8cdX9i54/h0/yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavIPEwAKCRAr4qD1Cr/k
CrMZAP9Cn1Kz9J33wncO6b48iJBfE+S61ajhU6U7OLxCmfK46wEAiPcrrc9f267d
cq0J45FqnGyKnUMBsC30Isdk+hbjQwU=
=ue12
-----END PGP SIGNATURE-----

--pP8cdX9i54/h0/yp--
