Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FFAC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE13287B1A;
	Thu, 14 Dec 2023 18:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GyO4Qe9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B082887B1A; Thu, 14 Dec 2023 18:54:08 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF38587B17
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dbcd0928530so2067345276.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576444; x=1703181244; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BCzrcjnbXtbjmx6SYYcUi1EJ3OGsmfpDXynbpH+ADNQ=;
 b=GyO4Qe9tlfy5YLsIiJkCLmNFHWkypvVOtHI7SO2gpuStOaTSJeDBsm4tyTqUtAx/l8
 EofQvv41Ay+ZHnZXV+HdKfTSrICx+k/dmvVolSS+Efcw3SGbhM0ATUeL7j5uEnVAGLUF
 TK1ZhDC5UImAbajI7A6VvrExVJBHI8IGu+uPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576444; x=1703181244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCzrcjnbXtbjmx6SYYcUi1EJ3OGsmfpDXynbpH+ADNQ=;
 b=hR9LEYlaQywL/7xQ0wBTcNVMn/9wl5CeXDdZEIVX5YPEEExvJljpEvLhE9MQDKg1Ck
 7niTRv+wCwSMbaZpWeFNunDgkcJl+V2snav397uqhnTixPWIC2W2UCTk0KOerIbUEay5
 CtyaLhHjN16cOfPOYzh7XGkGIkifCgbCA7bVHWWVwVGZkgw/SGV69mNoI8X234xcmt9d
 q3TMT6rM4G5EmauAOtypG0saN/dU6i6g9SYUsqitfLi7RZwrILtJp4cLFOXKJE6mNljy
 rC5jJTFsxm3IL5WCEH248Y43kktFN4ToVGtKxbfWjY2Y+h7R8XayWe+vaeKqWBlH3eJL
 6TbQ==
X-Gm-Message-State: AOJu0Yy4II/VbMEa9WHRy7rvQsA5x5GMNdxuimJetRcIC4LWrkXjqGyN
 xMy9zn9t8376hjrCE1CJcw9Me+r2NOXbLG2jtn4=
X-Google-Smtp-Source: AGHT+IHmCCiZ20XdCdGxS2LM97HW619KnpSqt9spFr8jxkEzVSEAXcVm0xKQR7YhjiwkRtx5eyZuaA==
X-Received: by 2002:a25:b90f:0:b0:db5:3eab:b4ad with SMTP id
 x15-20020a25b90f000000b00db53eabb4admr6659651ybj.12.1702576444689; 
 Thu, 14 Dec 2023 09:54:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a25e312000000b00da05d771097sm4811058ybd.22.2023.12.14.09.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:54:04 -0800 (PST)
Date: Thu, 14 Dec 2023 12:54:02 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Haijun Qin <qinhaijun@eswincomputing.com>
Subject: Re: [PATCH] lib: rsa: Print detailed error info in rsa_engine_init()
 on engine resolution failure
Message-ID: <20231214175402.GN2513409@bill-the-cat>
References: <20231214165416.35354-1-csokas.bence@prolan.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uq2a87ybNSra/sj2"
Content-Disposition: inline
In-Reply-To: <20231214165416.35354-1-csokas.bence@prolan.hu>
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


--uq2a87ybNSra/sj2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 05:54:17PM +0100, Cs=F3k=E1s Bence wrote:

> Signed-off-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uq2a87ybNSra/sj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QToACgkQFHw5/5Y0
tyzLgAv8DIRkH+RZT9oufxFo39zmyv5IlnEYsfyBz2gDIODNx17bOGJhAZACRuPq
C+oeGTjLxB9QC1pKjlXYzxSui4PuuNqnn0D5lfMvfHxrtaoqJsun9Ylk0tXtyTgH
OG6BEVJNUHGTyUqCeznrke6zM2HBQ9v3BiimmyZ9YQAHYssw44WdWyGKuOj+iAo+
tdH28gym0MP+lG/qvHVLyDuADjn0pjVnqAS4jmTZHT2VlPZOWRdnDKp8UTPu7kpG
ghU5DlbW5SFfXeStry0cETPabMe8cx6KtZ6tgVJDQFIwnpZn/IbeSx98x5t7Ak5x
3Vg/7UTHKxCltRpJG4IVoTbRL7UDinVnbc2DtZytykHxWHzuw/E2TCFQIFAIfcfk
MB1cvNxnsIFOoNiny//3wPQpU4nYAcSs8KZ2c/pelekFfobSlt15wirQcmPgrZmS
l203xa1QA9PociehPFDGhQ3xTeu7guLKu9N6C4OVB+802rUlOnybXvJ17ONt2Z6X
lSHo4BiV
=ztc0
-----END PGP SIGNATURE-----

--uq2a87ybNSra/sj2--
