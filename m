Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0411C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A140607DB;
	Tue, 21 Jul 2026 07:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FVza753k-Imc; Tue, 21 Jul 2026 07:53:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2877607FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784620386;
	bh=YYX40zdSX7sBhxGrWdyr8Ei6g54bQAQ4VO+LtZNfxS8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jLU0HFSdPD14TTq29Pw1W6gy3+FHIsAq44iMPUtu0xJfyCcDc2y+TTY2RThWfqKG4
	 567DGvEeTwlayLrWZ0e5P+HsDoOVnrg6jx4Iubb/WREwBSowriXpCsQdlJOxWfU3ML
	 HlSOy89u5N/jkBCoIu4L5DzrCMwHr408CbepxqRyVL2NYyi5hcaGZlJLz1FeSEspdT
	 J3hpEI5e6vr/QSoRQHlmmTCCANABfG8dgRmL8BMfhQ8hRTEms7gIP9z7/6kFb+MzZY
	 OA8QZGqXwIDnnCZ8+yftfhNL/RLhCIft0KJPDZ8da90h51t1E5kbQVFGtgEn+QtKJs
	 Z1s9YMCTAEQKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2877607FA;
	Tue, 21 Jul 2026 07:53:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 189B11093
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2C3C607FA
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PvnHap9kuGZF for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:53:04 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=neil.armstrong@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EF216607DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF216607DB
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF216607DB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:53:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEB684659; Tue, 21 Jul 2026 09:53:02 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC2B803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:53:00 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so47173965e9.3
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784620380; x=1785225180;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YYX40zdSX7sBhxGrWdyr8Ei6g54bQAQ4VO+LtZNfxS8=;
 b=P5Fq+iuuOhNuB7thxWDVjInNNg6wtuO/5h+rt7hXK2/dXSXe87EGaif2YuZQPw+Wmb
 z52R9OGwpFzb+RDmHjZiLxnPx0ImtM9coY+A1QJlTs8TkLv/XcKGCHlNghUXJ5CrtXDM
 R/IPeCdNyL9AYMu2Fuvb19vp02z1MfFNzJ61N1Ont4aP3tl2q+dkeRfP3gM9pHkPYvVS
 EVRlnaKUkI2Nxi455WVHw8qRvr7q/JcmcI2SOblp8WgFqzFUnuZsi5p72Sjm686EnfKl
 QVLKKuBFgPRhZQJKp2Sgj3TsgL8Q6jzjJLzxIhrLRcn/NAuL5B86NiQBS1XmyDwMKprF
 7nkQ==
X-Gm-Message-State: AOJu0Ywp/2Bw1xuQH7+R74sRnYZaDZp5MZkJdpc1g3zB1rj9Jfzg9j2H
 kPn+ITDWvh9lA2NUGw871rZAPOheWEfiED+kV2oWSUjDyROrUNF1jOAjtIrw0pg/B98=
X-Gm-Gg: AfdE7clTeXJ089XnYXbI83S1H3oxHeHeinFjUyTsE89zL/MQAm2CtYjoppSIGi5Z7C5
 zZvi9AS3JzpgfHaOvau+GNm+LlBQDgP7kmn3Cmi4KuzaLElczdg1VJbSQud3zg73WlfOqNlg6Qz
 hQn2OJLUwnkeWQppDgiJvn+f7zjQEWPoPlif1oTjRuT4ceDAd+ay0t553esJRqT1MzIXcQsQi4I
 7Cl4HCQ40JJXmzJsB8ZpCkwmRZNv3eLWBMDkoehiOekkiNUz/vQe0do5GjYatYncPar50U9Fnbk
 Y9GW1tkzEz6lSw6wRLXCDPdkerJQQgYkEdmO4pL5t3Y1Do3yqq5U8EOvMupgCrfobuboUW8YGju
 xnuDvZm2B4DPlWP6CFGsRcayJ0RQKxMYkCNP+vna2ZPAAySbKWeocedx5e1JD0/MjfFkZ2Vhlkm
 y+aS/JrYwpxkkX7jCtJB0Zm3I2NRi1YmxlkYfnIurJMPQ/xVCXkt2JogZE+0yWVVBfimUu
