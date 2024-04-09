Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DDBCD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 03:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC5488151;
	Tue,  9 Apr 2024 05:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Nn6SWC1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E25C8815E; Tue,  9 Apr 2024 05:55:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4298088145
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 05:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712634948; x=1713239748; i=xypron.glpk@gmx.de;
 bh=KO8q66meAtMa9XFCM6279yUF5Wps/y4I49cvr6j//Dk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Nn6SWC1DTM/kNvfxXUg9sVSTtKC/8APsbmGQLN3SVOcRE+M8nvm0wKdAaCqyD0k4
 ZNRSVczJXOxTmS1LO8rAMRhVecbigj+2LdgrWi9sYfa5iWDIReG233FHxHTlehSTe
 VIS6qkC6oVZk6ut4jHC3ts/f6tkgPbsOijugkEu9JsrN7YAzD90Uqj22GScOopKO3
 99KJHgNSf9LuOdDReIoOGsi10AeSS9IeC7b2VIxsmz1NOEWzHZhiI3rZzuTrckH6B
 IM6p9wheTACAfN22Pok9QYbixsnIF950NzhPhqouslGhBUoFYz+eDicewitUddqcl
 JbLDGCtYQae7KcBkTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1rx3nD0SN9-0036U7; Tue, 09
 Apr 2024 05:55:48 +0200
Message-ID: <cac63a03-b019-4aed-83de-db2effa1a2f1@gmx.de>
Date: Tue, 9 Apr 2024 05:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] board: Define GUIDs for firmware images
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Judith Mendez <jm@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-2-j-humphreys@ti.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240408223134.165877-2-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b4q7tc+DxyvmDnpZyJqPU+NS9HN3oYbKWKg+Wv8jpRYTNQ6WUUS
 tNPcewncDtJxyqMJKZdvCA5utIVcYd94SKipsWjzL09hy4+NzlCauBTT0AXhHfAfrCW6Izu
 DY0swUpFisj/lfRcjHljn4sfZImgTiEp9S/nUCsRvOlORqPMPzYiB0wrIaIhtRpm0JtZi0L
 w6sK0WrQwlqCGTx34T1+g==
UI-OutboundReport: notjunk:1;M01:P0:gn6XS48xtP0=;2SjoKKKv4ezw8O6NaN/JOlNMS4h
 9YDQJgOLpmkIICJ8DG0GXnZgWK8dF19aVSG/iU71jxxOKuf/ZIf+JzP+3KSoHBAsLHhpqXL6Y
 7vMDpfXLHYw/efe8BcUG2VTDPAvGIm9upzQyUR0wyfWutNtTYIJR8MEKTHe02+8pf/vbhSRQK
 QerVJjytOd2ZghU78roAw/9nA0wskEJgcPVC1J5Ej/qkjhxHgqetBlt9GNtGyk1TTZL7Un2UO
 gs4FwLPDLR3AsOFRBIEs52I9c5KdXGNJcaLB1wyq1y7YkzZPQ0X7lqa2CpcB3H8swSWRSFZ2b
 mOyprec9M5JP3je68cjdymAah94RMmOYODLgmX3/ahIed0h/vxY6ekO1xFI7FIA2WaLNnUOKy
 W7WByFPqcq0g5Bxjfrxc0eR4CCgDBnV8o/vEm6bZ42uT91FEXkPTrYHHv6SfqsSe0iuerxoVE
 nTAfKl8r6/KIEHFXDt5sOUnsbHnwmwTwg/v13FIoY0oPp3z+h9EExoQ2hjzbBKe+sh3QxCnkS
 Nt0lA3Zr0gDJlLZKdhB4Rsr9BQgzz2uamhQutxEj6o5+QbAYYL3AcORcLVo+B/EcO3CbORZyP
 UQKPk97FzoLrMuoH6GyPHase6nZE1svbDt6e2/UH14ct34T+WqeT7OvO765Hw9pCwxvHwHWQI
 XWoX2wBcZR8qrorx6lPrtoYruNqD5uJZbmFOhrG+BER2UjaDncNj3nTJ44y7X1+qKlZSveFtt
 JR4b4jydb+IWhPUfYF3DTXtOsIrHfIogrmoAXiMrsW08GFwGolxa1nBI3C9vEngJ448W1zmOV
 dcjYwnYYDxUQXN1TSSE6aCDTpHMzzGGkO10W9l/jK9tug=
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

On 4/9/24 00:31, Jonathan Humphreys wrote:
> Define GUIDs for the different firmware images (tiboot3.bin, tispl.bin,
> u-boot.img, sysfw). >
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>   include/configs/ti_armv7_common.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv=
7_common.h
> index 3def7b1027e..4ce14a9b84c 100644
> --- a/include/configs/ti_armv7_common.h
> +++ b/include/configs/ti_armv7_common.h
> @@ -16,6 +16,23 @@
>   #ifndef __CONFIG_TI_ARMV7_COMMON_H__
>   #define __CONFIG_TI_ARMV7_COMMON_H__
>
> +/* GUIDs for capsule updatable firmware images */

Please, provide code comments for the GUIDs, e.g.

/**
  * define K3_TIBOOT3_IMAGE_GUID - firmware GUID for K3 tiboot3.bin
  *
  * This GUID is used in capsules updates to identify the tiboot3.bin
  * binary.
  */

Cf.
https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-docume=
ntation

Best regards

Heinrich

> +#define K3_TIBOOT3_IMAGE_GUID \
> +	EFI_GUID(0xe672b518, 0x7cd7, 0x4014, 0xbd, 0x8d, \
> +		 0x40, 0x72, 0x4d, 0x0a, 0xd4, 0xdc)
> +
> +#define K3_SPL_IMAGE_GUID \
> +	EFI_GUID(0x86f710ad, 0x10cf, 0x46ea, 0xac, 0x67, \
> +		 0x85, 0x6a, 0xe0, 0x6e, 0xfa, 0xd2)
> +
> +#define K3_UBOOT_IMAGE_GUID \
> +	EFI_GUID(0x81b58fb0, 0x3b00, 0x4add, 0xa2, 0x0a, \
> +		 0xc1, 0x85, 0xbb, 0xac, 0xa1, 0xed)
> +
> +#define K3_SYSFW_IMAGE_GUID \
> +	EFI_GUID(0x6fd10680, 0x361b, 0x431f, 0x80, 0xaa, \
> +		 0x89, 0x94, 0x55, 0x81, 0x9e, 0x11)
> +
>   /*
>    * We setup defaults based on constraints from the Linux kernel, which=
 should
>    * also be safe elsewhere.  We have the default load at 32MB into DDR =
(for

