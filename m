Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02030C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 12:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ACDC60D5C;
	Fri, 25 Sep 2026 12:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oS4voDmzFEUE; Fri, 25 Sep 2026 12:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 936E86069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790339905;
	b=iW5YOnswCml7DWLafTO+GEsZju3xhrX49TzH31/zrg9Oxf6aEWR3nt1xePpQ6A+8fpOi
	 avi3tDLctF0WMY9+jiKxm0SEFDm+GNXayzRPpl/0CyWbfEleWGtBi9M8JhfkCD7peredG
	 +oBejTBTtDjy8PFt9VrPBd2mpcKTMjI7KdWnLeWJeNi/sXG5XnLMKGQh5qfXL9BUjb+2e
	 VdIgiu6qIjqH21LaUMUKkZYFOMn01dEA4TmG5P4jgcnjEeATq4V97MeVoSQl3LsiXPiNp
	 fv89DxdhV9CQrBjKLAcH2V7v5oPz4csLL/RRIkFTmpoP4HETvd3Xv6suMJkyCk3SPiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790339905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SnwPMwKeTISNqMOFxf23q10ujUGfd1zBl8U8JZ0kEbw=;
	b=ocTazsZUr6WLIJWl19TP/wLpF6vuUsBb8JdUIIYkw1aTARcsFbWGGG8qCwPbfV9rLYjB
	 rT5X0RMSewBcmAkz2A1zVc1iWJ/Faf3qQnQv483zK/C+PlWXuy69Da41tkhQOGpYs/UB/
	 XpoRPdMyuElRHbehmIiNPsP1NPZt/c2K2Gyvt8AAIwL1z6fsA/stugDhqUI0Rcsemq/W5
	 7SPc7wMlQR3li84B1C7s5gVhMvm3S6VYjD/5N3G5e9xLWfUD3ZdxHYuFyZ4sVt9P2zIa2
	 2RGNwP+jDrf0IvRNVUKiAedNQmyqP80DmTvC8MNvA/Kc21V790wqf+4XKamZo/LHcnw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790339905;
	bh=SnwPMwKeTISNqMOFxf23q10ujUGfd1zBl8U8JZ0kEbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fLcYzHw816XAN7rPQNiLRTJP3pelw6BX0hocsBHXCOqXzE04Wr53E5tqUVSxb7pDL
	 OZ0TJYAmLsZX7FXZQjkdImFOEycHwjnLGAtFTthF1+XoqL9GGyOqLCYdr9b1/VMCKK
	 wSB8We5OQy6ywnH8+Tbp6U9VioSbOKeMYlvn8VaEdj6M0+IYuYOm3DfYGwR2HY1cVU
	 uMzDmTZ2Z//LH2XToLBv1LE/VlZ8WBK1OtrjaajdaU28Qk/QkEigVIdaUn6KJ99jY/
	 AqKacc97AitS4wxl+SOD9t8LMA598zsCaCLDqsd40QBD8zwgsHAC29wiob9mJputFD
	 PN0/VesnLlkrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 936E86069A;
	Fri, 25 Sep 2026 12:38:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AB9532F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3F0140B2E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OME5YCTD2saj for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:38:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D413A40A3D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790339903;
 b=HEs6JTquIHnLtmJUly067MV1DvKkoPIt4ZE6po191g3XQjFiuKjHfLaRBIIzCbEYauqR
 eoiXMLcbw5eyngEXf7rR5vzAhYcJXs5NCzy0nRu8i8GRNvj3f8TzMQpzl3w6Xu51A+/0K
 MUPFDcIGHZTFAyA37YaMkf88zP72iekQXyM0ZJBIs+eYOI5A22GTZUEqkoMtK+XhJKlak
 t8XMixO58gznE10iXFUMFx3xEOMwyGqyC3CduFTHw/9ZO/Rc+lngE/+GEK7Wn2S/pyzXd
 uMO7CBprID1bGa5GKN/DcgKyD1ED3NFLgBh9e4oaLCxvIwVoboqusHPCvShEk2sfMNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790339903;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=SnwPMwKeTISNqMOFxf23q10ujUGfd1zBl8U8JZ0kEbw=;
 b=N+8qTOAQhmzBvXQFn/8zktgFcoR/e6+N1sTL3z0MFO1q12rJBAHNOw+s5vCt8p/pRd6v
 6D6PyOxI7PX2W/FlZ/eezV4YmdWdsLmdshTnV3gVIs+wKWv0oKDhx7c2x5U+cpYMkhhb4
 AMoY/Zof0I0bjtroJb98oqvEVx/aHdFPAvMmKlx0NJuPyj06e3SD7jcijGPXMxW5xs4nE
 ndd4IUH5Mr2kUJ/t6FUNKxoCKt7el1K3pB0kM6K+yjalQ4n0W7u99hEq73hwUjJhArfoQ
 pmcajHQVkIgSpbgs2rKwgNlZfAPZz3w7XzTR8E+Q7GWIMM09qIE1QEMeNPczrltRyFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PoN+MoIA; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PoN+MoIA
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D413A40A3D
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:38:22 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so5167875e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790339900; x=1790944700;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SnwPMwKeTISNqMOFxf23q10ujUGfd1zBl8U8JZ0kEbw=;
 b=PoN+MoIAre3ctU9STjbEEu/W6haYTL2XG6MmzHqPnY9EC0lMr4GRxGe5yPXxz/R6x0
 oqxs2f+Y+M1S87JhgHiQrrBx/xPA8JHQ+2LwOc1UIL6gTER6Lge6fnFYryJBNJgGB5Fy
 HX6OWWLw1qWgKxkwemQkWZkb/zCWtQYR/oGmNg8GhJlrvcit7pkU5DxSTPnlnUpH0zj/
 OGlsfCGpQKkT8Ly6wMu4PpazYLWAoJVAZqIhWWpJDxoxizMwu2Zddw3M2MEJ3XeZQ0I+
 dkUKHqqOSlDuI5DB2jct+a8Csr6szP0Rgy2Ojrab/feVgfEn2DUuyo/TG6F9xJMnmUch
 GmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790339900; x=1790944700;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SnwPMwKeTISNqMOFxf23q10ujUGfd1zBl8U8JZ0kEbw=;
 b=FYZ9RqfeCT08dK5w+VFCVwUvRE5fpcmWmKi+jzB/rVjx0XizWuYKanDtl9vYhxYmHS
 fobhbT/bSgIh8ImhfSII93YqGYkvOJEAQjCWb3lTQ/56Wk9OUGwhvpMCiRwHChxeyHWc
 5r/hnRtO1UfvOhcJ5bpbNuQLSBCcGHE1RA3MW/nitV+NKVHXFWBDmVIAcfPTBMNb77aL
 x4xCUU1rrgtB4OThVuakjNNAueRusAJS1bcd1GYBGlL2HsTdXodUT928T2PoglFLuURE
 +9+MjiQDrx3MBTZnkiiAkzdch+7YL0yxYkFRPFuwvr+UCzruajqlunbn4CPysAru4gCW
 Eh8w==
