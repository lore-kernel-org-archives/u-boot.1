Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54BBC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AFCC403F4;
	Mon, 24 Aug 2026 12:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2v4tA0Ubak7r; Mon, 24 Aug 2026 12:59:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787576369;
	bh=Ynp3uKxwvh4vNZ+6+UdCIWBJLz+gdvZ5Owh6ad2YRsc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=OWQ2Zzbx/n6SQsrTN4ou8HL4T/jdb5orrZ6eN3prYO6gHhMQxlOQLNP+85nh2hWTf
	 M0Mio+3876EIMLXJ9X4E3ovHdRWrKTC8GVON9ERYc80FiSgnuUyNmCu0D2xi0XBxwM
	 Ey2FC5pBLsdDMP7EwBl5JdBZknv48bNxH3ZXOzR9BO6XbDUHAJ07IG+MIWUeaCGogW
	 h7WBRuleXpZMggH9yszM4ZcRMRqTBDL7p5vfSzYiOhChn3ON51eExbeBFuB26CwxaY
	 PyEZ95UwJ9CYUp/cc+sL1YmoCGoubzfc7PjLlmH2f21Xcy7WY0oiq+gVQ78zFq/3Bl
	 Hp3MUzEWnLTlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10FA4402E7;
	Mon, 24 Aug 2026 12:59:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C304A386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0F9680796
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aWhRv78R-PeT for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:59:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=eW8mhvih
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F71C80766
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:59:26 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso18498375e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787576364; x=1788181164;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ynp3uKxwvh4vNZ+6+UdCIWBJLz+gdvZ5Owh6ad2YRsc=;
 b=eW8mhvihEOLKM/e0lngw/jst7uFhOuLSVH5SKkRdeliDRk+Q7fc/4Cyactbo/18Fs4
 9IhgXvDKGwSBbgRpreeE/FhSrXSLNqY7mh819MBtSdspP0e11IBT+VzH9pza246+zzHs
 DPS6F7w0tqlEAva1NfvH9KB+SDD6zWDhdtjld2n0lvNegjywEZE/azhSl+kV70YrG+ic
 A0fWVtot5x87uBfXLh946dAUjp8n+18cLxMmPUsXvP1x7uZifMKnWQbsvrY4jun8629E
 FVG8z7DuUEiukPIwTGOB+4UTstUDSeYHSJcs5r71e3fm4i6LWSomaQcCIGHEDeGQkUct
 h2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787576364; x=1788181164;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ynp3uKxwvh4vNZ+6+UdCIWBJLz+gdvZ5Owh6ad2YRsc=;
 b=roVRrqiRQSgc+jK+b7LVDDHDzPrhj1xd7vR/CFIrM0s3j4lcSYpKFgMjykK3v63KH1
 JnXUYloYu+3AIvLqbReoRg9JrM4XXCXXt33rfOMIvuemfWbAkPYLtz5bSF7PL0vmEi2V
 vUFfjhC9vCXqlw9gPEApfTijt35hFlRKZ5tNIrU+mqQ6UIGlI+rBJjY2rCT71ji3bH3B
 OzKuAMuIKXyOYf/EvdnRN03fHmfgvDYu3hFPsDf8prqqKdrXqSbr2v/AwwTwlmoOwhcp
 zSXi78EmM77QtWeQ0K8WHiC8gxaUIbHhF/qTSsnD29PkWEJGdF/ht1SAnNp5UC84xe5x
 X/fA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZUQNDbJgmlxAyQF9pZ+ISCaucvicRLhuRldnGROsVaW7T2dF5aurodcbWF4h4jwbA6KatqTc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mpI+LAcA4CAKpy1ZtO3uyBzTpf1bUrpwdN7WS4yzfpSRhT/S+N
 0a3o9IEqZzFH6L3yuBpBOW9qmtSrJ9CTrUBTuEkW5Vhuoeg0p/9uj1aPLme7l3a7lsU=
X-Gm-Gg: AR+sD11yI3fgJL7KT59mSQXHbjFo+RzIcfMGkjjZET5XIlXFG/Lb+1UTQG6bY8kQnnW
 evzvpUgWGLUiJRetHpEmzfpxB34r6vPsmgYF98HAvufOyjGu3n9B0IdoSdxw1DLfzmM129GG+aw
 mZCro4QV1YhZX0aatJ6dnpEmp4J+9WdnZVntyIroqm95TxtzDTsG4iQ/GbuV5fk4IcBSMyHUliR
 e2U0oy5V7EOlOMZC3i/B6F1hdte67ocICZMf9DOT9oM6eJIVuJBN5EFovU9L4ootOd/sL+BHrDP
 7W0GaPFshhMom6MsgBHZB9yW/NynhFdNY7JtYDFBt38wGhFcYe/dHt9fbq2k13xoTeNQrX7RIa5
 2NgeWPBNBoyTKQ1rBZBnOBYN50+pJdEHxbgyTfSVU9aRBjGWvQDBkl76MXMsGSPnR4VqsgwI+cY
 RQ+C8f4GgHxPjy0T8pBqGlbH1QEBKdSaR5nczvjb+nl666D2AZWu4fvN8nIbgbpHr2d5u4/Yhar
 9YRGc3iiTgoyouhVUIfzz1T+yJj9iFb3lsyLG16yg==
