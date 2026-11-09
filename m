Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91243606A8B2
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q4mUaB7I;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=XEXu0UDY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6864A406CC;
	Mon,  9 Nov 2026 16:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OhdrqjMTkbIL; Mon,  9 Nov 2026 16:57:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8008406EF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794243457;
	b=MtPgje+NtYv7W9uui8Vv5m2OMyWVemeoCWemDbsW2JrjyviSd33bGr3zIF7b5cD5qnXq
	 5eI8an/Hs8YZ7E1J5jJipURKCa+lax6n9ZFC4C/33RIk30lrxf+EtUGJ25M4SEaMlxXU9
	 2iReMzztQZRHcZXlPXcJxVmgJHE0c9tMrxzLzVx/kyj+86v/bzQQl2a6XvkmAEYVDNp5z
	 rJ+DLdAfBELDAY64TpM4QaLkhDvCC6h0B9yZTllHDPp8/M6tCANmlP4aHrMQB/0zGXdYY
	 8Bjxb6InQzRQFYKZfnem4JLpxvKzCkRHkE5NuPj5NaSjkKpXXpKuahn0qgrcIn7iNBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794243457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6T6NIUX6ujicisdllX38GFT43bfWKrgCdXoTzF6J43U=;
	b=nKRS8pyvDDWrsV6JxniS65lcJ4s2xu/O0WVbQpNUMY3/pMFuPo0SXUh07+wxGu66poq4
	 NG4TR4kvnQG4L/cUobTH1BwPvrENzcWwFbQmiqBJUoJK/7RXN16iMN/BgjPucYntXo0ZH
	 Q4QjRVckJuqhU0zH8M7z7bxg4LEqmXYEzJ1mVLuVq0YuZ7j2/m3wBpghPb+Xq57uibtl1
	 zHI+agquyqpkg5sUIcTsYz0/gVOpPeBoJQNGnAv7pdhPaWhxrlDKbF1X4/xu69skFQj9k
	 cx/flK2pyTEFb54AAQgIjlmLyvhwODXfMDgi8Ecxvi+ZAWj08LFKcUhSL4F3Jn8L5Bw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=XEXu0UDY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794243456;
	bh=6T6NIUX6ujicisdllX38GFT43bfWKrgCdXoTzF6J43U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q4mUaB7IBjKNJerlRGbmeHOrcLt2L3WK5g0PeuYqDKsMZZVryQ1npuqrB8/Vljjs+
	 TfIEC9y18oOeqalsYVGMHeFpbXtsLDsTZzIBtnNKrHc6k3XdqCCObY17jMuVTaDIZc
	 RBO2RsXSUMabvlq9AeTzX1WBPLVk7qmOVCziIEBZRPMLpihDjUZVqFVviwKKzO8w+a
	 Sau8T78Mvj2ORrSMPpN+RXJDZYSWWyAFpil2wUwTZ3N5a12aQsEiczsa3nm16zE9iQ
	 9xiPKrujwTImtHTq+6JDMtOUDCkeOIBfMCqu1HVTK221UVd/m1ZTW4eeYS8CUqcm9v
	 SJ19KHw99Uz3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8008406EF;
	Mon,  9 Nov 2026 16:57:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 729D7362
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62FF740706
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:57:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6RoksKYZ4iBl for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 16:57:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3801406CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XEXu0UDY
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3801406CC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:57:33 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7f48c750afcso635367a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794243452; x=1794848252;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6T6NIUX6ujicisdllX38GFT43bfWKrgCdXoTzF6J43U=;
 b=XEXu0UDYblqEIgfad9aNE1TvAoaQNxKqVnJ4uNPXNDhVa/9/JvVEndE4RGbuW6xreI
 ylnPTaMlnKErcCJYhhLrQUjR2aOn6kVu/ezWUM0GbAZFTAzWB//ugaxtSTgSkZ/ew6Na
 F/hOT3R3jYkPp9KbfBbIPtguxsQXD0MCBfoso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794243452; x=1794848252;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6T6NIUX6ujicisdllX38GFT43bfWKrgCdXoTzF6J43U=;
 b=V+tZLHxr5irWl2UVcV4/EgErUcu1xixMKVnOYK7s3jJiKNNbF/agHsPCRAPUs5seSX
 EShjA5CfdBv5D1uQXGCzwgMKw8ap9CUwonphEb/zvcxOahjLS7uXTF1B1jyvtPNxhqtq
 PA1fCljRofCNTnEV9pfqWEBZbWgLc6QZLjGh8OGpX/eD53TZb56oJeO7DP5cdcqfDQ+H
 fLcBzKf7nSAX/Gv6dGfi0jvYq8TnwzV75abKXmoTNyO7eOWNY8Pnfp4z359jX7vqRL55
 Fragp60m/YMeOsiMGu+QdLLQb0ECp5vBIFyRpb96cjpXhAdvNIRne/dw/19CVNpTdxcr
 enxw==
