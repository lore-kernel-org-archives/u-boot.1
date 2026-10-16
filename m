Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165ADCCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 16:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15DB360B1E;
	Fri, 16 Oct 2026 16:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hf_S465C-9hy; Fri, 16 Oct 2026 16:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0331D60AE1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792168069;
	b=o2Bs2Xf7O5S3Y+GntlaYrIxP6HhSoQ5fV8cfch1FTxpRMgq5uCf7mds9KBimQvmBqFdF
	 NHmF8NAXruv2ut2d8XK3Eidqlq1iizgo2JKIqN8ev0Ifigu4NOl3eHOZV3y5PP5b/IAKy
	 DOg4EGP+QtqqpkcBCDaZY8nhun6y595YuLjN2EmWo5Hz1pJF151TFO+8M4EJvpNgb4la8
	 E+ZP/PVmTcU2T8g6vsQZw+k1P65ownYK1/mJQLGa/3MOhZFZlAABKK8nTykhCXyq+TseT
	 5feCftevVk396UDgj/2EmpaDU91Rpkzxsx7QVeAOshsJjZQRJCh6WS6HkYr25I03RWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792168069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XPpIhGFB+GePd+IITmZyviSytw1OQySoc9xFfHZ2cM8=;
	b=nVvS940Ds+3ALeehUlF5JodVK+zWYWH6yV9v60lzZQTQsBHnpspZnYfP4Uo4QCKe2w1i
	 FeON+bHy3NMcxTSoL/BwoiNTWlEuAGVcECR6Kv6xaivIeYqIo/KsmTzBmiG58HfFryjyW
	 Jdg8RQwjdrDTJsrqI2tYqV0xq4J5kHnKCXjwtQkdirE/OsXlCZuTsstIkUcdfhFEXC8+J
	 YAZHz68azgiYSB89GYdP19S1s04Y8LEgNza/dcbHlSbsOVtxU6/mNaixALE514eFngVBu
	 gHww2cyk+69L5tWPrGraYn3BTDM0yLjjiqDhBAzAI18BFEi4/gQipRnHBxi86SF+oPQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792168069;
	bh=XPpIhGFB+GePd+IITmZyviSytw1OQySoc9xFfHZ2cM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tYXDLZMJlaGJl0UhRBcaMSQgVEvBVXibArwrike9c3F5y2OoY4OTfaAb1EvW5kExj
	 2VZ8UVA0P6/oU8mTcvKwGmjBwKDVo8dtUlSoOZzk+Gc3qZ7TyIvfXTAExES1WI/81E
	 l8AksolgSJWOqQZBIdXOXBXRDYxN0BucUXhexMPpBlnGxBHBPCqbi6WqP94BA7jlPP
	 ERV7n1j/Icyan60xm++JWYh2TA+3p8mBCeNqcZlbSN/6gyo0eaMof+pW+Nqa/hxkyQ
	 MRaI541NI0miSrxGVz7o3D87nlZBeogtuMvi4Al2o2EOYPIz+MdDekbtMv2MJ4C+Y8
	 KvtvAjuiNTUnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0331D60AE1;
	Fri, 16 Oct 2026 16:27:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E114A7AD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6DF340087
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 33timpXhpSHn for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 16:27:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AC23840042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792168066;
 b=VBN+0C9Fg0LY6DNMRIs4scE8DawKyG8ZaqqiK6DoJr4S9eGNQ54UH/CbBrxMKVCpNzAS
 Fkg4Rwgh1t26RAMM+ZYqNwFV0JUvE4E0y24e3MYTqi2wazAsAnferXPo4oBiDfbwwcj4p
 diDWNVhj0UThF3BrcDppITwGSlMV0lfOqLqeIwszVBy1jibe/kRBrMK/yakeaoijO6zH5
 Rw2EvkqZEAG7pgh3p5WqcyEzsl8LmEBrS+Udgr4rWQ2WTBIeSbU6ap5bkGW4x+vjovbHo
 Uy8yHWKcvM8m4Iq4XCVlC7NEJk5NfJCmbQqqG2Pl5oUXJaKWPJ/DH4+KdkpUDlIas4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792168066;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=XPpIhGFB+GePd+IITmZyviSytw1OQySoc9xFfHZ2cM8=;
 b=CMCq7KOeybuM2NfsOKdSo8iCCdCXgvCB1lJ4vrDypprLAIW/SmYtwAfeLJnLyBYjqItq
 LKXLqnunRmaRBux34vUsAHkQkmzGdxHAQIphF1PkYNFlFkYCwoRwtLCZlleBmIcwqANvi
 eg2jLz5VJF76eieiycz0/SDVmDqpvf/ZDMVTI1NS2/gG5Y3YUx9in6yAfA5HdTiUT2jef
 SV0NZHisF92pv606ET4/g4VCJ9u3WlBEXFTumDCsSVPJqg9fsqBHD2zFFOooNhb+SxtRV
 +0sr8MbCnk4JHGNDauBYf/W6Awna0XXtRnuEAyCxZZJIEnMDno+t4GSnBHpCpo7eN0A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="jv/j345I"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jv/j345I
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC23840042
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:27:46 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 006d021491bc7-6f9b24c99b6so48905eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792168065; x=1792772865;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XPpIhGFB+GePd+IITmZyviSytw1OQySoc9xFfHZ2cM8=;
 b=jv/j345IwbTmRRusMqqhOghJ3TRH+CNaRn1HGIYv6avXHSyag6FNZwTziG0IIVMuB6
 FsREVOpN1eXnPJZc3E1DgeDuc+wwVu4p3yRF09LI3yu0pLKqZeeem9x4+joA2/vcJeQ4
 diHaPoE7RRq8GfL/HQdJONDkGX2N+pASV1Cnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168065; x=1792772865;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XPpIhGFB+GePd+IITmZyviSytw1OQySoc9xFfHZ2cM8=;
 b=JKEZOQXz3TzTsBVxRhqUFT1nnBWdAT3NnRy5oLFAnN1xQGPYGMi5PkhtyJtn+PebUG
 TLEpHd0TQmQaCMzcAl+6cwWBzniXin1lmZ8ottREsfHedCUqQjFWu9yK08IXXJwYb/C/
 +6TpgMmp6f5E2aC3Lib9BePnafBL87OGXLC7VDsq9UlMulP4+KqDBcch+Qv7CMh3yRUb
 TUmI97gCLE7WC0h6CxfdrAdGlN3F9QDSX80ucawmPYaBmEBbX+f8/vSO+P+J25vWuRiI
 Mhs/vyo2EahihxelU4ENCitPl0K8S4HPehDbzzDbFYOzKUys5MpN8pFvFEKpUu2sB4Lu
 t1XQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7p3yNaXmIEDSjMyZvqSfEuqg4oyMG1zE2MsugOQE69H1nrMVYPlzb4mVIVI/O8eZ3cIXDdJ8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYINX0CA+e+8jI7NgeczCIfPdxtg7J3J0e5jcuQtkpZi4OF6nw6K
 X34SqkJLxhvj3VT+zymScZxnYJJuXI0lpX9ayesu4tZVOqd3qTebqnOdodpmqC/iW8U=
