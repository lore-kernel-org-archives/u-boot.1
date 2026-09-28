Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AAACA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 21:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F23B606D4;
	Mon, 28 Sep 2026 21:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8vn0z4SYx1H; Mon, 28 Sep 2026 21:22:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD51D60632
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790630578;
	b=FUwrHioIe9CHpls37UlajKMo3aY1fpld8eQHPm6GoLkQIXsykHBAp2cnFvmMeETbFOg0
	 roHTal4CEsCGoMjfZG+JA+MpXe+y2w3U5PqRd/shAI2j5ypOPIL+ix48ZmM9gQYqIJtau
	 VIbJemeaeiNaFbAvAT7BthDGX8RJe8/kKJ5pblGVLXjzgFFdDXY7OEE1qWpLkEbwpM9st
	 jiJrbOZDMxXbtGiopL6Zrf1ggC5Z8c4XPZvF87EYQNAJtbZfTz3blJr+fmIhTPM8jPyUY
	 Eb8f3ZEdCe6VeWRdquW56wIsQhpV1W7R+YC4Dl3/sDfITw4vXMXO5E09BveOYW8fREQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790630578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jzk2crLfTPBkfC3jcOvqjIFf+pB1kgleSavzndi9mmc=;
	b=JWdFHAF3NKM257ywS+u9x7rL+D+BStlDF25suy3dTPAQSQb3Ix5+Y4Jzk/u28Hi4wQ+z
	 iHzdU7ARu0rtfBg1yWZkt8WKveiEnKf+STuVDFHqi8U9bhE7ZsY7479ZJWEGZpgiDZPMd
	 iEKem4sXm2PVksP56SKUZ4Q6eumOlJbKsHf518MJg0RnlAsEspFxApKef3wbC6NkVjfPd
	 wjqXwmzdROuPIiPuBnTVha1suOtwJw/ckUxyeWxIq1gVNbTp0hDz/bLl065/A1mFAw8Yg
	 b2ah2Uqs2k3TZX7EjqfkRA8uxag/HFBbmY02IZvtb0CqlBmyp4ifMh6Clof4FjOpDgw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790630578;
	bh=Jzk2crLfTPBkfC3jcOvqjIFf+pB1kgleSavzndi9mmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RjQA3fZSN6DP4eiBIa2zq2+3uobjtTLwpjaP4dPjP/bu+HJ/zGT28hExIvqn3MkBI
	 LpZGzgwEEdXF8AKLeR/jiCxyr+DD47tKbqsByX7cpmkRR3KaiNILJJJdR22xaZmafN
	 0E5IBybChxIh0m/fDYQYZqOfaXmYmMdfdqMnipez8/xDH6ds0XMiVdmJVkFEhw8G3l
	 V8TM8voMSxjhNCGb6JiSRlbD9APTl18JKR6LEpAR9MRMUxqF+78ZGoJVZehpXNt4uC
	 4orKqMbj8sln+jNBhD/Dwr1dSO/HFnuju4np7JLGoGYCezEk9VqvvquCb4voQaMB6v
	 0L7823odu5QCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD51D60632;
	Mon, 28 Sep 2026 21:22:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 252413D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16AD1403C0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:22:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fbLY6HaRBu_R for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 21:22:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 54B8D40377
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790630576;
 b=PcxUfgKcPlKvyzfDG966jQpyeNuwURaXyRMxhIBo93NVMhAsL6/VNjAZqhGKSPRvAgcr
 XD00gdpofd0fqMXmt9GRX9hjn/s121xRxV89vsqkVQRYYrn18vAFHvcCVPoarUPVIkHvL
 LxzvqiYnEFWDbiFyKf3NVf9mL9mTOxxwzsrouxBHImpFSnEvWqcU09UQ6QxmLrUqMGZ0w
 ZSNNgwrLYRtUz8PjEyLmclZhqug8vvgyhemx8oKS5LFDaoLIYNfjA4a9yzrOGn3W0qEmb
 0uw70mqwxyp+e6WzMMKKI1i7zaKUrAC4Rlg5iVA6cRVQnjeVYVRpo4h8QEu4L/RfRxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790630576;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Jzk2crLfTPBkfC3jcOvqjIFf+pB1kgleSavzndi9mmc=;
 b=BrJ7TOGYVs4vy+LxcSK1/6F9ElhTa7QshVpONxADC8Ba5S6wx1Z2ZGvB2kCqEgis2gMP
 CB3ei3xWrwyMm0dJuKandVv3bZZkDs+Vd45VFSioY/pcv4i9IU5Ex3uY6sYQ6UeF1KYJ4
 UUTFcZWpjNUnXW7ZadxRbYyzFKUPacfGxU8DPZaWVYoDsW0ffMcaV16K5FphAwf18TGlk
 Sc8QDMerzxPEg8AduNJSYNUCoYxDPv86MfjKXgzMVZY3gMU7eKja76kY2H+jbcg6jzGkJ
 qcnJnpDS1b5HnwWSNbSEmQYLOthSTntzEJUOKxSOdXKW5RbWSPaFF3WEo0XN/JTR6hA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oJOvPOzO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oJOvPOzO
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54B8D40377
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:22:55 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4c6d6660191so1806515b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790630575; x=1791235375;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jzk2crLfTPBkfC3jcOvqjIFf+pB1kgleSavzndi9mmc=;
 b=oJOvPOzO+oD6Mrhkambymn1IsA9HC3pZcNFj2Yvuh+RBCEPyJyLTq27GUBuwEV/FzQ
 9A1ARRm6qELGJOxIEnYABIIvB5HRnBVjhck9fb1IdHuB8u7vlI7X7avj0IJZ1k3VBz44
 3EiPjxYFxkrA2iMr5pLS8HafH28KjVeKr4xk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790630575; x=1791235375;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jzk2crLfTPBkfC3jcOvqjIFf+pB1kgleSavzndi9mmc=;
 b=ojPuQdKS/A0w3QcNij5lZCLEyyD7Y8oWENk6jd1E0XJlRlbJiJf0PkWlo33An05QHs
 sSW6GDbcgIAhGDAbOgFia+vz9KqzgXhiwMdgXSCX9l7r+0XqhCKOuEYNBaXKEAL+mrBd
 Wcrvuy/QXwyegThbzz3+n9aUF/1/LX2+Kf5wvSWUarHRGWd1OwErqZEwSPCRyquaRO/O
 T+ANzOkMwZawfds9fQiCPJ3m3VyfWamyWYQoJ9ApnPpg+JO5lo4rGqxjxrYZt1ueu5Aa
 voZxYcYnHSt5KddoEsgGgXhRNcX96lxbZZFl2Sfiws+ufl5RwQNvta4IsvKlf/RK8o/6
 VZXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBynDhU3oAsnPw5nPYSHiM1KRp2Z5kEiTCMyKuZl+Y1SfeqaGXLoAfiif5eNkYxokgWSIMZYfzc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l5zDmgUzXDPZbDQpPDGV5IhbkQMis3N4JMZq894QPxSTf+ytti
 R9V84u2patSMwYRjONch16fwkEE///WHhWPIM6Wxaig0c18TuM/kmLyFivsHAZHCgS0=
