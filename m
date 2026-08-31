Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E0FC624A5
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 15:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A13180B96;
	Mon, 31 Aug 2026 15:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2ImnSXBqJ0n; Mon, 31 Aug 2026 15:16:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788189408;
	bh=OB+xPP3QyoZonu9uGRSoCM/TovTPGbYFVxZAdO8bAlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCIOBiKYbdPDbgdfqb4dAme4rlexnpPLb8aAYpb0JKEJsMhzU2Szk0mkRaGjyGs3z
	 NsfhP0NUaoDnJcM23rJIr4xVuggV2z1ByF/s4pPpA6SmBC1dsXyJmKYsGkNOaZs7KH
	 q7asWHvVxI/rbAivbl62gq0U3X/oFu5G/gKGUpLcWq8KgszhHrkJJnQB+K6m+utZTz
	 v2GOtCKG4VSHoOFMFCBnGCIo7LSBDXjwibpzTambS96F8/i0ZbXMZabKnvHPaSmPVd
	 5Ln0ozsi8KsyuSjnysmw06YWwTBwp4//BKqSetn78x3o0mHrOeoJ1lqQ7N3Z4DhKxb
	 xGUd3MF783JLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C615B80B6B;
	Mon, 31 Aug 2026 15:16:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35E672FC
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1EDD6403F1
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QKg64OlXaNlJ for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 15:16:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=X/5FyzJv
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33592403E8
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:16:45 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-459281bc13bso2863074fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788189404; x=1788794204;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OB+xPP3QyoZonu9uGRSoCM/TovTPGbYFVxZAdO8bAlc=;
 b=X/5FyzJvHtfwT0PStMemQzYFJ+Wf3uJDpKmYrICg2JilnRxkHQ0id2ftPRySkT/iPs
 6oeTsWeOCTyEpYR4pmxfDZa2WWxz6m9QmYuOX03/pJl+9AA+yIfausydstHxZVTsyVRt
 hEKMH27RCjMcjjAio4Uyotk0DKs1pn00lcGdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788189404; x=1788794204;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OB+xPP3QyoZonu9uGRSoCM/TovTPGbYFVxZAdO8bAlc=;
 b=DMwUrWC1rNHrFJhP4L6lZZAUnGOlo541Rc+IsCvIKLxXG1KFg6kjDHnOlgfzoc8wyt
 ttnwNJzzMfEQPaBEnupX1Y/FRXjC/HUT9f8S/MJplc421XmjodlVGzR/VIGETBZjHb0m
 BxvNi/WtjDyWU8S35+xNNYc95cW601J9UXCUxncnucY6E63kOZ4xoyhXYYVkOry41Gp2
 nNSwipjql+92ZvGoB/sgSXJjCwekTco7njWXD0gpnbez77ArACPlJggax3M2k8sIDqSJ
 FRXaxgkWMP9m3W0PL5m5Iq1Vqy5hRuN4IsTrDEpzClseui/YqUgTgRRVqbPERNL5tFAc
 Yrdg==
X-Gm-Message-State: AFuF++mWeLxx39+bZ9qq8HFkDrupVSBbyYTZbp84VyC8mWhrw0K7Ffid
 FCio//UrXgAml++aVCTJ7FOxt3W43W/eKhbwloF+S9fC+9sJEa/hnIlDex8e5czQkZIJkY0CAXm
 /AwcTPE1KtYJQ
X-Gm-Gg: AYBFou2nenPn7uLgjGWAaVjLmZEpZoM9J5A9P/SmJAwoYE5TcyJhEX42nvPXwa6VZS2
 oPmB2zhS+GHG9Y0Y1XsaNwVXJ7Q2n0HU5EaZ80eZKNSzO41p74BFiYxLUyz8vw4pbuWFFp1U3q7
 6IistMmLhLU6gV6F6AjPwRFgW2dfmRM3Gue3IB3bXfhBtV2JYKlkfEevqUPvHsuaQxNrYU7W1gh
 xDzKAFUemqo3Jue4flJ6o+jQvEZmiEnyPzgDculU1pv1U4bACh+geNi11w2E1txO1oCEqxfMyfD
 KeZvDoesP3iQOmbG58L12ZxPiBpfGxB1jbqHUXyct9bsf6PEZDB3uNB7o9lHVj2C9aifnCjo/PO
 L0dPYbrS+0olvB6eac1cnxV4GlakaHuYQxuWqixRYptQ+leUAnY7EsbmaBNMBK/wK5ZCMGaVO99
 w125sE257IeRejxk7Ya7BTybgW0v4XNCw2+gREiXBGYeWqQfd527MxUCZqFB9aODaSyKOurGgC9
 DrmqAGMKI9LxqbJSSSQW9QTD2Sr/7UGLE8ULg53qhrFJy8gs7Ycn/iDoDGgqXMwRm1p7sAApG/+
 9zow9+gPVps=
X-Received: by 2002:a05:6870:c282:b0:442:175:cea7 with SMTP id
 586e51a60fabf-46835a0778emr28985939fac.1.1788189404593; 
 Mon, 31 Aug 2026 08:16:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a2ef1e95sm10870194fac.1.2026.08.31.08.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 08:16:43 -0700 (PDT)
