Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93BCFD3776
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF2983EA6;
	Wed, 25 Feb 2026 18:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NWv8mPm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4611E83D77; Wed, 25 Feb 2026 18:12:53 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3180B83D77
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso6497119a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772039570; x=1772644370; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wYYrl2+KL7B3J1OKw56DDGlp/ggReqgJUf5u2nsQzGc=;
 b=NWv8mPm3UpQgA7b9k3TiX502bahNNcx8Ck6RKZhWXB6U7uLv5xps1aah22E57HJmX5
 lpPZpaUXWlzXWVpzdaWX/QglN/QBg1wkVwC+PWLYfnR8YTw0KsgycrqLh7or2OdClET0
 yKZK41FBpbWTQNYY+tRNzm8i44ZX/u4snHUKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772039570; x=1772644370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYYrl2+KL7B3J1OKw56DDGlp/ggReqgJUf5u2nsQzGc=;
 b=Do7WF+k3Xhs/+2A2BtkTfgXvwZJ0WFfjPDH5tMFB5Esb6L7tsG9NwbbPBtUHKFvVEM
 zOFAoqaFMx/oA2jY7etTnXpGxw5z4mDwdi/WchUYTKht5seLeM9B/cHGqHo6aqgHLUUJ
 r6P2QhKk+GlQilp4Z7/lmLx69JxRuUZkDTZZyXWn6/uKnL+3S+kD/o30KL/+VyleWhY7
 OZiaT6pTprArfTYLj72W9vU4oFdvMdZhE2wXNTF2vkCBv+m8iAjRQcE7xA4B6uaPws0z
 qpnFjUNWCc465Gw4ZtUdhXla1nTQCS6FJfKNH5+rlU6KyJnKMCRQDwsy73dWrKNl4YXr
 oQwQ==
X-Gm-Message-State: AOJu0Yzr8ISHSQFOuxYP+v1MchSmAYq/owpb0tkdzW5taG7qZAS3+/58
 CrOTOfwInIE2bWeVc6RwSvQXNBfG2zhlhq+Zldxs8iEYoALHwQ1MxvgW5V3bwSzc/ek=
X-Gm-Gg: ATEYQzwBrRRmtgP+6DUkDWhI1Ewt23dqqEMOaVaIRtVybuv7VNOmo5geHU/egt40Bbk
 1FjwTa0pNiOjTj3XB1U6J2BunNfqgjrYRwB38oxX4aTdCuK1uFe2kjuXNIM4yqegLHMplEo4IUB
 +UNsqe+PzZ+coAuU5iNBsZ6sKOy52IQ06YPh1csXQqY64dkUtITNZh6teAelSdfCMBRQXA54Kyp
 +kfcn1BjyC6qE3KK+v9eGGFiuDQNzFRC9uy6BPClhwA0O3qOAHvkDVyU+wbNuxYuRzxxmCsMc3o
 yhaCeguWqjHtsG5nHFR5iF2PfPe/7JAkGi9SkDQNqicpkD3jCUojZniP9QOwYTAHHKwTcbS2Z1B
 iq5/HfUFsbHqx9xEdqGWur6RvokfdwyceTvPdSCTMnzUYe3xI8N+dLNJG07YIG9cxYi/lOo/Fv4
 BK1nK3C2JqGCsHCz+KqaXlKO0aUm8mfD1LDIawmfipvhQW/7i+KQpacncIC1cZBhgWFovdfAMFV
 qlXf2fitiCQ0Fkr5YDCvLN3sir7n33ERWbpSbezgs5/zyFzwog=
X-Received: by 2002:a05:6870:5489:b0:3f9:ff05:438 with SMTP id
 586e51a60fabf-415ffd23c46mr577007fac.24.1772039569669; 
 Wed, 25 Feb 2026 09:12:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfa6624sm15533271fac.8.2026.02.25.09.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:12:48 -0800 (PST)
Date: Wed, 25 Feb 2026 11:12:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 3/6] test: fs_helper: Drop the size_gran argument
Message-ID: <20260225171246.GQ1593142@bill-the-cat>
References: <20260225162357.3449937-1-sjg@chromium.org>
 <20260225162357.3449937-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9yxiVV/T7BJGa5IR"
Content-Disposition: inline
In-Reply-To: <20260225162357.3449937-4-sjg@chromium.org>
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


--9yxiVV/T7BJGa5IR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 09:23:47AM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> Nothing uses this argument, so make it a constant for now.
>=20
> Also fix a pylint warning when checking for vfat/exfat.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

It would be good to ask the author about why they added it and mentioned
making 8.5MB filesystem images.

--=20
Tom

--9yxiVV/T7BJGa5IR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8tjgAKCRAr4qD1Cr/k
CmIcAP9qaV6bBYNC8GxU8nLcng+qSaO6eltVjeCWvCdoYtmbEgEAk4ATm3T1GU8W
lVtwCTcRRfiVItxVt/m56nwyz9ku0As=
=b2zL
-----END PGP SIGNATURE-----

--9yxiVV/T7BJGa5IR--
