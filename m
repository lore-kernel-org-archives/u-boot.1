Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CB3C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7DC8679F;
	Thu, 31 Aug 2023 18:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mFZ/3JMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05CB08667A; Thu, 31 Aug 2023 18:27:05 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 466F7867D2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-591ba8bd094so11886517b3.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499221; x=1694104021; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rHW2trNyHlBBJFkcjuR85ox3odzoTCcwSLVr5Xge0o4=;
 b=mFZ/3JMcrXL2bB39q4c0BmVbFg8idb7Pwu9CSR8ClNKEkge3SVjn8Z+FD57ithy1H4
 Pbdr2/ZbROu6w3hdAmWprBvxQwaUn+HSVhUQlOIRshaT3yjJn1R5tiYUoCkYvenmh2IN
 OoZi+IQ7ZBVPWNgY5+Jxh2NyAg6jC1fOFeHxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499221; x=1694104021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHW2trNyHlBBJFkcjuR85ox3odzoTCcwSLVr5Xge0o4=;
 b=CK81hTxtE4IF9cWt2UCEQi8h2eDnyyeuDdsoVKWcjliRURhWQ6S+pCx+qEN0ijrTCQ
 uLng250aBceK8lakWsKl6tHVE8Aeb5LUUyipEydL95Ru7942rblhr8DQc9RDt9EEE3Fs
 4OReCVE24xG0dw2ZuWFoqGc+NSKcnkSnROA3zcGBXPJ7vG7l4uxrDmL1OTdYdJhRvD8U
 YNCHwAAYUZ8XvfRnTECo9lCjUctQDDstOVHpdyQRCwW7lmuYV6lyXZeV5tnkF1WEMKRd
 S08LIdJWj2SCgQMgEuMtOV/AQbBTvj5ILWlceTUzDxMQM1AXAI70RbaaeRbH/hDop4rl
 raKw==
X-Gm-Message-State: AOJu0YzIQc+tARL3YfHilOekKsl+tbNcvp7LhGNkVotjoXTcqQbYr6nA
 yp2LbIkA1JexcIxij4M2wx9I/DdwHQrfF7T3UjJBmA==
X-Google-Smtp-Source: AGHT+IHQLMmBlZAk5oIrVOadUmvwx3Fs9uf9ctXBvksCoxup35wb3E9IWIm03RNFYMwaGZ9GKGXvKg==
X-Received: by 2002:a81:5fc3:0:b0:594:f864:8507 with SMTP id
 t186-20020a815fc3000000b00594f8648507mr5401829ywb.51.1693499220962; 
 Thu, 31 Aug 2023 09:27:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 w198-20020a8149cf000000b00577139f85dfsm505805ywa.22.2023.08.31.09.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:27:00 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] fwu: Initialize global fwu library state during CI test
Message-ID: <20230831162658.GK3101304@bill-the-cat>
References: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q9h9O4mjvikF7r7d"
Content-Disposition: inline
In-Reply-To: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
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


--q9h9O4mjvikF7r7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:16:52AM +0200, Marek Vasut wrote:

> The current CI test worked by sheer luck, the g_dev global pointer
> in the fwu library was never initialized and the test equally well
> failed on sandbox64. Trigger the main loop in sandbox tests too to
> initialize that global state, and move the sandbox specific exit
> from fwu_boottime_checks after g_dev is initialized.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--q9h9O4mjvikF7r7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwv1IACgkQFHw5/5Y0
tyzfvwv8DiRvnd8PABv/HH6NMOVsaWB8XMPZz/ubXo0YMntibfrnuSbkchiLA/d0
+1r6vdOp70VI4BMnEj/R7rRywyVldsEHPdYEIbjjYoKkgzYpLSttz2JLncgcmSjT
vzgWN4RtOJUVnKY8pU9gyq6DKNuzwx9xQhY1NZwmabVE0HQvt5EYXm3ZvIq8KZQJ
sCtb/mXIwP2fTyyJXmotizk7YVwDuVoDqxKmAWYQP46RDrWZbCfTCXinRFrW/snU
jYpuO9+4YO2nqa0NOqYaLkWSrmf0fSPdm2RnK08LW4ebOgi6AxKaHWsUqhe9Sp+c
+ZFo1b4J6bAxJtWLHiqf8WWkPtN6t3qm1gBwJ7NiT4DKlNkj6oI2tgjTgU4B9F3y
NZM2PtM/fvRccoP2rEMMw+G8GdIp3Iyh1F6ZcQjESIxnMPd2Q8DMOoMGX6NDR2k2
wIoa27Un0jqAf5PCbsBnGucKuTrWszmFUbIQ64vdaBlZL1YFPCBzw8uBLHKdvua+
S/aRnk8i
=OSiB
-----END PGP SIGNATURE-----

--q9h9O4mjvikF7r7d--
