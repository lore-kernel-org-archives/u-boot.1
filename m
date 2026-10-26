Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8F606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gefOsB6K;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=hyhToQ9B
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35DF740357;
	Mon, 26 Oct 2026 15:43:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 588lwUYZPDw7; Mon, 26 Oct 2026 15:43:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65258401F7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793029427;
	b=JbS5FQhDdn2MUG0zSHVQOallHLedbDIRnzN11SheJGaLJC+L9a9Jg9pLoF8wimDpcNrW
	 XteKpdzyxRdJi9z1ve+/Y8Fk29Lpje4A13cnrY1gAuveFwpjkUGKtJpNBOvOuiOl79p0n
	 BCx1N5oUw+1ZxYdlZ2jGqfJtr00Tz4nLgotG4lctd8GGw8rxIaGGYlvcuYGW61/EmxxXW
	 z6LYmcDH9HhmBUD0OCySVTwg7ZuBItsYjX28o12cTSvXi8rFwfksYoFtTV1RUh5SLIzxN
	 GGmciMNfV9wfHdsGP8uAh3Xr46I1uPxm342c+8iZAB3WhEiDtjJ2eoGOro4suazNR4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nW1Xfa7zG0MI0BpGZG2tQPS89WDs/FGWly0vPfu0ItI=;
	b=C1jKwGu8K1gCZ5sqhQivGVvauFBe6HGVnNJJNeKHv0B9ZbJO2mh+Jt3vGbsMhq/VDWyi
	 04VSgnJntuN6WouzMFVxQ/ShYaoIOdXoezRGyNzwpwg8B2fg1Bu9ej9fDRFPOv6yINgq5
	 P03fAW4hQEQy1VvHU8i8ECco7cHYYRXffw6dK1NPLwKbN/L0gVMglxP5JeqXOD77PVeYH
	 cb0OnegamZ5oD5kVQyrsBOqnpZpdlnyMNXIVxbLq8AAl8GuZvYvS5xh7RDc72V1sOuk7x
	 astwnlabPmNjyn2zGkP/5zcNt7EqYrzs9arcrBStdIAJ+me+fvEM+NJCESEdk3CC07w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793029427;
	bh=nW1Xfa7zG0MI0BpGZG2tQPS89WDs/FGWly0vPfu0ItI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gefOsB6K/x4PuDCTVSxGcnB3ewFCh5GfE6jhEkKjT31oIjY10Q14cvdqrtuK8ikM0
	 3Nm+bOkqe6tSZvcbpnifD5Bhdwo/szTgLU5a/GVQeIfg3oabANopA7G50YT9ybw/6A
	 1rMUg9CfE8t3UAm1pO2gIJYDYJJHaj+aTVXRGJdMz+LHjAsbXRkHz0a6yr5WLuh4BC
	 AFKDCIlicxmxp4JMnSWKHR+7bBqm9otZ1QDa8KVZokEacDIkwPv6lyxwoF/twOyM1L
	 Rb4FVuwweVcQjKLs90x73D9VUUXbQABEhf+iM8zx2Vf6GXVLbg9JQ6ngsbyRkl36EZ
	 7MpCOY+lOTI7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65258401F7;
	Mon, 26 Oct 2026 15:43:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 802B42F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71BFF40093
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OvDYo66Mw7nj for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7BA2340062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793029424;
 b=E7xR75KeTC+tYnOnJ3nLzqwAeCTO+h2m3BHdd5Q5OjpiyoJPxXBW4hNmhEAQWvcgUqdD
 UHFL+WQemGqvFWCTU5Gf6IM6WsgtWcXkiCpS9NIA6NWiAPAi9E0gLepMTVpNSEYcZd7dO
 6XEM/kE3ECcexdd2UpqJNSAQmplhqVaR84SiXa9hboScWNna6E3SlvYksnTKYHWLlKL5y
 Z/uabTXWS4ySoiQs7/ZdaTWcnPyzxDKjnH3IVDLMp9qCcn65P5VlLU2nbAGbsHl+Y35gM
 uU6mB3DN4dlwrzNLemGbY4Txi733a1l+ZR1aeJC8DMCAzeLkTypuOR3dloiE006DM3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793029424;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=nW1Xfa7zG0MI0BpGZG2tQPS89WDs/FGWly0vPfu0ItI=;
 b=pStlPYxB0kB19aYA8nRwnuJJakGILd8nBcfF6aoW1FEfCLpwYDPyB35/p3fGgLz2RoFE
 6twy5pl+n3Su+U8IrLcut3FKDvykLD3tVoBzyPCHgHifZINhn5S+8mSHz6UCCLrCPJBT3
 YboeiaCDr9Ra0Yg9EKpoxvSXyIkq+Qe+IHnCCXFMdC5w2CSXTxqaxStHpbaP2ioaGnV4T
 c1bhjyUqgK++T4Fb296d7YYOUEQZevM7Fei2ET/tsZhFVvPLU/mLLOIV1CYk5VRMjpa1j
 oqgg8WozFDW5pVtQDTsOfpZtXe8uq97RcfU+R5mYocpx2oMkeo/FEV68Z0XIOUE6X8A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hyhToQ9B; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hyhToQ9B
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BA2340062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:43:43 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-8446af403b5so2222106a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793029423; x=1793634223;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nW1Xfa7zG0MI0BpGZG2tQPS89WDs/FGWly0vPfu0ItI=;
 b=hyhToQ9Bf5hY4b7GToWdIXbRScMYkNcG1+oTZdqW23nel/K0mK4l6Fi69/Qq8FndAj
 sZinfxweLRjRtp/3qSR8/4fc6OTZ5X3C9jdCODBsV1AjNY5FLUPooDLJiZEW2CG/DTBZ
 3gyXbsDtIxJwBfs4wwIOMV6JubIlw1PoGe4qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793029423; x=1793634223;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nW1Xfa7zG0MI0BpGZG2tQPS89WDs/FGWly0vPfu0ItI=;
 b=wwHdMZ6M8g2wooc7fospEagwRHHfzBzv3thimzYJVIzPsX6LkBAFmeEilJWZ56SVq/
 us818iOi7+/qqtPQFOX91P5jTYS7bxwR2Yd/Ya58TFV9d+b8Peb4FbFDMpz1EHu4VvVf
 CZvXK5VYCxayaeX2vn4NDN5olV6CAIWdvWdxLCzVJ8eaOpT6X8U6r+rCyo13sK/c4VPP
 sTYvHnTG63uk4cGF6AWQ354zoHMGnNcpm0yONf1Iqy8ny1YUkJqNDree3i+vNdUff7jq
 0rgf9I468LFiXvu1W+hG0JM/wvX7jwiRLoy8kIZc9ZJwFxEKG0sKamesoRvLppXZDj+E
 fQ1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxk8FIF+iDkogV32C6J7oQpuIOlsq0ELnR9jh9+rMits1VNhJC9CUvWUyzm1fJMEZsvk9NFbtM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLPaB0hnKiNqXn5KfthrkgQ/nxSQhE83cmBW/4yTk7vy+DQRbS8
 BNhttrJmWrvVj46MWH67cPuxPAHb0MEJ/rrMUcWE0w4wK7yjC6rB5uuhOHiAh8xupyU=
