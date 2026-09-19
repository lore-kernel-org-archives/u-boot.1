Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B09C982D7
	for <u-boot@archiver.kernel.org>; Sat, 19 Sep 2026 21:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97974810AA;
	Sat, 19 Sep 2026 21:38:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AuyxTqOOofhW; Sat, 19 Sep 2026 21:38:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D2B00810AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789853904;
	b=YgHTEyUgKy2cRYAPJ43d0Nn6UzAlUuJQFkVqJhApDa7J8nEblaj2lgNHAUQlMj8VIjRW
	 rjF9EP85Q38lazRCY5UH2dCppSVRFI++cPNdX6m/tKmCsBp4gpv/SdLXh34SkRfwJgDhw
	 OI8MWt7xGlurpBbHnKa9q+3uu29CcNt5vxfrqWe/wSMTqQHelnoJNdJViDD0zGWTY6gc4
	 WkUwHSVK8jKZazJlv1LwFtvNdgX9AH4g4gzA8MWYH6P5368ZkIgoHMhTJubpmkH+q8WrY
	 nozcmc38UA7PXwrmXOJS9NovTdAoUkM8O0MBg0YiILS069QUxuVRTK+ZqrsNGhln28w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789853904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4F8M3yPuNNuDevIHnhV4YhtANxFB3XaHQY/Ytn0MkuA=;
	b=FhAAUSEMpTT6nmq6B2qXp5IBKKlF4zpWCbdwYtoGTYEPyC/sk8w5wQNrADSZk0JMjORZ
	 fmshq0SEzoGXONJDXwJZOrjS30Vk5vRfAXiDNqk/h4nyqVEEn3ruFzWvhijQBcOf/9Gcd
	 ot2tdQmuzQRm292kgusXQX+V6pCmWa5WBuaeyPKdt+O6pMN9daaefT77RuiLZrEY17RbI
	 pxnxLvPkxUr10UdM2cq3HKLk7//M+j2hCC5Fi9vqRnBvtssc826qWV+muqa9U/fpT/aTx
	 PpuckU4Qfrma7GH0sB/UIKIV0+O4lOrBtJCcv24kWC3BeSJJs+HaLjCdP1xxjGgboEQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UwUYJpvs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789853904;
	bh=4F8M3yPuNNuDevIHnhV4YhtANxFB3XaHQY/Ytn0MkuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y40vzkzeTQBDNypgc7TkJ5JjxpO4fVf+aGRcJwCLmIUCl+L/ywSgc/2GK5uylZnSY
	 heO9AePMsX9HdiNzGssVP1UybzT0uXo8izvlYzuE3irFzhEo0HcFW0dBMwhKd6U1BM
	 DQps0sTADbhRTDv2FmK6O2hewpxEg/e6QSsTKxk51836AcyDxr6ELR+yEYHtavadZn
	 /ZP5tVxYQJtfZcLJUIdTkqlIqF/FQsNrc9xuKOgruhrs+MZVZHwUh2jVONcsm/lj7Y
	 +K5Z9vrva1EHZOuk0uqJFBNKc3Cvcmdd4DOKiWJcVggUXizBSDv2k9wmDs53FsssL5
	 QgtUj9czpgaMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2B00810AE;
	Sat, 19 Sep 2026 21:38:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04BB2422
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 21:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA3F0810AA
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 21:38:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5p7WbbTK3dI2 for <u-boot@lists.u-boot-project.org>;
 Sat, 19 Sep 2026 21:38:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2BA0781094
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789853902;
 b=guWreJqZpImmeFa6kpXZagaYRu/gZ4dlWTGxG31Ubbeg59BUXx8IuMfSebxgunnskAi8
 SxbN3Shn1zCVMXr4TCv92nRm9W4WwUzBaikxzoXnbFx41LFY741hY7MmJTduf5aWMYTTP
 aHbjIkXMkMcyIU3ANJbwgRxzmxsQJYe4UJVRfnCoNDLxXDfv4h8M3eTAyJQWHyQcq2ru6
 X1y2wxkEuCtR5fpnW3rD4FtdZkS3UaiCCAOkK2sSj86dD8EN/6211gmmLnHmOe+6vjevz
 Wd2qNTT7BcYeiND6jmOjwZiofQ+VYyAUcimBI/bNatHxIdww5gru/f1Mtwti7GbDNqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789853902;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=4F8M3yPuNNuDevIHnhV4YhtANxFB3XaHQY/Ytn0MkuA=;
 b=B+b05kwS0skGUfznw0xn0MSkIrkA1h6Cx5WI/pEaw0NBS5VKD1VgZ+KxVuY+a1U8zaCH
 qRCOKWrkGQ+Py153Qk5A8HCkkA3sYwnjkwrvy+VGg2WXo3H10QPqnhWKls0dz2CChm1Wm
 xOnWLUFuo659lCxKevvJvC5Ph/ScdtrE9pSDNrTgsIex/QFFm7V2iCWjPiMOGaW7CE4pW
 +6cy3kBP4qGAQVwxBwuXahRJmNl2+oUFLl9O742XF89KHwBYud2k7MhTBZlfK2fUdem+B
 cU8nemjFv88m2HksWsNKbZmAKqZDfNUhOhKn9lFkyH+AKcuarOXqxfLzsabw4eeLFpA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UwUYJpvs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UwUYJpvs
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BA0781094
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 21:38:21 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-805c194bc92so1910856a34.1
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789853901; x=1790458701;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4F8M3yPuNNuDevIHnhV4YhtANxFB3XaHQY/Ytn0MkuA=;
 b=UwUYJpvsr2B3hb1fZ7WZOLdkTjRxh4SJWQoWfUP33S6lDm2MoA58N3RVYBTh+BXHRi
 WL5y9PwwIEIA/VA+YpJJSd3mz/iZaSWG1N0hyqe3rqbwRnqokcOEBGu3jQbncmkEUd4A
 Us/Yz1tFFuBXYWwmIgLk/QcqlQVrMYE9h4CWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789853901; x=1790458701;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4F8M3yPuNNuDevIHnhV4YhtANxFB3XaHQY/Ytn0MkuA=;
 b=mXHQiy4czur1GGf0nPybH1zldHUzOA0kTlO2o+fHbrq8/FTwou5Dm0NaPlM7+llZww
 8UHFHgY5G2jTr4zj9C1F/1gLeNNdH5snhhVACpf13cMqlccsu53KHCVpp9c0MVNgtrZi
 Q3dRCJ0E8NYzQfhj9d8ZWGs6EYi2pL27zwzlsYAcgmw+rUBStEgvXHkor0GAo2fuKkQi
 z0JJ4fZHXtbxsez/PygF+QsmTrF/INrlpjGwLEazAd3HSfxCQzFBZ2qpUF5tZXRX3Spq
 XwdGKE7Rltl+OIqZA76KYm0sToOaj9GHxVjc24fsWrx927HNMTuRgfrifW7I3wyzz8n2
 4hTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzODlXhD/78AVeVFNrfEYu8fzpiqBT5RQcImot1onnWDaxLutOD4D5Kmv7iG+ulTkw2eJqiGsQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mv2sGtISf5icQgL1zVuGslnUt3OvZ9i5PApqJW3Kx6z1qADQXH
 5V60F1IHJ3MMozOhwiwi/JcAIWvqZIpRNQ2pPizBtrCe6PtPnoFtoyFI+z1dHZHjr/NOEM1rhf6
 5fdCwwb0lPEB+
