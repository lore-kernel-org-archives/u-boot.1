Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FE0606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a7Al1MQq;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KbVX3iP5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B049480F6E;
	Mon,  9 Nov 2026 21:25:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4nkJ0tQQL0Ms; Mon,  9 Nov 2026 21:25:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D964380F38
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794259525;
	b=aH4I3zLz7qD8ljSv7CECzHRxRo83vNQyKrqiFzqcH/1PkjIVkZguMQLEApnCFmFILCno
	 RQ5E5lPQredJNkFHs3BKIk4NzBZpAUWu7GGlBkFh7Q2N8e6+7BDMTD3/y/lSF/Kw0NUlt
	 HG1sqNvAvOhuuCygXiWeISqilQmlaBfNtHP96OR3yS099Oce2Z22uwnMfELQ9b2mPziZB
	 1yo4ucEGYrYZ8R5o1CW8ogYBm2kbu8rBzItOhxuw20EoSLlLB6lG2hRCATfs34DpOsAFC
	 gYAaRP6HmOk2NDIdqBPb7qU8IF8CUjaRoj4Plp2zk1lWjROms2XOnphOq/ruaEFeP0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794259525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vMIQsL/sOxXjR1ql+xR1umEwRQAW/yBKqXDFsEZGUAY=;
	b=pbgc3iA4yHJp0ju87hac/jDiwK76ePk6un7jAQJOB2Dmu1bJLmnczdBRGmkkz9XJxnp8
	 S0mCD7rDW9f9UiQcfWd1QAjb1LfQG4LvMN3DtIEpChxfJneDfD6iNLKpMdZAp2lAjhhTN
	 ftMk0cTjYfPDnBbxpoOm/SRLD9py6/FMI4fMkkhBeZXlJ1xjyLpNImEGfNlNgo3LKgYcu
	 o44QFxZ6StnxnIzq6qyt3R2fbHBUS3YK3BHEFzZorF3ISHfefVDy+6pt61R1YhA0+tAoo
	 mKIUIe5ZoiHjUCAecJEMZYBgt7qNl1qkKzPTTl4NKlLpCN9UF7kFZD9KvasBLE+rn2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KbVX3iP5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794259525;
	bh=vMIQsL/sOxXjR1ql+xR1umEwRQAW/yBKqXDFsEZGUAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a7Al1MQqUI0dREJ4+am8m/Qz0mD0vbu6DeWcdNV0yhSVPg52J6wLL/TfaiyLIjXAa
	 oTKIknf1gT2Z5/zHEmixNv+dI063VKkIwpREdL75gi29f2ft/s9GYsFKd41BqzG8in
	 io5U1kHV3cHGnt5dNBrGzU5WqF0Is/Vm0T5XHoE0Nc0+CEkQZVyR2McqoFxg58HHDe
	 dbgMERaGF6vnS1MqESU0t6DVTJ2RyeSqIoEYiRhD21cFhFcg5xyZbqfi6lRbqxHLh6
	 7CEVO81G39s7E/W4XVi8E5KveM4rS7TCW4stK/KsR9c/k488yVOZAdp/yNmryJ3uoh
	 jUc0QfSpofsvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D964380F38;
	Mon,  9 Nov 2026 21:25:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F4A028C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00D4280F38
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 00TyEue3-ec1 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:25:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0B3680F26
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KbVX3iP5
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0B3680F26
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:25:21 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-8451a619da7so842818a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794259520; x=1794864320;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vMIQsL/sOxXjR1ql+xR1umEwRQAW/yBKqXDFsEZGUAY=;
 b=KbVX3iP5/mLDkoUlNhKno/JzSFIEOQJV/elwPka165udgmuIAI8pknCB968OYifazV
 mEyJC3XCGcVJpXWoDOG79Pq6tVBboLVNp7BT90pMsOOk5aVOrbEZyr6bBjXDPo9jffL3
 G3HMg4JmqNbN6/AkeB5jKWz0j55uN2k2fd4Z3s+Rtx/qi8BWaBJGye/qA1DcKdh0PXse
 d5ZjTfgHTSZRnaCOyAlpf0EF6pd1v0jM2qDK/q4RBz3n1sb2udeYIpN1m2opnaS5QpqF
 panHSjhG8xKC6ooVUoLp3Fl6kxyV0obd8u9AAxicjQOwznnANRmGmA/pAoMDEG3u8Tr9
 6ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794259520; x=1794864320;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vMIQsL/sOxXjR1ql+xR1umEwRQAW/yBKqXDFsEZGUAY=;
 b=a4ycBe/gQXnZF0WoEAq/KvB1HPu5oKDKmFVc55cGoMOcMlO/JcQaGD5tIuy2MqnkBJ
 sBI7Ih1FakbvatZ0e8mg0NqHOXMsbowK5kMeW2SIFpZEtKihLxTGPpBJflyAnBkpw0IZ
 ybMZrDIa/Q2O0gK2rl0ja3NyPL4wqp1B085XDUUuEKcQgLk8PZgSwG/3Z7lyLAaK4alQ
 9p4yj7TSh8AV9sRRhHw2VQS4pTHKP8apOYlOu9xkfypad9jN6aWid9OjAA6wO74RDZbr
 u+UVl969q4TeEa34ir59UPkQ+xUE/BTMDJpvrxkb5+nDGkerBCOqmd2NNYaaddQPGgEr
 ug/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFtCIBGO7M9ZwEfFxxteVrclL3j35E31cx7T1V9Lryk6Xj6vsRY46nZdpkV7FuCu35vrb1bXn4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Vj5XyCX29T1/jbgkXaGRmpXWpRv6+LqGYOWOFNbx6h+jv+FyT
 hYMyeHjYnF2R5Py69zm5ngjBCcMRoLVKpaZv7iCipvVL+40xEB8UztMj8EMD+vHQDOqHEGWR9FE
 wXBls28w=
