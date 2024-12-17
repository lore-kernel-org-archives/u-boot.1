Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B2BE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425C2801CE;
	Tue, 17 Dec 2024 15:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n86f/glF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B07DC801FB; Tue, 17 Dec 2024 15:53:07 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A7BE80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-467a17055e6so55401951cf.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734447184; x=1735051984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BPW4v8apBbQmxsH6S1RtIxiyaNlQLNMNkqGakzQDYV4=;
 b=n86f/glFflIM6jVIMHlY2+WH5Cmkm2i4O6UYHS9Jzc2lpvZ21BQ8qL8b4iAhBA2R1N
 XX8TjP468UeCxhnyts7ahuMpw4B/UOaFQbM42yq5YApt6lyvcyzuTW4EwwxW/2djYoIP
 5dRj+hLSwJFSSfYnRCAsDQC35S9iXK7Yo5h3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734447184; x=1735051984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPW4v8apBbQmxsH6S1RtIxiyaNlQLNMNkqGakzQDYV4=;
 b=QYyxLXl+nRn+feb3oadBk00ifo0fng5PLi7BBATMJwMyL1lUnn6m5/yT1u/HMTn4ly
 +2jKtuq1FShhpwrzetT4bhE01JqtpTIQsrgbGMXJaOgYSARKrm4Y0E7RJ5ZIh39LmaDF
 SQKk918anN0JPk5S+3PeJZ6GDVscyAe2w5f8Z2NwYIIqfQiBWwWW0RmT9g07JLDXq+08
 k7HLUOCOqPyyUsZ+qMqBNeoc8k3d1yvo+qsFFyj07Ygl+ZNFGiBuLVmcD2cpI9Bm0euQ
 Iy72UrknPTGyAXnXGpFl2qIddsGZ5JpNabABjApr8pHdn5AWLe8Tgfjq65h+L22lAGV+
 7KYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNtFgDTvgmS2BC/LK259zj0xlMiplFYTMVSAnm6Zgwi+zG8//mJnbgu38rhCJ1LrH5izUyJvI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxrr6WnzIxqxo5nlH2DEPRQzcQdnVBcKPM6Yt0XN1HQGHvPZNyy
 wCRZYEn4cpwMprhJBJ/jZ94JSdPPnCQIybQMeMuzBRJTJkrPrje/VvbZFMRRXSk=
X-Gm-Gg: ASbGncs6+RRUUfmRXgw1usLU2dovI4oZ8PTRok4Iz7X6GfBUjcSKv45EcD+1Qg4yAk8
 ltULZvFI4+rmaFlfLRfO4W0hAAj2C+RgdfndAgB13HKvsHeIFL8JOwajfdTQb7ZioDswRVwHrBo
 bym1xfWgFrtjXHRtUkpMUCx8Tc4bdNxQBB0fPSp2JjpzaISyP21K8nK6AMi3HZtDx1BMIMZoie1
 XBbExWyOUraR0M4MpIwAm3f5X/LBzKppzHbjBUCul3tzBJPK2jpSlG1
X-Google-Smtp-Source: AGHT+IFvvlJeuhoCOXCh2sxsuKXckhEfJ0z3evk+Y8947IcqnSde8m952GrPvmuunbKbPQ/UB/T+Eg==
X-Received: by 2002:a05:622a:149:b0:467:7513:3d8 with SMTP id
 d75a77b69052e-467a57559afmr305223131cf.21.1734447184445; 
 Tue, 17 Dec 2024 06:53:04 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cc2a51sm39678461cf.49.2024.12.17.06.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 06:53:03 -0800 (PST)
Date: Tue, 17 Dec 2024 08:53:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: firmware: ti_sci: Add DM_FLAG_PRE_RELOC to driver
Message-ID: <20241217145300.GN1505244@bill-the-cat>
References: <20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ReyPJ7l7KKEXbm1m"
Content-Disposition: inline
In-Reply-To: <20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com>
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


--ReyPJ7l7KKEXbm1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 02:24:37PM +0530, Manorit Chawdhry wrote:

> Currently the driver relies on bootph flag to probe it during PRE_RELOC
> stage but with the upcoming cleanup of v6.13, we don't have the bootph
> property in the parent nodes anymore and ti_sci driver being one of the
> parent nodes required during SPL stage would end up hampering the probe
> model [0].
>=20
> Add DM_FLAG_PRE_RELOC to ti_sci driver for mitigating this issue.


Can you please expand on why with v6.13 we don't have the flag anymore?
Thanks.

--=20
Tom

--ReyPJ7l7KKEXbm1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdhkEwACgkQFHw5/5Y0
tyysWgv/aVwtADLWaPwW+UeHlnrl7LMrNdkyZqxuRb4mqIeleIQryw/GmhiEeDD4
Q2EoQd3PWCq50iIIeuT7o3JG0qk55nFazXzbp+Cosl0gdnJC9r8H7ZWHLsrdHRbS
4eeaOSqbrDX3bxbQmmxfx4zArmKChl8uifw3f8uWb/HNQymQeYIefuCJh0pKevFj
PyG2VIbP5Zbf2dgJDiXcP3ei3B4r6OtIQc+2X4aOqJgQ5jxrfq0rxMei9GLbZxh3
ppwfILAWJpPXoX6VYf3fBRdNuqhTESyLOxrtiMHRAVQl3TOhSnBATGdYTAiQbJsq
+F7Z+mbWgvzEPihrW0RwO7HLXjuro6su6/uUi2IuYe33rGFRCvHZAjw62FTHZSCx
WSRM8at+TLv3ZdbknfN0n3M+bAiny+0IyrSdzq9d9Up6jmKKqGmErehf8gfQsLZS
UtNONgKDOh8Ue1363LLQCcRqqUPQAJSaO/1rTGRMSIXJ+GL6ue8FJb4Qc8IUe0J2
HUfVNSKo
=oaL9
-----END PGP SIGNATURE-----

--ReyPJ7l7KKEXbm1m--
