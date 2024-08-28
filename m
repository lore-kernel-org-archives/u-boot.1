Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF2FC636E9
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 16:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CA188703;
	Wed, 28 Aug 2024 18:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bCDAt0Q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB02C888C1; Wed, 28 Aug 2024 18:53:19 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C648862E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a7fa4cb3fdso31549585a.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724863996; x=1725468796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0RBvMWOiPBAoHEmDO5NF7KpXyX8CiUgS69SU+LRu33o=;
 b=bCDAt0Q0HG/SSMW83tqFrdkGZ+51y9dCk3h/L9VSmanVIQAAVJvVNj/z4iBMp+isVK
 76Oml6pHEdosVT4V1NbNVay3yJt8ShBc3ebkRJHaW+y4ccBclHqN/5Srz7prOB4gcfFZ
 kUFfB/TxOBpXq+qFExtQ4wndtPQm3KEDeN4hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724863996; x=1725468796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RBvMWOiPBAoHEmDO5NF7KpXyX8CiUgS69SU+LRu33o=;
 b=lAC9wjFwXPXdesd+5eITbxvUCNnm0np1WMtcMi+wRnpE9+x11XLttHnAqyX/4fzbPW
 0KZ/30T+qXpYElYEvEgj1YtVF9Eb3qY4LZ9XhWPmA/ydPKw2YryW7iOfYlpBQHXyoDIC
 kA84UwZZptgwW8nwYiQebxl6ncsDtIqyMcXOmRyaqJlhuEwFIy9PR4FAdQ0ImI8Lxwym
 +cVfDHr95XO2BsxFL+y+gBggO0Tzbz2cZsZm5kSeBl4V7krseTD55oUSYbN4UuHWfZA2
 OxFHNJY6E7m8IaCL94iZv7W8MQtnMu9fqXqayRWnONSRVFXRgrsvCoWEVaHIgLNZ/Clc
 dt0g==
X-Gm-Message-State: AOJu0Yw0B3n7Tu5FI8FpAglGwlymGtyswQ08jTo7PE8LV1TAO3dh3WBg
 lDOgbFFyiepHoO1k6DeO6HHjgyj5dM3w+CjJdHxDeNIH3USSMH1QUMGSocPCR6Q=
X-Google-Smtp-Source: AGHT+IGYzi9aF1k515RIhhRF07rH9QIXWEgpsbG+yIcsWECJPiAlrYDLStCOCXXxxJvH1FPPVKI1tg==
X-Received: by 2002:a05:620a:1906:b0:79e:ff47:3307 with SMTP id
 af79cd13be357-7a6896dc84amr2099118985a.8.1724863995738; 
 Wed, 28 Aug 2024 09:53:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f318e5bsm652336085a.20.2024.08.28.09.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 09:53:15 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:53:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] bootstage: Do not sort records
Message-ID: <20240828165312.GR2479150@bill-the-cat>
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-3-jonas@kwiboo.se>
 <CAFLszTha39GkRsZA1r91YpLdKJDiRfDmAzWsMTuByDtPC0YvGQ@mail.gmail.com>
 <CAFLszThNN-rfPtAYKSHtGTEUwuxFgz01A-yJMXRYtwX3WiA-Kg@mail.gmail.com>
 <0329ee07-3f99-4daf-8960-1e934ff753de@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2ZWLwbXGXXsC6eYZ"
Content-Disposition: inline
In-Reply-To: <0329ee07-3f99-4daf-8960-1e934ff753de@kwiboo.se>
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


