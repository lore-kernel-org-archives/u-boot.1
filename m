Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E617606A327
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UXIAhKRb;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=KsFBevXf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF32F6088D;
	Wed, 11 Nov 2026 14:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBQVcSo77S_K; Wed, 11 Nov 2026 14:37:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 113ED607B2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794407835;
	b=r9D3/vl4OL6LEOfxkInID2Ss68jSmCP4i3aI2bhLAGknTSHnFZ5Avtn4ZAreC/bdlMj5
	 cGLOGteghttogAW9DbxA55fUNu1KmbcGKUJN07pdvPYy3i+twas6hXoV3Z800tMmus7wE
	 t4ai/LIu/WbzFLBC9gUNc4uXIPA6zs66AebdgLxSDtrhq3oqapoKuPNaVaJlsNhp8Smau
	 B/KoVzg0dBDtqP5q/Reqii6AdXxYj9lX+F2a0bUGUL3J5pnqM1HarJctoOgIiIliTnd3k
	 izakTaAF/6kAsSv+j6pzze7M8/63sF/tJhK0z87SQG8uZ+mqlp3y6Va6YAbo1hAZOug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794407835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+s7ySRMKdIZdW+aqJ7lk92/ilKJcZVVREfYAzxIf7Po=;
	b=Gs74J8JMUy92TuAPtk7FgcGSftE2wA7oSA0zIGPRLRD978r5/u+cVZkEVA4e0M5n2hsY
	 YtT/WuAqEHLY6Dj0+okAiebcSckIx4MCDJsbMvce0AwsSX+YieyPugZwPolm175SVVVHY
	 qxX9z9AX1SKPoKEG0sFGnfsDFXfPysHnRQNt5pW1c7ECoOTtmFo3X8nWghcn0xk9r17hY
	 W8pWX05jeWuf4jRCWMe/4Bmr/X5NflbGVhYTtjY6Qx/xPnzp5rVRWcI4I62nZGVJScc9b
	 JJOEFqniyTtX9VNhAdRtAakDs02HhLWNf2qHfPSDpWxbgXxUAtAowjj7FUCIN6OyO/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794407835;
	bh=+s7ySRMKdIZdW+aqJ7lk92/ilKJcZVVREfYAzxIf7Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UXIAhKRbeHvlY9h+fF+cpy5HB3q0rLDFzWltYDFndeAhGz/CaPhNvdJgawjquFkBV
	 AvffveLRvnHGvj554nk8VaywwUiHakR3qHZ+yoBFJ/GJpniKyPg9Yd6zBpggBcKh+a
	 S0JLZb+BA2P8RNBChITjEuNBLhuMZVYI8b9kH7g/6MIm5GSXmzsbYJgKR+0M9ATURA
	 qF/N9tHAUeWtOIUZeAFFL0Nf/swLU/y8MnFQjkj9yKdIGBjfDD+5YnoFpkTVsOm/uf
	 PQ1cEA+5P04ItSF+AW0uHh15LNgfkrOYmhvrz/7vPOEG7wXqvkRNkHJ9lHb1jvIKwI
	 zsq2USdVQH3ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 113ED607B2;
	Wed, 11 Nov 2026 14:37:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2102617CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2AFB408EA
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id av320l7SCjDY for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:37:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4F1134089B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KsFBevXf
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F1134089B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:37:11 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-53c156ba662so1633220b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 06:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794407831; x=1795012631;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+s7ySRMKdIZdW+aqJ7lk92/ilKJcZVVREfYAzxIf7Po=;
 b=KsFBevXfr9NuHMS1TLl2Xl5WF7uyDfR8bbRinKOb4eBk0+8FuIbGEHZeQPbxnbnfYD
 4KCFy7x0MvQphX4xZvHMLx3t1ceLTHknhE5HZ9JFssRuebceg+7cFLJxHKoJWucPNBZ+
 RWjPyckNQ3VRxFH5q6hGRQjJCzHt2M+sVV7FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794407831; x=1795012631;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+s7ySRMKdIZdW+aqJ7lk92/ilKJcZVVREfYAzxIf7Po=;
 b=G67gSAGkH4v4JFuLTua8NUOwXFGkVs/jFjsFBcpzxD4x5XoYXvLuwty4omBtQuHjB+
 H8CDfDEVEgbnlvVHZmKXpBwzo23g+QsR9UFnc2wxNq0ghY5t/bW9mYgtRHVhow/kfxXr
 hLWA2dmreOodQHxmTEgeI2Btx3zQK2CigfRNtkO/AZOa6Hi8UptQJld1cc/iEdNLJlXF
 mdMrtVOz1oIzmra+clfGGcUSXDSDN5kydMgWAVU3Lzb4uebp1rgV1NSi5+CEc8oSS0LE
 6LgXQiGnPBrtFJt5vM9y6yWrqhuTDbJnUAarQzAnOTI4AXJmV1V94EVluzNWNBjR0JUD
 hQ/g==
