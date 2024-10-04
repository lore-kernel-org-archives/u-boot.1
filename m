Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDA5CF8840
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 17:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E27788DB2;
	Fri,  4 Oct 2024 19:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZUEO6MO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A8988EA8; Fri,  4 Oct 2024 19:14:50 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EBAD88D2C
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 19:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-45cac3368f0so13915811cf.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728062085; x=1728666885; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kenh3nTg2RdVTAsQN/rpHDjZoKTSp6S8l9mFOjWFfAI=;
 b=ZUEO6MO/m7BAfHIQtb8t+QSEiLPVDvck5nptRL8vAv5WZL46kP5yzS24e13X0d1V3K
 XBdBXNIdcT/C5JWz+Zsr02mOk0TqFkvlHbhIGDwJwQX5E6XRLzYR+/I+pkvMB2yURBYC
 jKI6zKwZ2LYdxtl7SqjulPLDvsygYail63/VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728062085; x=1728666885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kenh3nTg2RdVTAsQN/rpHDjZoKTSp6S8l9mFOjWFfAI=;
 b=pH8OEdiFTgwI2qob5C4G22rQWXSAnh9sV7FJsq7FatdnNBav9ZtUFBA5kRuhpCH3nu
 YdpLVxETa4VYIBMXibo9McpCwg2zldX0Du+rZ8nJbUu9nTfmmHMLuaoZWsuhNRihA/TC
 bDpBioM/wQm/X7cn9FvSUUvCfjwel+VANUT4l8Etc6jBPa1c2+OxgWM5XxyHF2lcoV2d
 4/gHOycUFRMkxJXjD24AA0c2/rzVInn+Cw2NZw9BOFte4mcIMWhOtRlHwfO4TCNIMFub
 yrbacqOtaKBDpKmO06MUen7kjf5OWaL3tOidUcT3d3UK5SUhEXmdWLdD8RE4cMWf1z0m
 FyIA==
X-Gm-Message-State: AOJu0YzE4nBHU38pjVEKQ8F2so9e39Mvcy5VYllBi1fCYDqowOwJ06FR
 z5ywDPxLhEHi6c5PDv1jQwsv52Wu8QqHjxPVQCW1gNaDCFF0A8Kzbz3uePtFliM3SY93fWODwr7
 f
X-Google-Smtp-Source: AGHT+IEK2sTMIUPwTGeDsuuYwTx431qeccgflUfBp7TjzXA+LCqPZjCRttbG5bWrmsV2Z2kMhDuzog==
X-Received: by 2002:a05:622a:12:b0:458:1d11:6064 with SMTP id
 d75a77b69052e-45d9ba2d37fmr60970971cf.3.1728062085442; 
 Fri, 04 Oct 2024 10:14:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da74b2051sm923271cf.7.2024.10.04.10.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 10:14:44 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:14:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 04/13] m68k: asm/ptrace.h: include linux/types.h
Message-ID: <20241004171441.GC4737@bill-the-cat>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-5-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TLNuCOavVDwpHasO"
Content-Disposition: inline
In-Reply-To: <20241003212802.3810-5-ravi@prevas.dk>
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


--TLNuCOavVDwpHasO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 11:27:53PM +0200, Rasmus Villemoes wrote:

> Modifying a generic header like watchdog.h, removing not directly used
> #includes, can apparently break the build of m68k, because the
> asm/ptrace.h header relies on whoever includes it to already have
> included something that defines the type ulong.
>=20
> Make the asm/ptrace.h header self-contained by including the proper
> header.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TLNuCOavVDwpHasO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAIoEACgkQFHw5/5Y0
tyx7BQwAiQ+LVV9K/IiTRsHswHGQkwRvHxxa/cmOa6TUAKoJv2FOFfqVZbS6IZt5
fLLQRcC8GQgcK7WzanKg5q32PJavGEgmnd5J/eEmCpXk7I8q/dm+VI2WmQI9XTm5
QhIc9lyWnvXI6/0aohlFv8Fa9kYFNAzWt5AgE949y29ziqDkcY6jw/dZa+D6UIAV
YmL2IFSN5sEkIi2qEFOandG3rgMl8ZoREaQ5qzVCkDyPZ+yrZ1ahPXbKi4e4PclU
rGHVDmdLRoi5RsMLEE0tEyjeOVhkuxW1HJIkxZmG4gZ+h0rFt8bCiuEXf3bIlyKm
ykVjNBog3jQUi0+iauTkHDrqW84j6JU/yex1NVVF6/wWFWVr/kFvoLyMrZJ3n8Gy
GfSQyAt9tuA+r1kOduUlYiMIMdoCbzSkr4vDM4jMOTdVydRwCFa/6yfTlYUYyNxC
I0eRWS/sai03uO1MHHfts197aLobJGsVtjzQYczJfM3gkpfT+iw7rJhxSwxGe4PP
74wmTeGy
=ckRs
-----END PGP SIGNATURE-----

--TLNuCOavVDwpHasO--
