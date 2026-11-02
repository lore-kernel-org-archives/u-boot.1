Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA5606A33D
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r/DaQ3rv;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZWd+KT3K
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC40D606E9;
	Mon,  2 Nov 2026 19:59:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U78csHioguuS; Mon,  2 Nov 2026 19:59:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D23060660
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793649547;
	b=oH5/wJwK4reYH974OI7v89XN6ty+01Rrvw0QHSHDs1KCmFDkY45V/yFWc3+MzRyejf2f
	 xcVZcBcmy0igMB1Cml91imm2S5PppAqFkB3Oq5980nS0MB1c/+axtXgQcJme5AxcnaB6l
	 C7KQXXu3x6uXf6TnMxn7+xfQjd++GCZGDHiks/ThA8dZCxXf33w693D6PTSVje9tZvJWb
	 9ppTZqxxhjgc6oons0+sm/uczsNQlT6LJDqFqyNJrf6QKxk4Z+h7Oo+pLP0ZDDV47OLP3
	 P4wTkNlItKQccJSHOOke45HjR7h6CinPbkzNIbBnzSK+5ZlYRTxHDGvoXl4kBQkHHhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793649547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LNzSz13YAVqBwkJT1yVdONV0loxOAaEjwL5lPeP2WRM=;
	b=e2X+ntBU0lxS8iu3HMn0WYI+aIT2Neo1K2acfawv5sFD2ulyPJLicVsUS+OBzDgRMSPk
	 r23bha/aDLDuywa4XflhyfGYSGypO5yBmyvmM6Bzp4rCOSqEFd7CbNQb6HdRLCyIDMIHs
	 SkyQueY1wwfMvjjxzNr3wRemvlT4NOKopTwkT8tk58XcpPN/ZqrjfPq3R+iPTMC6zAi4E
	 Bm36CdpE1TC+0h3WFDVPGq3zUTgoA+vS/RU9h+bM3RctVBjYWwXNt9oCKaF+gIlLGqh4w
	 YgBThrUnDquph2DgOHoep8faIud37bkxnaGf7y9JCHkPhyLl+4yHJKXx+EnUh0JcUtg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793649547;
	bh=LNzSz13YAVqBwkJT1yVdONV0loxOAaEjwL5lPeP2WRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r/DaQ3rvB54U0t1yogtm95OvoF1aoHcuCWSel3MgB/gUPG9mhO9la6ZjKeT0EixPK
	 rtHBfgdh/aG7+vS9BCNN/61U3uGUor+87EJ5vZ8H9XyqbNvdygFWXZaZGACUAM+sDX
	 spC5KfBA0aCFQZ6bJhGr1yc69xpZj/b+MoKPlheRqlFUW4fsK8imC6DE9PgtqMUW3i
	 FwC486XvBueeR/P4U89JZ47t4ZTiS/weLs125OJxGq/Rbu5jzpjBQgRhbRnw+L0mVP
	 dBLEiF05CoR4QSO2QPjKlS10yk02683yfx9DsbzuUvYNUz2gpCsja47CSLQgfrzO2n
	 OhtkJZlNJ6K8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D23060660;
	Mon,  2 Nov 2026 19:59:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EBFC120
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FDA040552
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5DK8uow1bd4y for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 19:59:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 210D84054A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793649545;
 b=T3+C9nInBbfnqVsMRtoxp9uiphbDsl7AM9AS78Cn0p1saY0Lmab/B5mpgRLok0dvGU2x
 V5hw2SI1z7tVzdgP/wRi7DCimNYLzMk/vPMXpwTGorvMdKJ3JDDa8ChnPQUbDVVoSCMzr
 XYtXCfElttobVN87tanbfEmY+UAFXervPsZSBQnAaYzLnM+qEnxErjooC98WM7C8SF8H7
 BL3AHqtSVKr7nuu818eYZv1wxVK8H5/gSkT9WPFZUYA3u8zqnBo4oF011hEQEg6ny7RRX
 t1uH6hkwuolCC4PQ3QXfjC3DvnE227uVh38dIDA9JxCQ5+e7PvVk1z5KqBDk0PSWLqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793649545;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=LNzSz13YAVqBwkJT1yVdONV0loxOAaEjwL5lPeP2WRM=;
 b=qQUpH4VSi01PfU7p7fSVkrD4us7SRjBFEiNroK8U+DpqPgcLNNoFoylXxzsUossjsXAn
 1DEoIYvENnSwuCsN76cFs6o6lzqavQONd2/LqVNSg6POh7nL6z99ui/GAhk/FFECGpPIB
 wN2pY4aaFaoH/vqEKHC3mAF3SI0OKLH0zv60nCLbqF8BvNQxnjJPDqlaf8CqsXJpRfPg2
 LMTK6z04zVd+FAtKvL1wvxQTgIEft0tETD+Th9i18jjdDukkP59M3nLypgOIANaqZkeRP
 h/CSC/Y2ptQdPlTEdLYXmwJh2klT4PIm5T4H/BpZHX/cwwlJOTJkj8l78VMojdXS9oQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZWd+KT3K; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZWd+KT3K
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 210D84054A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:59:04 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-539edfadfa9so1565337b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793649544; x=1794254344;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LNzSz13YAVqBwkJT1yVdONV0loxOAaEjwL5lPeP2WRM=;
 b=ZWd+KT3KSa0t0bDg2qFgLK3yPy8dcWsm24p795/3RXaEWZnEX5ZxBUDLCf9DXGY1D/
 TSlGTa2/H7S27bnTEoPee9nWwGJ5aCGPyC3SLURe0obGVlEuEz61SKsJRR8YXYGRUlIa
 FgqJGs45O/OcZh3yDpB/7D2EcYFW2NfsxLpZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793649544; x=1794254344;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LNzSz13YAVqBwkJT1yVdONV0loxOAaEjwL5lPeP2WRM=;
 b=x2t91u76YO4xxsGXmdO46/+TbISjD4Gn5lr3D6WxRE2epgzpuOXIEg4XuEq6N2eAO7
 1Q+BZA0HY0HT9aS0I+qSGrpPaIQpmYgGuiBhJp86UmTBD+hUisHHS+9yyYpNLcKTaNDZ
 qNGxRXDgEufpHn/SRau4j+vLaiP8FUZp5Jc+yBIYb/wrBssTC5slQEeu+gHcsmk1ZSBh
 /wwwk963suQpmc/T/5HxH/0fjnsaixSeOWSxsu13+LLsN8Bp0YrxWp5oanz4J3iwsvkX
 FtxfSe7z9vXqqBMwuXXZW3kJFv7AW6dselGo7ujbtVhOe84+XlZGIVdnK8BFxsiaog5m
 JRMw==
