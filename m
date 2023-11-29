Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D11C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 16:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602E187766;
	Wed, 29 Nov 2023 17:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fw6NHrwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4026D87747; Wed, 29 Nov 2023 17:57:54 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 345D387638
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-db498e1132bso4149614276.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701277071; x=1701881871; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m3Hw1CA0ioOtECP1U485CjWhH6meeLeSaKjaHFeDciU=;
 b=Fw6NHrwuzYCnLrVr4wfH0M8fOb1dF0iafTdP9xutn6pw/XTUuVsFbsFcOKTkqNevho
 rnL5IUXBOm/iHP/d3/wMUXr/hyyilncTNTQNgTtADTyixUtAXDOCNT/yCYXnbk3PrlQf
 q89ynWjvotl0uMXOGhd6UX/8hOrz//GzYQ3b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277071; x=1701881871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3Hw1CA0ioOtECP1U485CjWhH6meeLeSaKjaHFeDciU=;
 b=WMbgA4UKBg88ZGMrxG96GUTVTVy6HSf+I3QMVrXceCcm1RSb4FTQi9990mfjE7R/cG
 fz/Q/L714qzqlvAJFAGvdU3vK2mjR8t6qPozeHlUJVvWcvUjOTLaXDTQIavG0iZBUW/k
 1oqlbAw3Q8vnQfuQs1hsxE5HWrZUjfcAG8mi2drR35hA07QoSgWZqeGG4AXXMAktkseJ
 SVi41dunP25DijKju1XCegqub5cS3zjYtZhYAj3wHf+0KrTDfXAV3xXGhSGD0UyiZxut
 kZovf2h+oCDy5Y3cmW3JBYaXfzD1RiBaP1GWl3VtRoQ7KVxitbWjv4PMJ7eJaC3cN6NX
 lM/A==
X-Gm-Message-State: AOJu0YzVoNlkKNrdC/4elndf5MtaAEWca8R93yJ65Qsg2p9xuQvPD6oB
 7FHpUYFZcKTX8poAwfRmuh/wFA==
X-Google-Smtp-Source: AGHT+IG5KAIWdr6D0zzMTCVl0lMHdy2WnbyzpcM2KI6hx4TPzCc7yxMjJja45gab9lQT/rbEwYgeMg==
X-Received: by 2002:a25:a4c7:0:b0:db5:31f9:f944 with SMTP id
 g65-20020a25a4c7000000b00db531f9f944mr989269ybi.47.1701277070989; 
 Wed, 29 Nov 2023 08:57:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 p132-20020a25d88a000000b00d8674371317sm4301972ybg.36.2023.11.29.08.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:57:50 -0800 (PST)
Date: Wed, 29 Nov 2023 11:57:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Joel Peshkin <joel.peshkin@broadcom.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] Fix stack-protector for powerpc
Message-ID: <20231129165748.GJ2513409@bill-the-cat>
References: <cfd28ccf2ae6db320afd8d4542c57db0c12fca42.1700045185.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BL8zmQXERXsGFSZr"
Content-Disposition: inline
In-Reply-To: <cfd28ccf2ae6db320afd8d4542c57db0c12fca42.1700045185.git.christophe.leroy@csgroup.eu>
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


--BL8zmQXERXsGFSZr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 07:36:36PM +0100, Christophe Leroy wrote:

> On powerpc, stack protector expects a function called
> __stack_chk_fail_local() instead of __stack_chk_fail()
>=20
> And some versions of GCC for powerpc default to TLS canary
> instead of global canary, so always force GCC to use global
> canary with -mstack-protector-guard=3Dglobal
>=20
> Cc: Joel Peshkin <joel.peshkin@broadcom.com>
> Fixes: 4e9bce12432 ("Add support for stack-protector")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Applied to u-boot/next, thanks!

--=20
Tom

--BL8zmQXERXsGFSZr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnbYwACgkQFHw5/5Y0
tyxa/wv+PlwFhFF9C2q9V8RVgSHMC+zjbMgqm/mdBzWwbHcvJjULAWzCRBdsNKXy
pMQmoDUsnXmsm3acTdxMVQ0HhPeGtwoHiouO+qEk0G8tinaAJpcOVl8quRvt5DGn
mE9npFxAGm3o0bOqtPmSyQGOgU5tyWGL9B9hf4MmzL8z807R5H4PtGlB2nHRTqre
8kVz0nYc8kITNVpPJg+1gKAhKApR1d12vbQ8jKseJCZN0MYkb0dsvKlk3oWru+nk
6YucM/WKRtM5Ls13NkLOY3XmnOpTVqkaB91YDsIa8xsiaDIlbglmGNZfZqAHhF4x
88aOvGCwgB/Lst9E6LRoeQ52ysPO2gMu0/lFaAxSsI/ZQRnxDJUzZsEGLvblTGSI
HLnVNMosmZdBce/3kxXQX9lfWFwCK5MVBFuqpIrK3P2OJdU74QxoyKUiXqKBuKnF
ioczShduC767XPEgVAtk8dnyXAXzNQ+K1A6ogIo0UuEh43USTPmibAwx48uoY2B8
+9Gva7O9
=HQtJ
-----END PGP SIGNATURE-----

--BL8zmQXERXsGFSZr--
