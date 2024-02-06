Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B337FC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 17:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1717A876B5;
	Tue,  6 Feb 2024 18:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oGXnrell";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F09B6878A1; Tue,  6 Feb 2024 18:38:18 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2677876AE
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 18:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416HcEu5069040;
 Tue, 6 Feb 2024 11:38:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707241094;
 bh=X78lhD8dDzayXdFPvla3xr8ia7h9JliH8sigfDulWWc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oGXnrellLRhLmV5HT4X32twU5/8C/jINMFQy70VdRB0oH/g4lmr/7zhn5SjLDMR4/
 75bfpVU0sIxt0FzHvlzoBuIaycENM3VrvRlAmlbGzTA6xnxO+LU5+t3ruGKkog1mx7
 a41lsNFfWMbVe72OQ9zqKpZTvQhexLj1DkDpKFtg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416HcEDk043195
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Feb 2024 11:38:14 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 11:38:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 11:38:14 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416HcDOv037739;
 Tue, 6 Feb 2024 11:38:14 -0600
Message-ID: <eb8c6fdf-642b-40a5-be41-d555b2488c4a@ti.com>
Date: Tue, 6 Feb 2024 11:38:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] arm: dts: k3-am68*: Sync with 6.8-rc1
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
 <20240206-b4-upstream-j721s2-avs-v1-2-b75043c59969@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240206-b4-upstream-j721s2-avs-v1-2-b75043c59969@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/6/24 6:21 AM, Manorit Chawdhry wrote:
> Syncs the DT from Linux v6.8-rc1.
> 
> Remove udmap overrides and handle location change of chipid node.

Message doesn't match the patch. This patch should just be squashed
into the previous one anyway.

Andrew

> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-am68-sk-base-board.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/dts/k3-am68-sk-base-board.dts b/arch/arm/dts/k3-am68-sk-base-board.dts
> index 1e1a82f9d2b8..d0cfdeac21fb 100644
> --- a/arch/arm/dts/k3-am68-sk-base-board.dts
> +++ b/arch/arm/dts/k3-am68-sk-base-board.dts
> @@ -31,6 +31,7 @@
>   		can1 = &mcu_mcan1;
>   		can2 = &main_mcan6;
>   		can3 = &main_mcan7;
> +		ethernet0 = &cpsw_port1;
>   	};
>   
>   	vusb_main: regulator-vusb-main5v0 {
> 
