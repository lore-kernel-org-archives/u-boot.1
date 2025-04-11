Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A8BC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 20:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F8E8422F;
	Fri, 11 Apr 2025 22:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k5F/89o7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5A484230; Fri, 11 Apr 2025 22:29:18 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 750F48422D
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 22:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-603fd257386so580987eaf.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744403354; x=1745008154; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=slOUkeFiBJ+XaoaAeeK8id66GvphH6tVVIsiY9ix9g8=;
 b=k5F/89o7ynsCYrvg/osW2h9SD8g0cnuW9xcSWDPgw1PEWbzmDyQkL/Mw08zXwfJ2lL
 DLrqgb1J3XoRLVCLFnz78EcHyf4aCBifciOQXjfZb8HieMsUrq61GuTOv0rxnby7CPcY
 lcsOiwFLbMknbQOw2cM5fWFu2IlgVylkr4DqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744403354; x=1745008154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slOUkeFiBJ+XaoaAeeK8id66GvphH6tVVIsiY9ix9g8=;
 b=E/sDgYLOcOHol1+nULOK5d1PzILDCZuxJ5sLSSqcjX56HkwNGwkjGKTKiZNytS0qFl
 Wg5wBPrKFLQxW3lDxVkvFD8grIjNvbhVsN2UvWvb2NcVTILSLs4DPPVJMUvtPVmlSzwZ
 ZqemnwvUGIhK4Vak5b7Dfw46qBfWRDUomd0julheGlSIEIAKUMjqSZ+nSpaKJNESwAkA
 kMESpRvtE10Znf+2LmNzJ1iuIe31ITC4Tw6xNm3DYcKxnei/e2x92Tp8AEAoK4KAsIxe
 fyvrSztJW6Sk+x1HatbcOrhY+mNenbxPg636BI28x/8TRQq+AOTisVeW8IaeDzTf5gKw
 oEEA==
X-Gm-Message-State: AOJu0YzqxumsY8mCVwKpJusIqaYk/VE4/OuStnpQ9vsPNeak7g4SvzLR
 +iaS2QLIoZlEf+a6Xodlp2XcptoIoi8GNwO7zSe4Xq83rx3Y9EdzYOivBz/jbzE=
X-Gm-Gg: ASbGncvV+ETJCqj4JhiqLB2xoRWXIaTqzqlEgmfO4MvEfxHDoFKLUHKjbYlULVGtCUu
 cfA9x46CXny8WK6Yn/36yuDMNyJ2+XLtpuDadcYvKp+ICHvVTgPzVz/VLz6lSWSb/DDxKEc+HyD
 R31nsyMKHl0DsFFO4WzgvNbqOAaMepw9w/WfU7XKb68EGpGe88BzRG83MJrwkjuZ+TYuJqtrmDa
 dI0Vp5zFFZGfwfZNlFYcWtPf6JzqQXPCIBO4BTkrJ7KdEJEF+JzJlylaXj3SuIJeTlibjqXRINZ
 FKPoZzxCHEgRuJlngVQpoXceyN+NivYASCWZLlYjs6w9vmTCIivueNCM/0SYhTEupB6/biiT2W6
 ADA==
X-Google-Smtp-Source: AGHT+IEj2DyGDDCNXBgDsncfTgg0IpMzEwl/Be4aircJRny07DUf/1AR1qdLMuRzb2xf/wEEQXlAaw==
X-Received: by 2002:a05:6871:64c9:b0:2c6:72d3:fc93 with SMTP id
 586e51a60fabf-2d0d5cd3278mr2349433fac.12.1744403354030; 
 Fri, 11 Apr 2025 13:29:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d0969b721fsm1292222fac.25.2025.04.11.13.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 13:29:13 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:29:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 00/16] Uthreads
Message-ID: <20250411202910.GA141451@bill-the-cat>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="94WYbRju/vUEBzuz"
Content-Disposition: inline
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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


--94WYbRju/vUEBzuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 02:30:54PM +0200, Jerome Forissier wrote:

