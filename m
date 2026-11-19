Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954D3606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nCX7yrQj;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZxZhfRTk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A1AA60E17;
	Thu, 19 Nov 2026 20:09:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jit5Z7aZaXEs; Thu, 19 Nov 2026 20:09:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C063160DD2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795118971;
	b=V3nvXN4bxNRKf2cPu41U6qDBej7/RtUYIDkAziZqJHFLbEC9EEfKFjfp+1OA2fZJdLyQ
	 x1Sn61PmLlOFe2JiuXU+MFK8fniJ1oJu1iFfnvFzX+g82njRW/53meS3UvvWDUdKd1Slh
	 AmRUIjZh6t8nSCsdGVQ6qlKXzsB0i9q9KVHYig8ShChrNQHE2kb/bce+8+weU/pbls5SJ
	 gTgwcVBJyI0sQHZvf/Lpg5rKEmGnKiOacHLtsGSq5nXEUDc0SHqaKDqRA+36x8fTv8X8j
	 ZOoPmMoMGubcwoi2QNjPJTC7l2OSExCZN+2zV53RbGAunNRuBfCLK2HAVR/WP4QXvtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795118971;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tnmgcwk2kfP4oVel7LImpVGpq4sk14l5OrnnGce+EoY=;
	b=OUkY0AZw79+YPNt2AJBzu+KmJQCmPDeu3m4Fd595LTagItq9mbwOIL8mMCVATUtx5mgX
	 K/OLX9hjzoUCxZNSRutvoqN9Sc1g2OTva5Clcp7RyctdNLNR2OUadiwtFAjo0lMAYyCZ3
	 FmuypXXvdhbi0/34wdfgRAptYNf/u/QLIxAOzmstHtGnlHLE1FfNUWkpMF+uzydiMQy9+
	 avohaaJUuI2S5IzEIT4pNRt5iaL8P1eQ5fP9sMueHT4j4kQPYCMNo9kdfdA8UALlKcfAR
	 928B+ARya4U+beDFId00HIw8NOsssAsTU+bPoq+/Vb8aSpFo0QpS/vDB5iMDgXFRPCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZxZhfRTk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795118971;
	bh=tnmgcwk2kfP4oVel7LImpVGpq4sk14l5OrnnGce+EoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCX7yrQjBfM2U8YSeJ6g7NRcZ78njGISPHQM65acdA53PYMLBW9tHWbX79kxZ2jys
	 gBrW4/vS0aN+vFwiky9hDFeQXJzAWAOKktz1XxXAY304G4I7yud8roAcrderIumBtj
	 fl53Itv14elyJ7l3sV/yHE2OtIh7H092H0ogePgAiMztLdx/AIOU/whxrtfb9L29S5
	 y/DRVmckY4wkYSiSF5eMwtj+e1LiV3Z2kUOQJJYu9IZQH5p64LVtZ+1Dl1VWXSn9DX
	 IiRa81fkPvCmeQ88cngqCkjhMuZK+rKOOOsNvPYVcQt8PF6sT2T0FNRa2fMni7s+Ui
	 oTM7HPefvA8Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C063160DD2;
	Thu, 19 Nov 2026 20:09:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 809352F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 20:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E06760DD2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 20:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_I8wDHzjVNe for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 20:09:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B272E606F0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZxZhfRTk
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B272E606F0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 20:09:29 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4af81963f35so147923b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795118968; x=1795723768;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tnmgcwk2kfP4oVel7LImpVGpq4sk14l5OrnnGce+EoY=;
 b=ZxZhfRTk39QQ8tCzAjJsAaGiwM5QuV+6kIf7kL3SwYYfm0Jg79pivuWqUMdmFKHU2I
 Sgell2Sr2SCoijEIaglk8zOml4nk37TxPbO+HQXTB2CrJJPkCS0wu9PZ+CAtPv+RJfOz
 KUX0r6Hdi5kLR/iAIwLvH2+S53Ez82Ze/6Mno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795118968; x=1795723768;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tnmgcwk2kfP4oVel7LImpVGpq4sk14l5OrnnGce+EoY=;
 b=EUGcpeAkAxGKozxBl+k0wS69xPcrRcHy1iA3gZFMeJQhO02YzEdL7ogerv6Pz4eqYR
 h0z0z5Bke9NyETM5XidhlID28Hv0iXUYb8QyLGIHr5nFw/3iR1sJ7WfzePh6jko9f7Df
 kcrshjxkLJ8hBCjWjQKSRxrRHliW0/7U+Sx8ydUfkD26d3B9xAuzFYQV0CejpXqsLTjL
 fB/qlauGNOBO7WG8ejGtWrh7AIBvyTbI9Gdd4Z8LUcNtnXW1p6G5u8m0YFc+KnGeurTW
 2Lk1iP1oXrYF1/RFyONz8UvoUY0pkWn4rbu7dEmY3dyAuskvv1aJJQjnsPMCFUssCrgI
 jF4w==