Date: Mon, 31 Aug 2026 09:16:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 6/7] MAINTAINERS: Removed files
Message-ID: <20260831151641.GR3959812@bill-the-cat>
References: <20260829015026.473134-1-trini@konsulko.com>
 <20260829015026.473134-7-trini@konsulko.com>
 <e71bb6a0-6f20-4d61-81a5-668408d8d7f5@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1H+a2GxEk/0d06na"
Content-Disposition: inline
In-Reply-To: <e71bb6a0-6f20-4d61-81a5-668408d8d7f5@amd.com>
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


--1H+a2GxEk/0d06na
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 08:40:23AM +0200, Michal Simek wrote:
>=20
>=20
> On 8/29/26 03:50, Tom Rini wrote:
> > Correct MAINTAINERS entries for files that have been removed. In most
> > cases this is because a given platform has moved to using OF_UPSTREAM
> > and so the local version of the file does not exist. In other cases,
> > sample defconfigs have either been merged or simply removed.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Michal Simek <michal.simek@amd.com>
> > ---
> >   board/LaCie/net2big_v2/MAINTAINERS             |  4 ----
> >   board/LaCie/netspace_v2/MAINTAINERS            |  6 ------
> >   board/Synology/ds116/MAINTAINERS               |  1 -
> >   board/altera/stratix10-socdk/MAINTAINERS       |  1 -
> >   board/atmel/at91sam9260ek/MAINTAINERS          |  1 -
> >   board/beacon/beacon-rzg2m/MAINTAINERS          |  3 ---
> >   board/embest/mx6boards/MAINTAINERS             |  1 -
> >   board/gardena/smart-gateway-mt7688/MAINTAINERS |  1 -
> >   board/gateworks/gw_ventana/MAINTAINERS         |  6 ------
> >   board/ge/bx50v3/MAINTAINERS                    |  3 ---
> >   board/intel/agilex-socdk/MAINTAINERS           |  1 -
> >   board/intel/agilex7m-socdk/MAINTAINERS         |  1 -
> >   board/intel/n5x-socdk/MAINTAINERS              |  1 -
> >   board/khadas/khadas-edge2-rk3588s/MAINTAINERS  |  1 -
> >   board/kontron/sl-mx6ul/MAINTAINERS             |  7 +++----
> >   board/mediatek/mt7981/MAINTAINERS              |  2 --
> >   board/mediatek/mt7986/MAINTAINERS              |  4 ----
> >   board/nxp/imx93_evk/MAINTAINERS                |  1 -
> >   board/nxp/ls1012afrdm/MAINTAINERS              | 12 ++++--------
> >   board/nxp/ls1012aqds/MAINTAINERS               |  1 -
> >   board/nxp/ls1012ardb/MAINTAINERS               |  3 ---
> >   board/nxp/ls1043aqds/MAINTAINERS               |  7 -------
> >   board/nxp/ls1043ardb/MAINTAINERS               |  6 ------
> >   board/nxp/ls1046aqds/MAINTAINERS               |  7 -------
> >   board/nxp/ls1046ardb/MAINTAINERS               |  7 -------
> >   board/nxp/ls1088a/MAINTAINERS                  |  9 ---------
> >   board/nxp/ls2080aqds/MAINTAINERS               |  4 ----
> >   board/nxp/ls2080ardb/MAINTAINERS               |  6 ------
> >   board/nxp/lx2160a/MAINTAINERS                  |  2 --
> >   board/nxp/mpc837xerdb/MAINTAINERS              |  1 -
> >   board/nxp/mx6slevk/MAINTAINERS                 |  2 --
> >   board/nxp/p2041rdb/MAINTAINERS                 |  3 ---
> >   board/nxp/t104xrdb/MAINTAINERS                 | 13 -------------
> >   board/nxp/t208xqds/MAINTAINERS                 |  5 -----
> >   board/nxp/t208xrdb/MAINTAINERS                 |  1 -
> >   board/phytec/phycore_am68x/MAINTAINERS         |  1 -
> >   board/polyhex/imx8mp_debix_model_a/MAINTAINERS |  1 -
> >   board/renesas/blanche/MAINTAINERS              |  1 -
> >   board/seeed/linkit-smart-7688/MAINTAINERS      |  1 -
> >   board/sunxi/MAINTAINERS                        |  2 --
> >   board/toradex/colibri-imx6ull/MAINTAINERS      |  1 -
> >   board/traverse/ten64/MAINTAINERS               |  1 -
> >   board/xilinx/zynqmp/MAINTAINERS                |  1 -
> >   board/zyxel/nsa325/MAINTAINERS                 |  3 ---
> >   44 files changed, 7 insertions(+), 139 deletions(-)
>=20
> Perfect. Thanks. It depends which tree you will apply this
> but I will keep my eyes on it and will rebase my changes on the top of it.
>=20
> Acked-by: Michal Simek <michal.simek@amd.com>

Note that this replaces your series that updated the general MAINTAINERS
files. The series to consolidate the various tress you own still applies
on its own and you should pick that up when ready :)

--=20
Tom

--1H+a2GxEk/0d06na
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapWazQAKCRAr4qD1Cr/k
Cq3eAP4kat+vSQq1yA3qv0+3Pqctm/d3qCEN0pzdmeMkZCI2ogEA2GvcQYLINdXd
IKVicjMiM86z2tJDUz+qvyuRCSgxIwo=
=jLp1
-----END PGP SIGNATURE-----

--1H+a2GxEk/0d06na--
