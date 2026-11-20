Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE7B606A335
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H7y1b+CS;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PIQPeejc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C7A46078C;
	Fri, 20 Nov 2026 19:43:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-adb8RTl7M8; Fri, 20 Nov 2026 19:43:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAC176070E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795203819;
	b=gY3Y8PPVXRtfG9ev2xd0cOLstAd0HY5eiseg7Ouc3p69QpyxlrwUmOnp566b+iF9dRRa
	 EBKUzOpgBbsOI/LZwGvTAS768x1gDsYYhaKfrZOzNHpAJjI9pOrRJLMck5SU+45GI7QNT
	 Jyat/GgYwofpkeaBN00ogRVAwQ7X2A3NscH9oO6zimfnWvYqtPI+q5V3fO/d4u5srjPCO
	 ax86c/hNsbCIiy9EIX+LV4UCAjPwpUdDxFwGjxrLYDa3O3cIKZH1E71y/hb4fMGaSGI6i
	 YaLw044lNnw72cRwlN+IDJfIhjD0MezfDTBtmbKVFYhOYmRc67wBfRt1KZMiavNkPfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795203819;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=RQMM1P3GXWHXN5pRQhPXLMDL5xplR8OEp5k913xwtRY=;
	b=fuxjqvUSYETUZnTjeNuLZEPbsluO0JxlfS/dhbhbIpNgo+VZOVJfrrNwCj1XFAf2PAHc
	 Duq5tU5uEe3QHi4Dc2AHUymBPVq2CqTAG2XfJYw/lMMrYgurWMTxGmna5rj82xp2in+vI
	 LvlNcHaC4hwgEHD/TkHKzXL2i3/c3wbpW9SbOJGThAVjhvlrXCdFggfR2ISl6QNLZAPC4
	 j30CeQzwDPyujolPof0Kxq771/Fpiu96rN5QAoyBfqazyShofEMH1ogj4ve74UMXni8wJ
	 lPy6Uk4xjerfskWvY0OSv6jo/xoreZaZV1VacdxgCMM/DJHnDeET4bhx3NRMY7o96HQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795203819;
	bh=RQMM1P3GXWHXN5pRQhPXLMDL5xplR8OEp5k913xwtRY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=H7y1b+CSBlbvfkmdygS3EkBke89dsCBKp67u7+pe/wwRVHP9IsHARYD3qt8/uxhTG
	 n9N8N818pKxjFVOirHEkFFxjoYd5rTtihcBB/oxXA97UwEvYejwOcAu48cVSQrX2gW
	 a9fwE3hFVPaSmtGRaPMowWEcLDYJGWn78dCPqsoeuiYPtdPXcLvLg+IhootFp4XbeV
	 bAm4cuiO/T1PHWP512vdT5VK+GT1CFh0ZcU/N7o+QLDw4o+E3co3RVesUrPc1yONoz
	 t9WOMPdcE0KBdBIiSgklfjFcDUd+Z/sx6j9yUTSchGtk/ZfGDYiNUtoh7cMvO2DR1a
	 DNmXUU+dGy7qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAC176070E;
	Fri, 20 Nov 2026 19:43:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BE49F759
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A47F640208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNd-gGwAYQ8y for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 19:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C4338400BE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PIQPeejc
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4338400BE
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:43:35 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso10863575e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795203814; x=1795808614;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RQMM1P3GXWHXN5pRQhPXLMDL5xplR8OEp5k913xwtRY=;
 b=PIQPeejcWIU37SJoHRVchGZysg77LqFI9mAg4+aymec1ptPZADprEvDyBMiyuglIdv
 9663f60RwzX1MgNQlJrYLg20bn6gFVbj9zvTZEMFITq+5xYhU4zpFmeX4g7d4V7fTENl
 kgnoNRMdG5ohUW7ADZOLqWMNsSm5V+PaLy0eWXztUNOhQ8XbKteJQfwsVeWTJ9qzdEW7
 PmfubLYV0luErTfFQntAqOg74cop6p5sroWMZFypK3J094bMq/KMY3ZGQCUG1LfwkUXh
 j5wHX/4fHB9BNWs5/raDNVwXuHkR6kl25bgynjmqc0Rg+YGktKlg254INXmBx5kuuMnq
 DoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795203814; x=1795808614;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RQMM1P3GXWHXN5pRQhPXLMDL5xplR8OEp5k913xwtRY=;
 b=VUdDvsWcjaOyN1nJgzh5OgeWBxV7ToFmPI4j8IUHPzMEbv1+BtZ43x/3KF/9gO0CU8
 opNiBDziO9RsrZGPopDIkVXQDxDlkPcUxYSpJhhFc3YDtaTHhnxmfPEi5s6YIoCrN/8u
 LTEWQC5tcDS9Hel+B9G2aKjhzxFeGvAcxfzo7U84MjvvPIKOxkcc7MxkklYoXHFbUalo
 yZiG+jPXIwuTmxTWLJs+OACu4lZBAmh5omAPDGCWHEI8L0euulPENXwgJxmxX56kgpQU
 iX74tLZGWiAnmnPlqiooR3zkBVsW9jJXMOYbqKpy0WtYUjTawdtuNQL8Vy9nB1XTgQ7P
 6TPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEPbEMQlvF2Jy0tR0Xl23ced/fhm7KwNfhT0N9gmOU8/i4oHTqEguYBKpqpfU30SbYy3HeTRWs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+3wPMF19NU1wVFJKNKCUwtkTXrM6ofwYuAbgIIbinDPqeljqws
 brSE30cJCUhYUM1if0ZoUq0i/QA0QV+PSs3vUXsGWq1lYi/HjQfV9wvZsBKtBoEGQj4=
