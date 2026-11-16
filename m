Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FD606A881
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YFCC60lJ;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xjyg3iTm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56F874057D;
	Mon, 16 Nov 2026 09:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6iqR-sdPLXRn; Mon, 16 Nov 2026 09:51:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A99540583
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794822699;
	b=Rz8B8rwMXhgI8NBHQVtf2yololoT9fOm3/YIjY/yN1iZxyBh4ciEsNQjnXI7eFxLGUG7
	 +wKFYh4LYtYqTuI86B/Oajqf4fJ4KGr600zHPE3JEv60MfUdSZKOP5zoUuIFTx2gyEIkH
	 9+jxVsTKF1LFCvidCvAp4B9N29jgXvLRtZOQyK3fKQnGHnX4UnmubIqO//vbp91SilctL
	 ZNm0p/lVyDSaDEP9ZkvPPN31BVNeABFlDw7S6LIeCZYEZE9Ru/+rwen4Lz354ZXrjDy+R
	 /Cbd4aGi/9YOjanz8iBysc/ITVJn0Wax8pVNRiDdLW0McojnbViLDpl2mQvqByjdgxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794822699;
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
	bh=pMe0JTM0ySFpgrD8lgB8Zu1ARefLKCOYwmB3FrXPClE=;
	b=dRu2Mfxha99rEbfkD36Fm5Zxgm+Ay3ONmvPPzPLFq1NqQ9vSF49eMCF4V3ffEbmYYFXJ
	 urj1PLqDnkSKRHTnkPfYDyVldz2cCvWpf4G/rwGAHLmxnZC2HBjh2Re+g84ir4+k28j5j
	 xQIAZiQgGXGAi1T7ksUOrMYaQIM+8oH7rSqh5ujAj2K6rFTDiMbRcm7xLfRFIHybkBGum
	 87+3e6cPtFLXGY/z9BgO8xZHZVune83uL0YJ3eJjVxoLVvRN5eK8HQkzGx39EM6Bd4s/Q
	 ShFVPb/1Xe4Ls0GBjx3Rbi1HWVxi9gpfBM3Ua2UPehlU1gEW0da7NpITxvQ+xJNyGFg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xjyg3iTm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794822699;
	bh=pMe0JTM0ySFpgrD8lgB8Zu1ARefLKCOYwmB3FrXPClE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=YFCC60lJOXTyR1OdPlFPAM2i8AIfvz6F7yBgMmR1CGQjoFOg7P2FyQr63bHSf2Jx9
	 LqSE+WksrQeM/3aOpNakZnYiDiULS8rubqW64Yl1DM4XGiw5ugZo0oGT4DtwhB+VXr
	 4y60O5XFTPv/q+TD+fCuo5zS3OxyjoCyh4KErZ8ADxZ6mXOwzhvw80j/sbB+zpsiTt
	 G9hznan0GExHTz/vA2W8nOGlB85KnBkhqeBI++hbxYYVOdLEuWn82U1+gFwNf9JLws
	 jzkHYhXf7GEnJ3uJUSXZXq3zRVGhTgUBhFrJIKQ+2AmQ8sQxGK4GaAsJPiI0ZQEbAj
	 22LjxV6cRhMig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A99540583;
	Mon, 16 Nov 2026 09:51:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DA162FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F5EE40583
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:51:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KcaB4BZhDlAI for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 09:51:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 25CE44057D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xjyg3iTm
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25CE44057D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:51:36 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so18679985e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794822695; x=1795427495;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pMe0JTM0ySFpgrD8lgB8Zu1ARefLKCOYwmB3FrXPClE=;
 b=xjyg3iTmCCjNzdKdrNoWrIcTBjbcbh66MIm+iy2n08v+O2spKwvsXXb9HOVs6D1uGB
 8+PmXlisEPaPSTExFFspvJxGvkdYfEWdF8zC9YkP1LhPM3is1FVn5iQ9xmjSoyyQ6Q18
 wXWm/T3GoWRksNYmTZeoIkqMMlrIkrRG+bSY5YSUpyiXgjDV7kYZfSMfMrwQRL5H4XEw
 MGpHHzBrp6s0ctydA2raHDc1Ql359iNoRKMRgcH77chIRw0hBPQ4zACdVv7fM45lIQsj
 VG+C+HuikLN6yLV8XOO/WVb8BBw97oBDZYRk3Hx3mRGWk21XGO3HmPoKdGoeZNEbjz+c
 XQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794822695; x=1795427495;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pMe0JTM0ySFpgrD8lgB8Zu1ARefLKCOYwmB3FrXPClE=;
 b=F048MgW3InSYEgbHHuvnPpmvfIWLQf6lUzAA3crgIkMIjUS9zJziFr0LPNyC+ysB9G
 7YMUurucRI3T50nyGcmEuPZ66D6xdxRP6wUcDNWmtiyaDkOczy5XaYe3u8A5nNIqAmUR
 yhO+bcR/S2+EnyxeZoUTZIIdEQoiUor3uq6bWe2O+SrNsfpaAKwADYqB8PdUKbPZDaFy
 un62b7JfACHFBJPvi++awW6wS03r3qSo24zy4qSczc+mUQXrQ2ItemuMTI5s4/zcGiDF
 IIydjrkS/AlUPBLwn8WF7ipkUvrKJGmJmE4sGWb3ufE4EAIjslVgQn0EtxQw36ymVF0Z
 eigw==
