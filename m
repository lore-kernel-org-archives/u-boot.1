Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E74ECD98D8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 18:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E777C84877;
	Sat, 13 Jun 2026 20:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ihBqe3X9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E6E84878; Sat, 13 Jun 2026 20:04:37 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF59584874
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 20:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-69d862236ddso1284128eaf.0
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781373874; x=1781978674; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qcb1oJYacE6yV5oA+aMULaHpUeKZAsPXP00HKCEhwU4=;
 b=ihBqe3X9akOH6qQFGMJCxFzJxg7KTGoIHm04qWxZNhmuTJYljZllUq35OazAxNSQuF
 mUsV9pHJbpFhdau9I2NY1KrOzgPIlmCtCZVZ4fQABmlWAEjNRuGD8Z0gtnaerLqi60Je
 zSjwczq+89evJ7p40G7cJyYaLh5KRyWl9QXaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781373874; x=1781978674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qcb1oJYacE6yV5oA+aMULaHpUeKZAsPXP00HKCEhwU4=;
 b=I0KJbS2kL/YwIBkuLOGgBSBe6UirCOTQnoyTW28BF7utDobmorb6MkXmKF8uVh7l6/
 uClJr1zwGhcjkspQyjTYl1QX1/FhKzWnHDud9/vGrXKZj1r80slsR9UvzRpHu2xuMW6w
 KSgiWAyXHfuUHcvrJlCMfhXrbADslqDzMBizJ7KNU61nCcyMY0h1VOnv8cUkEQAGstfT
 dUSLqQLB1ufdTcJz5T+jnouFgyqWMWWI2awOJsSyheqYq2EnzFOpAH1fhL0a4E3QXJpi
 UFg6+/ofI9aOQR1uqcqzzqY8SmtKMBRlcNSgn54xodYTOMy30ZXNg63wOU1O1sZOR+Tc
 F0IA==
X-Gm-Message-State: AOJu0Yzca677+O5ORfcc3LsSQ/jSJkvv52EpHhdG5O2164yKyh8NHRWW
 CNxiPI17Z9AhQlw2+IpRv8rD+Db25GWbnltvsFHoDt5Yx/HPClyMy4Kn75eIsu9MvS0=
X-Gm-Gg: Acq92OFOkySbPQPDOoYOcX21VDteDuZx4Zo0tOHVQIVGwuVHe4VnZeVC0reCYUyGEhY
 5x30qV7SpXPBmURwXzGsukKhjTntnH39P+sjMJRMgnh3RcfxZnmFN6HhWS/NtBN9DMyqbxovozy
 nYTotMEXdVnTuzTFwZ1cIHRfeGlnZ0ZXS77+5oNR9J3SXvQ0JJK8Qndaai95WbiOECTs3euBjwU
 zZNZzAyRR6f8+ANnFOQKjEm8kp+1II8df8NoLd0cZ2cHt8x0j66aoIKJ8iX0jH5/Ro2whaiciGI
 8qCdSUXBxu1tXCdCFWS2LqRDmSO8nQar9TUdr5flt5soAmtCl0vEXLmhPDqgBA+v54ZAatovZ7U
 D/ABe5OV7pgTHvwf5UF+VLsoSm1XSKSr0S+1whVXs8QR7P2jGLRlxYqDPni3hGxJGYLa5w0VmY/
 Xj0N/lCWt0PB2c1PrfSeWU0cidwOferTUPrs3im0kzEcSOjrklGQfgFfVo/HCAYK2InoWKgNIoL
 pBKHYthOBGIU2U38vt+ipqa04LL+B59wD35ZJqSOKKthFL/H1AiN5fo8hw=
X-Received: by 2002:a05:6820:4dc3:b0:69e:3c64:7f6f with SMTP id
 006d021491bc7-69eec98af05mr2832250eaf.48.1781373874583; 
 Sat, 13 Jun 2026 11:04:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69ed83a4f7csm3777044eaf.6.2026.06.13.11.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 11:04:33 -0700 (PDT)
Date: Sat, 13 Jun 2026 12:04:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, sjg@chromium.org, vr@binarly.io
Subject: Re: [PATCH v4] image-fit-sig: Validate hashed-strings region size
Message-ID: <20260613180432.GW382693@bill-the-cat>
References: <20260527112338.9811-1-anton@binarly.io>
 <20260602182925.62169-1-anton@binarly.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z9lirlhCPUDI9Ga1"
Content-Disposition: inline
In-Reply-To: <20260602182925.62169-1-anton@binarly.io>
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


--z9lirlhCPUDI9Ga1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 07:29:25PM +0100, Anton Ivanov wrote:

> fit_config_check_sig() reads the hashed-strings property and uses
> its size value without validation when building the region list for
> signature verification. A crafted FIT image can specify an arbitrary
> size, causing the hash calculation to read beyond the end of the FIT
> image. The property length is also not checked, so a truncated
> hashed-strings property causes strings[1] to be read past the end of
> the property. This may result in the out-of-bounds read during signature
> verification of an untrusted FIT.
>=20
> Validate both the property length and that the declared strings region
> fits within bounds before adding it to the region list.
>=20
> Signed-off-by: Anton Ivanov <anton@binarly.io>

Applied to u-boot/next, thanks!

--=20
Tom

--z9lirlhCPUDI9Ga1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCai2brwAKCRAr4qD1Cr/k
ClXFAP9BVITZ/6GvnIZH5uHnV9dlubNUXKCM9yHU95f7jAdwaAEAiTu1Nn2O4hPk
I7UAMS+O5o9gTLUuQF9E9ergfVBYOQs=
=bFzQ
-----END PGP SIGNATURE-----

--z9lirlhCPUDI9Ga1--