X-Gm-Gg: AYBFou0PbULZmWCuJjdlRPeBpLDiGFDaBF6d2WwAKoPk7klq0TyfRrrTzxxaadaxCUi
 NiYLWyZC2iLSmPeTZZdblFlzOwTU8vrSiuSET7kmjRmGArJt6g5SlIv6BBkt8ofDydOABdXa+/m
 uFL2CQjCQQsJc4tmNBYWpG7OQOGhXr/fTtKYl1L7bt6DP6v/FewI/ozz7gRtUVRf9br2WGf1vna
 QCVxhA2TJJRpWXImU//uCjJ4oZIM4dgP/oN1mJdbNhn9jNR7JXbg3wOVOMIOjzPoSywcgTTfLc/
 RIZXjEm2enPfaKDVJL6itKAWSEGuhSkRGMNhRQNjFaVRM4IO1Iv0IMAR+h0I/Dr5OIytM4g8uUi
 OrPq3EQUNElF87DqAY0gqxZxFYmhDzlU9kCcbqzQPPjKdsdsfYFO+Mcp5iDHyVAtcZylDjVvy9t
 Whj/V0OS+w4shnS8NoQ6+Mlyv6HekElZxVNB6JvanWVCjW3YbGfPpbi6kY6I9cu7GYLGPZYlJv4
 THKK37kEosmasSiyIDI/n9vROUsxM9pLsxR1CYzihypKGU6haGr2F17Gw8oy6EPUNCCeLzA5R1c
 tGvjuEJsLBSQJuZlEgjCFM7QZqWG4A==
