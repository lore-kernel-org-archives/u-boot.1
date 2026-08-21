Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D538C5DF97
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 16:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D331740C17;
	Fri, 21 Aug 2026 16:20:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CuwLjUovVPwW; Fri, 21 Aug 2026 16:20:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787329257;
	bh=cIP3CzFZ5CgvhR6tsVmdCMELwOs/1VaC6u4gxEMr6V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WF06n7wPk2nTvr3Eh6jjeUx6NxxSjFZBonVwLiRssVyhGyCA+YQHff7r4vpFqKBUv
	 xWnHqMeRzBeFz5v9fQFi1lbUTt6WJ1nTlaDqTxGKQ7ketF8DuBim9PDVHU9rxrpTKx
	 EooqVhTGi26u1gAgAq5ubyrNZfsItbjOTMpHk5348Lyx61Q7T64SH9ya4ETTld+nVY
	 +f4HjV8LSYXz/0FeXr8uKiTQWBbsJYmcqUFnpp40nJlN8FrsgTYF3YrNtaOD+3W891
	 eA1/d6LUdVHCyabQdBDAxbqfC0pxgtuzNUePH2aq+DUl05l2ug4QxrYzvVFugweJdK
	 4Y6oIEPhG0W0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 298C940A14;
	Fri, 21 Aug 2026 16:20:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4AA1336
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2468812F9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3bWIps9_ZT3 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 16:20:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::b;
 helo=mail-yx2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iD5t6Q2N
Received: from mail-yx2-x0b.google.com (mail-yx2-x0b.google.com
 [IPv6:2607:f8b0:4864:41::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4449981175
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:20:52 +0000 (UTC)
Received: by mail-yx2-x0b.google.com with SMTP id
 956f58d0204a3-66c70d59eb7so241630d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787329252; x=1787934052;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cIP3CzFZ5CgvhR6tsVmdCMELwOs/1VaC6u4gxEMr6V8=;
 b=iD5t6Q2NfVxK5NvfzmeRyLGjGUt1j/JdZruKMmz8WfiBRi4KDnGYeyOY9OFrR6Ndfb
 InRCAwP2uRH+96bcMQYbixCBuB/grsnXK9oPm/Bfq8wVGbdPYarQsP7VsXa4kfiN/5Jc
 Pc2LTfKETBYN6PN4CT20dIkMbp1FOo8MHTW/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787329252; x=1787934052;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cIP3CzFZ5CgvhR6tsVmdCMELwOs/1VaC6u4gxEMr6V8=;
 b=GNy+EbKtyumZWTSUuHJuw7+wjIMBX1O8genuy3kTGfVokuEtrXoGqRfAnqF3vnW6L6
 bCV8X1AIfoOC30xHPiWWpqbEEb3RcC4MHo6duKPPdi5nql6l09pHq9ugt7PfQwsZ6SfF
 SEAUtr1rrbDl48AXLb+7I8AHA98R51yh/CUvJPfK/cqJ76rdlHnEMy5foEGh98MWXmfy
 CUBl42/IoJNeHBR89wMdALoLD6ERVh/dElL+WAd0CmtqNsnW4IKNMwRKymMbWQLzF8SU
 Gl1TyUGVxIL3YurThFwOxl9AeHnaZk5F3A/9fxfFv9/SsCCWQNNwcq5/sx21G4LjUM7N
 94fA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZagi9jgR6uIyXPogiNUx0V+ICvyjcL2BEtA3ta3nRsKRSx8jLNszIu4RZTHHftzU68rgzhu8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kPzhkHUV7p4MPgXiSNo607EGDV2CgVvfciy18R4geYPPcWMKlg
 d6cIyFcxJhlXzbvRs6IPjHhsBBnJ2HRcI/bcgvjbxqzczM7OH/iWLFCyJNDAqpC1n8E=
X-Gm-Gg: AR+sD12vxiNcjtS8M/1S193MTF/GJy1t6mRoA5aBbay1xOKW1ZCbDl2Y/S54eaaq1Ax
 9R4jvWrp/TOfinS+l+IBx/q8xryG5VbRaYMOFB09TOuXiFgp8jNR3IMWmf9NbS9LmDrhyL+9uKv
 56vA7Z1sb0yDBxGAsc7SEB2egyKlTQ8mfF77zDJ6t4zfvPqyGfDYsq1HKctLNmz6uhAl1EODao/
 fFD9THNd2aCD9TrNVNqnzi24xMg/Hl4z4yEY/YRD65D9+gOWEJSWBtO+AUZu7ttTUPZCLpZXl+S
 OQ96ko8OTXAUxNZSeAUavzHtVdJEWRmFHvCRW9KwO6G5eVIczwqBaPomzdsaOOkD5IcW8TvtIqX
 Obh3RkeA1TuwWrXqLo88XhUYq9U4TzeuAxEVuOD806b8QJ6u9JGmLpUFkYxnERTWmPlCWGlvJzT
 TIHEhLe0/SXt0c2svtQjWd9BF6WYnPDMwQXkUJl7hez0Erg9i2rPYxrDmCsLzk3MDxhbO9yWwDh
 oxCNK3uoGz2GvndLF2cJDppQxHH+/O51Bk5WgbZ3pQqGbv5vApghX6MplGIyLs2Se6Jo3xmcfbl
 lTuVF2Mcew==
X-Received: by 2002:a53:a544:0:b0:66b:28a9:5729 with SMTP id
 956f58d0204a3-66ce5a37ad8mr1798866d50.8.1787329251730; 
 Fri, 21 Aug 2026 09:20:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm4613105d50.1.2026.08.21.09.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 09:20:51 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:20:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 10/19] LoongArch: Boot Image bits
Message-ID: <20260821162048.GN523975@bill-the-cat>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-11-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oC+qAbMv6P1zoXb/"
Content-Disposition: inline
In-Reply-To: <20260821084219.1703743-11-me@ziyao.cc>
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


--oC+qAbMv6P1zoXb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 08:42:10AM +0000, Yao Zi wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> Implement loading and booting functions for LoongArch
> standard kernel image as per spec.
>=20
> LoongArch kernel do expect us to fake a efi systemtable
> for passing fdt to kernel, we don't need to implement any
> EFI functions for kernel because it won't look into anything
> beside devicetree from that table if we tell kernel we are
> not efi compatible by setting a0 boot argument to zero.
>=20
> Link: https://docs.kernel.org/arch/loongarch/booting.html
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
[snip]
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ac4be2c837c0..5654de5a58c7 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -56,4 +56,7 @@ config STACK_SIZE_SHIFT
>  config OF_BOARD_FIXUP
>  	default y if OF_SEPARATE
> =20
> +config LIB_BOOTM
> +	select CRC32

If this is needed, it's a generic problem (and to be fixed outside this
series) where LIB_BOOTM (and possibly LIB_BOOTI/Z since you know what to
look for) need to select CRC32 and SPL_LIB_BOOTM SPL_CRC32. Thanks.

--=20
Tom

--oC+qAbMv6P1zoXb/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoh64AAKCRAr4qD1Cr/k
CnwPAP41Acpwmcqyi/WfzbQz3TWMIAJQGwwRolvU3gAQLRslNgD/XWLnNXhmtPIc
bsVK8VxXOeCzkvH1AFeMsJCWrSbhzAU=
=zivU
-----END PGP SIGNATURE-----

--oC+qAbMv6P1zoXb/--