X-Gm-Message-State: AFq9FYI37BxvEzusmZfpzL8PDAkHNaqTEWPMMRZVxYsKJzp1tz5fnYAS
 qbggDLmjuW8MvebGpap8l1XOmPrsxW3PLHno3OH353WRj8gQ+FzR9MXFiNj65Ookoqg=
X-Gm-Gg: AYBFou3mhqlaO3fIMtr0osn8yFnnn4OwlIEd1f/aES6htalgKPkMoAQMlDr4ifXQIsp
 mUH2pkNT2c0+7iYes8vNFNxUa3BiMj5d0mny9KWQd7W93iNsL6Hq8VjsPAuP0PANOwJsZY0eC2m
 kzUXVpUddKPhOMEWypsKsgH8vTC0xAooW30vtU1iaOuW7W4QffKmmaEH7yVX253QCiUNtSNX9bj
 ASgUzL98sMsmCUszdZ83W7jtrMdU4moMf/q9hYbluFYCTMedKF1iweRK07es20rCWmnHKoq8H6g
 Oc/tCWv+llFlTHizNXSRtzLSsTzMiwSVYpLsLah/AMzz/CkeIGtMvj9sOuAhILwBkbh4zJFhIXF
 lVGRQMGHx4jIFYPCEqXpaoWGsLPnkI+mobiUNPpM2xEpOMrsuBTk8XOIyW4skKpcJcbb7BIDMle
 0WU2aP+ONXQIS5Umo5nplkhIR5Bhpt/zd/wJt9AljVTGvZJQuC65eLnWdRze+wCFsdjRowSYV0r
 gj49fimnsGDPfE2Q1E6i9BRn9K6iwCAqyLYu7oe0hAjPC7sfC7/B781q8CvqjeACJ8O5owOKbjE
 WnTxC/3mD1gGWhIJ5rFbEOXkWafDgdf19za5FY2cw1IcDBe41ns9lO2JjSsQZcEo4r/z7a8gcSh
 g/Pc1zCyahKRYbkEedwHvHzb2LQ8NKD03hlmaFT36rN72gzwqeT66TRl81ReBbABiL3LFqMMsQT
 eVFr7jjaUSVsXeaST5wz19hLGUGzd2+Q==
