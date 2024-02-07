Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B301C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2775787D0B;
	Wed,  7 Feb 2024 16:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p8+dB/iZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED0487D12; Wed,  7 Feb 2024 16:45:06 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2DF887D0B
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-42c38c4e5adso6324341cf.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320704; x=1707925504; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6cAlcQIAydMXScWhZNTDphfpAV/sd2WNnTZwotmlMFE=;
 b=p8+dB/iZ65zwqph2KwJ/VsFGM10bqcL0+hkux1BGTxJZLKEc22T2AKE6z1fmzfPhEN
 QXQ+TexLB2nbI87Yvhe5sbfdM+Ji9wZCjd4rtKB7vgYxs2KFnH273lhyTcVowO6TB0BS
 WGATJiWumcf2ewiJR4+iJD+fw8L/CpvWz1Nbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320704; x=1707925504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cAlcQIAydMXScWhZNTDphfpAV/sd2WNnTZwotmlMFE=;
 b=Fqfo2dav1NlYD+wE2ey/EzGlEkLCl6Oc5g69+KfBnMt4cxHaSzua3c+rs/jxHtCExD
 316V5BvKC1UBzZh8G0OgdTBzxSCAZlS2zazwOFW8aa+kMQ7QW6SxvvXCPbjk4eXSXDVF
 nDsfCK/FXIR09TEz1jb3nL4LD19KR7R8W0I12RhKeHdQxoNbQgR2qOe854dlKWaafIOX
 QQ7CC218HybvBP5ikFTI0AVhecX0uaYoUn0PlJ7xaMRD/Kn1gEx7to/Lsz7gflqMA3tD
 xOMRls63/wyxWWb2314muL4CwDKwIX8EZ8gKeFwnz4j3Cq9NQofPtLZUhZjwADANCTWb
 zU/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGmzjppMKYCcs1La3I/XQ0K5JdTHaMnOQAwAcTz74F7ABw5eTtUXIzMed2VnzLV+2OvnSyGaFQgrhqXLGIFhzeiglnWw==
X-Gm-Message-State: AOJu0YzqZFdXwDFPUH/lo1wK5YfFmv4Rn/meKuGx9fZ89tGFNtOOpvF4
 4F0AjcKTqM9jrI0gl+SFvfpgbnOV5MhaFjuKBemnGriCZ6rrCoMGp5LPTw0fWDM=
X-Google-Smtp-Source: AGHT+IGdTmiA0gNeOwSTHHsZSP4sNfVaNesw7aSvv3S1mV2Z7+y0Mob3ZcHbM2DpbLQ4pXe9RoHWbA==
X-Received: by 2002:ac8:5bd1:0:b0:42c:39dc:3d6c with SMTP id
 b17-20020ac85bd1000000b0042c39dc3d6cmr4578497qtb.48.1707320703801; 
 Wed, 07 Feb 2024 07:45:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXXp9qwNC5sohfm6eASjPesEwPOzMOjtxgiEdNk2xy4DhkAynzW5Udb+E6C/s8VHzpUa9e+bbLq0ACBUg9qAX1IOryHgA==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 d17-20020ac85ad1000000b0042aad0c6043sm614632qtd.95.2024.02.07.07.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:45:03 -0800 (PST)
Date: Wed, 7 Feb 2024 10:45:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] common: event: check event_type_name() argument
Message-ID: <20240207154501.GC1152441@bill-the-cat>
References: <20240128075855.15687-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7L9FpAEbNuvRZbyi"
Content-Disposition: inline
In-Reply-To: <20240128075855.15687-1-heinrich.schuchardt@canonical.com>
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


--7L9FpAEbNuvRZbyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 08:58:55AM +0100, Heinrich Schuchardt wrote:

> In event_type_name() we should avoid possible buffer overruns by checking
> the type argument.
>=20
> Addresses-Coverity-ID: 478862 Out-of-bounds access
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--7L9FpAEbNuvRZbyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpX0ACgkQFHw5/5Y0
tywzRAwAmG1Tf9FPGwLNxe66agZFAHVVMrwFMQrCtVyLSPrUqckzLc1mVFJcrofn
3BoNj4w2FUoEej0EtheykDCNqgWukFlDE5PA0YoCiVeSCMelUDTJZnmfBrXGuTDm
E7+UQB0dkuKbts3QRBGKbWsieM3q94VOpwgsWXGzZ6oNujeqB/SResai+03ZO2Gz
MZvi5/ZloVTEsY+LIUhzDB68h87Vn3xV/l3o+UB/XlbixJ4e3fSCxtpzYPs1ja6w
s01Gx5h33u893/P9sO0Y93IrUqLdAM8MxRH+k7///6KxblEkYqMbelDtMkj4vn3M
AffBmX0Y/iVvVo4hbkqHM+unI0C5DxLA1ZwTvYNzOZmteWw5H7Bbq5p70HpUzZwt
WxoY2SzCJUtzId0qI3I4jFbAtDCH77UVYP93bFQH0trLnBGXQJ+34qhRWNPG6SMw
tmbVMtopMS/a98jvQySGwAki+yEHuzf9CLJbaBZ95oB8ZOQjgNLk/luJfbK71uKP
7UnYD218
=sU94
-----END PGP SIGNATURE-----

--7L9FpAEbNuvRZbyi--
