Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28BCE92706
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930EC86D04;
	Thu,  5 Oct 2023 16:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mKmdMEm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 702A086D34; Thu,  5 Oct 2023 16:49:31 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB2386D33
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59f1dff5298so12513867b3.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696517368; x=1697122168; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LlL1ZTBTUkdRAKc576ALPE4Iaj2uxhidj83hAZ/e79Q=;
 b=mKmdMEm8AkXzTbJApU5zszIWqy6dfcCiTooKbyAXb7vtU0O8ZBu7HKD3HJgOF7zdSP
 Vs//Z9bK3iUBpcVlbbAzh2rrzq3yBZRw9ROUpkrLvW34kp2XJmoXztJv0TpuE68abunq
 /orlVy/fFInyao5VH99CSjzt6gXBJhUO/yB9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517368; x=1697122168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlL1ZTBTUkdRAKc576ALPE4Iaj2uxhidj83hAZ/e79Q=;
 b=frHDb3tWwnXNQaeoZnHpSsX40ltAyx9vHERJLrprfahempjEPK2IaWrK1eBmcLrkQJ
 nIivwr6S3KXKhZNuMypkxojTBWTpwBYvqUr/aw3fGJkHQG8d6sK54F27yeJbv13EO6wJ
 hHOD1TzU6rPpIodTp4GytPh2N13TAseVj4ayzQC/45pOlWgl3aDif8C4T53z6ubaPCkV
 1qEQEqm7ADbh/gY1bDNvE1ypgSd7L0Fb6aDHB+SayitL/vP0jcMwwvRm5AL443DW7tSb
 MyCU/C/e8OHrc9PDiVSGLEEIGPVvDnU4KscswNpZArbcailcjj0fDWJyp4j17CvQGUot
 s88Q==
X-Gm-Message-State: AOJu0YzHqtJl+4B0pmfNRo54soQlTHlOeH1+djbJByhIWIOxlj3kbtQr
 +eDgn3/5zyeUSjP3NC3dJGXA2g==
X-Google-Smtp-Source: AGHT+IGuXcXlMMiw4WkulflIGc9EcM3ZdGCwoKH3xliCRLz7GTFJ1JsvwqVFZS29XcfROR/A+uV3YQ==
X-Received: by 2002:a0d:dd96:0:b0:570:28a9:fe40 with SMTP id
 g144-20020a0ddd96000000b0057028a9fe40mr5335669ywe.5.1696517368125; 
 Thu, 05 Oct 2023 07:49:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 d68-20020a0df447000000b0059f5d686479sm564093ywf.16.2023.10.05.07.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:49:27 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:49:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, nm@ti.com, u-boot@lists.denx.de, vigneshr@ti.com,
 u-kumar1@ti.com, reidt@ti.com, m-chawdhry@ti.com, afd@ti.com,
 sinthu.raja@ti.com, gadiyar@ti.com, a-nandan@ti.com,
 vaishnav.a@ti.com, b-kapoor@ti.com, bb@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH v4 1/6] arm: mach-k3: j721e: dev-data: Add mcu_timer0 ID
Message-ID: <20231005144925.GM8465@bill-the-cat>
References: <20230927130956.910988-1-n-francis@ti.com>
 <20230927130956.910988-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ME28NfpwP0zDGDKK"
Content-Disposition: inline
In-Reply-To: <20230927130956.910988-2-n-francis@ti.com>
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


--ME28NfpwP0zDGDKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 06:39:51PM +0530, Neha Malcom Francis wrote:

> U-Boot uses mcu_timer0 as the tick-timer, so add it to device list.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>

For the series, applied to u-boot/master, thanks!

--=20
Tom

--ME28NfpwP0zDGDKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUezPUACgkQFHw5/5Y0
tyzw/Qv/aleKUSFe2NimlvhVoqK8ue3jhIS9+gmlfIb1+TOOVOIW+oT3Y3hvmrXo
H4op5bNy2RAlXQ45ecp+t0s2L5771cCZvaJEpD6U3X1DuQSCbotYn0f5IdXUNij8
PZShoCorwebuiXIGMW+4gG+B6b53215pZ66Z0fDCr0o5xBmGyLpN66+yR0WPY0SI
skeceWFZVIw6opNHRebL2RjXK7QhRdoiqOfq8IlYmU7sdGTXDGmDahHmJHAJqoAp
JFMr/s8y/pMPnHBAlf3xqN6YAvIGqaJJfgVwZdW52IUuQBt9zOYyQqjLsxXisAKU
HTVQiKBW+VBWWLPf7cyD0ZJiSve9Jnq9K3FSlNIi1CVYwjBor75AUQR5CKu0MoIC
1y46xe9yABJYdfPmMO4mdRDHVHqXG0SQX0/UTpqsLi01+i5657X+bf4/7doUUiPS
Nc8EKPbo/4CjJRhtWLJa8OFzXgIc9OrLqznY3I48s2joMpIG7zPqcFG7gGyT18yc
uTqZ4Wz9
=zy1s
-----END PGP SIGNATURE-----

--ME28NfpwP0zDGDKK--
