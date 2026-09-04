Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CAFC61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 14:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BAE540BD6;
	Fri,  4 Sep 2026 14:33:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ScjShRcx9DOG; Fri,  4 Sep 2026 14:33:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 86BF140B5C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788532380;
	b=a2Ao7hxYobK9Iqpm1OV04x0c3DAadA4NUBrEYfexbD38TB8MtleiaRYikpTmqtZ56Qq7
	 YQdqk42Bd9j3o/J3z6vY2Sg/g8yp1AG1T2oaEWiBMSYX8sWG4fOzxI8H/8u1Y4+H8/nHD
	 gmFkIqsEi1lFAYvEKVKrwaohOBBY0cAiK4MJ/rR0GzuBDhvhVYI4hjNwIt8Dp8gc63hkj
	 1Dcx/2lNMuT43vBEvoX9V7/KKssVHFAgM1cmQwVgwA4YShalZN9ur4opQ4rB/uZGHV/xI
	 sHWT8dK+LwNUTIATPezdgR78UloKOwoq2NVpIMzCKH4KDm9qhrwsORYy9Wuj+9HcgVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788532380;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2GFz2G4TvFAQmNfo2sz19Dj/yLOcHuLc2Pg+XpTGavM=;
	b=GDsolDi96ek2l8wgalD2t46ftxBdzXOa/gMmraC4q9O1kKVxp6En7VChPHfm/uOJOxkJ
	 l54BoXxEaszEQUbGs2hLO4/MgDbWRCf+ui9qrQ47ws89ElXRVmvgJDTeroJ0IV8+Ygaq4
	 GSZPO9NZfFEplux2U7aqfBrjqP2MBtQUIvwJTi+ZoNieyb+Mf0BE/HCUdkIlpuVLJrGD3
	 oDWXKneWA4ZMob/2iwfi9vx3IOS2psbsX0HbKRZXl5L0tVkLpiTL40NHPZNqdn5WTGMB+
	 T+B11q/pIF9TrllWnMjNkxIzEjVJEBYWgjkmOsKy9njYplpHdDHRDwRDDSlFdyEOt/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788532380;
	bh=2GFz2G4TvFAQmNfo2sz19Dj/yLOcHuLc2Pg+XpTGavM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aqpaIxC8l1ZUSps5uzUZMG/uAsonMD+mNgTJK4nkoZTqCIq8C62QlcKEZSdejU47I
	 9y4YXB4zIghYluWEQVbyzBqOqTPCvHmdgYh4zA27//TeK/A/26oBVwhlJ1lsnBcZP+
	 ZGu0sSrxX0ghoBX9D0blVqQXJybrpmHzyKdah5jwAac+WIqOm2IAz8CXOijVPv+zGj
	 7LDXyN2GT7Y2quaHIcIs+GLaVR0xHooAKP7hR1CQnt3TcRbdkPjYB7140Z3jqn3HKz
	 uMOD4AOZPb6BSbNgNXgwEVbL8QEtPM0fJTkbUnIIMbC7w2aA6yfzoLVPY1d1NsB1nM
	 kASe/w0gTkQ3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86BF140B5C;
	Fri,  4 Sep 2026 14:33:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D29AF2FD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B856260BFF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ER2hQ1Q8oB4j for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 14:32:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 05BF560BC8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788532378;
 b=jtDbC4heKMkVz14Xmqqju3LcSvtwCSEouNVyA+oWU+PxQA3qkpqY0k4drsmJmPY/AvgN
 yoimHip/fJDSUkGHCqI7+okViufxqvHibHrVzZkZ0POXUcGThjQC0nOQ7vAgXFFOLxSSe
 ofKgLI5QUgXN3XHB+CG+bQ4ND1u1xFPhsjQaEE6XdJtSodNxXJgeIvAs7WLIVYq7AxOzc
 Cvlzg3o7Wzwk0Mf/igYiP4/9AUed8mjyHvxo5e963sgmHlHtnasXq3WmfMJK574CJzbEq
 WdPKmWmS9GyO1oadwxgw/YkyQci925NuBczxQ4OOup0UVj1wrTuH5XzU1rG1fQmwb7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788532378;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=2GFz2G4TvFAQmNfo2sz19Dj/yLOcHuLc2Pg+XpTGavM=;
 b=nvF8/vk7nKhf5T4LPsdRhqUp75FkO0h0tlKiuT9LZwoI2KGdr1gHtCBqNnLCl/KK0gvS
 dgPJOaRAsl5W0LboQPH/Ou4hb4lPQXMSZG1n424TBl+ydlkIOjK2qhlVz8cfi0+mRniPx
 e1BaEBcYTRJ+IgihWY2YrlpKeNEBoXuoT3AurHrwTd5A5gfKYVJM/v8ncBu9Qm1NSNrbj
 BK6nM43nlX6mkj+BzCEwJDbSmS9fLAaqufuoWk5irTEq1vJ1vXRKuR4rwI5IGxR+DW/lm
 ARIz4nihXEajDUG4oqdHADsT3irUXrp/A9njhOr/+FHjaXxEV/OK2NbgjQfciBI/gAQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bQo3fybH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bQo3fybH
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05BF560BC8
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:32:57 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7ee4f241f42so1821020a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788532376; x=1789137176;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2GFz2G4TvFAQmNfo2sz19Dj/yLOcHuLc2Pg+XpTGavM=;
 b=bQo3fybHkoHZwacOu697ht9pakgx96YqW4T/4mf6vCkIPWvhhq5G9R2YIevmKn997c
 PQCCCUCWJasCNj2WbOs/YcaoP+p1QeV70RSudpEmhZC4R+hPRa3mbrTIebucD2DmPCEF
 4/UDW3NkDgp4DkzbSEyXvuknImJ+erLMJq0zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788532376; x=1789137176;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2GFz2G4TvFAQmNfo2sz19Dj/yLOcHuLc2Pg+XpTGavM=;
 b=OHOYEYD5knHdhn32CHkpU5JSEo8gJVaNhwioxNukPLAOftcpVtPOpxqkBA9cB+1t3w
 S1PTFsRPIMYvUb1c+5lQDqXLCt2vqB2FNOUyXV+RQ0QOX99CLBP7Sq7qJ6WFInH4WMZV
 iLFvj6JfM061WG+QpzAEa8AkMvvdONsA933A0rJ2YZoNStxxNlPDuDCcaY0WmpAkp5/i
 VNJStzJRmWZZoBkGXfTbfsb7mqpIcrGdPGpsYgvmFwrjQFSY6SOSvIUToqnHmNzP+XgG
 lwtnHf2NYj298VxS0wOJuf3afvSgwydbEN0C1Y5isAya2kWqsVZtFKJQXa/SlX9Z7U8L
 sMgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF5STmVAMlXWL+uPbd7KsesJRkjYAw8qPVEzJV+bHhaORhfIWP779cypFXQdyACI7dww+Zukw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kmudLlRTgt6T5EqSIql41NNVfM18HotV73acAocHumc0QkqSo1
 tb+W4ygnU5by07lmC2wSHrAicoKSG9TJI55cvpTmeTOysVd82x782JURzO2LqhTfVHg=
