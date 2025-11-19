Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D602FCF3185
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E020083BD2;
	Wed, 19 Nov 2025 10:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="MQsn+jDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75D483DE9; Wed, 19 Nov 2025 10:41:36 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 028C783DBF
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 10:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3F73F10848B; Wed, 19 Nov 2025 10:41:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763545294;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=G6ZfxH+fq4oOPhJGEiYH3vqNmIDaglWXtPWW6Y9rWdI=;
 b=MQsn+jDFXHrTe+vr5IZWhsAjahs+6KyppFgY4ngHql0KF23MzXjhs/Bvlrj8Aax+KvI7tz
 vzHxekr1cDIw68ifMGwIbid5Yk8slQYsF/GnrjvN8xuvmCVeXn8kEuftQxqEzRDlsacoxn
 LFhIfyYhCoi1qt+83AX4kG/iDBH3fBaP2jfBzvis++Y4K9umG4qqKDO3tW9bz/rAXWvi6x
 GoRSmKt3Mfdv5Qcv0satw1u+ohVkywQmTObeYhN13zugMwlTdycQk7mPd2n8RjfzOqkKAs
 0LDEu2TIxYFwAF4TggbVRYyebE7VWO7jaMzuPJxj6x2umfHPjU3GyAx5QwJstQ==
Date: Wed, 19 Nov 2025 10:41:32 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] kp_imx53: Stop disabling device tree relocation
Message-ID: <20251119104132.7993c58c@wsk>
In-Reply-To: <20251118180400.591100-1-trini@konsulko.com>
References: <20251118180400.591100-1-trini@konsulko.com>
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

On Tue, 18 Nov 2025 12:04:00 -0600
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
>  include/configs/kp_imx53.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/configs/kp_imx53.h b/include/configs/kp_imx53.h
> index 78c6c67ab99f..bb136b7e1290 100644
> --- a/include/configs/kp_imx53.h
> +++ b/include/configs/kp_imx53.h
> @@ -18,7 +18,6 @@
>  #define CFG_EXTRA_ENV_SETTINGS \
>  	"console=3Dttymxc1,115200\0"	\
>  	"fdt_addr=3D0x75000000\0"		\
> -	"fdt_high=3D0xffffffff\0"		\
>  	"scriptaddr=3D0x74000000\0"	\
>  	"kernel_file=3DfitImage\0"\
>  	"silent=3D1\0"\

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
