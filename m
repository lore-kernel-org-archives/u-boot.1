Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6154CC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 18:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960E388440;
	Fri,  2 Aug 2024 20:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KXLNVTvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFEB88BBB; Fri,  2 Aug 2024 20:33:00 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D51B8880DB
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 20:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70968db52d0so2719569a34.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722623576; x=1723228376; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yBHILcaJcprNfwUvVQmKMQNIJis4QSBL5vtKiu6kiDI=;
 b=KXLNVTvReabPeINYO/1ooqPED01PAvtm4EJlRrCZDy+sbdtCHQ2ZWdgVviohVdpG1x
 A0x0scd9ySlUyDNifFm+vwj0vAPWg5ii9vpVrssCPDFZ3gbvT5TbDMeRak9CxoCKleKH
 4SMMXh8QhMODgqvj2S4vAE2DynKdXUAvT49UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722623576; x=1723228376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBHILcaJcprNfwUvVQmKMQNIJis4QSBL5vtKiu6kiDI=;
 b=HNsPcmAkHM/1w5sx0ChaMhgE/OJPTvzgA4vNG+ReBpKtExFIY+kSMjbHTpO+k5t2ZY
 b/U3LwHesde5UsQomyPwjweC/HhvAaQD/JeiuNLgF2jMU+/pOrUOidx8UlG5Dcx+UPLo
 yVIBgs3pNBoZLsSKe/Ryeqvwu/18Tt2CS9XyKr7jhGpxTQG9XDvUkxapSavzO+ubxrjt
 zqYHauPjObdZqOqr1CZL7o7kKKs67eVFPgaofx24LD8N+ZtQhYJMFm7UF3JAErwSmNRu
 J9m5KfzevuVjglF7uVMU0iI8i013Pu+H3Ug9rKbcA+56Wr15MPJBoyK7PhBqwkzjXQzu
 dJ2w==
X-Gm-Message-State: AOJu0Yz0hsjQ3/Qs//Zpw9cIMiSrlAzLbYsFaLDHai7vbB6l40Z1PdK6
 eSosemyNCzj6b5ylM6MCLVrkSlXquLiDv0PXvLv3FH8e/9qt/9xA7turWxDThl0=
X-Google-Smtp-Source: AGHT+IGr8b4l4/t9bdlCGSNAC0wiDDw3UgA0N/diQeXJEHwTHovEmORihh12gIUfBhh5hsPelnigTA==
X-Received: by 2002:a05:6830:488f:b0:703:5efa:3ce4 with SMTP id
 46e09a7af769-709ad851fefmr5530639a34.4.1722623576499; 
 Fri, 02 Aug 2024 11:32:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31ebf4b4sm663501a34.37.2024.08.02.11.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 11:32:56 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:32:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v7 00/20] Introduce the lwIP network stack
Message-ID: <20240802183249.GO3794063@bill-the-cat>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0Wjs8Z7iGTgEJc1a"
Content-Disposition: inline
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
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


--0Wjs8Z7iGTgEJc1a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 06:26:27PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot
>=20
> Prior to applying this series, the lwIP stack needs to be added as a
> Git subtree with the following command:
>=20
>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.=
gnu.org/git/lwip.git STABLE-2_2_0_RELEASE

On Pi 3 I'm again / still seeing:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
___________________________________ test_efi_helloworld_net _______________=
____________________
test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
    assert expected_text in output
E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 20000=
0'
------------------------------------ Captured stdout call -----------------=
--------------------
U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
Using smsc95xx_eth device
TFTP from server 192.168.1.10; our IP address is 192.168.1.100
Filename 'EFI/arm64/helloworld.efi'.
Load address: 0x200000
Loading: #
         883.8 KiB/s
done
Bytes transferred =3D 4528 (11b0 hex)
U-Boot> U-Boot> crc32 200000 $filesize
crc32 for 00200000 ... 002011af =3D=3D> 2b466005
U-Boot> U-Boot> bootefi 200000
No UEFI binary known at 200000
U-Boot>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

On a configuration that works fine with the legacy network stack.

--=20
Tom

--0Wjs8Z7iGTgEJc1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmatJk4ACgkQFHw5/5Y0
tyyMVQwAioWgy6WWbIBfCgY2D4fqClNLQ+eVZ2fDEjfqyjeC079zQyU+Wd6V666/
XSW71H0/j8IKriahX3T3lG8AhW6R/ej7/q+Ig+ITx+d+PS9e8olO4CuYqK/WFT1d
FMy0mgqxRWBXJL3taXR+i2hBIHt0CnwGgJmPdPX+hqJVvyUrnY5Pa6f4ZY/DC3zG
aHteTGH9ki7SVjtQOzChxIX7zHVUF7OXoc/n9i2yO8aAdsCFcArEVzP8WwfNmzgS
gsk48nGhH1pr+9BODt1Fx4Vya+otvn9KkbAh9bi04UE86h8VEytArKdm0ikQsd+o
5C1R4NWRCqvE/E9i0gQqSlv0c4ocpqSFwgRWBlevolNclKii2+oaA+kzQf4FQ6Zc
n//3bOYSOQhKWnPOpqYI9aw0Ipm+ts5dxYtbrO0sI2vvbJIkS3MMqZDkKqlStGwo
qV7LzWv+ofwWRK43WtXhBHFpezVANGSfIrtVw2wEH7xa2UCLAWlbb2fQzqBAIwdl
K1ikp1K1
=FNqy
-----END PGP SIGNATURE-----

--0Wjs8Z7iGTgEJc1a--