X-Received: by 2002:a05:6870:6b95:b0:494:7af4:954a with SMTP id
 586e51a60fabf-4a7575da97fmr412784fac.8.1792168065182; 
 Fri, 16 Oct 2026 09:27:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b7741desm1999433fac.17.2026.10.16.09.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:27:44 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:27:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: Re: [PATCH RESEND v5 0/5] Add FIT multi-DTB selection for Qualcomm
Message-ID: <20261016162742.GK259661@bill-the-cat>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
 <20261012175042.GD3722450@bill-the-cat>
 <6bff4593-8182-4524-be00-6963ed9330d4@oss.qualcomm.com>
 <20261013150307.GB4042005@bill-the-cat>
 <atIVfAF9YZ_Ocp7S@sumit-xelite>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UI/Pu/7U3laOR2aQ"
Content-Disposition: inline
In-Reply-To: <atIVfAF9YZ_Ocp7S@sumit-xelite>
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


--UI/Pu/7U3laOR2aQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 05:45:56PM +0530, Sumit Garg wrote:
> Hi Tom,
>=20
> On Tue, 13 Oct 2026 at 09:03:07 -0600, Tom Rini wrote:
> > On Tue, Oct 13, 2026 at 12:50:42PM +0530, Aswin Murugan wrote:
> > >=20
> > > On 10/12/2026 11:20 PM, Tom Rini wrote:
> > > Hi Tom,
> > > > On Mon, Oct 12, 2026 at 10:37:49PM +0530, Aswin Murugan wrote:
> > > > > This series adds dynamic device tree selection from FIT images for
> > > > > Qualcomm Snapdragon platforms, enabling U-Boot to select the
> > > > > appropriate DTB based on hardware parameters detected at boot.
> > > > >
> > > > > Qualcomm FIT-based DTB format is documented in [1].
> > > > >
> > > > > The FIT image contains only DTBs, while the kernel is provided
> > > > > separately as part of a UKI image.
> > > > >
> > > > > The implementation consists of:
> > > > >
> > > > > 1. Hardware detection infrastructure: Introduces the qcom,hwinfo
> > > > >     driver and qcom_hwdetect helper to collect hardware identific=
ation
> > > > >     data from SMEM, IMEM and TCSR into a single qcom_hw_params
> > > > >     structure for consumers such as FIT multi-DTB selection.
> > > > >
> > > > > 2. FIT multi-DTB selection: Implements DTB selection based on the
> > > > >     aggregated hardware information. The code parses metadata DTB=
s,
> > > > >     matches FIT configurations against detected hardware attribut=
es,
> > > > >     applies overlays, and loads the selected DTB for EFI boot.
> > > > >
> > > > > [1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/
> > > > >      Documentation.md
> > > > >
> > > > > ---
> > > > >
> > > > > Changes in v4:
> > > > ... which was sent as v5, and this is a re-send of?
> > > Yes, this is a resend of v4, which was sent as v5
> > > > > 1. Drop the SMEM cache infrastructure.
> > > > >
> > > > > 2. misc: qcom: add qcom,hwinfo driver to provide a common interfa=
ce
> > > > >     for reading IMEM boot cookie and TCSR SOC version information.
> > > > >
> > > > > 3. arm: snapdragon: add qcom_hwdetect helper to aggregate hardware
> > > > >     information from SMEM, IMEM and TCSR into a single
> > > > >     struct qcom_hw_params.
> > > > >
> > > > > 4. Refactor FIT multi-DTB selection to consume qcom_hw_params ins=
tead
> > > > >     of accessing SMEM, IMEM and TCSR data directly.
> > > > >
> > > > > 5. Separate hardware discovery from FIT parsing and DTB matching
> > > > >     logic, reducing complexity and improving code organization.
> > > > >
> > > > > 6. Load FIT images directly from a raw GPT partition and remove t=
he
> > > > >     FAT filesystem image based loading approach.
> > > > >
> > > > > 7. Drop IH_TYPE_FATFS, mkimage FAT image generation support and
> > > > >     related documentation updates.
> > > > >
> > > > > 8. arm: dts: enable qcom,hwinfo on qcs9100-ride-r3, qcs615-ride a=
nd
> > > > >     qcs6490-rb3gen2 by adding the required qcom,hwinfo DT nodes a=
nd
> > > > >     board-specific offsets.
> > > > >
> > > > > Link to v3:
> > > > > https://lore.kernel.org/u-boot/20260417120951.3454249-1-aswin.mur=
ugan@oss.qualcomm.com/
> > > > The FAT comments in v3 were addressed. I'm not really sure the disc=
ussion about if
> > > > this approach makes sense as really was addressed however?
> > >=20
> > > Yes, the FAT-related comments from v3 were addressed in this
> > > revision by dropping the FAT filesystem image-based loading
> > > approach and loading FIT image directly from a raw GPT
> > > partition.
> >=20
> > Right, thanks.
> >=20
> > > Regarding the broader design, the reasoning for using a
> > > DTB-only FIT was discussed in the v3 thread [1]. The intention
> > > is to support firmware-side DT selection while keeping DTB
> > > management independent of kernel packaging, matching existing
> > > Qualcomm deployment models. This is intended to coexist with,
> > > rather than replace, approaches such as UKI DT bundling.
> > >=20
> > > [1]: https://lore.kernel.org/u-boot/afSXa7q7hJC_ZW07@sumit-xelite/
> >=20
> > Yes, and I'd appreciate some of the people that were discussing things
> > in that thread chiming in and saying they're happy enough, as it wasn't
> > clear to me in re-reading the thread yesterday that the discussion ended
> > with agreement and instead just stopped.
> >=20
>=20
> As of now the Qualcomm subsystem maintenence is in really inactive state
> as you can see from the list of patchsets even carrying review tags are
> missing custodian attention here [1]. If you remember it from our earlier
> private thread with Casey and Neil many months ago, the maintainence
> situation hasn't improved at all.
>=20
> Even as a reviewer for the Qcom subsystem, I have tried earlier with all
> the reviews but patches were still floating on the list, which just
> demotivated me from doing further reviews.
>=20
> I would really like to get this maintainence situation fixed. Would it
> be fine with you to accept me as a Qcom subsystem custodian with more
> people from Qualcomm contributing as reviewers?
>=20
> In the meantime why we decide on that, can you help with picking patches
> which have been reviewed directly for the Qualcomm subsystem?
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/list/?delegate=3D151538&pa=
ram=3D4&page=3D1

I don't have a problem with (and a number of our SoCs do this now) have
co-custodians, so I've reached out to Casey.

Since you brought it up in this thread, you were in the original v3 with
questions / concerns about the approach that I wasn't sure if were
resolved.

--=20
Tom

--UI/Pu/7U3laOR2aQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatJQfQAKCRAr4qD1Cr/k
Ct0CAQDl1mLag1EX3CnPgAfahQOC5B19EkrFM+60OGldOqubPQEA8WMa2JQFltG7
cmFScCEmesSk136/LmFmcupYYMVHKg8=
=11/i
-----END PGP SIGNATURE-----

--UI/Pu/7U3laOR2aQ--
