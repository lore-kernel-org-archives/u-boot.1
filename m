Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDDC606BE1E
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HrF9Oo96;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yoA2EM5V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54B38605FD;
	Mon, 16 Nov 2026 11:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id axditwDiEXpn; Mon, 16 Nov 2026 11:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 822EA6067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794828250;
	b=YSTYwg8utBfbFl0han1E7KLmbqCXxLRiPXVUgQhErwrjYOyHa+mE3oRsISvsOSf4jMg+
	 bfUKVRW5Wib7RWI1FfxicyxrZTCNHJw3JaI1tuDqPiKe831F//bhvOQKVKc0kPIldn/WL
	 9qs865Bqlr8yWrF+UXvMZOWdda3DvQeE8vo1IFhObGgn1aALSr8tn+qO4H3jJsFnsrugl
	 ljii7DKioweFkUoQOmun3Poifpvz2VgkBIT+6d3wcYatqpibo2GQeXW84NUaODJJmyjjK
	 Wr9RY9xT4+eGwfHeS+2356DhvoStDDNgH6HNFBX7aeQ5inhCmJDhhn2zPGRIJolfGvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794828250;
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
	bh=Wcaomish60s+3fIiRgyoq8o2uDLf1/OBVygdTUgxRxc=;
	b=IFhL2hwZ5K36Th0W4jWvvp2B5PmOZeO8f7ymu5HmqGr4UJ2deMretHSDDoIJ4TP86QV+
	 HwnwaI84msgm4G0Ssm4MbGnnsR6kxBDN+O7HP5Bajzu99gAGoO9v3UM8DLH2GbMnKEbFC
	 7/lulH6qfpf/Z9TuaQUwFtz+Xa2gH7+OPdnlZEeuLeDFmfZEY2SxsO2T5cZc5cb54Pn0U
	 DFR24tiTrVCD2XrR2+gb6YOBrR25mCJ+suCznwHGjy956c64I/zvzkApvIY9NUO15FkIS
	 nIMSKlNWt7cxamfIFq1Xv8mxQRCWczT1E8BszBlBuWG2Z9zdltBwTBC+zZRrcCcY82g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794828250;
	bh=Wcaomish60s+3fIiRgyoq8o2uDLf1/OBVygdTUgxRxc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=HrF9Oo96SAveRjwCiTW62MzGr1ROk0wtxGNMijpRzt1mwse+4z5u886LK3chCGFfF
	 MiwCBFGniMgBwRvPqROuE+AxulsAIFuNpDhyR3yJ9PsYgQ3KHc5WoaWczk8W2ZaSDK
	 Zk4OmR549TvTUI5ns6SW9CvcZCrMZ/ZAs+hqzqIr7mW4S9yp36nKBVxiCyVZHeYzV0
	 HpzWHg1R8KA38eL9c2gtakBQ672QTPSMW2NARwzi0ObHqLRydj0hTz4FPqlc3eXe3M
	 coKw8gb55sAZvIAgfbPg7UuHXCSDt4euHsvak4EPAIdEoSNZuOCrS2rxgw0+/p0tFO
	 HGL4cFKONZIVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 822EA6067D;
	Mon, 16 Nov 2026 11:24:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F6161A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7811A80C13
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1nrgqrdwEJt for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C6DB80BF1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yoA2EM5V
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C6DB80BF1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:24:07 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so14613685e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794828246; x=1795433046;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wcaomish60s+3fIiRgyoq8o2uDLf1/OBVygdTUgxRxc=;
 b=yoA2EM5VBG78rEr28o1RI4yt8MbXla81dKZl6wx9ueLFSaoLF/a7SIBwwPJo4WGvRE
 YFvl7pGeUPQ/Kcwr6L3n3D1pdLbKk5uwVJvFLYB0LAEKfJ6q+RcMex58ib+x+xtozY1p
 o2j4WC82tWNcxMqJplpDkO3XacUJvMjc2GyP0Fd0PDKSJHvTXW59LuDri8wEDs8c67Rg
 1Osj26ZKvTt13coR9DMjQw9y2VehYZHycAe9m7yIPimAv2QoisWJAsvP8QfQ41RU/qCr
 PeOqTtb2ZiQZJ3o3xxbSoJey/DcGciqCplsYx2d4+LfFmOd13yKhBmjPzCcBpVaaG2b0
 VqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794828246; x=1795433046;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wcaomish60s+3fIiRgyoq8o2uDLf1/OBVygdTUgxRxc=;
 b=oVmGz7Nuu05aElLfaxBg7Xk+fhFfkbebfvEZrErVBfguwNB97PvOLFAqldRMtSX/NJ
 Z9EKg5apHMCjwlCw0QKxGT9XNAwqZCMgJqwpPzrrwrxY8BAx9xZDhTFmiv0hL/VuYb+d
 cWPZolBufI8ZRnxZcyD3QHK7gtxXP8ocbV20PLJVjsk80vkCuAZf1cWjvwXTm+L+lEBl
 +yxowPr3IreS2au3FRmJAyUCMQPNjNIVYiP5PfGmTRk6ECnoWKIxrgqhkIFPnMQwk0H5
 CdqECQuXFvd5b2HSsn+QLzcGde03UPtjrgZsajguvULvHHw/1gf9IkjAxh47/eValRh/
 qbSg==
