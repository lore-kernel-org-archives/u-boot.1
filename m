Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C30C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C9880A55;
	Tue, 11 Feb 2025 14:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U/DCTvbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6317280AE5; Tue, 11 Feb 2025 14:48:10 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 893C9803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f3e2b4eceso105035065ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739281685; x=1739886485; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8lRr7wTxgucaEVniWd1fMq8YHlGtTmDXRbG+xpGFgYo=;
 b=U/DCTvbfvVW1LBgdFVtRqbqQR7BM/GYtiL5vlHgM5IBBRSzCaLN7/136z1pfErWy4Z
 9gMn5nUo0DYR8b/3EprfmdHEvU/5PS/pVVFgSp74i+DUb76RAasZydQ/q4KLPw8CoVzv
 kLTX/K0t6HCeAXlu/zOTk4FCqQwLJ+ZzAURJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739281685; x=1739886485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lRr7wTxgucaEVniWd1fMq8YHlGtTmDXRbG+xpGFgYo=;
 b=oenMFkmki24hfg2wPRSwU0VZHnIM7IMvHJNuT6jIXszM/YZOAN5AZwIUXjyFqR/c2n
 F+++JF0yftijCpYmtZeoQvpDY12ZO5eYh/U2OnNWecgsmkGQ3VRtOzcH0C44HXFXA7/E
 Hlc4D9TbjjACgffDPFLLvaY65WNwULc4AZPnbcDAoJSaB9yFbhsketJf4hHgzQa1V0yJ
 lgJDo0seioJzqxfYEU1fxPTqKkxEBr2tsiMrw5yqGnEZIaFBC0TXJzXuxQrRurljv2jW
 jgiDp2EjG+MRQhnNHeXgaD95aeMJUsv+z0yKs/EUuUdNBGspv2EAO2QsU4yZ1st0GiJ3
 Jf+A==
X-Gm-Message-State: AOJu0YwUf0bX8eMsG+hT38dHoc5++VSbtKpvexaG1NkqwTzFrTthhuZ8
 Q+GxSb8GH9ypSVvtCmezjh1aJ7ru/2cfUWRFceB6Qp9q8yIoJsayPDVnPHHY3Mw=
X-Gm-Gg: ASbGnct6aP3KCnSWdVSfQYBL8/ja9eJBRitF/ML6QjPTr7e1DdZWQr7TD3fbRKVJZGA
 S+EeuwzaWfO9qrZCjAlyv8xvk79Vu5licl0su4F0M68GHtFgQK1OqkQh6FReCAan/sqsBcAAtAf
 xRsX3d6NydKFrDUZWrk5Wio5rLG5BkFTNHYt45f/dKFXFCNqWuUsx2yLxg+1OK3SYDQorJyam+w
 E0/mjbbCMN6m5e9LMR25m1auPoenDd3f0RIwsNrpd1AdskFd2pRV7Mqw6xadkQr1B4dxIPmi3zS
 CMg0sSJ2xkTWUZA=
X-Google-Smtp-Source: AGHT+IEzklYo/lEfAw2Ng6ayvaQyjz3/YrTOmulZ3sP+B8LFCkbYGCDGVBSLwOcMNwPrMXZIjTHl7Q==
X-Received: by 2002:a05:6a21:158c:b0:1e1:aef4:9cd0 with SMTP id
 adf61e73a8af0-1ee03a24237mr31567863637.3.1739281685026; 
 Tue, 11 Feb 2025 05:48:05 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048ae7baasm9441254b3a.73.2025.02.11.05.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 05:48:04 -0800 (PST)
Date: Tue, 11 Feb 2025 07:48:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Arnaud Patard <arnaud.patard@collabora.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] drivers/Makefile: Fix TPL build with dwc3 generic
Message-ID: <20250211134801.GX1233568@bill-the-cat>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
 <01020194f07b459d-184820e6-90c2-44fe-9850-f57fc2ebaafe-000000@eu-west-1.amazonses.com>
 <20250210155158.GH1233568@bill-the-cat>
 <307b64aaf037c16efde86ceb0b43d7a3d6db14c4.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XEQNvQCK5rcJ0lwh"
Content-Disposition: inline
In-Reply-To: <307b64aaf037c16efde86ceb0b43d7a3d6db14c4.camel@collabora.com>
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


