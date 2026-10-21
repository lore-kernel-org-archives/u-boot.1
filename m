Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71C606A323
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YEfhivhD;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Lhcu/oDH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 730F580D07;
	Wed, 21 Oct 2026 17:35:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 74Oci36aR3nF; Wed, 21 Oct 2026 17:35:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 993DB80C53
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792604144;
	b=sbMtRdfUjQEPm5EVgsJogSNmORAfbCzAbNmMBXnAu2QTOLzPbZ5YaQntFa3PcE+aLCbM
	 9LAEfqldwhbqOtfpvxcToBVaE1YxEbvnkImCunKF1OBV4a4kAAn8M6e8bH+TfMz0W8Lv5
	 YQtF8Z6rQNIriodW1p2gaTY0tkyEMmsVzBXAYkN0TSffd8zrFA/NWZ460V3J3ZGT8k08n
	 UDx5+sA8exCukp2hZSojt/1MYJuM6rRaRlcWDIilkUgcrmZZYm6ogHmbIs28t3yAnQZ0h
	 JYfdWHFGg/vz0g0gJHQI6k6tctwFy3M41B7Qpt2kgZuQBj6Xzml4Ia9bI56A7JGcnCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792604144;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=F9KTq5HDBYqSiIqESZii3TXPDIkg8GEO+I37vdJfOoE=;
	b=qoWiD++LRO4pxrntBY1nJ1lDAnTingryhQp++RD5Q/qO/UhBUjYaDwn/ybihnl9718XG
	 9YuFHQxcRJb5t4TJZ1NNG1Ts8MpgmKSUFz2C/3ckZ6a+inDe4pL1OPwto7H+Kbc+DnsHW
	 ASjILp4YQNsr6ANSyXZD19gKdtztj63PAxoYioo7h5N2B0RY0xF5P5GeYMQaL74EUVnFH
	 2/zZI9L9csGm7pxM7eFXgQDRNNs1VcDiGCpZMVmU08MY00tnCqo9Te6c9qHZj4pAvSg79
	 YMObzuQfxZuSbv6YBVgkatNHlTXp9Oxpg3v3jzr/QZIaAKHf3ZlnaOO7cou182tOqHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="Lhcu/oDH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792604144;
	bh=F9KTq5HDBYqSiIqESZii3TXPDIkg8GEO+I37vdJfOoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YEfhivhDJAJ4oeh0dOGYaj6MY9OcfC8Qhoo9RyvX7kotn3w74OkQk1qWgN9v5NbTm
	 wuRoEVef+x50GEpRX4VT0FxuY9qQ5i/QiYnClCiUyrHyUI776PmwibwA/ln11CjqTL
	 l3XMQThBg2fpSoGnp3E/o6++rLdDz7Qai7RK3VWqmOW+Nn1paVqNzf+nIx6NIPc01d
	 KmcffquqnlNip14F1Io0tnKuI7CME6r5O24HJZq0L0zrrljBuy2+9HTTJ7GP/hDW4s
	 iYMEueMVJk3sIxESOtuIM3zWs2vXhlX2U/e5nJubGLUbNA9icnwQ435L2ObTIZSnCS
	 2n+vCjS6tGb7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 993DB80C53;
	Wed, 21 Oct 2026 17:35:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6952B235
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 669E580C53
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 75-ZtStK5o6I for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:35:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9554480C4D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792604142;
 b=rvXtl9cQgH/COchy67Hcf2KPSxYwy4BArBxDKWUpBi1kylqtoZ5Q51ksiNidJSK527vu
 gLnx3Dt1gc7tVBvO1BxGRY4fNMxbbyZm+7IaPhI9xFemw5XnvUfqJhqzMw5tNRJUOU88o
 J6pwB2qttQwbLotRO4pd0kIB1wPZwLUwULLyMxFd01T/vOcu4Z7hCxwBuzPantdoJTeYA
 /AWUu+p2Tbbhpq1ou6+QA7qs0Je8dhTRrdqzJqN2NqFO4cPyOyhHgF2tWV/eucWJyDw97
 UcbgfKHvZ/nd+Qa+oTb9ROxYlTsxTeb/6cnSu1m/MAwyObshrzJkM4clLCrO7hT849w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792604142;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=F9KTq5HDBYqSiIqESZii3TXPDIkg8GEO+I37vdJfOoE=;
 b=gkhOEChdkNGcjpSn9m8LH1+eKqxiBRIk3rAapdJXj6cu1me4u/1WfP0k6VZ2/wj40KUH
 4FBFRkVxJdtGagFtTa5VbtNfLxMTuSqOEA/HVtY+XuHhpARlUmO7ADWKIv0i0J1hDpnxT
 opXAGWNz4zeAbiqnIuZFu94UOxeO1/D5sSf18azJ3kIDCSs20TqQho+QiXk13zHCKdOEl
 glf8mcS+kKPtv68Gjghjw+IWbwkTkvBDTjmXhf53kgTfXct4/G5GCP2DvH4S6uU5zRtSB
 aJvQcjMYNob5UDHqouDF/LWqLfQJQoWSBVdY61A/lnh4KCQddc4C8/hIPSjqrL5XDjg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="Lhcu/oDH"; 
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Lhcu/oDH
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9554480C4D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:35:42 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4a6bb779d13so473654fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792604141; x=1793208941;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F9KTq5HDBYqSiIqESZii3TXPDIkg8GEO+I37vdJfOoE=;
 b=Lhcu/oDHgDBot4a8bqq2ce7XLV2oifqV7H8wvICfijfS98RwfETzi+mHydap6E/ug7
 Xf2eSuB1/I274DAnOOMykm4XUo7mTRBEY3XiU2P+aD29m3DhfQLnuVBj6TXRLOo3UaRF
 ZchIVh8Ryl+72EqW3UpqavnoIutv3RRLvaB6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604141; x=1793208941;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F9KTq5HDBYqSiIqESZii3TXPDIkg8GEO+I37vdJfOoE=;
 b=Gku5q+NMUWSC+YbAGWW1fNgVbJosu9O5x5k4kG788+/9R4QcIWh6c1uCrlWvd3WPF8
 Jb2PzsU+7lZ8Db0f+lLOwRZgeZFmwsMh0cG1eu1pvqGhkMbGxewKna0qjqs78rc0HJs/
 41AZaP9d3jmcccdGDF7HYgtZpHkZ1dJ/LtZk7a9EQl6LanSwHtIAiQ50Uu1z8JZCBO5J
 SvKEP2cz96qfR6nyI57/ubvaMNdmF2K5tWbI5DycRz2br3bNg9AB7a4yWzyl5y3Us1DD
 8CFVNFuWd+RPlbrG580SnI+YBkWTuZ3PrTGq8unR/3/QoG7yhatx57/xt9lL8NSxFgtw
 KIcQ==
