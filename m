Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F262606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eWtJ6lE1;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PQTtsoaZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50AFE60896;
	Wed, 25 Nov 2026 14:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7lMG5zqrv6yc; Wed, 25 Nov 2026 14:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69824607D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795617762;
	b=k+Yygp6kF/7t3D2tYpSPj/qYZCqLd4CUd+W1mt0RxvS2EQrdwdA/L/rqxa55WIjK18nk
	 VBp16/pSJu+IgoILAxbBXdDnJW4vnD7KofDXaQUi3YZH61TfrTYoB6W1chl52zSnKltwc
	 hgUmfUcGJJ1ztdqFfXgb5RCcmMVkjv1du9lEWVT6PAT7Mz4/+VC+QUskwbkLOOtmKXJgy
	 96zmxGNBh6PLEDmt2NQNXe6+gvnoSsRClb7Us3JL8vaZduZVFiCVuvDdbnHc5mYr/HwU5
	 OM8KVAyq+p55i1H4WixuyX3QDqjmQ4WggbA9riaNrrqEAJ4R8NNs3/fGtXVqO4U10Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795617762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eB3g+SCuu9GdRJYaS/8GkcWqWOvvS/cFf9W3m1Uo2LQ=;
	b=fbGqt0nN5s0XfKE/vToB9J8HWMU7B/SlzXs7k+1odKugcvltr2IqXiD2iOB7VuXWr7Mn
	 EwUxG2lAUcJ5dqmqH+PpZF2luoh+NWufX4kIwmFjIK5OVvtAMHJnK611lTZIPEqOIxS0X
	 zkNRTExEmy32cc3m4n1/AwdhNajcDE0P4uoCdAsdQlP/W2QYZhyBTAxzD4yqZJJopa7N4
	 0FPQT0uahfk/vHAc5OZM6/oJfaP2q8figELQSF1DD2s+1Hx4J6QwLUs1s4jbr26l4rAl1
	 78iUw2am0AxBucRe0QjoPhmUSfeVSH1L9G3kq+vxRUiZ+y8YWPBfpZ9SoyyaX8sG1Vw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795617762;
	bh=eB3g+SCuu9GdRJYaS/8GkcWqWOvvS/cFf9W3m1Uo2LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eWtJ6lE1SPq7rX2bRZ+8ZyWcN3Xsaobk7nMrLQycFEdtw8hSAfTz7fsXdnSn0tW2E
	 LrKQ5we2DUmMbJmrGyFCoGKM9O3LEhhFVOTobIMTC79KC6ZtaEeFUgdtbmqXm9HOO9
	 fBT5eFjnXsvHACR3y/fwVGGH07LPxL/CWoCmV623382ukZIAPpnCwXHTwZKKJaQOfU
	 12OjZiOYUfhcpkG558/jOIRmY/g9lATa8iODE0YOuc7n02LhwZPhovF355LLiyg5IG
	 ckFizgiQ7xo5LOVm3xkQAntn9i5UPs9WItxDvZWqzelxLsP6zwKIkRwkjAcpAgEVsR
	 H+bIzSB2SIvXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69824607D2;
	Wed, 25 Nov 2026 14:42:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2729A22B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 193E24077D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Na9Akjm5mTPD for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 14:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F4DF405A7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PQTtsoaZ
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F4DF405A7
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:42:38 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-71b47eede22so3355440eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795617757; x=1796222557;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eB3g+SCuu9GdRJYaS/8GkcWqWOvvS/cFf9W3m1Uo2LQ=;
 b=PQTtsoaZFrnkqEuu3CrieAe36BtwT1434b7Kf4h2nYDFaxz5WajPyD9IeZpYJ/2TUc
 hxcmqguGwuU96ea5rBCD1ccsWW0NI8kdDxMEe4OlbX+8n3yfRBfIRLoLMjHGrUwWqxlx
 Ou6/ycIg5LEn4K133r1dTPo3wRLAUMr0Q9yEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795617757; x=1796222557;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eB3g+SCuu9GdRJYaS/8GkcWqWOvvS/cFf9W3m1Uo2LQ=;
 b=2AR8WjxaeRzVp/9shL7GdPlHyc/kw3VPMXPpDP7tXM3n8+DEcTKKRZdh6Cs9oBG508
 KWE4rwntJdhKeihUuLy0rNtjR0BQyN21he3kvHxGybm5W0iRYYsC1ZXJqrEkWJrQpNrk
 nDJ9SLs/1s0d96InKRs4kcPT4AE7Q2sMfOjnxdWbRaxU+8Tfs0rfB3ZqaIp10kJDR37h
 TWoprcY+qm8TL8cgRUGXt5+pu1BJpMZVO+Q2mZQmxwrOudmhGMg4t8hUJ9rm0BaJPtB7
 jQSWAdTxeHdhylZFOvjJFlFJm1TMzKvehjG1KFbyEnGiEHN+96n6TvuQ0mtsrHzscYXw
 ANkg==