X-Gm-Gg: AYBFou2FP+lWL1ck+Ypcy53RyB0CXPWtXJzeNAlNDvw9snlNbY/KLq55VuGrgswrDeA
 OnLSWNPyUKrOT+nYELylst54Rv5IhgVy8GdxXTx4/M5pOYw2q7wu8ID4Di/b4ug0M1UXh4tc+OO
 x2Uf6LIxwRuL4orbrgR20OrTn5qddH13fvq5EQxzYdwtsKpqoGDytqTe2lYpugcuC9rkndK++sX
 TBZBzp0Q4pexn1wmrGTvQ548i0fHu05GRwdidIaSIDnXOTywaGBIwnp+rbcf5DiEGGh07+8Z1/Z
 zpaUKoxlr8pbd7LZCBsdxNsRQtvaLtuYLXt/vf2r2xsdRjlfTtsJX+JXjyazxtYqOI6Jh1YHsHP
 JSH2RAiaN+IPoKP+rtyjZtLi0ijMISDlRla9hXs14GwlUss0ANADP29wmpA7d6NSwLxgGjF+Ymd
 23Ls3VglTtK5QxOo2UUtyoD6Fp6B1H/XJqcbjEQrb9c61VS1p0RL3yRzebu+aTr5cvEOVHBJFUi
 WtyLQYkruqCnEEhwUyAwhmPjWc6cl0wcDy/FpxpC9L8tDSFHqEB/ekFjsFP+AC0Q+lQE9nm+Y3N
 V+VJpCy9caldjrSUuyyQpw/WkeevwHSnW3VYeR4vp7NTZLhTHopuIRgpOuXVD9hepvtwtjVksVy
 Gp4m56e/79WE=
