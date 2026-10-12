Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE732CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78F7F60680;
	Mon, 12 Oct 2026 14:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rmOTulqCJQrU; Mon, 12 Oct 2026 14:45:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B4FA160665
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791816304;
	b=SGGJ5oE+KrpHVzP73Om0ajonFeFIU6VgS+a+yx3Wd6aI8xxvpfP6s9hv3Z6qI/ndetgd
	 EnKHY+k38UmnZEh3x9mO692pH88az12yxLyEjGeeD0O3Xfh7YrGW4MAZIHbMQ0yEFEAXW
	 cWikndIf4rjQuEqshQQHK2m99FtmDS+omfayD2o/D4ioHectHSn2Gqi0tCFcngpeAFZ/m
	 hzK/QZqE5m6ZmDsMMXPcb1S/o/VUTgtrdOTDETFA9NzzaJYkC270PWrfpc0eK98xHOddu
	 LUVwZIRMM2rBCxGsyh2yCNVI/NgIQllPVvrZXZJbULk3qGBGM+oB27C14iUynIaGZ3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791816304;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=++5jb1YNBjIj42Y0HtYRn3Dlqye+7UOLQE/+wNyeVhQ=;
	b=Jed5axP6uaqz0y+iUUloPfq72m6kOxi9sB8Ffg2NFlNUQOTJWnOYoryItfFE5/V/GcEp
	 2SLQt8eVX1sg34hrt8Nkbr9gVKtSKhzT3wxo/8uxiVTkGLyg4m6tBEXbHzeL5T9Stuh9h
	 EWVEXIMBngIIyjSEU3TGN4GwpkazW+CnmaS0Q8IO6WY1Lwv6Bv34pptA013a48xhK8Frz
	 oLdDF6VTlVlnDQnA7iznHgac+nE2AC4X/fD9ufOS7/0qIdDo4q2PV7LKyT/8uNAxRhXOw
	 Y1uAa/h1MBUbXuURtFsarbnFWdBLtn5Wu0GaU81ry4Js2MTPxjbJd5oy1seSvHjnccA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791816304;
	bh=++5jb1YNBjIj42Y0HtYRn3Dlqye+7UOLQE/+wNyeVhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TOGAY9rdFltjY5cdNNxkzTX02Gu1KCOTNxy7QhZl8m+IdtBp3u53hy4vMTaXBBzMA
	 t+IUf/vAYbQTO0nBf9Gz5QoBJSY1Q3BwRfe8+XFV7jXCvOMlkzh0X3j2J9wbji/X6m
	 dpwRvYj8MbSDMI+/8jX9rFmz71sXBAAuKrhvrUkyVjVRh3XNz7QODTpYk67YV7iI6q
	 rTYYcWUrlsw7bJvhNXvhRC8V/dFcXtWlDB0a/9E+hPcEKLbB8KDBu5u7Lm6BDmU5xv
	 pgFqJlYvSac1IfsMAVInevcQUy/Zwz1O+0rH0qsjZBbgK2xOGVbyV6H1FpJYE9IU8O
	 ujRIjlqBSpP5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4FA160665;
	Mon, 12 Oct 2026 14:45:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94E9C156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AADD4056A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JYlS1lZ5P3Gt for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:45:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC5E640563
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791816301;
 b=RJ4VNxhM6i1WcWNnFDW3jITzP5iJz06cGgORWAcg17GxTqx5bFL4+p9IldR4YUKmPomT
 OQjbADAUSuGiXpITFuPBzwxt9X7DZCD/ghD+pakPD8E6ww5JQaG+O3SDGfnA40t4y1KiZ
 Vz4+TQ64patcPRc1ml8DACewnmMmcSy4+eo6NPvcoCygs9hMQght6WaenJQZMRm2G+UBR
 OL7xsSCaakMRNB0Xc6uaUuG6a99HrToVrriNNIK0kVWevNXgpE6VZ7W4V3nOvfpBpeI8N
 OOlt9wQ0Mk7z4TW7l20KgfgVYDsFrluQllzUgIEEY/t/+/mcyvoQjkEjYHDIFFT3maA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791816301;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=++5jb1YNBjIj42Y0HtYRn3Dlqye+7UOLQE/+wNyeVhQ=;
 b=nGyQNo9fmyfWv7PNAcwApthxE2NapMR3cN7f+IsdlffX0ggsrV08BQOpzOJBaFLIvZYK
 qtcJPKHR9C/9OV8l01n3z8mx0HTbSD7nkA4npiuquGyZxfgq4cTBr5VFciy5JJ2922+Db
 70xQmIgRce62WXLf9Fx2LgxxuM6rs4DVv6jK4ocrTaEUlO7I7qthLDaJ4JnAL848qQ6An
 4Gm7UA16h+w0Gq+ogUNejMnx/VQ9TqzbPb7Qa7ZkxVDx0x1yBkcX4mC1+RmZy5d3n1uBu
 eY1mW6KBPddUSCCBRSLWNLCZQjUFo/2HadcOzvZl7e71Q3EImiiyUNnCpO7rOzV7D3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=R8bY2k42; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=R8bY2k42
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC5E640563
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:45:01 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-822ddb835fbso1496829a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791816300; x=1792421100;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=++5jb1YNBjIj42Y0HtYRn3Dlqye+7UOLQE/+wNyeVhQ=;
 b=R8bY2k42jy+qSYsPCnvFFCu/BRllYCmxQOWy5sQvUiV1hMOWoxPF3F9Q5FvDfUPC5I
 CY/aRDBaZIaBEGVXCfyCT6Xr8myZ/VdC6Q+v9u7CgsyMB69GRDf43bWqULRaMxzYnAu/
 De/hAlTzF5VbwdaT3w3LbwSiWHKouzaPnXoSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816300; x=1792421100;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=++5jb1YNBjIj42Y0HtYRn3Dlqye+7UOLQE/+wNyeVhQ=;
 b=Apjp/RRyJpHnXO+u5MxItv1gXNXyDkM2/1hVIPar3SBdczc3fAatLuvf5/b2EIJ8cT
 UMSa+Dz0YX/vqhhQhlXoSa/+MJ2g8oO5U8BGF0b9/E767aIc2v4fBDl7RyiOzqSvVH1f
 PMTgH82NiuImkg1n87XIzl27qpIrZAYeXkPazV72YlfA71O0+AGrOoH0t9muYKz3sW6i
 wu9sUD/BmvAnX+3dl9lRmArMzUQxvdCHixmzbuLOEjRif3saFdITKCym82/oOPqQdokm
 NYRecjftjWHl5gfFUfJ7trOijrT/VV6zH5xGCLosCXNT1Fvbg5OG5EgXZUJiTPsJdO1s
 7How==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNGy0kq6qcXlKGhTv6e92k4mMfjzI4nUhoffPFS2i3tqLV9SMWMrHwCc9JmnGryS3mYHNceHM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLplNHxj5hblPFuS63LEIzV848m/cklR5QlNvf5lu2ms49nvRBT
 FEUj1yB+EgEo8WwiaxApz9rE+TiSHqFofqcnqQZj8ZnluLPXi9zdccX1aviYlwEFqvA=
