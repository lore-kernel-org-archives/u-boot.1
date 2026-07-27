Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262BEC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7871D80E1D;
	Mon, 27 Jul 2026 12:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xKA330RS1-Oo; Mon, 27 Jul 2026 12:47:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61A9380DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785156442;
	bh=sokg0z38Wp2ecITsAgRifPvE0HPahKz15w/1qSE981c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oDHPeIawihjAx8/McNKXj1V8k7D5Nm7ZHYvYoPe3+ZKCc7C1+T35Go6xQUmH5ceo0
	 6wOfI21cDNJPnp7qJEgryV0korsyI+Pn4nnqIPfsuyxsQ+vpjZrvJP8vpI9OEapvXx
	 pz8Ai9Ay0Jzdu92rGzyzUgTgPOFA/ApIxy9m97ePNaIPQr0dAY4YnmCubc3ibsJcBc
	 RwNlgWNEKXidlvRPBHN5hFsglfQKLTA+Emofd0SXaWV49mSh8VnWjxk9yixEKiVOlF
	 wyBh66CDnCdGxsolzS+5BlwEN99smG8SI55Tv1k+HurDoRns5MIVuVQNKoiT9jVdnq
	 DRt9Pr7YMV7mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61A9380DE3;
	Mon, 27 Jul 2026 12:47:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B819569
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D9074006A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RsvkRl26kSPW for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:47:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C7E7240015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7E7240015
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7E7240015
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:47:20 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so13367115e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 05:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785156439; x=1785761239;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sokg0z38Wp2ecITsAgRifPvE0HPahKz15w/1qSE981c=;
 b=S3ho/TM2e3ei+XTaR1MLBkaIE6LxIBK5XziNz0xlr1yk9fgnLEgjoVzbFTFEOGwXId
 F4gg8mPN00Ch7e1rUz7J5F0Fb+y88/N+1+Dc4VEe/R55qG0zoxnQwktSxI2IBTeEVhHB
 j9qx009C6Ehn5oUYTUsTDeW65JK8sDjsr7XsmETKCIcnZPTxv9CiaTLqaTFI1JH9r+DU
 5YC9wl9pU89fV/3T/e+0JPJ8egXJ53Ze4zyQmcV6FZvQ6G+NgHOUcy2vFI1LWjVbD8+4
 a5oF7b5hREfnyXDNWGCAd41nJAIMTLF5zKH61ngfAQ190tvM3wSKPlVlMnGZaC38SAUx
 T/3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEXZHn2RGNBpqQW/cfR/Rz6+mgVMYDdkGTHYPFqlOQLk650jbd2ruDFYP+z5PL1Fazh+NzbyQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyCC0BGZFfGhV1+CM5M6wIybFvI0no+23w1Ry5WA6fuVyWxcndF
 dkVn4FRNbX0sq/q0DrMd3vAbIrngRMHszXLZHJTF88qMfdEt5fmeVIEcUF8fYWvNhlc=
X-Gm-Gg: AR+sD12oegxjEs3Coohl3ciMFWvdxEN1fMiXGqP5eG9QUwie/2DgR2YXB5LWS7W1bKG
 4YKCtZC3i71WM+NGK4wb5S0NDGwul3TXodlYgzMcbPHenkTkoeNFUG7YabLMIKU0JagBshny3EY
 /axEjkw2jIerk44mg52hzFa0+6CS+xkGBqwdvnmf+KQHIY1G3Ly/lfqHXDFXSkwfF3+KdgrWTRs
 yKu8JGEIi9VvIRUAHhn2MOlvyjTcAJaAJM4JDmujBOFKiLLbKr+DUReFAmXocpK4bv6CVsbjoh/
 mM9Uhoh1oMaflmMFKC8hxh3MpHmgKNb+XNambbFDPAEx1RjfS3wCenfv08+hX4G+dOODcxUy23i
 JdlwhpxSiE+MeBAHIADzA6AA57Y78ihw1kXrMrZzCdG6wzqcYmWSGrFH0ilO4PUsSo1lDfBNwKj
 7nOIX/s61HhN2ouZ9q9qVwdGZ6UgyHhxs0lq1JgOYJHw==