X-Gm-Message-State: AFq9FYJvr5M+VUvIil6z3xMxAbwvx7HNl9JRUfwXdKjpJCONYxvnY0Au
 dZchaeohKTkeiIrIjXcWtGSW7DEHbnIo80hsk6ezFGIDct1CPQEzxPa6O/dOn5Qrmqs=
X-Gm-Gg: AYBFou0dD+KUQXJQCWO4PbVLV9/I9/EBKl0y8FHa7NPoJMP6qubWEnFHhwCHx91vK6Q
 hJ7tbBhP5M6KblOQeYt85QYKoaz6JSHXGeo245lOtlI3RA6JSlrBT+XVFyufLFKXmyNTRFOlgRI
 FkX+b7+ylNQRfIjUTYhCA6sBRhM/sdbxEjWwRJekbNW+3Vsyw16d654/00wpbOemTo6rvTmlk3f
 w7PeCHu6XjKkOy1MsbmltLQ5WnHMf899zeviV7PJMQaZbeczrFEmlKEG8DJwdfdFT6sqnHBNSDW
 FRPqa3iJ62L2CfQHo/L6xm1V8Wc4JYY8xhThJLnW3BTu8t6QOYpu7OopEkMDm5ZUAmZxuiiH8AT
 2PbRsYQydKjc+IoZgDcAE11n71de9eah4yrYsvj8/pK0GiIO1t2kplnVuFzBfA7qHsCUJ6++Y0w
 zsxIUwEQsKqQiJIRjP3JP8Fy7uXUCIogk2fD00GnXaWSrhZlj6napdRo0oXGzhLhp/G4J6A4Fpf
 RQdzNjBvnI4zqT4jeBG1uNGx9DZZl/XNHljM+ldSc5Pf0Em7WXNNHZCdTSH3DiSWgBeZCmmIoJT
 VhLT1sBU/Xhtf5LdTW3GLt74ZyA94sUi49Wl0FugFki51f8pMT8khkAChvn3wAXrcpQ6loR5Syy
 Y
X-Received: by 2002:a05:6871:c8c4:b0:49d:c88d:8bea with SMTP id
 586e51a60fabf-4a7dc276c0fmr1635166fac.42.1792604140933; 
 Wed, 21 Oct 2026 10:35:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d616e848sm2541473fac.7.2026.10.21.10.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:35:40 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:35:37 -0600
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
Subject: Re: [PATCH v9 2/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
Message-ID: <20261021173537.GA3275858@bill-the-cat>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-2-18ce3e431320@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PnnzAmC4uwAdny0N"
Content-Disposition: inline
In-Reply-To: <20261021-snagboot-v9-2-18ce3e431320@oss.qualcomm.com>
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


--PnnzAmC4uwAdny0N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:48:21PM +0530, Balaji Selvanathan wrote:

> In snagboot mode, U-Boot is loaded directly by XBL without PSCI
> firmware support. The functions show_psci_version() and
> qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
> CONFIG_ARM_SMCCC is disabled, causing build failures.
>=20
> Hence, added CONFIG_ARM_SMCCC guards to both functions.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v7:
> - No changes
>=20
> Changes in v5:
> - No changes
>=20
> Changes in v4:
> - No changes
>=20
> Changes in v3:
> - Added CONFIG_ARM_SMCCC guards
>=20
> Changes in v2:
> - Newly introduced in v2
> ---
>  arch/arm/mach-snapdragon/board.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/=
board.c
> index 87adb100edd..daee2ed4fa0 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -35,6 +35,9 @@ static void show_psci_version(void)
>  {
>  	struct arm_smccc_res res;
> =20
> +	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
> +		return;
> +
>  	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> =20
>  	/* Some older SoCs like MSM8916 don't always support PSCI */
> @@ -58,6 +61,9 @@ static void qcom_psci_fixup(void *fdt)
>  	int offset, ret;
>  	struct arm_smccc_res res;
> =20
> +	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
> +		return;
> +
>  	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> =20
>  	if ((int)res.a0 !=3D PSCI_RET_NOT_SUPPORTED)
>=20

Do we even need this, patch 1 of the series disables SYSRESET_PSCI when
you're doing this special snagboot mode so we shouldn't be calling
show_psci_version at all.

--=20
Tom

--PnnzAmC4uwAdny0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatj35gAKCRAr4qD1Cr/k
CgSQAQCAAoO2tVnRywesguxH1lwzRbGod9zqndmvRebWxVme9QD/QkQJK8wgPvrB
ip2T6ECBv/j5RhqHHdGbdgb168stYQg=
=Vjur
-----END PGP SIGNATURE-----

--PnnzAmC4uwAdny0N--
