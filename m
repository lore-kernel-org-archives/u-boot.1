Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D39E784BD
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E6E8711E;
	Mon,  2 Oct 2023 17:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ByRRwTtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F7E86DFD; Mon,  2 Oct 2023 17:27:07 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA31854BD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392FQuBB049098;
 Mon, 2 Oct 2023 10:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696260416;
 bh=hu7CJEjoOLzc9CQXwFCjTnGfnWPuUkR7TEf0iOur4SM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ByRRwTtkG4nty6kLj00BvM+b1Iaa2jBZutsnY8mAUTYxq/7D4YcJ3h8Mj8XRzUlb6
 8bII7fAv0Krw5eZc9i30Gs0JkPBeMnoj8lYIT5gQrjjXkEyMSTqREjxFH/KnADrni5
 oyQZmC26Xo/LbPDTZS1tMwEIH6cER+0cCUaQD0tI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392FQu8l119784
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:26:56 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:26:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:26:55 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392FQtTS119818;
 Mon, 2 Oct 2023 10:26:55 -0500
Date: Mon, 2 Oct 2023 10:26:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v4 16/16] doc: board: ti: k3: Add J784S4 EVM and AM69 SK
 documentation
Message-ID: <20231002152655.h6ayeal4olvycylt@munchkin>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-17-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231001165545.494212-17-a-nandan@ti.com>
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

On 22:25-20231001, Apurva Nandan wrote:
[...]

> +Debugging U-Boot
> +----------------
> +
> +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
> +detailed setup information.
> +
> +.. warning::
> +
> +  **OpenOCD support since**: v0.12.0

Did you check or just copy pasted?

> +
> +  If the default package version of OpenOCD in your development
> +  environment's distribution needs to be updated, it might be necessary to
> +  build OpenOCD from the source.
> +
> +Debugging U-Boot on J784S4-EVM
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> +
> +To start OpenOCD and connect to the board
> +
> +.. code-block:: bash
> +
> +  openocd -f board/ti_j784s4evm.cfg
> +
> +Debugging U-Boot on SK-AM69
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_cti20
> +    :end-before: .. k3_rst_include_end_openocd_connect_cti20
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_cfg_external_intro
> +    :end-before: .. k3_rst_include_end_openocd_cfg_external_intro
> +
> +For SK-AM69, the openocd_connect.cfg is as follows:

Did you check or just copy pasted am68?

> +
> +.. code-block:: tcl
> +
> +  # TUMPA example:
> +  # http://www.tiaowiki.com/w/TIAO_USB_Multi_Protocol_Adapter_User's_Manual
> +  source [find interface/ftdi/tumpa.cfg]

Why do you need TUMPA when you have xds110?

https://github.com/openocd-org/openocd/blob/master/tcl/board/ti_j784s4evm.cfg
> +
> +  transport select jtag
> +
> +  # default JTAG configuration has only SRST and no TRST
> +  reset_config srst_only srst_push_pull
> +
> +  # delay after SRST goes inactive
> +  adapter srst delay 20
> +
> +  if { ![info exists SOC] } {
> +    # Set the SoC of interest
> +    set SOC j784s4
> +  }
> +
> +  source [find target/ti_k3.cfg]
> +
> +  ftdi tdo_sample_edge falling
> +
> +  # Speeds for FT2232H are in multiples of 2, and 32MHz is tops
> +  # max speed we seem to achieve is ~20MHz.. so we pick 16MHz
> +  adapter speed 16000
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index ec447358ac..60aacdac99 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -35,6 +35,7 @@ K3 Based SoCs
>     am65x_evm
>     j7200_evm
>     j721e_evm
> +   j784s4_evm
>  
>  Boot Flow Overview
>  ------------------
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
