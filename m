Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BB1C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 17:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F22E60626;
	Fri, 11 Sep 2026 17:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C1PthFjStbhd; Fri, 11 Sep 2026 17:41:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8E20B6061F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789148489;
	b=oSMqFpj/9YSShlcsVqQDJaYOrax+XaUTKw6jWysgb8w1irVINionU+quNvaxoLdrPddW
	 RNuDccIXystq/r/cGvBa17rszrPrFaHSF+tXEYp9nvhqRwofFQCBfqVk/YbqFarLTAgsG
	 DKfT1A2gSpFBu0T4DIE6rBKaWXxavHkaUKu8DE6oYtpw/e6p3rav7TXscOBITYXMlYHOy
	 TyHkrC/TiiEf2HFH1EMyRPxWdP3IAO9TuKxRcANG/mdrlYvmgGjfv2QjmRlA0xr0FIxXx
	 6P8jLd/F9I6VXa7utJYBFJWK+Bz5oPvPPll9nLte/asZoKRx/4XTrQtprFM1kt2+wYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789148489;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tSNwMCjIxDv2Qm/qf4HgP00oimauKSwE/ND/olI/AGo=;
	b=Ga1gyu55/6EgKCaZiZHBAnFLwPKu359fsvVz7VaEzTuxcywW8XrymQ/upj3L3x/PfW18
	 GXebyocNsflPs+hXgpuvM5Ntcd8wl5b1uYf5+HrmxP+bPShU5esU44qCxDSEbuxfcU8wO
	 nnEFvnvZCpebZMIbG+Lw3uXpnx6JeoAC5vzm41cEmCrWc4Y2beiVQCSuqurBio3fhmNo+
	 +mbt+KpSku28th+QeG4NaakYBpMfp0Nryvugf9kWMMcYDTa6V7UuvgaswrhOWFOb7Mwu5
	 OqOZpduppNOpU3BNx0VD6CEbEqiF6/XKaTw6vNz5JSX7no9iFYJ9aOx7ev0TT6MxrCA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789148489;
	bh=tSNwMCjIxDv2Qm/qf4HgP00oimauKSwE/ND/olI/AGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qeKAPTiwHz/nUR3ZshA/HwY5pSs7k2/IIm+gmYaNQubcNQXDZHrKVnehLcMjdNzOP
	 QUanKhpuGNFhLht01tLtHNxzK/HU/lRtO8S0DDCtak1dv940IsQXb9byCE6gS4LfbL
	 cQR2cfTwPQ87wrjpqgX8O72HFYCyCSjm+PXsZp7zo8Aj+ycD22qBtXanpeT10rLuRv
	 Xp8tJhIrejw0U0Fho31jMnQlV5sbEunm5nWaJOTxvvsf2W1OZTx93f/7YMNEM16MT+
	 VcPCnTsDWoaM2m4+AbhuNo7XJNIQD8b/TtCWD5/QlUDL/ccO00emqAKoDSv4YEg0mW
	 Pnajz035h9ZHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E20B6061F;
	Fri, 11 Sep 2026 17:41:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 320D52E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 17:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17EBC4059E
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 17:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F76FK9Wr3RDk for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 17:41:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2203840542
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789148487;
 b=O2QC6Cqwho4PuFNQhoh/04ekdT2xmtz7sHNq+T98I2Pu6/vlMg2ea1vseNC/tszL+YvS
 uOCUmzXj3t13CJ6dmshry2zDzys63gnnZPbnu8yvf4gsEYQwWaqtbHSoe4PqFVCItw941
 MDE5d/eqcCUQj8RkGaHr//20Jqz9f7zhuXDGHBDheFjNK2NHg0wpGU6y/AlV4iIeMjvXv
 MVA1ni4dpRvtyNUo2K1iptAbUonoP2LDvQj+qf0kVlp2GModkg2hYrIG17NBx5hOi7CHL
 mHQzyZhb+qviiUD13Dfe3uwb3wb7CrXZBHr2jKQa+N4MWfOJofJP8kFPfMfyJDJ7NeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789148487;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=tSNwMCjIxDv2Qm/qf4HgP00oimauKSwE/ND/olI/AGo=;
 b=mQ3pvwoq6nBEqI2Ko5yqROw3YnpLnZ7iMCR43mNsupvMLKDKOdqLGkKeew8/D8FVk0bj
 utUrM8JjatXHLrZ5f+eq8gajmoe98WuEYk8D7mZldqpMTDtamlHOdlzoKJjKnCMTlhN1R
 hrq2hSZd0H5nyQ/u5G64YG5q7I7nV3duuKElX4VAxtcbLv2IVu5jKDS9dVlA416eLTJfc
 bEyo4pgTRt5glzKaCbqYfPpQQEmWQP5v7NIugLEGbf1MAvDezkaF+GPVh9ibx3UPsSJwJ
 HXzgiYWMlIJ8U8GBfex288HJiRXJ2C41HBIZbFJl9BIrJhnoyihUfMAgmoXlHtHDkMA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OpGHP9US; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OpGHP9US
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2203840542
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 17:41:26 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6bd209cf210so581333eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789148486; x=1789753286;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tSNwMCjIxDv2Qm/qf4HgP00oimauKSwE/ND/olI/AGo=;
 b=OpGHP9USEnC4EJ5qVdXaunGGtSQwRQaOn1qvzRuLisSiqjW39nIfIQX4glOyQpHpv+
 +Xvih35aCGUaN8srRpChg8BUKjEl4ajUPoMsT3ELxLAA2oTMhd6btFlfV1IQlXZbFF1j
 5NWv6DISQ/oVyJ9pTL+tDPCLIi0nAJ3PHiIhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789148486; x=1789753286;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tSNwMCjIxDv2Qm/qf4HgP00oimauKSwE/ND/olI/AGo=;
 b=Yxj4wqmqKL7DpMzyIx+qKXlfVT6QlZstX0nNz+ze9JNc4RISwL3DjNCEEsWQSnPvSD
 r+afsa1lPMh8PbYGRaGlgN3UTu5rCoMXW+eMiklskEJu+NeJ5buI2LXa+Z9VCS9ZB7pt
 vOsVZeSgckfK/ZWSYTiHV6MbG3oCfe5QBYJrDnQHT/UV3hSOgg58VMpUwwt1isET4AWn
 ev24WNNUN5/CqHZbIS1vnMOvEH66XgsudHKYKFJErtHI1jpQXV0Wxx5gNGLk+DMUOFko
 nq+960gTgjTWdWEydA0do4CIIPxFNBH3BRRLesS2ajpwPfTOW7cFWxoMt7moICsqkP9a
 TDDQ==
