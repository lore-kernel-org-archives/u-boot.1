Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA517C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 08:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0E188662;
	Tue,  7 May 2024 10:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ybGkFdiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B72288720; Tue,  7 May 2024 10:14:37 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D195885F7
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 10:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 969DF1F9D7;
 Tue,  7 May 2024 10:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1715069672;
 bh=0eKzgTftRF3yb4I2bLw19bOB0f5axptapJsuMjZ8Gas=; h=From:To:Subject;
 b=ybGkFdiC5t6QZ/i9gFTausTAfVIvRckpQyFs44qq5Ow16sqq5EopchxnljG/yhqBJ
 mB/2JTQBy6y1liy1y4il6aclOeBzRP/Bj34Tk72lyu0LdKu/nhSrJktRA7d7EQoRC2
 v7Epfg4/m/SiNXdqQR2I/sfTOx/oqnKX3asK9qd565y/YMBgenGOWmeCxpWYDDie6G
 s44IJ6k0feujECgJYKEsNKrnVEKa9vyIskwTLyF9idox6uci6m1ps46sdkLGVaaTWX
 +Ignd25+zm9iiJ1nFFp/Qg79nYqShqyQEBM8Ofj4j/5LIgaxcsYxZdmzG4r3RGR7Yb
 y0688+PQ5/nkg==
Date: Tue, 7 May 2024 10:14:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 4/6] configs: am62x_evm_*: Enable USB and DFU support
Message-ID: <20240507081428.GA17112@francesco-nb>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
 <20240506143846.1252377-5-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506143846.1252377-5-martyn.welch@collabora.com>
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

Hello Martyn,
first thanks for your series, with this we might be able to drop some
downstream branch.

On Mon, May 06, 2024 at 03:38:44PM +0100, Martyn Welch wrote:
> From: Sjoerd Simons <sjoerd@collabora.com>
> 
> Provide config fragments to enable USB host as well as USB gadget and DFU
> support for a53 and r5. This relevant fragment is included into the
> am62x EVM a53 defconfig. For the r5, due to the smaller available size,
> the config fragment also disables support for persistent storage to free
> up space for USB support. This fragment needs to be included is DFU
> booting is desired.
> 
> The CONFIG_DFU_SF option is placed in the defconfig rather than the
> fragment as this is known not to be supported on all boards that can
> support DFU.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

...

> diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.config
> new file mode 100644
> index 0000000000..772bb2ab93
> --- /dev/null
> +++ b/configs/am62x_r5_usbdfu.config
> @@ -0,0 +1,28 @@

...

> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165

This is making this fragment TI _board_ specific, while the file name seems
to imply that this is generic for the TI SoC. Other vendors, using TI
SoCs, will likely want to use their own USB IDs.

Not a big deal and no need to change it, we'll handle this in our own
defconfig when we'll enable this, but I wanted to mention this.

Francesco

