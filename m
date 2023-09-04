Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD11C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 777B486942;
	Mon,  4 Sep 2023 16:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e5ODRVPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78F0686932; Mon,  4 Sep 2023 16:41:08 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F9598693D
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d74a012e613so2023529276.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693838462; x=1694443262; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mg33pxBtcw1M6rN/C2BNzGGBb2XSfkQM5vJZX6rHz1k=;
 b=e5ODRVPb5A5bR4fFeZrD/ynsnRBlwlYc8UF11OSFXIWtanEXB2l56Qj5sFTVE4xUH8
 Q05TxpLQ0A8J902ZWJyJT5iUq8C3I880tppUJDeysAGTfeVBtEvr3eNmbliwmsMnBPLi
 kF+zT2tpAfb1jvfKBHu6/oqEIIMf5eAE8QgHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838462; x=1694443262;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mg33pxBtcw1M6rN/C2BNzGGBb2XSfkQM5vJZX6rHz1k=;
 b=j9D+kPhWAjlmeeSdKkp3QaUi1PoWg+no1hI3OQAgXWuPMB0BwcbOb0zrgJhlTU+DjK
 XLd13bv9oxYyY9Yq8DT7ipxeistt6ZG8TJW9+ryEK2d0eJ++ETRByDzGvaGYuN+kq+pk
 GpBo3YAmtvEI4YOHViV6qBi4nh0s8+vf17PXRKNJaQW2X0wfqpyE9G+1hTNpz28fseAx
 RQu8EDTZV+B3/Zoe2D+7QSq0lg3ZInrJmGMSl2Uv1mrGDgPhtSJ3KcU5tPztHohaPt8i
 OH/gnW6k+3RVjYY2Wv7xAKw3cSGaLPgcLTpHXcHcg9ZKC0lNIB1uoKHUD/nMrzrmgy7i
 c5vA==
X-Gm-Message-State: AOJu0Yz/aIFJt9aF8JONcOP+kBtS8T++1tUBNaoB7dALnsnvptNKpyrx
 HQXMRst6Ol7Od8EFth6/TRX1EaEsFy5n/FRLgKE3SA==
X-Google-Smtp-Source: AGHT+IE3KLuLTUWOmTRt+bBcvgFg+fL/7RQeKeRh8MEEX52q7VzXGBy8bsU0bvVE3kCsDQCAAOvdEA==
X-Received: by 2002:a25:ce47:0:b0:d7c:26ae:9518 with SMTP id
 x68-20020a25ce47000000b00d7c26ae9518mr13195350ybe.14.1693838462057; 
 Mon, 04 Sep 2023 07:41:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a25ce0d000000b00d0b0bbe574asm2330233ybe.44.2023.09.04.07.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:01 -0700 (PDT)
Date: Mon, 4 Sep 2023 10:40:59 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2023.10-rc4 released
Message-ID: <20230904144059.GC3101304@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r4AzFDNxSjrb9htA"
Content-Disposition: inline
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


--r4AzFDNxSjrb9htA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Once again it's release day and I've tagged and pushed -rc4, and will
merge that to next as well shortly. We are firmly in the stabilization
period at this point and I really want to see PRs for -next for things
that aren't fixes.  Adding Fixes tags would be great and helpful, but
not required.

In terms of a changelog,=20
git log --merges v2023.10-rc3..v2023.10-rc4
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I'm going to try and stay on schedule now and that means the rest of the
rcs every other Monday, and with final release on October 2nd, 2023.
Thanks all!

--=20
Tom

--r4AzFDNxSjrb9htA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT17HsACgkQFHw5/5Y0
tyzEtwwArJsMU0Qa7o6VaCien14Pr04EFIRWDQede6HSS+w4maSUDw61uwRKvlv2
dUlcPJXxtxzH4QSLh4OtzC4dwpwuyCl+xOXInFz9cVJ6oaHB1elgMhLQ/BBYVbmu
4rghmlQqrBgbHGHxQ8frbs8TxiKpm3o6Z+Oy52agwu2vr6ja4CiaFTSEbhSyylsW
bY0lbIkfJ3XOQEXDFV977qyZNviaYx8S6qZdQ4IgP52UnLr4axGk8dvR/7aYZsNH
Dsbty/MZObSOMg9vHo68lYVGpkB114OO0XPdz9duZEC4/XdPdZ+hrpy0YM1C7IDu
ByeZzx3NpQCtC70266//5LkCZnvczjvnSD/G+tqHpbsJbiHNqHXIX7YYxHwqyl0T
JCRQgJrdP8dsLA+MWxHBCXHfOG3B9rBIBzEZbde7Z+ghEskhy/0ASN6DPwrhpVPi
JAg2IIb+oocT+QxEpt54T5+TG4jFXSozLul5pVzYHDGUbr4vC4spvIFNa5t0R60s
ig+VFz4y
=NprC
-----END PGP SIGNATURE-----

--r4AzFDNxSjrb9htA--
