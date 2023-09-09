Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007D8EEB587
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 10:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC5C86537;
	Sat,  9 Sep 2023 12:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q1y/cioq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9617864A0; Sat,  9 Sep 2023 12:56:21 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6127E86537
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 12:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id F3162B8230E;
 Sat,  9 Sep 2023 10:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4682DC433C8;
 Sat,  9 Sep 2023 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694256977;
 bh=cHdi6MY+90eDoH7+/pgqbLJex2aILXa18eefB1NVlQg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=Q1y/cioqulvbHcm9vX+K2bCZVr9jWMt1WTWOENeZx83M8bCJb5vMcUQtmeydSuKZN
 L4UlkIY9bts9MnMkAVPxzonnTEjPwyZeEh/QS3w/fxHuwlVq3QTV1k+hfi6F3qKsSX
 R3GpgNY6UkeVHkl8kAH0gEuNsraw9V6k74VOtVrG2l74rBTRIiC11yZSkfxBui6E6y
 qake73EENkGGgTye/Of1RJApftQ0J4FMhxWZanPzW8hsnJeKGG5H0D2C+tRC3tp7h1
 3EJlzFA7DqaEfSSQqStfwA4H98tYYlKNOn+OHD8eAfZRWLchgFy0KnszShM3GVWvT5
 Ed5WZaIcNVaKA==
Message-ID: <0b68fd7f-eb71-a5af-996b-898b8f8145c8@kernel.org>
Date: Sat, 9 Sep 2023 13:56:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 06/16] remoteproc: k3-r5: Extend support for R5F
 clusters on J784S4 SoCs
Content-Language: en-US
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Jason Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-7-a-nandan@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230908110551.861575-7-a-nandan@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 08/09/2023 14:05, Apurva Nandan wrote:
> From: Hari Nagalla <hnagalla@ti.com>
> 
> The K3 J784S4 SoCs have four dual-core R5F subsystems, one in MCU
> voltage domain and the other three in MAIN voltage domain. These R5F
> clusters are similar to the R5F clusters in J7200 and J721S2 SoCs.
> 
> Extend support to the R5F clusters for J784S4 with J721S2 compatible
> string.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/remoteproc/ti_k3_r5f_rproc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
> index 6f3e12d915..631e548dcc 100644
> --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
> +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
> @@ -855,7 +855,7 @@ static const struct k3_r5f_ip_data k3_data = {
>  	.tcm_ecc_autoinit = false,
>  };
>  
> -static const struct k3_r5f_ip_data j7200_data = {
> +static const struct k3_r5f_ip_data j7200_j721s2_data = {

No need to rename this.

>  	.tcm_is_double = true,
>  	.tcm_ecc_autoinit = true,
>  };
> @@ -863,7 +863,8 @@ static const struct k3_r5f_ip_data j7200_data = {
>  static const struct udevice_id k3_r5f_rproc_ids[] = {
>  	{ .compatible = "ti,am654-r5f", .data = (ulong)&k3_data, },
>  	{ .compatible = "ti,j721e-r5f", .data = (ulong)&k3_data, },
> -	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_data, },
> +	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_j721s2_data, },
> +	{ .compatible = "ti,j721s2-r5f", .data = (ulong)&j7200_j721s2_data, },

Where is DT binding documentation for this?

Don't you need compatible for ti,j728s4-r5f?

>  	{}
>  };
>  
> @@ -901,6 +902,7 @@ static const struct udevice_id k3_r5fss_ids[] = {
>  	{ .compatible = "ti,am654-r5fss"},
>  	{ .compatible = "ti,j721e-r5fss"},
>  	{ .compatible = "ti,j7200-r5fss"},
> +	{ .compatible = "ti,j721s2-r5fss"},
>  	{}
>  };
>  

-- 
cheers,
-roger
