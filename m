Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485E606A331
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DS3YVA6y;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Bz7Wv2g2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BB9B4077C;
	Thu, 22 Oct 2026 16:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWjF2Y_g6RRv; Thu, 22 Oct 2026 16:52:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA6E840758
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792687946;
	b=fePVWRHcrGDOeutQkKm6cCp+Uli071Rws+xdjIUuGsIZgrEg1NyQnArMLT21NMcATVjX
	 Wz/NX9n2ct0gxheqLE4Boqn/0W0Z4zp3g5mCToASUB0Iq3Z0NX2i2FolUgQwpaxj0ZB82
	 dCUTyNzgcGfaKu7QlM8Efe7FZLr0kF1AOAmDQ/jGAg/37d5wPwD6OX62myGYgga/CelQR
	 0NIY/AEV+y2XtyDru1cU7s6sYE5kwyUJnw9VdZqjD2zLDUSA5fHW3XOFYaDYru6bSHBFv
	 rXmeUvhbpvBOOPT5OpjjtNuxEn0aZBnNnlypLBGf8qNmOCqy+4e4fknF6C/cRxIma8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792687946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hRblaIk+qKz/lk4JmKMbOAKVLCKXQ4/vU2qu6vXuDmk=;
	b=VPRVRUMdLCurCd8hJSQzJHQI0rnTaDMi4iagUkmXVNeHLMs9SFNRgKX/Q3352ZnnFqNR
	 TQsd0MlDjsM8pBKnEKc+9g9QxKiw+ApInId98H8aoP3cQ9Y1Pv+LDFqJyNtzFhQSP1FyG
	 lNe0GJjmAYGIcHAiJsuZsdIYhWDQJRTsXrbJTaAO4o5elXES7Hpnh98i/EcgEgudGywNS
	 9bTrY0duydiY1IUdAA4A+tColM05wmKd6rKdVA/8wfZzRWGMWDDRFeqNjHydF3jFVcbPQ
	 /zOgdNdhUfg4lOTWYfU+qLRFO/F6XiTIMQ+EpePOZb00haYSsoEaNJ4Eu99l/lK2iqQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792687946;
	bh=hRblaIk+qKz/lk4JmKMbOAKVLCKXQ4/vU2qu6vXuDmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DS3YVA6y6sy0Zq6TBsjF3yY911zBbr0+/cYE7nO726fOzZ5+MmFSHFx4jW7Urt2oy
	 VAsSrM4Q/P6RgaL3G8R7pHHQUNiuTnTFP5k0pRrJLLO46nGe0Z9V3KNFtNK2rGAdFk
	 MunagFm+RDiw3ZKlsxgpFzsmaGbPs4t/HKvEEgCXjz3xkLq3bKTR8cbmxj5sCa2eJ0
	 UoUx+Fv/JJOcO/h1JZjyCAuj7kOwzozgQBoAdgKBrdOhCRLIRsYApuFEnGdm78jBnG
	 24BRXLWVhykmANdE4eYYUnho3R2CAmNatv3tLv8talxoSl/BNQXIW2IIZBmoUwdKwE
	 ESs9njtlF2COw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA6E840758;
	Thu, 22 Oct 2026 16:52:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 215A33A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12852810D3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5bu8JE_oHkhO for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 23AB1810BA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792687943;
 b=Tnxj/hgH5Ogh8vUdVoqe1PqvDoTjEJIMQn2tRMtGIYEx0y2e1PQxJdJAAuydqOkYx9g2
 ofpLthZ8llmahKImG/Huk3WETgjKl2BOfJVt8bKT48PL4yRif6kV0pPro7DfeBQYpFegH
 ZSKrlAi3WQ+czjqioP6CICRlX81Y7T1achRQVhtuSC/oVCyptxxlnNjcHBkE02uYmF85n
 BJBNR11wNigx77/fG0k6ZHm3Be9Sx1qu+GxlasWE6qCC4R8ZlQ2QUGGD6CZwCAlyr0x8A
 M/jDlvwtyOoEZyfJtUhx6JdRExT97ELdO8gAba8hPYEblK+GqCsRGfhf6td+STvL8QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792687943;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=hRblaIk+qKz/lk4JmKMbOAKVLCKXQ4/vU2qu6vXuDmk=;
 b=DerruZcJg48hXLoM1KRmoUo8+BxNhszIgWEiDq6b9n3YZ0TMDH1Z0GYSNavToayUL1jv
 J8APuIC91tsbk9ylKYxW8ozpMTK/zwQrEsUAzHPGjEMjDdx8mqHmxIXo9FK0BmPEzpFf2
 UNvQaFTSMsxwcH6lyH6v+8MHCXhJdvC8bASjg31c07xlQOMruQGJE6UM0+dyKYKAJmj3W
 EH5IRhBPmvBiI1tlqSlWkMiz3roKDTRQBmcl98pyAZudiKYf1wgkJES/8wvoHSUBeLNI4
 ZKj8RH57xLK6wABYi5JpDIOaYQx7a17F7HH3bK78xry6NRV6FZbGELXwlDfSiN/WxJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bz7Wv2g2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bz7Wv2g2
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23AB1810BA
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:52:22 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so1738372a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792687942; x=1793292742;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hRblaIk+qKz/lk4JmKMbOAKVLCKXQ4/vU2qu6vXuDmk=;
 b=Bz7Wv2g2H2bJNrul4y4hHuA7YJ/UIcp3f6EQnzMl3Az49S7d6SmUMZ1vAL+ZVmSeNY
 LM6F+t4zb41EWmnM/wzJ1eTFxpZy4Fw2DyXct02ByLgY6LL+PcIVeKQ3KBJE4p1BtcMr
 yhZz8wSlAn9uvFxAn1GewTwtz4f7eyfXOqbEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792687942; x=1793292742;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hRblaIk+qKz/lk4JmKMbOAKVLCKXQ4/vU2qu6vXuDmk=;
 b=aD3ccFJnn1EmEJXn/XTFZqEbS3/+1EOek6kmAwLft+En6h5T1GhTkeKyvbMfo8mXQK
 nr4hZlFve5zGtZCkN9LdPd3RzQyKo+xYHK7DI+UIJUZhkL8CsxTownj43Kx1/Wk6NI1m
 GHiGGBSOmoyvIRLjQIZzC24BSCqDCccG14FCnZgjV2R2MAFrbfUcx8VyvkwSqb1D2Uf8
 7cemYYzbBAemsS93iYF/E4pIylsbK7BnBslmfQ1uL071FkY42yIj7BmGQrLb/lsgxL27
 6z9AEJB47lTEUUOx3TxF6h/tCh3oGmJjYK7EqiFSX5aY+JtOM4ywO3AacO5iSgouF5O/
 7CAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnZXB+c58FY6AvwKqpVBey13wAM2IIjG5uJlXvaukxUG+njXidD7Bc29GmEFMQYHx8yksJWQA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIUnsrEpq0tATXMcJObyBtxcuA3Lkni/bW8CwHJ13gjttSVBthd
 P/VGh5yiQjFxNyy51Vxx66OifY3KlDI1D2XyCQy4B/PAqPE0ZYJGWJQ48xut3dfdc3w=
