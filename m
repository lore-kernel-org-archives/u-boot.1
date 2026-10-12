Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043ABCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69A8E80AE7;
	Mon, 12 Oct 2026 21:45:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kp4X8oZHfN-B; Mon, 12 Oct 2026 21:45:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8297780AC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791841548;
	b=Z40rpFaBjVxUaEfL7Qgidgskv33o+KCL74t+5QHGa7WNrBI9sJwBaE8g1OH8e9/2+XCy
	 6PMANVz5L4H+owhnfM8HlwWL5W0gUdcq7oEzyv6mF7DAB9v4uDuresvy+2jjqEcvxjfhW
	 6KMV4fcqCQCpBzmeeOzbhtM3ErDnt1glmuk+x9Mb0SaDGhnS2iZX+gHeWitvxOMSy6gDI
	 fIsel6uZRtwJVQDGmvvP4DsaQ2IRUT45QkoX/qrgxFAWI3v6GAatO20xJPwqjBcN7oyT0
	 Ju9BkKE/veB8Aq8PXv3b3guBUevj9IgAQrv4r/T77xn2MCe7M1lO2yBCsZwPXpL1u0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791841548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2omWMCmu1huerje5LEZPRkpCkuOSpfLz4n+yI//OTNs=;
	b=VFdFuPklEwm/30t7ix3L+aPLo/q/PIbluv2QWKcTqqzQOYw+PPnrhvZjs59y3jVHk6yx
	 M9BZeARgWHjm5zCnGqZ8DoFGVygCV4PZekLbINC+HNr8rD+aNcv+X+zpRFBh35wixSZUi
	 BEqx3pKPlMlQkimh+CXvlyA+Xm/TBPvsr9w/YrQfPgK0fx4SvEcxD6MdyHulMUsqTgvo3
	 992CUgsNB+OSGZ/fiZajDxiYaZCSaB3FTinqKQZZ0oJaR8PsinoxnB7KBFgGQ60AWBU7h
	 9lGPqgWDLzTwp6mBqE37GyBHQWZgtyAtRijHk4lJP/J7CKpjL8RjTNBrzZFBS6IvIkw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=cuJL1VUx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791841548;
	bh=2omWMCmu1huerje5LEZPRkpCkuOSpfLz4n+yI//OTNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P5n4oRxeZg0EhwzWk/G9rKRRgpn/jjZlu8rG81W/EVStBVq4JUJLjf+flsaizl4pM
	 1S+KCKiv6Rkj2fHy3YgpQHslx5YYRZJPoLfDkxwa6VmZ7hPTcis1NReSfIL/nvbIH4
	 o38DfteecWloaipxy4g62HV7T7m4ViM5TWWxsdBcjMn2B9p6Vzd0PcM82HzphnYehM
	 zeYDgqgqh9EQt5GIOLAx5Ri1wZ0wA1IOj+3Ae9BhQBWLizstTvDzj0vIaWlJSfv/W/
	 pGS4KLzMKINbqBsyiZRc7BbLCVJb7lElmyi1p/o6n+mivOZIWvdtpugMi1Q79+tEcu
	 p7CcteSKhshOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8297780AC5;
	Mon, 12 Oct 2026 21:45:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A59132A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AEBE80A82
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GHaBf7j2cXM5 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:45:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 87E7280872
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791841546;
 b=gIcX7IQYFvP837Tz3xW0ECo7x36aECRXt8343F2qwR1TFUkhEhyKHtJG1bBIpH2zjpFG
 WrcCs8J+F3iDHK3mKsL0B42JrtAL1jPEJAB5nCh2MCzeaCXMdeyZApVKz5zsKZD4L/Gtk
 RsMU3iv9e2OJWbxT+x77ePiStteTu1rqtky5XyyTOHWxI70YN002GcnFXFNNDqOX7RVad
 H2r9umK2J1+wrthx8yBEie9ywgJGV2uouyaZlb/FPMGZy1BY9dWrlX1J52Fh3wpUX5BvR
 4Ur4+QZDkDN9K3h2svTEanW/qXo1F7dfBa+SAm+0NuW+2FhLxaTxmMYAyyQaJpvQ9uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791841546;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=2omWMCmu1huerje5LEZPRkpCkuOSpfLz4n+yI//OTNs=;
 b=L8A7Yits9OmoZQohW902zDdCPvpjaasHlrwUdATXEFzVXK8Dt+nFppwsYIt9IWrU/DNK
 RnRAYDTC60skc/JJJ8Ky0ISVyIpnYvlCxs69TNg5Et40oij8xClxIvknY6ZQLa/V5aEd1
 LrayknIjXVQ1xcTzb6aV+3xs+psqp9cVxMl3fng8ZAZQCWMAiBKXb2DgsHQETJDbdUoS/
 66PEsT+aHeurs17hHc4E+GP/tFzAMWse0tTVbwmmfiMchqa/h59nI/QFI2ce95wd71V+z
 YsdHJCixt1DAcuyB6xy3mu6XF/hXg5mzACws1TbixEJqJ/fOVm6EQOvJLFfGfyIGG/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cuJL1VUx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cuJL1VUx
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87E7280872
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:45:45 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824f3901d55so1631816a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791841545; x=1792446345;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2omWMCmu1huerje5LEZPRkpCkuOSpfLz4n+yI//OTNs=;
 b=cuJL1VUxe/saCRGV55ca3A8ly+FgWxjnDIa1N4ocscaMdohG5gssFOyIlh8NKB077i
 ZwSwXcTcNO5pHgJpxcnBDrPoYUi6Nz5TnrwhZw5Q0ksuf7FkRekNHRCqkjALodgyj1iT
 CX6vH8BoAHSvINjIWz0NVEqH4mNX0fC6xsBgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791841545; x=1792446345;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2omWMCmu1huerje5LEZPRkpCkuOSpfLz4n+yI//OTNs=;
 b=cgRZXb26cLcwn3MEipofELsrmuSaKF7cZbQD1iUKWwbgDiHp+ev4YE+4XWnP290mv6
 ZfaOd61c78RJb3/v5GI/nSLgPPFtkxxvPlRGxpS+pHaCgICQ77ZWR1lUdWgIx31DO+m1
 OsCcekdGvKEH/YOjfxQeTX/dliMrCO7fUJxcISGgvW1hMY0j3HPauZzOp2HTGxmJV6+t
 mVHbzi6vuLA4F6kEeN3RJdjhT9aFaYbfk4zithopcN/HpnpzQbSD3uvfWJKyyoCaZWiL
 ARjJwzYd/ZmM1DIJDNYg0g82J3V12tYAnWJDoLGa8WUxfYLlGy8yXBXsKIxguwNvoj5O
 57Gg==