X-Forwarded-Encrypted: i=1;
 AL+hErG7E9fXFlTFldaoa2K6ku3mTVtA6CW6b04Dgjy6HqUo7kRj9kkz103wDVXpbBYOqPTB92N96mo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/fJ2UVitYN+DUDkxee38TXikkOXLHEibQJZsf3jQnnjPAvO3qq
 DbU6oFYFjSLi2q+3+CeKA222uvseJ8gscn0OUmgONd2jlU7gmLQif6+SBBJ6kFw6tTA=
X-Gm-Gg: AYBFou2FPhRd8CzaUq8S8jY/vUpRfZusKDdApThBRrZSb/qVsLHKaUpTIgweQRjZ1vu
 4xMbXvEGCyS95VLBxT7r8JaY1GQErA8NDr5dkd4m+PMggAFV6tQ5IUzPMmfW4G/T5lc94EKZ6DA
 25xJuhx++UE0oir74rSc2F1wQHwZQ7jL3Q7Y5kAeEQv04WiiVG6YmRAR82izxmp9F+3gq6MewKy
 GC9R6h9+TwO/6KquVU3jIWZDw0JhrUXMz59c4V5b6XGy6hx2MQkV3VI5SXD2S4vmn7Je/efVIZN
 weN8uh2rTKRwYWKkh3MP+Vcs7PR+DMmLVHxBWeuJQyrJPMT+kk9KFD6rE9ZJX/sVusuSvnWhIBI
 7Gt5PqPcog17wkp+LnfQfix/NmLmlxWvhwtQvv6mN/uWq1vtOgG3KZzlzhBoJ84ltE/P3WkPkaf
 PIlcQFn8KR4bxPRFBiHfwQiq576FlDRE6adT00MitSsdvpyGyMUbs5GYrMMJdk/H9O5RbBW42ir
 wOWpR6bF+gWjAPs7d+lPLvCVfw4wC1eNnKSHKEZuT9D7OOEoZ25H9dk98kizSWPjtC6cBUhfA0n
 brTO1NVLSzT7qJoLZZRE2SMLhYrNU7zSuh4YB5GvVa+0GQYP2LkKTnwUAJSG7IISoONHAmcftmE
 QCS3+LQ/l
X-Received: by 2002:a05:600c:3b91:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4bb55a3e29cmr230882475e9.7.1794822694680; 
 Mon, 16 Nov 2026 01:51:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:575d:8fcf:e30d:5aed?
 ([2a01:e0a:106d:1080:575d:8fcf:e30d:5aed])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe370f8sm19084246f8f.27.2026.11.16.01.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 01:51:34 -0800 (PST)
