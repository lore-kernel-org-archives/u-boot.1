Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E670CCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 036E786E37;
	Mon, 16 Oct 2023 23:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hGJyu+bx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDF386C39; Mon, 16 Oct 2023 23:32:16 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1C9486E04
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7af45084eso64383447b3.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491930; x=1698096730; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p+oIK89zh9rnmfNJ8n7h84IuB4KLNuVSquEwTc9eKGM=;
 b=hGJyu+bxSMHbEwaV7l9SmqnQJf/Px79MJ+wPSO8s5n0KYKtT4sfn2cSxZEnMDQU8Yb
 YKfiOnt1AcQStpzHlBZEN1TcSrP3wmzexqXzfl3gRL0RuvCLZcuMHJHAIeMhqZ0Kopuw
 mFqC+6iMRgJoqGECsck4T3Smv+aF0nibpvIqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491930; x=1698096730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+oIK89zh9rnmfNJ8n7h84IuB4KLNuVSquEwTc9eKGM=;
 b=T4aEJRIqSLG5TlcsD3glPxUemTbnvqyAa7y5p3GyMAioKwsJZVVOFuJn0dVqgOf4O5
 AXYdF7AG+W83M6WHqbxq61E2fpJCt8v+EkjlWSeGVjEIb97fIS0sKGlOXkJYQsnmDjIc
 kXgJNqoO7SRo6aKihZNBEgjGZCeMxBm2bXhbynnqle2qp4y/9zooRdyohM/yhokQGPLI
 y9oIKYRolivD3nxlZ70AcHg7y/hyqXRAWwGoeB//LtemAGooZIIPvf8d7P9ldiNeTIhC
 jRFgQsmycrtr555k1pxABetbbCmyYNteYPmlf70yishXQ/g5MTsVoTek32DHNZ0m0JQv
 c4Ww==
X-Gm-Message-State: AOJu0YwWoP1YFSjKhgAe4WVE+0CdZjW5rn8rbZW974cbX+s9FQ+UB2OW
 DywugVvhon7lXxVdPoEEnjNCO/U7Elf9RKzbPXVuMg==
X-Google-Smtp-Source: AGHT+IGUNWUrRUXqSD+cL0/keldFJ4ieaeF00soQMPCzK+/1q7ap1fwpq4wH06eczkBhEeNg57PjIw==
X-Received: by 2002:a0d:cf43:0:b0:5a2:15bc:b32c with SMTP id
 r64-20020a0dcf43000000b005a215bcb32cmr330963ywd.42.1697491930421; 
 Mon, 16 Oct 2023 14:32:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 q4-20020a0de704000000b005a4d922cf77sm28820ywe.119.2023.10.16.14.32.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:32:09 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:32:08 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] cmd: Convert existing long help messages to the new
 macro
Message-ID: <20231016213208.GO3119521@bill-the-cat>
References: <20231007191308.2222470-1-trini@konsulko.com>
 <20231007191308.2222470-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZD5J9V6YN2vkgWlJ"
Content-Disposition: inline
In-Reply-To: <20231007191308.2222470-2-trini@konsulko.com>
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


--ZD5J9V6YN2vkgWlJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 03:13:08PM -0400, Tom Rini wrote:

> - Generally we just drop the #ifdef CONFIG_SYS_LONGHELP and endif lines
>   and use U_BOOT_LONGHELP to declare the same variable name as before
> - In a few places, either rename the variable to follow convention or
>   introduce the variable as it was being done inline before.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--ZD5J9V6YN2vkgWlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq9gACgkQFHw5/5Y0
tyxt0gv+OcigVloRw+IYdOfVxKRPdcswH4lMVreowDZWFMpbmJm8O2tHfrxv0vfr
m18x/C4m/3qz9oSTPU+Oi837JNCbmrxCwUfXaAxUwfhhPQG6303piNbTEHbwCrgp
sRfRsdFh2+EYoZl8dYtWDREHx7fXZM7brhxkTuwx8r9uXX0GfcRtmj5FY/bSfJHB
HUI8eo4X0m8c/seleqrt1Va0682MZuYe5Rvbu36Z6CMQtq78DQu9AYzEgFCRzyUa
hN3pgl6iTPNgWR+ASZbsHwn+oK4rfG+Phc68AnQ2irr2MFok28Ah7G6nSKsqObGA
QVlRg2DfQmC615ag3EymQYXbcqxu5xQghI1FPScuF/xFNFVTmDRsXfZodiBGNqqe
FYjRg0Qz4ZDj8rTdJ6QsWAafM5TssR4H4KojvEjc/4WH2MJouATiZMn4btsVKOR8
vsh2sEm/mMoKEWPSoAyDh/KYeLuq+y4QVXwqywx+k1NqIZn8/72GAVRa9GAExDWF
ywwsO46G
=Eokh
-----END PGP SIGNATURE-----

--ZD5J9V6YN2vkgWlJ--
