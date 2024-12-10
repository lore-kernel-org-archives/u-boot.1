Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EE4E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 11:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A198928C;
	Tue, 10 Dec 2024 12:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ZPhZYH6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 245998928C; Tue, 10 Dec 2024 12:17:37 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83963891C4
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 12:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241210111732epoutp0412e5c0b2a6ea94d85192477b29ae3ede~PzLNlcFXx2454224542epoutp04e
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 11:17:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241210111732epoutp0412e5c0b2a6ea94d85192477b29ae3ede~PzLNlcFXx2454224542epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733829452;
 bh=qeQsQW7tF9GEV5N+qvLV0EtGBz9VaV4Ra7H8p6+zCRk=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=ZPhZYH6QaGn90MgRY9FLxe/kMKhhKhZv3ypCHrq+6W0CqxZaYqHUUCo4ZFKS44LFo
 EijH5AcniBN0EFKI4J60THBbzx7H6Fz1kHDmR+ScfeFTGeOIRkYoxfxWMa3K9ROe9F
 PBzlX06/OuCnaNnGm7uhbZe47PbiQIpY1CRiR1l8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241210111732epcas1p22ebb8959bcc7d1829eac6056d6e2edde~PzLNRJfSh2706827068epcas1p2B;
 Tue, 10 Dec 2024 11:17:32 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.237]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Y6x630wwGz4x9Pv; Tue, 10 Dec
 2024 11:17:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 13.D1.24218.A4328576; Tue, 10 Dec 2024 20:17:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20241210111730epcas1p384454179b58d6fd9c4db6f6021192624~PzLL2RUX51995919959epcas1p3h;
 Tue, 10 Dec 2024 11:17:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241210111730epsmtrp2d5cda971a34ccaead3146d8068582f8b~PzLL07Ebu2696926969epsmtrp2E;
 Tue, 10 Dec 2024 11:17:30 +0000 (GMT)
X-AuditID: b6c32a38-580dc70000005e9a-c9-6758234ade5e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 31.78.18729.A4328576; Tue, 10 Dec 2024 20:17:30 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241210111730epsmtip2eb332e28bb0ebbfe39942611ccb1f466~PzLLokZL03163931639epsmtip2B;
 Tue, 10 Dec 2024 11:17:30 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>, "'U-Boot Mailing List'"
 <u-boot@lists.denx.de>
Cc: "'Tom Rini'" <trini@konsulko.com>, "'Stephen Warren'"
 <swarren@wwwdotorg.org>, "'Stephen Warren'" <swarren@nvidia.com>, "'Matthias
 Brugger'" <mbrugger@suse.com>, "'Francois Berder'" <fberder@outlook.fr>,
 "'Ivan T. Ivanov'" <iivanov@suse.de>, "'Patrick Rudolph'"
 <patrick.rudolph@9elements.com>, "'Peter Robinson'" <pbrobinson@gmail.com>,
 "'Rasmus Villemoes'" <rasmus.villemoes@prevas.dk>
