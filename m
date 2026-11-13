Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA835606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eKQ6bfkA;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lDm2j+4N
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8B8440987;
	Fri, 13 Nov 2026 18:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JbImfHSoJX5j; Fri, 13 Nov 2026 18:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C70F7408F7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794595213;
	b=s/oTrWbZGqG4LYi3P2HHDfB+nNPUp0Q2RY1l/eYX02KAoQEB6iSyZ+TmSLT1JjWnoYls
	 iLAkGL+1AV/MImvns2709jvsQUGDqk33locqBMBmjNzt8jNEAsB/Cu7o5SvcJbasvJwuS
	 UN7MzsdwvP3gwF6jqH+0P9Xa1vgw3cGA4FCW89eHzyiX4TMspHTT3pyjJPoKF7LXJXTx6
	 XKdSbHMAYqCKN9VaJE0jH0n9yvz/CvCji93NSHEvHKk7OPeetaN+24+o8NSJcT9RaZnke
	 a329X5srAtWN4gNIK1Ap4FRlHYCFxPmRjJd5UusPLl/anRF5OXa3UjYoPIJWCsaCqEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794595213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UjKL3FhxU/1zuSrNrzkAWPOnSutloT3BaM8EJju6By8=;
	b=nYevEUpkzw1fwuEg2vXVshJwDHTv5MTR4WNzCbHi3CrrSuRmSX3BRgx/ihx1wiaoT368
	 C4QJoEhQzoVurTmz9NI7NlIwy4jek08cc+2Uw05xjceF9MJJsIPYPffjKWawQ26t63L35
	 LchF+dcxadW3BlTcwn+OsaE9yZY2BC7DOQdNV7+Ow99ycss5HqhCQ9kU5tgoBA705EdD3
	 YpZRc1frH/Uke1cxkB7TAPywvvRQ+y98liKvwuOb2GMU65/BUYY6hkQmeOmlM25bMjGUU
	 rtrzXJ+cqUoMzxpULla0D8eKLhpEyrDnUP+T/BaU8dIS8gCO7pQT+JNGrWt9UH6hqIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794595212;
	bh=UjKL3FhxU/1zuSrNrzkAWPOnSutloT3BaM8EJju6By8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eKQ6bfkAPvLzRXHy0M2E63RHD1nkmC0r4DkaBZh9YrVo8fV/MslD2mhqjo0EEdfac
	 QmUrQ438rjQvSARNTDC98tuzM/Ni8eUy3Y+s9uw9rQVziMGdbD9nszebSGIYr8UAIN
	 XAPTHX1DwKItEW6ML9CLvYDcBeOwXwbQXUbI+vCuJawnsKbZd4KDDxHdFGY++zVB95
	 95bStGQMJUfAs2cxPx1+nzgV4wN3QCyXLphg7p/k+VLFxXdQDrT4SKWYVtEMQWMoZx
	 uOant3rQe3EeH2WzivrIEPQ6hRd/MeOa0UUML1QixNPEpUyEgsXSIrnjAsgfcnV7Ub
	 IP3uquBMMn41A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C70F7408F7;
	Fri, 13 Nov 2026 18:40:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E1FF1A6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B99D60B3F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SX1YyEfqH-A3 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F54260653
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lDm2j+4N
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F54260653
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:40:08 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-843cf077f10so2815633a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 10:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794595208; x=1795200008;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UjKL3FhxU/1zuSrNrzkAWPOnSutloT3BaM8EJju6By8=;
 b=lDm2j+4NFnI6uTfzXobqXWHjAxU+YnsaI/Vz+mJiu9BAhEFuboUOB1DUkHbWqERsUZ
 zjJyp/ddSNm9ywRVmlTGHzHO5d7tnk/VtK1CDO3UEM9hig2qluNa4g2MmsnpqDEf7ukW
 ZmxUm563Ird5BM/JdGJJjmIADg01GFdSx/cq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794595208; x=1795200008;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UjKL3FhxU/1zuSrNrzkAWPOnSutloT3BaM8EJju6By8=;
 b=R8EQ8RIFmeWtqf2BHKNEU13GnScPCoW4L/TI0FvXmpM6x2marIVoxLVCA1hDxVcPGq
 f6pgWiNqLMP6c3DpYcJv16EsLROlAghEHJ2pyRrxk8oBukKBMUfvDrcKAe2/yAYyb64L
 PhJBn6UIWhVrh7nxNHiHqUttwuT4QG+CTS1y4jiKN/oTkNmpnvLa3Q6YuP2aNYJZFbq3
 A8ZoxIgVJK3wXgEB3FmZEi9fBLCFogKxY5LdLrO7lm5QyrtCPMg8Hb+Vc9IR8EdFT1+x
 xdoQMSBEFhTc/ZbYBMOqZ9nu1T5jqnO0KAfcuQ+L5Tho1HnhK1Q25TR7jnSi9f+VSDzw
 34WQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE3ghkSoozB8nyjJ79WTJoOgD0+URoaQFsoke6jQB5uSdcVNckdI3SfxtvTZfKFpFyEsn/JOQk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8WLsdMTv9eKAFcfcxCmjNnWdBcEAH/3+sG/Wq5QV+R28U3c8RR
 IBLHA2+pMKTQIB3XcWDZ/so6yVKBvr3ISXc73bPKnQOYEC9CbK/+ndIkJVHi6AowdBw=
