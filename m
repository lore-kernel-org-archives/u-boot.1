Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12625606A329
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lccisR5L;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YYkViDJ3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B51B80D07;
	Tue, 24 Nov 2026 20:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avR6HZ5r-qPg; Tue, 24 Nov 2026 20:17:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C995F80CFE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795551450;
	b=Wvueg+iCX8XLaoYN58PB1b4qJOsOx/h/YtdCKdzmbz+XIMCt7zWWZaY2BHS9/qrdUlek
	 eXjFPcmfiBtrSKX8cveNP9qsFDzrnSkAPUndQA2vD16I6HDNT6f5igj50joghkYaslU7A
	 i4sfApComD6W3FN3hKgXRoaRHuweAcvNs6NIwFiKM1ngczSLiXTPOqIUERs62mdjdixjr
	 vgCwTobBgvylQI1as9CVKhKKrUZMCSrx24UR6v6cln2d1775TFnLa45Azde37zapQUY/4
	 8UKru3KAYkrAlulLzBl8U87VLu8Lz+p6RqapNhYijXX6cxUnKVVt3DdVG8r7BRDf1kw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795551450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0e9RBdkfY894D1oPMsQMH/xvLEFe+DvQYwOLxO4flv0=;
	b=qjsiAxEezW5YL7PFgMXyZNg16UTABHvM69tWFNII3qtw7Xl8qoXxnFvw0c3xanGH/7f7
	 pqvfPvGZi5FVHI6oqoAWJh0pwWKAnOwbMcHicnP9DMb9pd9PKf7UPhJtVePq60nF0I6jM
	 +gOvhuog1rlwmAkRTraEDdtZrSNP6lVKVQUxK++AGoo+tTkzF/C7D1QJki7w8ba+CXZLU
	 ltqPSZtlFnjrvR7vRD2dBBAqCOyytB/7t77Aa34wahEcTtZP2maTPTCOPb5Rfd8AU0o6x
	 KoiQi8Cp7UsU+9i6AaiD2Fd6xiUVSueyfq5pZ3lbBQ01OkqliI96AbYRQH9eUCoyBKw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795551449;
	bh=0e9RBdkfY894D1oPMsQMH/xvLEFe+DvQYwOLxO4flv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lccisR5LKQW0aDAqLQh1GOpTlZv/Sr17IFsFNJ4aWzHOHPTLDv1hQwW2Im2Vow4S8
	 YozLhpsB+KAmXnZ851ddX3w+uEeR9Z7tLKUud/e3szcg4UCMn9BVs4V0OXKo32iSzX
	 UrKLrx6yQXPbfN5pm1LMu2+ZelJdoVDCgLpHL/lIR/ovRswGI4OzIFerqKfgcpRgQi
	 gh6aaB8ZhutgaRmSg2s1XGRgFwCyaVlpjkQgj/vUTpUqUkdPn7ZJ0NQvEYJhnWbaoy
	 E0CDgFqhh+zb/ZUIA4x3GZDZ7/Ejp6czZiS+cwAf31PbGQZRVDApA60Ir+LgGeAVVb
	 C51+HEnOnD3AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C995F80CFE;
	Tue, 24 Nov 2026 20:17:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 68E6B10B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 460CF60699
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:17:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 006R6RTyqEDo for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 20:17:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7059F605F0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YYkViDJ3
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7059F605F0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:17:26 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-51f2e9e6987so4121144b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795551446; x=1796156246;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0e9RBdkfY894D1oPMsQMH/xvLEFe+DvQYwOLxO4flv0=;
 b=YYkViDJ3yPD42LaZSc57ffOq9x6iuUmJlIHzF0jsLXSGszFzGSPTyS9+3hz8+MJfzt
 pWWI69QhdKWZSBySwfeXfc7TrQiUBPFut+hBGgaFRXk8qEu4S0gCs+8Bu5RxkEkTJ9k5
 QMWz7x7/hCZgcU3Mv2p8EVY7RhujrHQe8ZHrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795551446; x=1796156246;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0e9RBdkfY894D1oPMsQMH/xvLEFe+DvQYwOLxO4flv0=;
 b=T+oj103M5iXM6qzmtBsvMx2YRvPqtEhKrvPCqKwffYCUW6Uo49NN8pEKHmgIVkRLwn
 XfGMOmdCIxhbw3mwX6EYwdCV3bju67K4Ep+Al3TBm6nvN5joGCGjXG5JsK29uf0DCZol
 SnHjcxojXvvk+dTASYDMko1dQYvnNcMnm+7rMfDBm9pGMo2r7WJkj8/TpDHs6hgQ/deO
 Cbst4btcHhSODX7roxTptFHctwxianoGfx0HboX7VT/zYiM3p89W3mdLSF+iIc8zxmOq
 ctphUBbuFsHrurybWqW2ACbJHbVJ3TQ6Ze9BdQCLVdhIOG4lSoneVryAYPCU74l48282
 cXnA==
