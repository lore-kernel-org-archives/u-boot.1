Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067CDE784BF
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E9186C59;
	Mon,  2 Oct 2023 17:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cCvNSTPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2CA87190; Mon,  2 Oct 2023 17:54:16 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4637F86C59
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392Fs2q4040064;
 Mon, 2 Oct 2023 10:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696262042;
 bh=4uQJVSWSNnowPZQLH+SKYZQTw54+Re42w3COtg73vXs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=cCvNSTPiLi/xTHsH7Gm2odEs8IbJTXRsa+dTM1huGbswepZtrXKvzHU2wQS/zad25
 dyu/4NKZg9oWkA7GEN58X26aI77ZTXampLjN8YnrrLV2G4lrBB9pN1z2k9FeZhDhex
 3MVmiHcKqEBoGEQjf8A9fN48XowwbjIlXUoEG1b4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392Fs2mv004482
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:54:02 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:54:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:54:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392Fs1Se071540;
 Mon, 2 Oct 2023 10:54:01 -0500
Date: Mon, 2 Oct 2023 10:54:01 -0500
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
Subject: Re: [PATCH v4 03/16] arm: mach-k3: Sort SoC JTAG_ID entries
Message-ID: <20231002155401.5fpkea5722mywz37@desecrate>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-4-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231001165545.494212-4-a-nandan@ti.com>
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
> Sort JTAG_IDs for K3 SoCs in hardware.h in alphabetical order.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm/mach-k3/include/mach/hardware.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index 03b18f6bad..e8283c066f 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -43,13 +43,13 @@
>  #define JTAG_ID_VARIANT_MASK	(0xf << 28)
>  #define JTAG_ID_PARTNO_SHIFT	12
>  #define JTAG_ID_PARTNO_MASK	(0xffff << 12)
> +#define JTAG_ID_PARTNO_AM62AX   0xbb8d
> +#define JTAG_ID_PARTNO_AM62X	0xbb7e
> +#define JTAG_ID_PARTNO_AM64X	0xbb38
>  #define JTAG_ID_PARTNO_AM65X	0xbb5a
> -#define JTAG_ID_PARTNO_J721E	0xbb64
>  #define JTAG_ID_PARTNO_J7200	0xbb6d
> -#define JTAG_ID_PARTNO_AM64X	0xbb38
> +#define JTAG_ID_PARTNO_J721E	0xbb64
>  #define JTAG_ID_PARTNO_J721S2	0xbb75
> -#define JTAG_ID_PARTNO_AM62X	0xbb7e
> -#define JTAG_ID_PARTNO_AM62AX   0xbb8d
>  
>  #define K3_SOC_ID(id, ID) \
>  static inline bool soc_is_##id(void) \
> -- 
> 2.34.1
> 
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
