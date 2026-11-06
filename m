Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84A606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GasVRnxb;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XFD7e5mi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 919D881352;
	Fri,  6 Nov 2026 16:37:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tiDu8fJoR2de; Fri,  6 Nov 2026 16:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C14FC81756
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793983078;
	b=kpP8PNIOxB3OKYSM+TR9H0kXRi7AMzwewleZF1GDjc07PX67s3Fi1M6gEVLdD3V4QGQ8
	 ab3tx+xvh8uifgvr2HR2Ww6ybNrG6MmRdT9UFooiGgpTjsvOCixgvtK0PnIS+hrxmLRgC
	 vgsY3yT57VWTMwmQ4CHfTezyWd0NnZh7j3c8sactE+n7IIrNKJEORuoPlW1JnhdPXvONB
	 R0V3VpeExKeOPpqF8QmsfRkH+HdpxSwe7kLTmgfqDmxytBngeIGlfYzllQyVlWXU9GUFC
	 tn5Rih7QL8PBCSgPTJRNJjncUKOGkT5RPQfoE+m4rFYjubYF8RdgTikjxO+gxxPIcZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793983078;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jbf7t91YuDG+7i9VtNtSf8+unGOtMuLMHhzD3Twf7tU=;
	b=JAGx4vjOn9HBYaEt2CZkHI5GDDvueooFBR5YROV+mGGXWeQLLysFAVG76II1bEhiOUvL
	 PUQv/mN1AHFLg9OO46vyadc3MjFXnoLfUIZZv4cIZDgBMUQz5SM/CtYYI6774xN6N+nGp
	 i7iWdbz97fd31vFv+3uaq1Blu7w8EMQBMH/ft3uAB/OqSdQ7EP/CafwSrlTanNYW6H63k
	 ydRvrmROfeEjKhunTE89L6UFiTHMFTbB8w+766PB/Wd0Hx+b0QXw517Ty/KfnUR6OFpYr
	 tf4gV+RE27IpbFiVau/QPo+FM6Lygc/SjaHZhy33ODCuOnIgTP3dBbS0HbJqJXykcbg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793983077;
	bh=Jbf7t91YuDG+7i9VtNtSf8+unGOtMuLMHhzD3Twf7tU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GasVRnxb12259T+F1dGpC9VO8qsypZVDyFhIYD5RjD8Owg4n2q+wpMe5CJE3IWgW0
	 ImwIT6jcHKcpS0n6p1tJDDZwWZ1o8DXaF4rlZInFpZDYnOaZhngc+nPNfGXhxtyZ6Z
	 pYDeQnwSJor8mz1wgzj5zwLMYtR9wZ4kY3Ru/hVke0YfWrtDJ8NzLXMsDJGGE/yqda
	 zxRaMu9Iy0Xc+tCV3mV43deb8hU0Xq0Ci7P6aGgUcmbJct4y+4gxd5LCzyHOJivCC2
	 XB1HNUl/+lKiJjiZChA3QWiDXKSjXkGNEKJEx4p/eTZR/7H2RP3kF34wVVfc+ZlxaJ
	 liJ52F53J/L9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C14FC81756;
	Fri,  6 Nov 2026 16:37:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C4E62E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19729606B1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:37:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9BYwceR1SYO for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:37:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 09E4E6069B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=XFD7e5mi
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09E4E6069B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:37:54 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-491aaed7565so490420f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793983072; x=1794587872;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jbf7t91YuDG+7i9VtNtSf8+unGOtMuLMHhzD3Twf7tU=;
 b=XFD7e5miI9VecgjL1SSKYzBodJxiFKE10swNUkl/iCX8pyHR9TpjHv6NIQM9MiCcE6
 V2aVJD7Pw5lthl2E7IWHbySm6JxvT7R/Tk5Sw/O3r+5s/XFV4+QCx6A8cFBcRV3X8nLv
 ay2HlXHGfeEEiJxGP0hTd3gCa6NC6fMCQ+XD+yFFPCg64xDVB96vRDPAL5oFPzOcuiqu
 iWh4tlCh0zS8f+qGQ1YwQ53IRDUgYCOdXz3MQsi6Lz1Aa+Tg3+jE6eAViR8mLpRJ8z+j
 LFwvDn2Q/g6WLfkDi+I1omNcjHrddOHZhTbMYMlTfIpuslYpyhB4xduhV7fIBqSAQIPd
 fYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793983072; x=1794587872;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jbf7t91YuDG+7i9VtNtSf8+unGOtMuLMHhzD3Twf7tU=;
 b=TLQ28f0pXBEfQcHlLzanpcfzqc8mOj6Am7K4T2+liykWflRQjAD+dwKXcnGQ3C24Eq
 9XhXskVrvX0xFsm4OY7j+W3/5EdL5KLxtO/nRRK4IO+/AokeJGnqJyAuAWLRGBo//dSW
 nGzPdxnRgciJkMd0PFKetFOVVlWvNOl0cLeCy/V+3NVd1BvKUTd7gVbkWC9kxG9/9q8j
 XELAWdP4afzhqrcEdeqVcOydSVqOc1reF1MsNOdIu9wRAxe1b3IpmLahVlUJktbwbaOz
 ZbCuEO+yTXO3cZoc/duoWh5rJV6R2z6nVcjOlEDto8jWzoRTzlSIdxxlosAzwj02GmTr
 01Pw==
