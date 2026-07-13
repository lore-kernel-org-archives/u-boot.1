Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FE6C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 22:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D34FF84C43;
	Tue, 14 Jul 2026 00:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cE1wt2DJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9A8E84C75; Tue, 14 Jul 2026 00:08:08 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4220E84B73
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 00:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a116bd18ebso264136eaf.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783980485; x=1784585285; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XouXMVRjLVj/fV0d8LczvGZlolgNH8+di2AZuWvt5lY=;
 b=cE1wt2DJngu6ybyZzdV4PVKHT3ybR7djZgBPYvjoIhkrIYytVdC7hEqKMJX0zPgTT/
 xsIQwjSPtVUSj6PAKD/Xt2u1H8xK7eouARDs4JHF/ArHEhJjYJ7/ssQAyK0hYOCpNvjd
 jndShYLcVmcGHUNUJup0F8Xb3vSp+vVVz36BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783980485; x=1784585285;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XouXMVRjLVj/fV0d8LczvGZlolgNH8+di2AZuWvt5lY=;
 b=f8qLKj509i8CAdbrfrFSGHAIyS4feDM1+ls0P5InYnzLJDjnaKJX5ltyrcn+847aVz
 z7Iz9FR9b9kN9X7PWad0xnRCdWr06eBG2RevcOXjOIR2Of/u2yf0mFhZ+mS7jTV8bw1J
 TU6TCaoxOxZLRHm29BqdVI+9r7rwTqea8ftPh+7naj+gZnKCcrYQ4Cnf3jkh24GqX+uh
 Ho1CaNila6jku7Xtlj2j74iRAmEvSlPgwDoxiEx9V63WSRYNIxQFlnAG9I6E/Dq/hysp
 zjErjzamkTVdVmL3stXVFkr5PHcjJ48xmQvMPYgHFVRUCv/MZUptsJuZd9XTefm97fKp
 h3fw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1v4pFW9PdMWt22lK7F+JhNq6hxTXIpjg8ZNmFAd9+x2vYLSA3ksi5b7FZlgNwzXlZ8446/vw=@lists.denx.de
X-Gm-Message-State: AOJu0YyZck5u8GhGq7vbxNtHyJSKZw8GkCwiU2gEepO777BCobgY7xtv
 UZ1rp52qY9O2R8/Tfn5CbnsaymbnYq0bzSKEaAwL3hVnbfgwot9ib5a8UR1W8zV6UMI=
X-Gm-Gg: AfdE7cnggycTY2R16Y0xdGUDAOFqJW+W6VobYUCaCzO4Jjb4guEdBSWgEqVnURO/JiU
 ar25nCoYINTFBGnA1OPtUL3yeq7twccqF4T63dWwCcsNKhYaRnCxhkdNHgjtk8CdOSknck3840t
 hiwQ+jy5tZe+6MZVhgNmkjFQJsl8DSOeEKWyPH2mORxXkE8OSQkdpSmgduFqg4FafMLE3nDxjvQ
 i22fwlWSRdwCBkPpBNZAtgUg3k2BGvEVnQA+GTxVwWUXQ1cMFWmTMoKtzVRSceYySb2K9ZIYE1U
 jPlFu+PRV5Op87drsEX/CO790bVDMPIDd0h5oPRxYS7c3iT+Lncm9A4RHiz5HXPTxROmYvrvhzP
 KDoyiOetVMhVTmEYv2GC6H7MoubDdTxFT7XLkyXWmwdaLIf9ZUF1uT1frz2fiu9gJRF/8WovizV
 +phkB4FgSTRk+Dw/9JWQHS6ZtciNCTCKq1DAXBzHIDljgUwpX0UPaPjt97qBzfZxjk/FSltQZMh
 ++8c90cbdPC3RsTCWEdgDitNLM1X6LU5xPHa0UNjvBumW3f
X-Received: by 2002:a05:6820:1a06:b0:6a1:43bc:d0b3 with SMTP id
 006d021491bc7-6a39a5fd2f5mr6445322eaf.27.1783980484641; 
 Mon, 13 Jul 2026 15:08:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-455b767413dsm4884362fac.3.2026.07.13.15.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 15:08:03 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:08:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Ludwig Nussel <ludwig.nussel@siemens.com>,
 Anton Ivanov <anton@binarly.io>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] boot: fit: factor out node-path collection in
 fit_config_add_hash()
Message-ID: <20260713220801.GW749385@bill-the-cat>
References: <cover.1783816074.git.daniel@makrotopia.org>
 <d460c0571dee7cd852267d881938d6c3d2caf300.1783816074.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZBWokbDjiM1HqNcm"
Content-Disposition: inline
In-Reply-To: <d460c0571dee7cd852267d881938d6c3d2caf300.1783816074.git.daniel@makrotopia.org>
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


--ZBWokbDjiM1HqNcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 01:33:13AM +0100, Daniel Golle wrote:

> fit_config_add_hash() repeats the same sequence to append a node's path
> to the hashed-node list three times: for the image node, for each hash
> subnode and for the cipher subnode. Extract it into a helper,
> fit_config_add_node(), with no functional change.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ZBWokbDjiM1HqNcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalVhugAKCRAr4qD1Cr/k
CkhhAQC1ADzNQQroylDKlf533STwGshOintYIDjlvP56aFGesAEA3OQiBONFLAU7
mLSn0+lVHEWINYXp1n4OTupopEzIugY=
=9/SH
-----END PGP SIGNATURE-----

--ZBWokbDjiM1HqNcm--