X-Received: by 2002:a05:600c:b96:b0:493:f6f0:d66b with SMTP id
 5b1f17b1804b1-4954a3ec771mr190603255e9.1.1784620379566; 
 Tue, 21 Jul 2026 00:52:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1?
 ([2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49548e075d4sm248841935e9.1.2026.07.21.00.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:52:59 -0700 (PDT)
Message-ID: <9c8ad68c-d1ad-43a3-b3d0-e960e9c5720c@linaro.org>
Date: Tue, 21 Jul 2026 09:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/7] ufs: rpmb: retry SECURITY PROTOCOL on power-on
 UNIT ATTENTION
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com, hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
 <20260720085202.537019-5-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260720085202.537019-5-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784620380; x=1785225180; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YYX40zdSX7sBhxGrWdyr8Ei6g54bQAQ4VO+LtZNfxS8=;
 b=pn4Dd5tt46azxaCsJqoHLPHiAvExhYAUKEYZfy+6XwR2eiFWkeSr2GaAqoIzYXS2Aq
 2jvb9RAuNfbwuALbRpaa+7UTj0UYupBE/sxT/ZX1NWHGTT9kHcahf9lP65cSgaJ2Uh7r
 /nUn27AH6BrwPROeaDxqbSEXFOo0Mpk+2hKsMohCe5dEr/jKf0lLpabXSfFgKmCc+j8h
 W4uiyPsjUFWu92ArSonoizEEeTbht4D1Cd0TDztha28WkK7RP/6vKrOE9P7GR26IZ9EM
 A6nYmbtNAT4ZKMfDiXuBr7EXys2jJbaUfbERy/nHuLK6lxfZioWYrtLRdZ7mc6PLUepE
 hSEw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=pn4Dd5tt
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="pn4Dd5tt"; 
 dkim-atps=neutral
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
From: "Neil Armstrong \(Linaro\) via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/20/26 10:51, Jorge Ramirez-Ortiz wrote:
> The RPMB Well-Known LUN is untouched during boot, so its first SECURITY
> PROTOCOL command after power-on is answered with a CHECK CONDITION
> carrying a power-on UNIT ATTENTION, which ufs_scsi_exec() surfaces as
> -EINVAL. U-Boot has no SCSI mid-layer to auto-retry, so the first RPMB
> frame OP-TEE sends (the write-counter read that verifies the key) was
> lost. Reporting the UNIT ATTENTION clears it, so retry the command once.

OK just squash this change with patch 2.

Neil

> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/ufs/ufs-rpmb.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> index 7919162ddae..1434161682b 100644
> --- a/drivers/ufs/ufs-rpmb.c
> +++ b/drivers/ufs/ufs-rpmb.c
> @@ -19,6 +19,8 @@
>   
>   #define RPMB_FRAME_REQ_OFFSET	510
>   
> +#define UFS_RPMB_UA_RETRIES	3
> +
>   static u16 rpmb_frame_request(const void *frame)
>   {
>   	const u8 *p = frame;
> @@ -34,6 +36,8 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
>   	struct scsi_cmd pccb;
>   	u32 len = nframes * RPMB_FRAME_SIZE;
>   	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
> +	int retries;
> +	int ret = 0;
>   
>   	memset(&pccb, 0, sizeof(pccb));
>   	pccb.lun = UFS_UPIU_RPMB_WLUN;
> @@ -54,7 +58,13 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
>   	pccb.datalen = len;
>   	pccb.dma_dir = dir;
>   
> -	return scsi_exec(scsi_dev, &pccb);
> +	for (retries = UFS_RPMB_UA_RETRIES; retries > 0; retries--) {
> +		ret = scsi_exec(scsi_dev, &pccb);
> +		if (!ret)
> +			break;
> +	}
> +
> +	return ret;
>   }
>   
>   static int ufs_rpmb_send(struct udevice *scsi_dev, unsigned int region,