X-Forwarded-Encrypted: i=1;
 AL+hErHHq6nCLQLOEj73yPbqj5Z+93VyBFY+ecQwBG/BvDWuOTBPfcyl7sHGdoW6YHVijzDuTYdES/4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+tEuyTMmYXZo+iKdhgDSBXLrecWFqVhc1fnbdrzWMArLN1PHkR
 rRa++lMaT7SUZvWg83QwGthKLEP4WTeEpq5aB7UPoNK04cfsBno3bnch6SngUWcev7k=
X-Gm-Gg: AYBFou3swJwWYOryMSwPxllDBRJUs6zxb9inssWd4qocdtdye2U1JW+FOEo23oIClpC
 3TI2Ljgsv9z3n7dJYaqH8Qq7Po8av3f13QRDUjpShrmHrj30PX51Gqg+Pd0rA/KhHcd2qLZhEs9
 b9PaouwppCy2RmqFjM3PyiPh1KxvV3pk3ySMVdICePfN33651XSzSwtItks7bGGzblbTbDRyUx0
 z2sxd43OTFA4X7Q57egcDB06MwwofOBWcAequpRFC1y0sOO5ts2YP8o8H59JiuiJJFJPXjZYeWE
 FxTOnqPT7onECK6WCflMlkYaZKIsffovbci58Ph2vxJnmWvxNLJ1aTXWlfqKk84bp223OHt0qVi
 Ynu+ew8XqjPuFSV+odRgz6hjdqPFr6fBXVktROaHimnTQ2mKX5AT/xvMhyt5PCbL0oNqC7U5DfQ
 OguyqPu7y8OeoUUSB0Jwsve/jXz42N0uFXeU/ydmpvZDzj+YAFSwfOpbCb1NrgVJvr8zfXwputm
 3FH9biHsjKdRdKQJzO71FaqnB6QcVfGU81qU6NnJYefxUiiGkb2l5crCNe9XpmuB7DTYNHdppnw
 NaIVg2CxTYvdqmrCYyb8dIxXXVz/VeTlSg3XJzW+0jrKVIRDtIeE8OjTRVBXRBXDzSLShIFBxbo
 2TqylvTnq+xLHHPJbEYzxFuii3RT6ji1yQhHSn3LYmh7RWswJzX01TfnoDxX5eCG1kfOcldaIVO
 AthKW+zm1uaKgjgrTSLyYLhrJmOGcL/32I
X-Received: by 2002:a05:6808:13d3:b0:531:7f68:842e with SMTP id
 5614622812f47-57a06d1a865mr1151089b6e.8.1795118968392; 
 Thu, 19 Nov 2026 12:09:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a35655a5bsm361917b6e.13.2026.11.19.12.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:09:27 -0800 (PST)
Date: Thu, 19 Nov 2026 14:09:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Bradley Morgan <bradley.morgan@linux.dev>, u-boot@lists.u-boot-project.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v3 04/14] powerpc: lib: Add 64-bit division to the
 private libgcc
Message-ID: <20261119200924.GB3176972@bill-the-cat>
References: <4EDA2004-7420-4BE7-BDD2-B71240E69107@linux.dev>
 <20261119184244.68936-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eqaHOUJNSYRkmFnY"
Content-Disposition: inline
In-Reply-To: <20261119184244.68936-1-pepe.schlehofer@gmail.com>
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


--eqaHOUJNSYRkmFnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 07:42:44PM +0100, Josef Schlehofer wrote:
> Hi Christophe, Bradley,
>=20
> On 19. 11. 26 17:01, Bradley Morgan wrote:
> > On 19 November 2026 14:21:14 GMT, "Christophe Leroy (CS GROUP)"
> > <chleroy@kernel.org> wrote:
> >> Why do we need __udivdi3() at all ? Can't we just avoid / and % on
> >> 64-bit operands and use __div64_32() or equivalent instead ?
> >
> > Oh yes. That's right. What's the point OF using __udivdi3()..
>=20
> The division operations originate in common code, for example in btrfs,
> squashfs, and mmc_berase() in turris_1x_sdcard. All the instances I
> found use 32-bit divisors, so do_div() should work for them.
>=20
> I can drop this patch and convert those divisions in v4 instead, if you
> both prefer. The downside is that another such division added to common
> code would break the mpc85xx LTO builds again, because patch 5 replaces
> the toolchain-provided libgcc for those builds.

Please update the common code. New breakage would trip CI and so that
new code would need to be corrected prior to merge.

--=20
Tom

--eqaHOUJNSYRkmFnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCav9XaQAKCRAr4qD1Cr/k
CrmxAP40kh4BZaD1lFCRhnpRjcZerecSZVF1Yb+y5aYLQdks7wEAkZrXoRwOT/r3
fpGZjFqEaQPJeMWkTmDd745NlHdjFgs=
=AaRq
-----END PGP SIGNATURE-----

--eqaHOUJNSYRkmFnY--
