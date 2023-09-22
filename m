Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21468CE7A86
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 22:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7B986B09;
	Sat, 23 Sep 2023 00:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B5WDb5lB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4D986B0D; Sat, 23 Sep 2023 00:26:50 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE74864D4
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 00:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d818d65f23cso3319100276.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695421606; x=1696026406; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y1Sg2kWI2FdttDKhFilpK1kySN40VP/d+Ttc+f2UyqQ=;
 b=B5WDb5lBOXnK5MHbWS3Jq0Z0fqGYyaG3ZRnVOo6tZa1f9XxOj/plCOCX1SVulDw1CI
 QC91a78Isuto1suRhTD0wiM76xa/4Va9Vv/TayMU03zKkrGh3R/xBJ0bG5nv37yoFHdq
 sxlUclBh2ybag+WJIgN2vxuRRlMS40sJJaieI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695421606; x=1696026406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1Sg2kWI2FdttDKhFilpK1kySN40VP/d+Ttc+f2UyqQ=;
 b=G2Nkn4cn5zcCWB92tvvC55gV4ivk1yIFNSW5ZA7iGnxt87f/JGNRJ4KQzJVd+UahgE
 wpEhwQTTniTkEv97u6ZLRekdEiyoXV7U0PdGU0n8WfULT6+2UZO+T6LU1nDDTqZtXZVc
 KIlGn3DCKeJRrChqJphnAtzdWWXaLjqRTlUAK2j9gTh9nGm/HaHmEiDK3I4LBriEOFaR
 pi/ieYPN+Zi+1736JGoJSIxtHuk22LtjNv8lZl3EtuaoVC1Y6xCCjcwoQM4CTPTS7Tyy
 TYJyUeKxnsW5ANhiU8EaE2YEHznZtatvNqtZmgavz5U8mkGpodSBT+kVYJNr+Q2+Qru6
 Olrg==
X-Gm-Message-State: AOJu0YzcedeLBzndgr35EclE/Zyvtx+g6/0/WSbBBuAyLAvP38J6sVdT
 HqcDMpyICEo9rwmaWfEVUAcUxg==
X-Google-Smtp-Source: AGHT+IFErVKx8PN7ZBf5hzpR53V7Og1u0fbGt3pj776BqOAenrshibqPsj0+MqyWmA04uMZ76SpggA==
X-Received: by 2002:a25:fb0c:0:b0:d77:dcff:e7b2 with SMTP id
 j12-20020a25fb0c000000b00d77dcffe7b2mr562321ybe.39.1695421606675; 
 Fri, 22 Sep 2023 15:26:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c83a-32d9-8f81-ed72.res6.spectrum.com.
 [2603:6081:7b00:6400:c83a:32d9:8f81:ed72])
 by smtp.gmail.com with ESMTPSA id
 142-20020a250394000000b00d8161769507sm1057144ybd.25.2023.09.22.15.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 15:26:46 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:26:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: u-boot@lists.denx.de, rogerq@kernel.org, angus@akkea.ca, srk@ti.com
Subject: Re: [PATCH] configs: am65x_evm_r5_usbmsc_defconfig: Enable DWC3
 wrapper for SPL
Message-ID: <20230922222644.GG305624@bill-the-cat>
References: <20230908110351.21369-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fRuU3FDXucdrCjBw"
Content-Disposition: inline
In-Reply-To: <20230908110351.21369-1-r-gunasekaran@ti.com>
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


--fRuU3FDXucdrCjBw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 04:33:51PM +0530, Ravi Gunasekaran wrote:

> commit 280f45d23977 ("configs: get rid of build warnings due to
> SPL_USB_DWC3_GENERIC") missed enabling DWC3 glue layer for
> usbmsc_defconfig and this broke boot from USB mass storage.
> Fix this by enabling DWC3 glue layer.
>=20
> Fixes: 280f45d23977 ("configs: get rid of build warnings due to SPL_USB_D=
WC3_GENERIC")
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--fRuU3FDXucdrCjBw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUOFKQACgkQFHw5/5Y0
tyynIAv/eGF9NipmoG0GPEdrp3DlsZword6MM/53y3TKMVNE+ZsC2r0XUSd0Pebq
sABiE0L/OoAjgJc5xRRL7UCyaji4KDTRZbP+sAA6tZSKlBHUfo0BYoruIr0++ZYA
JLnEb4WzbaMB3lQJ4/wXHMK0d+l1tBD7Beq2Ae2S0ZcuhOF0jMcVReZA4zgLKvMl
Ijb0pi6RRDF02cGA/3QT6+tG8IkGDbEMF0WUKEAFFTxujvwruheDR1t6BwJPj3z7
XlXSM7tyUtTaPW6TV6UILf6329ChOnL2SgZ6XJ+ONN/5CkpJ33kzguIYF4WzZTFQ
920eA35Ipa9WQFS7gN4oJqvJP8cBbJ1IsM5keuufZQVpsqM/mYuSAYNbIr62NG8g
U8SDp6kRNzC3K7uSQlmqDSwpNV5p11nS55q/QFuyVTX89R3Y1lkvgyBSwOefBujH
93v1pmVwGjdkJ3vxya9BUinHCeXSkcd+ZpL2MlrBB9uW6VL+TTiLXTu7++2GGllr
1zfhiNx4
=DiY7
-----END PGP SIGNATURE-----

--fRuU3FDXucdrCjBw--
