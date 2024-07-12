Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88439C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 451BB887CE;
	Fri, 12 Jul 2024 18:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ADwUYtx4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01998875D; Fri, 12 Jul 2024 18:48:15 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97BFD887E2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d9dfc7c5f6so1001324b6e.0
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720802892; x=1721407692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7eYw5nlU0mrWjxg1F6KA7wMNTtNIcKYlmh4JBevRNqs=;
 b=ADwUYtx4MkCbquyTEJet+anFg3POyJlYtSrl3UBiaLQ/RgKJkMDwvOQ/nrexki+TCM
 j7ixVrXcSvuAmKwmZrLxr1wjNggUvWWP1diNGFw1LqS4WTuEqKyhZR1OHoZh87sn1x1R
 VyPanG43jrRy/1AG8vDRz0qvz0suPHG9uRvDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720802892; x=1721407692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eYw5nlU0mrWjxg1F6KA7wMNTtNIcKYlmh4JBevRNqs=;
 b=rK7pFmT5Lj5Yc/WecNBGmmEbuJYuwXiIjCTz50n8DF3PJLYP0USVdVIbQX08cjNZth
 M2IIwL4BHFkEO/OPdztt5GN09SKgrq8DBQb1LCOtJIzwYmpMVsVMnZG+0CW44Krrzq56
 RT+7HRWqQTm++p8q6QO4a/szPplZRWxn3+L+NJaPHKuv2cwSRTnH+7MB/u45bdCOaAQs
 5NCUSGOnaAPWgQpsny6rwTgvo2UXYvIx9Ur7olk8wlBvV+jawM0LQPeMCNeI4d3aSuJ+
 yY8f2O7t6xtQssXhSDUhiyIwMRpfMxPxImbc2UQg3gRMMnqUSr/3DycO9tpc5hnHGYfb
 ChnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+56okUO7LIVKiGKDM4PXuXvLs/dd1Y/iaOdPsvh2ZnRGS0NmtqB8ym2pMexlCiA0mz/iJLi5y5Jr6gq67qXBJF4YynQ==
X-Gm-Message-State: AOJu0YySwk9Bhd3SL3jH6DRnf8rC2pzH6sTZOmOA3gAqgy7g0A26ZiC+
 pbeLN6OJDcBGG/sFvzTEOqwz3mlqYa4gWgYkT63vOTxGk8nC89hSx9xTHU9Zy5Y=
X-Google-Smtp-Source: AGHT+IEHSKECA5m21KBv+FK5Y9YKKdfduFJxmgmMT8zcthKIgP6mvBYrN/g+DVLozLZc3a9upITyPw==
X-Received: by 2002:a05:6870:7251:b0:25d:fef8:ac0a with SMTP id
 586e51a60fabf-25eae88c8f6mr10647597fac.30.1720802892403; 
 Fri, 12 Jul 2024 09:48:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25ea9f8fce4sm2313157fac.8.2024.07.12.09.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:48:12 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:48:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 0/3] ARM64: add symbol name lookup and print a
 backtrace on exception
Message-ID: <20240712164809.GV38804@bill-the-cat>
References: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e2nmZAVda9bDR0LD"
Content-Disposition: inline
In-Reply-To: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
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


--e2nmZAVda9bDR0LD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 06:26:17PM +0200, Caleb Connolly wrote:

> U-Boot already emits frame pointers on ARM64, but lacks the code to
> parse them, as well as a mechanism for looking up symbol names at
> runtime.
>=20
> There was some (seemingly?) leftover code for symbols lookups in
> common/kallsyms.c and associated parts in the makefile, however it
> appears to be entirely unused and unsupported. It relied on generating
> one long string of all symbol addresses and names.
>=20
> The approach taken here is instead largely based on the implementation
> in the Xen hypervisor, it performs basic compression using non-ASCII
> bytes to tokenize repeated string segments which can later be expanded
> back out at runtime.
>=20
> This is then utilized in the ARM64 interrupt handling routine to dump a
> backtrace in the show_regs() debug function. As well as providing a
> general purpose unwind_stack() function which can be used for debugging.

Just a few minor comments from me in general, and I'm glad to see this.
Please submit the next version non-RFC, thanks.

--=20
Tom

--e2nmZAVda9bDR0LD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRXkkACgkQFHw5/5Y0
tyxrrAwAoMZU5OwzZrXxuPbAv/xj6jCFc/p6a8X4Mf2DtLRrKfNXnAWJtDI9Ol+S
eJADLiMMCTLB/+r0CIjqNiWRTrs09Uf7UJ6GG08rd6uDyv+rHAGM3gtaDX34ECnF
AP1mcYiGqU5/ZmqdIkduACW2680bEzTp4y14Osv60AfCQvOUdlNSDV9t65wImLJ5
IYn9jSgsNkgbvSGlaszrUKj8qAaStOkXf864jB8Gyes3pN/3ycdFkIwo9TL1MyE/
lok8o/V9zy/Z/TDObCyBXWjqYhYp5Bk9504XzJruuaLo/V1COFGWphvYPOJ458B/
Gl6ED5E6hbYN/jR4zO3dksutMaeiofgrKWcHJ97JXkd3ZocMma3ITNE33zAbbM2T
qiBtOsMpGVhvbwSdj2adDupujNLC768z9vsYm0ruHu1M/kvKyx0offKBvHzJ5nTo
TRMImf1+hIHGaup6pOE39JtsK1dfE+rr1KT/hfvNOuYAbc2WhBBKSC4Bl9PJaopd
A7vtkWlj
=3C3k
-----END PGP SIGNATURE-----

--e2nmZAVda9bDR0LD--
