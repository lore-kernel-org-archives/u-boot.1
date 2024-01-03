Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D927C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 15:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9E98309D;
	Wed,  3 Jan 2024 16:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fk0DvxdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC327877CD; Wed,  3 Jan 2024 16:57:14 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF56807E4
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 16:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403Fv3wT035651;
 Wed, 3 Jan 2024 09:57:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704297423;
 bh=P3M3b4ZYAsYSczjvg45N9435a/4BghN9r3XlTbCduJw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Fk0DvxdYISvatw2/VJzeJ5ci9qt0Oy9Y2Ik1VBKpqlVxX+Z9fokU89TgdoRCx56rj
 Efg4iVneGf530PmV12+nlq5WvP22rB40R7R+rHjjkOIO9ErmkIW4fTAyzdClfS31bi
 zoYnj6E6au0x1WUDGwQlFlMOu8c6p0h5lLtfKKqc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403Fv3sL028291
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 09:57:03 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 09:57:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 09:57:03 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403Fv31o110937;
 Wed, 3 Jan 2024 09:57:03 -0600
Date: Wed, 3 Jan 2024 09:57:03 -0600
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
Subject: Re: [PATCH v7 01/17] arm: dts: Introduce j784s4 dts from linux kernel
Message-ID: <20240103155703.rwba3dnfoee64arh@antihero>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-2-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219191537.4039361-2-a-nandan@ti.com>
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
> Introduce the basic j784s4 SoC dts from the v6.7-rc1 tag of the
> linux kernel.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm/dts/Makefile                  |    1 +
>  arch/arm/dts/k3-j784s4-evm.dts         |  981 +++++++++++
>  arch/arm/dts/k3-j784s4-main.dtsi       | 2068 ++++++++++++++++++++++++
>  arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi |  743 +++++++++
>  arch/arm/dts/k3-j784s4-thermal.dtsi    |  101 ++
>  arch/arm/dts/k3-j784s4.dtsi            |  294 ++++
>  6 files changed, 4188 insertions(+)
>  create mode 100644 arch/arm/dts/k3-j784s4-evm.dts
>  create mode 100644 arch/arm/dts/k3-j784s4-main.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-thermal.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4.dtsi
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index e9e58c5478..b111abcc5b 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1410,6 +1410,7 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
>  			       k3-am68-sk-r5-base-board.dtb\
>  			       k3-j721s2-common-proc-board.dtb\
>  			       k3-j721s2-r5-common-proc-board.dtb
> +dtb-$(CONFIG_SOC_K3_J784S4) += k3-j784s4-evm.dtb

The CONFIG_SOC_K3_J784S4 has not yet been introduced. I suggest
changing the order of the patches: Introduce the base C files then
introduce the dts files.


>  dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
>  			      k3-am642-r5-evm.dtb \
>  			      k3-am642-sk.dtb \
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
