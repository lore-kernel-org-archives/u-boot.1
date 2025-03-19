Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20082C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB74781F64;
	Wed, 19 Mar 2025 15:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SZTuoCcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC85181E60; Wed, 19 Mar 2025 15:57:51 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6833081ECD
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22435603572so115544375ad.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742396267; x=1743001067; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n1/rOU15vfftJIyiu/TFIa9o8nc0Lnz/KjgKCWkxeHk=;
 b=SZTuoCcd66UnZ+w/DRogZLgySLBMTZVRJeQAzH4TbCr8nj7JtSuWMfPLwQFGyZ81NL
 ay3eGgR6t2FPkeNaPTaRmaQHdkjzKI13Y3Zj4jStO+Yawzk5bQaNYM8Vc9hnbBe3YQAZ
 1lUc7mXHKQJytCGkfkOzRNv1K5/C3YdEyBiOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396267; x=1743001067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1/rOU15vfftJIyiu/TFIa9o8nc0Lnz/KjgKCWkxeHk=;
 b=hweW7Yg2yY/W87U0A2RutlBt/Tr5pYo/an5eLNH4nnQE3eO45lZdmLw4Rg3UMOUS+a
 iOuE7QxhhW+1EBxnemnrmn6G565UqJoitlWCF974RcfPQ7SYE9tsbHc7WU2rAjFzvNUw
 g+JvIOYGUMsmqCCC+fIFZi2QJwp9OBMFG+g25VDGe5HQaSRnICZM4MIewkU4F8TAclqX
 V7xnpjcXLRIN+dqOwLKH1mLIrce4yT6eyTaQt0oISteX9LCp9AgSAxsrpK3scr7+5AFH
 MY9WQzCnwWd2L0Rje/PBQarJhZ7xe4h7PUExKYYFUxFDlDjBdQbj/vFg2VlPlc67/G2x
 pVag==
X-Gm-Message-State: AOJu0Yx/084d94OkMaLR+vrhxG4/Li4lkh4QPD6zgg8afJvQ/g3hlzvO
 ZRqgJdozn6uSthX8kLWSw47l7bwJdz+d0j+NV36OsIObU/8sM3m5ER1uP6RFDNY=
X-Gm-Gg: ASbGncvaI4vVE8T72y3v6EmEW9EuV6ot/OX5iXZLUt5+5zLWzcok0rIkgXydD0VG0u+
 O3RYMn0ll1xj/e5M8BT7QETF+XVbSpMoRDmruCaxvg7vpG3e21Re3qFgSshgYJvrJG/xmcASfBh
 7xX5ZvVeWspB/Ji+CnbzcpGbWhYnuKGhYfFs2rD67XiYx0zMiy2ouFRnsKhUXOQmyya/JeiHm5/
 II0YH7ef4Mds61ttDa4DhZ8F7F3mPVvY0tg1pLkGU3O4CA3ojkc6J2XwaxMyiP3DtIWx120y8IY
 WotEKDfaiTXhfL5My0Y5rds0og4WAVU1GAEN+wUkIRE0KqkEHMIH/ln/
X-Google-Smtp-Source: AGHT+IG+YFovEAbUM0V5/N3O1aqKQKCtzwdyCJgjNx9fOathvOkM0JqttIk34B1pa/8rMkDpRwStKw==
X-Received: by 2002:a17:903:230d:b0:224:1001:6787 with SMTP id
 d9443c01a7336-2264980c714mr41040095ad.4.1742396267457; 
 Wed, 19 Mar 2025 07:57:47 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbfb5asm115041585ad.209.2025.03.19.07.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:57:46 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:57:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/52] expo: Various features and improvements
Message-ID: <20250319145742.GI2640854@bill-the-cat>
References: <20250319145512.2391122-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rt5L9ZEuv4g+JrBZ"
Content-Disposition: inline
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
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


--Rt5L9ZEuv4g+JrBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:54:05PM +0100, Simon Glass wrote:

> This series collects together some new features for expo to make it more
> useful for boot menus:
>=20
> - measurement and display of multi-line text objects
> - internal alignment for objects (e.g. centred text)
> - editable strings in text fields
> - new 'box' object to draw a rectangle
> - highlighting of menu items, rather than just relying on a pointer
>=20
> Expo's boot menu is restructured so that it is possible to iterate
> through various bootdevs and update the menu as new ones are found. This
> is more in keeping with how bootstd works.
>=20
> A new textedit object is added, intended to provide a simple text
> editor. Future work will complete this.
>=20
> With this series the boot menu has a better layout and appearance.
>=20
>=20
> Simon Glass (52):

I see you haven't internalized the "don't post massive series" feedback
yet. Please, stop posting massive patch series. Figure out how to
logically break things down in to smaller chunks that can be
meaningfully reviewed.

--=20
Tom

--Rt5L9ZEuv4g+JrBZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfa22YACgkQFHw5/5Y0
tyxkFgv/YxmLye/9O2DEhSOrVbI0bD8iq9YlmemvgNWPyCIiEbAX/bDk+MBxZaOG
xXogvFTcHCSwVhdnL0DB3hYDzHcL1xSuP5Zad6OFIACJB8OHKgWBvLzOnVQi18r8
yOWtZBB4N4HZjnOxlt4puh6qih9IJ3weFfyvcKobzTpsNOlCORq19yLaEUNoalz6
xeuUDXEx/NUvS0A5Nvu49czoTM8yeQY6C8VYoJ1JVQP7G1eygBwKI4hHCY+VOp+R
9uAAF9YE8ZiGuL0FjJFK3sOrrqG7y/NQrPKOZrA3rGDFt/28u62HoZH5d9Wu1GJt
i1B7juFUSqe6STwQgEbtaq1wFWQjISSw7oi6xjpKqJFPmsWdkjKIeg1cIow9b/fx
bG5n3QnRzQm8yxoanadJF8CNvYJPA91EhJWAmLdI9wmBcqvfcs1kyy0FHkggt8e+
kzQ2QKkhEkNdTSilYVpM/vD5+IfUv+ke03NGM2GuSN6LTYwQF5Hc3M8dCVrkr5WC
jBiPhs5t
=DxAq
-----END PGP SIGNATURE-----

--Rt5L9ZEuv4g+JrBZ--