X-Gm-Gg: AYBFou3I2PahRMOmZ4bP7lXtpxnrYxk0H4cUnAAeMCKTgsLucsNJy2Jz7A9p5A/suQm
 FSx5NUdcrnL6xIqQ7+pugzjs1dno9eefD6KyboSzyXwaSWbxEkuLV5w8cJW5kyVAYydYw9eALnF
 sHshspPnQw9ssMDCrPTX1GKws70bA7y60H20T/77OwIJeS75Oz9UDM8lmjz5Sr3oC3Z7DUsCqZZ
 jJEPbJnRmPvieh1z6RNmhx8MExDX2Kl/8cDiGSAEcFSL1adAt8D8N/k5qDbCHNvfh23MA6VMKUj
 JXICBc3fpnZ2XBHxVbInWdO2n7KwlVsFfjE066ohSRfJWFfNl42gjF74GmFbrvBo6Mex4fH8+kV
 dwMJL/ud9waNMx2K/jH2m5snHukQGnlOsh1UjjDAlqYaSdP8FQV9ET+ptudb69KmpxipGqJhECZ
 JAcbbELv2ZQCvpfnhUeAdTXzOAT3FL8sWWPjsWTTVxrqhym708f2n5VW21DuRCbPSTRMDUvr7IP
 cKv3t6Un6YUkR2BZ0rIEpnCH801B3v3b5ChII9A7meUSnLkH7Gz2Qvyvt0071ZDCYfzxHdV2GDr
 lQmygTy/VN4YdBhvxJigXPc=
