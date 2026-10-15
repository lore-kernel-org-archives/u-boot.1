Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C93FCC6B2D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 00:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC08E407F3;
	Thu, 15 Oct 2026 00:03:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0CkMccfxhpY; Thu, 15 Oct 2026 00:03:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A96B7407E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792022636;
	b=LRL7a46/6quuNN5Q5u6tMlYfuZpcjT2BpNqYUziED4FSMejlNIGfHTbpX9xLrr4Pop3N
	 HtOqtG2arIEIqkIk/L2XvoKpDJ+j8ln2kU/bPNhX9LHi5lSbM0tym+bEdoQsuyXioW9rk
	 q1e0fj1I2SIHxcRnkxSNH1vRMIaORd0n5BK5QeBXMfS9gH+/gUCg0XAHDZNWAlkKRVuDL
	 1c++rxJULIsxRv0u200GsJyih576pQE9qvxtiBdWH77Le/ZZiw2wg3IUmtxC6VhXtNieY
	 /Pb7cUHxNNVvCqwG7GIxdXF/BByXBVb15+fGcVUhmIKbhpLyq8/zjISjKVXKK2QLCSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792022636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CPJtlXiuD7Vqx/2MD/3RwbBFxoVN6AKAi3GY4b3lB0A=;
	b=VRVsg5w3UoPSHWHtfjP8ytpU6040/1OlXAySRt89fxAmA/4+hnWfDGf8YxMmQuLG8ti5
	 tO3gsEqJ0TO4TRYVTT6i97i11liGSKt2wg9R/qiqaBI8YiVaRWthqsGyMZuAWEgMwzj6X
	 Y181cXfAlItEtA2edxdrjujqPjqOH5BF/d4+N88kBOX1eoID30Gx+6oR4vmjPsiOGVYCn
	 D+U6jjS0ZtTcYeKiorf5OFHz88BUL5n13vxuwtxurqlgedUtoqLL58vC+jtf519/c0wwV
	 4MIzKU9azvJv6c61pHSF8TTUNpyUl1Sb5Jtr08Ffr64+HosJAhCOLv4FXyzwqHiTz3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792022636;
	bh=CPJtlXiuD7Vqx/2MD/3RwbBFxoVN6AKAi3GY4b3lB0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bvYQNRPQ2ih2WLYda+z20xL6q08B3ZBba0Fm4g6MsAnX6xpNvZu5FMXw06eNJdZ3Q
	 2gAdK0ZJuSa+A0uBCEIH331KZ/1jbo+6fKeSIYvUWLtAvN6tJPv7i8ipl/MEBCoOze
	 OWmx2/FRuyBVZsmKB1aIcZNzqGmaOj8Jd+Zr3CcFFreF9lv25fP1AHg32nFnBJrmA8
	 snxyCthBDgO5OnqrbM6xSSrwBlXUhlxA+NSEMIhF/5kdSKqW9bsW4m1ZXQR8TEVibz
	 ZpwM8a9h+oJQhWiVkotp+bLtVEOBesBj7o9jzmLiouOZi+o8dEiApYeP+PenfR9+4c
	 GOCh9pcGFl3aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A96B7407E8;
	Thu, 15 Oct 2026 00:03:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C67EA58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 00:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52BB1401A4
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 00:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZcUEAXfDxs29 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 00:03:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 61DF940053
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792022634;
 b=tVIReZUTQ8R8ssZ7R+ZJZtujG4kFCP0F9lDYlzlmtPv6dpbJgE4IFmdYjdODZouMhHz6
 Vr6hvFgogt8L3u9nicrxpIraytXP9vLtYd/Fhn9Rkn/tnA0XlfF9qj4AXtZyWAl9yHz0D
 /XkPSOzRjqhMBJa7H2ZouLLQ62mvbcRuRDooyWgU/pGf0O1gWVDgHfeLpNN/w2yxWcRjp
 f9W08mi1UMSWramX7pTzut2K9pke/TqF80qMledZxTQXpyNsby0SVqsa8aNrwR4nm4qgR
 iITfHPS9l9zRWoEcoWTdtjxpZUuwVXOqbf87gLN4FxQyOaAjSvF69TL+YMt37fGa4kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792022634;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=CPJtlXiuD7Vqx/2MD/3RwbBFxoVN6AKAi3GY4b3lB0A=;
 b=NyIMvn6f0VK6pEFqzEiSiXhE8/IO3SARhWrplE4Uw0jDJDG0g0mw9FjX4lP+hfq7PR4b
 14ksfi6Nu7unrpOBKU93xIkQKjIc02P4MYI2/CuAg4h4YzTPTcq/xHvcZYX1dxymkFaxc
 uaXbsbBDo/NJvZgHo0uft4d7vaJH7dI7y4drMH/43u/n5Zfdxx8oMvwHNJzF2utkh5cVn
 /4xl3Dd3DtHphsIW5BQF/Ms+vmoPgpTo/r6P2OhPYjNNAVSeBDdVyzkry133pbpoBgm56
 ougEFr3hCRWKkW4gy7Ql4KWLhlk17oL7J6Kwrb7Y7gRFRHOjQ1H/AhE+/AYO9/rHPbg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nA1oDecg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nA1oDecg
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61DF940053
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 00:03:53 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 46e09a7af769-820ff812cd8so1489953a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792022632; x=1792627432;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CPJtlXiuD7Vqx/2MD/3RwbBFxoVN6AKAi3GY4b3lB0A=;
 b=nA1oDecgGGeOvjpJCZaEEMfDqXSzxhsj0/Jfq5LA7hs3u8SmXkZRRqTJAPBGG+u/GM
 5eF26pkp85h62h+yT8KnUv9pqx7yfKvOlVd/00IoCfulyKqZ3J1NtsagDpCZVWNcDC9W
 kxWMLrgxAFaCb2WGRJOY5fhtjbOs6FzHZrj70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792022632; x=1792627432;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CPJtlXiuD7Vqx/2MD/3RwbBFxoVN6AKAi3GY4b3lB0A=;
 b=j5qMPuq79XqOZRgNYd7ZuKUQoDmXDQWcdTdjyHicRkUGIpkyqkpn1kGR6jKLuZgRzV
 c2/PILjjewou+9mXjfsphSqfAucpMZZnhAi2NxfkwJ79AtHjZeFd5QAiF4qUl5GHO5Aj
 Z13oZXWZusuaM2IQ10tEAjO4msDdiztkq9wYPu40SBiQROJ0N/gY5jFU7SrsqUdyBslr
 BeUkrZx5w9LlhS7ZRglOVPXWk72GannBd4teF0SisRjSJp+Ag2fxgrLAvfA0bguLnn7j
 f1KgB03r1S3CdLG+45JH34GpVCzJp7hkb06vKRDd6u6MzzPEiBas8DzSrN207PuvmnFS
 2N3g==