X-Gm-Gg: AYBFou3N3UjjzRD/2RpeDmyreYfa8YPlyRL6+O/hV4G8IjfkeqPn38/lvPvOzMg7O3a
 D3ztRjWgJorK17LNsOLygl2v//Z4hIvWPN7T21j7t6ykhTyAPxVSK1fUmw3jKzyQCFoLcOLBw89
 8aRNT1UsoQNxnGoJ5+4mO7ICtahsPhPN5zIHFH2XOUvEuG2vnEf/YdSRadN0NRHsrUxn+BJuwOE
 lmT/6rQotHt3HhoZPqzxvQtQugskmUYQbsG15zQ3PI71WrWj3RYaTmvbP/5Ex33J1JF6gqKtQKM
 HmLaik9S3RxY53gX+TFE2e9xfZiDlzSe6GhnfUi7oJhdL30iyJgdL3yqjF4tpf09Eo7chEh0uyj
 4rEWPLzxkkrdTUEpkCzahI1RyjjY+aif8YuAVQEMpPrMhBaXL+skvC40zCggAmPtHbXzFIbhWKG
 9zZzGPSPqv8NIfcJk+hP3Z2YN6n8jbl56JtQmMHhW6OxCXy7hVNVht3DFjBiYgQ6fipbQLSzjeA
 omzfLNxN0coZlDqf1jZyBU34rwv1RrfGi9bRnvcx4/WOO9quuUGLpG3jzHL0xipxNxfhlbgQCId
 IxY+kP5FYdoRhqChLS8itCOTyfyaGNdzobnoFCnZBlxrvZRTQa3b7yNDohvXYOZ2BxYHYS92oSb
 zgrW8YvmQTwf7VH9N9/730Q==
X-Received: by 2002:a05:6808:c1b2:b0:4c3:bc6a:a328 with SMTP id
 5614622812f47-5535c282c20mr3601807b6e.31.1792687941650; 
 Thu, 22 Oct 2026 09:52:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-552b583fd57sm4873576b6e.8.2026.10.22.09.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:52:21 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:52:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com,
 macpaul.lin@mediatek.com, jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 12/12] doc: board: qualcomm: document Shikra IQS (IQ2)
Message-ID: <20261022165218.GC3621697@bill-the-cat>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-13-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PdER+Z0k7/ZqrcW5"
Content-Disposition: inline
In-Reply-To: <20261021160916.3894471-13-aswin.murugan@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--PdER+Z0k7/ZqrcW5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:39:16PM +0530, Aswin Murugan wrote:

> Introduce documentation for the Qualcomm Dragonwing IQ2 Shikra IQS
> platform in dragonwing.rst. Add Shikra IQS to the list of supported
> Dragonwing SoC series
>=20
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  doc/board/qualcomm/dragonwing.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Docs should be with adding the board.

--=20
Tom

--PdER+Z0k7/ZqrcW5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCato/QgAKCRAr4qD1Cr/k
CnUiAP9NFgoD5TuxGaNmFBV06F1QeYFoKb6dpiRNLNEtYkc7oQD+JAGIMvRvIKYw
7vXkpCLvM2njY7hMsN8AnAUZbE7wvg8=
=h0e4
-----END PGP SIGNATURE-----

--PdER+Z0k7/ZqrcW5--
