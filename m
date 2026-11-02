Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712A606A909
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TlN3EWXJ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Y7llqmiv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAF9680F95;
	Mon,  2 Nov 2026 17:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xU0S2xBBF0IQ; Mon,  2 Nov 2026 17:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06D9C80FFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793639079;
	b=oD2dx4iiPn+NQK4xqRn9Yeeo7Q/ciA4KsD7ailGW2pZu2gANE8bzZEqBJGZXazGeNrw4
	 Q8vFnjs7HlqruZm4zjhlnqqFIithd/pVXDVkpOljXRsvg6U51MkctfX+Yzp8P2uK2lwGR
	 El70u3fomFaUmI2ajndUEzKseeWZhmUWmmvzMSW5WJIrQqVv3qUCOIypNUJwtgUVFzEl3
	 GEJYC/F2x4pMY7S9ydYpoxzfIqRdnwu3CUopzwYTz2JfpQde0GadMvLIIPOZwLs/1EJzb
	 4sgx26V3CrLpAW//4X0z8EAStiaRjtIkivHkpbSdCYL4nfpDrfQ7HIxf10CqJbRHJow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793639079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=191TY3Q6PDfZ8SPa84XysCam5XaUVp38HxPShj3fNsU=;
	b=QUx2ayJ5rxMSX0jM3rXkDDyB1a6ZRccEErpJ2IpKSJ46LXfTtaPfXr1KWpaXEtCeDGWm
	 /ZrWmT4gZHgSPvpJa9EoxXZ1qdtr//yzsGGG65fEcM88fbocn2rwEnW/qtepydkdCb74m
	 5K0g+cvQldLySrZ1iCgL7R5udQfKUzs7l0k6OcKIoenO9wi2UjHbj/5k3Ov1smlKJM0Ea
	 2ZqcYa89E3ATNCgYttnF2EoMIw2C4bDQOtNNIJ+zCBuFtA4Qr0BAHugy5/ikZj3HfMfwx
	 e1jMW7KH8SP0UB9WDrPfO8PNC9DJqafm9nKUGeYWtW1I7Ku5cNHxw1+GDejnVMZFCpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793639079;
	bh=191TY3Q6PDfZ8SPa84XysCam5XaUVp38HxPShj3fNsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TlN3EWXJnALoyYU8EDRbx88Wt37PuwuwPPCFp2Svfk3so7MfHqkR2qeb11AAfssIs
	 FD7s3kl37CJOboDb5NQriK5K2SXvS2A+bIvVCTnEjfm31ZA/ktZlkVCU9eONJYgb8y
	 uBlNKwo3cpVJpAvOpPzCewm7Ntu654ww2eoyLlzYWKbcLFDkzSNL7NHQSoGjxWFrZQ
	 PEDZLBbCQVdSkgzCU/+OLcK9oYMqLck4rn66Hlw0J+HCuDC9VMeLPcybc/d/DNoVxZ
	 VahvuxYF1MJ6nvV7JVRd2Mr30UbafZvTydfelaDDM4XOTkO0Vm1aDnHXg0CS7vQ2lI
	 ev0IP2r41klSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06D9C80FFE;
	Mon,  2 Nov 2026 17:04:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2FBF235
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B90F0607EC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:04:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3IwpKdzBYwn for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 17:04:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01F4A607AE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793639077;
 b=hHpR/S2Zgtu9vRNVp2XTS2GPOWiAlqPTUyotJVV+mdNFK7gp6XEL49f9p0lQI7ldSeeQ
 T8VRvB+iF48AMO+JHTU350gk2K0o0+A/ptssdIhwpYrvK93OX+XaKWuk/tjblwD8Ma/LF
 yF17pY1A2aeZ2uddZVZemoYRg2sLPrliNeSH714H9VvKne9Ti9+1YX5qa3ILYhPpY9vAV
 icqAjYRRvbhgPfPGgEVjJAgF3b+RJWHymG/7vahNpHKLBmQhStBM4fL11h9lSCIEGg9rj
 LQ7AMe57nE+PB4poLnYrtMM4CIN74Mp7PmbI2gj6XBpnOOe+4uNQbQ6npr8z5zi6vgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793639077;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=191TY3Q6PDfZ8SPa84XysCam5XaUVp38HxPShj3fNsU=;
 b=k/kabakygWE9FL6Xt57PtoLg/APFUDCDPx8GRDZngBSAtiUJJBPrYUT7Gatrcvax1oY3
 tFVOk6sT+X7Sa+oeAZvjDzNhWfpY6Lu+xjgDPnDLSCSlDhUw+dkaBsNBauXcVewwfry8e
 dvT4iBGy/EJsn2QvMlutwJZ0HeU3KUokY8DRwb2X8LZOhjbkFQEAyZQgK3thcHe6EQIDL
 ExbQLBVdsHEsyTtkWWV1RgM31Zxu8YWejR2WfcWqE7cwpRmhdLuvowZIqXaa/U8Ry7Hxa
 VhIcLVht4ZopKJ0P3r+69O0EVt7NF5IchMh3K5w/fv/gwztluWt4MgQ2fXYj1E5qCSg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y7llqmiv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y7llqmiv
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01F4A607AE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:04:36 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4f488ba6e90so1169875b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793639075; x=1794243875;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=191TY3Q6PDfZ8SPa84XysCam5XaUVp38HxPShj3fNsU=;
 b=Y7llqmivWVmJngxJ5sQX0NLsILmsgpqOwxNv0xbEdCFxc8AbHf/62lc4MAFZw6OacG
 sSfL5m7xiAUFDY3kpHiOraD83dgmKENYrmcZY67CwCk4gYLl8o73g6irFuB4RYdUWbBM
 vCunx2vz7ctwkU5KrT00Y1Lbcm6jQNjEXNO+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793639075; x=1794243875;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=191TY3Q6PDfZ8SPa84XysCam5XaUVp38HxPShj3fNsU=;
 b=gVqCIksrlTI+q/5nLofLiGpuRiApfoQbyjpIHG+rxkI7XQ85pE1SuvKSkhnsdR4Uhg
 XM7DDN41/NKmpObQG0AId6PG4C7WYMwjk44uq0cfFpPRGN0qAEvh0w5LQQBAI05TzI0d
 wNLXQdV/UHVyKk/De1ruld3GNBTtahkyl5yeaXYqD+R51FtuMesQYd0us3GVjVUGF6GK
 yDNiNzjWog5tKO6KED+1oNcoXjd4Jh5FZdXU5r0xQ2aLfbzAiFyUudCq+NYJF6jebm99
 uYSXgkxmBBDxZQNhzH9ZkIxELkrlcG0mea/Grz11wW79hbmGpOk4CR/PM+9+GC4undJD
 L6tQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBziYODhZNz9C6mb5nB9vQgDCN0cJHMJuwIsEvN+YRuh0qnYSHKajA2YooisITzzMgCGnn6YC90=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKr4MNt9JV0KzRhloJQoU2oT/j4Tqzc4tEwBQGuT+G+jlrYaU9v
 VZd3Mr1sujEXFepSlPZd8ZZPo6wrakyTkEtOM/hDzTXWOAdu2eemXVa/uf3BfcqDcnY=
