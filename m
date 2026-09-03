Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10590C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 18:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4B9740B1E;
	Thu,  3 Sep 2026 18:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7sO9HrfUV1d4; Thu,  3 Sep 2026 18:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 01E3740863
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788460528;
	b=QrBNEX3RG9cugddz/e1cw8du7dKgVgEoQGs/F8oooHTkMDsflw/ua2tOhjfzN+9p9HfI
	 XDhApmjfQCuOXasYiMxrfNFkRTPk+ZgCUEYGaLXN8CGm3hzTsF0gJmvq4yzE5fArUwktc
	 SMuSwSe3z25HjPFGXHQnJJ7b7lRoCeNV7k+oc/7bECuXU7Oewty2R48x16FKuiKqqHrYM
	 Qqgayqhcg+PzlUL0SNMNu98ERyl5uBYQahtJhv90bvay0MpzbMnMcujeYNzuGC3bbR/V7
	 vm+zvjuNQU62aMe2d3to1ZuwZUvci22ntD+meMvP9P29g03806iwrD9vDdz5tOyGedA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788460528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qJ6YBM6gg6KDgMC+s/FlrQsEzMGcde7WiAD6E1gX/qA=;
	b=TKilOJA8oUSQJUgYEVVEfGG1vTAajnVeMpNm+LgEx4UXa5jfOMPMWMBM08FeNiLIlWBM
	 04IJsn2K+cbfH0DmSIEjDcbqswICKSdYwWDaa+y8Mh/KAMXbpJIdA6t/hsv1c0vmhwFdZ
	 biCEKvUc5LUTOuefkK83XFuDh/LQrUf5OmbH3KCcbBwKBKOdQvmYbkEuEtsHXbYW++uBf
	 L2HwsivQu9YVbhv0FEmLJ3Vvta2OPwiH/bHJ3jSJCt+oRzkgdFaT4ErXA275tS8ihsIeI
	 dQ7JNO7fePFCf37Mcynp/6IKyNLT2AXITn/RYrmlUxtWGDZYcmOPj3BrL2GjUIWj84w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788460528;
	bh=qJ6YBM6gg6KDgMC+s/FlrQsEzMGcde7WiAD6E1gX/qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q7ECIS/Kab/9QJ8TLB5cVoahrDoGTtYie/C3oB3N4NQKR9h/eVvdN0AfcV8wv6cjY
	 HlfiTEXPv3c9se9YdGfeWei/DeyaYKNN9VTqyYx2I6JK1HfvUZmPyf09QP7aaCDvbd
	 B7SwcPA4EMdI+WqM8Rv09HSV5KfYPQ7pnn0X61zrk2veyUmDtVwKgHtQQ5ySmCjPcC
	 knpT0IKgwNhBJzxFV/t+tZMHVgAWihXKo6936TYDY13Fw7EBLUJwYT7eSALbqOqid3
	 9Zekh0N+FQ6c5bRobycDY29G7u/maFAm4KrDMhWXGFo5w43WuTyw8Plksu1LYORDu9
	 3oiV998b35iRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01E3740863;
	Thu,  3 Sep 2026 18:35:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 705FE279
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 18:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56E3A60B64
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 18:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CRb-lXbLfd4n for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 18:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 96EA760616
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788460525;
 b=iccqu2QdmZAyE5dBHk964NP3bI46/eP0VSHSUXcJa8F3GwNutMHUuBwzEEJuA60TOk96
 8SgsdMe+fD/00Fp9kULfftO9e40JhYEtMwp1+kXh3+4Axe9ZvuRN5ooevmGAVuTBmt/b4
 m3XtbAPqGciaYZJ2KL7fpaK0MEgg98O2q5XiUT8+dNd4AKSqUpb2X/Ev+EOcRGl35XSYp
 raHm07QbPmf31UX8gmuCcQfERQmySsHiCBoL9JW1qfB8BsDUwJGlU6OvP3MRJW2tnrEIJ
 7aPEhD3wBOoohimt7anbtx6qrWs0BHlgJChFGL1+aNlH1Uagm1zrTOg36GYLkharo5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788460525;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=qJ6YBM6gg6KDgMC+s/FlrQsEzMGcde7WiAD6E1gX/qA=;
 b=DQNAnYIpRVu38Pq57JwC3w7zbphiMoIckguEKV19jUUuiLd5Sp3JrAN+kS0i0NJmM6JR
 ueEyyAK6Ur9N153R0AzMgHS/C6Ghlk/ZTlrSJec8Ioex2GmryPeKTVTLW0+XLfPjT8fus
 grI/lv2JvSR6AlvvJ+fxPRuIjU13QHWWc1MpB7A1XICw1H/xCug9hWNg4CAj9pxBfz5re
 AQjaGjSg92WcPk6rTulQnql/kvOJQQcceqofTp0T7GoqW5wO3bXVZGXCBpBSt3fC2njJ0
 11SrM+zgQvsOInprHKbFi9CuwPrifC40CKwgQCDLxCToGofIKkLIRCPd74MXk8BDrqA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Devu+a4Y; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Devu+a4Y
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96EA760616
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 18:35:24 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-497e6956acfso143675b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788460524; x=1789065324;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qJ6YBM6gg6KDgMC+s/FlrQsEzMGcde7WiAD6E1gX/qA=;
 b=Devu+a4YAuuKwTbHpW30A486Q3L6TS5zppPeZ4LsPMrRV1nanHmbeuU7BG7BOiTSTt
 /RPOCgAamXbKp1xHO6lrMKsr+dpGVhOLm5jRonfWoj+MjktqgTSgbKvZbghofDusE9n6
 3t7R8ulytt8lG9+r7Ut7Mq9BYMEq+zE/uiNW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460524; x=1789065324;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qJ6YBM6gg6KDgMC+s/FlrQsEzMGcde7WiAD6E1gX/qA=;
 b=McQb50lMYFDkH88t9lMVftgAZZsVVxd9SrYIuVgBWWbMVekHYuxNxnrC3UysLxeQZn
 jA/wpJQElnG7bvo4Vb7J1JtR7aRSwRxLklIo4ABHSv3qj2tmdgJ63Ea+4WDbbKH8mDgp
 XeHnhOnpyLJ8Og4fU2KxJZZqahMZMdtxnK01W36/Q/Q5F4Ebgr6veO7oJYmatUwBkF4w
 Nb0W+Sg0DiboyggCSF4Ocfaoivr9rRV+Ple8rkNxc6yUsl57Wx+jo3szZBcpqQGy4AZs
 0IO+7+2AD7z+tyl/tos+2lpkE+kdzvgjgdlwpne2aN0AR22YzD0Pa/J/8CQssBVTUjMY
 P+lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWrBnrfHhO8jE//1A2UU+ppiL6ccxr7AAJ73M1hRdjdYxDHWbRXvT+q0WDbiN07GBJELL8N4E=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lPRcbhIFyrvP7BaWHLmev59IfcTaywnCUzQ9uaJB6vJVOjpSBP
 KQZ7ZIOvty29VqcFQSUngYXjwR0kJhFzaa419tCeAhjwhFY+TQ1jLJCz0TRgko+eZFnPQkLN727
 YpWM310EPhG6S
