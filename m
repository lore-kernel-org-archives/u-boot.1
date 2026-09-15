Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB24C88E7D
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E267F405C4;
	Tue, 15 Sep 2026 20:07:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DRZTf9cpNYc3; Tue, 15 Sep 2026 20:07:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1ADD8405A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789502856;
	b=ndWnDgepGJnskE5qziBVhbyPaND13lcRrHGxHN7qO5VciowVoCZWySM6d2yotEgx1WC5
	 0/baZ5d/qUKgKVVM/4aGAR70jlovmPh2oHMVTLAltnxpz3BPP2G/+zXgY5onx4icTWutY
	 XdjcrZAYd7J13526Xvd6Y5rlBU+YZTWwnqANHWYsQ8XSDmB98qynk4fPIfyXNUOu4pPue
	 gZxwXVxQuhX4AAg9OMETJIwSNECMtN5ZX5etUUMCLVhQsu8YqpcfAKGIScDHoHNMkHNF7
	 J5vzWxdalaXgtbivfzw1Qn4RUzE4w3Ci6hgnYGta/KnpWsMG+ZnIUX2S0aXE9fIWzvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789502856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Du74yJKrvaAs1KkR1pt4rgIkR6dKInybswGUmFTbdIQ=;
	b=UfNC+dmw3yN1ZqUkz9x3A6I1WT2XlbKzJcfMEXHw5GkbM8iKaPeQvuCh2Cl+HO0/Ls7K
	 Y03Da3i1paDsgViP9YfdlcIVnyN4e9fUDz0uwnsei1Xp/dVgPyhTpXQhFFBuaCa+MCtRY
	 +AhwaaJd5nC197TW8Q3Km8tbsgEUrdSGNu7nShk08Rxm3autt0DpnRmWn0Nu6xhGGy0tX
	 KUNZbUBtC13THvfF/Zf3Ns/aldGa7m4qkXL5VcfNxiefsSg5DI86hWnifA9fCuPQ0XxNp
	 iCia5p2KuiQITteTRGvBwPgaX1zBxBhAnPL+/Us9oiYLBcMFj4YToRwvsN4oRgoT+6Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789502856;
	bh=Du74yJKrvaAs1KkR1pt4rgIkR6dKInybswGUmFTbdIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qxLvAJ6VVNfswnqZwMRlGNNoVoTB4iWqs7EARJO/4dlSLds+XVifpWM9205gCrFwS
	 KlrYjsuBeTOvE6kRacoYtOrpS+Y04VYbzfUN6YjnSsQniCxQKU/r97aJpfiWVaoEuX
	 Z2x4EqelbIrWHBRrfwEISMpvvI/TBM0vznr2f0Wn6oCkRfddhvAdrJ4sj6iCjYAGes
	 R/gKV3PIdEpj8DtQSJ4pURaKofzWpdBCBg/572105QY8Ryf23bvslNNYeRekgYjNvl
	 28w9+s+X6CmHXMi6T9TbD4fQC7lbpVHf8XqbI+UD3XET+oNZStmeqezDuw/BAVfInW
	 AZ4E+8xhsfTpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ADD8405A7;
	Tue, 15 Sep 2026 20:07:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F754352
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5523380AC4
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:07:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GK1ZlQiDbRvm for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:07:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 65E7B80ADA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789502854;
 b=rp7tAmRQ900d3FP1uce1k8os4eZZYsK4YydsjO0KMbixqrwmSJij/hJiv/sKhPedGth6
 zNWSXs32DhSYu/yjIxxgcTWxjisBzIwu68y37wQH3T+STdDojumKxTgEY5xnkYT/XCztK
 dHyOlgumBJoYCl6thiEvaRcS8BKAGkcb1Js/dXSmTRRynmWB2kcr9Hi5ZbgnCY2EavNTy
 EFYcT1H7jJCOuypt6hjYsxgDCq3yaS9YMa0l9k6EhO+bACI9ct8/ahagRecl3PZ9tV2x9
 ag6wshIU26PLCDeJMJioMkfpCd1RFb7hOa1RRlCz36LDU3s7OqhQWBZwQkMBMqak1Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789502854;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Du74yJKrvaAs1KkR1pt4rgIkR6dKInybswGUmFTbdIQ=;
 b=XlD4UYMeHbCV5PQ295VdtfpX3ngoTynADbD890CzC7zwzv3XS6jPY5M21h85RjJqcB0r
 1jO0+GAnjzSvvJ0vrvPOk8yRDudKAnq1TC5bzf2s7USo8P/kLyHDkJfsfo04tr9zzm5Js
 0Kig0BC0tI1852SDjraW67/reDGwMx0wH5jdFXMPvXyF2KRlfQOc9CxZEjhwNKVsg8AWX
 ibyx3djDNoRK6QWVLwyFXJOQInRhOcVKE66o65jgR57t7fFEPOmfXq2gv5wZ+fdfgww33
 1o5nDirvCz0DzxJYoYImFEd3vlg2XxrqLAiYSSfd8wM9st6C7ojjZxTaEM1yM0ldSkA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Fgy1g19z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Fgy1g19z
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65E7B80ADA
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:07:32 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae6c9b81so35230eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789502851; x=1790107651;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Du74yJKrvaAs1KkR1pt4rgIkR6dKInybswGUmFTbdIQ=;
 b=Fgy1g19zX07AIcKEyJXIDs5YXwK3HFtkSCDL6Sz7uHZPVEssRQOsj9obB7h5lmpCf9
 ojcb3MirMswHo6zG3L5PMPvqiNMUIbjxDw6B1pvG3t1Tit4ir3ceA+iRv05WW+US4W2Q
 zBpXDgAAMG2tsfmbio+3pBfn/wFB3zXW6AfQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789502851; x=1790107651;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Du74yJKrvaAs1KkR1pt4rgIkR6dKInybswGUmFTbdIQ=;
 b=u9J4fw9DyJHsSo/9Ww5zYThOmjZhNhY0w8nSvNXvhZYGhAzLwxzdU4Pnd4EukKvrZC
 LuhfRmbM6BDfLh4Uq+VFpQC354ZK0KmuVEF5K+58dGBSK9nh99SwldGEh8/+NOU872sl
 dDmaheMztfzLzaDP++Vosf4eNJEQ3s1LbtMnth39GBEB0CudTycx8Abv9Zo1fvnxn9G5
 ZqhVdK1eC2CHrmI2pEBef2aYAMyug/xFmL7OY8vwHkbfFzX/xohafnlJg9n9iL5TMYmB
 HakMFNHM2sk5kP7zO/lqMjy8Xgy30TSKSO5bPUGTsaNNb7Xjn8iuLz+OOcpFuO0Gk+Hy
 GkGg==
