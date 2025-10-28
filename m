Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0D5CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 19:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD1FB83885;
	Tue, 28 Oct 2025 20:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B1SegVPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0C583885; Tue, 28 Oct 2025 20:26:40 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663FC80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 20:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-654fbeb645bso1295674eaf.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761679597; x=1762284397; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tnk6r4cz9vfKtkr6hNJ6G2FfUzSCpD+Cnx7aRlbjC0k=;
 b=B1SegVPA5wA9i9gSBzHovkZMaqP8BZHT1FsV7PROOPuBKcaOwqfVB8rcf89WYFymPh
 xtE21WOPHSNG7xOM10kRaUH6DBDeoY3cWoTbcs1FT77jm1WwKBC23LVC3x18A+IjjacO
 vJlA76AS2owUPy/6OwwyYtzi3VyYbBQmFyqhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761679597; x=1762284397;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnk6r4cz9vfKtkr6hNJ6G2FfUzSCpD+Cnx7aRlbjC0k=;
 b=peZJ05j0fwVhqLP6SZ/c2sNSClHLOYrAJNME+Oz7eRFY5+2MasWe/M1DLfQMnUIWun
 nsK+LdvUx2KQAwGiIylJ+AlwGduHbH6caELXO4Vg4i05Lp6M3C3Mc0+MvsvA1EDSS4E1
 I/OLgNAmL5XP6X+TKkoZFDjsafnYNyFmp9mCq+fp9ilwwdTKn8wR6LkwQyDLLp3oVpyd
 VVlB3iuFjv1jDA4ywqVu2AtkS+zjjkZyCD+Q0TXZ+jJ3YEOJdKTItp5UStxcitd9h83K
 yC1PygUYfOhFJ1UKbiytm/mtmuQejwdp99jYQwxHWcgM+mIGr/oVeGqk47Lt3/tGxpxN
 bTNg==
X-Gm-Message-State: AOJu0Yxy/df7RqlpV/+owOXqXKQtd6BIy1YK3pRnScc6UPVrJG2mv0QD
 bFdDg7tvMIPnzHuvek6/x4SMctSI68fRQjEkmJqsud/vhav9qKAZN21O+q449/tp8MI=
X-Gm-Gg: ASbGncs+ums950ew9HZxCJ7Wo8flBIDMuv8pMWpIW12nQK2AAarEUxh8c9GNoF1Carl
 4V8aTNIKyeZQ5QYEya0y99vIaHsIq5zJyfzFgU2HKISFP80813eFhDUiUBO3oB1GRu0GGSoID/s
 /MojTVhwtquayfuO635RPhzZXDuiMfo0TUCgWOeAdA9P+oPyGicSG47uFndG6GU+59X8ZKOL6wY
 mGGUymPz5sXidZVHpho/xvpsH/WuCaknofmd/k7HUjoo/kwq+4ubF8Rm5b8NAJ9CV6Ego6+s1mR
 NDx7CqH4qCLUVqE3U5+ZdjjJ9e3MfRZt/0yUCwQVHsMcnKFtpTqBi7mgSZ+F1XIdzITX4ZznwKZ
 9Q0HSVHhvTfLA1G4p/zZvnfXbKNMbUMyOVs+UHlIT3c1/Q47RDmFzrrZE1nfCFnd7TMmjNo7eKe
 T3c3ppp8RAgeXiSvbqql1JyH2gBcgcZaO9rB3hN40=
X-Google-Smtp-Source: AGHT+IHMX4d980ccOZdsUptg7Km6oCh2+OpNczVH5a5FFZHq2nBlls/3o+4bHJYYhmktoFlKe0kyDQ==
X-Received: by 2002:a05:6820:992:b0:654:d917:63f3 with SMTP id
 006d021491bc7-65677ee6465mr303134eaf.3.1761679597048; 
 Tue, 28 Oct 2025 12:26:37 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2c2608sm2907433eaf.14.2025.10.28.12.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 12:26:36 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:26:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] clk: Return value calculated by ERR_PTR
Message-ID: <20251028192633.GH6688@bill-the-cat>
References: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
 <176167434712.2025892.9174636336405377074.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="txXHX95+orvdJ6vF"
Content-Disposition: inline
In-Reply-To: <176167434712.2025892.9174636336405377074.b4-ty@konsulko.com>
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


--txXHX95+orvdJ6vF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:59:07AM -0600, Tom Rini wrote:
> On Thu, 03 Jul 2025 15:40:46 +0100, Andrew Goodbody wrote:
>=20
> > In clk_set_default_get_by_id ret is passed to ERR_PTR but nothing is
> > done with the value that this calculates which is obviously not the
> > intention of the code. This is confirmed by the code around where this
> > function is called.
> > Instead return the value from ERR_PTR.
> >=20
> > This issue found by Smatch.
> >=20
> > [...]
>=20
> Applied to u-boot/master, thanks!
>=20
> [1/1] clk: Return value calculated by ERR_PTR
>       commit: 644b4650ee57c429bede77f44752cc867dac0e00

