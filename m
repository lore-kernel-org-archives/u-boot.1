Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99472C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C29CF87D10;
	Fri, 19 Jan 2024 17:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qDdDjzkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505AA87CE3; Fri, 19 Jan 2024 17:08:41 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D1187D23
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5ebca94cf74so9414857b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680517; x=1706285317; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+eGTO06nNbbQgV0iOkztzqAZSD1nzsmJAeYAoYLDVlI=;
 b=qDdDjzklVRfjTjEnp+OTtRxBgxn2w6bBv2XCJ7j/Etf8ckTDe4DtcH9d0tz/z4vidr
 0P36NW0K8kUXgRcutf6JJKKr3ZP+y++YuLrR9Y04QsQdidC9eaXqeyLiGevhFx/GYu1X
 ziibUNA4JN6AFRc3prsUA90Ek5p/auBK2cma4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680517; x=1706285317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eGTO06nNbbQgV0iOkztzqAZSD1nzsmJAeYAoYLDVlI=;
 b=OJdJpiHDeEPxjIyR0+N69itbwIGZapsqOXhGi27Vcs6bD013dJzJ5YvI5e94yCmz52
 kvZtaAEZXfRxI5zbC7m4TftXeLHA9pPVlCh/z5mr3eDasUJoolL44d/Ih/XFY4wtlTlA
 jHZVgI7flu2mnmNVySFCc7IJ+6Mmm2bA6dwxvvJK8cEi4KEK8UuxHf1Wntqo2K1ZupW+
 5ihkUA5zcGtBqCvMdL28RqgLfHKZXOqJzRUqEP4UTnNWHGpGoLPhvrjnO2GZZP84bGkn
 x5DGhGcJLV1YG91Wduw4o99MfJzCJHV6X+oHQuFAhGMsqHF5yeb5Ut7W7j3QQWWGNI/s
 JXKw==
X-Gm-Message-State: AOJu0YytqfKmvEhFaKQQyvsw/2iwM2GwWcknb5oTsScCHSbpKaElVbh+
 WNgMaJ0swfagctWtEvV0PSa35tb/FhkslePJqZtRXClBNS3fqYe0tFRxJLnvo/4=
X-Google-Smtp-Source: AGHT+IEJh0Ay3rCcZxBRlOdRgF7l9yzHt69DgfWw7pDja39wfgSoSyRnF4/OfbCOQlCUrFZY4O+hEQ==
X-Received: by 2002:a81:83ce:0:b0:5ff:9428:a8af with SMTP id
 t197-20020a8183ce000000b005ff9428a8afmr100300ywf.66.1705680517054; 
 Fri, 19 Jan 2024 08:08:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 b66-20020a0dd945000000b005ff9555c63asm968818ywe.110.2024.01.19.08.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:36 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd: bootflow: remove dead code in
 do_bootflow_cmdline()
Message-ID: <20240119160835.GO12635@bill-the-cat>
References: <20240111081433.178860-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+4BoFrfwBTb2KELt"
Content-Disposition: inline
In-Reply-To: <20240111081433.178860-1-heinrich.schuchardt@canonical.com>
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


--+4BoFrfwBTb2KELt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 09:14:33AM +0100, Heinrich Schuchardt wrote:

> Checking argc < 3 twice is redundant.
>=20
> Addresses-Coverity-ID: 477198 Logically dead code
> Fixes: 921f63e57238 ("bootflow: Allow setting a cmdline arg with no value=
")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--+4BoFrfwBTb2KELt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnoIACgkQFHw5/5Y0
tyyTrwwAhXO0rFz3KqckwwOBrpImGL0KEDk4QrO1b+4lYarsQ2EUWVBuC0W8GGHJ
0Sm3LF/2pkRJ9pvQNPWR4S0woJsaq2+96ttgTKx+rvZQBQhFNUMrFkF0CSw1mdst
Bnh4qiPBezss1pknq6KZYdKnNw7H/fsbQcmxkMoVs/p14zmYc0GU72uRE3rDyIC6
faNK+245JmwQnIr+fU6xV/pjw/HxegDXwr5MfpoyNaOJfLcOM5fMbGjDaZJbdKdj
XqEXkVOPURwy+Ctk6MWXeXbkfvOMTlsxy0m7wsmuPyCt+pmaUcvMYenK942hkhBN
PsSldbkjx++4Gp2ORC5agpN7sd52w1KN5t/qIXFfM+4l7w0IalWYMFws+rpKuoIK
AIjX4EshebvgU+WLcgHxX+QyIZrlleKReH1kqGwabgelJEsJE5G3HDV6XPHp+Hf2
XF1aTDU+eaWstH6+9KS+E786ktWTAO3zDb941vl6EbFkLC34b00cU+ne7AuBN4Mq
HKjSDCFp
=sb+A
-----END PGP SIGNATURE-----

--+4BoFrfwBTb2KELt--