X-Gm-Gg: AYBFou2tKE85rMnLXCxJwY2ffpVPRhdOp62d+i72zARdeBzxw6q120HC8dvlNdqHkgr
 NnCnWjEjv48H2+5P/rqg0zqYQsDBv6v0a/CLE/JaKG7XKo/YHoD+JktYBnq0FRB627UsH2Jou26
 njjANYHsjBUBin7FEgW0tUHDhDBY54n7i7T9EwW1AX8Ftbe78thR+ouxcg3bvq2942AhJgtyCYs
 KU0gbZjb7YvgIKINUv9rJcULiBcSxFSLVxT1eri6/YR3y7m4nVzwiZGNKqXkBvHui6XxRXuxBNu
 8+TDDPIhcWRsWxpeRAfqRb89p5OY36hifWcVEttETGiVI56LkcjmNefW0SLBmINLp6zJeqa1RVk
 aItH/dD2YAN7I7YzAo99OGI05emWBrUd0wEDKWJ7OXl+AtxaBmkZlxGUWDEnoceNMAm+qv+pGtI
 quGvIlpYDB5ljlsolkADjqiYDxUu5VDJdTChMZ14dB6PygNIh7Ue7Y3NQvxLi875t0BRkPsY4NA
 pUUnADle5NAMpd9uPUbbl/2+JCkqFnZIPuMG9Cps5CuziHU9JoqWgsGuZ0ZOVp+95ZnyD7oma3L
 XGgSTex1cqWQEdLapOux59A9WT1NTjoYx33QtiZ8dCbgwsseb+T+yFFhmq5Ch4Ng9IVTs0+l+AT
 xfQ==
X-Received: by 2002:a05:6830:44a7:b0:822:ce5a:4ab with SMTP id
 46e09a7af769-860dc7b64b7mr393547a34.26.1794259520430; 
 Mon, 09 Nov 2026 13:25:20 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcb5f847sm357687a34.8.2026.11.09.13.25.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 13:25:18 -0800 (PST)
Message-ID: <95e43ff4-7f8b-42d4-9a09-c4c15cf01247@baylibre.com>
Date: Mon, 9 Nov 2026 15:25:17 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] net: mtk_eth: an8855: sync SerDes analog tuning
 with Linux driver
To: Mikhail Zhilkin <csharper2005@gmail.com>, u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com
References: <20261107142441.2104669-1-csharper2005@gmail.com>
 <20261107142441.2104669-4-csharper2005@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261107142441.2104669-4-csharper2005@gmail.com>
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