Unfortunately I missed that this caused CI failures until too late:
__________________________ test_ut[ut_dm_dm_test_clk] _____________________=
_____
test/py/tests/test_ut.py:591: in test_ut
    assert output.endswith('failures: 0')
E   assert False
E    +  where False =3D <built-in method endswith of str object at 0xfffede=
8fec30>('failures: 0')
E    +    where <built-in method endswith of str object at 0xfffede8fec30> =
=3D "Test: clk: clk.c\r\r\ntest/dm/clk.c:92, dm_test_clk(): 321 =3D=3D sand=
box_clk_test_get_rate(dev_test, SANDBOX_CLK_TEST_ID...clk' failed 2 times\r=
\r\nTests run: 1, 12 ms, average: 12 ms, failures: 2\r\r\nexit not allowed =
=66rom main input shell.".endswith
----------------------------- Captured stdout call ------------------------=
-----
=3D> ut dm dm_test_clk
Test: clk: clk.c
test/dm/clk.c:92, dm_test_clk(): 321 =3D=3D sandbox_clk_test_get_rate(dev_t=
est, SANDBOX_CLK_TEST_ID_DEVM1): Expected 0x141 (321), got 0x0 (0)
Test: clk: clk.c (flat tree)
test/dm/clk.c:92, dm_test_clk(): 321 =3D=3D sandbox_clk_test_get_rate(dev_t=
est, SANDBOX_CLK_TEST_ID_DEVM1): Expected 0x141 (321), got 0x0 (0)
Test 'clk' failed 2 times
Tests run: 1, 12 ms, average: 12 ms, failures: 2
exit not allowed from main input shell.
=3D>=20
_______________________ test_ut[ut_dm_dm_test_clk_base] ___________________=
_____
test/py/tests/test_ut.py:591: in test_ut
    assert output.endswith('failures: 0')
E   assert False
E    +  where False =3D <built-in method endswith of str object at 0xaaab78=
8cbea0>('failures: 0')
E    +    where <built-in method endswith of str object at 0xaaab788cbea0> =
=3D 'Test: clk_base: clk.c\r\r\ntest/dm/clk.c:44, dm_test_clk_base(): 0 =3D=
=3D uclass_get_device_by_name(UCLASS_MISC, "clk-tes...base\' failed 2 times=
\r\r\nTests run: 1, 3 ms, average: 3 ms, failures: 2\r\r\nexit not allowed =
=66rom main input shell.'.endswith
---------------------------- Captured stdout setup ------------------------=
-----
/u-boot
Bloblist at 100 not found (err=3D-2)
U-Boot 2026.01-rc1-00013-gf12ca3e2b81b (Oct 28 2025 - 18:45:26 +0000)
Reset Status: WARM Reset Status: COLD
Model: sandbox
DRAM:  256 MiB
using memory 0x1988c000-0x1f88e000 for malloc()
Core:  266 devices, 94 uclasses, devicetree: board
WDT:   Not starting wdt-gpio-toggle
WDT:   Not starting wdt-gpio-level
WDT:   Not starting wdt@0
NAND:  4100 MiB
MMC:   mmc2: 2 (SD), mmc1: 1 (SD), mmc0: 0 (SD)
Loading Environment from nowhere... OK
In:    serial,cros-ec-keyb,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: sandbox
Net:   eth0: eth@10002000, eth5: eth@10003000, eth3: sbe5, eth6: eth@100040=
00, eth8: phy-test-eth, eth4: dsa-test-eth, eth2: lan0, eth7: lan1
Hit any key to stop autoboot:  0
=3D>=20
----------------------------- Captured stdout call ------------------------=
-----
=3D> ut dm dm_test_clk_base
Test: clk_base: clk.c
test/dm/clk.c:44, dm_test_clk_base(): 0 =3D=3D uclass_get_device_by_name(UC=
LASS_MISC, "clk-test4", &dev): Expected 0x0 (0), got 0xfffffffe (-2)
Test: clk_base: clk.c (flat tree)
test/dm/clk.c:44, dm_test_clk_base(): 0 =3D=3D uclass_get_device_by_name(UC=
LASS_MISC, "clk-test4", &dev): Expected 0x0 (0), got 0xfffffffe (-2)
Test 'clk_base' failed 2 times
Tests run: 1, 3 ms, average: 3 ms, failures: 2
exit not allowed from main input shell.
=3D>=20

So I will be pushing a revert in a moment.

--=20
Tom

--txXHX95+orvdJ6vF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQEYxwAKCRAr4qD1Cr/k
Cm9GAP9Qbk7Hil575pNTx6sacKWBzCepPHtGvS8fTuAcvUY14wEAneIEMFEQWlMj
8WLpeWxhdZi9Yu1N58OkJfd/FYFhog0=
=VuNa
-----END PGP SIGNATURE-----

--txXHX95+orvdJ6vF--