X-Received: by 2002:a05:600c:19c8:b0:495:5205:86c with SMTP id
 5b1f17b1804b1-496b5747d8dmr114590575e9.22.1785156438603; 
 Mon, 27 Jul 2026 05:47:18 -0700 (PDT)
Received: from [192.168.1.37] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ed6b76sm236142965e9.2.2026.07.27.05.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 05:47:17 -0700 (PDT)
Message-ID: <51d1cc74-ad84-49b0-916a-92200ce547c1@linaro.org>
Date: Mon, 27 Jul 2026 14:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] mach-snapdragon: spl: Update boot device
 information in SMEM
Content-Language: en-US
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>, Anshul Dalal <anshuld@ti.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>, Jens Reidel
 <adrian@mainlining.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
 <20260722-spl-v8-v8-4-cbfa79e85a9d@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260722-spl-v8-v8-4-cbfa79e85a9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785156439; x=1785761239;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sokg0z38Wp2ecITsAgRifPvE0HPahKz15w/1qSE981c=;
 b=TunRZttCrMCdsRVuWye6CX1Cpic0bbMJ7PyX8CoWbemtp9q48OI9syR/Ba+332x00W
 wPLiis1eUf2Ykq0L9G7rCOyEUszsfP0KXHIisTkNN6Y2vVGIfMJvu1XIAYJmIKM2zgZb
 r8bOdICVsqsl5Su5TRnyJRXoDJ5dndV31n3HQ2XtelLW2PdvzzY1Qu+Hngc8WgQ7vzlr
 4yuCvBJjesZacaeMngtbM2SFoFlSS7BSHeJmHhQ1GfKaA5pAOO8IJQYCUEY4NpFolsCM
 d2/kOjlarX8dseWUzwrIcqdfIBL5A9A0SmbQcWqc8crOQZBKGFv2sO73RIw9tJPr7YSG
 wSIg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=TunRZttC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 22/07/2026 09:41, Varadarajan Narayanan wrote:
> Update the SMEM with the boot device information got from the boot rom.
> 
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/board_spl.c | 46 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
> index 6ae59481ba9..69a32e5d8cf 100644
> --- a/arch/arm/mach-snapdragon/board_spl.c
> +++ b/arch/arm/mach-snapdragon/board_spl.c
> @@ -85,3 +85,49 @@ u32 spl_boot_device(void)
>  	pr_err("No boot device configured\n");
>  	return BOOT_DEVICE_NONE;
>  }
> +
> +#if IS_ENABLED(CONFIG_SPL_SMEM)
> +/**
> + * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
> + * @ctx:	Pointer to the global SPL context.
> + *
> + * This function initializes and populates various SMEM items with boot-related
> + * information, such as flash type, try-mode status, and ATF enable status.

ATF? what? where?

> + * Return: 0 on success, or a negative error code on failure.
> + */
> +static int qcom_spl_populate_smem(void *ctx)
> +{
> +	int ret;
> +	size_t size;
> +	struct udevice *smem;
> +	u32 *fltype;
> +
> +	ret = uclass_get_device(UCLASS_SMEM, 0, &smem);

still not rebased on qcom-next
> +	if (ret) {
> +		pr_err("Failed to find SMEM node (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	size = sizeof(u32);
> +	ret = smem_alloc(smem, -1, SMEM_BOOT_FLASH_TYPE, size);
> +	if (ret) {
> +		pr_err("Failed to alloc item: SMEM_BOOT_FLASH_TYPE (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	fltype = (u32 *)smem_get(smem, -1, SMEM_BOOT_FLASH_TYPE, &size);
> +	if (!fltype) {
> +		pr_err("Failed to get item: SMEM_BOOT_FLASH_TYPE\n");
> +		return -ENOENT;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_SPL_MMC)) {
> +		*fltype = SMEM_BOOT_MMC_FLASH;

missing wmb() ?

> +		return 0;
> +	}
> +
> +	pr_err("Boot medium not specified\n");
> +
> +	return -ENOENT;
> +}
> +#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
> 

-- 
// Casey (she/her)