X-Forwarded-Encrypted: i=1;
 AKwUvByZsVBCZC2Ho2G4Qn009p9+DVkIfzKEssc2OURjLe6SsDmNi9zByMMZQB2tH3v5JCbNpTlcFrs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k8ju89BZxsf1A3igleLyGTbEk/CB1HONTAAfz7fG/TwJ/BJyl6
 XQ4EDLRCUcqvwfVlOMyxALx5aGNWe2BrRXCRdxY9z2JFa+XMulH4598ytFDu0vgSUSo=
X-Gm-Gg: AYBFou3w2u49G993Mg8NbF+4l8RIoDk2rXw4F0SmAF8P/i42tPKRdlF5S2p1v0r9ALg
 L4AEDDZjjZhuFFnqmTwwDJTs6vNM2a2AAp+5oNxsU1MceFRBpXLNJg7P403yC5jZZFV8JRPCRvs
 qNFaOUUbORWi1DMKFgT/85nGp6frO6vtVt93Sd7EtuQivts+mHivq6uewhhl9rPE/AyTyNu34Eb
 t9AD3/TIvUw5yma5t9nSBCWyVy04Mmu9iWBQxamAsKCYxfYPs//dIFqh3HT8+HpRS3IZ/vCtmdq
 x8yWKRjSYIrss+lI22VkdvTF3j/GDYrkgXe7UsfTTK8gYQSWAvTZ58B6U4FTEgbeeFhXV3hKvA7
 Phf9Kmz3Z6N8S1rf0m8OPVK0Tz2yRYs1Frz+igrSRsJlL8lN+XnlVLbm9LPy6VoPBggr0HHyrRt
 MmgbM9qimDk+bn7L7SWQeC5uBQa2dOzHNB+YYMLT8msnjx7NkiUvZk65CTnc9U/7fJVdKMiBGOX
 TJbqI1tAxxM8Vuudw==
