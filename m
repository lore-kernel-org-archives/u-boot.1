Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93587606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=smNNiKBX;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=s95uDlYk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AA3E80E13;
	Thu, 29 Oct 2026 17:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tyT1d5dmiMjG; Thu, 29 Oct 2026 17:14:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A43B180F6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793294081;
	b=ljReVsq0DHwo0cYl6NSFtEYo7i1JBIhlGFMeefPY9P6TqiwA7MSMP1kl3cguvzX2N3sM
	 76Hju+hFalaelhi9QYpYjbIPG/gozOVKkAvEhiHHKDSBlXd4S+UcMW6U0O/fF5t3bfNUW
	 IHBp0jKSCvNYe0li2BWk5kYYRe1fjsULJDRsIjFF1vzvh5soVf6BGB46cz02wRH4YH0Gm
	 W1UPppt3T5xObV+FsIlQdrv7SeOnjjwlvDdHqd5qOYVfB/An8ULKKQ1Gn7LdQua1Ao9CJ
	 cSAtCQ7vRhlpOpxny1Su97dBWGDJRd6BBGxg7esABwQ8PvtWBd7j1gvUHw68US3gE2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793294081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7RTc1dEm5cbr7blNGSpuykRryen48bY6ic5cAqoXCjQ=;
	b=HJvz59i2LaUsxwFVdfoJkEoHmrLjCirLPACvewxSyiL9A7gAD+qB/6ZXEDsp31xQKQNN
	 RZgSalK5JnbAkqPRRTqfHt1chmlvcKJ/sEOguQXF48V/HC0sl9P75hy1TxkkgVtHoDXft
	 V1h0S+XkUIG32K8/S3LNYq+Nc3QFjHqC2L72UsdA43WAmfUCoocMMgPb4VKUFrk9hBrps
	 duL/Dbe+dyp8H5A7z2H7HTt1IUY6gmHWj+9hxlZObN0Jhg1h+hxYwQEMbMU7rJo0S23SW
	 T83bcKGsRZDBdkyntdTNIhl9KBZ4S0tLp/+WQaXotICksIXikJjRU8qn6F+XwyHgXCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793294081;
	bh=7RTc1dEm5cbr7blNGSpuykRryen48bY6ic5cAqoXCjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=smNNiKBX9sfyTqZxfeZadDc3skaYFjslJswscKmps9KMMFZYBbbmLWPZLsw+SKdNj
	 Fe+b1oBVTjSythknniM7AeKiz2GY+2++yzQvFF2MUIdgxS8bV0oijOUKMvHpSDvq+E
	 eS3J9wTJOuRMsYH7ukurm+PD/ebuzw1Vw4Q4p9ic9KqM/dz4atcdutyoD1H/cNxeuU
	 gGVO4ptTFs5RBSorsQa8y3yGivQ27y+ZXoz/ExUVjY04t5yQHRRcmGfQNZm6XQe3K4
	 JW/ZcZV8W1bP9bzBd0WOukSSh8m705cJXQHOh/qzNRvbfVUF6kZFgY9Ps1PtZ4+6Cq
	 AoOOwulE01J4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A43B180F6E;
	Thu, 29 Oct 2026 17:14:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EF2AE972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D54C340A59
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:14:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9NJkXoplWYe for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:14:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 29D6F40A58
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793294080;
 b=g2kxk91whd5tl+vVEwktfZ0VUkKebgvUaTTVdM74LZaPA6DTA3kkHa8hkVV7bAheYTaO
 TOYMJol3Ble2+M/brlAukmuqjrssaICL9xrN8cXVqEXp2/qvRZ8cHLu/iiI+GHkdKA63u
 4NtHZsdA0klefsiu7Dexij1iErXo2jtm8HrRA2Ln3nKBUW6zZt+4ZZG4baY/wtKg51H32
 MghAu14SkFhBMXnrSYwg4qYgPd0SaXo9Rv+jrVDOMY6jmLHACjYn0QCd4g1a4sMrm3bks
 Yvy1zvnsET+OuXaGJ7vbrUFII8cAYyM+PQz7y1MdQOfMbvKGeXG+MON3to5zJZRKErg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793294080;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=7RTc1dEm5cbr7blNGSpuykRryen48bY6ic5cAqoXCjQ=;
 b=beb7TP83h33SVSC+nq6FLg9VvwBGHea1j3on6Cc8e56QvuA5pt00j5aEy/sbTQei8jdE
 i1y/gjk1FeYmNp9TmtGRKcEVUdNWieAzRU4qE13+nIDoFkcZ8SbB8CZNyiE0fpv1rLYFm
 4G1hYV7Vmjh7T+HdQyYwMVFMkw9XblIXjjpDa5DsILPtjPsed+PPANwO98131Zzui5E5s
 FXxwz9qn3G5UwQ6I3CBRG3A3ZBEAZZHpd9Msra2SXGcHRhvVXk48RMhelO0S1hGujVCJQ
 L/wGXOe8UJHcUOIPxD5QOn7LBfJ/udABq5i2nkC7ZPI0bQkxLX7xIVgV6vCNex9kU1w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=s95uDlYk; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=s95uDlYk
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29D6F40A58
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:14:39 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-483c607ccb4so1314024fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793294078; x=1793898878;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7RTc1dEm5cbr7blNGSpuykRryen48bY6ic5cAqoXCjQ=;
 b=s95uDlYkDF901mn2nO9iLvWW29g2kTXLXcl2e0oK+eyWxn/UBfjgN8M6bP7SMK+yKg
 AS+mjp8omlevR2U54gMov7GuEMgA7gUteozwsR4NtHrSrpEuSf9b69zXGjdymeCcgsr4
 swR+fFv/0lh5fRtQ4x6NVEa1zlL0OsKBC8VTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294078; x=1793898878;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7RTc1dEm5cbr7blNGSpuykRryen48bY6ic5cAqoXCjQ=;
 b=agsf1+UXAwyIN9Wyc/hMtZUBjSFNhN+VClchBnpg2vTqUhOM0CgY/9zKTraNxBwxUU
 B86TvPnWqNy/6tj2N3gFOKmF87DvD/43p1LMqVN8CVO6h9a4n80l/r5SYy13Ts6SfMtj
 BmgahKIuLf5schHsJE52g12Mxgx30bZLFK1xizW25TTyJlY4MxOGaBrkDpagSb4HjnxS
 zxrSg5GBVApFVIAhT4ET9x3bIBFPr0s/85+KJaX5uYXWs4b6udz4beHxuzqKW2HjVMox
 x0fHjwmDNdcWy0Bbd+OKcI7ECUxkTQ2NiCLUpd8aYorKHiXmxLkjOiyStLx4f3O8wOUp
 qslg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlGhh89gxfFoBgr24IJGZvQWzKpy7pe41UM0hl1EWPMm8UvxuN7Kw7PGn6dHw6epx31dOJZ4M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJrZitO43y5skU+L4wGcOodXd7i1uXuHWsPKqqC+gLcFzzUrr20
 0xToh0vDcawGyQLS5djhQ93PhUxMWlQF9Q4QIhJxSbwQQvhA/RanPu3KeQYafYsa9XXvJVnYz4j
 gz8ZgkhRpEFgO