X-Gm-Message-State: AFuF++kqSCRvjrfhy/qQ6uzLxXQjqd/I7PAeRzCwww4YGc2DYC7l+uQm
 /YuqpsXUnA59JdHkEHazaWt5p/pKL3TLrQ0HRG0lg0jeJCDJcIEE5h6D7VrjN5SQKqc=
X-Gm-Gg: AYBFou0AALkgbivOZwxicZT1WYHMOpKvJveEErQRJ3RVWZoDrfhQ+/sgavaNIAt8+d1
 walvDIUdRshYua/DfchddDhnnHyYbp3qdthKplAya906l83T5LirrPu9KSFuL1YHn84d9IzjYCz
 waBbMOPL7TtsdL77ZZ7lW0Tnni9j65G4hkdPgnM+JHpJLa1xqJYoF2nLLBBZci2xEH4r1PFdthS
 seCUjW1Lq0J5FFAIHrv0G/FVcn4HQD9fc8L/NPEVUZsJQEiAH+imEpnlki/wui2FAQ8aqw6r7Yf
 34nIkApUfeWgQh6e6EKl/QdYRDXGrBsMZV/eq5NGpkYkhYikEV0CONZVJ8NyhaxLP/5Lzv0FrZy
 0ty5BSvqe4jSMxpuNmJpSUn3DvUHp8w2Is+XrGK6w8X9upw05O2shzRtVm7m+QYpCRLWVPttxVS
 XMcUH4CwmBVZe+Bn9VLMwIN34mzqK8MANG6i55LTOGFpAhPwe1uWrEUwzGoaF9J4JgBygcVbDEL
 BJGTHJCJ4QBKUOaLsMCcXtCc6k9jhV8d2W+bzc+7fKpXDipNE6Gj7r400NgZdyFy/pCOTtdEXQJ
 Dt9UYS+Gn7PAMkEeytON
X-Received: by 2002:a05:6820:1ca3:b0:6bd:c175:521d with SMTP id
 006d021491bc7-6c0b9960732mr3600766eaf.11.1789148485759; 
 Fri, 11 Sep 2026 10:41:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c0990cc7b4sm3262824eaf.5.2026.09.11.10.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 10:41:25 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:41:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 2/2] spl: mmc: support dynamic selection in raw
 partition mode
Message-ID: <20260911174122.GS1764417@bill-the-cat>
References: <20260911-ccaione-upstream-part-dynamic-v2-0-295fefc9a3c4@baylibre.com>
 <20260911-ccaione-upstream-part-dynamic-v2-2-295fefc9a3c4@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hh3PnpUrnG8+Typr"