X-Received: by 2002:a05:600c:4514:b0:4bb:6823:3d3c with SMTP id
 5b1f17b1804b1-4bb888169d0mr100350685e9.20.1795203813827; 
 Fri, 20 Nov 2026 11:43:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:3374:165a:45ca:24fb?
 ([2a01:e0a:106d:1080:3374:165a:45ca:24fb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b9abf15sm6926389f8f.43.2026.11.20.11.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 11:43:33 -0800 (PST)
Message-ID: <6908d3b9-8419-47e3-b80b-5ea9c2f60c4d@linaro.org>
Date: Fri, 20 Nov 2026 20:43:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 23/26] pci: sunxi: Add Allwinner A733 DesignWare PCIe host
 controller driver
To: Alastair D'Silva <alastair@d-silva.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski
 <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Yixun Lan <dlan@kernel.org>,
 Yixun Lan <dlan@gentoo.org>, Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261113023236.569054-1-alastair@d-silva.org>
 <20261113023236.569054-24-alastair@d-silva.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261113023236.569054-24-alastair@d-silva.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 03:32, Alastair D'Silva wrote:
> Add a DesignWare PCIe Root Complex driver (CONFIG_PCIE_DW_SUNXI) for
> the Allwinner A733 (sun60i) SoC, reusing pcie_dw_common for config
> space and outbound iATU programming while handling Allwinner LTSSM
> bringup, Combo PHY integration, PERST# sequencing, and 32-bit inbound
> DMA ATU setup.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   drivers/clk/sunxi/clk_a733.c |   4 +
>   drivers/pci/Kconfig          |  11 ++
>   drivers/pci/Makefile         |   1 +
>   drivers/pci/pcie_dw_sunxi.c  | 355 +++++++++++++++++++++++++++++++++++
>   4 files changed, 371 insertions(+)
>   create mode 100644 drivers/pci/pcie_dw_sunxi.c
> 
> diff --git a/drivers/clk/sunxi/clk_a733.c b/drivers/clk/sunxi/clk_a733.c
> index 4b0aaa7ab2b..ffc3509bd5c 100644
> --- a/drivers/clk/sunxi/clk_a733.c
> +++ b/drivers/clk/sunxi/clk_a733.c
> @@ -72,6 +72,8 @@ static const struct ccu_clk_gate a733_gates[] = {
>   	[CLK_BUS_OHCI1]		= GATE(0x130c, BIT(0)),
>   	[CLK_BUS_EHCI1]		= GATE(0x130c, BIT(4)),
>   
> +	[CLK_PCIE_AUX]		= GATE(0x1380, BIT(31)),
> +	[CLK_PCIE_AXI_SLV]	= GATE(0x1384, BIT(31)),
>   	[CLK_SERDES_PHY]	= GATE(0x13c0, BIT(31)),
>   	[CLK_AHB_SERDES]	= GATE(0x13c4, BIT(0)),
>   
> @@ -124,6 +126,8 @@ static const struct ccu_reset a733_resets[] = {
>   	[RST_BUS_OHCI1]		= RESET(0x130c, BIT(16)),
>   	[RST_BUS_EHCI1]		= RESET(0x130c, BIT(20)),
>   
> +	[RST_BUS_PCIE]		= RESET(0x138c, BIT(16)),
> +	[RST_BUS_PCIE_PWRUP]	= RESET(0x138c, BIT(17)),
>   	[RST_BUS_SERDES]	= RESET(0x13c4, BIT(16)),
>   
>   	[RST_BUS_GMAC0]		= RESET(0x141c, BIT(16)),
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 86fafc5a3c7..ce5843c6b8e 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -411,6 +411,17 @@ config PCIE_ROCKCHIP
>   	  Say Y here if you want to enable PCIe controller support on
>   	  Rockchip SoCs.
>   
> +config PCIE_DW_SUNXI
> +	bool "Allwinner A733 DesignWare PCIe controller"
> +	depends on ARCH_SUNXI
> +	select PCIE_DW_COMMON
> +	select DM_GPIO
> +	select PHY
> +	help
> +	  Enable support for the Synopsys DesignWare PCIe Root Complex
> +	  controller found on Allwinner sun60i (A733) SoCs, including
> +	  Gen3 link training and outbound/inbound iATU configuration.
> +
>   config PCIE_DW_ROCKCHIP
>   	bool "Rockchip DesignWare based PCIe controller"
>   	depends on ARCH_ROCKCHIP
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index f839ea1d396..0657aec3ecd 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_PCI_XILINX) += pcie_xilinx.o
>   obj-$(CONFIG_PCI_PHYTIUM) += pcie_phytium.o
>   obj-$(CONFIG_PCIE_DW_COMMON) += pcie_dw_common.o
>   obj-$(CONFIG_PCI_KEYSTONE) += pcie_dw_ti.o
> +obj-$(CONFIG_PCIE_DW_SUNXI) += pcie_dw_sunxi.o
>   obj-$(CONFIG_PCIE_MEDIATEK) += pcie_mediatek.o
>   obj-$(CONFIG_PCIE_MEDIATEK_GEN3) += pcie_mediatek_gen3.o
>   obj-$(CONFIG_PCIE_ROCKCHIP) += pcie_rockchip.o
> diff --git a/drivers/pci/pcie_dw_sunxi.c b/drivers/pci/pcie_dw_sunxi.c
> new file mode 100644
> index 00000000000..c4f27cda15f
> --- /dev/null
> +++ b/drivers/pci/pcie_dw_sunxi.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Allwinner A733 DesignWare based PCIe host controller driver
> + *
> + * Copyright (c) 2026 Armbian Project
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <generic-phy.h>
> +#include <pci.h>
> +#include <power/regulator.h>
> +#include <reset.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <asm-generic/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#include "pcie_dw_common.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +struct sunxi_pcie {
> +	/* Must be first member of the struct */
> +	struct pcie_dw dw;
> +	void __iomem *app_base;
> +	struct udevice *vpcie3v3;
> +	struct phy phy;
> +	struct clk_bulk clks;
> +	struct reset_ctl_bulk rsts;
> +	struct gpio_desc rst_gpio;
> +	u32 gen;
> +	u32 num_lanes;
> +};
> +
> +/* Allwinner PCIe application register offsets */
> +#define PCIE_APP_CLK_CTRL		0x0800
> +#define PCIE_APP_CLK_CTRL_DEFAULT	0x00a023f0
> +#define PCIE_LTSSM_CTRL			0x0c00
> +#define PCIE_DEVICE_TYPE_RC		BIT(6)
> +#define PCIE_LINK_TRAINING		BIT(0)
> +#define PCIE_LINK_STAT			0x0e0c
> +#define SMLH_LINK_UP			BIT(0)
> +#define RDLH_LINK_UP			BIT(1)
> +
> +/* Synopsys DWC port logic / coherent control offsets */
> +#define PCIE_PORT_DEBUG0		0x0728
> +#define PCIE_PORT_DEBUG0_LTSSM_MASK	GENMASK(5, 0)
> +#define PCIE_PORT_DEBUG0_LTSSM_L0	0x11
> +#define PCIE_AXI_MISC_CTRL		0x0718
> +#define PCIE_AXI_CTO_RESP_EN		BIT(19)
> +#define PCIE_COHERENCY_CTRL1		0x08e0
> +#define PCIE_COHERENCY_CTRL2		0x08e8
> +
> +/* Unrolled Inbound iATU offset within atu_base */
> +#define PCIE_ATU_INB_UNR_OFFSET		0x100
> +
> +static int sunxi_pcie_prog_inbound_atu(struct sunxi_pcie *priv, int index,
> +				       int type, u64 cpu_addr, u64 pci_addr,
> +				       u64 size)
> +{
> +	void __iomem *inb = priv->dw.atu_base + PCIE_ATU_INB_UNR_OFFSET +
> +			    PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> +	u32 val;
> +	int ret;
> +
> +	dw_pcie_dbi_write_enable(&priv->dw, true);
> +
> +	writel(lower_32_bits(pci_addr), inb + PCIE_ATU_UNR_LOWER_BASE);
> +	writel(upper_32_bits(pci_addr), inb + PCIE_ATU_UNR_UPPER_BASE);
> +	writel(lower_32_bits(pci_addr + size - 1), inb + PCIE_ATU_UNR_LIMIT);
> +	writel(upper_32_bits(pci_addr + size - 1), inb + PCIE_ATU_UNR_UPPER_LIMIT);
> +	writel(lower_32_bits(cpu_addr), inb + PCIE_ATU_UNR_LOWER_TARGET);
> +	writel(upper_32_bits(cpu_addr), inb + PCIE_ATU_UNR_UPPER_TARGET);
> +	writel(type, inb + PCIE_ATU_UNR_REGION_CTRL1);
> +	writel(PCIE_ATU_ENABLE, inb + PCIE_ATU_UNR_REGION_CTRL2);
> +
> +	ret = readl_poll_timeout(inb + PCIE_ATU_UNR_REGION_CTRL2, val,
> +				 val & PCIE_ATU_ENABLE,
> +				 LINK_WAIT_MAX_IATU_RETRIES * LINK_WAIT_IATU);
> +	dw_pcie_dbi_write_enable(&priv->dw, false);
> +	if (ret) {
> +		dev_err(priv->dw.dev, "inbound iATU is not being enabled\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

Can you rebase on top of https://lore.kernel.org/all/20261104163408.1250410-2-sumit.dhami@oss.qualcomm.com/ which adds the inbount atu ?

> +
> +static int sunxi_pcie_link_up(struct udevice *dev, struct sunxi_pcie *priv)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/* Set LTSSM Enable with RC Mode */
> +	writel(PCIE_DEVICE_TYPE_RC | PCIE_LINK_TRAINING,
> +	       priv->app_base + PCIE_LTSSM_CTRL);
> +
> +	/* Wait for SMLH link up and L0 active */
> +	ret = readl_poll_timeout(priv->app_base + PCIE_LINK_STAT, val,
> +				 ((val & SMLH_LINK_UP) &&
> +				  ((val & RDLH_LINK_UP) ||
> +				   ((readl(priv->dw.dbi_base + PCIE_PORT_DEBUG0) &
> +				     PCIE_PORT_DEBUG0_LTSSM_MASK) ==
> +				    PCIE_PORT_DEBUG0_LTSSM_L0))),
> +				 300000);
> +	if (ret) {
> +		dev_err(dev, "Link training timeout (LINK_STAT=0x%08x, DBG0=0x%08x)\n",
> +			readl(priv->app_base + PCIE_LINK_STAT),
> +			readl(priv->dw.dbi_base + PCIE_PORT_DEBUG0));
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sunxi_pcie_of_to_plat(struct udevice *dev)
> +{
> +	struct sunxi_pcie *priv = dev_get_priv(dev);
> +
> +	priv->dw.dbi_base = dev_read_addr_name_ptr(dev, "dbi");
> +	if (!priv->dw.dbi_base)
> +		return -EINVAL;
> +
> +	priv->app_base = dev_read_addr_name_ptr(dev, "app");
> +	if (!priv->app_base)
> +		return -EINVAL;
> +
> +	priv->dw.cfg_base =
> +		dev_read_addr_size_name_ptr(dev, "config", &priv->dw.cfg_size);
> +	if (!priv->dw.cfg_base)
> +		return -EINVAL;
> +
> +	priv->gen = dev_read_u32_default(dev, "max-link-speed",
> +					 LINK_SPEED_GEN_3);
> +	priv->num_lanes = dev_read_u32_default(dev, "num-lanes", 1);
> +
> +	return 0;
> +}
> +
> +static int sunxi_pcie_probe(struct udevice *dev)
> +{
> +	struct sunxi_pcie *priv = dev_get_priv(dev);
> +	u64 dma_size;
> +	u32 val;
> +	int ret;
> +
> +	priv->dw.first_busno = dev_seq(dev);
> +	priv->dw.dev = dev;
> +
> +	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->rst_gpio,
> +				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +	if (ret && ret != -ENOENT)
> +		return ret;
> +
> +	ret = device_get_supply_regulator(dev, "vpcie3v3-supply",
> +					  &priv->vpcie3v3);
> +	if (ret && ret != -ENOENT && ret != -ENOSYS)
> +		goto err_gpio;
> +
> +	ret = clk_get_bulk(dev, &priv->clks);
> +	if (ret)
> +		goto err_gpio;
> +
> +	ret = reset_get_bulk(dev, &priv->rsts);
> +	if (ret)
> +		goto err_clk_rel;
> +
> +	ret = generic_phy_get_by_index(dev, 0, &priv->phy);
> +	if (ret)
> +		goto err_rst_rel;
> +
> +	if (priv->vpcie3v3) {
> +		ret = regulator_set_enable_if_allowed(priv->vpcie3v3, true);
> +		if (ret && ret != -ENOSYS) {
> +			dev_err(dev, "Failed to enable vpcie3v3: %d\n", ret);
> +			goto err_rst_rel;
> +		}
> +		mdelay(50);
> +	}
> +
> +	/* Assert PERST# during PHY and controller initialization */
> +	if (dm_gpio_is_valid(&priv->rst_gpio))
> +		dm_gpio_set_value(&priv->rst_gpio, 1);
> +
> +	ret = clk_enable_bulk(&priv->clks);
> +	if (ret)
> +		goto err_reg;
> +
> +	ret = reset_deassert_bulk(&priv->rsts);
> +	if (ret)
> +		goto err_clk;
> +
> +	ret = generic_phy_init(&priv->phy);
> +	if (ret)
> +		goto err_rst;
> +
> +	ret = generic_phy_power_on(&priv->phy);
> +	if (ret)
> +		goto err_phy_exit;
> +
> +	/* Enable core, AXI, DBI, and AUX clock gates with PM defaults */
> +	writel(PCIE_APP_CLK_CTRL_DEFAULT, priv->app_base + PCIE_APP_CLK_CTRL);
> +
> +	/* Hold PERST# asserted for 20 ms, then deassert and wait 100 ms */
> +	if (dm_gpio_is_valid(&priv->rst_gpio)) {
> +		mdelay(20);
> +		dm_gpio_set_value(&priv->rst_gpio, 0);
> +		mdelay(100);
> +	}
> +
> +	/* Setup DWC controller host registers */
> +	pcie_dw_setup_host(&priv->dw);
> +
> +	/* Clear PORT_LOGIC_SPEED_CHANGE set by pcie_dw_setup_host before link up */
> +	clrbits_le32(priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL,
> +		     PORT_LOGIC_SPEED_CHANGE);
> +
> +	/*
> +	 * Clear RC BAR0/1 so U-Boot's PCI BAR scan does not allocate outbound
> +	 * memory space for unused root complex BARs, program max link
> +	 * capability/target speed and lane count, and enable CTO/coherency
> +	 * defaults for Allwinner A733.
> +	 */
> +	dw_pcie_dbi_write_enable(&priv->dw, true);
> +	writel(0x00000000, priv->dw.dbi_base + PCI_BASE_ADDRESS_0);
> +	writel(0x00000000, priv->dw.dbi_base + PCI_BASE_ADDRESS_1);
> +	clrsetbits_le32(priv->dw.dbi_base + PCIE_LINK_CAPABILITY,
> +			TARGET_LINK_SPEED_MASK, priv->gen);
> +	clrsetbits_le32(priv->dw.dbi_base + PCIE_LINK_CTL_2,
> +			TARGET_LINK_SPEED_MASK, priv->gen);
> +	dw_pcie_link_set_max_link_width(&priv->dw, priv->num_lanes);
> +	setbits_le32(priv->dw.dbi_base + PCIE_AXI_MISC_CTRL,
> +		     PCIE_AXI_CTO_RESP_EN);
> +	writel(0x00000000, priv->dw.dbi_base + PCIE_COHERENCY_CTRL1);
> +	writel(0x00000000, priv->dw.dbi_base + PCIE_COHERENCY_CTRL2);
> +	dw_pcie_dbi_write_enable(&priv->dw, false);
> +
> +	/* Start LTSSM link training and wait for SMLH & RDLH link up */
> +	ret = sunxi_pcie_link_up(dev, priv);
> +	if (ret)
> +		goto err_phy_power;
> +
> +	/* Trigger speed change after Gen1 link is established */
> +	if (priv->gen > LINK_SPEED_GEN_1) {
> +		dw_pcie_dbi_write_enable(&priv->dw, true);
> +		setbits_le32(priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL,
> +			     PORT_LOGIC_SPEED_CHANGE);
> +		ret = readl_poll_timeout(priv->dw.dbi_base +
> +					 PCIE_LINK_WIDTH_SPEED_CONTROL,
> +					 val, !(val & PORT_LOGIC_SPEED_CHANGE),
> +					 200000);
> +		if (ret)
> +			dev_warn(dev, "Gen%d speed change timeout\n",
> +				 priv->gen);
> +		dw_pcie_dbi_write_enable(&priv->dw, false);
> +	}
> +
> +	/*
> +	 * Program 32-bit inbound DMA ATU window matching the DT dma-ranges
> +	 * property (0x40000000..0xffffffff) for system DRAM.
> +	 */
> +	if (gd->ram_base < 0x100000000ULL) {
> +		dma_size = min_t(u64, gd->ram_size,
> +				 0x100000000ULL - gd->ram_base);
> +		if (dma_size) {
> +			ret = sunxi_pcie_prog_inbound_atu(priv,
> +							  PCIE_ATU_REGION_INDEX0,
> +							  PCIE_ATU_TYPE_MEM,
> +							  gd->ram_base,
> +							  gd->ram_base,
> +							  dma_size);
> +			if (ret)
> +				goto err_phy_power;
> +		}
> +	}
> +
> +	/* Program outbound MEM ATU */
> +	ret = pcie_dw_prog_outbound_atu_unroll(&priv->dw,
> +					       PCIE_ATU_REGION_INDEX0,
> +					       PCIE_ATU_TYPE_MEM,
> +					       priv->dw.mem.phys_start,
> +					       priv->dw.mem.bus_start,
> +					       priv->dw.mem.size);
> +	if (ret)
> +		goto err_phy_power;
> +
> +	dev_info(dev, "Link up (Gen%d-x%d, Bus%d)\n",
> +		 pcie_dw_get_link_speed(&priv->dw),
> +		 pcie_dw_get_link_width(&priv->dw),
> +		 priv->dw.first_busno);
> +
> +	return 0;
> +
> +err_phy_power:
> +	generic_phy_power_off(&priv->phy);
> +err_phy_exit:
> +	generic_phy_exit(&priv->phy);
> +err_rst:
> +	reset_assert_bulk(&priv->rsts);
> +err_clk:
> +	clk_disable_bulk(&priv->clks);
> +err_reg:
> +	if (priv->vpcie3v3)
> +		regulator_set_enable_if_allowed(priv->vpcie3v3, false);
> +err_rst_rel:
> +	reset_release_bulk(&priv->rsts);
> +err_clk_rel:
> +	clk_release_bulk(&priv->clks);
> +err_gpio:
> +	if (dm_gpio_is_valid(&priv->rst_gpio))
> +		dm_gpio_free(dev, &priv->rst_gpio);
> +	return ret;
> +}
> +
> +static int sunxi_pcie_remove(struct udevice *dev)
> +{
> +	struct sunxi_pcie *priv = dev_get_priv(dev);
> +
> +	generic_phy_power_off(&priv->phy);
> +	generic_phy_exit(&priv->phy);
> +	reset_assert_bulk(&priv->rsts);
> +	clk_disable_bulk(&priv->clks);
> +	if (priv->vpcie3v3)
> +		regulator_set_enable_if_allowed(priv->vpcie3v3, false);
> +	if (dm_gpio_is_valid(&priv->rst_gpio))
> +		dm_gpio_free(dev, &priv->rst_gpio);
> +	reset_release_bulk(&priv->rsts);
> +	clk_release_bulk(&priv->clks);
> +
> +	return 0;
> +}
> +
> +static const struct dm_pci_ops sunxi_pcie_ops = {
> +	.read_config	= pcie_dw_read_config,
> +	.write_config	= pcie_dw_write_config,
> +};
> +
> +static const struct udevice_id sunxi_pcie_ids[] = {
> +	{ .compatible = "allwinner,sun60i-a733-pcie" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(sunxi_pcie) = {
> +	.name		= "sunxi_pcie",
> +	.id		= UCLASS_PCI,
> +	.of_match	= sunxi_pcie_ids,
> +	.ops		= &sunxi_pcie_ops,
> +	.of_to_plat	= sunxi_pcie_of_to_plat,
> +	.probe		= sunxi_pcie_probe,
> +	.remove		= sunxi_pcie_remove,
> +	.priv_auto	= sizeof(struct sunxi_pcie),
> +};

