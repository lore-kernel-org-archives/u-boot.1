Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407D3E784BE
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63F786E06;
	Mon,  2 Oct 2023 17:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xsXexG1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 745C486E11; Mon,  2 Oct 2023 17:39:12 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE6386DE1
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392Fd1il047649;
 Mon, 2 Oct 2023 10:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696261141;
 bh=HoUZ5g4VOo2PKRIDwvACS05qx5BG7Zzc0/Q1PomtksQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xsXexG1gxIIs3kMphgapxMG9a23jlMojmuJYLKKnxTtmlvHgKwiKIUBEJyrAaciT6
 kF/CIFh7Dqu2YIoT3jjk/Vz66bUYsPI5n+rGauHP1ECHcDejSDpk+wfzpuzbJDQG76
 NxqcH2f+p/2gqxItyMFkDJ/EqIUeVCrpwGqn2C4I=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392Fd1Y9019765
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:39:01 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:39:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:39:00 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392Fd0cp058869;
 Mon, 2 Oct 2023 10:39:00 -0500
Date: Mon, 2 Oct 2023 10:39:00 -0500
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
Subject: Re: [PATCH v4 12/16] board: ti: j784s4: Update env to use am69-sk dtb
Message-ID: <20231002153900.putpm3ybdgtr3zhl@sibling>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-13-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231001165545.494212-13-a-nandan@ti.com>
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
> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 
> Add condition to select right dtb for AM69 SK vs J784S4 EVM board.
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  board/ti/j784s4/j784s4.env | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
> index 74f822440e..7c57952bfb 100644
> --- a/board/ti/j784s4/j784s4.env
> +++ b/board/ti/j784s4/j784s4.env
> @@ -10,6 +10,8 @@
>  default_device_tree=ti/k3-j784s4-evm.dtb
>  findfdt=
>  	setenv name_fdt ${default_device_tree};
> +	if test CONFIG_DEFAULT_DEVICE_TREE = "k3-am69-sk"; then
> +		setenv name_fdt ti/k3-am69-sk.dtb; fi;
>  	if test CONFIG_DEFAULT_DEVICE_TREE = "k3-j784s4-evm"; then
>  		setenv name_fdt ti/k3-j784s4-evm.dtb; fi;

What function is this doing? Why not leave it for defaults?

Just use include/env/ti/default_findfdt.env and be done with it?

>  	setenv fdtfile ${name_fdt}
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
