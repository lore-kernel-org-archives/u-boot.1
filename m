Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677C3C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE3883212;
	Fri, 18 Apr 2025 16:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744988014;
	bh=+WcTrdOzaqB+gYqNd1XOAE6HkUOW2GLuUJw+as9OIuU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vl3qM+LaZfwZp/CVFojTdBOgVGU4M5gWaiylusDeRmd0wDTpQDLugbU5T4vtuzfFo
	 qc5+i16UF2UiPbVwga0uk96XRVUeT/DdGHDWaklkjhXZ30dBqsaOkHpmDHHkHs4PbP
	 aLdgLlgAivm+PxnV9hrUW07Nsu+WtVws49w8S7Bg2iHJHt2g4MGZGa2sdg7PDNmpN/
	 2izGfdp+0UhfcdoCKd7TPe5cXGNm1sjpxLLaslCFJ23AFsNdd/jxydcsLZv+FUk5YP
	 sPXA5nnX/dJ0K32Fgnulo9AxwvQYnKDY8ZQMmQ62FQGauT4qgg5C4lCS4zCvwoYM/Y
	 ebTVghSZfR4kA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC528004F; Fri, 18 Apr 2025 16:53:32 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2577182140
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="K5zuvrv4"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 41F571007A572; 
 Fri, 18 Apr 2025 16:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744988009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+WcTrdOzaqB+gYqNd1XOAE6HkUOW2GLuUJw+as9OIuU=;
 b=K5zuvrv4iuQwAD7khvILYSsYOV/JfK1B060++B0r29Mp9rp/bNy8tz9iynLtUCacHzoJTH
 6SKbARhzbdPVIXsyPOyGH1yInW3nFF+RcR+ipbjqd/VozEYLOOLeBghP2e1UsNnNRanvG7
 +5/b+CmmWfe4Leamgy5C9kg3i9QLJlUcGe+htqLMgEOzt1CPwJnoT4Km1FIHTkZxFcVHWY
 dyJyKQx+xTMcmIPKAlcz8v17EEdXnqjvnhwmqKL3Xxrw9IhGSGVYcrWsFBGQR2Hzc7aaFk
 U6+gjnZsXW8Z6MAYC3w9goAZR8Qc5QjPH/hKqVi/aP8GTznqe7iYAcENIAgU4Q==
Message-ID: <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
Date: Fri, 18 Apr 2025 16:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Fabio Estevam <festevam@gmail.com>, trini@konsulko.com
Cc: lukma@denx.de, seanga2@gmail.com, francesco.dolcini@toradex.com,
 aford173@gmail.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20250417171101.2566447-1-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20250417171101.2566447-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/17/25 7:11 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, fixed-rate clocks in U-Boot are named based on their devicetree
> node names. For example, given the following node:
> 
> osc_24m: clock-osc-24m {
> 	compatible = "fixed-clock";
> 	#clock-cells = <0>;
> 	clock-frequency = <24000000>;
> 	clock-output-names = "osc_24m";
> };
> 
> U-Boot registers the clock as "clock-osc-24m", derived from the node name,
> ignoring the clock-output-names property.
> 
> This differs from Linux, which uses the clock-output-names property when
> assigning clock names. As a result, clock consumers expecting names
> like "osc_24m" (as defined in the property) may fail to resolve clocks
> correctly in U-Boot.
> 
> Update the fixed-rate clock driver to check for the clock-output-names
> property and use it as the clock name if present. If not, the fallback
> remains the node name. This makes U-Boot behavior consistent with Linux.

This part above ^ is fine.

This part below v is wrong .

> One concrete impact is on i.MX8MP, where USB clock lookup failed following
> commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*").
> 
> With this change applied, fixed-clocks are correctly registered with their
> expected names:
> 
> u-boot=> clk dump
>   Rate               Usecnt      Name
> ------------------------------------------
>   32768                0        |-- osc_32k
>   24000000             5        |-- osc_24m
> 
> This change restores i.MX8MP USB functionality by ensuring the proper clock
> names are used.

This is wrong, because this is NOT how the clock look up works at all.

The lookup works this way. Take for example:

drivers/clk/imx/clk-imx8mp.c

240         clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux(dev, 
"arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, 
ARRAY_SIZE(pll_ref_sels)));

pll_ref_sels:

  21 static const char * const pll_ref_sels[] = { "osc_24m", "dummy", 
"dummy", "dummy", };

the "osc_24m" is looked up in the clock-controller@30380000 clock-names 
property:

dts/upstream/src/arm64/freescale/imx8mp.dtsi

  745 clk: clock-controller@30380000 {
...
  751         clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
  752                  <&clk_ext3>, <&clk_ext4>;
  753         clock-names = "osc_32k", "osc_24m", ...
                                        ^^^^^^^

The offset of osc_24m in that clock-names property is 1 , so the phandle 
in clocks property array at offset 1 is used to look up those clock:

  745 clk: clock-controller@30380000 {
...
  751         clocks = <&osc_32k>, <&osc_24m>,
                                    ^^^^^^^^

Which leads to this clock node in DT:

  188         osc_24m: clock-osc-24m {
              ^^^^^^^^
  189                 compatible = "fixed-clock";
  190                 #clock-cells = <0>;

The "clock-output-names" is NEVER used for any clock look up.

...

I am fine with the first half of the description, but the second half is 
wrong and this actually does not fix anything. Simply remove 
clock-output-names from the osc_24m and the code will be broken again.

The clk_resolve_parent_clk() is meant to perform the aforementioned 
resolution(), that is what "[PATCH v2 00/24] clk: Add 
clk_resolve_parent_clk() and fix up iMX clock drivers" actually fixed. 
It seems there is something still missing and clk_resolve_parent_clk() 
does not do the resolution properly for some clock, but that is what 
needs to be understood and fixed, not worked around this way.
