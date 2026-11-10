Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F950606A9D6
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vhLXTGa1;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mUHoAcK2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45F274058A;
	Tue, 10 Nov 2026 16:57:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Pzp6zYb4km2; Tue, 10 Nov 2026 16:57:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6DD8A40595
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329839;
	b=T0IWOdw9ZcH+lmBOHE5oGSvuPZSbpJnhf+fSA6sIpQw2MhtflP6zoihNF5yoel4rvdSp
	 ivM6M+w0Emkvdm1PPxnVClSxI+gfO+ckY8DiBL+f9N8IfuyXc7+PTE7enfkJZfhmPrxsE
	 +13nJOkpZMiLqxaqyp0idOOQhpXTyjBVPnu5yWBlKJilIosviVh7VLu6oqmecx578ZIAO
	 3dsNw9lKG30C+C/ahLLr0Ljbm/ydKB0pc8/nhqqPpcsgA5QO45Je+qZLvZgkLvwOQMfRO
	 +H7MTbbgYpsJHNke2tvgAd49pmCpU2V47lIBzuBgtbzqt9vnhrdGGj0X4zHfhT1Wwcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ne5Sa/IB+RzMsHpsIMfPROO0gvv+5Eb5IyIt9Hh62t8=;
	b=gIFOahO719ySYYCF1Zq0D9Ej5u3e3Vg8xarRAOxHxtsrBjUDX6Kuzfu/bmXzO7bBxQtX
	 92wt8LHLW7cL0GjgruCZDFXR4aAqI+8NzVsPYQNv89vVjU/LG401TMnKNZb7g5tK9ohNz
	 qvLfmen9QzjPFYcljTF3mKdcUkUf/I72TSADmC9QtqulwPatTUUIEuvzSfIS/8e1LoLBP
	 XSbT9CYfVxo3mIB2ZeVpf2c09RzRfLkBctbmaQDEgymdXwvKzT5yCIy8T2ts0c2S8Znbj
	 dSLFpjZOC33dfu1A6TDIeUBBFZmbInrzlLkN7tAFtco9J442bzmjGMovWZ5C49NMqzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794329839;
	bh=ne5Sa/IB+RzMsHpsIMfPROO0gvv+5Eb5IyIt9Hh62t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vhLXTGa1Ccsw3SPjcEu2ajn5t8fAGSJBjhSZUzAVa4kUr7tPTrZaLjCW1bEF/RtRE
	 8kYEsR4HuqlGXaBRi9TmJTbTizZykCvAQxK26MKtE8z/POFWmckNN3QqRm/+QnQJMj
	 inUfxYd+Gd0zT38atD0Lvk0aMXCGnaNTg3M66srMzSxWDdr7s3gFyIpQyDBp0Ht9US
	 K3SLpdda/GVQZ+OEmUYzc1uwrLrbV7iPneiOxloROF9+RpJRppe67WStL6GbX7uumf
	 wtsZu/yoWQl7K0ckiOAw1Dr3ikbnw8K8kCtGtvf9cXE4thy1swexTlPRgR35ZiQ7vo
	 zS9arkq2rdzTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DD8A40595;
	Tue, 10 Nov 2026 16:57:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 218341FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0695D608DD
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:57:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UC3RbULVdcI for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 16:57:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25CA560879
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mUHoAcK2
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25CA560879
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:57:16 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-539a57a0b1fso862557b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794329835; x=1794934635;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ne5Sa/IB+RzMsHpsIMfPROO0gvv+5Eb5IyIt9Hh62t8=;
 b=mUHoAcK2NLAOxYh4FrPLXV1/du1AXjXgBrwlT0iozT8r9S+inQAXluwFb3gO95kU0f
 Kw9SPgXdfA1swN3E5rgTumKZdSM0w/uQAAEqijv4ZUzwM69JUp60IBqgKdajUas5ZVF9
 IHX8/2Cq6vJQ3Lt+7UX46ZtKtCoA6h6sdNR+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794329835; x=1794934635;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ne5Sa/IB+RzMsHpsIMfPROO0gvv+5Eb5IyIt9Hh62t8=;
 b=qcukFhd4NwFV3SxQ79jAx8bz5eGGn1tizHM/vAamtOWTozIkRVl313Gfke7jXNWlz4
 NpkKq0xJLV15+d24lV3hukBLI3+Q8i/voHMuNHVBVqhqnPLJazZOIJBO1QT0aJIFUDV6
 /FiZa5IytJOLzo1VCc7CLnoqb+OTA64fwCrQglvHkwzs51iOOsyCxGYK58W1SNgEMUUo
 Rqo+t7uFrZuQZnxhPk0/4h60pVXs7rHAmCBJMqnYXZgusU3uLG2i2yUWpPJClkPJiBpn
 fwu3AH9uSbPZAQLYYsJpupNltzYLfnBHjxE707CTp0RQ/gNs6o+3k46b0sQc1C6S78ZU
 GJDg==
