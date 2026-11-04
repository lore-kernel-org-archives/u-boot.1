Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE849606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZHeEMUoN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=B5gVHw2n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A56C1405A7;
	Wed,  4 Nov 2026 04:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UtvvcyajifoY; Wed,  4 Nov 2026 04:20:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A838940583
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793766013;
	b=oy6gTkmRGxkm+I2W8YOexDRBf3EJSLiaJTWYxTdxlaT1OAydVLvXi7dLrI6swLvGxqsa
	 4HuTDy81ZFvKCLyNs7DkZKNVQfjLf3MzRYK5kp5gPk74RBxKibnObQVSLOmF7JLoKG+++
	 NZnab2JQhB54FLz5R8e3BCkwTr7QiE19SLDx7vijZZkIpLM6hVAOOyQ5QoCktT5AGk1QY
	 +no5Cm5mFy4bLTAGnUBqqceYVZI/F4FtVxwtpnnkMhUB+kt+jDONWgfvLl9lhy2Ee/YOp
	 tD79YRCqDl+sB/7lISjA0UM95ztl8SdIf+clPWRwhn7a4qXVHuzzND8u1U3oGo/K18g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793766013;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fdx3MKi8uhLXVkBnoT1stA91pjr/THxW6wjZ/JZ4RZ8=;
	b=Lnw+Ke98tI+8zcDd4gX1/Vn8k498EIoFxbA6gaKr1V5R0ZycEAZvw5yToCSEH6V4fcWu
	 oUJCMJcroOHaouoeYo+dB5xZ0z2d2PYPLoDLd7LWi34IXMV+AoLxBYlPQum//PQElH7tx
	 HTal1Q9WemOuZsFlGppokTwrPqe8yXJZQSSiz3338PknJ8gh9HHGpHh1Z7kFme5KmcIQR
	 bDc78PyT/D+SjM0EnM1vgC8QSTgOI8J+krSARAfiX2WczVdoZ5imVSIPbpC0EYmm8ruqo
	 BmmKZUV+QE+gckzASsFOj3MDjTrzXtmUqJs+2xJ5C8qA9p8GbtaoxtdDkYlPE/VCpYQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=B5gVHw2n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793766013;
	bh=fdx3MKi8uhLXVkBnoT1stA91pjr/THxW6wjZ/JZ4RZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZHeEMUoNEOFlNon6ByxDUQp0jNwfjtdHbQL4VZewwJtVxoXHq47MppgGxadmpRz0R
	 YKeHCFngzRP4Q4TXbYyd1lNRu0K0k5Dh2a0FJiRcliXBl3Z3jmarsq5C0UTo6vUqwN
	 r0sS7F7wi83z83b9Sz02mSdBoP2PEPxQH1OSfoejnpdyfY/xM8vmO9uh1wGGSonKd6
	 PbujMDzgfV//WF63Z2HNTeTYEUjLwR/u5K4UcPyIAfMhnG+DVX0pLZl9YJdvcG/I0O
	 peGUqf4kbwzuI982BkOroukaQMDwSCDCQFae1Sy8vFdx2MHBPiI3I8bCrr/23nLtat
	 nHeiyokgES2kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A838940583;
	Wed,  4 Nov 2026 04:20:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CFAD2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E84240583
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:20:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7UXgP3Pq0X7n for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 04:20:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D3B2E40581
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793766011;
 b=b6FYfQzVm/DQ5AndMRbimRQGUD3Qv5CnEQhRt5IvLwB0+alIDHpV5/n7Y7SU7hmbraci
 hEXNDPeGa8IEJ9RD3GU84law3n9pvzO4yraZUJWEzyu1bGuYxbgEjj1g51kGMeuFAJDeI
 R02mV748lLs6e6UyeRGrBXxpqaj53VIxMEfuC9rTuTSISsi+UmNxu2N1UMp5Px+kMh3xL
 HKrcgA5mpV0oCqWIcGXs0U9FVmyXanm/S3pl/ut5vTEbDkFh8v10tUIx00g4R2cDhCsG5
 X1w3sJ884vfYkqcvUpkVnsSSH3mOUC1sZQ6SqcRJbS6dzyjZwImo6/BrPfdqR2DGXLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793766011;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=fdx3MKi8uhLXVkBnoT1stA91pjr/THxW6wjZ/JZ4RZ8=;
 b=scG5MqxlP/iMPAYgRLUhFaznflMk8bZOVMOhWhMsFzVosUZHRXzH1IlxPPIQKg7stK82
 GQdRwIc7bm9lFikzo0MkIWDXvZ/8pjnfr0ZC+v65LviP5NK3VGWQwrZHPFlovb0vxH/Nw
 EU4o0g+TqNQBA6SL73TppBmiQLr3pTFVWp0TixkYJ/bAOUb0JP/m615IMY51fqHUV6BVL
 rAKBmS9GVPiyhSuAlRadRiUHNIViJtsjyfqocyJ1E4Hrwpll8f7cHn1hX2uspf4YBl2g7
 riU2AMCUsyiADq7uo+TvBG12S5dtvuxBbl9x1Zv3//qVGF6ZBwMGAoY7sm5ChLs5LrQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=B5gVHw2n; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=B5gVHw2n
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3B2E40581
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793765981; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QACx1unNAQ+k0b0eaxf/ONOEAk25gYLtqTOH1X1S9Pgtzc7gB5f8uqZ9/4P5Ji052KA9uHNshTlZ2flOKvYI8Qv8OGggozoNV1gRrE8LDk5dYEKPU7LjzGcvNEfGrk62H0Sc4mU6CVql4UtZ9rRvpcZwhtoPv+ZBYIFFkX3nFF8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793765981;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fdx3MKi8uhLXVkBnoT1stA91pjr/THxW6wjZ/JZ4RZ8=; 
 b=SidAr5ohkIowd+t5cfbtHP9wLNtPDPkO/LbqUaThV+gy6hq9bKGYqX+9qGYPPDM0o7pv7V1TkrK5mxphfBGxMdssrWykYFb3LrAnPr2uCaTwu82s4XEg7h9La9h/MOQBRtZuUzkO+oE5YbNifI7dA3ZeBcMN46YHMM1T9ddN1gU=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=B5gVHw2nT/FckZr/R6EKV13NmUC47BLACqph2He1tsfeBqJYATgEphvdOnPlBp2n4wTikWcsg5CCmhsTez1vPgq1Pv0yCrL5+cx+nD6p7v87gtSmDo4UYBnSQHGrTu+1pJVCssaHBzR90VsZ8SNnQSieVrjye9EpEqRfXWw4hF0=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=fdx3MKi8uhLXVkBnoT1stA91pjr/THxW6wjZ/JZ4RZ8=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793765980477903.7168983227309;
 Tue, 3 Nov 2026 20:19:40 -0800 (PST)
