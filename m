Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9D606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PmX1FZS+;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NiYwRVMM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44B5C60AA1;
	Thu, 26 Nov 2026 14:49:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ObTA7YJyGxfI; Thu, 26 Nov 2026 14:49:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95F7D60A7F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795704593;
	b=qf1cxtrggPUAn8sfc5TZ8reuU8UKiP8SRUoE5TTEDonXrMRQoa1as2+Ho627cOMT71/b
	 R62GBe8w9FWSBymXxaVxm1ylgOYgHpPb+Y5PZ/Me83h8hDG9NviCA2C1wLl50G/PDOqaJ
	 vmDFGCJg38G/NTNZm7CIKTz26UuTsat21WfXdSeYjuqKQsW1PoFbWeL4A6s51f2B7LDzW
	 x8qnvRTPCzhbszWF+ZG3oL5FZSRI2yF0XpHCikAmqvr0PsQFG4OVHhKlXr/jFOoJg43KK
	 W3pgg0984N9Afag7IwxqPIo3+ABesxLxvAwULCQuilSsiVcv0OSwkhoZjqeuM2+g3vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795704593;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zSbburWSEfcADSf4yHE7240t64uUfgvxZbu6as21fnc=;
	b=n3crERsjm4DPqHItDAO8XfEfTA6oSlXd/EknWkiCYM1wjkpbgCs23LNu0Kd9J/AFM2+u
	 ReHrrXfuq00Mpq6Tgirbtcbi56NkJKc31+UOKlOlGjdQSj+AJ/4A7F4n02IVVs62aiIip
	 aHjRux52S6qzW6Mwtb8Rdg40s/MvxIIkYIV/C6TvUF1uc3tfwAjW+xDrepT+Ih6IRJ9Mn
	 WL4viupi9tyUjuXg4x9CJjaCx200LY2eDdoaXWtj61tKHdqjNraftJxQRYtwkzyyXS/4T
	 Y72ppVQL/JsJRqCbmmNoJa6hw8EBEXF/vFtpH8j6MNgx84a+93/+3n28NqM1UvO2Hhg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795704593;
	bh=zSbburWSEfcADSf4yHE7240t64uUfgvxZbu6as21fnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PmX1FZS+YFRjgyBn416GiSR+T1CvIIn4sYnzmpxyY/ybSy6qqD2rBZx3kwEePG8vT
	 xzTjfRR0pp/lA11tVCB9ENs6Z7lXKdXgKcKnZE+JhYHqNjdjpGVqb5nHzRFsqEwmtb
	 dvxF2O7e86fRJSgh8dfMmKvlkPRURjNYUI5CNcaaCTbUURGWTAqdAOgu0Ogbtm5RwI
	 gcwfEo51qPPPEGN0AmJlM/tYdUNtEVzLE0MKqHgrCqq39GBJ5mtMB1aIWZyuDyV3A9
	 iTPcGTiro0GP12LdQDiIes8rYCJTfKTkQEYcZTiuFSrvIxgvaOU9WElIfqp1bmhAxr
	 gQsV8+ADvML0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95F7D60A7F;
	Thu, 26 Nov 2026 14:49:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 87020325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78D3A8112A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GvH5jjzUN1j for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:49:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B40A381111
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NiYwRVMM
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B40A381111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:49:50 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-8629ef48703so3830948a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795704589; x=1796309389;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zSbburWSEfcADSf4yHE7240t64uUfgvxZbu6as21fnc=;
 b=NiYwRVMMFreFg4y/tR/aCOQDE4VdMD3U+FH3vfL91TBwySf9sDrfEtFgpc1OKunx1G
 bEBuE2Ems+rZTvrF33XShmK4g4eNKTkRNQ4r1fPeqmSp8GdgL/6F+0e80iXczn03DAd2
 C9mDLfO4gFcoLwVfceqDvkzt+yHegcWh72rps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795704589; x=1796309389;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zSbburWSEfcADSf4yHE7240t64uUfgvxZbu6as21fnc=;
 b=xTQImZvM+xlKXqjjuW0g+uK6czxdC22b7fJp2qvpLY6XAhrQ3fgEQ2YOUaoDZ7HXZl
 TFLeYLNJ8pQZu3Wk53zx3PEK7pu+mhcn09E2cj+x+ebnmbDSArXxqasJJSdT0I5jYRih
 6oJDYNm1uRz56tZ99mc3fc9XRZM3lA9V6U2DiXXCquERd4Y16NGlNR7CBQnb4yHg7tqC
 Tm5OcEACOIFQdC++6BuYtu72Bv8e5CphO4j1m9kfGSObnBzBKPbWSOW8dJiCmbyaALpo
 1oS2M3LKekEcuXS6s2C0bW/mfzQe13MBB5No7zu2Qu/AJvp5WXLXi8+lSiLXfysJmB9q
 9dvg==