X-Gm-Gg: AYBFou2yIbsFaNgvMbRfjBSV1uc8gV9ua22DMR2lBuYoVraUdVqZHH5HD8EUIImN6/b
 p/VY0c0hqEbvWOUWQd68Hei8ZQwdSURN/DLNmudDwJ51OvgKlB0oka8JI5cDdPaqJQ/Aa0EvZAO
 1fZj/kMd2ITTxcoEUxwNFpQLlevMNj3zCG32vqTS0A+ayJC6a4Pw7s73MUm061f7lGm7tYHlQPc
 syFQcbNpH+oCdJIF+fLeYKQCGC0/Bq/DPN9pGbTRJ8nQwy1qaZMt51M1nvNZf8HudDEB0bDy/nx
 e6ugv8CjyzZLyK/pS7dgssdsCEDb/C7yZxgKZi6kE0uJxcjw4Z+jVWt+yTyRD+yG3lTe6J2u8tr
 fRkkIc7AHPN7UvFTZ12IshbHQRcCvUIBCHdXdZ9Z6ofBEBZrLDHfMmm+icVpkFspD9QE/aQBeux
 Q/+9sKbxGDGX+XpDDW2SAP9+ig5zsAEyLaJDy4ev8iEuaNHGytunBzqiTMY23Gf1xyRqYmmehHe
 tH35rCwTlAnDUIp1PLmunhd1fc7N4/VwdF+gR90eQQzI+waVBo++wN5GAxitTbj/eTcFpq/NGZM
 XSDVYo7Q/THS42DcYkYrzNUwLn3u39SFT3DXhlJL1mlNDeZGADQZ0vaApG8KTuHcrUTwrIXI8uj
 WaMjcigkZqXbmQ8wZJmzrIdc/dLbDUNSxaCOlrSmLIp3YVxz3Qyc5e0imdQ==
