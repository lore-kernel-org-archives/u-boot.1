Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B66EC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 14:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F8B981353;
	Fri, 31 Jul 2026 14:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n6gjZavdqKXV; Fri, 31 Jul 2026 14:19:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2734481321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785507543;
	bh=8QiH6MsFUw8cmaFf+AISsZPSnrCYbhgAOlJkeieh/3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hnfbzMeBPtfviWdGn047giH7yvb8aHmlT5Thag7ad1jKpTrkTxbgXIuZ4fhouTwig
	 Zz1oLd6DzTxckmZ8DTDgUoclDgtGQgKNf6zDb0KovS2OQtIG85TmE5XUGj9bIvgGX2
	 GaMoPc8hqy1CD1ECAzZ/3oscJzkEddbuIfwt59iVMu0Z15/DN9mujL8lG/yrRSXJw8
	 fFS3g+W15QwGyPguVCbvYFg1KjrlC35/K/eRUCuQEdMTU0HF99T7Uw9yi2T3tn7YP/
	 SwQuko9ehrcZTj3Kx6gRxv2H7ljjOqVkZOG0OHbWY6kEpI8NZYRKm29/RSCB9cCDlI
	 gPol8lTa117vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2734481321;
	Fri, 31 Jul 2026 14:19:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CFA227C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 233DA410E3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NnS0UdlNsPIj for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 14:19:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5D801410C8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D801410C8
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D801410C8
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:19:00 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb9b427da2so1451471a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785507539; x=1786112339;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8QiH6MsFUw8cmaFf+AISsZPSnrCYbhgAOlJkeieh/3g=;
 b=pLrTebd0eOcnFZfmPKvccfOhybeI4IJ3709GAxLJdRWZPtq3R24mvTaTxzOzJ0gMmE
 tCTazKEBNWJcJ08ab5/8nB7L0Yd4hnGX+JCcwCZcYZ6xVX4exHjpHCpNGGnSAkOYkGV/
 ZEuNH4rJCsecu2hCfzRSROMbd0PT+8upsu4g5uMeLnqsqfULj3xE1+5nWu4WUzwq4JMr
 k79a4hU887IpXI5cWXBfb4vEsec0S6RXQjnJOQxzwQ83Jv59ohp7cooqDgm7KQlLPVMy
 d5G166yOT/T4xp9mIiCj7WGkJgyQZrmx6BuSwn9XBCi292PWYWbufq2cS0PzgJ9jKozp
 z88Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDafMzHJlOfVAt1njb7ScupY+hBiKLCh1FaQz6ezSWea/EMm5y5P21zUiLY2JtV3aB5pAmEso=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy80CjZeFQst7VZU3kPnBVq98MAGkhlzFj4BqpuldBDjXP4S5Ul
 bmBe6kW0v6HikO7lzMJq2NGwmNVhUCJ1hvIWdMPR1lN8h8gtfdZNF/Yv2C3tgcf/Brc=
X-Gm-Gg: AR+sD1166VW51DQdck4QS8M975xvhqlDNxprxFJyqix2FvToUaAQRFHSAbMp7FT7XM3
 4IuSaP64XErTbdM/ghffXLgHm5ohcnO0PFNbeFcK3pBxlUpQWWvqbu9dH5Zcr6HUwYUEMAu+9bZ
 lz6Z31anwqUFGl95oUaDKDglMNApAqfLoq6mvXmxGih0YHED4Ba/MK8G2SPqL2C4dy4EZExSLkK
 /dF4M8iqDSkAjJHAySxy/1hj+8qqSRZ0hODhwDkR8kDuBhAjjZUuH+8+sH+M1CwYO3nP8jmZPE8
 CEAITzrclU1aLnNt0b4l73Y5hoWrkJCHcU8ppbwQ2h/jePLurMf5DaOb2tNxTrgYK0NfPahtFex
 v0NzUXXOr8FtCM7HmHiCH5cPThE2hNWoV7EKrSuPYzBt/Wsu4/PChrYHio2C7/V/nF/g5gKM8be
 13ukjZ0mmh/XRJMNT6+lZlZUipSInvk2fSzqORwrFJMkgtpAhHd27EC2lveG7XFhj9SBUTomcpw
 irB3VaqICanNr8R6mulYbRm0b6pl2s9HzxZozI2v/MViFp8WhtYqblO6o3eG0PVnBRW9O430tL5
 8H6CviWcvA==
X-Received: by 2002:a05:6820:5714:20b0:6a3:4e5:5282 with SMTP id
 006d021491bc7-6ae38b656b3mr1792751eaf.1.1785507539273; 
 Fri, 31 Jul 2026 07:18:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae3a0c5dfdsm950645eaf.10.2026.07.31.07.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 07:18:58 -0700 (PDT)
Date: Fri, 31 Jul 2026 08:18:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.u-boot-project.org
Subject: Re: [RESEND PATCH v2 2/2] CI: Dockerfile: Add LoongArch64 support
Message-ID: <20260731141856.GL1773261@bill-the-cat>
References: <20260731120750.2212394-1-me@ziyao.cc>
 <20260731120750.2212394-3-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZrfF0NySdgmJs3yY"
Content-Disposition: inline
In-Reply-To: <20260731120750.2212394-3-me@ziyao.cc>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785507539; x=1786112339;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8QiH6MsFUw8cmaFf+AISsZPSnrCYbhgAOlJkeieh/3g=;
 b=RPHOPHjk9fzqboCbIaVYC6DNwdw9Kc7Twqst8ohXjFc8p9gBq0lJgCWfF0frAq/9Qx
 7H89T/cmH6hVOi55WbzJ88DEuxXlE//jYXOG+qRjs4YlUvPwBRQ91NL0QwMDJziv1gVY
 fVfdLsbWcgzU2aXUfG7vBgLW6kQWKnKVIk94Y=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RPHOPHjk
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--ZrfF0NySdgmJs3yY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 12:07:50PM +0000, Yao Zi wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> Install LoongArch64 toolchains, build LoongArch64 QEMU,
> build LoongArch64 GRUB.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ZrfF0NySdgmJs3yY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamyuzAAKCRAr4qD1Cr/k
CkFdAP0RysR6+ExROucza/r69l4I6pBTHHWgqTd+FicFgmVXpgEA6RCDKabHRDQj
e8C569X+bkmCL+thbA0wu2mYJIEZ2AA=
=+pCD
-----END PGP SIGNATURE-----

--ZrfF0NySdgmJs3yY--
