Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97BED17148
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 23:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3967188CC5;
	Tue, 22 Oct 2024 01:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jWZ7JfAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8097A88CFB; Mon, 21 Oct 2024 15:28:55 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3353488C63
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 15:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f2b95775so5229717e87.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 06:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729517331; x=1730122131; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/gm9qMtxJAEeRM95VewSipPtgwCIhqJg+I80r1GaWo=;
 b=jWZ7JfAPCkLoepsdwM2UNkDUTcJMRqAkD2WlcNeLrJLDKyCB/Bio8t5vbj1AEouhbD
 k4V+alMZm9+/D36E3o9bllwN0DgfpXu1KNchDNyvAspl/T82meyKkp9o9AGd9sU7gy1D
 R7QwdC+fYQvSspt4zT5nZZeHgt5Q61ASx0TZV7tJR/T9qo9g2ZU3S8n9KBBx4jiNHDpP
 CVJIMTJDUYi8uTIFjaJwku6PDYdIz/5qwbWUzi1xqYVgMi5ByUh4MBFTuqDZqKYAI7Xf
 0pSImnmhu3vXtujHuPy+4dHHZoCTk3b5Fe5XNQgIJ82J1NbayoDOY9iXX5GJsYfxr7TV
 QGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729517331; x=1730122131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/gm9qMtxJAEeRM95VewSipPtgwCIhqJg+I80r1GaWo=;
 b=Ikf8UVViU5C/J4RI97FfDzXmAtz+TXW/hLzCtqDQkeKbUvvA+VniPmhCONDc4io2dY
 H80P0BvLBryLm1eQWpqNTb0X6CmiFlK0r4+XiWgNF2c5L/4Jl6WY+GhV3G+xnrO5Xm6r
 QsRlIKz9WYwZWtFXE5UtPSRcldnQkDPYERfgWf+FKzqwuXHZQ779zqH7cTxiYjE6UCpx
 hkykGwkKySGNITVrxGf1kGdq0cDBW2NSCaQwsJ/UyT9X8OAUX7VNXvTTBNygMnTIVHKK
 J6szQeU8QrEUd3XJgkDLSt9kjjKvAeqexho39IXVTbQKB3+eU0aG3ShWm3JOXrrn94vH
 hbQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVAm5+zRV9yD7LsSNvMJPd7A/gP/KNQhTK40qo8x6IyaSpiKaatS2S941cVEeD0aASl2kHblg=@lists.denx.de
X-Gm-Message-State: AOJu0YyWTV0Zoh7cWLy/1rp+Gyg6QjkMIvpHRqYtbVh98XcVLrSS6mm0
 e5q3HElGYwWv7TIXNQI1zXXyNSQ9ANGprdvfgcdO4a6Ycl5w/EssIVry45ZNsv0=
X-Google-Smtp-Source: AGHT+IHC5mjADUYzm1NDoOaEh6pbfhw20oQZVk+/WO3nB3CZ53Hfh7TujxqSpMr8XibEuLCNYG2Uog==
X-Received: by 2002:a05:6512:3989:b0:52c:e10b:cb33 with SMTP id
 2adb3069b0e04-53a154d857fmr8475301e87.50.1729517331332; 
 Mon, 21 Oct 2024 06:28:51 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91599362sm203238266b.197.2024.10.21.06.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 06:28:50 -0700 (PDT)
Message-ID: <4b6297f7-4433-46c3-8661-4f68d7320c7f@linaro.org>
Date: Mon, 21 Oct 2024 15:28:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fdt: Swap the signature for board_fdt_blob_setup()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>, Alexander Graf <agraf@csgraf.de>,
 Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>,
 Andre Przywara <andre.przywara@arm.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>,
 David Feng <fenghua@phytium.com.cn>, E Shattow <lucent@gmail.com>,
 Eric Curtin <ecurtin@redhat.com>, Francois Berder <fberder@outlook.fr>,
 Green Wan <green.wan@sifive.com>, H Bell <dmoo_dv@protonmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, "Ivan T. Ivanov"
 <iivanov@suse.de>, James Hilliard <james.hilliard1@gmail.com>,
 Janne Grunau <j@jannau.net>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <kettenis@openbsd.org>, Matthias Brugger <mbrugger@suse.com>,
 Michal Simek <michal.simek@amd.com>, Minda Chen
 <minda.chen@starfivetech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Peter Robinson <pbrobinson@gmail.com>,
 Randolph <randolph@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Sam Day <me@samcday.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Tim Harvey
 <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 William Zhang <william.zhang@broadcom.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>, u-boot-qcom@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