X-Gm-Message-State: AFuF++ld+qhAtnGGtyK9fpEu6cHKKpCi3usOZaAFrJAny1WIe+IFE5jd
 3sd5rIAyvGZuBwDUWqcKrgfK2VRRGkubyMMz2c554uVYR1/pT5rdkAMggShnpDBuNG6KMVA7HL8
 tVOUfJ3YYgMnf
X-Gm-Gg: AYBFou0EWt0BgZkdE4D1PJx0BnlHEjqWmqfiCgK1AXglxK2VaOuNMlEz+zSUByzJV6O
 Z6r2sKwv8hsBZUZ3rfl4QylbxM9eIbHftlSuloXLj+H1rRa3eLwSJpivKnouPmnIi3BkCrvews8
 wUjRsBiT3Jk565nt6IkARNENOhFAjbsj+Abyu5i4PKPUvP+ebYK2CjnL1qE3zgOF2R9ZGQhr00t
 qHb/E5y5qCjxTrmOfN8YJGj+2tsxFg91EwETiyslJmLS2TJaJhh1iHRva88UWHm+dtpOwu0kqUI
 Z6bmeMmT6fM1J4gEoGnBeu1AwTQZMVvRDTfkNlCyuY3ueOCEr9Md4/jrDJ43eluTkovojXgmU4b
 zc8GFf0/eIbv4RVNYQK7pzxLleZita4M/3MGQkQHi7PmAOphVzoQZeLaWin6fzNGhgFiIuI+yoa
 oB8y9LgtKIuE7xSsJCAkk0O2wc6Mywv4p5MFZZXfRtwwM0fGw1wCtvApdPfB4I9ZpUPTEJnBtic
 rXHmcMr6bfPNCqrqZvwVR4UJVdtNe8r6EqevNl8CeFWkMVQOP6ecGMw0e3vJnWrFfmIGXB+PRhk
 hKFj0cGp7RmViy4wlW8I5LdwrW13BZE=
X-Received: by 2002:a05:6820:1992:b0:6c3:23f1:9b11 with SMTP id
 006d021491bc7-6c6397941camr3006731eaf.23.1789502851125; 
 Tue, 15 Sep 2026 13:07:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c7a6160149sm774270eaf.4.2026.09.15.13.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:07:30 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:07:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: u-boot@lists.u-boot-project.org, jerome.forissier@arm.com,
 ankluemk@microsoft.com