X-Forwarded-Encrypted: i=1;
 AL+hErHkrMZdl9M+vCzspsZHDfXuKYKMUV2If/BZYDN5SJk1Sdhq57avNtM1bzo4tCw5Zda/17DEh48=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/8TjIKYjfR0yZH8bnUXuJ4MxUK09apVYR38xiuFNGTLG/enTvw
 8tVfLeMwNJERghjPvuWmRxVVyuVCFvkBdvoRqrlttbunu8Vbd9LgnNYvgZ5MtHLqFbI=
X-Gm-Gg: AYBFou1p+7ii1wLP7sjTJciObZ2rgSyiC9oCM8M22YtwEnsy/G9tfqIftHyMAY7sUyR
 PYy7wEA9aEYmQgE5t7HnLVZF7+lFSFwetHUAD8MejOR0cPbgn0tfMI0kmHDLAwahlEyYN9O6+dV
 6VusqJYB47KfNN77GKNaGm7TVMbo0w0JyFMXh+U2r264X3toqeINCvnZzV1imzJATcYb72OIH5h
 9EEGJP4dW2sScsWtW/9bZKX8UhXNK3eIPzWbnnUkoVRrKXVX/yVEM3+DU2ILPuARNu6MAHKWhev
 xzMP8+AGCpiQBNOYisOPPNXZCawwgpsskCAorZCKDTlo83Cgb3xcX6PhUxt8hbR728uC0LWwnky
 5MzCHUlSb5oFmbT15oJSrjeNT6CcXcuSnMu71kMLmO1Wse5/aPdEGhFaN/i0Mn6QcBdauwU8U4H
 b4zH3sZhYG+Omktr25PIGByUyvVpZXCFQ1T+CknsalinvE+i0xpUd3egFaRs1cezk+W5GVux12a
 Xf3LzVn4TV9JpjIaJwIM9/Duv+Gu8Fz3us68x2vJ58o1PxebF8XWamO0kHgiAJis28umo32kTvT
 5kIhbIxgIuleU+0NuAeLKa4rYfLTH8AVsCZFLDwxx/UEKps1ZAOuiVK0csoYsCh8KT96vhH/n9U
 thvdR+Jw=
X-Received: by 2002:a05:600c:a012:b0:4b8:d17e:da27 with SMTP id
 5b1f17b1804b1-4bb55a85101mr203060705e9.27.1794828245639; 
 Mon, 16 Nov 2026 03:24:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:a58:fd6a:f400:142e?
 ([2a01:e0a:106d:1080:a58:fd6a:f400:142e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28c882sm380548945e9.6.2026.11.16.03.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 03:24:05 -0800 (PST)
Message-ID: <017980ed-fd33-4b50-9ce9-49a32d66a3ab@linaro.org>
Date: Mon, 16 Nov 2026 12:24:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] nvme: Drop late completions of commands that timed out
To: Alexey Charkov <alchark@flipper.net>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.u-boot-project.org, Zhikang Zhang <zhikang.zhang@nxp.com>,
 Wenbin Song <wenbin.song@nxp.com>
Cc: Tom Rini <trini@konsulko.com>,
 Prashant Kamble <prashant.kamble223@gmail.com>, Torsten Duwe <duwe@suse.de>
References: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
 <20261113-nvme-fixes-v1-3-a181c72f40e7@flipper.net>
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
In-Reply-To: <20261113-nvme-fixes-v1-3-a181c72f40e7@flipper.net>
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

On 11/13/26 13:00, Alexey Charkov wrote:
> When a command times out, nvme_submit_sync_cmd() returns without
> consuming its completion queue entry, so the entry posted when the
> command does finish is taken as the completion of the next command.
> That command then returns before its own data has arrived, and every
> later one stays a completion behind for as long as the queue lives.
> 
> On a Rock 5B whose disk is slow to serve its first read, this turns a
> failed GPT probe of LBA 0 into a successful DOS probe, which consumes
> the late completion of the GPT read and leaves the disk recorded as
> having a single whole-disk partition of type 0xee.
> 
> Check the command ID of each completion, and consume the entries of
> other commands instead of returning them, so a timed-out command no
> longer desynchronises the queue.
> 
> Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/nvme/nvme.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index a7950227abb8..37f5a3ce4b10 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -209,8 +209,22 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
>   
>   	for (;;) {
>   		status = nvme_read_completion_status(nvmeq, nvmeq->cq_head);
> -		if ((status & 0x01) == nvmeq->cq_phase)
> -			break;
> +		if ((status & 0x01) == nvmeq->cq_phase) {
> +			u16 cid = readw(&nvmeq->cqes[nvmeq->cq_head].command_id);
> +
> +			if (cid == le16_to_cpu(cmd->common.command_id))
> +				break;
> +
> +			/*
> +			 * A command which timed out earlier has completed
> +			 * after all. Consume its entry, so that it is not
> +			 * taken for the completion of this command.
> +			 */
> +			pr_warn("nvme: dropping late completion of cmd %#x\n",
> +				cid);
> +			nvme_consume_cqe(nvmeq);
> +			continue;
> +		}
>   		if (timeout_us > 0 && (timer_get_us() - start_time)
>   		    >= timeout_us) {
>   			pr_warn("nvme: cmd %#x timed out\n", cmd->common.command_id);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
