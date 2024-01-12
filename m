Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02980C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C78C879DB;
	Fri, 12 Jan 2024 13:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Lg0CEtsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05A7879DC; Fri, 12 Jan 2024 13:36:56 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F3E8760D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CCabEc019240;
 Fri, 12 Jan 2024 06:36:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705062997;
 bh=PBqj4qXQ5tLexUidYET8XSssee/qyqSRuo66Ksi/Slg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Lg0CEtsOhPg/fRi+MoYkJaJDXTP4vLIsKSwnkkg0z70beVP9Ip7zRjbiWZ4hLUgw9
 I6RLcjtfvfDe3MR2QXmnCk3aOQ2YZl2xmChpZc4EQPgIxzPuB1u8YxjKpN1RNeOkzQ
 aH49M750j/tgmWCNdBMGnG9AG/ppxiRQ0ch/ZZi4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CCabCW003586
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 06:36:37 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 06:36:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 06:36:36 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CCaaL8034208;
 Fri, 12 Jan 2024 06:36:36 -0600
Date: Fri, 12 Jan 2024 06:36:36 -0600
From: Nishanth Menon <nm@ti.com>
To: Sjoerd Simons <sjoerd@collabora.com>
CC: <u-boot@lists.denx.de>, Martyn Welch <martyn.welch@collabora.com>, Roger
 Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v4 7/7] doc: board: Add document for DFU boot on am62x SoCs
Message-ID: <20240112123636.2h44vbdffrjlik5g@kindling>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-8-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240112085317.1866449-8-sjoerd@collabora.com>
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

On 09:52-20240112, Sjoerd Simons wrote:
> Both AM62 SK and beagleplay support DFU boot in a similar way now;
> Document how to actually run DFU boot for both boards
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
> Changes in v4:
> - New patch
> 
>  doc/board/beagle/am62x_beagleplay.rst | 12 +++++++++
>  doc/board/ti/am62x_sk.rst             | 37 +++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
> index 7784e62b0b7..4c8b0845845 100644
> --- a/doc/board/beagle/am62x_beagleplay.rst
> +++ b/doc/board/beagle/am62x_beagleplay.rst
> @@ -270,6 +270,18 @@ for details.
>  To switch to SD card boot mode, hold the USR button while powering on
>  with Type-C power supply, then release when power LED lights up.
>  
> +DFU based boot
> +--------------
> +
> +To boot the board over DFU, ensure there is no SD card inserted with a
> +bootloader. Hold the USR switch while plugging into the Type C to boot into DFU
> +mode. After power-on the build artifacts needs to be uploaded one by one with a
> +tool like dfu-util.

Don't we also need a wiped out emmc unfortunately?

> +
> +.. include::  ../ti/am62x_sk.rst
> +    :start-after: .. am62x_evm_rst_include_start_dfu_boot
> +    :end-before: .. am62x_evm_rst_include_end_dfu_boot
> +
>  Debugging U-Boot
>  ----------------
>  
> diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> index b12dc85f06b..904a54cd5ff 100644
> --- a/doc/board/ti/am62x_sk.rst
> +++ b/doc/board/ti/am62x_sk.rst
> @@ -105,6 +105,20 @@ Set the variables corresponding to this platform:
>  
>  * 3.1 R5:
>  
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +* 3.1.1 Alternatively build R5 for DFU boot:
> +
> +As the SPL size can get to big when building with support for booting both from
> +local storage *and* DFU an extra config fragment should be used to enable DFU
> +support (and disable storage support)
> +
> +.. prompt:: bash $
> +
> +  export UBOOT_CFG_CORTEXR=${UBOOT_CFG_CORTEXR} am62x_r5_usbdfu.config
> +
>  .. include::  ../ti/k3.rst
>      :start-after: .. k3_rst_include_start_build_steps_spl_r5
>      :end-before: .. k3_rst_include_end_build_steps_spl_r5
> @@ -251,6 +265,29 @@ https://www.ti.com/lit/pdf/spruiv7 under the `Boot Mode Pins` section.
>  
>  For SW2 and SW1, the switch state in the "ON" position = 1.
>  
> +DFU based boot
> +--------------
> +
> +To boot the board over DFU, set the switches to DFU mode and connect to the
> +USB Type C DRD Port on the board. After power-on the build artifacts needs to be
> +uploaded one by one with a tool like dfu-util.
> +
> +.. am62x_evm_rst_include_start_dfu_boot
> +
> +The initial ROM will have a DFU alt named `bootloader` for the initial R5 spl
> +upload. The next stages as exposed by u-boot have target alts matching the name
> +of the artifacts, for these a USB reset has to be done after each upload.
> +
> +When using dfu-util the following commands can be used to boot to a u-boot shell:
> +
> +.. prompt:: bash $
> +
> +  dfu-util -a bootloader -D tiboot3.bin
> +  dfu-util -R -a tispl -D tispl.bin
> +  dfu-util -R -a u-boot.img -D u-boot.img
> +
> +.. am62x_evm_rst_include_end_dfu_boot
> +
>  Debugging U-Boot
>  ----------------
>  
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
