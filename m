Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF9CC88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CBF740509;
	Mon, 14 Sep 2026 20:09:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jRNFDkMGmPgQ; Mon, 14 Sep 2026 20:09:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8D7C940511
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789416561;
	b=PBGJ6ciay2fhbfxtZjHiH0KC83lViFIVR0uYu2xrJFEWsaWQe5t2/j+071UXzsggH+Mr
	 OCxMCY2udAI12i0j9zuQagZH90VQnuzcmuYFWYjU7NQxtGcFSmC8u4n7UGh5iKPrY/HM2
	 vJ/UpOestW8vxlQNhRMpznzfuHiCfHyIbuKPgtr3rHYxYrLb1QzvSu/JyfJ0Toj86Iykt
	 kOWLjuU67eNp0KfjzuNoGn5s5YzSNhUmNpLWzlJ6CYKANVWB79MLafFCLkIb/f/EExl08
	 rFWbALyvnRYzXwoyBmz1VhskIR4RBTeTTuqVm8FlYOjPZ3EssSqGfPy6fv7m+RVCCuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789416561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Z+FrXrxYPQ44QZiKEt1/sxFjd3PN3YuhObeKExjvrSw=;
	b=ZAvOi1ndsQjHpIAy5rSGqzxnoCVjAOQ7AbGKVFiDJaEfiPQLkntH7dxLeO5vQlzli4DB
	 Yzs/mij51kZUnEx2pYE/exIIk4xpLru8t+JlOo0CL9LhV53C6oJ1axHS/gpr0emc8xFEm
	 j1oRMLBBXk4dAkwImrZGE43zmt3Y0TYZiIeNX0WHdhdvel7zbQoGl4183wBhLkcbl9gbs
	 XEfMi9wbKT8z3sSWshEX6obYxplhXFWGiSNo8/w26smkU+4MFZdsMbZz47apI+PSmkEMC
	 vhkSUK+7owmkL6OGcovBHOad9zyPx8qqIqbD5w9vbIwmbXwl/TV6LLpgd99t5nEuNZw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789416561;
	bh=Z+FrXrxYPQ44QZiKEt1/sxFjd3PN3YuhObeKExjvrSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UskAGwU1qMr3e8LBknc8EuaubB+lJNRxX4cn02CT4vck8gVi+VF/rUkwPTGdDejPl
	 TYbMfT/KeBgctsg5ww00+BMe5DTQKo+ecBVegFikiNVJpa2iXAzZTn2scaOz4VTsiu
	 /nZunb5leIVAmMCJFCHEMBOk7bS17QhX6nsAPYH48QN2wdWg42cdKPiL8jGRSmu56V
	 ODrr0ZjOIiwfPNc+YryUy+B7VGcw3PETyRkD17kRYed2g/cjsETa43tGPRIflKSXFE
	 s80OA/CDsxGmRrg+MI4h7hMHLEx/SbJLDGnl2yx1GfAVVAmxdjOJ+eaED5J3QlhgfZ
	 UliX4sE5Sr95g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D7C940511;
	Mon, 14 Sep 2026 20:09:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 45EBB493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37B7780A8A
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:09:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id snV5fQUx4NHs for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:09:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56A1E80A75
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789416559;
 b=NNB7wbCedEZQcAXCpDMDPRSrsjZnKEDj7nBRsN9ASQ8/p3JUmBC/8iExj9YoSxKz2VRm
 Og67iE6kmPvfjtkL1/8NHeRIHVyTS9R+AvlgEPqlFIlGT2SQOvot8go4f0bgsQzTPhonF
 pvInLAUn0A8pARkRKtn96BZ4qaOd0ztR9bRBu1KCrHN6ePZ/Yvz80ZcdkEJngXMibVRgy
 nFGVJs3GLEUvY6W9raO/av8+fOmIEuUW76jIlnYFocrDmJZjyTF8OS1opfoUFKA8WY6p4
 ygpLN3chHj8neqnEXbmLxDjwNZPVoOCBYZgmbP3w3QyMk6Ejs3VXXGLABTuB3slnSEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789416559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Z+FrXrxYPQ44QZiKEt1/sxFjd3PN3YuhObeKExjvrSw=;
 b=CkdA6/fA3683WRe0uZkzBy464kdyXY/DYrH6Tw/XPPk6N2HGiv4lACBFWZZG40u939zo
 zRfqn/pudpS/N7wr8oDTiYUkG20eiTrJ7uKRvW6pYyuw50E5SL3Gzxg+xnY2NIb1N9rYf
 AFpy3F7JKEOKgBQVwHiTjENwJNhHetYLia+EuUvgcluc0LzVO7nZPXyKLTRMLxpnztE46
 Z7ScTa5S+ofaZJ6BxYrIpyxcGS3/T8eeh9hghEZ2q+iHHxHh/Gy0CpGmckb0GK3OnOtjj
 eMXShQo9sdhV1mIwOULk86eRdfp7l3zEurS8nVKF0DsuOOXizaG+F4PVdQwUPht856g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kH7Aa7fJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::7;
 helo=mail-pj2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kH7Aa7fJ
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56A1E80A75
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:09:18 +0000 (UTC)
Received: by mail-pj2-x07.google.com with SMTP id
 d9443c01a7336-2d903e972efso17064285ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789416558; x=1790021358;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z+FrXrxYPQ44QZiKEt1/sxFjd3PN3YuhObeKExjvrSw=;
 b=kH7Aa7fJdZ+FwtsqJkI9mrWR6T/EkC01bQnfubMOnsG3rdMEmcEC1slrKPpMfdIDkP
 K7fHD4mX2lXyMOfMxB1p73JZ8GeE0X2nFQGxnsCFfg4SRG741L183y8BuSzYtmdnJXHm
 ixNJyN66aiWcRCJKvi9RFhGD63QqD+bMLFySo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789416558; x=1790021358;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z+FrXrxYPQ44QZiKEt1/sxFjd3PN3YuhObeKExjvrSw=;
 b=GzeWcrgLnJSeVZKXvwx5bQCufMHVTNa1h1F6sZ0RbuZ76lLbhCXdFMpVCgzBV326bB
 NClFbILyg0hy8yOI6ojxx7RrLTsTPEu7F26kn6c+EPnGuH2McuD1sPK0tRv2oxxO/xcb
 /JAFVLmsn8/dhkd2b4+FGEz0jdHpZiAC9OeqjLQT+ShIb68pTkUNcQc5uVF+Rk8Gc3A+
 zD0HBm0HMRAR63pXZ+++qziSZDVu0Ies6elAYol403VVQiL2R+90MyEG6fpIen8+sSIx
 YGhw64G2NzrekUDM+MwP8msBCnDzpCHYE954WtTn8QuQA9LGStxsICZXvbZuy7EKnP0r
 hvlA==
