Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62193C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B8081FDE;
	Thu, 24 Apr 2025 18:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hwWka44k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CAE980BA8; Thu, 24 Apr 2025 18:44:58 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E5581FDE
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 18:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72ecc30903cso812466a34.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745513094; x=1746117894; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nz7X/X90mQ9a5U5/pIVbevsykwDrVHOsqx+UkVvtSoQ=;
 b=hwWka44keT36LFMgAyoMCmmJ7X7n1RpHKC8PWf2UkiXCMJIlO9p2gYINgSY5cRkjfA
 rA3cgs1+noHe3rWNT2hycFEpnHDY+x1lJCP7CkujJzB4gfyGuENTTb0jiLb1pPShAEqu
 LCA6B7cdHEbJ6N8qU3iy1nzR2U4xquLed7ZSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745513094; x=1746117894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nz7X/X90mQ9a5U5/pIVbevsykwDrVHOsqx+UkVvtSoQ=;
 b=H9PNTSSOoWg0Td6C00md87juDh/JkM0+E65Q7MvKqPPqdcwOTu3qG/GXpNRfe4PUKe
 np3ChRpxCMU7zr8xiK/6LYjDBKywu2trzpgKppABTDfOjVLKnvecKqJaUUI/cOo0FjYr
 2wZFd7CkXxtmmHybX3ycWVKAdKsvkKMEIX72pkOIv3EL32xgeuSxMnjN5zWp2+3au7w4
 Seyb0T5mywUL89kmnpfe4T/B6EzU1Ei1iVeplmFrdZXqrKkgPNMdJNjsYM0j08S2s2Dg
 f7/JKUcycBlY5MNYBiL3dKjJjRzn6Xb1/p+QHk0EngQRF1HQJfDDfIL8er4zz0qKBAsG
 OPiA==
X-Gm-Message-State: AOJu0YyxeTNrdikHk+ZbfhAZvT0YwVsSgrx5hAP+0Ernu0OKVgGz9pYR
 E+YdR5H/rxyFzcyqRPvAggrPCU578qlpFkvVLm3YOKfc+VfIvKi23hvern5wT3w=
X-Gm-Gg: ASbGncsuTjq9W3uJU4YzMLougTR4w/yybv4reWoSXLpDQ3QINIoHg5kasm+vCsaZk3B
 gV5goM1wXimpuf58jTrY8aJ0CriVmAwglYJ/wVRb4+UknXGJjeJQhxOldQEwnE21Ang8BdCfNU/
 N1kjr9EH5zVu5/jOhmv0AskUbEOG+TQS3iboETIj2KFdQVQTdRITs+bjQxhxoW78QlX368fyEBy
 rfkwg9APy92Ypmss/lsrJAly6yV6joH7Pg+ubU/S7N6z5BeCRh68aXzoAu/3axwpFBfufkdYrSE
 fNMP32kdQ2sgPIzNTj800yGHhZHkPssZz+TV22fsBVhrYKyvwz5ZLH5aZkH1KdJ0YlqUJExtoDq
 7wA==
X-Google-Smtp-Source: AGHT+IEBzTL3TEiPXV+dTCfK6dQ20NIk4pxZwUM8i547h9lGHNicqA3ekppkY0zKFbekGfaKNTX9ww==
X-Received: by 2002:a05:6830:91:b0:72c:10d5:783e with SMTP id
 46e09a7af769-73059c0535amr274757a34.10.1745513094053; 
 Thu, 24 Apr 2025 09:44:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f187f9csm292318a34.2.2025.04.24.09.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:44:53 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:44:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Ting Ting Meng <tingting.meng@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [CAD QSPI v2] spi: cadence-qspi: Add disable STIG mode quikrs.
Message-ID: <20250424164450.GJ5495@bill-the-cat>
References: <20250416031751.23483-1-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iLztXN6HMWNNeveU"
Content-Disposition: inline
In-Reply-To: <20250416031751.23483-1-boon.khai.ng@altera.com>
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


--iLztXN6HMWNNeveU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 11:17:51AM +0800, Boon Khai Ng wrote:

> Adding quirk to disable STIG mode since cadence controller has
> issue for read/write using the STIG mode. STIG mode is enabled
> by default since 2023.04 for small read/write(<8bytes).
>=20
> Updated STIG mode reading from dev_get_driver_data by assigning
> to platdata struct before read quirks variable.
>=20
> The STIG mode is disabled for normal read case and enabled
> for QSPI Jedec ID read/write since it requires STIG read/write.
>=20
> Porting from linux implementation
> https://lore.kernel.org/all/20241204063338.296959-1-niravkumar
> .l.rabara@intel.com/T/
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Applied to u-boot/master, thanks!

--=20
Tom

--iLztXN6HMWNNeveU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgKanwACgkQFHw5/5Y0
tyznzAv/YuoW6A1tmA/2M2Ccot5bebXXGvlndA5evbdEaSxUHZG72ETeK5qxuIAv
3mfVIf1hSi/lNVOV+GQTnBzX8HlDbgw430nn37EgtTPXyR6frwml9ryAkS0HnTXi
rWkSDj+eaOHQix8FD/ecKcCWMsDwiQMNY/yAR0dTKeM5Y89gdkCFP030HsczM1C6
+mfUTN0XCBXEneFlYkxVp3MDFZNgBjtB9utUt2SJhbHRQ14LTgh5qzJBk5YskF+P
pSy5/q7+SH31RfPq8TTrPjNbpPCnAd6Jg1aESOdLsu+5H/AUjvS2nw91kAjVwDIi
CxDMmEwX18t1XvtkfdONCaaJU+V676v83/zyayCpmQGPqLpjCGd6Z6+Uiez3fZxs
oO+TGqWj9clPZL5sDjyl/sX7OfxFpJkkLn4nM+fn/Cc5jifJdgFU5shJioIwBGGT
tqSArs2u5JFsWrEzAJP93AQdiBNXWAkUC5AFcnl8co2IIIUbYloSgba9gNG4Ruop
7gtEZvBN
=on/Y
-----END PGP SIGNATURE-----

--iLztXN6HMWNNeveU--
