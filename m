Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23604606A31E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l7lUkpil;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gfSyGK1t
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E85A58112F;
	Fri, 30 Oct 2026 16:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FVZrjzMtXmi2; Fri, 30 Oct 2026 16:31:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CB5081174
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793377878;
	b=ozP9yJ3XamCTb/F5r5napyN8oxwfdTO+5b0em0TnkJP4x6uTu2g38l9Dbt3vR0H9fEyw
	 2P8HczjmRqEvI4cC44xum2DGGWcA3XYkSQ+ekjFz64WHxcKEBIRALnysP1SpxYHJ9QIRE
	 aHFKwz4RK2+wU4smBrbQUDNdlOtwCkkkTxna8jLouLVkyBpwf5bRuZtbcIsxvpJz3L2nX
	 qUVoKy9IUxkvUWcKNU33kMWcLA6PYsUoCYnvuwZPamZ0xpqEM5bDKMVBoU933QnXrhboz
	 dJ9iNZi2Mdd8sIFfzMavIqpBqtID2RHrfuTTpPwZb+8AD0prvXC3rDgl+qoPlOo9+aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793377878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZP1jMXDxGqchNc6zvrdb+mnuEbziOMRfT/oEEe8zSNM=;
	b=d6TceZn34Lscx2VwXTWY7mJAN1WZutdGQ+F2zEjYfgGBbeJmvGw9+NUqloNqw4WzQwLZ
	 8aNUDv9eJJHLzQLU1riGiZ1eidBH5cmHmgSsAPQ1yLt+z6SBf/XL9STux2CuhV2Sgy9xc
	 5boouYSAiU+n1cf5If2eiJKyfdWewDykP7I8peFgCm7kbWk1Iq/UR3vgHHn15v8BHv+CU
	 WLK4S/BH+6zxwe2OqTRvS+QDVjcyVbWWa02RNf4GUd6rHEzt3GHBHhUPjuA4N53awyJ6C
	 A/oOIhTmWI3wfggT1fF8AtuiUJ95cLgbaOjJbYPiKyWjqd6bV75UYjdVNoJNMa54wZw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gfSyGK1t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793377878;
	bh=ZP1jMXDxGqchNc6zvrdb+mnuEbziOMRfT/oEEe8zSNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l7lUkpil9gXyRIBr3Y44/kksklYio135M0OLbDe9a59XZnE0XHfms+AemHK31lDoG
	 rQnqApxKe57zulCrDtpY1d0f1OJBPSLFV/IZE1L2C1TvXd+EAsMQoaYBdgrp8LHKFJ
	 XnUz8vQaHPzGV4MOQeAN7M06ABct8hj/Fz+KoKIx9rI9mil7Lrid3Sx8b391jB+xic
	 za1djn48Fr0P7MEpSNBemXq1rqBnNI+M7tbNJLybXXTO+OdF+BmZ5ZY+oaxe8HI/Uv
	 AUNOOlWcmy2gHg5dqI/H6I8jj/J+/3w7w7MNESmBCH59epPVxcKbrZMcezhUuTcnCf
	 bcIe/u6X1Nulg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CB5081174;
	Fri, 30 Oct 2026 16:31:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31B273AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 176D681174
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:31:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NrXaY4npQND for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 16:31:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BE9B8112F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793377876;
 b=Md86TosnGvuYcdufxT4ZpCyHLTGBWcRg/Mse80hyEcKgL0VPKiwo2RevSHOXH1PLkyFQ
 6+uG+D/iJZ++2ETZycwGDemWMAAfIR3VWRsU9UANX+VUYnS3HHvt1e3IwMTX2kIgSVJLv
 w8JXL112txyUGfXDbdILrsRf0KResVIIrO5M6xbyQq9EVijf7Mx787eyYyqRxqoCG3nOu
 tKPwCgS2ykbop/Ylh5iaNoijsNaXiXa/GOomZiilLvJhd1IHQYTl121Wa4NJdK90mDFxW
 A1OTvIGSJ5MeWHhDitVpn5lMAwttnhnPT+D9o1DXR6WYruBs1M2soTI5/VogKy0QmGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793377876;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ZP1jMXDxGqchNc6zvrdb+mnuEbziOMRfT/oEEe8zSNM=;
 b=bQKGqPc0svCdXAy+++3rCkAEol8kYUtgkpnsQgrlHltvXLfZXeAANb/lDt13+/lwpz82
 LyRKorfQLi1plQKu4Wr5+cDUQ5AcjocNfstaoe+s/38wePOSn64Q4UcxPiBE5oBE0yPoN
 QBEn3qOo/pNt2rzg+vVaqOtKfLkAPpEvIfTCaerOoAV3GnPioLG2IYTRyiMbIS7+tFhMr
 a3Hn2pbNdCsENP4tbGOXraHWdqD+VRHc+aOsEwWmmSoRj8Z3dDKVLTVE3PZgmTtcKtQTe
 TBA15imdIpY2l1NGPzeJKackpcXhqfmApGwgdkIkhk0DanMRNh31Bkc6XDRApmT582A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gfSyGK1t; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gfSyGK1t
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BE9B8112F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:31:15 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6dd7070699eso678326eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793377874; x=1793982674;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZP1jMXDxGqchNc6zvrdb+mnuEbziOMRfT/oEEe8zSNM=;
 b=gfSyGK1tyWHfvFnglFUlVFNZtoRQHo3g6hPgxSrNPCuuNsQtURfiSLlAO12x8jgg1p
 DYXo4BcucER+Kco3YaFM1Bdj+oTI8FmWuaTZKi1xfvnnwjlNOKEEwosrnbcI+WjGhTJb
 D2dOOQA/ThzwOi6pn3vWypB92VpyDCrfGCJK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793377874; x=1793982674;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZP1jMXDxGqchNc6zvrdb+mnuEbziOMRfT/oEEe8zSNM=;
 b=12DZY98gQDffpEPznpidDqYw54L8+m+hlvwRgvj6N+ZGq/E888Sf1q8US2zpKyKHYb
 e9inZrfdw/Nf116TfBAjuo/qWreFFPWTNOWdVIagmHv3rl7xU3rWvUu4qSkhihJ11tda
 rq1YBRx+5rXvoSvAWFPHse4hqs5DRjxHQo7+mxY1VIjYRrFUeF/Jx5RrtIM+ZS5ouoLB
 m9xA7rzy6s366M0gXUWg+ZIl3nwdxz88G6qiziOkKyMzkDkdn8txLaYW4PPEh0MGr0hx
 v2NJClQANOry1OddqlAVMOGpb4yQZWusC+v7dWCTNOHAHyehqtiXQEjTj5OxGPbaRcSV
 Uojw==
