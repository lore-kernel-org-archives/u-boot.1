Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9059BD78322
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 13:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEBAC890BC;
	Mon,  2 Dec 2024 14:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XgB7OqFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41F18910C; Mon,  2 Dec 2024 14:39:40 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4247890BC
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 14:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6ef4a03052cso39903917b3.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733146778; x=1733751578; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sphGoItoG6ify7Rr3Nek8Cma/kKF09/eIg0JDvu9Tto=;
 b=XgB7OqFeC9y5XfO5mIotKPuJ34pDqzKdyNeH5ej6pJu6mPmOqNmlCm1WSwk2Rg8sK+
 nd44ikXTQvRJ6JXZfHTst/6r5ThUJIPQO14PLwlgnEoEwEWFz5PCQvwEloA6ZIu2eVO2
 IVjw6DTHC1om7P3V6TXNyv0n95bjbW2BSeAGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733146778; x=1733751578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sphGoItoG6ify7Rr3Nek8Cma/kKF09/eIg0JDvu9Tto=;
 b=sPHTscImhIXFrjKzNAXdYTR1//US71kWxOfRNNVppbV8II3r47PEdpy7c0YA/+Dl1I
 bKtAYgVC83k7grtFwtF8JhMmT0zieODQlkSvIWilEh72IIfSJTfvrxyujKMcARf7oCj4
 JrZ2I4LpQngh7bJ94MyumHfy6iX5nF/21NH9Su/vyBm9fqA8nVb6dw76tIeQ4USokTmC
 NJ87+AiRxUqypHTo+PVMVahbgKYA7YU3eQGQvTbwAcq/AiQnLaTyiQwaD7zzOy1fPwK+
 0UrYSSkoDcnZeC1SzFoD3LTM7iGA84J43hngfx4i165DakqtCZjgzWpbOpijOkzLULS/
 Ot0g==
X-Gm-Message-State: AOJu0Ywh+OTgI6yru8oNlPWtuk+dYhUMrSHY96XwQ6dApb9W6N+sJy20
 urZx5ypRuI8eEqrY4MwVMIBrSterjICUCyZpKP9ghXUHU88mRkSVpLb4Qt6V5mE=
X-Gm-Gg: ASbGnctZD+LLM+EyOFIXeB8cDCItaULhyjZ7SHY2w84ltV9mKVtBf+2PJ2PEgsnx/75
 e3IoQwB1DEdU+/QjrnpEpxXDye+TAH3A+TE2SSUgzsmLz5pVHlJpgbw2LHgM89MFkPTpObZnePx
 nlTDnPeA8k6jKhnt6vcwj8HC7C72VfIGOIpY/FnAO3qLPhFZ8iwwJIfUi+dixshCTzTka1sseKG
 u2AqJO8nFRbqK1Uu7LpihE6bA+pnYodeHtcQ9nUbztuiGOcFA==
X-Google-Smtp-Source: AGHT+IEnczmFKfGq9MrYXnLYidrsns/+liDmEVyVm+dmf14q3F40PhRLNEYSDOSyStVBRAQkbdabqA==
X-Received: by 2002:a05:690c:6306:b0:6ef:7dde:bdef with SMTP id
 00721157ae682-6ef7ddec1f3mr71804317b3.23.1733146777744; 
 Mon, 02 Dec 2024 05:39:37 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8a3d2008bsm14616306d6.39.2024.12.02.05.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:39:37 -0800 (PST)
Date: Mon, 2 Dec 2024 07:39:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 8/8] CI: Drop broken boards from sjg lab
Message-ID: <20241202133934.GC2457179@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y7ufRZ6qBhUhT8qg"
Content-Disposition: inline
In-Reply-To: <20241201144240.1664398-9-sjg@chromium.org>
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


--y7ufRZ6qBhUhT8qg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 07:42:36AM -0700, Simon Glass wrote:

> Some of the boards have developed problems since the last passing run.
>=20
> Disable these while diagnosis is ongoing.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I'd rather not merge this since we don't need to pass or run this stage
by default.

--=20
Tom

--y7ufRZ6qBhUhT8qg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdNuJYACgkQFHw5/5Y0
tyzRnwwAgkVaVDueFy+7iBPdTXwiMOrtlthLt+6ahmSJsrRwQ5sZxr4nmPdiYpzh
fADmK/JRxwMJNtL2u5L6esqpT+uWb+tY7xIfFqMqBVPMFVX1YqnJikHlLknfxHNI
WQ9wRQ+K3ia9BV+/xVuIbsautcunlgeODFzwRdOssvNp+/eiX1GGRT6TsrUatq8n
45xgtz71IIpESWDpXtTeKhjH5d9f1TBRAzX8Ge4hl+atAjwJlkCxwvxbuZ3F2ELa
LaTnPZaUsXKBjdGckdlkVRKuT9WHVHP9uhWWPJ+RY1R/pZ9838CIpIZULtEURY0k
iPANn7xeIPWt4Tzhd/PMsJXAwu0sLEp3MK+iHmIdxhpT3DYAH9lvPCuYyr92xIYH
UFG/nweNKWP7C0llWidze2bJ0EpK/WjLDJAqRmFfkpLZSBMOC52fZ8r62y3X/Z6G
hhcZL09JfTGwOs2jPA2pG12BVMyhDd+ZU80/OEs1RHZOAUhc5w27BtezjdMhniiz
/cFSG8Mq
=6g5Q
-----END PGP SIGNATURE-----

--y7ufRZ6qBhUhT8qg--
