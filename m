Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC4606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OS3VpMhy;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gVE2hmMh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04C1E405CC;
	Mon, 16 Nov 2026 10:07:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEwcb1BUnGkd; Mon, 16 Nov 2026 10:07:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42F13405CE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794823650;
	b=FByYeaBwc3a+0u6IV9uFcle5IFUnUbmtY0a5HocjzJ3kHuRkI+3cXKk0rGBHxsMBEndA
	 6s6BIL130JH56ejAi1zFZB2nAPky7xb7jHENgZ04Xiltj+RLsV38LplJNSPPUDjKnnVVg
	 RU01ha4PgN+aajQ5/5QGMemo513WeyqyIr9U9doGauesCnInXvB6s8S1IQlaEeSX6RrA3
	 sQfTNlc3xy/xh9XZydYkz0E9G93nbeGPGiMTsBrnxrhhm6iSlOgiZDFy5C4+rwvOtqDvt
	 Y8h2w+bu3dWWtmlQU4uqx0YwwiJeob2SHVPacqbFH1hxB4yQ7TZ5OIodCwmcQR/71lQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794823650;
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
	b=UITgcugilAmaeCpnNtGsodo0XwgfzvnWG4Ka/3OhBKdMnmQz0pCvoihv/MYwVrid9FmT
	 Xdapf6u9E2XF1wFGKZDCEHMTbStdPm99lUoiELxUmD7BJKTV1zek/pgw5qjuVUVez/Lr3
	 z8Lp48Ws5z3owFwtmRtsLNdbfz99xAl0m1KXp5V1yOqZhipbxKSWpln5BKXpKRptAaoZi
	 mPlmDSEgzMFUFjBtf0ZK1cj7DvRB5SwEdY1I8LYQ0I29pT3AaKeStJQhRN2D7/7nAUyVW
	 6rk6CMdLRkATgJeWFqoxqgSIvpf387jRiW6kSQlTAyA6igfy+iPQDGM8MjLSpxztQvg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794823650;
	bh=Wcaomish60s+3fIiRgyoq8o2uDLf1/OBVygdTUgxRxc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=OS3VpMhya1pB9shjEFbRfvXEWm76XJsI4Hz2hLiXZIrOp4MiGWDiVFC+TRT0uXZFD
	 72diQPqs4PZIf4Z6/gSpPupaaL7kG2XwIRtONWvQ2/nxWm2TKQ0VLZyq4Dj5NuBD1L
	 kvBfVry7uBspSrFpv0IWkYy9TJfck3GP60aaFW65JOr6VfcXVKbUocPXYj2d0qdclp
	 kLRNwkCEOJ51WS86R71P45SYGGtA7AKPtWJKLpa4T+YtpeAluADO9fPTzpu+XANzBH
	 YUdv6k977OreECXmB1f1yv1xJOlTHjj5Ml7Q2ERu9PpyT/C/wr1hDdsxr3ddgSAiG4
	 5avRFo6FjL3KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42F13405CE;
	Mon, 16 Nov 2026 10:07:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BD361E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8207E4009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWGeYx28oSNm for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:07:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A94D40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gVE2hmMh
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A94D40012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:07:27 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so26006155e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794823646; x=1795428446;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wcaomish60s+3fIiRgyoq8o2uDLf1/OBVygdTUgxRxc=;
 b=gVE2hmMhq6QhI/F4+V9YKikqtItkpatvnXv4krUXGh39FYK+/2NQFiOlw2w09r46VF
 Qhi3pDv1aN9DgyS9bgGBoEc8gceaI++VYZLNl2m8vmdNpNp6Hg+O+ktDw7VEcQuoQ2gO
 KKDl5flgxINnVdaU7X12OJlFEGPPGsE3xupS4spKqB8VhvsZS/iEdziRd3wQvXY5OkJA
 8pXCU7ZbvuOCElP5yyGQo4z2BzoHWstz7YTpeezh0HMS2FsZtfhMYdJiboU2HZhSsIbm
 pj9lwyZKgoDjpjUasPbz+SeLA9pE3/tV8sVfiZfRGSKC01OM3IyRRyhgvlQl0hrsW90q
 a4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794823646; x=1795428446;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wcaomish60s+3fIiRgyoq8o2uDLf1/OBVygdTUgxRxc=;
 b=hrlubWPxR2+mnw8VEdAWeeqnTSgxdT1J/wVm+wuo8wMUINMF48H1JVlWJt/T3J/VdZ
 UofFe18RL9RMjNe4cBmlk5DJ5jSfUtx8rwF4a6JckQ0p4xOn6JF5hzPgGOzA4cDf0qnJ
 P/uM/vYv+vhQzcTqDdGhlmPGC01U1BniyRtff/4h4OdhOAAkvrEVYD3n9RhBJGGY+f1U
 p2gMcglczQBLVFT+4Hed67vn7i9T7c+bn0pgu2HfBr0o/OBCGDM2UMwlrs4kXc28d3G7
 NjRdRI0ePYuWiVIajSV1tQJ4ZH/8+rTwduJ8iDc2+CFa4c6uPsWpT9lo4e8DnsEiXbz5
 jPhw==