X-Forwarded-Encrypted: i=1;
 AL+hErHO0ItiusW2b80Hd7l2NUB/4PpyYfBQIt+aYiNb6IEYKfMosDaNFjdLEHJZs9JjMj61112jmXg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+EMt+wYIe956LKf+aDu1la4gnU8SSp21amtkvc9Jat45YJW4a5
 flkV6gj9/BM0xy2U5kHa4JpMthiDih5v2y4rhzUPSY6IQQtVz0C5uwB0D6jf91HBbqU=
X-Gm-Gg: AYBFou2IOtov3QaDqsJg37HGPbDF8h5Id5vlU3IWEaZtNhhUalmvXz8F5QIgYVORDSg
 r4dlh2459vXupANQW8t1aLhyv4DGeDJMhJ4M/I8CyGercm00Zl0ilS/wEd/YJiV4ZNF5Rna3p9u
 0bDxmAoTHL6YG0QJHlAEc+Z26WeAMiZYTRiKu/mbpSqmroRA2vo6L7W/mbuvIIvKPrXYoT2Yqo2
 wVb60zlK+3WXw3jaZbVASQQbgVzokYL0FfVHTg00SjT70QcdWN4EORiSvfjV4KC9eoNl1Vpr2s4
 4z1YHraSikNhpO53Cw/90L90uEFWPcuagrvJlCcwVLCHLgOO+OBqUSCNrP0fOMuPcz3aV1YMnQ6
 QC3jZsjRw/h6w+9iqWvB/KeZgCbYXr/Jlmk1eJqVu4N8nn9+mCgSutFmy+xeCdB34EIRlGUMiqC
 qLPWSjV8+zAIICM7PUWlZjWFkcENqBzaotmR2ZvAGDQfZmkdn8x/SNrOuy1w6zik07oc2wXKklm
 INJz0pvxvo0IWXpypS06BEJ4QRbs1IZAfZ4RSQ1dO7GDaO4H5tN6Gku/nJ8RRgLGP4vYX06eMkl
 3LPiVNx7GFj02RvTS8usQnfCSKZrWm5kLCBhKzcQk6xI+eAR9+GOXE4u/VCicT9Wdjzs
X-Received: by 2002:a05:6000:2892:b0:48e:d27:bef2 with SMTP id
 ffacd0b85a97d-49276a6e26fmr6496608f8f.21.1793983072342; 
 Fri, 06 Nov 2026 08:37:52 -0800 (PST)