X-Gm-Gg: AYBFou1FCAiSaRAYDJn2WE0sMXKBCBq5/ERk1IYbGZf6N/2kZoutCXH/sUzfciyqq0H
 x5Fn72o2n+7vvUr8Q9+A9uKHKLgTocNzL2mCvsIrScCkOZnY0yUaIIp/Zfrd8eHPjRUWwMqIDUt
 EvRsY04bHnpWripC2pqhzxXc9I65IrvblMCgVkiV9fs6r9cU9JuA86YaWc+0NB+3d2hiLlSqyrN
 zQ5S2dGJmjpjp375RIooXGoSFm3TBNCx+4cAOAnPRljM7NJw3xu68LMeLbNj2ILT7u48B9MPnzq
 VphL7GApErmZkc4f851NtChnEThjPeFteZa+aS0kPLqyjONTkH5PFQCVJVLnuNntxrq/acl4vcO
 5r55MRNQZL6VaooMnT/DHLly/qiLiFbtJdepZOq7PE50y4BDOoT8A8WrglkjF9C2l0JI3cPIYmw
 7qucDuTXUu7oCzbXIDRxIzZYqc4uTti8UHVMfguZM6+DNGB8m89Za/dDaJ/Xt8d33rH7T9oTU94
 G9FQ8muMSSHosdt7bS7LQBr7rEsGsrSaDnfEfJU5bljlywVsG01wpHVwECE6IsKERlaoNm5Jcl9
 VNEZgfQm52YOgGiYomehYYVDy6E43K8=
