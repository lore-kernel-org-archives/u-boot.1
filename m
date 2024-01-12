Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B5CC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B60BA879B2;
	Fri, 12 Jan 2024 14:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NrbW07j3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5EE879C5; Fri, 12 Jan 2024 14:46:04 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B828794F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5f2d4aaa2fdso67927087b3.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067161; x=1705671961; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wHtOoG6kDrpXxtdxAq385QLnFPnu60+JjTK043JM7rA=;
 b=NrbW07j3/EmyP0PkOG2u569qNEoe1LUgRBYonDJbudPsRp1KTmT340jqzlJtBjA4vD
 6ZEyJZG2nGtZKASBssMNtIEhlSFHEYmJO5zReluhUDPfTrpkjnrYTQAZaOLTi6PCjlxt
 FWQ81jji56ox8Npk+0tO75GYy/jZkM8VoJMtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067161; x=1705671961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHtOoG6kDrpXxtdxAq385QLnFPnu60+JjTK043JM7rA=;
 b=IdjiF0Dw5mBd9liJeiUWpUySIoPyRS7ojoSrR/KCfGPermyDWletfRvPbGLyPeNAMN
 kJ6DNAgBEG77msQbXkrd6wh0vA7KD/G6q8tQUqEG37BoqxsdMoAHvjWoyUT35COXusTj
 e1WeuLVwqBf4a4yWlIihNsQE/GEOFzBYWHJjIMnpLUcZGFVXVfhC2/2GZlVDRIYLmSb7
 3fWd2M92GYgrmNORAyn33bm00uangv9q9oyoO3++yGk1oboqkMmgnO7C+t9anOoQT1uz
 iQdD/wvjjEr2fGZaQipwBI9xGgLBC9A9Xw/WJzI9ZIudZbAGYy+zaQh1OfRdsmijE9YH
 aaQw==
X-Gm-Message-State: AOJu0YxYmjNDV/KztQcR8MiSc6jNz3n0H7sizp8jPB553haHgUyesliF
 F4l47/YQH+xAUNQpLR3fAzMCq1JYCuDmYA==
X-Google-Smtp-Source: AGHT+IGVSdW8PJfslyrTeJxl35K/AbUNMo7p1ysyQ2Adno9/lar5/qhBCrhk9PlD8lHXPfYyQBhA+A==
X-Received: by 2002:a81:9854:0:b0:5f3:ebb9:ec59 with SMTP id
 p81-20020a819854000000b005f3ebb9ec59mr1271139ywg.5.1705067160794; 
 Fri, 12 Jan 2024 05:46:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 p10-20020a81980a000000b005effa4feef0sm1336129ywg.58.2024.01.12.05.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:00 -0800 (PST)
Date: Fri, 12 Jan 2024 08:45:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Marek Vasut <marex@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH RESEND 2/2] phy: phy-mtk-tphy: add properties for phy
 tuning
Message-ID: <20240112134558.GQ1610741@bill-the-cat>
References: <20231213064134.12727-1-chunfeng.yun@mediatek.com>
 <20231213064134.12727-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BoAQJhIXlR5PytgS"
Content-Disposition: inline
In-Reply-To: <20231213064134.12727-2-chunfeng.yun@mediatek.com>
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


--BoAQJhIXlR5PytgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 02:41:34PM +0800, Chunfeng Yun wrote:

> Add properties to improve eye diagram which sometimes need adjust
> some parameters of u2phy;
> Add a property to tune disconnect threshold;
>=20
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied to u-boot/master, thanks!

--=20
Tom

--BoAQJhIXlR5PytgS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQpYACgkQFHw5/5Y0
tyyZ+Qv9Gh9Gl0/xA6wE1AZpzG/ms0aY2XlmPzaVaxc4wVS2M79Te8VRm6gsnC2G
vdoonvjm9+Gj9X3nJChEXYgpZCfR2YPETkmSixCdFbjKHN+Ft7ebjVuyKJMO/QQr
dK1B6E5hL9CQan6SVA6w9TGPAx4Wq4eIFyHXypjvmEZyGwH6YBc/7JtwJJHkXD13
oDPISjZCDHsNREiII0wV4eBJQ/J95iZZCnp3ug/Zrvskkz3hzaZkiL2cQA8cuSos
8FYSdC4GnWonedcxwjQgt10eXLORfvIVtq38phkIc+s4iTlvEyysXKtMsC+s/0eo
vLARTePPM6qBLv9K9yyRtUNkd8BZXhtElh1lJI0mnfZoLye6edWNErUjUAG4z5ED
HvAeMCk0jknEVy2zpwVtEVb5QWQZiuI9ue/7OTVrCF9t37rI6eeIIAihmmMcojMP
OfJXO+3A4KlafEqvBbQkFZnpg34yJT8gseIvFo5xSmkMZH9mwg/gbio/CqqHha9F
l+5u5k45
=ganq
-----END PGP SIGNATURE-----

--BoAQJhIXlR5PytgS--