X-Gm-Gg: AYBFou2suv+9jdt7zIhzcwVaZ2y8PvBRcVniKl/9vf1Ow3StaC81qExyJqsp6fuF7hJ
 4oMezeMf/r9yJG/QHGzvHCz0kvn6MhW2Vzd9zHgXbKHYFM1esaNLxTE3kNG2I6kLr2VtsBu34ex
 TCYWWX2lHw7rr3pXcfvqrRz4Pkml0C19UATrbtIYcIFvFfbO7TLZJhrAmzj0IdSgnu1CtPtwfXt
 iq/p0HXET5+bwJNlpBXcvP2HEC5tlif4p4nGSSI2hOyJvXAdpCJu+IXWDmdSOwwCKIKyQj55lAY
 b4lczxFSDn9uhwDmIL18itYJg2tEd3eOe4BnDnUF2OsvYAOpGFL5fIQTVWiwwlsOSHEHalitpP2
 0h97Zf76qJJLfSGH6VjO/bM88p5T/BZcmC8eV9unGVpRouGtwtqgaCp+yeN5oF3YGhCtQ9LUDlC
 aVWkB1A4G7v4XEKF77HQmx0WSpc3jCJTzF31mmMk0vSiKUochJ+25qEaI7nZ4yznYX3M6aw+Rhj
 s4EUR/vzC1dAeLRyI82OAKd3CYODe72UAneIPAZlLyScz8uQBWILR6lIPwwM4QdH5aVWOdqrshP
 ByvtFVOPRASV1E0GpvmeTwq5PhV3yaOVI8PxOZwNYrC9qPsSA3B86kJm1Hq12asBSYP7cgFWjIk
 zJsp925XXnIeVl+i8xLplzuy7smD4/kM5vcW9X2hg714lVsneCT1gVif8PpWTkOxxxjahkrkVei
 o8XdrL1l+EtsAwBU8Y68/3pJARIgJizhfD
X-Received: by 2002:a05:6830:4393:b0:861:551a:26e7 with SMTP id
 46e09a7af769-8628989981cmr2857449a34.19.1794595207950; 
 Fri, 13 Nov 2026 10:40:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862881379a7sm3362770a34.18.2026.11.13.10.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:40:07 -0800 (PST)
Date: Fri, 13 Nov 2026 12:40:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Message-ID: <20261113184005.GO554944@bill-the-cat>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
 <a2b6bc3d-db58-4882-9964-ae0a1fb218e1@linaro.org>
 <20261112163645.GE554944@bill-the-cat>
 <67e7e8ba-172e-4d89-b5ec-0c1c936f6c75@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EchPFlM0dsn0l9XO"
Content-Disposition: inline
In-Reply-To: <67e7e8ba-172e-4d89-b5ec-0c1c936f6c75@linaro.org>
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


--EchPFlM0dsn0l9XO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 07:18:41PM +0100, Casey Connolly wrote:
>=20
>=20
> On 11/12/26 17:36, Tom Rini wrote:
> > On Thu, Nov 12, 2026 at 05:21:36PM +0100, Casey Connolly wrote:
> > >=20
> > >=20
> > > On 06/11/2026 07:07, Varadarajan Narayanan wrote:
> > > > As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper s=
upport,
> > > > the mkmbn script has to be upgraded to create images that can be us=
ed
> > > > in the ipq5210 SoC.
> > > >=20
> > > > These changes are to address the feedback in the 'Qualcomm IPQ5210 =
SoC
> > > > bringup' series [1] to use mkbn.
> > > >=20
> > > > 1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9=
c6cf@linaro.org/
> > > >=20
> > > > While at it, fix the MBN version number for ipq5424.
> > > >=20
> > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qua=
lcomm.com>
> > > >=20
> > > > ---
> > > > Changes in v4:
> > > > - Drop sm8550 full defconfig and instead add a config fragment in b=
oard/qualcomm/sm8550.config
> > >=20
> > > why this change? let's keep it consistent. please resend the defconfig
> > > patch standalone, i'll pick the others here.
> >=20
> > I asked for moving some of these to fragments because that's how tegra
> > handles the case of N platforms that are defconfig + switching default
> > dtb (and more or less nothing else). It's just a tiny bit more typing
> > for humans to do the build and easily supported in
> > OE/buildroot/deb/rpm/etc.
>=20
> ahh i see, i think i missed that - apologies.
>=20
> i've thought about it a fair bit and I don't think I'm fully on board with
> the concept of having board support via fragments. to me they represent
> optional additional functionality, and there should be a strict 1 to many
> mapping from defconfig to board support, with fragments providing
> opinionated or usecase specific features.
>=20
> If the main issue is the world build CI, would it be ok to allow excluding
> defconfigs if they're trivial #include's?
>=20
> There was discussion before about de-duping some of the ipq qcom defconfi=
gs,
> and this is work I'd very much still like to see.

It's a hard balance to achieve. I was just now thinking, can we perhaps
figure out some way to take 1 U-Boot binary and a list of dtb files, and
make N u-boot-plus-dtb outputs? Or would that not quite solve it since
there's more than just changing the included dtb?

--=20
Tom

--EchPFlM0dsn0l9XO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavdZgQAKCRAr4qD1Cr/k
CoSaAPwNFnlBR9Nzrg4v93Z2BvBSR9gzMssg8kVEjV8XQhXBKAEA6A3VBJPlumHQ
/l6U8k5y5C6qgnVwklwD8ZpIdyZG3Ak=
=eIR2
-----END PGP SIGNATURE-----

--EchPFlM0dsn0l9XO--