X-Gm-Gg: AYBFou27HtSeojA2DtMN+Ksn8mGK+jvjd9J18Qz6quYbXKYjd8dMoiHG7jULOjr/IZF
 vfpcwm1ElN+pdIcx7+dpC8HyLhBuRKYWxS9CrA4J5fU+M5TTGS5Eln7f74kmFaXe+iRa9VeeXoo
 sZ8rONWzglqhJrS5Mi89jurg7w72BhMivV1Qm9MWu5WeOe+U1nmO6Uh6dLnHOZcF6AlN/SIct2M
 I44gH3/0UYcQo049w0m4MMuIr42WBgXgmMz5+1inFTOzo6FPCWYFo2nzJhhoDVOt+2aXlvFYuhM
 chl2oF4ZjT3igSSqPiwngHnRuBlRsfQcYBaporPL/94rzdSAnr9T02BNDhcr89pXmgFlORR+NhX
 O3Nyav7wSxKBzKYlhp5OZLNw8Vv7jtj0HfDJDHGKOjlv8CFF0lRTOwzL1Q+vgAR8N2ZO29/t+2g
 bU8VA/xqXLrpYAtU9XSeQaDQV3Ts3rCw9TVbLanqZ55sU2/0mHfAWGKPGPXnkBdYVeOzmQDlwoP
 GDv8Ge+pFo5pCbPTucQENg50FR4XjORBEJhQjd9S+4g3eeWYhL3jw9Z/hkATo5SCrK2nK8rT0Ar
 ofnsdHX4tB8csb+4S4Dga6NukLbiY6aq5BWE+xaK+F4BEel1ObNNVtYI4uo6uIynvv3taS8JGcZ
 n16Bnqjl2eTydCx9x32fdFgSd7bRI62GDoQBph8ktJ7oKJFoB3kU7cIpGiLB6HyvYbF09AM4m2l
 KC2bBvphqkYcuQxhkT/fhgTPvGt2kqCw==
X-Received: by 2002:a05:6808:23d0:b0:4d6:90d4:6bc with SMTP id
 5614622812f47-5640ddae7b2mr7392643b6e.46.1793639075531; 
 Mon, 02 Nov 2026 09:04:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fd9888bsm8849717b6e.5.2026.11.02.09.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:04:33 -0800 (PST)
Date: Mon, 2 Nov 2026 11:04:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Lukasz Majewski <lukma@denx.de>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH RESEND v10 10/15] dts: ipq5210-rdp504-u-boot: add
 override dtsi
Message-ID: <20261102170429.GB3309461@bill-the-cat>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-10-224d421c6201@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EU7678QGfLoiCHFj"
Content-Disposition: inline
In-Reply-To: <20261102-spl-v10-10-224d421c6201@oss.qualcomm.com>
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


--EU7678QGfLoiCHFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:18:42AM +0530, Varadarajan Narayanan wrote:

> * Add initial support for the IPQ5210 MMC based RDP platforms.
> * Define memory layout statically.
> * Mark the nodes that would be needed for SPL.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq52=
10-rdp504-u-boot.dtsi
> new file mode 100644
> index 00000000000..5582de9bebb
> --- /dev/null
> +++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IPQ5210 RDP504 board device tree source
> + *
> + * Copyright (c) 2026 The Linux Foundation. All rights reserved.
> + */
> +
> +/ {
> +	reserved-memory {
> +		/delete-node/ bootloader@87800000;
> +	};
> +};

I don't think the message and tags match, and so the reviewed-bys
should get dropped too.

--=20
Tom

--EU7678QGfLoiCHFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujCkAAKCRAr4qD1Cr/k
CmmYAQCWxRGVWD8vM5yqxxhxy9UiCnnSc8FgNT0b6/dGSkLtaAD6A/O8uUuIWrqx
uR3Z4vi/JDviBxWxDlPiYS8frGwTxAU=
=uN+5
-----END PGP SIGNATURE-----

--EU7678QGfLoiCHFj--