X-Gm-Gg: AYBFou1gOSlq+aM/bJnEuHVNFX5EFTOuT6iefwy5aK2+B8OeMdmC/4iwErBAxQemoPn
 0aSKQt8Wyaftll/Nt73SSS+GR7WZeUGVZuGk/DAO6zSo1gpWtWXNLItyvn2WX60/bTJJoMZB+fL
 Kef6jYG/dBHm9GGlhDXZEkpdYZjkUqT2xQnU9HDTF7bchVPmF0IGERTGo5YupqlBir8mfraWIgF
 P1sUbCl3IpqO2YbX9po/IEZwfkgQ/emohHvFwJ4JpU02pk/MkxrP1uiYFrYT79Q2cYLqHAdy4M5
 LN8ThtxHjlj5tS9tDSZ55r9v0bVzjb0KTzM/Pc9k7pFoH1a8pIwfzjYnGhIPzsuytNtXTyj5eiC
 CvI2sKnBPm00IuCSFhj1TQNtAL0g4qZf0JHSQ6EQuHu+77YT85Wk6DeXDrjAePtYfH6Ur1C+/Af
 RVAyiATB2fyxB2pRmc00d2pyJyHDPH1OcGI5wLmp7S+p5Ph1JEujqjlaEs7rGc1W5M269r+Ml3M
 GreSz3MgbxriAYOJAJszEaC/P5n8Fna8igI6TFIS+Q6lGtDToATVDfQEIntyXLZHAkgMsiV3mRB
 3ERYhsVk97uDGdbA12o=
