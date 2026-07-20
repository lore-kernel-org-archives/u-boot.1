Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B244BC44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 19:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A11780D1C;
	Mon, 20 Jul 2026 19:22:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tlkTLhcqrGpi; Mon, 20 Jul 2026 19:22:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 800BF80D64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784575366;
	bh=HImQxzWdBHkOA/znZr8n8OjSjdZltCNArf4+Ed6+Xz0=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eaBX+bXvZnBNaKiwek7eH0HZJZc4iAM51HPNvjXxZkl6LFMIKqKrYpiCPJVu46p3I
	 4nKLS+DTsqs/OnaDq4OcNkRi7LCKhtupzucCIWYS/x7E2b+QrGdO8A38mobpsfS4yK
	 21YtlTU3SYft2HFUop4aRgeSDbLEIZDqIBTujVdzI6uTkJ907jkG8ANqn3mCp1lqpG
	 e7vGEAiErOD1QdxExmcyCZDhX1hjYMtb63IUGGUm8W9bYoKVKjPh5T0+muV9AnxMpY
	 rle1+SFDqDn+7tcpaEH6RGJxIT56/aij0vCQSCZroQQ2nnL/GH/FMoTLosRVod+RKK
	 fmZIWQtxnXMiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 800BF80D64;
	Mon, 20 Jul 2026 19:22:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D5D2F132C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBCBB40194
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:22:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xXwAhPlx6hS1 for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 19:22:45 +0000 (UTC)
X-Greylist: delayed 484 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 19:22:44 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7E12A40167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E12A40167
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E12A40167
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:22:44 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A8D83C14; Mon, 20 Jul 2026 21:22:42 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8220982991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 21:22:40 +0200 (CEST)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-456f7012050so991343fac.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 12:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575359; x=1785180159;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HImQxzWdBHkOA/znZr8n8OjSjdZltCNArf4+Ed6+Xz0=;
 b=Oq+KUDPK890TyajV4EPs2DuqEVAy3ghlT1yj1I9IR9JORuZKqzQwgEaYmd0CdpSb7U
 8qfsf+x+6fTRcrZCI/S57Mi35Tcou7R9TqChe2OrPXBHAJUMoeb33wLEd7dkRWpejJ0k
 gCAm3mnSxvKFfjMpnqIuKkgQXPFtwxqgBicn1RRsZ9R/ww5noIwPmBVAcWrWwtll8JBc
 keXy2X+B6iNYXc/JwsofljyK5DgXDEuo1qeUpWQDV/+pl+e2gSSigso0/KSGMtkJsvPP
 SmKb8mujAq+j2dPVkWk964GcLM/HnzV1/fM0Vzdf6K5HWTDzECDhS6bQazvFZPqUKmU5
 vyLA==
X-Gm-Message-State: AOJu0Yza5goiSny5iW0XcgHjerfb2URTnMxsnBh5zVXqgxJorNCMQ5oO
 joha/N1hYf/X8QPkxBl4m+Nkn8ySK0oG5iNJDp75iCcM9YIxUhZYIi1DolGdvsTjM5R/HJsM/qS
 +uFSs9wQ=
X-Gm-Gg: AfdE7cmAsr9yG1Cmq+OFhYlzvgO7KB7jO/kJxJLgudbf/ZduKklPeW8BoLbKkV9GLZ6
 T8E6YLlmg5LDtUZ7O5HfAwovHCaPat2p4N9F//VgvLW52vMEhqWDVtDU8RIS4hm8/5qy//OzZ1v
 S1zbsHjQ7r/4QB6ICtlfrLaEbYQpOm1XHIHFeccaFm0LtEhPFZXOiIxemYFQK3C+2mrI0W3lwXH
 HJYhSUhqLYwAVISrPV//eVaXfqFYnB0QvAYjHBmeQmyWChiu9PMTO2SO6KVoko+sRlETD/CWF0+
 LP8RwixCbjkK5zVI5IZT88pLfMdF9Zc4rx9CDE99Y+eo4yV9Y3rX9cs0y5S8WZzE95RpB+cfWCJ
 7aPv1JALQk31cpxWeCh6Gl6kOIgJPizr/Izsnh1ekASCbzWK7XFNJfdtaY8quqb9fgrOmczjiuo
 h8+E08oZ3hzLnj3toP5zRAZGPJm52Af0Xm5GROUQWWmGHTVOcWmyJrZnGu/5EHsuo8FLOuc1KC4
 7Ccv2pqewks9P3kod/omZPxG+w=
X-Received: by 2002:a05:6808:190d:b0:49c:8a0f:f9e2 with SMTP id
 5614622812f47-4a4cf38ca98mr8294163b6e.17.1784575359218; 
 Mon, 20 Jul 2026 12:22:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4d3d4aa0dsm7831935b6e.17.2026.07.20.12.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:22:38 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:22:36 -0600
To: Quarkslab Vulnerability Reports <vulnreport@quarkslab.com>
Cc: u-boot@lists.denx.de
Subject: Re: reporting vulnerabilities in u-boot
Message-ID: <20260720192236.GH749385@bill-the-cat>
References: <919747a3-1b8f-4c5a-8ba4-0ef187d48ce0@quarkslab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gd7gxG7WMIRI2ZYq"
Content-Disposition: inline
In-Reply-To: <919747a3-1b8f-4c5a-8ba4-0ef187d48ce0@quarkslab.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784575359; x=1785180159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HImQxzWdBHkOA/znZr8n8OjSjdZltCNArf4+Ed6+Xz0=;
 b=Qd09yQV4R3arW2j+jRRHFPHKaZslJ/iYz0gMv/Zckg4uVbc0UQqmb1n8d948U+CGh2
 xhP26P388CrdxdnUaWQS65ausltYTm/BzTV+wqHj9mgMbJQRZS1yCWL18aI5cwqKDOy8
 aOlhGop2X2ML0iM+5RFENTOXqH7oBxaPI9U2E=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Qd09yQV4
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qd09yQV4";
 dkim-atps=neutral
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--Gd7gxG7WMIRI2ZYq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 02:43:09PM -0300, Quarkslab Vulnerability Reports w=
rote:
> Dear u-boot developers,
>=20
>=20
> I am contacting you on behalf of a security researcher at Quarkslab to
> report vulnerabilities in u-boot as indicated in your web page
>=20
> https://docs.u-boot-project.org/en/latest/develop/security.html
>=20
> We have identified 19 vulnerabilities, mostly in networking  code, with
> impact ranging from DoS and information leaks to unauthenticated remote c=
ode
> execution.
>=20
> Who should we report this to?

The mailing list, and the relevant maintainers for a given file, as
shown by scripts/get_maintainers.pl. And please note that reports should
be verified and proposed fixes (see
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html
is just as important if not more-so than just reporting an issue.
Thanks.

--=20
Tom

--Gd7gxG7WMIRI2ZYq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal51fAAKCRAr4qD1Cr/k
CneTAQCcuyegENm11UwdJsYGTrBTh7Z+UIhT7xupvC7cnh8OowEAvtUW0+gxZXM8
qbRSt5yaLQ6X7hJBgXqejSzbPfFQbQg=
=Flvh
-----END PGP SIGNATURE-----

--Gd7gxG7WMIRI2ZYq--
