Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F21EC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 20:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E2B8834B;
	Tue, 18 Jun 2024 22:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DwfEcTFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AB68834B; Tue, 18 Jun 2024 22:21:29 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C73E831A2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 22:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7005c84e525so294260a34.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718742086; x=1719346886; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9GgjRkQ8FA531FQ5vHRKy50rxud2bcyGMMp3PGDtcVg=;
 b=DwfEcTFlpk5+3xfzRKhEAchy7jQ6ocsomYLZwLBhnxSvwgNDtlbw6Tgje+wcFNGZoI
 b4+esqwYWiV94Xyt5wPzWFdjImQHA1cMc6MFokN+tECn5DIqVANYKt4+qxnIHnrJpi+P
 pgPrDcQbhq0d6cY/SbDegaOCAOsVdxfsDCYLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718742086; x=1719346886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GgjRkQ8FA531FQ5vHRKy50rxud2bcyGMMp3PGDtcVg=;
 b=vaNdC/jwXUZmbfjLouV9IS239tS2aFudyoQdFADQYMXxmhyMtxDSL++Ar9U86hs05f
 wO426+hs5LrkXSoksoTX0UaOgRrciFMRuMtxP4Sc4st4lUSgxYClF1LZuMrNhADyMvnl
 +7M58KS/CfgfPrUrZFnzo1WVjwsupED2J8KkD5fFPhEzp8XuJQDxgzArf2xyFg6NhEf+
 3yse3QlrC+t0xEjG9iGnd2UuNhzzIAoqZo8T60FkScXIFQt+w2QQ7hhDwmWYMK5iSOF1
 RI08QRW+pCFG8BDmUgXYOVd7OyA/ezq5hVr0fGb6xT+3NR9sdF3oxvgD5XjBTxCd3hsl
 kHmA==
X-Gm-Message-State: AOJu0YxjtOcUBtNdfi6yGV4kwx8PLJqf5BZqXBi+lr2JN4/EZL4mNcVW
 mE3qb2itLMh1hS8ObOGlNdMjliHo5LWCqZqz6TR6VFVLKwf7js/hhD195Ax4vvA=
X-Google-Smtp-Source: AGHT+IHaclRUXbyz330O45x20J/DWHzKOfjmGjCuWyD0vEd49zRAdzeOi/5i5/TZW5RnCWAI0l5pjQ==
X-Received: by 2002:a05:6830:6b45:b0:6f9:a19e:7b40 with SMTP id
 46e09a7af769-70075f5172bmr756853a34.36.1718742086099; 
 Tue, 18 Jun 2024 13:21:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1e2a56sm1962813a34.35.2024.06.18.13.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 13:21:25 -0700 (PDT)
Date: Tue, 18 Jun 2024 14:21:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
Message-ID: <20240618202123.GW68077@bill-the-cat>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xuc8S/DWSFZeFnH3"
Content-Disposition: inline
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
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


--Xuc8S/DWSFZeFnH3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 05:32:52PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
> has some additional lwIP and Mbed TLS patches to do so. With that it
> becomes possible to fetch and launch a distro installer such as Debian
> etc. using a secure, authenticated connection directly from the U-Boot
> shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot

So, on a Pi 3 (rpi_3_defconfig) I see this now (and it passes normally):
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
Loading:
Bytes transferred =3D 4528 (11b0 hex)
U-Boot> U-Boot> crc32 200000 $filesize
CRC32 for 00200000 ... 002011af =3D=3D> 2b466005
U-Boot> U-Boot> bootefi 200000
No UEFI binary known at 200000
U-Boot>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=20
If I disable that test, it moves on to failing the same exact way for
grub. If I disable the grub test too. After that, oh, a bunch of other
tests get skipped because CMD_NET and similar aren't enabled now, and
the tests are wrong. I'll post that as another patch by itself. After
correcting for that, we're seemingly noticeably slower as I need to
increase the timeout for tftp'ing my 83MiB FIT image I use for kernel
testing. We no longer have the estimated speed message, so I can't as
easily say how much slower it is. After increasing the timeout, the
kernel boot test does work.

I can note that normally it takes ~18ms to get a dhcp reply, but with
lwIP it's now 132ms, and previously the kernel loaded at 2.7MiB/s
(which, not great) but if that has a similar level of slowdown, could
well explain it.

--=20
Tom

--Xuc8S/DWSFZeFnH3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZx7EAACgkQFHw5/5Y0
tywTTAwAn85J7LXMk6PXtvGrDrLwJRB2PYxwEMsLKXOxnMEHLHVKnP0pHS2JJLAo
ZifOR9XPodXo1+SD2gkIekqlXUXWmc8rbX6qzb1oius7JYvbYZBbNcjcP0L3MMqk
n//Y7Y9xZ/N46YkMzRFjPOV1xEhAcHbMQiYdcnuIgjJguLl8PnUWELeP7tV6FX/q
Y15zwglmpxj+iQusXy/SaSQXMYHWD4NA9brOWLV7PVkc7LX3+35FwBAz5CGfyJgQ
XocY1I5Ced74ovTygPxQRr62G2kI5SbK6+ramDeMx1G82jmtjsP+RUCm7g6bi/l9
7nt6CHvJJa2fCQkLJnuyw+TnKD8d4VDRpErVzAsJdzJv5S2k2VmdNGhS2zRRTY5n
QX7e2J5l2mTGJWcwLLVK1pGnQjDa5yzm4P9yXGAZFNZzOktf62xMo5sXC78kuarN
4IJM3rQKalUA0WE59uv6gX2tGxIcJr5uRBQaqg9JrZBsWWTi7m9hq1ulDEOmEnDM
sqElpWaS
=iU7c
-----END PGP SIGNATURE-----

--Xuc8S/DWSFZeFnH3--