Received: from [192.168.1.37] (p5b29ebc8.dip0.t-ipconnect.de. [91.41.235.200])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc628dsm4728322f8f.48.2026.11.06.08.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 08:37:51 -0800 (PST)
Message-ID: <de41abe7-2987-4fe5-8f13-36d46de69c01@linaro.org>
Date: Fri, 6 Nov 2026 17:37:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: dram: report the sum of the banks as the
 RAM size
Content-Language: en-US
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20261106-dram-sum-banks-v1-1-d464040e390b@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20261106-dram-sum-banks-v1-1-d464040e390b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 06/11/2026 08:37, Vandhiadevan Karunamoorthy wrote:
> qcom_parse_memory() set gd->ram_size to the span from the start of the
> first bank to the end of the last one, so that the relocation address
> computed in setup_ram_config() lands at the end of the highest bank. With
> sparse banks, such as 2 GiB below 4 GiB plus 2 GiB at 32 GiB, the DRAM
> line then reports '32 GiB (total 4 GiB)'.
> 
> Make gd->ram_size the sum of the bank sizes and provide the relocation
> address through board_get_usable_ram_top() instead, taking the end of the
> highest bank. Boards with a single bank are unchanged. On boards with
> holes between the banks, the values derived from gd->ram_size, such as
> bootm_size, now reflect the real amount of RAM.
> 
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  arch/arm/mach-snapdragon/dram.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
> index 732e2bde2d2..af5e19960d9 100644
> --- a/arch/arm/mach-snapdragon/dram.c
> +++ b/arch/arm/mach-snapdragon/dram.c
> @@ -20,6 +20,15 @@ static struct {
>  	phys_size_t size;
>  } prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
>  
> +/* End of the highest memory bank, U-Boot is relocated to just below it */
> +static phys_addr_t qcom_ram_end __section(".data");
> +
> +/* Override the generic helper, gd->ram_size no longer spans to the highest bank */
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +	return qcom_ram_end ?: gd->ram_top;
> +}
> +
>  int dram_init(void)
>  {
>  	/*
> @@ -198,6 +207,10 @@ static void qcom_parse_memory_dt(const fdt64_t *fdt, int *banks, phys_addr_t *ra
>   * to correctly determine the relocation address for U-Boot is to parse all
>   * memory regions and find the highest valid address.
>   *
> + * gd->ram_size is set to the sum of the bank sizes, as the banks may be
> + * sparse. The relocation address is provided separately, as the end of the
> + * highest bank, by board_get_usable_ram_top().
> + *
>   * We can't use fdtdec_setup_memory_banksize() since it stores the result in
>   * gd->bd, which is not yet allocated.
>   *
> @@ -213,6 +226,7 @@ int qcom_parse_memory(const void *fdt, bool fdt_is_internal)
>  {
>  	phys_addr_t ram_end = 0;
>  	int banks;
> +	size_t i;
>  
>  	qcom_memmap_source = fdt_is_internal ? QCOM_MEMMAP_SOURCE_INTERNAL_FDT
>  					     : QCOM_MEMMAP_SOURCE_EXTERNAL_FDT;
> @@ -234,7 +248,10 @@ int qcom_parse_memory(const void *fdt, bool fdt_is_internal)
>  	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
>  
>  	gd->ram_base = prevbl_ddr_banks[0].start;
> -	gd->ram_size = ram_end - gd->ram_base;
> +	gd->ram_size = 0;
> +	for (i = 0; i < ARRAY_SIZE(prevbl_ddr_banks); i++)
> +		gd->ram_size += prevbl_ddr_banks[i].size;
> +	qcom_ram_end = ram_end;
>  
>  	return 0;
>  }
> 
> ---
> base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
> change-id: 20261105-dram-sum-banks-baea15fe7734
> 
> Best regards,
> --  
> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

-- 
// Casey (she/her)

