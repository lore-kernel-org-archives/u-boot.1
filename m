Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48DCCCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 14:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C2B0836D2;
	Mon, 13 Oct 2025 16:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JUr9psx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E172836EE; Mon, 13 Oct 2025 16:13:46 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1E883695
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 16:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-43f64a5014aso2275458b6e.1
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760364823; x=1760969623; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=67s4+MqM3im6v9TtsIzhKsmCqIoCAGSs4xmChYyCZh0=;
 b=JUr9psx6Mcy6Q4xc1Ws6IP53Y+rzbioluN98dADPn/I8S3xfUDdlgDS6yozmLecG0o
 R2MNtzeIM5w3SXp1QA/CjgVlCqqa18AdsUmtkoY575sRimIENaTqjTcc3SSNM0dTZbzi
 iqKQgLLlIQd0b7fuPGglpxPG6hKvi0599rE3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760364823; x=1760969623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67s4+MqM3im6v9TtsIzhKsmCqIoCAGSs4xmChYyCZh0=;
 b=AUWUI1pRN2MgFktqKgQv58MUwwCpcJgLi3vSlXb9BsN3PV4UESbPQ1TFbZNMJ1gV6p
 oi5isnwfUAsEWtBPhkT06gt2X+gdEjW+zaGMIXdWqbtScEMh6hzCHaUeC7sFhtaBUO/t
 v4P+Zv1hBUdMLcAFjyMNpoiQ8lJHE2v2E8kkY0zEP2AQQFzMbBXrKHUoEXyuC2jxFAEQ
 WNrWsF3G/UcpfoKMM8NknbiYOSwJ+fgSs97DEOj/VTp8ZfjgEmyhLGwdDGgBcJMIodGJ
 k7y0gPeXkskQRI/GR+EhGrE4AVJ5WAUxncWteAvdewlKuXcAmECeG46LJ5d1SvXT9VwX
 creQ==
X-Gm-Message-State: AOJu0YwWlnS9BYW47L2ea5GpIoXQuX5LposaXOeifjgWfJovDLIGYXAi
 E2pr5z5VDDRNW+vkmEf0GPVjASEFG5bhBHHs8/webTmpNJLjUW4RWXKkNKfBwWGKAzo=
X-Gm-Gg: ASbGncsydLr/V7Q7WaCpbF+SQwfwoZx2CSzE9uyhs5GE11EWe/5E4mKyYzMT0+xZ/Uh
 psNYJv57fmCspLpVG5brdMqyR7wp01IP5vlXC3on2Vy9OBsFimnPouTlXHVc5FGcas/aOHqH+q+
 6zqkc5OXyWckU9JbY82jK1vy8Q54DWUm6tkSMCLlH6zOcT0/8sINzFgdHRiPiAg8A7KLJDOS43z
 QTApwueY+MG7MvjLoxEySmA/8EKVosVJhvJqBRb92JWJgFpT6ditiWeBntATKyU1XxYS6H36ef8
 6DM/+8HY6eBvjTNz2hNiQDityDXV7cG7FM379JDZbOZXIogiWZLYiY5/AdwmPtqW2fY+C/yj7gE
 4n5VK2VxUCtM84XqmxO7+uIpToDZzQIs3/9/QXau/XQ1zhvV2GA5rL/pSGSvUjvYlXcsS3Cu6J+
 KuCb4c
X-Google-Smtp-Source: AGHT+IEhgweKuPDPWHOmiUyEu3SaciKIAfvTYjEOwYLVFhN3Tg3E9kNEXbbC0T3wXDXqhGYauJPz3A==
X-Received: by 2002:a05:6808:1821:b0:43f:5bee:4e4a with SMTP id
 5614622812f47-4417b3dd27emr9211943b6e.37.1760364822790; 
 Mon, 13 Oct 2025 07:13:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419895b2dfsm2427566b6e.24.2025.10.13.07.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:13:42 -0700 (PDT)
Date: Mon, 13 Oct 2025 08:13:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v5 2/4] boot: Move obtaining the label into a common file
Message-ID: <20251013141339.GC6113@bill-the-cat>
References: <20251012064412.2892979-1-sjg@chromium.org>
 <20251012064412.2892979-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nr22NAuZRXf2gPM0"
Content-Disposition: inline
In-Reply-To: <20251012064412.2892979-3-sjg@chromium.org>
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


--nr22NAuZRXf2gPM0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 12:43:54AM -0600, Simon Glass wrote:

> The 'bootflow list' command supports looking at the EFI device-path when
> available. Move this piece into a common function so it can be used
> elsewhere.
>=20
> This updates the output from 'bootflow list'.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

You were supposed to drop this patch since it was only needed for
another patch you have dropped. Thanks.

--=20
Tom

--nr22NAuZRXf2gPM0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO0JBgAKCRAr4qD1Cr/k
CjrUAQCOp9sGFzWBNtLaN+N6c5tExV4nl5u2hoEvx0yCI5O6ZQEAuFgIGK2oScR5
7c8tRSxnH86nq+apTVn1WdmrygouRQA=
=emxe
-----END PGP SIGNATURE-----

--nr22NAuZRXf2gPM0--