X-Gm-Message-State: APuU4Z9pRKZwseurn83VUoT7OWg9DSzUuL9sRKx7bhtSNJyi0F50C2Lx
 OXAdjNixFl9CiXZ3DHU5mM99F7RwbR1F/3z3cy04OR8UPdyQn0mlSWPQ/Ni7qUfR4v8=
X-Gm-Gg: AYBFou18hqcBSU7XOc9yFAxXoKxMc2uPMHz7piIpo0Ci19MH8ajYC6u8zYHvLpCGSg6
 VmNwfUEmNY+OV2pp+6mxQ8JZ2mqbpT6BsBM+/MN0+wfH6/GPK+OpBR1L513K2CusSDWYNF90xx9
 /A5EDUZ+TQEACui9VHPzxESLQ3t0APQph18lmUwgquE4vA2QhKIs4jpaSWYAkEMjyuOYTP5xYej
 YduvujNFpd998i1qK1ijT8ylSk0sshTJKyRSOblp3kpcWAY8eg0ITaFV2VHeRqHrb+p0aP6faQV
 8NPZa76032jDQWsyQY+PJOJbXjrF/z9VctzMu2vXD+d3fUcm9223gswlKhyCzy8unUa3lGvKWnF
 wSdeba88hDBBMj/zlM1Ci4jtbPP+FAjkWdtFXT54gfcWrMRhfqsglzqP6mdhcZDMWTY8phnErh1
 KWkfy1iKZnEGRN5Hr1gLZedGXuCn0beVzw+r/bWcFGE+oR4n/d8qPrtGw54FXYk9KlmBSwLqeXr
 TiVzJeMlZzpy+yc7Cieen4I4KLgg/R3nwuqBXGZoTkh6muCVrX1bIVjnqxZe/PwmpUL2Ef2rnqh
 YXQefnUE0njjN/0HWL8z6d1gkajjGcRVNVJkAuVVYXhryDwnjnVlfI9QKQdxyjJHdqTNFiIklGk
 FTWown1Q+iD89VlT3wCHB7HdEoczNWBc6RpKT5kaH+iXLDpEBL1uGvuskn8Rvi+f/Q8ew7qxJnY
 qbeYfvgIVhLGq1iEcYAnHsdoF7pyepWbM=
X-Received: by 2002:a05:6808:13c1:b0:53a:2f73:29ff with SMTP id
 5614622812f47-56b9325050bmr2317012b6e.6.1794407830705; 
 Wed, 11 Nov 2026 06:37:10 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56906330d56sm5227460b6e.15.2026.11.11.06.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:37:10 -0800 (PST)
Date: Wed, 11 Nov 2026 08:37:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] disable VBE by default
Message-ID: <20261111143707.GA255403@bill-the-cat>
References: <20261111093212.3390778-1-pbrobinson@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rnJytfqCEUTUZvNv"
Content-Disposition: inline
In-Reply-To: <20261111093212.3390778-1-pbrobinson@gmail.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--rnJytfqCEUTUZvNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 09:32:09AM +0000, Peter Robinson wrote:

> The VBE protocol needs explicit device support and as
> such isn't particularly useful by itself without that,
> it also adds size and the potential of an attack vector
> so devices that wish to use this protocol should
> explicitly opt in to it like all other large features
> in U-Boot.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--rnJytfqCEUTUZvNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavR9kAAKCRAr4qD1Cr/k
Ct/YAQDRcUfbqfhc1w38uskZNKQDnSxSQuy6VTiIqhohlGNaKgEA1AMVd5ic1srZ
GwoyZ/sNYi0mkKRBJvUc1ogxvG5BDQw=
=ziqA
-----END PGP SIGNATURE-----

--rnJytfqCEUTUZvNv--
