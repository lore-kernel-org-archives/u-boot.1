Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ABBCA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 19:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D206280FA7;
	Wed, 30 Sep 2026 19:23:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3cyJV8Xnhqs; Wed, 30 Sep 2026 19:23:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0705280ED6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790796233;
	b=BJwnzdSZ8P41dKyFl8q3XyO1ms2i3fQ/0evXuFJZsiA+Ynvmo+7XtSOFU+jag0cg9rv9
	 nOv/HUWqMFB62NTKvfWNaFKqfJ9QLlvEIvEVNo1LNtRvC0oq2sR4pcRShqdVzIg+SduAM
	 Jn1+E+Oo2c2d8VvqmF9ruxLZCHQzvmz3GfNd60NuPn0UH35d7ZbUXQTQtViMXoi4Bb1aU
	 Y6MTLWyKllY7SLbr5kvqt0Q85tSxpNMlDQIspKjT10Lii28r5oHZJF5KAweyFXn63RLaP
	 PXTr2jQCodOuzJW7YX8SsqlLmto4Dsy+xH2O9s2lsqFjlSyRZdCBAI8V45HXspxAG3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790796233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HOB2mpMMEKAEZFDIrgt3gc4UBU6URlZJ+CoE0CBTh24=;
	b=cjx2TkopSN3W58L7dEfoIT103uIaH6/EpjCPlHC6lGVRpHvh99dkuzATrbIRzlpu+9Iw
	 3k38cBG4injoQhyg5NvfDjRq2rTNZ9jd8g2GSbDXI7q3wTb5MLSfBzPDSfSvIS92DH/TV
	 5/fg/tOvsVkuG1HnufSR1EZNgpiS7d7zhc79N9b8o6Y7eeKUrm5PAtg4va6q9CPub2bgj
	 wFLDEXdxXmA1i0l4w8SAl0870Vak5x69Z24llgjZlCKIKT93QB2YvP0X430Ve6n4DF2wv
	 HJwp4U+yDR8vlytUF6B8X/MchGmTcBWbxcTphdKZmIDL2lQMfYWWwZTvZHTDDxLVAZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790796233;
	bh=HOB2mpMMEKAEZFDIrgt3gc4UBU6URlZJ+CoE0CBTh24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eL97y05O65PiScjDaqtOTvrB3NGq/xBphfJod5K3J6DPs3YxOLxIp/8wG7u2pPKTe
	 rcizJGC48nHUFOmCPv5QP0a9SjUjCvpkE+Yi3FFT2crYp6q7r46Ru6UcSeqcRJjAjy
	 MAUhNwfiicHMRYiOt8YIfzvX2Vv0DgnTNWoUjM8It7eEP+UwXLxCD6CQReqkpFx1K5
	 28oVpFn3iY8AoKlsw/dwtn7gqpAtqci+cjWVbwUhaKexsXemI+BrO0F9BCvAehie2A
	 wq6XeHNxm3hYGAiSKx/sayB+D0PSlw65xWjY7/LzP2lJTAqFAPdIQFFArh/MTtTnPQ
	 McM3ZiYO810hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0705280ED6;
	Wed, 30 Sep 2026 19:23:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1D0514C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 19:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A392E60B86
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 19:23:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y-XleBDxcCoA for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 19:23:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C4EC160803
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790796231;
 b=qz0miZNvDnOnBm6ju/DPyAr6GXRysRE3IR2GWYca+VTCA7TM2c/JeWvBv1C4zeKXNbuI
 AhYGUFTgAHpnmOyxiSZfCMYUJ5p5Wawjn11bEblK2yeXFxIfSjlMxjNrgWvcjKCiO0WTb
 dKNRbE6FI+3vtYE9ww6r4DQ7sQsWIGg8asZraiXwjJbOVdNMyESKiK03m8Qythg3veq0G
 n+YAQCQVTpyPHDyCFhTlyFlkaCd8UXBeqhPwzLBfvXd8e22k6FmOTRZ358itORxrnjAxg
 L0L54fnGxRXAo+00tx8m7lp9p6lTMntdZZgplYwKJApq19qo7GKXrYXwli0S4D5jrzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790796231;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=HOB2mpMMEKAEZFDIrgt3gc4UBU6URlZJ+CoE0CBTh24=;
 b=o6909NWiHRkrouSLRy8BFuaQ5QqXfMfq5jAlv8qTECBGKZc9pM4BAhGtuOB+aeNGQlCF
 0L9BRnkvMX/xfAhGrGOgQKB/5RSx+6gxwqcCli+Awao7O8KBXroYaBZwfh3NATEV/1k1v
 9QcE8EMQyjMezaOWJL8bCp7VjG3G3+MC+HNacjnJBGicSp/BATsUs0YSObOzejL1CsLks
 LI6XAF9I0/RgEQaQTJwGOy784KTvi86V6M5WicBH7db1G7iDo/Urf9bXJLHqQEZz+AE3R
 8Jxgon9Qsqu4A9AEE6cfnZp557qbaq3kQ/REBDelV52nvV+HwATw3QiBNAp2XZusYZg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NR822nwt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NR822nwt
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4EC160803
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 19:23:50 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 46e09a7af769-820ff812cd8so87026a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790796229; x=1791401029;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HOB2mpMMEKAEZFDIrgt3gc4UBU6URlZJ+CoE0CBTh24=;
 b=NR822nwtPMYvxc7ySX86J0PXWpUQL3KCWrp5LcYPxJjxwpHOkvjMW7zmn8YUxRLT6m
 J+O7AVdARfosr/C/oS0EWkOzHsxBL9I3rVZFDsuY5qkgxpVpkMFolzXcefH3qeSAS6mS
 zZdRnmtTVgUDY5g9QC1T1Kst+yQTlzPWjhEkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790796229; x=1791401029;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HOB2mpMMEKAEZFDIrgt3gc4UBU6URlZJ+CoE0CBTh24=;
 b=JPbDcf6UIOzh5oSRcwXhb1uDRuu8SQFwaLo6hjF9Kz6kgbCqH1UOMs5QNzuH43Lp5b
 MMT4bOP+B+Tlhyh6r5UtQsjRpE9V/4Wpz0FYkdyyuAFVKyxNeKM+9qkI3FUa+wOWJSb1
 Ir+jJz0Nh95zbTj5ARsNkwC1GbE3Ilcl5y+ONBq4uVhaT7/Fc6M6YSZ5oQ6Vb0yhltDo
 0IyVgCJk8tgztmLZneMaWtaKhOUbMSVK+9UCil956kZniBfcMoV1JdAkbbMxx+NpJ1hx
 tUe8TfmR15tcTUppxio8MMDQHgO0JsDZwQp5YhXLqrZZW/zL/HQ/nn/d9XD495n2zche
 tyGA==
