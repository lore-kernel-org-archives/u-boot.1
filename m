Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56198C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D4D81DCD;
	Sun, 30 Mar 2025 16:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="ZaOiH6/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D2780FDA; Sun, 30 Mar 2025 15:35:42 +0200 (CEST)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91EB580F9C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 15:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=obbardc@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:MIME-Version:Content-Transfer-Encoding
 :Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=AYTWBKCwhzniFEIo6aMr+7ijdhNqfX7SJABrPIifrCY=; b=ZaOiH6/9RllZDMoONOHo7XJRny
 hcOr2LzglU8ORUsWUoPIP/AqWqapbMdWJprVBmBNI0Y3AM1HZ90pMpHWmAzk27VWrPsPNa+/T93Xc
 lwQW99SdIG2YK0maAHMymXm2k68Xwrjw+ugxNAVfwe9P9kJNMCHrZcrG5TnOObXgaXF4E3htsIBsd
 1hQihmz9pkvLiqsyAn5gnThCKveAJmZn4N1m9s89OPW7dlPqLZDan/5sYpv7qxA0whxfM8oW+4+cy
 8A70zEmQVx69U6LoH5yjivdeuMp2Um58COT7SwVEx7AEChNTK/fcwDr1Jei3hBt8hfSNQZg1dBpof
 Gbe5chqA==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <obbardc@debian.org>)
 id 1tysp9-0082GU-Gz; Sun, 30 Mar 2025 13:35:39 +0000
Message-ID: <fc24191b5276a25766d81a0f37136c5f817c6f9e.camel@debian.org>
Subject: Re: [PATCH v4 3/5] rpi: Drop fdt_high and initrd_high
From: Christopher Obbard <obbardc@debian.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren
 <swarren@nvidia.com>,  Matthias Brugger	 <mbrugger@suse.com>, Tom Rini
 <trini@konsulko.com>, Peter Robinson	 <pbrobinson@gmail.com>
Date: Sun, 30 Mar 2025 14:35:38 +0100
In-Reply-To: <20241220003447.2913443-4-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-4-sjg@chromium.org>
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
> These are not needed now since there is a bootm_size setting to keep
> things within the lower part of memory.
>=20
> Drop them.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org> # CM4 1G

> ---
>=20
> (no changes since v2)
>=20
> Changes in v2:
> - Add new patch to drop fdt_high and initrd_high
>=20
> =C2=A0board/raspberrypi/rpi/rpi.env | 7 -------
> =C2=A01 file changed, 7 deletions(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.env
> b/board/raspberrypi/rpi/rpi.env
> index a327fccc77f..9b9fad82828 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -66,13 +66,6 @@ dfu_alt_info+=3DzImage fat 0 1
> =C2=A0 */
> =C2=A0bootm_size=3D0x20000000
> =C2=A0
> -#ifdef CONFIG_ARM64
> -fdt_high=3Dffffffffffffffff
> -initrd_high=3Dffffffffffffffff
> -#else
> -fdt_high=3Dffffffff
> -initrd_high=3Dffffffff
> -#endif
> =C2=A0kernel_addr_r=3D0x00080000
> =C2=A0scriptaddr=3D0x02400000
> =C2=A0pxefile_addr_r=3D0x02500000
