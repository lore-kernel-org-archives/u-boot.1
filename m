Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EEFE71D2D
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C44D86EAA;
	Fri, 29 Sep 2023 15:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JIZAK4jk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD1886EC7; Fri, 29 Sep 2023 15:21:34 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABD786E49
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a22f9e2f40so16695297b3.1
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695993690; x=1696598490; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ctAN8eIK0idImFI1ZJIXxaGitzWypNJuxPN2M1KQUPk=;
 b=JIZAK4jkGZChrcFVsN7miopcwATKHijp0IyMCmcgd687tN19b3To3w9Ab4SAouFjpr
 nItcbND7ySBzMtEtmTtfK2hcAcQHuvhSmsn7bV+PSNlml0SrFMSIVualqSMSsxJEFnaN
 COsejGVuBUfwc2/jfNOFC1oK0M+7LcnEihCq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695993690; x=1696598490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctAN8eIK0idImFI1ZJIXxaGitzWypNJuxPN2M1KQUPk=;
 b=VCvD6O5zAnsQG+EbUUiTXnxDslp3a3jCaGZbq414OzOECK3vUKDM7BoYj2ZRxWx0ey
 B9PiNxFbqYMjCqLGZuiJ0YKMgYDMMj+RFlDCEi+pJFzWjBgc0/GYzSLYjrzZ6saP6Ezl
 A3hA484+xU4jZ20Hf1HHob9g4j6Gh3yb3cF1yNYZiomT3VzjelRecQzfrdjgNOu85CxD
 OCswWVXDluY7dEY3ICl52E2NQbLQ+be/5wrWgvWIhK4LPGADuzPVZOO4o/UOscVLZ/uS
 ZNnS/QGgMMKZ8UXd4qEwQqAMqC7jqA5Xfll7HJ92dkp02a/yIvd/0gHXGCW+w8W1b9Cu
 N8Eg==
X-Gm-Message-State: AOJu0Yz16Snbq4+Rz62JwGnFosAOj0R2nlxqWnBSShwsHM20CmzrOn0z
 SvZz6uirZOtbGNtap+dZfOp5ug==
X-Google-Smtp-Source: AGHT+IGpSgDy6MqBMUALcU23FhiSm/KQ5xDM29Z+0leVVM9NQdoHkW8XGdidMyaAAtPpB4LGJydCdA==
X-Received: by 2002:a0d:dd45:0:b0:59b:5456:a9bb with SMTP id
 g66-20020a0ddd45000000b0059b5456a9bbmr3938280ywe.42.1695993690427; 
 Fri, 29 Sep 2023 06:21:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a39b-08c7-b2a8-b94f.res6.spectrum.com.
 [2603:6081:7b00:6400:a39b:8c7:b2a8:b94f])
 by smtp.gmail.com with ESMTPSA id
 b145-20020a0dd997000000b00583d1fa1fccsm5444502ywe.0.2023.09.29.06.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 06:21:29 -0700 (PDT)
Date: Fri, 29 Sep 2023 09:21:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH v3] env: ti: ti_common.env: Fix get_overlaystring for FIT
 Image
Message-ID: <20230929132128.GK305624@bill-the-cat>
References: <20230925-b4-upstream-overlaystring-v3-1-47bd6b973cfd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XqO2/HgiRMcJF7PF"
Content-Disposition: inline
In-Reply-To: <20230925-b4-upstream-overlaystring-v3-1-47bd6b973cfd@ti.com>
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


--XqO2/HgiRMcJF7PF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 11:53:42AM +0530, Manorit Chawdhry wrote:

> After the refactor with conf- nodes in fitImage, overlaystring wasn't
> didn't handle the new conf- nodes in FIT Booting. Fix get_overlaystring
> to handle conf- nodes.
>=20
> Fixes: 837833a724b7 ("environment: ti: Add get_fit_config command to get =
FIT config string")
> Reported-by: Aniket Limaye <a-limaye@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--XqO2/HgiRMcJF7PF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUWz1UACgkQFHw5/5Y0
tyxI6QwAs62g0/nhxE4cILvuUtOgnvw5QhCF77fingZe4Ca9yHPXiY+VWUPvyIuh
kFFqbfN4ft0r4UkAZr0dpNjiDLTcNVwHszazJ1U1etC55tuVUQWlT0sAblV2Y0ki
OgnjfQnGFW/IEsoZG1z+IvWjEwg2uKKoFYqgYgYgGIPGOksGpBpVQpD8Nx+9bx9Q
nqL2Zvvwi9DqF+zjWcD2XWpfFX1B8VihDnQPiHW2XpwR7HRWButB9fwtpfyZzoH/
PPkP2cbECBPx3ocrth1H+BHGRSbD7B3UyuY3f4/2w9ITT3SbfKNDAZu4qjFArdVu
9imuQwtVSZwOq+rdo7ufbUU6Nwdimlati1MGXYdWhYfF2At8HuYZ2xq5E+u2MBSB
t4S4JwmjWLGixiB8t4uDssXP7foNnpSJRzigHBd46fGRE/To0Pcomd9fBZedkG76
ayulFs6nIHcLpBxYDeJKXH8xJpuRf/wbkKa1ssVF+pvaYEBmXpfLPBOPt6xFPlW8
ngsbnAIj
=Jbce
-----END PGP SIGNATURE-----

--XqO2/HgiRMcJF7PF--
