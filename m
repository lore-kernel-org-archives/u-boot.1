Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624CDCA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6E0780DB5;
	Mon, 12 Oct 2026 17:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pcLZngD0dBCR; Mon, 12 Oct 2026 17:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8BA9480C74
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791827450;
	b=iSHrkG2i/pwYyOzcLnRJlXU5Ahfs1mj/6P1I0psZImRDSFFnyVkUYQIJCIFgtVt/CbBl
	 wyO9jFR3/uqtYAqxaq7lGwv9CiMGaQkruXYMtbIWAyI/S2lYtgWhWT97ZGmvmpdKso6+w
	 WiRfz/A+sjYa5Zy+KHZq4w3fvxSGXot+pKnKw6vCh7n8ikw1+eyO6p94OYxcGa8K4z2BP
	 3PCvmRRyC/Z1plDbhAKSU8gWTEr/JzhCLNxLRHc0Uolwc37vR3SHevWCX4rqCchFlVgY+
	 Yaxp4YAi3VVZTdReWlplY/GNWrVnp1FWl4cqadpmksxvKizNr7nzx60vQjKi5l+Fwug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791827450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qjOrQqY/SAx2KCeCiGnZCKR4/r8pNLgOxJwEvfftCAg=;
	b=Ih3cOnU0sFNPxrAr/CDIk7OxgZ6ZrMmn+wH7wws28STSvpKKUm/ISbJtwf88v2gOAIEE
	 jL+LcoV46Ut16x/AoB0Q/AunM7V9ZFU7iLvEc+2VdXfJosB+IJnl98520jNEvGRxa22L7
	 gQA0xe6lOryiyzO/Y0WvZHVPsSPRmQrEMhcXONUPDArJqMTIBTOw2UPa3ODwpdOAGlTZw
	 jG3OC6EthNwwP4mJ4wIcToqn2cTMjxZ3TuKXnz+RQ0S8uh2hFIBojURvAk4qiTDx9L8JF
	 EQrP+skppNbq1aunft0Bfo8/ocFMoYexD3j7BlaY/nxxB9ihUpK6PzogqqtNZRSk8nA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791827450;
	bh=qjOrQqY/SAx2KCeCiGnZCKR4/r8pNLgOxJwEvfftCAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iAftk8ViEnbmiSsNz6Z9Kd9Ypb1nq7h+EexhFML1dOfx2uuHJuzBiBGcdivu1L4Zx
	 yrp3OVBcmWs79BnmhcZKfd7BbMbS6GAA9IwY8IZ1JRdkrn7oqum4qngn6W9Ylg5KZt
	 Txpw6pER3B2caZwWjdB/7vrp62GYMIWjTWLdjSSuUVf0DIjfeDeCes/9HTSBcPhZpx
	 JXmwA3L3D0m49K01MW9RLto8+M4yAE2WrT1K2wD+Yi7UNfdwQ1+HtiRNR3/p0gKgUL
	 KPYBRNGxE7VrmVLtfhCBE+NObCsigar7Kapc2R7tmipiLCwG7KMIZgfAN7oI3WjNEB
	 QwIWGgNWTQd8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BA9480C74;
	Mon, 12 Oct 2026 17:50:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BBA2B380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD6D840445
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:50:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKi2ZH6C4iBG for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:50:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 918F34043F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791827447;
 b=BkrbGufSvO3kERJS/D6yzwn5FzELxN0AWQJA2HYUAMD90IWgZUQUQp8ZSlooMLlHr3E+
 tR975h6tfRopgJ8/o4d1fIWvGF3O+vRoQUmnt2rfwJ0QgEEwbCUH3glJ5/mAAkQeB6ktM
 0BnwmSVOYS6U0YdMNnJzeFToZ44VQe+DilNfE8fnjBKuON1frmG3ZkZSHbquyiRybsjpy
 f34Kffn9TkPsrHwIq+CVXvAgM6VPO7J1p4Q4vODmmRstxy3FwMHelrOmiuG1tbU93EmfJ
 03gxZNRqX/ZITkhVHcvmO18DdbkzFnwBnwVMAuqSVQNKXRNFncLYDNjjq5atq1l/6ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791827447;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=qjOrQqY/SAx2KCeCiGnZCKR4/r8pNLgOxJwEvfftCAg=;
 b=CMQq/HbBQL9KicLwCtlQXV+FU57Y3mID0l2Q5nfpPHieeve8msWQzxND0pXByM7INsby
 L53ZMyDSC+nMFZQZ0odxNQdSYiC5SoWUjfc40b8ZQENJUyzR4sT2qYmaQEUfeQmCvbF9S
 54BC0h9hN2PtkAXaAEgt+yhAwYkC9jH1WbUYilaQE5rNXecXRrKFpiKbkLANi84qcsaxI
 RlSeLmrKBSnAcvAAkp8Z6/Up6IVh0g2fh79v2NpCA0xP1Mse2R5weHUEiu13OfLfAGWcm
 Ua1HA15q5PS25jQuKUJMFRwRJ+ZVbuL6Tbp2X1ayCtFNuLotvvccmAsdgN+wdIGhBuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FJvWfoL4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FJvWfoL4
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 918F34043F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:50:47 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso410002a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791827446; x=1792432246;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qjOrQqY/SAx2KCeCiGnZCKR4/r8pNLgOxJwEvfftCAg=;
 b=FJvWfoL4ScGbRsTGzCw2i1KnY7jSahJhqdp86WxcERXZC8cWqqlXBLnOZNhBEes/hp
 n74IDo0UbtXvMgCrP3yukFbsBXsywi23xd8Wu6M3m7I753Vx0A4iv4Za56FE8QA6cvjr
 v06uIN/esErtUcQEDh5kMWisLzu6FyBuFkvBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791827446; x=1792432246;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qjOrQqY/SAx2KCeCiGnZCKR4/r8pNLgOxJwEvfftCAg=;
 b=2fS5dS4ON7eU9oZNlX4oZTmsMJzuOu9r/gApLscIvtlpLrWY0wKQC1jhHQqB6lBLFb
 wD2LHC/B1Uq/ZkLvqRzZIIMrb+K5hf8bQmdGS5SuxNE7739poiGZ2Oyo4UrXnxPsshah
 kU6WJF8NNscDWX2Hed0oFGn03xlWQHvnObXEu6DeC64Ow6wI6OVxTt4jtfCjh/zpGzA0
 2tQMoQ0xcBa6HvdyC7Fnrw0LY/BkeaBcDu0nHrNkFf6ekyLF7rWHnF6YhrYZRzNS/ZCB
 nHb901TEWe8yD7tVCbnsXgGCaGLb9Ay1Db0vNO9l55DKPO5ncobOdH2TNrTtbgrmyPwq
 ymYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGsXCpy1QBZVSPeyti29GSy+4P763SfW1O8j/F4RIuYfxdY4vgBC0qZzQB5ynghcjrx5i3tEc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLRA/eahYODFwIGmcSyf6AHhnX1kTzcFnIIMUQ9XtQx2ImvdWQh
 9KKa+yPf6fqY7zh7OBExggt7Ocs25OuVTDnaYZ2GRVSABEBYUZNcr5ANOJtYftdvYYM=