X-Received: by 2002:a05:6808:130a:b0:53c:7298:3591 with SMTP id
 5614622812f47-5640db0e29amr7200982b6e.1.1793649543693; 
 Mon, 02 Nov 2026 11:59:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fdce900sm9157353b6e.8.2026.11.02.11.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:59:02 -0800 (PST)
Date: Mon, 2 Nov 2026 13:59:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 0/3] Enable U-Boot SPL support for Lemans EVK
Message-ID: <20261102195900.GA506741@bill-the-cat>
References: <20260928-spl-lemans-v4-0-007635cc4667@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xtRZFEvDx4i4K7F6"
Content-Disposition: inline
In-Reply-To: <20260928-spl-lemans-v4-0-007635cc4667@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--xtRZFEvDx4i4K7F6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 03:58:13PM +0530, Balaji Selvanathan wrote:

> This series adds U-Boot SPL support for the Lemans EVK.
>=20
> In the Lemans SPL boot flow, the sequence is as follows:
>=20
> PBL -> XBL -> U-Boot SPL
>=20
> XBL initializes DDR and then hands control over to SPL. SPL loads the
> TFA-OPTEE-U-Boot proper FIT image from a UFS partition.
>=20
> This differs from the generic flow assumed by the new Qualcomm SPL
> architecture, where PBL loads SPL directly. SPL initializes DDR using
> QCLIB and then loads the TFA-OPTEE-U-Boot proper FIT image.
>=20
> This work is part of enabling SPL support on Qualcomm platforms,
> specifically targeting the Lemans EVK board.
>=20
> This series depends on Varadarajan Narayanan's "Qualcomm ipq5210 SoC
> bringup" series, which introduces the mach-snapdragon SPL architecture
> used here:
> https://lore.kernel.org/u-boot/20260917-spl-v10-0-3e83dcd239f0@oss.qualco=
mm.com/
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - Remove memory node as now the available RAM regions are taken
>   from SMEM
> - Link to v3: https://lore.kernel.org/r/20260921-spl-lemans-v3-0-de4b5432=
0c71@oss.qualcomm.com
>=20
> Changes in v3:
> - Rework the series on the new mach-snapdragon SPL architecture
>   (board_spl.c, fit-handler.c, qclib.c, pbl-shared-data.c), replacing
>   the monolithic arch/arm/mach-snapdragon/spl.c and the
>   SPL_QCOM_BOOT_FROM_PBL Kconfig option this series previously used.
>   Lemans SPL support is now a board file with strong overrides of the
>   new architecture's __weak extension points.=20
> - Add board/qualcomm/lemans/spl-lemans.c and include/configs/lemans.h,
>   replacing the earlier SPL_QCOM_BOOT_FROM_PBL-gated code path.
> - Drop CONFIG_SPL_FRAMEWORK_BOARD_INIT_F from the defconfig as now the
>   framework board_init_f support is removed.
> - Link to v2: https://lore.kernel.org/u-boot/20260615-spl_lemans-v2-0-d15=
746f4a64c@oss.qualcomm.com/
>=20
> Changes in v2:
> - Rebase changes on top of already added arch/arm/dts/lemans-evk-u-boot.d=
tsi
> - Link to v1: https://lore.kernel.org/u-boot/20260606-lemans_spl-v1-0-ead=
97dd5b515@oss.qualcomm.com/
>=20
> ---
> Balaji Selvanathan (3):
>       arm: dts: lemans-evk: enable SPL support for UFS and dependencies
>       board: qualcomm: lemans: add SPL support
>       configs: qcom: Add qcom_lemans_spl_defconfig for Lemans EVK
>=20
>  arch/arm/dts/lemans-evk-u-boot.dtsi |  51 +++++++++++++----

For clarity as I try and clean up patchwork, this series needs to push
the dts changes upstream and then be re-posted once we're either on the
correct devicetree rebasing tag, or can cherry-pick from there the
required changes. Thanks.

--=20
Tom

--xtRZFEvDx4i4K7F6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujrgAAKCRAr4qD1Cr/k
ClfiAP9atu8j0Kft5/IqTmRH5iemPzg3AHM1VL7Ism59G4gBZwEAt7nn5djBlpmN
moYcaG1YyhjMFZ1zoDqYF1v6tTwH1ww=
=iZO9
-----END PGP SIGNATURE-----

--xtRZFEvDx4i4K7F6--
