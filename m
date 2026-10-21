Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0B606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dRjK/63N;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bsofFrVk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 073E7810DD;
	Wed, 21 Oct 2026 17:47:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqyBPOCnbIhy; Wed, 21 Oct 2026 17:47:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40101810E3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792604835;
	b=Widu3IpNpWt9JCI2NkPrHn51RJWKMtZMOZl6qGeQw8Xdd4PeigB+O6bM5X2nyzgTg3F8
	 ub5IOjvzJLAnN+gg0nFGZ89ei+5HDiyRjrC9h4rswqqnxsRCH2f/eImBARzJBnyePPFTJ
	 Ojkk2oIWBMYXKheWE4gy8bWLVg1yM+s8/r/Udx1PjKwxZa/jKrwHle1QqEXJw1lGPfgdY
	 hUbSAsdi5JrLFI8GbBg9SSAty/0mFh/MPOe1NybGXo7j9VXFUmnKypjyrp9ryd0uAU0d8
	 Mtrgv7aghgGDtetXxTG0oQWySpx1llEOvK/ycby6SSkOJMosCVFwIIGhPuA2f4cztdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792604835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PYOBJjsbAEE0r6uf5uPcLTkV4J7rpM5tudGaLRIv7AQ=;
	b=Csq2eA4eoWaLi/cTdl3cTIzSK6ZBR9Fi9BZB2GDDT84vAg+Iil5AyGAoMUXsiLpmcCPx
	 EOtEREtTt8815OIxJvtKjSZMqflvfr49WYgNo6I11mcUdCfmIk/HP0zyLCAmtkX5SGQjj
	 r4t4O9KAM6wbxA0rFrY4JEhN+b4PWJe0LNBbwvIL/FUHigJl1D7n9qsZWVCBGQ6ankCw0
	 6jOLxdCWhxYs/kDneVA90dl8zLpJGSMwLvNMMEFfGFVFfVntcWwdD8VsCWuPGN6IEOFNu
	 udgcIo+YYU285lXh517QkgqlxrNQUL7gL4JPk+Ul8OR0GkJpmoGVn4F9T52QTKGS6pw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792604835;
	bh=PYOBJjsbAEE0r6uf5uPcLTkV4J7rpM5tudGaLRIv7AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dRjK/63NYE5dE+K4w0kGbT/gQzDXQmmhT+6oCkKrdg2dl4uddliwmSbff2eOEC5bp
	 HNo6LveD/ai0UdP3IU8Ymkq20yMQrzaYvMdBBlMb+gsxcfTKFdggChMc9xE0eZvLoi
	 p+Dnt65lNS5SNopHFI8ydeb4ZTm0X4HG2fyYzN++fLqvLIzOfoVKCcLwacD6KV5xZC
	 +lW6BmFCZPughFRDDVjfkfwyc8S1gsILQnZd/Z2+0YBipuDWmD08yCpYnD+FN8b5y6
	 IeB0MV/olyq7SwpvPwEm1RXN6s81O+r1UEjEyS9Ii1sqUyxMG4AmjLuyK/dEyt8Su+
	 z/Qvzes8At+aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40101810E3;
	Wed, 21 Oct 2026 17:47:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 63FFF235
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55A15608B4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:47:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWJK99XGGXgj for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:47:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B51A606B6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792604832;
 b=j2cfqybeVjJdw0rmA2C7WEeL0qDwM768gdDnFc7Ln5R3RDNrT06HAM3KPIAe43E3rWmi
 i6ERQHc9CaRpg7VZw1F6p7lRpeSDeuA+6jGCbmbmfVCPlvk0HTR0xH2D1BWyLfPG400yw
 ZVry81RQh0iblBhYGAjbE2QCdyE0kS7dcDaRM+Eni1XogbdeHF6byQ7s+SlCx+8FQ0Oau
 18g7DqDIi7V4jAYSkJpfc2/LCvOFSADmMABD7smdMhox6PvXzZSbSOGC73W3vkromv2nN
 KVbtb/WB6m9LzqRifvUeVK3zGeDuKTLWNJSGxgnRBT8LhoNeiyMZ/7WCSsHOxl0YAbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792604832;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=PYOBJjsbAEE0r6uf5uPcLTkV4J7rpM5tudGaLRIv7AQ=;
 b=FRJaTqBfIsphIR53B2p/gHnyRcabOVjAuLDjZPW/81P8I3Lb1C6wg1vNbqlE4xbSjiei
 tS/VAyknCvUEBX/BGgPipJs8+zOF8EO7jcxzgJsbKPbql3gTzVYpQsXEQ+yJhtYic1UHO
 0xdF8ZsWSTXOijCBIxxaVzlHl1UCgpiKoiopG4jqxsYIrx6XD7/sKLY890NQVQ6pQiN9s
 gTbLc2L7mCTikoM52CqpYspX1rGMDQLa8m138corOMLWid+vDyK6g9J5tPFXFDpq9UnqC
 ufbxPQI3NI8z09RuPrm2i5lrxlbParZDwYXKvrf5IU9KGcfuDttFH/7jCLKE4GJ4UNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bsofFrVk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bsofFrVk
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B51A606B6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:47:11 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6fe4372c5f3so576787eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792604830; x=1793209630;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PYOBJjsbAEE0r6uf5uPcLTkV4J7rpM5tudGaLRIv7AQ=;
 b=bsofFrVkPd38rV02KO5DFjSPB94A+pf2f1CRf+pP0YTy5tZnpd1bLeZ361jk2OkWEO
 604GQllsvvavLhWi3dZ9PH8uok9Sv0lA09vfH9FOmOdA6Phul/JpKUxi++BZpmYiHqaT
 nzTjW4zlgkrAhXgUms1nJYRrEt6TFFFtVke0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604830; x=1793209630;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PYOBJjsbAEE0r6uf5uPcLTkV4J7rpM5tudGaLRIv7AQ=;
 b=DDh2/K00NrchHqYikyoq4Y0TWlFZtVeQFnLNRsK/FHp4sVW9OWoxtb69jnuBuwPtsY
 iHm8TdRi52XRH7r40c0gb67T8fug4wMYHH//npIv9H9JXXJA+/WeGny4pMeycWr7S5DU
 1qyvYOTT7hBXCC0v35U3zwf0ZvGxQ0Czs22staYvLASdbup8lTdrtRBRlRGPSQopz/QZ
 gzbbf39XJe72vmbIMApS6s1wDDMLEecoSx6iFptHThrM7pZXRCK9VcLkyfsO6CoA5jEv
 3yAf3wsTFrEKZXaBShmw1ftV+k0DZ9PyaP1U9yjyJOsPIhXm9reClzOSIWai8MTd2fjI
 Rzbg==
