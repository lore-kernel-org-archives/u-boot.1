Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611A1C5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 17:21:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9988460A44;
	Wed, 12 Aug 2026 17:21:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAqPWoaPpHob; Wed, 12 Aug 2026 17:21:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19782607BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786555264;
	bh=6HfZpq5wVo+hlUZJcTU+hGx3711iOab2pFY9W9tBvRw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TYaoa0zoWigYiI0INxUO17gwkPQ4dWBUDbZWAU/Sowyh0LaaT5td6MAmkNlk2+8Mi
	 VqOrSVLvHP27uPkYcA40nC8SKmSovrtFeuhcrTyTAVfqQRWEvT0Q00dGEy4VW4GUfB
	 KeLfeE9YEoTZ9r/uenRFRze6wO4IX9s5BsoOyagQNuTB3r+I5cXrrKo+BarZKe3pK9
	 vd9z8At5VMXaWmIaNHpGBye1jE42Qfme0OZnf7m393KIptj0c8yiVcUasutKfy+QNk
	 X0/3DF7jxtSZhlIdOK7pY72OWqMsyO5dhoKnvi2syWzHDqWCbDsP1KGvdjNPwhMlFH
	 WDUEpNlapIqHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19782607BD;
	Wed, 12 Aug 2026 17:21:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8EF53A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 17:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAB8A4027A
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 17:21:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wY9ZAIUJlyaV for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 17:21:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 19BB140140
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19BB140140
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19BB140140
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 17:21:01 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4a475409044so477543b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 10:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786555261; x=1787160061;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6HfZpq5wVo+hlUZJcTU+hGx3711iOab2pFY9W9tBvRw=;
 b=aRbSjrom8qYFXRswgYl4SPmn0jJ2BMG62mgKKEQaARdRM5uZMWK1YTLwchChuxFpwl
 yztI0dW+gCeuTxr7rIzLP+9rmPbE6v2jYigZ75EmxdOscqEpltOTfgKa5q/oHtPBFLmv
 KPWGf1bO8z+uFJ8D5vc7sc4/hNwG7r79JKT2Zlyo58OoGVLM/UOioAVXQ8BRb7gq4qQs
 YurBJapjuJvFtp1Dni+Hmd+RID4x5HlI93Vc+8RGL/aVgEW8JiDKoMQqQTzCov9AYVqc
 ZqR9gK9xXxyXBxicFB0S8XJ5TgyCrhWCy9E1PAloudWDqz5uQaZVmiqAAkL+2fXjIefs
 U+VA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQEOmZYCiMDvml3+8mkELEvs57tsORdvgJRh/K6vYTMuS9CWEItOxtRlkgcciaXOOJ5lQuBDo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyoGMR6RCfVJ42Ych2FxeGcOIRsxczH2ZZv/BILX/0MxFQUHai2
 DWuzcqjLYOYzYmcadgqxrI4qwMHxNaewivERhk5Idx02GExOTQ2QyNWKAo1B35S4O4Ig6YkEwKB
 N7KUW4g0=
X-Gm-Gg: AR+sD1388z/BXEqptH8f3cUTRn+K9DKTHUxxM7bTKy8ilRKAAk3R/54KSiufbbJ0/3/
 TRSNWiGiNB4qJCQntXEuIYJ9Q+iNPvr5cjFJNR0PI4gQ5fdXsBsxIsnj47duHIkBVY5/B2emhKn
 N81FerVpniBo2xpC1ny0evsl3tsvGBSvR/wRK3vpeHxr2steLQgK8OGe1zRGpBaHvSyQMNBoWet
 sEhC06ZbSzKZKlBWUvZ8XKv/nHch2sL5ty1ZnKs00Av5mLc3tA573EftT2MMZUtgS73pH/GrlHV
 7NtBquBxWg6q1Jnkw9jZsof6MU/t8QGADUjY/M/9gofLuLfvLkp1tvDRo6OKjWdy9WcIFKGCQBP
 ogoXb8TW55mBSiarFTWtYf3IIKNvwwztDDSpbgDuxgxxBtTy2g/8KTNdj7jAwbHY6hLJAMyYyZ4
 uP5fL9y9DnEP1tcIIGPDsnu2E07pmmajcMEC3xf+DlbjWLWkMEqhkfM2pz0baglbBXGuHtEiDN5
 295TvUyOpg7ZpdM2JinDvvIOwHEVmT9Z2Zzxet9LmAjlVbEkIAeCBRbUvgj4hRgGoAEHptygLKC
 O8ZIUlCX9Q==