X-Forwarded-Encrypted: i=1;
 AKwUvByLDc+b/RzqU5ak9tAp9XK3UgWxSw0WSy1J0D7u1X5Xt/5F8d+7Rx0UTgfGln0kbkC9VTxy6Fw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKwGINaTcbVxlD/2SqB4adBQjrhexvVTURBgN4pNRz2wWFviddh
 v6P0jb4d36OhjtSgtzqJcUx9GHTBJ8laTZlL+k5Z4KbgWeAwscsViVjkn3ftBIQWgPU=
X-Gm-Gg: AYBFou09PDcdzUMMzEUezPZ+rbiy9sT95GBtKpXWwNCXluuFszDoMmAgUEvWC5/sfGL
 Lw0kPte5M+UJE9C7/H9XpkngLGTx1wuHoIT1M+druQoZRGl8p+6UkS34gv02yVjnVfP25DIUlGO
 2EUFqPbcp+uuTZC7cKEL3O5pgkyszSWKafYDS/TalCIyZO5w/s0T+0rCHzL2suI1J4oTUH1TOYF
 Nz3RrIzE7kQhKDwPISUUdtap5jOCX3xbXtsj4iZ3hjAbyjfza7VuGHlqmDqv6c/fuYTJ5LldN2x
 JDb8CJeOH12l7Jh/kLqtFdbRIFJu1xu1qpquFdpKULDaO3ot9Sv5dv899VnyM/O1/Oeqj94oggF
 GZcq/h1TMkvw3b9fjVcJsEwowSbNVMqJcWfxEvXpKB9/skCrvrxpfLaxShwab5MypYkIayROOiR
 FbglnoMNO2BnfR1NgnKHrbaWhiV1Ls9pPzymC+TgPuNoJvoZ7LpuxbXXIZ+5OafEfFnFta1AIqz
 Nc5ZSkvSXBD4wvrU46TSwlGpMYwQtksuUls1sn5O6DPxW9NJ0b/8TbIiGKyR0/BzeF7izbTxjkS
 Ku75QH2voiAQsXoOimAGWwVLfbrO6v7q3pOAdoFsSoky0GMU9U2qikSOE8h9ZxLn/7Gpn324XFN
 9Y4lv6K/zPbliSqgDrPpS08rlHmZDFF1ra0iz0HHpzQUt2k1pn22ClrKrC/z2YE29jXEBiN5dbY
 1GVb9hkfLH5KQhHzyTBTauKEeVvfWcWyJcJ4InnbJJ6L2ZtZ2jq405