X-Received: by 2002:a05:600c:3e1b:b0:499:a685:c10 with SMTP id
 5b1f17b1804b1-499b82e5427mr343146935e9.4.1787576363857; 
 Mon, 24 Aug 2026 05:59:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273?
 ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499d560f66csm241245e9.1.2026.08.24.05.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:59:23 -0700 (PDT)
Message-ID: <082abc17-d8bf-4083-80b4-8caae9c5bad1@linaro.org>
Date: Mon, 24 Aug 2026 14:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] watchdog: meson_gxbb: Add support for s4/t7 SoCs
To: u-boot-amlogic@groups.io, sanderson@brivo.com,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>
References: <20260817163048.1892107-1-sanderson@brivo.com>
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
In-Reply-To: <20260817163048.1892107-1-sanderson@brivo.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/24/26 14:53, Sean Anderson via groups.io wrote:
> These SoCs have an almost identical watchdog to other meson SoCs, except
> the reset bit has moved. Add a new compatible and driver data.
> 
> This commit is based off of Linux commits 55908e388b5da ("watchdog: Add
> a new struct for Amlogic-GXBB driver") and 8c776a0401f1d ("watchdog: Add
> support for Amlogic-T7 SoCs")
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/watchdog/meson_gxbb_wdt.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index fced8f3686b..30694936c93 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -18,7 +18,6 @@
>   #define GXBB_WDT_CTRL_SYS_RESET_NOW		BIT(26)
>   #define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
>   #define GXBB_WDT_CTRL_CLK_EN			BIT(24)
> -#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
>   #define GXBB_WDT_CTRL_EN			BIT(18)
>   
>   #define GXBB_WDT_CTRL_DIV_MASK			GENMASK(17, 0)
> @@ -28,6 +27,10 @@ struct amlogic_wdt_priv {
>   	void __iomem *reg_base;
>   };
>   
> +struct wdt_params {
> +	u32 rst;
> +};
> +
>   static int amlogic_wdt_set_timeout(struct udevice *dev, u64 timeout_ms)
>   {
>   	struct amlogic_wdt_priv *data = dev_get_priv(dev);
> @@ -84,14 +87,14 @@ static int amlogic_wdt_expire_now(struct udevice *dev, ulong flags)
>   static int amlogic_wdt_probe(struct udevice *dev)
>   {
>   	struct amlogic_wdt_priv *data = dev_get_priv(dev);
> +	struct wdt_params *params = (void *)dev_get_driver_data(dev);
> +	struct clk clk;
>   	int ret;
>   
>   	data->reg_base = dev_remap_addr(dev);
>   	if (!data->reg_base)
>   		return -EINVAL;
>   
> -	struct clk clk;
> -
>   	ret = clk_get_by_index(dev, 0, &clk);
>   	if (ret)
>   		return ret;
> @@ -102,7 +105,7 @@ static int amlogic_wdt_probe(struct udevice *dev)
>   
>   	/* Setup with 1ms timebase */
>   	writel(((clk_get_rate(&clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
> -	       GXBB_WDT_CTRL_EE_RESET |
> +	       params->rst |
>   	       GXBB_WDT_CTRL_CLK_EN |
>   	       GXBB_WDT_CTRL_CLKDIV_EN,
>   	       data->reg_base + GXBB_WDT_CTRL_REG);
> @@ -117,8 +120,17 @@ static const struct wdt_ops amlogic_wdt_ops = {
>   	.expire_now = amlogic_wdt_expire_now,
>   };
>   
> +static const struct wdt_params gxbb_params = {
> +	.rst = BIT(21),
> +};
> +
> +static const struct wdt_params t7_params = {
> +	.rst = BIT(22),
> +};
> +
>   static const struct udevice_id amlogic_wdt_ids[] = {
> -	{ .compatible = "amlogic,meson-gxbb-wdt" },
> +	{ .compatible = "amlogic,meson-gxbb-wdt", .data = (ulong)&gxbb_params, },
> +	{ .compatible = "amlogic,t7-wdt", .data = (ulong)&t7_params, },
>   	{}
>   };
>   
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: s4_wdt
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
