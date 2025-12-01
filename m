Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E56D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1CA83D07;
	Mon,  1 Dec 2025 19:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l608vVRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9BF683D0C; Mon,  1 Dec 2025 19:37:27 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2F983CF3
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so3441589a34.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764614243; x=1765219043; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O0/LNIeOfL+dUWyhQCVx89sMhuu+GJTAjWLqwbTAgmg=;
 b=l608vVRfrK2kv2W3r9lUR5qznu5NgR2RBhRRwvbmYSoyLYeLpwBqvRrsr1v+srWavW
 M89UC1rnWshI8KEIbgbp584w3nFuhSrsRJHjiHxOf4HzF2Zf1hrIgUao7YFK7pGMNxp0
 MgAzp8kJejo1orHXpJubufWoUdAjC1SJDylZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764614243; x=1765219043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0/LNIeOfL+dUWyhQCVx89sMhuu+GJTAjWLqwbTAgmg=;
 b=DOLiuTrWHn9H/N0WStl6VFxWaij7QIZLZd+UpL+6PY3f7dCgZW10/Uhwc7BGQuWjuM
 5/32/6EOtc6iVCMvRSk//boWSve4nsVAF1nEV/mCugVlwgki2Y2ralFRYXwScZIwoNP8
 f6yjazDWTAvajskycOa8eP14WihnWBUN32B7AcpVvppgwDP+5YHRE9KYSHr0MRa/b7/c
 Ej/g7BakqQsKTViL/w/8Zk+G0HdpqKWYMG20dYhKxvuX0Tn9xs+RTNOXdfeaYfO6zp66
 OED3l+l7yf8mx3AUZBXJ7B/WSf6ZWVNy/LTno8HJpQUq+mk9HmaYe4+t8+9e515P8icl
 bInw==
X-Gm-Message-State: AOJu0Yzq6XXcpI3olT5hReTQhdA1loWNs4MPElFt+62b0QxnzpvGeSFT
 OZEqlTqdcclZ1WNdqsccPOnXFP6SMcz83CvQx7un4GXQ2U1oep8k8sA2UhNlsIFk0Ig=
X-Gm-Gg: ASbGnctBXg/HrX/WVqQIB0MQ36CGJMM6j1A3l/xYQxgOu6sbU6VTb5tcDVxu2olAIch
 Mkk3YJe3SZDfSmW5KwYJL2e3ZunkNfVofzbajuSuyLCeeDjyjD4N2CQN9pA+uXRLtIRQ+Jp6YT+
 RhbF0nXpSAAsAmUdorS1VWvY8GLdQWizHQ8Oc324Fwc6AVbGztayy8mg+PfR8tt12A9qxLSe96g
 vZie3OZ4RA6I/xR7Yv5ypzecTA3mSirM9/OauFgSk1mZObCmo97ugDAuL58rOGPzeA9tPDFd1eQ
 mIYEiaobi9dWQ+3Ch2Ig7bkElUixLZgxbK9iittIyIBq1AR7k1AQIZh1Ik3uFIFbK0P6D/x1tmq
 w43xJ7YPeIKqNh6QzP9HniqmDzH5kyt4vJ4XSa3AKiU3MKf9MVbfBJ+YQoDH9OJGRpaWboaool+
 bNFxJjlDh+4WaCbiy9GM13sTnMMrbGFnjh8V5nhaocma1HLCrUog==
X-Google-Smtp-Source: AGHT+IHFtxXJp7CieK/+S/D07hOzqrgImuyUp3q9bNURv1dWAWS9DiBLjSwmfP/kS6fXj9uJXPvpiQ==
X-Received: by 2002:a05:6808:c2d2:b0:450:b1a9:e7ab with SMTP id
 5614622812f47-45112874638mr15318168b6e.9.1764614243270; 
 Mon, 01 Dec 2025 10:37:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453169b3d78sm4049437b6e.2.2025.12.01.10.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 10:37:22 -0800 (PST)
Date: Mon, 1 Dec 2025 12:37:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v5 0/3] Harmonize image size checks
Message-ID: <20251201183720.GQ303283@bill-the-cat>
References: <20251110091256.2422534-1-pro@denx.de>
 <aS3evAXY7dTqGfdq@eryximachos>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xSlwLZbQh5Ec0cTV"
Content-Disposition: inline
In-Reply-To: <aS3evAXY7dTqGfdq@eryximachos>
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


--xSlwLZbQh5Ec0cTV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 07:30:20PM +0100, Philip Oberfichtner wrote:
> On Mon, Nov 10, 2025 at 10:12:53AM +0100, Philip Oberfichtner wrote:
> > This patch series aims at harmonizing image size checks,=20
>=20
> Hi Tom,
>=20
> I don't want to be impatient, just to make sure this one won't slip
> through the cracks: What's the current status? Do we still have another
> reviewer we're currently waiting for?

Yes, Marek has said he'll review this when he has time, and I know he's
going to do so as soon as he's able. Thanks for your patience.

--=20
Tom

--xSlwLZbQh5Ec0cTV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3gYAAKCRAr4qD1Cr/k
CnsrAPoDGNOk/OsaKHPePnqf7KytFFjnoVr3vT4rKZ+dcxConQD+N3/LyazPBEsY
jIQ1cUWV6txPXVPKapPyyV0ZOIw7lgo=
=86Me
-----END PGP SIGNATURE-----

--xSlwLZbQh5Ec0cTV--