--2ZWLwbXGXXsC6eYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 06:15:32PM +0200, Jonas Karlman wrote:
> Hi Simon,
>=20
> On 2024-08-28 18:01, Simon Glass wrote:
> > Hi Jonas,
> >=20
> > On Tue, 6 Aug 2024 at 15:50, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Jonas,
> >>
> >> On Sat, 3 Aug 2024 at 06:42, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>
> >>> The timer counter on Rockchip SoCs may be reset in TF-A, this may cau=
se
> >>> the bootstage records to be printed out of order and with an incorrect
> >>> elapsed time.
> >>
> >> Eek can we just fix TF-A? That seems like a bug.
>=20
> TF-A is vendor blob, so we have no control of it.
>=20
> >>
> >>>
> >>> Fix this by not sorting the bootstage records.
> >>>
> >>> Before on a Radxa ZERO 3W (RK3566) board:
> >>>
> >>>   =3D> bootstage report
> >>>   Timer summary in microseconds (12 records):
> >>>          Mark    Elapsed  Stage
> >>>             0          0  reset
> >>>         7,436      7,436  board_init_f
> >>>       164,826    157,390  SPL
> >>>       375,392    210,566  end phase
> >>>       423,909     48,517  board_init_r
> >>>       472,973     49,064  eth_common_init
> >>>       476,848      3,875  main_loop
> >>>       477,003        155  cli_loop
> >>>
> >>>   Accumulated time:
> >>>                    7,181  of_live
> >>>                   14,739  dm_spl
> >>>                   15,029  dm_r
> >>>                  315,150  dm_f
> >>>
> >>> With this the records can be printed in chronological order when the
> >>> counter is reset and SPL and board_init_r records show correct elapsed
> >>> time.
> >>>
> >>>   =3D> bootstage report
> >>>   Timer summary in microseconds (12 records):
> >>>          Mark    Elapsed  Stage
> >>>             0          0  reset
> >>>       164,437    164,437  SPL
> >>>       375,023    210,586  end phase
> >>>         7,437      7,437  board_init_f
> >>>       424,390    416,953  board_init_r
> >>>       473,515     49,125  eth_common_init
> >>>       477,402      3,887  main_loop
> >>>       477,571        169  cli_loop
> >>>
> >>>   Accumulated time:
> >>>                   14,734  dm_spl
> >>>                  315,646  dm_f
> >>>                    7,339  of_live
> >>>                   14,977  dm_r
> >>>
> >>> For the tested board external TPL and BROM take ~164 ms to initialize
> >>> DRAM and load SPL, SPL take ~210ms to load images from FIT and U-Boot
> >>> proper take ~477ms to reach cli prompt.
> >>>
> >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>> ---
> >>>  common/bootstage.c | 12 ++----------
> >>>  1 file changed, 2 insertions(+), 10 deletions(-)
> >>>
> >=20
> > To put this more strongly, this breaks the timing output on other board=
s.
>=20
> Please elaborate, I cannot understand why not sorting would break output
> on other boards, are other boards adding records out of order?
>=20
> Do you have an example of how this change break other boards?
>=20
> >=20
> > At the very least, this should be Kconfig option just enabled for
> > boards with a broken ATF.
>=20
> I can add a Kconfig option, but would like to understand why other/any
> board would need to sort the records in the first place.

This got me to re-check everything and see I hadn't finished configuring
bootstage for pytest for Pi in my lab. And when building with:
CONFIG_BOOTSTAGE_STASH_ADDR=3D0x02400000
CONFIG_BOOTSTAGE=3Dy
CONFIG_BOOTSTAGE_STASH=3Dy
CONFIG_CMD_BOOTSTAGE=3Dy

And this in the boardenv py file:

env__bootstage_cmd_file =3D {
    'addr': 0x2400000,
    'size': 0x1000,
    'bootstage_magic_addr': 0xb00757a3,
}

All three tests pass, with both parts of the series applied. Of course
Pi is not a great example as there's not TF-A in the loop here and
that's part of the problem equation.

And also, JFYI:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D warnings summary =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
tests/test_bootstage.py::test_bootstage_stash
  /home/trini/labgrid-venv/lib/python3.11/site-packages/_pytest/python.py:1=
63: PytestReturnNotNoneWarning: Expected None, but tests/test_bootstage.py:=
:test_bootstage_stash returned (37748736, 4096), which will be an error in =
a future version of pytest.  Did you mean to use `assert` instead of `retur=
n`?
    warnings.warn(

-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html

--=20
Tom

--2ZWLwbXGXXsC6eYZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbPVfQACgkQFHw5/5Y0
tyyfHgv/dGnUSRLvJLdtX3Km6qjIq1Lu9HgeMDyljS7g0FooIDfotGj4WTGXxXpk
EH6h9yZXC3zhtgDJvfXXgVaKKJ1ecqsxIURyIIanI9ML2KOvmiLh9GtQyrgzHU0E
CvsKdCrWL791+N7rQPOTiDicMrmphQd2M4nJqJol8vK3T5paJSSI7uTatWH2unCr
Wrr9CPo6cdHXVjMsGQ80Rdf6ruAVbB/YMPFMpOxockpuQG7bxckzgvyKzZDLngbr
hLcIvoGTw8jlVv2aea4osqtslh6NCyjq4piyczQfmZEnY6Obj8UGFjMpc+2Pn2bA
3GSGSVLCP4cOEcs1lmWH0iLmutvtSdfhMoaSeTqlB6iG6eTnL4DsQCoyZMdPimWF
JTRgwizrVIxYy8pBRXJGMapJWWDwAoG3MX6PYFUQK3l081OgnKpGO6u4teQBLuql
tqyvl/1Bst88DAGk0gRwBJzsQYz2kldW++BAIA8WNneNLuVPHnxurAkskXMaJWAr
O4qeW6PW
=s+Nv
-----END PGP SIGNATURE-----

--2ZWLwbXGXXsC6eYZ--