On 11/7/26 8:24 AM, Mikhail Zhilkin wrote:
> Port the TX FIR (TX Eye) and RX CDR (RX Jitter Tolerance) analog
> tuning parameters from the upstream Linux Airoha AN8855 DSA driver
> (drivers/net/dsa/airoha/an8855.c).
> 
> The default U-Boot configuration omits these register writes, leaving
> the SerDes with inferior default drive characteristics. On hardware
> iterations with minor silicon or trace variances, this marginal signal
> integrity leads to severe packet loss (50-60%) during TFTP recovery
> over the 2500Base-X link. Explicitly configuring AN8855_INTF_CTRL_10,
> AN8855_INTF_CTRL_11, and AN8855_RG_QP_CDR_LPF_BOT_LIM ensures a
> stable physical link across boards.
> 
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> ---
>  drivers/net/mtk_eth/an8855.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
> index 513f4534701..f8f004e0914 100644
> --- a/drivers/net/mtk_eth/an8855.c
> +++ b/drivers/net/mtk_eth/an8855.c
> @@ -96,6 +96,8 @@
>  #define AN8855_SS_LCPLL_TDC_PCW_1		(AN8855_QP_PMA_TOP_BASE + 0x248)
>  #define AN8855_INTF_CTRL_8			(AN8855_QP_PMA_TOP_BASE + 0x320)
>  #define AN8855_INTF_CTRL_9			(AN8855_QP_PMA_TOP_BASE + 0x324)
> +#define AN8855_INTF_CTRL_10			(AN8855_QP_PMA_TOP_BASE + 0x328)
> +#define AN8855_INTF_CTRL_11			(AN8855_QP_PMA_TOP_BASE + 0x32c)
>  #define AN8855_PLL_CTRL_0			(AN8855_QP_PMA_TOP_BASE + 0x400)
>  #define AN8855_PLL_CTRL_2			(AN8855_QP_PMA_TOP_BASE + 0x408)
>  #define AN8855_PLL_CTRL_3			(AN8855_QP_PMA_TOP_BASE + 0x40c)
> @@ -113,6 +115,7 @@
>  #define AN8855_QP_ANA_CSR_BASE			0x1022f000
>  #define AN8855_RG_QP_RX_DAC_EN			(AN8855_QP_ANA_CSR_BASE + 0x00)
>  #define AN8855_RG_QP_RXAFE_RESERVE		(AN8855_QP_ANA_CSR_BASE + 0x04)
> +#define AN8855_RG_QP_CDR_LPF_BOT_LIM		(AN8855_QP_ANA_CSR_BASE + 0x08)
>  #define AN8855_RG_QP_CDR_LPF_MJV_LIM		(AN8855_QP_ANA_CSR_BASE + 0x0c)
>  #define AN8855_RG_QP_CDR_LPF_SETVALUE		(AN8855_QP_ANA_CSR_BASE + 0x14)
>  #define AN8855_RG_QP_CDR_PR_CKREF_DIV1		(AN8855_QP_ANA_CSR_BASE + 0x18)
> @@ -678,6 +681,28 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
>  	an8855_reg_write(priv, AN8855_MSG_RX_LIK_STS_0, 0x01010107);
>  	an8855_reg_write(priv, AN8855_MSG_RX_LIK_STS_2, 0x00000EEF);
>  
> +	/* TX FIR - improve TX EYE */

Probably should mention in this comment that these are 2500BASE-X values.

> +	an8855_reg_read(priv, AN8855_INTF_CTRL_10, &val);
> +	val &= ~(0x1f << 24);
> +	val |= (0x04 << 24);
> +	val &= ~(0x1f << 16);
> +	val |= (0x00 << 16);

nit: don't really need this line - unless we are going to follow up later
with macros to give all of these names. And using GENMAK/FIELD_PREP/etc
in a followup would be nice too. Don't combine that with fixes patches
though.

> +	val |= BIT(29) | BIT(21);
> +	an8855_reg_write(priv, AN8855_INTF_CTRL_10, val);
> +
> +	an8855_reg_read(priv, AN8855_INTF_CTRL_11, &val);
> +	val &= ~(0x3f << 0);
> +	val |= BIT(6);
> +	an8855_reg_write(priv, AN8855_INTF_CTRL_11, val);
> +
> +	/* RX CDR - improve RX Jitter Tolerance */
> +	an8855_reg_read(priv, AN8855_RG_QP_CDR_LPF_BOT_LIM, &val);
> +	val &= ~(0x7 << 24);
> +	val |= (0x5 << 24);
> +	val &= ~(0x7 << 20);
> +	val |= (0x5 << 20);
> +	an8855_reg_write(priv, AN8855_RG_QP_CDR_LPF_BOT_LIM, val);
> +

I don't know if order matters here, but it looks like the proposed Linux
driver does this at the beginning of the init sequence rather than at the
end.

>  	return 0;
>  }
>  