X-Gm-Message-State: AFq9FYIEQDmqb5G006pR1ql24idQ97YazPwIyhEjiwfC+kd7CF43AwdL
 iilrqugxyz2SrrTGvqSvzRGUmHG2D9+rIEmPOatzuD99YE2Ew2Bb37MAoFS+C46hWnE=
X-Gm-Gg: AYBFou33GbRLS5lEdpiIpyFyuGyrTWqajcTZ40MFEyg9L+O2xNGnpfaOuXuo2KnGfGk
 XfUSLUSexDpYLuKAzh5aTysBr9TkCoSiAYRYjSNZ7f5uvxC6LFIQzQFrAUmLtCdeyK2lvH8kBWh
 L8YyR4mUVy/BGs4Bl/w0l0VynhILOKuydknU2u95RF8S15sTRqcrybDNjnFmRVRMZ0SmbE8GxP2
 ZhGLkyeyQWQ+rvCmgl/K3xyzcwDGnaVw/VgCh7sX51Pp3v1b8PFDnnXIaMyh21Q9xNmdSvSUs8c
 LNXBmCfmTKAuc302feWfjDKORHerFSjZwp92Nwkoi030o6EtTLFEqKbHjS3fIEvla9Hobonk1I/
 2FFB7V3d8tssJGBYB+wmvmyAA723inuDZ639a4l6i0Q4t/FFx0AgOsZPJSQwg5URgAk7WJFmWYj
 +N55HNnCNY/Sp2ot4mHS51/jvw7S8k6QUbXIlmZ3VoZKhSLbSqzi09nPdIYAqvCTnAH4LbEF2p+
 iKS918CKSY40vNpzAlPqXVA2/7o2Oh29AzCmGqZSi0OWBYjOYqkV5MbFVszBxP+IfYQOg4YCmb4
 S8kiuJf29aGjCkBUUWPW7yOKevs50kSB/AY6oIfGx2vR+EdyhqTeXtY/IQvp2U9DR+LslV74ikE
 F
