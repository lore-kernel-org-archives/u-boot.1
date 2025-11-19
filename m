Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DA4CF3185
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EDF683966;
	Wed, 19 Nov 2025 10:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="R7brMSK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC218397A; Wed, 19 Nov 2025 10:41:28 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42B5800B6
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 10:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DF01B10848B; Wed, 19 Nov 2025 10:41:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763545285;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=LmJcqcxBuDhkLFryHxK0KFloI4Bc6C9UrGFMK3obfQc=;
 b=R7brMSK73z8z7bOHo7fWwhkJBTIryCl7pkWoDzlxTVtwCSMX3AnjY2DrcicDqt3aBr50Ym
 QdzoynTiqUrqXgL8ZbNjsN94a+hI2PSwSSQ3zsyGtreCYNuadKEKkPaSERwQ3Y/G2UsyNc
 2ZWXkG987gpICJHx1FvnAHetzT9nHZ/6SEAVLNqCHNgl+/4touWzY96QpTKAg3CR/52b4z
 4zy1M9mVpAJ7j+RHLNe40kBp3YbhcZ+KofbRppZFXg1dDGs+QRCClEmuLYEx/OgFLPJ0Uq
 cO0Fx7t7WrGmqvZe/U4+ACmxUCyga4kn7kLpBU7CsLiOREUb/K7csSY9pGG4CA==
Date: Wed, 19 Nov 2025 10:41:23 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] display5: Stop disabling device tree relocation
Message-ID: <20251119104123.1d68e5cf@wsk>
In-Reply-To: <20251118180356.591016-1-trini@konsulko.com>
References: <20251118180356.591016-1-trini@konsulko.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, 18 Nov 2025 12:03:56 -0600
Tom Rini <trini@konsulko.com> wrote:

> Remove setting of fdt_high to ~0, which disables device tree
> relocation, from the default environment. Doing so prevents U-Boot
> from correcting problems such as having an unaligned device tree and
> leads to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the
> device tree is relocated to, bootm_low + bootm_size (or often just
> bootm_size) or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
>=20
> Cc: Lukasz Majewski <lukma@nabladev.com>
> ---
>  include/configs/display5.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/configs/display5.h b/include/configs/display5.h
> index 19d71d6066f8..c311b35bb978 100644
> --- a/include/configs/display5.h
> +++ b/include/configs/display5.h
> @@ -175,7 +175,6 @@
>  	"fdtaddr=3D0x12800000\0" \
>  	"console=3Dttymxc4,115200 quiet cma=3D256M\0" \
>  	"fdtfile=3Dimx6q-display5.dtb\0" \
> -	"fdt_high=3D0xffffffff\0" \
>  	"initrd_high=3D0xffffffff\0" \
>  	"kernel_file=3DfitImage\0" \
>  	"fitImg_fw_sz=3D0x2200\0" \

Reviewed-by: =C5=81ukasz Majewski <lukma@nabladev.com>

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Managing Director : Stefano Babic