X-Gm-Gg: AYBFou2lSXnfuzy4BmjOx0u0Lms1kFylu2L5AU9MCIPDKkTZwKvNf5wtZaAQMwLkxdy
 nxuhBeZfcb+QxvapiS/H7aP1Bm+SEaigkAQ+aknsAmEqjjTb/uv767saGmft+pGHC9ZRYL3jVPt
 GPjZTTK7PMzIRsuxjoVmG5EKweHbiYP85CpC0E3kHirZ0jxTB0ILaJY1DiHOg7/quOmZ3Tokofa
 YcYzKkgPEaTVhYU8j/ALu0Ui0WVwQMrvW1DcveH6Ol7PoQBVdWdA/ueiDUmCGh+0wJKCeRX+j0X
 rgMB9aQIFIVZUncVLAexfg2O+FT3JbeZJUCG+VcCP2G2qaRjgFMlWoPSIEJph9LqTnlCYimb8Pa
 YbF8J62EhqH2rrmBlFOuCgbt7P5hRi8JgI1IriCJH1zD3pFhu2tux1R4nMBHp5fKNXGhyB4xO2U
 APgtar4pmDkLSH/8ROXTOLA9Zh5oiiYXbmjoGaibTc/dD8Yl9FuB+0OXClsTN5kT7XSwenIpG8u
 9cDUtWQ8yBVLwnrSm7pHz8kuOcvHTdA+KOB53BQtRXn4e6Eei6CrXrWacWD6TZvV0X5t1RSBuj2
 Tw1Tf4LZx692u08P9+0=
