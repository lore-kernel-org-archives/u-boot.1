Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD595C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 18:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA338775A;
	Wed,  3 Jan 2024 19:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y+9BT5ZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFD4875E9; Wed,  3 Jan 2024 19:39:29 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF2D877FD
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 19:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403IdARt098953;
 Wed, 3 Jan 2024 12:39:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704307150;
 bh=sRPbFhqj5N1/FPBHVXc4mSnSFRBOWpZ7E8LwHaWCaqA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Y+9BT5ZGHVonCtdoC7XwFAsafLUOSA8AcGPx7NXPuWg2fwKdfnAmqWfZbeFJz6Iko
 3l5dILkn6kCfVqT0fyQVlX0AvhrMyAbFQG94/UlmS1avEyVUyT5XtjSZA1VgA/INt+
 Dn4Vsk/1k8K0JhtKzngwlzJdjXJX080+lavTjcPY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403IdA7F065793
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 12:39:10 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 12:39:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 12:39:09 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403Id9BP051964;
 Wed, 3 Jan 2024 12:39:09 -0600
Date: Wed, 3 Jan 2024 12:39:09 -0600
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
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v7 16/17] doc: board: ti: k3: Add J784S4 EVM and AM69 SK
 documentation
Message-ID: <20240103183909.mzwi2itzmbp7pxwt@engaging>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-17-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219191537.4039361-17-a-nandan@ti.com>
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

On 00:45-20231220, Apurva Nandan wrote:
> TI K3 J784S4 and AM69 are new additions to the K3 SoC family.
> Add documentation about the J784S4 EVM and AM69 SK.
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  doc/board/ti/j784s4_evm.rst | 303 ++++++++++++++++++++++++++++++++++++
>  doc/board/ti/k3.rst         |   1 +
>  2 files changed, 304 insertions(+)
>  create mode 100644 doc/board/ti/j784s4_evm.rst
> 
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> new file mode 100644
> index 0000000000..bb7ed0b031
> --- /dev/null
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -0,0 +1,303 @@
[...]
> +
> +
> +More info can be found in TRM: http://www.ti.com/lit/zip/spruj52
> +
> +Platform information:
> +
> +* https://www.ti.com/tool/J784S4XEVM
> +* https://www.ti.com/tool/SK-AM69
> +
> +Boot Flow
> +---------
> +Below is the pictorial representation of boot flow:
> +
> +.. image:: img/boot_diagram_k3_current.svg
> +    :alt: K3 boot flow
> +
> +- On this platform, "TI Foundational Security (TIFS)" functions as the
"TI Foundational Security" (TIFS)

> +  security enclave master. While "Device Manager (DM)", also known as the
"Device Manager" (DM)

[...]

> +
> +Switch Setting for Boot Mode
> +----------------------------
> +
> +Boot Mode pins provide means to select the boot mode and options before the
> +device is powered up. After every POR, they are the main source to populate
> +the Boot Parameter Tables.
> +
> +Boot Mode Pins for J784S4-EVM
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following tables show some common boot modes used on J784S4 SoC platform.

Pick EVM Platform - since we are talking about evm in this context.

> +More details can be found in the Technical Reference Manual:
> +http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
> +
> +.. list-table:: J784S4 EVM Boot Modes
> +   :widths: 16 16 16
> +   :header-rows: 1
> +
> +   * - Switch Label
> +     - SW9: 12345678
> +     - SW8: 12345678
> +
> +   * - SD
> +     - 00000000
> +     - 10000010
> +
> +   * - EMMC
> +     - 01000000
> +     - 10000000
> +
> +   * - OSPI
> +     - 01000000
> +     - 00000110
> +
> +   * - UART
> +     - 01110000
> +     - 00000000
> +
> +   * - USB DFU
> +     - 00100000
> +     - 10000000
> +
> +For SW8 and SW9, the switch state in the "ON" position = 1.
> +
> +Boot Mode Pins for AM69-SK
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following table show some common boot modes used on AM69-SK platform.
> +More details can be found in the User Guide for AM69-SK:
> +https://www.ti.com/lit/ug/spruj70/spruj70.pdf under the `Bootmode Settings`
> +section.
> +
> +.. list-table:: AM69 SK Boot Modes
> +   :widths: 16 16
> +   :header-rows: 1
> +
> +   * - Switch Label
> +     - SW2: 1234
> +
> +   * - SD
> +     - 0000
> +
> +   * - EMMC
> +     - 0110
> +
> +   * - OSPI
> +     - 1110
> +
> +   * - UART
> +     - 1010

Just make sure that the dip switches match up to the boot modes we
support in u-boot.

> +
> +For SW2, the switch state in the "ON" position = 1.
> +
> +Debugging U-Boot
> +----------------
> +
> +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
> +detailed setup information.
> +
> +.. warning::
> +
> +  **Debugging the platform via JTAG requires latest OpenOCD tag**

This very vague. Use the same terminology as doc/board/ti/am62ax_sk.rst

> +
> +
> +Debugging U-Boot on J784S4-EVM and AM69-SK
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> +
> +To start OpenOCD and connect to J784S4-EVM or AM69-SK board, use the
> +following.
> +
> +.. code-block:: bash
> +
> +  openocd -f board/ti_j784s4evm.cfg
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index f19ee56f29..6b2faa9dc3 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -40,6 +40,7 @@ K3 Based SoCs
>     ../beagle/j721e_beagleboneai64
>     j721e_evm
>     j721s2_evm
> +   j784s4_evm
>  
>  Boot Flow Overview
>  ------------------

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
