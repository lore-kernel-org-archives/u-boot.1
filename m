Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF26606A335
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pUmFKji5;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=evNOfCU8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 346096075D;
	Tue, 20 Oct 2026 14:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h874TrHirkQK; Tue, 20 Oct 2026 14:08:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6FE7C607ED
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505332;
	b=kZv7loGvjJdfVzot9X2yxNFnmWETynxtFny14Zs5+ImplubbZIvLdlMzKz/MXroELBND
	 l0auzP5mxPMwrDRnpPLB7g0W2q2kXCP7BPtMnu5rTtYNOIwaZ//PkzUKh/lGS6qul9Aox
	 Xo81bYPMeov/2jBrxsH9jUHezQhBnENxWA8GqXhQUwJ47EW3AIpT2617qYdw3LDd6g3Vf
	 zu+sOSkhUF8fyNuMZWHbEdbSvdyabFHoMBHp/RXrS9SC61FLlAs2x+SR6jRhR+6U23uHo
	 N1ligxyRu3znKNwjO+BCb8SqXaSnMm6a51Y+YQojh61o6op/noNvxGg/hOEAULlGDxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505332;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sHDYaD/ImkfRHtj5aIpxtBIaMww0syfvtdtyftAb/tM=;
	b=W2/bEH1QHufLVZExdD/EX0z/XsSV94DTqaezdbKh9Num1wzWw5quPj23iAX02DFb0PdX
	 NuMnTRS+dxabq4B7OgQDnscRF1nQ5+LTRQ23Uhvt3AU6wZ/kCDRjh4X55XFND2vQ6l9H7
	 E4xkkdUQz6qm4RKqkmLPcD72JvhSK1hL8hllQwI7newtPZNlcCKsDYVLrMNMorOWmaQJS
	 KQT/HSt+n/gAAAqBTp7kLEeyXcX0bOjmzcuBkLFqrbBnCdVFUOTV/xbbfznPGcG0/0v6y
	 qxVo89+/qKupMCdVo+bz8a7dNmT0QPEyyL/HZnRdSni2mwSHalDZWL59FMy/6j+0j/w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505332;
	bh=sHDYaD/ImkfRHtj5aIpxtBIaMww0syfvtdtyftAb/tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pUmFKji5VwxpTlNje29wSkGy1C8uEcfa2nqxDsNZxlMTswMbT5ar9Rm7IJBHvsc/C
	 +d90KZzc3p9QHEfxa5PkOZHIJX04adiTw+Hj0dW7lwlHRKitCA2rT2MGRDEE/pMHu2
	 kvb7owDbxzFiohoXjE2iqTEP7APeTWCxnf4Pdr3AaqaJmlhkAcq8TKebSc+IxVNCBo
	 FcQxDecuuIAGxsQZF/h24ixjIRD0TRggGYAtQBK8zulZ+b9e6S5ZX88QdXakMGxth+
	 g+w6wkQxyDEYZeNGt4g3N6unjQpbFniC3bNLGLwcgCRzRhdm1Ty6O9xOopNpTNUuHh
	 dgIsUXZ4oL9Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FE7C607ED;
	Tue, 20 Oct 2026 14:08:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AF3E1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CAF84068B
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K0mzTZMyqAP1 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:08:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF0FA40621
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792505330;
 b=jFf4nroIil4zhN7AiZPDuLMxUhDSDl8dt12rY+Xvr20xr1LceDwJxXDPWpyHN6Hd8HTs
 5qxQDwwKSjtvIkeoJhEQAcihr2L5JMyAQ5H9wMi8bGLKSBou5/4WyobsCop/3A2pTymxO
 WmzcKuYy5j6W6yiFLctW8U1QjSNCNMkbIhi4ZXNp7o8ngt037nEBVXpw6WsOFMCeHbRg6
 nMWVM9XQeoqWFlJCI74XyZDCNDdPNql3JjkNi2Km1hIPILMDyiVGkl5RDTw1cIIqVeCOQ
 SLeY1o5WFEqi4o/TC8eNMqhm16AA3KKyZhBGqH4z3z8SHR14SOe+UEGdvqnh5/G6s6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505330;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-Virus-Scanned:
 X-Virus-Status;
 bh=sHDYaD/ImkfRHtj5aIpxtBIaMww0syfvtdtyftAb/tM=;
 b=G2WCGK4V8s2qqklHoC0ZUwVx/Ijp2wAGZj9rCIC+pSzCxtqbCLQDyXPR9eEMoPgxQrT6
 YB2roZjBOPG6K//UggkWXa9PujFaxgMirUSuRWL3ffJnVa2WBSiVaiod3SuvMA7T4pqlX
 TJuDNBsOmRBg0RiTVhkUmf2VjeKd32p8Q60/9rQSNYsS52KtCrEQ/k66Zi0RYifdFevjP
 o8LKgDekL47IMghRihEeNCi1WFGLM94jdixCjAeqtlYpp856GXXw/cA0SMjM17zqKq88v
 eVa69wDDnzY4CUQpWb9UsBtxbOjFv3yrkTJOexNCbpQ6qCQ155j4Eklc7zsEe6/PxCA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 spf=fail smtp.mailfrom=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=evNOfCU8; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=evNOfCU8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF0FA40621
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:08:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7D78432A; Tue, 20 Oct 2026 16:08:47 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D928056B
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 16:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4c382ece86fso1946011b6e.1
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792505319; x=1793110119; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sHDYaD/ImkfRHtj5aIpxtBIaMww0syfvtdtyftAb/tM=;
 b=evNOfCU8femHKR5XwzdyxdCbX5MVGRxGy4xgPkJjlrLsv7LXS/6VKtc9KVwME3Ms1q
 uWOJVGNB727oKN3UCf4GfUtypb+xrBSEZe9o4B8VBKtfcR0WVS+ZesVgo+R3PmWWxrG7
 34+JkZOMYXEcYbkQJjIu2EcLaniXPFf6m+2aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792505319; x=1793110119;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sHDYaD/ImkfRHtj5aIpxtBIaMww0syfvtdtyftAb/tM=;
 b=UDYf+hmtYQZhZRtjosycd1d8Z0SiEDFvOJ9B3BCVDL+re8VBZ89LPaw1ir4HiI0u7b
 mtbb5bWzM+iZmtjn/QHRHdrN0Su+E6+hQpGZtfiiAIx5nTeTmlbug0MsVz0X91fkCNkT
 sqL+CGVbRI4YBrpIEPwT2MF1k7RMXm5wMKxn7+1fkSEqhvSgnT7PZMujrTcoHgqqrms7
 L68R0FUQQf10emkInF7gF+0jiSlm5XhaXT94kooL9VbBKXIWzjuum9tmxlFKnEcjpUf2
 Op104yNxrUXnxOEs+3i/u5wzcISn6V2HlzuQWZwDu6l0vCuC5qNpc+RdYs8XIH8I4svq
 gpXg==