X-Received: by 2002:a05:6820:c8c:b0:6ae:47e0:be20 with SMTP id
 006d021491bc7-6b0c4194e3emr17420eaf.7.1786555260823; 
 Wed, 12 Aug 2026 10:21:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e35175873sm2301645fac.7.2026.08.12.10.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:21:00 -0700 (PDT)
Date: Wed, 12 Aug 2026 11:20:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>, u-boot@lists.u-boot-project.org
Subject: Problem with test/py/tests/test_fit_verity.py?
Message-ID: <20260812172057.GC3297518@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oTNySr9OHQg2P5qX"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786555261; x=1787160061;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6HfZpq5wVo+hlUZJcTU+hGx3711iOab2pFY9W9tBvRw=;
 b=EJrWAnyWI6j1dIMVbVKOCMiJbZYZ+OHhOmkNP+prLdVLlFO44oNqdqkYNJ8FD3JJi8
 mXNP2SlbZGwVr+pLNFv8h1Wl35HLleb9Uq7IDvmXuON0hVbOm3O8PvuS5v3m+rO4Kf8/
 RAk5IRe8zJzSES+SLgrckbx+E4F5Ijrc5BYYU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EJrWAnyW
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--oTNySr9OHQg2P5qX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

So we don't run the FIT verity tests on CI, because veritysetup isn't
installed, and should fix that as it's own problem. On one of my test
setups, I ran in to this:
----------------------------- Captured stdout call ------------------------=
-----
+/tmp/tmp.xSw29uYDUF/am62x_beagleplay_a53/tools/mkimage -E -D -I dts -O dtb=
 -i /tmp/tmp.xSw29uYDUF/am62x_beagleplay_a53_results/verity-equal -f /tmp/t=
mp.xSw29uYDUF/am62x_beagleplay_a53_results/verity-equal/image.its /tmp/tmp.=
xSw29uYDUF/am62x_beagleplay_a53_results/verity-equal/i
mage.itb
FIT description: dm-verity test
Created:         Wed Aug 12 11:01:01 2026
 Image 0 (rootfs)
  Description:  test filesystem
  Created:      Wed Aug 12 11:01:01 2026
  Type:         Filesystem Image
  Compression:  uncompressed
  Data Size:    262144 Bytes =3D 256.00 KiB =3D 0.25 MiB
 Default Configuration: 'conf-1'
 Configuration 0 (conf-1)
  Description:  test config
  Kernel:       unavailable
  Loadables:    rootfs
+fdtget /tmp/tmp.xSw29uYDUF/am62x_beagleplay_a53_results/verity-equal/image=
=2Eitb /images/rootfs/dm-verity algo
sha256
+fdtget /tmp/tmp.xSw29uYDUF/am62x_beagleplay_a53_results/verity-equal/image=
=2Eitb /images/rootfs/dm-verity data-block-size
4096
+fdtget /tmp/tmp.xSw29uYDUF/am62x_beagleplay_a53_results/verity-equal/image=
=2Eitb /images/rootfs/dm-verity hash-block-size
4096
+fdtget /tmp/tmp.xSw29uYDUF/am62x_beagleplay_a53_results/verity-equal/image=
=2Eitb /images/rootfs/dm-verity num-data-blocks
Error at 'num-data-blocks': FDT_ERR_NOTFOUND
Exit code: 1

--=20
Tom

--oTNySr9OHQg2P5qX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanyrcgAKCRAr4qD1Cr/k
CoF+AP4u0V2vHXc/X3XwcuKoiZgSjHymhrKoHMO8Oo0CQrWWkAEAq5vrcGtagLec
tPa24krhP/2AuCeOYWNwU0ey0j3U5A0=
=Nrwy
-----END PGP SIGNATURE-----

--oTNySr9OHQg2P5qX--
