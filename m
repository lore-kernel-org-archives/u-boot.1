Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7660A2606
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gj5R2I8S;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iSDNrwKs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBE58409C1;
	Tue, 10 Nov 2026 14:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrcN88D8nRPL; Tue, 10 Nov 2026 14:55:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F281E4094C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794322558;
	b=eaqJLeancpenbAZ16cbUyqreOhJCA5Pz1CsWbySEt3wZ1ffE5O8dWbERuiKgiafY9Wjx
	 9amt+PnO6rZ7ZnMH1gWl6yAEXGOaHODYif+zir/Y7lJYLt0UQqPdwl1Hjk58xtCw+gGIt
	 1Ivk8s8UvAgPiKzJu3bijGY1Wh+KzqjlK2Tm2rkwOnDkzrKq1Pj+4Ux2eO2Gsd4y8EX/i
	 zW2ZzAGTlvmawwHjNXgZFmfCytXvrsciJ0RWWy9XpJmvIkv/VuSRLit15y39XW9zxYrVR
	 hhK3bMhjjIv9UZIX3EeuqGLuOVoDKTpn1RGLEm27zM5RCodAdjTtqSeGK5VQsVv7K9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794322558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lr0i2+w8rhZZhD/PLCtxuH3aUd8pJFbEVrWyE+zrWag=;
	b=TOlSsBw7QSj2vvrRtaqo48Ws2YN/dzMKBaapQmnhvBSfgtbQjJlLp7qdVJ6H5hZ0B5L+
	 K326TjJPrzI7YzzFni+jj56KvdBtGbp62Z+yaz/16WeR+6sFwtcNbdjFwW6rzBl1ynCb7
	 xnsM3FLGxsQHNNBJVTPUrbMYkcmrBIF/qNEQjx0Y8ei/TmkMUH9YH0ywd4vNMQjzkDBSU
	 4dffZUtxYc+XoX6caW6PAK27vwEBhvnMqSovbIIu2EKHziwBucHhtFhrshtsK6pYMnpGC
	 iIknfY1fNOlBNzxrXaG9rfz6wJj1TrTqJWxt6lj1AfiZZeCRy0CpAY8bB8vyFhjK6xQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794322558;
	bh=lr0i2+w8rhZZhD/PLCtxuH3aUd8pJFbEVrWyE+zrWag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gj5R2I8S8wzOZ+dKli3AvEReRiFWC424kOND1VOv8pn/WFQuALTXyxsV4+t2/0wN2
	 7p+0xotVd0qbVYc7KDez8PFFxMrRxG/rfRNvxie2UKkTCDYK/dsMyai0B+AvUR4ZIQ
	 ELJ3SLPQvWY2EE6kgZkEnXqdawZD5CapuVyYaLNK78nxYW8ZOeOx39KHSIqm9XDwm0
	 apKbAcILxKyypcNePNCKQMtDFKjH23xUDpSHW9MH6O8cC9yike8oVoVeVpHoPg5PzY
	 i342I0SvBFsJyYpYZL76wM0x1irnBnPOGmH23e+GjptEvaCo8upTrlsKaK/tA+6Gei
	 6flw+I4SxmhXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F281E4094C;
	Tue, 10 Nov 2026 14:55:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 62C6B9D1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 489864031C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:55:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QnnlPSFGnp37 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:55:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5D6FE4008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iSDNrwKs
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D6FE4008E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:55:55 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-833e671ee9fso2049807a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794322554; x=1794927354;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lr0i2+w8rhZZhD/PLCtxuH3aUd8pJFbEVrWyE+zrWag=;
 b=iSDNrwKsMJtCH6d3kWUgH5g5nxA+VbkgOilUIjiuLGzw4NbT7i+q+iXPdSrqwreGPV
 CBAHvrr/O4Mx0JaaKME10au0DdQ+d0EiXoDoJ3Sy9m2yA5rWlf58ArrAkpOQbakvROrg
 +hFhFB/96Ddm3pgBS5kLoijL+FH9/BH00AoqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322554; x=1794927354;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lr0i2+w8rhZZhD/PLCtxuH3aUd8pJFbEVrWyE+zrWag=;
 b=v1FzCU9v+5ozmUNLGze2OUn1LGBbKsTYzCa84oqRES7zE+gZPQ7Pp0Jqmr6lcU3zGA
 PFLQP2s1qv7A7NZhKJz8oiJpjyctSitfqjMQQ/RR+fi9dFY04mPA/jFvyFTW5e6h2/fJ
 XmbOY6/aMzr8LOX6cr4o1svRo3j9eQ6dcPonJfS3YIHzZSlk1GwbtmYmaVhFuJWJ71Lu
 sue9fRSv/tIGRzEVm8RohEOi4EayqfI5Fi0o3/xdcONKsq/5XBHWn1e4cSqKBlcTrA31
 sF8w3n9G2iIhSA172yDZkgdnMv44W/8ezEd5Y4j0X/+cmI+7Iws33iFPjb4vBaRDiFDZ
 5EPA==
