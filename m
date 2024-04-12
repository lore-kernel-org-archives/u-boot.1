Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F2FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 19:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF3187E50;
	Fri, 12 Apr 2024 21:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hkTyzzeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BB287E62; Fri, 12 Apr 2024 21:45:18 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0603E87DF3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 21:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4345f35daa7so5711661cf.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712951115; x=1713555915; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=03y5jqK219BrUDZ3VRxZ+HjXYF37tereg9nmMNQBydE=;
 b=hkTyzzeWcmrVorm6uHRJpQ2sKUoms4fdkCZWduW9R90xwa7hvuMedgqHVIJIUDV1hA
 15Qdw9lI4tBANvKpX9C19oV2i1Pi+3ygNDu4icq1z2cvjnqOzWkewFHSq+1IZTC3e0se
 iCvCtFYEctru4EEZ/WvmWdM9i0rYHFoL2MslA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712951115; x=1713555915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03y5jqK219BrUDZ3VRxZ+HjXYF37tereg9nmMNQBydE=;
 b=drJaLKqN0eYi2s7ZIlqU/sMnu0ny6muWfZZe2aZ0FUDm3CUXB8iHHzwgzy1HJI8R7l
 fTsMrnQD6UdG0K0r+Nc1AcRoGQ7674fa5wrMpF3StYzZNTKorUUj3qS7ebfEdHtqd3Hn
 RDrx+T0dF44kqBM5UH+d2kuJiZSQ68yHk4i9Z2UjV3AqHIk+4F7orxBoCR9uOaVWoeBb
 K84gUL0PQeWmFxmCr8AWFWDGIQop1ofJT7m2rmy1Zd4IYMCNKkfGk2VpoS5M/zNoqCJy
 1YougaIE1iXDwEV5lXb+6D0M8mFLFe4HIBwoUCWvCTlpKBw3PAbs8Hv+v4UKbCUcA+bR
 PO3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmiwYfn8hwUAEdxqXbuQGSk+ePeWgYeNZOqa1sBcKWQr3ql5mwgCLIm8kgqS+L+6fcIPAD/az6xg1v3cBjYArjtx0mNw==
X-Gm-Message-State: AOJu0Yw59aGQcXQVnohSO8+lQnvwh8EeN6s1aQVT5n/ndIm05LrCFZyL
 LP7hiT/TDY5wfxwShd/AxCUjEn5DTCXm+a6UYkJaWYnVCBWFZPNO7gAKLR5puos=
X-Google-Smtp-Source: AGHT+IEkTLBZMobVlSx/XM7vd8j2HSiEClO9W3bQCv4ZMsf9947Nc8fk9J3HsRqX408wh9NgKdEObQ==
X-Received: by 2002:a05:622a:1186:b0:436:93d6:90dc with SMTP id
 m6-20020a05622a118600b0043693d690dcmr2602428qtk.8.1712951114844; 
 Fri, 12 Apr 2024 12:45:14 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 k2-20020ac84742000000b00434946547d3sm2599299qtp.53.2024.04.12.12.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 12:45:14 -0700 (PDT)
Date: Fri, 12 Apr 2024 13:45:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Artur Rojek <artur@conclusive.pl>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] event: add an event for livetree fixups
Message-ID: <20240412194510.GY2493117@bill-the-cat>
References: <20240412190542.1576801-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nl0KJVF8ni8yOKlO"
Content-Disposition: inline
In-Reply-To: <20240412190542.1576801-1-caleb.connolly@linaro.org>
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


--nl0KJVF8ni8yOKlO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 08:04:02PM +0100, Caleb Connolly wrote:

> Introduce a new EVT_OF_LIVE event to allow for the livetree to be
> modified before dm_init_and_scan(). Boards can perform fixups here to
> handle incompatibilities between U-Boot drivers and upstream DT.
>=20
> This will be used by Qualcomm platforms in future patches to enable
> setting the dr_mode property if the board doesn't provide one. This has t=
o be
> set before dm_init_and_scan() is called as this property effects the bind=
ing of
> drivers.

This doesn't quite explain why the answer isn't "fix the device tree
source" and instead "perform a live fixup". Thanks.

--=20
Tom

--nl0KJVF8ni8yOKlO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZj0MACgkQFHw5/5Y0
tyzO3gwAl9z6jMHLsmkVfSmgjwOj3IipUgxKTALgNmo+v6pN8kFoY/c0JTiMcECV
iO2ow9YRHq2ufHKuINXrKn5nkw35WzefwP8L8lfifbjlCxynvyr3K7+vAF2CiCDd
zLj1dB/T8swxZbFEnlATR86iobdY0EgRnxQXdxqd7VHNua1ml93LUOVErDzoaZ84
jMSDImiC8EYuhsdtvemo2mGHmmwhqzLJqa1Ymfbjw4Iq2fP55eV2aHLx/13F8Z29
kHM2/ynh1klkLiY72sKXGLGq/u/sEQTJzAoHnV3N0KTxCooJczwzh1cx8ChGObPJ
Z9kNbpj7FFBY9E0x+kj4tmcU6IKBFnMGp6+49dZWvAAl9dN+Q1Z7giPT2iv49W/E
SkkWVkxptx9l0K+rUs0yojELrTeDu9/wJO572EEjUkG3wGxAHpR8BlMkxAdBOnru
dheGJRN7f1bTEKloOwt9SVqMly5sv4iGb3l/vIO3yH1cRSpj4jbBSUiP+x3R+0uL
k64r1X8I
=UBqe
-----END PGP SIGNATURE-----

--nl0KJVF8ni8yOKlO--
