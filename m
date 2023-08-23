Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D621EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B7C864EB;
	Wed, 23 Aug 2023 16:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XEmLwpDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C295864EB; Wed, 23 Aug 2023 16:42:43 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BFA864F4
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59234aaca15so29349517b3.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801760; x=1693406560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nUAW+VpdgUqTpYMA9xwJWj/pwNqWOcStJVypHmK7k2A=;
 b=XEmLwpDUimq3kgE0KZKkCD23/V6CrLorNfmx7yz0r+ehV5bheb+uFdl4fA1pjjYz4X
 MQutst4LbCpxsNX7YzyYmmxf8aeuy6jBedJ3qd4I81a2K5khQMvUCNxc7zQeLAc2P00+
 9zgNb4orPmu8kql1QBGQneopIP4aSxVYvWVJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801760; x=1693406560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUAW+VpdgUqTpYMA9xwJWj/pwNqWOcStJVypHmK7k2A=;
 b=XIitozV9uc076v/2m8tKwKPsrDGBiXFoiEjqoJyajXQVj1gJaRDiD3zmx9G9ExSUbh
 QutCKzBdKc247n80SmSFgmkcpclrBnxTJcvgMPSw+HQEGhBDBzKdUchoW/egIn0P8r+u
 QB1gQdNdLJz3Kii9SC2FPE5Qe1UTWgHu8MN1YRroDpy6HZ4jFgiFaeMLWaBxsJyplNi3
 O2qq9/fmRTUKXJkauG85KUghaVyuGxFhQc9mUTybsZiZF1sfb/eWEf7A3yEAMva7JXDP
 WlToEdyeyktmG/sG7h6vECT8sXcGw/xr8OovqeLmFReXPmGNVj77N9GxleRvw0gYr7kH
 nOmg==
X-Gm-Message-State: AOJu0YxZslsP2ZT7Uj1xbXYeLAzIVdVRiCltPp1wV4RYSFJxmmvpKMy5
 +cVeFEKK9VpCMRdqjwnhcCQl2HRokCIVdOt0+hrawA==
X-Google-Smtp-Source: AGHT+IGfOsjaHUk4U5LacQ6DH135XAiKY0hIkK8p8d2P5o/VPqjqQIb5DDfTjMQr/vOdDZLmkch6ew==
X-Received: by 2002:a81:80c4:0:b0:58a:83cd:115d with SMTP id
 q187-20020a8180c4000000b0058a83cd115dmr11391281ywf.50.1692801760266; 
 Wed, 23 Aug 2023 07:42:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 p188-20020a0dcdc5000000b0057a44e20fb8sm3365872ywd.73.2023.08.23.07.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:39 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] disk: dos: Infer MBR partition sector size from
 underlying drive sector size
Message-ID: <20230823144238.GB3953269@bill-the-cat>
References: <20230813234845.591216-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rngN/HNVodK7/F4L"
Content-Disposition: inline
In-Reply-To: <20230813234845.591216-1-marek.vasut+renesas@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--rngN/HNVodK7/F4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:48:45AM +0200, Marek Vasut wrote:

> Block devices with 4k sectors imply the MBR sectors are also 4k instead
> of regular 512B. Avoid hard-coding the 512B sector size and isntead read
> the current block device sector size from it, and if the sector size is
> larger than 512B, use the block device sector size.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--rngN/HNVodK7/F4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGt0ACgkQFHw5/5Y0
tyy3EAv/f49VuAnbfskHhpeARcAu27pZnk0QJsBBrY0aHBFQ6i5Pfv3HKJs/V2gX
3T9aWeN4RNL60E5mFC50oYZWMWR97fkpP+Xd+M5m/0wikbDgm5r5w+bT/5vOUv2T
9W4y5EKPjz3rE+Hg9zmPysIMzDQThQMrNySwVYktTC38KQr4EIIoT7eBJ0CE7LuG
TQYQSZAkWTF3LR9OioLbFiqNJwdk74euyuW2nhJcJ/3j9eUKMZDoOAHQ2etImBC+
Ms35a1BuDE2zBjcunuJce4qa/YsspGNkHsoMdY6gSgOPnTXNSwlLZFPAQEV5Und0
T9cFBAqI8PQ+OM7SMauWeoQMkwjB/ljbU7BeffCqBDPEhQ1hhgrrokMNQXzwCRSY
ojeO89PJK41JHr73rH3kFyqe+u9Y0CcCocJPdIf7QZ5ZPE+E7ll9edcwdF2B70po
FzhUtm6dhQ8mVCkJlKAebJ/BM6qRXP+NHjMYqGnfpDtXuMrckAFiUpKtrH2WcvtX
h47fAssC
=XMXI
-----END PGP SIGNATURE-----

--rngN/HNVodK7/F4L--