X-Gm-Message-State: AFq9FYJGW5JeC3u8ERdFHfrZx5r3lpsh7vykKxx9gpsFkruAAEkrh6/N
 zxWgZ/IekB3yLIEtTvaGcF/7Lx7I5Y76lef0AP3e00Zza3N4TsSJo7TLKKjyQvCcE8E=
X-Gm-Gg: AYBFou1+zZ9MvvpWOt5sCWLOa7ZIbgnMuKtMYt1c3RBygkqxW0V+Us0sCofwK2b2jDC
 crQBEqtDA022nc6MnHXs2sLq5g2k7JL14c3AlnpaWTWmt9CON8gizushtWkPId7nKtmmwe/H3ML
 9815XcRuedcZK3uS+HM5EvDOnfPxBrKf/gRzBRzFCO6crVeB+bDQzlKdIUpP8HdDt7afwJQegm6
 CCird7r5yBduGFtgW5dzmxUNj5UxHzPULey+abtL5JpVuhdQPU0HepMZ5T6W/C1ChqzfKZRjYJ5
 y+yN2I64HDTRrQxUm7YWz9UFU2Ye/3JNuazyGQLLDIXq26MdSvdrPh3MPbdyJVy/DZOKTARZ9gZ
 +nbg6Bur1OdBuqNa4yRW4DHM2P1bbJIdiToOueX4V6yMObugEfbRVlyE6W7WWA77szDd1EUqDe0
 belSI/21RkU6NcOflRILHUbvHJful43ae0c8YcPMkRKolZG5RBAQK9N8X3eRMXRNmMEcoY2VDhj
 FRkwmjIOe8PqNzisp04p+1CywWDZvgCEq4fmUXVHySrloHKn/MAiHUzfknn/n3L6gy7DqC3aOaa
 +WFFyndI1uBux1I1y2o=