X-Gm-Message-State: APuU4Z+/2mhjhcESZrIJm5rRUOxa6rQm4Exi2hvcVR5mCyObFQH3Ioyf
 YZoSP+4+TQpScPBZyF5bi0TCt/mKgkwX4fXgoF41LWdKLHfUOjty17T2SPIPO+H/us4=
X-Gm-Gg: AZFdTZfq7q1+60XxUOo4aMcxijE8Vf4iq1tyFdWKtZM9+MuuA7Vzl2qEh7i5eZIyfLO
 2LgPGHhJYcpIWswfSvRjYT4gXorBGg0+M1EBO/HQGf47u9g7iO7glli48dJ/SQGar/sRPo2gcgO
 INeUpLyHwri+FCVNZIB7cPRsCACSkRlzVL3bomDh8PDDdcWN+30PeNENSLPeBHf3SWDQDk/yMpj
 6XE3BlBRfAb4xKHXCPQzVH2qrt8davKrcT3bvRNsTvlCtXZ7KbmiljysSres6/7GhdHvA6liFbB
 sS7q9XUw1EpHk2VJU8weeTnTgYUFL+CeQdkuqo4HsxsNtjYWFUmOyJGrAVQCkhZIYQKX8cz1IQg
 LjOLBEyzMefKRMD9/0dTVh+IQaqnOheyh5Klxttq9YT4QcFr/u/tWVigykMogyPtgYylsudHv7F
 OjM7ogcytZIVHgbgVAlrMUVfynXERM4yKBOef6RmLjryi6HrDhFYAkMqpd389wspCv+jik33w/k
 U08YFStpzfUORhmGsELN6aeb2O7uBEWFn/wJEeZuV1fvxjFYrfHZDVkWNFpDYAmaH1a7exiReQc
 +6HTWEmjBp5BTTfpnnMUmN6weRFjUDM+ko+TCWJ49aKR+d8LrzusKrGUOeoT94QiYus5YAeX51w
 fGEEq8RwIhMe8ocSWW81o9LzqaEZGVQIErKbYgI/5mQ8BM/DagMlqpdUkBSRBMUVOycbwsmhMIR
 AFow3NroCnaQPf6rlFkIbFzao2hwokJw4=
X-Received: by 2002:a05:6820:c0d2:20b0:71a:e73d:afbb with SMTP id
 006d021491bc7-71b394055camr11384484eaf.31.1795617757598; 
 Wed, 25 Nov 2026 06:42:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b6b680b66sm4488251eaf.9.2026.11.25.06.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 06:42:37 -0800 (PST)
Date: Wed, 25 Nov 2026 08:42:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH RFC] test: Add more tools tests to CI
Message-ID: <20261125144235.GD3176972@bill-the-cat>
References: <20261123-ci_more_tests-v1-1-52e9984f42cb@linaro.org>
 <20261124190931.GA3176972@bill-the-cat>
 <176aef67-030d-4ba8-84f0-da7dcab3b091@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4rR6jrJB+SCOQ6Ia"
Content-Disposition: inline
In-Reply-To: <176aef67-030d-4ba8-84f0-da7dcab3b091@linaro.org>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--4rR6jrJB+SCOQ6Ia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 09:47:19AM +0000, Andrew Goodbody wrote:
> On 24/11/2026 19:09, Tom Rini wrote:
> > On Mon, Nov 23, 2026 at 03:19:18PM +0000, Andrew Goodbody wrote:
> >=20
> > > 'make check' runs various tools tests that were not being run by the =
CI
> > > scripts. Add the missing tests to the CI scripts so that CI will be a
> > > complete super set of the local test runs such as by 'make check'.
> > >=20
> > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > ---
> > > This patch is in response to Tom asking what is tested by 'make check'
> > > that is not tested by CI. This is the simple answer that shows what
> > > tests are not being run by CI. This does not claim to say whether the=
se
> > > tests are actually useful or not.
> >=20
> > Thanks for doing this. Were you able to push this through one of the CI
> > pipelines as well?
> Yes, although it failed on a world build due to lack of disk space I do n=
ot
> think that is related to my changes. For the purposes of this PR, to run
> Azure CI, I based it on top of the series for the 'make check' fixes.
>=20
> https://github.com/u-boot/u-boot/pull/1087

Thanks for confirming. And yes, I had missed it was disk space causing
that part of the build to fail.

--=20
Tom

--4rR6jrJB+SCOQ6Ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawbz1wAKCRAr4qD1Cr/k
Crc+AQDXdLVe7VxAwfF1FcfggAV6e3fhKoq4SsjfdSCf9KktFgD9H+Rk11jt6B8p
Iaqo+bBrJZCOApRt21ZdLEP2Krz9SwU=
=Sl/7
-----END PGP SIGNATURE-----

--4rR6jrJB+SCOQ6Ia--