X-Gm-Message-State: APuU4Z8gvRxiNOvEXfCexoNbffE+Q9ZGmSygRH9k9eyLEO5lDDq6wEqh
 mHDP/x7TQiUBXtDfvQzvLbrU0iexT9O9qRjNV/knX70dXTLf0Os0P0fhfhuBFcM1eTc=
X-Gm-Gg: AZFdTZeYX5bNqSopW8iGkjmqPb04n5xRsEswAc1C/jzufqA15DHCyompFbB7+uUnTr4
 sHiPai6hsJaq7TJm7kAbromLeiZKz6o6b5vFmQ+wzIYkYcUFlVgATi8nVtP7ic5dOJKQ52S2tTr
 9Wb7mSiK6McBpWoiU3SMNmgqbiKRzkzZUvP+PELlXIq/dbfNMlxyQzAUJN7byIkcwkd4C7Lc9NB
 aTiZ9QH8cPiFTrduc9rJ4nvaYBqZy4cqybGRW0OSFw+YHDh73bOqcia30kzyaRk/xYsV+b91Tii
 Te040RYLhfo2AzahH184FlCHJS92J6TZjBraULi4ErG3xZCUmjvNQ4xaZoI8RrNwa+piR2FtlH1
 tiGwuNCITqEcG8PLZ2H7E1RRzU0JPXRACr50AQ3lji4YLl1AuApSn/PX52teb+Ccv+gX/oCoZoT
 UCt5XAsXDhdfN7RPIqTCHD1ZXU8yQSnWCOXzrMNEHaG48RuGXRPe9wVe4DnncD4We6iToJJVvGt
 2q2voiECKsw6CUJXE2aiNltK8fgp1uKOWMW/WO5ItXn/+Lh970jvg4Fj4i1dsEVBPTnWiDW8mVG
 hMRNC8smTYRGGSfz+sDkogFBOcRs0hXMqHKy8t2Xft7zwH6y9zt/f9ETdAc7lDdtoH+nkJWfXKN
 hLWxtL8Q7hz0/R/d1rJDZzSoxWFXyuPOL/PLRsny1+0WNW/ouCpex5jbNOXDIShUYR0tWdBBArH
 oc0ShKBoCasBAa57WnbBD11KZpglte6zw=
X-Received: by 2002:a05:6808:3503:b0:4b8:4703:db8b with SMTP id
 5614622812f47-5797c1c0fb9mr12645707b6e.20.1795551445782; 
 Tue, 24 Nov 2026 12:17:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5b07d766sm14408980fac.2.2026.11.24.12.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 12:17:25 -0800 (PST)
Date: Tue, 24 Nov 2026 14:17:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Jeremy Compostella <jeremy.compostella@intel.com>
Subject: Re: [PATCH] coreboot: Add Alper as a maintainer for coreboot builds
Message-ID: <20261124201722.GB3176972@bill-the-cat>
References: <20261124195555.261178-1-alpernebiyasak@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p7nPs+l2ITLedYPr"
Content-Disposition: inline
In-Reply-To: <20261124195555.261178-1-alpernebiyasak@gmail.com>
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


--p7nPs+l2ITLedYPr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 10:55:54PM +0300, Alper Nebi Yasak wrote:

> I have some experience building and testing U-Boot as a coreboot payload
> since I wanted to use that combination for Chromebooks (mostly ARM64) to
> reuse the work that Google upstreams to coreboot for this class of
> devices. I intend to continue working on that project again soon. It
> doesn't look like anyone has offered to take over maintainership for
> coreboot payload builds yet, and I would prefer if upstream support for
> this use case can be kept alive and hopefully improved.
>=20
> Add myself as a maintainer for coreboot-related builds. Drop Simon from
> maintainers per project decision.
>=20
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Thanks for picking these up!

Acked-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--p7nPs+l2ITLedYPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawXwzwAKCRAr4qD1Cr/k
CoarAQDVt1Q//zf5B5TaXvZZxbSczMRhfRWR4ofmGfOA+x+sEAD/aDeW6wzIH47T
ZOftKaIQ9dFbOjpocnbXp/XO2xjXcAQ=
=MZM6
-----END PGP SIGNATURE-----

--p7nPs+l2ITLedYPr--