X-Gm-Message-State: APuU4Z9bvm2tX5oEOnHOzcfVWDrHufi9ld/4wHJNoJNGO8vnKEhJ8EkM
 SxWPXSss82uCwZSOW5XYCR7WOnNbBeOwjj85TeN7eQrInCirc3HxevQsZ4tF9QD2Pf4=
X-Gm-Gg: AYBFou0vhhkjv6IAYAUPfUQfPRPnGEBnKyllHYA/51fbAWoCv65sV+/mktxmx3h58Jo
 ZTzNVQgvXkvgivN9++IMMUhPYW+NRUxTvBHm7/M6kFoGGnxvYjhzN1n43cUcvxHTAgvG00DnPmH
 TonN8YgY2fLDEr5eq8/sBCCIZ3pod+AyxZU7O3lRZLFDq8VwVujm+aLazjHT3LnozCcnHbeGwiz
 KGIw754sgknqCkqIt0KK+cBnX7gln2c5r090ieOFO8DgcGQmu93Ah7JfhxbZoeIRs1E7spfXMW/
 pylymr61Z28VS/ZoMuuAb1UDH/euHQB4zJ2LndgQbLTS9zXnCdXpimZJs/WrtcaZJK1fT1zTOOi
 La14LrRJgDd8O4nRs3g8lDCIMM9Sb6AvPRjdtp9WxH1c6+nKjgrgT0aJkLC05LpHXc1ROrC2BEZ
 iqLcmnTdCy7JfIHe0GYl7ql9nSlX8PJXYirehNNYktOSBxCPn4L7qb3ntFYTM9+gPkW7gpJGMgS
 4NMSrTPt/n8svb7Ob2lPAkZmbVb+bHuOAjaXMJNntwtfgsNVfKCo35iEkNauBQMfgY/vRxDTlAa
 WGINNkJyfFk13B8kmFFi5UR5vpkXMBbrWWUltuN3ewFvok6izJntkYg6meWPwQ4yrSICxEJoViH
 Y0NEcDKnS3BeFasulYB4XqAUv7qO0cdjSO+yAVDQesuEvHVTmxTPC21qGRJnmsaRGzccaFNQivk
 zhHm16jIRoTPe3H5JTtoAnn/FxWPvlN0w=
X-Received: by 2002:a05:6808:c1d4:b0:55e:fa63:7001 with SMTP id
 5614622812f47-5683ca515c5mr2399026b6e.36.1794329835527; 
 Tue, 10 Nov 2026 08:57:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905736b92sm2618399b6e.8.2026.11.10.08.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:57:15 -0800 (PST)
Date: Tue, 10 Nov 2026 10:57:12 -0600
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
Message-ID: <20261110165712.GD3741582@bill-the-cat>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110145550.GC3741582@bill-the-cat>
 <fc5535b6-d967-4890-96e5-337c6ea5c23d@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p6coDFjpUqiB7RIp"
