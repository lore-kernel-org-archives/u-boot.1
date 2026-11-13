Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50F606A32E
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=traDGFAL;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RadYYa1y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D612281547;
	Fri, 13 Nov 2026 17:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5CTIdaDbb0v; Fri, 13 Nov 2026 17:05:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C794381324
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794589501;
	b=dOMOjs/AnIdQvk8PSqyMEPNgjuxPDHrqg49oznO6JnPJ8TVaGmQJNqkrjsaAse8oP9TB
	 f3EfWIv8sRV+zz3wYoDKMHAhDQ9Kn1E3zOoKT8NtL9U+9yLmgJuozAwL8jLcQeuOCGVZL
	 baDA41cuWTnF0a4K7jjtinQF667S5YtGlg1V9aj4rKb4ssYzcAItE9i9+buGRuYInipNb
	 LJTzif+od85mqfEwMqPueMJiKdNbzdkW4jo0+Iue9gaLFbwCGKCK5MhF9V3OnUyMwQd6i
	 vMhwK9aLrD1HcUVd/6u7t+ANHHMX8Mrd0dg0kR/uDHI7gHntI4Hv/YExo2/FK8p7SUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XVwiUzCEyS//k+cUCmq+NYDWYPi8uTrbpGcKdqMHS7U=;
	b=m0mmg8VuNcY2WhxbD6NmXz8qERzuhILszNHMwe/l1PLjdp6582QU4WRClbeeVeUOBpHD
	 Qn3g9NlpEaMbwJFsXiia8nnJe4xHkQO810LyJDM22DCrApiKVVdQKxqlYBvt6rD83y7OA
	 EuyMnpwjnawSC8QkWKcqD/1r3nJQqCMJ3yg64sg8NpISxqQ8rE4Gs8682OAaVkUpSqLnr
	 3Jf/G14QZacHCoRpoxzyRRdDKpRuouRX8IWneFZv3JALihiopZDG1ADIwKonndFhK4Ly7
	 rOIQWLS/rcRY0Xm4lMUPduSFlWPztp9zG+jWXGdTeKjJabAahHErApstx+lZXzhSwtg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RadYYa1y;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794589500;
	bh=XVwiUzCEyS//k+cUCmq+NYDWYPi8uTrbpGcKdqMHS7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=traDGFALejptpbiK4WwMbbMiOiDTSKswRlzd2I194Q3bR3NyVrDVNmquSDpUxQUvS
	 er3FzY12AwYcrJ1XCSRRWhPKN0l6iO95UAdt4WZcQuJ5p2vAeBEvQniotDcZal1/Be
	 ogZecq/TcmBsbAVQdopeE75iroY03lv+SXLl0jm+TcZauX6YTm1YoVilKr6MHAqUOw
	 QgaawEpwjd4ug8gHiH5QhjQxAlDMRyw/+ixcIPYNpul+aHbcR+o/ispTK1CjisAQhi
	 a4PlHTCuPbutjRX6Pry0qH+BiQG2SQj3/vJ2WjR4nNtiew0cKt0dDWvFYzCxoGvD08
	 +GI70ZTfEAySw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C794381324;
	Fri, 13 Nov 2026 17:05:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C758178F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 434CE814D6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:04:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5ETpKGSA_cG for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:04:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 536FB80D84
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RadYYa1y
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 536FB80D84
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:04:56 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-86210f31496so1327634a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794589495; x=1795194295;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XVwiUzCEyS//k+cUCmq+NYDWYPi8uTrbpGcKdqMHS7U=;
 b=RadYYa1yyQdlUMHWQS+4BjkaZEppeae9j2I4v2yfl9YXAoTzb9UDZrjyKb4gf0UOAz
 JfPc6D9fLf33Q2AGJypOTh8IVvAf4wikqLPXEzMfNlxa0lJxqbDNgwULRAbljR8U0b08
 ODGHulKSL+FLxvtG8/RBkcJbMknJ7yTnDu/IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589495; x=1795194295;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XVwiUzCEyS//k+cUCmq+NYDWYPi8uTrbpGcKdqMHS7U=;
 b=aGIuD+g7sy+hLxtIeIgN/y7mmKGl4yP9MazHbhCjGtOfd6R0zmSS0Vj49GHmJT+4Ni
 f2+xB9B4lXWI5vEek+Rq0oKAC9wLArqUXfTfMaPlSlwWHwQYNEk3bC6aNWTOpvL8CTMP
 SF8eGO5UdCrAQgoPGakU+Q1PlV4XPCuT9V5w+w7kb7c1QkYKMGHXaC6jwrUgo36StJHQ
 JjPKU+EiQ/rTz3vDEgLJGZLCwYPXYNuPtR38wrjkp8wnejVgLaYZlkWbRMOKxbECzvLz
 3UMjzplCjBgiv3Ymb2X2r1OrLwNuEp8g+ZLrzJLAdhs1VwpdGHnq689Fxc9gOcxJbhWC
 b0KA==