--XEQNvQCK5rcJ0lwh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 09:51:50AM +0100, Arnaud Patard wrote:
> On Mon, 2025-02-10 at 09:51 -0600, Tom Rini wrote:
> > On Mon, Feb 10, 2025 at 03:29:58PM +0000, Arnaud Patard wrote:
> > > When building TPL with DWC3 generic enabled, the following error is
> > > occuring:
> > > aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in
> > > function `dwc3_glue_bind_common':
> > > .../drivers/usb/dwc3/dwc3-generic.c:527: undefined reference to
> > > `usb_get_dr_mode'
> > > .../drivers/usb/dwc3/dwc3-
> > > generic.c:527:(.text.dwc3_glue_bind_common+0x20): relocation
> > > truncated to fit: R_AARCH64_CALL26 against undefined symbol
> > > `usb_get_dr_mode'
> > > aarch64-linux-gnu-ld.bfd: .../drivers/usb/dwc3/dwc3-generic.c:529:
> > > undefined reference to `usb_get_dr_mode'
> > > .../drivers/usb/dwc3/dwc3-
> > > generic.c:529:(.text.dwc3_glue_bind_common+0x2c): relocation
> > > truncated to fit: R_AARCH64_CALL26 against undefined symbol
> > > `usb_get_dr_mode'
> > > aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in
> > > function `dwc3_glue_probe':
> > > .../drivers/usb/dwc3/dwc3-generic.c:683: undefined reference to
> > > `usb_get_dr_mode'
> > > .../drivers/usb/dwc3/dwc3-
> > > generic.c:683:(.text.dwc3_glue_probe+0xb0): relocation truncated to
> > > fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
> > > make[1]: *** [scripts/Makefile.xpl:544: tpl/u-boot-tpl] Error 1
> > > make: *** [Makefile:2137: tpl/u-boot-tpl] Error 2
> > >=20
> > > Enable building drivers/usb/common.c in TPL.
> > >=20
> > > Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
> > > ---
> > > =A0drivers/Makefile | 1 +
> > > =A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/Makefile b/drivers/Makefile
> > > index 0e1f58c515b..7cee5750396 100644
> > > --- a/drivers/Makefile
> > > +++ b/drivers/Makefile
> > > @@ -78,6 +78,7 @@ endif
> > > =A0ifdef CONFIG_TPL_BUILD
> > > =A0
> > > =A0obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) +=3D ddr/fsl/
> > > +obj-$(CONFIG_USB_GADGET) +=3D usb/common/
> > > =A0
> > > =A0endif
> >=20
> > Do we really need DWC3 in TPL?
> >=20
>=20
> No, not really but I failed at finding a way to not get DWC3 built for
> TPL. I tried to modify the Kconfig files with no success. So, I took a
> different approach.
> For DFU over SPL, it's obviously only needed in SPL for DFU and in u-
> boot proper.

Please post something that introduces the failure so someone can take a
look at it, thanks.

--=20
Tom

--XEQNvQCK5rcJ0lwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerVQ4ACgkQFHw5/5Y0
tyzvRAwAjT2+TzzetKbQaVrs+nGhqcaqZv75OkQkzAh7nVCnhyK4udE+0V1R1Drg
825vD19DeVNwoMmvZlrrZ36uJDsoY6EONlXkHqtNt0bX67SjldCtBbnYU3hDxDgn
n5YxXZTdDCegK6H/dOUtRu5itpTD8XQ9pCnDrBoHHaL2T94TenvGCtwxcFUuJ1Ur
25T7Wt6nC0uzYwnL81RruPx3urhD6LWN4S19S+MDfZCJvt70JY1tU5Aoqbrip4Uu
hmkHh6bGotEXXViRHL4IVm7Euj8EBiZhVS/0P2JrhB313P+JAUOCbEBAThGcr+L6
ZeOK2G1asZZpS1MPemnmHRD0DCR2UMAafFTKse82eghIdMVeEt6ni50p5VQOBwhw
6jh+PGo4W7aeQLfVO6v1LGnrnMF+lsnFMbG41SdSetj0hQEiunYIeIPMiCfsnT2R
WHefdQMCiM3W28geRcHKJyEsE+w2lJkwFyelpvPL2v4cVZF6R6PxeV58wF+u57YS
fyPwgNxt
=defM
-----END PGP SIGNATURE-----

--XEQNvQCK5rcJ0lwh--