X-Gm-Message-State: AFq9FYJeYQyagatPIqV9HgUoasuGTmrozYbrEXAGpI3mMsElpbJ60qqs
 +lEL9Cauqz1F+4VerkzQc6S4om0qoHbnT7RnbjKQS09gKjjVFM8T3VpOF/k5kEKngqI=
X-Gm-Gg: AYBFou2YZcYAJnjo/0vqX1ZCU0nHsVN2ji7jtUuCL+WQZqCfdelmsRZvKafeULSx2YL
 lJ34GHXyBOd2Abv7pFW0yYdU1tWMcVYSRVO1kDYea3TPshisUko05/uLsF1cGrBDnWyxV31IHCz
 Lpfbt4C3omMKGFhUc8mjrdOKsEPrMTvJsdo/h9gh5g5D+4PPDYXZ0iPoq2OvNKrQT5eHSzHRp72
 5wsp9cF1OZ+eDiSkoTwQlUOmIHgiBbTbfnXsvyuS1n0yEGlaj6fKbTJvBiAiIPPi2pk2N4JRqDe
 FYILvsG8DX2s0DZ4wramragDMhCQWQ2vepZ7YEBHSCA1RXQrxmcRGLKuP/lQ+OtZY0xyxgXoLy/
 bFHdh2/00uvyky3GeP6pCu1CA8KVweQxgecpxROsbG9L6/k9fHWHTSgil47DbMeo+uni52Th+31
 Q3w16BuYavIUcUvGXkBf5UKwPM/Azy3rRBAl8G3FB8RCqvBpo98JgwiYBouwVGnuFh8LLj28VlY
 1xZrjze7JOBViDPxO3uRdAn7JiGJOliwctjs891BMDGqDHd87rUPsYOFH1idL2homoR6kz4DfjU
 kTNREwbljzOorGFJ+VI=
X-Received: by 2002:a05:6808:4f1f:b0:53c:7298:3598 with SMTP id
 5614622812f47-53ccfcb37aemr9830261b6e.31.1792505318718; 
 Tue, 20 Oct 2026 07:08:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-550e96630a2sm393061b6e.8.2026.10.20.07.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:08:36 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:08:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Nimesh Acharya <nimeshacharya197@gmail.com>
Cc: u-boot@lists.denx.de, hsnaves@gmail.com,
 marek.vasut+socfpga@mailbox.org, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@altera.com
Subject: Re: [PATCH v2] configs: socfpga_de10_standard: Fix raw partition
 booting from SDMMC
Message-ID: <20261020140834.GH720525@bill-the-cat>
References: <20261020091125.4015-1-nimeshacharya197@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RinV3ztXo26ag5Vd"
Content-Disposition: inline
In-Reply-To: <20261020091125.4015-1-nimeshacharya197@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--RinV3ztXo26ag5Vd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 02:41:25PM +0530, Nimesh Acharya wrote:

> When using the default meta-intel-fpga configuration in Yocto
> 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
> U-Boot from the raw a2 partition on the SDMMC device.
>=20
> This change configures SPL to locate the raw U-Boot image using the
> partition type and data offset, rather than relying on the
> default offset relative to the beginning of the SD card.
>=20
> Signed-off-by: Nimesh Acharya <nimeshacharya197@gmail.com>
> ---
> Changes in v2:
>  - Remove CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2 since it=
s already the default.
>=20
>  configs/socfpga_de10_standard_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de=
10_standard_defconfig
> index 04f9d6c8494..f01667420a0 100644
> --- a/configs/socfpga_de10_standard_defconfig
> +++ b/configs/socfpga_de10_standard_defconfig
> @@ -70,3 +70,7 @@ CONFIG_USB_GADGET_DWC2_OTG=3Dy
>  CONFIG_USB_GADGET_DOWNLOAD=3Dy
>  # CONFIG_SPL_WDT is not set
>  CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy
> +
> +# SPL Fails to load UBOOT without these!
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x200

This needs to be run through "make savedefconfig" which also means no
adding back comments to it.

--=20
Tom

--RinV3ztXo26ag5Vd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatd11gAKCRAr4qD1Cr/k
Cr1AAP9XOQvUAsLFl+XAo+54611AQfXg11JwreXHzqC84iGnVwEA2YJQH2NzhWkT
gkEKopby7p2ErxJPzSWtv7oPMy19pA8=
=EbEa
-----END PGP SIGNATURE-----

--RinV3ztXo26ag5Vd--
