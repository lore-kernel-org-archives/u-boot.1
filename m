Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED25CCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A1F088A0E;
	Thu, 26 Sep 2024 06:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mAgD794F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E27488363; Thu, 26 Sep 2024 06:06:51 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABE688A0E
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a99de9beb2so36859785a.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 21:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727323601; x=1727928401; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lrB0cuRTLCourLx+cQDrZ6iWxEMRONFQWMaDDeBpniw=;
 b=mAgD794FEtplUYV0uNP92QUneVFbXIEYmsKdBqruIC9aFTb1AK27Wx/EAnB4tHyAd7
 RKQ6+C+353byzBqFK7G6FTI10vx+PymsPfuivmdShs8h8OWMdF7YZUS7KkM4u6r20jYK
 19Ol1h41wH+dRKvtjFf3G5iO+kJBHaMbOXWms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727323601; x=1727928401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrB0cuRTLCourLx+cQDrZ6iWxEMRONFQWMaDDeBpniw=;
 b=Q/N4N9Bo+88NryzLcFGZWRh6Ldc4Pn8kSvh8Wp149Nj5TXdz8DjkyFp0rjyAZSpyHX
 kEB+og3BM0hXithLdubD6rDYelFZIlxeEFECfqXZjxNdkNoyT3FEBXf7R4P2ujBLel0v
 qIlm+pH8cWbU95gWqA7ygLpRK0hEKgc1/Qs4WF+EVLNVsgxsBtjRrHzA6rhye9MbGpMo
 cJVlO9FuPhzKU1zi/EC3cSO+kUyNr86hS3t+7LLI6bcinHk7WzCwy9orFzlhE0fhL56X
 Sp7vLISdCHftIek/1W8FTjCZm0S26qC5v0mPnF/FPNuMT2mXGAgDAHCrActu14oWhB3p
 NEnA==
X-Gm-Message-State: AOJu0YzDPx5lpeXkaKfvWmtrBhlLguN/YGbI03W57IaLSntYPpueUPwQ
 lRNRoo0+jA6bST+S+34HxdVUXzPEHZ2MRP+KVkqgZSfqFfqVguYuI7VPu7uzm0w=
X-Google-Smtp-Source: AGHT+IE/emGuMjFWuqqxShzGcQ3ibDZDgrVuxUvb/omeagKFhXwk24+arIZOha+2tMLjGb9aLTNL4A==
X-Received: by 2002:a05:6214:4287:b0:6cb:2f53:4dca with SMTP id
 6a1803df08f44-6cb2f535391mr19821356d6.39.1727323601375; 
 Wed, 25 Sep 2024 21:06:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb0f4a404csm21990386d6.28.2024.09.25.21.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:06:39 -0700 (PDT)
Date: Wed, 25 Sep 2024 22:06:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Devarsh Thakkar <devarsht@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 01/19] spl: Reduce the size of the bl_len field
Message-ID: <20240926040636.GF4252@bill-the-cat>
References: <20240925125622.197915-1-sjg@chromium.org>
 <20240925125622.197915-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BBDo+jhLvRe88km+"
Content-Disposition: inline
In-Reply-To: <20240925125622.197915-2-sjg@chromium.org>
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


--BBDo+jhLvRe88km+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 02:55:27PM +0200, Simon Glass wrote:

> This is a block length, so typicaly 512 bytes. Reduce the size to
> 16 bits to save space, before more fields are added in future work.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  include/spl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't think this works as intended:
02: spl: Reduce the size of the bl_len field
       arm: (for 1/1 boards) spl/u-boot-spl:all +8.0 spl/u-boot-spl:text +8=
=2E0
            chiliboard     : spl/u-boot-spl:all +8 spl/u-boot-spl:text +8
               spl-u-boot-spl: add: 0/0, grow: 2/0 bytes: 8/0 (8)
                 function                                   old     new   d=
elta
                 spl_nand_load_image                         60      64    =
  +4
                 spl_mmc_load                               320     324    =
  +4

--=20
Tom

--BBDo+jhLvRe88km+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb03cgACgkQFHw5/5Y0
tywqhQwAsrlKrnzZEncFp9GOpuLQ17o21P52BCfZ7s+iNRSk6B7XplZqpjCYat4W
0SIsSidd1kD8tf0Gf9p470G29mPFnZPQxs0Nqa9Qigsf+ESXUWvLi/oqzeptNK1J
ksRsYvNqsOB8jL23eZf6IpMHDuQRzk6d5eHyBVaA8Df0y7lV6P/2Gws8ojRGZkn5
JQelJqnQEG1qENjWHn6hPdo9ceau+aiUMPffjLEgxspevC0rb80+N30go/NUmCmq
2L8ZjqbV7ygsGlJ2/V83uU2wRYfOh1A8g/8hEWW1PNzxM7oTuaskoIce99WdTZGV
PDrQWX0AbpRxXxcxt2j00FZCIKPrkI5EMoEUT8Yk8upezWhA72PLhF5QeOK8paoL
rDDvHMamw8oqXpJzrXur8JEnALvieTlSyEXCv4auIeM+SUQngNVEpbim+hMV9ljW
oPDsj9nPKYYYhxlbHbGIr/tz7C0gNLpa53CbkvJ0VNgVmx3J2VImcWzk33Z/k/v5
gsQquH7M
=jNUQ
-----END PGP SIGNATURE-----

--BBDo+jhLvRe88km+--