X-Received: by 2002:a05:6820:a515:20b0:6d8:57bf:57de with SMTP id
 006d021491bc7-714f24fb57amr1280167eaf.65.1793377874582; 
 Fri, 30 Oct 2026 09:31:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545b875sm2454071a34.5.2026.10.30.09.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:31:14 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:31:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, balaji.selvanathan@oss.qualcomm.com,
 nathbappai@gmail.com, Michael.Srba@seznam.cz, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] mmc: msm_sdhci: add HS200/HS400 support
Message-ID: <20261030163111.GC3309461@bill-the-cat>
References: <20261030134145.2349821-1-aswin.murugan@oss.qualcomm.com>
 <20261030134145.2349821-2-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wX5DCoLQac7dKc1O"
Content-Disposition: inline
In-Reply-To: <20261030134145.2349821-2-aswin.murugan@oss.qualcomm.com>
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


--wX5DCoLQac7dKc1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 07:11:44PM +0530, Aswin Murugan wrote:
> The Qualcomm SDHCI driver lacked DLL init/calibration and tuning
> support, so it never negotiated above high-speed/DDR52. Add the
> CM_DLL init/phase-tuning sequence for HS200 and the SDC4 DLL
> calibration for HS400, matching the SDCC core generation variants
> already distinguished in this driver.
>=20
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Change in v3:
> - guard execute_tuning under CONFIG_MMC_SUPPORTS_TUNING to fix
>   undefined reference to mmc_send_tuning when tuning is disabled=09
> ---
>  drivers/mmc/msm_sdhci.c | 749 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 748 insertions(+), 1 deletion(-)

You're adding 748 lines to a 358 line file? That doesn't make it an
outlier, but that's *a lot*. And that's a lot to review. Can this be
broken up in to logical chunks? Should we follow the example of some
other drivers and introduce drivers/mmc/msm_sdhci.h so the driver itself
can be better structured? Is there anything in here that we're
hard-coding but should be able to pull out of the device tree instead?

--=20
Tom

--wX5DCoLQac7dKc1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTGSwAKCRAr4qD1Cr/k
Ctb7APoD3ev290jH8sSUwIIg10QukR0rPLKwP+dGlBtrLEQ4IAD+JYQ+z7ysrjrw
XG9y9OAKvJk0WPAcSy09pGrGyEf0CgQ=
=8uas
-----END PGP SIGNATURE-----

--wX5DCoLQac7dKc1O--