X-Gm-Gg: AYBFou340H3XUTE7G+bEImbfqv+xaC4xtpgFsOJP4nWNt3sRp5boLByR/KgR+jCMIL7
 lA0Z7C0Czy/tP5QlICR/WYg699yMSem3szYNofEy0aZltAvlALU/YLgOHswA/pVnimPqMmg+4TH
 xWhDJ3onihDahCX/wgbrcGf2KxsQEpBsZTJfB9cthEZuh4CkAgE7Mg1R90aiNvb1lbi4C/Q7Ka6
 DaIAYgwjzVTLcy59+SFuVk5wMeOByxbFhBXIlv/9/4CwdKjrGMcGxMmy42hm5P0NZDeFbIKIxDk
 nbtekXE9bRjj2Iz6wdhRzGC9StqK19UmjebAD37aP0Kt99FAkXDb+g/kmP7MgBVl0kzXhqkJV7X
 h8GYgpfHuhYXlQjN+H6qCyozcL1hM10OIhlnsS4ybAluX4FIhux2KECtxnYajEfccimX2bgW1gd
 gQJyyMH2q8sHD10PImU/MPpT5vP9BtkluECrYost3r1eVoEL8Qym9c3UQ1Ly7myqk3/Y1P8CHSO
 Rzzrz0EVlARWIcACGuL14qJFVTh8Ty5Q8X6yPNSWANM8wgBZmsfnuIr6i5BY0OJE6HeUdlc1N35
 NkdhLfsYrjjC/SYOlRtvBFh3Rkd6xTld1DB54wsyYrCmVNUOlnuJpKLWiPJQevbSauZOS3pQe5q
 gVSbgWxf8b8loru2kXCyzyDXXxqUQfcG6Ecnx/DRNaQQly24Xj2In5J1VvpBarA/pPzNk0ikp+s
 Y8XRo3OCvoO9nqqEoXc3YrtcRpdv4ztfYUFXX1cblNJa0QrSb4RcRM
X-Received: by 2002:a05:6870:8242:b0:494:9268:70ca with SMTP id
 586e51a60fabf-4a8bb691443mr4808436fac.43.1793294078581; 
 Thu, 29 Oct 2026 10:14:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a904856efesm10668fac.6.2026.10.29.10.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:14:38 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:14:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 09/13] arm: qcom: enable MMU and cache setup for
 Shikra SPL
Message-ID: <20261029171435.GA3011578@bill-the-cat>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
 <20261029105746.3487456-10-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k0kTrwpUIJx/tq+4"
Content-Disposition: inline
In-Reply-To: <20261029105746.3487456-10-abhilash.v@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--k0kTrwpUIJx/tq+4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 03:57:42AM -0700, Abhilash V wrote:

> Use Shikra fixed pre-DDR memory map when enabling caches in
> SPL. Allocate page tables from the early malloc-F heap and
> select the board map through a common Qualcomm hook.
>=20
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
[snip]
> +/*
> + * SPL platforms whose pre-DRAM address map differs from the common Qual=
comm
> + * map may override this hook.
> + */
> +struct mm_region *__weak qcom_spl_mem_map(void)
> +{
> +	return NULL;
> +}
[snip]
> @@ -192,7 +208,11 @@ void enable_caches(void)
> =20
>  	gd->arch.tlb_fillptr =3D tlb_addr;
> =20
> -	build_mem_map();
> +	spl_mem_map =3D qcom_spl_mem_map();
> +	if (spl_mem_map)
> +		mem_map =3D spl_mem_map;
> +	else
> +		build_mem_map();

This is kind of odd. Which pre-requisite series brings this in? I wonder
if a better abstraction would help, and if this is still the right way
to go, the weak part should come in then.

--=20
Tom

--k0kTrwpUIJx/tq+4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauN+9wAKCRAr4qD1Cr/k
CsRJAQCvMPZBV1crexe9NK9r75S8fLuZ+58gwfZ4t1HUjoTn+gD9FmbIINyNcqOH
O07b+Ev1mG+e9BU33D+hSn6/QJXjggI=
=fO/2
-----END PGP SIGNATURE-----

--k0kTrwpUIJx/tq+4--
