Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEC0C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 17:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7F216085D;
	Wed, 14 Oct 2026 17:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VtN5hVxI6zZ2; Wed, 14 Oct 2026 17:50:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08D4360849
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792000204;
	b=QqjOWZMC8yn4brVPS4FrlixTnRwVqIrXlVFYgNiToA0xjvt5IBJCfr2O/ISpvT58IkdE
	 fEX8Mai+awBhtx9jiWcKsFyi/1+Pir/WlrNYQMis38XH3Ad702csnOMxBd6Oqc6o7xprc
	 B+Ay5y1lvQVQnI5CctXb8W0cClodTcuJo3AFLUUaEjNpnDJtiXpe7JgXg1IndG50mNkwk
	 J1h6lsajuQ1o1zFPtyR7iY2TCHHi6aWF3FydmQaSlV/k3OIj+PCS4Ea6l8Gm5f2PxRhyd
	 RHDl2nkZjZsqSudJqnkmUCGozzr2CGDMgx+7AOCkIZKNNui2wGrxcQN3La+XWY5xRkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792000204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AiGe80BfbdsK/q+8SE90AdpQxw8K2tLVFxD+EKbeS94=;
	b=WRlBzBhjGSUbdH93R4c5V9G+Hs7xtbKZXyGQAONtkLkKyN4UPfCADAZHo7mdlWyqnE98
	 NSe6gY9yRxcnM/6EvdapDMy2iwHzp5aFWipB88ZjsixsPrfN67Sjy63PZwl9hRhFBpa0C
	 fzTw/2nPzE4DsWfLgXgeni/OjO1ArtMZfZkIDzCiTdrp7ENAAl6axOraH5mUY417QpCZ2
	 o6Y5c02hxo+2dIrTB+bdWeRakMO/9niFnNBttxbhP0wmS93+iXzmnCfL7gOtH8OkggfAh
	 IcwClpzfmnf+QKEoyDIwn5aurVRB4fKTmN9FGFdiCTrbUbZtN01cm4hMsXXKmfWr80Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792000204;
	bh=AiGe80BfbdsK/q+8SE90AdpQxw8K2tLVFxD+EKbeS94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s6BnuFY/Lrlg/LJrzeF0U5lrbVP+SnxKdarh/u5529ak/qZpi7C/vkj6f3jy4czsD
	 Jo56Z8CXkp29muauylxf0Ddktj449kPZw4CKNftueHYbnx/eeellzt6XsH3ALMOacH
	 Mf5uQG0yY0/6b5Zcja/302S1kJPnt+/L4g34FxyqkbtFT16FREWld+SsWr8CYQQC0N
	 0mPlafve53VvKEHya0Uv0mIaH6ZUMt3i+R42lm/VTlvSW1afE+dheaU5Kp2JhHGH8I
	 fLw25zliUcYsqpYHWg0oNpNemO0sUr2DubPXgyqu/a4/JV46tOQCv9qW3R7ip8h4cE
	 t3H/6Cyu2I18w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08D4360849;
	Wed, 14 Oct 2026 17:50:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35A4A255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18263407E2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:50:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ll7fZIv0Op_X for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 17:50:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 620BC407E0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792000202;
 b=gSJ0x7KC0fg4mdCwxfRszjXa+Ugs/fLo+AWVOaA4KeQboHv0tgALdfGNhQqXDKTUMQCA
 VhGI6fha6L4x/FyFnJ6hjDwVCg4BGzkUIaknqaFAyKGZPritTW4zu7Qo0zb3PS/bz7AGo
 xeYdcZAsSS7Dib9tSmoSuX9CA3wWrmhaBvC82JH7KPPw8hvSxHhAZPbRk9Lz/YxTtyda5
 VgpJimlAWnsh1z39Xep8alY7yqngIYivT7iLnlej9RxtVegozXgY8rExo4UA/Cv255eJs
 mAz12u4k4qh7YoPFYQr9HS/s+P68qxHNZUfhpQuITZ26ClUlP3+tlbiboNZKuina3/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792000202;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=AiGe80BfbdsK/q+8SE90AdpQxw8K2tLVFxD+EKbeS94=;
 b=mmHzgqdbdVsCo237jJgnoYZZMUaonOZv2C2QOk5S4IYYR6TfhecIdJRNXypIi3k5nH6K
 A42yHi3PNjVurXA6pgqGDieXuzJVGXInPZ0xBZg8urd8zlHuGC4HJn6p8vVC9SNyp/Hrr
 ivOHregI/Zj+rEiOSxVcKPSXH1/39mEAqA0hB1Bdkmdm0gaSD1VI9GfNEeZsNix5whoyn
 t2JrtyP8osoQ3AYFwIX1d0HtPSta/nU9cUikGiTnnqpPjER3xlZ5JtQMji0AloV/gwGxE
 K2F0kEJswCWGLQzkVj0y3msWSXW966Z6CAsSz/wNJbeWvu4Ql2/+W8wYyjUAe08ed6w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RkpfWfay; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RkpfWfay
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 620BC407E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:50:01 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4af173320f9so402161b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792000201; x=1792605001;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AiGe80BfbdsK/q+8SE90AdpQxw8K2tLVFxD+EKbeS94=;
 b=RkpfWfay9TsskfjEn2kj650GbfP2bUsS/CTWGl0g2AWxUiEqZ4SyyA3vzi2e4Qrulz
 SEgPW7nXc+kF2MaL/mn+oCGUHnfRC+KR3mbTtIrGg4bdQUf258ONZnt9lpbyKp99ivHp
 DB/BWD3mIhlRGsXPXif2MQ5NZbscqxtoglUqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792000201; x=1792605001;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AiGe80BfbdsK/q+8SE90AdpQxw8K2tLVFxD+EKbeS94=;
 b=u87z0858bqSekNVNb3vHTI7CBn4rxqqtrxR8ZyyJVkm1jSLGQRoZ1+8e9HUltFGVDO
 5GkzrEEocRx1MV8yUngkOaWFIKB/SWHquYOq+vRV/PVFgAnKU5m7mJVIAnuwwRnkfI3r
 hXifyQfTSj0qOLCtSrXgHTaOGNu1KW3Uf4rJW2LhzNXFN8zpAcmtEpvja5o8oURLJqej
 KZgQf6k9a4+o2e2MU6QiQCz1kkZrIXyejrRrfzBTU89737dhgLoc40Sfbwj+NCX0APre
 slxxO0VV+Vg7wIDn5x7KRiCH8909MOx77l7AfHjrrlDqAhGD81xaDgB+z18M/sf959/9
 zGmQ==
