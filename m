Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F9FC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 13:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 275D084942;
	Mon,  6 Jul 2026 15:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N2YVlbXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE42848D2; Mon,  6 Jul 2026 15:57:18 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 198F7846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 15:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7eb63dbd229so1556141a34.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783346235; x=1783951035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ioNmbIxuW1n/8qcsmybkXzX/iB/10jTAaNK8wE2u8HM=;
 b=N2YVlbXBC4wtrya5h9peRQJkAaXTy5ANAO/f8MZMn0jsU6WwKEC4Jn+ZPtX718rXjY
 ecNCsx9hn+BN/4kbX/Klbfo7ni2x+L8BuxhiMFDL9b3Yk9y8pcQ8d8rhFf6nAFgeQ/e4
 LwfTPCt+JXE6VG6vljPzYjSP1EaSRoZGOKDAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783346235; x=1783951035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioNmbIxuW1n/8qcsmybkXzX/iB/10jTAaNK8wE2u8HM=;
 b=ELyPdwV4mFKqTC6RnNC0ZTnBvGIqZc+PpK4JNrb7fB85BdS4WL+Hl1aLfG1ikajWMP
 Jj6b61lPxiHd4aZ/1q8tfARIzmuPpr/nhv2n16GADQIkiw/qaaG4Ln5AdwTYnPo/zDWZ
 YZ06fLmSjAET0r0ZT2mYMj533v2v4YOJwY1untoy9sEtr0Tp25/xD+yNDzAHz8SKeUCS
 LaFVMlqYqqcA+tynYK9sHx6PPyxhLzbwD8urMG1VJyw9LxxsXuoK2hy0gPbQzazQj8T2
 StcMShNsytjbDE0EXCt310//OFtEhE/7negiEQwdQeuOeNQaL1cwP22j7KokanvCeJ+/
 Zrag==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RYwl8Yzs4pU4RSUwDmSF/KXRT9jK0JOgzkfC8HzJBHPQlw9kXdLk8vQ/7/cjtmJj780qgbdE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4WKw+l7kug+gkkxYYAhnPjtRwzUXR1Y9LOK2i1nWZOz2K7+0w
 pXcBcJHdOEf4u2mdbqgMc3Gxb3AABt5GraRBoaEW+WDWyIejmDKqYtz/tyQJaZuCGcw=
X-Gm-Gg: AfdE7clFMhxeJYPFo2f79R2ZIMTw1Qb+8ZtPkaK6cSPk/ncm5EDsf9a9HyemsRd2bjF
 k1Xyv0XbpHghlPbQevIWCtyzDxcRP/KNoL2bcgp3tI5oHlc6VJ8vtEL9EU3dYIhQMBuYfscFcyS
 c8UomafpuUTi3bNWuwO3RUplClulYQR+ecUwh8eSpfUQWeZx1iQQmeW77OxA/thXgJ6CL6ZdQVC
 5JpUHjFeANKhQi9eRug7pmB4GsJJ4sbxnd/DgYJvxGNd/8BfI5vJFtk4vsv47XpHk7gkAnyTSp2
 myWBocbQnDhBJu08SNSd8AnNjI/Ob/KdPJv7/qUd1qBX/rHjwcmCMXyzGunv5xEDIBMyPPAzfLz
 f+aHJk+eBcuw98uOiGptS3q0AiFZPEniIr8V3zkH3V6JpsuJbCer3jTHpeGzlDqdksueuD6ITsY
 lbk2ELXRabu3hcTArcfluKO/wHLuVsYSHOc6+cOE1nfvU5PFErB/ecT54OXO8nGYkXNnSiDlvph
 n247bpk5GmLbin8t7i+VTAA/eXTTDKnuCpfCg==
X-Received: by 2002:a05:6830:700a:b0:7e9:b4ea:2ef4 with SMTP id
 46e09a7af769-7ebb0ee6c71mr440843a34.14.1783346234829; 
 Mon, 06 Jul 2026 06:57:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb544a160esm10879761a34.13.2026.07.06.06.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 06:57:14 -0700 (PDT)
Date: Mon, 6 Jul 2026 07:57:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: Macpaul.Lin@mediatek.com, jstephan@baylibre.com, jmasson@baylibre.com,
 dlechner@baylibre.com, u-boot@lists.denx.de
Subject: Re: [PATCH] configs: mediatek: do not autostart the watchdog on the
 Genio EVKs
Message-ID: <20260706135712.GV749385@bill-the-cat>
References: <20260706133322.68010-1-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cciDGfdbGU9pu97P"
Content-Disposition: inline
In-Reply-To: <20260706133322.68010-1-ccaione@baylibre.com>
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


--cciDGfdbGU9pu97P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 03:24:59PM +0200, Carlo Caione wrote:

> U-Boot autostarts the SoC watchdog (CONFIG_WATCHDOG_AUTOSTART default
> y) and services it from its main loop, but nothing services it after
> ExitBootServices()/bootm: an EFI-booted OS that does not take over the
> watchdog in time is reset mid-boot at a wall-clock-dependent point.
>=20
> The MediaTek toprgu can count at most ~16 seconds, once firmware stops
> servicing it at the handoff, the OS has whatever is left of those 16
> seconds.
>=20
> On the Genio 700 EVK the generic Ubuntu 26.04 arm64 image is hard-reset
> before its first boot reaches the login prompt: the mtk-wdt driver is
> a module loaded from the rootfs and cannot win that race. Nothing tells
> a generic OS that the watchdog is armed, so the failure is silent and,
> from the user's side, indistinguishable from broken firmware.
>=20
> Disable WATCHDOG_AUTOSTART for the Genio EVK boards (mt8365_evk
> directly, mt8188.config for the Genio 510/700).
>=20
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--cciDGfdbGU9pu97P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaku0NwAKCRAr4qD1Cr/k
CkBBAQCHjVx4fDzBr37DtexwvRwVFdTb9d9FBuMbWTXqdiTF5AD/VNplLBeRnWpe
Pprdkcj0CxfAYEDcyu/3mvkOFmchBAU=
=m5Cq
-----END PGP SIGNATURE-----

--cciDGfdbGU9pu97P--
