Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22B606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L1zHa68D;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Qp+3gpgk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 326F040DBC;
	Fri, 30 Oct 2026 14:30:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bnt87DLIbLcp; Fri, 30 Oct 2026 14:30:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6BFC040DB0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793370645;
	b=F1k7v8tKg6R7eIfHNn5Q6wiftX9PXHBPXNv79aNiB8Cl03JuW+f9qBOvSwKe3uNWpW+Z
	 1brzn3+CBu2FHq3PpEgD2Vk5PPPqgydyIYwHE3ueFsegpF1dEkfUefb9v2fj0lICWfkWQ
	 22LUN6bTFLgCZNL5Phy2NqtG064d+V4lv5hmKZpyO/1UA2VwUYp2Tj0H1of8csWKj89/4
	 71rmGE+1qZTj0dsSJDnHbYl5TvXF/7kSx1O4+nb9gHg4/dqubvU2gXIthYxhR5EK1Re0J
	 04/BWmvLqp4eh4lOGf+M6lwwwHbXBrDexskgW4zqxaN2j4B8fOsk6Sh/uiku5Hf9m9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793370645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KQtSpQiinvP7bmjZ9hi7Yxk+6mViQ8oBMn/wYBWy7zI=;
	b=QaOmwgstwU/3Gx/aCek5KdIMdailmEPQWNResjCTkBDRK2nckl/b+uo7F7kx6Ialp5j6
	 kl4lfXR9bZf04db1B7aW8D89KZWlmabmFHsqC8/0pBWRkdEDaZW64yRz/+iJKlwSjAHyA
	 azFYe2wTVVC8iM6IyZFAVKG5ag1QtGWXT1C8oFHrq7s7oNlI7VKpKetcy2Zw+IEr2WWyi
	 gy6eIBzM5Y/g5/DnHxOQ5DTfF8oVpMgimZWU78zJzPmLVbv86iPSXjLvwZMauBWavd6mB
	 pzEhBldAyOKB3Q2fIwh1XKAZmFyIRhj1pCOz+osLWp/U/BewUPfUO2bn/60x0KqGIpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Qp+3gpgk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793370645;
	bh=KQtSpQiinvP7bmjZ9hi7Yxk+6mViQ8oBMn/wYBWy7zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L1zHa68D7hqeztq80AFIuMsQGNIk7GePBg0AOrYyOf3HUcnfSvtrCWFoxf6xDwiGF
	 xSB/ZWTsWizplRrYv13TQQG8fIz1P1YKu3GpJ1uAHYOKeI1bPZL3LDLArlG8efvKuW
	 4CWEw33GNS5ZBQrfoaVx1n3aEG8XcLjc8hy2oLrZuj9VKt6PxTCvnA/7Rm0bsdkH7I
	 XVFTf2q2lKKPkXLcODmEghxlMbUXzmfqt9snPdE/E2kNrmze0bRcTvo15mhdl5fRTx
	 0WjCIKEJxIfZsD4ttZRvdk9LWWsv9NytAFBqr31xgVblVuCScWNYCAOgtpoIMjp1Za
	 jpiLDCyzsr46g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BFC040DB0;
	Fri, 30 Oct 2026 14:30:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 082212AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E25F940DB0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 75X1Tn0pQaQ8 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:30:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 29ADB40D9E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793370643;
 b=HPdi7UMA6u7iIqlnUxMeOBkikTX1VO7lpC/rv0zC5xnRVsQoTYcGSw0agRfsZgAc+dt7
 F4o3coRZlwL4dapf/KNH1PK+2lLdyAyEewPLKNJaCq8WI9qIdZO7R1Tu+SHVE3GGJO9fe
 VnyNMvbFEF3SM47r4hW1DL3WModQ9/a7cp+xTIsuj+fnsUjWwXtMaXFbL7vU4JZ0g1OXL
 C9gZA5zN4eoEq51ydS3FKrt9Gopg5am01zJNWW7AvmXU9i0eYTS/AdL2HpG/G20YRgY94
 t0QpV1JTOTXKuvg9BMAZxVO8ejOP0TJ8wd56PvzU9icmQNVd6pbdqtXULsW0ULNsdBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793370643;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=KQtSpQiinvP7bmjZ9hi7Yxk+6mViQ8oBMn/wYBWy7zI=;
 b=qe2omHZ79GNgvnYxDWaLwnggC9Ep2NsNg3qBgwpm9a9G2ULskasYjYFvonwI4d8Qe3T1
 kNC6zmvyOnfXOQdIKDzAswrNCLPWIQx2ti5p4Erh/93HG2Wvz7IJyPtW/jtDxoHLM4gWi
 n4jTilxAODAzGSWKYDWPlqWcuu9bdKUvej9w5cEj2DVrbQ80XYXEUM6jZRnLKv+LnmNCu
 LBa304iCzZeBSE8uv+GIGXWEchXxQ8DA0mzv0XGwLCcPT0adpNfc4cUSLqPJi7AEqn82T
 rSxl/1HSyoEa+pydcS1K6GU9QefMjjk+Nzmm4jnY/QaVBtAN4rB37mU0z4TvpIuQ9Wg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Qp+3gpgk; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Qp+3gpgk
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29ADB40D9E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:30:42 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4a77761ff8aso582951fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793370642; x=1793975442;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KQtSpQiinvP7bmjZ9hi7Yxk+6mViQ8oBMn/wYBWy7zI=;
 b=Qp+3gpgk5KmAEbsVwMp5QkNvX5FVWmmIdxY1x9TZFD70hS5++eljEHSIkK5bhCPFnt
 5LQJp3p1ZXGc4OSwSFgsavtnABc/JEuQ9YOG21PjxToC38ej30tJZG1/UVuj4xUpc1ig
 xKa23jQ4DoSv7mSF42idN3iFhK9kmw+ZZyPeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370642; x=1793975442;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KQtSpQiinvP7bmjZ9hi7Yxk+6mViQ8oBMn/wYBWy7zI=;
 b=1S/E3oJ7nD43mt8ojcKvCKHSuBGn3hso82DyyYZ5TxKnF03BzWvfaLEy3f9J2kFGR9
 IEvevRvVWZU+t+3Yv0F/N4rhc3LxwWySdJxtc+hVz1J+q88PETJlBGFeItf3LCAgWHmS
 DXkbP/qIQF5cca7nCUZpYffXDgxa5P0wbiTA7vtgag9eWvizsfu49s0ssnohjgXmmNkc
 KCWHqNva/gaUHhipDRks5HOZM13H/UALHh7mO6LnRD/WorEpBVa7XDu3L8xeSj7SA1kd
 9nYDAfwUVBJq/OkyZeftPstvONEJ0X6oHqZT/Iidf3lJZO5OvXXt3ZxdLSxirmagMYpD
 RuEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMJty3FNR++VRzCSYsps3vG29xcjXurRLukYVa0n7ncwlaTdH/1ZtAD1ACwlr139dcj6daNVE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI8UkwE5GR3MVvmgydFyBNxUYWXPHJkbiBRccxLDp1Dk7wiP0fq
 evSCtHQ1q8axBwnlOU5tEo07pH6D8jFFrzq6sN5+t/AIn+IF0Iyg8D6L7ZFwKagdCQk=
