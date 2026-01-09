Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD3AD1A639
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 14:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66A88432F;
	Fri,  9 Jan 2026 15:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c4ZlEEAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24EF384355; Fri,  9 Jan 2026 15:48:17 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877858352B
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 15:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so3167779a34.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 06:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767970093; x=1768574893; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Un/IqSwA6IwYPeMNgL6Ep0SXlOhv0y/qAshUze0mnIQ=;
 b=c4ZlEEAiyUd6ahVf+X4ZNsMmXw5gW+pMuPSWvGafjJFNcL5CRdbwlz3a5eFs3YLs+4
 h/eNNRkwku1RQHvnTjfCeOg9ldX1BgSlz+3WLHkHwGVZIfUFlEqyo+FF8uW1Kk2ZpLa0
 v1DH49u6s5DV/sm0V/LTlF9YDNcBVkpL9nzCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767970093; x=1768574893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Un/IqSwA6IwYPeMNgL6Ep0SXlOhv0y/qAshUze0mnIQ=;
 b=Ji1kXIy+vQDmIA/TsXKuPHj0dnDcWpoU2l1rFyMu+1lK1sWoTN4ZGI09vEH0yLkRMc
 b2Y2l9fY3/OIiLSh0RBAvLI/g6vWfivHg5mefRk6xD/ZxrQlurHCMCrQRxDcVu6vN0bR
 7eoKSCndBj/LSdAs/dF0EQFOVhDm7dQD0wsvP8F9uN8c/dVDs71w0E/jIr9K0OR255qd
 sRv1vFTmFk4qwAd6YxYZ3NncOSCm/Clq+kNkmBYl3JjwmqnXuJ2c56e9vSQYOVOCaTF/
 cxeJYN5VHsLj2QXlUM5euWxWfBpr800vkAXLimDUgzEqI800/GQvOOYXwvRDOywQh7i0
 J6MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4hds80615/ZCAQeXRCtzDf3QxVGvHL7pQhEB7zUautBWYZ1lpj33j/23PEtguDiklBM0jEwg=@lists.denx.de
X-Gm-Message-State: AOJu0YyjAzg1wFMRemvbc5hhvem0Li4oDgJxtSHlI65J1gNLX9gHGz93
 jVY/mONLopNoB7xOOr3FxHNY9wqeKZzjlwZD2hZO+c8yxGiDUA7LQncBqXeS4C3IaZQ=
X-Gm-Gg: AY/fxX719CpEiUDzoGLBXWZzGNRpP1Acyz5nPysobIwuZwTyRQxBvVgfqypdpsdfYYU
 YqjWhkrQ7AzxoMI5xB4urGwfIA/l0DhmO+GYR2lzX48/XJ6J47pAonQILEy2DAzIjShPrrjoDIn
 obHZ0SRGMwWkpBGaZJOvm+1BGqfh4PfI+9zLoov+wywXk0aek58+xjv6fr7JhtTCICgneiRilU0
 Cyb8n4OgfA+hQMSF+1oBffpsvPNxh7U4PHtcB99Ov0uSNEt22fmf+4xqFV7SQxwWPJl4R1jSBDJ
 UOaMYC2iZGttYWDZIQGf05mTXT+8VkJzN3NP5HS2E4Vws332o4GTC/1RcJ0iH8s2QBjcXgL35j2
 L6HP8HgS3Ldq9ecWK4DXNVGLQfR+i8cj2OzopojhJMuXHlkWTWvOB9R+/LeHibXVPubjJtTCkeh
 0Mpj0oO0alla7z/cBuwAwlRH1XAubfUC/IjaM4jb436xStLF6wOfVqKVaychvVZSLs3pJ3QetTp
 nloI8nlmGykTp2Uv6r/MO7uZoh6+XH5VWAcxpU=
X-Google-Smtp-Source: AGHT+IHSa+36jWOihzymRTNovGGV0otcphHlRZfGreGb6NwgG4SknzmODGhOXYK2Yp/M5k5G5mjFrg==
X-Received: by 2002:a05:6830:1cc2:b0:7c7:6558:277a with SMTP id
 46e09a7af769-7ce508e094fmr5480811a34.15.1767970093111; 
 Fri, 09 Jan 2026 06:48:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce47801d63sm7320364a34.6.2026.01.09.06.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 06:48:12 -0800 (PST)
Date: Fri, 9 Jan 2026 08:48:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Simon Glass <sjg@chromium.org>, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de,
 ravi@prevas.dk, javier.tia@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 ansuelsmth@gmail.com, mwalle@kernel.org, anshuld@ti.com,
 jan.kiszka@siemens.com, javierm@redhat.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/4] env: scsi: Add support for partition type GUID
 based environment
Message-ID: <20260109144809.GY3416603@bill-the-cat>
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
 <CAFLszTg6X8PeD4ZyY08WsTSs+qnRb_-jJjyupzSmi-jDzEhWUQ@mail.gmail.com>
 <bb66d91b-667a-4c28-8acc-b64fa84fb7f6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bo7qz5OUEBE4/OrY"
Content-Disposition: inline
In-Reply-To: <bb66d91b-667a-4c28-8acc-b64fa84fb7f6@oss.qualcomm.com>
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


