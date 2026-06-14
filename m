Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BD9CD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 10:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281BB83EEF;
	Sun, 14 Jun 2026 12:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Qdlhb71/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76AD83FEE; Sun, 14 Jun 2026 12:16:03 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D6DB800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 12:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B9773117DEC; Sun, 14 Jun 2026 12:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781432158;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fOAAE/QqT4ur/MjT2ztfI5M998Ct5N8sKHzwkRJ3Eg8=;
 b=Qdlhb71/inIgJrqvDNf2IyQO0Y9oPR8v+vKDhArL+fK4/WIDKTp+/2qnYakHBGNCxGbROl
 iQV+h8vsaQpbjLoqtPLO+D44whRlg9sA7F7wAdM4pBF7VELyZ6DGs9575jZ9Pt8ePQ/OP5
 2lQQsnFf3azHRmzpUW5PB8WxQf1Cye8frMVPzHbT1iH8hjL+fXVawQ3a/jQ5izhdYD061V
 Lxj1GB5ASVFXyTjyufIkduMmdWugqPftDQRkJrYwlfHi1rIJ3st712pNih3ySi3xSTIOBC
 /UIdERyI3hjD8ABrPDQ38M47R0C1z0Yltc5bfChrqOTv/ycTi9JURO64701HXQ==
Date: Sun, 14 Jun 2026 12:15:55 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] cmd: ums: Set Device Descriptor iSerial based on
 serial# env variable
Message-ID: <20260614121555.4e97faac@wsk>
In-Reply-To: <20260613025510.134239-1-marex@nabladev.com>
References: <20260613025510.134239-1-marex@nabladev.com>
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

On Sat, 13 Jun 2026 04:54:23 +0200
Marek Vasut <marex@nabladev.com> wrote:

> The DFU code currently sets the content of "serial#" environment
> variable into Device Descriptor iSerial field. This is useful when
> there are multiple devices connected to the same host PC and they
> have to be told apart. Replicate the same behavior in the UMS code.
>=20
> Example without serial# set, which is the original behavior:
> "
> u-boot=3D> ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000
>=20
> $ dmesg -w
> ...
> usb 5-2.3.7: New USB device found, idVendor=3D0525, idProduct=3Da4a5,
> bcdDevice=3D7e.a7 usb 5-2.3.7: New USB device strings: Mfr=3D1,
> Product=3D2, SerialNumber=3D0 usb 5-2.3.7: Product: USB download gadget
> usb 5-2.3.7: Manufacturer: Vendor
>                             <------------------------------- NOT HERE
> usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
> ...
>=20
> $ lsusb -vd 0525:a4a5
>=20
> Bus 005 Device 051: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB
> File-backed Storage Gadget Negotiated speed: High Speed (480Mbps)
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 [unknown]
>   bDeviceSubClass         0 [unknown]
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0525 Netchip Technology, Inc.
>   idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
>   bcdDevice           7e.a7
>   iManufacturer           1 Vendor
>   iProduct                2 USB download gadget
>   iSerial                 0 <------------------------------- NOT HERE
> ...
> "
>=20
> Example with serial# set to 1234abcd, which is the optional new
> behavior: "
> u-boot=3D> setenv serial# 1234abcd <------------------------------ HERE
> u-boot=3D> ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000
>=20
> $ dmesg -w
> ...
> usb 5-2.3.7: New USB device found, idVendor=3D0525, idProduct=3Da4a5,
> bcdDevice=3D7e.a7 usb 5-2.3.7: New USB device strings: Mfr=3D1,
> Product=3D2, SerialNumber=3D3 usb 5-2.3.7: Product: USB download gadget
> usb 5-2.3.7: Manufacturer: Vendor
> usb 5-2.3.7: SerialNumber: 1234abcd <--------------------------- HERE
> usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
> ...
>=20
> $ lsusb -vd 0525:a4a5
>=20
> Bus 005 Device 052: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB
> File-backed Storage Gadget Negotiated speed: High Speed (480Mbps)
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 [unknown]
>   bDeviceSubClass         0 [unknown]
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0525 Netchip Technology, Inc.
>   idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
>   bcdDevice           7e.a7
>   iManufacturer           1 Vendor
>   iProduct                2 USB download gadget
>   iSerial                 3 1234abcd <-------------------------- HERE
> ...
> "
>=20
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  cmd/usb_mass_storage.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
> index e8b87045bdc..335258d7a56 100644
> --- a/cmd/usb_mass_storage.c
> +++ b/cmd/usb_mass_storage.c
> @@ -9,6 +9,7 @@
>  #include <blk.h>
>  #include <command.h>
>  #include <console.h>
> +#include <env.h>
>  #include <errno.h>
>  #include <g_dnl.h>
>  #include <malloc.h>
> @@ -65,7 +66,7 @@ static void ums_fini(void)
> =20
>  static int ums_init(const char *devtype, const char
> *devnums_part_str) {
> -	char *s, *t, *devnum_part_str, *name;
> +	char *s, *t, *devnum_part_str, *name, *sn;
>  	struct blk_desc *block_dev;
>  	struct disk_partition info;
>  	int partnum;
> @@ -76,6 +77,12 @@ static int ums_init(const char *devtype, const
> char *devnums_part_str) if (!s)
>  		return -1;
> =20
> +	if (CONFIG_IS_ENABLED(ENV_SUPPORT)) {
> +		sn =3D env_get("serial#");
> +		if (sn)
> +			g_dnl_set_serialnumber(sn);
> +	}
> +
>  	t =3D s;
>  	ums_count =3D 0;
> =20

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
