Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B43CEBF61
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 14:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 160F583A03;
	Mon, 17 Nov 2025 15:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fYo5fVRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CAB83A64; Mon, 17 Nov 2025 15:33:45 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD8983946
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 15:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-44ffaeda17fso1234707b6e.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763390022; x=1763994822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xl/A4a5ZAiayH445kd/8to5dKgOHNfARlM8yAOcDJzI=;
 b=fYo5fVRdyWmYoqB1yoHSj/Ik2FVaqu4MhBTD4ktFgAi/YymZkx/la5HE29DJjUgmng
 01I0hHO4pMNMyJDNXq6VYt+r5NoEv1zNA0GX2lINIMEgZDi8CZI1Qrg6AXVQ9DWAfqr6
 /UDsKoNfVXR3mi885uU+nlUREEIL+Kte+jJ80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763390022; x=1763994822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xl/A4a5ZAiayH445kd/8to5dKgOHNfARlM8yAOcDJzI=;
 b=X5pzliqr2I8/2Tixoe5UDkBTrdDA+rzYAdVKjK5fvmvUPl6P1JX0hiUNKv68UY7/Cp
 lpEbYUE0fVsqgQAMEKoKuDuwgnWdjpo9RkFzAWgN4pJzgcm0Cp0YDor+CkbwGWeVMFFF
 nFOLhAymtEB8QUeansUVGlM3l9RMG+V0S6NEepmdlSgIE4Zo8jptoyZvh6JCqfGRFBnT
 S+cckUGE3F9ZT6k0kB+uTyyOKUkbMhw0Ab17P7v8DWFSGH0zin8EE2R0Rs6P1dpZ38K0
 AvUUA5uCP8TCSob/ZIRYOWPHsRVGk43rtXFvb3yGV3EW+lKGwhVnsRLNDPHeO+WObD2o
 rAHA==
X-Gm-Message-State: AOJu0YzX+dOsDF1e3zY449pFuiiY4IsHwAZ9b5kOkanHLqBvje7Fv0Fk
 wx4EyU61fxxquMsuOiXTLD7psfmLZJxlLK8JBC8xgj0YwGZsjNK3Om+hiLKalEfTw4u8X9WJUK0
 0vboC61MfwA==
X-Gm-Gg: ASbGncsbuk+PwHO3RkPWQwssRo6UiH2LmBqlRaEz24YB5Ex7FWYlkAf9wkEF7FKCKAn
 5CYRXbdvzfZwMmdzyMvdQzphgWJxJguzrDFtVqeNdOtrZ18hWyayuYr2+hYsvaI4t0q2UuNO195
 Iv6NCqGIyCziv3IzGzNHvnyjnlZ3mZOPHawKuN8i5Nan7bmAcokhgNGMV+kHcvPo9Y8YfG701Ua
 NViEZlyGfx9SeCZnHkQjJECTlPntERQfw+N9eVglJNeMtVLxhho6kVtKGoZy8qv/sQaxwq/tivZ
 Cu0gnQedsrSMyZm9b+5wPTrfC42rKVUnGiE36IIKZqPLIhnFjvduWKNTSPucfuMvYXdJSd6sLAg
 Bidk5f6Y5KXveGZmTPuPgWLoI+e5S/Gr93rWezYuVOJ0erCSNJ3xOZQYEToWBwA/XC/p8yZkT7j
 CmhTNlr+1NYpfeTYw7AwG1xxZ+5Zh9Y9CYdHmLCblyf+KDciorpQ==
X-Google-Smtp-Source: AGHT+IFJBipduejl9RlX4wn6yNj0TUHR7ofFkJDM9qNXP91xR6L9fUlZmhvrvcbNuwB/4Nfe44FCtw==
X-Received: by 2002:a05:6808:152c:b0:450:ccc6:4124 with SMTP id
 5614622812f47-450ccc66d41mr1349159b6e.37.1763390021856; 
 Mon, 17 Nov 2025 06:33:41 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a555527sm4304262b6e.7.2025.11.17.06.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 06:33:41 -0800 (PST)
Date: Mon, 17 Nov 2025 08:33:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] drivers: rtc: convert tristate to bool
Message-ID: <20251117143339.GI2125796@bill-the-cat>
References: <20251117103315.2212686-1-mwalle@kernel.org>
 <20251117103315.2212686-2-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p7hi1RpsN1OWxRkK"
Content-Disposition: inline
In-Reply-To: <20251117103315.2212686-2-mwalle@kernel.org>
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


--p7hi1RpsN1OWxRkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:32:50AM +0100, Michael Walle wrote:

> As u-boot doesn't have any loadable modules, tristate doesn't make
> sense. Convert it to bool.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--p7hi1RpsN1OWxRkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRsyQgAKCRAr4qD1Cr/k
CtKqAP4vZX58sAjMYSe+BkmlxzHyZa7KLflgVFGgb1b8otQgeQEAnnytjD0Ns2iJ
9wv3xG6tzo4RDqS5AtuAUYbHwOjYagw=
=rMJ/
-----END PGP SIGNATURE-----

--p7hi1RpsN1OWxRkK--