X-Received: by 2002:a05:600c:a00b:b0:49c:cee2:a508 with SMTP id
 5b1f17b1804b1-49fe66eaff3mr87177715e9.16.1790339900062; 
 Fri, 25 Sep 2026 05:38:20 -0700 (PDT)
Received: from [172.20.10.2] ([47.65.176.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fee915f3dsm58449805e9.1.2026.09.25.05.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 05:38:18 -0700 (PDT)
Message-ID: <ad33fdf2-6db3-4368-920f-751a7489ae92@linaro.org>
Date: Fri, 25 Sep 2026 14:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] clk: qcom: qcs8300: add QUPv3 clocks
To: Tyler Baker <tyler.baker@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
 <20260924-monaco-ventuno-q-v1-2-290b6a4d10c0@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260924-monaco-ventuno-q-v1-2-290b6a4d10c0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tyler/Claude,

On 9/25/26 01:38, Tyler Baker wrote:
> The QCS8300 clock driver has no QUPv3 clocks, so every QUP serial
> engine in the device tree asks for a clock the driver does not know:
> 
>    gcc@0x100000: unknown clock ID 109!
>    gcc@0x100000: unknown clock ID 117!
>    gcc@0x100000: unknown clock ID 121!

useless context

> 
> Add the QUPv3 wrapper 0, 1 and 3 serial engine, core and AHB clocks.
> They are branch vote clocks: each is enabled through its bit in the
> APCS clock branch vote registers and polled on its branch status
> register, as the Linux QCS8300 GCC driver describes them. Rates are
> left as the boot firmware set them, as for SA8775P.

more useless context which doesn't belong here, this is not what a good 
commit message looks like.

I'll let you respin this series before i take a look at the other 
patches, using LLM slop commit messages like this is frankly just 
disrespectful, nevermind confusing and polluting to the quality of the 
codebase. NAK

> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/clock-qcs8300.c | 60 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
> index ac5b28ae34..361b74d709 100644
> --- a/drivers/clk/qcom/clock-qcs8300.c
> +++ b/drivers/clk/qcom/clock-qcs8300.c
> @@ -70,6 +70,66 @@ static const struct gate_clk qcs8300_clks[] = {
>   	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0)),
>   	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0)),
>   	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0)),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x4b008, BIT(9),
> +			0x23018),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x4b008, BIT(8),
> +			0x2300c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, BIT(10),
> +			0x2314c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x4b008, BIT(11),
> +			0x23280),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x4b008, BIT(12),
> +			0x233b4),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x4b008, BIT(13),
> +			0x234e8),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x4b008, BIT(14),
> +			0x2361c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x4b008, BIT(15),
> +			0x23750),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x4b008, BIT(16),
> +			0x23884),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x4b008, BIT(17),
> +			0x239b8),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x4b008, BIT(18),
> +			0x24018),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_CLK, 0x4b008, BIT(19),
> +			0x2400c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S0_CLK, 0x4b008, BIT(22),
> +			0x2414c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S1_CLK, 0x4b008, BIT(23),
> +			0x24280),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S2_CLK, 0x4b008, BIT(24),
> +			0x243b4),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S3_CLK, 0x4b008, BIT(25),
> +			0x244e8),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S4_CLK, 0x4b008, BIT(26),
> +			0x2461c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S5_CLK, 0x4b008, BIT(27),
> +			0x24750),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S6_CLK, 0x4b018, BIT(27),
> +			0x24884),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S7_CLK, 0x4b018, BIT(28),
> +			0x249b8),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_2X_CLK, 0x4b000, BIT(24),
> +			0xc4018),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_CLK, 0x4b000, BIT(23),
> +			0xc400c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, BIT(26),
> +			0xc4284),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, BIT(25),
> +			0xc4150),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x4b008, BIT(6),
> +			0x23004),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x4b008, BIT(7),
> +			0x23008),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x4b008, BIT(20),
> +			0x24004),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x4b008, BIT(21),
> +			0x24008),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, BIT(27),
> +			0xc4004),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, BIT(20),
> +			0xc4008),
>   };
>   
>   static int qcs8300_enable(struct clk *clk)
> 

