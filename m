Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D58C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 15:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66D1540676;
	Sun, 23 Aug 2026 15:11:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yRsIpndsRPfh; Sun, 23 Aug 2026 15:11:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787497894;
	bh=pOImOlxiEFc5gNzMeTaiBOELtHRQ2Ax5yE4fhzcsgmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c+h+cJacLlfMzYL+e5sXOiXooHsr13nxvMhdZpqR/mDkdW5qq9cBe14+JgeV2htcK
	 kPvip0mylvx8LJpBRRtxkQ8RrbEaYtPMqUDoFA794KM//Lhlo/N30Qhb+zc8mVdhKd
	 IH8fo9dN61gvwAsExmjHAQM/N8bFt0xlH8d4AL/56BToN1I+h1qplbpsYwCduY01ok
	 w7GEPTEFg1XP5FiNE/5xypv0Se0gWzxnVT/Gkb90Y4FWLa61SO0PprImFhB9yR2qXj
	 nlU+80EC4vR5fJ1EiQzrb4rl5kh7ZSiYDCHYG0oB9OYLhXXJZArjRLXLXKG1q7FSN7
	 EW3bN8KAAdGVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34A894055E;
	Sun, 23 Aug 2026 15:11:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D823336
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 15:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F47F6064C
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 15:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdzGH0OO2VqK for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 15:11:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=I6+KEdCg
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73FDA6062D
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 15:11:30 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb29ed2bbdso1820757a34.2
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787497890; x=1788102690;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pOImOlxiEFc5gNzMeTaiBOELtHRQ2Ax5yE4fhzcsgmg=;
 b=I6+KEdCgpFSlvUc5LF1MZxiHNz7frPdFL2Lpvmoh19duwpgvqW9S+4+k6hf46I6OMv
 mc5QsssB83Nu518hzqza2uyCcN/Tij2L/9GqWvcW/bsMiP7II0lg2GAwbosrwjNBee5B
 4PTCSLc2PVQgAy8BRxly/uLm7Cs1jpLshC0XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497890; x=1788102690;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pOImOlxiEFc5gNzMeTaiBOELtHRQ2Ax5yE4fhzcsgmg=;
 b=Wb5tA3UMEAHOrkyXIClx5ww3Uo/r5P/BoV2HtIVUv+XO4xwA5CEyRvB4JNfPo8eg7M
 HEzSVSyi5Zjho5CxjTe4mPa0qk6hHCkuvxfyWO/XjUOtXypef1rjCJ+1dAs/6qLoE2tn
 chzsEuKxtk1xCqlo1cdSwaTdJO/FQes6z2IBTZJ3uHA5mgDke0nmJGP+TYWG1kk4ZLmq
 33QJYZhoqeAoeh6Uq35u9ITJwCRzhXQkifsEX/QdOonT7+moCLYAW3VMBEIbi/plj8b6
 ne0YAS6qPvPZglrwUhDU2YXlNBtAvCaWI3jzDPv6mws1D6lkyxF835twS6mKpc1tP3p8
 I2uA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCNHk8+WMhk/YTCq1aVOoka03oF8ibJP+mdU+ZhDpg7sTJe3FTjdU9pEGZwXdx7N6IJQAYF9Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kG49Qzl03BsTBK2KsQ9OXtqh/3ab7CCFsGc31iYhcKN69kHx8s
 0jSWG+knvxPZVIVX3lklvmJiJ+UiB44eQEmznxbXn1CO7nmf4NVDKp+s8dPcPtCyWSo=
X-Gm-Gg: AR+sD12qp8MhAhBWGPBiptzueUv8oGtFiy+H67A2UyWvkJl0y2ilB3WcwDEZGzhxB3B
 AVdZDA9sNnFzK+7v2pvDfhGLkDRg37azi1cPysKVDtT4HCS1LK+p2QPouVyodT3fVF3Gy7vWTW0
 ZsxOpC9T/IYrKkUH836ZmJhiVczTCimbtN7Mc24pupOZjYCyZuFvNV8l2dFRrGolxdWQGQcvZOw
 6YvFE7O/+xYbki2jYDmLRNUuiuBxgeFP1hut/kBiqwQAYUijTzGKS+DKF4JAgejxL19AUIglqvV
 HyvZ05os7jL5U+SUcKpmPgQs7YZxwroGlPMweNsePX8thW0BDka//Ueq+yPflGDc2HLnApspNWv
 TKWULb7UBfH/QcwQumkiv7bYr3s94qFozwJmOG0KtP0+qg5Wi3oglpvCWK7ye2i4Mx9I7x5LuLf
 ++LQyL+gWoqJxeRyBvYKnpM+2cP3vDNnRq7k51onhBM3lZrU86Rsev4nnDdF7bNjzBbhl9HOIRv
 laHcZnmFqQAE2HJ+joIsRnp99uPGhGDBp2MPJQLC2Fvu9/Td1Nj31AkC2ONdYw5jNgWtfu5VpmR
 BNXZWr0mlw==
X-Received: by 2002:a05:6830:3785:b0:7f3:ff22:d8 with SMTP id
 46e09a7af769-7f46150d820mr23473060a34.9.1787497889949; 
 Sun, 23 Aug 2026 08:11:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fcb53d0sm1786866a34.26.2026.08.23.08.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:11:29 -0700 (PDT)
Date: Sun, 23 Aug 2026 09:11:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Aaron Williams <awilliams@marvell.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Stefan Roese <sr@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>, Johan Jonker <jbx6244@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/1] disk: drop Amiga partition table support
Message-ID: <20260823151126.GZ523975@bill-the-cat>
References: <20260823101128.87329-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y3idr1ioPG1IOyeO"
Content-Disposition: inline
In-Reply-To: <20260823101128.87329-1-xypron.glpk@gmx.de>
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


--y3idr1ioPG1IOyeO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 12:11:28PM +0200, Heinrich Schuchardt wrote:

> The AmigaOne is not supported anymore by U-Boot.
> There seems to be no need to keep support for Amiga partition tables
> anymore.
>=20
> The usage in sandbox*defconfig has been for compile testing only.
> theodorable-x86-conga-qa3-e3845-pcie-x4_defconfig and
> octeon_ebb7304_defconfig support GPT partition tables.
>=20
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

A future active user of this (something qemu?) can easily bring this
back.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--y3idr1ioPG1IOyeO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaosNlwAKCRAr4qD1Cr/k
Cke6AP44odBagv+PT3HfKVlMMep0A+RtpbpP+Rbt2yfLxKoNGQD+LUTex+TnEnJl
jaTqsdFFH7Wmd+FBOYXsMlnDE0C7rQ8=
=EUwk
-----END PGP SIGNATURE-----

--y3idr1ioPG1IOyeO--