X-Gm-Message-State: APuU4Z//33OX/+TMYbYyf+SG8Hshc6akQx9635OEiIr3ZOhbIT/Ma/aw
 l0e7pF7prQwvtkN9dDnS/LRlrTN9Ftw6SV0Tga6EjjL3yYc3P6Z4AwQXB1qiE51kuig=
X-Gm-Gg: AYBFou0TPmteWT38H9fWJ+wiUyXgBSRgi+2qBDh+HO2RQbzJz9dmAwgDrlFoCkxwJ1o
 ELvFAwCk+ELs9a5hQ2Wx7ViIY+4vixOswm7nLeYFD8LrCtbhYN/lZhDUdZIRtgbJ5U2GStE7AfI
 yP4ZzXghK4xNVDeQcjcq9cF2fSBZXF60RBfh/ZdlqG8KuolPV8FvJGIxoUaMPTHqSWaKS10gGhF
 bHhlr8Ulhnq7xXbF1WfW4Owkl/gsJ0ocu+CPb/DVkzheaaU7dPX5ttswUdQcb/u/BA16bOJwi49
 tECzSO0fjvtP3JUECCf2d5Zp7mA777jYa5NcA7NvL/BfQ6TwmnAHdyV/Tm9JUVXcalQVnf4D91E
 lBrxWIBq52zcP4vBNc8jwS9N93C6Pc6Gd53ikGf9Udnnjg4qJK7PLgcaepU2xIDBnMhvDU6htyC
 bfQxLKDr1i0yMPkDeIulEPetsg/8Pc+l1Rga4L+t5Bf00YQS3iT0DZXYOJQE+u0hIVEFTo4cfUB
 DrIiCa0t/mZNJY0+PP38OPw8m6QFpC3xS6bs/4/S6qlW90nwBX8Ha1KO5nKjEVW9rTgVTYuJ7jy
 ntcFk44Wg+EIMPHeHHfHwPYiis5xCKCay5oRtvYmLqBVW3uDyYpzKztR0NHdK8/e05qc2a163vb
 BzI/8Mu/zuT5FwwCRKEjQyJ+XF2il3xBMtJT8WaWBBQdawUqQjehhwqrS8bfU6Vox2nqzsMlZ/w
 0bi7U12wl78yOsqtURJYGme10QIxHDi/E=
X-Received: by 2002:a05:6830:230f:b0:861:5cbb:8608 with SMTP id
 46e09a7af769-8628981b6e4mr2530819a34.8.1794589495056; 
 Fri, 13 Nov 2026 09:04:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880e779dsm2809851a34.11.2026.11.13.09.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:04:54 -0800 (PST)
Date: Fri, 13 Nov 2026 11:04:51 -0600
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
Message-ID: <20261113170451.GL554944@bill-the-cat>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110145550.GC3741582@bill-the-cat>
 <fc5535b6-d967-4890-96e5-337c6ea5c23d@linaro.org>
 <20261110165712.GD3741582@bill-the-cat>
 <78111088-8ad2-41c2-9323-d6a65e03d83a@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HmRs2c3sQ+xwxBty"
Content-Disposition: inline
In-Reply-To: <78111088-8ad2-41c2-9323-d6a65e03d83a@linaro.org>
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


--HmRs2c3sQ+xwxBty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 04:47:51PM +0000, Andrew Goodbody wrote:
> On 10/11/2026 16:57, Tom Rini wrote:
> > And FWIW, with this series applied on current main 'make check' still
> > fails on my dev box, which is just Ubuntu 24.04.
> In addition to the packages documented for building U-Boot in order to run
> 'make check' and friends you need
>=20
> $ sudo apt install yamllint cgpt xilinx-bootgen u-boot-tools softhsm2
> vboot-kernel-utils opensc coreboot-utils libengine-pkcs11-openssl
>=20
> You also need a built copy of fiptool which seems to need being built from
> TF_A.
>=20
> cd ~/src
> git clone --recurse-submodules
> "https://review.trustedfirmware.org/TF-A/trusted-firmware-a"
> cd trusted-firmware-a
> make fiptool
> mkdir ~/bin # if this did not exist previously also need to logout/login =
to
> get on path
> cp ~/src/trusted-firmware-a/build/fvp/release/tools/fiptool/fiptool ~/bin
>=20
> I hope to do a an update to the docs to make all this knowledge generally
> available. But that will not be part of this series if that is OK.

That's fine, yes. But also highlights why I put what I put in the rest
of the email. Running "make check" is not some sort of quick test, nor
some self contained test. It's running a bunch of stuff, with a bunch of
required tooling. It's arguably not even doing what a developer expects.
If you're developing support for <arbitrary physical platform> why is a
bunch of sandbox stuff being built? But yes, fixing the bug you're
finding is worthwhile.

--=20
Tom

--HmRs2c3sQ+xwxBty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavdDMAAKCRAr4qD1Cr/k
Cq2jAP9kxpKI1uAx8wNrUGZf5lqwBClEEPgI2fRqYkqcXd1LLgD+I42Qw/JkZU9V
2E4nMdAW6Z46NyQQ6GxZrU6ZxCcp+gI=
=CWtW
-----END PGP SIGNATURE-----

--HmRs2c3sQ+xwxBty--