X-Received: by 2002:a05:6830:2547:b0:7eb:9464:ac2e with SMTP id
 46e09a7af769-83096bc668dmr21999940a34.11.1792022632638; 
 Wed, 14 Oct 2026 17:03:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-830383cd670sm15437042a34.6.2026.10.14.17.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:03:51 -0700 (PDT)
Date: Wed, 14 Oct 2026 18:03:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: u-boot@lists.u-boot-project.org, Vignesh R <vigneshr@ti.com>,
 Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Marek Vasut <marex@nabladev.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Ssunk <ssunkkan@gmail.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Eugen Hristev <ehristev@kernel.org>, Jeffrey Yu <jeyu@issi.com>
Subject: Re: [PATCH v2 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Message-ID: <20261015000349.GA337194@bill-the-cat>
References: <20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JjHV//N9b948W6uU"
Content-Disposition: inline
In-Reply-To: <20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com>
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


--JjHV//N9b948W6uU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 06:10:04PM +0900, Takahiro Kuwano wrote:

> The spi-nor-core.c contains optional logics like SFDP and manufcaturer
> specific fixups. The spi-nor-ids.c has single large ID database. There
> are many #ifdef directives in those files and that negatively affects
> readability and maintainability.
>=20
> This series, as the first step of cleanup, move SFDP logic, IDs, and
> fixups to newly source files. Reworking, renaming, and reformating
> existing code is not a scope of this series and further cleanup will be
> taken place in follow-up patches.
>=20
> Here is the code size impact when applying this series.
> Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
> manufcaturers are enabled.
>=20
> SPI-NOR:
>             text    data     bss     dec     hex filename
> BEFORE    731133   14696       0  745829   b6165 u-boot
> AFTER     732301   14696       0  746997   b65f5 u-boot
> DELTA      +1168       0       0
>=20
> TINY:
>             text    data     bss     dec     hex filename
> BEFORE     80492    3744     248   84484   14a04 spl/u-boot-spl
> AFTER      80748    3744     248   84740   14b04 spl/u-boot-spl
> DELTA       +256
>=20
> ---
> Changes in v2:
> - Rebase on top of next
> - Link to v1: https://lore.kernel.org/u-boot/20260612-split-id-table-into=
-vendor-files-v1-0-dfaaa82cc6f0@infineon.com/

Sorry, sandbox still doesn't compile:
/home/trini/u-boot/u-boot/drivers/mtd/spi/sandbox.c:156:14: error: use of u=
ndeclared identifier 'spi_nor_ids'; did you mean 'spi_nor_scan'?
  156 |         for (data =3D spi_nor_ids; data->name; data++) {
      |                     ^~~~~~~~~~~
      |                     spi_nor_scan
/home/trini/u-boot/u-boot/include/linux/mtd/spi-nor.h:656:5: note: 'spi_nor=
_scan' declared here
  656 | int spi_nor_scan(struct spi_nor *nor);
      |     ^
1 error generated.

--=20
Tom

--JjHV//N9b948W6uU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatAYXQAKCRAr4qD1Cr/k
CrSZAP4hfg7qAYpr4Df0b1d+qmHmrM4e3PgsVCogwtffFBJlQAD9GzSN7j9OeD8C
4J69YLRfqSyufSdU6rfdt4JYcXMrAwA=
=Wg5y
-----END PGP SIGNATURE-----

--JjHV//N9b948W6uU--
