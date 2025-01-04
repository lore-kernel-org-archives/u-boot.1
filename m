Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889CCE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 13:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E9E8036D;
	Sat,  4 Jan 2025 14:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="jyYVudNN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36E4803DC; Sat,  4 Jan 2025 13:06:30 +0100 (CET)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6E780107
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 13:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1735992387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=WICRutFrzNfYukhOJag2K9op4TGnqlYZc1cVanitdIs=;
 b=jyYVudNNbg3WFqO7bXve3CMHMad72at4tZgVGWL3Uw/AIi39KsIn5z/6t9t+aj/loltCmi
 eDk3heKEDWcKXMYccBmjtYVzPqzdPfzM4J/SPYMZYge+WqiXJju7y0VPsMIMXh+mNutUQe
 Td4CmUXdYwc4Kfam0GV6txeBgzHhstCm528zyGTfIGLP8CKXyFDJhFq6jCL6URPyafU9Q7
 b72Zp92wo212b3fe+eXPE0UQ4lkZw7W2XgN7bCur6XwU/KA+dIiLAJixLN1UnqCUUg3lsv
 r2tEWs63AlM7aI8ijm5IytDoNZKBNxbsQkB1yfC2nr4sPGHA+hWx/V2Fdx7jQw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Jan 2025 12:06:07 +0000
Message-Id: <D6T9XNZMHBVE.2FGE2RIBUOBP6@postmarketos.org>
To: <jonas@kwiboo.se>
In-Reply-To: <20250103215904.2590769-2-jonas@kwiboo.se>
Subject: Re: [PATCH 1/2] tools: mkimage: Add Amlogic Boot Image type
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <neil.armstrong@linaro.org>, <trini@konsulko.com>,
 <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <vitali64pmemail@protonmail.com>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:18:05 +0100
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

Hi,

> Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
> Amlogic AArch64 SoCs.
>=20
> Images can optionally be signed for secure boot scenario, however
> creation of signed images has not been implemented.
>=20
> Example of how to use it:
>   # Create an amlogic boot image
>   tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin u-boot-amlogic.bin
>=20
>   # List boot image header information
>   tools/mkimage -l u-boot-amlogic.bin
>=20
>   # Extract amlogic boot image payload
>   tools/dumpimage -T amlimage -o bl2-payload.bin u-boot-amlogic.bin
>=20
> Or with binman using something like:
>   binman {
> 	u-boot-amlogic {
> 		filename =3D "u-boot-amlogic.bin";
> 		pad-byte =3D <0xff>;
>=20
> 		mkimage {
> 			filename =3D "bl2.bin";
> 			args =3D "-n", "gxbb", "-T", "amlimage";
>=20
> 			u-boot-spl {
> 			};
> 		};
> 	};
>   };
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---

Acked-by: Ferass El Hafidi <funderscore@postmarketos.org>

Thanks for sending those patches upstream :) I've been using them for a
while now, and they work nicely.

Cheers!
