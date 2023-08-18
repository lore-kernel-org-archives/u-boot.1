Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4469CEE4987
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C8D86F7C;
	Fri, 18 Aug 2023 19:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FNUa5xw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF54A86F32; Fri, 18 Aug 2023 19:50:11 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31AC78082A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d6b1025fc7aso1137723276.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692381008; x=1692985808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uWG935J9Kfo5SA5L2A/+z5c9/81duepdrIxQR98aVbA=;
 b=FNUa5xw9PJMbW7kmnGypgMejLKD3MYmxwdTvaLSych0MELG9u7OU8v96+1emRB3lBC
 2RA90me4A8hvD44mFJ5eNfw+m14k7J+Cxq4UBi3PCFNkBI6XT+gy+jWnsf0irbAGN+jI
 FAZupxu4OBzyl3C55HPISmKUqk9VXy2p/AShU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692381008; x=1692985808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWG935J9Kfo5SA5L2A/+z5c9/81duepdrIxQR98aVbA=;
 b=hl00F/mQkuolO0lu3iTutB3KltabIcPKU1Ea8UdRhT6+Il4YA1CAxbxRbxRsn9wybt
 +Axgo/CZMnRJTjsydeUTVfq5AEk45ICpBOzpb2tCulSj3UaxkfRuzQ9Smg3G3H1qcCJB
 o/xp9zGCKSCU21+u4skTwi++B1jLyhET+evEozirt93W0Q8KEmAixwdLLlgWGp7sqSok
 HEeEpSe8wH8IyzYQ/eVMySWweC88mJsTKIsAA+vULcL1ya/K0a88NsEBTzmBy/l6ECMp
 kNUo9CL6YO/dEmdjd4HBEcrtgCHzYpBMI+8Ey3WZS45rHsCAv+4i+Ca4NjgDJn3NwMoW
 mXeg==
X-Gm-Message-State: AOJu0YxmwcyKXjl32y/Dt+nDp3yHW7qx041Dncgc07jhOHiZnh4Bzu52
 TS9KOJaLw+ujSYoe6eurfHxC5w==
X-Google-Smtp-Source: AGHT+IELTARmYAycVuxFICHwVXnCEbLdX6R2AsSj4ib1NYOCxYZUbdCiD0JgXvJrhCv7zSgoPeutCw==
X-Received: by 2002:a25:7448:0:b0:d4a:f17:88 with SMTP id
 p69-20020a257448000000b00d4a0f170088mr3277854ybc.61.1692381007930; 
 Fri, 18 Aug 2023 10:50:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 8-20020a251908000000b00d7465a90f0csm117658ybz.22.2023.08.18.10.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:50:07 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:50:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] scsi: Cache align temporary buffer
Message-ID: <20230818175006.GK1515023@bill-the-cat>
References: <20230807002612.114331-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hua+i5Ym8zerVizE"
Content-Disposition: inline
In-Reply-To: <20230807002612.114331-1-marek.vasut+renesas@mailbox.org>
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


--hua+i5Ym8zerVizE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 02:26:12AM +0200, Marek Vasut wrote:

> The temporary buffer may be passed to DMA capable device,
> make sure it is cache aligned.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--hua+i5Ym8zerVizE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfr00ACgkQFHw5/5Y0
tyzlXwv/QD3pvmKX+ysOCPeCRz5SKA8K1Xv82qF/tp7h7Kn+JN3+zx3vdk92jvUj
O6ZX5fP0Dky0S/h9SBgk2rX7yMfpP3oQwUJOcHZu3gKBhClnV52VrDJlYq3uWA1D
2Id9rmpM741rjEA3bWXfTpICzZ3yJrNpZXqZmGtnakrafpu4st8ZI8dKHrXkyV19
iO5WPwWLPVVZfsKDGVEHMZC2TKTrrvrIpRAOHD8n8CcJbiv7jB8QwBLCU2ZkjS+Y
K4YqNoes41iQ4zLdJp0hGLjd+n90Hby+lGu1I2gOV4DE4c4ok/C7oCKWyljdaOHZ
re6Jwp5RXg5nfvHmV1D+daIefOIo4k/E3JhGRoOSYAJamVyNgHESBPl0DNt5u9y8
EyOJSX+y+aco/OzKGssYkRQjzbZDDhtktNfRFayMoe5OKTj9+CG3VFI512c3jGLm
6Hskhpra6ojMT5uHYtlZEIUKz00AjKMAJM6pZdF2TaRcAgs6sWkuZtsjDfQzeTbN
SN2xn44x
=H6yT
-----END PGP SIGNATURE-----

--hua+i5Ym8zerVizE--
