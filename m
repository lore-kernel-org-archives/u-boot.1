Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CE606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=keFsSdTV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/hhHoxq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5FB481169;
	Thu, 26 Nov 2026 13:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TShSGtGohCao; Thu, 26 Nov 2026 13:25:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA03381150
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795699535;
	b=PP94enNiJAEo52n0u4RhF4d0AbWFSyytea0QkPmJOnA56MaOZktOlL/ZumNABz5pjEkm
	 uJqkqL89/RAr29metXWcTC3TfAOSU4R+MH4N6uWFVHi/1jqLTDCLrPbEtc72xR7uKu0St
	 21q4l7Q13fqqezh6IoyWMVNYzVXXBr8rW72x1jMBoHMA7VIIbai5QtVQK8treIBrHBQ3k
	 KYTnLnvbFN73zgaXTCBwCYmTyP86Sl0cmHBg2oDMBT3xuxDLUA/olDizXkB3itN/dB7Ry
	 2EP/10VNe0RmW8H7Q5o+6/wXT6KmNjsjMzsrCqp+tRbZMGaW//0965bt/HpOZbmnv0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795699535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Sbp+pI2rdztf+mWeKImHuAP4g4YxJ33jdBllH8mhzVg=;
	b=EN4PWcQrdVjth/ivb2qrRJl3aNS/cA4dSBOEtY054uoXS31Md/hfHu4qAziLOmORoVja
	 +ESe60ob7rHznVFFtZuYFKzH0ZBGJgfd8/Djlx0YGOaRbtsDy+FVqeRJ1Ey9ffJW7D40B
	 YPKCLky1HTDUlzgAaMhzpHMCJCWMuUtfgbkjqjiRb/reyIwin4/vq4cNHvYUJj/O5F9Bj
	 wAsRGETty28oUIePoZOXqxozdrczvk1a9NdR7caK9fx9NTbmWjtkGbnGCsjCaQXS7D2Bt
	 HK7UEY/o9LJo6Y/bVx0fzv+y/Gu6SLOmyWD654SZc3hcTyX6P9Yo7zqUy3BthwoXxyg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795699535;
	bh=Sbp+pI2rdztf+mWeKImHuAP4g4YxJ33jdBllH8mhzVg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=keFsSdTVVGGFSKH5AvP9S7TuWcTeftYVurOkYXf672n5qzaQO9x/UxS8Ui9l5/2O0
	 VonHhAeeF7i9FSxt07/pwSQk3k/RT/R9bQsI527xjmUomCW9tEw097caaodpe5cUV9
	 YBayZ2um74KxuNA/+j/SH+NGW195nENwK1C/pbTvN7ni+WWzXpwIsTaBJEckGqguP5
	 D9ZVxs77x0SvGf1RLbw8blQjpCQvUMwzHiNQM7Eb4xO7DmSsQ9cRTvknyRUWHTxmvQ
	 CHFjhMB0lGUXOFFIB5NKM0dD7gzzD4X3diLDS6ECrYMmPYNzq7KAfmH8sseeHVBG9w
	 Z1suZYxaRWzCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA03381150;
	Thu, 26 Nov 2026 13:25:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CCAFF311
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA591404DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:25:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNPvYg9YXG3b for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:25:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 154D9404A4
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=B/hhHoxq
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 154D9404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:25:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C340423D4;
 Thu, 26 Nov 2026 13:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA251F000C6;
 Thu, 26 Nov 2026 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795699531;
 bh=Sbp+pI2rdztf+mWeKImHuAP4g4YxJ33jdBllH8mhzVg=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=B/hhHoxqYy7C3eqTp7TcJ5ns2ynzaaJX2oHWPL2yAbkxxFGv9rRkbptU80kwt7deV
 3sA40BOLtJhFnZw8TeR1iLpk4y2q8ylFYLZ6i+wxFBc3onwrMpz0Z3lA8msvVWhVOf
 Hhni50jfInjoqqtUYomINUCJoMBiyQ4Lebs0T0GwTMyYTmuI3jvhVpv/qJRS2wxR5t
 gdNrc4dQuJsM397jzBsYTOnCJcJwtHgt5x7FRT0ISIq6opgE8NXBujKOP5xB7jeUQu
 BOIwPUmNPzadAjbCcBE/mnJDIBnqOkBba7F+Snsp/qmtwY9sOKii635GEGsdjVLB3C
 xRYKrhQx9dgVA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mach-snapdragon: dram: report the sum of the banks as
 the RAM size
From: Sumit Garg <sumit.garg@kernel.org>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20261106-dram-sum-banks-v1-1-d464040e390b@oss.qualcomm.com>
References: <20261106-dram-sum-banks-v1-1-d464040e390b@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:55:25 +0530
Message-Id: <179569952578.130558.15361827226300915345.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-06 13:07 +0530, Vandhiadevan Karunamoorthy wrote:
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
> ---
>  arch/arm/mach-snapdragon/dram.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
> 
> 