X-Gm-Message-State: APuU4Z8PHA+BKvktRuilGTtqjMTvB8lB1k2urapGK7Dio3Q/pawn+EtF
 unFnq5PWZJW/UZgJBZ2FMdxHjnWhltsW+NudL2KyuVhCyQST/rv+EXzP/B/UA5wtJf0=
X-Gm-Gg: AYBFou1u/QLxJ0A7PP/ESBJRL+Lkxi6ge61BdmCoh7QkGheV6ZqqrR68CAsq92mdCtq
 1oSVTY8AJu4qQ5wZ2wzyl7UyFWKPEkTBT4Zym4J8RBJChjNfxmk9Umiw+oPk67oLJxNZq/4+yqc
 /RUbb9i1pfqSfWDQ7unxVnIAVYHC6nEHWJnjuWvkG0SICEQrTSkJjasQJq3M7So+7TMOCCylg9n
 46cvPZuoXwKChpHbHrRa3vgy3XXbJKwyFfH2oaMmdAws87tnLTu8TnGbq9mQ9oIHeWXhcOmrWF8
 nQPDNFertM/YFkHXxO4Z4n+2yx38Ut5IbXxphrsJtN+/M3alN5YDm//HgwjKtCZMeKv5Ah6rzpY
 +nfQL6uJzjd6w1oVDucu+rnIUFlujyyCVfHlA1twit8fkGc275o8puagq6onNv7TKuCPxm4Kprx
 0pCp6unlAHzMJagtaHiydbontRWEUz+kr7Jq4OE0K/ZPm7PUzTSBV+fSZ2prP6/YE9JNL1pGiVT
 Ryboatic7aIzSivnBITYnLznuTuC6xSjaMZ45xwNZDZVNVeuSDcCpBN+rh4tbWiR3c+1t705p7K
 L8h293Kkd+xlnQBveQwT9DZNYjOeSsplqNGRrAEyLtjmA1GlHrqRESGEj8wc9ppRxOdEwe1RBWf
 denGqF9IAkM7m8MiO61ozTmuNxMu5avRMtmFouAyLAzKcXzTPNqTaJsShHR5HmBuCvbEC/RnZc6
 7btVCDizM3SuA5QW8GGYq9rEFHyCjxhQ==
X-Received: by 2002:a05:6830:2b11:b0:805:8b7d:d8d7 with SMTP id
 46e09a7af769-85f5074fd77mr3544438a34.7.1794243452226; 
 Mon, 09 Nov 2026 08:57:32 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f4fbcef97sm4220782a34.21.2026.11.09.08.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:57:31 -0800 (PST)
Date: Mon, 9 Nov 2026 10:57:29 -0600
From: Tom Rini <trini@konsulko.com>
To: He Yong <hyyoxhk@163.com>
Cc: u-boot@lists.u-boot-project.org, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: Re: [PATCH v4 0/5] bootstd: Support boot scripts in raw partitions
Message-ID: <20261109165729.GO3741582@bill-the-cat>
References: <20261107160406.3943071-1-hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c7pzbiVE577F+9Pi"
Content-Disposition: inline
In-Reply-To: <20261107160406.3943071-1-hyyoxhk@163.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--c7pzbiVE577F+9Pi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 08, 2026 at 12:04:01AM +0800, He Yong wrote:

> Hi all,
>=20
> Sorry for the delay in sending v4. Other matters kept me occupied and
> delayed this submission.
>=20
> This series adds a script_raw bootmeth for U-Boot script images stored
> in named raw partitions, without a filesystem or a board-specific
> bootcmd. It supports legacy scripts and self-contained FIT scripts,
> reusing the shared script parser and bootflow execution handler.

I'm sorry I missed asking this before, but what is driving this exact
use case?

--=20
Tom

--c7pzbiVE577F+9Pi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavH7dQAKCRAr4qD1Cr/k
CgnJAP4yj1wasOjnpVivkrdF8b4uIYd8YukiSXnbsrwMNpDThgD/fH18RyJN3Bur
Alvhu+LDq2NSWq7GBTRZzLzUDgio6gM=
=Q3ey
-----END PGP SIGNATURE-----

--c7pzbiVE577F+9Pi--