X-Gm-Message-State: AFq9FYKpQiZCWtmAUttrMoYlfQcSPOE7EjxmS9iGZRSotUkOj4Njk2C9
 b+C1Vxj2BtRXkI/WMfyramZh0lYovJyx5OlVR1Sp/5GV4ST2EwU7DEp1qWxMaBOFHhQ=
X-Gm-Gg: AYBFou1qgU6WPDWN3Q1+8BVCD2DGD4jfW9GRU22jDHkb6kYU/72/y/RUleOlO6AtJmT
 LZvcYOejbI3Qzx4e/OkKHDRPADXVOWqIIPeIKZ5FSf1alTuYlAk1zF5/YUObEqxTONEpU1pmgIj
 ugdoMgPGI6U6eaN4iIOM+69z2Q+8rFT6yH6Dr/WDm6evT3jkBz3VxA50Ocs1n/qYCvNbuAsgYqU
 /f9AY+86ay0ThFw4njhroszrSbTHze7BmWz99iPsesNWM4PilTdTiqwbk9yyhXt/Za371M5s+lD
 kNrpE/TJ5wORI794qqxHO238HWOQPxcDPcj9zp8ZceTnFFzQVhI90+6WiQ1ctIOmZ21G26mVUN0
 wYkl6iOr7Pydq2IBtns5o501/kXT6hA1/8RAXmjUHpaIb2Ka76x3fzAJZTJXupinYqGkgDZ87Rg
 /idZuQXj6oya2JBQ0MKH9FPlWisCOh3fCYTuFwJRmTBBfgIuBgBifdTk7NBwbFf2SRvAy+XdcRt
 o8b+xb0EMggiGE58NSGXZbfDQEQlwfuw4+tEJxl6OqYEaKG1ioCfcc2sCemGRvXCyIvAnBnxq01
 htAbF8eDNVl3y/49urs=
X-Received: by 2002:a4a:e906:0:b0:6d7:aca3:bba9 with SMTP id
 006d021491bc7-6ef0e2ef436mr8733274eaf.38.1791841544823; 
 Mon, 12 Oct 2026 14:45:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8592e2dsm10035272fac.13.2026.10.12.14.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:45:44 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:45:41 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: Re: [PATCH] net: ti: cpsw: return -EAGAIN when no RX packet is ready
Message-ID: <20261012214541.GK3722450@bill-the-cat>
References: <20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbdc9751568@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fLtUen6Z112LGFSJ"
Content-Disposition: inline
In-Reply-To: <20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbdc9751568@gmail.com>
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


--fLtUen6Z112LGFSJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 02:39:48PM -0600, James Hilliard wrote:

> DHCP exits without acquiring an address on BeagleBone Black with lwIP
> enabled after DHCP started checking the return value of net_lwip_poll().
>=20
> cpdma_process() returns -EBUSY while the receive descriptor is still owned
> by DMA. _cpsw_recv() passes that value through, but net_lwip_rx() only
> converts -EAGAIN to a non-fatal empty receive. DHCP therefore aborts on a
> normal poll with no packet ready.
>=20
> Translate -EBUSY to -EAGAIN in _cpsw_recv(), following the Ethernet recei=
ve
> interface's no-packet convention. Leave other errors and the shared CPDMA
> helper's transmit behavior unchanged.
>=20
> Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
> Reported-by: Tom Rini <trini@konsulko.com>
> Closes: https://lore.kernel.org/r/20261012200814.GA3799261@bill-the-cat
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--fLtUen6Z112LGFSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas1VAQAKCRAr4qD1Cr/k
Cqo5AQDVfaAE879Dg9Y0A9umiW2oO90iamkS0jDgxvhJjr2yJgD7BFc32bA5HzX+
pk7au96XGANcJo4AjOBrplObGflU1w4=
=aguS
-----END PGP SIGNATURE-----

--fLtUen6Z112LGFSJ--