X-Forwarded-Encrypted: i=1;
 AL+hErFmWV52tZwB7mAq9leoltSXUolgFT3q8gZOsYQOh2cq5O76vcmN9ADkH3NXoqKVx11wb0m1L+Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z83fBa6cYu47o8kcn8i/UYL+5R1ZBhHlZGAfetZQLOaqWauMrJb
 dgQqsUDyQOePXoW1lyhuXHesTUbN7LxWLiP6DACCr/tiQD/hxX5TbikKOzk9q7DxB0M=
X-Gm-Gg: AYBFou1838L3UduRXipdSpKwTlOGXs03soEZ0QH8cqYfCjyF5xIarUb+YWpGBaQPVDd
 dH4JdWOa305xi3b5KVMp7TdPGwdpIIX9Ak0fiY4XD39JBdXPhzY11XW74TsC3OMnvyxR84FIp37
 6rChIA01HClXtySVybk5j4bBDBalPymY1q+x9BW8yOf9Z1jGNr0ZQnZajLajEs6gXqUWiVGwKvX
 JhPVDEIOH1FnU4ZUm1TxYuS2x/1tTyf4U0Mbn04fP2shLLjmpix+XF2XhWH8sSANEqo/VjZhOvJ
 DzVxI4Lv0HNArXDtGps0Gc5IeoZ8rXHBLzAgrdlZ+YcwqPP3S+9LQFRDEBPNXOjYyLRFwusuQTk
 tUJI+gTmu7vyQZF/R41wbI+cG+tQ/MMwOBSIpuUzrgxx/rgg0+anTx6M8H6JPp/JFEqy7EK8qUo
 wNKKPfVKd4a+0kyuBOYcLT3k+Xm1C3I9EGL/Scbw0hsVkoXM5zG1oa8QQzZb2jZ2wXRYpKLg/TI
 IsQJSK51HDjUxZOpEkEKnGZtzVc+m4GXzxJXR5747xpuMxRFPau16pgjB+jKm0Nu05dyvZTOqdC
 LlnFFXKWL6uyeBWYtLX8SCcUkpirTmibAMYeokINb4gLesM5+sA6JqLFOhktRSdzWcMK+A134ds
 kvO8SM0Krug==
X-Received: by 2002:a05:600c:6912:b0:4ba:59fa:510e with SMTP id
 5b1f17b1804b1-4bb55ab411dmr219489715e9.23.1794823645951; 
 Mon, 16 Nov 2026 02:07:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:575d:8fcf:e30d:5aed?
 ([2a01:e0a:106d:1080:575d:8fcf:e30d:5aed])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e29daa5sm388787705e9.12.2026.11.16.02.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 02:07:25 -0800 (PST)
Message-ID: <851b1d62-169e-4b24-8e5c-13e0f1615b6f@linaro.org>
Date: Mon, 16 Nov 2026 11:07:24 +0100
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
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