Message-ID: <89c3c687-9295-4ba7-8a94-8a8228ef2bc0@linaro.org>
Date: Mon, 16 Nov 2026 10:51:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] nvme: Consume completion queue entries in one place
To: Alexey Charkov <alchark@flipper.net>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.u-boot-project.org, Zhikang Zhang <zhikang.zhang@nxp.com>,
 Wenbin Song <wenbin.song@nxp.com>
Cc: Tom Rini <trini@konsulko.com>,
 Prashant Kamble <prashant.kamble223@gmail.com>, Torsten Duwe <duwe@suse.de>
References: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
 <20261113-nvme-fixes-v1-2-a181c72f40e7@flipper.net>
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
In-Reply-To: <20261113-nvme-fixes-v1-2-a181c72f40e7@flipper.net>
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
> nvme_submit_sync_cmd() advances the completion queue head in two
> places, after a failed command and after a successful one. Each copy
> wraps the head, flips the phase, rings the doorbell and stores both
> back into the queue, so a change to one has to be repeated in the other
> by hand.
> 
> Move that sequence into a helper, and keep the head and phase in the
> queue only, so there is no local copy left to fall out of step with it.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/nvme/nvme.c | 36 ++++++++++++++++--------------------
>   1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 2063c73f9d85..a7950227abb8 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -183,13 +183,21 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
>   	nvmeq->sq_tail = tail;
>   }
>   
> +/* Hand the completion queue entry at the head back to the controller */
> +static void nvme_consume_cqe(struct nvme_queue *nvmeq)
> +{
> +	if (++nvmeq->cq_head == nvmeq->q_depth) {
> +		nvmeq->cq_head = 0;
> +		nvmeq->cq_phase = !nvmeq->cq_phase;
> +	}
> +	writel(nvmeq->cq_head, nvmeq->q_db + nvmeq->dev->db_stride);
> +}
> +
>   static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
>   				struct nvme_command *cmd,
>   				u32 *result, unsigned timeout)
>   {
>   	struct nvme_ops *ops;
> -	u16 head = nvmeq->cq_head;
> -	u16 phase = nvmeq->cq_phase;
>   	u16 status;
>   	ulong start_time;
>   	ulong timeout_us = timeout * USEC_PER_SEC;
> @@ -200,8 +208,8 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
>   	start_time = timer_get_us();
>   
>   	for (;;) {
> -		status = nvme_read_completion_status(nvmeq, head);
> -		if ((status & 0x01) == phase)
> +		status = nvme_read_completion_status(nvmeq, nvmeq->cq_head);
> +		if ((status & 0x01) == nvmeq->cq_phase)
>   			break;
>   		if (timeout_us > 0 && (timer_get_us() - start_time)
>   		    >= timeout_us) {
> @@ -217,29 +225,17 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
>   	status >>= 1;
>   	if (status) {
>   		printf("ERROR: status = %x, phase = %d, head = %d\n",
> -		       status, phase, head);
> +		       status, nvmeq->cq_phase, nvmeq->cq_head);
>   		status = 0;
> -		if (++head == nvmeq->q_depth) {
> -			head = 0;
> -			phase = !phase;
> -		}
> -		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
> -		nvmeq->cq_head = head;
> -		nvmeq->cq_phase = phase;
> +		nvme_consume_cqe(nvmeq);
>   
>   		return -EIO;
>   	}
>   
>   	if (result)
> -		*result = readl(&(nvmeq->cqes[head].result));
> +		*result = readl(&nvmeq->cqes[nvmeq->cq_head].result);
>   
> -	if (++head == nvmeq->q_depth) {
> -		head = 0;
> -		phase = !phase;
> -	}
> -	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
> -	nvmeq->cq_head = head;
> -	nvmeq->cq_phase = phase;
> +	nvme_consume_cqe(nvmeq);
>   
>   	return status;
>   }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