X-Gm-Gg: AYBFou2ANF+n0WVChLfPHSaajRJZz9UgvKY46DoGDi5A6CxlmA4kSohLk+k7WIz5keI
 dzhxHF1B4GkXY6bHNwvMau3oNBCCz66gRc/ZZ7vt33M0yTaAU85zj0CuWkOHGDvefuuOVMx7JhE
 XDY2byy5W1v1SBkOWBXdqF4MnMB01+I4Ck7QuxtVPuqIVZlcDFmrDt3q8BmsLcKQvMkpegEqnnI
 zyxtyGCNAlrIFqazBj3vS9pzCvfgrdVtr6397JirE5PyKSFlR052ZL69fA3+THLI8UOtCWYSgXJ
 /pV6z41X6c+XggxxsyVQufUMdNd56PHRpt3L3FNc5QTHyPUSZz3g0apa9Eexmo1x5N6fJDt3Eib
 UFXsa2TL3R1ubP3sUZ7lWj2NtP6MGaVT3HsHqhJyREfvi+4n70LrX0hPJEOm4haeP85oGTXBjl7
 1oEAjxbPIiNc57RB3OgKCegWEUbiJwDoU1Hh2vhIch2fcG4T0Tg1bq1ekbeCkNGqJv/A9l97qYp
 v+x6mBm+gY+rNDATrNr9AR21Gua4ES1mvoGnCCMu1zm6b3KGtFGApAqPw3khk2FFZtnybKBoJ26
 QhO4NlHeD8wH1Ye/jLOp3CuQbOm2gsIjwBBFnIOiAXlGQ0LCfJiW3Qhr0GKMenWqMAA1AoKzRyr
 dm1Bpb3h38Uim4Cy9xS59aDLcwQcau51ocN5oUcZ1m/sZDFGpNwTJc4ObhSRwgLSw9cKgUUCDia
 NFjzK/FEdsg/kz5NzfnZZlo05Q2nQBDL+g
