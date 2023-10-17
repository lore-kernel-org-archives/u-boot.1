Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4202CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 298E986BA1;
	Tue, 17 Oct 2023 16:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sEwJ/2Z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBB486BB4; Tue, 17 Oct 2023 16:11:10 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD1B2803AC
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a84204e7aeso40110487b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697551867; x=1698156667; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FjR9PFDiF7Zi7x7QuJCFL6FDPle1VEd0Pghps31yn5U=;
 b=sEwJ/2Z/+NhOT1JsHYChYsbvd2Ug8gcJ1d/OVfWMLlZ0uXYV0gtYcEGAWgdz+fE+dv
 wU3T8ERsKGUv0R53afMaGSHQQ/eIcygdFIwyaavMmLKprS1zC8ij69HycPTPOLLurIFq
 n0yoRtvicFOkkicP+WFqxoP7sWJNf/nu+liOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551867; x=1698156667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjR9PFDiF7Zi7x7QuJCFL6FDPle1VEd0Pghps31yn5U=;
 b=t7hl1Hc5iU5/jQQrHGoN7sSdNaKbeFzJsl0FxdwVcqRVqCUCom/ReiD7CscdCgoIWC
 ZHXpi1sicGNpfKmdexCizQ5mMCqxEC357DBvS7tPdLz2QKga41p6zByh/lQMwqCUhPpt
 KaOW/J61b6+oiuBsmwkiwrKfJEWf1ifvxFGNiSHoDlMLXwbqqVduUQD8+pn3rPWYC7jM
 Kd4qSMeBRxUzeM7o8mxvYMu1LPsaqk2PbhtwsLTcwiXpnZldHckJKeGiIX766cOhb4Su
 58gd64LTLrkNf5Zr0DIN0oXRvUQqpWbA2iIs1cPGTNkJZ66PwUcRZnBfK2pwondOjSQ3
 ecuA==
X-Gm-Message-State: AOJu0Yxj+1agYQ3EM+fsWZ45HdP7wZIQuFGqWiswAwinZeUQRVq2iwLm
 EopJNu3KVS4UXaorUP0Rhi0aQg==
X-Google-Smtp-Source: AGHT+IFhRNPu2h8XZXhry/fhov2lRNcKv6AXiMv84sv/kHRRWw5sqT3jLRv5s1emQpgdPsWJFR5Azg==
X-Received: by 2002:a81:a214:0:b0:5a8:19b0:513f with SMTP id
 w20-20020a81a214000000b005a819b0513fmr2869587ywg.14.1697551867653; 
 Tue, 17 Oct 2023 07:11:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 w66-20020a0dd445000000b005a7cc149e3asm640927ywd.2.2023.10.17.07.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:11:07 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:11:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 32/32] sandbox: Add a test for disabling CONFIG_CMDLINE
Message-ID: <20231017141105.GC3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-33-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="auAsFrbv91RuLXEl"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-33-sjg@chromium.org>
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


--auAsFrbv91RuLXEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:23PM -0600, Simon Glass wrote:

> Now that everything is working, add a test to make sure that this
> builds correctly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--auAsFrbv91RuLXEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUulfkACgkQFHw5/5Y0
tywR/Qv/bdkpdFyNKbdMbJhWlkwnTGeDX4tqovemn00P58tYSwYqI6B8UpV//46q
DpTx9GFQCvBJGjG7DSA1Mvi7HCiMY1NNXhMDlwrDJRa8VwLuG1a0OL+yxMkj7isE
wh2hNFE0u3X9sOAWE3/3dhF0AK4mrJpq+ZiznV0SkP0zXexy9VMHbuL/yKpkCahc
ojDmCM8pe+eodMGbWQU0YOIa8o/7SZhrFQdAigq0bJ+vaHvvrrqQciFQFbCM+Drk
MKfU3wwpUECW7hAk/mzflzO8LIdCuu2/7C6Iqv/qqJq7f7ND+O4GnQTXd+H62fUp
gkF6w3IBzuHJMsUxdaaby+/T5VL9Mlg2nCoKbrkWahiJBY/p/jk8D18Vwyt4adYe
9zKmErjj/inHAiyOS0fQmReGUKT8Rq6fnm3gS/NrHY3GVpUkRjyEBI+gfgzArFM7
whYaeJ1ZwjOuDH41R451blXqtjOy8QeM88RVM/FfVjg3L+FW59SZ7e7FGIzc6qWo
iQL8a0Mf
=Oim6
-----END PGP SIGNATURE-----

--auAsFrbv91RuLXEl--
