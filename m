Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE91CD185FE
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5428416C;
	Thu,  8 Jan 2026 15:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DVup6lDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C262B841B8; Thu,  8 Jan 2026 15:32:59 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9488684158
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c750b10e14so1413663a34.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767882776; x=1768487576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mEItE5/gHVoQVng51zq191d4UuO0tUr1HdHdbbbIaNw=;
 b=DVup6lDeJm1g5xZDv2l8LzcnJkvwH+M3tmi2YhU7olq79gV+7FPRbMlyxbLJNSpaxh
 9erT4AuMHUkc15BdJsRv/unoO+fIkIPfpIblfbPt0C9sFB6a2iyszzvTwwMF766l8vba
 /k2gYWYay4kkKAZOXKgUmZs/FQzb5yOJxJzpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882776; x=1768487576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEItE5/gHVoQVng51zq191d4UuO0tUr1HdHdbbbIaNw=;
 b=uzhAgI5PvncGK42TIN+cAOfCq4c0dpp/G9TzQbAnsXRCNp1RmWAa/1v9YEyvEzyfrW
 70RluWtwUThEOYlZOZfbIasttpc8Xu4RvQZYQRXZsZhOuUERrAD2TVGk4X+ghRKpiRAZ
 ZuhJtfyixM19gyoVcgRD4+KKD7XuSIY0qdcMVHlYtSjouq8p4LXh/CAx8rpEEGClzawY
 ON6gQcZih5tpHhpUNG413zdoDnin+NJGicqKs1JyN3mf5MBlFQXp62jA5lJbfuLSttl+
 7hdfKeqw6zAm4aMZr9rIM6okjEuftPXkECpTKw0pnsfUqyTapFIKHH+//ZVnDwp8pcmV
 nkmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW92CxcgP4PfHpIhXi1IKC9EM0jKG5mnqZl0eau2iIq+d+E/SlR2L3McZgns5mFJ7ijUT5P2ig=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+i9QKmNWkuKvThsb6tgSIluiJG7N6s6O2V5JxQfkDGKV/uXoE
 GnIgJqPPcrTBjSdu/LB2hKORUuUKG6EZGWbITDjYxQZmJTkpINlNLIBXrrfk/lbpEXc=
X-Gm-Gg: AY/fxX5cSG4rYbulj2fhMvQgqeGYy5PAqYXd8Nu6m2smlgypz6XtGfHAHwTZeIA4WQI
 9zRTHT/jpvBoPaI2Qx6IUe2QGi/k2Efb+4Boj12IwnqveSsKRKKRV1KwOQZPvg5POBAICtZ6VX1
 3/64TYKWr6vu9m+i6VS2ODmDEZnhei7XNuti+J6p8Q8PCamq460KM+6Ne5dmpboA2iOU4LdlZ6j
 EHWcxyccLW0VGZqNssBVydDPEwIpYMcTvjbuM8N2LrISFWK+lM0pMqItPTwAHpV9sRnaHwbkajI
 Ga0fO7aoDbD/+PTua3yrB1XxnM1IaZWf4DGFTpswEgCML1MqtLAxYBllyNbLXNVxk/w/QLUpPRA
 Kgd8v1SIuuzpRAvHCShJiToO2yC2K1QTpOw1WmFUORYp4W+ElmEzLRIt9LCU4SdUdcmioaQMgy9
 gxEWM1bjB19IDVUMlHwCiI1gLfNQjKohnbnGFUSpNwRol40UYkLepE/kgFoLt0iCzV0BgMqMIlY
 F3788oETfT19ZIuJmzZrs3fOnFSnBV9JTHOosg=
X-Google-Smtp-Source: AGHT+IHxXAIrqyHwV8oVz95cEdk7NoJLZuKgDL1RnRioHLTpBrMaHHoyGZW5WCtx/dyUjNVHxc7Hwg==
X-Received: by 2002:a05:6830:2b07:b0:7c7:2df4:faa3 with SMTP id
 46e09a7af769-7ce50c0aa4emr2932650a34.33.1767882776144; 
 Thu, 08 Jan 2026 06:32:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478ede43sm5414263a34.27.2026.01.08.06.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:32:55 -0800 (PST)
Date: Thu, 8 Jan 2026 08:32:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 joe.hershberger@ni.com, ilias.apalodimas@linaro.org,
 quentin.schulz@cherry.de, ravi@prevas.dk, javier.tia@linaro.org,
 quic_varada@quicinc.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, ansuelsmth@gmail.com, mwalle@kernel.org,
 anshuld@ti.com, jan.kiszka@siemens.com, javierm@redhat.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/4] env: scsi: Add support for partition type GUID
 based environment
Message-ID: <20260108143252.GS3416603@bill-the-cat>
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
 <aV970YfT3dkXmfxK@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m0sd2ObOM7wK2FD7"
Content-Disposition: inline
In-Reply-To: <aV970YfT3dkXmfxK@hu-varada-blr.qualcomm.com>
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


--m0sd2ObOM7wK2FD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 03:11:37PM +0530, Varadarajan Narayanan wrote:
> On Thu, Jan 08, 2026 at 12:19:46PM +0530, Balaji Selvanathan wrote:
> > Add support for locating SCSI environment partition using GPT type
> > GUID instead of unique UUID. This enables the saveenv command to
> > work with partitions identified by their type rather than unique
> > identifiers, providing flexibility for systems where partition
> > UUIDs may vary across devices but types remain constant.
> >
> > Introduce CONFIG_SCSI_ENV_PART_TYPE_GUID configuration option that
> > allows specifying a partition type GUID for environment storage.
> > When enabled, the environment subsystem uses the new type GUID
> > based lookup method via scsi_get_blk_by_type_guid() to find the
> > first matching partition.
> >
> > This change maintains backward compatibility with the existing
> > UUID-based approach.
> >
> > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > ---
> >  env/Kconfig |  7 +++++++
> >  env/scsi.c  | 13 +++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/env/Kconfig b/env/Kconfig
> > index b312f9b5324..97cb3d05daf 100644
> > --- a/env/Kconfig
> > +++ b/env/Kconfig
> > @@ -768,6 +768,13 @@ config SCSI_ENV_PART_UUID
> >  	help
> >  	  UUID of the SCSI partition that you want to store the environment i=
n.
> >
> > +config SCSI_ENV_PART_TYPE_GUID
> > +	string "SCSI partition type GUID for saving environment"
> > +	depends on ENV_IS_IN_SCSI
>=20
> Should we add
>=20
> 	depends on ENV_IS_IN_SCSI && !SCSI_ENV_PART_UUID
>=20
> and similarly vice versa in SCSI_ENV_PART_UUID since the code seems to
> handle them as mutually exclusive...

If they're mutually exclusive it needs to be handled in a choice
statement.

--=20
Tom

--m0sd2ObOM7wK2FD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV/AEQAKCRAr4qD1Cr/k
CmYdAQCsBWYpk113W8TRQcxl3R7koI9PAvTWPS5ACnU47MDvxQEAg8FpGLIuixwX
X8sAdpVd2Uak70WbSPf9VGeljbZI1Q4=
=+/Rj
-----END PGP SIGNATURE-----

--m0sd2ObOM7wK2FD7--