Date: Wed, 4 Nov 2026 04:19:33 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrei Lalaev <andrey.lalaev@gmail.com>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH 5/8] board: sophgo: milkv_duo: initialize PLLs in SPL
Message-ID: <auqyVVLqnKxPadXk@pie>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
 <20261021-milkv-duo-spl-v1-5-ee7618860237@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-milkv-duo-spl-v1-5-ee7618860237@baylibre.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.744.82
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 09:54:21AM -0300, Hiago De Franco wrote:
> DDR training runs from the XTAL, before the PLLs are configured, so add
> PLL setup after it in board_init_f().
> 
> The sequence bypasses all clocks to the XTAL, reprograms the APLL,
> DISPPLL, CAM0PLL, CAM1PLL, MIPIMPLL, MPLL and TPLL synthesizers and
> their derived dividers, waits for lock, then switches every clock from
> the XTAL bypass to its PLL source. It is ported from the Sophgo FSBL
> (plat/cv180x/platform.c), https://github.com/sophgo/fsbl.

I'm worried about code duplication since we already have a driver with
more features under clk/sophgo.

I think this setup work doesn't have to be done in the SPL stage? If so,
I'll suggest delaying the work to proper U-Boot or even the kernel, with
assigned-clock-rates/assigned-clock-parents for re-using existing clock
driver.

> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  board/sophgo/milkv_duo/spl.c | 123 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
> 
> diff --git a/board/sophgo/milkv_duo/spl.c b/board/sophgo/milkv_duo/spl.c
> index 3db50df0615..8b2dc2756ae 100644
> --- a/board/sophgo/milkv_duo/spl.c
> +++ b/board/sophgo/milkv_duo/spl.c

...

> +static void cv18xx_pll_init(void)
> +{
> +	int i;
> +
> +	/* Run everything from the XTAL while the PLLs are reprogrammed */
> +	writel(0xffffffff, clkgen_reg(CLK_BYP_0));
> +	writel(0x0000003f, clkgen_reg(CLK_BYP_1));
> +
> +	/* MIPIMPLL = 900 MHz */
> +	writel(0x05488101, clkgen_reg(MIPIMPLL_CSR));
> +
> +	writel(0x3f, clkgen_reg(PLL_G2_SSC_SYN_CTRL));
> +	for (i = 0; i < ARRAY_SIZE(cv18xx_pll_csr); i++) {
> +		writel(cv18xx_pll_syn_set[i],
> +		       clkgen_reg(APLL_SSC_SYN_SET + 0x10 * i));
> +		clrsetbits_le32(clkgen_reg(APLL_SSC_SYN_CTRL + 0x10 * i),
> +				SSC_SYN_CTRL_BYPASS, SSC_SYN_CTRL_SW_UP);
> +		writel(cv18xx_pll_csr[i], clkgen_reg(APLL0_CSR + 4 * i));
> +	}
> +
> +	/* Power up the PLLs */
> +	clrbits_le32(clkgen_reg(PLL_G2_CTRL), PLL_G2_CTRL_PD);
> +
> +	/* MPLL = TPLL = 850 MHz */
> +	writel(0x00448101, clkgen_reg(MPLL_CSR));
> +	writel(0x00448101, clkgen_reg(TPLL_CSR));
> +
> +	for (i = 0; i < ARRAY_SIZE(cv18xx_clk_divs); i++)
> +		writel(cv18xx_clk_divs[i].val,
> +		       clkgen_reg(cv18xx_clk_divs[i].off));
> +
> +	clrbits_le32(clkgen_reg(MIPIMPLL_D3_PD), MIPIMPLL_D3_PD_PD);
> +	clrbits_le32(clkgen_reg(CAM0PLL_D2_PD), CAM0PLL_D2_PD_PD);
> +
> +	/* Wait for the PLLs to lock */
> +	udelay(200);

If I read the datasheet correctly, the pll_g2_status register have bits
indicating PLL's locking status. We should probably poll for these bits
instead.

> +	/*
> +	 * C906 clocks from the *_0 dividers, then switch every clock from the
> +	 * XTAL to its PLL source.
> +	 */
> +	writel(CLK_SEL_0_C906_0 | CLK_SEL_0_C906_1, clkgen_reg(CLK_SEL_0));
> +	writel(0, clkgen_reg(CLK_BYP_0));
> +	writel(0, clkgen_reg(CLK_BYP_1));
> +}

Regards,
Yao Zi
