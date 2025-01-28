Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD5BC0218F
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 03:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64BE8187B;
	Tue, 28 Jan 2025 04:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qOZLRNuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D5081951; Tue, 28 Jan 2025 04:05:13 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE9781875
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 04:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50S34xvl1116599
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 21:04:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738033499;
 bh=WxnVlf2U8K9ANu4h+MyssxWt67T/VumoNF8TVBzKTTA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qOZLRNuGx3+g0R71QySWIkzl+Cv36WKwiwMcyvo4BBdSvohzRQH4qX85O2CzHkWmU
 OPkj8CeqYoVkqk2lGDcIYo7/7V4Ml3i4xOTfvTsfX/7WXNHo6DZgh9KrvmgifR+Ck4
 lOKfaJXI76tCYNFCTz/mnn+Wo1i6ASNnDGneIITI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50S34xjA101638
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 21:04:59 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 21:04:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 21:04:59 -0600
Received: from [10.249.140.248] ([10.249.140.248])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50S34pjb110871;
 Mon, 27 Jan 2025 21:04:52 -0600
Message-ID: <9fab0757-80f5-4f63-8b21-9b7776d5e170@ti.com>
Date: Tue, 28 Jan 2025 08:34:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] arm: dts: k3-am625-sk-u-boot: Add
 sysreset-controller node
To: Jonathan Humphreys <j-humphreys@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>, Nikhil M
 Jain <n-jain1@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240408212255.95255-1-j-humphreys@ti.com>
 <20240408212255.95255-13-j-humphreys@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240408212255.95255-13-j-humphreys@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Jonathan,

On 09-Apr-24 2:52 AM, Jonathan Humphreys wrote:
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Maybe this requires a commit message? It's not as self-explanatory to 
this series as the rest of the patches.
> ---
>   arch/arm/dts/k3-am625-sk-u-boot.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> index fa778b0ff4c..35bfeae75a0 100644
> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> @@ -46,3 +46,12 @@
>   &cpsw_port2 {
>   	status = "disabled";
>   };
> +
> +&dmsc {
> +	bootph-pre-ram;
> +
> +	k3_sysreset: sysreset-controller {
> +		compatible = "ti,sci-sysreset";
> +		bootph-pre-ram;
> +	};
> +};

-- 
Thanking You
Neha Malcom Francis
