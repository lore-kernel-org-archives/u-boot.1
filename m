Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434F2C83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E25831A4;
	Wed, 30 Jul 2025 19:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z7WK1oxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F0A78211F; Wed, 30 Jul 2025 19:18:54 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E98A8211F
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-41b7d124016so13926b6e.1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753895929; x=1754500729; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cSjZYEOpGfqegW6pgc5WCqdzMMNlaUUuHhPrT1Rhppw=;
 b=Z7WK1oxqcAACnr7y51wwCRKw1IVKYfM9G+flSePiR/mhkn8JACO/2Si5n8XD3U5Cpb
 8kkWFmuZWlITS/wAs3dq26d8TS78jS7lrGq+kqRYouLAzvywwyBi7UcVJPnYuaeDymkU
 n0421tn0BKQpn6PGD/qTz8MUWRqF0NDqUAtpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895929; x=1754500729;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cSjZYEOpGfqegW6pgc5WCqdzMMNlaUUuHhPrT1Rhppw=;
 b=dZgQ2myRcIgF+M5Sck2Uu0WHKwnlqsk90fAu4vJtkKlzas2o03q6CUgNo+uMTJkH25
 r2LEeiu1bu5tZmyhFj6CwVnjLcXZyFXM2u7YT7WIbLh5HtoyzMIchjO9xA9eoRXVPPtX
 3LTQ8s6w8PKtrXLmUq8zb79ePnsV6GkpEFuIS/k+kZ1nG2/QpC7LivTRD4Jw2Rz5OsWU
 wvRd90s6287HRpl0g+886qMoTtdAU6YVnRkEYYEKZYZ7F/9p/ok1EZlcFWJ8nOcFep1g
 oTXyjJJcgNkEsNeLvFvJkhQ9RRwZ6Gkv0+knVG3XNqpUTrzUofSGhc82nGGvPlde4Io2
 J4YQ==
X-Gm-Message-State: AOJu0Yx0tGPcvmyCrELB1wgvrw85IDMfY7ELGHJdoGRJe3UdGftFEyN5
 pcw6VSbbAHh3vufTqrDUHnbsLGBn0FWUUCMbxm1iE6AccVGAP6gZGJCzYY2+9eq12TA60CV3p8G
 MLiyKJ8I=
X-Gm-Gg: ASbGncu00M0iNoabeHCS+fUlAP6LKhYm/T18YA1iofIXL0R3Z4s6O8vmYw7w+WTP+PW
 tU8BAc/9J8MqSllRa9k5msHcw1dBqffZO0UiFF1pWEr7RBnJRIxpjYpdQnNqWl5nsurfpwJOVJJ
 I1rfAOwromQLoa2+28hWuOYgf7Bx2I2r9SUl7pIA26MCFxq8YEMVm1qaviqUpKnofvQfQbWmpoH
 mVZ2f18bd4RMsCUgccwB3IGsYmkVeY6rJe0kQE2LdtZQj4g87BgggGX2P0cJdDVoiYcViNYxx5/
 /s6n4TWmjw9CNm5eR1UNFTO5aQRRmjNWBXW9F40kiXUeER67YxUCnEs9Rf3HHt6qWSanwyXMxa4
 FJ7nKK/p59dX+Z0QsjYKPbWpbRhfmkctyAbCBD6CHGTvF3JPjw0+R8Bp+QQPqjmJW0s8=
X-Google-Smtp-Source: AGHT+IFEn9lLrX0Url1Yd6EHWipt8L3CNLVNtu/X8xflG2/Rzpft7P09a4cJOXDXav99wJOcEvuP1A==
X-Received: by 2002:a05:6808:2227:b0:408:fbed:c3a5 with SMTP id
 5614622812f47-4319b632ad8mr2811400b6e.20.1753895928557; 
 Wed, 30 Jul 2025 10:18:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-42c7b267d0csm2013268b6e.11.2025.07.30.10.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:18:47 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:18:45 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>
Subject: Updated to v6.16-dts tag
Message-ID: <20250730171845.GR1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oGElSbcD7Bc9sAcc"
Content-Disposition: inline
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


--oGElSbcD7Bc9sAcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

I've updated to the v6.16-dts tag in master now, and there's a few
things with that change. First, to avoid some breakage on Rockhip with
Quentin's help I've applied a few Rockchip and also one USB series to
keep things in sync. Sorry for stepping on toes here. Second, I had to
perform a few fixups of existing dts* files. I'm pretty sure these
changes are right based on reading the diff from v6.15-dts to v6.16-dts
but for the record, here's the partial merge commit diffs for review:

diff --cc arch/arm/dts/apq8016-sbc-u-boot.dtsi
index c8a46ed14483,000000000000..26d4506815ea
mode 100644,000000..100644
--- a/arch/arm/dts/apq8016-sbc-u-boot.dtsi
+++ b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
@@@ -1,20 -1,0 +1,20 @@@
 +// SPDX-License-Identifier: GPL-2.0
 +/*
 + * Copyright (c) 2024, Linaro Ltd.
 + */
 +
 +/ {
 +	/* When running as a first-stage bootloader this isn't filled in automat=
ically */
 +	memory@80000000 {
 +		reg =3D <0 0x80000000 0 0x40000000>;
 +	};
 +};
 +
 +/*
 + * When running as a first-stage bootloader, we need to re-configure the =
UART pins
 + * because SBL de-initialises them. Indicate that the UART pins should be=
 configured
 + * during all boot stages.
 + */
- &blsp_uart2_default {
++&blsp_uart2_console_default {
 +	bootph-all;
 +};
diff --cc arch/arm/dts/apq8016-schneider-hmibsc.dts
index 75c6137e5a11,000000000000..d8257fc077f9
mode 100644,000000..100644
--- a/arch/arm/dts/apq8016-schneider-hmibsc.dts
+++ b/arch/arm/dts/apq8016-schneider-hmibsc.dts
@@@ -1,491 -1,0 +1,491 @@@
[snip]
 +
- &blsp_uart1_default {
++&blsp_uart1_console_default {
 +	bootph-all;
 +};
 +
[snip]
diff --cc arch/arm/dts/sun8i-v3s.dtsi
index 9e13c2aa8911,000000000000..b3a325347629
mode 100644,000000..100644
--- a/arch/arm/dts/sun8i-v3s.dtsi
+++ b/arch/arm/dts/sun8i-v3s.dtsi
@@@ -1,656 -1,0 +1,656 @@@
[snip]
 +		csi1: camera@1cb4000 {
 +			compatible =3D "allwinner,sun8i-v3s-csi";
 +			reg =3D <0x01cb4000 0x3000>;
 +			interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 +			clocks =3D <&ccu CLK_BUS_CSI>,
- 				 <&ccu CLK_CSI1_SCLK>,
++				 <&ccu CLK_CSI_SCLK>,
 +				 <&ccu CLK_DRAM_CSI>;
 +			clock-names =3D "bus", "mod", "ram";
 +			resets =3D <&ccu RST_BUS_CSI>;
 +			status =3D "disabled";
 +		};
 +	};
 +};

--=20
Tom

--oGElSbcD7Bc9sAcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIpT7AAKCRAr4qD1Cr/k
CgNRAQDD+m46nhMAC+OLa8V8cU2pnbjlZ5iwgUbsxwjLl8PP4gEAgtoa+Fy28e97
K2GnLRPlA94aEq21d6yh8XoWWGW48QQ=
=+ZSU
-----END PGP SIGNATURE-----

--oGElSbcD7Bc9sAcc--