--bo7qz5OUEBE4/OrY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 02:21:28PM +0530, Balaji Selvanathan wrote:
> Hi Simon,
>=20
> On 1/8/2026 11:12 PM, Simon Glass wrote:
> > Hi Balaji,
> >=20
> > On Wed, 7 Jan 2026 at 23:50, Balaji Selvanathan
> > <balaji.selvanathan@oss.qualcomm.com> wrote:
> > > Add support for locating SCSI environment partition using GPT type
> > > GUID instead of unique UUID. This enables the saveenv command to
> > > work with partitions identified by their type rather than unique
> > > identifiers, providing flexibility for systems where partition
> > > UUIDs may vary across devices but types remain constant.
> > >=20
> > > Introduce CONFIG_SCSI_ENV_PART_TYPE_GUID configuration option that
> > > allows specifying a partition type GUID for environment storage.
> > > When enabled, the environment subsystem uses the new type GUID
> > > based lookup method via scsi_get_blk_by_type_guid() to find the
> > > first matching partition.
> > >=20
> > > This change maintains backward compatibility with the existing
> > > UUID-based approach.
> > >=20
> > > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.co=
m>
> > > ---
> > >   env/Kconfig |  7 +++++++
> > >   env/scsi.c  | 13 +++++++++++++
> > >   2 files changed, 20 insertions(+)
> > >=20
> > > diff --git a/env/Kconfig b/env/Kconfig
> > > index b312f9b5324..97cb3d05daf 100644
> > > --- a/env/Kconfig
> > > +++ b/env/Kconfig
> > > @@ -768,6 +768,13 @@ config SCSI_ENV_PART_UUID
> > >          help
> > >            UUID of the SCSI partition that you want to store the envi=
ronment in.
> > >=20
> > > +config SCSI_ENV_PART_TYPE_GUID
> > > +       string "SCSI partition type GUID for saving environment"
> > > +       depends on ENV_IS_IN_SCSI
> > > +       help
> > > +         Type GUID of the SCSI partition to store the environment in.
> > > +         Uses the first partition matching this type GUID.
> > > +
> > >   config ENV_USE_DEFAULT_ENV_TEXT_FILE
> > >          bool "Create default environment from file"
> > >          depends on !COMPILE_TEST
> > > diff --git a/env/scsi.c b/env/scsi.c
> > > index 207717e17b1..6182ae26679 100644
> > > --- a/env/scsi.c
> > > +++ b/env/scsi.c
> > > @@ -35,8 +35,13 @@ static inline struct env_scsi_info *env_scsi_get_p=
art(void)
> > >   {
> > >          struct env_scsi_info *ep =3D &env_part;
> > >=20
> > > +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
> > > +       if (scsi_get_blk_by_type_guid(CONFIG_SCSI_ENV_PART_TYPE_GUID,=
 &ep->blk, &ep->part))
> > Can you use if IS_ENABLED(CONFIG_SCSI_ENV_PART_TYPE_GUID)
> >=20
> > (we try to avoid #ifdef)
> Thanks for the feedback.
>=20
> In this respin https://lore.kernel.org/u-boot/20260109070912.4106466-4-ba=
laji.selvanathan@oss.qualcomm.com/,
> I've introduced a choice statement in env/Kconfig to ensure mutual
> exclusivity between CONFIG_SCSI_ENV_PART_UUID and
> CONFIG_SCSI_ENV_PART_TYPE_GUID.
>=20
> Due to this choice-based configuration, only one of these string configs =
is
> defined at compile time. When I attempted to use `if (IS_ENABLED(...))` f=
or
> the string concatenation cases, I encountered compilation errors because =
the
> compiler tries to evaluate both branches, but the undefined config macro
> causes an "undeclared identifier" error.
>=20
> For example:
>=20
> if (IS_ENABLED(CONFIG_SCSI_ENV_PART_USE_TYPE_GUID))
> =A0 =A0 env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition not fo=
und",
> 0);
> else
> =A0 =A0 env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found",=
 0);=A0
> // Error: CONFIG_SCSI_ENV_PART_UUID undeclared
>=20
> Given this constraint with mutually exclusive string configs, I've kept t=
he
> #ifdef approach for these specific cases. I understand the preference for
> IS_ENABLED() for its compile-time checking benefits, but in this scenario
> with string concatenation, the preprocessor conditional appears to be
> necessary.
>=20
> Would this approach be acceptable, or would you prefer an alternative
> solution?

The way to solve this would be to wrap CONFIG_SCSI_ENV_PART_*UID with
CONFIG_VAL(...), but at that point we've also lost the readability
argument of avoiding #ifdef.

--=20
Tom

--bo7qz5OUEBE4/OrY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWEVJgAKCRAr4qD1Cr/k
Cm3RAQCJD2F470YFdGt/LKjHyob/zIUpkC0nPTd23PD6ij4kIgEAuaNJapY4gEWn
ZVkztyMl4CEnuiVBS/VjjzB2v5ZwcgQ=
=e2rJ
-----END PGP SIGNATURE-----

--bo7qz5OUEBE4/OrY--