In-Reply-To: <20241209195528.730260-6-sjg@chromium.org>
Subject: RE: [PATCH v3 5/5] rpi: Use the U-Boot control FDT for fdt_addr
Date: Tue, 10 Dec 2024 20:17:30 +0900
Message-ID: <0b9401db4af5$1a2029c0$4e607d40$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHWHE+rJGlG6nTqz0NZt5G0ftzdLQFplRS9ATu07smy1IctoA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmga6XckS6wa5dNhY3D8xjszi0oonZ
 YsHkJ6wWH5bsZLFYt2oNm8XN1w4W37ZsY7S4Mb2F1eLVwTYWi6mTNrNbvN3bye7A7XF9mp3H
 7IaLLB47Z91l93h1YBW7x9k7Oxg9epvfsXksO3ed2WPG7DeMHuu3XGXx2Hy62mPj3NAA7qhs
 m4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygq5UUyhJz
 SoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BaYFesWJucWleel6eaklVoYGBkamQIUJ2Rk3
 ZtYVNEtXnN/SzdjA+FO0i5GTQ0LAROL5hqOsXYxcHEICOxgl+o79YoNwPjFKHLyxghHC+cYo
 sXXjfUaYlolfL0NV7WWUePz0LAuE85JRYvfVQ+wgVWwCehL/Fy1k7mLk4BARiJA4e8MPpIZZ
 YCKzxMlzO5hAajgFzCWWvvjADGILC3hI/Do0H6yXRUBVoun2ARYQm1fAUuLG6TdQmxUkfj5d
 xgpiiwg4SXxb3goWZxYQkZjd2cYMskBCYCWHRPOmd+wQDS4SN2Z3QdnCEq+Ob4GypSQ+v9vL
 BtHQzCixdMlBVginh1HiX8N1NogqY4n9SyczgbzALKApsX6XPsQ2Pol3X3tYQcISArwSHW1C
 ENUqEpdev2SCmX/3yX9WCNtDYtvym+yQENrOKHHhxCG2CYzys5AcPgthwwJGplWMYqkFxbnp
 qcWGBSbwuEzOz93ECE6vWhY7GOe+/aB3iJGJg/EQowQHs5IIL4d3aLoQb0piZVVqUX58UWlO
 avEhRlNgUE5klhJNzgcm+LySeEMTSwMTMyNjEwtDM0Mlcd4zV8pShQTSE0tSs1NTC1KLYPqY
 ODilGpgmMlbLZdXd3KSZkfXHdkncHk2G/FamtiWfJvSVKJ9IPrs/e7fJlTi76BSLdr/Q9Pv/
 XMLmeT7YXHu++c6BRTcylBgyeXvvFztYVK+flLZLavOhsk1RTdmGyZYfZDf8FAti2DTVoXUa
 yzrH3r2Cv+MaM6KPHq/emn6r59Mz/snvDha92Hx47poHN1cbLYm4WVXbdWXLieYPO7pCRR7b
 B+q/SmV22dc1U5yV78Wt9HBuM0mfghlxr2Ok9Rbndl10rbyT/puNMbSWudD48mPFfWaWs8pN
 nN7vX/PdZP2rA1/buPfW7Zd9p58unpqn+pW98EiOdfIBbYPHl7w/1Z2X269wK9DTxcUyNNgy
 4M87TyWW4oxEQy3mouJEAJeSphY4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvK6XckS6wdI+OYubB+axWRxa0cRs
 sWDyE1aLD0t2slisW7WGzeLmaweLb1u2MVrcmN7CavHqYBuLxdRJm9kt3u7tZHfg9rg+zc5j
 dsNFFo+ds+6ye7w6sIrd4+ydHYwevc3v2DyWnbvO7DFj9htGj/VbrrJ4bD5d7bFxbmgAdxSX
 TUpqTmZZapG+XQJXxo2ZdQXN0hXnt3QzNjD+FO1i5OSQEDCRmPj1MlsXIxeHkMBuRoneZ30s
 EAkpic9PpwIlOIBsYYnDh4shap4zShw808wEUsMmoCfxf9FCZhBbRCBCYu6vRWBxZoHpzBIb
 vztCNGxmlNja1M8IkuAUMJdY+uIDWIOwgIfEr0Pz2UFsFgFViabbB8AW8wpYStw4/YYR4ggF
 iZ9Pl7FCLHCS+La8lRFigYjE7M425gmMArOQuAsYGVcxSqYWFOem5xYbFhjmpZbrFSfmFpfm
 pesl5+duYgTHhpbmDsbtqz7oHWJk4mA8xCjBwawkwsvhHZouxJuSWFmVWpQfX1Sak1p8iFGa
 g0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgUlz6sJ3/3yrKk/Y1h/vesSwbWe9Vv+GHxNX
 zlm4O0Bdve71HWaOLEs+s7oHHx6oO6svfSS6unnlkrV/npi+v2F1NPX6dr7a+Y+OLtTQrXFn
 7PzSYd3V9PYpQ6hdWlmN48HdNnefGE5o+/+bLf3DtQvny9uDNf8qT35x5XX9rwQnKyNhLgP2
 Uy0TlnJmsNzueHxRkEvUPSxmtXnWg4wQ4x2pIksnVE36Z6c5bb+Cl/nHM8z7KjevaFz/ZFaY
 ucdRtRV1HxlyFPRFOg/aXpzAZnrFuyj1/Ib3/Cdy12xf1s4cn2gxIyjcQ3uq8icTl1ajkkvL
 n+vcunvozGILnjop4zrnMxs9ihgnzbk05bnFTxYlluKMREMt5qLiRABQOPIV/AIAAA==