> This series introduces threads and uses them for two things:
> - Improve the performance of the USB bus scanning code (scan multiple
> busses simultaneously),
> - Implement background jobs in the shell via two new commands: 'spawn'
> and 'wait'.
>=20
> The threading framework is called 'uthread' and is inspired from the
> barebox threads [2]. setjmp() and longjmp() are used to save and
> restore contexts, as well as a non-standard extension called initjmp().
> This new function is added in several patches, one for each
> architecture that supports HAVE_SETJMP. A new symbol is defined:
> HAVE_INITJMP. Two tests, one for initjmp() and one for the uthread
> scheduling, are added to the lib suite.
>=20
> The schedule() and udelay() function are updated to become thread
> re-scheduling points, and mutex objects are introduced. With that the
> USB stack initialization is modified to benefit from concurrency when
> UTHREAD is enabled, where uthreads are used in usb_init() to initialize
> and scan multiple busses at the same time. The code was tested on arm64
> and arm QEMU with 4 simulated XHCI buses and some devices. On this
> platform the USB scan takes 2.2 s instead of 5.6 s. Tested on i.MX93 EVK
> with two USB hubs, one ethernet adapter and one webcam on each, "usb
> start" takes 2.4 s instead of 4.6 s.
>=20
> Finally, the spawn and wait commands are introduced, allowing the use of
> threads from the shell. Tested on the i.MX93 EVK with a spinning HDD
> connected to USB1 and the network connected to ENET1. The USB plus DHCP
> init sequence "spawn usb start; spawn dhcp; wait" takes 4.5 seconds
> instead of 8 seconds for "usb start; dhcp".
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D446674
> [2] https://github.com/barebox/barebox/blob/master/common/bthread.c

So, we're nearly there. But there's some CI problems. First, CI isn't
testing this because nothing enables UTHREADS. I don't know if we should
enable it by default on qemu_arm64 for example or not. But for testing,
I added this to .gitlab-ci.yml (and something similar would work for
Azure):
qemu_arm64_uthread test.py:
  variables:
    TEST_PY_BD: "qemu_arm64"
    TEST_PY_TEST_SPEC: "not sleep"
    OVERRIDE: "-a CONFIG_UTHREAD=3Dy -a CONFIG_CMD_SPAWN=3Dy -a CONFIG_UNIT=
_TEST=3Dy"
  <<: *buildman_and_testpy_dfn

This however leads first to unrelated tests failing:
https://source.denx.de/u-boot/u-boot/-/jobs/1099921

And I didn't see if the new tests ran either.

--=20
Tom

--94WYbRju/vUEBzuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5e4sACgkQFHw5/5Y0
tywjHAwAoQ/DjgFBRt/mncSaR7ueJhejvf/GGGc71mVOKtXblZClwsrGiXWN28B9
2wCm1UNY/GbJN//+oJHx5lyjh8nq5o7TOi5PS+dMJ4zUyge3ZwqP7OpPga1Rfnre
ZXBEzoMQauuCyjM2ZTW5O8S/V+viojNqZrT6JqZwhdH/WoRWjnyRaVn3Rnqz0V5M
QLmVmaotqt070+Re63AWrYt0q68MVLaa7mpRYFyOsTvQUkQseidwvBTHdv8PBfml
No4Tr2dlK66k7VQAegHiOR5kxe0lVzaDIZOU4XZkGM5m45e5Anh016tVCJJ/CE9q
MORufH+jEPloOWZ9edZa+ivhK6pntVdBDn2U5F/fcIOIuNYT3i9ALvaQSifhRCSZ
thuDxxVeRBNTmrjDk2HIImKS51pG/5myfrjiIrJk6dDmcN/wjmBugxfUOvQUVjy/
X9CcKc5izvKFu4ooUcQ+YHOL5wRxPp8IjPu0hDWkY3SjaWNViPW74drKZC/518ai
TRFjF6wy
=ygSf
-----END PGP SIGNATURE-----

--94WYbRju/vUEBzuz--