X-Received: by 2002:a05:6820:168f:b0:6cd:3fdc:5ff9 with SMTP id
 006d021491bc7-6cd3fdc602amr3112815eaf.74.1789853900535; 
 Sat, 19 Sep 2026 14:38:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4881f4d519fsm3410450fac.2.2026.09.19.14.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 14:38:19 -0700 (PDT)
Date: Sat, 19 Sep 2026 15:38:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Han Gao <gaohan@iscas.ac.cn>, Casey Connolly <casey.connolly@linaro.org>,
 u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH] cmd: ufetch: avoid truncating storage sizes on 32-bit
 systems
Message-ID: <20260919213815.GY858934@bill-the-cat>
References: <20260919-fixfetch-v1-1-f1e8b54d8a87@iscas.ac.cn>
 <A6F0EE08-626E-4D1E-B5ED-E5F3198C846F@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+ku1V2/3RmEeKkk1"
Content-Disposition: inline
In-Reply-To: <A6F0EE08-626E-4D1E-B5ED-E5F3198C846F@gmx.de>
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


--+ku1V2/3RmEeKkk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 08:29:34PM +0200, Heinrich Schuchardt wrote:
> Am 18. September 2026 22:35:33 MESZ schrieb Han Gao <gaohan@iscas.ac.cn>:
> >Storage capacities above 4 GiB are truncated when stored in size_t
> >on 32-bit systems. Use a 64-bit accumulator and promote the block
> >count before multiplication so 32-bit LBA configurations are also
> >handled correctly.
> >
> >Fixes: 86d462c05d57 ("cmd: add a fetch utility")
> >
> >Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> >---
> > cmd/ufetch.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> >index d4b54f77b7b2..29ccbf654a4e 100644
> >--- a/cmd/ufetch.c
> >+++ b/cmd/ufetch.c
> >@@ -95,7 +95,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, =
int argc,
> > 	const char *model, *compatible;
> > 	char *ipaddr;
> > 	int n_cmds, n_cpus =3D 0, compatlen;
> >-	size_t size =3D 0;
> >+	u64 size =3D 0;
> > 	ofnode np;
> > 	bool skip_ascii =3D false;
> >=20
> >@@ -221,7 +221,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag=
, int argc,
> > 			ret =3D uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
> > 			if (!ret && dev) {
> > 				desc =3D dev_get_uclass_plat(dev);
> >-				size =3D desc->lba * desc->blksz;
> >+				size =3D (u64)desc->lba * desc->blksz;
>=20
> Shouldn't desc->lba itself be 64 bit to allow for drives larger than 2 Ti=
B.

Likely so, yes.

> Why do we allow CONFIG_SYS_64BIT_LBA=3Dn?

It'd be interesting to see the size growth from that change.

--=20
Tom

--+ku1V2/3RmEeKkk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq8AxAAKCRAr4qD1Cr/k
CrNrAP4qs4OaaPxiz9be8WGGpSy03fOQ1u5vKT02SGH0UsIpwAEAyRES5aPmo1MX
CI9ntS4erqDySUPvsG+0h6dwPQDb4g4=
=7+Tt
-----END PGP SIGNATURE-----

--+ku1V2/3RmEeKkk1--