X-Gm-Message-State: APuU4Z/MvEIUDTqVdOmqeP2cwUUMs7qYEj1DfSbE/qvjPS8BwK9I2cs6
 0Y7g1QnwXeFynxR0mz5qsaP0Zj2kAFkAXHnBm1oUJh26FWPQDC/tT1YeozYc1Gs/fPU=
X-Gm-Gg: AYBFou2lKntY6PzEnZE5Oqil93mkTz6QEaaxLD9PFQpEhsnrRumqNXZ43CptYqnYRLA
 Ke10AQvhCJROVqNyQSI1CKY80dXufVXL2TwKYM3GcAMXbO5MnDckc+SjDESWb3VTS/izs4s6M9x
 s38O8OcNf4THQFEFZkwYCdClJ6iU6f1fDG03W/T2VsIhKlXWv4eXGMQdQMPx19apcKX0L3qtKjb
 +IUO+3rkVcIWytVYGJEtfKPIcQrKlicFzKyi4JuTHn6Wm8KR7ZDWGnuTDBuc/vxDJgNlsFmEa/B
 pEWBX/tKiG4QN5J/RyyAnKJoGfoNLS/gmJgzpnCv5dQ+cE3Rg4uUK2iDSN64XWbhMFZbV4nPeyR
 uQkFpeA8UU2c9KRyAPyGRvQQKSN37GK1dwV2nPXfjryZiGXonD6NDTJze78ju3Ra2y6//06/mYP
 hkeYbo8R7BR9xabnsZElJmoNY2bEIUk8mm8oZn/doY8UACAdNm15+32WnrTM8acC00hVf91qqLD
 yY077QbG9Y1vSe47t3zOc8DWuhyz/qAYHfeC0WiUN00CTCSXv9JzqDqx1Sjar+UvtyYOEXxVd4p
 4vM9qg0dOikFlEZPDUK9YmvsWIiZFYazpjSNeO+PoCLYDXUWtiNFpwdsbKoZd9YrACvHHTttVKX
 K2RM3eTMqshTQnX4Uo6TcJq1x85BhiAfsKCM7AM+fZzGFgPpAxl3Wl0xGIfbp6cj4TSM/UjGkYE
 +x4WvjqgxY8/HrXVC8k1v36WIU3d2R+tL3Eqf34YSuVrHAbkXJYQNy
X-Received: by 2002:a05:6808:14d2:b0:4f3:890b:5fec with SMTP id
 5614622812f47-5683cc1019bmr2069040b6e.25.1794322553917; 
 Tue, 10 Nov 2026 06:55:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56906330d56sm2344397b6e.15.2026.11.10.06.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:55:53 -0800 (PST)
Date: Tue, 10 Nov 2026 08:55:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>,
 Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 00/12] Fix 'make check' errors
Message-ID: <20261110145550.GC3741582@bill-the-cat>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FcpGcmKitGl9Yv85"
Content-Disposition: inline
In-Reply-To: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--FcpGcmKitGl9Yv85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 12:23:57PM +0000, Andrew Goodbody wrote:

> Various tests can be run using 'make check', 'make qcheck' and 'make
> tcheck'. These have become broken and need fixing to be useful again.
>=20
> Running 'make qcheck' fails on the binman test to check the version
> numbers of the tools are found as expected. Update the code for the
> tools that have been updated and no longer have their version numbers
> found by the code.
>=20
> There are also failures in buildman. First add code to understand 'gcc
> -E' as an alternative to cpp. Second add the code to accept an empty
> CROSS_COMPILE variable in the environment when testing that
> CROSS_COMPILE is not set by the toolchain selection.
>=20
> dtoc was not achieving 100% code coverage so add a new test to rectify
> that.
>=20
> Disable event_dump tests that are broken on newer versions of binutils.
>=20
> Build mkeficapsule in the tree that is used for testing the tools.
>=20
> 'make tcheck' was not achieving 100% code coverage and needs to know the
> location of the built tools to resolve.
>=20
> 'make check' tests of the file system had errors due to ext4 file
> systems being created with an orphaned file but were marked clean.

The biggest problem I see is that we need to step back and see what of
make check/qcheck/tcheck make sense to support at this point. As you run
in to, and was my concern last I tried any of these targets, things
quickly become very host dependent. Which is why we have CI abstracting
all of this away. Personally, I found it best to just fire off a
one-shot container to run pytest in.

--=20
Tom

--FcpGcmKitGl9Yv85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavMwcgAKCRAr4qD1Cr/k
CjheAQCJqp36e0NpJHYtdsFnKWQjHaosTQtIbvMXPnsMhIAQQgD+KBKAPCR8ytMA
YLN8FoMpCZOsNHvQJzcJWu7s92v3HgM=
=Hvy6
-----END PGP SIGNATURE-----

--FcpGcmKitGl9Yv85--