X-Gm-Message-State: AFuF++k9mQwhFVmWLFvYiSxI9y623bgsUAt3oSKcjcupvwb5pMtnUh5z
 LmFb8jMqFoW9xxYRvrJxB3jKloaRIu35wtS820+pkW+wcNjmTJ4Q0dcXQqcDsH9Tabw=
X-Gm-Gg: AYBFou1zA8Yc9GIHVQ7IgHfo3Ot87ZA1dPXBYSYKOwIgBMZfgBkVtBwkZFS0GSMyBl/
 frdht+0JQZCpjk0Vp/ScTkGR+ztre/kViCL8Y0t6FuclsFiwNAIeFHifhdhLFfEIKXdA3FeOPGH
 B5x8rujNjnj6OK+gZSOp41v/etnL9q0fWmFX8GpJ1gweli7A1bHPFPEqCUgQrXIuQntg6B7GnGu
 +HnaKtnYCiinRwtlw6SOYh8gObxu1aDIiqotPuWoIlo6yn3M5z2BMjGsYb/xzSCGIVuw3gmOeiy
 X9oYXTOf87vxOQWGXfwaHmbefYVby5tXTCRnlzB43GI8EO8kMCUi/YsPJyTAy+FB1L5XEpHOwz4
 GJ239sbLWvO/Z7wDlkf/lruiMb7VHB/6Gwi1gVSpmzAW+ne0I2qSjelbomxsD1B5jKa9YfKKi5j
 nOywaoQxKhHxksFGlnIXEaE9S7saPK/KJZ3ORosm4SxagCXVP2At1RxwPBD0NiYN/AuuQ6sN/Gt
 9+0zXcnaut1Tzns5G2GhH8VzVnIFExwKATWstdjkt6icB6rqx2AqxXugzrIdTZqX7ot5rOzB8uv
 /nd0by2rg9nQBTzxkkcX
X-Received: by 2002:a17:903:244d:b0:2d9:438e:b70d with SMTP id
 d9443c01a7336-2dd6c5c1352mr85486605ad.1.1789416557843; 
 Mon, 14 Sep 2026 13:09:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf31c1sm28421623eec.1.2026.09.14.13.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:09:17 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:09:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 00/13] arm: u8500: Enable upstream DT based SD card boot
Message-ID: <20260914200914.GA625059@bill-the-cat>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jEWxOjYWvKIPwyer"
Content-Disposition: inline
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
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


--jEWxOjYWvKIPwyer
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 11:12:58AM +0200, Linus Walleij wrote:
> Switch the U8500 Stemmy configuration to the upstream Samsung Janice
> device tree and enable booting an EFI system from the external SD card.
>=20
> Add compact DB8500 pinctrl support for applying the default states from
> the upstream device trees. Extend the PL180 driver to configure Ux500
> signal direction and the SD card supply voltages.
>=20
> The upstream device trees describe the SD card supplies through the
> AB8500 or AB8505 PMIC. Add support for the AUX3 regulator used as
> vmmc-supply, using the existing AB8500 PMIC driver for register access.
> Enable fixed regulators for the vqmmc level shifters used on the other
> supported Samsung boards.
>=20
> Backport the pending Linux DTS fixes for Golden's duplicate regulator
> name and GPIO key labels. These patches are queued for v7.4 on a locked
> down branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/=
log/?h=3Dux500-dts-for-soc

OK, so, the problem is that since they aren't in Linus' tree, they may
get over-written with v7.3-dts once that exists and I do the import. Can
those changes live in -u-boot.dtsi file(s) under arch/arm/... until they
are available in devicetree-rebasing? Sorry for not catching this
earlier.

--=20
Tom

--jEWxOjYWvKIPwyer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqhUZgAKCRAr4qD1Cr/k
CnEtAP9VFIeDHoF+P8GlhKHeiHc+aRtQAH/mlGKLOVMvp0iFzgEA+5xU+HnPWohG
2fbRXPSY5vhBRTte2Aqcel/4CMZCYg8=
=EYd4
-----END PGP SIGNATURE-----

--jEWxOjYWvKIPwyer--