X-Gm-Gg: AYBFou0RiWyXZ+0wkvyYd6aiRdMK10PYPkELYcdeVXSQbJXT4lWnjMt1NHPmuoFsndT
 LZjz4lL1qAxxDAAa6pdq4HIlDm/Ttnsu9xFXzdoD59MDvkqc2ncTLRdeYZET0OdIYSRYkD19Cm+
 4QhgoOEVPsJo3g4YPN9LFRw5BMUuXNI55kEm5edHoj7FrNdLTR9N4m21lBMNTJ2iq2Xm2GEbp4Z
 6Q2Egu/EUaWVH4p28u99/uZz6haD0TXLDz8xw2J/A77lYPrE2sPnnYKWsu+a9kdwIogt7/eoAps
 SdN728uxmvIr9uF6jBioot6noz2iK7Zt0sB0FwINsdMDLTWgtkpj1fRERPDRbFEmh8NRlpBSHAk
 anJ+AGpn0z86rzTLlC6EwHVhkD970je3P1ik2Du/xDe1azwuwA/cr1yejDHXH4fJ8mVCUv7xNr8
 QXktgjnCtzFcXgJTRuuC7VABKGpFyeo6FRbl/I5f7q37mPoYVPs9c2pwnZNYn9aWGXgEmZdHb9Y
 NgQKgJ/TgK+zcg/uAyBbw4t3r8+l0vStGuNYbBghSMaRUuBX1KOeCcxlRYs0AJELieF+x/Dkc9Z
 0uFFTINvM8G8xSGqowAGOZf69wzbWzQ=