X-Received: by 2002:a05:6830:3591:b0:7f4:d6ff:230f with SMTP id
 46e09a7af769-7f8969e9ae0mr6316303a34.0.1788532376249; 
 Fri, 04 Sep 2026 07:32:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f4615a20sm2805159a34.1.2026.09.04.07.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:32:54 -0700 (PDT)
Date: Fri, 4 Sep 2026 08:32:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v9 00/15] add software ecdsa support
Message-ID: <20260904143252.GP1764417@bill-the-cat>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903183521.GL1764417@bill-the-cat>
 <9c0d700d-04f3-4ad0-9453-bae0dbe6e471@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XW99Md+TZSBoHsbp"
Content-Disposition: inline
In-Reply-To: <9c0d700d-04f3-4ad0-9453-bae0dbe6e471@softathome.com>
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


--XW99Md+TZSBoHsbp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 10:10:24AM +0200, Philippe Reynes wrote:
> Hi Tom,
>=20
> Le 03/09/2026 =E0 20:35, Tom Rini a =E9crit=A0:
> > On Thu, Sep 03, 2026 at 10:16:50AM +0200, Philippe Reynes wrote:
> >=20
> > > This series adds the support of ecdsa with software
> > > using mbedtls. So boards without ecdsa hardware may
> > > also use signature with ecdsa.
> > >=20
> > > To achieve this goal, several changes are done:
> > > - fix the support of secp521r1
> > > - enable support of ecdsa in mbedtls
> > > - add software ecdsa signature check using mbedtls
> > > - add support of ecdsa for internal fit signature
> > > - add test for ecdsa for internal fit signature in vboot
> > > - add support of ecdsa for pre-load signature
> > > - add test for ecdsa for pre-load signature in vboot
> > > - enable software ecdsa signature check in sandbox
> > OK, so it's enabled on sandbox.
> >=20
> > > To test this new feature, just follow those steps:
> > >=20
> > > 0) build u-boot using sandbox_defconfig and adding those options:
> > >=20
> > > CONFIG_ECDSA_MBEDTLS=3Dy
> > > CONFIG_ECDSA_VERIFY_MBEDTLS=3Dy
> > > CONFIG_ECDSA=3Dy
> > > CONFIG_ECDSA_VERIFY=3Dy
> > >=20
> > > 1) add a signature node to an its file
> > > 	signature-256 {
> > > 		algo =3D "sha256,ecdsa256";
> > > 		key-name-hint =3D "private-key-256";
> > > 	};
> > >=20
> > > 2) generate an ecdsa key
> > > openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.=
pem
> > >=20
> > > 3) create the itb file
> > > ./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file=
=2Eitb>
> > >=20
> > > 4) launch sandbox u-boot
> > >=20
> > > ./u-boot -d arch/sandbox/dts/test.dtb
> > >=20
> > > 5) on sandbox u-boot prompt, load the itb and launch bootm on it
> > >=20
> > > =3D> host load hostfs - 1000000 uboot-ecdsa.itb
> > > 4628674 bytes read in 1 ms (4.3 GiB/s)
> > > =3D> bootm 1000000
> > > ...
> > > ...
> > >     Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK
> > Does this mean the new tests aren't run automatically?
> The tests for software ecdsa are added in vboot, so they are run
> automatically.
> Ecdsa signature in fit and ecdsa signature in pre-load header are tested.
> This last paragraph was for human being, to explain how to use it. Sorry =
if
> this adds confusion.

Ah, OK, thanks.

--=20
Tom

--XW99Md+TZSBoHsbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaprWkAAKCRAr4qD1Cr/k
CnfYAP9D92YGYMO3A7ajbcdAuZhl50hqH+QBQNrSRtxoeUKyNQD7B481hms5023b
AXycouYG/JlBhmgZY0bJYgZ6Nmf6gQU=
=RPSl
-----END PGP SIGNATURE-----

--XW99Md+TZSBoHsbp--
