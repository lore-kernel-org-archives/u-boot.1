Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B3FE77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 14:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58298056B;
	Sun, 22 Dec 2024 15:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Glh2CNUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818EC80658; Sun, 22 Dec 2024 15:08:54 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD548056A
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 15:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BME8kg2430317
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Dec 2024 08:08:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734876527;
 bh=stLhyutGm0CvtKjKYNDgSxhDYr5I7Fh6lLQzX4DHJxk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Glh2CNUgU0h+oIuEk4jmx6TMk+xb6JUb/ARHGyJOtBEvZ1RJKGSxCN91qAgqAuxwE
 AdH7bMLQpithz5aAkj/9Uy8e3H6hF4RxEMK/CAemMYaWtEKPITF2o7GNUXjf6jbKX/
 L+DnvrZmjFYPpu0dJc3kTlVPggCUfh7U1wWcg2N8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BME8krg110718
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 22 Dec 2024 08:08:46 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 22
 Dec 2024 08:08:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 22 Dec 2024 08:08:46 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BME8gK2008534;
 Sun, 22 Dec 2024 08:08:42 -0600
Message-ID: <05b11035-b5ee-4589-aa31-3e095622a694@ti.com>
Date: Sun, 22 Dec 2024 19:38:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/8] arm: mach-k3: j742s2: Introduce clock and device
 files for J742S2 SoC
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
 <20241217-b4-upstream-j742s2-v1-5-13a6a127b344@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241217-b4-upstream-j742s2-v1-5-13a6a127b344@ti.com>
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


On 12/17/2024 4:37 PM, Manorit Chawdhry wrote:
> Re-use j784s4 clocks and power domains for j742s2 family of device.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   drivers/clk/ti/clk-k3.c                | 4 ++++
>   drivers/power/domain/ti-power-domain.c | 4 ++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
> index bf65f573cb86ed30aed96ea59189dd3b2f3b16cf..734a71a8ef00c7d673dfe409a99191b91cd10774 100644
> --- a/drivers/clk/ti/clk-k3.c
> +++ b/drivers/clk/ti/clk-k3.c
> @@ -104,6 +104,10 @@ static const struct soc_attr ti_k3_soc_clk_data[] = {
>   		.family = "J784S4",
>   		.data = &j784s4_clk_platdata,
>   	},
> +	{
> +		.family = "J742S2",
> +		.data = &j784s4_clk_platdata,
> +	},


Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>   #endif
>   	{ /* sentinel */ }
>   };
> diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
> index 5e7a4c5648d8f94d0f9587213837b31bf7245219..9dafb04a2a1bcd6f04f828812f2841bd8ddc3254 100644
> --- a/drivers/power/domain/ti-power-domain.c
> +++ b/drivers/power/domain/ti-power-domain.c
> @@ -116,6 +116,10 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
>   		.family = "J784S4",
>   		.data = &j784s4_pd_platdata,
>   	},
> +	{
> +		.family = "J742S2",
> +		.data = &j784s4_pd_platdata,
> +	},
>   #endif
>   	{ /* sentinel */ }
>   };
>