X-Received: by 2002:a05:6808:13c6:b0:4a4:ed9a:e7ac with SMTP id
 5614622812f47-4d72c043858mr14959606b6e.1.1790630574739; 
 Mon, 28 Sep 2026 14:22:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ebbbb2324csm2891554b6e.8.2026.09.28.14.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:22:53 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:22:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, vandhiadevan.karunamoorthy@oss.qualcomm.com,
 dario.binacchi@amarulasolutions.com, sjg@chromium.org,
 pbrobinson@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 0/8] gpt: enable writing a full-featured GPT via 'gpt
 write' over fastboot
Message-ID: <20260928212251.GS858934@bill-the-cat>
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eU6Dxp+qTAEOmcaD"
Content-Disposition: inline
In-Reply-To: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
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


--eU6Dxp+qTAEOmcaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:10:33PM +0530, Sumit Singh Dhami wrote:
> This work is done as part of Snagboot support for Qualcomm Lemans-EVK to
> help flash GPT via u-boot 'gpt write' command. It addresses the following
> issues:
>   - Incorrect first/last LBA computation for devices whose block size is
>    not 512 bytes.
>   - No option available in 'gpt write' to set full 64-bit gpt partition
>    attributes.
>   - Fastboot EP_BUFFER_SIZE is not configurable and set to 4096 bytes whi=
ch
>    overflows when long command strings are passed. (We faced this issue w=
hen
>    we passed 'gpt write' via 'fastboot oem run' with a very long partition
>    list).
>=20
> The changes are followed by a final patch that adds all the config options
> required for writing a GPT via 'gpt write' over fastboot to
> qcom-snagboot.config file.
>=20
>=20
> Sumit Singh Dhami (8):
>   disk: part_efi: fix first/last usable LBA computation
>   disk: part_efi: support writing full 64-bit GPT partition attributes
>   disk: part_efi: read full GPT partition attributes
>   cmd: gpt: support setting full 64-bit GPT partition attributes
>   cmd: gpt: report partition attributes via 'gpt setenv'
>   doc: gpt: document 'attrs' key and gpt_partition_attrs var
>   usb: gadget: fastboot: allow configuring the endpoint buffer size
>   configs: add fastboot config options for writing GPT
>=20
>  cmd/gpt.c                       | 26 ++++++++++++++++++++++++--
>  configs/qcom-snagboot.config    |  7 +++++++
>  disk/Kconfig                    |  8 ++++++++
>  disk/part_efi.c                 | 18 ++++++++++++++----
>  doc/README.gpt                  | 11 +++++++++++

Looks like doc/README.gpt is something that needs to be converted to rST
and then updated?

--=20
Tom

--eU6Dxp+qTAEOmcaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarraqgAKCRAr4qD1Cr/k
CmCmAQCOKmU9CfP0h8ezJsuoP/CJ6mARx/WCm5740J6ALGxo2QEAofriQQuy3PRi
ywJSja0OriqHqGy+THgyWnCeLGjY7g4=
=ct67
-----END PGP SIGNATURE-----

--eU6Dxp+qTAEOmcaD--