X-Gm-Message-State: AFuF++kn56dfHPkZuklnoXm7YiulMg2y5L/g9ZHZXtF+HLxX44yhCs1n
 SC2XzljJwbsEyOwBQkXs174Vo21q40CgLOlTmOHryOlJ37lKhTvk3bfZ+gBVwbXLrEI=
X-Gm-Gg: AYBFou3DqwTWSGlfbnhDQXxKIphGRsDDENgzkx87Du8ufcXtiGH2GoQGcWhKEkCEfTX
 glFWh923ALRXY9Srh/hICn9rSUTgwjlj1OzALJuXi0qJgYUZc13MEsmLB2O7w8VTgu+/axsQnm5
 mfiiP9LLezuaxNR8mwCsR0v4ctepbNP/Gm3QpzBPxQUzoLskaaQkFf9u6bwdnsy8eJ/v2qpRr9t
 lcAXD0y3n0RuH8jr6f+LCoj69QJk/P/xxH2XbJlIrvsjCExDrI1spmx6ednaZIO2ronReryvvhx
 +4G6JWnvcznymdrzqQWyB+4qThYYQ9L1iHgJLii0lLRlQl4BhhQ1JJzMdR4gYYcxyK/QRC0Ev2y
 4PPX1Xq0N0qEjApd0vtQR9CctnaGoXp70Ot3FYXaXNpYuRs0XzayhblJUVET/ccxRX53GN+CgQK
 Do6rXF+Y9kFH1k+6P/zZDvLxEfaKZdf9c1LSeK4VJ3OFbpIBkT2lcaFI1BruXubklbDcfqY/SiT
 SHjifz22+d6MPru/SMArr2lulj9V62Wxi7YV3VFWyQDkuMFd/S2AhymPYzvb2zUDfET2HK3P4ro
 8bpCRYGP2KiztANK0CqZeJrPyM1f9w==
X-Received: by 2002:a05:6820:1625:b0:6d8:4e2e:997c with SMTP id
 006d021491bc7-6dcf4557faemr2382119eaf.19.1790796228440; 
 Wed, 30 Sep 2026 12:23:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd989cd088sm869075eaf.14.2026.09.30.12.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 12:23:47 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:23:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [RFC] XPL linker scripts and related Kconfig options questions
Message-ID: <20260930192345.GJ858934@bill-the-cat>
References: <CAC928HYhgVNM9BwpJJ821PWpZuR2gCKZisuQK4exKSCG42AO3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X5CBr0SC6S9DOp+e"
Content-Disposition: inline
In-Reply-To: <CAC928HYhgVNM9BwpJJ821PWpZuR2gCKZisuQK4exKSCG42AO3g@mail.gmail.com>
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