X-Gm-Gg: AYBFou1QTqArqMMmxCE5ZsA2pDE8B7TlNFKGLkfZbhZ94v4lhzmcwq9i6Il09UkblpY
 42ZGF11+PsrycOY5xCsK4FKY7FvbB2n2bcpjbQxRN/7vDJNuuiDmY5P3KUtmgAQuaplY4nnqszc
 tpc4ctkPUSEJITTk5suQNQzJv5IWuA+a3/w/xyonJSWXpDycI5jO+TfXWipgCVH8RThUtwHWBN0
 Uqklxh5HvBbXQC3PIItCCINfqMKxF/7gPSD7y6htY//6gRYZtJW4gA43Sfc3MXtiM0nDKBQRGHH
 w5udUupbpV0D7zpw4n2v1SmlDh5uP6SL2xZFwbwE9eQMElRjJdrL1fedhn4gdw62AE+GCwEPmPq
 LmLm9puGgAh5NdxT+k89bsqcp6hZ2lxeVW4NTGoJ4DmAsu8rBdbbdyfsEbWmQME+dz9o9iuOdbW
 LCwwYPuP61pHGVQE330jvYuTw2P6Hg+CFVLyXXNYFxvxhMPRGTuq383Xl4zdtmaIyyAiwBTBTbS
 gzxiJ7vLP21UtvF0zwmL/POBe2GmAQ+aBQFhwuMV/tMBCzexn/KRZuhCUrFlVmosK92xvoSxlsd
 2ruN2QCdk3SVQH47yhhPwzQ=
