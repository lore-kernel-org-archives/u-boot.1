Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6246ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7FB86BF2;
	Mon, 16 Oct 2023 18:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ukIurvUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D34E86BA1; Mon, 16 Oct 2023 18:14:32 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71ACD86940
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4180adafdc6so31973331cf.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697472867; x=1698077667; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LCTodl1HeIhd1o79s9ULFOn/w/+oA5gjXnRKI2C9sEU=;
 b=ukIurvUyRexZIaNVDCZvPz4EEMV1hIUV8QL2vlB+TP2IgLnDUEA10yxH7CE1HN+cnL
 xXGNfaGixFRcWEdMRKYwmUT/VD9Pyi/TdFOZ3NMv9mQmD/WWmzpEiz69cd85WZGvNYzJ
 msL0QQYm2VWG4KoaRuZc9BZg8znv8etLBz1WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697472867; x=1698077667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCTodl1HeIhd1o79s9ULFOn/w/+oA5gjXnRKI2C9sEU=;
 b=cNchC4qEt3OpSXStDFI5KeEqoBVjhyxt82IRyIG+0GeQC3zc1BMQ6/t3vKlJPG8bRX
 ORzS4o+Axqsler2HSLjFx5B5PQt12TzbvuCRSF+jl0UT7N9x7yG6kCaO6Ond28cWUADc
 KTxOROKotEiOC0nuj3+NhiVUjQvIeY0hWHyyAqwrOiQVRTI/uEYcG7wHyFy1vRk/8lRD
 PbVYtgR1ZchoV3+gjxvMA+oVW3yqbHBV1KaJ6ZqjL/Qd8Ch4p+ZbuCfHeJtycA3LSamA
 4ypJUH0hKWK42d6Rch3beLWg6eKt7UuB8bmco5j+1tbGWndRaQ1LILqlld1O4+NKPyRh
 m+8w==
X-Gm-Message-State: AOJu0YzejxAlYpCZKPgpyHJWzpCObUHw3tt6cUByCdyiqH+5DtOLGXIk
 dkeTnnZ9dP+p8xfmAC9AhNiHAw==
X-Google-Smtp-Source: AGHT+IF4L+LPPa7xRR3n6FsZlcosvSuq2S78OR5YBPpFxrlpO+HtaiUZAtuUNIp8BqEdyP52KNl28g==
X-Received: by 2002:ac8:7f86:0:b0:418:111e:7910 with SMTP id
 z6-20020ac87f86000000b00418111e7910mr38283625qtj.43.1697472867212; 
 Mon, 16 Oct 2023 09:14:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 ic3-20020a05622a68c300b004181f542bcbsm3106138qtb.11.2023.10.16.09.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 09:14:26 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:14:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Alexander Gendin <agendin@matrox.com>, Simon Glass <sjg@chromium.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] cmd: mbr: Allow 4 MBR partitions without need for
 extended
Message-ID: <20231016161424.GE3119521@bill-the-cat>
References: <ZSCw7eCcnSRpgkBN@alg-gentoo>
 <CAPnjgZ1jyvKku8V5UKqVxBHC4qEy7EtHN+yBuUNQW0pxxHpwkg@mail.gmail.com>
 <ZSNWVGTjPEt2jXn5@alg-gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kpkf3tq8yMMFrXCd"
Content-Disposition: inline
In-Reply-To: <ZSNWVGTjPEt2jXn5@alg-gentoo>
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


--Kpkf3tq8yMMFrXCd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 01:24:36AM +0000, Alexander Gendin wrote:

> Current code allows up to 3 MBR partitions without extended one.
> If more than 3 partitions are required, then extended partition(s)
> must be used.
> This commit allows up to 4 primary MBR partitions without the
> need for extended partition.
>=20
> Add mbr test unit. In order to run the test manually, mmc6.img file
> of size 12 MiB or greater is required in the same directory as u-boot.
> Test also runs automatically via ./test/py/test.py tool.
> Running mbr test is only supported in sandbox mode.
>=20
> Signed-off-by: Alex Gendin <agendin@matrox.com>
> ---
> Changes for v2:
> - Cleanup coding style
> - Adjust commit message to the changes in v2
> - Add mmc6 device to sandbox device tree
> - Adjust boot/bootdev.c and dm/blk.c tests to include mmc6 in tests
> - Auto-create mmc6.img in test_ut_dm_init()
> - Add mbr test to the list of tests run by test.py. Test can be run manua=
lly
>   too via 'ut mbr'.
> - Change mbr test to use mmc6.img dedicated to the test, instead of mmc1.=
img.
> - Clear read buffer before reading data from test file.
>=20
>  arch/sandbox/dts/test.dts |   7 +
>  disk/part_dos.c           |   2 +-
>  include/test/suites.h     |   1 +
>  test/boot/bootdev.c       |   2 +-
>  test/cmd/Makefile         |   1 +
>  test/cmd/mbr.c            | 471 ++++++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c             |   4 +
>  test/dm/blk.c             |  44 ++--

