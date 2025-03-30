Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F944C3600B
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8570781EBB;
	Sun, 30 Mar 2025 16:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="hlywfKwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A0081E06; Sun, 30 Mar 2025 15:36:16 +0200 (CEST)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E47581879
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 15:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=obbardc@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:MIME-Version:Content-Transfer-Encoding
 :Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=X5NLJwEsvtsDJJOFthcL0UhHx8Kyj0gbO60p9OvGIJw=; b=hlywfKwtCDI8jHf8Z/I8tCEe6L
 LlYHSskXPjcWgI1QR4sIJbPPi37ch2+GgZb2PKsT+yDz44VTrRvKDo/FihXmAW7dRKt//jdmfeBbI
 U4ZPT7/Lai35MazmCYX7yBqFaiVINIgusJokCSiirQXf+MmqXp4+/BWS1JM9Zq88gv3eol4v5iYlR
 LW2BaYvS4ODn+LksZusdaTra37ISuGVeufSiDUJ9OVavUKDRlGS3PZGskZUESUZFdJMAvSicjnz3R
 xLjTYAnfQd27DGBBjqwbtFhUzRw2D94xvTof2B9RPYTkfaOfvUI9QVNwYMQj8Sl9xOyBX6eC9OOUK
 PYkUQtEg==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <obbardc@debian.org>)
 id 1tysph-0082Hl-3a; Sun, 30 Mar 2025 13:36:13 +0000
Message-ID: <42a4c1623e19968a7f503db899ea424887c330e0.camel@debian.org>
Subject: Re: [PATCH v4 5/5] rpi: Use the U-Boot control FDT for fdt_addr
From: Christopher Obbard <obbardc@debian.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren
 <swarren@nvidia.com>,  Matthias Brugger	 <mbrugger@suse.com>, Tom Rini
 <trini@konsulko.com>, Francois Berder	 <fberder@outlook.fr>, "Ivan T.
 Ivanov" <iivanov@suse.de>, Patrick Rudolph	
 <patrick.rudolph@9elements.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Sun, 30 Mar 2025 14:36:12 +0100
In-Reply-To: <20241220003447.2913443-6-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-6-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
X-Debian-User: obbardc
X-Mailman-Approved-At: Sun, 30 Mar 2025 16:36:48 +0200
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

Hi Simon,

On Thu, 2024-12-19 at 17:34 -0700, Simon Glass wrote:
> The fdt_addr variable is used in extlinux as a fallback devicetree if
> none is provided by the boot command. Otherwise the only use in U-
> Boot
> seems to me efi_install_fdt() when the internal FDT is required.
>=20
> The existing mechanism uses the devicetree provided to U-Boot, but in
> its original, unrelocated position. In my testing on an rpi_4, this
> ends
> up at 2b35ef00 which is not a convenient place in memory, if the
> ramdisk
> is large.
>=20
> U-Boot already deals with this sort of problem by relocating the FDT
> to a safe address.
>=20
> So use the control-FDT address instead.
>=20
> Remove the existing comment, which is confusing, since the FDT is not
> actually passed unmodified to the kernel: U-Boot adds various things
> using its FDT-fixup mechanism.
>=20
> Note that board_get_usable_ram_top() reduces the RAM top for boards
> with
> less RAM. This behaviour is left unchanged as there is no other
> mechanism for U-Boot to handle this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org> # CM4 1G

> ---
>=20
> Changes in v4:
> - Expand the comment on set_fdt_addr()
> - Update the commit message to talk in terms of my testing
>=20
> Changes in v2:
> - Drop patch to allow expanding the devicetree during relocation
>=20
> =C2=A0board/raspberrypi/rpi/rpi.c | 20 ++++++++++----------
> =C2=A01 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.c
> b/board/raspberrypi/rpi/rpi.c
> index c46fe4b2350..f74006e0968 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -3,6 +3,8 @@
> =C2=A0 * (C) Copyright 2012-2016 Stephen Warren
> =C2=A0 */
> =C2=A0
> +#define LOG_CATEGORY	LOGC_BOARD
> +
> =C2=A0#include <config.h>
> =C2=A0#include <dm.h>
> =C2=A0#include <env.h>
> @@ -326,18 +328,13 @@ static void set_fdtfile(void)
> =C2=A0}
> =C2=A0
> =C2=A0/*
> - * If the firmware provided a valid FDT at boot time, let's expose
> it in
> - * ${fdt_addr} so it may be passed unmodified to the kernel.
> + * Allow U-Boot to use its control FDT with extlinux if one is not
> provided.
> + * This will then go through the usual fixups that U-Boot does,
> before being
> + * handed off to Linux
> =C2=A0 */
> =C2=A0static void set_fdt_addr(void)
> =C2=A0{
> -	if (env_get("fdt_addr"))
> -		return;
> -
> -	if (fdt_magic(fw_dtb_pointer) !=3D FDT_MAGIC)
> -		return;
> -
> -	env_set_hex("fdt_addr", fw_dtb_pointer);
> +	env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -571,7 +568,10 @@ int ft_board_setup(void *blob, struct bd_info
> *bd)
> =C2=A0{
> =C2=A0	int node;
> =C2=A0
> -	update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> +	if (blob =3D=3D gd->fdt_blob)
> +		log_debug("Same FDT: nothing to do\n");
> +	else
> +		update_fdt_from_fw(blob, (void *)gd->fdt_blob);
> =C2=A0
> =C2=A0	node =3D fdt_node_offset_by_compatible(blob, -1, "simple-
> framebuffer");
> =C2=A0	if (node < 0)
