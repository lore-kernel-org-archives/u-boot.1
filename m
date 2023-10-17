Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D0BCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8A986BB4;
	Tue, 17 Oct 2023 16:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="THlNjH3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C127586C6E; Tue, 17 Oct 2023 16:05:23 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA1E803AC
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a8628e54d4so22687547b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697551520; x=1698156320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xDAx18ncvdS5qT6GJ/41/jxyCuifOsafefJ8EHzcnNA=;
 b=THlNjH3BdneD2IkfZkJe1XJn1l9v31r15gQvpMttFYRdUn4po8PhZr1DrTTw0SiBN5
 4QpINdRXPCUTeXwg8yUPUSmXduGSqZEFJWY09UiqjBkNmqw3xbq7HlppeggRE7305Htm
 KnljNTihx9ELtPp83W2TrlrgYn87ntsW70MiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551520; x=1698156320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDAx18ncvdS5qT6GJ/41/jxyCuifOsafefJ8EHzcnNA=;
 b=T57UjxTLHn7Ad4J61jsU1OPTuWPHtP0mna7RPiZozvpAmIcSaztPIm7uTmI8ywU8LH
 +Esq/hQuylz3NU6xYOZ0XXlTmNSa9iZPgbPNlOgAinkrSAx/SGUl0vSZeszvoc4NYFZZ
 hVCbzZ6J4V8NAT9oWc9rXaOZiefpmYt+By0QMjoA/7hddNcWkUsxXovNm0TRab62zkro
 yYge0PzsGrPje31gNced31ksIZ80UqKo4nEdh9jbOdd92nPq173XOWZj80VwR3k/rciP
 IZ7gBh8XhUCTCkbCe4bl6PkYv3487Vvl91vT2rFC4J0nixcHrq1F4rE4FY0NiOK7l2g2
 mGvg==
X-Gm-Message-State: AOJu0Yw+ye1wI09IkRUpEHEYQR9ZOc0ThIgai5RfPnNanZth+kFMURHx
 2S5piAJgR8VdFx01UeBete2GU9raikOfyDiJBrKemw==
X-Google-Smtp-Source: AGHT+IF4IazxgHjwsUbTWRTM54KF2kqcZEyZh0z7C87AQCd/SebIsX4D+h325QnCAnsBV2Cp909zPg==
X-Received: by 2002:a05:690c:113:b0:5a7:be3f:c451 with SMTP id
 bd19-20020a05690c011300b005a7be3fc451mr1415946ywb.3.1697551520319; 
 Tue, 17 Oct 2023 07:05:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 a197-20020a0dd8ce000000b0059bc0d766f8sm637655ywe.34.2023.10.17.07.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:05:19 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:05:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 17/32] log: Allow use without CONFIG_CMDLINE
Message-ID: <20231017140518.GY3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="27iv314B8EfvLMN6"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-18-sjg@chromium.org>
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


--27iv314B8EfvLMN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:08PM -0600, Simon Glass wrote:

> When CONFIG_SYS_CBSIZE is not used we need an alternative. For logging
> it seems that CONFIG_SYS_PBSIZE is a better choice anyway, so update
> this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--27iv314B8EfvLMN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUulJ0ACgkQFHw5/5Y0
tyzNQgwAnBwnJ90H3WoI7F1BO3SUDQZVAfsukOFm5kk8+k1uvc2MGoFKZjN/Yk7E
b0tPZtTrn4+DiNHn3w/N+IrLWE3qFuvPezqN4GQQbNbdgCIo6A7gEEVP1RH38SCX
m/AnILP5JHyaKXaJbsWDd1sUtAK0YMyue8lujHBoFOHZmhYbsVpZ9iUnU59az91C
TLiVKwyYxlVwWJRzEuZZAF0FXMkUz3t+rjfTbboP5gJgsJbeaodcWBaWljIsnukm
0/8C6jprL2C9dFookmSTqV/IeWpiQKWclu+3mxoaIY/WPKVejQ8bcUEKPuvmzj5m
MvdAv3Ydt3Q+BC38y5Xkg2nPp8mIpqutygun5ckDhKc/yJLBM+eX9f1keUXmpkN5
Blpuw0cigBe18HMdrgFd6xFuVwIwbEz14z1zFn9WYAlmp8PCcwa3UJ8GN6l7Crol
vwhSPSOgmpJtFHxAOn/a9Uo5Gdb6j+L+4a7jYe7RppRIahLwW2DqRx/+c+FAb/18
/nZiyU4W
=RT+7
-----END PGP SIGNATURE-----

--27iv314B8EfvLMN6--
