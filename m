Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAB8C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 15:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB730801CF;
	Mon, 13 Jan 2025 16:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kKEyjOr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E25F805DA; Mon, 13 Jan 2025 16:44:59 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B907980141
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 16:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b9ad0e84e6so429739785a.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 07:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736783095; x=1737387895; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CsP/lU5XOOr4NfZqpHPS5qM9nIJZETyeSg/lreaQ85o=;
 b=kKEyjOr6n87pjeYQx4pIsrnpO2Lbl/rZoElIzxCf+HIg/SGFuy4g6bI8yBbRGLeip5
 IwaIQ10+kKmp0MtP2vDejrEYXyqAIYnDXJ2cI01G8dU1imvFBSntEX6XHh12y/EmCesB
 h2cpJ5qOB0b/BT4ERLr3SZ5N//1JQi9oXeDa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736783095; x=1737387895;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CsP/lU5XOOr4NfZqpHPS5qM9nIJZETyeSg/lreaQ85o=;
 b=bFamxuStzmWa0V7mU6GXL6Kt4afg1dTkJCN6kmAMZrPxCCl4yUb5h7CdFfe5V1CHYF
 eqBzrq18HaZw0zbvVNZtzY5AOj7nl8OGlbtyIUmnx4zbOQ4cP8ALYMC2KQ+yxbkChM8B
 Gp0JlZfz1JEfbaLq6tdH3P0b2Gzf0IAv6yMdgrCB6wUHlukn3P0AF59bqLLAmpftS1XZ
 D9S1kowD6GMXIu+ar7FUzP+l1RJkCpWGmtbPg89C638O28rAAGtmM13wBOOup0KFYI9N
 7NM+hY3SdIZ5q+0MtECqK+dYnsiuqFrqfY/+N+dOp2eXsPWwWDKYy+KhRpHc+B2wXrcL
 OzMg==
X-Gm-Message-State: AOJu0Yzcg2XorW4xt00MTHApR5IxjU+e/LEwE02FseYyOtBchgz8McR8
 w61onG+KpUszN5b1PVdshdtLoOkno76Dq/qDul0LIA5jitVnBfPFO6cU1Hz4D8E=
X-Gm-Gg: ASbGncukM2LIVU0e3mTb0EjFJs0+pbgmAAfPMeWqiCTqBF9tNOY8h21iHHMYqyugxAz
 2m+zDHHnFI7hurFih0wDQpGFhbA1qRW726rnoMRczKbjiFruK18Ou6k9MMlcVe8pLPbZuu8YYki
 eUSmiaGCrjdXKZ/MUfk8QYohvCGMHAJm/j1AXokqQQuFdskbmHJFiob+gg9eJcNhUyNifvR+3t9
 74eTjiuT6B1WPdnjfYoa7iUFf3QvJd3Bnp26A3w5FORw8HWbmcH/Us=
X-Google-Smtp-Source: AGHT+IGDEXX8WiMzAQaBsPXtLijr3Jxv3S6yCT550lBleb6loanU8rzdJ3DPO5NWDek07UzHf4900g==
X-Received: by 2002:a05:620a:2b9c:b0:7b6:d23a:be39 with SMTP id
 af79cd13be357-7bcd97a7077mr3355026985a.44.1736783095589; 
 Mon, 13 Jan 2025 07:44:55 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce35160f2sm499113885a.107.2025.01.13.07.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 07:44:54 -0800 (PST)
Date: Mon, 13 Jan 2025 09:44:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v3 17/30] emulation: fdt: Relax condition for
 OF_HAS_PRIOR_STAGE
Message-ID: <20250113154451.GV3476@bill-the-cat>
References: <20250111000029.245022-1-sjg@chromium.org>
 <20250111000029.245022-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="om8qEOMn/1kJZbyH"
Content-Disposition: inline
In-Reply-To: <20250111000029.245022-18-sjg@chromium.org>
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


--om8qEOMn/1kJZbyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 05:00:16PM -0700, Simon Glass wrote:

> QEMU always gets its devicetree from the OF_BOARD mechanism so we should
> not depend on !BLOBLIST here.
>=20
> It's not clear why we need to have any relationship with BLOBLIST so
> let's remove the entire condition.

This is fine.

> The logic of PRIOR_STAGE is quite a mess, unfortuantely. We should rely
> only standard passage to receive things from the prior stage. QEMU
> should implement standard passage to provide its devicetree to U-Boot
> However Linaro has blocked my patch to provide devicetree additions[1],
> so little breath should be held in respect of either change.
>=20
> [1] https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromi=
um.org/

Drop this portion.

Otherwise:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--om8qEOMn/1kJZbyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFNPMACgkQFHw5/5Y0
tyySTgv/RDFm+kCb8kaA+JkHnCrhs5z4yta7pG1NK99cw2AnLPul2Xx4Sgo1Gj4j
YuDO4j6jNgfv+OTyZ78fMvz+UMPK+DXXL30eAtRe2Bj/9/5GPW8O3HDl8dVh/tUM
SHCHPcTgp7xGFzraF0qQXZrcESDiHjBxG0C+gXicSj00TAiGoCjVkkux1OAdKdlb
7XeeCEvmadF6vwq0TaCcjwA4z6wfzWeTi7y6oy8pdrBiTsPYhpYmYxNkPmJIEVlG
KESw4Rcgjv0bEAcYJYX5YRTQl/uoY9pekybyxdk6PmI8N9khDSpA187n9nACCjls
ktgbOBGzJTR/adqV9d6F8NUhHxhdPnI7J5CMK8TGqhDOoRM5bikzDAv2jV4U3RMI
Y2hrD4DSgHylJ5wdi58hULWDnNJULqEkTHHR37PXUbTXW4+re8co4crJ4/8ddB0X
NzaVBYwMmgnsSz3fnbmt6iL2ALXoWgnfF5hcoO5b4bgH3zAQNXl0fXeyXtzATkji
5zzbmude
=934B
-----END PGP SIGNATURE-----

--om8qEOMn/1kJZbyH--
