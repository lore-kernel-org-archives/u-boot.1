Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760A0E7719A
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 22:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BCB3801BE;
	Sat, 11 Jan 2025 23:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mtF8f8Sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532BA8036B; Sat, 11 Jan 2025 23:54:40 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12CEE80137
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 23:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6dd5c544813so31419296d6.1
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 14:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736636077; x=1737240877; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6eCJGK6KRr6HN2wrdg2S/sNPSsCbJrlluw2wmbXnBho=;
 b=mtF8f8SxiR2rwz2b4MGwDN41K0FPzO/gZ18wTHVc0oIekgq5wKLfX2uRH2YZbBTKoO
 e7uDQNPk9v8/nEUb0DALVHIIplR2xNtgdRWmJloGueMtF5zRE+WtIYq8B/2rJ+3uJgE6
 38Q1XtCRhQlleCsQKaIMVMDBHwLhwPv9eofRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736636077; x=1737240877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eCJGK6KRr6HN2wrdg2S/sNPSsCbJrlluw2wmbXnBho=;
 b=XY3EFwhiv4100+OGbXEmQR0RwWJBDojvZ5I8yppmXRz6K+usXIL9Qun3EDfDV8zd9J
 x8o23rBc56iqTOqF8hsJaffgwVXox4h56nGaCka2q/igMMgK2g3WQaSR3ClTHERB+rfe
 u7z8oqST4A297KwTi7YxxSVn9foImiZjwmD18YW5b2gCTbJb1EcaRN6bO09qBPMcs2Cz
 DnfFqHrODlc/lKpl7O4JHGjiSC/fK22t5lfA40sD/HI09dCFDyDl5H7uLfuhDBEACtoJ
 qSl2ikTXuBu4ayTOKFMakmDLkvOZ9cngrc/2YAr872jmxJc38fVUVlG/vnDNkZhNZtme
 XOzA==
X-Gm-Message-State: AOJu0Yyx5evZ8Yk0Dxjf8cAcUfZB65HdT1przu6MGYb8RAOCB5gPYThE
 qNVFyvI2Deyi63RwwbzhNLf87xU/xLsLNYUhMO6P3JufeoK+US0SANih2XOlKHY=
X-Gm-Gg: ASbGncu60KbecHgIbUeuEkjEKbThHIiEklwN8psnGspKM3sZ7Iwjvrloe10lx2tTEAl
 uCIm97dzO5DBwWZ9XdeqwMSq+dF9B6mgdFVHaMSkMMsoYBJJ+3N0GkwN1/DQG5L61qW3a7RzyZE
 EV42DeiHNAi2XgVvxYUDc3wt3bKvt2XeJQmPOfuUcOVyqS1EK3cg5KDmDJA3gFYyD7zkJpTY5+P
 rt6HL6DEn2rZqAuIFRR3u/Hemi/e1J7LqhmdUKEH2337nplnfuZZ7w=
X-Google-Smtp-Source: AGHT+IG0UkKZya00ZH3O/MlhvmXwKt2bOLThR1FUDLn/qdvX8Xc8KahlJK7tuOsHBSdErFn0U0xQsA==
X-Received: by 2002:a05:6214:2f8e:b0:6df:ba24:2af2 with SMTP id
 6a1803df08f44-6dfba242b5bmr68013896d6.25.1736636076850; 
 Sat, 11 Jan 2025 14:54:36 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad880ea6sm24367436d6.42.2025.01.11.14.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 14:54:35 -0800 (PST)
Date: Sat, 11 Jan 2025 16:54:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/15] vbe: Split out reading a FIT into a common file
Message-ID: <20250111225433.GS3476@bill-the-cat>
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xJQLClfvTrf/nEcQ"
Content-Disposition: inline
In-Reply-To: <20250109123010.4005298-3-sjg@chromium.org>
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


--xJQLClfvTrf/nEcQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 05:29:57AM -0700, Simon Glass wrote:

> Loading a FIT is useful for other VBE methods, such as ABrec. Create a
> new function to handling reading it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This causes a bunch of growth:
            a3y17lte       : all +1328 text +1328
               u-boot: add: 8/0, grow: 1/0 bytes: 1328/0 (1328)
                 function                                   old     new   d=
elta
                 blkcache_fill                                -     332    =
+332
                 blkcache_read                                -     240    =
+240
                 blk_read                                     -     188    =
+188
                 vbe_read_nvdata                              -     156    =
+156
                 vbe_read_version                             -     140    =
+140
                 vbe_get_blk                                  -     100    =
+100
                 simple_read_nvdata                           -      96    =
 +96
                 crc8                                         -      72    =
 +72
                 vbe_simple_read_state                      108     112    =
  +4

Which is unexpected for just moving code around that's not newly used.
And even when it's just a move it's still growing:
            xilinx_zynqmp_virt: all +128 bss -72 text +200
               u-boot: add: 4/0, grow: 0/-1 bytes: 540/-340 (200)
                 function                                   old     new   d=
elta
                 vbe_read_nvdata                              -     156    =
+156
                 vbe_get_blk                                  -     148    =
+148
                 vbe_read_version                             -     140    =
+140
                 simple_read_nvdata                           -      96    =
 +96
                 vbe_simple_read_state                      452     112    =
-340

--=20
Tom

--xJQLClfvTrf/nEcQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeC9qIACgkQFHw5/5Y0
tywwYwv+LtKDnAHnUYbfrqY4+Cwl1zM+W/vd+7gPukkEjd5HUClrPuy/9HmdKsgv
Kcn1Jckdz6C98jKWk5zaNAHSyT5JnCVMQHSluv2rX6Oe0xqig0svZfw0Czxrlad7
PH6/HhauXQqyO8/ookGbMbrkeNnwco58+S56IAX2pPAQ1c2mrJymBu735LHsjBNm
B9fYBJQOrm/HM9PjOfTTDNJFKbNiwP9739IyDFWo8NA/dq4mG6uoIWMxLeSW+Dzm
iKg+UwOEjOC06cDF7IPdBu9n7BW26ojTuOI3jVGT1nslK7p1aLNkxRifatOxCOsR
URfnjzhYBv6GQkzo2XKiD4l6d2VKBPVfWwYTwfyV4vNgfYQI13AV02IrBfDZ9+Mk
jygl8Vcyk6prNxQ+nq8ccOwryS3f0vHjeoiHsckCZ6+E4/NDXe20O88G0euM3LPw
rVLa84m0PFG35bPm9d9gtICbGrAlonm63stb956FRTt8l5JbdU/L4xSNZWvxEZhq
7EO6Gdfn
=uOhO
-----END PGP SIGNATURE-----

--xJQLClfvTrf/nEcQ--