Content-Disposition: inline
In-Reply-To: <20260911-ccaione-upstream-part-dynamic-v2-2-295fefc9a3c4@baylibre.com>
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


--Hh3PnpUrnG8+Typr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 02:05:59PM +0200, Carlo Caione wrote:

> Boards using boot metadata to select U-Boot should not need to configure
> an unused fixed partition number. Add an explicit runtime-selection
> option within the existing partition mode, retaining its loader and
> platform dependencies.
>=20
> A failed dynamic selection must not boot from an unrelated filesystem
> partition. Reject an invalid selection for this MMC attempt while keeping
> the existing fallback behavior when dynamic selection is disabled.
>=20
> STM32's existing hook implements fixed partition selection and references
> the static partition settings. Restrict it and its MMC2 setting to fixed
> mode so dynamic selection can provide its own hook.
>=20
> The board hook owns hardware-area selection, including access to metadata
> and leaving the image area selected.
>=20
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/mach-stm32mp/Kconfig        |  1 +
>  arch/arm/mach-stm32mp/stm32mp1/spl.c |  2 +-
>  common/spl/Kconfig                   |  9 +++++++++
>  common/spl/spl_mmc.c                 | 19 +++++++++++++------
>  include/spl.h                        | 14 +++++++++-----
>  5 files changed, 33 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
> index f45010ddbd0..bea4a1b6aaf 100644
> --- a/arch/arm/mach-stm32mp/Kconfig
> +++ b/arch/arm/mach-stm32mp/Kconfig
> @@ -175,6 +175,7 @@ config DDR_CACHEABLE_SIZE
>  config SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_MMC2
>  	hex "Partition on MMC2 to use to load U-Boot from"
>  	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +	depends on !SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
>  	default 1
>  	help
>  	  Partition on the second MMC to load U-Boot from when the MMC is being
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp=
/stm32mp1/spl.c
> index 2229ebf5eeb..c1be468cb1d 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
> @@ -61,7 +61,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_d=
evice)
>  	return MMCSD_MODE_RAW;
>  }
> =20
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
>  int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
>  {
>  	switch (boot_device) {
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 0618f42c941..9e1c23ea0f4 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -576,6 +576,14 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
> =20
>  endchoice
> =20
> +config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
> +	bool "Select the raw partition at runtime"
> +	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +	select SPL_PARTITIONS
> +	help
> +	  Select the partition at runtime instead of using a fixed number.
> +	  The board must implement spl_mmc_boot_partition().
> +
>  config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
>  	hex "Address on the MMC to load U-Boot from"
>  	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> @@ -609,6 +617,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
>  config SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
>  	hex "Partition to use to load U-Boot from"
>  	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +	depends on !SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
>  	default 1
>  	help
>  	  Partition on the MMC to load U-Boot from when the MMC is being
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 3e637f5adbd..d538fbb9c41 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -303,7 +303,11 @@ u32 __weak spl_mmc_boot_mode(struct mmc *mmc, const =
u32 boot_device)
>  #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>  int __weak spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
>  {
> +#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
>  	return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
> +#else
> +	return -ENOSYS;
> +#endif
>  }
>  #endif
> =20
> @@ -432,8 +436,15 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>  #elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
>        defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
>  		if (IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) &&
> -		    raw_part =3D=3D -1)
> +		    raw_part =3D=3D -1) {
>  			raw_part =3D spl_mmc_boot_partition(mmc, bootdev->boot_device);
> +			if (IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC=
) &&
> +			    raw_part < 1) {
> +				ret =3D raw_part < 0 ? raw_part : -EINVAL;
> +				printf("spl: partition selection failed: %d\n", ret);
> +				return ret;
> +			}
> +		}
>  		ret =3D mmc_load_image_raw_partition(spl_image, bootdev,
>  						   mmc, raw_part,
>  						   raw_sect);

This is better than v1. Did you look in to my suggestion about turning
this in to a choice between hard-coded number, hard-coded type and this
new dynamic option? I do wonder if that would let us get rid of a lot of
the if/else nesting we have in these functions. Thanks!

--=20
Tom

--Hh3PnpUrnG8+Typr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqQ9PgAKCRAr4qD1Cr/k
Cl7zAP45nTQB0jgaBBM++G+H4G+7hfANZOw0AAhKzGZbfYpMVQEA/PTQChBA13Cu
3Xz5Q7Y8VdpWmnhiNdfW4UEdq2QrcAs=
=Fh4m
-----END PGP SIGNATURE-----

--Hh3PnpUrnG8+Typr--