X-Received: by 2002:a05:6820:200d:b0:6f8:51f5:b9b8 with SMTP id
 006d021491bc7-7093d695c8bmr1639658eaf.7.1792604830653; 
 Wed, 21 Oct 2026 10:47:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d62249cesm2389046fac.16.2026.10.21.10.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:47:10 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:47:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
Subject: Re: [PATCH v9 4/8] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE
 option
Message-ID: <20261021174707.GC3275858@bill-the-cat>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-4-18ce3e431320@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j9CgiePRjzeDvSmX"
Content-Disposition: inline
In-Reply-To: <20261021-snagboot-v9-4-18ce3e431320@oss.qualcomm.com>
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


--j9CgiePRjzeDvSmX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:48:23PM +0530, Balaji Selvanathan wrote:
> Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
> platforms. This config automatically selects the required dependencies.
> Express the platform-specific requirements and configs that must be
> selected and disabled in snagboot mode.
>=20
> Add QCOM_BOOT0_SNAGBOOT_MODE as a hidden boot0.h config, selected
> automatically by QCOM_SNAGBOOT_MODE. This boot0.h config is for
> disabling MMU at the start of U-Boot execution.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v9:
> - Remove depends on !IOMMU from QCOM_SNAGBOOT_MODE
>=20
> Changes in v7:
> - No changes
>=20
> Changes in v5:
> - Made QCOM_BOOT0_SNAGBOOT_MODE dependent on QCOM_SNAGBOOT_MODE so
>   it is not exposed to users
> - Add dependencies for QCOM_SNAGBOOT_MODE explicitly as "depends"
>=20
> Changes in v4:
> - Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
> - Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
>   QCOM_SNAGBOOT_MODE
> - Document the platform-specific requirements and configs that must be
>   disabled in snagboot mode.
>=20
> Changes in v3:
> - Newly introduced in v3
> ---
>  arch/arm/mach-snapdragon/Kconfig | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/=
Kconfig
> index ddded0029ef..db770ad6edc 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -82,4 +82,23 @@ config BOOT0_SDM845_WORKAROUND
> =20
>  endchoice
> =20
> +config QCOM_BOOT0_SNAGBOOT_MODE
> +	bool
> +	depends on QCOM_SNAGBOOT_MODE
> +
> +config QCOM_SNAGBOOT_MODE
> +	bool "Build U-Boot for Snagboot mode loading"
> +	select QCOM_BOOT0_SNAGBOOT_MODE
> +	select ENABLE_ARM_SOC_BOOT0_HOOK
> +	select SKIP_RELOCATE
> +	select ENV_IS_NOWHERE
> +	depends on !ENV_IS_IN_SCSI

You probably want to look at testing ENV_IS_DEFAULT

> +	depends on !PSCI_RESET

You earlier change PSCI_RESET so this is redundant?

> +	depends on !SAVE_PREV_BL_INITRAMFS_START_ADDR

Why?

> +	depends on COUNTER_FREQUENCY !=3D 0

You probably need to be setting a default then for the snagboot case as
I assume this is currently 0.

> +	depends on TEXT_BASE !=3D 0

You probably meant !POSITION_INDEPENDENT, and need to set a default.
This doesn't work since TEXT_BASE is a hex and 0x0 !=3D 0 is true in
Kconfig.

--=20
Tom

--j9CgiePRjzeDvSmX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatj6mwAKCRAr4qD1Cr/k
ChHaAQCU2j67pvzZo5mLfMHEic4TDHu+hfAe5RDR/SL7AMKPfgEA/ayjp+N5PMA4
JT3paI2JhcdmHOIJRn/Q3dU04doR3w8=
=M9i5
-----END PGP SIGNATURE-----

--j9CgiePRjzeDvSmX--