X-Received: by 2002:a05:6830:4c0d:b0:806:1e7:4167 with SMTP id
 46e09a7af769-850fd94f8ddmr5648334a34.13.1793029422941; 
 Mon, 26 Oct 2026 08:43:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fa99bd35sm7970346a34.8.2026.10.26.08.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:43:42 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:43:40 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Macpaul Lin <macpaul.lin@mediatek.com>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from
 the bloblist
Message-ID: <20261026154340.GA646438@bill-the-cat>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ImTEB8sgMH9hYhhB"
Content-Disposition: inline
In-Reply-To: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ImTEB8sgMH9hYhhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 05:32:42PM -0500, David Lechner wrote:

> On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
> reserved for the DRAM controller depend on the DRAM fitted to the board.
> The devicetree built into U-Boot can't describe them, but the boot stage
> which initializes the DRAM has this information.
>=20
> That boot stage can describe them with a devicetree overlay in a
> Firmware Handoff transfer list: a memory node with the DRAM size and a
> no-map reserved-memory node for each reserved region. U-Boot already
> applies such overlays, but only when the transfer list also contains
> the devicetree of U-Boot itself.
>=20
> The first patch makes U-Boot apply the overlays to the devicetree it
> found by other means as well, so that the earlier boot stage only has to
> pass the DRAM information. The second patch enables bloblist support for
> MT8189.
>=20
> The first patch only changes behavior when a transfer list contains
> overlays but no devicetree. As far as I can tell, no board does that
> today.
>=20
> Tested with TF-A BL2 passing the overlay on a Genio 720 EVK (8 GiB).
> U-Boot reports the DRAM size from the overlay and its devicetree
> contains the reserved regions. Without a transfer list, U-Boot uses its
> devicetree as before.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I'm wondering what the status of uptreaming the TF-A parts of this is,
and why we're in this situation rather than how the other bloblist
platforms work (as I understand it anyhow) of either providing or being
provided with the device tree, updating it, and passing it along?
Conceptually, I'm OK with this but the support of just passing an
overlay from TF-A needs to be accepted in TF-A too. Thanks.

--=20
Tom

--ImTEB8sgMH9hYhhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat91KAAKCRAr4qD1Cr/k
CsABAP9SGyazfxbHlU2YdcnTeDPKAutsEYw0QJmsNhAuerazlQD8C2dxI5uvVO7G
sPfZU3dCAkNhmgNIL/OUaHtRezINUQk=
=nWH1
-----END PGP SIGNATURE-----

--ImTEB8sgMH9hYhhB--