X-CMS-MailID: 20241210111730epcas1p384454179b58d6fd9c4db6f6021192624
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209195632epcas1p32063037f67840aa83d0355e3d61033e1
References: <20241209195528.730260-1-sjg@chromium.org>
 <CGME20241209195632epcas1p32063037f67840aa83d0355e3d61033e1@epcas1p3.samsung.com>
 <20241209195528.730260-6-sjg@chromium.org>
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



> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Simon Glass
> Sent: Tuesday, December 10, 2024 4:55 AM
> To: U-Boot Mailing List <u-boot@lists.denx.de>
> Cc: Tom Rini <trini@konsulko.com>; Stephen Warren <swarren@wwwdotorg.org>; Stephen Warren
> <swarren@nvidia.com>; Matthias Brugger <mbrugger@suse.com>; Simon Glass <sjg@chromium.org>; Francois
> Berder <fberder@outlook.fr>; Ivan T. Ivanov <iivanov@suse.de>; Patrick Rudolph
> <patrick.rudolph@9elements.com>; Peter Robinson <pbrobinson@gmail.com>; Rasmus Villemoes
> <rasmus.villemoes@prevas.dk>
> Subject: [PATCH v3 5/5] rpi: Use the U-Boot control FDT for fdt_addr
>
> The fdt_addr variable is used in extlinux as a fallback devicetree if
> none is provided by the boot command.
>
> The existing mechanism uses the devicetree provided to U-Boot, but in
> its original, unrelocated position. For the rpi_4 I am using, this is
> at 2b35ef00 which is not a convenient place in memory, if the ramdisk
> is large.
>
> U-Boot already deals with this sort of problem by relocating the FDT
> to a safe address.
>
> So use the control-FDT address instead.
>
> Remove the existing comment, which is confusing, since the FDT is not
> actually passed unmodified to the kernel: U-Boot adds various things
> using its FDT-fixup mechanism.
>
> Note that board_get_usable_ram_top() reduces the RAM top for boards with
> less RAM. This behaviour is left unchanged as there is no other
> mechanism for U-Boot to handle this.
>
> In version 2, it incorporates some changes to fdt_addr, etc. suggested
> by Tom, as well as adding myself as a maintainer.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Drop patch to allow expanding the devicetree during relocation
>
>  board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 9122f33d88d..8f6ab1b1b9b 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -3,6 +3,8 @@
>   * (C) Copyright 2012-2016 Stephen Warren
>   */
>
> +#define LOG_CATEGORY	LOGC_BOARD
> +
>  #include <config.h>
>  #include <dm.h>
>  #include <env.h>
> @@ -325,19 +327,10 @@ static void set_fdtfile(void)
>  	env_set("fdtfile", fdtfile);
>  }
>
> -/*
> - * If the firmware provided a valid FDT at boot time, let's expose it in
> - * ${fdt_addr} so it may be passed unmodified to the kernel.
> - */
> +/* Allow U-Boot to use its control FDT with extlinux if one is not provided */
>  static void set_fdt_addr(void)
>  {
> -	if (env_get("fdt_addr"))
> -		return;
> -
> -	if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC)
> -		return;
> -
> -	env_set_hex("fdt_addr", fw_dtb_pointer);
> +	env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
>  }
>
>  /*
> @@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  {
>  	int node;
>
> -	update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> +	if (blob == gd->fdt_blob)
> +		log_debug("Same FDT: nothing to do\n");
> +	else
> +		update_fdt_from_fw(blob, (void *)gd->fdt_blob);
>
>  	node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
>  	if (node < 0)
> --
> 2.34.1