X-Gm-Message-State: AFq9FYJOB2z6853MZhjHsvsEWNvnrnHP8LGdYo2VgmKEq25KH/2QYngu
 7XR3qnT3Yzwi+8mjnxBgsNnopbYK3XXNHbGGl66dDH7lV8M2wuxei4nhoUv1LB+RF4Y=
X-Gm-Gg: AYBFou3shstq2DL9K55B6i1xwkj/31c6GRdjReym8/8u8tJK7wUoH4p9Tbq4aB1tOKH
 AzhflZihKXPhJ5ud6kxH6b5bB3swKLpJOJw4rqy/6NEzwTvADC8t4laY8o4VbAf1MEslf5pmNsS
 nF/2R6ahVGPlvZDZ3q+dqufPKMxtlTe606axUBi4hWHA2w032y2uvmyr1RVIK3Hpq8fLydzSR/r
 OzMoZdGTo9Mwl5X9RKdLqDU50Ka8tFaS3fsGjhbTQNY5DAavI3QLfrNa9YZBqXl6xM/xfEe3PJh
 8V5pqfPaRv3pLN5QnkFZZYes+InI9+1cG1EAV7GR4HgvwbRaezzWnUEDlEPxjaWuALU22zWgQZ6
 vDmLkOD8NYi71MqXJBE4rwqeDsCRDHhMRzYmP9nRHpMH7E2pa5FTR2445fQ+MXtatrVctJGJu/H
 d5StmoRPiPONwBR/f7A6UP/jWXmcAXVzw69PtbWYH0ZVwFEBCletM5lQvWXuRHkt4/WgJenJcva
 n+R19Jc0jM9bek2V6FF6B6KuZItD5LIW+E4fUjODKh0jlb8OGsHug98kmgL694NKczQiu5zb2IH
 HeyhpoCSYEHEWQN3lyAPuTnGa8xBww==
X-Received: by 2002:a05:6808:6406:b0:4d5:27da:a492 with SMTP id
 5614622812f47-50c54842320mr14333826b6e.44.1792000200717; 
 Wed, 14 Oct 2026 10:50:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1a325a38sm17960820b6e.12.2026.10.14.10.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 10:49:59 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:49:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: u-boot@lists.u-boot-project.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_IMX8M
Message-ID: <20261014174957.GA152546@bill-the-cat>
References: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="euoDFh3G+gbZZ7IE"
Content-Disposition: inline
In-Reply-To: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
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


--euoDFh3G+gbZZ7IE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 09:46:44AM +0200, Andreas Henriksson wrote:
> On boards with >3GiB ram, we can end up with transfers above 4GiB
> which is not allowed by SDHC driver.
>=20
> fsl_esdhc_imx.c: esdhc_setup_dma():
> 	if (upper_32_bits(priv->dma_addr))
> 		printf("Cannot use 64 bit addresses with SDMA\n");
>=20
> Tested on Toradex Verdin i.MX8M Plus SoM, where bootefi would not work
> (with systemd-boot as efi application) and print the above message.

Is this a driver limitation which should be fixed, or a hardware
limitation that needs to be enforced by this Kconfig option?

--=20
Tom

--euoDFh3G+gbZZ7IE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas/AwQAKCRAr4qD1Cr/k
CrzVAP9d3LNNuoI8SWDhXkfKG+xbq7xUxQCpos05vj2mchFCRgEA2ch50dRRtXKb
+nAhgooFuCsGKdtwiwhR/owBui2QVAo=
=6R4m
-----END PGP SIGNATURE-----

--euoDFh3G+gbZZ7IE--