Subject: Re: [PATCH 2/4] boot: image-fit: add overflow guard for FIT
 decompression buffer
Message-ID: <20260915200727.GE858934@bill-the-cat>
References: <aqmYHG/KDZT6K8AB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WqORP17SLtW2JpUh"
Content-Disposition: inline
In-Reply-To: <aqmYHG/KDZT6K8AB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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


--WqORP17SLtW2JpUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 12:10:20PM -0700, Sriram Sriram wrote:
> ankluemk@microsoft.com=20
> Bcc:=20
> Subject: Re: [PATCH 2/4] boot: image-fit: add overflow guard for FIT
>  decompression buffer
> Reply-To:=20
> In-Reply-To: <20260910190944.GN1764417@bill-the-cat>
>=20
> On Thu, Sep 10, 2026 at 01:09:44PM -0600, Tom Rini wrote:
> > On Wed, Sep 09, 2026 at 12:20:14PM -0700, Sriram Sriram wrote:
> >=20
> > > From: Drew Kluemke <ankluemk@microsoft.com>
> > >=20
> > > Add an overflow check before the 'len * 20' multiplication used to
> > > compute the maximum decompression buffer size. On platforms where len
> > > exceeds ULONG_MAX / 20 the multiplication wraps to a small value,
> > > leading malloc to allocate a tiny buffer while decompression writes t=
he
> > > full stream -- a heap buffer overflow.
>=20
> > OK, so lets assume an overflow, or just an invalid max_decomp_len,
> > shouldn't image_decomp handle this case and fail and we catch it?
>=20
> You are right, and I should not have sent this one as written.
>=20
> max_decomp_len is used for two things -- the size of the buffer we
> allocate, and the unc_len bound we hand to image_decomp():
>=20
> 	if (load =3D=3D data) {
> 		loadbuf =3D aligned_alloc(8, max_decomp_len);
> 		load =3D map_to_sysmem(loadbuf);
> 	} else {
> 		loadbuf =3D map_sysmem(load, max_decomp_len);
> 	}
> 	if (image_decomp(comp, load, data, image_type,
> 			loadbuf, buf, len, max_decomp_len, &load_end)) {
>=20
> so if the multiply wraps, the buffer and the bound wrap together.  They
> cannot diverge in the dangerous direction, which is precisely the
> scenario the commit message claims.  And every arm of image_decomp()
> does honour unc_len -- IH_COMP_NONE has an explicit "image_len <=3D
> unc_len" test that returns -ENOSPC, and gzip, bzip2, lzma, lzo, lz4 and
> zstd all pass it through as the output size limit -- so a too-small
> bound comes back as a failure and fit_image_load() catches it with
> "Error decompressing %s" and returns -ENOEXEC.  That is exactly the
> behaviour you describe, and it is what already happens.
>=20
> For the record on reachability: on 64-bit ULONG_MAX / 20 is about
> 9.2e17, so len would have to be an exabyte-scale subimage and the
> multiply can never wrap in practice.  On 32-bit the threshold is about
> 205 MiB, which is reachable, but per the above it degrades to a failed
> decompression rather than to memory corruption.
>=20
> So please drop 2/4.  I would rather withdraw the claim than try to
> defend it.
>=20
> While re-reading this, two things nearby do look like real (if smaller)
> problems, if you think either is worth a patch:
>=20
> 1. aligned_alloc() is never checked for NULL.  A len that is merely
>    large, with no wrap involved, makes the allocation fail and we hand
>    the NULL straight to map_to_sysmem() and then into the decompressor.
>    The IH_TYPE_FLATDT branch a few lines below has the same shape and
>    follows it with a memcpy(loadbuf, buf, len).
>=20
> 2. image_decomp() takes "uint unc_len" while max_decomp_len is a ulong,
>    so on 64-bit the bound is silently truncated.  The truncation is in
>    the safe direction -- the bound ends up <=3D the allocation -- so it is
>    not a bug, just surprising: we can allocate 20x and then refuse to
>    use most of it.
>=20
> Happy to send (1) as a standalone patch, or to leave both alone.  The
> other three patches in the series do not depend on this one.

I think we can leave them alone, thanks.

--=20
Tom

--WqORP17SLtW2JpUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqmlfwAKCRAr4qD1Cr/k
Cui9AP97n+NKYQm/NpC2OiwAz6YzXZFvmpS74Qj0dC+LD4vgngD/YcD3R3RPpSt4
7T/vojcwZ3nMoCQ8NPPPeEQZU9Rdgws=
=14qM
-----END PGP SIGNATURE-----

--WqORP17SLtW2JpUh--
