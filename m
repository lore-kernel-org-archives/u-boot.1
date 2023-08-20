Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FD5EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 18:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15433865DE;
	Sun, 20 Aug 2023 20:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gZf1tfZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8B486354; Sun, 20 Aug 2023 20:00:57 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686A4869E9
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 20:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5922380064bso2357b3.2
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692554453; x=1693159253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k0XiDwJ6KoobccER6DQ035KVZL5IyGTtS5JO1PVdkNw=;
 b=gZf1tfZhm+nHcf3rmHZ68JX4N04BX/ENJoz04kHuk1YshPuLb9hFx7v2GhPhCzJgl+
 DlnfcwSTbhFuZuwZfTkB/YHR6Y3B5khgIHyObayWfF2e80/62gYYV6GBCLJRgKyQffqV
 CJdPChJ+gEdZIFlQ7daa6hLJecar8JJQWP7VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692554453; x=1693159253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0XiDwJ6KoobccER6DQ035KVZL5IyGTtS5JO1PVdkNw=;
 b=ReQLmlr0p1HHXnyNhsEdGgZA2TAsKkfwkO/l7+W4VBwtoLoUDoA2mOUEwWvD/UV86X
 JniU/VuPrvK8Z1ZTTdnCfsUumZJeRYygPXo1hSUuuse/Nyrr/TmCek3ekF2IC86fpcDp
 BbiqN7Eq5E+aihF87Sm3rV7nlEZxq1Rhyn7hXiSQwCeSxmX5VQDR1AawOANkuM16fBDu
 3Uw/OUWrP5YBZ9dX8ejm47dZpKdpGEGirIu7mQAnfHKy0yXBAQbeXyAPsCCOeXZmAe3m
 siWoUAtWuUFuaggxFKRh+xcs7siHUq1Hd8V7AjIhAuMXeoBoCQ8Pls+72CTIXAc50FwL
 LOkg==
X-Gm-Message-State: AOJu0YxDN2NGEJ9HW3URok1HkHfRBHYls6MHqPS9V+tTzo+NUmEH5xYI
 i4ClHLRsX9+ELFr/tKv6HHuB5Q==
X-Google-Smtp-Source: AGHT+IElOx3X9M8Z9NBXeXDFNVa3f9tmn5Bdku6ljUPV7NahW0JKGLqmWEg9/ogy58Rlj9hS9ErVvw==
X-Received: by 2002:a81:9141:0:b0:57a:8ecb:11ad with SMTP id
 i62-20020a819141000000b0057a8ecb11admr5791415ywg.43.1692554453205; 
 Sun, 20 Aug 2023 11:00:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2d48-63ba-cc6c-366e.res6.spectrum.com.
 [2603:6081:7b00:6400:2d48:63ba:cc6c:366e])
 by smtp.gmail.com with ESMTPSA id
 m124-20020a0dca82000000b005897fd75c80sm1808232ywd.78.2023.08.20.11.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 11:00:52 -0700 (PDT)
Date: Sun, 20 Aug 2023 14:00:51 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mingkai Hu <mingkai.hu@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 "Andrew F. Davis" <afd@ti.com>, Mario Six <mario.six@gdsys.cc>
Subject: Re: Dropping CONFIG_SCSI
Message-ID: <20230820180051.GS1515023@bill-the-cat>
References: <CAPnjgZ2jMCpQbBGUx5ZnX1cDNJy3G8+HDMzk92CSwRVCE8TDjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SibDdvZPTQ4Ov8Hq"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2jMCpQbBGUx5ZnX1cDNJy3G8+HDMzk92CSwRVCE8TDjA@mail.gmail.com>
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


--SibDdvZPTQ4Ov8Hq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 11:49:21AM -0600, Simon Glass wrote:
> Hi,
>=20
> The deadline has passed for the non-driver model SCSI code. The boards
> below still have this enabled:
>=20
> $ ./tools/moveconfig.py -f SCSI ~DM_SCSI
> controlcenterdc am57xx_hs_evm_usb ls1088ardb_sdcard_qspi_SECURE_BOOT
> ls1046ardb_sdcard_SECURE_BOOT ls1021atsn_qspi ls1021atsn_sdcard
> highbank ls1021atwr_sdcard_ifc_SECURE_BOOT
>=20
> Please can you take a look at migration?

For the layerscape configs that aren't to be removed by:
https://patchwork.ozlabs.org/project/uboot/patch/20230818134330.12509-2-lau=
rentiu.tudor@nxp.com/
they're just out of sync with the other configs, and so can just be
enabled.

--=20
Tom

--SibDdvZPTQ4Ov8Hq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTiVNIACgkQFHw5/5Y0
tyw7mQv/Y2+XAidwEJvk0HR8ZLJlcjArzmHv6W4+gFF8cKVBKnzcmBx3fqrLCbzn
TEt6q0pA7EN2SyVinKx2LkUi2HnAXVddZd2s/pw9tEXqX6pilcrduTBfUskCmfuC
oGc6o7lipbv3rlsxOvK1tKv7msM6VJ//OEEHAQoMvNDUVI5emol8kTqZB/WMZSXP
4AbGaYPD66FeYx/Cald5Sy/qmt9Hcj/mnMptvS+Cfu/f9zlt7CW0f2dW8g7v4DQb
mZwbbzOX/+/sHgrqzzKoFU+ygHNRK8oBCrQCe+OK2g8th6908xgX0wUVMNdSFHo4
1TF090v8KLnElZx9jWFJ5U+Z+87OyNy6g7IqVISCI7Rhlu4Vvwbdiz04ShIvxC0s
UZCHQ8ER0QH1EJxUW0cuoRVOpEPc1rArMK/0FEcmicJytgLq7kEU8eB+cs2YIc1w
s8wZvYY1K/R1bu15wcl8yjIWlQroL7Vrz5hv615+1uyz/jWnnzB7T68W8RPmHrfJ
yDX1TdmA
=g5rq
-----END PGP SIGNATURE-----

--SibDdvZPTQ4Ov8Hq--
