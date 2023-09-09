Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB8DEEB57C
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 10:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6B6D86844;
	Sat,  9 Sep 2023 12:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lPJsQzDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A780F86758; Sat,  9 Sep 2023 12:59:10 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74F48689A
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 12:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 4342ECE021B;
 Sat,  9 Sep 2023 10:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1CCC433C7;
 Sat,  9 Sep 2023 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694257142;
 bh=6H696fx5pDX/FDjh+6LMLxvfppvRLeHqz7Vq0PNG2lY=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=lPJsQzDueL0OI1N98wYik1hmYOT1PpZnqtk3SdUU3st57Dj1zPSIYC8e/p5e5raOx
 IqC6Wa9PDqTqEndj331Gr4SINGWbokthIHZF1WzawuQELNAkaD/NoB3BrnMbpNciUr
 2Ngait5nb24M5yEj/QnHflrXL03zsLMT2xnJSApU/4afkHLR9Kr32amEUCwowXwaCL
 QtHVd2V8bRol6Cuip1/EOZAV8IYzmz3qMdDKVn794ap6Yt0SNrovsqEuYd65KeMmsV
 lMV7HSocHoqm6lo1EgaAtAqOpQjsaBxsS1zLcznjTN/QIAy5MCtpiq2ZXqCW4o8ENk
 2mi6a8/Vkl7aQ==
Message-ID: <0f25c263-3add-ec80-9d5f-8393deba56d1@kernel.org>
Date: Sat, 9 Sep 2023 13:58:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 07/16] remoteproc: k3-dsp: Extend support for C71x DSPs
 on J784S4 SoCs
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
 <20230908110551.861575-8-a-nandan@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230908110551.861575-8-a-nandan@ti.com>
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
> The K3 J784S4 SoCs have four C71x DSP subsystems in MAIN voltage domain
missing period.

SoCs have/SoC has

> The C71x DSPs are 64 bit machine with fixed and floating point DSP> operations. The C71x DSP subsystem is a slighly updated version of the

slighly/slightly

> C71x DSP subsystem on J721e. And, same ip data can be used for J7200,

J721e/J721E
ip/IP

> J721S2 and J784S4.
> 
> Extend support to the C71x DSPs for J784S4 with J721S2 compatible
> string.


> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/remoteproc/ti_k3_dsp_rproc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
> index 1a2e9dd1f5..d856e31db8 100644
> --- a/drivers/remoteproc/ti_k3_dsp_rproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
> @@ -327,7 +327,8 @@ static int k3_dsp_of_get_memories(struct udevice *dev)
>  
>  	for (i = 0; i < dsp->num_mems; i++) {
>  		/* C71 cores only have a L1P Cache, there are no L1P SRAMs */
> -		if (device_is_compatible(dev, "ti,j721e-c71-dsp") &&
> +		if (((device_is_compatible(dev, "ti,j721e-c71-dsp")) ||
> +		     (device_is_compatible(dev, "ti,j721s2-c71-dsp"))) &&
>  		    !strcmp(mem_names[i], "l1pram")) {
>  			dsp->mem[i].bus_addr = FDT_ADDR_T_NONE;
>  			dsp->mem[i].dev_addr = FDT_ADDR_T_NONE;
> @@ -446,6 +447,7 @@ static const struct k3_dsp_boot_data c71_data = {
>  static const struct udevice_id k3_dsp_ids[] = {
>  	{ .compatible = "ti,j721e-c66-dsp", .data = (ulong)&c66_data, },
>  	{ .compatible = "ti,j721e-c71-dsp", .data = (ulong)&c71_data, },
> +	{ .compatible = "ti,j721s2-c71-dsp", .data = (ulong)&c71_data, },
>  	{}
>  };
>  

-- 
cheers,
-roger