X-Received: by 2002:a05:6870:5cce:b0:4a7:2342:e65f with SMTP id
 586e51a60fabf-4a907852eb6mr1506210fac.61.1793370641575; 
 Fri, 30 Oct 2026 07:30:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9218ef39csm70283fac.6.2026.10.30.07.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:30:40 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:30:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 1/1] cdt: enable CDT for Shikra SPL
Message-ID: <20261030143038.GA3288491@bill-the-cat>
References: <20261029062431.3117727-1-abhilash.v@oss.qualcomm.com>
 <20261029062431.3117727-2-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RaNNjtDxFxGGI1K7"
Content-Disposition: inline
In-Reply-To: <20261029062431.3117727-2-abhilash.v@oss.qualcomm.com>
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


--RaNNjtDxFxGGI1K7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 11:24:31PM -0700, Abhilash V wrote:

> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>=20
> Add support for loading the Config/Chip Data Table (CDT) from eMMC
> during the Shikra SPL boot flow and registering it with QCLIB via
> the interface table.
>=20
> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig            | 73 ++++++++++++++++
>  arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
>  arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
>  arch/arm/mach-snapdragon/qclib.c            |  8 ++
>  board/qualcomm/shikra/spl-shikra.c          | 10 +++
>  5 files changed, 188 insertions(+)
>=20
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/=
Kconfig
> index 9e23d6d8948..7f5a9eecb7e 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -76,6 +76,79 @@ config QCOM_HWDETECT
>  	  Hardware parameter detection from SMEM and TCSR for
>  	  DTB selection and other platform subsystems.
> =20
> +config QCOM_SPL_CDT_SUPPORTED
> +	bool "Enable CDT support in SPL"
> +	depends on SPL
> +	help
> +	  Enable support for reading the CDT off the boot medium during
> +	  SPL and staging it in IMEM, so that QCLIB can pick it up via
> +	  the interface table.
> +
> +if QCOM_SPL_CDT_SUPPORTED
> +
> +choice
> +	prompt "CDT partition lookup method"
> +	default QCOM_SPL_CDT_USE_PARTITION_NAME
> +	help
> +	  Locate the CDT partition on the boot media either using partition
> +	  name or partition type GUID.
> +
> +config QCOM_SPL_CDT_USE_PARTITION_NAME
> +	bool "Look up the CDT partition by GPT partition name"
> +	depends on SPL_PARTITIONS
> +	help
> +	  Locate the CDT partition on the boot medium by its GPT partition
> +	  name (CONFIG_QCOM_SPL_CDT_PARTITION_NAME).
> +
> +config QCOM_SPL_CDT_USE_PARTITION_GUID
> +	bool "Look up the CDT partition by GPT partition type GUID"
> +	depends on SPL_PARTITION_TYPE_GUID
> +	help
> +	  Locate the CDT partition on the boot medium by its GPT partition
> +	  type GUID (CONFIG_QCOM_SPL_CDT_PARTITION_GUID).
> +
> +endchoice

I think I made this comment on another patch? Since both options in a
choice depend on something else, QCOM_SPL_CDT_SUPPORTED needs to depend
on one of those other dependencies too. Please make sure your other
series don't have this issue as well, thanks.

--=20
Tom

--RaNNjtDxFxGGI1K7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauSqDgAKCRAr4qD1Cr/k
CjUfAPoCmfikfLKcbd9HlBwhG88TdP+VQ31bdEin/kw2a+d5BAEAr6bLyqMAZSxz
yoUBo4nf/YaE3H2dbsx6pc5yMlgOHAo=
=ODe+
-----END PGP SIGNATURE-----

--RaNNjtDxFxGGI1K7--
