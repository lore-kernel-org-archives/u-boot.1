Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D4A109024C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 16:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20A083EEF;
	Thu, 19 Mar 2026 17:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WOdfEzTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6538D83F00; Thu, 19 Mar 2026 17:21:41 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C45783DA6
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 17:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d7851e2cc4so1015901a34.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773937297; x=1774542097; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uHpMf/9eu1mBUIe1X/+7r95/9ogH59hcU2/fv5aeETc=;
 b=WOdfEzTDjvtkLqnJw4noLaQj4zPgl17mZbWlRghk6uzAnqxPWvYATe/MGTOzVk2qsz
 EttQBKWnij9davc1Pe5YvZh0aZHbCQ5qSaw2K8/vhvYLEfDRvAeK9pYp5BGucOCDt2fW
 NsoSdUy3Wa7Iaq5mlcInMun5OVxD5LT4oIXe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773937297; x=1774542097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHpMf/9eu1mBUIe1X/+7r95/9ogH59hcU2/fv5aeETc=;
 b=kHkQJ4XlODVR1+0Ml2cVpV+Fd6WfSpZ1+C9lzmSagz+x4xQWxV6AzeTe7IR1h2e7p5
 PtnTyQ/68PY/IDGE6QhgF924SWzgLgS8uTmyTV6G380DE6YYSgw85og5G45KcMKhbiZE
 3G6qx7t3vAaP5q7zg09N/HSaEnjJAX0kF59U79YMBeuk7RnTDr2tHcoHdoWSZfHZuHuf
 U2FAMUelh0HVUt5EMQiCgQxcYcuhMJFXnS482dBG+l/Mzbaoyb0Fs/EIQz1sTUQ/HNWg
 CHOinhkoGQ+Bl64gg3OlfVRlryXEpfGKm7fBcUF4dau4LyTj+MKRBWS5Llbz0OiWOam6
 HGpQ==
X-Gm-Message-State: AOJu0YzRh14Sn5r6L34etwUv9hv7chOg6tn7Qk2tdFt/PDsiM+4Tesl0
 VpwMLV08hRRxSWVNvchfuGo/I2eAPldRoHEKuy8UkSNLPg8gb9YkqazMqHddZhoG9TY=
X-Gm-Gg: ATEYQzxGXreEwhYIKt1KS2+wN7gbAhNRFkLpC9APm1urruj2uDHrqfsSNXT3QDUvC5U
 3mgSKoFBRY7pmA/k5348wUvC2My4bBdRjAoqz8ZOS7+XXunedoeRd1zWkZk3kyWhwl8gtsL8wL/
 Viy9c2/KrIsK2LWQ3tUrdvV1n+8XlS0sVusseCr0QfnoBhgsxlVeZe4Ult4J3mB+yJUOszYqyLM
 bBZgVNRf9N6JLSQkUaH12108eeGGsrSSPjmnpki8bzocp8bwI9nJtop880uWmFDqHmqXecKDSoe
 Bzp2cOMb0pQF3bn4vYkqTqqztRAUneMqNrIModGiRTT3v3PDxVgzQYoZhUYC1h5H+OYPzt6pFJ+
 QixzweRIQVTGJ1IpB+HIijPrgfsOOwLAKVsgVZswM/lDZAFy15AwdkeWaF3JsSgafWavsTB+rvt
 UtIuoKTtiJbIyf7/g69nCu4c148rzXpKgRTLa3V6sBncbXEN8yGyGRwua+xj7Ktm9/LJ9mgEuqc
 yAk/oS/yKuDOxqTGK3S/OGxh5IXp+CRTCaI0PNavWMD5vsv
X-Received: by 2002:a05:6830:82c5:b0:7d7:b683:c279 with SMTP id
 46e09a7af769-7d7ca565f2fmr4523569a34.3.1773937297424; 
 Thu, 19 Mar 2026 09:21:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7e0ed5405sm1280782a34.21.2026.03.19.09.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:21:36 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:21:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 dlechner@baylibre.com
Subject: Re: [PATCH] scripts: merge_config.sh: support include directives in
 fragments
Message-ID: <20260319162134.GV502704@bill-the-cat>
References: <20260319-merge_configs-support-include-directive-v1-1-dcfb1c7f934c@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QIgp52NWIn/Afwt+"
Content-Disposition: inline
In-Reply-To: <20260319-merge_configs-support-include-directive-v1-1-dcfb1c7f934c@baylibre.com>
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


--QIgp52NWIn/Afwt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 05:14:05PM +0100, Julien Stephan wrote:

> Many defconfig files rely on include directives to factor out common
> configuration. When running "make some_board_defconfig", these files are
> preprocessed and the includes are resolved automatically. However,
> merge_config.sh script currently does not handle include directives in
> configuration fragments.
>=20
> Add a preprocessing step to resolve include directives in all fragments
> before merging them.
>=20
> By default, the include search path consists of:
>   - the current working directory
>   - the fragment's directory
>   - the default U-Boot configs/ directory
>=20
> This ensures that existing defconfig files work out of the box. Additional
> include directories can be specified using the -I option:
>=20
>   ./scripts/kconfig/merge_config.sh -I <additional include dir>  configs/=
some_board_defconfig frag1.cfg frag2.cfg
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  scripts/kconfig/merge_config.sh | 56 +++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 51 insertions(+), 5 deletions(-)

This forks us from the upstream version of the script, and I don't think
upstream will want this.

When I make use of this locally I do a two step:
- make foo_defconfig savedefconfig
- merge_config.sh defconfig frag1 ... fragN

So, I am hesistant to start with to change this tool more.

--=20
Tom

--QIgp52NWIn/Afwt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabwijgAKCRAr4qD1Cr/k
CmkSAQCmGZ0gzgaAnjGHZsnn2kOUcdSK5Pf8fQjR8860H2UmWAEA8IFJ9lA9RbJ3
uc/RA5t9RzieGkalqEFDId+4V/xFzgk=
=rin0
-----END PGP SIGNATURE-----

--QIgp52NWIn/Afwt+--
