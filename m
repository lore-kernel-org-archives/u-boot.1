Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2E7C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D398787D42;
	Fri, 19 Jan 2024 17:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z4ySfY/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F04E987D42; Fri, 19 Jan 2024 17:09:19 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0E687D4D
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5f8cf76ef5bso10947967b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680555; x=1706285355; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0NJCxOnfDsVlY9+M6e5rkAxZoJ92IOvH6zk6bqDVmhU=;
 b=Z4ySfY/XmZSCbrNZSpbAaNfuKhLDQcf4FUe6iyDXyE/9Xg9t5AReLuLjspv+DKbusL
 eItBdkl7v60t1/WNSSG+n1bE3yFPPYlI2A3G60AUsrUZXIJwiGMVHvAkjGfUPezBgTy1
 yrmJlBUfshMRP2Y+Vdy/nbp2Izr6Veidblsxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680555; x=1706285355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NJCxOnfDsVlY9+M6e5rkAxZoJ92IOvH6zk6bqDVmhU=;
 b=M19NBUxQbpCDVb00A5l9rq/f9iRmM9mctJgBDxyr9/AxVMPL41yxFM4w9PygDW11BD
 AzoC7AMkqj7P3BTd7gKaJMNKeqVC3h6gbC76LfXh4DgzkB4Ag574h/hZCHQipuZZtaJT
 Zr5VeO5FFRRshY0GnSSJMKxcWyKo66hEaCpQbhn9lXvKOZmkk4cZrE5oXrn/po5MFcNY
 YAtdwuiHIQ9ifzgQZEOIH53Pgzon+yca0wgvVRiI9JvCsmRfaQHVsTkG+IEnEgu4y1Tm
 00VT2lAR9sM+ig7xJHdcFxQQ9i6IJQDyDgkEGpyNUcmydFKBiZHiPqGbQjRGkxpfNNnN
 kzaw==
X-Gm-Message-State: AOJu0Yx96AWs0aTumHWF7hYiZL5ISAfqjG6g3HTs4JsphFATHSml1gdm
 tRBVffPMWfo8Uh8nSY9h5IcHIytI3aCpxqcX09Cb06E8yhFqdSDGp/5xLo7siQLauGkyZmTbRjW
 j
X-Google-Smtp-Source: AGHT+IEbVm7PzbVDE4hNKWKl32YPknluo1ifFPp5ZyBIawWn9qiBXSxILUM10nDFb/vKDBJG9wstmw==
X-Received: by 2002:a81:8201:0:b0:5ff:86ea:47be with SMTP id
 s1-20020a818201000000b005ff86ea47bemr123026ywf.92.1705680555424; 
 Fri, 19 Jan 2024 08:09:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 g189-20020a0df6c6000000b005a4da74b869sm7624007ywf.139.2024.01.19.08.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:15 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 2/2] smbios: fix matching issues for table types
Message-ID: <20240119160913.GX12635@bill-the-cat>
References: <20240111143936.983448-1-ilias.apalodimas@linaro.org>
 <20240111143936.983448-2-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jQprGdx/NxbwQoD/"
Content-Disposition: inline
In-Reply-To: <20240111143936.983448-2-ilias.apalodimas@linaro.org>
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


--jQprGdx/NxbwQoD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 04:39:36PM +0200, Ilias Apalodimas wrote:

> commit 738b34668f28 ("smbios: Fallback to the default DT if sysinfo nodes=
 are missing")
> allowed the code to fallback and fill in SMBIOS tables with properties
> from the compatible and product nodes of the DT, in case the
> 'smbios,sysinfo' node is missing.
> That works fine for Type1/2 tables, but for other types we need to
> match the smbios,sysinfo subnode name as well. So add it to the
> smbios_ctx and check it during the sysinfo <-> DT mathcing
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--jQprGdx/NxbwQoD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnqkACgkQFHw5/5Y0
tyzKOwv/VZTrZpnZ661+vbpArCB6fmnTPL8WryLl0IErvek2FkwgolWHR9vBPeK4
mEUq6/3F+lhUO5Gc/tzoGoVNa6NrnAhYVJstZtr/gwD5esmVrFxFeWUrs2oX73/4
ubQOd6J7kNF0RzfeGp/VGcQx19xaYfHsA6N/ub0Tr532eOVUeVnMDfzsPVXGd8h0
DP90o1K3xYwnmAEo5wTVBzmmdzrc38ckX/RWnIx0YEKnyngRdwbJeq+rt39qA472
fyozJJ8H95QZjsLJZbZiBcTFv0N5mhDSUx7f07kAtXQe/exjd9MWmfYaBVHfS/RH
HeWWCil1QHDEo53qoJ3kWxY/qlA/+RSRzunmq9Hssvor+lBWWTNqqydI+YwFRF0h
+zdH6Nb4A2Y3XNQcSLFTokIeVBPOIZJOLoCzp3SMeec9kbqCApL/Dlr7T8ST6mky
xlqmC9SgcFKgTXuJ5Mxvmv0FCjZrQgkSRi87tyJMWUnNjjp8m+Y2MSbkbzn8RVbY
/Ocs+71H
=gJRw
-----END PGP SIGNATURE-----

--jQprGdx/NxbwQoD/--