--X5CBr0SC6S9DOp+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 07:46:08PM +0200, Massimo Pegorer wrote:

> Hi,
>=20
> I'm going to send a patch to fix arch/arm/cpu/armv8/u-boot-spl.lds linker
> script, making it honor the TPL_SEPARATE_BSS value and not the SPL_SEPARA=
TE_BSS
> one within TPL builds (quite trivial). In the meanwhile, I would like fee=
dback

Thanks, this is an area that's needed some investigation and cleanup for
some time. I know Ilias has had some thoughts on this over the years as
well, so I'm hoping these are things he has some notes on.

> on some doubts I have, starting with the comment that stated to use "#ifd=
ef
> [CONFIG_SPL_SEPARATE_BSS] to avoid using CONFIG_SPL_BSS_START_ADDR which =
is
> not valid in this case" in commit:
>=20
> a3403e6fbf8 ("armv8: Support not having separate BSS")
>=20
> First of all, I've noticed that there are several linker scripts using
> SPL_BSS_START_ADDR without any guard. Second, the Kconfig guard for
> SPL_BSS_START_ADDR is SPL_HAS_BSS_LINKER_SECTION.
>=20
> Therefore, wouldn't it make sense to have the Kconfig default value for
> SPL_LDSCRIPT pointing to these linker scripts if and only if
> SPL_HAS_BSS_LINKER_SECTION is selected?
>=20
> Moreover, I would expect all architectures relying on these default linker
> scripts to have at least 'imply' SPL_HAS_BSS_LINKER_SECTION under their o=
wn
> 'config' ARCH_XXX section. But I found it just for ARCH_SNAPDRAGON.
>=20
> ARCH_ROCKCHIP has a second 'config' statement for SPL_HAS_BSS_LINKER_SECT=
ION
> and for SPL_BSS_START_ADDR too, the latter losing its dependency from the=
 first:
> unselecting SPL_HAS_BSS_LINKER_SECTION does not make SPL_BSS_START_ADDR
> undefined anymore, which does not sound very good.
>=20
> Another point is related to the relationship between SPL_HAS_BSS_LINKER_S=
ECTION
> and SPL_SEPARATE_BSS: looking at armv8/u-boot-spl.lds SPL_SEPARATE_BSS ma=
kes
> sense to be defined if and only if SPL_BSS_START_ADDR exists and therefore
> SPL_HAS_BSS_LINKER_SECTION is defined. Is this always true? If it is true,
> shouldn't we have a 'depends on' SPL_HAS_BSS_LINKER_SECTION under 'config'
> SPL_SEPARATE_BSS?
>=20
> Third: TPL_SEPARATE_BSS exists but TPL_HAS_BSS_LINKER_SECTION TPL_BSS_STA=
RT_ADDR
> etc. do not, even if armv8/u-boot-spl.lds is the default value for TPL_LD=
SCRIPT,
> therefore it would be used to build TPL too. Do these TPL config options =
need to
> be created (maybe with defaults equal to SPL ones), or are there no real =
use
> cases where SPL and TPL need different values? In the latter case, I would
> prefer to rename these 'common' SPL_XXX config options as XPL_XXX to unde=
rline
> that they are common to all XPL builds and not SPL specific only. My case=
s are
> without TPL_SEPARATE_BSS, thus I do not care.
>=20
> I would also rename all linker scripts not used solely for SPL as u-boot-=
xpl.lds
> instead of u-boot-spl.lds, as before, for the same reason.
>=20
> For SPL_BSS_MAX_SIZE/SPL_BSS_LIMIT the situation is similar to that one of
> SPL_BSS_START_ADDR/SPL_HAS_BSS_LINKER_SECTION described.
>=20
> We maybe can drop IMAGE_TEXT_BASE and IMAGE_MAX_SIZE definitions appended=
 to
> LDPPFLAGS in scripts/Makefile.xpl and use CONFIG_VAL(TEXT_BASE) and
> CONFIG_VAL(MAX_SIZE) in the linker scripts.

One tool that might be helpful here, that I don't know if you've been
using yet or not, is tools/qconfig.py. If you tell it to generate a
database with -b you can then query it for what platforms set a given
option with -f FOO or don't set it with -f ~FOO. It can also be told to
match values (and I'm 90% sure it's case-insensitive for hex).

--=20
Tom

--X5CBr0SC6S9DOp+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar1hvQAKCRAr4qD1Cr/k
CjzDAP4nVuf6dmjTqvEeu/ngRjv1VPzc26nxuW3RV3BV4jiM/wEAi5UQxTRSHP2c
suNLC/34y7IVVn3UhwmgHoaBB3xUGgQ=
=s+Ai
-----END PGP SIGNATURE-----

--X5CBr0SC6S9DOp+e--
