Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D88C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0023C87582;
	Tue, 21 Nov 2023 14:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TKK4AhPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC5F875B1; Tue, 21 Nov 2023 14:15:57 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 124228745B
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67089696545so18998476d6.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 05:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700572554; x=1701177354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pBBD5EHmhRSLa28zpgHcGntYet6+ErJ4N7/pCjAJSpE=;
 b=TKK4AhPdGEMOMWpg3SKIV2LssyvuBmtI4Shiu6DwcvkspA+qLmhTB6wsktHEfZP+R+
 UNhTpifce6E5FVOqA1TfI568LtvNEHyBGte2hGF6MaA0aEjeNA4ftG3J7AkBzJHZm4pc
 aiQDfWqcPIQ+G1fHNTnySXOxU64FXraZ76NJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700572554; x=1701177354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBBD5EHmhRSLa28zpgHcGntYet6+ErJ4N7/pCjAJSpE=;
 b=oCplRhA38kJhZFAxEgijoBoKzkEp5s01PiyJ0rLqTo6CeBt+WrzcxYPVP1Xgd2sW8l
 4bwZiMCwLaq2dsoeARA+Z6gjShz1Z1NitgXYUeR6jCor8OdmspKfJPKO/UE71A3komoe
 tuxuZGW9vP0g9ppy9Isrve0/RCZ3NZG7lt3a9H90VZNy+AXeASoWC3FLTKMioR3Hh1Ra
 Mfe31v/WrKR0Jl/g67rO68ovGVHUraoF9pbnEWeR+ejLxmNHHnO/GzP3cOzykOKuBW/E
 lC6cmkLd1Fb8xXlaZ0KsAdz0xjwsOQfWiKk35mYi7sVVOKZoaNMHEK82talyYSInSms5
 aPjA==
X-Gm-Message-State: AOJu0YwpRMZEZFNgWnFhRgy6py/Oz2yuRt2k5BrqRFJxI7nAI57Qyz/M
 Xtf43gnfMeaU283PsEk0D/eN/w==
X-Google-Smtp-Source: AGHT+IFbNiceepEhdqJZzGR5L2hWNYMJWf3lxLNlVnihoCi7dNW0Tk7/4hXxsphQXRlHUNOqozYmPw==
X-Received: by 2002:a05:6214:1948:b0:679:e640:2790 with SMTP id
 q8-20020a056214194800b00679e6402790mr5051104qvk.40.1700572553793; 
 Tue, 21 Nov 2023 05:15:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 qh10-20020a0562144c0a00b00677f605f12asm3748848qvb.79.2023.11.21.05.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 05:15:53 -0800 (PST)
Date: Tue, 21 Nov 2023 08:15:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
Message-ID: <20231121131551.GP2513409@bill-the-cat>
References: <20231120201609.619598-1-trini@konsulko.com>
 <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FkCwsxYNn6Td9D7x"
Content-Disposition: inline
In-Reply-To: <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
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


--FkCwsxYNn6Td9D7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
> Hi Tom,
>=20
> On 20/11/2023 21:16, Tom Rini wrote:
> > Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
> > eventually display this information
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Posting this as this was the easiest platform for me to test some SMBIOS
> > related patches on and I needed to populate the nodes so I could check
> > things in dmidecode once Linux was up.
>=20
> Sorry to be late a the party, but can't this be dynamically found from DT=
's compatible & model ?
> Since I'll probably need to add this to all boards, it seems like a dupli=
cate of what's already in the DT.

Part of the "fun" as to why we have the binding here is that while we
could use the top-level model property, there's not a corresponding one
for manufacturer. I'm fine ignoring the patch I posted here and having a
longer discussion about populating SMBIOS more usefully, globally, as I
think has been suggested a time or two.

--=20
Tom

--FkCwsxYNn6Td9D7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcrYcACgkQFHw5/5Y0
tyw6JAwAhNxlw4AzLR5HWq+K1nPqOfzQdmbS+RAlGevb6y0rGbU0GXlWjSE3FuZb
1JqjqA2XZ3Tf9i5aMVM52aopoYqsHtnZEmTmx1TGBeOGKjd+2RHiNwMG80+hZwUe
58bGVn+1YbwM2dgw29hB896KQEtf7dQKTElhI5JA3YJhyZMEgPCLKSI/fktkPSjg
Rp01YTZI/R2QsR5PIALA1jrXP5UmX/ttuFecuxM4hBzJdTLEKdHkFCKE+gT6LUVi
awzbjdu8TOSslhC1IRUp6lhbIhxP83PuKja5iunRu7zTyp8CHlSYa95yT8ix6o1v
fhy3irNU7oMxqlg84iZKp/lDrGL1ToGQngYh3jqgx+FyHWBoCVRRAheML3letKuk
FJBMkeV9wUm5zCQ71bth1qbcP1aL6Tw0nXXhFVtPeyJRQYZ4x4He6XJFTfsNmlv9
1BO6Du+uRsv5AksPoiPbEDrBSPMNvHTI/4Mzl1uKISuYOeQH+WNXXA55VzDsCr8V
/zaPTdqT
=kli4
-----END PGP SIGNATURE-----

--FkCwsxYNn6Td9D7x--
