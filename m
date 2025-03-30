Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FA8C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5C681E5B;
	Sun, 30 Mar 2025 16:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="VUmEAnlg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2494681DE3; Sun, 30 Mar 2025 15:35:54 +0200 (CEST)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2D080FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 15:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=obbardc@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:MIME-Version:Content-Transfer-Encoding
 :Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=Xchcn/yyxUtqJe9EdnLGHfSokLuxG8fkQXf34LuKTN0=; b=VUmEAnlgTlG3XJa6Chh2CdW6Le
 5Z0pKQVpaFACn+MhKQ6O4I1ryQOjF1MMHE7olc20T2Exm2Ub8jbKJaFaZLkhDNafIMMLYpKd/S4W1
 Ynvy2c/tEl4OIuwXOInwSDTwTrnUivUtuqCEY2rjKuBskA8oo++NVuJRw+wC/sTy4k5n25Xxk52Jq
 igxNCN9MvnVPjRyKXbHhrl0IPvZD/bbj4ThxAX348ak7C0Cdwf6Pno3pmLndoSucaOMXi6idD7aJE
 yJh/WOi+7vwI8QCnrwDwA3OiURgA2m/0Qe1lpw/F1dlxUsPiOq5XeLnEGWdzfv4FbSxb7H4TGTWce
 3Y3xE5AA==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <obbardc@debian.org>)
 id 1tyspL-0082HT-8y; Sun, 30 Mar 2025 13:35:51 +0000
Message-ID: <e672db931b223184ca8644c9d56ca86f0fdac7bc.camel@debian.org>
Subject: Re: [PATCH v4 4/5] rpi: Update environment to support booti and
 large initrd
From: Christopher Obbard <obbardc@debian.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren
 <swarren@nvidia.com>,  Matthias Brugger	 <mbrugger@suse.com>, Tom Rini
 <trini@konsulko.com>, Peter Robinson	 <pbrobinson@gmail.com>
Date: Sun, 30 Mar 2025 14:35:50 +0100
In-Reply-To: <20241220003447.2913443-5-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-5-sjg@chromium.org>
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
> The existing values don't provide for decompressing an arm64 boot-
> image.
> Add those values and move things apart a bit so that a 50MB kernel
> can be
> accommodated.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org> # CM4 1G

> ---
>=20
> (no changes since v3)
>=20
> Changes in v3:
> - Update the comment block with the new values, including compression
>=20
> =C2=A0board/raspberrypi/rpi/rpi.env | 27 ++++++++++++++++-----------
> =C2=A01 file changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.env
> b/board/raspberrypi/rpi/rpi.env
> index 9b9fad82828..9ac9d6768ca 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -48,28 +48,33 @@ dfu_alt_info+=3DzImage fat 0 1
> =C2=A0 *
> =C2=A0 * scriptaddr and pxefile_addr_r can be pretty much anywhere that
> doesn't
> =C2=A0 * conflict with something else. Reserving 1M for each of them at
> - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> + * 0x05400000-0x05500000 and 0x05500000-0x05600000 should be plenty.
> =C2=A0 *
> =C2=A0 * On ARM, both the DTB and any possible initrd must be loaded such
> that they
> =C2=A0 * fit inside the lowmem mapping in Linux. In practice, this usuall=
y
> means not
> =C2=A0 * more than ~700M away from the start of the kernel image but this
> number can
> =C2=A0 * be larger OR smaller depending on e.g. the 'vmalloc=3DxxxM' comm=
and
> line
> =C2=A0 * parameter given to the kernel. So reserving memory from low to
> high
> - * satisfies this constraint again. Reserving 1M at 0x02600000-
> 0x02700000 for
> - * the DTB leaves rest of the free RAM to the initrd starting at
> 0x02700000.
> - * Even with the smallest possible CPU-GPU memory split of the CPU
> getting
> - * only 64M, the remaining 25M starting at 0x02700000 should allow
> quite
> - * large initrds before they start colliding with U-Boot.
> + * satisfies this constraint again. Reserving 1M at 0x05600000-
> 0x05700000 for
> + * the DTB leaves rest of the free RAM to the initrd starting at
> 0x05700000.
> + * This means that the board must have at least 128MB of RAM
> available to
> + * U-Boot, more if the initrd is large.
> =C2=A0 *
> - * Limit bootm_size to 512MB so that all boot images stay within the
> bottom
> + * For compressed kernels, the maximum size is just under 32MB, with
> an area for
> + * decompression at 0x02000000 with space for 52MB, which is plenty
> for current
> + * kernels.
> + *
> + * limit bootm_size to 512MB so that all boot images stay within the
> bottom
> =C2=A0 * 512MB of memory
> =C2=A0 */
> =C2=A0bootm_size=3D0x20000000
> =C2=A0
> =C2=A0kernel_addr_r=3D0x00080000
> -scriptaddr=3D0x02400000
> -pxefile_addr_r=3D0x02500000
> -fdt_addr_r=3D0x02600000
> -ramdisk_addr_r=3D0x02700000
> +kernel_comp_addr_r=3D0x02000000
> +kernel_comp_size=3D0x03400000
> +scriptaddr=3D0x05400000
> +pxefile_addr_r=3D0x05500000
> +fdt_addr_r=3D0x05600000
> +ramdisk_addr_r=3D0x05700000
> =C2=A0
> =C2=A0boot_targets=3Dmmc usb pxe dhcp