References: <20241021114247.349863-1-sjg@chromium.org>
 <20241021114247.349863-2-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241021114247.349863-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Oct 2024 01:45:50 +0200
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

Hi Simon,

On 21/10/2024 13:42, Simon Glass wrote:
> This returns a devicetree and updates a parameter with an error code.
> Swap it, since this fits better with the way U-Boot normally works. It
> also (more easily) allows leaving the existing pointer unchanged.
> 
> No yaks were harmed in this change, but there is a very small code-size
> reduction.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

...

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ab2ceb5138..7a7a36831c3 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -147,12 +147,11 @@ static void show_psci_version(void)
>    * or for supporting quirky devices where it's easier to leave the downstream DT in place
>    * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
>    */
> -void *board_fdt_blob_setup(int *err)
> +int board_fdt_blob_setup(void **fdtp)
>   {
>   	struct fdt_header *fdt;
>   	bool internal_valid, external_valid;
>   
> -	*err = 0;
>   	fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
>   	external_valid = fdt && !fdt_check_header(fdt);
>   	internal_valid = !fdt_check_header(gd->fdt_blob);
> @@ -170,7 +169,7 @@ void *board_fdt_blob_setup(int *err)
>   	} else {
>   		debug("Using external FDT\n");
>   		/* So we can use it before returning */
> -		gd->fdt_blob = fdt;
> +		*fdtp = fdt;

I believe this is a breaking change. The qcom_parse_memory() call below 
expects gd->fdt_blob to point to the in-use FDT. This is a bit of a 
hack, but doing memory parsing this early simplifies things for us.

Additionally, this change doesn't make the function return -EEXIST when 
it should.

...

> diff --git a/include/fdtdec.h b/include/fdtdec.h
> index 555c9520379..9e36acc7e9b 100644
> --- a/include/fdtdec.h
> +++ b/include/fdtdec.h
> @@ -1191,11 +1191,13 @@ int fdtdec_resetup(int *rescan);
>    *
>    * The existing devicetree is available at gd->fdt_blob
>    *
> - * @err: 0 on success, -EEXIST if the devicetree is already correct, or other
> + * @fdtp: Existing devicetree blob pointer; update this and return 0 if a

It doesn't looks like this is initialised before calling 
board_fdt_blob_setup()?

Kind regards,
> + * different devicetree should be used
> + * Return: 0 on success, -EEXIST if the devicetree is already correct, 0 to use
> + * *@fdtp as the new devicetree, or other
>    * internal error code if we fail to setup a DTB
> - * @returns new devicetree blob pointer
>    */
> -void *board_fdt_blob_setup(int *err);
> +int board_fdt_blob_setup(void **fdtp);
>   
>   /*
>    * Decode the size of memory
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index 60e28173c03..e876b17f9ad 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1706,11 +1706,16 @@ int fdtdec_setup(void)
>   
>   	/* Allow the board to override the fdt address. */
>   	if (IS_ENABLED(CONFIG_OF_BOARD)) {
> -		gd->fdt_blob = board_fdt_blob_setup(&ret);
> -		if (!ret)
> +		void *blob;
> +
> +		ret = board_fdt_blob_setup(&blob);
> +		if (ret) {
> +			if (ret != -EEXIST)
> +				return ret;
> +		} else {
>   			gd->fdt_src = FDTSRC_BOARD;
> -		else if (ret != -EEXIST)
> -			return ret;
> +			gd->fdt_blob = blob;
> +		}
>   	}
>   
>   	/* Allow the early environment to override the fdt address */

-- 
// Caleb (they/them)

