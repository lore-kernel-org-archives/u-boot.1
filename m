Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015CBC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 17:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D86F877FD;
	Wed,  3 Jan 2024 18:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iJ3KAY/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96AAB877FD; Wed,  3 Jan 2024 18:39:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D9E86EE2
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 18:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403HdVq8041742;
 Wed, 3 Jan 2024 11:39:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704303571;
 bh=MKT0zC7Ervj0qQTMZYMu2ShU2FWKv2aBkDyN/SMSb6g=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=iJ3KAY/QAWAjDyIjs4piKafMyXErVx479IfV9Qqp1R60d0nhQXEFLc/03ozPCLoFA
 B4lWduhw+cw2zvF2J8SnBrjrDWNi3C08ibekXOoimEA2bPdKrZ4gUqaT1e6n02cMS6
 9ZiFABvzaDNe54WOTPttjUrQuI4C4lYTkOR9vVjY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403HdVtK013578
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 11:39:31 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 11:39:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 11:39:30 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403HdU0I111250;
 Wed, 3 Jan 2024 11:39:30 -0600
Date: Wed, 3 Jan 2024 11:39:30 -0600
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
Subject: Re: [PATCH v7 10/17] board: ti: j784s4: Add boot environment variables
Message-ID: <20240103173930.46kojg6z3clxp25a@filter>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-11-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219191537.4039361-11-a-nandan@ti.com>
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
> Add env file with necessary boot variables.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  board/ti/j784s4/j784s4.env | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 board/ti/j784s4/j784s4.env
> 
> diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
> new file mode 100644
> index 0000000000..0055019074
> --- /dev/null
> +++ b/board/ti/j784s4/j784s4.env
> @@ -0,0 +1,18 @@
> +#include <env/ti/ti_common.env>
> +#include <env/ti/default_findfdt.env>

Other than the previous comment in board_late_init, which would remove
the need for findfdt call to setup fdtfile (mandatory for bootstd to
work properly)

> +#include <env/ti/mmc.env>
> +#include <env/ti/ufs.env>
> +#include <env/ti/k3_dfu.env>
> +
> +name_kern=Image
> +console=ttyS2,115200n8
> +args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02880000
> +	${mtdparts}
> +run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> +
> +boot_targets=mmc1 mmc0 usb pxe dhcp
> +boot=mmc
> +mmcdev=1
> +bootpart=1:2
> +bootdir=/boot
> +rd_spec=-

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