X-Gm-Message-State: APuU4Z8Zt6YltYvUewKTQdEjk1UskltgVpWjbHp6Y9H0vn0opwZXFyVt
 EAZyTHgS3pj+PsgpvxJBrX8ynZsNetsAWULaKeG4lHbe01mh+WGZIqt1bYtPsWZBgss=
X-Gm-Gg: AZFdTZfVHBe9VIdXN0TnJFZbOnAHvGl+FFOBfMNckeaNqIeX1Y8/ul4TATQEO506DFe
 sqIRsJBSWZZIAHs868OXU8p+9ChspLW4BOFIyVhHgT6D/D4zWelrFuThlNlNEp8aU+27Due6T21
 q/8b+z2yKncAM2dO61P/OYf9M+H2HhOZ2IXXDd8gKpn+ULLpcqhnSPJ3CILmpNI8387/VP2WyLE
 J0xspttmxntfwEuOZ1NwAo/r8D4GYTR/gTHtfOr1xMfUyfZVTS+GKLms+jNS1va0PC8/zPLBolL
 dwmUbJgkVkWgiqbyZB+OIvSqeHsZtC8hUSxp0P9rbK9sso5UefITPla/U92pJ4sVlCG1ZhH6084
 pEsSWfib3PTILqhPZ2TXumtLB4KmCSTh8pVkN8JCGNT8zct0xBgbBSGOlY5uIRYzC0laNowSWRu
 LxX2CBgXDn2NYBwmDW2cx6jSL2ErSaZxYwpb1+sDxhrA7Ksh6/kcglbXa31KWjxysfHL6YSFSIq
 X8whToRb4OhruE0AAMmr8AsP4I2N7AdkZNv8wJcmNAtPT/7QtQGdq/RTM/+kY14+dw5Tn4OmIEB
 5H+yyW50dbAVYKrYfnj88xOSVPBIHY559tEJCPhI9qVEs7KogxvZr8eyAxKOKhWubnNbWPm7Cvu
 P2IrSpQJrb5EsyOySJ2wyd6uJXS9rcMwZFxvlmQCeQq90UDQSVuan72eNCP1l1Gmo1mUQnlDRiZ
 q4bMORSNVUd6rORQwZA9uExjQu2lw75V8=
X-Received: by 2002:a05:6830:2642:b0:862:cae6:db61 with SMTP id
 46e09a7af769-863158f56a2mr24267660a34.20.1795704589165; 
 Thu, 26 Nov 2026 06:49:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168dcf38sm15016848a34.9.2026.11.26.06.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:49:48 -0800 (PST)
Date: Thu, 26 Nov 2026 08:49:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/3] Dockerfile: Minor robustness updates
Message-ID: <20261126144946.GI3176972@bill-the-cat>
References: <20261125134317.2479815-1-trini@konsulko.com>
 <CALeDE9MvMg0o2jJUhMQjfej+J85n-tiMecHLo56WX83DJi09rQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IEFQ6PRyc5w0UgnE"
Content-Disposition: inline
In-Reply-To: <CALeDE9MvMg0o2jJUhMQjfej+J85n-tiMecHLo56WX83DJi09rQ@mail.gmail.com>
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


--IEFQ6PRyc5w0UgnE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 12:51:36PM +0000, Peter Robinson wrote:
> On Wed, 25 Nov 2026 at 13:43, Tom Rini <trini@konsulko.com> wrote:
>=20
> > Hey all,
> >
> > As part of rebuilding our containers for CI again, I found two types of
> > problems we need to solve, to make building them more robust. First, it
> > is possible that our toolchain downloads from kernel.org mirrors can
> > fail and we weren't catching that. Add both retries and an explicit
>=20
> What's the advantage of using toolchains from kernel.org vs just the
> default distro toolchains?

Portability, vendor neutrality and also that they exist for every
architecture we support.

> > failure for that. Second, we should be cloning only exactly what we need
> > when building qemu and grub as they are big repositories and doing a
> > full clone and checkout is both wasteful and can timeout. While doing
> > this type of change I also updated mkbootimg the same way.
>=20
> Similar question, is there distro qemu options we could use that provide
> the functionality so we don't need to build at all?

Not consistently. We might be able to downgrade to 8.2.2 (Ubuntu
24.04.x) but that might also be too old for some of the targets we
support in CI currently.

--=20
Tom

--IEFQ6PRyc5w0UgnE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawhHBgAKCRAr4qD1Cr/k
CuWPAP98cIh9v7eKS3ommgOVAu2KBfA0T7/A5Moj6FA1U1JJzgD6AubMIUKnJ5sz
zizr6T5SMD7vdiAwhC4aMZtsO8MtrwU=
=d6Xt
-----END PGP SIGNATURE-----

--IEFQ6PRyc5w0UgnE--
