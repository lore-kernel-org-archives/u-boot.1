Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6B6CCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 16:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BE483211;
	Sun, 19 Oct 2025 18:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ckh8qQqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D042283893; Sun, 19 Oct 2025 18:48:44 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F90831D6
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 18:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c288d3f249so877455a34.1
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760892521; x=1761497321; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NCvLGNbja+npIQswrSxYdbCmY1KgZBTFcqQvnCkd2eE=;
 b=ckh8qQqAipM5ePxczfeQzs6im+tAFBP+fLf5u6GaPaomIlgKPvBZPNqv2A1HcGSGE1
 DNyS23S8yTHQztbvelQEfH564g0SN2XANIxF0RRKiKufH4FUR/ED3Rosxl/JqaCIQaD+
 NG4+x/1hWUu52FI2WxZEL1XiCBZhwD/Bl3GSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760892521; x=1761497321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCvLGNbja+npIQswrSxYdbCmY1KgZBTFcqQvnCkd2eE=;
 b=tEhDsU9KZHwYhhyY/Vb5honUvVPyZQpqky0+sbonpa5+CgUdCXlsmeGZbJIymx5Dkr
 GY9MbCnVAN2XJxXXsYgV/41CMAl4NiMKhA+fCKFkiHe8gl9TScpPbKyOXbSH1FB3dg2s
 IXbpO4CFQxRDwQwSuUqqhMdK2G/wphARO0bvmJ9L1saDA61hdfY4e/CYoCbm6MhkSE4W
 waYR4ur3WVAKiZQ/UcCxFuIWhM4mBHXQkaLUnK7NnkXPOKNCTzwWRmlQObaojE+9WGg7
 VD+IclRmzkGSTjHEgJySPaPDhWjLlWmdKGX7rCVogkhn249alQ6wHtOShXHdbTMUKmPb
 7gAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqLQgIAp7wjO9Oe103i0OUEGhG85/ODK87T5BOvryHLowNnz4SB1vQgowvjKFID73FzwTyxH8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo2dKFwvnpw3Ghv7M5SfqC4Jz6UOcgwFraJoxpG8GXmHlp2g+s
 /Nzwm0PC8KFowEixGlmhtDu6zXFv8DnPoYo0ikLE+8T5komvMog7DnBJZm7EMDbV2Tg=
X-Gm-Gg: ASbGncusVegikP5h2UY9P8wF/JttQFn5WBSE2Zaga0KXVtXPMVbmgD2Ll9BkzM314oV
 udn5hN1UxrjkUuRw4cKzVcQJCakO5Kz4d09fd0BVpUi2Kjuneo8BPaZozXfApXl7WnKxdDryetA
 IpyTPMk4QhoXq1+YJpx6NkSumSCOqJ8vvAokRhX9UL8vDT1hmMKooBc1D6tS0xwQpD6AZavErxO
 J+lrR1azpSjArmb5pJo3DEUcTGpyPW9FzIy/aroiAuX2VaQQURUGvgH6mPmhd1JeBPftYubUCct
 a7+fIbxRBR1QyVicmaoz1LZ5WDBvuvlv7EXWCXODxuW2k8eNGPX7tG1wXA5GCBMU3QCx93qj+hH
 CjPW8C8ee0ahzZGSaan8L31JbCCN+E5cTFckZ7bSwmBWUI2zwmKB0a/XHpue5YMYVQsB4srMN7L
 zT55Vi7pla0Q5V7tS0f45pMvmput161y/qXkTgWEMmeo0/U/43nQ==
X-Google-Smtp-Source: AGHT+IHNx7+UmjF9W1s0KUpq9aMhYrtR2jKKs3fCF/xNfwzjaAHa7dtVXDd9hpF02tuNTWzm9q55Kw==
X-Received: by 2002:a05:6830:33ca:b0:7b2:8ab:69cb with SMTP id
 46e09a7af769-7c27cb2baadmr4160069a34.18.1760892521477; 
 Sun, 19 Oct 2025 09:48:41 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c28890e24bsm1817455a34.23.2025.10.19.09.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:48:40 -0700 (PDT)
Date: Sun, 19 Oct 2025 10:48:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251019162234.GQ6688@bill-the-cat>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E6B/aJvH9ADpOBJh"
Content-Disposition: inline
In-Reply-To: <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
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


--E6B/aJvH9ADpOBJh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass wrote:
> Hi Kory,
>=20
> On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
> <kory.maincent@bootlin.com> wrote:
> >
> > This series converts the extension board framework to use UCLASS as
> > requested by Simon Glass, then adds extension support to pxe_utils
> > and bootmeth_efi (not tested) to enable extension boards devicetree load
> > in the standard boot process.
> >
> > I can't test the imx8 extension scan enabled by the
> > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > I also can't test the efi bootmeth change as I don't have such board.
>=20
> You can test this with sandbox, using one of the bootmeth tests,
> perhaps. Let me know if you need help with this.

But the question is, does the real hardware platform work before/after
this, not does the sandbox test still work before/after this.

--=20
Tom

--E6B/aJvH9ADpOBJh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPUWYQAKCRAr4qD1Cr/k
CtvMAQCnHc3B14yR1AzE+nEqEsTTVkPjLhoo4raqq6g/vRMeAgEAz0j03aqmeTKE
JT2JE5jT3q+ww55URnKD+W0Nopy9DAE=
=0mRK
-----END PGP SIGNATURE-----

--E6B/aJvH9ADpOBJh--
