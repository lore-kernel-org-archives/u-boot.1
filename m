Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DECEC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8958803E;
	Mon,  4 Mar 2024 16:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SGtDBtkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D008803B; Mon,  4 Mar 2024 16:28:07 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677DE88028
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-42efbc18f2fso700381cf.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566084; x=1710170884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zJMXEFZZt97zhvB5RdD9x0TXK/jVVhx2wZBTXwuMWqg=;
 b=SGtDBtkCwCFj8rBl7GGqULAg8uOWeMKyGhgBqXABfHlZoCyE+cYM2yi208nDvc1pC2
 S354XjSD2TVP7JDru652LtrM+o0gizk0i6PGQ44d9JzZIpzTrRFnPbiL1pXc+sUghU8W
 eb08kWpisfhjR4aCiwLNxoYl2c8LG0XQFysEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566084; x=1710170884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJMXEFZZt97zhvB5RdD9x0TXK/jVVhx2wZBTXwuMWqg=;
 b=jqrrwAhyWGN+BCk684ieDckDmaAIvrWuWwL1XqgzafIaHAI/DG1FhMagYzGyeBiARi
 weQmbeg9ODKCrdHO4kLeIZeJ6VjdYqlWW40E7g4ctrYhQV7W/WXTBYP3D4ipYtQ4YDuF
 97y3W0axhKdf4wUUklYdaOwywqPpNl/XDDZpF8Lws5XGb3uFldLYakwlVJpiRMM/QYFb
 az/PcPNRB6wgTiWon+UwAaxrC2Wb9T+J5xPjGo1XOlynVwYNI283wrMu7J2YH6so0b9k
 dobTsa1oHMIlIEBbTc4G+bXZxSQhCShIyfugUnqb3lleUP7aQgz4Dcw/n1h7snCkSpkK
 UYOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoomgnrAeZuxWl4/6e9Gcko5pSTYpvwmeveceKW3kpnFE3LbW6MgQ+GMZDKex1kfbO7wiMXDj3tjhHIWA0mRHZUEq3Og==
X-Gm-Message-State: AOJu0Yx8IPOWs0Q8hRX0SrgbkozRGGzvTCoZ9j3FD0qh46Hh1Vj7Mo3Y
 6t8uHyRqWs7eI5KOZsOeb1yRfhIWO1t2I3B1AFDU/uyHVTDqgo3G3LZr3v6ibYg=
X-Google-Smtp-Source: AGHT+IHytKW3gkDWWU/M4e8MRQtzR+tmXXBzrNjDWsZw86EPYRj+H3shllVPW35EMXOlCa6TtXyIOw==
X-Received: by 2002:ac8:5b84:0:b0:42e:ed66:9dfb with SMTP id
 a4-20020ac85b84000000b0042eed669dfbmr5994567qta.22.1709566084268; 
 Mon, 04 Mar 2024 07:28:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 z10-20020ac86b8a000000b0042eefc8614fsm1174635qts.83.2024.03.04.07.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:03 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: remove common.h from exception command
 implementations
Message-ID: <20240304152801.GY1523872@bill-the-cat>
References: <20240212165329.17847-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H/pWImD65XtUKsRo"
Content-Disposition: inline
In-Reply-To: <20240212165329.17847-1-heinrich.schuchardt@canonical.com>
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


--H/pWImD65XtUKsRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 05:53:29PM +0100, Heinrich Schuchardt wrote:

> The common.h should not be used anymore.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--H/pWImD65XtUKsRo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6IEACgkQFHw5/5Y0
tyztawwApwNp0Ntle4CQgjummeDKN5EQRZacDf/GsSYuCts492C97e0LIhCsmjLH
qZWK8sFABEjAaCXDrZH/+gtKa4nGdPPXkptzhO7NMtWfqbmf2nAltsDh9F9hBvPK
gmQsVwJIcHLQ/nBmsniiPa1OiGwmrI5DcbEt+Y4cz/87z0rsLojrGur0OL5nbGAB
i52+QoKw3VO8WEln3AJlp1z3t1QxK7N/BEv+Dl1Sm/C6MH4O/Yjlb3pZlTMOi9d7
4qFOuccws4Cqp4Bo5cv/iwsf/8NGA7A6hAZqKzwB+xhF3XiYpFJBqC2LzikrM1bS
CM/RQvNuyi/slzu3iFqeR3t7FFAD50agZhY6NxawOfcIDHcGflo/Y/1HzEJgJexH
H0yINhUErF0BUPQLG2mfFVFgGFrmxCnNMz5s5BKkFIaoWVAghGUmZETghc3aW7qG
jlgAqRQHSCnzddw3en53Qu2OS52Bk/V3pEqe+EuTS/O15iCILvWPw/roHfPJhZ99
kVOxtJ8f
=8kJU
-----END PGP SIGNATURE-----

--H/pWImD65XtUKsRo--