X-Received: by 2002:a05:6820:4d09:b0:6c0:7620:fccf with SMTP id
 006d021491bc7-6ef0f3ada9cmr6445838eaf.57.1791827446320; 
 Mon, 12 Oct 2026 10:50:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a858aa3esm10218094fac.12.2026.10.12.10.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:50:45 -0700 (PDT)
Date: Mon, 12 Oct 2026 11:50:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: Re: [PATCH RESEND v5 0/5] Add FIT multi-DTB selection for Qualcomm
Message-ID: <20261012175042.GD3722450@bill-the-cat>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JfUgWVvGH063Z9Tw"
Content-Disposition: inline
In-Reply-To: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
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


--JfUgWVvGH063Z9Tw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 10:37:49PM +0530, Aswin Murugan wrote:
> This series adds dynamic device tree selection from FIT images for
> Qualcomm Snapdragon platforms, enabling U-Boot to select the
> appropriate DTB based on hardware parameters detected at boot.
>=20
> Qualcomm FIT-based DTB format is documented in [1].
>=20
> The FIT image contains only DTBs, while the kernel is provided
> separately as part of a UKI image.
>=20
> The implementation consists of:
>=20
> 1. Hardware detection infrastructure: Introduces the qcom,hwinfo
>    driver and qcom_hwdetect helper to collect hardware identification
>    data from SMEM, IMEM and TCSR into a single qcom_hw_params
>    structure for consumers such as FIT multi-DTB selection.
>=20
> 2. FIT multi-DTB selection: Implements DTB selection based on the
>    aggregated hardware information. The code parses metadata DTBs,
>    matches FIT configurations against detected hardware attributes,
>    applies overlays, and loads the selected DTB for EFI boot.
>=20
> [1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/
>     Documentation.md
>=20
> ---
>=20
> Changes in v4:

=2E.. which was sent as v5, and this is a re-send of?

> 1. Drop the SMEM cache infrastructure.
>=20
> 2. misc: qcom: add qcom,hwinfo driver to provide a common interface
>    for reading IMEM boot cookie and TCSR SOC version information.
>=20
> 3. arm: snapdragon: add qcom_hwdetect helper to aggregate hardware
>    information from SMEM, IMEM and TCSR into a single
>    struct qcom_hw_params.
>=20
> 4. Refactor FIT multi-DTB selection to consume qcom_hw_params instead
>    of accessing SMEM, IMEM and TCSR data directly.
>=20
> 5. Separate hardware discovery from FIT parsing and DTB matching
>    logic, reducing complexity and improving code organization.
>=20
> 6. Load FIT images directly from a raw GPT partition and remove the
>    FAT filesystem image based loading approach.
>=20
> 7. Drop IH_TYPE_FATFS, mkimage FAT image generation support and
>    related documentation updates.
>=20
> 8. arm: dts: enable qcom,hwinfo on qcs9100-ride-r3, qcs615-ride and
>    qcs6490-rb3gen2 by adding the required qcom,hwinfo DT nodes and
>    board-specific offsets.
>=20
> Link to v3:
> https://lore.kernel.org/u-boot/20260417120951.3454249-1-aswin.murugan@oss=
=2Equalcomm.com/

The FAT comments in v3 were addressed. I'm not really sure the discussion a=
bout if
this approach makes sense as really was addressed however?

--=20
Tom

--JfUgWVvGH063Z9Tw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas0d7wAKCRAr4qD1Cr/k
CmTKAQC+nRTBKPaiCrhQ+I2hfvWyRC66Iv9AIs24MaCUnWtWgwD+PNGSdBnx3iVi
oMakXp7DjCo8N5hUzi3HTXdMuzFZgwQ=
=9Ldp
-----END PGP SIGNATURE-----

--JfUgWVvGH063Z9Tw--