X-Received: by 2002:a05:6808:e314:10b0:4b8:4703:db97 with SMTP id
 5614622812f47-4b84703dcf1mr1565735b6e.32.1788460523892; 
 Thu, 03 Sep 2026 11:35:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b970d200fesm7198b6e.3.2026.09.03.11.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:35:23 -0700 (PDT)
Date: Thu, 3 Sep 2026 12:35:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v9 00/15] add software ecdsa support
Message-ID: <20260903183521.GL1764417@bill-the-cat>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8sddD7tIC1bPIPfb"
Content-Disposition: inline
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
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


--8sddD7tIC1bPIPfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026 at 10:16:50AM +0200, Philippe Reynes wrote:

> This series adds the support of ecdsa with software
> using mbedtls. So boards without ecdsa hardware may
> also use signature with ecdsa.
>=20
> To achieve this goal, several changes are done:
> - fix the support of secp521r1
> - enable support of ecdsa in mbedtls
> - add software ecdsa signature check using mbedtls
> - add support of ecdsa for internal fit signature
> - add test for ecdsa for internal fit signature in vboot
> - add support of ecdsa for pre-load signature
> - add test for ecdsa for pre-load signature in vboot
> - enable software ecdsa signature check in sandbox

OK, so it's enabled on sandbox.

>=20
> To test this new feature, just follow those steps:
>=20
> 0) build u-boot using sandbox_defconfig and adding those options:
>=20
> CONFIG_ECDSA_MBEDTLS=3Dy
> CONFIG_ECDSA_VERIFY_MBEDTLS=3Dy
> CONFIG_ECDSA=3Dy
> CONFIG_ECDSA_VERIFY=3Dy
>=20
> 1) add a signature node to an its file
> 	signature-256 {
> 		algo =3D "sha256,ecdsa256";
> 		key-name-hint =3D "private-key-256";
> 	};
>=20
> 2) generate an ecdsa key
> openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem
>=20
> 3) create the itb file
> ./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>
>=20
> 4) launch sandbox u-boot
>=20
> ./u-boot -d arch/sandbox/dts/test.dtb
>=20
> 5) on sandbox u-boot prompt, load the itb and launch bootm on it
>=20
> =3D> host load hostfs - 1000000 uboot-ecdsa.itb
> 4628674 bytes read in 1 ms (4.3 GiB/s)
> =3D> bootm 1000000
> ...
> ...
>    Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK

Does this mean the new tests aren't run automatically?

--=20
Tom

--8sddD7tIC1bPIPfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapm96QAKCRAr4qD1Cr/k
Cgv6AQDavWlbilwBWrJC/YRbvqKLAbN3nk73pps095nw0BpZCAD8CEo0uXJBsTnb
Q3dA7Jm9fqhluEm0EULvuyuP/LLVKAs=
=6nGV
-----END PGP SIGNATURE-----

--8sddD7tIC1bPIPfb--