So, in addition to the changes to test/dm/blk.c I had gotten as far as:
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 66c151131edb..33babdcf699c 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -43,8 +43,10 @@ static int bootdev_test_cmd_list(struct unit_test_state =
*uts)
 				   "mmc", "mmc1.bootdev");
 		ut_assert_nextline("%3x   [ %c ]  %6s  %-8s  %s", 2, probe_ch, "OK",
 				   "mmc", "mmc0.bootdev");
+		ut_assert_nextline("%3x   [ %c ]  %6s  %-8s  %s", 3, probe_ch, "OK",
+				   "mmc", "mmc6.bootdev");
 		ut_assert_nextlinen("---");
-		ut_assert_nextline("(3 bootdevs)");
+		ut_assert_nextline("(4 bootdevs)");
 		ut_assert_console_end();
 	}
=20
@@ -225,10 +227,11 @@ static int bootdev_test_order(struct unit_test_state =
*uts)
 	ut_assertok(env_set("boot_targets", "mmc spi"));
 	ut_asserteq(0, bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(3, iter.num_devs);
+	ut_asserteq(4, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
+	ut_asserteq_str("mmc6.bootdev", iter.dev_used[3]->name);
 	bootflow_iter_uninit(&iter);
=20
 	return 0;
@@ -254,7 +257,7 @@ static int bootdev_test_order_default(struct unit_test_=
state *uts)
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
=20
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(3, iter.num_devs);
+	ut_asserteq(4, iter.num_devs);
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
 	bootflow_iter_uninit(&iter);
=20
@@ -693,6 +696,10 @@ static int bootdev_test_next_prio(struct unit_test_sta=
te *uts)
 	ut_asserteq_str("mmc0.bootdev", dev->name);
 	ut_assert_console_end();
=20
+	ut_assertok(bootdev_next_prio(&iter, &dev));
+	ut_asserteq_str("mmc6.bootdev", dev->name);
+	ut_assert_console_end();
+
 	ut_assertok(bootdev_next_prio(&iter, &dev));
 	ut_asserteq_str("spi.bin@0.bootdev", dev->name);
 	ut_assert_skip_to_line("Hunting with: spi_flash");

To make the bootdev test pass (and they still don't with the above)
before deciding that it seems like there's a bigger problem here, and
maybe Simon can help explain or figure out what to do?  Is there no way
to drop mmc6 once we've completed the new test here?

--=20
Tom

--Kpkf3tq8yMMFrXCd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtYV0ACgkQFHw5/5Y0
tyy5HQv/VFxtqWODWAqMa06eQidRXtCd3EoJbk6BO+rhSj0uKvImtDzRInqFZDv6
EqpUlZX6M5uH3lVktLgImfm9VgqeWQGyyfBbbMC2WSlSanFiymxQyNVRRgRMOFzI
v3Ppvhu1AoKRYOefYLoP2xl8lLsD3T9MKJRlgYGKBTJAANDnp5Ldsj25mCF4H9U+
ZjbACnHNHCDvwVFiW2B/maRGZae6kvNblg17pmjmUzfaEAz3EXjjdRBIaWNsaaLf
bJXJolVCijppSwjRf3EEf5IxpIrZAWGqj5tGUawzZt3UNvPUyAaPwxu0qxcO39A5
qUbCzPquNarRwQh/nUlRjaZc3ewquf0LUi7duT6q63W3XYJbgQzxjc7bn3Zw7oWm
tgRueGFfyS4Y425bmA/Tzdep9ZM+/Xb9hWlux89tM+wunN+E0rMwzaKyunDXLfaC
vP95XdjsFZxMiILhi6RP4dzKYikvD6k6rHIP4+U/h030BShaG9usR9P1LWBtvKcu
DjnXuq6q
=4KhF
-----END PGP SIGNATURE-----

--Kpkf3tq8yMMFrXCd--