X-Received: by 2002:a05:6808:199b:b0:4dd:18c7:5448 with SMTP id
 5614622812f47-50c56de25dbmr10910726b6e.56.1791816300081; 
 Mon, 12 Oct 2026 07:45:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c16755440sm11631517b6e.6.2026.10.12.07.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:44:59 -0700 (PDT)
Date: Mon, 12 Oct 2026 08:44:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
Message-ID: <20261012144457.GB3722450@bill-the-cat>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XR9nQx/j7IBTRAkS"
Content-Disposition: inline
In-Reply-To: <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
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


--XR9nQx/j7IBTRAkS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 02:26:55PM +0200, Ludwig Nussel wrote:
> On 10/9/26 09:23, Simon Glass wrote:
> > On 2026-09-23T11:49:31, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >=20
> > > - Note: commit 68e65953400 introduced forcing OF_OMIT_DTB which is
> > >    incompatible with the intent of the qemu DT merging feature, ie me=
rge
> > >    built-in signature nodes into qemu's DT. To be sorted out at some
> > >    point.
> >=20
> > One thing I'd like to check before this series goes in.. with this
> > series applied, qemu_arm64_defconfig still ends up with
> > CONFIG_OF_OMIT_DTB=3Dy, since ARCH_QEMU implies OF_HAS_PRIOR_STAGE and
> > BINMAN is not enabled. OF_OMIT_DTB no longer has a prompt, so the 'is
> > not set' line added to the defconfig in patch 1 has no effect and
> > savedefconfig drops it. As a result qemu_arm64 never has a built-in
> > DT, the merge code in patch 1 always takes the early exit, and the
> > problem in the cover letter (QEMU not seeing the public keys) remains
> > by default. The patch 1 commit message also says the defconfig change
> > enables the feature, which is no longer true.
> >=20
> > Please can you either fix the Kconfig (e.g. stop defaulting
> > OF_OMIT_DTB to y for QEMU when FIT_SIGNATURE is enabled, or let
> > ARCH_QEMU opt out some other way), or drop the defconfig change and
> > say clearly that the merge only happens on builds that include a DT? A
> > test for the merge itself would be good, perhaps as a follow-up, since
> > none of the vboot tests run on QEMU. This may also be worth checking
> > against the CI failure Tom reported.
>=20
> When I developed the patch OF_OMIT_DTB was "default". 68e65953400 changed=
 it
> to "def_bool". Would something like this make sense as a fix?
>=20
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -213,7 +213,8 @@ config OF_HAS_PRIOR_STAGE
>           disabled in the board's defconfig file.
>=20
>  config OF_OMIT_DTB
> -       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
> +       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN && !ARCH_QEMU
> +       def_bool n if ARCH_QEMU
>         help
>           As a special case, avoid writing a device tree file u-boot.dtb
> when
>           building. Also don't include that file in u-boot.bin

No, because commit 68e65953400 was fixing how the symbol had been
misused over time. I need to understand a bit better about what you're
doing here next, so we can see the path forward. In commit 99df7f471551
("arm: Drop unused dts files") we dropped the empty dts file that was
being used to generate the dtb OF_OMIT_DTB required.

--=20
Tom

--XR9nQx/j7IBTRAkS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaszyaAAKCRAr4qD1Cr/k
Cq5GAPwK481VkuolIYWspMk+D7DyFGhhTyXkHeuEAwe/P0tyHwD+KVBqCXMbMYU8
okkcFti0mel9ofhhygdMonAzAuYLjwA=
=V5+u
-----END PGP SIGNATURE-----

--XR9nQx/j7IBTRAkS--
