Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA41C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 19:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B200C87CF2;
	Fri, 19 Jan 2024 20:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D2kVxVjc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC1F87D5D; Fri, 19 Jan 2024 20:25:57 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6229687C6B
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 20:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JJPkM1115981;
 Fri, 19 Jan 2024 13:25:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705692346;
 bh=pVVNSJE2NQEa8xLkAVbIP3U9Owo7z75OeByMbJKDCeE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=D2kVxVjcmvPjpbOHNdsQ3VjM7/NwuMKkXnKsJc7vbrC80q0NHdadwmG3gooqPW+BB
 YCqrSt24moVsccoZoc4RElTwvBSTcusfMgtwg7BhCaPtVJsHsxxOVtXyLQG+IhBzDD
 DanS0wfPO+khcwTRR0EC8G+hq4Niciol6buLuxAQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JJPjmU088427
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jan 2024 13:25:45 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 13:25:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 13:25:45 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JJPjGj129490;
 Fri, 19 Jan 2024 13:25:45 -0600
Date: Fri, 19 Jan 2024 13:25:45 -0600
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
Subject: Re: [PATCH v8 04/16] arm: dts: Add bootph-all for memory node
Message-ID: <20240119192545.dybq7b5yy22oar75@observer>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-5-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240119175043.3904751-5-a-nandan@ti.com>
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

On 23:20-20240119, Apurva Nandan wrote:
[...]

> diff --git a/arch/arm/dts/k3-am69-sk.dts b/arch/arm/dts/k3-am69-sk.dts
> index 9868c7049b..29884097b9 100644
> --- a/arch/arm/dts/k3-am69-sk.dts
> +++ b/arch/arm/dts/k3-am69-sk.dts

I think you mis-interpreted
https://lore.kernel.org/u-boot/20240103175221.ovjzcwwljnjhka2n@expire/
comment to modify kernel board.dts. I meant for you to squash that
correct change  to the patch that introduces board-u-boot.dtsi and r5.dts

Now that i read my comment, I can see why it might have been
mis-interpreted. Sorry about that - please squash your v7 patch
instead to appropriate patch.

> @@ -33,6 +33,7 @@
>  
>  	memory@80000000 {
>  		device_type = "memory";
> +		bootph-all;
>  		/* 32G RAM */
>  		reg = <0x00 0x80000000 0x00 0x80000000>,
>  		      <0x08 0x80000000 0x07 0x80000000>;
> diff --git a/arch/arm/dts/k3-j784s4-evm.dts b/arch/arm/dts/k3-j784s4-evm.dts
> index f1f4c8634a..662552c872 100644
> --- a/arch/arm/dts/k3-j784s4-evm.dts
> +++ b/arch/arm/dts/k3-j784s4-evm.dts
> @@ -31,6 +31,7 @@
>  
>  	memory@80000000 {
>  		device_type = "memory";
> +		bootph-all;
>  		/* 32G RAM */
>  		reg = <0x00 0x80000000 0x00 0x80000000>,
>  		      <0x08 0x80000000 0x07 0x80000000>;
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
