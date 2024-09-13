Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED9CFA3750
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 20:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDBA88883;
	Fri, 13 Sep 2024 22:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Njkdwajz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F50D88883; Fri, 13 Sep 2024 22:04:53 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC86788B1C
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 22:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4585721f6edso10662361cf.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726257890; x=1726862690; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nP5zDqycvvVW87UK0ZU1/kfy9RbkR0mPosxSLxuVBDc=;
 b=NjkdwajzPAoXMtPSKuyMJrEh/Q5ye2I0uC9eMLn2jfIu8i657BJ+ZMOdXgIGKySzvg
 egvahJTp/8Ial60HqfNnu0Hr/FDC1JcIzNyRQwXoglpW8oKFfI1oAWfngcxaz+NbzVIR
 I/zgtt/yK/JJSd2NYUbfgxD2Ow/W7Z3HI+l1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726257890; x=1726862690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nP5zDqycvvVW87UK0ZU1/kfy9RbkR0mPosxSLxuVBDc=;
 b=nqHzJNT2W6aJ3jO1LOOrdQBUou+syywjjWC1T5TfyjnEQEVrKcRyYnL4ZZ/6+/QYZN
 51jmI5f3VROF2fKq9J6ozyh5E+tAS0V5UAhRfLidWwz2oO/LrIzePjbg6jjyUyBg2Dgt
 Y6N2McxmFAfUDJNSLRRbQiOwEPt6W0dPRNFlAtGUl8mg4OP10JeFubG8xC2dbcZsCfN7
 vYwWKTYh75Ob361DiBYg1rsUoHOmt/0u7DMVZchOYOnBUjYutFb1L7XcDvulr7cDjcUN
 tAYsGVSViDGQ1WmsUW8JEdyejun3aXNnYnAYPNhYkW6zX2YkWvSlAzH8+68t9+HLzKFS
 SGMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQeXQG9sgG3qtwYG9YiAG3hA8jqFBM7OCgLX5ZMgeT2EM7uPNTtRHrCYUOBgZnM3Mw0qunQ+8=@lists.denx.de
X-Gm-Message-State: AOJu0YxMTeVjGrq/b950rSq1FFADTpUUrBJTt0HGQVpflimm2oj+afUc
 mKIOpf9oZLcpyjjLuN1A4ib3b+SCLlDKPdsqWxvKoH82HaSf+lKpWDOz5OTNtDU=
X-Google-Smtp-Source: AGHT+IFg8FB2SW78Vm2jMZKWju39OgmlpQMcxraEWQch+jURfY5WUE9oBusNcCkqiTu2j1PCUtqrIw==
X-Received: by 2002:ac8:5ac5:0:b0:458:4e4c:b68f with SMTP id
 d75a77b69052e-4599d29f796mr51459731cf.46.1726257889465; 
 Fri, 13 Sep 2024 13:04:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f6bb0dsm68546861cf.72.2024.09.13.13.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 13:04:48 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:04:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, sjg@chromium.org,
 semen.protsenko@linaro.org, colin.mcallister@garmin.com,
 4.shket@gmail.com, avromanov@salutedevices.com,
 u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com
Subject: Re: [PATCH v2 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
Message-ID: <20240913200444.GZ4252@bill-the-cat>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240912071053.4cquqz5fcbhg6yzc@CAB-WSD-L081021>
 <20240913162738.brhoavecnvaudw66@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AmYqxW/o2aW4btCP"
Content-Disposition: inline
In-Reply-To: <20240913162738.brhoavecnvaudw66@CAB-WSD-L081021>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--AmYqxW/o2aW4btCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 07:27:38PM +0300, Dmitry Rokosov wrote:
> On Thu, Sep 12, 2024 at 10:10:53AM +0300, Dmitry Rokosov wrote:
> > There are Pipeline results. One test was failed. I suppose it's not
> > related to my patch series:
> >=20
> > https://github.com/u-boot/u-boot/pull/625/checks?check_run_id=3D3002992=
5059
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > _______________________ test_ut[ut_dm_dm_test_rtc_dual] _______________=
_________
> > test/py/tests/test_ut.py:590: in test_ut
> >     assert output.endswith('Failures: 0')
> > E   AssertionError: assert False
> > E    +  where False =3D <built-in method endswith of str object at 0x7f=
b0835c50d0>('Failures: 0')
> > E    +    where <built-in method endswith of str object at 0x7fb0835c50=
d0> =3D 'Test: dm_test_rtc_dual: rtc.c\r\r\nTest: dm_test_rtc_dual: rtc.c (=
flat tree)\r\r\ntest/dm/rtc.c:307, dm_test_rtc_dual...&now1, &cmp, false): =
Expected 0xffffffea (-22), got 0x0 (0)\r\r\nTest dm_test_rtc_dual failed 1 =
times\r\r\nFailures: 1'.endswith
> > ----------------------------- Captured stdout call --------------------=
---------
> > =3D> ut dm dm_test_rtc_dual
> >=20
> > Test: dm_test_rtc_dual: rtc.c
> >=20
> > Test: dm_test_rtc_dual: rtc.c (flat tree)
> >=20
> > test/dm/rtc.c:307, dm_test_rtc_dual(): -EINVAL =3D=3D cmp_times(&now1, =
&cmp, false): Expected 0xffffffea (-22), got 0x0 (0)
> >=20
> > Test dm_test_rtc_dual failed 1 times
> >=20
> > Failures: 1
> >=20
> > =3D>=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >=20
>=20
> I've re-run the pipeline. This time it was finished successfully.
>=20
> https://github.com/u-boot/u-boot/pull/625/checks

Thanks!

--=20
Tom

--AmYqxW/o2aW4btCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbkmtkACgkQFHw5/5Y0
tyxrRAv8CW3MHsqC2rxZ9OJn9b2cCRTrFVqAFfryWvcot+3T3618jt6kKhantZNz
jELm952XG4GioMA6f0YYs/QfDPZdnlhY74gPvBmwsuG8lcgF9oYHxY4mP1bDZ46m
20qhznDfYn06AFJ6JgpDiTEKPdIm0brZbY43G/zoQbzKKFmYS3ybC81ysrdV1fE/
Jxdm3eqzyu7cwyIFgn4grqjDsJzyQS22bzN4ZMPi6TJVVXNx2vqalw0ZtDpgjsbc
1c4+wNMF8PqumMUD+fg6EpoheY6UJwtq2oUw+XmGhREhcujSNRqcdY1YBiwfNVo2
4VnM873kG8IHS34l9sdUml1WowMbjHpFponryYKISPBFxsCnC1RoySVBEoc/u5xc
vJKmwbEAxVjtXsoXmMvYctRRdMehY2dcRBhnp2TOZw4d/yUdUZuqE4Z1qEP4rfdA
6bH5dWXWGJqAqDcrUZPx3sRyZlfoPDiTLDr9X6GSUOOSfSyzegRTs1b9WLsHqWWD
VocI6xWA
=t6vX
-----END PGP SIGNATURE-----

--AmYqxW/o2aW4btCP--
