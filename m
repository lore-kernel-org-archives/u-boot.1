Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE938C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3C9A877D7;
	Thu, 21 Dec 2023 22:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TnHE3EMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92050869B6; Thu, 21 Dec 2023 22:07:22 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E03B877EC
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77faf967e65so63481985a.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703192839; x=1703797639; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zPsZC+Oiqzf50okrWz/gzFijO4DK1PyCh9pr4UTxPrg=;
 b=TnHE3EMJZnpeTw7nL61CtO/R3wTB/9H5HsMehK0xixB9dSddSQBYNTZRLSEIuQ19uF
 APcTM8QlbrVOocThD4/mrmSmniy+mpY5fPdx3sWyyexJd8f931fbu4qpFIEswfFquTsb
 2wNr7Qu79aShZkppHAmFPXslEnRXk7NgdntTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703192839; x=1703797639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPsZC+Oiqzf50okrWz/gzFijO4DK1PyCh9pr4UTxPrg=;
 b=M6vDY9LadgrWmGYsq8kz9q4hM5nDkCE1+6sDkMM+YXHs00NdUQbabq0OGVWqQhelFN
 +5JI38//zRopX0XW3GLC+SuJdBB8dqjvmaGs9UZ8WtJjXb5M8l3ZkVf+fXffak/WlRhp
 ZOkCNbJVYL0Ggt5K2EpMZUtTcnKjdb4CYds3icVO/9ZO6agqLAqhhGdswyB+vl28Rjyu
 HgWoXb7omyg+0K2ILH7lyZ2idL/JzQUpLDJDXww9E/PWzee1+E61Z3Av656xCeczZm1H
 2GDGrFZKrFKucycqvnpJtcTmHmB7c/6SxXWPcM5sc7rqukMSPWGoK8ps3GCBXqFdlyrj
 az5g==
X-Gm-Message-State: AOJu0Yz/97bWW5GwO6YygUac9aFfM4I2oQ6+wfwj9Nxxp1xluj9LrVFT
 nNAUYmP2Fzd3L9AXeVtt1LWKrtgDUlxHDxA8gvC4bVZyogM=
X-Google-Smtp-Source: AGHT+IGDN7wozhTmva7v9+qc2eoT9DYGgHdiBWIORNdyyumQmMOMUI0yP7b8NlJRAXEt+nvA6y989A==
X-Received: by 2002:a05:620a:2e6:b0:77f:1827:a9b6 with SMTP id
 a6-20020a05620a02e600b0077f1827a9b6mr479802qko.138.1703192839289; 
 Thu, 21 Dec 2023 13:07:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 b24-20020a05620a0cd800b007811c18c371sm822185qkj.36.2023.12.21.13.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:07:18 -0800 (PST)
Date: Thu, 21 Dec 2023 16:07:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] iommu: add a connect op
Message-ID: <20231221210717.GS2513409@bill-the-cat>
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
 <20231211-b4-dwc3-qcom-v1-2-46275113b4f2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dLhcMvtmSRW5Gu19"
Content-Disposition: inline
In-Reply-To: <20231211-b4-dwc3-qcom-v1-2-46275113b4f2@linaro.org>
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


--dLhcMvtmSRW5Gu19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 06:41:41PM +0000, Caleb Connolly wrote:

> Add an optional iommu callback to be invoked before a device probes.
> This can be used to configure the IOMMU in preparation for the device
> (e.g. by allocating a context bank)
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--dLhcMvtmSRW5Gu19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEqQUACgkQFHw5/5Y0
tyyOlAv/eldia3f0FnkbUIMuIXpTMRcdO14bqK33XEmZDt2gFqVKJ4TwSOsGVlRY
ePFW7mvlkheHc6r2EddECzVU4hAks8zmLmKSgrfkqV5PCDgA9vQJZkVEEi/AnPOH
jn9yF45ILBaxh1Z3k2sVtz7i22UDM8vqOIu2cbpcVVmk4FC1V2vi5JgKy4uyJsnE
/RzaNsgrmGPOj8UqCvcVSse4ZVg8mFsmTylvgMee/X3JmKvadocw6QROoPdxGmHy
O49FxKiqCNll7rKN+QY+7arIlLlcIXQB7wx7sGv8Tsp0mBJyIEtBw2dDji/yxhln
mf3ofENdwx+x9OJ/c2XrsSY9ZX3+H+2nI+eZ4VGG6fOTPcBfJuS/1aj1biu9bsDA
j3PYmSY1udY7sI8do2bnFm3D+5xQuEqCaxa9h7BYEDJlDaftGVRhT7+Zwb1YvVOP
6kcfGK/O99xq0FKyzahZbON0OCREVJ5I3Ha7MA51kgbfNWeyKcTEQUqmRQfP7yxg
lCZOOAaP
=gK/m
-----END PGP SIGNATURE-----

--dLhcMvtmSRW5Gu19--