Content-Disposition: inline
In-Reply-To: <fc5535b6-d967-4890-96e5-337c6ea5c23d@linaro.org>
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


--p6coDFjpUqiB7RIp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 03:55:55PM +0000, Andrew Goodbody wrote:
> On 10/11/2026 14:55, Tom Rini wrote:
> > On Tue, Nov 10, 2026 at 12:23:57PM +0000, Andrew Goodbody wrote:
> >=20
> > > Various tests can be run using 'make check', 'make qcheck' and 'make
> > > tcheck'. These have become broken and need fixing to be useful again.
> > >=20
> > > Running 'make qcheck' fails on the binman test to check the version
> > > numbers of the tools are found as expected. Update the code for the
> > > tools that have been updated and no longer have their version numbers
> > > found by the code.
> > >=20
> > > There are also failures in buildman. First add code to understand 'gcc
> > > -E' as an alternative to cpp. Second add the code to accept an empty
> > > CROSS_COMPILE variable in the environment when testing that
> > > CROSS_COMPILE is not set by the toolchain selection.
> > >=20
> > > dtoc was not achieving 100% code coverage so add a new test to rectify
> > > that.
> > >=20
> > > Disable event_dump tests that are broken on newer versions of binutil=
s.
> > >=20
> > > Build mkeficapsule in the tree that is used for testing the tools.
> > >=20
> > > 'make tcheck' was not achieving 100% code coverage and needs to know =
the
> > > location of the built tools to resolve.
> > >=20
> > > 'make check' tests of the file system had errors due to ext4 file
> > > systems being created with an orphaned file but were marked clean.
> >=20
> > The biggest problem I see is that we need to step back and see what of
> > make check/qcheck/tcheck make sense to support at this point. As you run
> > in to, and was my concern last I tried any of these targets, things
> > quickly become very host dependent. Which is why we have CI abstracting
> > all of this away. Personally, I found it best to just fire off a
> > one-shot container to run pytest in.
> This all started when I found a suggestion to run 'make qcheck' on the
> U-Boot source tree to confirm all was good. Of course I found that it was
> not good and started to fix things.
>=20
> I do not mind if we just remove 'make check' and friends or if we resolve
> the issues but the status quo at the moment is a bad place to be in. I ha=
ve
> tried to make my fixes be less host dependent than they were.
>=20
> CI is all well and good but having a local smoke test seems to me to be of
> some value. If the request is going to be 'please rewrite this whole
> mechanism to use containers' then I am not sure that I will have the time
> for that.
>=20
> I would appreciate some indication of how to proceed here because while I
> understand and agree with your concern I am not sure what is being asked =
of
> me.

The problem I see (and have talked about before) is that having a shell
script to run $X means that it's expected to work everywhere. This was
difficult before and even harder currently.  Personally, I run mine in
containers because the last time I tried "make check" it was failing on
things passing in the container, and I had everything documented
installed.  What I would like to see is:
- The fixes this series exposes, for running tests on more modern
  distributions than CI is[1] using.
- Improving documentation how how to run tests manually. And I'm not
- See if there's things make check/etc are testing that CI is not
  testing.
  saying "and in the CI containers". Just, run them manually.
- RFC dropping make check/qcheck/tcheck in favor of pointing people at
  the docs.

And FWIW, with this series applied on current main 'make check' still
fails on my dev box, which is just Ubuntu 24.04.

[1]: Updating our containers is on my TODO list. The first step is
moving to having CI build containers. This is blocked on in-progress
work at OSU OSL.
--=20
Tom

--p6coDFjpUqiB7RIp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavNM5AAKCRAr4qD1Cr/k
CssKAQC7NF/Hqa95yQuDN7eJEdMH5FW+cJraYSWWIG9Prr5qLgD+OyZ48WLErk2d
dhtp1DP2xX2oDPgucdWNxhdyhq468g4=
=O677
-----END PGP SIGNATURE-----

--p6coDFjpUqiB7RIp--
