Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443F0C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 10:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7A28789D;
	Tue,  5 Dec 2023 11:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VO8tInkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DBB9878A0; Tue,  5 Dec 2023 11:21:06 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 790C2870DF
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 11:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5AKvbT073121;
 Tue, 5 Dec 2023 04:20:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701771657;
 bh=XBqJ+HpxwAjpB40RpNxtrWn5TlsSpQYZ2bTXAHJB8b4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=VO8tInkh0zSBgd55Em5cv+PG8yN1zaW1tEYHhd2tHtEEvcqlH0CJF3i+0qXpZbsCy
 nRSoVvT1csauJHbllPxurDrw0jHQnduSWIJqsNMk642Z5ySYjyA9CRfOBzkzq6tu3q
 0YxvtRw2wIfKi9gvR8rarObybwyitvgnn+mrJGQk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5AKvNt012739
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 04:20:57 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 04:20:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 04:20:57 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5AKuTX012920;
 Tue, 5 Dec 2023 04:20:56 -0600
Date: Tue, 5 Dec 2023 15:50:56 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <marcel.ziswiler@toradex.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>, <hs@denx.de>,
 <christophe.leroy@csgroup.eu>, <mr.bossman075@gmail.com>, <afd@ti.com>,
 <kamlesh@ti.com>, <nm@ti.com>, <c-shilwant@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v2 3/3] doc: board: ti: k3: Mention TI_DM argument
Message-ID: <20231205102056.dmkh4fntzs4thpdv@uda0497581>
References: <20231205094220.2301360-1-n-francis@ti.com>
 <20231205094220.2301360-4-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231205094220.2301360-4-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Neha,

On 15:12-20231205, Neha Malcom Francis wrote:
> Mention TI_DM argument can be used to fetch a custom DM binary in the
> A72 build instructions for K3 devices.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
>  doc/board/ti/k3.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index a127215ce5..f19ee56f29 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -320,6 +320,13 @@ use the `lite` option.
>   make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
>          BL31=$TFA_PATH/build/k3/$TFA_BOARD/release/bl31.bin \
>          TEE=$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin
> +
> +.. note::
> +   It is also possible to pick up a custom DM binary by adding TI_DM argument
> +   pointing to the file. If not provided, it defaults to picking up the DM
> +   binary from BINMAN_INDIRS. This is only applicable to devices that utilize
> +   split firmware.
> +
>  .. k3_rst_include_end_build_steps_uboot
>  
>  At this point you should have every binary needed initialize both the
> -- 
> 2.34.1
> 

For the series
Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit
